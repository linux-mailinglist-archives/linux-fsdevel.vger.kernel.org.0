Return-Path: <linux-fsdevel+bounces-58536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D22B2EA61
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A6AA7A365E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D3F205ABA;
	Thu, 21 Aug 2025 01:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qW+hc4+D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F65A1F37C5;
	Thu, 21 Aug 2025 01:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739038; cv=none; b=k9wAp9Jle42ZvWcLIf4sRejnWt8Oro4K3IjFdLWRJElo41l9SAer5oU1CKUJ6tAriTQYZ+6iRaXrEcoz36iVgNXTC9JqcdmvBOEQlw972K4SlTmDDR/R6aYYel84LQLqbQ0l23dDNC0wYoJEI6r1P180QoecE/l78RLmSSc8gMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739038; c=relaxed/simple;
	bh=Vl1HTqR85aGJ60RDemuuoE+HKDeTXYHvsBBxEM7qP5A=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOY/dTbAxlBFfv9mE9y2z9PI46xYIjOPYXATaPt3W/9HEc/dvWW9PtKMZv2x7nDalUMIY4mav7k+qX48BH0Nr8u04N0IjzBbGrhN8RR7ANqG1hK41cRdxyPT9sNoP6bpl+Xmo6Vkye9/QtS1dcM6Aky2FDN5oL3Hq/Awmi7Gfx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qW+hc4+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5726C4CEE7;
	Thu, 21 Aug 2025 01:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755739036;
	bh=Vl1HTqR85aGJ60RDemuuoE+HKDeTXYHvsBBxEM7qP5A=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=qW+hc4+DYkcJtkf+YrL+pRRgqqeGF5481nPbXDnzRqwZWL9AqyFrMPvz5v5kHAanD
	 Ys3nHWw62gaXA3gHpQqB/M6NS151QHjaNxsnmjDM597B27mmgCmgkERNpPquXN6v0m
	 r6NSCmD/UJvZRv/36JQVElhaPKTrcuBT0nbxToKVIwDhLWWd+Q3BsNlvOlZXU/r6Hu
	 Smq1gPH5QdszrCkB52hctcbFc0wTBS/NkRlD0VPgpbqwpZNJcHlKW/cRHwHtsS9ETf
	 HxQmygPk8WL3QwbuU1oo1aJrM6VJ1w9r61/ct0D9v8TS9mlGLWOyqF4nESnsac5AEz
	 qJ+TN+ZBZdnJw==
Date: Wed, 20 Aug 2025 18:17:16 -0700
Subject: [PATCH 06/19] fuse2fs: add extent dump function for debugging
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573713838.21970.8881520552720760067.stgit@frogsfrogsfrogs>
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

Add a function to dump an inode's extent map for debugging purposes.
This helped debug a problem with generic/299 failing on 1k fsblock
filesystems:

--- a/tests/generic/299.out	2025-07-15 14:45:15.030113607 -0700
+++ b/tests/generic/299.out.bad	2025-07-16 19:33:50.889344998 -0700
@@ -3,3 +3,4 @@ QA output created by 299
 Run fio with random aio-dio pattern

 Start fallocate/truncate loop
+fio: io_u error on file /opt/direct_aio.0.0: Input/output error: write offset=2602827776, buflen=131072

(The cause of this was misuse of the libext2fs extent code)

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 misc/fuse4fs.c |   73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 146 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 1dda9c45cb5089..4a9fda62f99bc2 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -578,6 +578,74 @@ static inline int fuse2fs_iomap_enabled(const struct fuse2fs *ff)
 # define fuse2fs_iomap_enabled(...)	(0)
 #endif
 
+static inline void fuse2fs_dump_extents(struct fuse2fs *ff, ext2_ino_t ino,
+					struct ext2_inode_large *inode,
+					const char *why)
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
+	printf("%s: %s ino=%u isize %llu iblocks %llu\n", __func__, why, ino,
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
+		printf("[%u]: %s ino=%u lblk 0x%llx pblk 0x%llx len 0x%x flags 0x%x\n",
+		       nr++, why, ino, extent.e_lblk, extent.e_pblk,
+		       extent.e_len, extent.e_flags);
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
@@ -5433,6 +5501,11 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
 		   (unsigned long long)read->length,
 		   read->type);
 
+	/* Not filling even the first byte will make the kernel unhappy. */
+	if (ff->debug && (read->offset > pos ||
+			  read->offset + read->length <= pos))
+		fuse2fs_dump_extents(ff, attr_ino, &inode, "BAD DATA");
+
 out_unlock:
 	fuse2fs_finish(ff, ret);
 	return ret;
diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index 2aa7ab646592e9..0ac5de90498dac 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -730,6 +730,74 @@ static inline int fuse4fs_iomap_enabled(const struct fuse4fs *ff)
 # define fuse4fs_iomap_enabled(...)	(0)
 #endif
 
+static inline void fuse4fs_dump_extents(struct fuse4fs *ff, ext2_ino_t ino,
+					struct ext2_inode_large *inode,
+					const char *why)
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
+		retval = fuse4fs_read_inode(fs, ino, inode);
+		if (retval) {
+			com_err(__func__, retval, _("reading ino %u"), ino);
+			return;
+		}
+	}
+
+	if (!(inode->i_flags & EXT4_EXTENTS_FL))
+		return;
+
+	printf("%s: %s ino=%u isize %llu iblocks %llu\n", __func__, why, ino,
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
+		printf("[%u]: %s ino=%u lblk 0x%llx pblk 0x%llx len 0x%x flags 0x%x\n",
+		       nr++, why, ino, extent.e_lblk, extent.e_pblk,
+		       extent.e_len, extent.e_flags);
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
@@ -5839,6 +5907,11 @@ static void op_iomap_begin(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
 		   read.type,
 		   read.flags);
 
+	/* Not filling even the first byte will make the kernel unhappy. */
+	if (ff->debug && (read.offset > pos ||
+			  read.offset + read.length <= pos))
+		fuse4fs_dump_extents(ff, ino, &inode, "BAD DATA");
+
 out_unlock:
 	fuse4fs_finish(ff, ret);
 	if (ret)


