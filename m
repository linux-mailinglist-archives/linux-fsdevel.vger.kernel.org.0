Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B12AF22C0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 08:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbfETG0U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 02:26:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33737 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbfETG0U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 02:26:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id h17so6278248pgv.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 May 2019 23:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZvN5dru2fbfadF16bU9RBwpGSyZKssYKbfiJ7DQgr6U=;
        b=FlnDODv6QDdj7/Ck4u3Y60ZH/vNr1VktUzyKDlAH3YNqQ1ecsyNiaRkdo1b0dba6Ks
         7GUltzwkhnsVmIAgZ68dL5obRI4Q0Sp9Ws0aRTHmUEQCJCeWsvwiga8RgGGeElfs/dEu
         EfQX0dfZ9fUv+G8YhesR2mouMkOuViflbcMfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZvN5dru2fbfadF16bU9RBwpGSyZKssYKbfiJ7DQgr6U=;
        b=tUCiq00ZOSemPvRCdZ5KNf4RTlUIc6dWzTMXR0uPb5zyxRau07jE8UXCJj+GiNDiG7
         RYx0++x375P9qtel56mY/csjf8onN3lISSp8AUC8mPBoTaKRkeCNvegjWcR5viii838J
         2fo1hT6xUcXUBFkEIVLoCKWdkMboMgnbpDc5u+nqeUFrgF/iw03xkuHDeAdKS7SQ5u81
         KMpQa+kX8uM+Ndh8XLygVcKMtucTa7GdZxaXA0lDbl8cXxo6MGYbh0qFTtp2+/+iv9aT
         YJKAj2wG1ueMpWpduMHEUAU+/pijKCePKZzSFle+nZITDlwstd0ZQqCmU+rjHPiEH/Wh
         XjqQ==
X-Gm-Message-State: APjAAAWY3mErETWCQry95DPKyr4ZK2AMckgUSWT0QlzEFra2k7xoY1gc
        rgvG8UL953TkSjW9MYFyaYGR3AYApKg=
X-Google-Smtp-Source: APXvYqz92sjhaj5uCz8/TF/5ffa7N1djjsTQHP+b4lFkZP7+xDoOnKGNDS2YwFwWq2egSOAo0uY4PA==
X-Received: by 2002:a63:804a:: with SMTP id j71mr74405136pgd.68.1558333578984;
        Sun, 19 May 2019 23:26:18 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id 127sm20317681pfc.159.2019.05.19.23.26.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 May 2019 23:26:18 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     nayna@linux.ibm.com, cclaudio@linux.ibm.com,
        linux-fsdevel@vger.kernel.org, greg@kroah.com,
        linuxppc-dev@lists.ozlabs.org
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [WIP RFC PATCH 4/6] powerpc/powernv: Add support for OPAL secure variables
Date:   Mon, 20 May 2019 16:25:51 +1000
Message-Id: <20190520062553.14947-5-dja@axtens.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190520062553.14947-1-dja@axtens.net>
References: <20190520062553.14947-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Claudio Carvalho <cclaudio@linux.ibm.com>

[dja: this is a WIP version - a new version is coming that changes
the interface. I also had to renumber the opal calls to get this
to apply. Basically, this is an illustration of the concept: more
work would be required to get this to actually function.]

The X.509 certificates trusted by the platform and other information
required to secure boot the host OS kernel are wrapped in secure
variables, which are controlled by OPAL.

The OPAL secure variables can be handled through the following OPAL
calls.

OPAL_SECVAR_GET:
Returns the data for a given secure variable name and vendor GUID.

OPAL_SECVAR_GET_NEXT:
For a given secure variable, it returns the name and vendor GUID
of the next variable.

OPAL_SECVAR_ENQUEUE:
Enqueue the supplied secure variable update so that it can be processed
by OPAL in the next boot. Variable updates cannot be be processed right
away because the variable storage is write locked at runtime.

OPAL_SECVAR_INFO:
Returns size information about the variable.

This patch adds support for OPAL secure variables by setting up the EFI
runtime variable services to make OPAL calls.

This patch also introduces CONFIG_OPAL_SECVAR for enabling the OPAL
secure variables support in the kernel. Since CONFIG_OPAL_SECVAR selects
CONFIG_EFI, it also allow us to manage the OPAL secure variables from
userspace via efivarfs.

Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/include/asm/opal-api.h          |   6 +-
 arch/powerpc/include/asm/opal.h              |  10 ++
 arch/powerpc/platforms/Kconfig               |   3 +
 arch/powerpc/platforms/powernv/Kconfig       |   9 +
 arch/powerpc/platforms/powernv/Makefile      |   1 +
 arch/powerpc/platforms/powernv/opal-call.c   |   4 +
 arch/powerpc/platforms/powernv/opal-secvar.c | 179 +++++++++++++++++++
 7 files changed, 211 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-secvar.c

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index e1577cfa7186..8054e1e983ff 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -212,7 +212,11 @@
 #define OPAL_HANDLE_HMI2			166
 #define	OPAL_NX_COPROC_INIT			167
 #define OPAL_XIVE_GET_VP_STATE			170
