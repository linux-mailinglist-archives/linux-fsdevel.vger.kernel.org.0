Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E43E2328EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 02:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgG3AbX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jul 2020 20:31:23 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54106 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbgG3AbW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jul 2020 20:31:22 -0400
Received: from dede-linux-virt.corp.microsoft.com (unknown [131.107.160.54])
        by linux.microsoft.com (Postfix) with ESMTPSA id E0E3220B490D;
        Wed, 29 Jul 2020 17:31:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E0E3220B490D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596069080;
        bh=qDBhra6RZyxVVfdRleQ/T358fYx5mtSorhMjepv44Ls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UwLHzGvmSwUORqbI9xDVft9awp7CxfIFHJzrSac6adL+uRpxIhEzsQmJnWrzWus+w
         qaHUlUqiSS5LH1PHGUTpV94+snHRvJTjXQNUMuhrC7IV/1rNnW92xjY5ze0ZdhRHid
         Q70bweWgM31XGQzD2VuLha79f8fpe26AW3DQluG0=
From:   Deven Bowers <deven.desai@linux.microsoft.com>
To:     agk@redhat.com, axboe@kernel.dk, snitzer@redhat.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        viro@zeniv.linux.org.uk, paul@paul-moore.com, eparis@redhat.com,
        jannh@google.com, dm-devel@redhat.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-audit@redhat.com
Cc:     tyhicks@linux.microsoft.com, linux-kernel@vger.kernel.org,
        corbet@lwn.net, sashal@kernel.org,
        jaskarankhurana@linux.microsoft.com, mdsakib@microsoft.com,
        nramas@linux.microsoft.com, pasha.tatashin@soleen.com
Subject: [RFC PATCH v6 04/11] ipe: add property for trust of boot volume
Date:   Wed, 29 Jul 2020 17:31:06 -0700
Message-Id: <20200730003113.2561644-5-deven.desai@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200730003113.2561644-1-deven.desai@linux.microsoft.com>
References: <20200730003113.2561644-1-deven.desai@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a property for IPE policy to express trust of the first superblock
where a file would be evaluated to determine trust.

Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
---
 security/ipe/Kconfig                    |  2 +
 security/ipe/Makefile                   |  4 ++
 security/ipe/ipe-engine.c               |  4 ++
 security/ipe/ipe-hooks.c                | 19 +++++
 security/ipe/ipe-hooks.h                |  2 +
 security/ipe/ipe-pin.c                  | 93 +++++++++++++++++++++++++
 security/ipe/ipe-pin.h                  | 36 ++++++++++
 security/ipe/ipe.c                      | 28 +++++++-
 security/ipe/properties/Kconfig         | 15 ++++
 security/ipe/properties/Makefile        | 11 +++
 security/ipe/properties/boot-verified.c | 82 ++++++++++++++++++++++
 security/ipe/properties/prop-entry.h    | 20 ++++++
 security/ipe/utility.h                  | 22 ++++++
 13 files changed, 337 insertions(+), 1 deletion(-)
 create mode 100644 security/ipe/ipe-pin.c
 create mode 100644 security/ipe/ipe-pin.h
 create mode 100644 security/ipe/properties/Kconfig
 create mode 100644 security/ipe/properties/Makefile
 create mode 100644 security/ipe/properties/boot-verified.c
 create mode 100644 security/ipe/properties/prop-entry.h
 create mode 100644 security/ipe/utility.h

diff --git a/security/ipe/Kconfig b/security/ipe/Kconfig
index 665524fc3ca4..469ef78c2f4f 100644
--- a/security/ipe/Kconfig
+++ b/security/ipe/Kconfig
@@ -43,4 +43,6 @@ config SECURITY_IPE_PERMISSIVE_SWITCH
 
 	  If unsure, answer Y.
 
+source "security/ipe/properties/Kconfig"
+
 endif
diff --git a/security/ipe/Makefile b/security/ipe/Makefile
index 7d6da33dd0c4..7e98982c5035 100644
--- a/security/ipe/Makefile
+++ b/security/ipe/Makefile
@@ -26,3 +26,7 @@ obj-$(CONFIG_SECURITY_IPE) += \
 	ipe-secfs.o \
 
 clean-files := ipe-bp.c
