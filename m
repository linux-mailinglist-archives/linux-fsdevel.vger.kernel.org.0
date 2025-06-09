Return-Path: <linux-fsdevel+bounces-50974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D873DAD1848
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 07:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796141889D30
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 05:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE9E280030;
	Mon,  9 Jun 2025 05:20:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65638194C96
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 05:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749446448; cv=none; b=Sq0KeMVxTvn8RC/qHao/ylUUxhvF0snxnHHIfQMgdBJNY6ADIs77BYbtzGelwwmY3hC7U623chEZEQlgJ3oycvsy6Q9ZDUSsSttpEAer6XRT36gJq6GOPG5h0BeJJYU2z/oR46f9UMC3QHDmV7tTpICuvkAk5rgVBwEA/tIdCJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749446448; c=relaxed/simple;
	bh=vSp26FR603Pj7zMU00hMJBAWjqzDQ0DYDxNHjzzr1rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZU9pZJbZvULAu7Ff6yT7pReQmkRz72Nl4Ig2QsnoR1HtOsRG9t19B9BYe+ZQqMnh5OTliy4/q8Ru/XrHPBajowS3cMOIxVpM14tu1QQYzkrGvB9LaDfGE6MHMhNy6TR2h6klUrz4yA5G/ufV1VHkDRXCV0aWFk56kTWsfRUz+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uOUw7-006Apn-DN;
	Mon, 09 Jun 2025 05:20:43 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/5] VFS: introduce lock_and_check_dentry()
Date: Mon,  9 Jun 2025 15:01:17 +1000
Message-ID: <20250609051419.106580-6-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609051419.106580-1-neil@brown.name>
References: <20250609051419.106580-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few callers operate on a dentry which they already have - unlike the
normal case where a lookup proceeds an operation.

For these callers lock_and_check_dentry() is provided where other
callers would use lookup_and_lock().  The call will fail if, after the
lock was gained, the child is no longer a child of the given parent.

When the operation completes dentry_unlock() must be called.  An
extra reference is taken when the lock_and_check_dentry() call succeeds
and will be dropped by dentry_unlock().

This patch changes ecryptfs to make use of this new interface.
cachefiles and smb/server can also benefit as will be seen in later
patches.

Note that lock_parent() in ecryptfs is changed to return with the lock
NOT held when an error occurs.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/ecryptfs/inode.c   | 124 +++++++++++++++++++++++-------------------
 fs/namei.c            |  26 +++++++++
 include/linux/namei.h |   1 +
 3 files changed, 96 insertions(+), 55 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 3e627bcbaff1..3173ba89bc20 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -26,16 +26,15 @@
 
 static int lock_parent(struct dentry *dentry,
 		       struct dentry **lower_dentry,
-		       struct inode **lower_dir)
+		       struct dentry **lower_dir_dentry)
 {
-	struct dentry *lower_dir_dentry;
 
-	lower_dir_dentry = ecryptfs_dentry_to_lower(dentry->d_parent);
-	*lower_dir = d_inode(lower_dir_dentry);
+	*lower_dir_dentry = ecryptfs_dentry_to_lower(dentry->d_parent);
 	*lower_dentry = ecryptfs_dentry_to_lower(dentry);
 
-	inode_lock_nested(*lower_dir, I_MUTEX_PARENT);
-	return (*lower_dentry)->d_parent == lower_dir_dentry ? 0 : -EINVAL;
+	if (!lock_and_check_dentry(*lower_dir_dentry, *lower_dentry))
+		return -EINVAL;
+	return 0;
 }
 
 static int ecryptfs_inode_test(struct inode *inode, void *lower_inode)
