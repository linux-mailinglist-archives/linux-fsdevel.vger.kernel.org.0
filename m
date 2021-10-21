Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAC74366FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 17:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbhJUQBS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 12:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhJUQBP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:01:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041BEC061243;
        Thu, 21 Oct 2021 08:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+t/vvP4oUE+C+jnp9T5zmZocQtVq/GU6RPnUPNVoq9E=; b=ouSBtCIGhtHVe8yatmK3EAo7fW
        UOTws2bYS2nTtBEhIFbV8kK1jHEnGf0nTf6IHdlQb3B9F2tEsXCn9YyI80UIM3Gr5o9zgn5c26YI1
        11gqSo4rRA9xaWTiu4avIKOIaZYnulivS3CVa2PT6BmOmWUcDQr78L8nCoxTooMIYIoVjvSyUidXX
        3NFYDTOx0ch+fE5bQYNjqvTAuQR5vCewtp3pdxSytkIX5CFgUQG4AzNgCc0P2XLnGslcLzj7psAMV
        2LPuPUpJ/mQpnd1ORfp6Vx3yHxhZ4sONAErKI4TxIodI/3dwj43ZMKoCimMkA5XYTMOnaT+OcEvIw
        42CjrYrw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdaSq-008GME-Kx; Thu, 21 Oct 2021 15:58:44 +0000
From:   "Luis R. Rodriguez" <mcgrof@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     bp@suse.de, akpm@linux-foundation.org, josh@joshtriplett.org,
        rishabhb@codeaurora.org, kubakici@wp.pl, maco@android.com,
        david.brown@linaro.org, bjorn.andersson@linaro.org,
        linux-wireless@vger.kernel.org, keescook@chromium.org,
        shuah@kernel.org, mfuzzey@parkeon.com, zohar@linux.vnet.ibm.com,
        dhowells@redhat.com, pali.rohar@gmail.com, tiwai@suse.de,
        arend.vanspriel@broadcom.com, zajec5@gmail.com, nbroeking@me.com,
        broonie@kernel.org, dmitry.torokhov@gmail.com, dwmw2@infradead.org,
        torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
        jewalt@lgsinnovations.com, cantabile.desu@gmail.com, ast@fb.com,
        andresx7@gmail.com, dan.rue@linaro.org, brendanhiggins@google.com,
        yzaikin@google.com, sfr@canb.auug.org.au, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 07/10] firmware_loader: rename EXTRA_FIRMWARE and EXTRA_FIRMWARE_DIR
Date:   Thu, 21 Oct 2021 08:58:40 -0700
Message-Id: <20211021155843.1969401-8-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211021155843.1969401-1-mcgrof@kernel.org>
References: <20211021155843.1969401-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

Now that we've tied loose ends on the built-in firmware API,
rename the kconfig symbols for it to reflect more that they are
associated to the firmware_loader and to make it easier to
understand what they are for.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 .../driver-api/firmware/built-in-fw.rst       |  6 ++--
 Documentation/x86/microcode.rst               |  8 ++---
 arch/x86/Kconfig                              |  4 +--
 drivers/base/firmware_loader/Kconfig          | 29 ++++++++++++-------
 drivers/base/firmware_loader/builtin/Makefile |  6 ++--
 drivers/staging/media/av7110/Kconfig          |  4 +--
 6 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/Documentation/driver-api/firmware/built-in-fw.rst b/Documentation/driver-api/firmware/built-in-fw.rst
index bc1c961bace1..a9a0ab8c9512 100644
--- a/Documentation/driver-api/firmware/built-in-fw.rst
+++ b/Documentation/driver-api/firmware/built-in-fw.rst
@@ -8,11 +8,11 @@ the filesystem. Instead, firmware can be looked for inside the kernel
 directly. You can enable built-in firmware using the kernel configuration
 options:
 
