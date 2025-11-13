Return-Path: <linux-fsdevel+bounces-68251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 336DDC57917
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B8486356086
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5F5355047;
	Thu, 13 Nov 2025 13:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSbvCJVj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C66D355045;
	Thu, 13 Nov 2025 13:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039012; cv=none; b=rC9VYMxeEHpyq39pF/zQ+6aGf4nhtPwgOHvEUBCvdayaQXSdannWAQ0X9HQbWLuzdx2uhDH7n6m0qkWmfcoBq2EFdUMKltr38nZ+zLbJZkvqpZtE5z4GTNGfxwXiRRJz+CuL7brIJd2lGVVBKsu1nlhxj2Wg+1fXqH8qTBp3NF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039012; c=relaxed/simple;
	bh=vksKly6OytlaVpvodsPiP/0YfpMTThMl+2cRtgE2P4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DFcyNDxDpz3F/7/RLcfgctc2mTzNdlJ6kA7MEXN1MjqNbKmmNz97BP44AuPfu5eC/I0qRV/jMMgNJihi+ExQ+sM3vPxJk7AjJOHo3YKh6jVHzFh4Lm5BpGNEqk05VaI/GettV3C8a3BfreQnKxlZIyDhMOUiY3QVL5reog4JRcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSbvCJVj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277C3C4CEFB;
	Thu, 13 Nov 2025 13:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763039012;
	bh=vksKly6OytlaVpvodsPiP/0YfpMTThMl+2cRtgE2P4o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FSbvCJVjZsPOHKia4ltyn09hPlhEpzH6p4Sl8b4IJO9GvX1IvibNoAUattErsCanO
	 KjrCvchXZhuzh0TUnfU2y8PfDOEvvqW0alEPd+KUgoVnmOr/naObVVciK131XEXS+L
	 LlgeeACZ4QAGt7GA9evEI1PLNpY3aGWgJBLZEax/pbyZhNHKluOwZWaymXYSUjXIZF
	 iPrkQXHPCF5ADt+BWlU6RfHsrAibW39oP481xx1SA36vWrw9LOB6YSPAZPZhP7NjH5
	 KWjFTmBJrRW0v+h7swg/7lH+3RHwE/3VrHVFtAHuc9zvFaVa9fsKb+a9NB36vdJcAn
	 aKS7ViueLZRRw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:54 +0100
Subject: [PATCH RFC 34/42] ovl: refactor ovl_rename()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-34-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10870; i=brauner@kernel.org;
 h=from:subject:message-id; bh=vksKly6OytlaVpvodsPiP/0YfpMTThMl+2cRtgE2P4o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnti2Lb2f2+L/BSX+WbFh5eIHJ8f+HLy64/8D++bC
 IZHGATZdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk7y5Ghj031UQmbVm4J3Lb
 noCJ56rN2x/WZtZYzZLfqHWUsfiC8n2G/4Em80s7xedPT5ET3z/JLojX8eDusJ6KS1yGbV8nc6v
 94AQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make use of fms extensions and add a struct ovl_renamedata which embedds
the vfs struct and adds overlayfs specific data.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 271 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 143 insertions(+), 128 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 86b72bf87833..d61f5d681fec 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1090,103 +1090,36 @@ static int ovl_set_redirect(struct dentry *dentry, bool samedir)
 	return err;
 }
 
