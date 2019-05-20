Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4551122C0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 08:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbfETG0Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 02:26:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33189 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbfETG0Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 02:26:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id z28so6714125pfk.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 May 2019 23:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RcwbVYwdq48sfOp6PGv07uva9wEB1qXU03ldISHqIjY=;
        b=gju99YrlA8WbvZBOLxa6NIR55Tz+k0zo57RMStRaczF+jVg2evldO1MixGeAkRO7fu
         +G8hluymiFZ0Ptf82vc5n2ioZZspWH+bbhnnsDfon8ZxTgrOqYiyBx8xhzoatN98qGwA
         NLc8rdELsVvTox/YHAnAwaqzmF4XmpCPA7RAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RcwbVYwdq48sfOp6PGv07uva9wEB1qXU03ldISHqIjY=;
        b=J0T7kYOqgOkDXghZ26tfzKgZIMi2lK0MjRuBFwLRNmV7oLcGat3IGcTdJVgUnD2AR8
         HVI8MWtDzkvINQupXNN/5JofXC4aBavIrkhRBAO0ztwNnNw7oCzQ2V5X77nYYkylQA/1
         slcRqJF8wMi+7KmLipAItkch2eeuW5WX9sSmIT/y5nOQ9T3YxSVRBCNwzvi7BZKccmvl
         7blLcI53gJ1qwwcgZX75U3DxTbygS9im3s5S8BbfAgA7vVWTo/bC4xDHpY+/8Vrc09Ro
         dBfENS9I8R9db3T7CEre1EVoSjin+odPWL+owvm0rTAUYwVrOkp9rOew95xU6aryPKXz
         S3Pg==
X-Gm-Message-State: APjAAAVJbaFCBiq/FgYo9NyM/ePHUCRmEfZtH8JJ8YahlYbfTgAsHZsE
        8wrmJ6+FVxWiX3mMqO+2xktO5w==
X-Google-Smtp-Source: APXvYqyvHrWHKtpCcMdTTtU4rHUlvDogyixu4xu4e+BkMO2Z2Bja3aXeuOOSyyKd6f4Z1VcJY8ptgg==
X-Received: by 2002:a63:144e:: with SMTP id 14mr56194249pgu.304.1558333583617;
        Sun, 19 May 2019 23:26:23 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id s137sm25511420pfc.119.2019.05.19.23.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 May 2019 23:26:23 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     nayna@linux.ibm.com, cclaudio@linux.ibm.com,
        linux-fsdevel@vger.kernel.org, greg@kroah.com,
        linuxppc-dev@lists.ozlabs.org
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [WIP RFC PATCH 5/6] powerpc/powernv: Remove EFI support for OPAL secure variables
Date:   Mon, 20 May 2019 16:25:52 +1000
Message-Id: <20190520062553.14947-6-dja@axtens.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190520062553.14947-1-dja@axtens.net>
References: <20190520062553.14947-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace it with a generic API.

Compile tested only.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/include/asm/opal-secvar.h       |  58 +++++++++++
 arch/powerpc/platforms/Kconfig               |   3 -
 arch/powerpc/platforms/powernv/Kconfig       |   5 +-
 arch/powerpc/platforms/powernv/opal-secvar.c | 104 ++++---------------
 4 files changed, 83 insertions(+), 87 deletions(-)
 create mode 100644 arch/powerpc/include/asm/opal-secvar.h

