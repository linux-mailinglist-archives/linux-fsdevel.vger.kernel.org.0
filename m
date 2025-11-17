Return-Path: <linux-fsdevel+bounces-68677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2ACC6349F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85B404E9CCE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999A732E6A1;
	Mon, 17 Nov 2025 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJyN9BKw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE31232E15D;
	Mon, 17 Nov 2025 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372086; cv=none; b=SSmR9h26Ztc6yVUcz79/OXZ737WJ8DVR/Vvz3nB03jTeK3xAAiy9f24IrSzv+H5G0QtGENa8b4SyXRs8KKuPUYmSYX6KEfK2srQPspgAk07Y0CqaTFZOba7y6qWT098K+GPY85cii2733Ql8qRJRijJfE7puWdldQY1ypuRdTHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372086; c=relaxed/simple;
	bh=W2c6MmMTcXoPOYzUs1Zpu4JjvkUAhCIB7TMDlxKnAgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rUoo7Lco7EwLb/q1Tjj+gy3a6mDw5q2IH51Rw6/vaAwC8OKYMYDxqtxgtrCUa5v06p8nDYAK0MTMe+epLkhxS4QUGbLef+ep1GMN/IctzL+ow4sR9P9HnqRIWB0peylMzn2vnhfJIFmzUko8sZUi3zxQJS/Lo8IHe99qE9zSwbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJyN9BKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF72C4CEF5;
	Mon, 17 Nov 2025 09:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372085;
	bh=W2c6MmMTcXoPOYzUs1Zpu4JjvkUAhCIB7TMDlxKnAgk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KJyN9BKwP+0Ff4ojXjbxsf2cJiMBG0kMiRBuiwjZq3GK/ZhZglOLl0ieTyu9mI7Xx
	 fbEGbAWdSZIqoYDD2Bk7H0usol3gv5SZUak6BsBQrcQY5JzYlMpL3W0lhHZQTWb40D
	 N93KP3CG10S9ErgJtBwTg0IPuULsqEdx8PMj5Fj//PbIm82Pp51v6LfCm3gyJql3VT
	 zm1F8vfAvkscoyEBJZNP6xI8dP4dQ+A5WCDouTcDRm5znaWH6kk+tVaLUi2yxS1Ymc
	 zUvuRtThw2fhKYGPs0ymFAzCkl0XXJoEiImNCkxa+NbrTJuePjGSJgxcZxZk+L7atf
	 QXr0jp2aONexA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:34:05 +0100
Subject: [PATCH v4 34/42] ovl: refactor ovl_rename()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-34-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11130; i=brauner@kernel.org;
 h=from:subject:message-id; bh=W2c6MmMTcXoPOYzUs1Zpu4JjvkUAhCIB7TMDlxKnAgk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf42UTumbtLDiZLebf3ntvZ/nsyRf1I4eEmwcv7Ey
 tQG+7XMHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMRzWT4X/Liu0jVZJmeyviJ
 VZ6ds/b+fiRl0vVq947s/8ZZ0tkNGxn+x73fubm/PVix9lXrj2PqBvF3b8zUXv0msqXhzg6ViAt
 rmQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Extract the code that runs under overridden credentials into a separate
ovl_rename_upper() helper function and the code that runs before/after to
ovl_rename_start/end(). Error handling is simplified.
The helpers returns errors directly instead of using goto labels.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 222 +++++++++++++++++++++++++++++------------------------
 1 file changed, 120 insertions(+), 102 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index d16a09aaab99..b0e619a9b004 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1100,105 +1100,97 @@ struct ovl_renamedata {
 	bool overwrite;
 };
 
