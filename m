Return-Path: <linux-fsdevel+bounces-66116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A47DDC17D16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721A94255B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96502DAFC7;
	Wed, 29 Oct 2025 01:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzRsETtR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDCA1BCA1C;
	Wed, 29 Oct 2025 01:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700482; cv=none; b=elmAIPUw988oE9HT0FDmPr5A3d7QwuSwQRKnzW61a2Q+KypU80pOcjP6LhTEQUoFza0MWb+qLi9VqGZf43koMz9dTHUC7u5g8nBo7enSZCregx/LKevS7Mt9RkbsDFEwnyeiedAeBnl7Vwdbq94EGPBOiwT22WJB2JLQ3SjifOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700482; c=relaxed/simple;
	bh=4UovTnEkjek0g8v+qyn5wDQWRwWR7grdffoBTtS7nZw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O1TIhCBov9ta5+24a2nIpXKczdXLr4YiryoKoP+kkoRVWWNW8nXfJJrsqj4HxKxZmFe/tpJeDNRYUdiVCtUzgdHBEpBtX6e8DVUhz7+04Bgbvq8YD3Pv68UHveDgLaGx4GqTS46xjq0iU7wabdRvtLl9m0sm44MwpHcTu4/KhQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzRsETtR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E13C4CEE7;
	Wed, 29 Oct 2025 01:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700481;
	bh=4UovTnEkjek0g8v+qyn5wDQWRwWR7grdffoBTtS7nZw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=qzRsETtR/sDidh5EgGMYxNIbsD7vI/g09hDypfZfnogckmYIasosn2bUPQ74p/kpZ
	 BCarQm2DGH7yphF4yWzjdnJS1SWSeCvykb/Q3fjzCrjNGKUHCRc3wivfgsf2ovDjoJ
	 EUoYyc59sBbVjyPIO3KJxY51XcNDqbTGqGdUtNaWyyAjLh9nxG6ar9XB+qEiyTFpky
	 3XakAPld7DMQaXzs8Wy/NX6Fag7s5x1eH8Pdcq36DJ6NcW+j02YLnRw/FadgC7Radt
	 0xx8MaD1jf8ljzRgjOHrYto2m0e6pTrmCkhxwdeaKZnXnsbqqNHydhXlRqk4b8tZ8r
	 VJq7wO7gc/VNg==
Date: Tue, 28 Oct 2025 18:14:41 -0700
Subject: [PATCH 05/11] fuse2fs: debug timestamp updates
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169818312.1430380.14612165762844822973.stgit@frogsfrogsfrogs>
In-Reply-To: <176169818170.1430380.13590456647130347042.stgit@frogsfrogsfrogs>
References: <176169818170.1430380.13590456647130347042.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add tracing for timestamp updates to files.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   97 +++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 61 insertions(+), 36 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index fe6410a42a17ff..f77d778aec24ec 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -864,7 +864,8 @@ static void increment_version(struct ext2_inode_large *inode)
 		inode->i_version_hi = ver >> 32;
 }
 
-static void init_times(struct ext2_inode_large *inode)
+static void fuse2fs_init_timestamps(struct fuse2fs *ff, ext2_ino_t ino,
+				    struct ext2_inode_large *inode)
 {
 	struct timespec now;
 
@@ -874,11 +875,15 @@ static void init_times(struct ext2_inode_large *inode)
 	EXT4_INODE_SET_XTIME(i_mtime, &now, inode);
 	EXT4_EINODE_SET_XTIME(i_crtime, &now, inode);
 	increment_version(inode);
+
+	dbg_printf(ff, "%s: ino=%u time %ld:%lu\n", __func__, ino, now.tv_sec,
+		   now.tv_nsec);
 }
 
