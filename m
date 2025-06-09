Return-Path: <linux-fsdevel+bounces-51037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A822AD210F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 16:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D693ABA51
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 14:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A938C25D8E4;
	Mon,  9 Jun 2025 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIB0bmtg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21A760DCF;
	Mon,  9 Jun 2025 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749479782; cv=none; b=L2qO9OvSG88VUcyWg0taMBfPApgj6TrjcnL0mWj7YUxWNT+YNBoHDDJl9B2J2TORjiOoyMESBYaFnP656FPkerMDw0Ore0gG9NNY1XfdkkesycmO5OOQTiLC2l1aBdZsY3pD8wPhq19jjwkqLbAU/PiOt5llLlPx70aqboYg9IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749479782; c=relaxed/simple;
	bh=dtDoz4lFxHUrcNFFc2ksHg5b9nQk/UBSA45CCM1lT3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fd4N2H/BoWaFNhS/a1+0ryJ0a7R7V1/YOFgU2lKs9Zbrp/CGJxl0ka/EDI1ZGiljvzTQvXCTQRyimLei11x5Ya9QaXwvVbjcrx0Rdr1zCJo1dAiMWsbLPKEbulP/LFpCDDzuh5RFH2P9aBDcnA09DJ3ztAZcCLYnyQ8oo5IJUfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIB0bmtg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D8FC4CEF0;
	Mon,  9 Jun 2025 14:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749479780;
	bh=dtDoz4lFxHUrcNFFc2ksHg5b9nQk/UBSA45CCM1lT3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IIB0bmtgUJBIR6dCR1po5pvdKRHtFE7AWpA+ome6M7jicyY/jzw9KPr6R3dFOzszN
	 KgTjtQoDJ+Up/RvX95bNTyMOp+rNqGzT44TBBXdaOX0SOgNt7bimDW4esCJO0pbTgt
	 f68icJ2iX3ohNucKrXxthOCFqbUxPthojzuSjM/0its+2Ty2Gd8gocLCurtk5LjtBh
	 WH4bNgMK5frossZ/5EZXFAXR7/qMafJ/rcenzo4KRAZeFm6UKtvACpOYd3Wn/pYJy9
	 6iuTltXaVu33mYMlfymtYYPxYGC+oek+puV0fhsMlwKX87lUpF2k6Yr/IJwCXCBeUL
	 SuFC9iBCED0ug==
From: Hans de Goede <hansg@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Hans de Goede <hansg@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-ide@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH v2 1/1] MAINTAINERS: .mailmap: Update Hans de Goede's email address
Date: Mon,  9 Jun 2025 16:35:57 +0200
Message-ID: <20250609143558.42941-2-hansg@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609143558.42941-1-hansg@kernel.org>
References: <20250609143558.42941-1-hansg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm moving all my kernel work over to using my kernel.org email address.
Update .mailmap and MAINTAINER entries still using hdegoede@redhat.com.

Signed-off-by: Hans de Goede <hansg@kernel.org>
---
 .mailmap    |  1 +
 MAINTAINERS | 72 ++++++++++++++++++++++++++---------------------------
 2 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/.mailmap b/.mailmap
index 9b0dc7c30e6d..6ea2677ae494 100644
--- a/.mailmap
+++ b/.mailmap
@@ -276,6 +276,7 @@ Gustavo Padovan <gustavo@las.ic.unicamp.br>
 Gustavo Padovan <padovan@profusion.mobi>
 Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> <hamza.mahfooz@amd.com>
 Hanjun Guo <guohanjun@huawei.com> <hanjun.guo@linaro.org>
