Return-Path: <linux-fsdevel+bounces-50988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B68AD197A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 10:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A47F63AA539
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 08:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F275283121;
	Mon,  9 Jun 2025 08:00:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79299280A4E
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749456009; cv=none; b=OZN3M7pCNII5nKNsbWlfIyFrb6COk766wAU8BKOSPOV1om+Lg2JByKQdINEih9dGUrhLogWrs583MhvQIo8xlCqwYNtcvhk9h1kF1zgzQDXn6xnt2mw8ho/l6d8Lq9qWnyNQleXDTUBGDNSMqhqzzhSuS8gviyg5UZe6EsUx7Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749456009; c=relaxed/simple;
	bh=NxZqddktA+tsR9BctihM6LJQ59bNP4jov+rqFcmkEGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUlRZKDyDkEIW9ysd+Mr3keNwI4MgkwZfZhIqtJfl2a3G1+Ju9d6j+6RslVUWTXpIUsV6kVUfwNwB16rLhUtoOTn19tB773DY2qXHC6z3zimIb3zGXQgXl15lY2BGIp7POYfZb+D8nTuOroHlbHW7vtf9UghN8kstQ0/mvEsEl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uOXQL-006HU0-53;
	Mon, 09 Jun 2025 08:00:05 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/8] Introduce S_DYING which warns that S_DEAD might follow.
Date: Mon,  9 Jun 2025 17:34:10 +1000
Message-ID: <20250609075950.159417-6-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609075950.159417-1-neil@brown.name>
References: <20250609075950.159417-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once we support directory operations (e.g. create) without requiring the
parent to be locked, the current practice locking a directory while
processing rmdir() or similar will not be sufficient to wait for
operations to complete and to block further operations.

This patch introduced a new inode flag S_DYING.  It indicates that
a rmdir or similar is being processed and new directory operations must
not commence in the directory.  They should not abort either as the
rmdir might fail - instead they should block.  They can do this by
waiting for a lock on the inode.

A new interface rmdir_lock() locks the inode, sets this flag, and waits
for any children with DCACHE_LOCK set to complete their operation, and
for any d_in_lookup() children to complete the lookup.  It should be
called before attempted to delete the directory or set S_DEAD.  Matching
rmdir_unlock() clears the flag and unlocks the inode.

dentry_lock() and d_alloc_parallel() are changed to block while this
flag it set and to fail if the parent IS_DEADDIR(), though dentry_lock()
doesn't block for d_in_lookup() dentries.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst |  10 ++
 fs/btrfs/ioctl.c                      |   4 +-
 fs/configfs/dir.c                     |  24 ++---
 fs/dcache.c                           |  26 ++++-
 fs/fuse/dir.c                         |   4 +-
 fs/internal.h                         |   1 +
 fs/libfs.c                            |   8 +-
 fs/namei.c                            | 139 ++++++++++++++++++++++++--
 include/linux/dcache.h                |   1 +
 include/linux/fs.h                    |   1 +
 include/linux/namei.h                 |   3 +
 11 files changed, 191 insertions(+), 30 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 1feeac9e1483..10dcdcf8be57 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1282,3 +1282,13 @@ the necessary d_lookup_done().  If the caller *knows* which filesystem
 is being used, it may know that this is not possible.  Otherwise it must
 be careful testing if the dentry is positive or negative as the lookup
 may not have been performed yet.
+
+---
+
+*** mandatory**
+
+Code that might set %S_DEAD must use rmdir_lock() on the dentry rather
+than inode_lock() on the inode.  This both locks the inode and waits for
+any child dentrys which are locked, to be unlocked.  rmdir_unlock() is
+then called after %S_DEAD has been set, or after it has been decided not
+to set it.
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 9a3af4049c60..159b6d3f22c1 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2466,9 +2466,9 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 		goto out_unlock;
 	}
 
-	btrfs_inode_lock(BTRFS_I(inode), 0);
+	rmdir_lock(parent);
 	ret = btrfs_delete_subvolume(BTRFS_I(dir), dentry);
