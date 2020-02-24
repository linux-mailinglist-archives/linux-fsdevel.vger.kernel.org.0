Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4294D16AAEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 17:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgBXQKy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 11:10:54 -0500
Received: from smtp-sh.infomaniak.ch ([128.65.195.4]:51414 "EHLO
        smtp-sh.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgBXQKx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:10:53 -0500
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Feb 2020 11:10:31 EST
Received: from smtp-2-0001.mail.infomaniak.ch ([10.5.36.108])
        by smtp-sh.infomaniak.ch (8.14.5/8.14.5) with ESMTP id 01OG2Pnm021724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 24 Feb 2020 17:02:25 +0100
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 48R6Jx2C5hzlnBxH;
        Mon, 24 Feb 2020 17:02:25 +0100 (CET)
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
Subject: [RFC PATCH v14 02/10] landlock: Add ruleset and domain management
Date:   Mon, 24 Feb 2020 17:02:07 +0100
Message-Id: <20200224160215.4136-3-mic@digikod.net>
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

A Landlock ruleset is mainly a red-black tree with Landlock rules as
nodes.  This enables quick update and lookup to match a requested access
e.g., to a file.  A ruleset is usable through a dedicated file
descriptor (cf. following commit adding the syscall) which enables a
process to build it by adding new rules.

A domain is a ruleset tied to a set of processes.  This group of rules
defined the security policy enforced on these processes and their future
children.  A domain can transition to a new domain which is the merge of
itself with a ruleset provided by the current process.  This merge is
the intersection of all the constraints, which means that a process can
only gain more constraints over time.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
---

Changes since v13:
* New implementation, inspired by the previous inode eBPF map, but
  agnostic to the underlying kernel object.

Previous version:
https://lore.kernel.org/lkml/20190721213116.23476-7-mic@digikod.net/
---
 MAINTAINERS                   |   1 +
 include/uapi/linux/landlock.h | 102 ++++++++
 security/landlock/Makefile    |   2 +-
 security/landlock/ruleset.c   | 460 ++++++++++++++++++++++++++++++++++
 security/landlock/ruleset.h   | 106 ++++++++
 5 files changed, 670 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/landlock.h
 create mode 100644 security/landlock/ruleset.c
 create mode 100644 security/landlock/ruleset.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 206f85768cd9..937257925e65 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9366,6 +9366,7 @@ L:	linux-security-module@vger.kernel.org
 W:	https://landlock.io
 T:	git https://github.com/landlock-lsm/linux.git
 S:	Supported
+F:	include/uapi/linux/landlock.h
 F:	security/landlock/
 K:	landlock
 K:	LANDLOCK
diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
new file mode 100644
index 000000000000..92760aca3645
--- /dev/null
+++ b/include/uapi/linux/landlock.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Landlock - UAPI headers
+ *
+ * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2018-2020 ANSSI
+ */
+
+#ifndef _UAPI__LINUX_LANDLOCK_H__
+#define _UAPI__LINUX_LANDLOCK_H__
+
+/**
+ * DOC: fs_access
+ *
+ * A set of actions on kernel objects may be defined by an attribute (e.g.
+ * &struct landlock_attr_path_beneath) and a bitmask of access.
+ *
+ * Filesystem flags
+ * ~~~~~~~~~~~~~~~~
+ *
+ * These flags enable to restrict a sandbox process to a set of of actions on
+ * files and directories.  Files or directories opened before the sandboxing
+ * are not subject to these restrictions.
+ *
+ * - %LANDLOCK_ACCESS_FS_READ: Open or map a file with read access.
+ * - %LANDLOCK_ACCESS_FS_READDIR: List the content of a directory.
+ * - %LANDLOCK_ACCESS_FS_GETATTR: Read metadata of a file or a directory.
+ * - %LANDLOCK_ACCESS_FS_WRITE: Write to a file.
+ * - %LANDLOCK_ACCESS_FS_TRUNCATE: Truncate a file.
+ * - %LANDLOCK_ACCESS_FS_LOCK: Lock a file.
+ * - %LANDLOCK_ACCESS_FS_CHMOD: Change DAC permissions on a file or a
+ *   directory.
+ * - %LANDLOCK_ACCESS_FS_CHOWN: Change the owner of a file or a directory.
+ * - %LANDLOCK_ACCESS_FS_CHGRP: Change the group of a file or a directory.
+ * - %LANDLOCK_ACCESS_FS_IOCTL: Send various command to a special file, cf.
+ *   :manpage:`ioctl(2)`.
+ * - %LANDLOCK_ACCESS_FS_LINK_TO: Link a file into a directory.
+ * - %LANDLOCK_ACCESS_FS_RENAME_FROM: Rename a file or a directory.
+ * - %LANDLOCK_ACCESS_FS_RENAME_TO: Rename a file or a directory.
+ * - %LANDLOCK_ACCESS_FS_RMDIR: Remove an empty directory.
+ * - %LANDLOCK_ACCESS_FS_UNLINK: Remove a file.
+ * - %LANDLOCK_ACCESS_FS_MAKE_CHAR: Create a character device.
+ * - %LANDLOCK_ACCESS_FS_MAKE_DIR: Create a directory.
+ * - %LANDLOCK_ACCESS_FS_MAKE_REG: Create a regular file.
+ * - %LANDLOCK_ACCESS_FS_MAKE_SOCK: Create a UNIX domain socket.
+ * - %LANDLOCK_ACCESS_FS_MAKE_FIFO: Create a named pipe.
+ * - %LANDLOCK_ACCESS_FS_MAKE_BLOCK: Create a block device.
+ * - %LANDLOCK_ACCESS_FS_MAKE_SYM: Create a symbolic link.
+ * - %LANDLOCK_ACCESS_FS_EXECUTE: Execute a file.
+ * - %LANDLOCK_ACCESS_FS_CHROOT: Change the root directory of the current
+ *   process.
+ * - %LANDLOCK_ACCESS_FS_OPEN: Open a file or a directory.  This flag is set
+ *   for any actions (e.g. read, write, execute) requested to open a file or
+ *   directory.
+ * - %LANDLOCK_ACCESS_FS_MAP: Map a file.  This flag is set for any actions
+ *   (e.g. read, write, execute) requested to map a file.
+ *
+ * There is currently no restriction for directory walking e.g.,
+ * :manpage:`chdir(2)`.
+ */
+#define LANDLOCK_ACCESS_FS_READ			(1ULL << 0)
+#define LANDLOCK_ACCESS_FS_READDIR		(1ULL << 1)
+#define LANDLOCK_ACCESS_FS_GETATTR		(1ULL << 2)
+#define LANDLOCK_ACCESS_FS_WRITE		(1ULL << 3)
+#define LANDLOCK_ACCESS_FS_TRUNCATE		(1ULL << 4)
+#define LANDLOCK_ACCESS_FS_LOCK			(1ULL << 5)
+#define LANDLOCK_ACCESS_FS_CHMOD		(1ULL << 6)
+#define LANDLOCK_ACCESS_FS_CHOWN		(1ULL << 7)
+#define LANDLOCK_ACCESS_FS_CHGRP		(1ULL << 8)
+#define LANDLOCK_ACCESS_FS_IOCTL		(1ULL << 9)
+#define LANDLOCK_ACCESS_FS_LINK_TO		(1ULL << 10)
+#define LANDLOCK_ACCESS_FS_RENAME_FROM		(1ULL << 11)
+#define LANDLOCK_ACCESS_FS_RENAME_TO		(1ULL << 12)
+#define LANDLOCK_ACCESS_FS_RMDIR		(1ULL << 13)
+#define LANDLOCK_ACCESS_FS_UNLINK		(1ULL << 14)
+#define LANDLOCK_ACCESS_FS_MAKE_CHAR		(1ULL << 15)
+#define LANDLOCK_ACCESS_FS_MAKE_DIR		(1ULL << 16)
+#define LANDLOCK_ACCESS_FS_MAKE_REG		(1ULL << 17)
+#define LANDLOCK_ACCESS_FS_MAKE_SOCK		(1ULL << 18)
+#define LANDLOCK_ACCESS_FS_MAKE_FIFO		(1ULL << 19)
+#define LANDLOCK_ACCESS_FS_MAKE_BLOCK		(1ULL << 20)
+#define LANDLOCK_ACCESS_FS_MAKE_SYM		(1ULL << 21)
+#define LANDLOCK_ACCESS_FS_EXECUTE		(1ULL << 22)
+#define LANDLOCK_ACCESS_FS_CHROOT		(1ULL << 23)
+#define LANDLOCK_ACCESS_FS_OPEN			(1ULL << 24)
+#define LANDLOCK_ACCESS_FS_MAP			(1ULL << 25)
+
+/*
+ * Potential future access:
+ * - %LANDLOCK_ACCESS_FS_SETATTR
+ * - %LANDLOCK_ACCESS_FS_APPEND
+ * - %LANDLOCK_ACCESS_FS_LINK_FROM
+ * - %LANDLOCK_ACCESS_FS_MOUNT_FROM
+ * - %LANDLOCK_ACCESS_FS_MOUNT_TO
+ * - %LANDLOCK_ACCESS_FS_UNMOUNT
+ * - %LANDLOCK_ACCESS_FS_TRANSFER
+ * - %LANDLOCK_ACCESS_FS_RECEIVE
+ * - %LANDLOCK_ACCESS_FS_CHDIR
+ * - %LANDLOCK_ACCESS_FS_FCNTL
+ */
+
+#endif /* _UAPI__LINUX_LANDLOCK_H__ */
diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index cb6deefbf4c0..d846eba445bb 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_SECURITY_LANDLOCK) := landlock.o
 
