Return-Path: <linux-fsdevel+bounces-61645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19204B58A9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA652173A7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C701D63CD;
	Tue, 16 Sep 2025 01:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXvmogml"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E3F38DDB;
	Tue, 16 Sep 2025 01:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984685; cv=none; b=oV3RayslIH2ijLcWriMcgiOgiRf0OSd/A7tFwONTrjXJcrBbUoc+71BiZXbsxGEDoD2GYzgwdIgNQg4QRjxiH+yQAOAYjhqU88MGQtAT+d0YvwXKTU8AmLGYe5GTKGVKmlov8SVUO9o3gWPvTNkp6VYWu9oQF/xG1woLckoUYQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984685; c=relaxed/simple;
	bh=8C3J0k8S1dbH8Kt9Q+BgqDI2goxLNycVnvoyjM2uxVA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g4f/pB7hxA9VvqCc83xtdOYbojnWZU+lxU4WC92tlpPYyVG0FnAaAaMguX+mOFxg9pJvudrVMkQ8tUtWW8qr3pXdgNM19lGKaximu5mTwH0cRlncZSM6PaoDNhPIQziCClF+vIW37imcn/ctKWVf9728tReoCjui6vpVz1UxYK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXvmogml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF5FC4CEF1;
	Tue, 16 Sep 2025 01:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984685;
	bh=8C3J0k8S1dbH8Kt9Q+BgqDI2goxLNycVnvoyjM2uxVA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=AXvmogmlIKFV1C6epnu6Fwly3Oa/LtueMsstyviGVsZyTYW9DK4BPhPxXmhxVj1+x
	 npQ5RD304sd0GXj64jbhyd4WOtmfBi6TQtUZjSvgmbnJrfVbWfwvOjuylWJWJ3xteQ
	 yx10qZc//XdZw/+uelkL0xJ1Lw5oxieHLLQmmuh6ZpEkRNXg6otecjrOX9EyoJ5uTN
	 w+3onJbOo6k0BpVX1GmSaigSAkN0cmOb3EgQuDl9/LSrO/ir/aQVyfT/fYrE0ln/yg
	 XlPbyLWuKTOHMCouUKdb8V7VGRGz3LyN/bRGVo6Fmf6FvH3B7Qfz3BkKEMRkBMtj64
	 4X7qQCVfoxPlA==
Date: Mon, 15 Sep 2025 18:04:44 -0700
Subject: [PATCH 05/10] fuse2fs: debug timestamp updates
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798162430.391272.2799083764274258064.stgit@frogsfrogsfrogs>
In-Reply-To: <175798162297.391272.17812368866586383182.stgit@frogsfrogsfrogs>
References: <175798162297.391272.17812368866586383182.stgit@frogsfrogsfrogs>
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
index 53adf8542e2f42..aedd1add48db82 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -686,7 +686,8 @@ static void increment_version(struct ext2_inode_large *inode)
 		inode->i_version_hi = ver >> 32;
 }
 
