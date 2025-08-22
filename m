Return-Path: <linux-fsdevel+bounces-58712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E907BB30A12
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 02:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58220AC685C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 00:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CABF2AE8E;
	Fri, 22 Aug 2025 00:11:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94866139E;
	Fri, 22 Aug 2025 00:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755821483; cv=none; b=B02kxAEKWH7iJvUSJPg5UREgzqapPAVQTJm2SYxn4g3PsVCd4AMf+OPPEHVIFVyGhXhDwJbc3tDm4adnZdfZR70obiT5TCDL3E+jvPG2NWK8ypoKc+zIKX2FBVhorWsf+vG4kiTUAQO+x3DzLGDajvZkG7ELn3DdjnR7zdsCUwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755821483; c=relaxed/simple;
	bh=ULv7ZyF5fWdjhfgSI2qkGQb6DUzG8NgxC77a+4v4w64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X43bFH/IYfYuMytqR1FvjzThPgujLKS3rw7Qjc0f7nIyvAnNOPldqubvRoYDPqMzJ/F+aRhKalxZ537WOuYFHz60Cuf3dGbEL6TVDYuTC27aXvSAv5K7X03itJRHFPbVUj6h2EbXWVZWbkmrPAUJl3bjrX1Nz0q0H2swtbBggKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1upFNF-006nbk-Ef;
	Fri, 22 Aug 2025 00:11:19 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/16] VFS: add start_creating_killable() and start_removing_killable()
Date: Fri, 22 Aug 2025 10:00:34 +1000
Message-ID: <20250822000818.1086550-17-neil@brown.name>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250822000818.1086550-1-neil@brown.name>
References: <20250822000818.1086550-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are similar to start_creating() and start_removing(), but allow a
fatal signal to abort waiting for the lock.