-landlock-y := object.o
+landlock-y := object.o ruleset.o
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
new file mode 100644
index 000000000000..5ec013a4188d
--- /dev/null
+++ b/security/landlock/ruleset.c
@@ -0,0 +1,460 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock LSM - Ruleset management
+ *
+ * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2018-2020 ANSSI
+ */
+
+#include <linux/bug.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/rbtree.h>
+#include <linux/rcupdate.h>
+#include <linux/refcount.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+
+#include "object.h"
+#include "ruleset.h"
+
+static struct landlock_ruleset *create_ruleset(void)
+{
+	struct landlock_ruleset *ruleset;
+
+	ruleset = kzalloc(sizeof(*ruleset), GFP_KERNEL);
+	if (!ruleset)
+		return ERR_PTR(-ENOMEM);
+	refcount_set(&ruleset->usage, 1);
+	mutex_init(&ruleset->lock);
+	atomic_set(&ruleset->nb_rules, 0);
+	ruleset->root = RB_ROOT;
+	return ruleset;
+}
+
+struct landlock_ruleset *landlock_create_ruleset(u64 fs_access_mask)
+{
+	struct landlock_ruleset *ruleset;
+
+	/* Safely handles 32-bits conversion. */
+	BUILD_BUG_ON(!__same_type(fs_access_mask, _LANDLOCK_ACCESS_FS_LAST));
+
+	/* Checks content. */
+	if ((fs_access_mask | _LANDLOCK_ACCESS_FS_MASK) !=
+			_LANDLOCK_ACCESS_FS_MASK)
+		return ERR_PTR(-EINVAL);
+	/* Informs about useless ruleset. */
+	if (!fs_access_mask)
+		return ERR_PTR(-ENOMSG);
+	ruleset = create_ruleset();
+	if (!IS_ERR(ruleset))
+		ruleset->fs_access_mask = fs_access_mask;
+	return ruleset;
+}
+
+/*
+ * The underlying kernel object must be held by the caller.
+ */
+static struct landlock_ruleset_elem *create_ruleset_elem(
+		struct landlock_object *object)
+{
+	struct landlock_ruleset_elem *ruleset_elem;
+
+	ruleset_elem = kzalloc(sizeof(*ruleset_elem), GFP_KERNEL);
+	if (!ruleset_elem)
+		return ERR_PTR(-ENOMEM);
+	RB_CLEAR_NODE(&ruleset_elem->node);
+	RCU_INIT_POINTER(ruleset_elem->ref.object, object);
+	return ruleset_elem;
+}
+
+static struct landlock_rule *create_rule(struct landlock_object *object,
+		struct landlock_access *access)
+{
+	struct landlock_rule *new_rule;
+
+	if (WARN_ON_ONCE(!object))
+		return ERR_PTR(-EFAULT);
+	if (WARN_ON_ONCE(!access))
+		return ERR_PTR(-EFAULT);
+	new_rule = kzalloc(sizeof(*new_rule), GFP_KERNEL);
+	if (!new_rule)
+		return ERR_PTR(-ENOMEM);
+	refcount_set(&new_rule->usage, 1);
+	INIT_LIST_HEAD(&new_rule->list);
+	new_rule->access = *access;
+
+	spin_lock(&object->lock);
+	list_add_tail(&new_rule->list, &object->rules);
+	spin_unlock(&object->lock);
+	return new_rule;
+}
+
+/*
+ * An inserted rule can not be removed, only disabled (cf. struct
+ * landlock_ruleset_elem).
+ *
+ * The underlying kernel object must be held by the caller.
+ *
+ * @rule: Allocated struct owned by this function. The caller must hold the
+ * underlying kernel object (e.g., with a FD).
+ */
+int landlock_insert_ruleset_rule(struct landlock_ruleset *ruleset,
+		struct landlock_object *object, struct landlock_access *access,
+		struct landlock_rule *rule)
+{
+	struct rb_node **new;
+	struct rb_node *parent = NULL;
+	struct landlock_ruleset_elem *ruleset_elem;
+	struct landlock_rule *new_rule;
+
+	might_sleep();
+	/* Accesses may be set when creating a new rule. */
+	if (rule) {
+		if (WARN_ON_ONCE(access))
+			return -EINVAL;
+	} else {
+		if (WARN_ON_ONCE(!access))
+			return -EFAULT;
+	}
+
+	lockdep_assert_held(&ruleset->lock);
+	new = &(ruleset->root.rb_node);
+	while (*new) {
+		struct landlock_ruleset_elem *this = rb_entry(*new,
+				struct landlock_ruleset_elem, node);
+		uintptr_t this_object;
+		struct landlock_rule *this_rule;
+		struct landlock_access new_access;
+
+		this_object = (uintptr_t)rcu_access_pointer(this->ref.object);
+		if (this_object != (uintptr_t)object) {
+			parent = *new;
+			if (this_object < (uintptr_t)object)
+				new = &((*new)->rb_right);
+			else
+				new = &((*new)->rb_left);
+			continue;
+		}
+
+		/* Do not increment ruleset->nb_rules. */
+		this_rule = rcu_dereference_protected(this->ref.rule,
+				lockdep_is_held(&ruleset->lock));
+		/*
+		 * Checks if it is a new object with the same address as a
+		 * previously disabled one.  There is no possible race
+		 * condition because an object can not be disabled/deleted
+		 * while being inserted in this tree.
+		 */
+		if (landlock_rule_is_disabled(this_rule)) {
+			if (rule) {
+				refcount_inc(&rule->usage);
+				new_rule = rule;
+			} else {
+				/* Replace the previous rule with a new one. */
+				new_rule = create_rule(object, access);
+				if (IS_ERR(new_rule))
+					return PTR_ERR(new_rule);
+			}
+			rcu_assign_pointer(this->ref.rule, new_rule);
+			landlock_put_rule(object, this_rule);
+			return 0;
+		}
+
+		/* this_rule is potentially enabled. */
+		if (refcount_read(&this_rule->usage) == 1) {
+			if (rule) {
+				/* merge rule: intersection of access rights */
+				this_rule->access.self &= rule->access.self;
+				this_rule->access.beneath &=
+					rule->access.beneath;
+			} else {
+				/* extend rule: union of access rights */
+				this_rule->access.self |= access->self;
+				this_rule->access.beneath |= access->beneath;
+			}
+			return 0;
+		}
+
+		/*
+		 * If this_rule is shared with another ruleset, then create a
+		 * new object rule.
+		 */
+		if (rule) {
+			/* Merging a rule means an intersection of access. */
+			new_access.self = this_rule->access.self &
+				rule->access.self;
+			new_access.beneath = this_rule->access.beneath &
+				rule->access.beneath;
+		} else {
+			/* Extending a rule means a union of access. */
+			new_access.self = this_rule->access.self |
+				access->self;
+			new_access.beneath = this_rule->access.self |
+				access->beneath;
+		}
+		new_rule = create_rule(object, &new_access);
+		if (IS_ERR(new_rule))
+			return PTR_ERR(new_rule);
+		rcu_assign_pointer(this->ref.rule, new_rule);
+		landlock_put_rule(object, this_rule);
+		return 0;
+	}
+
+	/* There is no match for @object. */
+	ruleset_elem = create_ruleset_elem(object);
+	if (IS_ERR(ruleset_elem))
+		return PTR_ERR(ruleset_elem);
+	if (rule) {
+		refcount_inc(&rule->usage);
+		new_rule = rule;
+	} else {
+		new_rule = create_rule(object, access);
+		if (IS_ERR(new_rule)) {
+			kfree(ruleset_elem);
+			return PTR_ERR(new_rule);
+		}
+	}
+	RCU_INIT_POINTER(ruleset_elem->ref.rule, new_rule);
+	/*
+	 * Because of the missing RCU context annotation in struct rb_node,
+	 * Sparse emits a warning when encountering rb_link_node_rcu(), but
+	 * this function call is still safe.
+	 */
+	rb_link_node_rcu(&ruleset_elem->node, parent, new);
+	rb_insert_color(&ruleset_elem->node, &ruleset->root);
+	atomic_inc(&ruleset->nb_rules);
+	return 0;
+}
+
+static int merge_ruleset(struct landlock_ruleset *dst,
+		struct landlock_ruleset *src)
+{
+	struct rb_node *node;
+	int err = 0;
+
+	might_sleep();
+	if (!src)
+		return 0;
+	if (WARN_ON_ONCE(!dst))
+		return -EFAULT;
+	if (WARN_ON_ONCE(!dst->hierarchy))
+		return -EINVAL;
+
+	mutex_lock(&dst->lock);
+	mutex_lock_nested(&src->lock, 1);
+	dst->fs_access_mask |= src->fs_access_mask;
+	for (node = rb_first(&src->root); node; node = rb_next(node)) {
+		struct landlock_ruleset_elem *elem = rb_entry(node,
+				struct landlock_ruleset_elem, node);
+		struct landlock_object *object =
+			rcu_dereference_protected(elem->ref.object,
+					lockdep_is_held(&src->lock));
+		struct landlock_rule *rule =
+			rcu_dereference_protected(elem->ref.rule,
+					lockdep_is_held(&src->lock));
+
+		err = landlock_insert_ruleset_rule(dst, object, NULL, rule);
+		if (err)
+			goto out_unlock;
+	}
+
+out_unlock:
+	mutex_unlock(&src->lock);
+	mutex_unlock(&dst->lock);
+	return err;
+}
+
+void landlock_get_ruleset(struct landlock_ruleset *ruleset)
+{
+	if (!ruleset)
+		return;
+	refcount_inc(&ruleset->usage);
+}
+
+static void put_hierarchy(struct landlock_hierarchy *hierarchy)
+{
+	if (hierarchy && refcount_dec_and_test(&hierarchy->usage))
+		kfree(hierarchy);
+}
+
+static void put_ruleset(struct landlock_ruleset *ruleset)
+{
+	struct rb_node *orig;
+
+	might_sleep();
+	for (orig = rb_first(&ruleset->root); orig; orig = rb_next(orig)) {
+		struct landlock_ruleset_elem *freeme;
+		struct landlock_object *object;
+		struct landlock_rule *rule;
+
+		freeme = rb_entry(orig, struct landlock_ruleset_elem, node);
+		object = rcu_dereference_protected(freeme->ref.object,
+				refcount_read(&ruleset->usage) == 0);
+		rule = rcu_dereference_protected(freeme->ref.rule,
+				refcount_read(&ruleset->usage) == 0);
+		landlock_put_rule(object, rule);
+		kfree_rcu(freeme, rcu_free);
+	}
+	put_hierarchy(ruleset->hierarchy);
+	kfree_rcu(ruleset, rcu_free);
+}
+
+void landlock_put_ruleset(struct landlock_ruleset *ruleset)
+{
+	might_sleep();
+	if (ruleset && refcount_dec_and_test(&ruleset->usage))
+		put_ruleset(ruleset);
+}
+
+static void put_ruleset_work(struct work_struct *work)
+{
+	struct landlock_ruleset *ruleset;
+
+	ruleset = container_of(work, struct landlock_ruleset, work_put);
+	/*
+	 * Clean up rcu_free because of previous use through union work_put.
+	 * ruleset->rcu_free.func is already NULLed by __rcu_reclaim().
+	 */
+	ruleset->rcu_free.next = NULL;
+	put_ruleset(ruleset);
+}
+
+void landlock_put_ruleset_enqueue(struct landlock_ruleset *ruleset)
+{
+	if (ruleset && refcount_dec_and_test(&ruleset->usage)) {
+		INIT_WORK(&ruleset->work_put, put_ruleset_work);
+		schedule_work(&ruleset->work_put);
+	}
+}
+
+static bool clean_ref(struct landlock_ref *ref)
+{
+	struct landlock_rule *rule;
+
+	rule = rcu_dereference(ref->rule);
+	if (!rule)
+		return false;
+	if (!landlock_rule_is_disabled(rule))
+		return false;
+	rcu_assign_pointer(ref->rule, NULL);
+	/*
+	 * landlock_put_rule() will not sleep because we already checked
+	 * !landlock_rule_is_disabled(rule).
+	 */
+	landlock_put_rule(rcu_dereference(ref->object), rule);
+	return true;
+}
+
+static void clean_ruleset(struct landlock_ruleset *ruleset)
+{
+	struct rb_node *node;
+
+	if (!ruleset)
+		return;
+	/* We must lock the ruleset to not have a wrong nb_rules counter. */
+	mutex_lock(&ruleset->lock);
+	rcu_read_lock();
+	for (node = rb_first(&ruleset->root); node; node = rb_next(node)) {
+		struct landlock_ruleset_elem *elem = rb_entry(node,
+				struct landlock_ruleset_elem, node);
+
+		if (clean_ref(&elem->ref)) {
+			rb_erase(&elem->node, &ruleset->root);
+			kfree_rcu(elem, rcu_free);
+			atomic_dec(&ruleset->nb_rules);
+		}
+	}
+	rcu_read_unlock();
+	mutex_unlock(&ruleset->lock);
+}
+
+/*
+ * Creates a new ruleset, merged of @parent and @ruleset, or return @parent if
+ * @ruleset is empty.  If @parent is empty, return a duplicate of @ruleset.
+ *
+ * @parent: Must not be modified (i.e. locked or read-only).
+ */
+struct landlock_ruleset *landlock_merge_ruleset(
+		struct landlock_ruleset *parent,
+		struct landlock_ruleset *ruleset)
+{
+	struct landlock_ruleset *new_dom;
+	int err;
+
+	might_sleep();
+	/* Opportunistically put disabled rules. */
+	clean_ruleset(ruleset);
+
+	if (parent && WARN_ON_ONCE(!parent->hierarchy))
+		return ERR_PTR(-EINVAL);
+	if (!ruleset || atomic_read(&ruleset->nb_rules) == 0 ||
+			parent == ruleset) {
+		landlock_get_ruleset(parent);
+		return parent;
+	}
+
+	new_dom = create_ruleset();
+	if (IS_ERR(new_dom))
+		return new_dom;
+	new_dom->hierarchy = kzalloc(sizeof(*new_dom->hierarchy), GFP_KERNEL);
+	if (!new_dom->hierarchy) {
+		landlock_put_ruleset(new_dom);
+		return ERR_PTR(-ENOMEM);
+	}
+	refcount_set(&new_dom->hierarchy->usage, 1);
+
+	if (parent) {
+		new_dom->hierarchy->parent = parent->hierarchy;
+		refcount_inc(&parent->hierarchy->usage);
+		err = merge_ruleset(new_dom, parent);
+		if (err) {
+			landlock_put_ruleset(new_dom);
+			return ERR_PTR(err);
+		}
+	}
+	err = merge_ruleset(new_dom, ruleset);
+	if (err) {
+		landlock_put_ruleset(new_dom);
+		return ERR_PTR(err);
+	}
+	return new_dom;
+}
+
+/*
+ * The return pointer must only be used in a RCU-read block.
+ */
+const struct landlock_access *landlock_find_access(
+		const struct landlock_ruleset *ruleset,
+		const struct landlock_object *object)
+{
+	struct rb_node *node;
+
+	WARN_ON_ONCE(!rcu_read_lock_held());
+	if (!object)
+		return NULL;
+	node = ruleset->root.rb_node;
+	while (node) {
+		struct landlock_ruleset_elem *this = rb_entry(node,
+				struct landlock_ruleset_elem, node);
+		uintptr_t this_object =
+			(uintptr_t)rcu_access_pointer(this->ref.object);
+
+		if (this_object == (uintptr_t)object) {
+			struct landlock_rule *rule;
+
+			rule = rcu_dereference(this->ref.rule);
+			if (!landlock_rule_is_disabled(rule))
+				return &rule->access;
+			return NULL;
+		}
+		if (this_object < (uintptr_t)object)
+			node = node->rb_right;
+		else
+			node = node->rb_left;
+	}
+	return NULL;
+}
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
new file mode 100644
index 000000000000..afc88dbb8b4b
--- /dev/null
+++ b/security/landlock/ruleset.h
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock LSM - Ruleset management
+ *
+ * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2018-2020 ANSSI
+ */
+
+#ifndef _SECURITY_LANDLOCK_RULESET_H
+#define _SECURITY_LANDLOCK_RULESET_H
+
+#include <linux/compiler.h>
+#include <linux/mutex.h>
+#include <linux/poison.h>
+#include <linux/rbtree.h>
+#include <linux/rcupdate.h>
+#include <linux/refcount.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+#include <uapi/linux/landlock.h>
+
+#include "object.h"
+
+#define _LANDLOCK_ACCESS_FS_LAST	LANDLOCK_ACCESS_FS_MAP
+#define _LANDLOCK_ACCESS_FS_MASK	((_LANDLOCK_ACCESS_FS_LAST << 1) - 1)
+
+struct landlock_ref {
+	/*
+	 * @object: Identify a kernel object (e.g. an inode).  This is used as
+	 * a key for a ruleset tree (cf. struct landlock_ruleset_elem).  This
+	 * pointer is set once and never modified.  It may point to a deleted
+	 * object and should then be dereferenced with great care, thanks to a
+	 * call to landlock_rule_is_disabled(@rule) from inside an RCU-read
+	 * block, cf. landlock_put_rule().
+	 */
+	struct landlock_object __rcu *object;
+	/*
+	 * @rule: Ties a rule to an object. Set once with an allocated rule,
+	 * but can be NULLed if the rule is disabled.
+	 */
+	struct landlock_rule __rcu *rule;
+};
+
+/*
+ * Red-black tree element used in a landlock_ruleset.
+ */
+struct landlock_ruleset_elem {
+	struct landlock_ref ref;
+	struct rb_node node;
+	struct rcu_head rcu_free;
+};
+
+/*
+ * Enable hierarchy identification even when a parent domain vanishes.  This is
+ * needed for the ptrace protection.
+ */
+struct landlock_hierarchy {
+	struct landlock_hierarchy *parent;
+	refcount_t usage;
+};
+
+/*
+ * Kernel representation of a ruleset.  This data structure must contains
+ * unique entries, be updatable, and quick to match an object.
+ */
+struct landlock_ruleset {
+	/*
+	 * @fs_access_mask: Contains the subset of filesystem actions which are
+	 * restricted by a ruleset.  This is used when merging rulesets and for
+	 * userspace backward compatibility (i.e. future-proof).  Set once and
+	 * never changed for the lifetime of the ruleset.
+	 */
+	u32 fs_access_mask;
+	struct landlock_hierarchy *hierarchy;
+	refcount_t usage;
+	union {
+		struct rcu_head	rcu_free;
+		struct work_struct work_put;
+	};
+	struct mutex lock;
+	atomic_t nb_rules;
+	/*
+	 * @root: Red-black tree containing landlock_ruleset_elem nodes.
+	 */
+	struct rb_root root;
+};
+
+struct landlock_ruleset *landlock_create_ruleset(u64 fs_access_mask);
+
+void landlock_get_ruleset(struct landlock_ruleset *ruleset);
+void landlock_put_ruleset(struct landlock_ruleset *ruleset);
+void landlock_put_ruleset_enqueue(struct landlock_ruleset *ruleset);
+
+int landlock_insert_ruleset_rule(struct landlock_ruleset *ruleset,
+		struct landlock_object *object, struct landlock_access *access,
+		struct landlock_rule *rule);
+
+struct landlock_ruleset *landlock_merge_ruleset(
+		struct landlock_ruleset *domain,
+		struct landlock_ruleset *ruleset);
+
+const struct landlock_access *landlock_find_access(
+		const struct landlock_ruleset *ruleset,
+		const struct landlock_object *object);
+
+#endif /* _SECURITY_LANDLOCK_RULESET_H */
-- 
2.25.0

