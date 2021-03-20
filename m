Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8320F342FBC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 22:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhCTVyW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 17:54:22 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:35554 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhCTVxz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 17:53:55 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNjVW-007jXu-Hj; Sat, 20 Mar 2021 21:51:42 +0000
Date:   Sat, 20 Mar 2021 21:51:42 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tyler Hicks <code@tyhicks.com>
Cc:     ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/4] ecryptfs: saner API for lock_parent()
Message-ID: <YFZubuMq1akR1YDx@zeniv-ca.linux.org.uk>
References: <YFZuSSpfWPrkJNVY@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFZuSSpfWPrkJNVY@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch all users of lock_parent() to the approach used by ->unlink()
and ->rmdir() - instead of playing with dget_parent() of underlying
dentry of child,
	* start with ecryptfs dentry of child.
	* find underlying dentries for that dentry and its parent
(which is stable, since the parent directory in upper layer is
held at least shared).  No need to pin them, they are already pinned
by ecryptfs dentries.
	* lock the inode of undelying directory of parent
	* check if it's the parent of underlying dentry of child.
->d_parent of underlying dentry of child might be unstable.  However,
result of its comparison with underlying dentry of parent *is* stable now.

Turn that into replacement of lock_parent(), convert the existing callers
of lock_parent() to that, along with ecryptfs_unlink() and ecryptfs_rmdir().

Callers need only the underlying dentry of child and inode of underlying
dentry of parent, so lock_parent() passes those to the caller now.
Note that underlying directory is locked in any case, success or failure.

That approach does not need a primitive for unlocking - we hadn't grabbed
any dentry references, so all we need is to unlock the underlying directory
inode.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ecryptfs/inode.c | 157 +++++++++++++++++++++++++---------------------------
 1 file changed, 74 insertions(+), 83 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 689aa493e587..861a01713f3f 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -21,19 +21,18 @@
 #include <asm/unaligned.h>
 #include "ecryptfs_kernel.h"
 
-static struct dentry *lock_parent(struct dentry *dentry)
+static int lock_parent(struct dentry *dentry,
+		       struct dentry **lower_dentry,
+		       struct inode **lower_dir)
 {
-	struct dentry *dir;
+	struct dentry *lower_dir_dentry;
 
-	dir = dget_parent(dentry);
-	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
-	return dir;
-}
+	lower_dir_dentry = ecryptfs_dentry_to_lower(dentry->d_parent);
+	*lower_dir = d_inode(lower_dir_dentry);
+	*lower_dentry = ecryptfs_dentry_to_lower(dentry);
 
-static void unlock_dir(struct dentry *dir)
-{
-	inode_unlock(d_inode(dir));
-	dput(dir);
+	inode_lock_nested(*lower_dir, I_MUTEX_PARENT);
+	return (*lower_dentry)->d_parent == lower_dir_dentry ? 0 : -EINVAL;
 }
 
 static int ecryptfs_inode_test(struct inode *inode, void *lower_inode)
