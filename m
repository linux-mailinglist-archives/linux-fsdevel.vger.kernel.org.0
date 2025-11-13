Return-Path: <linux-fsdevel+bounces-68390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B5FC5A2E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75B074F4E27
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E441F325700;
	Thu, 13 Nov 2025 21:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvfVE1Oi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E975324B14;
	Thu, 13 Nov 2025 21:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069592; cv=none; b=BGfTAU63dzXuiwip47miiEG+iudKjrm7mZ2RQ7Y29gaFMXwOvT5cdZi3a8AXBYppq00Jcv1mhgDXAfoAAy+ohubrjdkm5LOdomcbZ3MuA6iEGQy+5FdWKzRetSdaEmKuAd3XRMen9bK/Al/JuvZx2UNgBo3xCC/wVPvQZqTofZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069592; c=relaxed/simple;
	bh=zeruP5gHE+q89QPE5M20hrsO8GhrY7lxn1nYZz2/tEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rAqURO3OQ2+iGkyA67zEo4U5NZlRCGaBJm8r5U3BtH/5bFGzgxiOeRgMRA5+DbMyXlU63mXfkSCuIDCyg+m8/xIH/WZimrXedQXR0DNzmQqOetjZfAOJgnM+Gbkum2Y7uHUfYyGj4GHl4TRtBdcj9HdQMgF0dwPwF7aOQ38UfmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvfVE1Oi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0400C4CEF7;
	Thu, 13 Nov 2025 21:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069592;
	bh=zeruP5gHE+q89QPE5M20hrsO8GhrY7lxn1nYZz2/tEw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MvfVE1Oii83v42qeuMSINWfGLe9V9aZmv17IljSdctn7oCHzq8pBnpaKttv3ddI3H
	 UVBEzRcCZWJuE+Hi2LEDx37b7j1so7r2yIRwpxPtj6BIsY7edRKBtf9ZUhg6Pfpu9O
	 Xx1sGHDpIQ4vCNy16eAyQ8h3+p8UBsk9F0wmPeIVYFrEfqR+4FQgj0HsoTNQWzxuTJ
	 8L2vv2+mxx9ivvm7BmCaddcWQ0Ec3aK+fDRsP9RTKIFah3K9zNAOzkKDL72LJqza12
	 nvpG/0lpqGk+nLpNo3A9Vk9jNtkLvsYDZpkFmFiBolDpLkQTUbiFUomrXbo7ItWjV8
	 amzMdh28CzaAA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:32:17 +0100
Subject: [PATCH v3 34/42] ovl: extract do_ovl_rename() helper function
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-34-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11287; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zeruP5gHE+q89QPE5M20hrsO8GhrY7lxn1nYZz2/tEw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+UW87Fi+7eaXONaPpx50Ofs0XuvhETnx6u+UmHe3v
 CLiC0s4O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayL56RYZech8vDBal1Z08U
 hkYb8sz0fej2IVvu9M8TTPcrJTc+TWBkWOYUlnctbdWihrv15Sn7jT/3XW/+++dUxrS2OH6dXKF
 QNgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Extract the code that runs under overridden credentials into a separate
do_ovl_rename() helper function. Error handling is simplified. The
helper returns errors directly instead of using goto labels.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 277 +++++++++++++++++++++++++++--------------------------
 1 file changed, 140 insertions(+), 137 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 052929b9b99d..0812bb4ee4f6 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1099,107 +1099,28 @@ struct ovl_renamedata {
 	bool overwrite;
 };
 
