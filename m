Return-Path: <linux-fsdevel+bounces-58548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1171B2EA79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 935274E36B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8388C1FF61E;
	Thu, 21 Aug 2025 01:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgzLefTH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D620A1E493C;
	Thu, 21 Aug 2025 01:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739224; cv=none; b=SVvt4v7fZ60lwpCm3D2imyXob5efgXgMOAlQZ81XUJduZpzHTpjgnUggiOYW1YTU4j/Yyu/Ao8a4r1BsMCab8NlG7YdBJySi/DHH4kbBzixm+mG2xkpPGlpOb6F49oPB2HaqqqAMqZ66gKrug/C5pyiw/+sH5BFfnC5BZ/v7jKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739224; c=relaxed/simple;
	bh=ZD3EKiy0sJAJOROpTiKibQBvl1G8mvXiwvaVCNE75hY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LDxRj4hpW81iUwf+jZ5bM1WjkMV5mPkoepdemuqV6AuLttuK0vtvPpNAbeIbi+6xBA+Yt6WbQt7IYUg1pzLCjTuHznRJfXYQ7WmCZVWWW+ilwhkS6df7ssnDrWy7qV90lTOQCHpSRBMLLRd4QKYi+fwYKDGq+9CEujhQLv8iLc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgzLefTH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E234C4CEE7;
	Thu, 21 Aug 2025 01:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755739224;
	bh=ZD3EKiy0sJAJOROpTiKibQBvl1G8mvXiwvaVCNE75hY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=BgzLefTHAqf0YX4L3XtILXevnTjy3+jRGYyAjNv2AF9jrkBQRf5z2QA/9MQ/BXVyY
	 jkVeDx5dPps0aYMXWRU6YkQGk9kYvFQPW363cyeNJ10P6wdT8B4oadgfEEF7tk1p5I
	 uIJD7kwUyavupKLmutBqTI7O+RH3UuQv6MgwrI5V7izZheyH19bbzLpHd5ZlRjzDd0
	 9Z7aaFcRC3R8JVwA9oyiGrkL1WM1sdRR6Nx1IVtDmmmVg+nrkxDdJho6m0UfPgS4H/
	 KsOk8ZWvZ4+nrFlyEF2HeS74ueZ2fzaN/kD7ubBIukXaibKvnXrvwiF5z3hNc/rodj
	 VKZB78rujWjLw==
Date: Wed, 20 Aug 2025 18:20:24 -0700
Subject: [PATCH 18/19] fuse2fs: implement statx
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573714056.21970.14760527425331887145.stgit@frogsfrogsfrogs>
In-Reply-To: <175573713645.21970.9783397720493472605.stgit@frogsfrogsfrogs>
References: <175573713645.21970.9783397720493472605.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Implement statx.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |  128 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 misc/fuse4fs.c |  133 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 261 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index cc835f894122a4..a00c32e9f2cae8 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -23,6 +23,7 @@
 #include <sys/xattr.h>
 #endif
 #include <sys/ioctl.h>
+#include <sys/sysmacros.h>
 #include <unistd.h>
 #include <ctype.h>
 #include <stdbool.h>
