Return-Path: <linux-fsdevel+bounces-52824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07595AE72DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 01:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8B43BCC7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 23:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB5825C835;
	Tue, 24 Jun 2025 23:07:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77932571DD;
	Tue, 24 Jun 2025 23:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750806439; cv=none; b=lOGiHI7I1TT7lEiTTEvm/Jsr5Mq8eRlrIkZyFNHxkdreEAqUD8g70iaTeUltCmvPtyoQHdSgYaAtyDtopbtt7TvJx6/zhdQ55Yjmw80ZVu3OmRT/K5WbzqYX/XdmBRhZDqAMUzG+SOPHp/+yVrKfqUjiucsG80T9OxgdTncew2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750806439; c=relaxed/simple;
	bh=+C4lWfBoJAjWZv1fssTnC78Ro7Oo/U8AKaBvjx5oZYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nu7NA6uJehEtpvkbuO1T3NusoAKBShvRFlgKVBqUIUdwSEzuhU04JGLyVsHwwWqjsZMgdoi/1eeCJSfmupQoVOQIeqCOKTYmMqtVRy1pexCggklH9zkdhXOsV3ek6BxFAPu3XNQ9hGPok1blssYDmzhsA6Qv3rl3z5uodn13k4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uUCjR-0045cA-BP;
	Tue, 24 Jun 2025 23:07:13 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/12] ovl: Call ovl_create_temp() and ovl_create_index() without lock held.
Date: Wed, 25 Jun 2025 08:54:58 +1000
Message-ID: <20250624230636.3233059-3-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624230636.3233059-1-neil@brown.name>
References: <20250624230636.3233059-1-neil@brown.name>
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

This patch moves calls to ovl_create_temp() and ovl_create_index() out
of the locked region and has them take and release the relevant lock
themselves.

The lock that was taken before these functions are called is now taken
after.  This means that any code between where the lock was taken and
these calls is now unlocked.  This necessitates the creation of
_unlocked() versions of ovl_cleanup() and ovl_lookup_upper().  These
will be used more widely in future patches.

ovl_cleanup_unlocked() takes a dentry for the directory rather than an
inode as this simplifies calling slightly.

Note that when we move a lookup or create out of a locked region in
which the dentry is acted on, we need to ensure after taking the lock
that the dentry is still in the directory we expect it to be in.  It is
conceivable that it was moved.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/copy_up.c   | 37 +++++++++++-------
 fs/overlayfs/dir.c       | 84 +++++++++++++++++++++++++---------------
 fs/overlayfs/overlayfs.h | 10 +++++
 fs/overlayfs/super.c     |  7 ++--
 4 files changed, 88 insertions(+), 50 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 8a3c0d18ec2e..7a21ad1f2b6e 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -517,15 +517,12 @@ static int ovl_set_upper_fh(struct ovl_fs *ofs, struct dentry *upper,
 
 /*
  * Create and install index entry.
- *
- * Caller must hold i_mutex on indexdir.
  */
 static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *fh,
 			    struct dentry *upper)
 {
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *indexdir = ovl_indexdir(dentry->d_sb);
-	struct inode *dir = d_inode(indexdir);
 	struct dentry *index = NULL;
 	struct dentry *temp = NULL;
 	struct qstr name = { };
@@ -558,17 +555,21 @@ static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *fh,
 	err = ovl_set_upper_fh(ofs, upper, temp);
 	if (err)
 		goto out;
-
+	lock_rename(indexdir, indexdir);
 	index = ovl_lookup_upper(ofs, name.name, indexdir, name.len);
 	if (IS_ERR(index)) {
 		err = PTR_ERR(index);
+	} else if (temp->d_parent != indexdir) {
+		err = -EINVAL;
+		dput(index);
 	} else {
 		err = ovl_do_rename(ofs, indexdir, temp, indexdir, index, 0);
 		dput(index);
 	}
+	unlock_rename(indexdir, indexdir);
 out:
 	if (err)
-		ovl_cleanup(ofs, dir, temp);
+		ovl_cleanup_unlocked(ofs, indexdir, temp);
 	dput(temp);
 free_name:
 	kfree(name.name);
@@ -779,9 +780,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 		return err;
 
 	ovl_start_write(c->dentry);
-	inode_lock(wdir);
 	temp = ovl_create_temp(ofs, c->workdir, &cattr);
-	inode_unlock(wdir);
 	ovl_end_write(c->dentry);
 	ovl_revert_cu_creds(&cc);
 
@@ -794,6 +793,8 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	 */
 	path.dentry = temp;
 	err = ovl_copy_up_data(c, &path);
+	if (err)
+		goto cleanup_write_unlocked;
 	/*
 	 * We cannot hold lock_rename() throughout this helper, because of
 	 * lock ordering with sb_writers, which shouldn't be held when calling
@@ -801,6 +802,13 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	 * temp wasn't moved before copy up completion or cleanup.
 	 */
 	ovl_start_write(c->dentry);
+
+	if (S_ISDIR(c->stat.mode) && c->indexed) {
+		err = ovl_create_index(c->dentry, c->origin_fh, temp);
+		if (err)
+			goto cleanup_unlocked;
+	}
+
 	trap = lock_rename(c->workdir, c->destdir);
 	if (trap || temp->d_parent != c->workdir) {
 		/* temp or workdir moved underneath us? abort without cleanup */
@@ -809,20 +817,12 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 		if (IS_ERR(trap))
 			goto out;
 		goto unlock;
-	} else if (err) {
-		goto cleanup;
 	}
 
 	err = ovl_copy_up_metadata(c, temp);
 	if (err)
 		goto cleanup;
 
-	if (S_ISDIR(c->stat.mode) && c->indexed) {
-		err = ovl_create_index(c->dentry, c->origin_fh, temp);
-		if (err)
-			goto cleanup;
-	}
-
 	upper = ovl_lookup_upper(ofs, c->destname.name, c->destdir,
 				 c->destname.len);
 	err = PTR_ERR(upper);
@@ -857,6 +857,13 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	ovl_cleanup(ofs, wdir, temp);
 	dput(temp);
 	goto unlock;
+
+cleanup_write_unlocked:
+	ovl_start_write(c->dentry);
+cleanup_unlocked:
+	ovl_cleanup_unlocked(ofs, c->workdir, temp);
+	dput(temp);
+	goto out;
 }
 
 /* Copyup using O_TMPFILE which does not require cross dir locking */
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 4fc221ea6480..a51a3dc02bf5 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -43,6 +43,21 @@ int ovl_cleanup(struct ovl_fs *ofs, struct inode *wdir, struct dentry *wdentry)
 	return err;
 }
 
