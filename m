Return-Path: <linux-fsdevel+bounces-58555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 683D7B2EA90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E54D3B4305
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A98211A35;
	Thu, 21 Aug 2025 01:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2/u6oGF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAE4204F99;
	Thu, 21 Aug 2025 01:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739334; cv=none; b=J/Pbo17NuhiynuJHXCQ/pojUwP5qvsKjLT21VB9iZ4/KpXQV5fPxsmZpa0DptEzqrnZ55scPkT1coKW/3WaVszvSizid6BddGMLgO/lE0DQZr2hriM4b5k4jSgfuvxmKYiSb1NXHGXEmr1MqcEltrYfzM4TagQ+ZV8y28dBD3e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739334; c=relaxed/simple;
	bh=v6hAuTJT7gqOb7Ctf5xQy10jltzAxQuc6GkxzlLrgp8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LqQOoS6762gwFRZZPl6RzzNi8YR4lmm5heG+DQ2W5LwgWoGuM4NwiVPcBZ3Kg10+yYF+wcS0rgZEwXmQGJ/+XJymLeemA0k7dPQzglbMSwkKdKYuy9das1XyoLMICsU0q4Tj8HE5+hPsJZpgbMdaWm5pSxNw4NBo1B7krF0p2BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2/u6oGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B4FC4CEE7;
	Thu, 21 Aug 2025 01:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755739333;
	bh=v6hAuTJT7gqOb7Ctf5xQy10jltzAxQuc6GkxzlLrgp8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=U2/u6oGFyz0x83j1LxbEz7P8FSxvN/ujnQVgW11W1GgVZXUhXhiB0hSwZbNvljPuR
	 fZzq6jteXYc4Wq17vJYvfYfhn/uO9yNnB4sFChjhoRTYlwiKBKaPqRrlUfCxDjxok7
	 lQaYsmYx0OTFvlyqdDXlx1AuEpWJTXnvMTfaBI/UmJkbLhC2WZ688dG4Kx5UMonK+P
	 Y1oi/i0DJWF94VrIZN/RJ45abcbLU3n38xMLb51AhMo8lZ05ho/icR8i+Io5Eoqh8i
	 woayaCI4Hz0bTeyQFTW+j6aLf10jJMh6Awa2bPKR2RSu9fbLgp4pVeFP/wPvCC1A79
	 piiDzwE2yaSkg==
Date: Wed, 20 Aug 2025 18:22:13 -0700
Subject: [PATCH 4/8] fuse2fs: debug timestamp updates
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573714464.22854.6057932667823312007.stgit@frogsfrogsfrogs>
In-Reply-To: <175573714359.22854.5198450217393478706.stgit@frogsfrogsfrogs>
References: <175573714359.22854.5198450217393478706.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |   99 +++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 62 insertions(+), 37 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 44f76e9bed5f42..fe7d6a2568dcf0 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -693,7 +693,8 @@ static void increment_version(struct ext2_inode_large *inode)
 		inode->i_version_hi = ver >> 32;
 }
 
