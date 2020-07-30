Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375F52328F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 02:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgG3AcP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jul 2020 20:32:15 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54046 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbgG3AbW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jul 2020 20:31:22 -0400
Received: from dede-linux-virt.corp.microsoft.com (unknown [131.107.160.54])
        by linux.microsoft.com (Postfix) with ESMTPSA id 52E1A20B490A;
        Wed, 29 Jul 2020 17:31:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 52E1A20B490A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596069079;
        bh=IfOCfKQ/bRR1JYObw9J0crVUAEx4Ah9sosL00Wpw+m4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jX9FykFmgb8v46wnNuByxdkCM0CdGhUobb/TaYj8fkPBCfM2xvdqNQ5sQJjNLnp4b
         W8B3aSgJgL9qljBrjgoERuo5m1MMyHtqI76Mmrp6/y1Cm6L5Bo7ZoeNV+JM0RLjIWx
         sW1HOjc4xGkiml8v5Lf47gXty1vH2o2Cc2bGxw5c=
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
Subject: [RFC PATCH v6 02/11] security: add ipe lsm evaluation loop and audit system
Date:   Wed, 29 Jul 2020 17:31:04 -0700
Message-Id: <20200730003113.2561644-3-deven.desai@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200730003113.2561644-1-deven.desai@linux.microsoft.com>
References: <20200730003113.2561644-1-deven.desai@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the core logic of the IPE LSM, the evaluation loop (engine),
a portion of the audit system, and the skeleton of the policy
structure.

Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
---
 MAINTAINERS                      |   1 +
 include/uapi/linux/audit.h       |   4 +
 security/Kconfig                 |  12 +-
 security/Makefile                |   2 +
 security/ipe/.gitignore          |   2 +
 security/ipe/Kconfig             |  44 ++++++
 security/ipe/Makefile            |  25 ++++
 security/ipe/ipe-audit.c         | 231 +++++++++++++++++++++++++++++++
 security/ipe/ipe-audit.h         |  18 +++
 security/ipe/ipe-engine.c        | 205 +++++++++++++++++++++++++++
 security/ipe/ipe-engine.h        |  37 +++++
 security/ipe/ipe-hooks.c         | 149 ++++++++++++++++++++
 security/ipe/ipe-hooks.h         |  61 ++++++++
 security/ipe/ipe-policy.h        |  62 +++++++++
 security/ipe/ipe-prop-internal.h |  37 +++++
 security/ipe/ipe-property.c      | 142 +++++++++++++++++++
 security/ipe/ipe-property.h      |  99 +++++++++++++
 security/ipe/ipe.c               |  67 +++++++++
 security/ipe/ipe.h               |  20 +++
 19 files changed, 1212 insertions(+), 6 deletions(-)
 create mode 100644 security/ipe/.gitignore
 create mode 100644 security/ipe/Kconfig
 create mode 100644 security/ipe/Makefile
 create mode 100644 security/ipe/ipe-audit.c
 create mode 100644 security/ipe/ipe-audit.h
 create mode 100644 security/ipe/ipe-engine.c
 create mode 100644 security/ipe/ipe-engine.h
 create mode 100644 security/ipe/ipe-hooks.c
 create mode 100644 security/ipe/ipe-hooks.h
 create mode 100644 security/ipe/ipe-policy.h
 create mode 100644 security/ipe/ipe-prop-internal.h
 create mode 100644 security/ipe/ipe-property.c
 create mode 100644 security/ipe/ipe-property.h
 create mode 100644 security/ipe/ipe.c
 create mode 100644 security/ipe/ipe.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d29c2e4612e4..e817e4bfeae3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8585,6 +8585,7 @@ M:	Deven Bowers <deven.desai@linux.microsoft.com>
 L:	linux-integrity@vger.kernel.org
 S:	Supported
 F:	scripts/ipe/
+F:	security/ipe/
 
 INTEL 810/815 FRAMEBUFFER DRIVER
 M:	Antonino Daplas <adaplas@gmail.com>
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 9b6a973f4cc3..5a634cca1d42 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -154,6 +154,10 @@
 #define AUDIT_INTEGRITY_RULE	    1805 /* policy rule */
 #define AUDIT_INTEGRITY_EVM_XATTR   1806 /* New EVM-covered xattr */
 #define AUDIT_INTEGRITY_POLICY_RULE 1807 /* IMA policy rules */
+#define AUDIT_INTEGRITY_POLICY_LOAD	1808 /* IPE Policy Load */
+#define AUDIT_INTEGRITY_POLICY_ACTIVATE	1809 /* IPE Policy Activation */
+#define AUDIT_INTEGRITY_EVENT		1810 /* IPE Evaluation Event */
+#define AUDIT_INTEGRITY_MODE		1811 /* IPE Mode Switch */
 
 #define AUDIT_KERNEL		2000	/* Asynchronous audit record. NOT A REQUEST. */
 
diff --git a/security/Kconfig b/security/Kconfig
index cd3cc7da3a55..94924556b637 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -238,6 +238,7 @@ source "security/loadpin/Kconfig"
 source "security/yama/Kconfig"
 source "security/safesetid/Kconfig"
 source "security/lockdown/Kconfig"
+source "security/ipe/Kconfig"
 
 source "security/integrity/Kconfig"
 
@@ -277,11 +278,11 @@ endchoice
 
 config LSM
 	string "Ordered list of enabled LSMs"
-	default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
-	default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
-	default "lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
-	default "lockdown,yama,loadpin,safesetid,integrity,bpf" if DEFAULT_SECURITY_DAC
-	default "lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"
+	default "lockdown,yama,loadpin,ipe,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
+	default "lockdown,yama,loadpin,ipe,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
+	default "lockdown,yama,loadpin,ipe,safesetid,integrity,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
+	default "lockdown,yama,loadpin,ipe,safesetid,integrity,bpf" if DEFAULT_SECURITY_DAC
+	default "lockdown,yama,loadpin,ipe,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list will be ignored. This can be
@@ -292,4 +293,3 @@ config LSM
 source "security/Kconfig.hardening"
 
 endmenu
