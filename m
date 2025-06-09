Return-Path: <linux-fsdevel+bounces-50970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF24AD1844
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 07:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5E1D1889D13
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 05:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF14427FD7A;
	Mon,  9 Jun 2025 05:20:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988EB2F4A
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 05:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749446446; cv=none; b=rQohT7boHcsoUc+VgstT2QJCnH2Df5gmgRlIxaFJPwOmur5oqVvQMpCTMJak2sTd+IdJy9Q4usCP9Jy8KwofVZ0SsPwItJQNOQj1u2kENd9tPqzPCNIP9jAoLsJ3POLl5lxMhDEYFLcLWQ4JkaVqzdUzVKxiYu1jTEP3JZaxtko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749446446; c=relaxed/simple;
	bh=+69KseJVaDWLnRW2ecrMUVTpwm+zseM5FiUx6E61tNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/FiXe7b0/EcaiwZDTj3+nApB9SR1kH42y3iaiKe/X91BXS+dIv+MudgxCBBtVHD2Zv4q3xl8hYp78G9jLfd9pHy7sA4pPsK0KVUTUHcroXqkVyFOLameInWXGiBSHGn/4sES4sLtZUm3Ta8eQKzfBi0Fw1BqFklrk5fYlV9u08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uOUw5-006ApN-Mc;
	Mon, 09 Jun 2025 05:20:41 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/5] VFS/btrfs: add lookup_and_lock_killable()
Date: Mon,  9 Jun 2025 15:01:14 +1000
Message-ID: <20250609051419.106580-3-neil@brown.name>
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

btrfs/ioctl.c uses a "killable" lock on the directory when creating an
destroying subvols.

This patch adds lookup_and_lock_killable() and uses it in btrfs.

Possibly all look_and_lock should be killable as there is no down-side,
but that can come in a later patch.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/btrfs/ioctl.c      | 49 ++++++++++++++-----------------------------
 fs/namei.c            | 36 +++++++++++++++++++++++++++++++
 include/linux/namei.h |  3 +++
 3 files changed, 55 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 913acef3f0a9..9a3af4049c60 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -905,18 +905,15 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 	struct fscrypt_str name_str = FSTR_INIT((char *)name, namelen);
 	int error;
 
-	error = down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
-	if (error == -EINTR)
-		return error;
-
-	dentry = lookup_one(idmap, &QSTR_LEN(name, namelen), parent->dentry);
-	error = PTR_ERR(dentry);
+	dentry = lookup_and_lock_killable(idmap, &QSTR_LEN(name, namelen),
+					  parent->dentry,
+					  LOOKUP_CREATE|LOOKUP_EXCL);
 	if (IS_ERR(dentry))
-		goto out_unlock;
+		return PTR_ERR(dentry);
 
 	error = btrfs_may_create(idmap, dir, dentry);
 	if (error)
-		goto out_dput;
+		goto out_unlock;
 
 	/*
 	 * even if this name doesn't exist, we may get hash collisions.
@@ -925,7 +922,7 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 	error = btrfs_check_dir_item_collision(BTRFS_I(dir)->root,
 					       dir->i_ino, &name_str);
 	if (error)
-		goto out_dput;
+		goto out_unlock;
 
 	down_read(&fs_info->subvol_sem);
 
@@ -941,10 +938,8 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 		fsnotify_mkdir(dir, dentry);
 out_up_read:
 	up_read(&fs_info->subvol_sem);
-out_dput:
-	dput(dentry);
 out_unlock:
-	btrfs_inode_unlock(BTRFS_I(dir), 0);
+	dentry_unlock(dentry);
 	return error;
 }
 
@@ -2421,19 +2416,9 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 		goto free_subvol_name;
 	}
 
-	ret = down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
-	if (ret == -EINTR)
+	dentry = lookup_and_lock_killable(idmap, &QSTR(subvol_name), parent, 0);
+	if (IS_ERR(dentry))
 		goto free_subvol_name;
-	dentry = lookup_one(idmap, &QSTR(subvol_name), parent);
-	if (IS_ERR(dentry)) {
-		ret = PTR_ERR(dentry);
-		goto out_unlock_dir;
-	}
-
-	if (d_really_is_negative(dentry)) {
-		ret = -ENOENT;
-		goto out_dput;
-	}
 
 	inode = d_inode(dentry);
 	dest = BTRFS_I(inode)->root;
@@ -2453,7 +2438,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 		 */
 		ret = -EPERM;
 		if (!btrfs_test_opt(fs_info, USER_SUBVOL_RM_ALLOWED))
