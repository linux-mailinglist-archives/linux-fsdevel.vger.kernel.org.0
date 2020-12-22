Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4282E06F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 08:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgLVHtn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 02:49:43 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:26607 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725300AbgLVHtn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 02:49:43 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-lku-1dzGPQmrfoQ-Yf5w0g-1; Tue, 22 Dec 2020 02:48:20 -0500
X-MC-Unique: lku-1dzGPQmrfoQ-Yf5w0g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D919759;
        Tue, 22 Dec 2020 07:48:18 +0000 (UTC)
Received: from mickey.themaw.net (ovpn-116-49.sin2.redhat.com [10.67.116.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 498D010013C1;
        Tue, 22 Dec 2020 07:48:11 +0000 (UTC)
Subject: [PATCH 4/6] kernfs: switch kernfs to use an rwsem
From:   Ian Kent <raven@themaw.net>
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Tue, 22 Dec 2020 15:48:08 +0800
Message-ID: <160862328895.291330.6343298157363590479.stgit@mickey.themaw.net>
In-Reply-To: <160862320263.291330.9467216031366035418.stgit@mickey.themaw.net>
References: <160862320263.291330.9467216031366035418.stgit@mickey.themaw.net>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=raven@themaw.net
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: themaw.net
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The kernfs global lock restricts the ability to perform kernfs node
lookup operations in parallel.

Change the kernfs mutex to an rwsem so that, when oppertunity arises,
node searches can be done in parallel with path walk lookups.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/kernfs/dir.c             |  117 ++++++++++++++++++++++++-------------------
 fs/kernfs/file.c            |    4 +
 fs/kernfs/inode.c           |   16 +++---
 fs/kernfs/kernfs-internal.h |    5 +-
 fs/kernfs/mount.c           |   12 ++--
 fs/kernfs/symlink.c         |    4 +
 6 files changed, 85 insertions(+), 73 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index aced0bb41083..fdeae2c6e7ba 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -17,7 +17,7 @@
 
 #include "kernfs-internal.h"
 
-DEFINE_MUTEX(kernfs_mutex);
+DECLARE_RWSEM(kernfs_rwsem);
 static DEFINE_SPINLOCK(kernfs_rename_lock);	/* kn->parent and ->name */
 static char kernfs_pr_cont_buf[PATH_MAX];	/* protected by rename_lock */
 static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
@@ -26,10 +26,21 @@ static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
 
 static bool kernfs_active(struct kernfs_node *kn)
 {
-	lockdep_assert_held(&kernfs_mutex);
 	return atomic_read(&kn->active) >= 0;
 }
 
+static bool kernfs_active_write(struct kernfs_node *kn)
+{
+	lockdep_assert_held_write(&kernfs_rwsem);
+	return kernfs_active(kn);
+}
+
+static bool kernfs_active_read(struct kernfs_node *kn)
+{
+	lockdep_assert_held_read(&kernfs_rwsem);
+	return kernfs_active(kn);
+}
+
 static bool kernfs_lockdep(struct kernfs_node *kn)
 {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -340,7 +351,7 @@ static int kernfs_sd_compare(const struct kernfs_node *left,
  *	@kn->parent->dir.children.
  *
  *	Locking:
- *	mutex_lock(kernfs_mutex)
+ *	kernfs_rwsem write lock
  *
  *	RETURNS:
  *	0 on susccess -EEXIST on failure.
@@ -386,7 +397,7 @@ static int kernfs_link_sibling(struct kernfs_node *kn)
  *	removed, %false if @kn wasn't on the rbtree.
  *
  *	Locking:
- *	mutex_lock(kernfs_mutex)
+ *	kernfs_rwsem write lock
  */
 static bool kernfs_unlink_sibling(struct kernfs_node *kn)
 {
@@ -457,14 +468,14 @@ void kernfs_put_active(struct kernfs_node *kn)
  * return after draining is complete.
  */
 static void kernfs_drain(struct kernfs_node *kn)
-	__releases(&kernfs_mutex) __acquires(&kernfs_mutex)
+	__releases(&kernfs_rwsem) __acquires(&kernfs_rwsem)
 {
 	struct kernfs_root *root = kernfs_root(kn);
 
-	lockdep_assert_held(&kernfs_mutex);
+	lockdep_assert_held_write(&kernfs_rwsem);
 	WARN_ON_ONCE(kernfs_active(kn));
 
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 
 	if (kernfs_lockdep(kn)) {
 		rwsem_acquire(&kn->dep_map, 0, 0, _RET_IP_);
@@ -483,7 +494,7 @@ static void kernfs_drain(struct kernfs_node *kn)
 
 	kernfs_drain_open_files(kn);
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 }
 
 /**
@@ -722,7 +733,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 	bool has_ns;
 	int ret;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 
 	ret = -EINVAL;
 	has_ns = kernfs_ns_enabled(parent);
@@ -737,7 +748,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 	if (parent->flags & KERNFS_EMPTY_DIR)
 		goto out_unlock;
 
-	if ((parent->flags & KERNFS_ACTIVATED) && !kernfs_active(parent))
+	if ((parent->flags & KERNFS_ACTIVATED) && !kernfs_active_write(parent))
 		goto out_unlock;
 
 	kn->hash = kernfs_name_hash(kn->name, kn->ns);
@@ -753,7 +764,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 		ps_iattr->ia_mtime = ps_iattr->ia_ctime;
 	}
 
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 
 	/*
 	 * Activate the new node unless CREATE_DEACTIVATED is requested.
@@ -767,7 +778,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 	return 0;
 
 out_unlock:
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 	return ret;
 }
 
@@ -788,7 +799,7 @@ static struct kernfs_node *kernfs_find_ns(struct kernfs_node *parent,
 	bool has_ns = kernfs_ns_enabled(parent);
 	unsigned int hash;
 
-	lockdep_assert_held(&kernfs_mutex);
+	lockdep_assert_held(&kernfs_rwsem);
 
 	if (has_ns != (bool)ns) {
 		WARN(1, KERN_WARNING "kernfs: ns %s in '%s' for '%s'\n",
@@ -820,7 +831,7 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
 	size_t len;
 	char *p, *name;
 
-	lockdep_assert_held(&kernfs_mutex);
+	lockdep_assert_held_read(&kernfs_rwsem);
 
 	/* grab kernfs_rename_lock to piggy back on kernfs_pr_cont_buf */
 	spin_lock_irq(&kernfs_rename_lock);
@@ -860,10 +871,10 @@ struct kernfs_node *kernfs_find_and_get_ns(struct kernfs_node *parent,
 {
 	struct kernfs_node *kn;
 
-	mutex_lock(&kernfs_mutex);
+	down_read(&kernfs_rwsem);
 	kn = kernfs_find_ns(parent, name, ns);
 	kernfs_get(kn);
-	mutex_unlock(&kernfs_mutex);
+	up_read(&kernfs_rwsem);
 
 	return kn;
 }
@@ -884,10 +895,10 @@ struct kernfs_node *kernfs_walk_and_get_ns(struct kernfs_node *parent,
 {
 	struct kernfs_node *kn;
 
-	mutex_lock(&kernfs_mutex);
+	down_read(&kernfs_rwsem);
 	kn = kernfs_walk_ns(parent, path, ns);
 	kernfs_get(kn);
-	mutex_unlock(&kernfs_mutex);
+	up_read(&kernfs_rwsem);
 
 	return kn;
 }
@@ -1040,7 +1051,7 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
 
-	mutex_lock(&kernfs_mutex);
+	down_read(&kernfs_rwsem);
 
 	kn = kernfs_dentry_node(dentry);
 
@@ -1088,10 +1099,10 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	    kernfs_info(dentry->d_sb)->ns != kn->ns)
 		goto out_bad;
 out:
-	mutex_unlock(&kernfs_mutex);
+	up_read(&kernfs_rwsem);
 	return 1;
 out_bad:
-	mutex_unlock(&kernfs_mutex);
+	up_read(&kernfs_rwsem);
 	return 0;
 }
 
@@ -1109,7 +1120,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	struct inode *inode = NULL;
 	const void *ns = NULL;
 
-	mutex_lock(&kernfs_mutex);
+	down_read(&kernfs_rwsem);
 
 	kernfs_set_rev(dentry, parent);
 
@@ -1132,7 +1143,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	/* instantiate and hash dentry */
 	ret = d_splice_alias(inode, dentry);
 out_unlock:
-	mutex_unlock(&kernfs_mutex);
+	up_read(&kernfs_rwsem);
 	return ret;
 }
 
@@ -1251,7 +1262,7 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
 {
 	struct rb_node *rbn;
 
-	lockdep_assert_held(&kernfs_mutex);
+	lockdep_assert_held_write(&kernfs_rwsem);
 
 	/* if first iteration, visit leftmost descendant which may be root */
 	if (!pos)
@@ -1287,7 +1298,7 @@ void kernfs_activate(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 
 	pos = NULL;
 	while ((pos = kernfs_next_descendant_post(pos, kn))) {
@@ -1301,14 +1312,14 @@ void kernfs_activate(struct kernfs_node *kn)
 		pos->flags |= KERNFS_ACTIVATED;
 	}
 
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 }
 
 static void __kernfs_remove(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
 
-	lockdep_assert_held(&kernfs_mutex);
+	lockdep_assert_held_write(&kernfs_rwsem);
 
 	/*
 	 * Short-circuit if non-root @kn has already finished removal.
@@ -1323,7 +1334,7 @@ static void __kernfs_remove(struct kernfs_node *kn)
 	/* prevent any new usage under @kn by deactivating all nodes */
 	pos = NULL;
 	while ((pos = kernfs_next_descendant_post(pos, kn)))
-		if (kernfs_active(pos))
+		if (kernfs_active_write(pos))
 			atomic_add(KN_DEACTIVATED_BIAS, &pos->active);
 
 	/* deactivate and unlink the subtree node-by-node */
@@ -1331,7 +1342,7 @@ static void __kernfs_remove(struct kernfs_node *kn)
 		pos = kernfs_leftmost_descendant(kn);
 
 		/*
-		 * kernfs_drain() drops kernfs_mutex temporarily and @pos's
+		 * kernfs_drain() drops kernfs_rwsem temporarily and @pos's
 		 * base ref could have been put by someone else by the time
 		 * the function returns.  Make sure it doesn't go away
 		 * underneath us.
@@ -1378,9 +1389,9 @@ static void __kernfs_remove(struct kernfs_node *kn)
  */
 void kernfs_remove(struct kernfs_node *kn)
 {
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 	__kernfs_remove(kn);
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 }
 
 /**
@@ -1467,17 +1478,17 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 {
 	bool ret;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 	kernfs_break_active_protection(kn);
 
 	/*
 	 * SUICIDAL is used to arbitrate among competing invocations.  Only
 	 * the first one will actually perform removal.  When the removal
 	 * is complete, SUICIDED is set and the active ref is restored
-	 * while holding kernfs_mutex.  The ones which lost arbitration
-	 * waits for SUICDED && drained which can happen only after the
-	 * enclosing kernfs operation which executed the winning instance
-	 * of kernfs_remove_self() finished.
+	 * while holding kernfs_rwsem for write.  The ones which lost
+	 * arbitration waits for SUICIDED && drained which can happen only
+	 * after the enclosing kernfs operation which executed the winning
+	 * instance of kernfs_remove_self() finished.
 	 */
 	if (!(kn->flags & KERNFS_SUICIDAL)) {
 		kn->flags |= KERNFS_SUICIDAL;
@@ -1495,9 +1506,9 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 			    atomic_read(&kn->active) == KN_DEACTIVATED_BIAS)
 				break;
 
-			mutex_unlock(&kernfs_mutex);
+			up_write(&kernfs_rwsem);
 			schedule();
-			mutex_lock(&kernfs_mutex);
+			down_write(&kernfs_rwsem);
 		}
 		finish_wait(waitq, &wait);
 		WARN_ON_ONCE(!RB_EMPTY_NODE(&kn->rb));
@@ -1505,12 +1516,12 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 	}
 
 	/*
-	 * This must be done while holding kernfs_mutex; otherwise, waiting
-	 * for SUICIDED && deactivated could finish prematurely.
+	 * This must be done while holding kernfs_rwsem for write; otherwise,
+	 * waiting for SUICIDED && deactivated could finish prematurely.
 	 */
 	kernfs_unbreak_active_protection(kn);
 
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 	return ret;
 }
 
@@ -1534,13 +1545,13 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 		return -ENOENT;
 	}
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 
 	kn = kernfs_find_ns(parent, name, ns);
 	if (kn)
 		__kernfs_remove(kn);
 
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 
 	if (kn)
 		return 0;
@@ -1566,10 +1577,10 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 	if (!kn->parent)
 		return -EINVAL;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 
 	error = -ENOENT;
-	if (!kernfs_active(kn) || !kernfs_active(new_parent) ||
+	if (!kernfs_active_write(kn) || !kernfs_active_write(new_parent) ||
 	    (new_parent->flags & KERNFS_EMPTY_DIR))
 		goto out;
 
@@ -1620,7 +1631,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 
 	error = 0;
  out:
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 	return error;
 }
 
@@ -1640,7 +1651,7 @@ static struct kernfs_node *kernfs_dir_pos(const void *ns,
 	struct kernfs_node *parent, loff_t hash, struct kernfs_node *pos)
 {
 	if (pos) {
-		int valid = kernfs_active(pos) &&
+		int valid = kernfs_active_read(pos) &&
 			pos->parent == parent && hash == pos->hash;
 		kernfs_put(pos);
 		if (!valid)
@@ -1660,7 +1671,7 @@ static struct kernfs_node *kernfs_dir_pos(const void *ns,
 		}
 	}
 	/* Skip over entries which are dying/dead or in the wrong namespace */
-	while (pos && (!kernfs_active(pos) || pos->ns != ns)) {
+	while (pos && (!kernfs_active_read(pos) || pos->ns != ns)) {
 		struct rb_node *node = rb_next(&pos->rb);
 		if (!node)
 			pos = NULL;
@@ -1681,7 +1692,7 @@ static struct kernfs_node *kernfs_dir_next_pos(const void *ns,
 				pos = NULL;
 			else
 				pos = rb_to_kn(node);
-		} while (pos && (!kernfs_active(pos) || pos->ns != ns));
+		} while (pos && (!kernfs_active_read(pos) || pos->ns != ns));
 	}
 	return pos;
 }
@@ -1695,7 +1706,7 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
-	mutex_lock(&kernfs_mutex);
+	down_read(&kernfs_rwsem);
 
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dentry->d_sb)->ns;
@@ -1712,12 +1723,12 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 		file->private_data = pos;
 		kernfs_get(pos);
 
-		mutex_unlock(&kernfs_mutex);
+		up_read(&kernfs_rwsem);
 		if (!dir_emit(ctx, name, len, ino, type))
 			return 0;
-		mutex_lock(&kernfs_mutex);
+		down_read(&kernfs_rwsem);
 	}
-	mutex_unlock(&kernfs_mutex);
+	up_read(&kernfs_rwsem);
 	file->private_data = NULL;
 	ctx->pos = INT_MAX;
 	return 0;
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index f277d023ebcd..7e391784dbe4 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -879,7 +879,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	spin_unlock_irq(&kernfs_notify_lock);
 
 	/* kick fsnotify */
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 
 	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
 		struct kernfs_node *parent;
@@ -917,7 +917,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 		iput(inode);
 	}
 
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 	kernfs_put(kn);
 	goto repeat;
 }
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index fc2469a20fed..ddaf18198935 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -106,9 +106,9 @@ int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 {
 	int ret;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 	ret = __kernfs_setattr(kn, iattr);
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 	return ret;
 }
 