@@ -1642,6 +1643,130 @@ static int op_getattr_iflags(const char *path, struct stat *statbuf,
 }
 #endif
 
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 18) && defined(STATX_BASIC_STATS)
+static inline void fuse2fs_set_statx_attr(struct statx *stx,
+					  uint64_t statx_flag, int set)
+{
+	if (set)
+		stx->stx_attributes |= statx_flag;
+	stx->stx_attributes_mask |= statx_flag;
+}
+
+static void fuse2fs_statx_directio(struct fuse2fs *ff, struct statx *stx)
+{
+	struct statx devx;
+	errcode_t err;
+	int fd;
+
+	err = io_channel_get_fd(ff->fs->io, &fd);
+	if (err)
+		return;
+
+	err = statx(fd, "", AT_EMPTY_PATH, STATX_DIOALIGN, &devx);
+	if (err)
+		return;
+	if (!(devx.stx_mask & STATX_DIOALIGN))
+		return;
+
+	stx->stx_mask |= STATX_DIOALIGN;
+	stx->stx_dio_mem_align = devx.stx_dio_mem_align;
+	stx->stx_dio_offset_align = devx.stx_dio_offset_align;
+}
+
+static int fuse2fs_statx(struct fuse2fs *ff, ext2_ino_t ino, int statx_mask,
+			 struct statx *stx)
+{
+	struct ext2_inode_large inode;
+	ext2_filsys fs = ff->fs;;
+	dev_t fakedev = 0;
+	errcode_t err;
+	struct timespec tv;
+
+	err = fuse2fs_read_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	memcpy(&fakedev, fs->super->s_uuid, sizeof(fakedev));
+	stx->stx_mask = STATX_BASIC_STATS | STATX_BTIME;
+	stx->stx_dev_major = major(fakedev);
+	stx->stx_dev_minor = minor(fakedev);
+	stx->stx_ino = ino;
+	stx->stx_mode = inode.i_mode;
+	stx->stx_nlink = inode.i_links_count;
+	stx->stx_uid = inode_uid(inode);
+	stx->stx_gid = inode_gid(inode);
+	stx->stx_size = EXT2_I_SIZE(&inode);
+	stx->stx_blksize = fs->blocksize;
+	stx->stx_blocks = ext2fs_get_stat_i_blocks(fs,
+						EXT2_INODE(&inode));
+	EXT4_INODE_GET_XTIME(i_atime, &tv, &inode);
+	stx->stx_atime.tv_sec = tv.tv_sec;
+	stx->stx_atime.tv_nsec = tv.tv_nsec;
+
+	EXT4_INODE_GET_XTIME(i_mtime, &tv, &inode);
+	stx->stx_mtime.tv_sec = tv.tv_sec;
+	stx->stx_mtime.tv_nsec = tv.tv_nsec;
+
+	EXT4_INODE_GET_XTIME(i_ctime, &tv, &inode);
+	stx->stx_ctime.tv_sec = tv.tv_sec;
+	stx->stx_ctime.tv_nsec = tv.tv_nsec;
+
+	EXT4_INODE_GET_XTIME(i_crtime, &tv, &inode);
+	stx->stx_btime.tv_sec = tv.tv_sec;
+	stx->stx_btime.tv_nsec = tv.tv_nsec;
+
+	dbg_printf(ff, "%s: ino=%d atime=%lld.%d mtime=%lld.%d ctime=%lld.%d btime=%lld.%d\n",
+		   __func__, ino,
+		   (long long int)stx->stx_atime.tv_sec, stx->stx_atime.tv_nsec,
+		   (long long int)stx->stx_mtime.tv_sec, stx->stx_mtime.tv_nsec,
+		   (long long int)stx->stx_ctime.tv_sec, stx->stx_ctime.tv_nsec,
+		   (long long int)stx->stx_btime.tv_sec, stx->stx_btime.tv_nsec);
+
+	if (LINUX_S_ISCHR(inode.i_mode) ||
+	    LINUX_S_ISBLK(inode.i_mode)) {
+		if (inode.i_block[0]) {
+			stx->stx_rdev_major = major(inode.i_block[0]);
+			stx->stx_rdev_minor = minor(inode.i_block[0]);
+		} else {
+			stx->stx_rdev_major = major(inode.i_block[1]);
+			stx->stx_rdev_minor = minor(inode.i_block[1]);
+		}
+	}
+
+	fuse2fs_set_statx_attr(stx, STATX_ATTR_COMPRESSED,
+			       inode.i_flags & EXT2_COMPR_FL);
+	fuse2fs_set_statx_attr(stx, STATX_ATTR_IMMUTABLE,
+			       inode.i_flags & EXT2_IMMUTABLE_FL);
+	fuse2fs_set_statx_attr(stx, STATX_ATTR_APPEND,
+			       inode.i_flags & EXT2_APPEND_FL);
+	fuse2fs_set_statx_attr(stx, STATX_ATTR_NODUMP,
+			       inode.i_flags & EXT2_NODUMP_FL);
+
+	fuse2fs_statx_directio(ff, stx);
+
+	return 0;
+}
+
+static int op_statx(const char *path, int statx_flags, int statx_mask,
+		    struct statx *stx, struct fuse_file_info *fi)
+{
+	struct fuse2fs *ff = fuse2fs_get();
+	ext2_ino_t ino;
+	int ret = 0;
+
+	FUSE2FS_CHECK_CONTEXT(ff);
+	fuse2fs_start(ff);
+	ret = fuse2fs_file_ino(ff, path, fi, &ino);
+	if (ret)
+		goto out;
+	ret = fuse2fs_statx(ff, ino, statx_mask, stx);
+out:
+	fuse2fs_finish(ff, ret);
+	return ret;
+}
+#else
+# define op_statx		NULL
+#endif
 
 static int op_readlink(const char *path, char *buf, size_t len)
 {
@@ -6460,6 +6585,9 @@ static struct fuse_operations fs_ops = {
 	.fallocate = op_fallocate,
 # endif
 #endif
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 18)
+	.statx = op_statx,
+#endif
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 99)
 	.getattr_iflags = op_getattr_iflags,
 #endif
diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index 2371b9b37cc16a..b45f92a1cdbe25 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -24,6 +24,7 @@
 #include <sys/xattr.h>
 #endif
 #include <sys/ioctl.h>
+#include <sys/sysmacros.h>
 #include <unistd.h>
 #include <ctype.h>
 #include <stdbool.h>
@@ -1811,6 +1812,135 @@ static void op_getattr(fuse_req_t req, fuse_ino_t fino,
 				       fstat.entry.attr_timeout);
 }
 
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 18) && defined(STATX_BASIC_STATS)
+static inline void fuse4fs_set_statx_attr(struct statx *stx,
+					  uint64_t statx_flag, int set)
+{
+	if (set)
+		stx->stx_attributes |= statx_flag;
+	stx->stx_attributes_mask |= statx_flag;
+}
+
+static void fuse4fs_statx_directio(struct fuse4fs *ff, struct statx *stx)
+{
+	struct statx devx;
+	errcode_t err;
+	int fd;
+
+	err = io_channel_get_fd(ff->fs->io, &fd);
+	if (err)
+		return;
+
+	err = statx(fd, "", AT_EMPTY_PATH, STATX_DIOALIGN, &devx);
+	if (err)
+		return;
+	if (!(devx.stx_mask & STATX_DIOALIGN))
+		return;
+
+	stx->stx_mask |= STATX_DIOALIGN;
+	stx->stx_dio_mem_align = devx.stx_dio_mem_align;
+	stx->stx_dio_offset_align = devx.stx_dio_offset_align;
+}
+
+static int fuse4fs_statx(struct fuse4fs *ff, ext2_ino_t ino, int statx_mask,
+			 struct statx *stx)
+{
+	struct ext2_inode_large inode;
+	ext2_filsys fs = ff->fs;;
+	dev_t fakedev = 0;
+	errcode_t err;
+	struct timespec tv;
+
+	err = fuse4fs_read_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	memcpy(&fakedev, fs->super->s_uuid, sizeof(fakedev));
+	stx->stx_mask = STATX_BASIC_STATS | STATX_BTIME;
+	stx->stx_dev_major = major(fakedev);
+	stx->stx_dev_minor = minor(fakedev);
+	stx->stx_ino = ino;
+	stx->stx_mode = inode.i_mode;
+	stx->stx_nlink = inode.i_links_count;
+	stx->stx_uid = inode_uid(inode);
+	stx->stx_gid = inode_gid(inode);
+	stx->stx_size = EXT2_I_SIZE(&inode);
+	stx->stx_blksize = fs->blocksize;
+	stx->stx_blocks = ext2fs_get_stat_i_blocks(fs,
+						EXT2_INODE(&inode));
+	EXT4_INODE_GET_XTIME(i_atime, &tv, &inode);
+	stx->stx_atime.tv_sec = tv.tv_sec;
+	stx->stx_atime.tv_nsec = tv.tv_nsec;
+
+	EXT4_INODE_GET_XTIME(i_mtime, &tv, &inode);
+	stx->stx_mtime.tv_sec = tv.tv_sec;
+	stx->stx_mtime.tv_nsec = tv.tv_nsec;
+
+	EXT4_INODE_GET_XTIME(i_ctime, &tv, &inode);
+	stx->stx_ctime.tv_sec = tv.tv_sec;
+	stx->stx_ctime.tv_nsec = tv.tv_nsec;
+
+	EXT4_INODE_GET_XTIME(i_crtime, &tv, &inode);
+	stx->stx_btime.tv_sec = tv.tv_sec;
+	stx->stx_btime.tv_nsec = tv.tv_nsec;
+
+	dbg_printf(ff, "%s: ino=%d atime=%lld.%d mtime=%lld.%d ctime=%lld.%d btime=%lld.%d\n",
+		   __func__, ino,
+		   (long long int)stx->stx_atime.tv_sec, stx->stx_atime.tv_nsec,
+		   (long long int)stx->stx_mtime.tv_sec, stx->stx_mtime.tv_nsec,
+		   (long long int)stx->stx_ctime.tv_sec, stx->stx_ctime.tv_nsec,
+		   (long long int)stx->stx_btime.tv_sec, stx->stx_btime.tv_nsec);
+
+	if (LINUX_S_ISCHR(inode.i_mode) ||
+	    LINUX_S_ISBLK(inode.i_mode)) {
+		if (inode.i_block[0]) {
+			stx->stx_rdev_major = major(inode.i_block[0]);
+			stx->stx_rdev_minor = minor(inode.i_block[0]);
+		} else {
+			stx->stx_rdev_major = major(inode.i_block[1]);
+			stx->stx_rdev_minor = minor(inode.i_block[1]);
+		}
+	}
+
+	fuse4fs_set_statx_attr(stx, STATX_ATTR_COMPRESSED,
+			       inode.i_flags & EXT2_COMPR_FL);
+	fuse4fs_set_statx_attr(stx, STATX_ATTR_IMMUTABLE,
+			       inode.i_flags & EXT2_IMMUTABLE_FL);
+	fuse4fs_set_statx_attr(stx, STATX_ATTR_APPEND,
+			       inode.i_flags & EXT2_APPEND_FL);
+	fuse4fs_set_statx_attr(stx, STATX_ATTR_NODUMP,
+			       inode.i_flags & EXT2_NODUMP_FL);
+
+	fuse4fs_statx_directio(ff, stx);
+
+	return 0;
+}
+
+static void op_statx(fuse_req_t req, fuse_ino_t fino, int flags, int mask,
+		     struct fuse_file_info *fi)
+{
+	struct statx stx;
+	struct fuse4fs *ff = fuse4fs_get(req);
+	ext2_ino_t ino;
+	int ret = 0;
+
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CONVERT_FINO(req, &ino, fino);
+	fuse4fs_start(ff);
+	ret = fuse4fs_statx(ff, ino, mask, &stx);
+	if (ret)
+		goto out;
+out:
+	fuse4fs_finish(ff, ret);
+	if (ret)
+		fuse_reply_err(req, -ret);
+	else
+		fuse_reply_statx(req, 0, &stx, FUSE4FS_ATTR_TIMEOUT);
+}
+#else
+# define op_statx		NULL
+#endif
+
 static void op_readlink(fuse_req_t req, fuse_ino_t fino)
 {
 	struct ext2_inode inode;
@@ -6770,6 +6900,9 @@ static struct fuse_lowlevel_ops fs_ops = {
 #ifdef SUPPORT_FALLOCATE
 	.fallocate = op_fallocate,
 #endif
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 18)
+	.statx = op_statx,
+#endif
 #ifdef HAVE_FUSE_IOMAP
 	.iomap_begin = op_iomap_begin,
 	.iomap_end = op_iomap_end,


