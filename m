Return-Path: <linux-fsdevel+bounces-50987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2814AD1979
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 10:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68BC3AC519
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 08:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5520428137D;
	Mon,  9 Jun 2025 08:00:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F02B27FB3D
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749456008; cv=none; b=AMc204CdbQR02/yBDk2F7P66bskN8SKWWs46PdPNYLKAlE6gRsVozFQ3hKqyFqupY4ucaIH0nO2YwNaiB1vD5ys7oawrtYhAQNKl3587kw7+6rju+N95OLgeR/XYGJDDeQ/OCMbiWnhAJgEoTCDlx3Megr0nDr+/6Gk03YUgbqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749456008; c=relaxed/simple;
	bh=oI9D7JJP8S5uEkKMIFRhKaeNDys0hVNZTJZWPqB+J7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nef0sQz5/Y6ptNeW/1DaQkcNic9/DWuHbbjM6TIWVYhoISvDHDNDzubqx92FRWLOkgecLxrGbkg1eeSyxG5nTFbxArgUmVkaewgldUXeIrtf6yTl9E07KduXhrYkKxrScMrQZEaiQRrDo9T0pNUNQuVsoiyie34iCo7xDBU4twU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uOXQK-006HTv-Hm;
	Mon, 09 Jun 2025 08:00:04 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/8] VFS: Add ability to exclusively lock a dentry and use for open/create
Date: Mon,  9 Jun 2025 17:34:09 +1000
Message-ID: <20250609075950.159417-5-neil@brown.name>
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

dentry_lock(), dentry_trylock(), __dentry_unlock() are added which can be
used to get an exclusive lock on a dentry in preparation for a directory
operation on the name.  It is planned for this to be used to provide
name-based exclusive access to create (mkdir, mknod, symlink, link,
create) a name, to remove (unlink, rmdir) a name, to rename between 2
names (rename) or to open (atomic_open) a name.  This will allow i_rwsem
to be deprecated for directories.

Note that lookup does not require this exclusion as it is only performed
on d_in_lookup() dentries which already provide exclusive access.

As contention on a name is rare this locking is optimised for the
uncontended case.  A bit is set under the d_lock spinlock to claim a
lock, and wait_var_event_spinlock() is used when waiting is needed.  To
avoid sending a wakeup when not needed we have a second bit flag to
indicate if there are any waiters.

Once the exclusive lock is obtained on the dentry we must make sure it
wasn't unlinked or renamed while we slept.  If it was, dentry_lock()
will fail so the (in-cache) lookup can be repeated.

For this patch the lock is only taken for "open" when a positive dentry
is NOT found.  This is currently uncontended as the i_rwsem is still
held on the directory.  A future patch will make that locking optional.

The notify_create() calls are moved into the region where the dentry is
locked to ensure continuing exclusion.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/dcache.c            |  26 ++++++-
 fs/internal.h          |  20 +++++
 fs/namei.c             | 173 +++++++++++++++++++++++++++++++++++++++--
 include/linux/dcache.h |  11 +++
 4 files changed, 221 insertions(+), 9 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index c21122ccea4f..b5cef2963169 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1680,9 +1680,10 @@ EXPORT_SYMBOL(d_invalidate);
  * available. On a success the dentry is returned. The name passed in is
  * copied and the copy passed in may be reused after this call.
  */