@@ -121,7 +121,7 @@ int kernfs_iop_setattr(struct dentry *dentry, struct iattr *iattr)
 	if (!kn)
 		return -EINVAL;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 	error = setattr_prepare(dentry, iattr);
 	if (error)
 		goto out;
@@ -134,7 +134,7 @@ int kernfs_iop_setattr(struct dentry *dentry, struct iattr *iattr)
 	setattr_copy(inode, iattr);
 
 out:
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 	return error;
 }
 
@@ -189,9 +189,9 @@ int kernfs_iop_getattr(const struct path *path, struct kstat *stat,
 	struct inode *inode = d_inode(path->dentry);
 	struct kernfs_node *kn = inode->i_private;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 	kernfs_refresh_inode(kn, inode);
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 
 	generic_fillattr(inode, stat);
 	return 0;
@@ -281,9 +281,9 @@ int kernfs_iop_permission(struct inode *inode, int mask)
 
 	kn = inode->i_private;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 	kernfs_refresh_inode(kn, inode);
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 
 	return generic_permission(inode, mask);
 }
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 0d48a367231d..a7b0e2074260 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -13,6 +13,7 @@
 #include <linux/lockdep.h>
 #include <linux/fs.h>
 #include <linux/mutex.h>
+#include <linux/rwsem.h>
 #include <linux/xattr.h>
 
 #include <linux/kernfs.h>
