Return-Path: <linux-fsdevel+bounces-49646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F5EAC0134
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8DCB9E59D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05311FC3;
	Thu, 22 May 2025 00:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZ8PWHaP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFC4195;
	Thu, 22 May 2025 00:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872824; cv=none; b=GM4R+l7ggr+3y+/JRzoqCKOT7ngmH1GmOF6c8Ys0UPExOCquN7v0fmTslIUkT8CT3LfndHaD7BgkIDDMj4AekulTBRUnJhj899wOVFsL4I8QFjcgTvp5WoCu/IVOihvpCv+Iv5Ij+PEckq7v9kyLm29P/lEBebhZV6F6GG/W4uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872824; c=relaxed/simple;
	bh=xMhQFaupd8XtgwhvMkZGQzM1S/LUbYuPp1Q1IrCtDT0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LjSjzc9K2q5DrXtm/7UJ1MTQig1i2p5j1rXFPhb9xRZE7QgMf62sNsrPX6+rlw1U7RHOYuIhrFYc5aY+3Co9eeeE/NiPC9iPwn/8mlDHfeEeHZIIOD0iFGkOpkPdp4U82ebSkN3q5fnAKAK/aR1r8ZIr95uqRud0Ic+rDB7yZLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZ8PWHaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81326C4CEE4;
	Thu, 22 May 2025 00:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872823;
	bh=xMhQFaupd8XtgwhvMkZGQzM1S/LUbYuPp1Q1IrCtDT0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=HZ8PWHaPYm3kWa/hlkrgtHu2pHNCDvsSjsz3iqm2ObGg53bR2KoqfIURhqSpyGajf
	 YfwqXVpCUDD8zTkbppk3MXFL41DE01h8LfcE/7xZ9yMUp3zEQJiIfeGgB8/WloQeLp
	 ITIdMC9avwu7FtEMoNZp7SEN/dR/iPsNnch2kkp3Ri0ogHmDzPzgEufkh8XFhl08ZR
	 Fa8/HEDYExNpvEtzaaHtueIUCjLxLK2Tvt2DLAjtwWnWjPxpy4gP4BGtQ3GcFnYsXa
	 NsVN6VAesVbljM4YmAH0qwNmjPHNcOy9LaNUCYmI5oZB/E7jgI/vnPNBWcnxEpq7EY
	 YF0QbMAwTXMeQ==
Date: Wed, 21 May 2025 17:13:43 -0700
Subject: [PATCH 11/16] fuse2fs: improve tracing for fallocate
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, linux-ext4@vger.kernel.org, miklos@szeredi.hu,
 joannelkoong@gmail.com, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
Message-ID: <174787198631.1484996.10907307868617305720.stgit@frogsfrogsfrogs>
In-Reply-To: <174787198370.1484996.3340565971108603226.stgit@frogsfrogsfrogs>
References: <174787198370.1484996.3340565971108603226.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Improve the tracing for fallocate by reporting the inode number and the
file range in all tracepoints.  Make the ranges hexadecimal to make it
easier for the programmer to convert bytes to block numbers and back.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 219d4bf698d628..fe6d97324c1f57 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4529,8 +4529,8 @@ static int fallocate_helper(struct fuse_file_info *fp, int mode, off_t offset,
 	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	start = FUSE2FS_B_TO_FSBT(ff, offset);
 	end = FUSE2FS_B_TO_FSBT(ff, offset + len - 1);
-	dbg_printf(ff, "%s: ino=%d mode=0x%x start=%llu end=%llu\n", __func__,
-		   fh->ino, mode, start, end);
+	dbg_printf(ff, "%s: ino=%d mode=0x%x offset=0x%jx len=0x%jx start=%llu end=%llu\n",
+		   __func__, fh->ino, mode, offset, len, start, end);
 	if (!fs_can_allocate(ff, FUSE2FS_B_TO_FSB(ff, len)))
 		return -ENOSPC;
 
@@ -4601,6 +4601,7 @@ static errcode_t clean_block_middle(struct fuse2fs *ff, ext2_ino_t ino,
 	if (err)
 		return err;
 
+	dbg_printf(ff, "%s: ino=%d offset=0x%jx len=0x%jx\n", __func__, ino, offset + residue, len);
 	memset(*buf + residue, 0, len);
 
 	return io_channel_write_tagblk(fs->io, ino, blk, 1, *buf);
@@ -4637,10 +4638,13 @@ static errcode_t clean_block_edge(struct fuse2fs *ff, ext2_ino_t ino,
 	if (!blk || (retflags & BMAP_RET_UNINIT))
 		return 0;
 
-	if (clean_before)
+	if (clean_before) {
+		dbg_printf(ff, "%s: ino=%d before offset=0x%jx len=0x%jx\n", __func__, ino, offset, residue);
 		memset(*buf, 0, residue);
-	else
+	} else {
+		dbg_printf(ff, "%s: ino=%d after offset=0x%jx len=0x%jx\n", __func__, ino, offset, fs->blocksize - residue);
 		memset(*buf + residue, 0, fs->blocksize - residue);
+	}
 
 	return io_channel_write_tagblk(fs->io, ino, blk, 1, *buf);
 }
@@ -4661,7 +4665,6 @@ static int punch_helper(struct fuse_file_info *fp, int mode, off_t offset,
 	FUSE2FS_CHECK_CONTEXT(ff);
 	fs = ff->fs;
 	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
-	dbg_printf(ff, "%s: offset=%jd len=%jd\n", __func__, offset, len);
 
 	/* kernel ext4 punch requires this flag to be set */
 	if (!(mode & FL_KEEP_SIZE_FLAG))
@@ -4670,8 +4673,9 @@ static int punch_helper(struct fuse_file_info *fp, int mode, off_t offset,
 	/* Punch out a bunch of blocks */
 	start = FUSE2FS_B_TO_FSB(ff, offset);
 	end = (offset + len - fs->blocksize) / fs->blocksize;
-	dbg_printf(ff, "%s: ino=%d mode=0x%x start=%llu end=%llu\n", __func__,
-		   fh->ino, mode, start, end);
+
+	dbg_printf(ff, "%s: ino=%d mode=0x%x offset=0x%jx len=0x%jx start=%llu end=%llu\n",
+		   __func__, fh->ino, mode, offset, len, start, end);
 
 	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
@@ -4727,6 +4731,8 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
 {
 	struct fuse_context *ctxt = fuse_get_context();
 	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs_file_handle *fh =
+		(struct fuse2fs_file_handle *)(uintptr_t)fp->fh;
 	int ret;
 
 	/* Catch unknown flags */
@@ -4738,6 +4744,12 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
 		ret = -EROFS;
 		goto out;
 	}
+
+	dbg_printf(ff, "%s: ino=%d mode=0x%x start=0x%llx end=0x%llx\n", __func__,
+		   fh->ino, mode,
+		   (unsigned long long)offset,
+		   (unsigned long long)offset + len);
+
 	if (mode & FL_ZERO_RANGE_FLAG)
 		ret = zero_helper(fp, mode, offset, len);
 	else if (mode & FL_PUNCH_HOLE_FLAG)