-static void init_times(struct ext2_inode_large *inode)
+static void fuse2fs_init_timestamps(struct fuse2fs *ff, ext2_ino_t ino,
+				    struct ext2_inode_large *inode)
 {
 	struct timespec now;
 
@@ -696,11 +697,15 @@ static void init_times(struct ext2_inode_large *inode)
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
@@ -711,6 +716,10 @@ static int update_ctime(ext2_filsys fs, ext2_ino_t ino,
 	if (pinode) {
 		increment_version(pinode);
 		EXT4_INODE_SET_XTIME(i_ctime, &now, pinode);
+
+		dbg_printf(ff, "%s: ino=%u ctime %ld:%lu\n", __func__, ino,
+			   now.tv_sec, now.tv_nsec);
+
 		return 0;
 	}
 
@@ -722,6 +731,9 @@ static int update_ctime(ext2_filsys fs, ext2_ino_t ino,
 	increment_version(&inode);
 	EXT4_INODE_SET_XTIME(i_ctime, &now, &inode);
 
+	dbg_printf(ff, "%s: ino=%u ctime %ld:%lu\n", __func__, ino,
+		   now.tv_sec, now.tv_nsec);
+
 	err = fuse2fs_write_inode(fs, ino, &inode);
 	if (err)
 		return translate_error(fs, ino, err);
@@ -729,8 +741,9 @@ static int update_ctime(ext2_filsys fs, ext2_ino_t ino,
 	return 0;
 }
 
-static int update_atime(ext2_filsys fs, ext2_ino_t ino)
+static int fuse2fs_update_atime(struct fuse2fs *ff, ext2_ino_t ino)
 {
+	ext2_filsys fs = ff->fs;
 	errcode_t err;
 	struct ext2_inode_large inode, *pinode;
 	struct timespec atime, mtime, now;
@@ -749,6 +762,10 @@ static int update_atime(ext2_filsys fs, ext2_ino_t ino)
 	dmtime = mtime.tv_sec + ((double)mtime.tv_nsec / NSEC_PER_SEC);
 	dnow = now.tv_sec + ((double)now.tv_nsec / NSEC_PER_SEC);
 
+	dbg_printf(ff, "%s: ino=%u atime %ld:%lu mtime %ld:%lu now %ld:%lu\n",
+		   __func__, ino, atime.tv_sec, atime.tv_nsec, mtime.tv_sec,
+		   mtime.tv_nsec, now.tv_sec, now.tv_nsec);
+
 	/*
 	 * If atime is newer than mtime and atime hasn't been updated in thirty
 	 * seconds, skip the atime update.  Same idea as Linux "relatime".  Use
@@ -765,9 +782,10 @@ static int update_atime(ext2_filsys fs, ext2_ino_t ino)
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
@@ -777,6 +795,10 @@ static int update_mtime(ext2_filsys fs, ext2_ino_t ino,
 		EXT4_INODE_SET_XTIME(i_mtime, &now, pinode);
 		EXT4_INODE_SET_XTIME(i_ctime, &now, pinode);
 		increment_version(pinode);
+
+		dbg_printf(ff, "%s: ino=%u mtime/ctime %ld:%lu\n",
+			   __func__, ino, now.tv_sec, now.tv_nsec);
+
 		return 0;
 	}
 
@@ -789,6 +811,9 @@ static int update_mtime(ext2_filsys fs, ext2_ino_t ino,
 	EXT4_INODE_SET_XTIME(i_ctime, &now, &inode);
 	increment_version(&inode);
 
+	dbg_printf(ff, "%s: ino=%u mtime/ctime %ld:%lu\n",
+		   __func__, ino, now.tv_sec, now.tv_nsec);
+
 	err = fuse2fs_write_inode(fs, ino, &inode);
 	if (err)
 		return translate_error(fs, ino, err);
@@ -1858,7 +1883,7 @@ static int op_readlink(const char *path, char *buf, size_t len)
 	buf[len] = 0;
 
 	if (fuse2fs_is_writeable(ff)) {
-		ret = update_atime(fs, ino);
+		ret = fuse2fs_update_atime(ff, ino);
 		if (ret)
 			goto out;
 	}
@@ -2132,7 +2157,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 		goto out2;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse2fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -2155,7 +2180,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 	}
 
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse2fs_init_timestamps(ff, child, &inode);
 	err = fuse2fs_write_inode(fs, child, &inode);
 	if (err) {
 		ret = translate_error(fs, child, err);
@@ -2241,7 +2266,7 @@ static int op_mkdir(const char *path, mode_t mode)
 		goto out2;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse2fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -2268,7 +2293,7 @@ static int op_mkdir(const char *path, mode_t mode)
 	if (parent_sgid)
 		inode.i_mode |= S_ISGID;
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse2fs_init_timestamps(ff, child, &inode);
 
 	err = fuse2fs_write_inode(fs, child, &inode);
 	if (err) {
@@ -2351,7 +2376,7 @@ static int fuse2fs_unlink(struct fuse2fs *ff, const char *path,
 	if (err)
 		return translate_error(fs, dir, err);
 
-	ret = update_mtime(fs, dir, NULL);
+	ret = fuse2fs_update_mtime(ff, dir, NULL);
 	if (ret)
 		return ret;
 
@@ -2430,7 +2455,7 @@ static int remove_inode(struct fuse2fs *ff, ext2_ino_t ino)
 		inode.i_links_count--;
 	}
 
-	ret = update_ctime(fs, ino, &inode);
+	ret = fuse2fs_update_ctime(ff, ino, &inode);
 	if (ret)
 		return ret;
 
@@ -2604,7 +2629,7 @@ static int __op_rmdir(struct fuse2fs *ff, const char *path)
 		}
 		if (inode.i_links_count > 1)
 			inode.i_links_count--;
-		ret = update_mtime(fs, rds.parent, &inode);
+		ret = fuse2fs_update_mtime(ff, rds.parent, &inode);
 		if (ret)
 			goto out;
 		err = fuse2fs_write_inode(fs, rds.parent, &inode);
@@ -2701,7 +2726,7 @@ static int op_symlink(const char *src, const char *dest)
 	}
 
 	/* Update parent dir's mtime */
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse2fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -2725,7 +2750,7 @@ static int op_symlink(const char *src, const char *dest)
 	fuse2fs_set_uid(&inode, ctxt->uid);
 	fuse2fs_set_gid(&inode, gid);
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse2fs_init_timestamps(ff, child, &inode);
 
 	err = fuse2fs_write_inode(fs, child, &inode);
 	if (err) {
@@ -2970,11 +2995,11 @@ static int op_rename(const char *from, const char *to,
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
 
@@ -3063,7 +3088,7 @@ static int op_link(const char *src, const char *dest)
 		goto out2;
 
 	inode.i_links_count++;
-	ret = update_ctime(fs, ino, &inode);
+	ret = fuse2fs_update_ctime(ff, ino, &inode);
 	if (ret)
 		goto out2;
 
@@ -3082,7 +3107,7 @@ static int op_link(const char *src, const char *dest)
 		goto out2;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse2fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -3230,7 +3255,7 @@ static int op_chmod(const char *path, mode_t mode, struct fuse_file_info *fi)
 
 	inode.i_mode = new_mode;
 
-	ret = update_ctime(fs, ino, &inode);
+	ret = fuse2fs_update_ctime(ff, ino, &inode);
 	if (ret)
 		goto out;
 
@@ -3297,7 +3322,7 @@ static int op_chown(const char *path, uid_t owner, gid_t group,
 		fuse2fs_set_gid(&inode, group);
 	}
 
-	ret = update_ctime(fs, ino, &inode);
+	ret = fuse2fs_update_ctime(ff, ino, &inode);
 	if (ret)
 		goto out;
 
@@ -3427,7 +3452,7 @@ static int fuse2fs_truncate(struct fuse2fs *ff, ext2_ino_t ino, off_t new_size)
 	if (err)
 		return translate_error(fs, ino, err);
 
-	ret = update_mtime(fs, ino, NULL);
+	ret = fuse2fs_update_mtime(ff, ino, NULL);
 	if (ret)
 		return ret;
 
@@ -3655,7 +3680,7 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
 	}
 
 	if (fh->check_flags != X_OK && fuse2fs_is_writeable(ff)) {
-		ret = update_atime(fs, fh->ino);
+		ret = fuse2fs_update_atime(ff, fh->ino);
 		if (ret)
 			goto out;
 	}
@@ -3739,7 +3764,7 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 		goto out;
 	}
 
-	ret = update_mtime(fs, fh->ino, NULL);
+	ret = fuse2fs_update_mtime(ff, fh->ino, NULL);
 	if (ret)
 		goto out;
 
@@ -4101,7 +4126,7 @@ static int op_setxattr(const char *path EXT2FS_ATTR((unused)),
 		goto out2;
 	}
 
-	ret = update_ctime(fs, ino, NULL);
+	ret = fuse2fs_update_ctime(ff, ino, NULL);
 out2:
 	err = ext2fs_xattrs_close(&h);
 	if (!ret && err)
@@ -4195,7 +4220,7 @@ static int op_removexattr(const char *path, const char *key)
 		goto out2;
 	}
 
-	ret = update_ctime(fs, ino, NULL);
+	ret = fuse2fs_update_ctime(ff, ino, NULL);
 out2:
 	err = ext2fs_xattrs_close(&h);
 	if (err && !ret)
@@ -4313,7 +4338,7 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)), void *buf,
 	}
 
 	if (fuse2fs_is_writeable(ff)) {
-		ret = update_atime(i.fs, fh->ino);
+		ret = fuse2fs_update_atime(ff, fh->ino);
 		if (ret)
 			goto out;
 	}
