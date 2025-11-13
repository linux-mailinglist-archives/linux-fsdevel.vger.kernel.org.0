Return-Path: <linux-fsdevel+bounces-68389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F5DC5A386
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 662004F4BC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D35329383;
	Thu, 13 Nov 2025 21:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NI96n6WV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9225832936E;
	Thu, 13 Nov 2025 21:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069590; cv=none; b=UijdArw1jHVJUDUHNQgDdgSm+Meyd1h6vZXk5sqwkXz35NCBI4heqB4lEreMMrbFu9huef8Dt9zvoqwbVE/h8rkOAvIEbT24hIP2iQfcdfN0+3pBJwHuMtXvgDwZZHYF/fX9tup8Gu6YgAA+J1YdWNF2BA9hyf/z9zXSD6B67Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069590; c=relaxed/simple;
	bh=FCsSh3Vn+G0LR3UOGOGVAUGRklrz6yFgAT1rh7Jo9YI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WktY51FyyQeyG/wq///L4kxSdPVQvftgI9tO027xyazB1e2Db63zYybxQDaybelRbpvwS5kli4ECZ4y2NldIy80ObU4sO9ToG5BsDam+MhCRBRX/g9j4ZvwaF5mSBhcxxeYX8W1rShDScOECH69Fgb9aDYpy4B7tnqSNbDl29L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NI96n6WV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C3BC4CEFB;
	Thu, 13 Nov 2025 21:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069590;
	bh=FCsSh3Vn+G0LR3UOGOGVAUGRklrz6yFgAT1rh7Jo9YI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NI96n6WVjf7qe38NdISydpf4fzs9orCIWpwmMVMcen+nk0yV5rxgm+KUn/pO9lpBF
	 QVlAsFOSwkR64jPVGLdeMTmXkhcJHQrjI/ewI2miXkkrUMjtl3jZMIICBnLyD09UGz
	 anT3q5ZlwyT4BzfOKOwZqplDpRDUFnr5k2b1BAHWngYLQWz4Aq/tIgued8fY6N4bYc
	 zr9l0otZluJsg5aAQEyuQnKbLgCsRdpvGzl1Cix9/ACBu0A4F3EhaqdUHT+AO6mv/C
	 x4nW8bxAa/FJoJtouSQu+seXWAzTRufqpQBMhP+nHJ6khWKJ9Tg7Cb+ckLw7EiWIXZ
	 PaWgz32eIcQFg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:32:16 +0100
Subject: [PATCH v3 33/42] ovl: introduce struct ovl_renamedata
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-33-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8807; i=brauner@kernel.org;
 h=from:subject:message-id; bh=FCsSh3Vn+G0LR3UOGOGVAUGRklrz6yFgAT1rh7Jo9YI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+UXcedrr/zTOuSSy1TfV/rFbMtvq59ueJ8g+jmIs8
 uSv3CrYUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBH/Y4wMc4vZpGrOfGJNdzmx
 enZ4veCqG9K8lY/2L2JrnjarZ938tYwMr5sWn25YuiiyovjL5Eff2Do2HfIPLf3pZ3WVY/6NgwY
 bWQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a struct ovl_renamedata to group rename-related state that was
previously stored in local variables. Embedd struct renamedata directly
aligning with the vfs.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 123 +++++++++++++++++++++++++++++------------------------
 1 file changed, 68 insertions(+), 55 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 86b72bf87833..052929b9b99d 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1090,6 +1090,15 @@ static int ovl_set_redirect(struct dentry *dentry, bool samedir)
 	return err;
 }
 
+struct ovl_renamedata {
+	struct renamedata;
+	struct dentry *opaquedir;
+	struct dentry *olddentry;
+	struct dentry *newdentry;
+	bool cleanup_whiteout;
+	bool overwrite;
+};
+
 static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 		      struct dentry *old, struct inode *newdir,
 		      struct dentry *new, unsigned int flags)
@@ -1097,53 +1106,57 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	int err;
 	struct dentry *old_upperdir;
 	struct dentry *new_upperdir;
-	struct dentry *olddentry = NULL;
-	struct dentry *newdentry = NULL;
 	struct dentry *trap, *de;
 	bool old_opaque;
 	bool new_opaque;
-	bool cleanup_whiteout = false;
 	bool update_nlink = false;
-	bool overwrite = !(flags & RENAME_EXCHANGE);
 	bool is_dir = d_is_dir(old);
 	bool new_is_dir = d_is_dir(new);
-	bool samedir = olddir == newdir;
-	struct dentry *opaquedir = NULL;
 	const struct cred *old_cred = NULL;
 	struct ovl_fs *ofs = OVL_FS(old->d_sb);