+Hans de Goede <hansg@kernel.org> <hdegoede@redhat.com>
 Hans Verkuil <hverkuil@xs4all.nl> <hansverk@cisco.com>
 Hans Verkuil <hverkuil@xs4all.nl> <hverkuil-cisco@xs4all.nl>
 Harry Yoo <harry.yoo@oracle.com> <42.hyeyoo@gmail.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index b8a8d8a5a2e1..020ee13d64c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -207,7 +207,7 @@ X:	arch/*/include/uapi/
 X:	include/uapi/
 
 ABIT UGURU 1,2 HARDWARE MONITOR DRIVER
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	drivers/hwmon/abituguru.c
@@ -371,7 +371,7 @@ S:	Maintained
 F:	drivers/platform/x86/quickstart.c
 
 ACPI SERIAL MULTI INSTANTIATE DRIVER
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/serial-multi-instantiate.c
@@ -3506,7 +3506,7 @@ F:	arch/arm64/boot/Makefile
 F:	scripts/make_fit.py
 
 ARM64 PLATFORM DRIVERS
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
 R:	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
 L:	platform-driver-x86@vger.kernel.org
@@ -3667,7 +3667,7 @@ F:	drivers/platform/x86/asus*.c
 F:	drivers/platform/x86/eeepc*.c
 
 ASUS TF103C DOCK DRIVER
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
@@ -5553,14 +5553,14 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.git
 F:	drivers/usb/chipidea/
 
 CHIPONE ICN8318 I2C TOUCHSCREEN DRIVER
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/input/touchscreen/chipone,icn8318.yaml
 F:	drivers/input/touchscreen/chipone_icn8318.c
 
 CHIPONE ICN8505 I2C TOUCHSCREEN DRIVER
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/input/touchscreen/chipone_icn8505.c
@@ -6844,7 +6844,7 @@ F:	include/dt-bindings/pmu/exynos_ppmu.h
 F:	include/linux/devfreq-event.h
 
 DEVICE RESOURCE MANAGEMENT HELPERS
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 R:	Matti Vaittinen <mazziesaccount@gmail.com>
 S:	Maintained
 F:	include/linux/devm-helpers.h
@@ -7435,7 +7435,7 @@ F:	drivers/gpu/drm/gud/
 F:	include/drm/gud.h
 
 DRM DRIVER FOR GRAIN MEDIA GM12U320 PROJECTORS
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	drivers/gpu/drm/tiny/gm12u320.c
@@ -7809,7 +7809,7 @@ F:	drivers/gpu/drm/ci/xfails/vkms*
 F:	drivers/gpu/drm/vkms/
 
 DRM DRIVER FOR VIRTUALBOX VIRTUAL GPU
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
@@ -8208,7 +8208,7 @@ F:	drivers/gpu/drm/panel/
 F:	include/drm/drm_panel.h
 
 DRM PRIVACY-SCREEN CLASS
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
@@ -10101,7 +10101,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/connector/gocontroll,moduline-module-slot.yaml
 
 GOODIX TOUCHSCREEN
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/input/touchscreen/goodix*
@@ -10139,7 +10139,7 @@ F:	include/dt-bindings/clock/google,gs101.h
 K:	[gG]oogle.?[tT]ensor
 
 GPD POCKET FAN DRIVER
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/gpd-pocket-fan.c
@@ -11287,7 +11287,7 @@ F:	drivers/i2c/busses/i2c-via.c
 F:	drivers/i2c/busses/i2c-viapro.c
 
 I2C/SMBUS INTEL CHT WHISKEY COVE PMIC DRIVER
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 L:	linux-i2c@vger.kernel.org
 S:	Maintained
 F:	drivers/i2c/busses/i2c-cht-wc.c
@@ -11868,13 +11868,13 @@ S:	Supported
 F:	sound/soc/intel/
 
 INTEL ATOMISP2 DUMMY / POWER-MANAGEMENT DRIVER
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/intel/atomisp2/pm.c
 
 INTEL ATOMISP2 LED DRIVER
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/intel/atomisp2/led.c
@@ -13535,7 +13535,7 @@ S:	Maintained
 F:	drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
 
 LETSKETCH HID TABLET DRIVER
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 L:	linux-input@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
@@ -13585,7 +13585,7 @@ F:	drivers/ata/sata_gemini.c
 F:	drivers/ata/sata_gemini.h
 
 LIBATA SATA AHCI PLATFORM devices support
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 L:	linux-ide@vger.kernel.org
 S:	Maintained
 F:	drivers/ata/ahci_platform.c
@@ -13956,7 +13956,7 @@ F:	Documentation/admin-guide/ldm.rst
 F:	block/partitions/ldm.*
 
 LOGITECH HID GAMING KEYBOARDS
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 L:	linux-input@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
@@ -14623,7 +14623,7 @@ F:	Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
 F:	drivers/power/supply/max17040_battery.c
 
 MAXIM MAX17042 FAMILY FUEL GAUGE DRIVERS
-R:	Hans de Goede <hdegoede@redhat.com>
+R:	Hans de Goede <hansg@kernel.org>
 R:	Krzysztof Kozlowski <krzk@kernel.org>
 R:	Marek Szyprowski <m.szyprowski@samsung.com>
 R:	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
@@ -15414,7 +15414,7 @@ Q:	https://patchwork.kernel.org/project/netdevbpf/list/
 F:	drivers/net/ethernet/mellanox/mlxfw/
 
 MELLANOX HARDWARE PLATFORM SUPPORT
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
 M:	Vadim Pasternak <vadimp@nvidia.com>
 L:	platform-driver-x86@vger.kernel.org
@@ -16332,7 +16332,7 @@ S:	Maintained
 F:	drivers/platform/surface/surface_gpe.c
 
 MICROSOFT SURFACE HARDWARE PLATFORM SUPPORT
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
 M:	Maximilian Luz <luzmaximilian@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
@@ -17496,7 +17496,7 @@ F:	tools/include/nolibc/
 F:	tools/testing/selftests/nolibc/
 
 NOVATEK NVT-TS I2C TOUCHSCREEN DRIVER
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/input/touchscreen/novatek,nvt-ts.yaml
@@ -22430,7 +22430,7 @@ K:	fu[57]40
 K:	[^@]sifive
 
 SILEAD TOUCHSCREEN DRIVER
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 L:	linux-input@vger.kernel.org
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
@@ -22463,7 +22463,7 @@ F:	Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
 F:	drivers/i3c/master/svc-i3c-master.c
 
 SIMPLEFB FB DRIVER
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 L:	linux-fbdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/display/simple-framebuffer.yaml
@@ -22592,7 +22592,7 @@ F:	Documentation/hwmon/emc2103.rst
 F:	drivers/hwmon/emc2103.c
 
 SMSC SCH5627 HARDWARE MONITOR DRIVER
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 L:	linux-hwmon@vger.kernel.org
 S:	Supported
 F:	Documentation/hwmon/sch5627.rst
@@ -23241,7 +23241,7 @@ S:	Supported
 F:	Documentation/process/stable-kernel-rules.rst
 
 STAGING - ATOMISP DRIVER
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
 R:	Sakari Ailus <sakari.ailus@linux.intel.com>
 L:	linux-media@vger.kernel.org
@@ -23538,7 +23538,7 @@ F:	arch/m68k/sun3*/
 F:	drivers/net/ethernet/i825xx/sun3*
 
 SUN4I LOW RES ADC ATTACHED TABLET KEYS DRIVER
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
@@ -25258,7 +25258,7 @@ F:	Documentation/hid/hiddev.rst
 F:	drivers/hid/usbhid/
 
 USB INTEL XHCI ROLE MUX DRIVER
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
 F:	drivers/usb/roles/intel-xhci-usb-role-switch.c