-#define OPAL_LAST				170
+#define OPAL_SECVAR_GET				171
+#define OPAL_SECVAR_GET_NEXT			172
+#define OPAL_SECVAR_ENQUEUE			173
+#define OPAL_SECVAR_INFO			174
+#define OPAL_LAST				174
 
 #define QUIESCE_HOLD			1 /* Spin all calls at entry */
 #define QUIESCE_REJECT			2 /* Fail all calls with OPAL_BUSY */
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 4cc37e708bc7..4b8046caaf4f 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -394,6 +394,16 @@ void opal_powercap_init(void);
 void opal_psr_init(void);
 void opal_sensor_groups_init(void);
 
+extern int opal_secvar_get(uint64_t name, uint64_t vendor, uint64_t attr,
+			   uint64_t data_size, uint64_t data);
+extern int opal_secvar_get_next(uint64_t name_size, uint64_t name,
+				uint64_t vendor);
+extern int opal_secvar_enqueue(uint64_t name, uint64_t vendor, uint64_t attr,
+			       uint64_t data_size, uint64_t data);
+extern int opal_secvar_info(uint64_t attr, uint64_t storage_space,
+			    uint64_t remaining_space,
+			    uint64_t max_variable_size);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_OPAL_H */
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index f3fb79fccc72..8e30510bc0c1 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -326,4 +326,7 @@ config XILINX_PCI
 	bool "Xilinx PCI host bridge support"
 	depends on PCI && XILINX_VIRTEX
 
+config EFI
+	bool
+
 endmenu
diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index 850eee860cf2..879f8e766098 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -47,3 +47,12 @@ config PPC_VAS
 	  VAS adapters are found in POWER9 based systems.
 
 	  If unsure, say N.
+
+config OPAL_SECVAR
+	bool "OPAL Secure Variables"
+	depends on PPC_POWERNV && !CPU_BIG_ENDIAN
+	select UCS2_STRING
+	select EFI
+	help
+	  This enables the kernel to access OPAL secure variables via EFI
+	  runtime variable services.
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index da2e99efbd04..1511d836fd19 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -16,3 +16,4 @@ obj-$(CONFIG_PERF_EVENTS) += opal-imc.o
 obj-$(CONFIG_PPC_MEMTRACE)	+= memtrace.o
 obj-$(CONFIG_PPC_VAS)	+= vas.o vas-window.o vas-debug.o
 obj-$(CONFIG_OCXL_BASE)	+= ocxl.o
+obj-$(CONFIG_OPAL_SECVAR)	+= opal-secvar.o
diff --git a/arch/powerpc/platforms/powernv/opal-call.c b/arch/powerpc/platforms/powernv/opal-call.c
index 36c8fa3647a2..1a2e080dd027 100644
--- a/arch/powerpc/platforms/powernv/opal-call.c
+++ b/arch/powerpc/platforms/powernv/opal-call.c
@@ -288,3 +288,7 @@ OPAL_CALL(opal_pci_set_pbcq_tunnel_bar,		OPAL_PCI_SET_PBCQ_TUNNEL_BAR);
 OPAL_CALL(opal_sensor_read_u64,			OPAL_SENSOR_READ_U64);
 OPAL_CALL(opal_sensor_group_enable,		OPAL_SENSOR_GROUP_ENABLE);
 OPAL_CALL(opal_nx_coproc_init,			OPAL_NX_COPROC_INIT);
