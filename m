Return-Path: <linux-fsdevel+bounces-58503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5D5B2EA0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10AED17DBAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEC71F4289;
	Thu, 21 Aug 2025 01:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1Fsj4DK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AA85FEE6;
	Thu, 21 Aug 2025 01:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738520; cv=none; b=aDvMgH2eg66T8u9VW2BSKOrCG9FNrGMi37DQVg/0EiIGKxAUnJuePbbAs983po6b2/dyidw1/rbZYMWN/KG6HwUyUnpENswtAPkHYRROS66FqfsLO+ZDau07hpC0pVuP9S1k3e6hvzLnkGIX5BMwclqwdvAj6kLW2CKL92Fu3sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738520; c=relaxed/simple;
	bh=RlOio8j3TjEgAqslysQ7or/Ic3aAstMp96i++I6B+oE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YGyko5owlAywl34oFZ6xf1v10Yeg89mI+l1N4hYIDPK0y1rB+9PzAJGryBY5Gaz+Wo70tBRiIo1/DiWSmm7EHorzYC4Y0VZ1KZXsmMb/+Pi1BJRkOHKXHV8DHvpT9N0jfEEzrzx4Q+EEt3f931UDCn9+duAslc9JK5FaPfG6+/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1Fsj4DK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE38C4CEE7;
	Thu, 21 Aug 2025 01:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738519;
	bh=RlOio8j3TjEgAqslysQ7or/Ic3aAstMp96i++I6B+oE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=e1Fsj4DK8KJutf2fgrymOsHFm9vwcAlwu49VxOy7GnvY0K12vK4ZP62RZrGaQzsYG
	 p49VfwNYe/qpMZ4VGq5Mmjus+emTjYjPtyQ6QdM0i2SvTaEW/ZU37o66k6RAbSjjds
	 8LYjTruhg/nuI9+QdIfKzL4iXfcnuBlGw6IUMX0pjqm8+pCowW4VJTgvINFSCU/ojh
	 /gUf+R7sHd+LQ8ecnflxvDFKmY45Px3LmUuj1UWL8z99c1xVKwt3WtWIBoNxAdx7vh
	 suQNA4I2jx5LC9uwA3zC6x+YsXU2/fCaDucJ9cWLLNzPC0BWKdov5i7xYw44vpqpcp
	 jUIe6OrkTHkpw==
Date: Wed, 20 Aug 2025 18:08:39 -0700
Subject: [PATCH 03/20] fuse4fs: namespace some helpers
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, amir73il@gmail.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <175573712861.20753.12678836494772235653.stgit@frogsfrogsfrogs>
In-Reply-To: <175573712721.20753.5223489399594191991.stgit@frogsfrogsfrogs>
References: <175573712721.20753.5223489399594191991.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Prepend "fuse4fs_" to all helper functions that take a struct fuse4fs
object pointer.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse4fs.c |  177 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 90 insertions(+), 87 deletions(-)


diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index e6e5729936f6a1..124a16eb0614a8 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -2,6 +2,7 @@
  * fuse4fs.c - FUSE low-level server for e2fsprogs.
  *
  * Copyright (C) 2014-2025 Oracle.
+ * Copyright (C) 2025 CTERA Networks.
  *
  * %Begin-Header%
  * This file may be redistributed under the terms of the GNU Public
@@ -691,7 +692,7 @@ static int ext2_file_type(unsigned int mode)
 	return 0;
 }
 
-static int fs_can_allocate(struct fuse4fs *ff, blk64_t num)
+static int fuse4fs_can_allocate(struct fuse4fs *ff, blk64_t num)
 {
 	ext2_filsys fs = ff->fs;
 	blk64_t reserved;
@@ -718,21 +719,22 @@ static int fs_can_allocate(struct fuse4fs *ff, blk64_t num)
 	return ext2fs_free_blocks_count(fs->super) > reserved + num;
 }
 