-static int update_ctime(ext2_filsys fs, ext2_ino_t ino,
-			struct ext2_inode_large *pinode)
+static int fuse2fs_update_ctime(struct fuse2fs *ff, ext2_ino_t ino,
+				struct ext2_inode_large *pinode)
 {
+	ext2_filsys fs = ff->fs;
 	errcode_t err;
 	struct timespec now;
 	struct ext2_inode_large inode;
@@ -889,6 +894,10 @@ static int update_ctime(ext2_filsys fs, ext2_ino_t ino,
 	if (pinode) {
 		increment_version(pinode);
 		EXT4_INODE_SET_XTIME(i_ctime, &now, pinode);
+
+		dbg_printf(ff, "%s: ino=%u ctime %ld:%lu\n", __func__, ino,
+			   now.tv_sec, now.tv_nsec);
+
 		return 0;
 	}
 
@@ -900,6 +909,9 @@ static int update_ctime(ext2_filsys fs, ext2_ino_t ino,
 	increment_version(&inode);
 	EXT4_INODE_SET_XTIME(i_ctime, &now, &inode);
 
+	dbg_printf(ff, "%s: ino=%u ctime %ld:%lu\n", __func__, ino,
+		   now.tv_sec, now.tv_nsec);
+
 	err = fuse2fs_write_inode(fs, ino, &inode);
 	if (err)
 		return translate_error(fs, ino, err);
@@ -907,8 +919,9 @@ static int update_ctime(ext2_filsys fs, ext2_ino_t ino,
 	return 0;
 }
 
-static int update_atime(ext2_filsys fs, ext2_ino_t ino)
+static int fuse2fs_update_atime(struct fuse2fs *ff, ext2_ino_t ino)
 {
+	ext2_filsys fs = ff->fs;
 	errcode_t err;
 	struct ext2_inode_large inode, *pinode;
 	struct timespec atime, mtime, now;
@@ -927,6 +940,10 @@ static int update_atime(ext2_filsys fs, ext2_ino_t ino)
 	dmtime = mtime.tv_sec + ((double)mtime.tv_nsec / NSEC_PER_SEC);
 	dnow = now.tv_sec + ((double)now.tv_nsec / NSEC_PER_SEC);
 
+	dbg_printf(ff, "%s: ino=%u atime %ld:%lu mtime %ld:%lu now %ld:%lu\n",
+		   __func__, ino, atime.tv_sec, atime.tv_nsec, mtime.tv_sec,
+		   mtime.tv_nsec, now.tv_sec, now.tv_nsec);
+
 	/*
 	 * If atime is newer than mtime and atime hasn't been updated in thirty
 	 * seconds, skip the atime update.  Same idea as Linux "relatime".  Use
@@ -943,9 +960,10 @@ static int update_atime(ext2_filsys fs, ext2_ino_t ino)
 	return 0;
 }
 
-static int update_mtime(ext2_filsys fs, ext2_ino_t ino,
-			struct ext2_inode_large *pinode)
+static int fuse2fs_update_mtime(struct fuse2fs *ff, ext2_ino_t ino,
+				struct ext2_inode_large *pinode)
 {
+	ext2_filsys fs = ff->fs;
 	errcode_t err;
 	struct ext2_inode_large inode;
 	struct timespec now;
@@ -955,6 +973,10 @@ static int update_mtime(ext2_filsys fs, ext2_ino_t ino,
 		EXT4_INODE_SET_XTIME(i_mtime, &now, pinode);
 		EXT4_INODE_SET_XTIME(i_ctime, &now, pinode);
 		increment_version(pinode);
+
+		dbg_printf(ff, "%s: ino=%u mtime/ctime %ld:%lu\n",
+			   __func__, ino, now.tv_sec, now.tv_nsec);
+
 		return 0;
 	}
 
@@ -967,6 +989,9 @@ static int update_mtime(ext2_filsys fs, ext2_ino_t ino,
 	EXT4_INODE_SET_XTIME(i_ctime, &now, &inode);
 	increment_version(&inode);
 
+	dbg_printf(ff, "%s: ino=%u mtime/ctime %ld:%lu\n",
+		   __func__, ino, now.tv_sec, now.tv_nsec);
+
 	err = fuse2fs_write_inode(fs, ino, &inode);
 	if (err)
 		return translate_error(fs, ino, err);
@@ -2222,7 +2247,7 @@ static int op_readlink(const char *path, char *buf, size_t len)
 	buf[len] = 0;
 
 	if (fuse2fs_is_writeable(ff)) {
-		ret = update_atime(fs, ino);
+		ret = fuse2fs_update_atime(ff, ino);
 		if (ret)
 			goto out;
 	}
@@ -2496,7 +2521,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 		goto out2;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse2fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -2519,7 +2544,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 	}
 
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse2fs_init_timestamps(ff, child, &inode);
 	err = fuse2fs_write_inode(fs, child, &inode);
 	if (err) {
 		ret = translate_error(fs, child, err);
@@ -2605,7 +2630,7 @@ static int op_mkdir(const char *path, mode_t mode)
 		goto out2;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse2fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -2632,7 +2657,7 @@ static int op_mkdir(const char *path, mode_t mode)
 	if (parent_sgid)
 		inode.i_mode |= S_ISGID;
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse2fs_init_timestamps(ff, child, &inode);
 
 	err = fuse2fs_write_inode(fs, child, &inode);
 	if (err) {
@@ -2715,7 +2740,7 @@ static int fuse2fs_unlink(struct fuse2fs *ff, const char *path,
 	if (err)
 		return translate_error(fs, dir, err);
 
-	ret = update_mtime(fs, dir, NULL);
+	ret = fuse2fs_update_mtime(ff, dir, NULL);
 	if (ret)
 		return ret;
 
@@ -2806,7 +2831,7 @@ static int remove_inode(struct fuse2fs *ff, ext2_ino_t ino)
 			ext2fs_set_dtime(fs, EXT2_INODE(&inode));
 	}
 
-	ret = update_ctime(fs, ino, &inode);
+	ret = fuse2fs_update_ctime(ff, ino, &inode);
 	if (ret)
 		return ret;
 
@@ -2976,7 +3001,7 @@ static int __op_rmdir(struct fuse2fs *ff, const char *path)
 			goto out;
 		}
 		ext2fs_dec_nlink(EXT2_INODE(&inode));
-		ret = update_mtime(fs, rds.parent, &inode);
+		ret = fuse2fs_update_mtime(ff, rds.parent, &inode);
 		if (ret)
 			goto out;
 		err = fuse2fs_write_inode(fs, rds.parent, &inode);
@@ -3073,7 +3098,7 @@ static int op_symlink(const char *src, const char *dest)
 	}
 
 	/* Update parent dir's mtime */
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse2fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -3097,7 +3122,7 @@ static int op_symlink(const char *src, const char *dest)
 	fuse2fs_set_uid(&inode, ctxt->uid);
 	fuse2fs_set_gid(&inode, gid);
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse2fs_init_timestamps(ff, child, &inode);
 
 	err = fuse2fs_write_inode(fs, child, &inode);
 	if (err) {
@@ -3382,11 +3407,11 @@ static int op_rename(const char *from, const char *to,
 	}
 
 	/* Update timestamps */
-	ret = update_ctime(fs, from_ino, NULL);
+	ret = fuse2fs_update_ctime(ff, from_ino, NULL);
 	if (ret)
 		goto out2;
 
-	ret = update_mtime(fs, to_dir_ino, NULL);
+	ret = fuse2fs_update_mtime(ff, to_dir_ino, NULL);
 	if (ret)
 		goto out2;
 
@@ -3480,7 +3505,7 @@ static int op_link(const char *src, const char *dest)
 	}
 
 	ext2fs_inc_nlink(fs, EXT2_INODE(&inode));
-	ret = update_ctime(fs, ino, &inode);
+	ret = fuse2fs_update_ctime(ff, ino, &inode);
 	if (ret)
 		goto out2;
 
@@ -3499,7 +3524,7 @@ static int op_link(const char *src, const char *dest)
 		goto out2;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse2fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -3647,7 +3672,7 @@ static int op_chmod(const char *path, mode_t mode, struct fuse_file_info *fi)
 
 	inode.i_mode = new_mode;
 
-	ret = update_ctime(fs, ino, &inode);
+	ret = fuse2fs_update_ctime(ff, ino, &inode);
 	if (ret)
 		goto out;
 
@@ -3714,7 +3739,7 @@ static int op_chown(const char *path, uid_t owner, gid_t group,
 		fuse2fs_set_gid(&inode, group);
 	}
 
-	ret = update_ctime(fs, ino, &inode);
+	ret = fuse2fs_update_ctime(ff, ino, &inode);
 	if (ret)
 		goto out;
 
@@ -3844,7 +3869,7 @@ static int fuse2fs_truncate(struct fuse2fs *ff, ext2_ino_t ino, off_t new_size)
 	if (err)
 		return translate_error(fs, ino, err);
 
-	ret = update_mtime(fs, ino, NULL);
+	ret = fuse2fs_update_mtime(ff, ino, NULL);
 	if (ret)
 		return ret;
 
@@ -4072,7 +4097,7 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
 	}
 
 	if (fh->check_flags != X_OK && fuse2fs_is_writeable(ff)) {
-		ret = update_atime(fs, fh->ino);
+		ret = fuse2fs_update_atime(ff, fh->ino);
 		if (ret)
 			goto out;
 	}
@@ -4156,7 +4181,7 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 		goto out;
 	}
 
-	ret = update_mtime(fs, fh->ino, NULL);
+	ret = fuse2fs_update_mtime(ff, fh->ino, NULL);
 	if (ret)
 		goto out;
 
@@ -4518,7 +4543,7 @@ static int op_setxattr(const char *path EXT2FS_ATTR((unused)),
 		goto out2;
 	}
 
-	ret = update_ctime(fs, ino, NULL);
+	ret = fuse2fs_update_ctime(ff, ino, NULL);
 out2:
 	err = ext2fs_xattrs_close(&h);
 	if (!ret && err)
@@ -4612,7 +4637,7 @@ static int op_removexattr(const char *path, const char *key)
 		goto out2;
 	}
 
-	ret = update_ctime(fs, ino, NULL);
+	ret = fuse2fs_update_ctime(ff, ino, NULL);
 out2:
 	err = ext2fs_xattrs_close(&h);
 	if (err && !ret)
@@ -4730,7 +4755,7 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)), void *buf,
 	}
 
 	if (fuse2fs_is_writeable(ff)) {
-		ret = update_atime(i.fs, fh->ino);
+		ret = fuse2fs_update_atime(ff, fh->ino);
 		if (ret)
 			goto out;
 	}
