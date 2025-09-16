Return-Path: <linux-fsdevel+bounces-61595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA3CB58A24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB995239D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306811C8621;
	Tue, 16 Sep 2025 00:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0e952PH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8949D19EEC2;
	Tue, 16 Sep 2025 00:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983902; cv=none; b=aMHjKcoMjY6vWwQb0B1Vz6cX8ysVIr/Wy2ET+haJqxRwx0nB0+mOcv8C3JXhwWTXA8mD1cIjB9NfHkfJfExe3N5VO8HE7qQ/94EeuMSuc9JXyTxv3YL2gCD+xFYbFFKG/RDJMb9vMrrKp/pFRwWA1ON4SIPVwX5+5Q4gjtAjiqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983902; c=relaxed/simple;
	bh=pgQxkCxJWLhbgq0b82xpEW+tzXCJWgAH7u+7+q6ZLqQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J7665FYBGgyNhCfK4G7QmkMt+plXxV+l+RBluiQT1Yv0sNOhKPRW6h6dPH7kanMJjFzGBmnO3Ikx9YDM1ssuiJD9y+btp3t8wBBGb/hv3M2hLMcFztpbEjvbqunfVG4A9/sbq5jwbJlW+lB+3sr2OVomseb2ZPH7EaGMUNQK1/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0e952PH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159B1C4CEF5;
	Tue, 16 Sep 2025 00:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983902;
	bh=pgQxkCxJWLhbgq0b82xpEW+tzXCJWgAH7u+7+q6ZLqQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=r0e952PH/dGG/2e1PV+qJFgoJiYhN7mbQbBlIntmrZLexiyuuPRiLvDtvCq+M+kmb
	 OI1tu+WlgAoEqNvbB+AmBV2Q8PP4MoxuxtCWQe0VHJ/t9G7uKuDA0aqSfytMhLjXG3
	 sG0PWYzAVl5i/uyfjzgKYd68GvIYN+xvchK/QqsNKO9SrdNGMWAe2NsRt9MJncHdDG
	 FHEbSLTaduLiKkqRvyKf2OtyVsF7v+85BlnLxg8xgs4UInyHJrc0r1WNVEaNexWfTC
	 RJQFw8BfSjg9+qArOFuNFQpyZp3gXX8jouezCZPv5sk4ZtVtPn2OqtXGlX+sdXVyZm
	 IHuMkSWpoFstQ==
Date: Mon, 15 Sep 2025 17:51:41 -0700
Subject: [PATCH 04/21] fuse4fs: namespace some helpers
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, John@groves.net,
 bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175798160847.389252.14928522642504543579.stgit@frogsfrogsfrogs>
In-Reply-To: <175798160681.389252.3813376553626224026.stgit@frogsfrogsfrogs>
References: <175798160681.389252.3813376553626224026.stgit@frogsfrogsfrogs>
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
 fuse4fs/fuse4fs.c |  177 +++++++++++++++++++++++++++--------------------------
 1 file changed, 90 insertions(+), 87 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 99b9b902b37a57..a4eeb86201db0c 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -2,6 +2,7 @@
  * fuse4fs.c - FUSE low-level server for e2fsprogs.
  *
  * Copyright (C) 2014-2025 Oracle.
+ * Copyright (C) 2025 CTERA Networks.
  *
  * %Begin-Header%
  * This file may be redistributed under the terms of the GNU Public
@@ -696,7 +697,7 @@ static int ext2_file_type(unsigned int mode)
 	return 0;
 }
 
