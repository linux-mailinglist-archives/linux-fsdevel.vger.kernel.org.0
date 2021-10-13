Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDFDF42CCA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 23:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhJMVSk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 17:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhJMVSk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 17:18:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEE5C061570;
        Wed, 13 Oct 2021 14:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OweN4/Q43r5ozRtiEmdcNGecCgrlkdYBbqLd/9fIyVk=; b=cmm0g5Se2fWpUxGHvS6/o1TTcp
        /swZ7uaI+PDlqFVaF2Zi47SDpB+XkzBatRloiXdxRM9IThZNImjwcEaOedeJ5FXpvxC3i3djvO+1X
        1awvhIRanaOJ0jyMfu85yaOxlFzOjpH/v59jvmjABFtQhkcadtEiePraL4t5sOZ+bv+GX+pv7GgLH
        JhSntEk5nBztXOUXirJmr9bcC9rWIBpfRL8CPbhtt0X4HXhZkknC2JcnJRRfBtDYcO53kiTzWuI05
        irVDoJ4aC8jFAmvlq24fs5BojdIGY1Ub8a65qLuQU7WoZ9JVju8+5wX+1t6ceyHytQnJYFWywSJIN
        gmycqdHw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1malbq-000hyd-FV; Wed, 13 Oct 2021 21:16:22 +0000
Date:   Wed, 13 Oct 2021 14:16:22 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Miroslav Benes <mbenes@suse.cz>, tj@kernel.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        minchan@kernel.org, jeyu@kernel.org, shuah@kernel.org,
        bvanassche@acm.org, dan.j.williams@intel.com, joe@perches.com,
        tglx@linutronix.de, keescook@chromium.org, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org
Subject: Re: [PATCH v8 09/12] sysfs: fix deadlock race with module removal
Message-ID: <YWdMpv8lAFYtc18c@bombadil.infradead.org>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-10-mcgrof@kernel.org>
 <YVwZwh7qDKfSM59h@T590>
 <YWSr2trabEJflzlj@bombadil.infradead.org>
 <YWTU3kTlJKONyFjZ@T590>
 <YWX7pAn0YMaJeJBA@bombadil.infradead.org>
 <YWYxN875B6rlmAjC@T590>
 <YWbSk6p3bfXUPZ92@bombadil.infradead.org>
 <YWb1Z7EXruo6gaEp@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWb1Z7EXruo6gaEp@T590>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 13, 2021 at 11:04:07PM +0800, Ming Lei wrote:
> On Wed, Oct 13, 2021 at 05:35:31AM -0700, Luis Chamberlain wrote:
> > On Wed, Oct 13, 2021 at 09:07:03AM +0800, Ming Lei wrote:
> > > On Tue, Oct 12, 2021 at 02:18:28PM -0700, Luis Chamberlain wrote:
> > > > > Looks test_sysfs isn't in linus tree, where can I find it?
> > > > 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20210927-sysfs-generic-deadlock-fix
> > > > 
> > > > To reproduce the deadlock revert the patch in this thread and then run
> > > > either of these two tests as root:
> > > > 
> > > > ./tools/testing/selftests/sysfs/sysfs.sh -w 0027
> > > > ./tools/testing/selftests/sysfs/sysfs.sh -w 0028
> > > > 
> > > > You will need to enable the test_sysfs driver.
> > > > > Can you share the code which waits for the sysfs / kernfs files to be
> > > > > stop being used?
> > > > 
> > > > How about a call trace of the two tasks which deadlock, here is one of
> > > > running test 0027:
> > > > 
> > > > kdevops login: [  363.875459] INFO: task sysfs.sh:1271 blocked for more
> > > > than 120 seconds.
> > 
> > <-- snip -->
> > 
> > > That doesn't show the deadlock is related with module_exit().
> > 
> > Not directly no.
> 
> Then the patch title of 'sysfs: fix deadlock race with module removal'
> is wrong.

Well that is what it does though. The scope of the issue you are raising
is beyond module removal, but I do agree such races can exist outside of
module removal.

> > > It is clearly one AA deadlock, what I meant was that it isn't related with
> > > module exit cause lock & device_del() isn't always done in module exit, so
> > > I doubt your fix with grabbing module refcnt is good or generic enough.
> > 
> > A device_del() *can* happen in other areas other than module exit sure,
> > but the issue is if a shared lock is used *before* device_del() and also
> > used on a sysfs op. Typically this can happen on module exit, and the
> > other common use case in my experience is on sysfs ops, such is the case
> > with the zram driver. Both cases are covered then by this fix.
> 
> Again, can you share the related zram code about the issue? In
> zram_drv.c of linus or next tree, I don't see any lock is held before
> calling del_gendisk().