- 
+
 static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 {
+	static struct lock_class_key __key;
 	struct dentry *dentry;
 	char *dname;
 	int err;
@@ -1740,6 +1741,8 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	INIT_HLIST_NODE(&dentry->d_sib);
 	d_set_d_op(dentry, dentry->d_sb->s_d_op);
 
+	lockdep_init_map(&dentry->dentry_map, "DCACHE_LOCK", &__key, 0);
+
 	if (dentry->d_op && dentry->d_op->d_init) {
 		err = dentry->d_op->d_init(dentry);
 		if (err) {
@@ -2988,6 +2991,10 @@ static int __d_unalias(struct dentry *dentry, struct dentry *alias)
 	struct rw_semaphore *m2 = NULL;
 	int ret = -ESTALE;
 
+	if (dentry->d_flags & DCACHE_LOCK) {
+		if (!dentry_trylock(alias, NULL, NULL))
+			return ret;
+	}
 	/* If alias and dentry share a parent, then no extra locks required */
 	if (alias->d_parent == dentry->d_parent)
 		goto out_unalias;
@@ -3012,6 +3019,12 @@ static int __d_unalias(struct dentry *dentry, struct dentry *alias)
 		up_read(m2);
 	if (m1)
 		mutex_unlock(m1);
+	if (dentry->d_flags & DCACHE_LOCK) {
+		if (ret)
+			__dentry_unlock(alias);
+		else
+			__dentry_unlock(dentry);
+	}
 	return ret;
 }
 
@@ -3033,6 +3046,9 @@ static int __d_unalias(struct dentry *dentry, struct dentry *alias)
  * If a dentry was found and moved, then it is returned.  Otherwise NULL
  * is returned.  This matches the expected return value of ->lookup.
  *
+ * If a different dentry is returned, any DCACHE_LOCK on the original
+ * dentry will be transferred to the new.
+ *
  * Cluster filesystems may call this function with a negative, hashed dentry.
  * In that case, we know that the inode will be a regular file, and also this
  * will only occur during atomic_open. So we need to check for the dentry
@@ -3074,7 +3090,15 @@ struct dentry *d_splice_alias(struct inode *inode, struct dentry *dentry)
 				}
 				dput(old_parent);
 			} else {
+				if (dentry->d_flags & DCACHE_LOCK)
+					/* This must succeed because IS_ROOT() dentries
+					 * are never locked - except temporarily
+					 * here while rename_lock is held.
+					 */
+					dentry_trylock(new, NULL, NULL);
 				__d_move(new, dentry, false);
+				if (dentry->d_flags & DCACHE_LOCK)
+					__dentry_unlock(dentry);
 				write_sequnlock(&rename_lock);
 			}
 			iput(inode);
diff --git a/fs/internal.h b/fs/internal.h
index 393f6c5c24f6..d40d1d479a46 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -228,6 +228,26 @@ extern struct dentry *__d_lookup_rcu(const struct dentry *parent,
 				const struct qstr *name, unsigned *seq);
 extern void d_genocide(struct dentry *);
 
+extern bool dentry_trylock(struct dentry *dentry,
+			     struct dentry *base,
+			     const struct qstr *last);
+
+/*
+ * The name "dentry_unlock()" is current used for unlocking the parent
+ * directory.  Once we dispense with locking the dentry, that name can
+ * be used for this function.
+ */
+static inline void __dentry_unlock(struct dentry *dentry)
+{
+	WARN_ON(!(dentry->d_flags & DCACHE_LOCK));
+	lock_map_release(&dentry->dentry_map);
+	spin_lock(&dentry->d_lock);
+	if (dentry->d_flags & DCACHE_LOCK_WAITER)
+		wake_up_var_locked(&dentry->d_flags, &dentry->d_lock);
+	dentry->d_flags &= ~(DCACHE_LOCK | DCACHE_LOCK_WAITER);
+	spin_unlock(&dentry->d_lock);
+}
+
 /*
  * pipe.c
  */
diff --git a/fs/namei.c b/fs/namei.c
index e1749fb03cb5..4ad76df21677 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1723,6 +1723,142 @@ static struct dentry *lookup_one_qstr(const struct qstr *name,
 	}
 	return dentry;
 }
