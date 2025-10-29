Return-Path: <linux-fsdevel+bounces-66117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DB2C17D1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 283564257D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE682DA762;
	Wed, 29 Oct 2025 01:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuoVuQ+U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A058B2D9EEA;
	Wed, 29 Oct 2025 01:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700497; cv=none; b=EXXF5CHpT1aOXcSVuNnrXDSEyx9AwaWEzAXoQojVvGn52D5swVxSIDT1yRLrkiywPmhu+jvouhCowemNT9YTuY6CrtcDSdZJKRKbf5VCD6trwO4JWg1MGMDCWGHTuU/DNMLnmclApl2EEGhg35EveY+JWV3r+ypKnhAHjbluyhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700497; c=relaxed/simple;
	bh=sMf6D2z633UWR6vZ9TBo2dC0KXCJ9+QLWwDc8Hqbd64=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qn2fkjP2KFoZSlWJOCPH/lxWQfoT0WM6cHnDo+/Dl9sy8bDBBAvOTJ3+tq/BEficmDTbONDgCkbIjP1cluKsa3KT5UZjCTGHIssTrc2Io34d5B/iZh+MVOCVA2kWkI0pUHigAiN8takmNDrE2RPjsb1Xai47+5CVgtAAy+sJaP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuoVuQ+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72096C4CEE7;
	Wed, 29 Oct 2025 01:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700497;
	bh=sMf6D2z633UWR6vZ9TBo2dC0KXCJ9+QLWwDc8Hqbd64=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=WuoVuQ+UNn7LmVK9vwwDkYo6BveyT2JPqs0GGPGaQaL+n2KzGDewBUH2iwFxanMtY
	 ZXOmlApe5Z/Xbdm9KsfQZ6T/mUY87XgAVwzO0bpeABfLN42CHHNMbql0ZFbv//mUpw
	 MYu0/2YQL/Ox08BOS6qVzVKE5dC2Pz7s1K5bVqRPa7+J5odT42cx0CE0MX54BA2e9m
	 BHTAXEfASnwa913rHbpbCAB2bTcf/9wZnYJK0GcDfiMlN7W1ih+Lkn4NK8cxD/3X9Y
	 MUxhSiCHHWdYd6V2ejTvWWCN4QbkporBHEqakXGW327X/QZTZR1bX98HTJ6MPaifyP
	 XYfMHRrV4oUOA==
Date: Tue, 28 Oct 2025 18:14:57 -0700
Subject: [PATCH 06/11] fuse2fs: use coarse timestamps for iomap mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169818331.1430380.10138568938764887209.stgit@frogsfrogsfrogs>
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

In iomap mode, the kernel is responsible for maintaining timestamps
because file writes don't upcall to fuse2fs.  The kernel's predicate for
deciding if [cm]time should be updated bases its decisions off [cm]time
being an exact match for the coarse clock (instead of checking that
[cm]time < coarse_clock) which means that fuse2fs setting a fine-grained
timestamp that is slightly ahead of the coarse clock can result in
timestamps appearing to go backwards.  generic/423 doesn't like seeing
btime > ctime from statx, so we'll use the coarse clock in iomap mode.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |  110 +++++++++++++++++++++++++++++++----------------------
 misc/fuse2fs.c    |   34 ++++++++++++----
 2 files changed, 90 insertions(+), 54 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 7570950ca2458d..cafee29991bff6 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -1004,8 +1004,24 @@ static inline void fuse4fs_dump_extents(struct fuse4fs *ff, ext2_ino_t ino,
 	ext2fs_extent_free(extents);
 }
 