diff --git a/arch/powerpc/include/asm/opal-secvar.h b/arch/powerpc/include/asm/opal-secvar.h
new file mode 100644
index 000000000000..ba9bd52138d9
--- /dev/null
+++ b/arch/powerpc/include/asm/opal-secvar.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PowerNV code for secure variables
+ *
+ * Copyright (C) 2019 IBM Corporation
+ * Author: Claudio Carvalho <cclaudio@linux.ibm.com>
+ * Author: Daniel Axtens <dja@axtens.net>
+ *
+ */
+
+#ifndef __OPAL_SECVAR_H
+#define __OPAL_SECVAR_H
+
+#include <linux/types.h>
+#include <linux/uuid.h>
+
+#ifdef CONFIG_OPAL_SECVAR
+int opal_get_secure_variable(u16 *name, guid_t *vendor, u32 *attr,
+			     unsigned long *data_size, void *data);
+
+int opal_get_next_secure_variable(unsigned long *name_size, u16 *name,
+				  guid_t *vendor);
+
+int opal_set_secure_variable(u16 *name, guid_t *vendor, u32 attr,
+			     unsigned long data_size, void *data);
+
+int opal_query_secure_variable_info(u32 attr, u64 *storage_space,
+				    u64 *remaining_space,
+				    u64 *max_variable_size);
+#else
+
+static inline int opal_get_secure_variable(u16 *name, guid_t *vendor,
+			u32 *attr, unsigned long *data_size, void *data)
+{
+	return OPAL_UNSUPPORTED;
+}
+
+static inline int opal_get_next_secure_variable(unsigned long *name_size,
+			u16 *name, guid_t *vendor)
+{
+	return OPAL_UNSUPPORTED;
+}
+
+static inline int opal_set_secure_variable(u16 *name, guid_t *vendor,
+			u32 attr, unsigned long data_size, void *data)
+{
+	return OPAL_UNSUPPORTED;
+}
+
+static inline int opal_query_secure_variable_info(u32 attr,
+			u64 *storage_space, u64 *remaining_space,
+			u64 *max_variable_size)
+{
+	return OPAL_UNSUPPORTED;
+}
+
+#endif
+#endif
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 8e30510bc0c1..f3fb79fccc72 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -326,7 +326,4 @@ config XILINX_PCI
 	bool "Xilinx PCI host bridge support"
 	depends on PCI && XILINX_VIRTEX
 
-config EFI
-	bool
-
 endmenu
diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index 879f8e766098..a71fc5daa60a 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -52,7 +52,6 @@ config OPAL_SECVAR
 	bool "OPAL Secure Variables"
 	depends on PPC_POWERNV && !CPU_BIG_ENDIAN
 	select UCS2_STRING
-	select EFI
 	help
-	  This enables the kernel to access OPAL secure variables via EFI
-	  runtime variable services.
+	  This enables the kernel to access OPAL secure variables via
+	  an API.
diff --git a/arch/powerpc/platforms/powernv/opal-secvar.c b/arch/powerpc/platforms/powernv/opal-secvar.c
index e333828bd0bc..af753b94cceb 100644
--- a/arch/powerpc/platforms/powernv/opal-secvar.c
+++ b/arch/powerpc/platforms/powernv/opal-secvar.c
@@ -8,62 +8,20 @@
  */
 #define pr_fmt(fmt) "secvar: "fmt
 
-#include <linux/efi.h>
 #include <asm/machdep.h>
 #include <asm/opal.h>
+#include <asm/opal-secvar.h>
+#include <linux/uuid.h>
 
 static bool opal_secvar_supported;
 