@@ -4418,7 +4443,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 		goto out2;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse2fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -4449,7 +4474,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 	}
 
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse2fs_init_timestamps(ff, child, &inode);
 	err = fuse2fs_write_inode(fs, child, &inode);
 	if (err) {
 		ret = translate_error(fs, child, err);
@@ -4533,7 +4558,7 @@ static int op_utimens(const char *path, const struct timespec ctv[2],
 	if (tv[1].tv_nsec != UTIME_OMIT)
 		EXT4_INODE_SET_XTIME(i_mtime, &tv[1], &inode);
 #endif /* UTIME_OMIT */
-	ret = update_ctime(fs, ino, &inode);
+	ret = fuse2fs_update_ctime(ff, ino, &inode);
 	if (ret)
 		goto out;
 
@@ -4601,7 +4626,7 @@ static int ioctl_setflags(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	if (ret)
 		return ret;
 
-	ret = update_ctime(fs, fh->ino, &inode);
+	ret = fuse2fs_update_ctime(ff, fh->ino, &inode);
 	if (ret)
 		return ret;
 
@@ -4648,7 +4673,7 @@ static int ioctl_setversion(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 
 	inode.i_generation = generation;
 
-	ret = update_ctime(fs, fh->ino, &inode);
+	ret = fuse2fs_update_ctime(ff, fh->ino, &inode);
 	if (ret)
 		return ret;
 
@@ -4779,7 +4804,7 @@ static int ioctl_fssetxattr(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	if (ext2fs_inode_includes(inode_size, i_projid))
 		inode.i_projid = fsx->fsx_projid;
 
-	ret = update_ctime(fs, fh->ino, &inode);
+	ret = fuse2fs_update_ctime(ff, fh->ino, &inode);
 	if (ret)
 		return ret;
 
@@ -5048,7 +5073,7 @@ static int fuse2fs_allocate_range(struct fuse2fs *ff,
 		}
 	}
 
-	err = update_mtime(fs, fh->ino, &inode);
+	err = fuse2fs_update_mtime(ff, fh->ino, &inode);
 	if (err)
 		return err;
 
@@ -5221,7 +5246,7 @@ static int fuse2fs_punch_range(struct fuse2fs *ff,
 			return translate_error(fs, fh->ino, err);
 	}
 
-	err = update_mtime(fs, fh->ino, &inode);
+	err = fuse2fs_update_mtime(ff, fh->ino, &inode);
 	if (err)
 		return err;
 


