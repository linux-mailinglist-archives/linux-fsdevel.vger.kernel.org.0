Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A272616AC96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 18:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbgBXRDI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 12:03:08 -0500
Received: from smtp-sh2.infomaniak.ch ([128.65.195.6]:51329 "EHLO
        smtp-sh2.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgBXRDH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:03:07 -0500
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
        by smtp-sh2.infomaniak.ch (8.14.4/8.14.4/Debian-8+deb8u2) with ESMTP id 01OG2O4L042016
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 24 Feb 2020 17:02:24 +0100
Received: from localhost (unknown [94.23.54.103])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 48R6Jw04gPzljlp7;
        Mon, 24 Feb 2020 17:02:24 +0100 (CET)
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
Subject: [RFC PATCH v14 01/10] landlock: Add object and rule management
Date:   Mon, 24 Feb 2020 17:02:06 +0100
Message-Id: <20200224160215.4136-2-mic@digikod.net>
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

A Landlock object enables to identify a kernel object (e.g. an inode).
A Landlock rule is a set of access rights allowed on an object.  Rules
are grouped in rulesets that may be tied to a set of processes (i.e.
subjects) to enforce a scoped access-control (i.e. a domain).

Because Landlock's goal is to empower any process (especially
unprivileged ones) to sandbox themselves, we can't rely on a system-wide
object identification such as file extended attributes.  Indeed, we need
innocuous, composable and modular access-controls.

The main challenge with this constraints is to identify kernel objects
while this identification is useful (i.e. when a security policy makes
use of this object).  But this identification data should be freed once
no policy is using it.  This ephemeral tagging should not and may not be
written in the filesystem.  We then need to manage the lifetime of a
rule according to the lifetime of its object.  To avoid a global lock,
this implementation make use of RCU and counters to safely reference
objects.

A following commit uses this generic object management for inodes.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
---

Changes since v13:
* New dedicated implementation, removing the need for eBPF.

Previous version:
https://lore.kernel.org/lkml/20190721213116.23476-6-mic@digikod.net/
---
 MAINTAINERS                |  10 ++
 security/Kconfig           |   1 +
 security/Makefile          |   2 +
 security/landlock/Kconfig  |  15 ++
 security/landlock/Makefile |   3 +
 security/landlock/object.c | 339 +++++++++++++++++++++++++++++++++++++
 security/landlock/object.h | 134 +++++++++++++++
 7 files changed, 504 insertions(+)
 create mode 100644 security/landlock/Kconfig
 create mode 100644 security/landlock/Makefile
 create mode 100644 security/landlock/object.c
 create mode 100644 security/landlock/object.h

diff --git a/MAINTAINERS b/MAINTAINERS
index fcd79fc38928..206f85768cd9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9360,6 +9360,16 @@ F:	net/core/skmsg.c
 F:	net/core/sock_map.c
 F:	net/ipv4/tcp_bpf.c
 
+LANDLOCK SECURITY MODULE
+M:	Mickaël Salaün <mic@digikod.net>
+L:	linux-security-module@vger.kernel.org
+W:	https://landlock.io
+T:	git https://github.com/landlock-lsm/linux.git
+S:	Supported
+F:	security/landlock/
+K:	landlock
+K:	LANDLOCK
+
 LANTIQ / INTEL Ethernet drivers
 M:	Hauke Mehrtens <hauke@hauke-m.de>
 L:	netdev@vger.kernel.org
diff --git a/security/Kconfig b/security/Kconfig
index 2a1a2d396228..9d9981394fb0 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -238,6 +238,7 @@ source "security/loadpin/Kconfig"
 source "security/yama/Kconfig"
 source "security/safesetid/Kconfig"
 source "security/lockdown/Kconfig"
+source "security/landlock/Kconfig"
 
 source "security/integrity/Kconfig"
 
diff --git a/security/Makefile b/security/Makefile
index 746438499029..2472ef96d40a 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -12,6 +12,7 @@ subdir-$(CONFIG_SECURITY_YAMA)		+= yama
 subdir-$(CONFIG_SECURITY_LOADPIN)	+= loadpin
 subdir-$(CONFIG_SECURITY_SAFESETID)    += safesetid
 subdir-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown
+subdir-$(CONFIG_SECURITY_LANDLOCK)		+= landlock
 
 # always enable default capabilities
 obj-y					+= commoncap.o
@@ -29,6 +30,7 @@ obj-$(CONFIG_SECURITY_YAMA)		+= yama/
 obj-$(CONFIG_SECURITY_LOADPIN)		+= loadpin/
 obj-$(CONFIG_SECURITY_SAFESETID)       += safesetid/
 obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
+obj-$(CONFIG_SECURITY_LANDLOCK)	+= landlock/
 obj-$(CONFIG_CGROUP_DEVICE)		+= device_cgroup.o
 
 # Object integrity file lists
diff --git a/security/landlock/Kconfig b/security/landlock/Kconfig
new file mode 100644
index 000000000000..4a321d5b3f67
--- /dev/null
+++ b/security/landlock/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config SECURITY_LANDLOCK
+	bool "Landlock support"
+	depends on SECURITY
+	default n
+	help
+	  This selects Landlock, a safe sandboxing mechanism.  It enables to
+	  restrict processes on the fly (i.e. enforce an access control policy),
+	  which can complement seccomp-bpf.  The security policy is a set of access
+	  rights tied to an object, which could be a file, a socket or a process.
+
+	  See Documentation/security/landlock/ for further information.
+
+	  If you are unsure how to answer this question, answer N.
diff --git a/security/landlock/Makefile b/security/landlock/Makefile
new file mode 100644
index 000000000000..cb6deefbf4c0
--- /dev/null
+++ b/security/landlock/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_SECURITY_LANDLOCK) := landlock.o
+
+landlock-y := object.o
diff --git a/security/landlock/object.c b/security/landlock/object.c
new file mode 100644
index 000000000000..38fbbb108120
--- /dev/null
+++ b/security/landlock/object.c
@@ -0,0 +1,339 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock LSM - Object and rule management
+ *
+ * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2018-2020 ANSSI
+ *
+ * Principles and constraints of the object and rule management:
+ * - Do not leak memory.
+ * - Try as much as possible to free a memory allocation as soon as it is
+ *   unused.
+ * - Do not use global lock.
+ * - Do not charge processes other than the one requesting a Landlock
+ *   operation.
+ */
+
+#include <linux/bug.h>
+#include <linux/compiler.h>
+#include <linux/compiler_types.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
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
+
+struct landlock_object *landlock_create_object(
+		const enum landlock_object_type type, void *underlying_object)
+{
+	struct landlock_object *object;
+
+	if (WARN_ON_ONCE(!underlying_object))
+		return NULL;
+	object = kzalloc(sizeof(*object), GFP_KERNEL);
+	if (!object)
+		return NULL;
+	refcount_set(&object->usage, 1);
+	refcount_set(&object->cleaners, 1);
+	spin_lock_init(&object->lock);
+	INIT_LIST_HEAD(&object->rules);
+	object->type = type;
+	WRITE_ONCE(object->underlying_object, underlying_object);
+	return object;
+}
+
+struct landlock_object *landlock_get_object(struct landlock_object *object)
+	__acquires(object->usage)
+{
+	__acquire(object->usage);
+	/*
+	 * If @object->usage equal 0, then it will be ignored by writers, and
+	 * underlying_object->object may be replaced, but this is not an issue
+	 * for release_object().
+	 */
+	if (object && refcount_inc_not_zero(&object->usage)) {
+		/*
+		 * It should not be possible to get a reference to an object if
+		 * its underlying object is being terminated (e.g. with
+		 * landlock_release_object()), because an object is only
+		 * modifiable through such underlying object.  This is not the
+		 * case with landlock_get_object_cleaner().
+		 */
+		WARN_ON_ONCE(!READ_ONCE(object->underlying_object));
+		return object;
+	}
+	return NULL;
+}
+
+static struct landlock_object *get_object_cleaner(
+		struct landlock_object *object)
+	__acquires(object->cleaners)
+{
+	__acquire(object->cleaners);
+	if (object && refcount_inc_not_zero(&object->cleaners))
+		return object;
+	return NULL;
+}
+
+/*
+ * There is two cases when an object should be free and the reference to the
+ * underlying object should be put:
+ * - when the last rule tied to this object is removed, which is handled by
+ *   landlock_put_rule() and then release_object();
+ * - when the object is being terminated (e.g. no more reference to an inode),
+ *   which is handled by landlock_put_object().
+ */
+static void put_object_free(struct landlock_object *object)
+	__releases(object->cleaners)
+{
+	__release(object->cleaners);
+	if (!refcount_dec_and_test(&object->cleaners))
+		return;
+	WARN_ON_ONCE(refcount_read(&object->usage));
+	/*
+	 * Ensures a safe use of @object in the RCU block from
+	 * landlock_put_rule().
+	 */
+	kfree_rcu(object, rcu_free);
+}
+
+/*
+ * Destroys a newly created and useless object.
+ */
+void landlock_drop_object(struct landlock_object *object)
+{
+	if (WARN_ON_ONCE(!refcount_dec_and_test(&object->usage)))
+		return;
+	__acquire(object->cleaners);
+	put_object_free(object);
+}
+
+/*
+ * Puts the underlying object (e.g. inode) if it is the first request to
+ * release @object, without calling landlock_put_object().
+ *
+ * Return true if this call effectively marks @object as released, false
+ * otherwise.
+ */
+static bool release_object(struct landlock_object *object)
+	__releases(&object->lock)
+{
+	void *underlying_object;
+
+	lockdep_assert_held(&object->lock);
+
+	underlying_object = xchg(&object->underlying_object, NULL);
+	spin_unlock(&object->lock);
+	might_sleep();
+	if (!underlying_object)
+		return false;
+
+	switch (object->type) {
+	case LANDLOCK_OBJECT_INODE:
+		break;
+	default:
+		WARN_ON_ONCE(1);
+	}
+	return true;
+}
+
+static void put_object_cleaner(struct landlock_object *object)
+	__releases(object->cleaners)
+{
+	/* Let's try an early lockless check. */
+	if (list_empty(&object->rules) &&
+			READ_ONCE(object->underlying_object)) {
+		/*
+		 * Puts @object if there is no rule tied to it and the
+		 * remaining user is the underlying object.  This check is
+		 * atomic because @object->rules and @object->underlying_object
+		 * are protected by @object->lock.
+		 */
+		spin_lock(&object->lock);
+		if (list_empty(&object->rules) &&
+				READ_ONCE(object->underlying_object) &&
+				refcount_dec_if_one(&object->usage)) {
+			/*
+			 * Releases @object, in place of
+			 * landlock_release_object().
+			 *
+			 * @object is already empty, implying that all its
+			 * previous rules are already disabled.
+			 *
+			 * Unbalance the @object->cleaners counter to reflect
+			 * the underlying object release.
+			 */
+			if (!WARN_ON_ONCE(!release_object(object))) {
+				__acquire(object->cleaners);
+				put_object_free(object);
+			}
+		} else {
+			spin_unlock(&object->lock);
+		}
+	}
+	put_object_free(object);
+}
+
+/*
+ * Putting an object is easy when the object is being terminated, but it is
+ * much more tricky when the reason is that there is no more rule tied to this
+ * object.  Indeed, new rules could be added at the same time.
+ */
+void landlock_put_object(struct landlock_object *object)
+	__releases(object->usage)
+{
+	struct landlock_object *object_cleaner;
+
+	__release(object->usage);
+	might_sleep();
+	if (!object)
+		return;
+	/*
+	 * Guards against concurrent termination to be able to terminate
+	 * @object if it is empty and not referenced by another rule-appender
+	 * other than the underlying object.
+	 */
+	object_cleaner = get_object_cleaner(object);
+	if (WARN_ON_ONCE(!object_cleaner)) {
+		__release(object->cleaners);
+		return;
+	}
+	/*
+	 * Decrements @object->usage and if it reach zero, also decrement
+	 * @object->cleaners.  If both reach zero, then release and free
+	 * @object.
+	 */
+	if (refcount_dec_and_test(&object->usage)) {
+		struct landlock_rule *rule_walker, *rule_walker2;
+
+		spin_lock(&object->lock);
+		/*
+		 * Disables all the rules tied to @object when it is forbidden
+		 * to add new rule but still allowed to remove them with
+		 * landlock_put_rule().  This is crucial to be able to safely
+		 * free a rule according to landlock_rule_is_disabled().
+		 */
+		list_for_each_entry_safe(rule_walker, rule_walker2,
+				&object->rules, list)
+			list_del_rcu(&rule_walker->list);
+
+		/*
+		 * Releases @object if it is not already released (e.g. with
+		 * landlock_release_object()).
+		 */
+		release_object(object);
+		/*
+		 * Unbalances the @object->cleaners counter to reflect the
+		 * underlying object release.
+		 */
+		__acquire(object->cleaners);
+		put_object_free(object);
+	}
+	put_object_cleaner(object_cleaner);
+}
+
+void landlock_put_rule(struct landlock_object *object,
+		struct landlock_rule *rule)
+{
+	if (!rule)
+		return;
+	WARN_ON_ONCE(!object);
+	/*
+	 * Guards against a concurrent @object self-destruction with
+	 * landlock_put_object() or put_object_cleaner().
+	 */
+	rcu_read_lock();
+	if (landlock_rule_is_disabled(rule)) {
+		rcu_read_unlock();
+		if (refcount_dec_and_test(&rule->usage))
+			kfree_rcu(rule, rcu_free);
+		return;
+	}
+	if (refcount_dec_and_test(&rule->usage)) {
+		struct landlock_object *safe_object;
+
+		/*
+		 * Now, @rule may still be enabled, or in the process of being
+		 * untied to @object by put_object_cleaner().  However, we know
+		 * that @object will not be freed until rcu_read_unlock() and
+		 * until @object->cleaners reach zero.  Furthermore, we may not
+		 * be the only one willing to free a @rule linked with @object.
+		 * If we succeed to hold @object with get_object_cleaner(), we
+		 * know that until put_object_cleaner(), we can safely use
+		 * @object to remove @rule.
+		 */
+		safe_object = get_object_cleaner(object);
+		rcu_read_unlock();
+		if (!safe_object) {
+			__release(safe_object->cleaners);
+			/*
+			 * We can safely free @rule because it is already
+			 * removed from @object's list.
+			 */
+			WARN_ON_ONCE(!landlock_rule_is_disabled(rule));
+			kfree_rcu(rule, rcu_free);
+		} else {
+			spin_lock(&safe_object->lock);
+			if (!landlock_rule_is_disabled(rule))
+				list_del(&rule->list);
+			spin_unlock(&safe_object->lock);
+			kfree_rcu(rule, rcu_free);
+			put_object_cleaner(safe_object);
+		}
+	} else {
+		rcu_read_unlock();
+	}
+	/*
+	 * put_object_cleaner() might sleep, but it is only reachable if
+	 * !landlock_rule_is_disabled().  Therefore, clean_ref() can not sleep.
+	 */
+	might_sleep();
+}
+
+void landlock_release_object(struct landlock_object __rcu *rcu_object)
+{
+	struct landlock_object *object;
+
+	if (!rcu_object)
+		return;
+	rcu_read_lock();
+	object = get_object_cleaner(rcu_dereference(rcu_object));
+	rcu_read_unlock();
+	if (unlikely(!object)) {
+		__release(object->cleaners);
+		return;
+	}
+	/*
+	 * Makes sure that the underlying object never point to a freed object
+	 * by firstly releasing the object (i.e. NULL the reference to it) to
+	 * be sure no one could get a new reference to it while it is being
+	 * terminated.  Secondly, put the object globally (e.g. for the
+	 * super-block).
+	 *
+	 * This can run concurrently with put_object_cleaner(), which may try
+	 * to release @object as well.
+	 */
+	spin_lock(&object->lock);
+	if (release_object(object)) {
+		/*
+		 * Unbalances the object to reflect the underlying object
+		 * release.
+		 */
+		__acquire(object->usage);
+		landlock_put_object(object);
+	}
+	/*
+	 * If a concurrent thread is adding a new rule, the object will be free
+	 * at the end of this rule addition, otherwise it will be free with the
+	 * following put_object_cleaner() or a remaining one.
+	 */
+	put_object_cleaner(object);
+}
diff --git a/security/landlock/object.h b/security/landlock/object.h
new file mode 100644
index 000000000000..15dfc9a75a82
--- /dev/null
+++ b/security/landlock/object.h
@@ -0,0 +1,134 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock LSM - Object and rule management
+ *
+ * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2018-2020 ANSSI
+ */
+
+#ifndef _SECURITY_LANDLOCK_OBJECT_H
+#define _SECURITY_LANDLOCK_OBJECT_H
+
+#include <linux/compiler_types.h>
+#include <linux/list.h>
+#include <linux/poison.h>
+#include <linux/rcupdate.h>
+#include <linux/refcount.h>
+#include <linux/spinlock.h>
+
+struct landlock_access {
+	/*
+	 * @self: Bitfield of allowed actions on the kernel object.  They are
+	 * relative to the object type (e.g. LANDLOCK_ACTION_FS_READ).
+	 */
+	u32 self;
+	/*
+	 * @beneath: Same as @self, but for the child objects (e.g. a file in a
+	 * directory).
+	 */
+	u32 beneath;
+};
+
+struct landlock_rule {
+	struct landlock_access access;
+	/*
+	 * @list: Linked list with other rules tied to the same object, which
+	 * enable to manage their lifetimes.  This is also used to identify if
+	 * a rule is still valid, thanks to landlock_rule_is_disabled(), which
+	 * is important in the matching process because the original object
+	 * address might have been recycled.
+	 */
+	struct list_head list;
+	union {
+		/*
+		 * @usage: Number of rulesets pointing to this rule.  This
+		 * field is never used by RCU readers.
+		 */
+		refcount_t usage;
+		struct rcu_head rcu_free;
+	};
+};
+
+enum landlock_object_type {
+	LANDLOCK_OBJECT_INODE = 1,
+};
+
+struct landlock_object {
+	/*
+	 * @usage: Main usage counter, used to tie an object to it's underlying
+	 * object (i.e. create a lifetime) and potentially add new rules.
+	 */
+	refcount_t usage;
+	/*
+	 * @cleaners: Usage counter used to free a rule from @rules (thanks to
+	 * put_rule()).  Enables to get a reference to this object until it
+	 * really become freed.  Cf. put_object().
+	 */
+	refcount_t cleaners;
+	union {
+		/*
+		 * The use of this struct is controlled by @usage and
+		 * @cleaners, which makes it safe to union it with @rcu_free.
+		 */
+		struct {
+			/*
+			 * @underlying_object: Used when cleaning up an object
+			 * and to mark an object as tied to its underlying
+			 * kernel structure.  It must then be atomically read
+			 * using READ_ONCE().
+			 *
+			 * The one who clear @underlying_object must:
+			 * 1. clear the object self-reference and
+			 * 2. decrement @usage (and potentially free the
+			 *    object).
+			 *
+			 * Cf. clean_object().
+			 */
+			void *underlying_object;
+			/*
+			 * @type: Only used when cleaning up an object.
+			 */
+			enum landlock_object_type type;
+			spinlock_t lock;
+			/*
+			 * @rules: List of struct landlock_rule linked with
+			 * their "list" field.  This list is only accessed when
+			 * updating the list (to be able to clean up later)
+			 * while holding @lock.
+			 */
+			struct list_head rules;
+		};
+		struct rcu_head rcu_free;
+	};
+};
+
+void landlock_put_rule(struct landlock_object *object,
+		struct landlock_rule *rule);
+
+void landlock_release_object(struct landlock_object __rcu *rcu_object);
+
+struct landlock_object *landlock_create_object(
+		const enum landlock_object_type type, void *underlying_object);
+
+struct landlock_object *landlock_get_object(struct landlock_object *object)
+	__acquires(object->usage);
+
+void landlock_put_object(struct landlock_object *object)
+	__releases(object->usage);
+
+void landlock_drop_object(struct landlock_object *object);
+
+static inline bool landlock_rule_is_disabled(
+		struct landlock_rule *rule)
+{
+	/*
+	 * Disabling (i.e. unlinking) a landlock_rule is a one-way operation.
+	 * It is not possible to re-enable such a rule, then there is no need
+	 * for smp_load_acquire().
+	 *
+	 * LIST_POISON2 is set by list_del() and list_del_rcu().
+	 */
+	return !rule || READ_ONCE(rule->list.prev) == LIST_POISON2;
+}
+
+#endif /* _SECURITY_LANDLOCK_OBJECT_H */
-- 
2.25.0