+OPAL_CALL(opal_secvar_get,			OPAL_SECVAR_GET);
+OPAL_CALL(opal_secvar_get_next,			OPAL_SECVAR_GET_NEXT);
+OPAL_CALL(opal_secvar_enqueue,			OPAL_SECVAR_ENQUEUE);
+OPAL_CALL(opal_secvar_info,			OPAL_SECVAR_INFO)
diff --git a/arch/powerpc/platforms/powernv/opal-secvar.c b/arch/powerpc/platforms/powernv/opal-secvar.c
new file mode 100644
index 000000000000..e333828bd0bc
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-secvar.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PowerNV code for secure variables
+ *
+ * Copyright (C) 2019 IBM Corporation
+ * Author: Claudio Carvalho <cclaudio@linux.ibm.com>
+ *
+ */
+#define pr_fmt(fmt) "secvar: "fmt
+
+#include <linux/efi.h>
+#include <asm/machdep.h>
+#include <asm/opal.h>
+
+static bool opal_secvar_supported;
+
+static efi_status_t opal_to_efi_status_log(int rc, const char *func_name)
+{
+	efi_status_t status;
+
+	switch (rc) {
+	case OPAL_EMPTY:
+		status = EFI_NOT_FOUND;
+		break;
+	case OPAL_HARDWARE:
+		status = EFI_DEVICE_ERROR;
+		break;
+	case OPAL_NO_MEM:
+		pr_err("%s: No space in the volatile storage\n", func_name);
+		status = EFI_OUT_OF_RESOURCES;
+		break;
+	case OPAL_PARAMETER:
+		status = EFI_INVALID_PARAMETER;
+		break;
+	case OPAL_PARTIAL:
+		status = EFI_BUFFER_TOO_SMALL;
+		break;
+	case OPAL_PERMISSION:
+		status = EFI_WRITE_PROTECTED;
+		break;
+	case OPAL_RESOURCE:
+		pr_err("%s: No space in the non-volatile storage\n", func_name);
+		status = EFI_OUT_OF_RESOURCES;
+		break;
+	case OPAL_SUCCESS:
+		status = EFI_SUCCESS;
+		break;
+	default:
+		pr_err("%s: Unknown OPAL error %d\n", func_name, rc);
+		status = EFI_DEVICE_ERROR;
+		break;
+	}
+
+	return status;
+}
+
+#define opal_to_efi_status(rc) opal_to_efi_status_log(rc, __func__)
+
+static efi_status_t
+opal_get_variable(efi_char16_t *name, efi_guid_t *vendor, u32 *attr,
+		  unsigned long *data_size, void *data)
+{
+	int rc;
+
+	if (!opal_secvar_supported)
+		return EFI_UNSUPPORTED;
+
+	*data_size = cpu_to_be64(*data_size);
+
+	rc = opal_secvar_get(__pa(name), __pa(vendor), __pa(attr),
+			     __pa(data_size), __pa(data));
+	/*
+	 * The @attr is an optional output parameter. It is returned in
+	 * big-endian.
+	 */
+	if (attr)
+		*attr = be32_to_cpup(attr);
+	*data_size = be64_to_cpu(*data_size);
+
+	return opal_to_efi_status(rc);
+}
+
+static efi_status_t
+opal_get_next_variable(unsigned long *name_size, efi_char16_t *name,
+		       efi_guid_t *vendor)
+{
+	int rc;
+
+	if (!opal_secvar_supported)
+		return EFI_UNSUPPORTED;
+
+	*name_size = cpu_to_be64(*name_size);
+
+	rc = opal_secvar_get_next(__pa(name_size), __pa(name),
+				  __pa(vendor));
+
+	*name_size = be64_to_cpu(*name_size);
+
+	return opal_to_efi_status(rc);
+}
+
+static efi_status_t
+opal_set_variable(efi_char16_t *name, efi_guid_t *vendor, u32 attr,
+		  unsigned long data_size, void *data)
+{
+	int rc;
+
+	if (!opal_secvar_supported)
+		return EFI_UNSUPPORTED;
+	/*
+	 * The secure variable update must be enqueued in order to be processed
+	 * in the next boot by firmware. The secure variable storage is write
+	 * locked at runtime.
+	 */
+	rc = opal_secvar_enqueue(__pa(name), __pa(vendor), attr,
+				 data_size, __pa(data));
+	return opal_to_efi_status(rc);
+}
+
+static efi_status_t
+opal_query_variable_info(u32 attr, u64 *storage_space, u64 *remaining_space,
+			 u64 *max_variable_size)
+{
+	int rc;
+
+	if (!opal_secvar_supported)
+		return EFI_UNSUPPORTED;
+
+	*storage_space = cpu_to_be64p(storage_space);
+	*remaining_space = cpu_to_be64p(remaining_space);
+	*max_variable_size = cpu_to_be64p(max_variable_size);
+
+	rc = opal_secvar_info(attr, __pa(storage_space), __pa(remaining_space),
+			      __pa(max_variable_size));
+
+	*storage_space = be64_to_cpup(storage_space);
+	*remaining_space = be64_to_cpup(remaining_space);
+	*max_variable_size = be64_to_cpup(max_variable_size);
+
+	return opal_to_efi_status(rc);
+}
+
+static void pnv_efi_runtime_setup(void)
+{
+	/*
+	 * The opal wrappers below treat the @name, @vendor, and @data
+	 * parameters as little endian blobs.
+	 * @name is a ucs2 string
+	 * @vendor is the vendor GUID. It is converted to LE in the kernel
+	 * @data variable data, which layout may be different for each variable
+	 */
+	efi.get_variable = opal_get_variable;
+	efi.get_next_variable = opal_get_next_variable;
+	efi.set_variable = opal_set_variable;
+	efi.query_variable_info = opal_query_variable_info;
+
+	if (!opal_check_token(OPAL_SECVAR_GET) ||
+	    !opal_check_token(OPAL_SECVAR_GET_NEXT) ||
+	    !opal_check_token(OPAL_SECVAR_ENQUEUE) ||
+	    !opal_check_token(OPAL_SECVAR_INFO)) {
+		pr_err("OPAL doesn't support secure variables\n");
+		opal_secvar_supported = false;
+	} else {
+		opal_secvar_supported = true;
+	}
+}
+
+static int __init pnv_efi_init(void)
+{
+	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
+	set_bit(EFI_BOOT, &efi.flags);
+
+	if (IS_ENABLED(CONFIG_64BIT))
+		set_bit(EFI_64BIT, &efi.flags);
+
+	pnv_efi_runtime_setup();
+	return 0;
+}
+machine_arch_initcall(powernv, pnv_efi_init);
-- 
2.19.1

