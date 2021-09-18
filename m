Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E30B4103EA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Sep 2021 07:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242385AbhIRFGp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Sep 2021 01:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238582AbhIRFGf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Sep 2021 01:06:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB87C061574;
        Fri, 17 Sep 2021 22:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=JPiPQLfbh0zvgSweOGGWu9LHmTLKw+6joIwG+XJiktQ=; b=Dl39X2CltgzrunxpQcnNoLMxo2
        yL4KkYWiiV1BOk10H3QjCsRBM7yEIsJ+oN2pv4v048sGKpvBaNnSOgq8opLqSHnQWt4bgNqQpptfk
        c2aF7STQXnHcvnPKP5raG9MGs7CPMqKvEszUM2aqZE20bsLTq5Xlqff4CfhpUGfD2dNfHHKz8phO4
        2gk3BvKPkXM8CWCPbQZIU0atDoaR1oyt1nlV/bESdriPo2xDbk5a5aDruse48XiS0SuuRVvcy7QBI
        f9haE9y0wl8aDIcah6VjZ9EkbwMFKiPSsZyTdyp5WVh0uaq181JQSQFy67iWp47YnevX69E826+VA
        pEna2zlQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRSWf-00FP4c-9u; Sat, 18 Sep 2021 05:04:33 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org
Cc:     rdunlap@infradead.org, rafael@kernel.org, masahiroy@kernel.org,
        ndesaulniers@google.com, yzaikin@google.com, nathan@kernel.org,
        ojeda@kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
        vitor@massaru.org, elver@google.com, jarkko@kernel.org,
        glider@google.com, rf@opensource.cirrus.com,
        stephen@networkplumber.org, David.Laight@ACULAB.COM,
        bvanassche@acm.org, jolsa@kernel.org,
        andriy.shevchenko@linux.intel.com, trishalfonso@google.com,
        andreyknvl@gmail.com, jikos@kernel.org, mbenes@suse.com,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        mcgrof@kernel.org, reinette.chatre@intel.com, fenghua.yu@intel.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        daniel.vetter@ffwll.ch, bhelgaas@google.com, kw@linux.com,
        dan.j.williams@intel.com, senozhatsky@chromium.org, hch@lst.de,
        joe@perches.com, hkallweit1@gmail.com, axboe@kernel.dk,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, peterz@infradead.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, copyleft-next@lists.fedorahosted.org
Subject: [PATCH v7 09/12] sysfs: fix deadlock race with module removal
Date:   Fri, 17 Sep 2021 22:04:27 -0700
Message-Id: <20210918050430.3671227-10-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210918050430.3671227-1-mcgrof@kernel.org>
References: <20210918050430.3671227-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When sysfs attributes use a lock also used on module removal we can
race to deadlock. This happens when for instance a sysfs file on
a driver is used, then at the same time we have module removal call
trigger. The module removal call code holds a lock, and then the sysfs
file entry waits for the same lock. While holding the lock the module
removal tries to remove the sysfs entries, but these cannot be removed
yet as one is waiting for a lock. This won't complete as the lock is
already held. Likewise module removal cannot complete, and so we deadlock.

This can now be easily reproducible with our sysfs selftest as follows:

./tools/testing/selftests/sysfs/sysfs.sh -t 0027

To fix this we extend the struct kernfs_node with a module reference and
use the try_module_get() after kernfs_get_active() is called which
protects integrity and the existence of the kernfs node during the
operation.

So long as the kernfs node is protected with kernfs_get_active() we know
we can rely on its contents. And, as now just documented in the previous
patch, we also now know that once kernfs_get_active() is called the module
is also guarded to exist and cannot be removed.

If try_module_get() fails we fail the operation on the kernfs node.

We use a try method as a full lock means we'd then make our sysfs
attributes busy us out from possible module removal, and so userspace
could force denying module removal, a silly form of "DOS" against module
removal. A try lock on the module removal ensures we give priority to
module removal and interacting with sysfs attributes only comes second.
Using a full lock could mean for instance that if you don't stop poking
at sysfs files you cannot remove a module.

