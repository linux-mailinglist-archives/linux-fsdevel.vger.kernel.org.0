Return-Path: <linux-fsdevel+bounces-66098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B15C17C71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D869189AEE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC452D9497;
	Wed, 29 Oct 2025 01:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3sT+q4r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63993A1CD;
	Wed, 29 Oct 2025 01:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700202; cv=none; b=Nb8TaLbNlfGSA4bg3JtGjHCYAeVDu7zH+a3s9ku0goSShyu//0wcMYW1WN0w24BshVLY2g4f47EbyD0XCwsDRt5Qt/mCXeWeF/+hHiybw0VB3nJltN3sFFYukzWLZ6HB5l3vyPdLu6JpF/rOLUIk486AbqFZCMGvfxHli4Te2C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700202; c=relaxed/simple;
	bh=QFewkSQHdfBFyDFpuQxeGs+ltQlebz+W18yXu6PgQLc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HA0EsA+HuKZyf400laWdeEJiKnTZVxgL6xIrgQ0GTvIKcybyArMJTRl2cpeJYLxvWDQoomk6biKRxYjHs7gxX9ilt/PqyrFjtvJgkyAvbN27VuE9MyqvZlt93HQ9Y6U/ZoeYhJnuyDAD/dNg1ZqCvTyGwenAyh7BVtOFhEnrzTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3sT+q4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDF7C4CEE7;
	Wed, 29 Oct 2025 01:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700200;
	bh=QFewkSQHdfBFyDFpuQxeGs+ltQlebz+W18yXu6PgQLc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Z3sT+q4rsd/LmHmzmHXQepKvLK/0A/YGMSUQy62MSwz+jtNCMaxyyufZtidS6Arhf
	 LSirg+1sFIlJNByOacdyaR+HqwiVIySi9NdafYvxGxoelqTtJNWAyY6QKlSkhvdK+h
	 gg9D7qTK7Y9gC5aHyMaLIIO4WAjyBh8VvFmDaeC+BfHusWNMP+hVwsIZX5a7tMDxg+
	 5mwhufOkORxi/lIFK5JgLyf8cIcOoF0fYjvOAElEvwywdkvDrM3U5rjkuOdEiK9qdw
	 RnxeLl7iBLRu4RSbCgX7XUtsv38s2G2cZSRWVGW4PpkVfzp0nfELmU5jaYA7lvOMGW
	 d18+DgvDt3rXA==
Date: Tue, 28 Oct 2025 18:09:59 -0700
Subject: [PATCH 06/17] fuse2fs: add extent dump function for debugging
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169817670.1429568.4452309826792905922.stgit@frogsfrogsfrogs>
In-Reply-To: <176169817482.1429568.16747148621305977151.stgit@frogsfrogsfrogs>
References: <176169817482.1429568.16747148621305977151.stgit@frogsfrogsfrogs>
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
 fuse4fs/fuse4fs.c |   73 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 misc/fuse2fs.c    |   73 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 146 insertions(+)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index d8523ec8bbecc9..3b6938c6caeaf2 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -889,6 +889,74 @@ static inline int fuse4fs_iomap_enabled(const struct fuse4fs *ff)
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
@@ -6210,6 +6278,11 @@ static void op_iomap_begin(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
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
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index f0bb19ef4c8b30..556f728051eba1 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -728,6 +728,74 @@ static inline int fuse2fs_iomap_enabled(const struct fuse2fs *ff)
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
@@ -5658,6 +5726,11 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
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


