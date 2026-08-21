--[[
    PulseVisuals - Violence District Ultimate
    Полный GUI + все функции
    Автор: ughqgeigwd
]]

-- ============ GUI ============
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PulseVisuals"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 550)
MainFrame.Position = UDim2.new(0, 10, 0, 10)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Text = "PulseVisuals | Violence District"
TitleText.Size = UDim2.new(1, -50, 1, 0)
TitleText.Position = UDim2.new(0, 20, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.TextColor3 = Color3.fromRGB(153, 204, 255)
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextSize = 18
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Text = "×"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 20
CloseButton.BorderSizePixel = 0
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 5)
CloseCorner.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Вкладки
local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(1, 0, 0, 35)
TabFrame.Position = UDim2.new(0, 0, 0, 40)
TabFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
TabFrame.BorderSizePixel = 0
TabFrame.Parent = MainFrame

local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, 0, 1, -75)
ContentFrame.Position = UDim2.new(0, 0, 0, 75)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 5
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 70)
ContentFrame.Parent = MainFrame

-- Настройки
local Settings = {
    Height = 30,
    Opacity = 50,
    Outline = false,
    Model = "Стимулятор",
    Voltage = false,
    Output = false,
    Response = false,
    Thickness = 5,
    Indent = 10,
    Aimbot = false,
    AimbotFOV = 100,
    AimbotSmooth = 5,
    TeamCheck = true,
    SilentAim = false,
    TriggerBot = false,
    WallHack = false,
    NoRecoil = false,
    NoSpread = false,
    RapidFire = false,
    ESP = false,
    ESPBoxes = true,
    ESPNames = true,
    ESPDistance = true,
    ESPHealth = true,
    ESPTracers = false,
    SpeedHack = false,
    SpeedValue = 50,
    FlyHack = false,
    FlySpeed = 30,
    NoClip = false,
    GodMode = false,
    Invisible = false,
    NoFallDamage = false
}

-- Сервисы
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = game:GetService("Workspace").CurrentCamera
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- Переменные
local FlyConnection = nil
local NoClipConnection = nil
local GodModeConnection = nil
local WallHackParts = {}
local currentTab = "Visuals"

-- Функции GUI
local function CreateSection(text, yPos)
    local Section = Instance.new("TextLabel")
    Section.Text = "▸ " .. text
    Section.Size = UDim2.new(1, -40, 0, 25)
    Section.Position = UDim2.new(0, 20, 0, yPos)
    Section.BackgroundTransparency = 1
    Section.TextColor3 = Color3.fromRGB(102, 153, 230)
    Section.Font = Enum.Font.SourceSansBold
    Section.TextSize = 16
    Section.TextXAlignment = Enum.TextXAlignment.Left
    Section.Parent = ContentFrame
    return yPos + 30
end

local function CreateSlider(name, min, max, default, yPos, callback)
    local Label = Instance.new("TextLabel")
    Label.Text = name .. ": " .. default
    Label.Size = UDim2.new(1, -40, 0, 20)
    Label.Position = UDim2.new(0, 20, 0, yPos)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.SourceSans
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ContentFrame
    
    local SliderBg = Instance.new("Frame")
    SliderBg.Size = UDim2.new(1, -40, 0, 8)
    SliderBg.Position = UDim2.new(0, 20, 0, yPos + 25)
    SliderBg.BackgroundColor3 = Color3.fromRGB(76, 76, 89)
    SliderBg.BorderSizePixel = 0
    SliderBg.Parent = ContentFrame
    
    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(0, 4)
    SliderCorner.Parent = SliderBg
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(102, 153, 230)
    SliderFill.BorderSizePixel = 0
    SliderFill.Parent = SliderBg
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(0, 4)
    FillCorner.Parent = SliderFill
    
    local SliderButton = Instance.new("TextButton")
    SliderButton.Size = UDim2.new(0, 16, 0, 16)
    SliderButton.Position = UDim2.new((default - min) / (max - min), -8, 0.5, -8)
    SliderButton.BackgroundColor3 = Color3.fromRGB(178, 204, 255)
    SliderButton.BorderSizePixel = 0
    SliderButton.Text = ""
    SliderButton.Parent = SliderBg
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(1, 0)
    ButtonCorner.Parent = SliderButton
    
    local dragging = false
    
    SliderButton.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = UserInputService:GetMouseLocation()
            local sliderPos = SliderBg.AbsolutePosition
            local sliderSize = SliderBg.AbsoluteSize
            local relativeX = (mousePos.X - sliderPos.X) / sliderSize.X
            relativeX = math.clamp(relativeX, 0, 1)
            
            local value = min + (max - min) * relativeX
            value = math.floor(value)
            
            SliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
            SliderButton.Position = UDim2.new(relativeX, -8, 0.5, -8)
            Label.Text = name .. ": " .. value
            
            callback(value)
        end
    end)
    
    return yPos + 45
