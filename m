Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4FD740FF34
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 20:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344532AbhIQSYc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 14:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344524AbhIQSYR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 14:24:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C594EC061768;
        Fri, 17 Sep 2021 11:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Iu5EEZjwltqs2N860TioX8KgIjxPxn8KDGVoWqpsxrA=; b=p6Kb4Ueij1g/DmufXMCh5opuW5
        hLt53u40jBqA8WAO9H2CPW2ZsMM5h9PlXtyx3kiOSpw/eRih/Hq31NeXxgq9CtTygqMGUKeWOH02j
        AcOokCGQZnSqwi2pNxy45Eer8IV/B6+k4MnzO5eiALLSI1Re38irsl2pVHcAJs/pCEuZYIDf8LZKP
        EY2Ok9d7TdtvfxtZeTXqbzy11PMClGEch4XKOD0hOCeKNYKKlMQF9EE/q+K/z/ADwcMyJTO9XifIc
        OGY4vqdG7WtkUOn6Q+lm+B6GVuG3DZtJ9+ek8hiRET9NUYJZ7/Zi/MN94+J0nWstS64DmVL2/Gofm
        pzQe+08Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRIVI-00Ep5W-7c; Fri, 17 Sep 2021 18:22:28 +0000
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
Subject: [PATCH 04/14] firmware_loader: add built-in firmware kconfig entry
Date:   Fri, 17 Sep 2021 11:22:16 -0700
Message-Id: <20210917182226.3532898-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210917182226.3532898-1-mcgrof@kernel.org>
References: <20210917182226.3532898-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

The built-in firmware is always supported when a user enables
FW_LOADER=y today, that is, it is built-in to the kernel. When the
firmware loader is built as a module, support for built-in firmware
is skipped. This requirement is not really clear to users or even
developers.

Also, by default the EXTRA_FIRMWARE is always set to an empty string
and so by default we really have nothing built-in to that kernel's
sections for built-in firmware, so today a all FW_LOADER=y kernels
spins their wheels on an empty set of built-in firmware for each
firmware request with no true need for it.

Add a new kconfig entry to represent built-in firmware support more
clearly. This let's knock 3 birds with one stone:

 o Clarifies that support for built-in firmware requires the
   firmware loader to be built-in to the kernel

 o By default we now always skip built-in firmware even if a FW_LOADER=y

 o This also lets us make it clear that the EXTRA_FIRMWARE_DIR
   kconfig entry is only used for built-in firmware

Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 .../driver-api/firmware/built-in-fw.rst       |  2 ++
 Documentation/x86/microcode.rst               |  5 ++--
 drivers/base/firmware_loader/Kconfig          | 25 +++++++++++++------
 drivers/base/firmware_loader/Makefile         |  3 +--
 drivers/base/firmware_loader/main.c           |  4 +--
 5 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/Documentation/driver-api/firmware/built-in-fw.rst b/Documentation/driver-api/firmware/built-in-fw.rst
index bc1c961bace1..9dd2b1df44f0 100644
--- a/Documentation/driver-api/firmware/built-in-fw.rst
+++ b/Documentation/driver-api/firmware/built-in-fw.rst
@@ -8,6 +8,7 @@ the filesystem. Instead, firmware can be looked for inside the kernel
 directly. You can enable built-in firmware using the kernel configuration
 options:
 
+  * CONFIG_FW_LOADER_BUILTIN
   * CONFIG_EXTRA_FIRMWARE
   * CONFIG_EXTRA_FIRMWARE_DIR
 
@@ -17,6 +18,7 @@ into the kernel with CONFIG_EXTRA_FIRMWARE:
 * Speed
 * Firmware is needed for accessing the boot device, and the user doesn't
   want to stuff the firmware into the boot initramfs.
+* Testing built-in firmware
 
 Even if you have these needs there are a few reasons why you may not be
 able to make use of built-in firmware:
diff --git a/Documentation/x86/microcode.rst b/Documentation/x86/microcode.rst
index a320d37982ed..d199f0b98869 100644
--- a/Documentation/x86/microcode.rst
+++ b/Documentation/x86/microcode.rst
@@ -114,11 +114,12 @@ Builtin microcode
 =================
 
 The loader supports also loading of a builtin microcode supplied through