+	struct ovl_renamedata ovlrd = {
+		.old_parent		= old->d_parent,
+		.old_dentry		= old,
+		.new_parent		= new->d_parent,
+		.new_dentry		= new,
+		.flags			= flags,
+		.cleanup_whiteout	= false,
+		.overwrite		= !(flags & RENAME_EXCHANGE),
+	};
 	LIST_HEAD(list);
+	bool samedir = ovlrd.old_parent == ovlrd.new_parent;
 
 	err = -EINVAL;
-	if (flags & ~(RENAME_EXCHANGE | RENAME_NOREPLACE))
+	if (ovlrd.flags & ~(RENAME_EXCHANGE | RENAME_NOREPLACE))
 		goto out;
 
-	flags &= ~RENAME_NOREPLACE;
+	ovlrd.flags &= ~RENAME_NOREPLACE;
 
 	/* Don't copy up directory trees */
 	err = -EXDEV;
 	if (!ovl_can_move(old))
 		goto out;
-	if (!overwrite && !ovl_can_move(new))
+	if (!ovlrd.overwrite && !ovl_can_move(new))
 		goto out;
 
-	if (overwrite && new_is_dir && !ovl_pure_upper(new)) {
+	if (ovlrd.overwrite && new_is_dir && !ovl_pure_upper(new)) {
 		err = ovl_check_empty_dir(new, &list);
 		if (err)
 			goto out;
 	}
 
-	if (overwrite) {
+	if (ovlrd.overwrite) {
 		if (ovl_lower_positive(old)) {
 			if (!ovl_dentry_is_whiteout(new)) {
 				/* Whiteout source */
-				flags |= RENAME_WHITEOUT;
+				ovlrd.flags |= RENAME_WHITEOUT;
 			} else {
 				/* Switch whiteouts */
-				flags |= RENAME_EXCHANGE;
+				ovlrd.flags |= RENAME_EXCHANGE;
 			}
 		} else if (is_dir && ovl_dentry_is_whiteout(new)) {
-			flags |= RENAME_EXCHANGE;
-			cleanup_whiteout = true;
+			ovlrd.flags |= RENAME_EXCHANGE;
+			ovlrd.cleanup_whiteout = true;
 		}
 	}
 
@@ -1151,10 +1164,10 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	if (err)
 		goto out;
 
-	err = ovl_copy_up(new->d_parent);
+	err = ovl_copy_up(ovlrd.new_parent);
 	if (err)
 		goto out;
-	if (!overwrite) {
+	if (!ovlrd.overwrite) {
 		err = ovl_copy_up(new);
 		if (err)
 			goto out;
@@ -1176,16 +1189,16 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	old_cred = ovl_override_creds(old->d_sb);
 
 	if (!list_empty(&list)) {
-		opaquedir = ovl_clear_empty(new, &list);
-		err = PTR_ERR(opaquedir);
-		if (IS_ERR(opaquedir)) {
-			opaquedir = NULL;
+		ovlrd.opaquedir = ovl_clear_empty(new, &list);
+		err = PTR_ERR(ovlrd.opaquedir);
+		if (IS_ERR(ovlrd.opaquedir)) {
+			ovlrd.opaquedir = NULL;
 			goto out_revert_creds;
 		}
 	}
 
-	old_upperdir = ovl_dentry_upper(old->d_parent);
-	new_upperdir = ovl_dentry_upper(new->d_parent);
+	old_upperdir = ovl_dentry_upper(ovlrd.old_parent);
+	new_upperdir = ovl_dentry_upper(ovlrd.new_parent);
 
 	if (!samedir) {
 		/*
@@ -1195,12 +1208,12 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 		 * lookup the origin inodes of the entries to fill d_ino.
 		 */
 		if (ovl_type_origin(old)) {
-			err = ovl_set_impure(new->d_parent, new_upperdir);
+			err = ovl_set_impure(ovlrd.new_parent, new_upperdir);
 			if (err)
 				goto out_revert_creds;
 		}
-		if (!overwrite && ovl_type_origin(new)) {
-			err = ovl_set_impure(old->d_parent, old_upperdir);
+		if (!ovlrd.overwrite && ovl_type_origin(new)) {
+			err = ovl_set_impure(ovlrd.old_parent, old_upperdir);
 			if (err)
 				goto out_revert_creds;
 		}
@@ -1217,10 +1230,10 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	err = PTR_ERR(de);
 	if (IS_ERR(de))
 		goto out_unlock;
-	olddentry = de;
+	ovlrd.olddentry = de;
 
 	err = -ESTALE;
-	if (!ovl_matches_upper(old, olddentry))
+	if (!ovl_matches_upper(old, ovlrd.olddentry))
 		goto out_unlock;
 
 	de = ovl_lookup_upper(ofs, new->d_name.name, new_upperdir,
@@ -1228,73 +1241,73 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	err = PTR_ERR(de);
 	if (IS_ERR(de))
 		goto out_unlock;
-	newdentry = de;
+	ovlrd.newdentry = de;
 
 	old_opaque = ovl_dentry_is_opaque(old);
 	new_opaque = ovl_dentry_is_opaque(new);
 
 	err = -ESTALE;
 	if (d_inode(new) && ovl_dentry_upper(new)) {
-		if (opaquedir) {
-			if (newdentry != opaquedir)
+		if (ovlrd.opaquedir) {
+			if (ovlrd.newdentry != ovlrd.opaquedir)
 				goto out_unlock;
 		} else {
-			if (!ovl_matches_upper(new, newdentry))
+			if (!ovl_matches_upper(new, ovlrd.newdentry))
 				goto out_unlock;
 		}
 	} else {
-		if (!d_is_negative(newdentry)) {
-			if (!new_opaque || !ovl_upper_is_whiteout(ofs, newdentry))
+		if (!d_is_negative(ovlrd.newdentry)) {
+			if (!new_opaque || !ovl_upper_is_whiteout(ofs, ovlrd.newdentry))
 				goto out_unlock;
 		} else {
-			if (flags & RENAME_EXCHANGE)
+			if (ovlrd.flags & RENAME_EXCHANGE)
 				goto out_unlock;
 		}
 	}
 
-	if (olddentry == trap)
+	if (ovlrd.olddentry == trap)
 		goto out_unlock;
-	if (newdentry == trap)
+	if (ovlrd.newdentry == trap)
 		goto out_unlock;
 
-	if (olddentry->d_inode == newdentry->d_inode)
+	if (ovlrd.olddentry->d_inode == ovlrd.newdentry->d_inode)
 		goto out_unlock;
 
 	err = 0;
 	if (ovl_type_merge_or_lower(old))
 		err = ovl_set_redirect(old, samedir);
-	else if (is_dir && !old_opaque && ovl_type_merge(new->d_parent))
-		err = ovl_set_opaque_xerr(old, olddentry, -EXDEV);
+	else if (is_dir && !old_opaque && ovl_type_merge(ovlrd.new_parent))
+		err = ovl_set_opaque_xerr(old, ovlrd.olddentry, -EXDEV);
 	if (err)
 		goto out_unlock;
 
-	if (!overwrite && ovl_type_merge_or_lower(new))
+	if (!ovlrd.overwrite && ovl_type_merge_or_lower(new))
 		err = ovl_set_redirect(new, samedir);
-	else if (!overwrite && new_is_dir && !new_opaque &&
-		 ovl_type_merge(old->d_parent))
-		err = ovl_set_opaque_xerr(new, newdentry, -EXDEV);
+	else if (!ovlrd.overwrite && new_is_dir && !new_opaque &&
+		 ovl_type_merge(ovlrd.old_parent))
+		err = ovl_set_opaque_xerr(new, ovlrd.newdentry, -EXDEV);
 	if (err)
 		goto out_unlock;
 
-	err = ovl_do_rename(ofs, old_upperdir, olddentry,
-			    new_upperdir, newdentry, flags);
+	err = ovl_do_rename(ofs, old_upperdir, ovlrd.olddentry,
+			    new_upperdir, ovlrd.newdentry, flags);
 	unlock_rename(new_upperdir, old_upperdir);
 	if (err)
 		goto out_revert_creds;
 
-	if (cleanup_whiteout)
-		ovl_cleanup(ofs, old_upperdir, newdentry);
+	if (ovlrd.cleanup_whiteout)
+		ovl_cleanup(ofs, old_upperdir, ovlrd.newdentry);
 
-	if (overwrite && d_inode(new)) {
+	if (ovlrd.overwrite && d_inode(new)) {
 		if (new_is_dir)
 			clear_nlink(d_inode(new));
 		else
 			ovl_drop_nlink(new);
 	}
 
-	ovl_dir_modified(old->d_parent, ovl_type_origin(old) ||
-			 (!overwrite && ovl_type_origin(new)));
-	ovl_dir_modified(new->d_parent, ovl_type_origin(old) ||
+	ovl_dir_modified(ovlrd.old_parent, ovl_type_origin(old) ||
+			 (!ovlrd.overwrite && ovl_type_origin(new)));
+	ovl_dir_modified(ovlrd.new_parent, ovl_type_origin(old) ||
 			 (d_inode(new) && ovl_type_origin(new)));
 
 	/* copy ctime: */
@@ -1309,9 +1322,9 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	else
 		ovl_drop_write(old);
 out:
-	dput(newdentry);
-	dput(olddentry);
-	dput(opaquedir);
+	dput(ovlrd.newdentry);
+	dput(ovlrd.olddentry);
+	dput(ovlrd.opaquedir);
 	ovl_cache_free(&list);
 	return err;
 

-- 
2.47.3


