Return-Path: <linux-fsdevel+bounces-54557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5EFB00F74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 01:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7EB1CA379A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 23:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4492C15BD;
	Thu, 10 Jul 2025 23:21:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FB63208;
	Thu, 10 Jul 2025 23:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752189690; cv=none; b=SzWZnfHaZpIOFlPO16nq6xVBrnahgnLbHwbpi4dRN5nEdSadzqtfGSu6dcJ/e/njB7RNbhj1X+RVSzfkX81evoVgP8mBdNm6oKNA99c07yuySvmQg3mBrikpqM0KNmJJm+8NDdYGzT+gOZZc9eMh6fWqHGYqiACGSDwbjRIqTLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752189690; c=relaxed/simple;
	bh=86mXGli4PX3mNNL3xS3mNLTKQ7AIMW46R7zJd7tyyBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrK56DqKchizlvlzKkHl3WJVhwEatlREF13MqV/WGDVn+IH6cc2/451qsRHo7lEXMf7y9zFSxm1fz021QTZoG1qHUa3bzGfzjIjw/mxceowZzI9DzYemXOIsETERc1daOOx864AnVxRONfbd34nlBFydXQ8rqa1pd0k9++kKKVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ua0Zq-001XFw-NQ;
	Thu, 10 Jul 2025 23:21:20 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/20] ovl: Call ovl_create_temp() without lock held.
Date: Fri, 11 Jul 2025 09:03:33 +1000
Message-ID: <20250710232109.3014537-4-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250710232109.3014537-1-neil@brown.name>
References: <20250710232109.3014537-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ovl currently locks a directory or two and then performs multiple actions
in one or both directories.  This is incompatible with proposed changes
which will lock just the dentry of objects being acted on.

This patch moves calls to ovl_create_temp() out of the locked regions and
has it take and release the relevant lock itself.

The lock that was taken before this function was called is now taken
after.  This means that any code between where the lock was taken and
ovl_create_temp() is now unlocked.  This necessitates the use of
ovl_cleanup_unlocked() and the creation of ovl_lookup_upper_unlocked().
These will be used more widely in future patches.

Now that the file is created before the lock is taken for rename, we
need to ensure the parent wasn't changed before the lock was gained.
ovl_lock_rename_workdir() is changed to optionally receive the dentries
that will be involved in the rename.  If either is present but has the
wrong parent, an error is returned.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/copy_up.c   |  5 ---
 fs/overlayfs/dir.c       | 67 ++++++++++++++++++++--------------------
 fs/overlayfs/overlayfs.h | 12 ++++++-
 fs/overlayfs/super.c     | 11 ++++---
 fs/overlayfs/util.c      |  7 ++++-
 5 files changed, 58 insertions(+), 44 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 25be0b80a40b..eafb46686854 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -523,7 +523,6 @@ static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *fh,
 {
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *indexdir = ovl_indexdir(dentry->d_sb);
-	struct inode *dir = d_inode(indexdir);
 	struct dentry *index = NULL;
 	struct dentry *temp = NULL;
 	struct qstr name = { };
@@ -549,9 +548,7 @@ static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *fh,
 		return err;
 
 	ovl_start_write(dentry);
-	inode_lock(dir);
 	temp = ovl_create_temp(ofs, indexdir, OVL_CATTR(S_IFDIR | 0));
-	inode_unlock(dir);
 	err = PTR_ERR(temp);
 	if (IS_ERR(temp))
 		goto free_name;
@@ -785,9 +782,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 		return err;
 
 	ovl_start_write(c->dentry);
-	inode_lock(wdir);
 	temp = ovl_create_temp(ofs, c->workdir, &cattr);
-	inode_unlock(wdir);
 	ovl_end_write(c->dentry);
 	ovl_revert_cu_creds(&cc);
 
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index cee35d69e0e6..144e1753d0c9 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -214,8 +214,12 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, struct inode *dir,
 struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
 			       struct ovl_cattr *attr)
 {
-	return ovl_create_real(ofs, d_inode(workdir),
-			       ovl_lookup_temp(ofs, workdir), attr);
+	struct dentry *ret;
+	inode_lock(workdir->d_inode);
+	ret = ovl_create_real(ofs, d_inode(workdir),
+			      ovl_lookup_temp(ofs, workdir), attr);
+	inode_unlock(workdir->d_inode);
+	return ret;
 }
 
 static int ovl_set_opaque_xerr(struct dentry *dentry, struct dentry *upper,
@@ -353,7 +357,6 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 	struct dentry *workdir = ovl_workdir(dentry);
 	struct inode *wdir = workdir->d_inode;
 	struct dentry *upperdir = ovl_dentry_upper(dentry->d_parent);
-	struct inode *udir = upperdir->d_inode;
 	struct path upperpath;
 	struct dentry *upper;
 	struct dentry *opaquedir;
@@ -363,28 +366,25 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 	if (WARN_ON(!workdir))
 		return ERR_PTR(-EROFS);
 
-	err = ovl_lock_rename_workdir(workdir, upperdir);
-	if (err)
-		goto out;
-
 	ovl_path_upper(dentry, &upperpath);
 	err = vfs_getattr(&upperpath, &stat,
 			  STATX_BASIC_STATS, AT_STATX_SYNC_AS_STAT);
 	if (err)
-		goto out_unlock;
+		goto out;
 
 	err = -ESTALE;
 	if (!S_ISDIR(stat.mode))
-		goto out_unlock;
+		goto out;
 	upper = upperpath.dentry;
-	if (upper->d_parent->d_inode != udir)
-		goto out_unlock;
 
 	opaquedir = ovl_create_temp(ofs, workdir, OVL_CATTR(stat.mode));
 	err = PTR_ERR(opaquedir);
 	if (IS_ERR(opaquedir))
-		goto out_unlock;
-
+		/* workdir was unlocked, no upperdir */
+		goto out;
+	err = ovl_lock_rename_workdir(workdir, opaquedir, upperdir, upper);
+	if (err)
+		goto out_cleanup_unlocked;
 	err = ovl_copy_xattr(dentry->d_sb, &upperpath, opaquedir);
 	if (err)
 		goto out_cleanup;
@@ -413,10 +413,10 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 	return opaquedir;
 
 out_cleanup:
-	ovl_cleanup(ofs, wdir, opaquedir);
-	dput(opaquedir);
-out_unlock:
 	unlock_rename(workdir, upperdir);
+out_cleanup_unlocked:
+	ovl_cleanup_unlocked(ofs, workdir, opaquedir);
+	dput(opaquedir);
 out:
 	return ERR_PTR(err);
 }