Races between removal of sysfs files and the module are not possible
given sysfs files are created by the same module, and when a sysfs file
is being used kernfs prevents removal of the sysfs file. So if module
removal is actually happening the removal would have to wait until
the sysfs file operation is complete.

This deadlock was first reported with the zram driver, however the live
patching folks have acknowledged they have observed this as well with
live patching, when a live patch is removed. I was then able to
reproduce easily by creating a dedicated selftests.

A sketch of how this can happen follows:

CPU A                              CPU B
                                   whatever_store()
module_unload
  mutex_lock(foo)
                                   mutex_lock(foo)
   del_gendisk(zram->disk);
     device_del()
       device_remove_groups()

In this situation whatever_store() is waiting for the mutex foo to
become unlocked, but that won't happen until module removal is complete.
But module removal won't complete until the sysfs file being poked
completes which is waiting for a lock already held.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  4 +-
 fs/kernfs/dir.c                        | 41 ++++++++++++++++++--
 fs/kernfs/file.c                       |  7 +++-
 fs/kernfs/kernfs-internal.h            |  1 +
 fs/kernfs/symlink.c                    |  3 +-
 fs/sysfs/dir.c                         |  4 +-
 fs/sysfs/file.c                        | 10 +++--
 fs/sysfs/group.c                       |  1 +
 include/linux/kernfs.h                 | 11 ++++--
 include/linux/sysfs.h                  | 52 ++++++++++++++++++++------
 kernel/cgroup/cgroup.c                 |  2 +-
 11 files changed, 106 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index b57b3db9a6a7..d40c486f46b9 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -207,7 +207,7 @@ static int rdtgroup_add_file(struct kernfs_node *parent_kn, struct rftype *rft)
 	struct kernfs_node *kn;
 	int ret;
 