There is another bug with CPU hotplug multistate support in the zram
driver which a patch in this series fixes, refer to the patch titled
"zram: fix crashes with cpu hotplug multistate". In zram's case we need
to contend a generic lock on certain sysfs attributes due to the way CPU
hotplug is used.

If we tried to generalize this on the block layer the closest we get is
the disk->fops->owner, however zram is an example driver where the
disk->fops is actually be even changed *after* module load, and so the
original disk->fops->owner can be dynamic. In zram's case the
fops->owner is the same, however we have no semantics to ensure this is
the case for all block drivers.

In the case for live patching, refer to the use of klp_mutex. The way
that was solved there was a combination of completions and deferred
works to solve it, so that all kobject_put calls are outside of the
critical sections, refer to commit 3ec24776bfd0 ("livepatch:
allow removal of a disabled patch").

And so it was encouraged a generic solution be sought after.

> > If there are other areas, that is still driver specific, but of the
> > things we *can* generalize, definitely module exit is a common path.
> > 
> > > Except for your cooked test_sys module, how many real drivers do suffer the
> > > problem? What are they?
> > 
> > I only really seriously considered trying to generalize this after it
> 
> IMO your generalization isn't good or correct because this kind of issue
> is _not_ related with module exit at all. What matters is just that one lock is
> held before calling device_del(), meantime the same lock is required
> in the device's attribute show/store function().

Your point that a race for a deadlock still can exist beyond module
removal is valid but unfortunately there are no possible semantics I can
see to fix that generically at this time.

> There are many cases in which we call device_del() not from module_exit(),
> such as scsi scan, scsi sysfs store(), or even handling event from
> device side, nvme error handling, usb hotplug, ...

These are really good points.

> > was hinted to me live patching was also affected, and so clearly
> > something generic was desirable.
> 
> It might be just the only two drivers(zram and live patch) with this bug, and
> it is one simply AA bug in driver. Not mention I don't see such usage in
> zram_drv.c.

Well... given what you say above about other uses cases other than
module removal which can remove sysfs files and having them be used,
the possibilities of this deadlock existing elsewhere should increase,
not decrease.

> > There may be other drivers for sure, but a hunt for that with semantics
> > would require a bit complex coccinelle patch with iteration support.
> > 
> > > Why can't we fix the exact driver?
> > 
> > You can try, the way the lock is used in zram is correct, specially
> 
> What is the lock in zram? Again can you share the related functions?

If you git checked out the tree I mentioned try looking at the code
there with the fix for CPU hotplug multistate in mind.

> > after my other fix in this series which addresses another unrelated bug
> > with cpu hotplug multistate support. So we then can proceed to either
> > take the position to say: "Thou shalt not use a shared lock on module
> > exit and a sysfs op" and try to fix all places, or we generalize a fix
> > for this. A generic fix seems more desirable.
> 
> What matters is that the lock is held before calling device_del()
> instead of being held in module_exit().

I agree the possibilities can include more than just module exit.
Unfortunately I can't see a way to generalize this further. I tried,
see below, and this moves the ideas from a module to the kobject, but
even with that, it does not get us any closer to fixing this
generically. The reason a fix works for module removal is the
try_module_get() call when getting the kernfs active reference
will trump the module exit call completely, and so we *do* prevent
the context which will issue the lock in this case if a sysfs
operation is in progress.

Outside of that call sequence I am afraid we'd need separate solutions
or side with the 'though shall not use a shared lock on a sysfs op
and when issuing a device_del(), other than module exit'.

Below is an attempt to generalize this further, but it does not work,
let me know if you have further ideas.

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index b57b3db9a6a7..4edf3b37fd2c 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -209,7 +209,7 @@ static int rdtgroup_add_file(struct kernfs_node *parent_kn, struct rftype *rft)
 
 	kn = __kernfs_create_file(parent_kn, rft->name, rft->mode,
 				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
-				  0, rft->kf_ops, rft, NULL, NULL);
+				  0, rft->kf_ops, rft, NULL, NULL, NULL);
 	if (IS_ERR(kn))
 		return PTR_ERR(kn);
 
@@ -2482,7 +2482,7 @@ static int mon_addfile(struct kernfs_node *parent_kn, const char *name,
 
 	kn = __kernfs_create_file(parent_kn, name, 0444,
 				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, 0,
-				  &kf_mondata_ops, priv, NULL, NULL);
+				  &kf_mondata_ops, priv, NULL, NULL, NULL);
 	if (IS_ERR(kn))
 		return PTR_ERR(kn);
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 7758223f040c..38f07072ab44 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3507,6 +3507,7 @@ bool kill_device(struct device *dev)
 	if (dev->p->dead)
 		return false;
 	dev->p->dead = true;
