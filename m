Return-Path: <linux-fsdevel+bounces-61628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF33DB58A72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C713AC809
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270AC1F1513;
	Tue, 16 Sep 2025 01:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+BGTXOW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABD91D7984;
	Tue, 16 Sep 2025 01:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984418; cv=none; b=NlJisYk8ylMhUPxywz6K8bm0/Kku7tyPefXV2XP0YlHtDN1N8WJ4l3Hq9n1yjfRDeHDU78TbLuyh00xfZ73NiBKvc66pWuXSKvIr6HBZm+n/BUyo0llPYNufxniHeVyypIXQdNMi+CYXgMpW77YfNMy2QhDOmrnOA1HIzJih69k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984418; c=relaxed/simple;
	bh=d6pzn8HnZ/WeKlM+TITnm19T7lzdohP/7Za2zAtABMg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emApKdP7C00cbsgSgr8cAKRjHrGVcVxBNpLluVN2MyKtwfxsRLVLzEQiSS7Ix0/oMK7gTJP/5BmYXLJjTo62mHev5AHBtfW1NCMp0QvMkT7vz5BcRkUHdiaCXGWLIUM21TN2K6G/O+MURzdX5Z7hqhGW4t4Kyha2Wl1sWNMOka0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+BGTXOW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F3BC4CEF5;
	Tue, 16 Sep 2025 01:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984417;
	bh=d6pzn8HnZ/WeKlM+TITnm19T7lzdohP/7Za2zAtABMg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=E+BGTXOWAux5ELX2l9AMS/1qt2eWaRWjwPy+o2AXzdh6xXQU7W1k5jvtu5Bsd/kVc
	 flJmy9xVHYfCxit0NDQ+f2kBwbIIsCei0ko10kvla0jCUxSn1A0llMIa6DrNE9DeAX
	 JWWj6y2ajz1LMBK/3oByMYbP85oSp53pytBvvHMc61MQlzrCBVtnmXyu9kS2SxBPkP
	 8b/Zx0z55V3juN3NLLh+v1kq0I/+YoqPfO5/sM1Prdq1Ybtk1kRG0Hwz+vOvz/WnDC
	 17LndcSUOLvo/b3hpluZZqLhW//c5e+TWXQ5GKRzh/piPUdqGygsEdX+VBCs98nWF0
	 HUrEareMP6Dfg==
Date: Mon, 15 Sep 2025 18:00:17 -0700
Subject: [PATCH 06/17] fuse2fs: add extent dump function for debugging
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798161827.390496.15257362546342259764.stgit@frogsfrogsfrogs>
In-Reply-To: <175798161643.390496.10274066827486065265.stgit@frogsfrogsfrogs>
References: <175798161643.390496.10274066827486065265.stgit@frogsfrogsfrogs>
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
index 90d94bb7404f90..03fc25de7b6fbb 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -735,6 +735,74 @@ static inline int fuse4fs_iomap_enabled(const struct fuse4fs *ff)
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
@@ -5907,6 +5975,11 @@ static void op_iomap_begin(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
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
index 31fd882dac4ef6..76540f4fc3c694 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -572,6 +572,74 @@ static inline int fuse2fs_iomap_enabled(const struct fuse2fs *ff)
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
@@ -5351,6 +5419,11 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
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