@@ -69,7 +70,7 @@ struct kernfs_super_info {
 	 */
 	const void		*ns;
 
-	/* anchored at kernfs_root->supers, protected by kernfs_mutex */
+	/* anchored at kernfs_root->supers, protected by kernfs_rwsem */
 	struct list_head	node;
 };
 #define kernfs_info(SB) ((struct kernfs_super_info *)(SB->s_fs_info))
@@ -123,7 +124,7 @@ int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr);
 /*
  * dir.c
  */
-extern struct mutex kernfs_mutex;
+extern struct rw_semaphore kernfs_rwsem;
 extern const struct dentry_operations kernfs_dops;
 extern const struct file_operations kernfs_dir_fops;
 extern const struct inode_operations kernfs_dir_iops;
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 9dc7e7a64e10..baa4155ba2ed 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -255,9 +255,9 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
 	sb->s_shrink.seeks = 0;
 
 	/* get root inode, initialize and unlock it */
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 	inode = kernfs_get_inode(sb, info->root->kn);
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 	if (!inode) {
 		pr_debug("kernfs: could not get root inode\n");
 		return -ENOMEM;
@@ -344,9 +344,9 @@ int kernfs_get_tree(struct fs_context *fc)
 		}
 		sb->s_flags |= SB_ACTIVE;
 
-		mutex_lock(&kernfs_mutex);
+		down_write(&kernfs_rwsem);
 		list_add(&info->node, &info->root->supers);
-		mutex_unlock(&kernfs_mutex);
+		up_write(&kernfs_rwsem);
 	}
 
 	fc->root = dget(sb->s_root);
@@ -372,9 +372,9 @@ void kernfs_kill_sb(struct super_block *sb)
 {
 	struct kernfs_super_info *info = kernfs_info(sb);
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 	list_del(&info->node);
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 
 	/*
 	 * Remove the superblock from fs_supers/s_instances
diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
index 5432883d819f..7246b470de3c 100644
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -116,9 +116,9 @@ static int kernfs_getlink(struct inode *inode, char *path)
 	struct kernfs_node *target = kn->symlink.target_kn;
 	int error;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 	error = kernfs_get_target_path(parent, target, path);
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 
 	return error;
 }