+	kobject_set_being_removed(&dev->kobj);
 	return true;
 }
 EXPORT_SYMBOL_GPL(kill_device);
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index ba581429bf7b..7d14f6b2c12d 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/security.h>
 #include <linux/hash.h>
+#include <linux/kobject.h>
 
 #include "kernfs-internal.h"
 
@@ -414,15 +415,38 @@ static bool kernfs_unlink_sibling(struct kernfs_node *kn)
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
+	 * If a kobject created the kernfs_node, the kobject cannot possibly be
+	 * removed if the above atomic_inc_unless_negative() succeeded. But we
+	 * need to inspect if its on its way out to ensure that we don't
+	 * deadlock in case a kernfs operation and the code responsible for
+	 * the kobject removal used a shared lock.
+	 */
+	if (kn->kobj) {
+		if (WARN_ON(!kobject_get_unless_zero(kn->kobj))) {
+			goto fail;
+		} else if (kobject_being_removed(kn->kobj)) {
+			kobject_put(kn->kobj);
+			goto fail;
+		}
+	}
+
 	if (kernfs_lockdep(kn))
 		rwsem_acquire_read(&kn->dep_map, 0, 1, _RET_IP_);
 	return kn;
+fail:
+	v = atomic_dec_return(&kn->active);
+	if (unlikely(v == KN_DEACTIVATED_BIAS))
+		wake_up_all(&kernfs_root(kn)->deactivate_waitq);
+	return NULL;
 }
 
 /**
@@ -442,6 +466,7 @@ void kernfs_put_active(struct kernfs_node *kn)
 	if (kernfs_lockdep(kn))
 		rwsem_release(&kn->dep_map, _RET_IP_);
 	v = atomic_dec_return(&kn->active);
+	kobject_put(kn->kobj);
 	if (likely(v != KN_DEACTIVATED_BIAS))
 		return;
 
@@ -572,7 +597,8 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 					     struct kernfs_node *parent,
 					     const char *name, umode_t mode,
 					     kuid_t uid, kgid_t gid,
-					     unsigned flags)
+					     unsigned flags,
+					     struct kobject *kobj)
 {
 	struct kernfs_node *kn;
 	u32 id_highbits;
@@ -607,6 +633,7 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	kn->name = name;
 	kn->mode = mode;
 	kn->flags = flags;
+	kn->kobj = kobj;
 
 	if (!uid_eq(uid, GLOBAL_ROOT_UID) || !gid_eq(gid, GLOBAL_ROOT_GID)) {
 		struct iattr iattr = {
@@ -640,12 +667,13 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
 				    const char *name, umode_t mode,
 				    kuid_t uid, kgid_t gid,
-				    unsigned flags)
+				    unsigned flags,
+				    struct kobject *kobj)
 {
 	struct kernfs_node *kn;
 
 	kn = __kernfs_new_node(kernfs_root(parent), parent,
-			       name, mode, uid, gid, flags);
+			       name, mode, uid, gid, flags, kobj);
 	if (kn) {
 		kernfs_get(parent);
 		kn->parent = parent;
@@ -927,7 +955,7 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 
 	kn = __kernfs_new_node(root, NULL, "", S_IFDIR | S_IRUGO | S_IXUGO,
 			       GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
-			       KERNFS_DIR);
+			       KERNFS_DIR, NULL);
 	if (!kn) {
 		idr_destroy(&root->ino_idr);
 		kfree(root);
@@ -969,20 +997,22 @@ void kernfs_destroy_root(struct kernfs_root *root)
  * @gid: gid of the new directory
  * @priv: opaque data associated with the new directory
  * @ns: optional namespace tag of the directory
+ * @kobj: if set, the kobject responsible for this directory
  *
  * Returns the created node on success, ERR_PTR() value on failure.
  */
 struct kernfs_node *kernfs_create_dir_ns(struct kernfs_node *parent,
 					 const char *name, umode_t mode,
 					 kuid_t uid, kgid_t gid,
-					 void *priv, const void *ns)
+					 void *priv, const void *ns,
+					 struct kobject *kobj)
 {
 	struct kernfs_node *kn;
 	int rc;
 
 	/* allocate */
 	kn = kernfs_new_node(parent, name, mode | S_IFDIR,
-			     uid, gid, KERNFS_DIR);
+			     uid, gid, KERNFS_DIR, kobj);
 	if (!kn)
 		return ERR_PTR(-ENOMEM);
 