end

local function CreateCheckbox(name, default, yPos, callback)
    local CheckboxButton = Instance.new("TextButton")
    CheckboxButton.Size = UDim2.new(0, 20, 0, 20)
    CheckboxButton.Position = UDim2.new(0, 20, 0, yPos)
    CheckboxButton.BackgroundColor3 = Color3.fromRGB(76, 76, 89)
    CheckboxButton.BorderSizePixel = 0
    CheckboxButton.Text = ""
    CheckboxButton.Parent = ContentFrame
    
    local CheckCorner = Instance.new("UICorner")
    CheckCorner.CornerRadius = UDim.new(0, 4)
    CheckCorner.Parent = CheckboxButton
    
    local CheckMark = Instance.new("TextLabel")
    CheckMark.Text = "✓"
    CheckMark.Size = UDim2.new(1, 0, 1, 0)
    CheckMark.BackgroundTransparency = 1
    CheckMark.TextColor3 = Color3.fromRGB(102, 153, 230)
    CheckMark.Font = Enum.Font.SourceSansBold
    CheckMark.TextSize = 16
    CheckMark.Visible = default
    CheckMark.Parent = CheckboxButton
    
    local Label = Instance.new("TextLabel")
    Label.Text = name
    Label.Size = UDim2.new(0, 250, 0, 20)
    Label.Position = UDim2.new(0, 50, 0, yPos)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.SourceSans
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ContentFrame
    
    local checked = default
    
    CheckboxButton.MouseButton1Click:Connect(function()
        checked = not checked
        CheckMark.Visible = checked
        callback(checked)
    end)
    
    return yPos + 30
end

local function CreateButton(name, yPos, callback)
    local Button = Instance.new("TextButton")
    Button.Text = name
    Button.Size = UDim2.new(1, -40, 0, 35)
    Button.Position = UDim2.new(0, 20, 0, yPos)
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.SourceSansBold
    Button.TextSize = 14
    Button.BorderSizePixel = 0
    Button.Parent = ContentFrame
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 5)
    ButtonCorner.Parent = Button
    
    Button.MouseButton1Click:Connect(callback)
    
    return yPos + 45
end

-- Функции скрипта
local function GetClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = Settings.AimbotFOV
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            if Settings.TeamCheck and player.Team == LocalPlayer.Team then
                continue
            end
            
            local targetPart = player.Character:FindFirstChild("Head") or player.Character:FindFirstChild("HumanoidRootPart")
            if targetPart then
                local screenPos, onScreen = Camera:WorldToScreenPoint(targetPart.Position)
                if onScreen then
                    local mousePos = UserInputService:GetMouseLocation()
                    local distance = (Vector2.new(mousePos.X, mousePos.Y) - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                    
                    if distance < shortestDistance then
                        closestPlayer = player
                        shortestDistance = distance
                    end
                end
            end
        end
    end
    
    return closestPlayer
end

local function Fly()
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    local bodyGyro = Instance.new("BodyGyro")
    local bodyVelocity = Instance.new("BodyVelocity")
    
    bodyGyro.P = 9e4
    bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    bodyGyro.CFrame = character.HumanoidRootPart.CFrame
    
    bodyVelocity.velocity = Vector3.new(0, 0, 0)
    bodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
    
    bodyGyro.Parent = character.HumanoidRootPart
    bodyVelocity.Parent = character.HumanoidRootPart
    
    FlyConnection = RunService.RenderStepped:Connect(function()
        if Settings.FlyHack and LocalPlayer.Character then
            local direction = Vector3.new()
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                direction = direction + Camera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                direction = direction - Camera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                direction = direction - Camera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                direction = direction + Camera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                direction = direction + Vector3.new(0, 1, 0)
            end
            
            bodyVelocity.velocity = direction * Settings.FlySpeed
            humanoid.PlatformStand = true
        end
    end)
end

local function Unfly()
    if FlyConnection then
        FlyConnection:Disconnect()
        FlyConnection = nil
    end
end

local function TeleportToPlayer(targetPlayer)
    if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character then
        LocalPlayer.Character:SetPrimaryPartCFrame(targetPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0))
    end