-  * CONFIG_EXTRA_FIRMWARE
-  * CONFIG_EXTRA_FIRMWARE_DIR
+  * CONFIG_FW_LOADER_BUILTIN_FILES
+  * CONFIG_FW_LOADER_BUILTIN_DIR
 
 There are a few reasons why you might want to consider building your firmware
-into the kernel with CONFIG_EXTRA_FIRMWARE:
+into the kernel with CONFIG_FW_LOADER_BUILTIN_FILES:
 
 * Speed
 * Firmware is needed for accessing the boot device, and the user doesn't
diff --git a/Documentation/x86/microcode.rst b/Documentation/x86/microcode.rst
index a320d37982ed..2cacc7f60014 100644
--- a/Documentation/x86/microcode.rst
+++ b/Documentation/x86/microcode.rst
@@ -114,13 +114,13 @@ Builtin microcode
 =================
 
 The loader supports also loading of a builtin microcode supplied through
-the regular builtin firmware method CONFIG_EXTRA_FIRMWARE. Only 64-bit is
-currently supported.
+the regular builtin firmware method using CONFIG_FW_LOADER_BUILTIN and
+CONFIG_FW_LOADER_BUILTIN_FILES. Only 64-bit is currently supported.
 
 Here's an example::
 
-  CONFIG_EXTRA_FIRMWARE="intel-ucode/06-3a-09 amd-ucode/microcode_amd_fam15h.bin"
-  CONFIG_EXTRA_FIRMWARE_DIR="/lib/firmware"
+  CONFIG_FW_LOADER_BUILTIN_FILES="intel-ucode/06-3a-09 amd-ucode/microcode_amd_fam15h.bin"
+  CONFIG_FW_LOADER_BUILTIN_DIR="/lib/firmware"
 
 This basically means, you have the following tree structure locally::
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 999907dd7544..cfb09dc7f21b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1315,8 +1315,8 @@ config MICROCODE
 	  initrd for microcode blobs.
 
 	  In addition, you can build the microcode into the kernel. For that you
-	  need to add the vendor-supplied microcode to the CONFIG_EXTRA_FIRMWARE
-	  config option.
+	  need to add the vendor-supplied microcode to the configuration option
+	  CONFIG_FW_LOADER_BUILTIN_FILES
 
 config MICROCODE_INTEL
 	bool "Intel microcode loading support"
diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
index 5b24f3959255..2dc3e137d903 100644
--- a/drivers/base/firmware_loader/Kconfig
+++ b/drivers/base/firmware_loader/Kconfig
@@ -22,14 +22,14 @@ config FW_LOADER
 	  You typically want this built-in (=y) but you can also enable this
 	  as a module, in which case the firmware_class module will be built.
 	  You also want to be sure to enable this built-in if you are going to
-	  enable built-in firmware (CONFIG_EXTRA_FIRMWARE).
+	  enable built-in firmware (CONFIG_FW_LOADER_BUILTIN_FILES).
 
 if FW_LOADER
 
 config FW_LOADER_PAGED_BUF
 	bool
 
-config EXTRA_FIRMWARE
+config FW_LOADER_BUILTIN_FILES
 	string "Build named firmware blobs into the kernel binary"
 	help
 	  Device drivers which require firmware can typically deal with
@@ -43,14 +43,21 @@ config EXTRA_FIRMWARE
 	  in boot and cannot rely on the firmware being placed in an initrd or
 	  initramfs.
 
-	  This option is a string and takes the (space-separated) names of the
+	  Support for built-in firmware is not supported if you are using
+	  the firmware loader as a module.
+
+	  This option is a string and takes the space-separated names of the
 	  firmware files -- the same names that appear in MODULE_FIRMWARE()
 	  and request_firmware() in the source. These files should exist under
-	  the directory specified by the EXTRA_FIRMWARE_DIR option, which is
+	  the directory specified by the FW_LOADER_BUILTIN_DIR option, which is
 	  /lib/firmware by default.
 