@@ -454,15 +454,11 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 			return err;
 	}
 
-	err = ovl_lock_rename_workdir(workdir, upperdir);
-	if (err)
-		goto out;
-
-	upper = ovl_lookup_upper(ofs, dentry->d_name.name, upperdir,
-				 dentry->d_name.len);
+	upper = ovl_lookup_upper_unlocked(ofs, dentry->d_name.name, upperdir,
+					  dentry->d_name.len);
 	err = PTR_ERR(upper);
 	if (IS_ERR(upper))
-		goto out_unlock;
+		goto out;
 
 	err = -ESTALE;
 	if (d_is_negative(upper) || !ovl_upper_is_whiteout(ofs, upper))
@@ -473,6 +469,10 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 	if (IS_ERR(newdentry))
 		goto out_dput;
 
+	err = ovl_lock_rename_workdir(workdir, newdentry, upperdir, upper);
+	if (err)
+		goto out_cleanup;
+
 	/*
 	 * mode could have been mutilated due to umask (e.g. sgid directory)
 	 */
@@ -487,35 +487,35 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 		err = ovl_do_notify_change(ofs, newdentry, &attr);
 		inode_unlock(newdentry->d_inode);
 		if (err)
-			goto out_cleanup;
+			goto out_cleanup_locked;
 	}
 	if (!hardlink) {
 		err = ovl_set_upper_acl(ofs, newdentry,
 					XATTR_NAME_POSIX_ACL_ACCESS, acl);
 		if (err)
-			goto out_cleanup;
+			goto out_cleanup_locked;
 
 		err = ovl_set_upper_acl(ofs, newdentry,
 					XATTR_NAME_POSIX_ACL_DEFAULT, default_acl);
 		if (err)
-			goto out_cleanup;
+			goto out_cleanup_locked;
 	}
 
 	if (!hardlink && S_ISDIR(cattr->mode)) {
 		err = ovl_set_opaque(dentry, newdentry);
 		if (err)
-			goto out_cleanup;
+			goto out_cleanup_locked;
 
 		err = ovl_do_rename(ofs, workdir, newdentry, upperdir, upper,
 				    RENAME_EXCHANGE);
 		if (err)
-			goto out_cleanup;
+			goto out_cleanup_locked;
 
 		ovl_cleanup(ofs, wdir, upper);
 	} else {
 		err = ovl_do_rename(ofs, workdir, newdentry, upperdir, upper, 0);
 		if (err)
-			goto out_cleanup;
+			goto out_cleanup_locked;
 	}
 	ovl_dir_modified(dentry->d_parent, false);
 	err = ovl_instantiate(dentry, inode, newdentry, hardlink, NULL);