-the regular builtin firmware method CONFIG_EXTRA_FIRMWARE. Only 64-bit is
-currently supported.
+the regular builtin firmware method using CONFIG_FW_LOADER_BUILTIN and
+CONFIG_EXTRA_FIRMWARE. Only 64-bit is currently supported.
 
 Here's an example::
 
+  CONFIG_FW_LOADER_BUILTIN=y
   CONFIG_EXTRA_FIRMWARE="intel-ucode/06-3a-09 amd-ucode/microcode_amd_fam15h.bin"
   CONFIG_EXTRA_FIRMWARE_DIR="/lib/firmware"
 
diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
index 5b24f3959255..de4fcd9d41f3 100644
--- a/drivers/base/firmware_loader/Kconfig
+++ b/drivers/base/firmware_loader/Kconfig
@@ -29,8 +29,10 @@ if FW_LOADER
 config FW_LOADER_PAGED_BUF
 	bool
 
-config EXTRA_FIRMWARE
-	string "Build named firmware blobs into the kernel binary"
+config FW_LOADER_BUILTIN
+	bool "Enable support for built-in firmware"
+	default n
+	depends on FW_LOADER=y
 	help
 	  Device drivers which require firmware can typically deal with
 	  having the kernel load firmware from the various supported
@@ -43,7 +45,14 @@ config EXTRA_FIRMWARE
 	  in boot and cannot rely on the firmware being placed in an initrd or
 	  initramfs.
 
-	  This option is a string and takes the (space-separated) names of the
+	  Support for built-in firmware is not supported if you are using
+	  the firmware loader as a module.
+
+config EXTRA_FIRMWARE
+	string "Build named firmware blobs into the kernel binary"
+	depends on FW_LOADER_BUILTIN
+	help
+	  This option is a string and takes the space-separated names of the
 	  firmware files -- the same names that appear in MODULE_FIRMWARE()
 	  and request_firmware() in the source. These files should exist under
 	  the directory specified by the EXTRA_FIRMWARE_DIR option, which is
@@ -61,12 +70,14 @@ config EXTRA_FIRMWARE
 	  consult a lawyer of your own before distributing such an image.
 
 config EXTRA_FIRMWARE_DIR
-	string "Firmware blobs root directory"
-	depends on EXTRA_FIRMWARE != ""
+	string "Directory with firmware to be built-in to the kernel"
+	depends on FW_LOADER_BUILTIN
 	default "/lib/firmware"
 	help
-	  This option controls the directory in which the kernel build system
-	  looks for the firmware files listed in the EXTRA_FIRMWARE option.
+	  This option specifies the directory which the kernel build system
+	  will use to look for the firmware files which are going to be
+	  built into the kernel using the space-separated EXTRA_FIRMWARE
+	  entries.
 
 config FW_LOADER_USER_HELPER
 	bool "Enable the firmware sysfs fallback mechanism"
diff --git a/drivers/base/firmware_loader/Makefile b/drivers/base/firmware_loader/Makefile
index e87843408fe6..a2dbfa19201c 100644
--- a/drivers/base/firmware_loader/Makefile
+++ b/drivers/base/firmware_loader/Makefile
@@ -1,10 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for the Linux firmware loader
 
+obj-$(CONFIG_FW_LOADER_BUILTIN) += builtin/
 obj-$(CONFIG_FW_LOADER_USER_HELPER) += fallback_table.o
 obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
 firmware_class-objs := main.o
 firmware_class-$(CONFIG_FW_LOADER_USER_HELPER) += fallback.o
 firmware_class-$(CONFIG_EFI_EMBEDDED_FIRMWARE) += fallback_platform.o
-
-obj-y += builtin/
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index d95b5fe5f700..45075c7f9290 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -95,7 +95,7 @@ static struct firmware_cache fw_cache;
 
 /* Builtin firmware support */
 
-#ifdef CONFIG_FW_LOADER
+#ifdef CONFIG_FW_LOADER_BUILTIN
 
 extern struct builtin_fw __start_builtin_fw[];
 extern struct builtin_fw __end_builtin_fw[];
@@ -148,7 +148,7 @@ static bool fw_is_builtin_firmware(const struct firmware *fw)
 	return false;
 }
 
-#else /* Module case - no builtin firmware support */
+#else
 
 static inline bool firmware_request_builtin(struct firmware *fw,
 					    const char *name)
-- 
2.30.2