-	kn = __kernfs_create_file(parent_kn, rft->name, rft->mode,
+	kn = __kernfs_create_file(parent_kn, rft->name, rft->mode, NULL,
 				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
 				  0, rft->kf_ops, rft, NULL, NULL);
 	if (IS_ERR(kn))
@@ -2480,7 +2480,7 @@ static int mon_addfile(struct kernfs_node *parent_kn, const char *name,
 	struct kernfs_node *kn;
 	int ret = 0;
 
-	kn = __kernfs_create_file(parent_kn, name, 0444,
+	kn = __kernfs_create_file(parent_kn, name, 0444, NULL,
 				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, 0,
 				  &kf_mondata_ops, priv, NULL, NULL);
 	if (IS_ERR(kn))
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index ba581429bf7b..f463878a5bf4 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/security.h>
 #include <linux/hash.h>
+#include <linux/module.h>
 
 #include "kernfs-internal.h"
 
@@ -414,12 +415,32 @@ static bool kernfs_unlink_sibling(struct kernfs_node *kn)
  */
 struct kernfs_node *kernfs_get_active(struct kernfs_node *kn)
 {
+	int v;
+
 	if (unlikely(!kn))
 		return NULL;
 
 	if (!atomic_inc_unless_negative(&kn->active))
 		return NULL;
 
+	/*
+	 * If a module created the kernfs_node, the module cannot possibly be
+	 * removed if the above atomic_inc_unless_negative() succeeded. So the
+	 * try_module_get() below is not to protect the lifetime of the module
+	 * as that is already guaranteed. The try_module_get() below is used
+	 * to ensure that we don't deadlock in case a kernfs operation and
+	 * module removal used a shared lock.
+	 *
+	 * We use a try method to avoid userspace DOS'ing module removal with
+	 * access to kernfs ops.
+	 */
+	if (!try_module_get(kn->owner)) {
+		v = atomic_dec_return(&kn->active);
+		if (unlikely(v == KN_DEACTIVATED_BIAS))
+			wake_up_all(&kernfs_root(kn)->deactivate_waitq);
+		return NULL;
+	}
+
 	if (kernfs_lockdep(kn))
 		rwsem_acquire_read(&kn->dep_map, 0, 1, _RET_IP_);
 	return kn;
@@ -442,6 +463,13 @@ void kernfs_put_active(struct kernfs_node *kn)
 	if (kernfs_lockdep(kn))
 		rwsem_release(&kn->dep_map, _RET_IP_);
 	v = atomic_dec_return(&kn->active);
+
+	/*
+	 * We prevent module exit *until* we know for sure all possible
+	 * kernfs ops are done.
+	 */
+	module_put(kn->owner);
+
 	if (likely(v != KN_DEACTIVATED_BIAS))
 		return;
 
@@ -571,6 +599,7 @@ struct kernfs_node *kernfs_node_from_dentry(struct dentry *dentry)
 static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 					     struct kernfs_node *parent,
 					     const char *name, umode_t mode,
+					     struct module *owner,
 					     kuid_t uid, kgid_t gid,
 					     unsigned flags)
 {
@@ -606,6 +635,7 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 
 	kn->name = name;
 	kn->mode = mode;
+	kn->owner = owner;
 	kn->flags = flags;
 
 	if (!uid_eq(uid, GLOBAL_ROOT_UID) || !gid_eq(gid, GLOBAL_ROOT_GID)) {
@@ -639,13 +669,14 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 
 struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
 				    const char *name, umode_t mode,
+				    struct module *owner,
 				    kuid_t uid, kgid_t gid,
 				    unsigned flags)
 {
 	struct kernfs_node *kn;
 
 	kn = __kernfs_new_node(kernfs_root(parent), parent,
-			       name, mode, uid, gid, flags);
+			       name, mode, owner, uid, gid, flags);
 	if (kn) {
 		kernfs_get(parent);
 		kn->parent = parent;
@@ -926,7 +957,7 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 		root->id_highbits = 1;
 
 	kn = __kernfs_new_node(root, NULL, "", S_IFDIR | S_IRUGO | S_IXUGO,
-			       GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
+			       NULL, GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
 			       KERNFS_DIR);
 	if (!kn) {
 		idr_destroy(&root->ino_idr);
@@ -965,6 +996,7 @@ void kernfs_destroy_root(struct kernfs_root *root)
  * @parent: parent in which to create a new directory
  * @name: name of the new directory
  * @mode: mode of the new directory
+ * @owner: if set, the module owner of this directory
  * @uid: uid of the new directory
  * @gid: gid of the new directory
  * @priv: opaque data associated with the new directory
@@ -974,6 +1006,7 @@ void kernfs_destroy_root(struct kernfs_root *root)
  */
 struct kernfs_node *kernfs_create_dir_ns(struct kernfs_node *parent,
 					 const char *name, umode_t mode,
+					 struct module *owner,
 					 kuid_t uid, kgid_t gid,
 					 void *priv, const void *ns)
 {
@@ -982,7 +1015,7 @@ struct kernfs_node *kernfs_create_dir_ns(struct kernfs_node *parent,
 
 	/* allocate */
 	kn = kernfs_new_node(parent, name, mode | S_IFDIR,
-			     uid, gid, KERNFS_DIR);
+			     owner, uid, gid, KERNFS_DIR);
 	if (!kn)
 		return ERR_PTR(-ENOMEM);
 
@@ -1014,7 +1047,7 @@ struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
 
 	/* allocate */
 	kn = kernfs_new_node(parent, name, S_IRUGO|S_IXUGO|S_IFDIR,
-			     GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, KERNFS_DIR);
+			     NULL, GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, KERNFS_DIR);
 	if (!kn)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 4479c6580333..73be39ddc856 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -974,6 +974,7 @@ const struct file_operations kernfs_file_fops = {
  * @uid: uid of the file
  * @gid: gid of the file
  * @size: size of the file
+ * @owner: if set, the module owner of the file
  * @ops: kernfs operations for the file
  * @priv: private data for the file
  * @ns: optional namespace tag of the file
@@ -983,7 +984,9 @@ const struct file_operations kernfs_file_fops = {
  */
 struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
 					 const char *name,
-					 umode_t mode, kuid_t uid, kgid_t gid,
+					 umode_t mode,
+					 struct module *owner,
+					 kuid_t uid, kgid_t gid,
 					 loff_t size,
 					 const struct kernfs_ops *ops,
 					 void *priv, const void *ns,
@@ -996,7 +999,7 @@ struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
 	flags = KERNFS_FILE;
 
 	kn = kernfs_new_node(parent, name, (mode & S_IALLUGO) | S_IFREG,
-			     uid, gid, flags);
+			     owner, uid, gid, flags);
 	if (!kn)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 9e3abf597e2d..3551f62f1449 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -133,6 +133,7 @@ void kernfs_put_active(struct kernfs_node *kn);
 int kernfs_add_one(struct kernfs_node *kn);
 struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
 				    const char *name, umode_t mode,
+				    struct module *owner,
 				    kuid_t uid, kgid_t gid,
 				    unsigned flags);
 
diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
index 19a6c71c6ff5..1d781970bec7 100644
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -36,7 +36,8 @@ struct kernfs_node *kernfs_create_link(struct kernfs_node *parent,
 		gid = target->iattr->ia_gid;
 	}
 
-	kn = kernfs_new_node(parent, name, S_IFLNK|0777, uid, gid, KERNFS_LINK);
+	kn = kernfs_new_node(parent, name, S_IFLNK|0777, target->owner, uid,
+			     gid, KERNFS_LINK);
 	if (!kn)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
index b6b6796e1616..01a0a53ee18e 100644
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -56,8 +56,8 @@ int sysfs_create_dir_ns(struct kobject *kobj, const void *ns)
 
 	kobject_get_ownership(kobj, &uid, &gid);
 
-	kn = kernfs_create_dir_ns(parent, kobject_name(kobj), 0755, uid, gid,
-				  kobj, ns);
+	kn = kernfs_create_dir_ns(parent, kobject_name(kobj), 0755, NULL, uid,
+				  gid, kobj, ns);
 	if (IS_ERR(kn)) {
 		if (PTR_ERR(kn) == -EEXIST)
 			sysfs_warn_dup(parent, kobject_name(kobj));
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 42dcf96881b6..5edc6e180a97 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -291,8 +291,9 @@ int sysfs_add_file_mode_ns(struct kernfs_node *parent,
 		key = attr->key ?: (struct lock_class_key *)&attr->skey;
 #endif
 
-	kn = __kernfs_create_file(parent, attr->name, mode & 0777, uid, gid,
-				  PAGE_SIZE, ops, (void *)attr, ns, key);
+	kn = __kernfs_create_file(parent, attr->name, mode & 0777, attr->owner,
+				  uid, gid, PAGE_SIZE, ops, (void *)attr, ns,
+				  key);
 	if (IS_ERR(kn)) {
 		if (PTR_ERR(kn) == -EEXIST)
 			sysfs_warn_dup(parent, attr->name);
@@ -326,8 +327,9 @@ int sysfs_add_bin_file_mode_ns(struct kernfs_node *parent,
 		key = attr->key ?: (struct lock_class_key *)&attr->skey;
 #endif
 
-	kn = __kernfs_create_file(parent, attr->name, mode & 0777, uid, gid,
-				  battr->size, ops, (void *)attr, ns, key);
+	kn = __kernfs_create_file(parent, attr->name, mode & 0777, attr->owner,
+				  uid, gid, battr->size, ops, (void *)attr, ns,
+				  key);
 	if (IS_ERR(kn)) {
 		if (PTR_ERR(kn) == -EEXIST)
 			sysfs_warn_dup(parent, attr->name);
diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index eeb0e3099421..283607c22eef 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -135,6 +135,7 @@ static int internal_create_group(struct kobject *kobj, int update,
 		} else {
 			kn = kernfs_create_dir_ns(kobj->sd, grp->name,
 						  S_IRWXU | S_IRUGO | S_IXUGO,
+						  grp->owner,
 						  uid, gid, kobj, NULL);
 			if (IS_ERR(kn)) {
 				if (PTR_ERR(kn) == -EEXIST)
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index cd968ee2b503..8655abd53c85 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -160,6 +160,7 @@ struct kernfs_node {
 
 	unsigned short		flags;
 	umode_t			mode;
+	struct module           *owner;
 	struct kernfs_iattrs	*iattr;
 };
 
@@ -369,12 +370,14 @@ void kernfs_destroy_root(struct kernfs_root *root);
 
 struct kernfs_node *kernfs_create_dir_ns(struct kernfs_node *parent,
 					 const char *name, umode_t mode,
+					 struct module *owner,
 					 kuid_t uid, kgid_t gid,
 					 void *priv, const void *ns);
 struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
 					    const char *name);
 struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
 					 const char *name, umode_t mode,
+					 struct module *owner,
 					 kuid_t uid, kgid_t gid,
 					 loff_t size,
 					 const struct kernfs_ops *ops,
@@ -471,13 +474,15 @@ static inline void kernfs_destroy_root(struct kernfs_root *root) { }
 
 static inline struct kernfs_node *
 kernfs_create_dir_ns(struct kernfs_node *parent, const char *name,
-		     umode_t mode, kuid_t uid, kgid_t gid,
+		     umode_t mode, struct module *owner,
+		     kuid_t uid, kgid_t gid,
 		     void *priv, const void *ns)
 { return ERR_PTR(-ENOSYS); }
 
 static inline struct kernfs_node *
 __kernfs_create_file(struct kernfs_node *parent, const char *name,
-		     umode_t mode, kuid_t uid, kgid_t gid,
+		     umode_t mode, struct module *owner,
+		     kuid_t uid, kgid_t gid,
 		     loff_t size, const struct kernfs_ops *ops,
 		     void *priv, const void *ns, struct lock_class_key *key)
 { return ERR_PTR(-ENOSYS); }
@@ -564,7 +569,7 @@ static inline struct kernfs_node *
 kernfs_create_dir(struct kernfs_node *parent, const char *name, umode_t mode,
 		  void *priv)
 {
-	return kernfs_create_dir_ns(parent, name, mode,
+	return kernfs_create_dir_ns(parent, name, mode, parent->owner,
 				    GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
 				    priv, NULL);
 }
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index e3f1e8ac1f85..babbabb460dc 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -30,6 +30,7 @@ enum kobj_ns_type;
 struct attribute {
 	const char		*name;
 	umode_t			mode;
+	struct module           *owner;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	bool			ignore_lockdep:1;
 	struct lock_class_key	*key;
@@ -80,6 +81,7 @@ do {							\
  * @attrs:	Pointer to NULL terminated list of attributes.
  * @bin_attrs:	Pointer to NULL terminated list of binary attributes.
  *		Either attrs or bin_attrs or both must be provided.
+ * @module:	If set, module responsible for this attribute group
  */
 struct attribute_group {
 	const char		*name;
@@ -89,6 +91,7 @@ struct attribute_group {
 						  struct bin_attribute *, int);
 	struct attribute	**attrs;
 	struct bin_attribute	**bin_attrs;
+	struct module           *owner;
 };
 
 /*
@@ -100,38 +103,52 @@ struct attribute_group {
 
 #define __ATTR(_name, _mode, _show, _store) {				\
 	.attr = {.name = __stringify(_name),				\
-		 .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },		\
+		 .mode = VERIFY_OCTAL_PERMISSIONS(_mode),               \
+		 .owner  = THIS_MODULE,                                 \
+	},                                                             \
 	.show	= _show,						\
 	.store	= _store,						\
 }
 
 #define __ATTR_PREALLOC(_name, _mode, _show, _store) {			\
 	.attr = {.name = __stringify(_name),				\
-		 .mode = SYSFS_PREALLOC | VERIFY_OCTAL_PERMISSIONS(_mode) },\
+		 .mode = SYSFS_PREALLOC | VERIFY_OCTAL_PERMISSIONS(_mode),\
+		 .owner  = THIS_MODULE,                                 \
+	},                                                              \
 	.show	= _show,						\
 	.store	= _store,						\
 }
 
 #define __ATTR_RO(_name) {						\
-	.attr	= { .name = __stringify(_name), .mode = 0444 },		\
+	.attr	= { .name = __stringify(_name),                         \
+		    .mode = 0444,					\
+		    .owner  = THIS_MODULE,				\
+		},                                                     \
 	.show	= _name##_show,						\
 }
 
 #define __ATTR_RO_MODE(_name, _mode) {					\
 	.attr	= { .name = __stringify(_name),				\
-		    .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },		\
+		    .mode = VERIFY_OCTAL_PERMISSIONS(_mode),            \
+		    .owner  = THIS_MODULE,				\
+	},                                                              \
 	.show	= _name##_show,						\
 }
 
 #define __ATTR_RW_MODE(_name, _mode) {					\
 	.attr	= { .name = __stringify(_name),				\
-		    .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },		\
+		    .mode = VERIFY_OCTAL_PERMISSIONS(_mode),            \
+		    .owner  = THIS_MODULE,                              \
+	},								\
 	.show	= _name##_show,						\
 	.store	= _name##_store,					\
 }
 
 #define __ATTR_WO(_name) {						\
-	.attr	= { .name = __stringify(_name), .mode = 0200 },		\
+	.attr	= { .name = __stringify(_name),                         \
+		    .mode = 0200,					\
+		    .owner  = THIS_MODULE,				\
+	},                                                              \
 	.store	= _name##_store,					\
 }
 
@@ -141,8 +158,11 @@ struct attribute_group {
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 #define __ATTR_IGNORE_LOCKDEP(_name, _mode, _show, _store) {	\
-	.attr = {.name = __stringify(_name), .mode = _mode,	\
-			.ignore_lockdep = true },		\
+	.attr = {.name = __stringify(_name),                    \
+		 .mode = _mode,					\
+		 .ignore_lockdep = true,                        \
+		 .owner  = THIS_MODULE,                         \
+	},							\
 	.show		= _show,				\
 	.store		= _store,				\
 }
@@ -159,6 +179,7 @@ static const struct attribute_group *_name##_groups[] = {	\
 #define ATTRIBUTE_GROUPS(_name)					\
 static const struct attribute_group _name##_group = {		\
 	.attrs = _name##_attrs,					\
+	.owner = THIS_MODULE,					\
 };								\
 __ATTRIBUTE_GROUPS(_name)
 
@@ -199,20 +220,29 @@ struct bin_attribute {
 
 /* macros to create static binary attributes easier */
 #define __BIN_ATTR(_name, _mode, _read, _write, _size) {		\
-	.attr = { .name = __stringify(_name), .mode = _mode },		\
+	.attr = { .name = __stringify(_name),                           \
+		   .mode = _mode,					\
+		   .owner = THIS_MODULE,				\
+	},								\
 	.read	= _read,						\
 	.write	= _write,						\
 	.size	= _size,						\
 }
 
 #define __BIN_ATTR_RO(_name, _size) {					\
-	.attr	= { .name = __stringify(_name), .mode = 0444 },		\
+	.attr	= { .name = __stringify(_name),                         \
+		    .mode = 0444,					\
+		    .owner = THIS_MODULE,				\
+	},								\
 	.read	= _name##_read,						\
 	.size	= _size,						\
 }
 
 #define __BIN_ATTR_WO(_name, _size) {					\
-	.attr	= { .name = __stringify(_name), .mode = 0200 },		\
+	.attr	= { .name = __stringify(_name),                         \
+		    .mode = 0200,					\
+		    .owner = THIS_MODULE,				\
+	},								\
 	.write	= _name##_write,					\
 	.size	= _size,						\
 }
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 8afa8690d288..b9886db9ecdd 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3949,7 +3949,7 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
 	key = &cft->lockdep_key;
 #endif
 	kn = __kernfs_create_file(cgrp->kn, cgroup_file_name(cgrp, cft, name),
-				  cgroup_file_mode(cft),
+				  cgroup_file_mode(cft), NULL,
 				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
 				  0, cft->kf_ops, cft,
 				  NULL, key);
-- 
2.30.2