-static void get_now(struct timespec *now)
+static void fuse4fs_get_now(struct fuse4fs *ff, struct timespec *now)
 {
+#ifdef CLOCK_REALTIME_COARSE
+	/*
+	 * In iomap mode, the kernel is responsible for maintaining timestamps
+	 * because file writes don't upcall to fuse4fs.  The kernel's predicate
+	 * for deciding if [cm]time should be updated bases its decisions off
+	 * [cm]time being an exact match for the coarse clock (instead of
+	 * checking that [cm]time < coarse_clock) which means that fuse4fs
+	 * setting a fine-grained timestamp that is slightly ahead of the
+	 * coarse clock can result in timestamps appearing to go backwards.
+	 * generic/423 doesn't like seeing btime > ctime from statx, so we'll
+	 * use the coarse clock in iomap mode.
+	 */
+	if (fuse4fs_iomap_enabled(ff) &&
+	    !clock_gettime(CLOCK_REALTIME_COARSE, now))
+		return;
+#endif
 #ifdef CLOCK_REALTIME
 	if (!clock_gettime(CLOCK_REALTIME, now))
 		return;
@@ -1028,11 +1044,12 @@ static void increment_version(struct ext2_inode_large *inode)
 		inode->i_version_hi = ver >> 32;
 }
 
-static void init_times(struct ext2_inode_large *inode)
+static void fuse4fs_init_timestamps(struct fuse4fs *ff,
+				    struct ext2_inode_large *inode)
 {
 	struct timespec now;
 
-	get_now(&now);
+	fuse4fs_get_now(ff, &now);
 	EXT4_INODE_SET_XTIME(i_atime, &now, inode);
 	EXT4_INODE_SET_XTIME(i_ctime, &now, inode);
 	EXT4_INODE_SET_XTIME(i_mtime, &now, inode);
@@ -1040,14 +1057,15 @@ static void init_times(struct ext2_inode_large *inode)
 	increment_version(inode);
 }
 