-	btrfs_inode_unlock(BTRFS_I(inode), 0);
+	rmdir_unlock(parent);
 	if (!ret)
 		d_delete_notify(dir, dentry);
 
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index ebf32822e29b..965c0e925d17 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -11,6 +11,7 @@
 #undef DEBUG
 
 #include <linux/fs.h>
+#include <linux/namei.h>
 #include <linux/fsnotify.h>
 #include <linux/mount.h>
 #include <linux/module.h>
@@ -660,13 +661,11 @@ static void detach_groups(struct config_group *group)
 
 		child = sd->s_dentry;
 
-		inode_lock(d_inode(child));
-
+		rmdir_lock(child);
 		configfs_detach_group(sd->s_element);
 		d_inode(child)->i_flags |= S_DEAD;
 		dont_mount(child);
-
-		inode_unlock(d_inode(child));
+		rmdir_unlock(child);
 
 		d_delete(child);
 		dput(child);
@@ -853,11 +852,11 @@ static int configfs_attach_item(struct config_item *parent_item,
 			 * the VFS may already have hit and used them. Thus,
 			 * we must lock them as rmdir() would.
 			 */
-			inode_lock(d_inode(dentry));
+			rmdir_lock(dentry);
 			configfs_remove_dir(item);
 			d_inode(dentry)->i_flags |= S_DEAD;
 			dont_mount(dentry);
-			inode_unlock(d_inode(dentry));
+			rmdir_unlock(dentry);
 			d_delete(dentry);
 		}
 	}
