Return-Path: <linux-fsdevel+bounces-58538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99F4B2EA6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BCCD5A85B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04B31FAC42;
	Thu, 21 Aug 2025 01:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiO4WEZ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494EF36CE02;
	Thu, 21 Aug 2025 01:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739068; cv=none; b=CFrBMSbQlF1NJ6Z3S7nZWVD/QQ5me8U1/KzYhdnCbSeN+8ZNYiAhITI2hy8CcZyimeN/DRnLNobp4f8mKU8tRsz+Iauf5rUBmXo3cBdwJ0Qq6GRULHDBTK7gYoIK77w4x8Gl+u8CJotpCBKKL5tJXjotVvoAk3S+v1E1CoCDHpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739068; c=relaxed/simple;
	bh=/gPbcysrjtMctzAG0T7R6pjzx6LNUnc6Lm5he4s1L08=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MN/QOOA7vHlDDW9vv57XCMBiD6AoGvEe5+ht4uu+/9CeVuLbLRh2f2cC438vdtqYcDUxAaK3/dgy7TipyFooOLMTeIq74Cu2HQ6BRJoK9oNzlgOQoNlK5RawEnXxiWjYuqRmACxe32HTF8avptFB1Rpwrj3iih52arOH7joKHW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiO4WEZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED25C4CEEB;
	Thu, 21 Aug 2025 01:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755739068;
	bh=/gPbcysrjtMctzAG0T7R6pjzx6LNUnc6Lm5he4s1L08=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=OiO4WEZ2XtvXNyRAc+ZjzkYhl22GU4/ROmKlJNaxXV3SCMhoxYwcYUKhAwPnO5JRR
	 /Tp+GEq81tZxiEuPZQNebtlu4JBwvResguMU8dsRfdhp2cNke9ApTcBR/UiRsOVye8
	 s5vqlNSpBKUNTJE5HTFzBAMI+4bI1tJut+PuYEjfQA1OmNa4pGYSWNl44I1MXSIxrm
	 ijKmn3h3Hd7mfu9nkFAD4CU9TMSHiK05PLCKJWR5eyJpxjhSyq6URRQ3WvkThDMQqw
	 2yB2CGegxx6lUaiJMb8c95NxlFW2zT61aQ3QLbcbmNL/kMLcyGhn6IHeJNnSa7ZEwj
	 /x/NGWVn2PBMg==
Date: Wed, 20 Aug 2025 18:17:47 -0700
Subject: [PATCH 08/19] fuse2fs: turn on iomap for pagecache IO
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573713874.21970.7909523404730526756.stgit@frogsfrogsfrogs>
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