+
+obj-$(CONFIG_IPE_BOOT_PROP) += ipe-pin.o
+
+obj-$(CONFIG_SECURITY_IPE) += properties/
diff --git a/security/ipe/ipe-engine.c b/security/ipe/ipe-engine.c
index ac526d4ea5e6..0291ced99d64 100644
--- a/security/ipe/ipe-engine.c
+++ b/security/ipe/ipe-engine.c
@@ -9,6 +9,8 @@
 #include "ipe-policy.h"
 #include "ipe-engine.h"
 #include "ipe-audit.h"
+#include "ipe-pin.h"
+#include "utility.h"
 
 #include <linux/types.h>
 #include <linux/fs.h>
@@ -197,6 +199,8 @@ int ipe_process_event(const struct file *file, enum ipe_op op,
 	if (IS_ERR(ctx))
 		goto cleanup;
 
+	ipe_pin_superblock(ctx->file);
+
 	rc = evaluate(ctx);
 
 cleanup:
diff --git a/security/ipe/ipe-hooks.c b/security/ipe/ipe-hooks.c
index 071c4af23a3d..45efe022be04 100644
--- a/security/ipe/ipe-hooks.c
+++ b/security/ipe/ipe-hooks.c
@@ -6,6 +6,7 @@
 #include "ipe.h"
 #include "ipe-hooks.h"
 #include "ipe-engine.h"
+#include "ipe-pin.h"
 
 #include <linux/types.h>
 #include <linux/fs.h>
@@ -147,3 +148,21 @@ int ipe_on_kernel_load_data(enum kernel_load_data_id id)
 					 ipe_hook_kernel_load);
 	}
 }
+
+/**
+ * ipe_sb_free_security: LSM hook called on sb_free_security.
+ * @mnt_sb: Super block that is being freed.
+ *
+ * IPE does not currently utilize the super block security hook,
+ * it utilizes this hook to invalidate the saved super block for
+ * the boot_verified property.
+ *
+ * For more information, see the LSM hook, sb_free_security.
+ *
+ * Return:
+ * 0 - OK
+ */
+void ipe_sb_free_security(struct super_block *mnt_sb)
+{
+	ipe_invalidate_pinned_sb(mnt_sb);
+}
diff --git a/security/ipe/ipe-hooks.h b/security/ipe/ipe-hooks.h
index 806659b7cdbe..5e46726f2562 100644
--- a/security/ipe/ipe-hooks.h
+++ b/security/ipe/ipe-hooks.h
@@ -58,4 +58,6 @@ int ipe_on_kernel_read(struct file *file, enum kernel_read_file_id id);
 
 int ipe_on_kernel_load_data(enum kernel_load_data_id id);
 
+void ipe_sb_free_security(struct super_block *mnt_sb);
+
 #endif /* IPE_HOOK_H */