@@ -894,7 +893,7 @@ static int configfs_attach_group(struct config_item *parent_item,
 		 * We must also lock the inode to remove it safely in case of
 		 * error, as rmdir() would.
 		 */
-		inode_lock_nested(d_inode(dentry), I_MUTEX_CHILD);
+		rmdir_lock(dentry);
 		configfs_adjust_dir_dirent_depth_before_populate(sd);
 		ret = populate_groups(to_config_group(item), frag);
 		if (ret) {
@@ -903,7 +902,7 @@ static int configfs_attach_group(struct config_item *parent_item,
 			dont_mount(dentry);
 		}
 		configfs_adjust_dir_dirent_depth_after_populate(sd);
-		inode_unlock(d_inode(dentry));
+		rmdir_unlock(dentry);
 		if (ret)
 			d_delete(dentry);
 	}
@@ -1806,7 +1805,8 @@ void configfs_unregister_group(struct config_group *group)
 	frag->frag_dead = true;
 	up_write(&frag->frag_sem);
 
-	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
+	rmdir_lock(parent);
+
 	spin_lock(&configfs_dirent_lock);
 	configfs_detach_prep(dentry, NULL);
 	spin_unlock(&configfs_dirent_lock);
@@ -1816,7 +1816,7 @@ void configfs_unregister_group(struct config_group *group)
 	dont_mount(dentry);
 	d_drop(dentry);
 	fsnotify_rmdir(d_inode(parent), dentry);
-	inode_unlock(d_inode(parent));
+	rmdir_unlock(parent);
 
 	dput(dentry);
 
@@ -1952,7 +1952,7 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 
 	inode_lock_nested(d_inode(root),
 			  I_MUTEX_PARENT);
-	inode_lock_nested(d_inode(dentry), I_MUTEX_CHILD);
+	rmdir_lock(dentry);
 	mutex_lock(&configfs_symlink_mutex);
 	spin_lock(&configfs_dirent_lock);
 	if (configfs_detach_prep(dentry, NULL)) {
@@ -1963,7 +1963,7 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 	configfs_detach_group(&group->cg_item);
 	d_inode(dentry)->i_flags |= S_DEAD;
 	dont_mount(dentry);
-	inode_unlock(d_inode(dentry));
+	rmdir_unlock(dentry);
 
 	d_drop(dentry);
 	fsnotify_rmdir(d_inode(root), dentry);
diff --git a/fs/dcache.c b/fs/dcache.c
index b5cef2963169..78ec5ab58362 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2550,7 +2550,7 @@ static inline void end_dir_add(struct inode *dir, unsigned int n,
 	d_wake_waiters(d_wait, de);
 }
 
-static void d_wait_lookup(struct dentry *dentry)
+void d_wait_lookup(struct dentry *dentry)
 {
 	if (d_in_lookup(dentry)) {
 		struct par_wait_key wk = {
@@ -2672,10 +2672,30 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 		return dentry;
 	}
 	rcu_read_unlock();
-	/* we can't take ->d_lock here; it's OK, though. */
-	new->d_flags |= DCACHE_PAR_LOOKUP;
+	/*
+	 * we can't take ->d_lock here; it's OK, though as there is no concurrency.
+	 * barrier ensure rmdir_lock() will see the flag or we will see S_DYING
+	 */
+	smp_store_mb(new->d_flags, new->d_flags | DCACHE_PAR_LOOKUP);
 	/* Don't set a wait_queue until someone is actually waiting */
 	new->d_wait = NULL;
+	if (parent->d_inode->i_flags & (S_DYING | S_DEAD)) {
+		new->d_flags &= DCACHE_PAR_LOOKUP;
+		hlist_bl_del(&new->d_u.d_in_lookup_hash);
+		hlist_bl_unlock(b);
+		/* rmdir_lock() might be waiting already ! */
+		__d_lookup_unhash_wake(new);
+		if (!(parent->d_inode->i_flags & S_DEAD)) {
+			inode_lock(parent->d_inode);
+			/* S_DYING must be clean now */
+			inode_unlock(parent->d_inode);
+		}
+		if (parent->d_inode->i_flags & S_DEAD) {
+			dput(new);
+			return ERR_PTR(-ENOENT);
+		}
+		goto retry;
+	}
 	hlist_bl_add_head(&new->d_u.d_in_lookup_hash, b);
 	hlist_bl_unlock(b);
 	return new;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 3118191ea290..3d379678992e 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1427,7 +1427,7 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
 	fuse_invalidate_entry_cache(entry);
 
 	if (child_nodeid != 0 && d_really_is_positive(entry)) {
-		inode_lock(d_inode(entry));
+		rmdir_lock(entry);
 		if (get_node_id(d_inode(entry)) != child_nodeid) {
 			err = -ENOENT;
 			goto badentry;
@@ -1448,7 +1448,7 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
 		clear_nlink(d_inode(entry));
 		err = 0;
  badentry:
-		inode_unlock(d_inode(entry));
+		rmdir_unlock(entry);
 		if (!err)
 			d_delete(entry);
 	} else {
diff --git a/fs/internal.h b/fs/internal.h
index d40d1d479a46..2462d67d84f6 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -231,6 +231,7 @@ extern void d_genocide(struct dentry *);
 extern bool dentry_trylock(struct dentry *dentry,
 			     struct dentry *base,
 			     const struct qstr *last);
+void d_wait_lookup(struct dentry *dentry);
 
 /*
  * The name "dentry_unlock()" is current used for unlocking the parent
diff --git a/fs/libfs.c b/fs/libfs.c
index 9ea0ecc325a8..cfd85fe7b8ee 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -613,9 +613,13 @@ void simple_recursive_removal(struct dentry *dentry,
 		struct dentry *victim = NULL, *child;
 		struct inode *inode = this->d_inode;
 
-		inode_lock(inode);
-		if (d_is_dir(this))
+		if (d_is_dir(this)) {
+			rmdir_lock(this);
 			inode->i_flags |= S_DEAD;
+			rmdir_unlock(this);
+		}
+
+		inode_lock(inode);
 		while ((child = find_next_child(this, victim)) == NULL) {
 			// kill and ascend
 			// update metadata while it's still locked
diff --git a/fs/namei.c b/fs/namei.c
index 4ad76df21677..c590f25d0d49 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1770,8 +1770,11 @@ static bool __dentry_lock(struct dentry *dentry,
 			  struct dentry *base, const struct qstr *last,
 			  unsigned int subclass, int state)
 {
+	struct dentry *parent;
+	struct inode *dir;
 	int err;
 
+retry:
 	lock_acquire_exclusive(&dentry->dentry_map, subclass, 0, NULL, _THIS_IP_);
 	spin_lock(&dentry->d_lock);
 	err = wait_var_event_any_lock(&dentry->d_flags,
@@ -1782,10 +1785,43 @@ static bool __dentry_lock(struct dentry *dentry,
 		spin_unlock(&dentry->d_lock);
 		return false;
 	}
-
-	dentry->d_flags |= DCACHE_LOCK;
+	parent = dentry->d_parent;
+	/*
+	 * memory barrier ensures rmdir_lock() will see the lock,
+	 * or we will subsequently see S_DYING or S_DEAD
+	 */
+	smp_store_mb(dentry->d_flags, dentry->d_flags | DCACHE_LOCK);
+	/* in-lookup dentries can bypass S_DYING tests because the test
+	 * was done in d_alloc_parallel()
+	 */
+	if (d_in_lookup(dentry) ||
+	    !(parent->d_inode->i_flags & (S_DYING | S_DEAD))) {
+		spin_unlock(&dentry->d_lock);
+		return true;
+	}
+	/* Cannot lock while parent is dying */
+	dentry->d_flags &= ~DCACHE_LOCK;
+	if (IS_DEADDIR(parent->d_inode)) {
+		lock_map_release(&dentry->dentry_map);
+		spin_unlock(&dentry->d_lock);
+		return false;
+	}
+	dir = igrab(parent->d_inode);
+	lock_map_release(&dentry->dentry_map);
 	spin_unlock(&dentry->d_lock);
-	return true;
+
+	if (state == TASK_KILLABLE) {
+		err = down_write_killable(&dir->i_rwsem);
+		if (err) {
+			iput(dir);
+			return false;
+		}
+	} else
+		inode_lock(dir);
+	/* S_DYING much be clear now */
+	inode_unlock(dir);
+	iput(dir);
+	goto retry;
 }
 
 /**
@@ -1860,6 +1896,89 @@ bool dentry_trylock(struct dentry *dentry,
 	return ret;
 }
 
+static bool dentry_wait_locked(struct dentry *dentry)
+{
+	int ret;
+
+	/*
+	 * We might be in rename holding two dentry locks already.
+	 * Here we wait on a child of one of those so use a different
+	 * nesting level.
+	 */
+	lock_acquire_exclusive(&dentry->dentry_map, DLOCK_DYING_WAIT,
+			       0, NULL, _THIS_IP_);
+	spin_lock(&dentry->d_lock);
+	ret = wait_var_event_spinlock(&dentry->d_flags,
+				      !check_dentry_locked(dentry),
+				      &dentry->d_lock);
+	spin_unlock(&dentry->d_lock);
+	lock_map_release(&dentry->dentry_map);
+	return ret == 0;
+}
+
+/** rmdir_lock - wait for all operations in directory to complete
+ * @dentry: dentry for the directory
+ *
+ * When removing a directory it is necessary to wait for pending operations
+ * (e.g. create) in the directory to complete and to block further operations.
+ * rmdir_lock() achieves this by marking the inode as dying and waiting
+ * for any locked children to unlock.
+ *
+ * If removal of the directory is successeful, S_DEAD should be set. In any case
+ * rmdir_unlock() must be called after either success or failure.
+ */
+void rmdir_lock(struct dentry *dentry)
+{
+	struct dentry *child;
+	struct inode *dir = d_inode(dentry);
+
+	inode_lock_nested(dir, I_MUTEX_CHILD);
+
+	/* memory barrier matches that in dcache_lock() */
+	smp_store_mb(dir->i_flags, dir->i_flags | S_DYING);
+	/*
+	 * Any attempt to lock a child will now block on parent lock.
+	 * Must wait for any locked children to be unlocked
+	 */
+again:
+	spin_lock(&dentry->d_lock);
+	for (child = d_first_child(dentry); child;
+	     child = d_next_sibling(child)) {
+		if (child->d_flags & DCACHE_LOCK) {
+			spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
+			dget_dlock(child);
+			spin_unlock(&child->d_lock);
+			spin_unlock(&dentry->d_lock);
+			dentry_wait_locked(child);
+			dput(child);
+			goto again;
+		}
+		if (d_in_lookup(child)) {
+			spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
+			dget_dlock(child);
+			spin_unlock(&child->d_lock);
+			spin_unlock(&dentry->d_lock);
+			d_wait_lookup(child);
+			dput(child);
+			goto again;
+		}
+	}
+	spin_unlock(&dentry->d_lock);
+}
+EXPORT_SYMBOL(rmdir_lock);
+
+/** rmdir_unlock - remove the block imposed by rmdir_lock()
+ * @dentry: dentry for directory
+ *
+ * Every call to rmdir_lock() must be paired with a call to rmdir_unlock().
+ */
+void rmdir_unlock(struct dentry *dentry)
+{
+	d_inode(dentry)->i_flags &= ~S_DYING;
+	inode_unlock(d_inode(dentry));
+}
+EXPORT_SYMBOL(rmdir_unlock);
+
 /**
  * lookup_and_lock_hashed - lookup and lock a name prior to dir ops
  * @last: the name in the given directory
@@ -4953,7 +5072,7 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
 		return -EPERM;
 
 	dget(dentry);
-	inode_lock(dentry->d_inode);
+	rmdir_lock(dentry);
 
 	error = -EBUSY;
 	if (is_local_mountpoint(dentry) ||
@@ -4974,7 +5093,7 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
 	detach_mounts(dentry);
 
 out:
-	inode_unlock(dentry->d_inode);
+	rmdir_unlock(dentry);
 	dput(dentry);
 	if (!error)
 		d_delete_notify(dir, dentry);
@@ -5592,10 +5711,10 @@ int vfs_rename(struct renamedata *rd)
 		if (lock_old_subdir)
 			inode_lock_nested(source, I_MUTEX_CHILD);
 		if (target && (!new_is_dir || lock_new_subdir))
-			inode_lock(target);
+			rmdir_lock(new_dentry);
 	} else if (new_is_dir) {
 		if (lock_new_subdir)
-			inode_lock_nested(target, I_MUTEX_CHILD);
+			rmdir_lock(new_dentry);
 		inode_lock(source);
 	} else {
 		lock_two_nondirectories(source, target);
@@ -5647,10 +5766,12 @@ int vfs_rename(struct renamedata *rd)
 			d_exchange(old_dentry, new_dentry);
 	}
 out:
+	if (target && new_is_dir && !(flags & RENAME_EXCHANGE)) // IS THIS CORRECT?
+		rmdir_unlock(new_dentry);
+	else if (target && (!new_is_dir || lock_new_subdir))
+		inode_unlock(target);
 	if (!is_dir || lock_old_subdir)
 		inode_unlock(source);
-	if (target && (!new_is_dir || lock_new_subdir))
-		inode_unlock(target);
 	dput(new_dentry);
 	if (!error) {
 		fsnotify_move(old_dir, new_dir, &old_name.name, is_dir,
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index c150d3f10a3d..2c7a2326367b 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -238,6 +238,7 @@ enum dentry_flags {
 enum {
 	DLOCK_NORMAL,
 	DLOCK_RENAME,		/* dentry with higher address in rename */
+	DLOCK_DYING_WAIT,	/* child of a locked parent that is dying */
 };
 
 extern seqlock_t rename_lock;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 24bc29efecd5..d7fa38668987 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2395,6 +2395,7 @@ struct super_operations {
 #define S_CASEFOLD	(1 << 15) /* Casefolded file */
 #define S_VERITY	(1 << 16) /* Verity file (using fs/verity/) */
 #define S_KERNEL_FILE	(1 << 17) /* File is in use by the kernel (eg. fs/cachefiles) */
+#define S_DYING		(1 << 18) /* dir is locked ready to set S_DEAD */
 #define S_ANON_INODE	(1 << 19) /* Inode is an anonymous inode */
 
 /*
diff --git a/include/linux/namei.h b/include/linux/namei.h
index aa5bcdbe705d..6c9b545c60ce 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -90,6 +90,9 @@ struct dentry *lookup_and_lock_hashed(struct qstr *last, struct dentry *base,
 void dentry_unlock(struct dentry *dentry);
 void dentry_unlock_dir_locked(struct dentry *dentry);
 
+void rmdir_lock(struct dentry *dentry);
+void rmdir_unlock(struct dentry *dentry);
+
 extern int follow_down_one(struct path *);
 extern int follow_down(struct path *path, unsigned int flags);
 extern int follow_up(struct path *);
-- 
2.49.0