@@ -138,28 +137,30 @@ static int ecryptfs_do_unlink(struct inode *dir, struct dentry *dentry,
 			      struct inode *inode)
 {
 	struct dentry *lower_dentry;
-	struct inode *lower_dir;
+	struct dentry *lower_dir_dentry;
 	int rc;
 
-	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
-	dget(lower_dentry);	// don't even try to make the lower negative
+	rc = lock_parent(dentry, &lower_dentry, &lower_dir_dentry);
+	if (rc) {
+		printk(KERN_ERR "Error in vfs_unlink; rc = [%d]\n", rc);
+		return rc;
+	}
 	if (!rc) {
 		if (d_unhashed(lower_dentry))
 			rc = -EINVAL;
 		else
-			rc = vfs_unlink(&nop_mnt_idmap, lower_dir, lower_dentry,
-					NULL);
+			rc = vfs_unlink(&nop_mnt_idmap, d_inode(lower_dir_dentry),
+					lower_dentry, NULL);
 	}
 	if (rc) {
 		printk(KERN_ERR "Error in vfs_unlink; rc = [%d]\n", rc);
 		goto out_unlock;
 	}
-	fsstack_copy_attr_times(dir, lower_dir);
+	fsstack_copy_attr_times(dir, d_inode(lower_dir_dentry));
 	set_nlink(inode, ecryptfs_inode_to_lower(inode)->i_nlink);
 	inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
 out_unlock:
-	dput(lower_dentry);
-	inode_unlock(lower_dir);
+	dentry_unlock(lower_dentry);
 	if (!rc)
 		d_drop(dentry);
 	return rc;
@@ -182,14 +183,18 @@ ecryptfs_do_create(struct inode *directory_inode,
 		   struct dentry *ecryptfs_dentry, umode_t mode)
 {
 	int rc;
-	struct dentry *lower_dentry;
+	struct dentry *lower_dentry, *lower_dir_dentry;
 	struct inode *lower_dir;
 	struct inode *inode;
 
-	rc = lock_parent(ecryptfs_dentry, &lower_dentry, &lower_dir);
-	if (!rc)
-		rc = vfs_create(&nop_mnt_idmap, lower_dir,
-				lower_dentry, mode, true);
+	rc = lock_parent(ecryptfs_dentry, &lower_dentry, &lower_dir_dentry);
+	if (rc) {
+		printk(KERN_ERR "%s: Failure to create dentry in lower fs; "
+		       "rc = [%d]\n", __func__, rc);
+		return ERR_PTR(rc);
+	}
+	lower_dir = d_inode(lower_dir_dentry);
+	rc = vfs_create(&nop_mnt_idmap, lower_dir, lower_dentry, mode, true);
 	if (rc) {
 		printk(KERN_ERR "%s: Failure to create dentry in lower fs; "
 		       "rc = [%d]\n", __func__, rc);
@@ -205,7 +210,7 @@ ecryptfs_do_create(struct inode *directory_inode,
 	fsstack_copy_attr_times(directory_inode, lower_dir);
 	fsstack_copy_inode_size(directory_inode, lower_dir);
 out_lock:
-	inode_unlock(lower_dir);
+	dentry_unlock(lower_dentry);
 	return inode;
 }
 
@@ -436,16 +441,19 @@ static int ecryptfs_link(struct dentry *old_dentry, struct inode *dir,
 {
 	struct dentry *lower_old_dentry;
 	struct dentry *lower_new_dentry;
+	struct dentry *lower_dir_dentry;
 	struct inode *lower_dir;
 	u64 file_size_save;
 	int rc;
 
 	file_size_save = i_size_read(d_inode(old_dentry));
 	lower_old_dentry = ecryptfs_dentry_to_lower(old_dentry);
-	rc = lock_parent(new_dentry, &lower_new_dentry, &lower_dir);
-	if (!rc)
-		rc = vfs_link(lower_old_dentry, &nop_mnt_idmap, lower_dir,
-			      lower_new_dentry, NULL);
+	rc = lock_parent(new_dentry, &lower_new_dentry, &lower_dir_dentry);
+	if (rc)
+		return rc;
+	lower_dir = d_inode(lower_dir_dentry);
+	rc = vfs_link(lower_old_dentry, &nop_mnt_idmap, lower_dir,
+		      lower_new_dentry, NULL);
 	if (rc || d_really_is_negative(lower_new_dentry))
 		goto out_lock;
 	rc = ecryptfs_interpose(lower_new_dentry, new_dentry, dir->i_sb);
@@ -457,7 +465,7 @@ static int ecryptfs_link(struct dentry *old_dentry, struct inode *dir,
 		  ecryptfs_inode_to_lower(d_inode(old_dentry))->i_nlink);
 	i_size_write(d_inode(new_dentry), file_size_save);
 out_lock:
-	inode_unlock(lower_dir);
+	dentry_unlock(lower_new_dentry);
 	return rc;
 }
 
@@ -472,14 +480,16 @@ static int ecryptfs_symlink(struct mnt_idmap *idmap,
 {
 	int rc;
 	struct dentry *lower_dentry;
+	struct dentry *lower_dir_dentry;
 	struct inode *lower_dir;
 	char *encoded_symname;
 	size_t encoded_symlen;
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat = NULL;
 
-	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
+	rc = lock_parent(dentry, &lower_dentry, &lower_dir_dentry);
 	if (rc)
-		goto out_lock;
+		goto out;
+	lower_dir = d_inode(lower_dir_dentry);
 	mount_crypt_stat = &ecryptfs_superblock_to_private(
 		dir->i_sb)->mount_crypt_stat;
 	rc = ecryptfs_encrypt_and_encode_filename(&encoded_symname,
@@ -499,7 +509,8 @@ static int ecryptfs_symlink(struct mnt_idmap *idmap,
 	fsstack_copy_attr_times(dir, lower_dir);
 	fsstack_copy_inode_size(dir, lower_dir);
 out_lock:
-	inode_unlock(lower_dir);
+	dentry_unlock(lower_dentry);
+out:
 	if (d_really_is_negative(dentry))
 		d_drop(dentry);
 	return rc;
@@ -509,30 +520,30 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 				     struct dentry *dentry, umode_t mode)
 {
 	int rc;
-	struct dentry *lower_dentry;
+	struct dentry *lower_dentry, *lower_dir_dentry;
 	struct inode *lower_dir;
 
-	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
+	rc = lock_parent(dentry, &lower_dentry, &lower_dir_dentry);
 	if (rc)
 		goto out;
-
+	lower_dir = d_inode(lower_dir_dentry);
 	lower_dentry = vfs_mkdir(&nop_mnt_idmap, lower_dir,
 				 lower_dentry, mode);
 	rc = PTR_ERR(lower_dentry);
 	if (IS_ERR(lower_dentry))
-		goto out_unlocked;
+		goto out;
 	rc = 0;
 	if (d_unhashed(lower_dentry))
-		goto out;
+		goto out_unlock;
 	rc = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb);
 	if (rc)
-		goto out;
+		goto out_unlock;
 	fsstack_copy_attr_times(dir, lower_dir);
 	fsstack_copy_inode_size(dir, lower_dir);
 	set_nlink(dir, lower_dir->i_nlink);
+out_unlock:
+	dentry_unlock(lower_dentry);
 out:
-	inode_unlock(lower_dir);
-out_unlocked:
 	if (d_really_is_negative(dentry))
 		d_drop(dentry);
 	return ERR_PTR(rc);
@@ -540,25 +551,25 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 
 static int ecryptfs_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	struct dentry *lower_dentry;
+	struct dentry *lower_dentry, *lower_dir_dentry;
 	struct inode *lower_dir;
 	int rc;
 
-	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
-	dget(lower_dentry);	// don't even try to make the lower negative
-	if (!rc) {
-		if (d_unhashed(lower_dentry))
-			rc = -EINVAL;
-		else
-			rc = vfs_rmdir(&nop_mnt_idmap, lower_dir, lower_dentry);
-	}
+	rc = lock_parent(dentry, &lower_dentry, &lower_dir_dentry);
+	if (rc)
+		return rc;
+	lower_dir = d_inode(lower_dir_dentry);
+	if (d_unhashed(lower_dentry))
+		rc = -EINVAL;
+	else
+		rc = vfs_rmdir(&nop_mnt_idmap, lower_dir, lower_dentry);
+
 	if (!rc) {
 		clear_nlink(d_inode(dentry));
 		fsstack_copy_attr_times(dir, lower_dir);
 		set_nlink(dir, lower_dir->i_nlink);
 	}
-	dput(lower_dentry);
-	inode_unlock(lower_dir);
+	dentry_unlock(lower_dentry);
 	if (!rc)
 		d_drop(dentry);
 	return rc;
@@ -569,22 +580,25 @@ ecryptfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	       struct dentry *dentry, umode_t mode, dev_t dev)
 {
 	int rc;
-	struct dentry *lower_dentry;
+	struct dentry *lower_dentry, *lower_dir_dentry;
 	struct inode *lower_dir;
 
-	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
-	if (!rc)
-		rc = vfs_mknod(&nop_mnt_idmap, lower_dir,
-			       lower_dentry, mode, dev);
-	if (rc || d_really_is_negative(lower_dentry))
+	rc = lock_parent(dentry, &lower_dentry, &lower_dir_dentry);
+	if (rc)
 		goto out;
+	lower_dir = d_inode(lower_dir_dentry);
+	rc = vfs_mknod(&nop_mnt_idmap, lower_dir,
+		       lower_dentry, mode, dev);
+	if (rc || d_really_is_negative(lower_dentry))
+		goto out_unlock;
 	rc = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb);
 	if (rc)
-		goto out;
+		goto out_unlock;
 	fsstack_copy_attr_times(dir, lower_dir);
 	fsstack_copy_inode_size(dir, lower_dir);
+out_unlock:
+	dentry_unlock(lower_dentry);
 out:
-	inode_unlock(lower_dir);
 	if (d_really_is_negative(dentry))
 		d_drop(dentry);
 	return rc;
diff --git a/fs/namei.c b/fs/namei.c
index 39868ee40f03..65f1d50c5a5b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1850,6 +1850,32 @@ struct dentry *lookup_and_lock_killable(struct mnt_idmap *idmap,
 }
 EXPORT_SYMBOL(lookup_and_lock_killable);
 
+/**
+ * lock_and_check_dentry: lock a dentry in given parent prior to dir ops
+ * @child: the dentry to lock
+ * @parent: the dentry of the assumed parent
+ *
+ * The child is locked - currently by taking i_rwsem on the parent - to
+ * prepare for create/remove operations.  If the given parent is no longer
+ * the parent of the dentry after the lock is gained, the lock is released
+ * and the call failed (returns %false).
+ *
+ * A reference is taken to the child on success.  The lock and references
+ * must both be dropped by dentry_unlock() after the operation completes.
+ */
+bool lock_and_check_dentry(struct dentry *child, struct dentry *parent)
+{
+	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
+	if (child->d_parent == parent) {
+		/* get the child to balance with dentry_unlock which puts it. */
+		dget(child);
+		return true;
+	}
+	inode_unlock(d_inode(parent));
+	return false;
+}
+EXPORT_SYMBOL(lock_and_check_dentry);
+
 void dentry_unlock_dir_locked(struct dentry *dentry)
 {
 	d_lookup_done(dentry);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index a51f3caad106..67c82caa4676 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -106,6 +106,7 @@ int lookup_and_lock_rename(struct renamedata *rd, int lookup_flags);
 int lookup_and_lock_rename_noperm(struct renamedata *rd, int lookup_flags);
 int lookup_and_lock_rename_hashed(struct renamedata *rd, int lookup_flags);
 void dentry_unlock_rename(struct renamedata *rd);
+bool lock_and_check_dentry(struct dentry *child, struct dentry *parent);
 
 /**
  * mode_strip_umask - handle vfs umask stripping
-- 
2.49.0