-			goto out_dput;
+			goto out_unlock;
 
 		/*
 		 * Do not allow deletion if the parent dir is the same
@@ -2464,21 +2449,21 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 		 */
 		ret = -EINVAL;
 		if (root == dest)
-			goto out_dput;
+			goto out_unlock;
 
 		ret = inode_permission(idmap, inode, MAY_WRITE | MAY_EXEC);
 		if (ret)
-			goto out_dput;
+			goto out_unlock;
 	}
 
 	/* check if subvolume may be deleted by a user */
 	ret = btrfs_may_delete(idmap, dir, dentry, 1);
 	if (ret)
-		goto out_dput;
+		goto out_unlock;
 
 	if (btrfs_ino(BTRFS_I(inode)) != BTRFS_FIRST_FREE_OBJECTID) {
 		ret = -EINVAL;
-		goto out_dput;
+		goto out_unlock;
 	}
 
 	btrfs_inode_lock(BTRFS_I(inode), 0);
@@ -2487,10 +2472,8 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	if (!ret)
 		d_delete_notify(dir, dentry);
 
-out_dput:
-	dput(dentry);
-out_unlock_dir:
-	btrfs_inode_unlock(BTRFS_I(dir), 0);
+out_unlock:
+	dentry_unlock(dentry);
 free_subvol_name:
 	kfree(subvol_name_ptr);
 free_parent:
diff --git a/fs/namei.c b/fs/namei.c
index 5e8fe2d78486..55ce5700ba0e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1814,6 +1814,42 @@ struct dentry *lookup_and_lock(struct mnt_idmap *idmap,
 }
 EXPORT_SYMBOL(lookup_and_lock);
 
+/**
+ * lookup_and_lock_killable - lookup and lock a name prior to dir ops
+ * @last: the name in the given directory
+ * @base: the directory in which the name is to be found
+ * @lookup_flags: %LOOKUP_xxx flags
+ *
+ * The name is looked up and necessary locks are taken so that
+ * the name can be created or removed.
+ * The "necessary locks" are currently the inode node lock on @base.
+ * If a fatal signal arrives or is already pending the operation is aborted.
+ * The name @last is NOT expected to already have the hash calculated.
+ * Permission checks are performed to ensure %MAY_EXEC access to @base.
+ * Returns: the dentry, suitably locked, or an ERR_PTR().
+ */
+struct dentry *lookup_and_lock_killable(struct mnt_idmap *idmap,
+					struct qstr *last,
+					struct dentry *base,
+					unsigned int lookup_flags)
+{
+	struct dentry *dentry;
+	int err;
+
+	err = down_write_killable_nested(&base->d_inode->i_rwsem, I_MUTEX_PARENT);
+	if (err)
+		return ERR_PTR(err);
+	err = lookup_one_common(idmap, last, base);
+	if (err < 0)
+		return ERR_PTR(err);
+
+	dentry = lookup_one_qstr_excl(last, base, lookup_flags);
+	if (IS_ERR(dentry))
+		inode_unlock(base->d_inode);
+	return dentry;
+}
+EXPORT_SYMBOL(lookup_and_lock_killable);
+
 void dentry_unlock_dir_locked(struct dentry *dentry)
 {
 	d_lookup_done(dentry);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 378ee72b57f4..5177499a2f6b 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -83,6 +83,9 @@ struct dentry *lookup_one_positive_unlocked(struct mnt_idmap *idmap,
 struct dentry *lookup_and_lock(struct mnt_idmap *idmap,
 			       struct qstr *last, struct dentry *base,
 			       unsigned int lookup_flags);
+struct dentry *lookup_and_lock_killable(struct mnt_idmap *idmap,
+					struct qstr *last, struct dentry *base,
+					unsigned int lookup_flags);
 struct dentry *lookup_and_lock_noperm(struct qstr *name, struct dentry *base,
 				      unsigned int lookup_flags);
 struct dentry *lookup_and_lock_noperm_locked(struct qstr *name, struct dentry *base,
-- 
2.49.0