diff --git a/security/ipe/ipe-pin.c b/security/ipe/ipe-pin.c
new file mode 100644
index 000000000000..a963be8e5321
--- /dev/null
+++ b/security/ipe/ipe-pin.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This file has been heavily adapted from the source code of the
+ * loadpin LSM. The source code for loadpin is co-located in the linux
+ * tree under security/loadpin/loadpin.c.
+ *
+ * Please see loadpin.c for up-to-date information about
+ * loadpin.
+ */
+
+#include "ipe.h"
+
+#include <linux/types.h>
+#include <linux/spinlock_types.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/magic.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+
+static DEFINE_SPINLOCK(pinned_sb_spinlock);
+
+static struct super_block *pinned_sb;
+
+/**
+ * ipe_is_from_pinned_sb: Determine if @file originates from the initial
+ *			  super block that a file was executed from.
+ * @file: File to check if it originates from the super block.
+ *
+ * Return:
+ * true - File originates from the initial super block
+ * false - File does not originate from the initial super block
+ */
+bool ipe_is_from_pinned_sb(const struct file *file)
+{
+	bool rv = false;
+
+	spin_lock(&pinned_sb_spinlock);
+
+	/*
+	 * Check if pinned_sb is set:
+	 *  NULL == not set -> exit
+	 *  ERR == was once set (and has been unmounted) -> exit
+	 * AND check that the pinned sb is the same as the file's.
+	 */
+	if (!IS_ERR_OR_NULL(pinned_sb) &&
+	    file->f_path.mnt->mnt_sb == pinned_sb) {
+		rv = true;
+		goto cleanup;
+	}
+
+cleanup:
+	spin_unlock(&pinned_sb_spinlock);
+	return rv;
+}
+
+/**
+ * ipe_pin_superblock: Attempt to save a file's super block address to later
+ *		       determine if a file originates from a super block.
+ * @file: File to source the super block from.
+ */
+void ipe_pin_superblock(const struct file *file)
+{
+	spin_lock(&pinned_sb_spinlock);
+
+	/* if set, return */
+	if (pinned_sb || !file)
+		goto cleanup;
+
+	pinned_sb = file->f_path.mnt->mnt_sb;
+cleanup:
+	spin_unlock(&pinned_sb_spinlock);
+}
+
+/**
+ * ipe_invalidate_pinned_sb: Invalidate the saved super block.
+ * @mnt_sb: Super block to compare against the saved super block.
+ *
+ * This avoids authorizing a file when the super block does not exist anymore.
+ */
+void ipe_invalidate_pinned_sb(const struct super_block *mnt_sb)
+{
+	spin_lock(&pinned_sb_spinlock);
+
+	/*
+	 * On pinned sb unload - invalidate the pinned address
+	 * by setting the pinned_sb to ERR_PTR(-EIO)
+	 */
+	if (!IS_ERR_OR_NULL(pinned_sb) && mnt_sb == pinned_sb)
+		pinned_sb = ERR_PTR(-EIO);
+
+	spin_unlock(&pinned_sb_spinlock);
+}
diff --git a/security/ipe/ipe-pin.h b/security/ipe/ipe-pin.h
new file mode 100644
index 000000000000..b707e6253c33
--- /dev/null
+++ b/security/ipe/ipe-pin.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+#ifndef IPE_PIN_H
+#define IPE_PIN_H
+
+#include <linux/types.h>
+#include <linux/fs.h>
+
+#ifdef CONFIG_IPE_BOOT_PROP
+
+bool ipe_is_from_pinned_sb(const struct file *file);
+
+void ipe_pin_superblock(const struct file *file);
+
+void ipe_invalidate_pinned_sb(const struct super_block *mnt_sb);
+
+#else /* CONFIG_IPE_BOOT_PROP */
+
+static inline bool ipe_is_from_pinned_sb(const struct file *file)
+{
+	return false;
+}
+
+static inline void ipe_pin_superblock(const struct file *file)
+{
+}
+
+static inline void ipe_invalidate_pinned_sb(const struct super_block *mnt_sb)
+{
+}
+
+#endif /* !CONFIG_IPE_BOOT_PROP */
+
+#endif /* IPE_PIN_H */
diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
index 6e3b9a10813c..706ff38083c6 100644
--- a/security/ipe/ipe.c
+++ b/security/ipe/ipe.c
@@ -6,6 +6,7 @@
 #include "ipe.h"
 #include "ipe-policy.h"
 #include "ipe-hooks.h"
+#include "properties/prop-entry.h"
 
 #include <linux/module.h>
 #include <linux/lsm_hooks.h>
@@ -21,8 +22,27 @@ static struct security_hook_list ipe_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(kernel_read_file, ipe_on_kernel_read),
 	LSM_HOOK_INIT(kernel_load_data, ipe_on_kernel_load_data),
 	LSM_HOOK_INIT(file_mprotect, ipe_on_mprotect),
+	LSM_HOOK_INIT(sb_free_security, ipe_sb_free_security),
 };
 