-static efi_status_t opal_to_efi_status_log(int rc, const char *func_name)
-{
-	efi_status_t status;
-
-	switch (rc) {
-	case OPAL_EMPTY:
-		status = EFI_NOT_FOUND;
-		break;
-	case OPAL_HARDWARE:
-		status = EFI_DEVICE_ERROR;
-		break;
-	case OPAL_NO_MEM:
-		pr_err("%s: No space in the volatile storage\n", func_name);
-		status = EFI_OUT_OF_RESOURCES;
-		break;
-	case OPAL_PARAMETER:
-		status = EFI_INVALID_PARAMETER;
-		break;
-	case OPAL_PARTIAL:
-		status = EFI_BUFFER_TOO_SMALL;
-		break;
-	case OPAL_PERMISSION:
-		status = EFI_WRITE_PROTECTED;
-		break;
-	case OPAL_RESOURCE:
-		pr_err("%s: No space in the non-volatile storage\n", func_name);
-		status = EFI_OUT_OF_RESOURCES;
-		break;
-	case OPAL_SUCCESS:
-		status = EFI_SUCCESS;
-		break;
-	default:
-		pr_err("%s: Unknown OPAL error %d\n", func_name, rc);
-		status = EFI_DEVICE_ERROR;
-		break;
-	}
-
-	return status;
-}
-
-#define opal_to_efi_status(rc) opal_to_efi_status_log(rc, __func__)
-
-static efi_status_t
-opal_get_variable(efi_char16_t *name, efi_guid_t *vendor, u32 *attr,
-		  unsigned long *data_size, void *data)
+int opal_get_secure_variable(u16 *name, guid_t *vendor, u32 *attr,
+			     unsigned long *data_size, void *data)
 {
 	int rc;
 
 	if (!opal_secvar_supported)
-		return EFI_UNSUPPORTED;
+		return OPAL_UNSUPPORTED;
 
 	*data_size = cpu_to_be64(*data_size);
 
@@ -77,17 +35,16 @@ opal_get_variable(efi_char16_t *name, efi_guid_t *vendor, u32 *attr,
 		*attr = be32_to_cpup(attr);
 	*data_size = be64_to_cpu(*data_size);
 
-	return opal_to_efi_status(rc);
+	return rc;
 }
 
-static efi_status_t
-opal_get_next_variable(unsigned long *name_size, efi_char16_t *name,
-		       efi_guid_t *vendor)
+int opal_get_next_secure_variable(unsigned long *name_size, u16 *name,
+				  guid_t *vendor)
 {
 	int rc;
 
 	if (!opal_secvar_supported)
-		return EFI_UNSUPPORTED;
+		return OPAL_UNSUPPORTED;
 
 	*name_size = cpu_to_be64(*name_size);
 
@@ -96,17 +53,16 @@ opal_get_next_variable(unsigned long *name_size, efi_char16_t *name,
 
 	*name_size = be64_to_cpu(*name_size);
 
-	return opal_to_efi_status(rc);
+	return rc;
 }
 
-static efi_status_t
-opal_set_variable(efi_char16_t *name, efi_guid_t *vendor, u32 attr,
-		  unsigned long data_size, void *data)
+int opal_set_secure_variable(u16 *name, guid_t *vendor, u32 attr,
+			     unsigned long data_size, void *data)
 {
 	int rc;
 
 	if (!opal_secvar_supported)
-		return EFI_UNSUPPORTED;
+		return OPAL_UNSUPPORTED;
 	/*
 	 * The secure variable update must be enqueued in order to be processed
 	 * in the next boot by firmware. The secure variable storage is write
@@ -114,17 +70,17 @@ opal_set_variable(efi_char16_t *name, efi_guid_t *vendor, u32 attr,
 	 */
 	rc = opal_secvar_enqueue(__pa(name), __pa(vendor), attr,
 				 data_size, __pa(data));
-	return opal_to_efi_status(rc);
+	return rc;
 }
 
-static efi_status_t
-opal_query_variable_info(u32 attr, u64 *storage_space, u64 *remaining_space,
-			 u64 *max_variable_size)
+int opal_query_secure_variable_info(u32 attr, u64 *storage_space,
+				    u64 *remaining_space,
+				    u64 *max_variable_size)
 {
 	int rc;
 
 	if (!opal_secvar_supported)
-		return EFI_UNSUPPORTED;
+		return OPAL_UNSUPPORTED;
 
 	*storage_space = cpu_to_be64p(storage_space);
 	*remaining_space = cpu_to_be64p(remaining_space);
@@ -137,22 +93,18 @@ opal_query_variable_info(u32 attr, u64 *storage_space, u64 *remaining_space,
 	*remaining_space = be64_to_cpup(remaining_space);
 	*max_variable_size = be64_to_cpup(max_variable_size);
 
-	return opal_to_efi_status(rc);
+	return rc;
 }
 
-static void pnv_efi_runtime_setup(void)
+static int __init pnv_opal_secvar_init(void)
 {
 	/*
 	 * The opal wrappers below treat the @name, @vendor, and @data
-	 * parameters as little endian blobs.
+	 * parameters as opaque blobs.
 	 * @name is a ucs2 string
-	 * @vendor is the vendor GUID. It is converted to LE in the kernel
+	 * @vendor is the vendor GUID in EFI format
 	 * @data variable data, which layout may be different for each variable
 	 */
-	efi.get_variable = opal_get_variable;
-	efi.get_next_variable = opal_get_next_variable;
-	efi.set_variable = opal_set_variable;
-	efi.query_variable_info = opal_query_variable_info;
 
 	if (!opal_check_token(OPAL_SECVAR_GET) ||
 	    !opal_check_token(OPAL_SECVAR_GET_NEXT) ||
@@ -163,17 +115,7 @@ static void pnv_efi_runtime_setup(void)
 	} else {
 		opal_secvar_supported = true;
 	}
-}
-
-static int __init pnv_efi_init(void)
-{
-	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
-	set_bit(EFI_BOOT, &efi.flags);
-
-	if (IS_ENABLED(CONFIG_64BIT))
-		set_bit(EFI_64BIT, &efi.flags);
 
-	pnv_efi_runtime_setup();
 	return 0;
 }
-machine_arch_initcall(powernv, pnv_efi_init);
+machine_arch_initcall(powernv, pnv_opal_secvar_init);
-- 
2.19.1

