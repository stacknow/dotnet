# Use the official .NET SDK image for .NET 8.0
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the CSPROJ file and restore dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the application files
COPY . ./

# Build the application
RUN dotnet publish -c Release -o /app/publish

# Use the runtime image for .NET 8.0
FROM mcr.microsoft.com/dotnet/aspnet:8.0

# Set the working directory inside the container
WORKDIR /app

# Copy the published files from the build stage
COPY --from=build /app/publish .

# Expose port 80
EXPOSE 80

# Set the entry point for the application
ENTRYPOINT ["dotnet", "DotNetApp.dll"]