@@ -25449,7 +25449,7 @@ F:	Documentation/firmware-guide/acpi/intel-pmc-mux.rst
 F:	drivers/usb/typec/mux/intel_pmc_mux.c
 
 USB TYPEC PI3USB30532 MUX DRIVER
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
 F:	drivers/usb/typec/mux/pi3usb30532.c
@@ -25478,7 +25478,7 @@ F:	drivers/usb/host/uhci*
 
 USB VIDEO CLASS
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 W:	http://www.ideasonboard.org/uvc/
@@ -26001,7 +26001,7 @@ F:	include/uapi/linux/virtio_snd.h
 F:	sound/virtio/*
 
 VIRTUAL BOX GUEST DEVICE DRIVER
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 M:	Arnd Bergmann <arnd@arndb.de>
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 S:	Maintained
@@ -26010,7 +26010,7 @@ F:	include/linux/vbox_utils.h
 F:	include/uapi/linux/vbox*.h
 
 VIRTUAL BOX SHARED FOLDER VFS DRIVER
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
 F:	fs/vboxsf/*
@@ -26263,7 +26263,7 @@ F:	drivers/mmc/host/wbsd.*
 
 WACOM PROTOCOL 4 SERIAL TABLETS
 M:	Julian Squires <julian@cipht.net>
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/input/tablet/wacom_serial4.c
@@ -26424,7 +26424,7 @@ F:	include/linux/wwan.h
 F:	include/uapi/linux/wwan.h
 
 X-POWERS AXP288 PMIC DRIVERS
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 S:	Maintained
 F:	drivers/acpi/pmic/intel_pmic_xpower.c
 N:	axp288
@@ -26516,14 +26516,14 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
 F:	arch/x86/mm/
 
 X86 PLATFORM ANDROID TABLETS DSDT FIXUP DRIVER
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
 F:	drivers/platform/x86/x86-android-tablets/
 
 X86 PLATFORM DRIVERS
-M:	Hans de Goede <hdegoede@redhat.com>
+M:	Hans de Goede <hansg@kernel.org>
 M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
-- 
2.49.0


