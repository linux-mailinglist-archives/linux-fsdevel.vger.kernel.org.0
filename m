Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA822A4EA9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 19:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbgKCSWs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 13:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729342AbgKCSVT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:21:19 -0500
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [IPv6:2001:1600:4:17::8faa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44561C061A48
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 10:21:19 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CQdQP4QvrzlhTgm;
        Tue,  3 Nov 2020 19:21:17 +0100 (CET)
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4CQdQN3HLHzlh8TK;
        Tue,  3 Nov 2020 19:21:15 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
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
Subject: [PATCH v23 02/12] landlock: Add ruleset and domain management
Date:   Tue,  3 Nov 2020 19:20:59 +0100
Message-Id: <20201103182109.1014179-3-mic@digikod.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103182109.1014179-1-mic@digikod.net>
References: <20201103182109.1014179-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

A Landlock ruleset is mainly a red-black tree with Landlock rules as
nodes.  This enables quick update and lookup to match a requested
access, e.g. to a file.  A ruleset is usable through a dedicated file
descriptor (cf. following commit implementing syscalls) which enables a
process to create and populate a ruleset with new rules.

A domain is a ruleset tied to a set of processes.  This group of rules
defines the security policy enforced on these processes and their future
children.  A domain can transition to a new domain which is the
intersection of all its constraints and those of a ruleset provided by
the current process.  This modification only impact the current process.
This means that a process can only gain more constraints (i.e. lose
accesses) over time.

Cc: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Reviewed-by: Jann Horn <jannh@google.com>
---

Changes since v22:
* Explicitely use RB_ROOT and SINGLE_DEPTH_NESTING (suggested by Jann
  Horn).
* Improve comments and fix spelling (suggested by Jann Horn).

Changes since v21:
* Add and clean up comments.

Changes since v18:
* Account rulesets to kmemcg.
* Remove struct holes.
* Cosmetic changes.

Changes since v17:
* Move include/uapi/linux/landlock.h and _LANDLOCK_ACCESS_FS_* to a
  following patch.

Changes since v16:
* Allow enforcement of empty ruleset, which enables deny-all policies.

Changes since v15:
* Replace layer_levels and layer_depth with a bitfield of layers, cf.
  filesystem commit.
* Rename the LANDLOCK_ACCESS_FS_{UNLINK,RMDIR} with
  LANDLOCK_ACCESS_FS_REMOVE_{FILE,DIR} because it makes sense to use
  them for the action of renaming a file or a directory, which may lead
  to the removal of the source file or directory.  Removes the
  LANDLOCK_ACCESS_FS_{LINK_TO,RENAME_FROM,RENAME_TO} which are now
  replaced with LANDLOCK_ACCESS_FS_REMOVE_{FILE,DIR} and
  LANDLOCK_ACCESS_FS_MAKE_* .
* Update the documentation accordingly and highlight how the access
  rights are taken into account.
* Change nb_rules from atomic_t to u32 because it is not use anymore by
  show_fdinfo().
* Add safeguard for level variables types.
* Check max number of rules.
* Replace struct landlock_access (self and beneath bitfields) with one
  bitfield.
* Remove useless variable.
* Add comments.

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

Previous changes:
https://lore.kernel.org/lkml/20190721213116.23476-7-mic@digikod.net/
---
 security/landlock/Makefile  |   2 +-
 security/landlock/ruleset.c | 355 ++++++++++++++++++++++++++++++++++++
 security/landlock/ruleset.h | 158 ++++++++++++++++
 3 files changed, 514 insertions(+), 1 deletion(-)
 create mode 100644 security/landlock/ruleset.c
 create mode 100644 security/landlock/ruleset.h

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
index 000000000000..9fe92b2f5fbd
--- /dev/null
+++ b/security/landlock/ruleset.c
@@ -0,0 +1,355 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock LSM - Ruleset management
+ *
+ * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2018-2020 ANSSI
+ */
+
+#include <linux/bits.h>
+#include <linux/bug.h>
+#include <linux/compiler_types.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/limits.h>
+#include <linux/lockdep.h>
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
+	struct landlock_ruleset *new_ruleset;
+
+	new_ruleset = kzalloc(sizeof(*new_ruleset), GFP_KERNEL_ACCOUNT);
+	if (!new_ruleset)
+		return ERR_PTR(-ENOMEM);
+	refcount_set(&new_ruleset->usage, 1);
+	mutex_init(&new_ruleset->lock);
+	new_ruleset->root = RB_ROOT;
+	/*
+	 * hierarchy = NULL
+	 * nb_rules = 0
+	 * nb_layers = 0
+	 * fs_access_mask = 0
+	 */
+	return new_ruleset;
+}
+
+struct landlock_ruleset *landlock_create_ruleset(const u32 fs_access_mask)
+{
+	struct landlock_ruleset *new_ruleset;
+
+	/* Informs about useless ruleset. */
+	if (!fs_access_mask)
+		return ERR_PTR(-ENOMSG);
+	new_ruleset = create_ruleset();
+	if (!IS_ERR(new_ruleset))
+		new_ruleset->fs_access_mask = fs_access_mask;
+	return new_ruleset;
+}
+
+static struct landlock_rule *duplicate_rule(struct landlock_rule *const src)
+{
+	struct landlock_rule *new_rule;
+
+	new_rule = kzalloc(sizeof(*new_rule), GFP_KERNEL_ACCOUNT);
+	if (!new_rule)
+		return ERR_PTR(-ENOMEM);
+	RB_CLEAR_NODE(&new_rule->node);
+	landlock_get_object(src->object);
+	new_rule->object = src->object;
+	new_rule->access = src->access;
+	new_rule->layers = src->layers;
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
+/**
+ * landlock_insert_rule - Insert a rule in a ruleset
+ *
+ * @ruleset: The ruleset to be updated.
+ * @rule: Read-only payload to be inserted (not owned by this function).
+ * @is_merge: If true, intersects access rights and updates the rule's layers
+ *            (e.g. merge two rulesets), else do a union of access rights and
+ *            keep the rule's layers (e.g. extend a ruleset)
+ *
+ * Assumptions:
+ *
+ * - An inserted rule cannot be removed.
+ * - The underlying kernel object must be held by the caller.
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
+		struct landlock_rule *const this = rb_entry(*walker_node,
+				struct landlock_rule, node);
+
+		if (this->object != rule->object) {
+			parent_node = *walker_node;
+			if (this->object < rule->object)
+				walker_node = &((*walker_node)->rb_right);
+			else
+				walker_node = &((*walker_node)->rb_left);
+			continue;
+		}
+
+		/* If there is a matching rule, updates it. */
+		if (is_merge) {
+			/* Intersects access rights. */
+			this->access &= rule->access;
+
+			/* Updates the rule layers with the next one. */
+			this->layers |= BIT_ULL(ruleset->nb_layers);
+		} else {
+			/* Extends access rights. */
+			this->access |= rule->access;
+		}
+		return 0;
+	}
+
+	/* There is no match for @rule->object. */
+	if (ruleset->nb_rules == U32_MAX)
+		return -E2BIG;
+	new_rule = duplicate_rule(rule);
+	if (IS_ERR(new_rule))
+		return PTR_ERR(new_rule);
+	if (is_merge)
+		/* Sets the rule layer to the next one. */
+		new_rule->layers = BIT_ULL(ruleset->nb_layers);
+	rb_link_node(&new_rule->node, parent_node, walker_node);
+	rb_insert_color(&new_rule->node, &ruleset->root);
+	ruleset->nb_rules++;
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
+	/*
+	 * The ruleset being modified (@dst) is locked first, then the ruleset
+	 * being copied (@src).
+	 */
+	mutex_lock(&dst->lock);
+	mutex_lock_nested(&src->lock, SINGLE_DEPTH_NESTING);
+	/*
+	 * Makes a new layer, but only increments the number of layers after
+	 * the rules are inserted.
+	 */
+	if (dst->nb_layers == (sizeof(walker_rule->layers) * BITS_PER_BYTE)) {
+		err = -E2BIG;
+		goto out_unlock;
+	}
+	dst->fs_access_mask |= src->fs_access_mask;
+
+	/* Merges the @src tree. */
+	rbtree_postorder_for_each_entry_safe(walker_rule, next_rule,
+			&src->root, node) {
+		err = landlock_insert_rule(dst, walker_rule, true);
+		if (err)
+			goto out_unlock;
+	}
+	dst->nb_layers++;
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
+			GFP_KERNEL_ACCOUNT);
+	if (!new_ruleset->hierarchy) {
+		err = -ENOMEM;
+		goto out_put_ruleset;
+	}
+	refcount_set(&new_ruleset->hierarchy->usage, 1);
+	if (!parent)
+		return new_ruleset;
+
+	mutex_lock(&new_ruleset->lock);
+	mutex_lock_nested(&parent->lock, 1);
+	new_ruleset->nb_layers = parent->nb_layers;
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
+/**
+ * landlock_merge_ruleset - Merge a ruleset with a domain
+ *
+ * @parent: Parent domain.
+ * @ruleset: New ruleset to be merged.
+ *
+ * Returns the intersection of @parent and @ruleset, or returns @parent if
+ * @ruleset is empty, or returns a duplicate of @ruleset if @parent is empty.
+ */
+struct landlock_ruleset *landlock_merge_ruleset(
+		struct landlock_ruleset *const parent,
+		struct landlock_ruleset *const ruleset)
+{
+	struct landlock_ruleset *new_dom;
+	int err;
+
+	might_sleep();
+	/*
+	 * Merging duplicates a ruleset, so a new ruleset cannot be
+	 * the same as the parent, but they can have similar content.
+	 */
+	if (WARN_ON_ONCE(!ruleset || parent == ruleset)) {
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
index 000000000000..2d2c860fbb6e
--- /dev/null
+++ b/security/landlock/ruleset.h
@@ -0,0 +1,158 @@
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
+
+#include "object.h"
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
+	 * @node: Node in the ruleset's red-black tree.
+	 */
+	struct rb_node node;
+	/**
+	 * @object: Pointer to identify a kernel object (e.g. an inode).  This
+	 * is used as a key for this ruleset element.  This pointer is set once
+	 * and never modified.  It always points to an allocated object because
+	 * each rule increments the refcount of its object.
+	 */
+	struct landlock_object *object;
+	/**
+	 * @layers: Bitfield to identify the layers which resulted to @access
+	 * from different consecutive intersections.
+	 */
+	u64 layers;
+	/**
+	 * @access: Bitfield of allowed actions on the kernel object.  They are
+	 * relative to the object type (e.g. %LANDLOCK_ACTION_FS_READ).  This
+	 * may be the result of the merged access rights (boolean AND) from
+	 * multiple layers referring to the same object.
+	 */
+	u32 access;
+};
+
+/**
+ * struct landlock_hierarchy - Node in a ruleset hierarchy
+ */
+struct landlock_hierarchy {
+	/**
+	 * @parent: Pointer to the parent node, or NULL if it is a root
+	 * Landlock domain.
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
+ * This data structure must contain unique entries, be updatable, and quick to
+ * match an object.
+ */
+struct landlock_ruleset {
+	/**
+	 * @root: Root of a red-black tree containing &struct landlock_rule
+	 * nodes.  Once a ruleset is tied to a process (i.e. as a domain), this
+	 * tree is immutable until @usage reaches zero.
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
+		 * The fields @lock, @usage, @nb_layers, @nb_rules and
+		 * @fs_access_mask are then unused.
+		 */
+		struct work_struct work_free;
+		struct {
+			/**
+			 * @lock: Guards against concurrent modifications of
+			 * @root, if @usage is greater than zero.
+			 */
+			struct mutex lock;
+			/**
+			 * @usage: Number of processes (i.e. domains) or file
+			 * descriptors referencing this ruleset.
+			 */
+			refcount_t usage;
+			/**
+			 * @nb_rules: Number of non-overlapping (i.e. not for
+			 * the same object) rules in this ruleset.
+			 */
+			u32 nb_rules;
+			/**
+			 * @nb_layers: Number of layers which are used in this
+			 * ruleset.  This enables to check that all the layers
+			 * allow an access request.  A value of 0 identifies a
+			 * non-merged ruleset (i.e. not a domain).
+			 */
+			u32 nb_layers;
+			/**
+			 * @fs_access_mask: Contains the subset of filesystem
+			 * actions which are restricted by a ruleset.  This is
+			 * used when merging rulesets and for user space
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
2.28.0