+/**
+ * ipe_load_properties: Call the property entry points for all the IPE modules
+ *			that were selected at kernel build-time.
+ *
+ * Return:
+ * 0 - OK
+ */
+static int __init ipe_load_properties(void)
+{
+	int rc = 0;
+
+	rc = ipe_init_bootv();
+	if (rc != 0)
+		return rc;
+
+	return rc;
+}
+
 /**
  * ipe_init: Entry point of IPE.
  *
@@ -38,12 +58,18 @@ static struct security_hook_list ipe_hooks[] __lsm_ro_after_init = {
  */
 static int __init ipe_init(void)
 {
+	int rc;
+
+	rc = ipe_load_properties();
+	if (rc != 0)
+		panic("IPE: properties failed to load");
+
 	pr_info("mode=%s", (ipe_enforce == 1) ? IPE_MODE_ENFORCE :
 						IPE_MODE_PERMISSIVE);
 
 	security_add_hooks(ipe_hooks, ARRAY_SIZE(ipe_hooks), "IPE");
 
-	return 0;
+	return rc;
 }
 
 DEFINE_LSM(ipe) = {
diff --git a/security/ipe/properties/Kconfig b/security/ipe/properties/Kconfig
new file mode 100644
index 000000000000..75c6c6ff6cd8
--- /dev/null
+++ b/security/ipe/properties/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Integrity Policy Enforcement (IPE) configuration
+#
+
+config IPE_BOOT_PROP
+	bool "Enable trust for boot volume"
+	help
+	  This option enables the property "boot_verified" in IPE policy.
+	  This property 'pins' the initial superblock when something is
+	  evaluated as an execution. This property will evaluate to true
+	  when the file being evaluated originates from the initial
+	  superblock.
+
+	  if unsure, answer N.
diff --git a/security/ipe/properties/Makefile b/security/ipe/properties/Makefile
new file mode 100644
index 000000000000..e3e7fe17cf58
--- /dev/null
+++ b/security/ipe/properties/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) Microsoft Corporation. All rights reserved.
+#
+# Makefile for building the properties that IPE uses
+# as part of the kernel tree.
+#
+
+obj-$(CONFIG_SECURITY_IPE) += properties.o
+
+properties-$(CONFIG_IPE_BOOT_PROP) += boot-verified.o
diff --git a/security/ipe/properties/boot-verified.c b/security/ipe/properties/boot-verified.c
new file mode 100644
index 000000000000..eb9e6ebe34fa
--- /dev/null
+++ b/security/ipe/properties/boot-verified.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#include "../ipe.h"
+#include "../ipe-pin.h"
+#include "../ipe-property.h"
+#include "../utility.h"
+
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/audit.h>
+
+#define PROPERTY_NAME "boot_verified"
+
+static void audit(struct audit_buffer *ab, bool value)
+{
+	audit_log_format(ab, "%s", (value) ? "TRUE" : "FALSE");
+}
+
+static inline void audit_rule_value(struct audit_buffer *ab,
+				    const void *value)
+{
+	audit(ab, (bool)value);
+}
+
+static inline void audit_ctx(struct audit_buffer *ab,
+			     const struct ipe_engine_ctx *ctx)
+{
+	bool b = has_sb(ctx->file) && ipe_is_from_pinned_sb(ctx->file);
+
+	audit(ab, b);
+}
+
+static bool evaluate(const struct ipe_engine_ctx *ctx,
+		     const void *value)
+{
+	bool expect = (bool)value;
+
+	if (!ctx->file || !has_sb(ctx->file))
+		return false;
+
+	return ipe_is_from_pinned_sb(ctx->file) == expect;
+}
+
+static int parse(const char *val_str, void **value)
+{
+	if (strcmp("TRUE", val_str) == 0)
+		*value = (void *)true;
+	else if (strcmp("FALSE", val_str) == 0)
+		*value = (void *)false;
+	else
+		return -EBADMSG;
+
+	return 0;
+}
+
+static inline int duplicate(const void *src, void **dest)
+{
+	*dest = (void *)(bool)src;
+
+	return 0;
+}
+
+static const struct ipe_property boot_verified = {
+	.property_name = PROPERTY_NAME,
+	.version = 1,
+	.eval = evaluate,
+	.rule_audit = audit_rule_value,
+	.ctx_audit = audit_ctx,
+	.parse = parse,
+	.dup = duplicate,
+	.free_val = NULL,
+};
+
+int ipe_init_bootv(void)
+{
+	return ipe_register_property(&boot_verified);
+}
diff --git a/security/ipe/properties/prop-entry.h b/security/ipe/properties/prop-entry.h
new file mode 100644
index 000000000000..f598dd9608b9
--- /dev/null
+++ b/security/ipe/properties/prop-entry.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#include <linux/types.h>
+
+#ifndef IPE_PROP_ENTRY_H
+#define IPE_PROP_ENTRY_H
+
+#ifndef CONFIG_IPE_BOOT_PROP
+static inline int __init ipe_init_bootv(void)
+{
+	return 0;
+}
+#else
+int __init ipe_init_bootv(void);
+#endif /* CONFIG_IPE_BOOT_PROP */
+
+#endif /* IPE_PROP_ENTRY_H */
diff --git a/security/ipe/utility.h b/security/ipe/utility.h
new file mode 100644
index 000000000000..a13089bb0d8f
--- /dev/null
+++ b/security/ipe/utility.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#ifndef IPE_UTILITY_H
+#define IPE_UTILITY_H
+
+#include <linux/types.h>
+#include <linux/fs.h>
+
+static inline bool has_mount(const struct file *file)
+{
+	return file && file->f_path.mnt;
+}
+
+static inline bool has_sb(const struct file *file)
+{
+	return has_mount(file) && file->f_path.mnt->mnt_sb;
+}
+
+#endif /* IPE_UTILITY_H */
-- 
2.27.0