+/*
+ * dentry locking for updates.
+ * When modifying a directory the target dentry will be locked by
+ * setting DCACHE_LOCK under ->d_lock.  If it is already set,
+ * DCACHE_LOCK_WAITER is set to ensure a wakeup is sent, and we wait
+ * using wait_var_event_any_lock().
+ * Conceptually the name in the parent is locked, so if a dentry has no
+ * name or parent is can not be locked.  So an IS_ROOT() dentry is never
+ * locked.
+ */
+
+static bool check_dentry_locked(struct dentry *de)
+{
+	if (de->d_flags & DCACHE_LOCK) {
+		de->d_flags |= DCACHE_LOCK_WAITER;
+		return true;
+	}
+	return false;
+}
+
+static bool dentry_matches(struct dentry *dentry,
+			   struct dentry *base, const struct qstr *last)
+{
+	if (d_unhashed(dentry) && !d_in_lookup(dentry))
+		/* An unhashed dentry can never be locked */
+		return false;
+	if (d_is_negative(dentry))
+		/* Negative dentries are never unlinked or renamed,
+		 * there is no race we could have lost and no need to check.
+		 */
+		return true;
+	if (!base)
+		/* No matching required */
+		return true;
+	if (dentry->d_parent != base)
+		return false;
+	if (last &&
+	    (dentry->d_name.hash != last->hash ||
+	     !d_same_name(dentry, base, last)))
+		return false;
+	return true;
+}
+
+static bool __dentry_lock(struct dentry *dentry,
+			  struct dentry *base, const struct qstr *last,
+			  unsigned int subclass, int state)
+{
+	int err;
+
+	lock_acquire_exclusive(&dentry->dentry_map, subclass, 0, NULL, _THIS_IP_);
+	spin_lock(&dentry->d_lock);
+	err = wait_var_event_any_lock(&dentry->d_flags,
+				      !check_dentry_locked(dentry),
+				      &dentry->d_lock, spin, state);
+	if (err || !dentry_matches(dentry, base, last)) {
+		lock_map_release(&dentry->dentry_map);
+		spin_unlock(&dentry->d_lock);
+		return false;
+	}
+
+	dentry->d_flags |= DCACHE_LOCK;
+	spin_unlock(&dentry->d_lock);
+	return true;
+}
+
+/**
+ * dentry_lock - lock a dentry in preparation for create/remove/rename
+ * @dentry:	the dentry to be locked
+ * @base:	the parent the dentry must still have after being locked, or NULL
+ * @last:	the name the dentry must still have after being locked, or NULL
+ * @state:	the process state to wait in.
+ *
+ * This function locks a dentry in preparation for create/remove/rename.
+ * While the lock is held no other process will change the parent or name of
+ * this dentry.
+ * The only case where a process might hold locks on two dentries is when
+ * performing a rename operation.  In that case they should be taken in
+ * address order to avoid AB-BA deadlocks.
+ *
+ * Returns: %true if lock was successfully applied, or %false if the process
+ * was signalled and @state allowed the signal, or if @base and @last are given
+ * but the dentry was renamed or unlinked while waiting for the lock.
+ *
+ * If @state is TASK_UNINTERRUPTIBLE and base is NULL the lock will always be
+ * obtained.
+ *
+ * Must not be called while an inode lock is held except for silly_rename
+ * lookups though this exception will be removed on the transition to
+ * dentry locking is complete.
+ */
+static bool dentry_lock(struct dentry *dentry,
+			struct dentry *base, const struct qstr *last,
+			int state)
+{
+	return __dentry_lock(dentry, base, last, DLOCK_NORMAL, state);
+}
+
+__maybe_unused /* will be used for rename */
+static bool dentry_lock_nested(struct dentry *dentry,
+			       struct dentry *base, const struct qstr *last,
+			       int state)
+{
+	return __dentry_lock(dentry, base, last, DLOCK_RENAME, state);
+}
+
+/**
+ * dentry_trylock - attempt to lock a dentry without waiting
+ * @dentry:	the dentry to be locked
+ * @base:	the parent the dentry must still have after being locked, or NULL
+ * @last:	the name the dentry must still have afte being locked, or NULL
+ *
+ * This function locks a dentry in preparation for create/remove/rename if it
+ * is not already locked.
+ *
+ * Returns: %true if the dentry was not locked but now is.  %false if
+ * the dentry was already locked, or if the parent or name were wrong
+ * after finding the the dentry wasn't already locked.
+ */
+
+bool dentry_trylock(struct dentry *dentry,
+		      struct dentry *base,
+		      const struct qstr *last)
+{
+	int ret = false;
+
+	spin_lock(&dentry->d_lock);
+	if (!(dentry->d_flags & DCACHE_LOCK) &&
+	    dentry_matches(dentry, base, last)) {
+		lock_map_acquire_try(&dentry->dentry_map);
+		dentry->d_flags |= DCACHE_LOCK;
+		ret = true;
+	}
+	spin_unlock(&dentry->d_lock);
+
+	return ret;
+}
 
 /**
  * lookup_and_lock_hashed - lookup and lock a name prior to dir ops
@@ -3907,7 +4043,9 @@ static int may_o_create(struct mnt_idmap *idmap,
  * have been updated to point to the new dentry.  This may be negative.
  *
  * Returns an error code otherwise.
- */
+ *
+ * The dentry must be locked (DCACHE_LOCK) and it will be unlocked on return.
+*/
 static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
 				  struct file *file,
 				  int open_flag, umode_t mode)