@@ -4835,7 +4860,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 		goto out2;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse2fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -4866,7 +4891,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 	}
 
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse2fs_init_timestamps(ff, child, &inode);
 	err = fuse2fs_write_inode(fs, child, &inode);
 	if (err) {
 		ret = translate_error(fs, child, err);
@@ -4950,7 +4975,7 @@ static int op_utimens(const char *path, const struct timespec ctv[2],
 	if (tv[1].tv_nsec != UTIME_OMIT)
 		EXT4_INODE_SET_XTIME(i_mtime, &tv[1], &inode);
 #endif /* UTIME_OMIT */
-	ret = update_ctime(fs, ino, &inode);
+	ret = fuse2fs_update_ctime(ff, ino, &inode);
 	if (ret)
 		goto out;
 
@@ -5018,7 +5043,7 @@ static int ioctl_setflags(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	if (ret)
 		return ret;
 
-	ret = update_ctime(fs, fh->ino, &inode);
+	ret = fuse2fs_update_ctime(ff, fh->ino, &inode);
 	if (ret)
 		return ret;
 
@@ -5065,7 +5090,7 @@ static int ioctl_setversion(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 
 	inode.i_generation = generation;
 
-	ret = update_ctime(fs, fh->ino, &inode);
+	ret = fuse2fs_update_ctime(ff, fh->ino, &inode);
 	if (ret)
 		return ret;
 
@@ -5196,7 +5221,7 @@ static int ioctl_fssetxattr(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	if (ext2fs_inode_includes(inode_size, i_projid))
 		inode.i_projid = fsx->fsx_projid;
 
-	ret = update_ctime(fs, fh->ino, &inode);
+	ret = fuse2fs_update_ctime(ff, fh->ino, &inode);
 	if (ret)
 		return ret;
 
@@ -5468,7 +5493,7 @@ static int fuse2fs_allocate_range(struct fuse2fs *ff,
 		}
 	}
 
-	err = update_mtime(fs, fh->ino, &inode);
+	err = fuse2fs_update_mtime(ff, fh->ino, &inode);
 	if (err)
 		return err;
 
@@ -5641,7 +5666,7 @@ static int fuse2fs_punch_range(struct fuse2fs *ff,
 			return translate_error(fs, fh->ino, err);
 	}
 
-	err = update_mtime(fs, fh->ino, &inode);
+	err = fuse2fs_update_mtime(ff, fh->ino, &inode);
 	if (err)
 		return err;
 


