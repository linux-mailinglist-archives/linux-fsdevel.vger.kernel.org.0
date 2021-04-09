Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D7C35913B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 03:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbhDIBPh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Thu, 8 Apr 2021 21:15:37 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:58788 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233202AbhDIBPh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 21:15:37 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-baU1LXyIMFuqdHOBZS6Qlw-1; Thu, 08 Apr 2021 21:15:22 -0400
X-MC-Unique: baU1LXyIMFuqdHOBZS6Qlw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F011F5B38D;
        Fri,  9 Apr 2021 01:15:20 +0000 (UTC)
Received: from mickey.themaw.net (ovpn-116-30.sin2.redhat.com [10.67.116.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5785E5D9C0;
        Fri,  9 Apr 2021 01:15:17 +0000 (UTC)
Subject: [PATCH v3 3/4] kernfs: switch kernfs to use an rwsem
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Brice Goglin <brice.goglin@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Fri, 09 Apr 2021 09:15:15 +0800
Message-ID: <161793091593.10062.3742007138443093729.stgit@mickey.themaw.net>
In-Reply-To: <161793058309.10062.17056551235139961080.stgit@mickey.themaw.net>
References: <161793058309.10062.17056551235139961080.stgit@mickey.themaw.net>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
lookup operations in parallel during path walks.

Change the kernfs mutex to an rwsem so that, when opportunity arises,
node searches can be done in parallel with path walk lookups.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/kernfs/dir.c             |  117 ++++++++++++++++++++++++-------------------
 fs/kernfs/file.c            |    4 +
 fs/kernfs/inode.c           |   16 +++---
 fs/kernfs/kernfs-internal.h |    5 +-
 fs/kernfs/mount.c           |   12 ++--
 fs/kernfs/symlink.c         |    4 +
 include/linux/kernfs.h      |    2 -
 7 files changed, 86 insertions(+), 74 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index edfeee1bf38ec..9bea235f2ec66 100644
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
+ *	kernfs_rwsem held exclusive
  *
  *	RETURNS:
  *	0 on susccess -EEXIST on failure.
@@ -385,7 +396,7 @@ static int kernfs_link_sibling(struct kernfs_node *kn)
  *	removed, %false if @kn wasn't on the rbtree.
  *
  *	Locking:
- *	mutex_lock(kernfs_mutex)
+ *	kernfs_rwsem held exclusive
  */
 static bool kernfs_unlink_sibling(struct kernfs_node *kn)
 {
@@ -455,14 +466,14 @@ void kernfs_put_active(struct kernfs_node *kn)
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
@@ -481,7 +492,7 @@ static void kernfs_drain(struct kernfs_node *kn)
 
 	kernfs_drain_open_files(kn);
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 }
 
 /**
@@ -720,7 +731,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 	bool has_ns;
 	int ret;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 
 	ret = -EINVAL;
 	has_ns = kernfs_ns_enabled(parent);
@@ -735,7 +746,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 	if (parent->flags & KERNFS_EMPTY_DIR)
 		goto out_unlock;
 
-	if ((parent->flags & KERNFS_ACTIVATED) && !kernfs_active(parent))
+	if ((parent->flags & KERNFS_ACTIVATED) && !kernfs_active_write(parent))
 		goto out_unlock;
 
 	kn->hash = kernfs_name_hash(kn->name, kn->ns);
@@ -751,7 +762,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 		ps_iattr->ia_mtime = ps_iattr->ia_ctime;
 	}
 
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 
 	/*
 	 * Activate the new node unless CREATE_DEACTIVATED is requested.
@@ -765,7 +776,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 	return 0;
 
 out_unlock:
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 	return ret;
 }
 
@@ -786,7 +797,7 @@ static struct kernfs_node *kernfs_find_ns(struct kernfs_node *parent,
 	bool has_ns = kernfs_ns_enabled(parent);
 	unsigned int hash;
 
-	lockdep_assert_held(&kernfs_mutex);
+	lockdep_assert_held(&kernfs_rwsem);
 
 	if (has_ns != (bool)ns) {
 		WARN(1, KERN_WARNING "kernfs: ns %s in '%s' for '%s'\n",
@@ -818,7 +829,7 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
 	size_t len;
 	char *p, *name;
 
-	lockdep_assert_held(&kernfs_mutex);
+	lockdep_assert_held_read(&kernfs_rwsem);
 
 	/* grab kernfs_rename_lock to piggy back on kernfs_pr_cont_buf */
 	spin_lock_irq(&kernfs_rename_lock);
@@ -858,10 +869,10 @@ struct kernfs_node *kernfs_find_and_get_ns(struct kernfs_node *parent,
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
@@ -882,10 +893,10 @@ struct kernfs_node *kernfs_walk_and_get_ns(struct kernfs_node *parent,
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
@@ -1037,7 +1048,7 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
 
-	mutex_lock(&kernfs_mutex);
+	down_read(&kernfs_rwsem);
 
 	kn = kernfs_dentry_node(dentry);
 
@@ -1082,10 +1093,10 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
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
 
@@ -1103,7 +1114,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	struct inode *inode = NULL;
 	const void *ns = NULL;
 
-	mutex_lock(&kernfs_mutex);
+	down_read(&kernfs_rwsem);
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dir->i_sb)->ns;
 
@@ -1116,7 +1127,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	}
 	/* instantiate and hash (possibly negative) dentry */
 	ret = d_splice_alias(inode, dentry);
-	mutex_unlock(&kernfs_mutex);
+	up_read(&kernfs_rwsem);
 
 	return ret;
 }
@@ -1238,7 +1249,7 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
 {
 	struct rb_node *rbn;
 
-	lockdep_assert_held(&kernfs_mutex);
+	lockdep_assert_held_write(&kernfs_rwsem);
 
 	/* if first iteration, visit leftmost descendant which may be root */
 	if (!pos)
@@ -1274,7 +1285,7 @@ void kernfs_activate(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 
 	pos = NULL;
 	while ((pos = kernfs_next_descendant_post(pos, kn))) {
@@ -1288,14 +1299,14 @@ void kernfs_activate(struct kernfs_node *kn)
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
@@ -1310,7 +1321,7 @@ static void __kernfs_remove(struct kernfs_node *kn)
 	/* prevent any new usage under @kn by deactivating all nodes */
 	pos = NULL;
 	while ((pos = kernfs_next_descendant_post(pos, kn)))
-		if (kernfs_active(pos))
+		if (kernfs_active_write(pos))
 			atomic_add(KN_DEACTIVATED_BIAS, &pos->active);
 
 	/* deactivate and unlink the subtree node-by-node */
@@ -1318,7 +1329,7 @@ static void __kernfs_remove(struct kernfs_node *kn)
 		pos = kernfs_leftmost_descendant(kn);
 
 		/*
-		 * kernfs_drain() drops kernfs_mutex temporarily and @pos's
+		 * kernfs_drain() drops kernfs_rwsem temporarily and @pos's
 		 * base ref could have been put by someone else by the time
 		 * the function returns.  Make sure it doesn't go away
 		 * underneath us.
@@ -1365,9 +1376,9 @@ static void __kernfs_remove(struct kernfs_node *kn)
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
@@ -1454,17 +1465,17 @@ bool kernfs_remove_self(struct kernfs_node *kn)
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
+	 * while kernfs_rwsem for held exclusive.  The ones which lost
+	 * arbitration waits for SUICIDED && drained which can happen only
+	 * after the enclosing kernfs operation which executed the winning
+	 * instance of kernfs_remove_self() finished.
 	 */
 	if (!(kn->flags & KERNFS_SUICIDAL)) {
 		kn->flags |= KERNFS_SUICIDAL;
@@ -1482,9 +1493,9 @@ bool kernfs_remove_self(struct kernfs_node *kn)
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
@@ -1492,12 +1503,12 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 	}
 
 	/*
-	 * This must be done while holding kernfs_mutex; otherwise, waiting
-	 * for SUICIDED && deactivated could finish prematurely.
+	 * This must be done while kernfs_rwsem held exclusive; otherwise,
+	 * waiting for SUICIDED && deactivated could finish prematurely.
 	 */
 	kernfs_unbreak_active_protection(kn);
 
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 	return ret;
 }
 
@@ -1521,13 +1532,13 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
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
@@ -1553,10 +1564,10 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 	if (!kn->parent)
 		return -EINVAL;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 
 	error = -ENOENT;
-	if (!kernfs_active(kn) || !kernfs_active(new_parent) ||
+	if (!kernfs_active_write(kn) || !kernfs_active_write(new_parent) ||
 	    (new_parent->flags & KERNFS_EMPTY_DIR))
 		goto out;
 
@@ -1607,7 +1618,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 
 	error = 0;
  out:
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 	return error;
 }
 
@@ -1627,7 +1638,7 @@ static struct kernfs_node *kernfs_dir_pos(const void *ns,
 	struct kernfs_node *parent, loff_t hash, struct kernfs_node *pos)
 {
 	if (pos) {
-		int valid = kernfs_active(pos) &&
+		int valid = kernfs_active_read(pos) &&
 			pos->parent == parent && hash == pos->hash;
 		kernfs_put(pos);
 		if (!valid)
@@ -1647,7 +1658,7 @@ static struct kernfs_node *kernfs_dir_pos(const void *ns,
 		}
 	}
 	/* Skip over entries which are dying/dead or in the wrong namespace */
-	while (pos && (!kernfs_active(pos) || pos->ns != ns)) {
+	while (pos && (!kernfs_active_read(pos) || pos->ns != ns)) {
 		struct rb_node *node = rb_next(&pos->rb);
 		if (!node)
 			pos = NULL;
@@ -1668,7 +1679,7 @@ static struct kernfs_node *kernfs_dir_next_pos(const void *ns,
 				pos = NULL;
 			else
 				pos = rb_to_kn(node);
-		} while (pos && (!kernfs_active(pos) || pos->ns != ns));
+		} while (pos && (!kernfs_active_read(pos) || pos->ns != ns));
 	}
 	return pos;
 }
@@ -1682,7 +1693,7 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
-	mutex_lock(&kernfs_mutex);
+	down_read(&kernfs_rwsem);
 
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dentry->d_sb)->ns;
@@ -1699,12 +1710,12 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
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
index c757193121475..60e2a86c535eb 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -860,7 +860,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	spin_unlock_irq(&kernfs_notify_lock);
 
 	/* kick fsnotify */
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 
 	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
 		struct kernfs_node *parent;
@@ -898,7 +898,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 		iput(inode);
 	}
 
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 	kernfs_put(kn);
 	goto repeat;
 }
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index d73950fc3d57d..3b01e9e61f14e 100644
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
 
