Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B96E516AB08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 17:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgBXQNG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 11:13:06 -0500
Received: from smtp-8faa.mail.infomaniak.ch ([83.166.143.170]:50365 "EHLO
        smtp-8faa.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727763AbgBXQNB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:13:01 -0500
X-Greylist: delayed 622 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Feb 2020 11:12:59 EST
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 245DE10036190;
        Mon, 24 Feb 2020 17:02:27 +0100 (CET)
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 48R6Jy4l4kzlnxxt;
        Mon, 24 Feb 2020 17:02:26 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
Subject: [RFC PATCH v14 03/10] landlock: Set up the security framework and manage credentials
Date:   Mon, 24 Feb 2020 17:02:08 +0100
Message-Id: <20200224160215.4136-4-mic@digikod.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200224160215.4136-1-mic@digikod.net>
References: <20200224160215.4136-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A process credentials point to a Landlock domain, which is underneath
implemented with a ruleset.  In the following commits, this domain is
used to check and enforce the ptrace and filesystem security policies.
A domain is inherited from a parent to its child the same way a thread
inherits a seccomp policy.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
---

Changes since v13:
* totally get ride of the seccomp dependency
* only keep credential management and LSM setup.

Previous version:
https://lore.kernel.org/lkml/20191104172146.30797-4-mic@digikod.net/
---
 security/Kconfig           | 10 +++----
 security/landlock/Makefile |  3 ++-
 security/landlock/cred.c   | 47 ++++++++++++++++++++++++++++++++
 security/landlock/cred.h   | 55 ++++++++++++++++++++++++++++++++++++++
 security/landlock/setup.c  | 30 +++++++++++++++++++++
 security/landlock/setup.h  | 18 +++++++++++++
 6 files changed, 157 insertions(+), 6 deletions(-)
 create mode 100644 security/landlock/cred.c
 create mode 100644 security/landlock/cred.h
 create mode 100644 security/landlock/setup.c
 create mode 100644 security/landlock/setup.h

diff --git a/security/Kconfig b/security/Kconfig
index 9d9981394fb0..76547b5c694d 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -278,11 +278,11 @@ endchoice
 
 config LSM
 	string "Ordered list of enabled LSMs"
-	default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor" if DEFAULT_SECURITY_SMACK
-	default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo" if DEFAULT_SECURITY_APPARMOR
-	default "lockdown,yama,loadpin,safesetid,integrity,tomoyo" if DEFAULT_SECURITY_TOMOYO
-	default "lockdown,yama,loadpin,safesetid,integrity" if DEFAULT_SECURITY_DAC
-	default "lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
+	default "landlock,lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor" if DEFAULT_SECURITY_SMACK
+	default "landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo" if DEFAULT_SECURITY_APPARMOR
+	default "landlock,lockdown,yama,loadpin,safesetid,integrity,tomoyo" if DEFAULT_SECURITY_TOMOYO
+	default "landlock,lockdown,yama,loadpin,safesetid,integrity" if DEFAULT_SECURITY_DAC
+	default "landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list will be ignored. This can be
diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index d846eba445bb..041ea242e627 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_SECURITY_LANDLOCK) := landlock.o
 