-static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
-		      struct dentry *old, struct inode *newdir,
-		      struct dentry *new, unsigned int flags)
+struct ovl_renamedata {
+	struct renamedata;
+	struct dentry *opaquedir;
+	struct dentry *olddentry;
+	struct dentry *newdentry;
+	bool cleanup_whiteout;
+};
+
+static int do_ovl_rename(struct ovl_renamedata *ovlrd, struct list_head *list)
 {
-	int err;
-	struct dentry *old_upperdir;
-	struct dentry *new_upperdir;
-	struct dentry *olddentry = NULL;
-	struct dentry *newdentry = NULL;
-	struct dentry *trap, *de;
-	bool old_opaque;
-	bool new_opaque;
-	bool cleanup_whiteout = false;
-	bool update_nlink = false;
+	struct dentry *old = ovlrd->old_dentry;
+	struct dentry *new = ovlrd->new_dentry;
+	struct ovl_fs *ofs = OVL_FS(old->d_sb);
+	unsigned int flags = ovlrd->flags;
+	struct dentry *old_upperdir = ovl_dentry_upper(ovlrd->old_parent);
+	struct dentry *new_upperdir = ovl_dentry_upper(ovlrd->new_parent);
+	bool samedir = ovlrd->old_parent == ovlrd->new_parent;
 	bool overwrite = !(flags & RENAME_EXCHANGE);
 	bool is_dir = d_is_dir(old);
 	bool new_is_dir = d_is_dir(new);
-	bool samedir = olddir == newdir;
-	struct dentry *opaquedir = NULL;
-	const struct cred *old_cred = NULL;
-	struct ovl_fs *ofs = OVL_FS(old->d_sb);
-	LIST_HEAD(list);
-
-	err = -EINVAL;
-	if (flags & ~(RENAME_EXCHANGE | RENAME_NOREPLACE))
-		goto out;
-
-	flags &= ~RENAME_NOREPLACE;
-
-	/* Don't copy up directory trees */
-	err = -EXDEV;
-	if (!ovl_can_move(old))
-		goto out;
-	if (!overwrite && !ovl_can_move(new))
-		goto out;
-
-	if (overwrite && new_is_dir && !ovl_pure_upper(new)) {
-		err = ovl_check_empty_dir(new, &list);
-		if (err)
-			goto out;
-	}
-
-	if (overwrite) {
-		if (ovl_lower_positive(old)) {
-			if (!ovl_dentry_is_whiteout(new)) {
-				/* Whiteout source */
-				flags |= RENAME_WHITEOUT;
-			} else {
-				/* Switch whiteouts */
-				flags |= RENAME_EXCHANGE;
-			}
-		} else if (is_dir && ovl_dentry_is_whiteout(new)) {
-			flags |= RENAME_EXCHANGE;
-			cleanup_whiteout = true;
-		}
-	}
-
-	err = ovl_copy_up(old);
-	if (err)
-		goto out;
-
-	err = ovl_copy_up(new->d_parent);
-	if (err)
-		goto out;
-	if (!overwrite) {
-		err = ovl_copy_up(new);
-		if (err)
-			goto out;
-	} else if (d_inode(new)) {
-		err = ovl_nlink_start(new);
-		if (err)
-			goto out;
-
-		update_nlink = true;
-	}
-
-	if (!update_nlink) {
-		/* ovl_nlink_start() took ovl_want_write() */
-		err = ovl_want_write(old);
-		if (err)
-			goto out;
-	}
-
-	old_cred = ovl_override_creds(old->d_sb);
+	struct dentry *trap, *de;
+	bool old_opaque, new_opaque;
+	int err;
 
-	if (!list_empty(&list)) {
-		opaquedir = ovl_clear_empty(new, &list);
-		err = PTR_ERR(opaquedir);
-		if (IS_ERR(opaquedir)) {
-			opaquedir = NULL;
-			goto out_revert_creds;
-		}
+	if (!list_empty(list)) {
+		ovlrd->opaquedir = ovl_clear_empty(new, list);
+		if (IS_ERR(ovlrd->opaquedir))
+			return PTR_ERR(ovlrd->opaquedir);
 	}
 
-	old_upperdir = ovl_dentry_upper(old->d_parent);
-	new_upperdir = ovl_dentry_upper(new->d_parent);
-
 	if (!samedir) {
 		/*
 		 * When moving a merge dir or non-dir with copy up origin into
@@ -1195,32 +1128,30 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 		 * lookup the origin inodes of the entries to fill d_ino.
 		 */
 		if (ovl_type_origin(old)) {
-			err = ovl_set_impure(new->d_parent, new_upperdir);
+			err = ovl_set_impure(ovlrd->new_parent, new_upperdir);
 			if (err)
-				goto out_revert_creds;
+				return err;
 		}
 		if (!overwrite && ovl_type_origin(new)) {
-			err = ovl_set_impure(old->d_parent, old_upperdir);
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
-	olddentry = de;
+	ovlrd->olddentry = de;
 
 	err = -ESTALE;
-	if (!ovl_matches_upper(old, olddentry))
+	if (!ovl_matches_upper(old, ovlrd->olddentry))
 		goto out_unlock;
 
 	de = ovl_lookup_upper(ofs, new->d_name.name, new_upperdir,
@@ -1228,23 +1159,23 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	err = PTR_ERR(de);
 	if (IS_ERR(de))
 		goto out_unlock;
-	newdentry = de;
+	ovlrd->newdentry = de;
 
 	old_opaque = ovl_dentry_is_opaque(old);
 	new_opaque = ovl_dentry_is_opaque(new);
 
 	err = -ESTALE;
 	if (d_inode(new) && ovl_dentry_upper(new)) {
-		if (opaquedir) {
-			if (newdentry != opaquedir)
+		if (ovlrd->opaquedir) {
+			if (ovlrd->newdentry != ovlrd->opaquedir)
 				goto out_unlock;
 		} else {
-			if (!ovl_matches_upper(new, newdentry))
+			if (!ovl_matches_upper(new, ovlrd->newdentry))
 				goto out_unlock;
 		}
 	} else {
-		if (!d_is_negative(newdentry)) {
-			if (!new_opaque || !ovl_upper_is_whiteout(ofs, newdentry))
+		if (!d_is_negative(ovlrd->newdentry)) {
+			if (!new_opaque || !ovl_upper_is_whiteout(ofs, ovlrd->newdentry))
 				goto out_unlock;
 		} else {
 			if (flags & RENAME_EXCHANGE)
@@ -1252,38 +1183,39 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 		}
 	}
 
-	if (olddentry == trap)
+	if (ovlrd->olddentry == trap)
 		goto out_unlock;
-	if (newdentry == trap)
+	if (ovlrd->newdentry == trap)
 		goto out_unlock;
 
-	if (olddentry->d_inode == newdentry->d_inode)
+	if (ovlrd->olddentry->d_inode == ovlrd->newdentry->d_inode)
 		goto out_unlock;
 
 	err = 0;
 	if (ovl_type_merge_or_lower(old))
 		err = ovl_set_redirect(old, samedir);
-	else if (is_dir && !old_opaque && ovl_type_merge(new->d_parent))
-		err = ovl_set_opaque_xerr(old, olddentry, -EXDEV);
+	else if (is_dir && !old_opaque && ovl_type_merge(ovlrd->new_parent))
+		err = ovl_set_opaque_xerr(old, ovlrd->olddentry, -EXDEV);
 	if (err)
 		goto out_unlock;
 
 	if (!overwrite && ovl_type_merge_or_lower(new))
 		err = ovl_set_redirect(new, samedir);
 	else if (!overwrite && new_is_dir && !new_opaque &&
-		 ovl_type_merge(old->d_parent))
-		err = ovl_set_opaque_xerr(new, newdentry, -EXDEV);
+		 ovl_type_merge(ovlrd->old_parent))
+		err = ovl_set_opaque_xerr(new, ovlrd->newdentry, -EXDEV);
 	if (err)
 		goto out_unlock;
 
-	err = ovl_do_rename(ofs, old_upperdir, olddentry,
-			    new_upperdir, newdentry, flags);
+	err = ovl_do_rename(ofs, old_upperdir, ovlrd->olddentry,
+			    new_upperdir, ovlrd->newdentry, flags);
+out_unlock:
 	unlock_rename(new_upperdir, old_upperdir);
 	if (err)
-		goto out_revert_creds;
+		return err;
 
-	if (cleanup_whiteout)
-		ovl_cleanup(ofs, old_upperdir, newdentry);
+	if (ovlrd->cleanup_whiteout)
+		ovl_cleanup(ofs, old_upperdir, ovlrd->newdentry);
 
 	if (overwrite && d_inode(new)) {
 		if (new_is_dir)
@@ -1292,9 +1224,9 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 			ovl_drop_nlink(new);
 	}
 
-	ovl_dir_modified(old->d_parent, ovl_type_origin(old) ||
+	ovl_dir_modified(ovlrd->old_parent, ovl_type_origin(old) ||
 			 (!overwrite && ovl_type_origin(new)));
-	ovl_dir_modified(new->d_parent, ovl_type_origin(old) ||
+	ovl_dir_modified(ovlrd->new_parent, ovl_type_origin(old) ||
 			 (d_inode(new) && ovl_type_origin(new)));
 
 	/* copy ctime: */
@@ -1302,22 +1234,105 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	if (d_inode(new) && ovl_dentry_upper(new))
 		ovl_copyattr(d_inode(new));
 
-out_revert_creds:
+	return err;
+}
+
+static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
+		      struct dentry *old, struct inode *newdir,
+		      struct dentry *new, unsigned int flags)
+{
+	int err;
+	bool update_nlink = false;
+	bool overwrite = !(flags & RENAME_EXCHANGE);
+	bool is_dir = d_is_dir(old);
+	bool new_is_dir = d_is_dir(new);
+	const struct cred *old_cred = NULL;
+	struct ovl_renamedata ovlrd = {
+		.old_parent		= old->d_parent,
+		.old_dentry		= old,
+		.new_parent		= new->d_parent,
+		.new_dentry		= new,
+		.flags			= flags,
+		.cleanup_whiteout	= false,
+	};
+	LIST_HEAD(list);
+
+	err = -EINVAL;
+	if (flags & ~(RENAME_EXCHANGE | RENAME_NOREPLACE))
+		goto out;
+
+	flags &= ~RENAME_NOREPLACE;
+
+	/* Don't copy up directory trees */
+	err = -EXDEV;
+	if (!ovl_can_move(old))
+		goto out;
+	if (!overwrite && !ovl_can_move(new))
+		goto out;
+
+	if (overwrite && new_is_dir && !ovl_pure_upper(new)) {
+		err = ovl_check_empty_dir(new, &list);
+		if (err)
+			goto out;
+	}
+
+	if (overwrite) {
+		if (ovl_lower_positive(old)) {
+			if (!ovl_dentry_is_whiteout(new)) {
+				/* Whiteout source */
+				ovlrd.flags |= RENAME_WHITEOUT;
+			} else {
+				/* Switch whiteouts */
+				ovlrd.flags |= RENAME_EXCHANGE;
+			}
+		} else if (is_dir && ovl_dentry_is_whiteout(new)) {
+			ovlrd.flags |= RENAME_EXCHANGE;
+			ovlrd.cleanup_whiteout = true;
+		}
+	}
+
+	err = ovl_copy_up(old);
+	if (err)
+		goto out;
+
+	err = ovl_copy_up(new->d_parent);
+	if (err)
+		goto out;
+	if (!overwrite) {
+		err = ovl_copy_up(new);
+		if (err)
+			goto out;
+	} else if (d_inode(new)) {
+		err = ovl_nlink_start(new);
+		if (err)
+			goto out;
+
+		update_nlink = true;
+	}
+
+	if (!update_nlink) {
+		/* ovl_nlink_start() took ovl_want_write() */
+		err = ovl_want_write(old);
+		if (err)
+			goto out;
+	}
+
+	old_cred = ovl_override_creds(old->d_sb);
+
+	err = do_ovl_rename(&ovlrd, &list);
+
 	ovl_revert_creds(old_cred);
 	if (update_nlink)
 		ovl_nlink_end(new);
 	else
 		ovl_drop_write(old);
+
+	dput(ovlrd.newdentry);
+	dput(ovlrd.olddentry);
+	dput(ovlrd.opaquedir);
 out:
-	dput(newdentry);
-	dput(olddentry);
-	dput(opaquedir);
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


