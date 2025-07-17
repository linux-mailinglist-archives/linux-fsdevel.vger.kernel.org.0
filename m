Return-Path: <linux-fsdevel+bounces-55392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 005F1B0988D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3537D16FDF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B4924110F;
	Thu, 17 Jul 2025 23:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkN+nu++"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0622921018A;
	Thu, 17 Jul 2025 23:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752796002; cv=none; b=cjKcq2QIS8RfNbja78uKvXLNPqLPOaZSSKnFt+dpLG2AjgAaCvHmSS+YE26JiZtwr3uZb/14+uxOZV1tPaXMcQo+FW+3sZXvZ4kXR30EKY6SgUwl5nvQpYV1dfAIlf0HAIupBF18fvSr+BvGzSh2AGGNHAk5+iWeZ8cqRDpwplc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752796002; c=relaxed/simple;
	bh=NVYBv/OgbnMc0LWZ8UaScTbENU6iIjheHH1jH4EqJmM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MeITWCHArlo09Rt4zLs2awkuMqkhjlkrHpwQo/dDGY7MvdiEAuRLaQss+xW7HSn66/8r9I3rcB2kJ3hpg5nsU/6IO4+w4A+Oj788xJ2pjSgfrKT/CcrpNnsyC8KP/jaaq1Ehte1MmWDFJnfUEht0CuSFivv8lXj20Kh9iz3xQyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkN+nu++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3917C4CEE3;
	Thu, 17 Jul 2025 23:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752796001;
	bh=NVYBv/OgbnMc0LWZ8UaScTbENU6iIjheHH1jH4EqJmM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=VkN+nu++e96VP4fPozeHF9GUsfWBIhf36hrT7vDjkNW+L67hhhsG+ZUuJwIR2BWqU
	 XjoaXENxIaKi62GOnIqQr5dg1uSOT0xWW3dgzkRKN1+wfpmswOE0Bt3N5tlODcjDYk
	 r1mhES9axMdNIS7npUcG3jab7MVwrXjrjQea/d3owYwt6i5LLjMXD0KgPPd5neNTkt
	 W3Men4BCyTZ5usptSVWsPO0SxGj6CrEzp5Ya/2s+BDnK49tkB0gqdbnqyqCBn0mg4e
	 1wSZ7LXkDlAAJg+6ApD0fkxUHerv+2ZPgjV7PXSLdvJg1Tgd9u/GEliJEYkXOG4ecc
	 6i/SvmwoBe96A==
Date: Thu, 17 Jul 2025 16:46:41 -0700
Subject: [PATCH 05/10] fuse2fs: debug timestamp updates
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461810.716436.1763004745075206966.stgit@frogsfrogsfrogs>
In-Reply-To: <175279461680.716436.11923939115339176158.stgit@frogsfrogsfrogs>
References: <175279461680.716436.11923939115339176158.stgit@frogsfrogsfrogs>
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
index f2cb44a4e53b4c..ddc647f32c5df6 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -599,7 +599,8 @@ static void increment_version(struct ext2_inode_large *inode)
 		inode->i_version_hi = ver >> 32;
 }
 