-static int fuse4fs_is_writeable(struct fuse4fs *ff)
+static int fuse4fs_is_writeable(const struct fuse4fs *ff)
 {
 	return ff->opstate == F4OP_WRITABLE &&
 		(ff->fs->super->s_error_count == 0);
 }
 
-static inline int is_superuser(struct fuse4fs *ff, struct fuse_context *ctxt)
+static inline int fuse4fs_is_superuser(struct fuse4fs *ff,
+				       const struct fuse_context *ctxt)
 {
 	if (ff->fakeroot)
 		return 1;
 	return ctxt->uid == 0;
 }
 
-static inline int want_check_owner(struct fuse4fs *ff,
-				   struct fuse_context *ctxt)
+static inline int fuse4fs_want_check_owner(struct fuse4fs *ff,
+					   const struct fuse_context *ctxt)
 {
 	/*
 	 * The kernel is responsible for access control, so we allow anything
@@ -740,14 +742,14 @@ static inline int want_check_owner(struct fuse4fs *ff,
 	 */
 	if (ff->kernel)
 		return 0;
-	return !is_superuser(ff, ctxt);
+	return !fuse4fs_is_superuser(ff, ctxt);
 }
 
 /* Test for append permission */
 #define A_OK	16
 
-static int check_iflags_access(struct fuse4fs *ff, ext2_ino_t ino,
-			       const struct ext2_inode *inode, int mask)
+static int fuse4fs_iflags_access(struct fuse4fs *ff, ext2_ino_t ino,
+				 const struct ext2_inode *inode, int mask)
 {
 	EXT2FS_BUILD_BUG_ON((A_OK & (R_OK | W_OK | X_OK | F_OK)) != 0);
 
@@ -775,7 +777,7 @@ static int check_iflags_access(struct fuse4fs *ff, ext2_ino_t ino,
 	return 0;
 }
 
-static int check_inum_access(struct fuse4fs *ff, ext2_ino_t ino, int mask)
+static int fuse4fs_inum_access(struct fuse4fs *ff, ext2_ino_t ino, int mask)
 {
 	struct fuse_context *ctxt = fuse_get_context();
 	ext2_filsys fs = ff->fs;
@@ -807,7 +809,7 @@ static int check_inum_access(struct fuse4fs *ff, ext2_ino_t ino, int mask)
 	if (mask == 0)
 		return 0;
 
-	ret = check_iflags_access(ff, ino, &inode, mask);
+	ret = fuse4fs_iflags_access(ff, ino, &inode, mask);
 	if (ret)
 		return ret;
 
@@ -816,7 +818,7 @@ static int check_inum_access(struct fuse4fs *ff, ext2_ino_t ino, int mask)
 		return 0;
 
 	/* Figure out what root's allowed to do */
-	if (is_superuser(ff, ctxt)) {
+	if (fuse4fs_is_superuser(ff, ctxt)) {
 		/* Non-file access always ok */
 		if (!LINUX_S_ISREG(inode.i_mode))
 			return 0;
@@ -1517,8 +1519,8 @@ static int op_readlink(const char *path, char *buf, size_t len)
 	return ret;
 }
 
-static int __getxattr(struct fuse4fs *ff, ext2_ino_t ino, const char *name,
-		      void **value, size_t *value_len)
+static int fuse4fs_getxattr(struct fuse4fs *ff, ext2_ino_t ino,
+			    const char *name, void **value, size_t *value_len)
 {
 	ext2_filsys fs = ff->fs;
 	struct ext2_xattr_handle *h;
@@ -1548,8 +1550,8 @@ static int __getxattr(struct fuse4fs *ff, ext2_ino_t ino, const char *name,
 	return ret;
 }
 
-static int __setxattr(struct fuse4fs *ff, ext2_ino_t ino, const char *name,
-		      void *value, size_t valuelen)
+static int fuse4fs_setxattr(struct fuse4fs *ff, ext2_ino_t ino,
+			    const char *name, void *value, size_t valuelen)
 {
 	ext2_filsys fs = ff->fs;
 	struct ext2_xattr_handle *h;
@@ -1579,8 +1581,8 @@ static int __setxattr(struct fuse4fs *ff, ext2_ino_t ino, const char *name,
 	return ret;
 }
 
-static int propagate_default_acls(struct fuse4fs *ff, ext2_ino_t parent,
-				  ext2_ino_t child)
+static int fuse4fs_propagate_default_acls(struct fuse4fs *ff, ext2_ino_t parent,
+					  ext2_ino_t child)
 {
 	void *def;
 	size_t deflen;
@@ -1589,8 +1591,8 @@ static int propagate_default_acls(struct fuse4fs *ff, ext2_ino_t parent,
 	if (!ff->acl)
 		return 0;
 
-	ret = __getxattr(ff, parent, XATTR_NAME_POSIX_ACL_DEFAULT, &def,
-			 &deflen);
+	ret = fuse4fs_getxattr(ff, parent, XATTR_NAME_POSIX_ACL_DEFAULT, &def,
+			       &deflen);
 	switch (ret) {
 	case -ENODATA:
 	case -ENOENT:
@@ -1602,7 +1604,8 @@ static int propagate_default_acls(struct fuse4fs *ff, ext2_ino_t parent,
 		return ret;
 	}
 
-	ret = __setxattr(ff, child, XATTR_NAME_POSIX_ACL_DEFAULT, def, deflen);
+	ret = fuse4fs_setxattr(ff, child, XATTR_NAME_POSIX_ACL_DEFAULT, def,
+			       deflen);
 	ext2fs_free_mem(&def);
 	return ret;
 }
@@ -1731,7 +1734,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 	*node_name = 0;
 
 	fs = fuse4fs_start(ff);
-	if (!fs_can_allocate(ff, 2)) {
+	if (!fuse4fs_can_allocate(ff, 2)) {
 		ret = -ENOSPC;
 		goto out2;
 	}
@@ -1743,7 +1746,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 		goto out2;
 	}
 
-	ret = check_inum_access(ff, parent, A_OK | W_OK);
+	ret = fuse4fs_inum_access(ff, parent, A_OK | W_OK);
 	if (ret)
 		goto out2;
 
@@ -1813,7 +1816,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 
 	ext2fs_inode_alloc_stats2(fs, child, 1, 0);
 
-	ret = propagate_default_acls(ff, parent, child);
+	ret = fuse4fs_propagate_default_acls(ff, parent, child);
 	if (ret)
 		goto out2;
 
@@ -1861,7 +1864,7 @@ static int op_mkdir(const char *path, mode_t mode)
 	*node_name = 0;
 
 	fs = fuse4fs_start(ff);
-	if (!fs_can_allocate(ff, 1)) {
+	if (!fuse4fs_can_allocate(ff, 1)) {
 		ret = -ENOSPC;
 		goto out2;
 	}
@@ -1873,7 +1876,7 @@ static int op_mkdir(const char *path, mode_t mode)
 		goto out2;
 	}
 
-	ret = check_inum_access(ff, parent, A_OK | W_OK);
+	ret = fuse4fs_inum_access(ff, parent, A_OK | W_OK);
 	if (ret)
 		goto out2;
 
@@ -1946,7 +1949,7 @@ static int op_mkdir(const char *path, mode_t mode)
 		goto out3;
 	}
 
-	ret = propagate_default_acls(ff, parent, child);
+	ret = fuse4fs_propagate_default_acls(ff, parent, child);
 	if (ret)
 		goto out3;
 
@@ -1987,7 +1990,7 @@ static int fuse4fs_unlink(struct fuse4fs *ff, const char *path,
 		base_name = filename;
 	}
 
-	ret = check_inum_access(ff, dir, W_OK);
+	ret = fuse4fs_inum_access(ff, dir, W_OK);
 	if (ret) {
 		free(filename);
 		return ret;
@@ -2009,8 +2012,8 @@ static int fuse4fs_unlink(struct fuse4fs *ff, const char *path,
 	return 0;
 }
 
-static int remove_ea_inodes(struct fuse4fs *ff, ext2_ino_t ino,
-			    struct ext2_inode_large *inode)
+static int fuse4fs_remove_ea_inodes(struct fuse4fs *ff, ext2_ino_t ino,
+				    struct ext2_inode_large *inode)
 {
 	ext2_filsys fs = ff->fs;
 	struct ext2_xattr_handle *h;
@@ -2054,7 +2057,7 @@ static int remove_ea_inodes(struct fuse4fs *ff, ext2_ino_t ino,
 	return 0;
 }
 
-static int remove_inode(struct fuse4fs *ff, ext2_ino_t ino)
+static int fuse4fs_remove_inode(struct fuse4fs *ff, ext2_ino_t ino)
 {
 	ext2_filsys fs = ff->fs;
 	errcode_t err;
@@ -2087,7 +2090,7 @@ static int remove_inode(struct fuse4fs *ff, ext2_ino_t ino)
 		goto write_out;
 
 	if (ext2fs_has_feature_ea_inode(fs->super)) {
-		ret = remove_ea_inodes(ff, ino, &inode);
+		ret = fuse4fs_remove_ea_inodes(ff, ino, &inode);
 		if (ret)
 			return ret;
 	}
@@ -2128,7 +2131,7 @@ static int __op_unlink(struct fuse4fs *ff, const char *path)
 		goto out;
 	}
 
-	ret = check_inum_access(ff, ino, W_OK);
+	ret = fuse4fs_inum_access(ff, ino, W_OK);
 	if (ret)
 		goto out;
 
@@ -2136,7 +2139,7 @@ static int __op_unlink(struct fuse4fs *ff, const char *path)
 	if (ret)
 		goto out;
 
-	ret = remove_inode(ff, ino);
+	ret = fuse4fs_remove_inode(ff, ino);
 	if (ret)
 		goto out;
 
@@ -2204,7 +2207,7 @@ static int __op_rmdir(struct fuse4fs *ff, const char *path)
 	}
 	dbg_printf(ff, "%s: rmdir path=%s ino=%d\n", __func__, path, child);
 
-	ret = check_inum_access(ff, child, W_OK);
+	ret = fuse4fs_inum_access(ff, child, W_OK);
 	if (ret)
 		goto out;
 
@@ -2223,7 +2226,7 @@ static int __op_rmdir(struct fuse4fs *ff, const char *path)
 		goto out;
 	}
 
-	ret = check_inum_access(ff, rds.parent, W_OK);
+	ret = fuse4fs_inum_access(ff, rds.parent, W_OK);
 	if (ret)
 		goto out;
 
@@ -2236,10 +2239,10 @@ static int __op_rmdir(struct fuse4fs *ff, const char *path)
 	if (ret)
 		goto out;
 	/* Directories have to be "removed" twice. */
-	ret = remove_inode(ff, child);
+	ret = fuse4fs_remove_inode(ff, child);
 	if (ret)
 		goto out;
-	ret = remove_inode(ff, child);
+	ret = fuse4fs_remove_inode(ff, child);
 	if (ret)
 		goto out;
 
@@ -2321,7 +2324,7 @@ static int op_symlink(const char *src, const char *dest)
 		goto out2;
 	}
 
-	ret = check_inum_access(ff, parent, A_OK | W_OK);
+	ret = fuse4fs_inum_access(ff, parent, A_OK | W_OK);
 	if (ret)
 		goto out2;
 
@@ -2433,7 +2436,7 @@ static int op_rename(const char *from, const char *to,
 	FUSE4FS_CHECK_CONTEXT(ff);
 	dbg_printf(ff, "%s: renaming %s to %s\n", __func__, from, to);
 	fs = fuse4fs_start(ff);
-	if (!fs_can_allocate(ff, 5)) {
+	if (!fuse4fs_can_allocate(ff, 5)) {
 		ret = -ENOSPC;
 		goto out;
 	}
@@ -2459,12 +2462,12 @@ static int op_rename(const char *from, const char *to,
 		goto out;
 	}
 
-	ret = check_inum_access(ff, from_ino, W_OK);
+	ret = fuse4fs_inum_access(ff, from_ino, W_OK);
 	if (ret)
 		goto out;
 
 	if (to_ino) {
-		ret = check_inum_access(ff, to_ino, W_OK);
+		ret = fuse4fs_inum_access(ff, to_ino, W_OK);
 		if (ret)
 			goto out;
 	}
@@ -2502,7 +2505,7 @@ static int op_rename(const char *from, const char *to,
 		goto out2;
 	}
 
-	ret = check_inum_access(ff, from_dir_ino, W_OK);
+	ret = fuse4fs_inum_access(ff, from_dir_ino, W_OK);
 	if (ret)
 		goto out2;
 
@@ -2527,7 +2530,7 @@ static int op_rename(const char *from, const char *to,
 		goto out2;
 	}
 
-	ret = check_inum_access(ff, to_dir_ino, W_OK);
+	ret = fuse4fs_inum_access(ff, to_dir_ino, W_OK);
 	if (ret)
 		goto out2;
 
@@ -2674,7 +2677,7 @@ static int op_link(const char *src, const char *dest)
 	*node_name = 0;
 
 	fs = fuse4fs_start(ff);
-	if (!fs_can_allocate(ff, 2)) {
+	if (!fuse4fs_can_allocate(ff, 2)) {
 		ret = -ENOSPC;
 		goto out2;
 	}
@@ -2687,7 +2690,7 @@ static int op_link(const char *src, const char *dest)
 		goto out2;
 	}
 
-	ret = check_inum_access(ff, parent, A_OK | W_OK);
+	ret = fuse4fs_inum_access(ff, parent, A_OK | W_OK);
 	if (ret)
 		goto out2;
 
@@ -2703,7 +2706,7 @@ static int op_link(const char *src, const char *dest)
 		goto out2;
 	}
 
-	ret = check_iflags_access(ff, ino, EXT2_INODE(&inode), W_OK);
+	ret = fuse4fs_iflags_access(ff, ino, EXT2_INODE(&inode), W_OK);
 	if (ret)
 		goto out2;
 
@@ -2743,7 +2746,7 @@ static int op_link(const char *src, const char *dest)
 }
 
 /* Obtain group ids of the process that sent us a command(?) */
-static int get_req_groups(struct fuse4fs *ff, gid_t **gids, size_t *nr_gids)
+static int fuse4fs_get_groups(struct fuse4fs *ff, gid_t **gids, size_t *nr_gids)
 {
 	ext2_filsys fs = ff->fs;
 	errcode_t err;
@@ -2788,8 +2791,8 @@ static int get_req_groups(struct fuse4fs *ff, gid_t **gids, size_t *nr_gids)
  * that initiated the fuse request?  Returns 1 for yes, 0 for no, or a negative
  * errno.
  */
-static int in_file_group(struct fuse_context *ctxt,
-			 const struct ext2_inode_large *inode)
+static int fuse4fs_in_file_group(struct fuse_context *ctxt,
+				 const struct ext2_inode_large *inode)
 {
 	struct fuse4fs *ff = fuse4fs_get();
 	gid_t *gids = NULL;
@@ -2797,7 +2800,7 @@ static int in_file_group(struct fuse_context *ctxt,
 	gid_t gid = inode_gid(*inode);
 	int ret;
 
-	ret = get_req_groups(ff, &gids, &nr_gids);
+	ret = fuse4fs_get_groups(ff, &gids, &nr_gids);
 	if (ret == -ENOENT) {
 		/* magic return code for "could not get caller group info" */
 		return ctxt->gid == inode_gid(*inode);
@@ -2840,11 +2843,11 @@ static int op_chmod(const char *path, mode_t mode, struct fuse_file_info *fi)
 		goto out;
 	}
 
-	ret = check_iflags_access(ff, ino, EXT2_INODE(&inode), W_OK);
+	ret = fuse4fs_iflags_access(ff, ino, EXT2_INODE(&inode), W_OK);
 	if (ret)
 		goto out;
 
-	if (want_check_owner(ff, ctxt) && ctxt->uid != inode_uid(inode)) {
+	if (fuse4fs_want_check_owner(ff, ctxt) && ctxt->uid != inode_uid(inode)) {
 		ret = -EPERM;
 		goto out;
 	}
@@ -2854,8 +2857,8 @@ static int op_chmod(const char *path, mode_t mode, struct fuse_file_info *fi)
 	 * of the user's groups, but FUSE only tells us about the primary
 	 * group.
 	 */
-	if (!is_superuser(ff, ctxt)) {
-		ret = in_file_group(ctxt, &inode);
+	if (!fuse4fs_is_superuser(ff, ctxt)) {
+		ret = fuse4fs_in_file_group(ctxt, &inode);
 		if (ret < 0)
 			goto out;
 
@@ -2909,14 +2912,14 @@ static int op_chown(const char *path, uid_t owner, gid_t group,
 		goto out;
 	}
 
-	ret = check_iflags_access(ff, ino, EXT2_INODE(&inode), W_OK);
+	ret = fuse4fs_iflags_access(ff, ino, EXT2_INODE(&inode), W_OK);
 	if (ret)
 		goto out;
 
 	/* FUSE seems to feed us ~0 to mean "don't change" */
 	if (owner != (uid_t) ~0) {
 		/* Only root gets to change UID. */
-		if (want_check_owner(ff, ctxt) &&
+		if (fuse4fs_want_check_owner(ff, ctxt) &&
 		    !(inode_uid(inode) == ctxt->uid && owner == ctxt->uid)) {
 			ret = -EPERM;
 			goto out;
@@ -2926,7 +2929,7 @@ static int op_chown(const char *path, uid_t owner, gid_t group,
 
 	if (group != (gid_t) ~0) {
 		/* Only root or the owner get to change GID. */
-		if (want_check_owner(ff, ctxt) &&
+		if (fuse4fs_want_check_owner(ff, ctxt) &&
 		    inode_uid(inode) != ctxt->uid) {
 			ret = -EPERM;
 			goto out;
@@ -3036,7 +3039,7 @@ static int op_truncate(const char *path, off_t len, struct fuse_file_info *fi)
 		goto out;
 	dbg_printf(ff, "%s: ino=%d len=%jd\n", __func__, ino, (intmax_t) len);
 
-	ret = check_inum_access(ff, ino, W_OK);
+	ret = fuse4fs_inum_access(ff, ino, W_OK);
 	if (ret)
 		goto out;
 
@@ -3118,7 +3121,7 @@ static int __op_open(struct fuse4fs *ff, const char *path,
 	}
 	dbg_printf(ff, "%s: ino=%d\n", __func__, file->ino);
 
-	ret = check_inum_access(ff, file->ino, check);
+	ret = fuse4fs_inum_access(ff, file->ino, check);
 	if (ret) {
 		/*
 		 * In a regular (Linux) fs driver, the kernel will open
@@ -3130,7 +3133,7 @@ static int __op_open(struct fuse4fs *ff, const char *path,
 		 * also employ undocumented hacks (see above).
 		 */
 		if (check == R_OK) {
-			ret = check_inum_access(ff, file->ino, X_OK);
+			ret = fuse4fs_inum_access(ff, file->ino, X_OK);
 			if (ret)
 				goto out;
 		} else
@@ -3239,7 +3242,7 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 		goto out;
 	}
 
-	if (!fs_can_allocate(ff, FUSE4FS_B_TO_FSB(ff, len))) {
+	if (!fuse4fs_can_allocate(ff, FUSE4FS_B_TO_FSB(ff, len))) {
 		ret = -ENOSPC;
 		goto out;
 	}
@@ -3439,11 +3442,11 @@ static int op_getxattr(const char *path, const char *key, char *value,
 	}
 	dbg_printf(ff, "%s: ino=%d name=%s\n", __func__, ino, key);
 
-	ret = check_inum_access(ff, ino, R_OK);
+	ret = fuse4fs_inum_access(ff, ino, R_OK);
 	if (ret)
 		goto out;
 
-	ret = __getxattr(ff, ino, key, &ptr, &plen);
+	ret = fuse4fs_getxattr(ff, ino, key, &ptr, &plen);
 	if (ret)
 		goto out;
 
@@ -3509,7 +3512,7 @@ static int op_listxattr(const char *path, char *names, size_t len)
 	}
 	dbg_printf(ff, "%s: ino=%d\n", __func__, ino);
 
-	ret = check_inum_access(ff, ino, R_OK);
+	ret = fuse4fs_inum_access(ff, ino, R_OK);
 	if (ret)
 		goto out;
 
@@ -3590,7 +3593,7 @@ static int op_setxattr(const char *path EXT2FS_ATTR((unused)),
 	}
 	dbg_printf(ff, "%s: ino=%d name=%s\n", __func__, ino, key);
 
-	ret = check_inum_access(ff, ino, W_OK);
+	ret = fuse4fs_inum_access(ff, ino, W_OK);
 	if (ret == -EACCES) {
 		ret = -EPERM;
 		goto out;
@@ -3679,7 +3682,7 @@ static int op_removexattr(const char *path, const char *key)
 		goto out;
 	}
 
-	if (!fs_can_allocate(ff, 1)) {
+	if (!fuse4fs_can_allocate(ff, 1)) {
 		ret = -ENOSPC;
 		goto out;
 	}
@@ -3691,7 +3694,7 @@ static int op_removexattr(const char *path, const char *key)
 	}
 	dbg_printf(ff, "%s: ino=%d name=%s\n", __func__, ino, key);
 
-	ret = check_inum_access(ff, ino, W_OK);
+	ret = fuse4fs_inum_access(ff, ino, W_OK);
 	if (ret)
 		goto out;
 
@@ -3878,7 +3881,7 @@ static int op_access(const char *path, int mask)
 		goto out;
 	}
 
-	ret = check_inum_access(ff, ino, mask);
+	ret = fuse4fs_inum_access(ff, ino, mask);
 	if (ret)
 		goto out;
 
@@ -3918,7 +3921,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 	*node_name = 0;
 
 	fs = fuse4fs_start(ff);
-	if (!fs_can_allocate(ff, 1)) {
+	if (!fuse4fs_can_allocate(ff, 1)) {
 		ret = -ENOSPC;
 		goto out2;
 	}
@@ -3930,7 +3933,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 		goto out2;
 	}
 
-	ret = check_inum_access(ff, parent, A_OK | W_OK);
+	ret = fuse4fs_inum_access(ff, parent, A_OK | W_OK);
 	if (ret)
 		goto out2;
 
@@ -3997,7 +4000,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 
 	ext2fs_inode_alloc_stats2(fs, child, 1, 0);
 
-	ret = propagate_default_acls(ff, parent, child);
+	ret = fuse4fs_propagate_default_acls(ff, parent, child);
 	if (ret)
 		goto out2;
 
@@ -4045,7 +4048,7 @@ static int op_utimens(const char *path, const struct timespec ctv[2],
 	 */
 	if (ctv[0].tv_nsec == UTIME_NOW && ctv[1].tv_nsec == UTIME_NOW)
 		access |= A_OK;
-	ret = check_inum_access(ff, ino, access);
+	ret = fuse4fs_inum_access(ff, ino, access);
 	if (ret)
 		goto out;
 
@@ -4130,7 +4133,7 @@ static int ioctl_setflags(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
 	if (err)
 		return translate_error(fs, fh->ino, err);
 
-	if (want_check_owner(ff, ctxt) && inode_uid(inode) != ctxt->uid)
+	if (fuse4fs_want_check_owner(ff, ctxt) && inode_uid(inode) != ctxt->uid)
 		return -EPERM;
 
 	ret = set_iflags(&inode, flags);
@@ -4179,7 +4182,7 @@ static int ioctl_setversion(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
 	if (err)
 		return translate_error(fs, fh->ino, err);
 
-	if (want_check_owner(ff, ctxt) && inode_uid(inode) != ctxt->uid)
+	if (fuse4fs_want_check_owner(ff, ctxt) && inode_uid(inode) != ctxt->uid)
 		return -EPERM;
 
 	inode.i_generation = generation;
@@ -4278,7 +4281,7 @@ static int ioctl_fssetxattr(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
 	if (err)
 		return translate_error(fs, fh->ino, err);
 
-	if (want_check_owner(ff, ctxt) && inode_uid(inode) != ctxt->uid)
+	if (fuse4fs_want_check_owner(ff, ctxt) && inode_uid(inode) != ctxt->uid)
 		return -EPERM;
 
 	ret = set_iflags(&inode, flags);
@@ -4399,7 +4402,7 @@ static int ioctl_shutdown(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
 	struct fuse_context *ctxt = fuse_get_context();
 	ext2_filsys fs = ff->fs;
 
-	if (!is_superuser(ff, ctxt))
+	if (!fuse4fs_is_superuser(ff, ctxt))
 		return -EPERM;
 
 	err_printf(ff, "%s.\n", _("shut down requested"));
@@ -4518,7 +4521,7 @@ static int fuse4fs_allocate_range(struct fuse4fs *ff,
 		   (unsigned long long)len,
 		   (unsigned long long)start,
 		   (unsigned long long)end);
-	if (!fs_can_allocate(ff, FUSE4FS_B_TO_FSB(ff, len)))
+	if (!fuse4fs_can_allocate(ff, FUSE4FS_B_TO_FSB(ff, len)))
 		return -ENOSPC;
 
 	err = fuse4fs_read_inode(fs, fh->ino, &inode);
@@ -4561,9 +4564,9 @@ static int fuse4fs_allocate_range(struct fuse4fs *ff,
 	return err;
 }
 
-static errcode_t clean_block_middle(struct fuse4fs *ff, ext2_ino_t ino,
-				    struct ext2_inode_large *inode,
-				    off_t offset, off_t len, char **buf)
+static errcode_t fuse4fs_zero_middle(struct fuse4fs *ff, ext2_ino_t ino,
+				     struct ext2_inode_large *inode,
+				     off_t offset, off_t len, char **buf)
 {
 	ext2_filsys fs = ff->fs;
 	blk64_t blk;
@@ -4597,9 +4600,9 @@ static errcode_t clean_block_middle(struct fuse4fs *ff, ext2_ino_t ino,
 	return io_channel_write_blk64(fs->io, blk, 1, *buf);
 }
 
-static errcode_t clean_block_edge(struct fuse4fs *ff, ext2_ino_t ino,
-				  struct ext2_inode_large *inode, off_t offset,
-				  int clean_before, char **buf)
+static errcode_t fuse4fs_zero_edge(struct fuse4fs *ff, ext2_ino_t ino,
+				   struct ext2_inode_large *inode, off_t offset,
+				   int clean_before, char **buf)
 {
 	ext2_filsys fs = ff->fs;
 	blk64_t blk;
@@ -4690,13 +4693,13 @@ static int fuse4fs_punch_range(struct fuse4fs *ff,
 
 	/* Zero everything before the first block and after the last block */
 	if (FUSE4FS_B_TO_FSBT(ff, offset) == FUSE4FS_B_TO_FSBT(ff, offset + len))
-		err = clean_block_middle(ff, fh->ino, &inode, offset,
+		err = fuse4fs_zero_middle(ff, fh->ino, &inode, offset,
 					 len, &buf);
 	else {
-		err = clean_block_edge(ff, fh->ino, &inode, offset, 0, &buf);
+		err = fuse4fs_zero_edge(ff, fh->ino, &inode, offset, 0, &buf);
 		if (!err)
-			err = clean_block_edge(ff, fh->ino, &inode,
-					       offset + len, 1, &buf);
+			err = fuse4fs_zero_edge(ff, fh->ino, &inode,
+						offset + len, 1, &buf);
 	}
 	if (buf)
 		ext2fs_free_mem(&buf);


