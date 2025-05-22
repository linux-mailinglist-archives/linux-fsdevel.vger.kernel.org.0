Return-Path: <linux-fsdevel+bounces-49642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E319AC012C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C613AC5A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAA020EB;
	Thu, 22 May 2025 00:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYQILCZf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15160383;
	Thu, 22 May 2025 00:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872761; cv=none; b=nMXalJ7RkRzz6jhIBkPgxoJBmK27351dipbkjAgqlV8mJDYDjyvlIiitl5H8SLpqRrv3shUVACwxD5Za19Zft6OOKSrv6AnDlgKyXahCDoxwr1clKoVDte+gxEiQyjGrMYnGrWkROXUSvaj5iBICtxmXOO0kRwjkpbz0361Lcq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872761; c=relaxed/simple;
	bh=sXcmX708lshPnZN8laaLSeqTqfefcFbY9LCwwNZcs3k=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FAi7sbD1WHZFGNftM9XdvuU9jTGplw5hNlNcL8/iZJtWkg/FcDU+D9R9P1btwPduwfGiNnt9Z/u8YmPQ+o49YfhfRdOh2My3n+f/SDF3X6kg6RnmmNh37/CcvUGGbAHkXPYsVgpAnGxIb46AnMe+OebRs9QUkWz8q/OrEA1URwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYQILCZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3CBC4CEE4;
	Thu, 22 May 2025 00:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872760;
	bh=sXcmX708lshPnZN8laaLSeqTqfefcFbY9LCwwNZcs3k=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=lYQILCZfnxz0Mjf7gI2qW8Je0AgsXee7Ey6ApNGUzCpMR0nRMr2Kh6ya6ALl0LMp6
	 Df6IhOPhjQq+6FiGie16YndM7uTOaBpa/WO8FKBuNLiGO71b+1F95P7aOv7pgTjTY7
	 7iMl2oZITWo0fjlUdGRlDj1m/9nGGOd8b9ZHsQaf7765edjKxEArx3ScQwiqudPNhw
	 jzUNqNo6hxAZ04/4uZgHMLsEkxK4/aahqoGWUxv6MhfX/kzuifnqa4SPNBpyj4l/DW
	 CGIv/n7lPUnZsvs87B1baSK/hQ3ZYH9pI8C5lrRxzhE/JQKLplIT/LjQUmk0b5zsqr
	 6Qic9Yq2lMMIQ==
Date: Wed, 21 May 2025 17:12:40 -0700
Subject: [PATCH 07/16] fuse2fs: add extent dump function for debugging
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, linux-ext4@vger.kernel.org, miklos@szeredi.hu,
 joannelkoong@gmail.com, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
Message-ID: <174787198559.1484996.8861134416496115630.stgit@frogsfrogsfrogs>
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

Add a function to dump an inode's extent map for debugging purposes.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 3ec99310b0f112..7e9095766c6624 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -377,6 +377,74 @@ static inline errcode_t fuse2fs_write_inode(ext2_filsys fs, ext2_ino_t ino,
 				       sizeof(*inode));
 }
 
+static inline void dump_ino_extents(struct fuse2fs *ff, ext2_ino_t ino,
+				    struct ext2_inode_large *inode,
+				    const char *why)
+{
+	ext2_filsys fs = ff->fs;
+	unsigned int nr = 0;
+	blk64_t blockcount = 0;
+	struct ext2_inode_large xinode;
+	struct ext2fs_extent extent;
+	ext2_extent_handle_t extents;
+	int op = EXT2_EXTENT_ROOT;
+	errcode_t retval;
+
+	if (!inode) {
+		inode = &xinode;
+
+		retval = fuse2fs_read_inode(fs, ino, inode);
+		if (retval) {
+			com_err(__func__, retval, _("reading ino %u"), ino);
+			return;
+		}
+	}
+
+	if (!(inode->i_flags & EXT4_EXTENTS_FL))
+		return;
+
+	printf("%s: %s ino %u isize %llu iblocks %llu\n", __func__, why, ino,
+	       EXT2_I_SIZE(inode),
+	       (ext2fs_get_stat_i_blocks(fs, EXT2_INODE(inode)) * 512) /
+	        fs->blocksize);
+	fflush(stdout);
+
+	retval = ext2fs_extent_open(fs, ino, &extents);
+	if (retval) {
+		com_err(__func__, retval, _("opening extents of ino \"%u\""),
+			ino);
+		return;
+	}
+
+	while ((retval = ext2fs_extent_get(extents, op, &extent)) == 0) {
+		op = EXT2_EXTENT_NEXT;
+
+		if (extent.e_flags & EXT2_EXTENT_FLAGS_SECOND_VISIT)
+			continue;
+
+		printf("[%u]: %s lblk 0x%llx pblk 0x%llx len 0x%x flags 0x%x\n",
+		       nr++, why, extent.e_lblk, extent.e_pblk, extent.e_len,
+		       extent.e_flags);
+		fflush(stdout);
+		if (extent.e_flags & EXT2_EXTENT_FLAGS_LEAF)
+			blockcount += extent.e_len;
+		else
+			blockcount++;
+	}
+	if (retval == EXT2_ET_EXTENT_NO_NEXT)
+		retval = 0;
+	if (retval) {
+		com_err(__func__, retval, ("getting extents of ino %u"),
+			ino);
+	}
+	if (inode->i_file_acl)
+		blockcount++;
+	printf("%s: %s sum(e_len) %llu\n", __func__, why, blockcount);
+	fflush(stdout);
+
+	ext2fs_extent_free(extents);
+}
+
 static void get_now(struct timespec *now)
 {
 #ifdef CLOCK_REALTIME