end

-- Создание вкладок
local tabButtons = {}
local tabNames = {"🎨 Visuals", "⚔️ Combat", "🏃 Movement", "👤 Player", "📍 Teleport"}

for i, tabName in ipairs(tabNames) do
    local TabButton = Instance.new("TextButton")
    TabButton.Text = tabName
    TabButton.Size = UDim2.new(0.2, 0, 1, 0)
    TabButton.Position = UDim2.new((i-1) * 0.2, 0, 0, 0)
    TabButton.BackgroundColor3 = i == 1 and Color3.fromRGB(50, 50, 60) or Color3.fromRGB(35, 35, 40)
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.Font = Enum.Font.SourceSansBold
    TabButton.TextSize = 12
    TabButton.BorderSizePixel = 0
    TabButton.Parent = TabFrame
    
    TabButton.MouseButton1Click:Connect(function()
        currentTab = tabName
        for j, btn in pairs(tabButtons) do
            btn.BackgroundColor3 = j == i and Color3.fromRGB(50, 50, 60) or Color3.fromRGB(35, 35, 40)
        end
        LoadTab(tabName)
    end)
    
    table.insert(tabButtons, TabButton)
end

-- Функция загрузки вкладок
function LoadTab(tabName)
    -- Очистка контента
    for _, child in pairs(ContentFrame:GetChildren()) do
        if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    local yPos = 10
    
    if tabName == "🎨 Visuals" then
        yPos = CreateSection("Visuals", yPos)
        yPos = CreateSlider("Высота", 0, 100, Settings.Height, yPos, function(val) Settings.Height = val end)
        yPos = CreateSlider("Прозрачность", 0, 100, Settings.Opacity, yPos, function(val) Settings.Opacity = val end)
        yPos = CreateCheckbox("Обводка", Settings.Outline, yPos, function(val) Settings.Outline = val end)
        
        yPos = CreateSection("Анимация", yPos)
        yPos = CreateCheckbox("Стимулятор", Settings.Model == "Стимулятор", yPos, function(val) if val then Settings.Model = "Стимулятор" end end)
        yPos = CreateCheckbox("Слушатель", Settings.Model == "Слушатель", yPos, function(val) if val then Settings.Model = "Слушатель" end end)
        yPos = CreateCheckbox("Full-Bridge", Settings.Model == "Full-Bridge", yPos, function(val) if val then Settings.Model = "Full-Bridge" end end)
        yPos = CreateCheckbox("Ag-Drive", Settings.Model == "Ag-Drive", yPos, function(val) if val then Settings.Model = "Ag-Drive" end end)
        yPos = CreateCheckbox("PH-Boosters", Settings.Model == "PH-Boosters", yPos, function(val) if val then Settings.Model = "PH-Boosters" end end)
        
        yPos = CreateSection("Акселерометр", yPos)
        yPos = CreateCheckbox("Сигнал Напряжения", Settings.Voltage, yPos, function(val) Settings.Voltage = val end)
        yPos = CreateCheckbox("Сигнал Выхода", Settings.Output, yPos, function(val) Settings.Output = val end)
        yPos = CreateCheckbox("Сигнал Отклика", Settings.Response, yPos, function(val) Settings.Response = val end)
        
        yPos = CreateSection("Длина", yPos)
        yPos = CreateSlider("Толщина", 1, 20, Settings.Thickness, yPos, function(val) Settings.Thickness = val end)
        yPos = CreateSlider("Отступ", 0, 30, Settings.Indent, yPos, function(val) Settings.Indent = val end)
        
    elseif tabName == "⚔️ Combat" then
        yPos = CreateSection("Aimbot", yPos)
        yPos = CreateCheckbox("Enable Aimbot", Settings.Aimbot, yPos, function(val) Settings.Aimbot = val end)
        yPos = CreateSlider("Aimbot FOV", 10, 500, Settings.AimbotFOV, yPos, function(val) Settings.AimbotFOV = val end)
        yPos = CreateSlider("Aimbot Smoothness", 1, 20, Settings.AimbotSmooth, yPos, function(val) Settings.AimbotSmooth = val end)
        yPos = CreateCheckbox("Team Check", Settings.TeamCheck, yPos, function(val) Settings.TeamCheck = val end)
        
        yPos = CreateSection("Combat Features", yPos)
        yPos = CreateCheckbox("Silent Aim", Settings.SilentAim, yPos, function(val) Settings.SilentAim = val end)
        yPos = CreateCheckbox("Trigger Bot", Settings.TriggerBot, yPos, function(val) Settings.TriggerBot = val end)
        yPos = CreateCheckbox("Wall Hack", Settings.WallHack, yPos, function(val) Settings.WallHack = val end)
        yPos = CreateCheckbox("No Recoil", Settings.NoRecoil, yPos, function(val) Settings.NoRecoil = val end)
        yPos = CreateCheckbox("No Spread", Settings.NoSpread, yPos, function(val) Settings.NoSpread = val end)
        yPos = CreateCheckbox("Rapid Fire", Settings.RapidFire, yPos, function(val) Settings.RapidFire = val end)
        
        yPos = CreateSection("ESP", yPos)
        yPos = CreateCheckbox("Enable ESP", Settings.ESP, yPos, function(val) Settings.ESP = val end)
        yPos = CreateCheckbox("ESP Boxes", Settings.ESPBoxes, yPos, function(val) Settings.ESPBoxes = val end)
        yPos = CreateCheckbox("ESP Names", Settings.ESPNames, yPos, function(val) Settings.ESPNames = val end)
        yPos = CreateCheckbox("ESP Distance", Settings.ESPDistance, yPos, function(val) Settings.ESPDistance = val end)
        yPos = CreateCheckbox("ESP Health", Settings.ESPHealth, yPos, function(val) Settings.ESPHealth = val end)
        yPos = CreateCheckbox("ESP Tracers", Settings.ESPTracers, yPos, function(val) Settings.ESPTracers = val end)
        
    elseif tabName == "🏃 Movement" then
        yPos = CreateSection("Movement Features", yPos)
        yPos = CreateCheckbox("Speed Hack", Settings.SpeedHack, yPos, function(val) 
            Settings.SpeedHack = val
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = val and Settings.SpeedValue or 16
            end
        end)
        yPos = CreateSlider("Speed Value", 16, 200, Settings.SpeedValue, yPos, function(val) 
            Settings.SpeedValue = val
            if Settings.SpeedHack and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = val
            end
        end)
        yPos = CreateCheckbox("Fly Hack", Settings.FlyHack, yPos, function(val) 
            Settings.FlyHack = val
            if val then Fly() else Unfly() end
        end)
        yPos = CreateSlider("Fly Speed", 10, 100, Settings.FlySpeed, yPos, function(val) Settings.FlySpeed = val end)
        yPos = CreateCheckbox("No Clip", Settings.NoClip, yPos, function(val) 
            Settings.NoClip = val
            if val then
                NoClipConnection = RunService.Stepped:Connect(function()
                    if LocalPlayer.Character then
                        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end
                end)
            else
                if NoClipConnection then NoClipConnection:Disconnect() end
            end
        end)
        
    elseif tabName == "👤 Player" then
        yPos = CreateSection("Player Features", yPos)
        yPos = CreateCheckbox("God Mode", Settings.GodMode, yPos, function(val) 
            Settings.GodMode = val
            if val then
                GodModeConnection = RunService.RenderStepped:Connect(function()
                    if Settings.GodMode and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                        LocalPlayer.Character.Humanoid.Health = LocalPlayer.Character.Humanoid.MaxHealth
                    end
                end)
            else
                if GodModeConnection then GodModeConnection:Disconnect() end
            end
        end)
        yPos = CreateCheckbox("Invisible", Settings.Invisible, yPos, function(val) 
            Settings.Invisible = val
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.Transparency = val and 1 or 0
                    end
                end
            end
        end)
        yPos = CreateCheckbox("No Fall Damage", Settings.NoFallDamage, yPos, function(val) Settings.NoFallDamage = val end)
        
    elseif tabName == "📍 Teleport" then
        yPos = CreateSection("Teleport Locations", yPos)
        yPos = CreateButton("Teleport to Random Player", yPos, function()
            local randomPlayer = Players:GetPlayers()[math.random(1, #Players:GetPlayers())]
            if randomPlayer and randomPlayer ~= LocalPlayer then
                TeleportToPlayer(randomPlayer)
            end
        end)
        yPos = CreateButton("Teleport to Spawn", yPos, function()
            if LocalPlayer.Character then
                LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(0, 50, 0))
            end
        end)
    end
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 20)
end