@@ -523,10 +523,9 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 		ovl_cleanup(ofs, udir, newdentry);
 		dput(newdentry);
 	}
+	unlock_rename(workdir, upperdir);
 out_dput:
 	dput(upper);
-out_unlock:
-	unlock_rename(workdir, upperdir);
 out:
 	if (!hardlink) {
 		posix_acl_release(acl);
@@ -534,8 +533,10 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 	}
 	return err;
 
+out_cleanup_locked:
+	unlock_rename(workdir, upperdir);
 out_cleanup:
-	ovl_cleanup(ofs, wdir, newdentry);
+	ovl_cleanup_unlocked(ofs, workdir, newdentry);
 	dput(newdentry);
 	goto out_dput;
 }
@@ -772,7 +773,7 @@ static int ovl_remove_and_whiteout(struct dentry *dentry,
 			goto out;
 	}
 
-	err = ovl_lock_rename_workdir(workdir, upperdir);
+	err = ovl_lock_rename_workdir(workdir, NULL, upperdir, NULL);
 	if (err)
 		goto out_dput;
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 68dc78c712a8..ec804d6bb2ef 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -407,6 +407,15 @@ static inline struct dentry *ovl_lookup_upper(struct ovl_fs *ofs,
 	return lookup_one(ovl_upper_mnt_idmap(ofs), &QSTR_LEN(name, len), base);
 }
 
+static inline struct dentry *ovl_lookup_upper_unlocked(struct ovl_fs *ofs,
+						       const char *name,
+						       struct dentry *base,
+						       int len)
+{
+	return lookup_one_unlocked(ovl_upper_mnt_idmap(ofs),
+				   &QSTR_LEN(name, len), base);
+}
+
 static inline bool ovl_open_flags_need_copy_up(int flags)
 {
 	if (!flags)
@@ -540,7 +549,8 @@ bool ovl_is_inuse(struct dentry *dentry);
 bool ovl_need_index(struct dentry *dentry);
 int ovl_nlink_start(struct dentry *dentry);
 void ovl_nlink_end(struct dentry *dentry);
-int ovl_lock_rename_workdir(struct dentry *workdir, struct dentry *upperdir);
+int ovl_lock_rename_workdir(struct dentry *workdir, struct dentry *work,
+			    struct dentry *upperdir, struct dentry *upper);
 int ovl_check_metacopy_xattr(struct ovl_fs *ofs, const struct path *path,
 			     struct ovl_metacopy *data);
 int ovl_set_metacopy_xattr(struct ovl_fs *ofs, struct dentry *d,
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index cf99b276fdfb..9cce3251dd83 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -564,13 +564,16 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 	struct name_snapshot name;
 	int err;
 
-	inode_lock_nested(dir, I_MUTEX_PARENT);
-
 	temp = ovl_create_temp(ofs, workdir, OVL_CATTR(S_IFREG | 0));
 	err = PTR_ERR(temp);
 	if (IS_ERR(temp))
-		goto out_unlock;
+		return err;
 
+	err = parent_lock(workdir, temp);
+	if (err) {
+		dput(temp);
+		return err;
+	}
 	dest = ovl_lookup_temp(ofs, workdir);
 	err = PTR_ERR(dest);
 	if (IS_ERR(dest)) {
@@ -606,7 +609,7 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 	dput(dest);
 
 out_unlock:
-	inode_unlock(dir);
+	parent_unlock(workdir);
 
 	return err;
 }
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index a5105d68f6b4..9ce9fe62ef28 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1220,7 +1220,8 @@ void ovl_nlink_end(struct dentry *dentry)
 	ovl_inode_unlock(inode);
 }
 
-int ovl_lock_rename_workdir(struct dentry *workdir, struct dentry *upperdir)
+int ovl_lock_rename_workdir(struct dentry *workdir, struct dentry *work,
+			    struct dentry *upperdir, struct dentry *upper)
 {
 	struct dentry *trap;
 
@@ -1234,6 +1235,10 @@ int ovl_lock_rename_workdir(struct dentry *workdir, struct dentry *upperdir)
 		goto err;
 	if (trap)
 		goto err_unlock;
+	if (work && work->d_parent != workdir)
+		goto err_unlock;
+	if (upper && upper->d_parent != upperdir)
+		goto err_unlock;
 
 	return 0;
 
-- 
2.49.0