-	  For example, you might set CONFIG_EXTRA_FIRMWARE="usb8388.bin", copy
-	  the usb8388.bin file into /lib/firmware, and build the kernel. Then
+	  For example, you might have set:
+
+	  CONFIG_FW_LOADER_BUILTIN_FILES="usb8388.bin"
+
+	  After this you would copy the usb8388.bin file into directory
+	  specified by FW_LOADER_BUILTIN_DIR and build the kernel. Then
 	  any request_firmware("usb8388.bin") will be satisfied internally
 	  inside the kernel without ever looking at your filesystem at runtime.
 
@@ -60,13 +67,15 @@ config EXTRA_FIRMWARE
 	  image since it combines both GPL and non-GPL work. You should
 	  consult a lawyer of your own before distributing such an image.
 
-config EXTRA_FIRMWARE_DIR
-	string "Firmware blobs root directory"
+config FW_LOADER_BUILTIN_DIR
+	string "Directory with firmware to be built-in to the kernel"
 	depends on EXTRA_FIRMWARE != ""
 	default "/lib/firmware"
 	help
-	  This option controls the directory in which the kernel build system
-	  looks for the firmware files listed in the EXTRA_FIRMWARE option.
+	  This option specifies the directory which the kernel build system
+	  will use to look for the firmware files which are going to be
+	  built into the kernel using the space-separated
+	  FW_LOADER_BUILTIN_FILES entries.
 
 config FW_LOADER_USER_HELPER
 	bool "Enable the firmware sysfs fallback mechanism"
diff --git a/drivers/base/firmware_loader/builtin/Makefile b/drivers/base/firmware_loader/builtin/Makefile
index eb4be452062a..7cdd0b5c7384 100644
--- a/drivers/base/firmware_loader/builtin/Makefile
+++ b/drivers/base/firmware_loader/builtin/Makefile
@@ -1,12 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y  += main.o
 
-# Create $(fwdir) from $(CONFIG_EXTRA_FIRMWARE_DIR) -- if it doesn't have a
+# Create $(fwdir) from $(CONFIG_FW_LOADER_BUILTIN_DIR) -- if it doesn't have a
 # leading /, it's relative to $(srctree).
-fwdir := $(subst $(quote),,$(CONFIG_EXTRA_FIRMWARE_DIR))
+fwdir := $(subst $(quote),,$(CONFIG_FW_LOADER_BUILTIN_DIR))
 fwdir := $(addprefix $(srctree)/,$(filter-out /%,$(fwdir)))$(filter /%,$(fwdir))
 
-firmware  := $(addsuffix .gen.o, $(subst $(quote),,$(CONFIG_EXTRA_FIRMWARE)))
+firmware  := $(addsuffix .gen.o, $(subst $(quote),,$(CONFIG_FW_LOADER_BUILTIN_FILES)))
 obj-y += $(firmware)
 
 FWNAME    = $(patsubst $(obj)/%.gen.S,%,$@)
diff --git a/drivers/staging/media/av7110/Kconfig b/drivers/staging/media/av7110/Kconfig
index 9faf9d2d4001..87c7702f72f6 100644
--- a/drivers/staging/media/av7110/Kconfig
+++ b/drivers/staging/media/av7110/Kconfig
@@ -31,8 +31,8 @@ config DVB_AV7110
 	  or /lib/firmware (depending on configuration of firmware hotplug).
 
 	  Alternatively, you can download the file and use the kernel's
-	  EXTRA_FIRMWARE configuration option to build it into your
-	  kernel image by adding the filename to the EXTRA_FIRMWARE
+	  FW_LOADER_BUILTIN_FILES configuration option to build it into your
+	  kernel image by adding the filename to the FW_LOADER_BUILTIN_FILES
 	  configuration option string.
 
 	  Say Y if you own such a card and want to use it.
-- 
2.30.2