-static int fs_can_allocate(struct fuse4fs *ff, blk64_t num)
+static int fuse4fs_can_allocate(struct fuse4fs *ff, blk64_t num)
 {
 	ext2_filsys fs = ff->fs;
 	blk64_t reserved;
@@ -723,21 +724,22 @@ static int fs_can_allocate(struct fuse4fs *ff, blk64_t num)
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
@@ -745,14 +747,14 @@ static inline int want_check_owner(struct fuse4fs *ff,
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
 
@@ -780,7 +782,7 @@ static int check_iflags_access(struct fuse4fs *ff, ext2_ino_t ino,
 	return 0;
 }
 
-static int check_inum_access(struct fuse4fs *ff, ext2_ino_t ino, int mask)
+static int fuse4fs_inum_access(struct fuse4fs *ff, ext2_ino_t ino, int mask)
 {
 	struct fuse_context *ctxt = fuse_get_context();
 	ext2_filsys fs = ff->fs;
@@ -812,7 +814,7 @@ static int check_inum_access(struct fuse4fs *ff, ext2_ino_t ino, int mask)
 	if (mask == 0)
 		return 0;
 
-	ret = check_iflags_access(ff, ino, &inode, mask);
+	ret = fuse4fs_iflags_access(ff, ino, &inode, mask);
 	if (ret)
 		return ret;
 
@@ -821,7 +823,7 @@ static int check_inum_access(struct fuse4fs *ff, ext2_ino_t ino, int mask)
 		return 0;
 
 	/* Figure out what root's allowed to do */
-	if (is_superuser(ff, ctxt)) {
+	if (fuse4fs_is_superuser(ff, ctxt)) {
 		/* Non-file access always ok */
 		if (!LINUX_S_ISREG(inode.i_mode))
 			return 0;
@@ -1539,8 +1541,8 @@ static int op_readlink(const char *path, char *buf, size_t len)
 	return ret;
 }
 
-static int __getxattr(struct fuse4fs *ff, ext2_ino_t ino, const char *name,
-		      void **value, size_t *value_len)
+static int fuse4fs_getxattr(struct fuse4fs *ff, ext2_ino_t ino,
+			    const char *name, void **value, size_t *value_len)
 {
 	ext2_filsys fs = ff->fs;
 	struct ext2_xattr_handle *h;
@@ -1570,8 +1572,8 @@ static int __getxattr(struct fuse4fs *ff, ext2_ino_t ino, const char *name,
 	return ret;
 }
 
-static int __setxattr(struct fuse4fs *ff, ext2_ino_t ino, const char *name,
-		      void *value, size_t valuelen)
+static int fuse4fs_setxattr(struct fuse4fs *ff, ext2_ino_t ino,
+			    const char *name, void *value, size_t valuelen)
 {
 	ext2_filsys fs = ff->fs;
 	struct ext2_xattr_handle *h;
@@ -1601,8 +1603,8 @@ static int __setxattr(struct fuse4fs *ff, ext2_ino_t ino, const char *name,
 	return ret;
 }
 
-static int propagate_default_acls(struct fuse4fs *ff, ext2_ino_t parent,
-				  ext2_ino_t child, mode_t mode)
+static int fuse4fs_propagate_default_acls(struct fuse4fs *ff, ext2_ino_t parent,
+					  ext2_ino_t child, mode_t mode)
 {
 	void *def;
 	size_t deflen;
@@ -1611,8 +1613,8 @@ static int propagate_default_acls(struct fuse4fs *ff, ext2_ino_t parent,
 	if (!ff->acl || S_ISDIR(mode))
 		return 0;
 
-	ret = __getxattr(ff, parent, XATTR_NAME_POSIX_ACL_DEFAULT, &def,
-			 &deflen);
+	ret = fuse4fs_getxattr(ff, parent, XATTR_NAME_POSIX_ACL_DEFAULT, &def,
+			       &deflen);
 	switch (ret) {
 	case -ENODATA:
 	case -ENOENT:
@@ -1624,7 +1626,8 @@ static int propagate_default_acls(struct fuse4fs *ff, ext2_ino_t parent,
 		return ret;
 	}
 
-	ret = __setxattr(ff, child, XATTR_NAME_POSIX_ACL_DEFAULT, def, deflen);
+	ret = fuse4fs_setxattr(ff, child, XATTR_NAME_POSIX_ACL_DEFAULT, def,
+			       deflen);
 	ext2fs_free_mem(&def);
 	return ret;
 }
@@ -1753,7 +1756,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 	*node_name = 0;
 
 	fs = fuse4fs_start(ff);
-	if (!fs_can_allocate(ff, 2)) {
+	if (!fuse4fs_can_allocate(ff, 2)) {
 		ret = -ENOSPC;
 		goto out2;
 	}
@@ -1765,7 +1768,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 		goto out2;
 	}
 
-	ret = check_inum_access(ff, parent, A_OK | W_OK);
+	ret = fuse4fs_inum_access(ff, parent, A_OK | W_OK);
 	if (ret)
 		goto out2;
 
@@ -1835,7 +1838,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 
 	ext2fs_inode_alloc_stats2(fs, child, 1, 0);
 
-	ret = propagate_default_acls(ff, parent, child, inode.i_mode);
+	ret = fuse4fs_propagate_default_acls(ff, parent, child, inode.i_mode);
 	if (ret)
 		goto out2;
 
@@ -1883,7 +1886,7 @@ static int op_mkdir(const char *path, mode_t mode)
 	*node_name = 0;
 
 	fs = fuse4fs_start(ff);
-	if (!fs_can_allocate(ff, 1)) {
+	if (!fuse4fs_can_allocate(ff, 1)) {
 		ret = -ENOSPC;
 		goto out2;
 	}
@@ -1895,7 +1898,7 @@ static int op_mkdir(const char *path, mode_t mode)
 		goto out2;
 	}
 
-	ret = check_inum_access(ff, parent, A_OK | W_OK);
+	ret = fuse4fs_inum_access(ff, parent, A_OK | W_OK);
 	if (ret)
 		goto out2;
 
@@ -1968,7 +1971,7 @@ static int op_mkdir(const char *path, mode_t mode)
 		goto out3;
 	}
 
-	ret = propagate_default_acls(ff, parent, child, inode.i_mode);
+	ret = fuse4fs_propagate_default_acls(ff, parent, child, inode.i_mode);
 	if (ret)
 		goto out3;
 
@@ -2009,7 +2012,7 @@ static int fuse4fs_unlink(struct fuse4fs *ff, const char *path,
 		base_name = filename;
 	}
 
-	ret = check_inum_access(ff, dir, W_OK);
+	ret = fuse4fs_inum_access(ff, dir, W_OK);
 	if (ret) {
 		free(filename);
 		return ret;
@@ -2031,8 +2034,8 @@ static int fuse4fs_unlink(struct fuse4fs *ff, const char *path,
 	return 0;
 }
 
-static int remove_ea_inodes(struct fuse4fs *ff, ext2_ino_t ino,
-			    struct ext2_inode_large *inode)
+static int fuse4fs_remove_ea_inodes(struct fuse4fs *ff, ext2_ino_t ino,
+				    struct ext2_inode_large *inode)
 {
 	ext2_filsys fs = ff->fs;
 	struct ext2_xattr_handle *h;
@@ -2076,7 +2079,7 @@ static int remove_ea_inodes(struct fuse4fs *ff, ext2_ino_t ino,
 	return 0;
 }
 
-static int remove_inode(struct fuse4fs *ff, ext2_ino_t ino)
+static int fuse4fs_remove_inode(struct fuse4fs *ff, ext2_ino_t ino)
 {
 	ext2_filsys fs = ff->fs;
 	errcode_t err;
@@ -2109,7 +2112,7 @@ static int remove_inode(struct fuse4fs *ff, ext2_ino_t ino)
 		goto write_out;
 
 	if (ext2fs_has_feature_ea_inode(fs->super)) {
-		ret = remove_ea_inodes(ff, ino, &inode);
+		ret = fuse4fs_remove_ea_inodes(ff, ino, &inode);
 		if (ret)
 			return ret;
 	}
@@ -2150,7 +2153,7 @@ static int __op_unlink(struct fuse4fs *ff, const char *path)
 		goto out;
 	}
 
-	ret = check_inum_access(ff, ino, W_OK);
+	ret = fuse4fs_inum_access(ff, ino, W_OK);
 	if (ret)
 		goto out;
 
@@ -2158,7 +2161,7 @@ static int __op_unlink(struct fuse4fs *ff, const char *path)
 	if (ret)
 		goto out;
 
-	ret = remove_inode(ff, ino);
+	ret = fuse4fs_remove_inode(ff, ino);
 	if (ret)
 		goto out;
 
@@ -2226,7 +2229,7 @@ static int __op_rmdir(struct fuse4fs *ff, const char *path)
 	}
 	dbg_printf(ff, "%s: rmdir path=%s ino=%d\n", __func__, path, child);
 
-	ret = check_inum_access(ff, child, W_OK);
+	ret = fuse4fs_inum_access(ff, child, W_OK);
 	if (ret)
 		goto out;
 
@@ -2245,7 +2248,7 @@ static int __op_rmdir(struct fuse4fs *ff, const char *path)
 		goto out;
 	}
 
-	ret = check_inum_access(ff, rds.parent, W_OK);
+	ret = fuse4fs_inum_access(ff, rds.parent, W_OK);
 	if (ret)
 		goto out;
 
@@ -2258,10 +2261,10 @@ static int __op_rmdir(struct fuse4fs *ff, const char *path)
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
 
@@ -2347,7 +2350,7 @@ static int op_symlink(const char *src, const char *dest)
 		goto out2;
 	}
 
-	ret = check_inum_access(ff, parent, A_OK | W_OK);
+	ret = fuse4fs_inum_access(ff, parent, A_OK | W_OK);
 	if (ret)
 		goto out2;
 
@@ -2459,7 +2462,7 @@ static int op_rename(const char *from, const char *to,
 	FUSE4FS_CHECK_CONTEXT(ff);
 	dbg_printf(ff, "%s: renaming %s to %s\n", __func__, from, to);
 	fs = fuse4fs_start(ff);
-	if (!fs_can_allocate(ff, 5)) {
+	if (!fuse4fs_can_allocate(ff, 5)) {
 		ret = -ENOSPC;
 		goto out;
 	}
@@ -2485,12 +2488,12 @@ static int op_rename(const char *from, const char *to,
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
@@ -2528,7 +2531,7 @@ static int op_rename(const char *from, const char *to,
 		goto out2;
 	}
 
-	ret = check_inum_access(ff, from_dir_ino, W_OK);
+	ret = fuse4fs_inum_access(ff, from_dir_ino, W_OK);
 	if (ret)
 		goto out2;
 
@@ -2553,7 +2556,7 @@ static int op_rename(const char *from, const char *to,
 		goto out2;
 	}
 
-	ret = check_inum_access(ff, to_dir_ino, W_OK);
+	ret = fuse4fs_inum_access(ff, to_dir_ino, W_OK);
 	if (ret)
 		goto out2;
 
@@ -2700,7 +2703,7 @@ static int op_link(const char *src, const char *dest)
 	*node_name = 0;
 
 	fs = fuse4fs_start(ff);
-	if (!fs_can_allocate(ff, 2)) {
+	if (!fuse4fs_can_allocate(ff, 2)) {
 		ret = -ENOSPC;
 		goto out2;
 	}
@@ -2713,7 +2716,7 @@ static int op_link(const char *src, const char *dest)
 		goto out2;
 	}
 
-	ret = check_inum_access(ff, parent, A_OK | W_OK);
+	ret = fuse4fs_inum_access(ff, parent, A_OK | W_OK);
 	if (ret)
 		goto out2;
 
@@ -2729,7 +2732,7 @@ static int op_link(const char *src, const char *dest)
 		goto out2;
 	}
 
-	ret = check_iflags_access(ff, ino, EXT2_INODE(&inode), W_OK);
+	ret = fuse4fs_iflags_access(ff, ino, EXT2_INODE(&inode), W_OK);
 	if (ret)
 		goto out2;
 
@@ -2769,7 +2772,7 @@ static int op_link(const char *src, const char *dest)
 }
 
 /* Obtain group ids of the process that sent us a command(?) */
-static int get_req_groups(struct fuse4fs *ff, gid_t **gids, size_t *nr_gids)
+static int fuse4fs_get_groups(struct fuse4fs *ff, gid_t **gids, size_t *nr_gids)
 {
 	ext2_filsys fs = ff->fs;
 	errcode_t err;
@@ -2814,8 +2817,8 @@ static int get_req_groups(struct fuse4fs *ff, gid_t **gids, size_t *nr_gids)
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
@@ -2827,7 +2830,7 @@ static int in_file_group(struct fuse_context *ctxt,
 	if (ctxt->gid == gid)
 		return 1;
 
-	ret = get_req_groups(ff, &gids, &nr_gids);
+	ret = fuse4fs_get_groups(ff, &gids, &nr_gids);
 	if (ret == -ENOENT) {
 		/* magic return code for "could not get caller group info" */
 		return 0;
@@ -2870,11 +2873,11 @@ static int op_chmod(const char *path, mode_t mode, struct fuse_file_info *fi)
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
@@ -2884,8 +2887,8 @@ static int op_chmod(const char *path, mode_t mode, struct fuse_file_info *fi)
 	 * of the user's groups, but FUSE only tells us about the primary
 	 * group.
 	 */
-	if (!is_superuser(ff, ctxt)) {
-		ret = in_file_group(ctxt, &inode);
+	if (!fuse4fs_is_superuser(ff, ctxt)) {
+		ret = fuse4fs_in_file_group(ctxt, &inode);
 		if (ret < 0)
 			goto out;
 
@@ -2939,14 +2942,14 @@ static int op_chown(const char *path, uid_t owner, gid_t group,
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
@@ -2956,7 +2959,7 @@ static int op_chown(const char *path, uid_t owner, gid_t group,
 
 	if (group != (gid_t) ~0) {
 		/* Only root or the owner get to change GID. */
-		if (want_check_owner(ff, ctxt) &&
+		if (fuse4fs_want_check_owner(ff, ctxt) &&
 		    inode_uid(inode) != ctxt->uid) {
 			ret = -EPERM;
 			goto out;
@@ -3066,7 +3069,7 @@ static int op_truncate(const char *path, off_t len, struct fuse_file_info *fi)
 		goto out;
 	dbg_printf(ff, "%s: ino=%d len=%jd\n", __func__, ino, (intmax_t) len);
 
-	ret = check_inum_access(ff, ino, W_OK);
+	ret = fuse4fs_inum_access(ff, ino, W_OK);
 	if (ret)
 		goto out;
 
@@ -3148,7 +3151,7 @@ static int __op_open(struct fuse4fs *ff, const char *path,
 	}
 	dbg_printf(ff, "%s: ino=%d\n", __func__, file->ino);
 
-	ret = check_inum_access(ff, file->ino, check);
+	ret = fuse4fs_inum_access(ff, file->ino, check);
 	if (ret) {
 		/*
 		 * In a regular (Linux) fs driver, the kernel will open
@@ -3160,7 +3163,7 @@ static int __op_open(struct fuse4fs *ff, const char *path,
 		 * also employ undocumented hacks (see above).
 		 */
 		if (check == R_OK) {
-			ret = check_inum_access(ff, file->ino, X_OK);
+			ret = fuse4fs_inum_access(ff, file->ino, X_OK);
 			if (ret)
 				goto out;
 			check = X_OK;
@@ -3271,7 +3274,7 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 		goto out;
 	}
 
-	if (!fs_can_allocate(ff, FUSE4FS_B_TO_FSB(ff, len))) {
+	if (!fuse4fs_can_allocate(ff, FUSE4FS_B_TO_FSB(ff, len))) {
 		ret = -ENOSPC;
 		goto out;
 	}
@@ -3471,11 +3474,11 @@ static int op_getxattr(const char *path, const char *key, char *value,
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
 
@@ -3541,7 +3544,7 @@ static int op_listxattr(const char *path, char *names, size_t len)
 	}
 	dbg_printf(ff, "%s: ino=%d\n", __func__, ino);
 
-	ret = check_inum_access(ff, ino, R_OK);
+	ret = fuse4fs_inum_access(ff, ino, R_OK);
 	if (ret)
 		goto out;
 
@@ -3622,7 +3625,7 @@ static int op_setxattr(const char *path EXT2FS_ATTR((unused)),
 	}
 	dbg_printf(ff, "%s: ino=%d name=%s\n", __func__, ino, key);
 
-	ret = check_inum_access(ff, ino, W_OK);
+	ret = fuse4fs_inum_access(ff, ino, W_OK);
 	if (ret == -EACCES) {
 		ret = -EPERM;
 		goto out;
@@ -3711,7 +3714,7 @@ static int op_removexattr(const char *path, const char *key)
 		goto out;
 	}
 
-	if (!fs_can_allocate(ff, 1)) {
+	if (!fuse4fs_can_allocate(ff, 1)) {
 		ret = -ENOSPC;
 		goto out;
 	}
@@ -3723,7 +3726,7 @@ static int op_removexattr(const char *path, const char *key)
 	}
 	dbg_printf(ff, "%s: ino=%d name=%s\n", __func__, ino, key);
 
-	ret = check_inum_access(ff, ino, W_OK);
+	ret = fuse4fs_inum_access(ff, ino, W_OK);
 	if (ret)
 		goto out;
 
@@ -3910,7 +3913,7 @@ static int op_access(const char *path, int mask)
 		goto out;
 	}
 
-	ret = check_inum_access(ff, ino, mask);
+	ret = fuse4fs_inum_access(ff, ino, mask);
 	if (ret)
 		goto out;
 
@@ -3950,7 +3953,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 	*node_name = 0;
 
 	fs = fuse4fs_start(ff);
-	if (!fs_can_allocate(ff, 1)) {
+	if (!fuse4fs_can_allocate(ff, 1)) {
 		ret = -ENOSPC;
 		goto out2;
 	}
@@ -3962,7 +3965,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 		goto out2;
 	}
 
-	ret = check_inum_access(ff, parent, A_OK | W_OK);
+	ret = fuse4fs_inum_access(ff, parent, A_OK | W_OK);
 	if (ret)
 		goto out2;
 
@@ -4029,7 +4032,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 
 	ext2fs_inode_alloc_stats2(fs, child, 1, 0);
 
-	ret = propagate_default_acls(ff, parent, child, inode.i_mode);
+	ret = fuse4fs_propagate_default_acls(ff, parent, child, inode.i_mode);
 	if (ret)
 		goto out2;
 
@@ -4077,7 +4080,7 @@ static int op_utimens(const char *path, const struct timespec ctv[2],
 	 */
 	if (ctv[0].tv_nsec == UTIME_NOW && ctv[1].tv_nsec == UTIME_NOW)
 		access |= A_OK;
-	ret = check_inum_access(ff, ino, access);
+	ret = fuse4fs_inum_access(ff, ino, access);
 	if (ret)
 		goto out;
 
@@ -4162,7 +4165,7 @@ static int ioctl_setflags(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
 	if (err)
 		return translate_error(fs, fh->ino, err);
 
-	if (want_check_owner(ff, ctxt) && inode_uid(inode) != ctxt->uid)
+	if (fuse4fs_want_check_owner(ff, ctxt) && inode_uid(inode) != ctxt->uid)
 		return -EPERM;
 
 	ret = set_iflags(&inode, flags);
@@ -4211,7 +4214,7 @@ static int ioctl_setversion(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
 	if (err)
 		return translate_error(fs, fh->ino, err);
 
-	if (want_check_owner(ff, ctxt) && inode_uid(inode) != ctxt->uid)
+	if (fuse4fs_want_check_owner(ff, ctxt) && inode_uid(inode) != ctxt->uid)
 		return -EPERM;
 
 	inode.i_generation = generation;
@@ -4336,7 +4339,7 @@ static int ioctl_fssetxattr(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
 	if (err)
 		return translate_error(fs, fh->ino, err);
 
-	if (want_check_owner(ff, ctxt) && inode_uid(inode) != ctxt->uid)
+	if (fuse4fs_want_check_owner(ff, ctxt) && inode_uid(inode) != ctxt->uid)
 		return -EPERM;
 
 	ret = set_xflags(&inode, fsx->fsx_xflags);
@@ -4465,7 +4468,7 @@ static int ioctl_shutdown(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
 	struct fuse_context *ctxt = fuse_get_context();
 	ext2_filsys fs = ff->fs;
 
-	if (!is_superuser(ff, ctxt))
+	if (!fuse4fs_is_superuser(ff, ctxt))
 		return -EPERM;
 
 	err_printf(ff, "%s.\n", _("shut down requested"));
@@ -4584,7 +4587,7 @@ static int fuse4fs_allocate_range(struct fuse4fs *ff,
 		   (unsigned long long)len,
 		   (unsigned long long)start,
 		   (unsigned long long)end);
-	if (!fs_can_allocate(ff, FUSE4FS_B_TO_FSB(ff, len)))
+	if (!fuse4fs_can_allocate(ff, FUSE4FS_B_TO_FSB(ff, len)))
 		return -ENOSPC;
 
 	err = fuse4fs_read_inode(fs, fh->ino, &inode);
@@ -4627,9 +4630,9 @@ static int fuse4fs_allocate_range(struct fuse4fs *ff,
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
@@ -4663,9 +4666,9 @@ static errcode_t clean_block_middle(struct fuse4fs *ff, ext2_ino_t ino,
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
@@ -4756,13 +4759,13 @@ static int fuse4fs_punch_range(struct fuse4fs *ff,
 
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


