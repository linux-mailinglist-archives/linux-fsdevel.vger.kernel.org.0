Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2097733DF36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 21:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhCPUna (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 16:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhCPUnF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 16:43:05 -0400
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DD4C06174A;
        Tue, 16 Mar 2021 13:43:03 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4F0QGZ3cTLzMq06g;
        Tue, 16 Mar 2021 21:43:02 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4F0QGZ0gz0zlh8T2;
        Tue, 16 Mar 2021 21:43:02 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v30 04/12] landlock: Add ptrace restrictions
Date:   Tue, 16 Mar 2021 21:42:44 +0100
Message-Id: <20210316204252.427806-5-mic@digikod.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316204252.427806-1-mic@digikod.net>
References: <20210316204252.427806-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

Using ptrace(2) and related debug features on a target process can lead
to a privilege escalation.  Indeed, ptrace(2) can be used by an attacker
to impersonate another task and to remain undetected while performing
malicious activities.  Thanks to  ptrace_may_access(), various part of
the kernel can check if a tracer is more privileged than a tracee.

A landlocked process has fewer privileges than a non-landlocked process
and must then be subject to additional restrictions when manipulating
processes. To be allowed to use ptrace(2) and related syscalls on a
target process, a landlocked process must have a subset of the target
process's rules (i.e. the tracee must be in a sub-domain of the tracer).

Cc: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Reviewed-by: Jann Horn <jannh@google.com>
Acked-by: Serge Hallyn <serge@hallyn.com>
Link: https://lore.kernel.org/r/20210316204252.427806-5-mic@digikod.net
---

Changes since v28:
* Add Acked-by Serge Hallyn.

Changes since v25:
* Rename function to landlock_add_ptrace_hooks().

Changes since v22:
* Add Reviewed-by: Jann Horn <jannh@google.com>

Changes since v21:
* Fix copyright dates.

Changes since v14:
* Constify variables.

Changes since v13:
* Make the ptrace restriction mandatory, like in the v10.
* Remove the eBPF dependency.

Previous changes:
https://lore.kernel.org/lkml/20191104172146.30797-5-mic@digikod.net/
---
 security/landlock/Makefile |   2 +-
 security/landlock/ptrace.c | 120 +++++++++++++++++++++++++++++++++++++
 security/landlock/ptrace.h |  14 +++++
 security/landlock/setup.c  |   2 +
 4 files changed, 137 insertions(+), 1 deletion(-)
 create mode 100644 security/landlock/ptrace.c
 create mode 100644 security/landlock/ptrace.h

diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index 041ea242e627..f1d1eb72fa76 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -1,4 +1,4 @@
 obj-$(CONFIG_SECURITY_LANDLOCK) := landlock.o
 
 landlock-y := setup.o object.o ruleset.o \
-	cred.o
+	cred.o ptrace.o
diff --git a/security/landlock/ptrace.c b/security/landlock/ptrace.c
new file mode 100644
index 000000000000..f55b82446de2
--- /dev/null
+++ b/security/landlock/ptrace.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock LSM - Ptrace hooks
+ *
+ * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2019-2020 ANSSI
+ */
+
+#include <asm/current.h>
+#include <linux/cred.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/lsm_hooks.h>
+#include <linux/rcupdate.h>
+#include <linux/sched.h>
+
+#include "common.h"
+#include "cred.h"
+#include "ptrace.h"
+#include "ruleset.h"
+#include "setup.h"
+
+/**
+ * domain_scope_le - Checks domain ordering for scoped ptrace
+ *
+ * @parent: Parent domain.
+ * @child: Potential child of @parent.
+ *
+ * Checks if the @parent domain is less or equal to (i.e. an ancestor, which
+ * means a subset of) the @child domain.
+ */
+static bool domain_scope_le(const struct landlock_ruleset *const parent,
+		const struct landlock_ruleset *const child)
+{
+	const struct landlock_hierarchy *walker;
+
+	if (!parent)
+		return true;
+	if (!child)
+		return false;
+	for (walker = child->hierarchy; walker; walker = walker->parent) {
+		if (walker == parent->hierarchy)
+			/* @parent is in the scoped hierarchy of @child. */
+			return true;
+	}
+	/* There is no relationship between @parent and @child. */
+	return false;
+}
+
+static bool task_is_scoped(const struct task_struct *const parent,
+		const struct task_struct *const child)
+{
+	bool is_scoped;
+	const struct landlock_ruleset *dom_parent, *dom_child;
+
+	rcu_read_lock();
+	dom_parent = landlock_get_task_domain(parent);
+	dom_child = landlock_get_task_domain(child);
+	is_scoped = domain_scope_le(dom_parent, dom_child);
+	rcu_read_unlock();
+	return is_scoped;
+}
+
+static int task_ptrace(const struct task_struct *const parent,
+		const struct task_struct *const child)
+{
+	/* Quick return for non-landlocked tasks. */
+	if (!landlocked(parent))
+		return 0;
+	if (task_is_scoped(parent, child))
+		return 0;
+	return -EPERM;
+}
+
+/**
+ * hook_ptrace_access_check - Determines whether the current process may access
+ *			      another
+ *
+ * @child: Process to be accessed.
+ * @mode: Mode of attachment.
+ *
+ * If the current task has Landlock rules, then the child must have at least
+ * the same rules.  Else denied.
+ *
+ * Determines whether a process may access another, returning 0 if permission
+ * granted, -errno if denied.
+ */
+static int hook_ptrace_access_check(struct task_struct *const child,
+		const unsigned int mode)
+{
+	return task_ptrace(current, child);
+}
+
+/**
+ * hook_ptrace_traceme - Determines whether another process may trace the
+ *			 current one
+ *
+ * @parent: Task proposed to be the tracer.
+ *
+ * If the parent has Landlock rules, then the current task must have the same
+ * or more rules.  Else denied.
+ *
+ * Determines whether the nominated task is permitted to trace the current
+ * process, returning 0 if permission is granted, -errno if denied.
+ */
+static int hook_ptrace_traceme(struct task_struct *const parent)
+{
+	return task_ptrace(parent, current);
+}
+
+static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
+	LSM_HOOK_INIT(ptrace_access_check, hook_ptrace_access_check),
+	LSM_HOOK_INIT(ptrace_traceme, hook_ptrace_traceme),
+};
+
+__init void landlock_add_ptrace_hooks(void)
+{
+	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
+			LANDLOCK_NAME);
+}
diff --git a/security/landlock/ptrace.h b/security/landlock/ptrace.h
new file mode 100644
index 000000000000..265b220ae3bf
--- /dev/null
+++ b/security/landlock/ptrace.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock LSM - Ptrace hooks
+ *
+ * Copyright © 2017-2019 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2019 ANSSI
+ */
+
+#ifndef _SECURITY_LANDLOCK_PTRACE_H
+#define _SECURITY_LANDLOCK_PTRACE_H
+
+__init void landlock_add_ptrace_hooks(void);
+
+#endif /* _SECURITY_LANDLOCK_PTRACE_H */
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index 8661112fb238..a5d6ef334991 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -11,6 +11,7 @@
 
 #include "common.h"
 #include "cred.h"
+#include "ptrace.h"
 #include "setup.h"
 
 struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
@@ -20,6 +21,7 @@ struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
 static int __init landlock_init(void)
 {
 	landlock_add_cred_hooks();
+	landlock_add_ptrace_hooks();
 	pr_info("Up and running.\n");
 	return 0;
 }
-- 
2.30.2