-
diff --git a/security/Makefile b/security/Makefile
index 3baf435de541..48bd063d66e1 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -13,6 +13,7 @@ subdir-$(CONFIG_SECURITY_LOADPIN)	+= loadpin
 subdir-$(CONFIG_SECURITY_SAFESETID)    += safesetid
 subdir-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown
 subdir-$(CONFIG_BPF_LSM)		+= bpf
+subdir-$(CONFIG_SECURITY_IPE)		+= ipe
 
 # always enable default capabilities
 obj-y					+= commoncap.o
@@ -32,6 +33,7 @@ obj-$(CONFIG_SECURITY_SAFESETID)       += safesetid/
 obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
 obj-$(CONFIG_CGROUPS)			+= device_cgroup.o
 obj-$(CONFIG_BPF_LSM)			+= bpf/
+obj-$(CONFIG_SECURITY_IPE)		+= ipe/
 
 # Object integrity file lists
 subdir-$(CONFIG_INTEGRITY)		+= integrity
diff --git a/security/ipe/.gitignore b/security/ipe/.gitignore
new file mode 100644
index 000000000000..bbf824e665d7
--- /dev/null
+++ b/security/ipe/.gitignore
@@ -0,0 +1,2 @@
+# Generated Boot Policy
+ipe-bp.c
diff --git a/security/ipe/Kconfig b/security/ipe/Kconfig
new file mode 100644
index 000000000000..7615109a19ca
--- /dev/null
+++ b/security/ipe/Kconfig
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Integrity Policy Enforcement (IPE) configuration
+#
+
+menuconfig SECURITY_IPE
+	bool "Integrity Policy Enforcement (IPE)"
+	depends on SECURITY && AUDIT
+	select SYSTEM_DATA_VERIFICATION
+	help
+	  This option enables the Integrity Policy Enforcement subsystem
+	  allowing systems to enforce integrity having no dependencies
+	  on filesystem metadata, making its decisions based off of kernel-
+	  resident features and data structures. A key feature of IPE is a
+	  customizable policy to allow admins to reconfigure integrity
+	  requirements on the fly.
+
+	  If unsure, answer N.
+
+if SECURITY_IPE
+
+config SECURITY_IPE_BOOT_POLICY
+	string "Integrity policy to apply on system startup"
+	help
+	  This option specifies a filepath to a IPE policy that is compiled
+	  into the kernel. This policy will be enforced until a policy update
+	  is deployed via the $securityfs/ipe/policies/$policy_name/active
+	  interface.
+
+	  If unsure, leave blank.
+
+config SECURITY_IPE_PERMISSIVE_SWITCH
+	bool "Enable the ability to switch IPE to permissive mode"
+	default y
+	help
+	  This option enables two ways of switching IPE to permissive mode,
+	  a securityfs node, `$securityfs/ipe/enforce`, or a kernel command line
+	  parameter, `ipe.enforce`. If either of these is set to 0, files
+	  will be subject to IPE's policy, audit messages will be logged, but
+	  the policy will not be enforced.
+
+	  If unsure, answer Y.
+
+endif
diff --git a/security/ipe/Makefile b/security/ipe/Makefile
new file mode 100644
index 000000000000..40565b73fac2
--- /dev/null
+++ b/security/ipe/Makefile
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) Microsoft Corporation. All rights reserved.
+#
+# Makefile for building the IPE module as part of the kernel tree.
+#
+
+quiet_cmd_polgen  = IPE_POL $(patsubst "%",%,$(2))
+      cmd_polgen  = scripts/ipe/polgen/polgen security/ipe/ipe-bp.c $(2)
+
+$(eval $(call config_filename,SECURITY_IPE_BOOT_POLICY))
+
+targets += ipe-bp.c
+$(obj)/ipe-bp.c: scripts/ipe/polgen/polgen $(SECURITY_IPE_BOOT_POLICY_FILENAME) FORCE
+	$(call if_changed,polgen,$(SECURITY_IPE_BOOT_POLICY_FILENAME))
+
+obj-$(CONFIG_SECURITY_IPE) += \
+	ipe.o \
+	ipe-audit.o \
+	ipe-bp.o \
+	ipe-engine.o \
+	ipe-property.o \
+	ipe-hooks.o \
+
+clean-files := ipe-bp.c
diff --git a/security/ipe/ipe-audit.c b/security/ipe/ipe-audit.c
new file mode 100644
index 000000000000..2c754851bd40
--- /dev/null
+++ b/security/ipe/ipe-audit.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#include "ipe.h"
+#include "ipe-audit.h"
+#include "ipe-engine.h"
+#include "ipe-prop-internal.h"
+
+#include <linux/types.h>
+#include <linux/audit.h>
+#include <linux/rcupdate.h>
+#include <linux/lsm_audit.h>
+#include <linux/rbtree.h>
+#include <crypto/hash.h>
+#include <crypto/sha1_base.h>
+
+#define ACTION_STR(a) ((a) == ipe_action_allow ? "ALLOW" : "DENY")
+
+#define IPE_UNKNOWN		"UNKNOWN"
+
+/* Keep in sync with ipe_op in ipe-hooks.h */
+const char *audit_op_names[] = {
+	IPE_OP_EXECUTE,
+	IPE_OP_FIRMWARE,
+	IPE_OP_KEXEC_IMAGE,
+	IPE_OP_KEXEC_INITRAMFS,
+	IPE_OP_X509_CERTIFICATE,
+	IPE_OP_POLICY,
+	IPE_OP_KMODULE,
+	IPE_OP_KERNEL_READ,
+	IPE_UNKNOWN,
+};
+
+/* Keep in sync with ipe_hook in ipe-hooks.h */
+const char *audit_hook_names[] = {
+	IPE_HOOK_EXEC,
+	IPE_HOOK_MMAP,
+	IPE_HOOK_MPROTECT,
+	IPE_HOOK_KERNEL_READ,
+	IPE_HOOK_KERNEL_LOAD,
+	IPE_UNKNOWN,
+};
+
+/**
+ * ipe_audit_mode: Emit an audit event indicating what mode IPE is currently
+ *		   in.
+ *
+ * This event is of form "IPE mode=(enforce|audit)"
+ */
+void ipe_audit_mode(bool enforcing)
+{
+	struct audit_buffer *ab;
+	const char *mode_str = (enforcing) ? IPE_MODE_ENFORCE :
+					     IPE_MODE_PERMISSIVE;
+
+	ab = audit_log_start(audit_context(), GFP_KERNEL,
+			     AUDIT_INTEGRITY_MODE);
+	if (!ab)
+		return;
+
+	audit_log_format(ab, "IPE mode=%s", mode_str);
+
+	audit_log_end(ab);
+}
+
+/**
+ * audit_engine_ctx: Add the string representation of ipe_engine_ctx to the
+ *		     end of an audit buffer.
+ * @ab: the audit buffer to append the string representation of @ctx
+ * @ctx: the ipe_engine_ctx structure to transform into a string
+ *	 representation
+ *
+ * This string representation is of form:
+ * "ctx_pid=%d ctx_op=%s ctx_hook=%s ctx_comm=%s ctx_audit_pathname=%s ctx_ino=%ld ctx_dev=%s"
+ *
+ * Certain fields may be omitted or replaced with ERR(%d).
+ *
+ */
+static void audit_engine_ctx(struct audit_buffer *ab,
+			     const struct ipe_engine_ctx *ctx)
+{
+	audit_log_format(ab, "ctx_pid=%d ctx_op=%s ctx_hook=%s ctx_comm=",
+			 task_tgid_nr(current),
+			 audit_op_names[ctx->op],
+			 audit_hook_names[ctx->hook]);
+
+	audit_log_untrustedstring(ab, current->comm);
+
+	if (ctx->file) {
+		if (IS_ERR(ctx->audit_pathname)) {
+			audit_log_format(ab, " ctx_audit_pathname=ERR(%ld) ",
+					 PTR_ERR(ctx->audit_pathname));
+		} else {
+			audit_log_format(ab, " ctx_audit_pathname=\"%s\" ",
+					 ctx->audit_pathname);
+		}
+
+		audit_log_format(ab, "ctx_ino=%ld ctx_dev=%s",
+				 ctx->file->f_inode->i_ino,
+				 ctx->file->f_inode->i_sb->s_id);
+	}
+}
+
+struct prop_audit_ctx {
+	struct audit_buffer *ab;
+	const struct ipe_engine_ctx *ctx;
+};
+
+/**
+ * audit_property: callback to print a property, used with ipe_for_each_prop.
+ * @prop: property to print an audit record for.
+ * @ctx: context passed to ipe_for_each_prop. In this case, it is of type
+ *	prop_audit_ctx, containing the audit buffer and engine ctx.
+ *
+ * Return:
+ * 0 - Always
+ */
+static int audit_property(const struct ipe_property *prop, void *ctx)
+{
+	const struct prop_audit_ctx *aud_ctx = (struct prop_audit_ctx *)ctx;
+
+	audit_log_format(aud_ctx->ab, "prop_%s=", prop->property_name);
+	prop->ctx_audit(aud_ctx->ab, aud_ctx->ctx);
+	audit_log_format(aud_ctx->ab, " ");
+
+	return 0;
+}
+
+/**
+ * audit_eval_properties: Append the string representation of evaluated
+ *			  properties to an audit buffer.
+ * @ab: the audit buffer to append the string representation of the evaluated
+ *	properties.
+ * @ctx: the ipe_engine_ctx structure to pass to property audit function.
+ *
+ * This string representation is of form:
+ * "prop_key1=value1 prop_key2=value2 ... "
+ *
+ * Certain values may be replaced with ERR(%d). Prop may also be empty,
+ * and thus omitted entirely.
+ *
+ */
+static inline void audit_eval_properties(struct audit_buffer *ab,
+					 const struct ipe_engine_ctx *ctx)
+{
+	const struct prop_audit_ctx aud_ctx = {
+		.ab = ab,
+		.ctx = ctx
+	};
+
+	(void)ipe_for_each_prop(audit_property, (void *)&aud_ctx);
+}
+
+/**
+ * audit_rule: Add the string representation of a non-default IPE rule to the
+ *	       end of an audit buffer.
+ * @ab: the audit buffer to append the string representation of a rule.
+ * @rule: the ipe_rule structure to transform into a string representation.
+ *
+ * This string representation is of form:
+ * 'rule="op=%s key1=value1 key2=value2 ... action=%s"'
+ *
+ * Certain values may be replaced with ERR(%d).
+ *
+ */
+static void audit_rule(struct audit_buffer *ab,
+		       const struct ipe_rule *rule)
+{
+	struct ipe_prop_container *ptr;
+
+	audit_log_format(ab, "rule=\"op=%s ", audit_op_names[rule->op]);
+
+	list_for_each_entry(ptr, &rule->props, next) {
+		audit_log_format(ab, "%s=", ptr->prop->property_name);
+
+		ptr->prop->rule_audit(ab, ptr->value);
+
+		audit_log_format(ab, " ");
+	}
+
+	audit_log_format(ab, "action=%s\"", ACTION_STR(rule->action));
+}
+
+/**
+ * ipe_audit_match: Emit an audit event indicating that the IPE engine has
+ *		    determined a match to a rule in IPE policy.
+ * @ctx: the engine context structure to audit
+ * @rule: The rule that was matched. If NULL, then assumed to be a default
+ *	  either operation specific, indicated by table, or global.
+ * @table: the operation-specific rule table. If NULL, then it assumed
+ *	   that the global default is matched.
+ * @match_type: The type of match that the engine used during evaluation
+ * @action: The action that the engine decided to take
+ * @rule: The rule that was matched. Must be set if @match_type is
+ *	  ipe_match_rule and NULL otherwise.
+ */
+void ipe_audit_match(const struct ipe_engine_ctx *ctx,
+		     enum ipe_match match_type, enum ipe_action action,
+		     const struct ipe_rule *rule)
+{
+	struct audit_buffer *ab;
+
+	if (!ipe_success_audit && action == ipe_action_allow)
+		return;
+
+	ab = audit_log_start(audit_context(), GFP_ATOMIC | __GFP_NOWARN,
+			     AUDIT_INTEGRITY_EVENT);
+	if (!ab)
+		return;
+
+	audit_log_format(ab, "IPE ");
+
+	audit_engine_ctx(ab, ctx);
+
+	audit_log_format(ab, " ");
+
+	audit_eval_properties(ab, ctx);
+
+	if (match_type == ipe_match_rule)
+		audit_rule(ab, rule);
+	else if (match_type == ipe_match_table)
+		audit_log_format(ab, "rule=\"DEFAULT op=%s action=%s\"",
+				 audit_op_names[ctx->op], ACTION_STR(action));
+	else if (match_type == ipe_match_global)
+		audit_log_format(ab, "rule=\"DEFAULT action=%s\"",
+				 ACTION_STR(action));
+
+	audit_log_end(ab);
+}
diff --git a/security/ipe/ipe-audit.h b/security/ipe/ipe-audit.h
new file mode 100644
index 000000000000..e00f415bed2c
--- /dev/null
+++ b/security/ipe/ipe-audit.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#include "ipe-engine.h"
+#include "ipe-policy.h"
+
+#ifndef IPE_AUDIT_H
+#define IPE_AUDIT_H
+
+void ipe_audit_mode(bool enforcing);
+
+void ipe_audit_match(const struct ipe_engine_ctx *ctx,
+		     enum ipe_match match_type, enum ipe_action action,
+		     const struct ipe_rule *rule);
+
+#endif /* IPE_AUDIT_H */
diff --git a/security/ipe/ipe-engine.c b/security/ipe/ipe-engine.c
new file mode 100644
index 000000000000..ac526d4ea5e6
--- /dev/null
+++ b/security/ipe/ipe-engine.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#include "ipe.h"
+#include "ipe-property.h"
+#include "ipe-prop-internal.h"
+#include "ipe-policy.h"
+#include "ipe-engine.h"
+#include "ipe-audit.h"
+
+#include <linux/types.h>
+#include <linux/fs.h>
+#include <linux/list.h>
+#include <linux/rbtree.h>
+#include <linux/rcupdate.h>
+#include <linux/security.h>
+
+const struct ipe_policy *ipe_active_policy;
+
+/**
+ * get_audit_pathname: Return the absolute path of the file struct passed in
+ * @file: file to derive an absolute path from.
+ *
+ * This function walks past chroots and mount points.
+ *
+ * Return:
+ * !NULL - OK
+ * ERR_PTR(-ENOENT) - No File
+ * ERR_PTR(-ENOMEM) - No Memory
+ * ERR_PTR(-ENAMETOOLONG) - Path Exceeds PATH_MAX
+ */
+static char *get_audit_pathname(const struct file *file)
+{
+	int rc = 0;
+	char *pos = NULL;
+	char *pathbuf = NULL;
+	char *temp_path = NULL;
+
+	/* No File to get Path From */
+	if (!file)
+		return ERR_PTR(-ENOENT);
+
+	pathbuf = __getname();
+	if (!pathbuf)
+		return ERR_PTR(-ENOMEM);
+
+	pos = d_absolute_path(&file->f_path, pathbuf, PATH_MAX);
+	if (IS_ERR(pos)) {
+		rc = PTR_ERR(pos);
+		goto err;
+	}
+
+	temp_path = __getname();
+	if (!temp_path) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	strlcpy(temp_path, pos, PATH_MAX);
+
+	__putname(pathbuf);
+
+	return temp_path;
+
+err:
+	__putname(pathbuf);
+	return ERR_PTR(rc);
+}
+
+/**
+ * free_ctx: free a previously allocated ipe_engine_ctx struct
+ * @ctx: structure to deallocate.
+ *
+ */
+static void free_ctx(struct ipe_engine_ctx *ctx)
+{
+	if (IS_ERR_OR_NULL(ctx))
+		return;
+
+	if (!IS_ERR_OR_NULL(ctx->audit_pathname))
+		__putname(ctx->audit_pathname);
+
+	kfree(ctx);
+}
+
+/**
+ * build_ctx: allocate a new ipe_engine_ctx structure
+ * @file: File that is being evaluated against IPE policy.
+ * @op: Operation that the file is being evaluated against.
+ * @hook: Specific hook that the file is being evaluated through.
+ *
+ * Return:
+ * !NULL - OK
+ * ERR_PTR(-ENOMEM) - no memory
+ */
+static struct ipe_engine_ctx *build_ctx(const struct file *file,
+					enum ipe_op op, enum ipe_hook hook)
+{
+	struct ipe_engine_ctx *local;
+
+	local = kzalloc(sizeof(*local), GFP_KERNEL);
+	if (!local)
+		return ERR_PTR(-ENOMEM);
+
+	/* if there's an error here, it's O.K. */
+	local->audit_pathname = get_audit_pathname(file);
+	local->file = file;
+	local->op = op;
+	local->hook = hook;
+
+	return local;
+}
+
+/**
+ * evaluate: Process an @ctx against IPE's current active policy.
+ * @ctx: the engine ctx to perform an evaluation on.
+ *
+ * Return:
+ * -EACCES - A match occurred against a "action=DENY" rule
+ * -ENOMEM - Out of memory
+ */
+static int evaluate(struct ipe_engine_ctx *ctx)
+{
+	int rc = 0;
+	bool match = false;
+	enum ipe_action action;
+	enum ipe_match match_type;
+	const struct ipe_rule *rule;
+	const struct ipe_policy *pol;
+	const struct ipe_rule_table *rules;
+	const struct ipe_prop_container *prop;
+
+	if (!rcu_access_pointer(ipe_active_policy))
+		return rc;
+
+	rcu_read_lock();
+
+	pol = rcu_dereference(ipe_active_policy);
+
+	rules = &pol->ops[ctx->op];
+
+	list_for_each_entry(rule, &rules->rules, next) {
+		match = true;
+
+		list_for_each_entry(prop, &rule->props, next)
+			match = match && prop->prop->eval(ctx, prop->value);
+
+		if (match)
+			break;
+	}
+
+	if (match) {
+		match_type = ipe_match_rule;
+		action = rule->action;
+	} else if (rules->def != ipe_action_unset) {
+		match_type = ipe_match_table;
+		action = rules->def;
+		rule = NULL;
+	} else {
+		match_type = ipe_match_global;
+		action = pol->def;
+		rule = NULL;
+	}
+
+	ipe_audit_match(ctx, match_type, action, rule);
+
+	if (action == ipe_action_deny)
+		rc = -EACCES;
+
+	if (ipe_enforce == 0)
+		rc = 0;
+
+	rcu_read_unlock();
+	return rc;
+}
+
+/**
+ * ipe_process_event: Perform an evaluation of @file, @op, and @hook against
+ *		      IPE's current active policy.
+ * @file: File that is being evaluated against IPE policy.
+ * @op: Operation that the file is being evaluated against.
+ * @hook: Specific hook that the file is being evaluated through.
+ *
+ * Return:
+ * -ENOMEM: (No Memory)
+ * -EACCES: (A match occurred against a "action=DENY" rule)
+ */
+int ipe_process_event(const struct file *file, enum ipe_op op,
+		      enum ipe_hook hook)
+{
+	int rc = 0;
+	struct ipe_engine_ctx *ctx;
+
+	ctx = build_ctx(file, op, hook);
+	if (IS_ERR(ctx))
+		goto cleanup;
+
+	rc = evaluate(ctx);
+
+cleanup:
+	free_ctx(ctx);
+	return rc;
+}
diff --git a/security/ipe/ipe-engine.h b/security/ipe/ipe-engine.h
new file mode 100644
index 000000000000..d9a95674e70d
--- /dev/null
+++ b/security/ipe/ipe-engine.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#include "ipe-hooks.h"
+
+#include <linux/types.h>
+#include <linux/rbtree.h>
+#include <linux/fs.h>
+
+#ifndef IPE_ENGINE_H
+#define IPE_ENGINE_H
+
+struct ipe_engine_ctx {
+	enum ipe_op op;
+	enum ipe_hook hook;
+	const struct file *file;
+	const char *audit_pathname;
+};
+
+struct ipe_prop_cache {
+	struct rb_node node;
+	void *storage;
+	const struct ipe_property *prop;
+};
+
+enum ipe_match {
+	ipe_match_rule = 0,
+	ipe_match_table,
+	ipe_match_global
+};
+
+int ipe_process_event(const struct file *file, enum ipe_op op,
+		      enum ipe_hook hook);
+
+#endif /* IPE_ENGINE_H */
diff --git a/security/ipe/ipe-hooks.c b/security/ipe/ipe-hooks.c
new file mode 100644
index 000000000000..071c4af23a3d
--- /dev/null
+++ b/security/ipe/ipe-hooks.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#include "ipe.h"
+#include "ipe-hooks.h"
+#include "ipe-engine.h"
+
+#include <linux/types.h>
+#include <linux/fs.h>
+#include <linux/binfmts.h>
+#include <linux/mount.h>
+#include <linux/mman.h>
+#include <linux/mm.h>
+#include <linux/security.h>
+
+/**
+ * ipe_on_exec: LSM hook called on the exec family of system calls.
+ * @bprm: A structure to hold arguments that are used when loading binaries,
+ *	  used to extract the file being executed.
+ *
+ * Return:
+ * 0 - OK
+ * !0 - see ipe_process_event
+ */
+int ipe_on_exec(struct linux_binprm *bprm)
+{
+	return ipe_process_event(bprm->file, ipe_op_execute, ipe_hook_exec);
+}
+
+/**
+ * ipe_on_mmap: LSM hook called on the mmap system call.
+ * @file: File being mapped into memory.
+ * @reqprot: Unused.
+ * @prot: A protection mapping of the memory region, calculated based on
+ *	  @reqprot, and the system configuration.
+ * @flags: Unused.
+ *
+ * Return:
+ * 0 - OK
+ * !0 - see ipe_process_event
+ */
+int ipe_on_mmap(struct file *file, unsigned long reqprot, unsigned long prot,
+		unsigned long flags)
+{
+	if (prot & PROT_EXEC)
+		return ipe_process_event(file, ipe_op_execute, ipe_hook_mmap);
+
+	return 0;
+}
+
+/**
+ * ipe_on_mprotect: LSM hook called on the mprotect system call
+ * @vma: A structure representing the existing memory region.
+ * @reqprot: Unused.
+ * @prot: A protection mapping of the memory region, calculated based on
+ *	  @reqprot, and the system configuration.
+ *
+ * Return:
+ * 0 - OK
+ * !0 - see ipe_process_event
+ */
+int ipe_on_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
+		    unsigned long prot)
+{
+	if ((prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC))
+		return ipe_process_event(vma->vm_file, ipe_op_execute,
+					 ipe_hook_mprotect);
+
+	return 0;
+}
+
+/**
+ * ipe_on_kernel_read: LSM hook called on kernel_read_file.
+ * @file: File being read by the hook kernel_read_file.
+ * @id: Enumeration indicating the type of file being read.
+ *
+ * For more information, see the LSM hook, kernel_read_file.
+ *
+ * Return:
+ * 0 - OK
+ * !0 - see ipe_process_event
+ */
+int ipe_on_kernel_read(struct file *file, enum kernel_read_file_id id)
+{
+	switch (id) {
+	case READING_FIRMWARE:
+	case READING_FIRMWARE_PREALLOC_BUFFER:
+		return ipe_process_event(file, ipe_op_firmware,
+					 ipe_hook_kernel_read);
+	case READING_MODULE:
+		return ipe_process_event(file, ipe_op_kmodule,
+					 ipe_hook_kernel_read);
+	case READING_KEXEC_INITRAMFS:
+		return ipe_process_event(file, ipe_op_kexec_initramfs,
+					 ipe_hook_kernel_read);
+	case READING_KEXEC_IMAGE:
+		return ipe_process_event(file, ipe_op_kexec_image,
+					 ipe_hook_kernel_read);
+	case READING_POLICY:
+		return ipe_process_event(file, ipe_op_policy,
+					 ipe_hook_kernel_read);
+	case READING_X509_CERTIFICATE:
+		return ipe_process_event(file, ipe_op_x509,
+					 ipe_hook_kernel_read);
+	default:
+		return ipe_process_event(file, ipe_op_kernel_read,
+					 ipe_hook_kernel_read);
+	}
+}
+
+/**
+ * ipe_on_kernel_load_data: LSM hook called on kernel_load_data.
+ * @id: Enumeration indicating what type of data is being loaded.
+ *
+ * For more information, see the LSM hook, kernel_load_data.
+ *
+ * Return:
+ * 0 - OK
+ * !0 - see ipe_process_event
+ */
+int ipe_on_kernel_load_data(enum kernel_load_data_id id)
+{
+	switch (id) {
+	case LOADING_FIRMWARE:
+	case LOADING_FIRMWARE_PREALLOC_BUFFER:
+		return ipe_process_event(NULL, ipe_op_firmware,
+					 ipe_hook_kernel_load);
+	case LOADING_MODULE:
+		return ipe_process_event(NULL, ipe_op_kmodule,
+					 ipe_hook_kernel_load);
+	case LOADING_KEXEC_INITRAMFS:
+		return ipe_process_event(NULL, ipe_op_kexec_initramfs,
+					 ipe_hook_kernel_load);
+	case LOADING_KEXEC_IMAGE:
+		return ipe_process_event(NULL, ipe_op_kexec_image,
+					 ipe_hook_kernel_load);
+	case LOADING_POLICY:
+		return ipe_process_event(NULL, ipe_op_policy,
+					 ipe_hook_kernel_load);
+	case LOADING_X509_CERTIFICATE:
+		return ipe_process_event(NULL, ipe_op_x509,
+					 ipe_hook_kernel_load);
+	default:
+		return ipe_process_event(NULL, ipe_op_kernel_read,
+					 ipe_hook_kernel_load);
+	}
+}
diff --git a/security/ipe/ipe-hooks.h b/security/ipe/ipe-hooks.h
new file mode 100644
index 000000000000..806659b7cdbe
--- /dev/null
+++ b/security/ipe/ipe-hooks.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#include <linux/types.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/binfmts.h>
+#include <linux/mman.h>
+#include <linux/mm.h>
+#include <linux/security.h>
+
+#ifndef IPE_HOOK_H
+#define IPE_HOOK_H
+
+#define IPE_HOOK_EXEC		"EXEC"
+#define IPE_HOOK_MMAP		"MMAP"
+#define IPE_HOOK_MPROTECT	"MPROTECT"
+#define IPE_HOOK_KERNEL_READ	"KERNEL_READ"
+#define IPE_HOOK_KERNEL_LOAD	"KERNEL_LOAD"
+
+enum ipe_hook {
+	ipe_hook_exec = 0,
+	ipe_hook_mmap,
+	ipe_hook_mprotect,
+	ipe_hook_kernel_read,
+	ipe_hook_kernel_load,
+	ipe_hook_max
+};
+
+/*
+ * The sequence between ipe_op_firmware and ipe_op_kmodule
+ * must remain the same for ipe_op_kernel read to function
+ * appropriately.
+ */
+enum ipe_op {
+	ipe_op_execute = 0,
+	ipe_op_firmware,
+	ipe_op_kexec_image,
+	ipe_op_kexec_initramfs,
+	ipe_op_x509,
+	ipe_op_policy,
+	ipe_op_kmodule,
+	ipe_op_kernel_read,
+	ipe_op_max
+};
+
+int ipe_on_exec(struct linux_binprm *bprm);
+
+int ipe_on_mmap(struct file *file, unsigned long reqprot, unsigned long prot,
+		unsigned long flags);
+
+int ipe_on_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
+		    unsigned long prot);
+
+int ipe_on_kernel_read(struct file *file, enum kernel_read_file_id id);
+
+int ipe_on_kernel_load_data(enum kernel_load_data_id id);
+
+#endif /* IPE_HOOK_H */
diff --git a/security/ipe/ipe-policy.h b/security/ipe/ipe-policy.h
new file mode 100644
index 000000000000..c0c9f2962c92
--- /dev/null
+++ b/security/ipe/ipe-policy.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#include "ipe-hooks.h"
+#include "ipe-property.h"
+
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/rcupdate.h>
+
+#ifndef IPE_POLICY_H
+#define IPE_POLICY_H
+
+#define IPE_HEADER_POLICY_NAME		"policy_name"
+#define IPE_HEADER_POLICY_VERSION	"policy_version"
+
+extern const char *const ipe_boot_policy;
+extern const struct ipe_policy *ipe_active_policy;
+
+enum ipe_action {
+	ipe_action_unset = 0,
+	ipe_action_allow,
+	ipe_action_deny
+};
+
+struct ipe_prop_container {
+	struct list_head next;
+	void *value;
+	const struct ipe_property *prop;
+};
+
+struct ipe_rule {
+	struct list_head props;
+	struct list_head next;
+	enum ipe_action action;
+	enum ipe_op op;
+};
+
+struct ipe_rule_table {
+	struct list_head rules;
+	enum ipe_action def;
+};
+
+struct ipe_pol_ver {
+	u16 major;
+	u16 minor;
+	u16 rev;
+};
+
+struct ipe_policy {
+	char *policy_name;
+	struct ipe_pol_ver policy_version;
+	enum ipe_action def;
+
+	/* KERNEL_READ stores no data itself */
+	struct ipe_rule_table ops[ipe_op_max - 1];
+};
+
+#endif /* IPE_POLICY_H */
diff --git a/security/ipe/ipe-prop-internal.h b/security/ipe/ipe-prop-internal.h
new file mode 100644
index 000000000000..95a2081e77ee
--- /dev/null
+++ b/security/ipe/ipe-prop-internal.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#include "ipe-property.h"
+
+#include <linux/types.h>
+
+#ifndef IPE_PROPERTY_INTERNAL_H
+#define IPE_PROPERTY_INTERNAL_H
+
+#define IPE_PROPERTY_OPERATION	"op"
+#define IPE_PROPERTY_DEFAULT	"DEFAULT"
+#define IPE_PROPERTY_ACTION	"action"
+
+#define IPE_OP_EXECUTE		"EXECUTE"
+#define IPE_OP_FIRMWARE		"FIRMWARE"
+#define IPE_OP_KEXEC_IMAGE	"KEXEC_IMAGE"
+#define IPE_OP_KEXEC_INITRAMFS	"KEXEC_INITRAMFS"
+#define IPE_OP_X509_CERTIFICATE	"X509_CERT"
+#define IPE_OP_POLICY		"POLICY"
+#define IPE_OP_KMODULE		"KMODULE"
+#define IPE_OP_KERNEL_READ	"KERNEL_READ"
+
+struct ipe_prop_reg {
+	struct rb_node node;
+	const struct ipe_property *prop;
+};
+
+int ipe_for_each_prop(int (*view)(const struct ipe_property *prop,
+				  void *ctx),
+		      void *ctx);
+
+const struct ipe_property *ipe_lookup_prop(const char *key);
+
+#endif /* IPE_PROPERTY_INTERNAL_H */
diff --git a/security/ipe/ipe-property.c b/security/ipe/ipe-property.c
new file mode 100644
index 000000000000..d4b0283f86bd
--- /dev/null
+++ b/security/ipe/ipe-property.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#include "ipe.h"
+#include "ipe-prop-internal.h"
+#include "ipe-property.h"
+
+#include <linux/types.h>
+#include <linux/rbtree.h>
+#include <linux/slab.h>
+
+/* global root containing all registered properties */
+struct rb_root ipe_registry_root = RB_ROOT;
+
+/**
+ * reg_lookup: Attempt to find a `prop_reg` structure with property_name @key.
+ * @key: The property_name to look for in the tree.
+ *
+ * Return:
+ * ipe_prop_reg structure - OK
+ * NULL - No such property exists
+ */
+static struct ipe_prop_reg *reg_lookup(const char *key)
+{
+	struct rb_node *n = ipe_registry_root.rb_node;
+
+	while (n) {
+		int r;
+		struct ipe_prop_reg *reg =
+			container_of(n, struct ipe_prop_reg, node);
+
+		r = strcmp(reg->prop->property_name, key);
+		if (r == 0)
+			return reg;
+		else if (r > 0)
+			n = n->rb_right;
+		else
+			n = n->rb_left;
+	}
+
+	return NULL;
+}
+
+/**
+ * ipe_lookup_prop: Attempt to find a ipe_property structure by name @key.
+ * @key: The property_name to look for in the tree.
+ *
+ * Return:
+ * ipe_property structure - OK
+ * NULL - No property exists under @key
+ */
+const struct ipe_property *ipe_lookup_prop(const char *key)
+{
+	struct ipe_prop_reg *reg = reg_lookup(key);
+
+	if (!reg)
+		return NULL;
+
+	return reg->prop;
+}
+
+/**
+ * ipe_register_property: Insert a property into the registration system.
+ * @prop: Read-only property structure containing the property_name, as well
+ *	  as the necessary function pointers for a property.
+ *
+ * The caller needs to maintain the lifetime of @prop throughout the life of
+ * the system, after calling ipe_register_property.
+ *
+ * All necessary properties need to be loaded via this method before
+ * loading a policy, otherwise the properties will be ignored as unknown.
+ *
+ * Return:
+ * 0 - OK
+ * -EEXIST - A key exists with the name @prop->property_name
+ * -ENOMEM - Out of Memory
+ */
+int ipe_register_property(const struct ipe_property *prop)
+{
+	struct rb_node *parent = NULL;
+	struct ipe_prop_reg *new_data = NULL;
+	struct rb_node **new = &ipe_registry_root.rb_node;
+
+	while (*new) {
+		int r;
+		struct ipe_prop_reg *reg =
+			container_of(*new, struct ipe_prop_reg, node);
+
+		parent = *new;
+
+		r = strcmp(reg->prop->property_name, prop->property_name);
+		if (r == 0)
+			return -EEXIST;
+		else if (r > 0)
+			new = &((*new)->rb_right);
+		else
+			new = &((*new)->rb_left);
+	}
+
+	new_data = kzalloc(sizeof(*new_data), GFP_KERNEL);
+	if (!new_data)
+		return -ENOMEM;
+
+	new_data->prop = prop;
+
+	rb_link_node(&new_data->node, parent, new);
+	rb_insert_color(&new_data->node, &ipe_registry_root);
+
+	return 0;
+}
+
+/**
+ * ipe_for_each_prop: Iterate over all currently-registered properties
+ *	calling @fn on the values, and providing @view @ctx.
+ * @view: The function to call for each property. This is given the property
+ *	structure as the first argument, and @ctx as the second.
+ * @ctx: caller-specified context that is passed to the function. Can be NULL.
+ *
+ * Return:
+ * 0 - OK
+ * !0 - Proper errno as returned by @view.
+ */
+int ipe_for_each_prop(int (*view)(const struct ipe_property *prop,
+				  void *ctx),
+		      void *ctx)
+{
+	struct rb_node *node;
+	struct ipe_prop_reg *val;
+	int rc = 0;
+
+	for (node = rb_first(&ipe_registry_root); node; node = rb_next(node)) {
+		val = container_of(node, struct ipe_prop_reg, node);
+
+		rc = view(val->prop, ctx);
+		if (rc)
+			return rc;
+	}
+
+	return rc;
+}
diff --git a/security/ipe/ipe-property.h b/security/ipe/ipe-property.h
new file mode 100644
index 000000000000..cf570d52d0d2
--- /dev/null
+++ b/security/ipe/ipe-property.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#include "ipe-engine.h"
+
+#include <linux/types.h>
+#include <linux/lsm_audit.h>
+
+#ifndef IPE_PROPERTY_H
+#define IPE_PROPERTY_H
+
+/**
+ * ipe_property_evaluator: Determines whether a file subject matches the
+ *			   property.
+ * @value: Value to compare against for a match
+ *
+ * NOTE: This is done in an rcu read critical section - sleeping
+ *	 allocations are prohibited.
+ *
+ * Return:
+ * true - The property matches evaluation
+ * false - The property does not match evaluation
+ */
+typedef bool (*ipe_property_evaluator)(const struct ipe_engine_ctx *ctx,
+				       const void *value);
+
+/**
+ * ipe_property_audit: Transform a rule value into a string representation.
+ * @ab: Audit buffer to add the string representation of @value to.
+ * @value: Value to transform into a string representation.
+ *
+ * NOTE: This is done in an rcu read critical section - sleeping
+ *	 allocations are prohibited.
+ */
+typedef void (*ipe_property_audit)(struct audit_buffer *ab, const void *value);
+
+/**
+ * ipe_ctx_audit: Called by the auditing to provide the values
+ *	that were evaluated about the subject, @ctx->file, to determine how
+ *	a value was evaluated.
+ *
+ * NOTE: This is done in an rcu read critical section - sleeping
+ *	 allocations are prohibited.
+ *
+ * @ab: Audit buffer to add the string representation of @value to.
+ * @value: Value to transform into a string representation.
+ *
+ */
+typedef void (*ipe_ctx_audit)(struct audit_buffer *ab,
+			     const struct ipe_engine_ctx *ctx);
+
+/**
+ * ipe_parse_value: Transform a string representation of a rule into an
+ *		    internal ipe data-structure, opaque to the engine.
+ * @val_str: String-value parsed by the policy parser.
+ * @value: Valid-pointer indicating address to store parsed value.
+ *
+ * Return:
+ * 0 - OK
+ * !0 - ERR, use Standard Return Codes
+ */
+typedef int(*ipe_parse_value)(const char *val_str, void **value);
+
+/**
+ * ipe_dup_val: Called by the policy parser to make duplicate properties for
+ *		pseudo-properties like "KERNEL_READ".
+ * @src:  Value to copy.
+ * @dest: Pointer to the destination where the value should be copied.
+ *
+ * Return:
+ * 0 - OK
+ * !0 - ERR, use Standard Return Codes
+ */
+typedef int (*ipe_dup_val)(const void *src, void **dest);
+
+/**
+ * ipe_free_value: Free a policy value, created by ipe_parse_value.
+ * @value: Valid-pointer to the value to be interpreted and
+ *	   freed by the property.
+ *
+ * Optional, can be NULL - in which case, this will not be called.
+ */
+typedef void (*ipe_free_value)(void **value);
+
+struct ipe_property {
+	const char			*const property_name;
+	ipe_property_evaluator		eval;
+	ipe_property_audit		rule_audit;
+	ipe_ctx_audit			ctx_audit;
+	ipe_parse_value			parse;
+	ipe_dup_val			dup;
+	ipe_free_value			free_val;
+};
+
+int ipe_register_property(const struct ipe_property *prop);
+
+#endif /* IPE_PROPERTY_H */
diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
new file mode 100644
index 000000000000..6e3b9a10813c
--- /dev/null
+++ b/security/ipe/ipe.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#include "ipe.h"
+#include "ipe-policy.h"
+#include "ipe-hooks.h"
+
+#include <linux/module.h>
+#include <linux/lsm_hooks.h>
+#include <linux/sysctl.h>
+#include <linux/rcupdate.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/security.h>
+
+static struct security_hook_list ipe_hooks[] __lsm_ro_after_init = {
+	LSM_HOOK_INIT(bprm_check_security, ipe_on_exec),
+	LSM_HOOK_INIT(mmap_file, ipe_on_mmap),
+	LSM_HOOK_INIT(kernel_read_file, ipe_on_kernel_read),
+	LSM_HOOK_INIT(kernel_load_data, ipe_on_kernel_load_data),
+	LSM_HOOK_INIT(file_mprotect, ipe_on_mprotect),
+};
+
+/**
+ * ipe_init: Entry point of IPE.
+ *
+ * This is called at LSM init, which happens occurs early during kernel
+ * start up. During this phase, IPE loads the
+ * properties compiled into the kernel, and register's IPE's hooks.
+ * The boot policy is loaded later, during securityfs init, at which point
+ * IPE will start enforcing its policy.
+ *
+ * Return:
+ * 0 - OK
+ * -ENOMEM - sysctl registration failed.
+ */
+static int __init ipe_init(void)
+{
+	pr_info("mode=%s", (ipe_enforce == 1) ? IPE_MODE_ENFORCE :
+						IPE_MODE_PERMISSIVE);
+
+	security_add_hooks(ipe_hooks, ARRAY_SIZE(ipe_hooks), "IPE");
+
+	return 0;
+}
+
+DEFINE_LSM(ipe) = {
+	.name = "ipe",
+	.init = ipe_init,
+};
+
+bool ipe_enforce = true;
+bool ipe_success_audit;
+
+#ifdef CONFIG_SECURITY_IPE_PERMISSIVE_SWITCH
+
+/* Module Parameter for Default Behavior on Boot */
+module_param_named(enforce, ipe_enforce, bool, 0644);
+MODULE_PARM_DESC(enforce, "IPE Permissive Switch");
+
+#endif /* CONFIG_SECURITY_IPE_PERMISSIVE_SWITCH */
+
+/* Module Parameter for Success Audit on Boot */
+module_param_named(success_audit, ipe_success_audit, bool, 0644);
+MODULE_PARM_DESC(success_audit, "IPE Audit on Success");
diff --git a/security/ipe/ipe.h b/security/ipe/ipe.h
new file mode 100644
index 000000000000..af72bb574f73
--- /dev/null
+++ b/security/ipe/ipe.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#ifndef IPE_H
+#define IPE_H
+
+#define pr_fmt(fmt) "IPE " fmt "\n"
+
+#include <linux/types.h>
+#include <linux/fs.h>
+
+#define IPE_MODE_ENFORCE	"enforce"
+#define IPE_MODE_PERMISSIVE	"permissive"
+
+extern bool ipe_enforce;
+extern bool ipe_success_audit;
+
+#endif /* IPE_H */
-- 
2.27.0

