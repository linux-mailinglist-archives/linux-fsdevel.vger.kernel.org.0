Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92BDF3CB55C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 11:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbhGPJko (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 05:40:44 -0400
Received: from icp-osb-irony-out9.external.iinet.net.au ([203.59.1.226]:22628
        "EHLO icp-osb-irony-out9.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234171AbhGPJkm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 05:40:42 -0400
X-SMTP-MATCH: 0
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A3Psp5Kh+8mu4r5gWjz8DT+hA1XBQXvEji2?=
 =?us-ascii?q?hC6mlwRA09TyX4raCTdZEgviMc5wx6ZJhNo7290cq7IE80l6Qb3WB5B97LYO?=
 =?us-ascii?q?CMggWVxe9ZgbcLQ1Xbak7DHm0079YYT0BUY+eAb2STh63BkXGF+1FJ+qjhzE?=
 =?us-ascii?q?gr7d2uqUuEzGlRGsRdB4IQMHf+LnFL?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2A3DAA6UPFg/y2ELHlaHgEBCxIMQAm?=
 =?us-ascii?q?BRQsCg3ZshAJGkBMBAQEBAQEGgUCBE4lWhQVqX4opFIFoCwEBAQEBAQEBAUo?=
 =?us-ascii?q?EAQGEVAKCfAElNAkOAgQVAQEBBQEBAQEBBgMBgQ6FdUMBAQQHAYV1BiMEUhA?=
 =?us-ascii?q?YDQIYDgICRxAGARKFUyWnZ38zGgJlgQGJQoEQKgGHCIJog3onHH2BEIEVMwO?=
 =?us-ascii?q?BBYEzdYQqgzGCZASDFwEWZQkKAX94CSgXY5EugnsBRohtgSxbnQyDLp5kF5V?=
 =?us-ascii?q?PA5B1lgiffgcfhmqCFE0uCjuCaVAZjjgBFo46Ny84AgYKAQEDCYJyhHqCJiy?=
 =?us-ascii?q?CGwEB?=
X-IPAS-Result: =?us-ascii?q?A2A3DAA6UPFg/y2ELHlaHgEBCxIMQAmBRQsCg3ZshAJGk?=
 =?us-ascii?q?BMBAQEBAQEGgUCBE4lWhQVqX4opFIFoCwEBAQEBAQEBAUoEAQGEVAKCfAElN?=
 =?us-ascii?q?AkOAgQVAQEBBQEBAQEBBgMBgQ6FdUMBAQQHAYV1BiMEUhAYDQIYDgICRxAGA?=
 =?us-ascii?q?RKFUyWnZ38zGgJlgQGJQoEQKgGHCIJog3onHH2BEIEVMwOBBYEzdYQqgzGCZ?=
 =?us-ascii?q?ASDFwEWZQkKAX94CSgXY5EugnsBRohtgSxbnQyDLp5kF5VPA5B1lgiffgcfh?=
 =?us-ascii?q?mqCFE0uCjuCaVAZjjgBFo46Ny84AgYKAQEDCYJyhHqCJiyCGwEB?=
X-IronPort-AV: E=Sophos;i="5.84,244,1620662400"; 
   d="scan'208";a="329873587"
Received: from unknown (HELO web.messagingengine.com) ([121.44.132.45])
  by icp-osb-irony-out9.iinet.net.au with ESMTP; 16 Jul 2021 17:28:29 +0800
Subject: [PATCH v8 3/5] kernfs: switch kernfs to use an rwsem
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Eric Sandeen <sandeen@sandeen.net>, Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 16 Jul 2021 17:28:29 +0800
Message-ID: <162642770946.63632.2218304587223241374.stgit@web.messagingengine.com>
In-Reply-To: <162642752894.63632.5596341704463755308.stgit@web.messagingengine.com>
References: <162642752894.63632.5596341704463755308.stgit@web.messagingengine.com>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The kernfs global lock restricts the ability to perform kernfs node
lookup operations in parallel during path walks.

Change the kernfs mutex to an rwsem so that, when opportunity arises,
node searches can be done in parallel with path walk lookups.

Signed-off-by: Ian Kent <raven@themaw.net>
Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/kernfs/dir.c             |  100 ++++++++++++++++++++++---------------------
 fs/kernfs/file.c            |    4 +-
 fs/kernfs/inode.c           |   16 +++----
 fs/kernfs/kernfs-internal.h |    5 +-
 fs/kernfs/mount.c           |   12 +++--
 fs/kernfs/symlink.c         |    4 +-
 include/linux/kernfs.h      |    2 -
 7 files changed, 72 insertions(+), 71 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 0b21a8f961ac..4994723d6cf7 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -17,7 +17,7 @@
 
 #include "kernfs-internal.h"
 
-DEFINE_MUTEX(kernfs_mutex);
+DECLARE_RWSEM(kernfs_rwsem);
 static DEFINE_SPINLOCK(kernfs_rename_lock);	/* kn->parent and ->name */
 static char kernfs_pr_cont_buf[PATH_MAX];	/* protected by rename_lock */
 static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
@@ -26,7 +26,7 @@ static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
 
 static bool kernfs_active(struct kernfs_node *kn)
 {
-	lockdep_assert_held(&kernfs_mutex);
+	lockdep_assert_held(&kernfs_rwsem);
 	return atomic_read(&kn->active) >= 0;
 }
 
@@ -340,7 +340,7 @@ static int kernfs_sd_compare(const struct kernfs_node *left,
  *	@kn->parent->dir.children.
  *
  *	Locking:
- *	mutex_lock(kernfs_mutex)
+ *	kernfs_rwsem held exclusive
  *
  *	RETURNS:
  *	0 on susccess -EEXIST on failure.
@@ -386,7 +386,7 @@ static int kernfs_link_sibling(struct kernfs_node *kn)
  *	removed, %false if @kn wasn't on the rbtree.
  *
  *	Locking:
- *	mutex_lock(kernfs_mutex)
+ *	kernfs_rwsem held exclusive
  */
 static bool kernfs_unlink_sibling(struct kernfs_node *kn)
 {
@@ -457,14 +457,14 @@ void kernfs_put_active(struct kernfs_node *kn)
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
@@ -483,7 +483,7 @@ static void kernfs_drain(struct kernfs_node *kn)
 
 	kernfs_drain_open_files(kn);
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 }
 
 /**
@@ -722,7 +722,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 	bool has_ns;
 	int ret;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 
 	ret = -EINVAL;
 	has_ns = kernfs_ns_enabled(parent);
@@ -753,7 +753,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 		ps_iattr->ia_mtime = ps_iattr->ia_ctime;
 	}
 
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 
 	/*
 	 * Activate the new node unless CREATE_DEACTIVATED is requested.
@@ -767,7 +767,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 	return 0;
 
 out_unlock:
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 	return ret;
 }
 
@@ -788,7 +788,7 @@ static struct kernfs_node *kernfs_find_ns(struct kernfs_node *parent,
 	bool has_ns = kernfs_ns_enabled(parent);
 	unsigned int hash;
 
-	lockdep_assert_held(&kernfs_mutex);
+	lockdep_assert_held(&kernfs_rwsem);
 
 	if (has_ns != (bool)ns) {
 		WARN(1, KERN_WARNING "kernfs: ns %s in '%s' for '%s'\n",
@@ -820,7 +820,7 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
 	size_t len;
 	char *p, *name;
 
-	lockdep_assert_held(&kernfs_mutex);
+	lockdep_assert_held_read(&kernfs_rwsem);
 
 	/* grab kernfs_rename_lock to piggy back on kernfs_pr_cont_buf */
 	spin_lock_irq(&kernfs_rename_lock);
@@ -860,10 +860,10 @@ struct kernfs_node *kernfs_find_and_get_ns(struct kernfs_node *parent,
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
@@ -884,10 +884,10 @@ struct kernfs_node *kernfs_walk_and_get_ns(struct kernfs_node *parent,
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
@@ -1046,18 +1046,18 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 		/* If the kernfs parent node has changed discard and
 		 * proceed to ->lookup.
 		 */
-		mutex_lock(&kernfs_mutex);
+		down_read(&kernfs_rwsem);
 		spin_lock(&dentry->d_lock);
 		parent = kernfs_dentry_node(dentry->d_parent);
 		if (parent) {
 			if (kernfs_dir_changed(parent, dentry)) {
 				spin_unlock(&dentry->d_lock);
-				mutex_unlock(&kernfs_mutex);
+				up_read(&kernfs_rwsem);
 				return 0;
 			}
 		}
 		spin_unlock(&dentry->d_lock);
-		mutex_unlock(&kernfs_mutex);
+		up_read(&kernfs_rwsem);
 
 		/* The kernfs parent node hasn't changed, leave the
 		 * dentry negative and return success.
@@ -1066,7 +1066,7 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	}
 
 	kn = kernfs_dentry_node(dentry);
-	mutex_lock(&kernfs_mutex);
+	down_read(&kernfs_rwsem);
 
 	/* The kernfs node has been deactivated */
 	if (!kernfs_active(kn))
@@ -1085,10 +1085,10 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	    kernfs_info(dentry->d_sb)->ns != kn->ns)
 		goto out_bad;
 
-	mutex_unlock(&kernfs_mutex);
+	up_read(&kernfs_rwsem);
 	return 1;
 out_bad:
-	mutex_unlock(&kernfs_mutex);
+	up_read(&kernfs_rwsem);
 	return 0;
 }
 
@@ -1106,7 +1106,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	struct inode *inode = NULL;
 	const void *ns = NULL;
 
-	mutex_lock(&kernfs_mutex);
+	down_read(&kernfs_rwsem);
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dir->i_sb)->ns;
 
@@ -1122,7 +1122,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 		kernfs_set_rev(parent, dentry);
 	/* instantiate and hash (possibly negative) dentry */
 	ret = d_splice_alias(inode, dentry);
-	mutex_unlock(&kernfs_mutex);
+	up_read(&kernfs_rwsem);
 
 	return ret;
 }
@@ -1244,7 +1244,7 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
 {
 	struct rb_node *rbn;
 
-	lockdep_assert_held(&kernfs_mutex);
+	lockdep_assert_held_write(&kernfs_rwsem);
 
 	/* if first iteration, visit leftmost descendant which may be root */
 	if (!pos)
@@ -1280,7 +1280,7 @@ void kernfs_activate(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 
 	pos = NULL;
 	while ((pos = kernfs_next_descendant_post(pos, kn))) {
@@ -1294,14 +1294,14 @@ void kernfs_activate(struct kernfs_node *kn)
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
@@ -1324,7 +1324,7 @@ static void __kernfs_remove(struct kernfs_node *kn)
 		pos = kernfs_leftmost_descendant(kn);
 
 		/*
-		 * kernfs_drain() drops kernfs_mutex temporarily and @pos's
+		 * kernfs_drain() drops kernfs_rwsem temporarily and @pos's
 		 * base ref could have been put by someone else by the time
 		 * the function returns.  Make sure it doesn't go away
 		 * underneath us.
@@ -1371,9 +1371,9 @@ static void __kernfs_remove(struct kernfs_node *kn)
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
@@ -1460,17 +1460,17 @@ bool kernfs_remove_self(struct kernfs_node *kn)
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
@@ -1488,9 +1488,9 @@ bool kernfs_remove_self(struct kernfs_node *kn)
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
@@ -1498,12 +1498,12 @@ bool kernfs_remove_self(struct kernfs_node *kn)
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
 
@@ -1527,13 +1527,13 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
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
@@ -1559,7 +1559,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 	if (!kn->parent)
 		return -EINVAL;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 
 	error = -ENOENT;
 	if (!kernfs_active(kn) || !kernfs_active(new_parent) ||
@@ -1613,7 +1613,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 
 	error = 0;
  out:
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 	return error;
 }
 
@@ -1688,7 +1688,7 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
-	mutex_lock(&kernfs_mutex);
+	down_read(&kernfs_rwsem);
 
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dentry->d_sb)->ns;
@@ -1705,12 +1705,12 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
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
index c75719312147..60e2a86c535e 100644
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
index 26f2aa3586f9..dad749f39518 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -100,9 +100,9 @@ int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 {
 	int ret;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 	ret = __kernfs_setattr(kn, iattr);
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 	return ret;
 }
 
@@ -116,7 +116,7 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (!kn)
 		return -EINVAL;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 	error = setattr_prepare(&init_user_ns, dentry, iattr);
 	if (error)
 		goto out;
@@ -129,7 +129,7 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	setattr_copy(&init_user_ns, inode, iattr);
 
 out:
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 	return error;
 }
 
@@ -185,9 +185,9 @@ int kernfs_iop_getattr(struct user_namespace *mnt_userns,
 	struct inode *inode = d_inode(path->dentry);
 	struct kernfs_node *kn = inode->i_private;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 	kernfs_refresh_inode(kn, inode);
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 
 	generic_fillattr(&init_user_ns, inode, stat);
 	return 0;
@@ -278,9 +278,9 @@ int kernfs_iop_permission(struct user_namespace *mnt_userns,
 
 	kn = inode->i_private;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 	kernfs_refresh_inode(kn, inode);
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 
 	return generic_permission(&init_user_ns, inode, mask);
 }
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index c2ae58f3b202..f9cc912c31e1 100644
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
@@ -121,7 +122,7 @@ int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr);
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
index 5432883d819f..c8f8e41b8411 100644
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
index d68b4ad09573..1093abf7c28c 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -193,7 +193,7 @@ struct kernfs_root {
 	u32			id_highbits;
 	struct kernfs_syscall_ops *syscall_ops;
 
-	/* list of kernfs_super_info of this root, protected by kernfs_mutex */
+	/* list of kernfs_super_info of this root, protected by kernfs_rwsem */
 	struct list_head	supers;
 
 	wait_queue_head_t	deactivate_waitq;