-- Загрузка первой вкладки
LoadTab("🎨 Visuals")

-- Делаем окно перетаскиваемым
local dragging = false
local dragStart = nil
local frameStart = nil

TitleBar.MouseButton1Down:Connect(function()
    dragging = true
    dragStart = UserInputService:GetMouseLocation()
    frameStart = MainFrame.Position
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mousePos = UserInputService:GetMouseLocation()
        local delta = mousePos - dragStart
        MainFrame.Position = UDim2.new(frameStart.X.Scale, frameStart.X.Offset + delta.X, frameStart.Y.Scale, frameStart.Y.Offset + delta.Y)
    end
end)

-- ============ MAIN LOOP ============
RunService.RenderStepped:Connect(function()
    -- Aimbot
    if Settings.Aimbot then
        local target = GetClosestPlayer()
        if target and target.Character then
            local targetPart = target.Character:FindFirstChild("Head")
            if targetPart then
                Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, targetPart.Position), Settings.AimbotSmooth / 10)
            end
        end
    end
    
    -- Trigger Bot
    if Settings.TriggerBot then
        local target = GetClosestPlayer()
        if target and target.Character then
            local mouse = LocalPlayer:GetMouse()
            mouse1click()
        end
    end
    
    -- Rapid Fire
    if Settings.RapidFire then
        if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
            local mouse = LocalPlayer:GetMouse()
            mouse1click()
        end
    end
    
    -- No Fall Damage
    if Settings.NoFallDamage then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.FallSpeed = 0
        end
    end
end)

-- ESP
RunService.RenderStepped:Connect(function()
    if Settings.ESP then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
                local head = player.Character:FindFirstChild("Head")
                local root = player.Character:FindFirstChild("HumanoidRootPart")
                
                if head and root then
                    local headPos, onScreen = Camera:WorldToScreenPoint(head.Position)
                    
                    if onScreen then
                        -- Здесь можно добавить ESP отрисовку
                    end
                end
            end
        end
    end
end)

-- Silent Aim
RunService.RenderStepped:Connect(function()
    if Settings.SilentAim then
        local target = GetClosestPlayer()
        if target and target.Character and LocalPlayer.Character then
            local targetPart = target.Character:FindFirstChild("Head")
            if targetPart then
                local weapon = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if weapon and weapon:FindFirstChild("Handle") then
                    weapon.Handle.CFrame = CFrame.new(weapon.Handle.Position, targetPart.Position)
                end
            end
        end
    end
end)

print("PulseVisuals | Violence District loaded!")
print("Made by ughqgeigwd")