-landlock-y := object.o ruleset.o
+landlock-y := setup.o object.o ruleset.o \
+	cred.o
diff --git a/security/landlock/cred.c b/security/landlock/cred.c
new file mode 100644
index 000000000000..69ef93e29a53
--- /dev/null
+++ b/security/landlock/cred.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock LSM - Credential hooks
+ *
+ * Copyright © 2017-2019 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2018-2019 ANSSI
+ */
+
+#include <linux/cred.h>
+#include <linux/lsm_hooks.h>
+
+#include "cred.h"
+#include "ruleset.h"
+#include "setup.h"
+
+static int hook_cred_prepare(struct cred *new, const struct cred *old,
+		gfp_t gfp)
+{
+	const struct landlock_cred_security *cred_old = landlock_cred(old);
+	struct landlock_cred_security *cred_new = landlock_cred(new);
+	struct landlock_ruleset *dom_old;
+
+	dom_old = cred_old->domain;
+	if (dom_old) {
+		landlock_get_ruleset(dom_old);
+		cred_new->domain = dom_old;
+	} else {
+		cred_new->domain = NULL;
+	}
+	return 0;
+}
+
+static void hook_cred_free(struct cred *cred)
+{
+	landlock_put_ruleset_enqueue(landlock_cred(cred)->domain);
+}
+
+static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
+	LSM_HOOK_INIT(cred_prepare, hook_cred_prepare),
+	LSM_HOOK_INIT(cred_free, hook_cred_free),
+};
+
+__init void landlock_add_hooks_cred(void)
+{
+	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
+			LANDLOCK_NAME);
+}
diff --git a/security/landlock/cred.h b/security/landlock/cred.h
new file mode 100644
index 000000000000..1e24682ee27e
--- /dev/null
+++ b/security/landlock/cred.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock LSM - Credential hooks
+ *
+ * Copyright © 2019 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2019 ANSSI
+ */
+
+#ifndef _SECURITY_LANDLOCK_CRED_H
+#define _SECURITY_LANDLOCK_CRED_H
+
+#include <linux/cred.h>
+#include <linux/init.h>
+#include <linux/rcupdate.h>
+
+#include "ruleset.h"
+#include "setup.h"
+
+struct landlock_cred_security {
+	struct landlock_ruleset *domain;
+};
+
+static inline struct landlock_cred_security *landlock_cred(
+		const struct cred *cred)
+{
+	return cred->security + landlock_blob_sizes.lbs_cred;
+}
+
+static inline struct landlock_ruleset *landlock_get_current_domain(void)
+{
+	return landlock_cred(current_cred())->domain;
+}
+
+/*
+ * The caller needs an RCU lock.
+ */
+static inline struct landlock_ruleset *landlock_get_task_domain(
+		struct task_struct *task)
+{
+	return landlock_cred(__task_cred(task))->domain;
+}
+
+static inline bool landlocked(struct task_struct *task)
+{
+	bool has_dom;
+
+	rcu_read_lock();
+	has_dom = !!landlock_get_task_domain(task);
+	rcu_read_unlock();
+	return has_dom;
+}
+
+__init void landlock_add_hooks_cred(void);
+
+#endif /* _SECURITY_LANDLOCK_CRED_H */
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
new file mode 100644
index 000000000000..fca5fa185465
--- /dev/null
+++ b/security/landlock/setup.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock LSM - Security framework setup
+ *
+ * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2018-2020 ANSSI
+ */
+
+#include <linux/init.h>
+#include <linux/lsm_hooks.h>
+
+#include "cred.h"
+#include "setup.h"
+
+struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
+	.lbs_cred = sizeof(struct landlock_cred_security),
+};
+
+static int __init landlock_init(void)
+{
+	pr_info(LANDLOCK_NAME ": Registering hooks\n");
+	landlock_add_hooks_cred();
+	return 0;
+}
+
+DEFINE_LSM(LANDLOCK_NAME) = {
+	.name = LANDLOCK_NAME,
+	.init = landlock_init,
+	.blobs = &landlock_blob_sizes,
+};
diff --git a/security/landlock/setup.h b/security/landlock/setup.h
new file mode 100644
index 000000000000..52eb8d806376
--- /dev/null
+++ b/security/landlock/setup.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock LSM - Security framework setup
+ *
+ * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2018-2020 ANSSI
+ */
+
+#ifndef _SECURITY_LANDLOCK_SETUP_H
+#define _SECURITY_LANDLOCK_SETUP_H
+
+#include <linux/lsm_hooks.h>
+
+#define LANDLOCK_NAME "landlock"
+
+extern struct lsm_blob_sizes landlock_blob_sizes;
+
+#endif /* _SECURITY_LANDLOCK_SETUP_H */
-- 
2.25.0

