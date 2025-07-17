Return-Path: <linux-fsdevel+bounces-55397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27120B0989E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B19189E427
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B1925B1DC;
	Thu, 17 Jul 2025 23:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZSSSPF5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C672255F53;
	Thu, 17 Jul 2025 23:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752796080; cv=none; b=OhwOewTAXy4VdplndxGRTQ5rU+Ds9//ZTnG8WipiOjK6HnpoCF8ifhsro1kNxqQsLFsrrN4AEhATwZNLH8GngYasFVOTmVWHRT9A0cdQ+gDLy+Y/PuCyoqh/tQnApwGWWV7sWXcTBUf3pGhF1J0o6YgU2ArCYs1XrbDSOjuyB/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752796080; c=relaxed/simple;
	bh=JeYv39w2MTaAnEH6C45hdB/CpeLfsS8BX0mRO6+/G1I=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fDfvT9fa2nH5okqUIqDgxL/OmGCWwvFOG0mIsRJN8qyXb6XKmrdNC0thbvKjNUUjhrxdSNwTFRPlK/UipRkJH1rPyFEvtO5MMmNSFohack3Nz65hZY9JsQfVy8H0zvgUP5QKm/5MTaCAR4/TQ5rjP8bYRgSZOfgNp0GyOIXGsYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZSSSPF5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9957C4CEE3;
	Thu, 17 Jul 2025 23:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752796080;
	bh=JeYv39w2MTaAnEH6C45hdB/CpeLfsS8BX0mRO6+/G1I=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=dZSSSPF5mUZUsiAJzoA94Dkba3fXzGcCODQh7JMtbnId0VLDAnhfhx8z00QNCvtMJ
	 mw3fNagS7dttyS4NLJ8a8tkZXnRNv4C2Jt/7gQqqSusfSGD9hztLIOBFnoCO4O+MXV
	 OX4vyk+7/HlaKRwfzRWkcGVRObmDCDHTcJ7d32ZtGBZzqoKb6BvjZVo4PTzRriDMeo
	 1EHlBjA4Roasuzv/md4RjNbbcsJBlvvb/OQuhBz1s5plvvZJmL07lgAFaSVNcQk/Gu
	 68EXNVc+2BsqrtmEGlR4GbT1lWkqkDscK8Ex/EyKvYgeVF0twjd9Dzj7MS6wYe3s9m
	 Qyvt8TU+5LO6A==
Date: Thu, 17 Jul 2025 16:47:59 -0700
Subject: [PATCH 10/10] fuse2fs: implement statx
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461900.716436.1047020432825856932.stgit@frogsfrogsfrogs>
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

Implement statx.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |  107 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 3bded0fdd21e2a..6d2ed7da9cc09e 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -23,6 +23,7 @@
 #include <sys/xattr.h>
 #endif
 #include <sys/ioctl.h>
+#include <sys/sysmacros.h>
 #include <unistd.h>
 #include <ctype.h>
 #define FUSE_DARWIN_ENABLE_EXTENSIONS 0
@@ -1646,6 +1647,111 @@ static int op_getattr_iflags(const char *path, struct stat *statbuf,
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
+static int fuse2fs_statx(struct fuse2fs *ff, ext2_ino_t ino,
+			 uint32_t statx_mask, struct statx *stx, size_t size)
+{
+	struct ext2_inode_large inode;
+	ext2_filsys fs = ff->fs;;
+	dev_t fakedev = 0;
+	errcode_t err;
+	struct timespec tv;
+
+	if (size < sizeof(struct statx))
+		return translate_error(fs, ino, EOPNOTSUPP);
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
+	return 0;
+}
+
+static int op_statx(const char *path, uint32_t statx_flags, uint32_t statx_mask,
+		    struct statx *stx, size_t size, struct fuse_file_info *fi)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	ext2_ino_t ino;
+	int ret = 0;
+
+	FUSE2FS_CHECK_CONTEXT(ff);
+	fuse2fs_start(ff);
+	ret = fuse2fs_file_ino(ff, path, fi, &ino);
+	if (ret)
+		goto out;
+	ret = fuse2fs_statx(ff, ino, statx_mask, stx, size);
+out:
+	fuse2fs_finish(ff, ret);
+	return ret;
+}
+#else
+# define op_statx		NULL
+#endif
 
 static int op_readlink(const char *path, char *buf, size_t len)
 {
@@ -6351,6 +6457,7 @@ static struct fuse_operations fs_ops = {
 #endif
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 18)
 	.syncfs = op_syncfs,
+	.statx = op_statx,
 #endif
 #ifdef HAVE_FUSE_IOMAP
 	.iomap_begin = op_iomap_begin,