+int ovl_cleanup_unlocked(struct ovl_fs *ofs, struct dentry *workdir,
+			 struct dentry *wdentry)
+{
+	int err;
+
+	inode_lock_nested(workdir->d_inode, I_MUTEX_PARENT);
+	if (wdentry->d_parent == workdir)
+		ovl_cleanup(ofs, workdir->d_inode, wdentry);
+	else
+		err = -EINVAL;
+	inode_unlock(workdir->d_inode);
+
+	return err;
+}
+
 struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdir)
 {
 	struct dentry *temp;
@@ -199,8 +214,12 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, struct inode *dir,
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
@@ -348,28 +367,30 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
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
+	/* This test is racey but we re-test under the lock */
+	if (upper->d_parent != upperdir)
+		goto out;
 
 	opaquedir = ovl_create_temp(ofs, workdir, OVL_CATTR(stat.mode));
 	err = PTR_ERR(opaquedir);
 	if (IS_ERR(opaquedir))
-		goto out_unlock;
-
+		/* workdir was unlocked, no upperdir */
+		goto out;
+	err = ovl_lock_rename_workdir(workdir, upperdir);
+	if (err)
+		goto out_cleanup_unlocked;
+	if (upper->d_parent->d_inode != udir)
+		goto out_cleanup;
 	err = ovl_copy_xattr(dentry->d_sb, &upperpath, opaquedir);
 	if (err)
 		goto out_cleanup;
@@ -398,10 +419,10 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
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
@@ -439,15 +460,11 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
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
@@ -458,6 +475,10 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 	if (IS_ERR(newdentry))
 		goto out_dput;
 
+	err = ovl_lock_rename_workdir(workdir, upperdir);
+	if (err)
+		goto out_cleanup;
+
 	/*
 	 * mode could have been mutilated due to umask (e.g. sgid directory)
 	 */
@@ -472,35 +493,35 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
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
@@ -508,10 +529,9 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
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
@@ -519,8 +539,10 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
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
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 42228d10f6b9..508003e26e08 100644
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
@@ -843,6 +852,7 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs,
 			       struct inode *dir, struct dentry *newdentry,
 			       struct ovl_cattr *attr);
 int ovl_cleanup(struct ovl_fs *ofs, struct inode *dir, struct dentry *dentry);
+int ovl_cleanup_unlocked(struct ovl_fs *ofs, struct dentry *workdir, struct dentry *dentry);
 struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdir);
 struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
 			       struct ovl_cattr *attr);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index db046b0d6a68..576b5c3b537c 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -558,13 +558,12 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 	struct name_snapshot name;
 	int err;
 
-	inode_lock_nested(dir, I_MUTEX_PARENT);
-
 	temp = ovl_create_temp(ofs, workdir, OVL_CATTR(S_IFREG | 0));
 	err = PTR_ERR(temp);
 	if (IS_ERR(temp))
-		goto out_unlock;
+		return err;
 
+	lock_rename(workdir, workdir);
 	dest = ovl_lookup_temp(ofs, workdir);
 	err = PTR_ERR(dest);
 	if (IS_ERR(dest)) {
@@ -600,7 +599,7 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 	dput(dest);
 
 out_unlock:
-	inode_unlock(dir);
+	unlock_rename(workdir, workdir);
 
 	return err;
 }
-- 
2.49.0