-static void init_times(struct ext2_inode_large *inode)
+static void fuse2fs_init_timestamps(struct fuse2fs *ff, ext2_ino_t ino,
+				    struct ext2_inode_large *inode)
 {
 	struct timespec now;
 
@@ -703,11 +704,15 @@ static void init_times(struct ext2_inode_large *inode)
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
@@ -718,6 +723,10 @@ static int update_ctime(ext2_filsys fs, ext2_ino_t ino,
 	if (pinode) {
 		increment_version(pinode);
 		EXT4_INODE_SET_XTIME(i_ctime, &now, pinode);
+
+		dbg_printf(ff, "%s: ino=%u ctime %ld:%lu\n", __func__, ino,
+			   now.tv_sec, now.tv_nsec);
+
 		return 0;
 	}
 
@@ -729,6 +738,9 @@ static int update_ctime(ext2_filsys fs, ext2_ino_t ino,
 	increment_version(&inode);
 	EXT4_INODE_SET_XTIME(i_ctime, &now, &inode);
 
+	dbg_printf(ff, "%s: ino=%u ctime %ld:%lu\n", __func__, ino,
+		   now.tv_sec, now.tv_nsec);
+
 	err = fuse2fs_write_inode(fs, ino, &inode);
 	if (err)
 		return translate_error(fs, ino, err);
@@ -736,8 +748,9 @@ static int update_ctime(ext2_filsys fs, ext2_ino_t ino,
 	return 0;
 }
 
-static int update_atime(ext2_filsys fs, ext2_ino_t ino)
+static int fuse2fs_update_atime(struct fuse2fs *ff, ext2_ino_t ino)
 {
+	ext2_filsys fs = ff->fs;
 	errcode_t err;
 	struct ext2_inode_large inode, *pinode;
 	struct timespec atime, mtime, now;
@@ -756,6 +769,10 @@ static int update_atime(ext2_filsys fs, ext2_ino_t ino)
 	dmtime = mtime.tv_sec + ((double)mtime.tv_nsec / NSEC_PER_SEC);
 	dnow = now.tv_sec + ((double)now.tv_nsec / NSEC_PER_SEC);
 
+	dbg_printf(ff, "%s: ino=%u atime %ld:%lu mtime %ld:%lu now %ld:%lu\n",
+		   __func__, ino, atime.tv_sec, atime.tv_nsec, mtime.tv_sec,
+		   mtime.tv_nsec, now.tv_sec, now.tv_nsec);
+
 	/*
 	 * If atime is newer than mtime and atime hasn't been updated in thirty
 	 * seconds, skip the atime update.  Same idea as Linux "relatime".  Use
@@ -772,9 +789,10 @@ static int update_atime(ext2_filsys fs, ext2_ino_t ino)
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
@@ -784,6 +802,10 @@ static int update_mtime(ext2_filsys fs, ext2_ino_t ino,
 		EXT4_INODE_SET_XTIME(i_mtime, &now, pinode);
 		EXT4_INODE_SET_XTIME(i_ctime, &now, pinode);
 		increment_version(pinode);
+
+		dbg_printf(ff, "%s: ino=%u mtime/ctime %ld:%lu\n",
+			   __func__, ino, now.tv_sec, now.tv_nsec);
+
 		return 0;
 	}
 
@@ -796,6 +818,9 @@ static int update_mtime(ext2_filsys fs, ext2_ino_t ino,
 	EXT4_INODE_SET_XTIME(i_ctime, &now, &inode);
 	increment_version(&inode);
 
+	dbg_printf(ff, "%s: ino=%u mtime/ctime %ld:%lu\n",
+		   __func__, ino, now.tv_sec, now.tv_nsec);
+
 	err = fuse2fs_write_inode(fs, ino, &inode);
 	if (err)
 		return translate_error(fs, ino, err);
@@ -1860,7 +1885,7 @@ static int op_readlink(const char *path, char *buf, size_t len)
 	buf[len] = 0;
 
 	if (fuse2fs_is_writeable(ff)) {
-		ret = update_atime(fs, ino);
+		ret = fuse2fs_update_atime(ff, ino);
 		if (ret)
 			goto out;
 	}
@@ -2134,7 +2159,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 		goto out2;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse2fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -2157,7 +2182,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 	}
 
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse2fs_init_timestamps(ff, child, &inode);
 	err = fuse2fs_write_inode(fs, child, &inode);
 	if (err) {
 		ret = translate_error(fs, child, err);
@@ -2243,7 +2268,7 @@ static int op_mkdir(const char *path, mode_t mode)
 		goto out2;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse2fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -2270,7 +2295,7 @@ static int op_mkdir(const char *path, mode_t mode)
 	if (parent_sgid)
 		inode.i_mode |= S_ISGID;
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse2fs_init_timestamps(ff, child, &inode);
 
 	err = fuse2fs_write_inode(fs, child, &inode);
 	if (err) {
@@ -2353,7 +2378,7 @@ static int fuse2fs_unlink(struct fuse2fs *ff, const char *path,
 	if (err)
 		return translate_error(fs, dir, err);
 
-	ret = update_mtime(fs, dir, NULL);
+	ret = fuse2fs_update_mtime(ff, dir, NULL);
 	if (ret)
 		return ret;
 
@@ -2432,7 +2457,7 @@ static int remove_inode(struct fuse2fs *ff, ext2_ino_t ino)
 		inode.i_links_count--;
 	}
 
-	ret = update_ctime(fs, ino, &inode);
+	ret = fuse2fs_update_ctime(ff, ino, &inode);
 	if (ret)
 		return ret;
 
@@ -2606,7 +2631,7 @@ static int __op_rmdir(struct fuse2fs *ff, const char *path)
 		}
 		if (inode.i_links_count > 1)
 			inode.i_links_count--;
-		ret = update_mtime(fs, rds.parent, &inode);
+		ret = fuse2fs_update_mtime(ff, rds.parent, &inode);
 		if (ret)
 			goto out;
 		err = fuse2fs_write_inode(fs, rds.parent, &inode);
@@ -2699,7 +2724,7 @@ static int op_symlink(const char *src, const char *dest)
 	}
 
 	/* Update parent dir's mtime */
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse2fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -2723,7 +2748,7 @@ static int op_symlink(const char *src, const char *dest)
 	fuse2fs_set_uid(&inode, ctxt->uid);
 	fuse2fs_set_gid(&inode, gid);
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse2fs_init_timestamps(ff, child, &inode);
 
 	err = fuse2fs_write_inode(fs, child, &inode);
 	if (err) {
@@ -2973,11 +2998,11 @@ static int op_rename(const char *from, const char *to
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
 
@@ -3066,7 +3091,7 @@ static int op_link(const char *src, const char *dest)
 		goto out2;
 
 	inode.i_links_count++;
-	ret = update_ctime(fs, ino, &inode);
+	ret = fuse2fs_update_ctime(ff, ino, &inode);
 	if (ret)
 		goto out2;
 
@@ -3085,7 +3110,7 @@ static int op_link(const char *src, const char *dest)
 		goto out2;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse2fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -3241,7 +3266,7 @@ static int op_chmod(const char *path, mode_t mode
 
 	inode.i_mode = new_mode;
 
-	ret = update_ctime(fs, ino, &inode);
+	ret = fuse2fs_update_ctime(ff, ino, &inode);
 	if (ret)
 		goto out;
 
@@ -3311,7 +3336,7 @@ static int op_chown(const char *path, uid_t owner, gid_t group
 		fuse2fs_set_gid(&inode, group);
 	}
 
-	ret = update_ctime(fs, ino, &inode);
+	ret = fuse2fs_update_ctime(ff, ino, &inode);
 	if (ret)
 		goto out;
 
@@ -3441,7 +3466,7 @@ static int fuse2fs_truncate(struct fuse2fs *ff, ext2_ino_t ino, off_t new_size)
 	if (err)
 		return translate_error(fs, ino, err);
 
-	ret = update_mtime(fs, ino, NULL);
+	ret = fuse2fs_update_mtime(ff, ino, NULL);
 	if (ret)
 		return ret;
 
@@ -3671,7 +3696,7 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
 	}
 
 	if (fuse2fs_is_writeable(ff)) {
-		ret = update_atime(fs, fh->ino);
+		ret = fuse2fs_update_atime(ff, fh->ino);
 		if (ret)
 			goto out;
 	}
@@ -3755,7 +3780,7 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 		goto out;
 	}
 
-	ret = update_mtime(fs, fh->ino, NULL);
+	ret = fuse2fs_update_mtime(ff, fh->ino, NULL);
 	if (ret)
 		goto out;
 
@@ -4117,7 +4142,7 @@ static int op_setxattr(const char *path EXT2FS_ATTR((unused)),
 		goto out2;
 	}
 
-	ret = update_ctime(fs, ino, NULL);
+	ret = fuse2fs_update_ctime(ff, ino, NULL);
 out2:
 	err = ext2fs_xattrs_close(&h);
 	if (!ret && err)
@@ -4211,7 +4236,7 @@ static int op_removexattr(const char *path, const char *key)
 		goto out2;
 	}
 
-	ret = update_ctime(fs, ino, NULL);
+	ret = fuse2fs_update_ctime(ff, ino, NULL);
 out2:
 	err = ext2fs_xattrs_close(&h);
 	if (err && !ret)
@@ -4348,7 +4373,7 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 	}
 
 	if (fuse2fs_is_writeable(ff)) {
-		ret = update_atime(i.fs, fh->ino);
+		ret = fuse2fs_update_atime(ff, fh->ino);
 		if (ret)
 			goto out;
 	}
@@ -4453,7 +4478,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 		goto out2;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse2fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -4484,7 +4509,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 	}
 
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse2fs_init_timestamps(ff, child, &inode);
 	err = fuse2fs_write_inode(fs, child, &inode);
 	if (err) {
 		ret = translate_error(fs, child, err);
@@ -4555,7 +4580,7 @@ static int op_ftruncate(const char *path EXT2FS_ATTR((unused)),
 		goto out;
 	}
 
-	ret = update_mtime(fs, fh->ino, NULL);
+	ret = fuse2fs_update_mtime(ff, fh->ino, NULL);
 	if (ret)
 		goto out;
 
@@ -4642,7 +4667,7 @@ static int op_utimens(const char *path, const struct timespec ctv[2]
 	if (tv[1].tv_nsec != UTIME_OMIT)
 		EXT4_INODE_SET_XTIME(i_mtime, &tv[1], &inode);
 #endif /* UTIME_OMIT */
-	ret = update_ctime(fs, ino, &inode);
+	ret = fuse2fs_update_ctime(ff, ino, &inode);
 	if (ret)
 		goto out;
 
@@ -4710,7 +4735,7 @@ static int ioctl_setflags(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	if (ret)
 		return ret;
 
-	ret = update_ctime(fs, fh->ino, &inode);
+	ret = fuse2fs_update_ctime(ff, fh->ino, &inode);
 	if (ret)
 		return ret;
 
@@ -4757,7 +4782,7 @@ static int ioctl_setversion(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 
 	inode.i_generation = generation;
 
-	ret = update_ctime(fs, fh->ino, &inode);
+	ret = fuse2fs_update_ctime(ff, fh->ino, &inode);
 	if (ret)
 		return ret;
 
@@ -4862,7 +4887,7 @@ static int ioctl_fssetxattr(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	if (ext2fs_inode_includes(inode_size, i_projid))
 		inode.i_projid = fsx->fsx_projid;
 
-	ret = update_ctime(fs, fh->ino, &inode);
+	ret = fuse2fs_update_ctime(ff, fh->ino, &inode);
 	if (ret)
 		return ret;
 
@@ -5130,7 +5155,7 @@ static int fuse2fs_allocate_range(struct fuse2fs *ff,
 		}
 	}
 
-	err = update_mtime(fs, fh->ino, &inode);
+	err = fuse2fs_update_mtime(ff, fh->ino, &inode);
 	if (err)
 		return err;
 
@@ -5303,7 +5328,7 @@ static int fuse2fs_punch_range(struct fuse2fs *ff,
 			return translate_error(fs, fh->ino, err);
 	}
 
-	err = update_mtime(fs, fh->ino, &inode);
+	err = fuse2fs_update_mtime(ff, fh->ino, &inode);
 	if (err)
 		return err;
 