@@ -1014,7 +1044,8 @@ struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
 
 	/* allocate */
 	kn = kernfs_new_node(parent, name, S_IRUGO|S_IXUGO|S_IFDIR,
-			     GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, KERNFS_DIR);
+			     GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, KERNFS_DIR,
+			     parent->kobj);
 	if (!kn)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 4479c6580333..1b02f3e69c81 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -978,6 +978,7 @@ const struct file_operations kernfs_file_fops = {
  * @priv: private data for the file
  * @ns: optional namespace tag of the file
  * @key: lockdep key for the file's active_ref, %NULL to disable lockdep
+ * @kobj: if set, the kobject responsible for the file
  *
  * Returns the created node on success, ERR_PTR() value on error.
  */
@@ -987,7 +988,8 @@ struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
 					 loff_t size,
 					 const struct kernfs_ops *ops,
 					 void *priv, const void *ns,
-					 struct lock_class_key *key)
+					 struct lock_class_key *key,
+					 struct kobject *kobj)
 {
 	struct kernfs_node *kn;
 	unsigned flags;
@@ -996,7 +998,7 @@ struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
 	flags = KERNFS_FILE;
 
 	kn = kernfs_new_node(parent, name, (mode & S_IALLUGO) | S_IFREG,
-			     uid, gid, flags);
+			     uid, gid, flags, kobj);
 	if (!kn)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 9e3abf597e2d..44983720d292 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -134,7 +134,8 @@ int kernfs_add_one(struct kernfs_node *kn);
 struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
 				    const char *name, umode_t mode,
 				    kuid_t uid, kgid_t gid,