There are used in btrfs for subvol creating and removal, and will have a
role in overlayfs too.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/btrfs/ioctl.c      | 43 +++++++----------------
 fs/namei.c            | 80 +++++++++++++++++++++++++++++++++++++++++--
 include/linux/namei.h |  6 ++++
 3 files changed, 95 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7e13de2bdcbf..20febcf25aea 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -880,8 +880,6 @@ static inline int btrfs_may_create(struct mnt_idmap *idmap,
 {
 	if (d_really_is_positive(child))
 		return -EEXIST;
-	if (IS_DEADDIR(dir))
-		return -ENOENT;
 	if (!fsuidgid_has_mapping(dir->i_sb, idmap))
 		return -EOVERFLOW;
 	return inode_permission(idmap, dir, MAY_WRITE | MAY_EXEC);
@@ -904,14 +902,9 @@ static noinline int btrfs_mksubvol(struct dentry *parent,
 	struct fscrypt_str name_str = FSTR_INIT((char *)qname->name, qname->len);
 	int ret;
 
-	ret = down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
-	if (ret == -EINTR)
-		return ret;
-
-	dentry = lookup_one(idmap, qname, parent);
-	ret = PTR_ERR(dentry);
+	dentry = start_creating_killable(idmap, parent, qname);
 	if (IS_ERR(dentry))
-		goto out_unlock;
+		return PTR_ERR(dentry);
 
 	ret = btrfs_may_create(idmap, dir, dentry);
 	if (ret)
@@ -940,9 +933,7 @@ static noinline int btrfs_mksubvol(struct dentry *parent,
 out_up_read:
 	up_read(&fs_info->subvol_sem);
 out_dput:
-	dput(dentry);
-out_unlock:
-	btrfs_inode_unlock(BTRFS_I(dir), 0);
+	end_creating(dentry, parent);
 	return ret;
 }
 
@@ -2417,18 +2408,10 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 		goto free_subvol_name;
 	}
 
-	ret = down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
-	if (ret == -EINTR)
-		goto free_subvol_name;
-	dentry = lookup_one(idmap, &QSTR(subvol_name), parent);
+	dentry = start_removing_killable(idmap, parent, &QSTR(subvol_name));
 	if (IS_ERR(dentry)) {
 		ret = PTR_ERR(dentry);
-		goto out_unlock_dir;
-	}
-
-	if (d_really_is_negative(dentry)) {
-		ret = -ENOENT;
-		goto out_dput;
+		goto out_end_dirop;
 	}
 
 	inode = d_inode(dentry);
@@ -2449,7 +2432,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 		 */
 		ret = -EPERM;
 		if (!btrfs_test_opt(fs_info, USER_SUBVOL_RM_ALLOWED))
-			goto out_dput;
+			goto out_end_dirop;
 
 		/*
 		 * Do not allow deletion if the parent dir is the same
@@ -2460,21 +2443,21 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 		 */
 		ret = -EINVAL;
 		if (root == dest)
-			goto out_dput;
+			goto out_end_dirop;
 
 		ret = inode_permission(idmap, inode, MAY_WRITE | MAY_EXEC);
 		if (ret)
-			goto out_dput;
+			goto out_end_dirop;
 	}
 
 	/* check if subvolume may be deleted by a user */
 	ret = btrfs_may_delete(idmap, dir, dentry, 1);
 	if (ret)
-		goto out_dput;
+		goto out_end_dirop;
 
 	if (btrfs_ino(BTRFS_I(inode)) != BTRFS_FIRST_FREE_OBJECTID) {
 		ret = -EINVAL;
-		goto out_dput;
+		goto out_end_dirop;
 	}
 
 	btrfs_inode_lock(BTRFS_I(inode), 0);
@@ -2483,10 +2466,8 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	if (!ret)
 		d_delete_notify(dir, dentry);
 
-out_dput:
-	dput(dentry);
-out_unlock_dir:
-	btrfs_inode_unlock(BTRFS_I(dir), 0);
+out_end_dirop:
+	end_dirop(dentry);
 free_subvol_name:
 	kfree(subvol_name_ptr);
 free_parent:
diff --git a/fs/namei.c b/fs/namei.c
index af56bc39c4d5..5b40f025ecc5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2765,19 +2765,33 @@ static int filename_parentat(int dfd, struct filename *name,
  * Returns: a locked dentry, or an error.
  *
  */
-struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
-			   unsigned int lookup_flags)
+static struct dentry *__start_dirop(struct dentry *parent, struct qstr *name,
+				    unsigned int lookup_flags,
+				    unsigned int state)
 {
 	struct dentry *dentry;
 	struct inode *dir = d_inode(parent);
 
-	inode_lock_nested(dir, I_MUTEX_PARENT);
+	if (state == TASK_KILLABLE) {
+		int ret = down_write_killable_nested(&dir->i_rwsem,
+						     I_MUTEX_PARENT);
+		if (ret)
+			return ERR_PTR(ret);
+	} else {
+		inode_lock_nested(dir, I_MUTEX_PARENT);
+	}
 	dentry = lookup_one_qstr_excl(name, parent, lookup_flags);
 	if (IS_ERR(dentry))
 		inode_unlock(dir);
 	return dentry;
 }
 
+struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
+			   unsigned int lookup_flags)
+{
+	return __start_dirop(parent, name, lookup_flags, TASK_NORMAL);
+}
+
 /**
  * end_dirop - signal completion of a dirop
  * @de - the dentry which was returned by start_dirop or similar.
@@ -3213,6 +3227,66 @@ struct dentry *start_removing(struct mnt_idmap *idmap, struct dentry *parent,
 }
 EXPORT_SYMBOL(start_removing);
 
+/**
+ * start_creating_killable - prepare to create a given name with permission checking
+ * @idmap - idmap of the mount
+ * @parent - directory in which to prepare to create the name
+ * @name - the name to be created
+ *
+ * Locks are taken and a lookup in performed prior to creating
+ * an object in a directory.  Permission checking (MAY_EXEC) is performed
+ * against @idmap.
+ *
+ * If the name already exists, a positive dentry is returned.
+ *
+ * If a signal is received or was already pending, the function aborts
+ * with -EINTR;
+ *
+ * Returns: a negative or positive dentry, or an error.
+ */
+struct dentry *start_creating_killable(struct mnt_idmap *idmap,
+				       struct dentry *parent,
+				       struct qstr *name)
+{
+	int err = lookup_one_common(idmap, name, parent);
+
+	if (err)
+		return ERR_PTR(err);
+	return __start_dirop(parent, name, LOOKUP_CREATE, TASK_KILLABLE);
+}
+EXPORT_SYMBOL(start_creating_killable);
+
+/**
+ * start_removing_killable - prepare to remove a given name with permission checking
+ * @idmap - idmap of the mount
+ * @parent - directory in which to find the name
+ * @name - the name to be removed
+ *
+ * Locks are taken and a lookup in performed prior to removing
+ * an object from a directory.  Permission checking (MAY_EXEC) is performed
+ * against @idmap.
+ *
+ * If the name doesn't exist, an error is returned.
+ *
+ * end_dirop() should be called when removal is complete, or aborted.
+ *
+ * If a signal is received or was already pending, the function aborts
+ * with -EINTR;
+ *
+ * Returns: a positive dentry, or an error.
+ */
+struct dentry *start_removing_killable(struct mnt_idmap *idmap,
+				       struct dentry *parent,
+				       struct qstr *name)
+{
+	int err = lookup_one_common(idmap, name, parent);
+
+	if (err)
+		return ERR_PTR(err);
+	return __start_dirop(parent, name, 0, TASK_KILLABLE);
+}
+EXPORT_SYMBOL(start_removing_killable);
+
 /**
  * start_creating_noperm - prepare to create a given name without permission checking
  * @parent - directory in which to prepare to create the name
diff --git a/include/linux/namei.h b/include/linux/namei.h
index b89be0ac5e87..11b8d410b5eb 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -85,6 +85,12 @@ struct dentry *start_creating(struct mnt_idmap *idmap, struct dentry *parent,
 			      struct qstr *name);
 struct dentry *start_removing(struct mnt_idmap *idmap, struct dentry *parent,
 			      struct qstr *name);
+struct dentry *start_creating_killable(struct mnt_idmap *idmap,
+				       struct dentry *parent,
+				       struct qstr *name);
+struct dentry *start_removing_killable(struct mnt_idmap *idmap,
+				       struct dentry *parent,
+				       struct qstr *name);
 struct dentry *start_creating_noperm(struct dentry *parent, struct qstr *name);
 struct dentry *start_removing_noperm(struct dentry *parent, struct qstr *name);
 struct dentry *start_removing_dentry(struct dentry *parent,
-- 
2.50.0.107.gf914562f5916.dirty