-static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
-		      struct dentry *old, struct inode *newdir,
-		      struct dentry *new, unsigned int flags)
+static int ovl_rename_start(struct ovl_renamedata *ovlrd, struct list_head *list)
 {
-	int err;
-	struct dentry *old_upperdir;
-	struct dentry *new_upperdir;
-	struct dentry *trap, *de;
-	bool old_opaque;
-	bool new_opaque;
+	struct dentry *old = ovlrd->old_dentry;
+	struct dentry *new = ovlrd->new_dentry;
 	bool is_dir = d_is_dir(old);
 	bool new_is_dir = d_is_dir(new);
-	const struct cred *old_cred = NULL;
-	struct ovl_fs *ofs = OVL_FS(old->d_sb);
-	struct ovl_renamedata ovlrd = {
-		.old_parent		= old->d_parent,
-		.old_dentry		= old,
-		.new_parent		= new->d_parent,
-		.new_dentry		= new,
-		.flags			= flags,
-		.cleanup_whiteout	= false,
-		.overwrite		= !(flags & RENAME_EXCHANGE),
-	};
-	LIST_HEAD(list);
-	bool samedir = ovlrd.old_parent == ovlrd.new_parent;
+	int err;
 
-	err = -EINVAL;
-	if (ovlrd.flags & ~(RENAME_EXCHANGE | RENAME_NOREPLACE))
-		goto out;
+	if (ovlrd->flags & ~(RENAME_EXCHANGE | RENAME_NOREPLACE))
+		return -EINVAL;
 
-	ovlrd.flags &= ~RENAME_NOREPLACE;
+	ovlrd->flags &= ~RENAME_NOREPLACE;
 
 	/* Don't copy up directory trees */
 	err = -EXDEV;
 	if (!ovl_can_move(old))
-		goto out;
-	if (!ovlrd.overwrite && !ovl_can_move(new))
-		goto out;
+		return err;
+	if (!ovlrd->overwrite && !ovl_can_move(new))
+		return err;
 
-	if (ovlrd.overwrite && new_is_dir && !ovl_pure_upper(new)) {
-		err = ovl_check_empty_dir(new, &list);
+	if (ovlrd->overwrite && new_is_dir && !ovl_pure_upper(new)) {
+		err = ovl_check_empty_dir(new, list);
 		if (err)
-			goto out;
+			return err;
 	}
 
-	if (ovlrd.overwrite) {
+	if (ovlrd->overwrite) {
 		if (ovl_lower_positive(old)) {
 			if (!ovl_dentry_is_whiteout(new)) {
 				/* Whiteout source */
-				ovlrd.flags |= RENAME_WHITEOUT;
+				ovlrd->flags |= RENAME_WHITEOUT;
 			} else {
 				/* Switch whiteouts */
-				ovlrd.flags |= RENAME_EXCHANGE;
+				ovlrd->flags |= RENAME_EXCHANGE;
 			}
 		} else if (is_dir && ovl_dentry_is_whiteout(new)) {
-			ovlrd.flags |= RENAME_EXCHANGE;
-			ovlrd.cleanup_whiteout = true;
+			ovlrd->flags |= RENAME_EXCHANGE;
+			ovlrd->cleanup_whiteout = true;
 		}
 	}
 
 	err = ovl_copy_up(old);
 	if (err)
-		goto out;
+		return err;
 
-	err = ovl_copy_up(ovlrd.new_parent);
+	err = ovl_copy_up(new->d_parent);
 	if (err)
-		goto out;
-	if (!ovlrd.overwrite) {
+		return err;
+	if (!ovlrd->overwrite) {
 		err = ovl_copy_up(new);
 		if (err)
-			goto out;
+			return err;
 	} else if (d_inode(new)) {
 		err = ovl_nlink_start(new);
 		if (err)
-			goto out;
+			return err;
 
-		ovlrd.update_nlink = true;
+		ovlrd->update_nlink = true;
 	}
 
-	if (!ovlrd.update_nlink) {
+	if (!ovlrd->update_nlink) {
 		/* ovl_nlink_start() took ovl_want_write() */
 		err = ovl_want_write(old);
 		if (err)
-			goto out;
+			return err;
 	}
 
-	old_cred = ovl_override_creds(old->d_sb);
+	return 0;
+}
 
-	if (!list_empty(&list)) {
-		ovlrd.opaquedir = ovl_clear_empty(new, &list);
-		err = PTR_ERR(ovlrd.opaquedir);
-		if (IS_ERR(ovlrd.opaquedir)) {
-			ovlrd.opaquedir = NULL;
-			goto out_revert_creds;
-		}
-	}
+static int ovl_rename_upper(struct ovl_renamedata *ovlrd, struct list_head *list)
+{
+	struct dentry *old = ovlrd->old_dentry;
+	struct dentry *new = ovlrd->new_dentry;
+	struct ovl_fs *ofs = OVL_FS(old->d_sb);
+	unsigned int flags = ovlrd->flags;
+	struct dentry *old_upperdir = ovl_dentry_upper(ovlrd->old_parent);
+	struct dentry *new_upperdir = ovl_dentry_upper(ovlrd->new_parent);
+	bool samedir = ovlrd->old_parent == ovlrd->new_parent;
+	bool is_dir = d_is_dir(old);
+	bool new_is_dir = d_is_dir(new);
+	struct dentry *trap, *de;
+	bool old_opaque, new_opaque;
+	int err;
 
-	old_upperdir = ovl_dentry_upper(ovlrd.old_parent);
-	new_upperdir = ovl_dentry_upper(ovlrd.new_parent);
+	if (!list_empty(list)) {
+		de = ovl_clear_empty(new, list);
+		if (IS_ERR(de))
+			return PTR_ERR(de);
+		ovlrd->opaquedir = de;
+	}
 
 	if (!samedir) {
 		/*
@@ -1208,32 +1200,30 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 		 * lookup the origin inodes of the entries to fill d_ino.
 		 */
 		if (ovl_type_origin(old)) {
-			err = ovl_set_impure(ovlrd.new_parent, new_upperdir);
+			err = ovl_set_impure(ovlrd->new_parent, new_upperdir);
 			if (err)
-				goto out_revert_creds;
+				return err;
 		}
-		if (!ovlrd.overwrite && ovl_type_origin(new)) {
-			err = ovl_set_impure(ovlrd.old_parent, old_upperdir);
+		if (!ovlrd->overwrite && ovl_type_origin(new)) {
+			err = ovl_set_impure(ovlrd->old_parent, old_upperdir);
 			if (err)
-				goto out_revert_creds;
+				return err;
 		}
 	}
 
 	trap = lock_rename(new_upperdir, old_upperdir);
-	if (IS_ERR(trap)) {
-		err = PTR_ERR(trap);
-		goto out_revert_creds;
-	}
+	if (IS_ERR(trap))
+		return PTR_ERR(trap);
 
 	de = ovl_lookup_upper(ofs, old->d_name.name, old_upperdir,
 			      old->d_name.len);
 	err = PTR_ERR(de);
 	if (IS_ERR(de))
 		goto out_unlock;
-	ovlrd.old_upper = de;
+	ovlrd->old_upper = de;
 
 	err = -ESTALE;
-	if (!ovl_matches_upper(old, ovlrd.old_upper))
+	if (!ovl_matches_upper(old, ovlrd->old_upper))
 		goto out_unlock;
 
 	de = ovl_lookup_upper(ofs, new->d_name.name, new_upperdir,
@@ -1241,73 +1231,74 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	err = PTR_ERR(de);
 	if (IS_ERR(de))
 		goto out_unlock;
-	ovlrd.new_upper = de;
+	ovlrd->new_upper = de;
 
 	old_opaque = ovl_dentry_is_opaque(old);
 	new_opaque = ovl_dentry_is_opaque(new);
 
 	err = -ESTALE;
 	if (d_inode(new) && ovl_dentry_upper(new)) {
-		if (ovlrd.opaquedir) {
-			if (ovlrd.new_upper != ovlrd.opaquedir)
+		if (ovlrd->opaquedir) {
+			if (ovlrd->new_upper != ovlrd->opaquedir)
 				goto out_unlock;
 		} else {
-			if (!ovl_matches_upper(new, ovlrd.new_upper))
+			if (!ovl_matches_upper(new, ovlrd->new_upper))
 				goto out_unlock;
 		}
 	} else {
-		if (!d_is_negative(ovlrd.new_upper)) {
-			if (!new_opaque || !ovl_upper_is_whiteout(ofs, ovlrd.new_upper))
+		if (!d_is_negative(ovlrd->new_upper)) {
+			if (!new_opaque || !ovl_upper_is_whiteout(ofs, ovlrd->new_upper))
 				goto out_unlock;
 		} else {
-			if (ovlrd.flags & RENAME_EXCHANGE)
+			if (flags & RENAME_EXCHANGE)
 				goto out_unlock;
 		}
 	}
 
-	if (ovlrd.old_upper == trap)
+	if (ovlrd->old_upper == trap)
 		goto out_unlock;
-	if (ovlrd.new_upper == trap)
+	if (ovlrd->new_upper == trap)
 		goto out_unlock;
 
-	if (ovlrd.old_upper->d_inode == ovlrd.new_upper->d_inode)
+	if (ovlrd->old_upper->d_inode == ovlrd->new_upper->d_inode)
 		goto out_unlock;
 
 	err = 0;
 	if (ovl_type_merge_or_lower(old))
 		err = ovl_set_redirect(old, samedir);
-	else if (is_dir && !old_opaque && ovl_type_merge(ovlrd.new_parent))
-		err = ovl_set_opaque_xerr(old, ovlrd.old_upper, -EXDEV);
+	else if (is_dir && !old_opaque && ovl_type_merge(ovlrd->new_parent))
+		err = ovl_set_opaque_xerr(old, ovlrd->old_upper, -EXDEV);
 	if (err)
 		goto out_unlock;
 
-	if (!ovlrd.overwrite && ovl_type_merge_or_lower(new))
+	if (!ovlrd->overwrite && ovl_type_merge_or_lower(new))
 		err = ovl_set_redirect(new, samedir);
-	else if (!ovlrd.overwrite && new_is_dir && !new_opaque &&
-		 ovl_type_merge(ovlrd.old_parent))
-		err = ovl_set_opaque_xerr(new, ovlrd.new_upper, -EXDEV);
+	else if (!ovlrd->overwrite && new_is_dir && !new_opaque &&
+		 ovl_type_merge(ovlrd->old_parent))
+		err = ovl_set_opaque_xerr(new, ovlrd->new_upper, -EXDEV);
 	if (err)
 		goto out_unlock;
 
-	err = ovl_do_rename(ofs, old_upperdir, ovlrd.old_upper,
-			    new_upperdir, ovlrd.new_upper, flags);
+	err = ovl_do_rename(ofs, old_upperdir, ovlrd->old_upper,
+			    new_upperdir, ovlrd->new_upper, flags);
+out_unlock:
 	unlock_rename(new_upperdir, old_upperdir);
 	if (err)
-		goto out_revert_creds;
+		return err;
 
-	if (ovlrd.cleanup_whiteout)
-		ovl_cleanup(ofs, old_upperdir, ovlrd.new_upper);
+	if (ovlrd->cleanup_whiteout)
+		ovl_cleanup(ofs, old_upperdir, ovlrd->new_upper);
 
-	if (ovlrd.overwrite && d_inode(new)) {
+	if (ovlrd->overwrite && d_inode(new)) {
 		if (new_is_dir)
 			clear_nlink(d_inode(new));
 		else
 			ovl_drop_nlink(new);
 	}
 
-	ovl_dir_modified(ovlrd.old_parent, ovl_type_origin(old) ||
-			 (!ovlrd.overwrite && ovl_type_origin(new)));
-	ovl_dir_modified(ovlrd.new_parent, ovl_type_origin(old) ||
+	ovl_dir_modified(ovlrd->old_parent, ovl_type_origin(old) ||
+			 (!ovlrd->overwrite && ovl_type_origin(new)));
+	ovl_dir_modified(ovlrd->new_parent, ovl_type_origin(old) ||
 			 (d_inode(new) && ovl_type_origin(new)));
 
 	/* copy ctime: */
@@ -1315,22 +1306,49 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	if (d_inode(new) && ovl_dentry_upper(new))
 		ovl_copyattr(d_inode(new));
 
-out_revert_creds:
-	ovl_revert_creds(old_cred);
-	if (ovlrd.update_nlink)
-		ovl_nlink_end(new);
+	return err;
+}
+
+static void ovl_rename_end(struct ovl_renamedata *ovlrd)
+{
+	if (ovlrd->update_nlink)
+		ovl_nlink_end(ovlrd->new_dentry);
 	else
-		ovl_drop_write(old);
+		ovl_drop_write(ovlrd->old_dentry);
+}
+
+static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
+		      struct dentry *old, struct inode *newdir,
+		      struct dentry *new, unsigned int flags)
+{
+	const struct cred *old_cred = NULL;
+	struct ovl_renamedata ovlrd = {
+		.old_parent		= old->d_parent,
+		.old_dentry		= old,
+		.new_parent		= new->d_parent,
+		.new_dentry		= new,
+		.flags			= flags,
+		.overwrite		= !(flags & RENAME_EXCHANGE),
+	};
+	LIST_HEAD(list);
+	int err;
+
+	err = ovl_rename_start(&ovlrd, &list);
+	if (err)
+		goto out;
+
+	old_cred = ovl_override_creds(old->d_sb);
+
+	err = ovl_rename_upper(&ovlrd, &list);
+
+	ovl_revert_creds(old_cred);
+	ovl_rename_end(&ovlrd);
 out:
 	dput(ovlrd.new_upper);
 	dput(ovlrd.old_upper);
 	dput(ovlrd.opaquedir);
 	ovl_cache_free(&list);
 	return err;
-
-out_unlock:
-	unlock_rename(new_upperdir, old_upperdir);
-	goto out_revert_creds;
 }
 
 static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,

-- 
2.47.3