Turn on iomap for pagecache IO to regular files.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   61 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 misc/fuse4fs.c |   61 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 108 insertions(+), 14 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index e8e9056a661e71..895addcbc59e04 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -5427,9 +5427,6 @@ static int fuse2fs_iomap_begin_read(struct fuse2fs *ff, ext2_ino_t ino,
 				    uint64_t count, uint32_t opflags,
 				    struct fuse_file_iomap *read)
 {
-	if (!(opflags & FUSE_IOMAP_OP_DIRECT))
-		return -ENOSYS;
-
 	/* fall back to slow path for inline data reads */
 	if (inode->i_flags & EXT4_INLINE_DATA_FL)
 		return -ENOSYS;
@@ -5517,9 +5514,6 @@ static int fuse2fs_iomap_begin_write(struct fuse2fs *ff, ext2_ino_t ino,
 	off_t max_size = fuse2fs_max_file_size(ff, inode);
 	int ret;
 
-	if (!(opflags & FUSE_IOMAP_OP_DIRECT))
-		return -ENOSYS;
-
 	if (pos >= max_size)
 		return -EFBIG;
 
@@ -5611,11 +5605,50 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
 	return ret;
 }
 
+static int fuse2fs_iomap_append_setsize(struct fuse2fs *ff, ext2_ino_t ino,
+					loff_t newsize)
+{
+	ext2_filsys fs = ff->fs;
+	struct ext2_inode_large inode;
+	ext2_off64_t isize;
+	errcode_t err;
+
+	dbg_printf(ff, "%s: ino=%u newsize=%llu\n", __func__, ino,
+		   (unsigned long long)newsize);
+
+	err = fuse2fs_read_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	isize = EXT2_I_SIZE(&inode);
+	if (newsize <= isize)
+		return 0;
+
+	dbg_printf(ff, "%s: ino=%u oldsize=%llu newsize=%llu\n", __func__, ino,
+		   (unsigned long long)isize,
+		   (unsigned long long)newsize);
+
+	/*
+	 * XXX cheesily update the ondisk size even though we only want to do
+	 * the incore size until writeback happens
+	 */
+	err = ext2fs_inode_size_set(fs, EXT2_INODE(&inode), newsize);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	err = fuse2fs_write_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	return 0;
+}
+
 static int op_iomap_end(const char *path, uint64_t nodeid, uint64_t attr_ino,
 			off_t pos, uint64_t count, uint32_t opflags,
 			ssize_t written, const struct fuse_file_iomap *iomap)
 {
 	struct fuse2fs *ff = fuse2fs_get();
+	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 
@@ -5630,7 +5663,21 @@ static int op_iomap_end(const char *path, uint64_t nodeid, uint64_t attr_ino,
 		   written,
 		   iomap->flags);
 
-	return 0;
+	fuse2fs_start(ff);
+
+	/* XXX is this really necessary? */
+	if ((opflags & FUSE_IOMAP_OP_WRITE) &&
+	    !(opflags & FUSE_IOMAP_OP_DIRECT) &&
+	    (iomap->flags & FUSE_IOMAP_F_SIZE_CHANGED) &&
+	    written > 0) {
+		ret = fuse2fs_iomap_append_setsize(ff, attr_ino, pos + written);
+		if (ret)
+			goto out_unlock;
+	}
+
+out_unlock:
+	fuse2fs_finish(ff, ret);
+	return ret;
 }
 
 /*
diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index ff50182b929974..2373c5a371e2b0 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -5835,9 +5835,6 @@ static int fuse4fs_iomap_begin_read(struct fuse4fs *ff, ext2_ino_t ino,
 				    uint64_t count, uint32_t opflags,
 				    struct fuse_file_iomap *read)
 {
-	if (!(opflags & FUSE_IOMAP_OP_DIRECT))
-		return -ENOSYS;
-
 	/* fall back to slow path for inline data reads */
 	if (inode->i_flags & EXT4_INLINE_DATA_FL)
 		return -ENOSYS;
@@ -5928,9 +5925,6 @@ static int fuse4fs_iomap_begin_write(struct fuse4fs *ff, ext2_ino_t ino,
 	off_t max_size = fuse4fs_max_file_size(ff, inode);
 	int ret;
 
-	if (!(opflags & FUSE_IOMAP_OP_DIRECT))
-		return -ENOSYS;
-
 	if (pos >= max_size)
 		return -EFBIG;
 
@@ -6023,12 +6017,51 @@ static void op_iomap_begin(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
 		fuse_reply_iomap_begin(req, &read, NULL);
 }
 
+static int fuse4fs_iomap_append_setsize(struct fuse4fs *ff, ext2_ino_t ino,
+					loff_t newsize)
+{
+	ext2_filsys fs = ff->fs;
+	struct ext2_inode_large inode;
+	ext2_off64_t isize;
+	errcode_t err;
+
+	dbg_printf(ff, "%s: ino=%u newsize=%llu\n", __func__, ino,
+		   (unsigned long long)newsize);
+
+	err = fuse4fs_read_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	isize = EXT2_I_SIZE(&inode);
+	if (newsize <= isize)
+		return 0;
+
+	dbg_printf(ff, "%s: ino=%u oldsize=%llu newsize=%llu\n", __func__, ino,
+		   (unsigned long long)isize,
+		   (unsigned long long)newsize);
+
+	/*
+	 * XXX cheesily update the ondisk size even though we only want to do
+	 * the incore size until writeback happens
+	 */
+	err = ext2fs_inode_size_set(fs, EXT2_INODE(&inode), newsize);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	err = fuse4fs_write_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	return 0;
+}
+
 static void op_iomap_end(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
 			 off_t pos, uint64_t count, uint32_t opflags,
 			 ssize_t written, const struct fuse_file_iomap *iomap)
 {
 	struct fuse4fs *ff = fuse4fs_get(req);
 	ext2_ino_t ino;
+	int ret = 0;
 
 	FUSE4FS_CHECK_CONTEXT(req);
 	FUSE4FS_CONVERT_FINO(req, &ino, fino);
@@ -6042,7 +6075,21 @@ static void op_iomap_end(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
 		   written,
 		   iomap->flags);
 
-	fuse_reply_err(req, 0);
+	fuse4fs_start(ff);
+
+	/* XXX is this really necessary? */
+	if ((opflags & FUSE_IOMAP_OP_WRITE) &&
+	    !(opflags & FUSE_IOMAP_OP_DIRECT) &&
+	    (iomap->flags & FUSE_IOMAP_F_SIZE_CHANGED) &&
+	    written > 0) {
+		ret = fuse4fs_iomap_append_setsize(ff, ino, pos + written);
+		if (ret)
+			goto out_unlock;
+	}
+
+out_unlock:
+	fuse4fs_finish(ff, ret);
+	fuse_reply_err(req, -ret);
 }
 
 /*


