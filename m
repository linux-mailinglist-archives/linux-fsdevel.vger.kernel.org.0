Return-Path: <linux-fsdevel+bounces-55376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FDBB09856
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C50D3B1424
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD9C241676;
	Thu, 17 Jul 2025 23:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dk5JOIEn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CE4BE46;
	Thu, 17 Jul 2025 23:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795750; cv=none; b=Z24lmqs9IT0qxc0peHFTU1wyqx4RQAlss2XKObUgBp3PBPqC4Gvdl972h/m8opS/2nlG+j/Rwj7HoVT4DvGuvtUmgeadSHZROCXaZOJ8WoxWyR0H+6Sb/n+GXN1EZ1vrFZ8xBbqGsc6m2dPI2Ql0uRr+4C9T+Jsvfm475ecVets=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795750; c=relaxed/simple;
	bh=CRnBU2YC3za5UyTpDZ3AliXABheext3bxeXnsoyBHE4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rh8wSQRck2wYZ3YNJ3+QZdnpE0/oE6+HUwB/tfM/fSQCqGmDzcj9KQgsWsTSj5/zJLEqPx+HB/+E2tmOPQG3KenLZDsbKoJeaeCsntVAiC8edKlNuO5Im4xPpiUg7R0/yBGWAiS8FjvkO1fxN2Q7TjORLwnp7qE3mVvqR8yYA8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dk5JOIEn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AA6C4CEE3;
	Thu, 17 Jul 2025 23:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795750;
	bh=CRnBU2YC3za5UyTpDZ3AliXABheext3bxeXnsoyBHE4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=dk5JOIEnZcOg/SuNntIblwxyEAnO7Mvff4eUOYKK4/eSnI91A3dKEIkneICMW1StZ
	 S5m46wa8R+vRqaIr1JBOyH7kA3hUfAq1epQK2XpJrGxcmKMCerFCdfSoIaCdH36PHg
	 cfqWcnyKq2xfyfpmcHDYl0GdC274CS8QurMdJbk5V6c71t8llg8bhHDJS8O0+TtvQc
	 nM4iNFY3xK9AateNZ5UZIxy6bHDr0Dqdk+RWy80Bl8v70GMxVYDdZkPv/+rD4PlRRt
	 QAAb5mZaTEVmcszX8WvGvkG4AYKY5h70/Ze8tpp8QekT0N0YXdmpGJcQxQOXP+UB/3
	 Q6WoMwcJlrTBw==
Date: Thu, 17 Jul 2025 16:42:29 -0700
Subject: [PATCH 12/22] fuse2fs: improve tracing for fallocate
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461250.715479.6969062418820124769.stgit@frogsfrogsfrogs>
In-Reply-To: <175279460935.715479.15460687085573767955.stgit@frogsfrogsfrogs>
References: <175279460935.715479.15460687085573767955.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |   23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index a8fb18650ec080..f7d17737459c11 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4683,8 +4683,8 @@ static int fuse2fs_allocate_range(struct fuse2fs *ff,
 
 	start = FUSE2FS_B_TO_FSBT(ff, offset);
 	end = FUSE2FS_B_TO_FSBT(ff, offset + len - 1);
-	dbg_printf(ff, "%s: ino=%d mode=0x%x start=%llu end=%llu\n", __func__,
-		   fh->ino, mode, start, end);
+	dbg_printf(ff, "%s: ino=%d mode=0x%x offset=0x%jx len=0x%jx start=%llu end=%llu\n",
+		   __func__, fh->ino, mode, offset, len, start, end);
 	if (!fs_can_allocate(ff, FUSE2FS_B_TO_FSB(ff, len)))
 		return -ENOSPC;
 
@@ -4751,6 +4751,7 @@ static errcode_t clean_block_middle(struct fuse2fs *ff, ext2_ino_t ino,
 	if (err)
 		return err;
 
+	dbg_printf(ff, "%s: ino=%d offset=0x%jx len=0x%jx\n", __func__, ino, offset + residue, len);
 	memset(*buf + residue, 0, len);
 
 	return io_channel_write_tagblk(fs->io, ino, blk, 1, *buf);
@@ -4787,10 +4788,15 @@ static errcode_t clean_block_edge(struct fuse2fs *ff, ext2_ino_t ino,
 	if (!blk || (retflags & BMAP_RET_UNINIT))
 		return 0;
 
-	if (clean_before)
+	if (clean_before) {
+		dbg_printf(ff, "%s: ino=%d before offset=0x%jx len=0x%jx\n",
+			   __func__, ino, offset, residue);
 		memset(*buf, 0, residue);
-	else
+	} else {
+		dbg_printf(ff, "%s: ino=%d after offset=0x%jx len=0x%jx\n",
+			   __func__, ino, offset, fs->blocksize - residue);
 		memset(*buf + residue, 0, fs->blocksize - residue);
+	}
 
 	return io_channel_write_tagblk(fs->io, ino, blk, 1, *buf);
 }
@@ -4805,9 +4811,6 @@ static int fuse2fs_punch_range(struct fuse2fs *ff,
 	errcode_t err;
 	char *buf = NULL;
 
-	dbg_printf(ff, "%s: offset=%jd len=%jd\n", __func__,
-		   (intmax_t) offset, (intmax_t) len);
-
 	/* kernel ext4 punch requires this flag to be set */
 	if (!(mode & FL_KEEP_SIZE_FLAG))
 		return -EINVAL;
@@ -4900,6 +4903,12 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
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
 		ret = fuse2fs_zero_range(ff, fh, mode, offset, len);
 	else if (mode & FL_PUNCH_HOLE_FLAG)


