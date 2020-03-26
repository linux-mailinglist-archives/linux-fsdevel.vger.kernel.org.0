Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29C60194915
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 21:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgCZU2j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 16:28:39 -0400
Received: from smtp-42a8.mail.infomaniak.ch ([84.16.66.168]:53605 "EHLO
        smtp-42a8.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728689AbgCZU1q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 16:27:46 -0400
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 48pGkk44HtzljC1p;
        Thu, 26 Mar 2020 21:27:42 +0100 (CET)
Received: from localhost (unknown [94.23.54.103])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 48pGkk129bzlk4Vp;
        Thu, 26 Mar 2020 21:27:42 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
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
Subject: [PATCH v15 02/10] landlock: Add ruleset and domain management
Date:   Thu, 26 Mar 2020 21:27:23 +0100
Message-Id: <20200326202731.693608-3-mic@digikod.net>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200326202731.693608-1-mic@digikod.net>
References: <20200326202731.693608-1-mic@digikod.net>
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
descriptor (cf. following commit implementing the syscall) which enables
a process to create and populate a ruleset with new rules.

A domain is a ruleset tied to a set of processes.  This group of rules
define the security policy enforced on these processes and their future
children.  A domain can transition to a new domain which is the
intersection of all its constraints and those of a ruleset provided by
the current process.  This modification only impact the current process.
This means that a process can only gain more constraints (i.e. lose
accesses) over time.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
---

Changes since v14:
* Simplify the object, rule and ruleset management at the expense of a
  less aggressive memory freeing (contributed by Jann Horn, with
  additional modifications):
  - Make a domain immutable (remove the opportunistic cleaning).
  - Remove RCU pointers.
  - Merge struct landlock_ref and struct landlock_ruleset_elem into
    landlock_rule: get ride of rule's RCU.
  - Adjust union.
  - Remove the landlock_insert_rule() check about a new object with the
    same address as a previously disabled one, because it is not
    possible to disable a rule anymore.
  Cf. https://lore.kernel.org/lkml/CAG48ez21bEn0wL1bbmTiiu8j9jP5iEWtHOwz4tURUJ+ki0ydYw@mail.gmail.com/
* Fix nested domains by implementing a notion of layer level and depth:
  - Update landlock_insert_rule() to manage such layers.
  - Add an inherit_ruleset() helper to properly create a new domain.
  - Rename landlock_find_access() to landlock_find_rule() and return a
    full rule reference.
  - Add a layer_level and a layer_depth fields to struct landlock_rule.
  - Add a top_layer_level field to struct landlock_ruleset.
* Remove access rights that may be required for FD-only requests:
  truncate, getattr, lock, chmod, chown, chgrp, ioctl.  This will be
  handle in a future evolution of Landlock, but right now the goal is to
  lighten the code to ease review.
* Remove LANDLOCK_ACCESS_FS_OPEN and rename
  LANDLOCK_ACCESS_FS_{READ,WRITE} with a FILE suffix.
* Rename LANDLOCK_ACCESS_FS_READDIR to match the *_FILE pattern.
* Remove LANDLOCK_ACCESS_FS_MAP which was useless.
* Fix memory leak in put_hierarchy() (reported by Jann Horn).
* Fix user-after-free and rename free_ruleset() (reported by Jann Horn).
* Replace the for loops with rbtree_postorder_for_each_entry_safe().
* Constify variables.
* Only use refcount_inc() through getter helpers.
* Change Landlock_insert_ruleset_access() to
  Landlock_insert_ruleset_rule().
* Rename landlock_put_ruleset_enqueue() to landlock_put_ruleset_deferred().
* Improve kernel documentation and add a warning about the unhandled
  access/syscall families.
* Move ABI check to syscall.c .

Changes since v13:
* New implementation, inspired by the previous inode eBPF map, but
  agnostic to the underlying kernel object.

Previous version:
https://lore.kernel.org/lkml/20190721213116.23476-7-mic@digikod.net/
---
 MAINTAINERS                   |   1 +
 include/uapi/linux/landlock.h |  93 +++++++++
 security/landlock/Makefile    |   2 +-
 security/landlock/ruleset.c   | 352 ++++++++++++++++++++++++++++++++++
 security/landlock/ruleset.h   | 182 ++++++++++++++++++
 5 files changed, 629 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/landlock.h
 create mode 100644 security/landlock/ruleset.c
 create mode 100644 security/landlock/ruleset.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 440750cf4fbc..f8fa29e0f550 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9364,6 +9364,7 @@ L:	linux-security-module@vger.kernel.org
 W:	https://landlock.io
 T:	git https://github.com/landlock-lsm/linux.git
 S:	Supported
+F:	include/uapi/linux/landlock.h
 F:	security/landlock/
 K:	landlock
 K:	LANDLOCK
diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
new file mode 100644
index 000000000000..32003e8b845a
--- /dev/null
+++ b/include/uapi/linux/landlock.h
@@ -0,0 +1,93 @@
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
+ * - %LANDLOCK_ACCESS_FS_EXECUTE: Execute a file.
+ * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Write to a file.
+ * - %LANDLOCK_ACCESS_FS_READ_FILE: Open a file with read access.
+ * - %LANDLOCK_ACCESS_FS_READ_DIR: Open a directory or list its content.
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
+ * - %LANDLOCK_ACCESS_FS_CHROOT: Change the root directory of the current
+ *   process.
+ *
+ * .. warning::
+ *
+ *   It is currently not possible to restrict some file-related actions
+ *   accessible through these syscall families: :manpage:`chdir(2)`,
+ *   :manpage:`truncate(2)`, :manpage:`stat(2)`, :manpage:`flock(2)`,
+ *   :manpage:`chmod(2)`, :manpage:`chown(2)`, :manpage:`setxattr(2)`,
+ *   :manpage:`ioctl(2)`, :manpage:`fcntl(2)`.
+ *   Future evolutions of Landlock will make possible to restrict them.
+ */
+#define LANDLOCK_ACCESS_FS_EXECUTE		(1ULL << 0)
+#define LANDLOCK_ACCESS_FS_WRITE_FILE		(1ULL << 1)
+#define LANDLOCK_ACCESS_FS_READ_FILE		(1ULL << 2)
+#define LANDLOCK_ACCESS_FS_READ_DIR		(1ULL << 3)
+#define LANDLOCK_ACCESS_FS_LINK_TO		(1ULL << 4)
+#define LANDLOCK_ACCESS_FS_RENAME_FROM		(1ULL << 5)
+#define LANDLOCK_ACCESS_FS_RENAME_TO		(1ULL << 6)
+#define LANDLOCK_ACCESS_FS_RMDIR		(1ULL << 7)
+#define LANDLOCK_ACCESS_FS_UNLINK		(1ULL << 8)
+#define LANDLOCK_ACCESS_FS_MAKE_CHAR		(1ULL << 9)
+#define LANDLOCK_ACCESS_FS_MAKE_DIR		(1ULL << 10)
+#define LANDLOCK_ACCESS_FS_MAKE_REG		(1ULL << 11)
+#define LANDLOCK_ACCESS_FS_MAKE_SOCK		(1ULL << 12)
+#define LANDLOCK_ACCESS_FS_MAKE_FIFO		(1ULL << 13)
+#define LANDLOCK_ACCESS_FS_MAKE_BLOCK		(1ULL << 14)
+#define LANDLOCK_ACCESS_FS_MAKE_SYM		(1ULL << 15)
+#define LANDLOCK_ACCESS_FS_CHROOT		(1ULL << 16)
+
+/*
+ * Potential future access:
+ * - %LANDLOCK_ACCESS_FS_OPEN (for O_PATH)
+ * - %LANDLOCK_ACCESS_FS_GETATTR
+ * - %LANDLOCK_ACCESS_FS_SETATTR
+ * - %LANDLOCK_ACCESS_FS_LOCK
+ * - %LANDLOCK_ACCESS_FS_CHMOD
+ * - %LANDLOCK_ACCESS_FS_CHOWN
+ * - %LANDLOCK_ACCESS_FS_CHGRP
+ * - %LANDLOCK_ACCESS_FS_APPEND
+ * - %LANDLOCK_ACCESS_FS_TRUNCATE
+ * - %LANDLOCK_ACCESS_FS_LINK_FROM
+ * - %LANDLOCK_ACCESS_FS_MOUNT_FROM
+ * - %LANDLOCK_ACCESS_FS_MOUNT_TO
+ * - %LANDLOCK_ACCESS_FS_UNMOUNT
+ * - %LANDLOCK_ACCESS_FS_TRANSFER
+ * - %LANDLOCK_ACCESS_FS_RECEIVE
+ * - %LANDLOCK_ACCESS_FS_CHDIR
+ * - %LANDLOCK_ACCESS_FS_FCNTL
+ * - %LANDLOCK_ACCESS_FS_IOCTL
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
index 000000000000..505c6d435a55
--- /dev/null
+++ b/security/landlock/ruleset.c
@@ -0,0 +1,352 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock LSM - Ruleset management
+ *
+ * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2018-2020 ANSSI
+ */
+
+#include <linux/bug.h>
+#include <linux/compiler_types.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/limits.h>
+#include <linux/rbtree.h>
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
+	/*
+	 * root = RB_ROOT
+	 * hierarchy = NULL
+	 * top_layer_level = 0
+	 * nb_rules = 0
+	 * fs_access_mask = 0
+	 */
+	return ruleset;
+}
+
+struct landlock_ruleset *landlock_create_ruleset(const u32 fs_access_mask)
+{
+	struct landlock_ruleset *ruleset;
+
+	/* Informs about useless ruleset. */
+	if (!fs_access_mask)
+		return ERR_PTR(-ENOMSG);
+	ruleset = create_ruleset();
+	if (!IS_ERR(ruleset))
+		ruleset->fs_access_mask = fs_access_mask;
+	return ruleset;
+}
+
+static struct landlock_rule *duplicate_rule(struct landlock_rule *const src)
+{
+	struct landlock_rule *new_rule;
+
+	new_rule = kzalloc(sizeof(*new_rule), GFP_KERNEL);
+	if (!new_rule)
+		return ERR_PTR(-ENOMEM);
+	RB_CLEAR_NODE(&new_rule->node);
+	landlock_get_object(src->object);
+	new_rule->object = src->object;
+	new_rule->layer_level = src->layer_level;
+	new_rule->layer_depth = src->layer_depth;
+	new_rule->access = src->access;
+	return new_rule;
+}
+
+static void put_rule(struct landlock_rule *const rule)
+{
+	might_sleep();
+	if (!rule)
+		return;
+	landlock_put_object(rule->object);
+	kfree(rule);
+}
+
+/*
+ * Assumptions:
+ * - An inserted rule can not be removed.
+ * - The underlying kernel object must be held by the caller.
+ *
+ * @rule: Read-only payload to be inserted (not own by this function).
+ * @is_merge: If true, intersects access rights and updates the rule's layer
+ * (e.g. merge two rulesets), else do a union of access rights and keep the
+ * rule's layer (e.g. extend a ruleset)
+ */
+int landlock_insert_rule(struct landlock_ruleset *const ruleset,
+		struct landlock_rule *const rule, const bool is_merge)
+{
+	struct rb_node **walker_node;
+	struct rb_node *parent_node = NULL;
+	struct landlock_rule *new_rule;
+
+	might_sleep();
+	lockdep_assert_held(&ruleset->lock);
+	walker_node = &(ruleset->root.rb_node);
+	while (*walker_node) {
+		struct landlock_rule *this = rb_entry(*walker_node,
+				struct landlock_rule, node);
+		uintptr_t this_object;
+
+		this_object = (uintptr_t)this->object;
+		if (this_object != (uintptr_t)rule->object) {
+			parent_node = *walker_node;
+			if (this_object < (uintptr_t)rule->object)
+				walker_node = &((*walker_node)->rb_right);
+			else
+				walker_node = &((*walker_node)->rb_left);
+			continue;
+		}
+
+		/* If there is a matching rule, updates it. */
+		if (is_merge) {
+			/* Intersects access rights. */
+			this->access.self &= rule->access.self;
+			this->access.beneath &= rule->access.beneath;
+
+			/* Updates the rule layer. */
+			if (this->layer_level + 1 == ruleset->top_layer_level)
+				/* Extend the contiguous underlying level. */
+				this->layer_depth++;
+			else
+				/*
+				 * Creates a new separated layer.  The previous
+				 * level may still have other rules referring
+				 * to it.  In any case, this new layer is a
+				 * subset of the previous access rights.
+				 */
+				this->layer_depth = 1;
+			this->layer_level = ruleset->top_layer_level;
+		} else {
+			/* Extends access rights. */
+			this->access.self |= rule->access.self;
+			this->access.beneath |= rule->access.beneath;
+		}
+		return 0;
+	}
+
+	/* There is no match for @rule->object. */
+	new_rule = duplicate_rule(rule);
+	if (IS_ERR(new_rule))
+		return PTR_ERR(new_rule);
+	if (is_merge) {
+		new_rule->layer_depth = 1;
+		new_rule->layer_level = ruleset->top_layer_level;
+	}
+	rb_link_node(&new_rule->node, parent_node, walker_node);
+	rb_insert_color(&new_rule->node, &ruleset->root);
+	atomic_inc(&ruleset->nb_rules);
+	return 0;
+}
+
+static inline void get_hierarchy(struct landlock_hierarchy *const hierarchy)
+{
+	if (hierarchy)
+		refcount_inc(&hierarchy->usage);
+}
+
+static void put_hierarchy(struct landlock_hierarchy *hierarchy)
+{
+	while (hierarchy && refcount_dec_and_test(&hierarchy->usage)) {
+		const struct landlock_hierarchy *const freeme = hierarchy;
+
+		hierarchy = hierarchy->parent;
+		kfree(freeme);
+	}
+}
+
+static int merge_ruleset(struct landlock_ruleset *const dst,
+		struct landlock_ruleset *const src)
+{
+	struct landlock_rule *walker_rule, *next_rule;
+	int err = 0;
+
+	might_sleep();
+	if (!src)
+		return 0;
+	/* Only merge into a domain. */
+	if (WARN_ON_ONCE(!dst || !dst->hierarchy))
+		return -EFAULT;
+
+	mutex_lock(&dst->lock);
+	mutex_lock_nested(&src->lock, 1);
+	dst->fs_access_mask |= src->fs_access_mask;
+
+	/* Merges the @src tree. */
+	rbtree_postorder_for_each_entry_safe(walker_rule, next_rule,
+			&src->root, node) {
+		err = landlock_insert_rule(dst, walker_rule, true);
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
+static struct landlock_ruleset *inherit_ruleset(
+		struct landlock_ruleset *const parent)
+{
+	struct landlock_rule *walker_rule, *next_rule;
+	struct landlock_ruleset *new_ruleset;
+	int err = 0;
+
+	might_sleep();
+	new_ruleset = create_ruleset();
+	if (IS_ERR(new_ruleset))
+		return new_ruleset;
+
+	new_ruleset->hierarchy = kzalloc(sizeof(*new_ruleset->hierarchy),
+			GFP_KERNEL);
+	if (!new_ruleset->hierarchy) {
+		err = -ENOMEM;
+		goto out_put_ruleset;
+	}
+	refcount_set(&new_ruleset->hierarchy->usage, 1);
+	if (!parent) {
+		/* Makes an initial layer. */
+		new_ruleset->top_layer_level = 1;
+		return new_ruleset;
+	}
+
+	mutex_lock(&new_ruleset->lock);
+	mutex_lock_nested(&parent->lock, 1);
+	/* Makes a new layer. */
+	if (parent->top_layer_level == U32_MAX) {
+		err = -E2BIG;
+		goto out_unlock;
+	}
+	new_ruleset->top_layer_level = parent->top_layer_level + 1;
+	new_ruleset->fs_access_mask = parent->fs_access_mask;
+	WARN_ON_ONCE(!parent->hierarchy);
+	get_hierarchy(parent->hierarchy);
+	new_ruleset->hierarchy->parent = parent->hierarchy;
+
+	/* Copies the @parent tree. */
+	rbtree_postorder_for_each_entry_safe(walker_rule, next_rule,
+			&parent->root, node) {
+		err = landlock_insert_rule(new_ruleset, walker_rule, false);
+		if (err)
+			goto out_unlock;
+	}
+	mutex_unlock(&parent->lock);
+	mutex_unlock(&new_ruleset->lock);
+	return new_ruleset;
+
+out_unlock:
+	mutex_unlock(&parent->lock);
+	mutex_unlock(&new_ruleset->lock);
+
+out_put_ruleset:
+	landlock_put_ruleset(new_ruleset);
+	return ERR_PTR(err);
+}
+
+static void free_ruleset(struct landlock_ruleset *const ruleset)
+{
+	struct landlock_rule *freeme, *next;
+
+	might_sleep();
+	rbtree_postorder_for_each_entry_safe(freeme, next, &ruleset->root,
+			node)
+		put_rule(freeme);
+	put_hierarchy(ruleset->hierarchy);
+	kfree(ruleset);
+}
+
+void landlock_put_ruleset(struct landlock_ruleset *const ruleset)
+{
+	might_sleep();
+	if (ruleset && refcount_dec_and_test(&ruleset->usage))
+		free_ruleset(ruleset);
+}
+
+static void free_ruleset_work(struct work_struct *const work)
+{
+	struct landlock_ruleset *ruleset;
+
+	ruleset = container_of(work, struct landlock_ruleset, work_free);
+	free_ruleset(ruleset);
+}
+
+void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset)
+{
+	if (ruleset && refcount_dec_and_test(&ruleset->usage)) {
+		INIT_WORK(&ruleset->work_free, free_ruleset_work);
+		schedule_work(&ruleset->work_free);
+	}
+}
+
+/*
+ * Creates a new transition domain, intersection of @parent and @ruleset, or
+ * return @parent if @ruleset is empty.  If @parent is empty, returns a
+ * duplicate of @ruleset.
+ */
+struct landlock_ruleset *landlock_merge_ruleset(
+		struct landlock_ruleset *const parent,
+		struct landlock_ruleset *const ruleset)
+{
+	struct landlock_ruleset *new_dom;
+	int err;
+
+	might_sleep();
+	if (!ruleset || atomic_read(&ruleset->nb_rules) == 0 ||
+			parent == ruleset) {
+		landlock_get_ruleset(parent);
+		return parent;
+	}
+
+	new_dom = inherit_ruleset(parent);
+	if (IS_ERR(new_dom))
+		return new_dom;
+
+	err = merge_ruleset(new_dom, ruleset);
+	if (err) {
+		landlock_put_ruleset(new_dom);
+		return ERR_PTR(err);
+	}
+	return new_dom;
+}
+
+/*
+ * The returned access has the same lifetime as @ruleset.
+ */
+const struct landlock_rule *landlock_find_rule(
+		const struct landlock_ruleset *const ruleset,
+		const struct landlock_object *const object)
+{
+	const struct rb_node *node;
+
+	if (!object)
+		return NULL;
+	node = ruleset->root.rb_node;
+	while (node) {
+		struct landlock_rule *this = rb_entry(node,
+				struct landlock_rule, node);
+
+		if (this->object == object)
+			return this;
+		if (this->object < object)
+			node = node->rb_right;
+		else
+			node = node->rb_left;
+	}
+	return NULL;
+}
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
new file mode 100644
index 000000000000..1bbd8d842c01
--- /dev/null
+++ b/security/landlock/ruleset.h
@@ -0,0 +1,182 @@
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
+#include <linux/mutex.h>
+#include <linux/rbtree.h>
+#include <linux/refcount.h>
+#include <linux/workqueue.h>
+#include <uapi/linux/landlock.h>
+
+#include "object.h"
+
+#define _LANDLOCK_ACCESS_FS_LAST	LANDLOCK_ACCESS_FS_CHROOT
+#define _LANDLOCK_ACCESS_FS_MASK	((_LANDLOCK_ACCESS_FS_LAST << 1) - 1)
+
+/**
+ * struct landlock_access - Set of access rights
+ */
+struct landlock_access {
+	/**
+	 * @self: Bitfield of allowed actions on the kernel object.  They are
+	 * relative to the object type (e.g. %LANDLOCK_ACTION_FS_READ).
+	 */
+	u32 self;
+	/**
+	 * @beneath: Same as @self, but for the child objects (e.g. a file in a
+	 * directory).
+	 */
+	u32 beneath;
+};
+
+/**
+ * struct landlock_rule - Access rights tied to an object
+ *
+ * When enforcing a ruleset (i.e. merging a ruleset into the current domain),
+ * the layer level of a new rule is the incremented top layer level (cf.
+ * &struct landlock_ruleset).  If there is no rule (from this domain) tied to
+ * the same object, then the depth of the new rule is 1. However, if there is
+ * already a rule tied to the same object and if this rule's layer level is the
+ * previous top layer level, then the depth and the layer level are both
+ * incremented and the rule is updated with the new access rights (boolean
+ * AND).
+ */
+struct landlock_rule {
+	/**
+	 * @node: Node in the red-black tree.
+	 */
+	struct rb_node node;
+	/**
+	 * @object: Pointer to identify a kernel object (e.g. an inode).  This
+	 * is used as a key for this ruleset element.  This pointer is set once
+	 * and never modified.  It always point to an allocated object because
+	 * each rule increment the refcount of there object.
+	 */
+	struct landlock_object *object;
+	/**
+	 * @layer_level: Identifies the layer level of the ruleset from which
+	 * the rule come from.
+	 */
+	u32 layer_level;
+	/**
+	 * @layer_depth: Number of rules from different consecutive merged
+	 * layers from which this rule is the result.
+	 */
+	u32 layer_depth;
+	/**
+	 * @access: Access rights for the object.  This may be the result of
+	 * the merged access rights (boolean AND) from multiple layers
+	 * referring to the same object.
+	 */
+	struct landlock_access access;
+};
+
+/**
+ * struct landlock_hierarchy - Node in a ruleset hierarchy
+ */
+struct landlock_hierarchy {
+	/**
+	 * @parent: Pointer to the parent node, or NULL if it is a root Lanlock
+	 * domain.
+	 */
+	struct landlock_hierarchy *parent;
+	/**
+	 * @usage: Number of potential children domains plus their parent
+	 * domain.
+	 */
+	refcount_t usage;
+};
+
+/**
+ * struct landlock_ruleset - Landlock ruleset
+ *
+ * This data structure must contains unique entries, be updatable, and quick to
+ * match an object.
+ */
+struct landlock_ruleset {
+	/**
+	 * @root: Root of a red-black tree containing &struct landlock_rule
+	 * nodes.
+	 */
+	struct rb_root root;
+	/**
+	 * @hierarchy: Enables hierarchy identification even when a parent
+	 * domain vanishes.  This is needed for the ptrace protection.
+	 */
+	struct landlock_hierarchy *hierarchy;
+	union {
+		/**
+		 * @work_free: Enables to free a ruleset within a lockless
+		 * section.  This is only used by
+		 * landlock_put_ruleset_deferred() when @usage reaches zero.
+		 * The fields @usage, @lock, @top_layer_level, @nb_rules and
+		 * @fs_access_mask are then unused.
+		 */
+		struct work_struct work_free;
+		struct {
+			/**
+			 * @usage: Number of processes (i.e. domains) or file
+			 * descriptors referencing this ruleset.
+			 */
+			refcount_t usage;
+			/**
+			 * @lock: Guards against concurrent modifications of
+			 * @root, if @usage is greater than zero.
+			 */
+			struct mutex lock;
+			/**
+			 * @top_layer_level: Stores the last merged layer
+			 * level.  This enables to set the layer level of the
+			 * new rules imported from a ruleset, and to check that
+			 * all the layers allow an access request.  The first
+			 * layer level is 1.  A value of 0 identify a
+			 * non-merged ruleset (i.e. not a domain).
+			 */
+			u32 top_layer_level;
+			/**
+			 * @nb_rules: Number of rules in this ruleset.
+			 */
+			atomic_t nb_rules;
+			/**
+			 * @fs_access_mask: Contains the subset of filesystem
+			 * actions which are restricted by a ruleset.  This is
+			 * used when merging rulesets and for userspace
+			 * backward compatibility (i.e. future-proof).  Set
+			 * once and never changed for the lifetime of the
+			 * ruleset.
+			 */
+			u32 fs_access_mask;
+		};
+	};
+};
+
+struct landlock_ruleset *landlock_create_ruleset(const u32 fs_access_mask);
+
+void landlock_put_ruleset(struct landlock_ruleset *const ruleset);
+void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset);
+
+int landlock_insert_rule(struct landlock_ruleset *const ruleset,
+		struct landlock_rule *const rule, const bool is_merge);
+
+struct landlock_ruleset *landlock_merge_ruleset(
+		struct landlock_ruleset *const parent,
+		struct landlock_ruleset *const ruleset);
+
+const struct landlock_rule *landlock_find_rule(
+		const struct landlock_ruleset *const ruleset,
+		const struct landlock_object *const object);
+
+static inline void landlock_get_ruleset(struct landlock_ruleset *const ruleset)
+{
+	if (ruleset)
+		refcount_inc(&ruleset->usage);
+}
+
+#endif /* _SECURITY_LANDLOCK_RULESET_H */
-- 
2.26.0.rc2