@@ -127,32 +126,29 @@ static int ecryptfs_interpose(struct dentry *lower_dentry,
 static int ecryptfs_do_unlink(struct inode *dir, struct dentry *dentry,
 			      struct inode *inode)
 {
-	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
-	struct dentry *lower_dir_dentry;
-	struct inode *lower_dir_inode;
+	struct dentry *lower_dentry;
+	struct inode *lower_dir;
 	int rc;
 
-	lower_dir_dentry = ecryptfs_dentry_to_lower(dentry->d_parent);
-	lower_dir_inode = d_inode(lower_dir_dentry);
-	inode_lock_nested(lower_dir_inode, I_MUTEX_PARENT);
+	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
 	dget(lower_dentry);	// don't even try to make the lower negative
-	if (lower_dentry->d_parent != lower_dir_dentry)
-		rc = -EINVAL;
-	else if (d_unhashed(lower_dentry))
-		rc = -EINVAL;
-	else
-		rc = vfs_unlink(&init_user_ns, lower_dir_inode, lower_dentry,
-				NULL);
+	if (!rc) {
+		if (d_unhashed(lower_dentry))
+			rc = -EINVAL;
+		else
+			rc = vfs_unlink(&init_user_ns, lower_dir, lower_dentry,
+					NULL);
+	}
 	if (rc) {
 		printk(KERN_ERR "Error in vfs_unlink; rc = [%d]\n", rc);
 		goto out_unlock;
 	}
-	fsstack_copy_attr_times(dir, lower_dir_inode);
+	fsstack_copy_attr_times(dir, lower_dir);
 	set_nlink(inode, ecryptfs_inode_to_lower(inode)->i_nlink);
 	inode->i_ctime = dir->i_ctime;
 out_unlock:
 	dput(lower_dentry);
-	inode_unlock(lower_dir_inode);
+	inode_unlock(lower_dir);
 	if (!rc)
 		d_drop(dentry);
 	return rc;
@@ -176,13 +172,13 @@ ecryptfs_do_create(struct inode *directory_inode,
 {
 	int rc;
 	struct dentry *lower_dentry;
-	struct dentry *lower_dir_dentry;
+	struct inode *lower_dir;
 	struct inode *inode;
 
-	lower_dentry = ecryptfs_dentry_to_lower(ecryptfs_dentry);
-	lower_dir_dentry = lock_parent(lower_dentry);
-	rc = vfs_create(&init_user_ns, d_inode(lower_dir_dentry), lower_dentry,
-			mode, true);
+	rc = lock_parent(ecryptfs_dentry, &lower_dentry, &lower_dir);
+	if (!rc)
+		rc = vfs_create(&init_user_ns, lower_dir,
+				lower_dentry, mode, true);
 	if (rc) {
 		printk(KERN_ERR "%s: Failure to create dentry in lower fs; "
 		       "rc = [%d]\n", __func__, rc);
@@ -192,14 +188,13 @@ ecryptfs_do_create(struct inode *directory_inode,
 	inode = __ecryptfs_get_inode(d_inode(lower_dentry),
 				     directory_inode->i_sb);
 	if (IS_ERR(inode)) {
-		vfs_unlink(&init_user_ns, d_inode(lower_dir_dentry),
-			   lower_dentry, NULL);
+		vfs_unlink(&init_user_ns, lower_dir, lower_dentry, NULL);
 		goto out_lock;
 	}
-	fsstack_copy_attr_times(directory_inode, d_inode(lower_dir_dentry));
-	fsstack_copy_inode_size(directory_inode, d_inode(lower_dir_dentry));
+	fsstack_copy_attr_times(directory_inode, lower_dir);
+	fsstack_copy_inode_size(directory_inode, lower_dir);
 out_lock:
-	unlock_dir(lower_dir_dentry);
+	inode_unlock(lower_dir);
 	return inode;
 }
 
@@ -430,28 +425,28 @@ static int ecryptfs_link(struct dentry *old_dentry, struct inode *dir,
 {
 	struct dentry *lower_old_dentry;
 	struct dentry *lower_new_dentry;
-	struct dentry *lower_dir_dentry;
+	struct inode *lower_dir;
 	u64 file_size_save;
 	int rc;
 
 	file_size_save = i_size_read(d_inode(old_dentry));
 	lower_old_dentry = ecryptfs_dentry_to_lower(old_dentry);
-	lower_new_dentry = ecryptfs_dentry_to_lower(new_dentry);
-	lower_dir_dentry = lock_parent(lower_new_dentry);
-	rc = vfs_link(lower_old_dentry, &init_user_ns,
-		      d_inode(lower_dir_dentry), lower_new_dentry, NULL);
+	rc = lock_parent(new_dentry, &lower_new_dentry, &lower_dir);
+	if (!rc)
+		rc = vfs_link(lower_old_dentry, &init_user_ns, lower_dir,
+			      lower_new_dentry, NULL);
 	if (rc || d_really_is_negative(lower_new_dentry))
 		goto out_lock;
 	rc = ecryptfs_interpose(lower_new_dentry, new_dentry, dir->i_sb);
 	if (rc)
 		goto out_lock;
-	fsstack_copy_attr_times(dir, d_inode(lower_dir_dentry));
-	fsstack_copy_inode_size(dir, d_inode(lower_dir_dentry));
+	fsstack_copy_attr_times(dir, lower_dir);
+	fsstack_copy_inode_size(dir, lower_dir);
 	set_nlink(d_inode(old_dentry),
 		  ecryptfs_inode_to_lower(d_inode(old_dentry))->i_nlink);
 	i_size_write(d_inode(new_dentry), file_size_save);
 out_lock:
-	unlock_dir(lower_dir_dentry);
+	inode_unlock(lower_dir);
 	return rc;
 }
 
@@ -466,13 +461,14 @@ static int ecryptfs_symlink(struct user_namespace *mnt_userns,
 {
 	int rc;
 	struct dentry *lower_dentry;
-	struct dentry *lower_dir_dentry;
+	struct inode *lower_dir;
 	char *encoded_symname;
 	size_t encoded_symlen;
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat = NULL;
 
-	lower_dentry = ecryptfs_dentry_to_lower(dentry);
-	lower_dir_dentry = lock_parent(lower_dentry);
+	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
+	if (rc)
+		goto out_lock;
 	mount_crypt_stat = &ecryptfs_superblock_to_private(
 		dir->i_sb)->mount_crypt_stat;
 	rc = ecryptfs_encrypt_and_encode_filename(&encoded_symname,
@@ -481,7 +477,7 @@ static int ecryptfs_symlink(struct user_namespace *mnt_userns,
 						  strlen(symname));
 	if (rc)
 		goto out_lock;
-	rc = vfs_symlink(&init_user_ns, d_inode(lower_dir_dentry), lower_dentry,
+	rc = vfs_symlink(&init_user_ns, lower_dir, lower_dentry,
 			 encoded_symname);
 	kfree(encoded_symname);
 	if (rc || d_really_is_negative(lower_dentry))
@@ -489,10 +485,10 @@ static int ecryptfs_symlink(struct user_namespace *mnt_userns,
 	rc = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb);
 	if (rc)
 		goto out_lock;
-	fsstack_copy_attr_times(dir, d_inode(lower_dir_dentry));
-	fsstack_copy_inode_size(dir, d_inode(lower_dir_dentry));
+	fsstack_copy_attr_times(dir, lower_dir);
+	fsstack_copy_inode_size(dir, lower_dir);
 out_lock:
-	unlock_dir(lower_dir_dentry);
+	inode_unlock(lower_dir);
 	if (d_really_is_negative(dentry))
 		d_drop(dentry);
 	return rc;
@@ -503,22 +499,22 @@ static int ecryptfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 {
 	int rc;
 	struct dentry *lower_dentry;
-	struct dentry *lower_dir_dentry;
+	struct inode *lower_dir;
 
-	lower_dentry = ecryptfs_dentry_to_lower(dentry);
-	lower_dir_dentry = lock_parent(lower_dentry);
-	rc = vfs_mkdir(&init_user_ns, d_inode(lower_dir_dentry), lower_dentry,
-		       mode);
+	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
+	if (!rc)
+		rc = vfs_mkdir(&init_user_ns, lower_dir,
+			       lower_dentry, mode);
 	if (rc || d_really_is_negative(lower_dentry))
 		goto out;
 	rc = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb);
 	if (rc)
 		goto out;
-	fsstack_copy_attr_times(dir, d_inode(lower_dir_dentry));
-	fsstack_copy_inode_size(dir, d_inode(lower_dir_dentry));
-	set_nlink(dir, d_inode(lower_dir_dentry)->i_nlink);
+	fsstack_copy_attr_times(dir, lower_dir);
+	fsstack_copy_inode_size(dir, lower_dir);
+	set_nlink(dir, lower_dir->i_nlink);
 out:
-	unlock_dir(lower_dir_dentry);
+	inode_unlock(lower_dir);
 	if (d_really_is_negative(dentry))
 		d_drop(dentry);
 	return rc;
@@ -527,29 +523,24 @@ static int ecryptfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 static int ecryptfs_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	struct dentry *lower_dentry;
-	struct dentry *lower_dir_dentry;
-	struct inode *lower_dir_inode;
+	struct inode *lower_dir;
 	int rc;
 
-	lower_dentry = ecryptfs_dentry_to_lower(dentry);
-	lower_dir_dentry = ecryptfs_dentry_to_lower(dentry->d_parent);
-	lower_dir_inode = d_inode(lower_dir_dentry);
-
-	inode_lock_nested(lower_dir_inode, I_MUTEX_PARENT);
+	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
 	dget(lower_dentry);	// don't even try to make the lower negative
-	if (lower_dentry->d_parent != lower_dir_dentry)
-		rc = -EINVAL;
-	else if (d_unhashed(lower_dentry))
-		rc = -EINVAL;
-	else
-		rc = vfs_rmdir(&init_user_ns, lower_dir_inode, lower_dentry);
+	if (!rc) {
+		if (d_unhashed(lower_dentry))
+			rc = -EINVAL;
+		else
+			rc = vfs_rmdir(&init_user_ns, lower_dir, lower_dentry);
+	}
 	if (!rc) {
 		clear_nlink(d_inode(dentry));
-		fsstack_copy_attr_times(dir, lower_dir_inode);
-		set_nlink(dir, lower_dir_inode->i_nlink);
+		fsstack_copy_attr_times(dir, lower_dir);
+		set_nlink(dir, lower_dir->i_nlink);
 	}
 	dput(lower_dentry);
-	inode_unlock(lower_dir_inode);
+	inode_unlock(lower_dir);
 	if (!rc)
 		d_drop(dentry);
 	return rc;
@@ -561,21 +552,21 @@ ecryptfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 {
 	int rc;
 	struct dentry *lower_dentry;
-	struct dentry *lower_dir_dentry;
+	struct inode *lower_dir;
 
-	lower_dentry = ecryptfs_dentry_to_lower(dentry);
-	lower_dir_dentry = lock_parent(lower_dentry);
-	rc = vfs_mknod(&init_user_ns, d_inode(lower_dir_dentry), lower_dentry,
-		       mode, dev);
+	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
+	if (!rc)
+		rc = vfs_mknod(&init_user_ns, lower_dir,
+			       lower_dentry, mode, dev);
 	if (rc || d_really_is_negative(lower_dentry))
 		goto out;
 	rc = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb);
 	if (rc)
 		goto out;
-	fsstack_copy_attr_times(dir, d_inode(lower_dir_dentry));
-	fsstack_copy_inode_size(dir, d_inode(lower_dir_dentry));
+	fsstack_copy_attr_times(dir, lower_dir);
+	fsstack_copy_inode_size(dir, lower_dir);
 out:
-	unlock_dir(lower_dir_dentry);
+	inode_unlock(lower_dir);
 	if (d_really_is_negative(dentry))
 		d_drop(dentry);
 	return rc;
-- 
2.11.0