@@ -3941,6 +4079,9 @@ static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
 				error = -ENOENT;
 		}
 	}
+	if (!error && (file->f_mode & FMODE_CREATED))
+		fsnotify_create(dir, dentry);
+	__dentry_unlock(dentry);
 	if (error) {
 		dput(dentry);
 		dentry = ERR_PTR(error);
@@ -3979,6 +4120,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		return ERR_PTR(-ENOENT);
 
 	file->f_mode &= ~FMODE_CREATED;
+lookup:
 	dentry = d_lookup(dir, &nd->last);
 	for (;;) {
 		if (!dentry) {
@@ -4002,6 +4144,19 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		/* Cached positive dentry: will open in f_op->open */
 		return dentry;
 	}
+	if (!dentry_lock(dentry, dir, &nd->last,
+			 TASK_UNINTERRUPTIBLE)) {
+		/* Became positive and renamed/removed while we slept */
+		dput(dentry);
+		goto lookup;
+	}
+	if (dentry->d_inode) {
+		/* Became positive while waiting for lock - will open in
+		 * f_op->open
+		 */
+		__dentry_unlock(dentry);
+		return dentry;
+	}
 
 	if (open_flag & O_CREAT)
 		audit_inode(nd->name, dir, AUDIT_INODE_PARENT);
@@ -4021,7 +4176,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (open_flag & O_CREAT) {
 		if (open_flag & O_EXCL)
 			open_flag &= ~O_TRUNC;
-		mode = vfs_prepare_mode(idmap, dir->d_inode, mode, mode, mode);
+		mode = vfs_prepare_mode(idmap, dir_inode, mode, mode, mode);
 		if (likely(got_write))
 			create_error = may_o_create(idmap, &nd->path,
 						    dentry, mode);
@@ -4044,7 +4199,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		if (unlikely(res)) {
 			if (IS_ERR(res)) {
 				error = PTR_ERR(res);
-				goto out_dput;
+				goto out_unlock;
 			}
 			dput(dentry);
 			dentry = res;
@@ -4057,20 +4212,24 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
 		if (!dir_inode->i_op->create) {
 			error = -EACCES;
-			goto out_dput;
+			goto out_unlock;
 		}
 
 		error = dir_inode->i_op->create(idmap, dir_inode, dentry,
 						mode, open_flag & O_EXCL);
 		if (error)
-			goto out_dput;
+			goto out_unlock;
+		fsnotify_create(dir_inode, dentry);
 	}
 	if (unlikely(create_error) && !dentry->d_inode) {
 		error = create_error;
-		goto out_dput;
+		goto out_unlock;;
 	}
+	__dentry_unlock(dentry);
 	return dentry;
 
+out_unlock:
+	__dentry_unlock(dentry);
 out_dput:
 	dput(dentry);
 	return ERR_PTR(error);
@@ -4161,8 +4320,6 @@ static const char *open_last_lookups(struct nameidata *nd,
 		inode_lock_shared(dir->d_inode);
 	dentry = lookup_open(nd, file, op, got_write);
 	if (!IS_ERR(dentry)) {
-		if (file->f_mode & FMODE_CREATED)
-			fsnotify_create(dir->d_inode, dentry);
 		if (file->f_mode & FMODE_OPENED)
 			fsnotify_open(file);
 	}
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 2b8f8641e1f8..c150d3f10a3d 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -114,6 +114,8 @@ struct dentry {
 					 * possible!
 					 */
 
+	/* lockdep tracking of DCACHE_LOCK locks */
+	struct lockdep_map		dentry_map;
 	union {
 		struct list_head d_lru;		/* LRU list */
 		wait_queue_head_t *d_wait;	/* in-lookup ones only */
@@ -229,6 +231,15 @@ enum dentry_flags {
 #define DCACHE_MANAGED_DENTRY \
 	(DCACHE_MOUNTED|DCACHE_NEED_AUTOMOUNT|DCACHE_MANAGE_TRANSIT)
 
+#define DCACHE_LOCK			BIT(27) /* Locked for update */
+#define DCACHE_LOCK_WAITER		BIT(28) /* someone is waiting for LOCK */
+
+/* Nesting levels for DCACHE_LOCK */
+enum {
+	DLOCK_NORMAL,
+	DLOCK_RENAME,		/* dentry with higher address in rename */
+};
+
 extern seqlock_t rename_lock;
 
 /*
-- 
2.49.0