-				    unsigned flags);
+				    unsigned flags,
+				    struct kobject *kobj);
 
 /*
  * file.c
diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
index 19a6c71c6ff5..c877de06e53a 100644
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -36,7 +36,8 @@ struct kernfs_node *kernfs_create_link(struct kernfs_node *parent,
 		gid = target->iattr->ia_gid;
 	}
 
-	kn = kernfs_new_node(parent, name, S_IFLNK|0777, uid, gid, KERNFS_LINK);
+	kn = kernfs_new_node(parent, name, S_IFLNK|0777, uid, gid, KERNFS_LINK,
+			     target->kobj);
 	if (!kn)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
index b6b6796e1616..9cc159e9fb55 100644
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -57,7 +57,7 @@ int sysfs_create_dir_ns(struct kobject *kobj, const void *ns)
 	kobject_get_ownership(kobj, &uid, &gid);
 
 	kn = kernfs_create_dir_ns(parent, kobject_name(kobj), 0755, uid, gid,
-				  kobj, ns);
+				  kobj, ns, kobj);
 	if (IS_ERR(kn)) {
 		if (PTR_ERR(kn) == -EEXIST)
 			sysfs_warn_dup(parent, kobject_name(kobj));
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 42dcf96881b6..e1a3315dba35 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -292,7 +292,7 @@ int sysfs_add_file_mode_ns(struct kernfs_node *parent,
 #endif
 
 	kn = __kernfs_create_file(parent, attr->name, mode & 0777, uid, gid,
-				  PAGE_SIZE, ops, (void *)attr, ns, key);
+				  PAGE_SIZE, ops, (void *)attr, ns, key, kobj);
 	if (IS_ERR(kn)) {
 		if (PTR_ERR(kn) == -EEXIST)
 			sysfs_warn_dup(parent, attr->name);
@@ -309,6 +309,7 @@ int sysfs_add_bin_file_mode_ns(struct kernfs_node *parent,
 	struct lock_class_key *key = NULL;
 	const struct kernfs_ops *ops;
 	struct kernfs_node *kn;
+	struct kobject *kobj = parent->priv;
 
 	if (battr->mmap)
 		ops = &sysfs_bin_kfops_mmap;
@@ -327,7 +328,8 @@ int sysfs_add_bin_file_mode_ns(struct kernfs_node *parent,
 #endif
 
 	kn = __kernfs_create_file(parent, attr->name, mode & 0777, uid, gid,
-				  battr->size, ops, (void *)attr, ns, key);
+				  battr->size, ops, (void *)attr, ns, key,
+				  kobj);
 	if (IS_ERR(kn)) {
 		if (PTR_ERR(kn) == -EEXIST)
 			sysfs_warn_dup(parent, attr->name);
diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index eeb0e3099421..36022fe2b21d 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -135,7 +135,8 @@ static int internal_create_group(struct kobject *kobj, int update,
 		} else {
 			kn = kernfs_create_dir_ns(kobj->sd, grp->name,
 						  S_IRWXU | S_IRUGO | S_IXUGO,
-						  uid, gid, kobj, NULL);
+						  uid, gid, kobj, NULL,
+						  kobj);
 			if (IS_ERR(kn)) {
 				if (PTR_ERR(kn) == -EEXIST)
 					sysfs_warn_dup(kobj->sd, grp->name);
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index cd968ee2b503..38155414e6e5 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -161,6 +161,7 @@ struct kernfs_node {
 	unsigned short		flags;
 	umode_t			mode;
 	struct kernfs_iattrs	*iattr;
+	struct kobject		*kobj;
 };
 
 /*
@@ -370,7 +371,8 @@ void kernfs_destroy_root(struct kernfs_root *root);
 struct kernfs_node *kernfs_create_dir_ns(struct kernfs_node *parent,
 					 const char *name, umode_t mode,
 					 kuid_t uid, kgid_t gid,
-					 void *priv, const void *ns);
+					 void *priv, const void *ns,
+					 struct kobject *kobj);
 struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
 					    const char *name);
 struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
@@ -379,7 +381,8 @@ struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
 					 loff_t size,
 					 const struct kernfs_ops *ops,
 					 void *priv, const void *ns,
-					 struct lock_class_key *key);
+					 struct lock_class_key *key,
+					 struct kobject *kobj);
 struct kernfs_node *kernfs_create_link(struct kernfs_node *parent,
 				       const char *name,
 				       struct kernfs_node *target);
@@ -472,14 +475,15 @@ static inline void kernfs_destroy_root(struct kernfs_root *root) { }
 static inline struct kernfs_node *
 kernfs_create_dir_ns(struct kernfs_node *parent, const char *name,
 		     umode_t mode, kuid_t uid, kgid_t gid,
-		     void *priv, const void *ns)
+		     void *priv, const void *ns, struct kobject *kobj)
 { return ERR_PTR(-ENOSYS); }
 
 static inline struct kernfs_node *
 __kernfs_create_file(struct kernfs_node *parent, const char *name,
 		     umode_t mode, kuid_t uid, kgid_t gid,
 		     loff_t size, const struct kernfs_ops *ops,
-		     void *priv, const void *ns, struct lock_class_key *key)
+		     void *priv, const void *ns, struct lock_class_key *key,
+		     struct kobject *kobj)
 { return ERR_PTR(-ENOSYS); }
 
 static inline struct kernfs_node *
@@ -566,7 +570,7 @@ kernfs_create_dir(struct kernfs_node *parent, const char *name, umode_t mode,
 {
 	return kernfs_create_dir_ns(parent, name, mode,
 				    GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
-				    priv, NULL);
+				    priv, NULL, parent->kobj);
 }
 
 static inline int kernfs_remove_by_name(struct kernfs_node *parent,
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index efd56f990a46..cb26ebeb7cf1 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -77,6 +77,7 @@ struct kobject {
 	unsigned int state_add_uevent_sent:1;
 	unsigned int state_remove_uevent_sent:1;
 	unsigned int uevent_suppress:1;
+	unsigned int being_removed:1;
 };
 
 extern __printf(2, 3)
@@ -117,6 +118,15 @@ extern void kobject_get_ownership(struct kobject *kobj,
 				  kuid_t *uid, kgid_t *gid);
 extern char *kobject_get_path(struct kobject *kobj, gfp_t flag);
 
+static inline bool kobject_being_removed(const struct kobject *kobj)
+{
+	if (!kobj)
+		return false;
+	return !!kobj->being_removed;
+}
+
+void kobject_set_being_removed(struct kobject *kobj);
+
 /**
  * kobject_has_children - Returns whether a kobject has children.
  * @kobj: the object to test
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 9e0390000025..c6b0a28f599c 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3975,7 +3975,7 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
 				  cgroup_file_mode(cft),
 				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
 				  0, cft->kf_ops, cft,
-				  NULL, key);
+				  NULL, key, NULL);
 	if (IS_ERR(kn))
 		return PTR_ERR(kn);
 
diff --git a/lib/kobject.c b/lib/kobject.c
index 4a56f519139d..ef89bf2ac218 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -221,6 +221,12 @@ static void kobject_init_internal(struct kobject *kobj)
 	kobj->state_initialized = 1;
 }
 
+void kobject_set_being_removed(struct kobject *kobj)
+{
+	if (!kobj)
+		return;
+	kobj->being_removed = 1;
+}
 
 static int kobject_add_internal(struct kobject *kobj)
 {