-static int update_ctime(ext2_filsys fs, ext2_ino_t ino,
-			struct ext2_inode_large *pinode)
+static int fuse4fs_update_ctime(struct fuse4fs *ff, ext2_ino_t ino,
+				struct ext2_inode_large *pinode)
 {
-	errcode_t err;
 	struct timespec now;
 	struct ext2_inode_large inode;
+	ext2_filsys fs = ff->fs;
+	errcode_t err;
 
-	get_now(&now);
+	fuse4fs_get_now(ff, &now);
 
 	/* If user already has a inode buffer, just update that */
 	if (pinode) {
@@ -1071,12 +1089,13 @@ static int update_ctime(ext2_filsys fs, ext2_ino_t ino,
 	return 0;
 }
 
-static int update_atime(ext2_filsys fs, ext2_ino_t ino)
+static int fuse4fs_update_atime(struct fuse4fs *ff, ext2_ino_t ino)
 {
-	errcode_t err;
 	struct ext2_inode_large inode, *pinode;
 	struct timespec atime, mtime, now;
+	ext2_filsys fs = ff->fs;
 	double datime, dmtime, dnow;
+	errcode_t err;
 
 	err = fuse4fs_read_inode(fs, ino, &inode);
 	if (err)
@@ -1085,7 +1104,7 @@ static int update_atime(ext2_filsys fs, ext2_ino_t ino)
 	pinode = &inode;
 	EXT4_INODE_GET_XTIME(i_atime, &atime, pinode);
 	EXT4_INODE_GET_XTIME(i_mtime, &mtime, pinode);
-	get_now(&now);
+	fuse4fs_get_now(ff, &now);
 
 	datime = atime.tv_sec + ((double)atime.tv_nsec / NSEC_PER_SEC);
 	dmtime = mtime.tv_sec + ((double)mtime.tv_nsec / NSEC_PER_SEC);
@@ -1107,15 +1126,16 @@ static int update_atime(ext2_filsys fs, ext2_ino_t ino)
 	return 0;
 }
 
-static int update_mtime(ext2_filsys fs, ext2_ino_t ino,
-			struct ext2_inode_large *pinode)
+static int fuse4fs_update_mtime(struct fuse4fs *ff, ext2_ino_t ino,
+				struct ext2_inode_large *pinode)
 {
-	errcode_t err;
 	struct ext2_inode_large inode;
 	struct timespec now;
+	ext2_filsys fs = ff->fs;
+	errcode_t err;
 
 	if (pinode) {
-		get_now(&now);
+		fuse4fs_get_now(ff, &now);
 		EXT4_INODE_SET_XTIME(i_mtime, &now, pinode);
 		EXT4_INODE_SET_XTIME(i_ctime, &now, pinode);
 		increment_version(pinode);
@@ -1126,7 +1146,7 @@ static int update_mtime(ext2_filsys fs, ext2_ino_t ino,
 	if (err)
 		return translate_error(fs, ino, err);
 
-	get_now(&now);
+	fuse4fs_get_now(ff, &now);
 	EXT4_INODE_SET_XTIME(i_mtime, &now, &inode);
 	EXT4_INODE_SET_XTIME(i_ctime, &now, &inode);
 	increment_version(&inode);
@@ -2416,7 +2436,7 @@ static void op_readlink(fuse_req_t req, fuse_ino_t fino)
 	buf[len] = 0;
 
 	if (fuse4fs_is_writeable(ff)) {
-		ret = update_atime(fs, ino);
+		ret = fuse4fs_update_atime(ff, ino);
 		if (ret)
 			goto out;
 	}
@@ -2685,7 +2705,7 @@ static void op_mknod(fuse_req_t req, fuse_ino_t fino, const char *name,
 		goto out2;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse4fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -2708,7 +2728,7 @@ static void op_mknod(fuse_req_t req, fuse_ino_t fino, const char *name,
 	}
 
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse4fs_init_timestamps(ff, &inode);
 	err = fuse4fs_write_inode(fs, child, &inode);
 	if (err) {
 		ret = translate_error(fs, child, err);
@@ -2770,7 +2790,7 @@ static void op_mkdir(fuse_req_t req, fuse_ino_t fino, const char *name,
 		goto out2;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse4fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -2796,7 +2816,7 @@ static void op_mkdir(fuse_req_t req, fuse_ino_t fino, const char *name,
 	if (parent_sgid)
 		inode.i_mode |= S_ISGID;
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse4fs_init_timestamps(ff, &inode);
 
 	err = fuse4fs_write_inode(fs, child, &inode);
 	if (err) {
@@ -3147,7 +3167,7 @@ static int fuse4fs_remove_inode(struct fuse4fs *ff, ext2_ino_t ino)
 		inode.i_links_count--;
 	}
 
-	ret = update_ctime(fs, ino, &inode);
+	ret = fuse4fs_update_ctime(ff, ino, &inode);
 	if (ret)
 		return ret;
 
@@ -3219,7 +3239,7 @@ static int fuse4fs_unlink(struct fuse4fs *ff, ext2_ino_t parent,
 		goto out;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse4fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out;
 out:
@@ -3353,7 +3373,7 @@ static int fuse4fs_rmdir(struct fuse4fs *ff, ext2_ino_t parent,
 			goto out;
 		}
 		ext2fs_dec_nlink(EXT2_INODE(&inode));
-		ret = update_mtime(fs, rds.parent, &inode);
+		ret = fuse4fs_update_mtime(ff, rds.parent, &inode);
 		if (ret)
 			goto out;
 		err = fuse4fs_write_inode(fs, rds.parent, &inode);
@@ -3457,7 +3477,7 @@ static void op_symlink(fuse_req_t req, const char *target, fuse_ino_t fino,
 	}
 
 	/* Update parent dir's mtime */
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse4fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -3480,7 +3500,7 @@ static void op_symlink(fuse_req_t req, const char *target, fuse_ino_t fino,
 	fuse4fs_set_uid(&inode, ctxt->uid);
 	fuse4fs_set_gid(&inode, gid);
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse4fs_init_timestamps(ff, &inode);
 
 	err = fuse4fs_write_inode(fs, child, &inode);
 	if (err) {
@@ -3711,11 +3731,11 @@ static void op_rename(fuse_req_t req, fuse_ino_t from_parent, const char *from,
 	}
 
 	/* Update timestamps */
-	ret = update_ctime(fs, from_ino, NULL);
+	ret = fuse4fs_update_ctime(ff, from_ino, NULL);
 	if (ret)
 		goto out;
 
-	ret = update_mtime(fs, to_dir_ino, NULL);
+	ret = fuse4fs_update_mtime(ff, to_dir_ino, NULL);
 	if (ret)
 		goto out;
 
@@ -3794,7 +3814,7 @@ static void op_link(fuse_req_t req, fuse_ino_t child_fino,
 	}
 
 	ext2fs_inc_nlink(fs, EXT2_INODE(&inode));
-	ret = update_ctime(fs, child, &inode);
+	ret = fuse4fs_update_ctime(ff, child, &inode);
 	if (ret)
 		goto out2;
 
@@ -3811,7 +3831,7 @@ static void op_link(fuse_req_t req, fuse_ino_t child_fino,
 		goto out2;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse4fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -4047,7 +4067,7 @@ static int fuse4fs_truncate(struct fuse4fs *ff, ext2_ino_t ino, off_t new_size)
 	if (err)
 		return translate_error(fs, ino, err);
 
-	ret = update_mtime(fs, ino, NULL);
+	ret = fuse4fs_update_mtime(ff, ino, NULL);
 	if (ret)
 		return ret;
 
@@ -4249,7 +4269,7 @@ static void op_read(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
 	}
 
 	if (fh->check_flags != X_OK && fuse4fs_is_writeable(ff)) {
-		ret = update_atime(fs, fh->ino);
+		ret = fuse4fs_update_atime(ff, fh->ino);
 		if (ret)
 			goto out;
 	}
@@ -4323,7 +4343,7 @@ static void op_write(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
 		goto out;
 	}
 
-	ret = update_mtime(fs, fh->ino, NULL);
+	ret = fuse4fs_update_mtime(ff, fh->ino, NULL);
 	if (ret)
 		goto out;
 
@@ -4770,7 +4790,7 @@ static void op_setxattr(fuse_req_t req, fuse_ino_t fino, const char *key,
 		goto out2;
 	}
 
-	ret = update_ctime(fs, ino, NULL);
+	ret = fuse4fs_update_ctime(ff, ino, NULL);
 out2:
 	err = ext2fs_xattrs_close(&h);
 	if (!ret && err)
@@ -4864,7 +4884,7 @@ static void op_removexattr(fuse_req_t req, fuse_ino_t fino, const char *key)
 		goto out2;
 	}
 
-	ret = update_ctime(fs, ino, NULL);
+	ret = fuse4fs_update_ctime(ff, ino, NULL);
 out2:
 	err = ext2fs_xattrs_close(&h);
 	if (err && !ret)
@@ -5011,7 +5031,7 @@ static void __op_readdir(fuse_req_t req, fuse_ino_t fino, size_t size,
 	}
 
 	if (fuse4fs_is_writeable(ff)) {
-		ret = update_atime(i.fs, fh->ino);
+		ret = fuse4fs_update_atime(i.ff, fh->ino);
 		if (ret)
 			goto out;
 	}
@@ -5111,7 +5131,7 @@ static void op_create(fuse_req_t req, fuse_ino_t fino, const char *name,
 			goto out2;
 		}
 
-		ret = update_mtime(fs, parent, NULL);
+		ret = fuse4fs_update_mtime(ff, parent, NULL);
 		if (ret)
 			goto out2;
 	} else {
@@ -5152,7 +5172,7 @@ static void op_create(fuse_req_t req, fuse_ino_t fino, const char *name,
 	}
 
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse4fs_init_timestamps(ff, &inode);
 	err = fuse4fs_write_inode(fs, child, &inode);
 	if (err) {
 		ret = translate_error(fs, child, err);
@@ -5231,7 +5251,7 @@ static int fuse4fs_utimens(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 	int ret = 0;
 
 	if (to_set & (FUSE_SET_ATTR_ATIME_NOW | FUSE_SET_ATTR_MTIME_NOW))
-		get_now(&now);
+		fuse4fs_get_now(ff, &now);
 
 	if (to_set & FUSE_SET_ATTR_ATIME_NOW) {
 		atime = now;
@@ -5369,7 +5389,7 @@ static void op_setattr(fuse_req_t req, fuse_ino_t fino, struct stat *attr,
 	}
 
 	/* Update ctime for any attribute change */
-	ret = update_ctime(fs, ino, &inode);
+	ret = fuse4fs_update_ctime(ff, ino, &inode);
 	if (ret)
 		goto out;
 
@@ -5451,7 +5471,7 @@ static int ioctl_setflags(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 	if (ret)
 		return ret;
 
-	ret = update_ctime(fs, fh->ino, &inode);
+	ret = fuse4fs_update_ctime(ff, fh->ino, &inode);
 	if (ret)
 		return ret;
 
@@ -5504,7 +5524,7 @@ static int ioctl_setversion(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 
 	inode.i_generation = *indata;
 
-	ret = update_ctime(fs, fh->ino, &inode);
+	ret = fuse4fs_update_ctime(ff, fh->ino, &inode);
 	if (ret)
 		return ret;
 
@@ -5640,7 +5660,7 @@ static int ioctl_fssetxattr(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 	if (ext2fs_inode_includes(inode_size, i_projid))
 		inode.i_projid = fsx->fsx_projid;
 
-	ret = update_ctime(fs, fh->ino, &inode);
+	ret = fuse4fs_update_ctime(ff, fh->ino, &inode);
 	if (ret)
 		return ret;
 
@@ -5936,7 +5956,7 @@ static int fuse4fs_allocate_range(struct fuse4fs *ff,
 		}
 	}
 
-	err = update_mtime(fs, fh->ino, &inode);
+	err = fuse4fs_update_mtime(ff, fh->ino, &inode);
 	if (err)
 		return err;
 
@@ -6109,7 +6129,7 @@ static int fuse4fs_punch_range(struct fuse4fs *ff,
 			return translate_error(fs, fh->ino, err);
 	}
 
-	err = update_mtime(fs, fh->ino, &inode);
+	err = fuse4fs_update_mtime(ff, fh->ino, &inode);
 	if (err)
 		return err;
 
@@ -8271,7 +8291,7 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 			error_message(err), func, line);
 
 	/* Make a note in the error log */
-	get_now(&now);
+	fuse4fs_get_now(ff, &now);
 	ext2fs_set_tstamp(fs->super, s_last_error_time, now.tv_sec);
 	fs->super->s_last_error_ino = ino;
 	fs->super->s_last_error_line = line;
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index f77d778aec24ec..de712461492e05 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -840,8 +840,24 @@ static inline void fuse2fs_dump_extents(struct fuse2fs *ff, ext2_ino_t ino,
 	ext2fs_extent_free(extents);
 }
 
-static void get_now(struct timespec *now)
+static void fuse2fs_get_now(struct fuse2fs *ff, struct timespec *now)
 {
+#ifdef CLOCK_REALTIME_COARSE
+	/*
+	 * In iomap mode, the kernel is responsible for maintaining timestamps
+	 * because file writes don't upcall to fuse2fs.  The kernel's predicate
+	 * for deciding if [cm]time should be updated bases its decisions off
+	 * [cm]time being an exact match for the coarse clock (instead of
+	 * checking that [cm]time < coarse_clock) which means that fuse2fs
+	 * setting a fine-grained timestamp that is slightly ahead of the
+	 * coarse clock can result in timestamps appearing to go backwards.
+	 * generic/423 doesn't like seeing btime > ctime from statx, so we'll
+	 * use the coarse clock in iomap mode.
+	 */
+	if (fuse2fs_iomap_enabled(ff) &&
+	    !clock_gettime(CLOCK_REALTIME_COARSE, now))
+		return;
+#endif
 #ifdef CLOCK_REALTIME
 	if (!clock_gettime(CLOCK_REALTIME, now))
 		return;
@@ -869,7 +885,7 @@ static void fuse2fs_init_timestamps(struct fuse2fs *ff, ext2_ino_t ino,
 {
 	struct timespec now;
 
-	get_now(&now);
+	fuse2fs_get_now(ff, &now);
 	EXT4_INODE_SET_XTIME(i_atime, &now, inode);
 	EXT4_INODE_SET_XTIME(i_ctime, &now, inode);
 	EXT4_INODE_SET_XTIME(i_mtime, &now, inode);
@@ -888,7 +904,7 @@ static int fuse2fs_update_ctime(struct fuse2fs *ff, ext2_ino_t ino,
 	struct timespec now;
 	struct ext2_inode_large inode;
 
-	get_now(&now);
+	fuse2fs_get_now(ff, &now);
 
 	/* If user already has a inode buffer, just update that */
 	if (pinode) {
@@ -934,7 +950,7 @@ static int fuse2fs_update_atime(struct fuse2fs *ff, ext2_ino_t ino)
 	pinode = &inode;
 	EXT4_INODE_GET_XTIME(i_atime, &atime, pinode);
 	EXT4_INODE_GET_XTIME(i_mtime, &mtime, pinode);
-	get_now(&now);
+	fuse2fs_get_now(ff, &now);
 
 	datime = atime.tv_sec + ((double)atime.tv_nsec / NSEC_PER_SEC);
 	dmtime = mtime.tv_sec + ((double)mtime.tv_nsec / NSEC_PER_SEC);
@@ -969,7 +985,7 @@ static int fuse2fs_update_mtime(struct fuse2fs *ff, ext2_ino_t ino,
 	struct timespec now;
 
 	if (pinode) {
-		get_now(&now);
+		fuse2fs_get_now(ff, &now);
 		EXT4_INODE_SET_XTIME(i_mtime, &now, pinode);
 		EXT4_INODE_SET_XTIME(i_ctime, &now, pinode);
 		increment_version(pinode);
@@ -984,7 +1000,7 @@ static int fuse2fs_update_mtime(struct fuse2fs *ff, ext2_ino_t ino,
 	if (err)
 		return translate_error(fs, ino, err);
 
-	get_now(&now);
+	fuse2fs_get_now(ff, &now);
 	EXT4_INODE_SET_XTIME(i_mtime, &now, &inode);
 	EXT4_INODE_SET_XTIME(i_ctime, &now, &inode);
 	increment_version(&inode);
@@ -4965,9 +4981,9 @@ static int op_utimens(const char *path, const struct timespec ctv[2],
 	tv[1] = ctv[1];
 #ifdef UTIME_NOW
 	if (tv[0].tv_nsec == UTIME_NOW)
-		get_now(tv);
+		fuse2fs_get_now(ff, tv);
 	if (tv[1].tv_nsec == UTIME_NOW)
-		get_now(tv + 1);
+		fuse2fs_get_now(ff, tv + 1);
 #endif /* UTIME_NOW */
 #ifdef UTIME_OMIT
 	if (tv[0].tv_nsec != UTIME_OMIT)
@@ -7708,7 +7724,7 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 			error_message(err), func, line);
 
 	/* Make a note in the error log */
-	get_now(&now);
+	fuse2fs_get_now(ff, &now);
 	ext2fs_set_tstamp(fs->super, s_last_error_time, now.tv_sec);
 	fs->super->s_last_error_ino = ino;
 	fs->super->s_last_error_line = line;