-static void init_times(struct ext2_inode_large *inode)
+static void fuse2fs_init_timestamps(struct fuse2fs *ff, ext2_ino_t ino,
+				    struct ext2_inode_large *inode)
 {
 	struct timespec now;
 
@@ -609,11 +610,15 @@ static void init_times(struct ext2_inode_large *inode)
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
@@ -624,6 +629,10 @@ static int update_ctime(ext2_filsys fs, ext2_ino_t ino,
 	if (pinode) {
 		increment_version(pinode);
 		EXT4_INODE_SET_XTIME(i_ctime, &now, pinode);
+
+		dbg_printf(ff, "%s: ino=%u ctime %ld:%lu\n", __func__, ino,
+			   now.tv_sec, now.tv_nsec);
+
 		return 0;
 	}
 
@@ -635,6 +644,9 @@ static int update_ctime(ext2_filsys fs, ext2_ino_t ino,
 	increment_version(&inode);
 	EXT4_INODE_SET_XTIME(i_ctime, &now, &inode);
 
+	dbg_printf(ff, "%s: ino=%u ctime %ld:%lu\n", __func__, ino,
+		   now.tv_sec, now.tv_nsec);
+
 	err = fuse2fs_write_inode(fs, ino, &inode);
 	if (err)
 		return translate_error(fs, ino, err);
@@ -642,8 +654,9 @@ static int update_ctime(ext2_filsys fs, ext2_ino_t ino,
 	return 0;
 }
 
-static int update_atime(ext2_filsys fs, ext2_ino_t ino)
+static int fuse2fs_update_atime(struct fuse2fs *ff, ext2_ino_t ino)
 {
+	ext2_filsys fs = ff->fs;
 	errcode_t err;
 	struct ext2_inode_large inode, *pinode;
 	struct timespec atime, mtime, now;
@@ -662,6 +675,10 @@ static int update_atime(ext2_filsys fs, ext2_ino_t ino)
 	dmtime = mtime.tv_sec + ((double)mtime.tv_nsec / NSEC_PER_SEC);
 	dnow = now.tv_sec + ((double)now.tv_nsec / NSEC_PER_SEC);
 
+	dbg_printf(ff, "%s: ino=%u atime %ld:%lu mtime %ld:%lu now %ld:%lu\n",
+		   __func__, ino, atime.tv_sec, atime.tv_nsec, mtime.tv_sec,
+		   mtime.tv_nsec, now.tv_sec, now.tv_nsec);
+
 	/*
 	 * If atime is newer than mtime and atime hasn't been updated in thirty
 	 * seconds, skip the atime update.  Same idea as Linux "relatime".  Use
@@ -678,9 +695,10 @@ static int update_atime(ext2_filsys fs, ext2_ino_t ino)
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
@@ -690,6 +708,10 @@ static int update_mtime(ext2_filsys fs, ext2_ino_t ino,
 		EXT4_INODE_SET_XTIME(i_mtime, &now, pinode);
 		EXT4_INODE_SET_XTIME(i_ctime, &now, pinode);
 		increment_version(pinode);
+
+		dbg_printf(ff, "%s: ino=%u mtime/ctime %ld:%lu\n",
+			   __func__, ino, now.tv_sec, now.tv_nsec);
+
 		return 0;
 	}
 
@@ -702,6 +724,9 @@ static int update_mtime(ext2_filsys fs, ext2_ino_t ino,
 	EXT4_INODE_SET_XTIME(i_ctime, &now, &inode);
 	increment_version(&inode);
 
+	dbg_printf(ff, "%s: ino=%u mtime/ctime %ld:%lu\n",
+		   __func__, ino, now.tv_sec, now.tv_nsec);
+
 	err = fuse2fs_write_inode(fs, ino, &inode);
 	if (err)
 		return translate_error(fs, ino, err);
@@ -1660,7 +1685,7 @@ static int op_readlink(const char *path, char *buf, size_t len)
 	buf[len] = 0;
 
 	if (fuse2fs_is_writeable(ff)) {
-		ret = update_atime(fs, ino);
+		ret = fuse2fs_update_atime(ff, ino);
 		if (ret)
 			goto out;
 	}
@@ -1927,7 +1952,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 		goto out2;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse2fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -1950,7 +1975,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 	}
 
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse2fs_init_timestamps(ff, child, &inode);
 	err = fuse2fs_write_inode(fs, child, &inode);
 	if (err) {
 		ret = translate_error(fs, child, err);
@@ -2036,7 +2061,7 @@ static int op_mkdir(const char *path, mode_t mode)
 		goto out2;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse2fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -2063,7 +2088,7 @@ static int op_mkdir(const char *path, mode_t mode)
 	if (parent_sgid)
 		inode.i_mode |= S_ISGID;
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse2fs_init_timestamps(ff, child, &inode);
 
 	err = fuse2fs_write_inode(fs, child, &inode);
 	if (err) {
@@ -2146,7 +2171,7 @@ static int fuse2fs_unlink(struct fuse2fs *ff, const char *path,
 	if (err)
 		return translate_error(fs, dir, err);
 
-	ret = update_mtime(fs, dir, NULL);
+	ret = fuse2fs_update_mtime(ff, dir, NULL);
 	if (ret)
 		return ret;
 
@@ -2215,7 +2240,7 @@ static int remove_inode(struct fuse2fs *ff, ext2_ino_t ino)
 		inode.i_links_count--;
 	}
 
-	ret = update_ctime(fs, ino, &inode);
+	ret = fuse2fs_update_ctime(ff, ino, &inode);
 	if (ret)
 		goto out;
 
@@ -2394,7 +2419,7 @@ static int __op_rmdir(struct fuse2fs *ff, const char *path)
 		}
 		if (inode.i_links_count > 1)
 			inode.i_links_count--;
-		ret = update_mtime(fs, rds.parent, &inode);
+		ret = fuse2fs_update_mtime(ff, rds.parent, &inode);
 		if (ret)
 			goto out;
 		err = fuse2fs_write_inode(fs, rds.parent, &inode);
@@ -2488,7 +2513,7 @@ static int op_symlink(const char *src, const char *dest)
 	}
 
 	/* Update parent dir's mtime */
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse2fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -2512,7 +2537,7 @@ static int op_symlink(const char *src, const char *dest)
 	fuse2fs_set_uid(&inode, ctxt->uid);
 	fuse2fs_set_gid(&inode, gid);
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse2fs_init_timestamps(ff, child, &inode);
 
 	err = fuse2fs_write_inode(fs, child, &inode);
 	if (err) {
@@ -2762,11 +2787,11 @@ static int op_rename(const char *from, const char *to
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
 
@@ -2860,7 +2885,7 @@ static int op_link(const char *src, const char *dest)
 		goto out2;
 
 	inode.i_links_count++;
-	ret = update_ctime(fs, ino, &inode);
+	ret = fuse2fs_update_ctime(ff, ino, &inode);
 	if (ret)
 		goto out2;
 
@@ -2879,7 +2904,7 @@ static int op_link(const char *src, const char *dest)
 		goto out2;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse2fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -3016,7 +3041,7 @@ static int op_chmod(const char *path, mode_t mode
 
 	inode.i_mode = new_mode;
 
-	ret = update_ctime(fs, ino, &inode);
+	ret = fuse2fs_update_ctime(ff, ino, &inode);
 	if (ret)
 		goto out;
 
@@ -3086,7 +3111,7 @@ static int op_chown(const char *path, uid_t owner, gid_t group
 		fuse2fs_set_gid(&inode, group);
 	}
 
-	ret = update_ctime(fs, ino, &inode);
+	ret = fuse2fs_update_ctime(ff, ino, &inode);
 	if (ret)
 		goto out;
 
@@ -3159,7 +3184,7 @@ static int truncate_helper(struct fuse2fs *ff, ext2_ino_t ino, off_t new_size)
 	if (err)
 		return translate_error(fs, ino, err);
 
-	ret = update_mtime(fs, ino, NULL);
+	ret = fuse2fs_update_mtime(ff, ino, NULL);
 	if (ret)
 		return ret;
 
@@ -3378,7 +3403,7 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
 	}
 
 	if (fuse2fs_is_writeable(ff)) {
-		ret = update_atime(fs, fh->ino);
+		ret = fuse2fs_update_atime(ff, fh->ino);
 		if (ret)
 			goto out;
 	}
@@ -3464,7 +3489,7 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 		goto out;
 	}
 
-	ret = update_mtime(fs, fh->ino, NULL);
+	ret = fuse2fs_update_mtime(ff, fh->ino, NULL);
 	if (ret)
 		goto out;
 
@@ -3834,7 +3859,7 @@ static int op_setxattr(const char *path EXT2FS_ATTR((unused)),
 		goto out2;
 	}
 
-	ret = update_ctime(fs, ino, NULL);
+	ret = fuse2fs_update_ctime(ff, ino, NULL);
 out2:
 	err = ext2fs_xattrs_close(&h);
 	if (!ret && err)
@@ -3929,7 +3954,7 @@ static int op_removexattr(const char *path, const char *key)
 		goto out2;
 	}
 
-	ret = update_ctime(fs, ino, NULL);
+	ret = fuse2fs_update_ctime(ff, ino, NULL);
 out2:
 	err = ext2fs_xattrs_close(&h);
 	if (err && !ret)
@@ -4067,7 +4092,7 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 	}
 
 	if (fuse2fs_is_writeable(ff)) {
-		ret = update_atime(i.fs, fh->ino);
+		ret = fuse2fs_update_atime(ff, fh->ino);
 		if (ret)
 			goto out;
 	}
@@ -4173,7 +4198,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 		goto out2;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse2fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -4204,7 +4229,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 	}
 
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse2fs_init_timestamps(ff, child, &inode);
 	err = fuse2fs_write_inode(fs, child, &inode);
 	if (err) {
 		ret = translate_error(fs, child, err);
@@ -4277,7 +4302,7 @@ static int op_ftruncate(const char *path EXT2FS_ATTR((unused)),
 		goto out;
 	}
 
-	ret = update_mtime(fs, fh->ino, NULL);
+	ret = fuse2fs_update_mtime(ff, fh->ino, NULL);
 	if (ret)
 		goto out;
 
@@ -4365,7 +4390,7 @@ static int op_utimens(const char *path, const struct timespec ctv[2]
 	if (tv[1].tv_nsec != UTIME_OMIT)
 		EXT4_INODE_SET_XTIME(i_mtime, &tv[1], &inode);
 #endif /* UTIME_OMIT */
-	ret = update_ctime(fs, ino, &inode);
+	ret = fuse2fs_update_ctime(ff, ino, &inode);
 	if (ret)
 		goto out;
 
@@ -4433,7 +4458,7 @@ static int ioctl_setflags(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	if (ret)
 		return ret;
 
-	ret = update_ctime(fs, fh->ino, &inode);
+	ret = fuse2fs_update_ctime(ff, fh->ino, &inode);
 	if (ret)
 		return ret;
 
@@ -4480,7 +4505,7 @@ static int ioctl_setversion(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 
 	inode.i_generation = generation;
 
-	ret = update_ctime(fs, fh->ino, &inode);
+	ret = fuse2fs_update_ctime(ff, fh->ino, &inode);
 	if (ret)
 		return ret;
 
@@ -4585,7 +4610,7 @@ static int ioctl_fssetxattr(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	if (ext2fs_inode_includes(inode_size, i_projid))
 		inode.i_projid = fsx->fsx_projid;
 
-	ret = update_ctime(fs, fh->ino, &inode);
+	ret = fuse2fs_update_ctime(ff, fh->ino, &inode);
 	if (ret)
 		return ret;
 
@@ -4832,7 +4857,7 @@ static int fuse2fs_allocate_range(struct fuse2fs *ff,
 		}
 	}
 
-	err = update_mtime(fs, fh->ino, &inode);
+	err = fuse2fs_update_mtime(ff, fh->ino, &inode);
 	if (err)
 		return err;
 
@@ -4986,7 +5011,7 @@ static int fuse2fs_punch_range(struct fuse2fs *ff,
 			return translate_error(fs, fh->ino, err);
 	}
 
-	err = update_mtime(fs, fh->ino, &inode);
+	err = fuse2fs_update_mtime(ff, fh->ino, &inode);
 	if (err)
 		return err;
 