@@ -122,7 +122,7 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (!kn)
 		return -EINVAL;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 	error = setattr_prepare(&init_user_ns, dentry, iattr);
 	if (error)
 		goto out;
@@ -135,7 +135,7 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	setattr_copy(&init_user_ns, inode, iattr);
 
 out:
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 	return error;
 }
 
@@ -191,9 +191,9 @@ int kernfs_iop_getattr(struct user_namespace *mnt_userns,
 	struct inode *inode = d_inode(path->dentry);
 	struct kernfs_node *kn = inode->i_private;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 	kernfs_refresh_inode(kn, inode);
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 
 	generic_fillattr(&init_user_ns, inode, stat);
 	return 0;
@@ -284,9 +284,9 @@ int kernfs_iop_permission(struct user_namespace *mnt_userns,
 
 	kn = inode->i_private;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 	kernfs_refresh_inode(kn, inode);
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 
 	return generic_permission(&init_user_ns, inode, mask);
 }
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index ccc3b44f6306f..cbd4789fac0f5 100644
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
@@ -102,7 +103,7 @@ int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr);
 /*
  * dir.c
  */
-extern struct mutex kernfs_mutex;
+extern struct rw_semaphore kernfs_rwsem;
 extern const struct dentry_operations kernfs_dops;
 extern const struct file_operations kernfs_dir_fops;
 extern const struct inode_operations kernfs_dir_iops;
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 9dc7e7a64e10f..baa4155ba2edf 100644
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
index 5432883d819f2..c8f8e41b84110 100644
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -116,9 +116,9 @@ static int kernfs_getlink(struct inode *inode, char *path)
 	struct kernfs_node *target = kn->symlink.target_kn;
 	int error;
 
-	mutex_lock(&kernfs_mutex);
+	down_read(&kernfs_rwsem);
 	error = kernfs_get_target_path(parent, target, path);
-	mutex_unlock(&kernfs_mutex);
+	up_read(&kernfs_rwsem);
 
 	return error;
 }
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 9e8ca8743c268..1adb6f0c5f836 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -188,7 +188,7 @@ struct kernfs_root {
 	u32			id_highbits;
 	struct kernfs_syscall_ops *syscall_ops;
 
-	/* list of kernfs_super_info of this root, protected by kernfs_mutex */
+	/* list of kernfs_super_info of this root, protected by kernfs_rwsem */
 	struct list_head	supers;
 
 	wait_queue_head_t	deactivate_waitq;