-static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
-		      struct dentry *old, struct inode *newdir,
-		      struct dentry *new, unsigned int flags)
+static int do_ovl_rename(struct ovl_renamedata *ovlrd, struct list_head *list)
 {
-	int err;
-	struct dentry *old_upperdir;
-	struct dentry *new_upperdir;
-	struct dentry *trap, *de;
-	bool old_opaque;
-	bool new_opaque;
-	bool update_nlink = false;
+	struct dentry *old = ovlrd->old_dentry;
+	struct dentry *new = ovlrd->new_dentry;
+	struct ovl_fs *ofs = OVL_FS(old->d_sb);
+	unsigned int flags = ovlrd->flags;
+	struct dentry *old_upperdir = ovl_dentry_upper(ovlrd->old_parent);
+	struct dentry *new_upperdir = ovl_dentry_upper(ovlrd->new_parent);
+	bool samedir = ovlrd->old_parent == ovlrd->new_parent;
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
-
-	err = -EINVAL;
-	if (ovlrd.flags & ~(RENAME_EXCHANGE | RENAME_NOREPLACE))
-		goto out;
-
-	ovlrd.flags &= ~RENAME_NOREPLACE;
-
-	/* Don't copy up directory trees */
-	err = -EXDEV;
-	if (!ovl_can_move(old))
-		goto out;
-	if (!ovlrd.overwrite && !ovl_can_move(new))
-		goto out;
-
-	if (ovlrd.overwrite && new_is_dir && !ovl_pure_upper(new)) {
-		err = ovl_check_empty_dir(new, &list);
-		if (err)
-			goto out;
-	}
-
-	if (ovlrd.overwrite) {
-		if (ovl_lower_positive(old)) {
-			if (!ovl_dentry_is_whiteout(new)) {
-				/* Whiteout source */
-				ovlrd.flags |= RENAME_WHITEOUT;
-			} else {
-				/* Switch whiteouts */
-				ovlrd.flags |= RENAME_EXCHANGE;
-			}
-		} else if (is_dir && ovl_dentry_is_whiteout(new)) {
-			ovlrd.flags |= RENAME_EXCHANGE;
-			ovlrd.cleanup_whiteout = true;
-		}
-	}
-
-	err = ovl_copy_up(old);
-	if (err)
-		goto out;
-
-	err = ovl_copy_up(ovlrd.new_parent);
-	if (err)
-		goto out;
-	if (!ovlrd.overwrite) {
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
-		ovlrd.opaquedir = ovl_clear_empty(new, &list);
-		err = PTR_ERR(ovlrd.opaquedir);
-		if (IS_ERR(ovlrd.opaquedir)) {
-			ovlrd.opaquedir = NULL;
-			goto out_revert_creds;
-		}
+	if (!list_empty(list)) {
+		de = ovl_clear_empty(new, list);
+		if (IS_ERR(de))
+			return PTR_ERR(de);
+		ovlrd->opaquedir = de;
 	}
 
-	old_upperdir = ovl_dentry_upper(ovlrd.old_parent);
-	new_upperdir = ovl_dentry_upper(ovlrd.new_parent);
-
 	if (!samedir) {
 		/*
 		 * When moving a merge dir or non-dir with copy up origin into
@@ -1208,32 +1129,30 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
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
-	ovlrd.olddentry = de;
+	ovlrd->olddentry = de;
 
 	err = -ESTALE;
-	if (!ovl_matches_upper(old, ovlrd.olddentry))
+	if (!ovl_matches_upper(old, ovlrd->olddentry))
 		goto out_unlock;
 
 	de = ovl_lookup_upper(ofs, new->d_name.name, new_upperdir,
@@ -1241,73 +1160,74 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	err = PTR_ERR(de);
 	if (IS_ERR(de))
 		goto out_unlock;
-	ovlrd.newdentry = de;
+	ovlrd->newdentry = de;
 
 	old_opaque = ovl_dentry_is_opaque(old);
 	new_opaque = ovl_dentry_is_opaque(new);
 
 	err = -ESTALE;
 	if (d_inode(new) && ovl_dentry_upper(new)) {
-		if (ovlrd.opaquedir) {
-			if (ovlrd.newdentry != ovlrd.opaquedir)
+		if (ovlrd->opaquedir) {
+			if (ovlrd->newdentry != ovlrd->opaquedir)
 				goto out_unlock;
 		} else {
-			if (!ovl_matches_upper(new, ovlrd.newdentry))
+			if (!ovl_matches_upper(new, ovlrd->newdentry))
 				goto out_unlock;
 		}
 	} else {
-		if (!d_is_negative(ovlrd.newdentry)) {
-			if (!new_opaque || !ovl_upper_is_whiteout(ofs, ovlrd.newdentry))
+		if (!d_is_negative(ovlrd->newdentry)) {
+			if (!new_opaque || !ovl_upper_is_whiteout(ofs, ovlrd->newdentry))
 				goto out_unlock;
 		} else {
-			if (ovlrd.flags & RENAME_EXCHANGE)
+			if (flags & RENAME_EXCHANGE)
 				goto out_unlock;
 		}
 	}
 
-	if (ovlrd.olddentry == trap)
+	if (ovlrd->olddentry == trap)
 		goto out_unlock;
-	if (ovlrd.newdentry == trap)
+	if (ovlrd->newdentry == trap)
 		goto out_unlock;
 
-	if (ovlrd.olddentry->d_inode == ovlrd.newdentry->d_inode)
+	if (ovlrd->olddentry->d_inode == ovlrd->newdentry->d_inode)
 		goto out_unlock;
 
 	err = 0;
 	if (ovl_type_merge_or_lower(old))
 		err = ovl_set_redirect(old, samedir);
-	else if (is_dir && !old_opaque && ovl_type_merge(ovlrd.new_parent))
-		err = ovl_set_opaque_xerr(old, ovlrd.olddentry, -EXDEV);
+	else if (is_dir && !old_opaque && ovl_type_merge(ovlrd->new_parent))
+		err = ovl_set_opaque_xerr(old, ovlrd->olddentry, -EXDEV);
 	if (err)
 		goto out_unlock;
 
-	if (!ovlrd.overwrite && ovl_type_merge_or_lower(new))
+	if (!ovlrd->overwrite && ovl_type_merge_or_lower(new))
 		err = ovl_set_redirect(new, samedir);
-	else if (!ovlrd.overwrite && new_is_dir && !new_opaque &&
-		 ovl_type_merge(ovlrd.old_parent))
-		err = ovl_set_opaque_xerr(new, ovlrd.newdentry, -EXDEV);
+	else if (!ovlrd->overwrite && new_is_dir && !new_opaque &&
+		 ovl_type_merge(ovlrd->old_parent))
+		err = ovl_set_opaque_xerr(new, ovlrd->newdentry, -EXDEV);
 	if (err)
 		goto out_unlock;
 
-	err = ovl_do_rename(ofs, old_upperdir, ovlrd.olddentry,
-			    new_upperdir, ovlrd.newdentry, flags);
+	err = ovl_do_rename(ofs, old_upperdir, ovlrd->olddentry,
+			    new_upperdir, ovlrd->newdentry, flags);
+out_unlock:
 	unlock_rename(new_upperdir, old_upperdir);
 	if (err)
-		goto out_revert_creds;
+		return err;
 
-	if (ovlrd.cleanup_whiteout)
-		ovl_cleanup(ofs, old_upperdir, ovlrd.newdentry);
+	if (ovlrd->cleanup_whiteout)
+		ovl_cleanup(ofs, old_upperdir, ovlrd->newdentry);
 
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
@@ -1315,22 +1235,105 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
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
+		.overwrite		= !(flags & RENAME_EXCHANGE),
+	};
+	LIST_HEAD(list);
+
+	err = -EINVAL;
+	if (ovlrd.flags & ~(RENAME_EXCHANGE | RENAME_NOREPLACE))
+		goto out;
+
+	ovlrd.flags &= ~RENAME_NOREPLACE;
+
+	/* Don't copy up directory trees */
+	err = -EXDEV;
+	if (!ovl_can_move(old))
+		goto out;
+	if (!ovlrd.overwrite && !ovl_can_move(new))
+		goto out;
+
+	if (ovlrd.overwrite && new_is_dir && !ovl_pure_upper(new)) {
+		err = ovl_check_empty_dir(new, &list);
+		if (err)
+			goto out;
+	}
+
+	if (ovlrd.overwrite) {
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
+	if (!ovlrd.overwrite) {
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
-out:
+
 	dput(ovlrd.newdentry);
 	dput(ovlrd.olddentry);
 	dput(ovlrd.opaquedir);
+out:
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


