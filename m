Return-Path: <linux-fsdevel+bounces-66100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99794C17C85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D492B401534
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0E42D8767;
	Wed, 29 Oct 2025 01:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpMyINiE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55491A5B9E;
	Wed, 29 Oct 2025 01:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700231; cv=none; b=Rn2o63KJBE6ywKkshIWA74qsTAgjbPB+LzU6LlCltX/a0628r8dimunwahZIxVJhVB7zutpCkyd/sRntarjPpRWnJFjdOcJ/StShn4GioNiJfXjo8c2AMpI+vZMJCMREIWkno0FcKLahTtESEQWvqQSEnZGCU+ia0bEkx1kgrnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700231; c=relaxed/simple;
	bh=V9ROOmWedUXzImN/gZDy9twaIJVXCNmvCf+izTW2DcE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VPtoECCJFDHIpNOaA+OV9zNSnlOyLJwkd9OGTnHo3VrDbAkn9CMAnJz1pAUH4sgEhYcg/YpxkygJKnZm/YobaBzCK7jOQdmDae6hn+rF3ZNUXHIXD1naVK0wgRDqnyuD2ZnKdQjr8Nc/Fq7EisyZhBPQZdIHpLQbeWDFm1IY1qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpMyINiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFDBC4CEE7;
	Wed, 29 Oct 2025 01:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700231;
	bh=V9ROOmWedUXzImN/gZDy9twaIJVXCNmvCf+izTW2DcE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=DpMyINiEoP4wS+e7e0hy+G+fTOWdarUrgxrrzLjoqgFpmpzQqYqA4PeRjGybb6L9z
	 BTj/g229P9nz0hFUHWV9GmFEcjrh8OetPYfxoZCVF8jV15r6t5bTTaqg40yvR/zg6n
	 ILtPK3Rer1MBT6pDn1RXiUNDG9R7/fh2+XXmt8JTYYjiJFqPoePx7v8CJU2gAmfuw5
	 T4eZUpKqY4tYeHvKw13P2UPNlUn5LSez42lL0+c2V9tVUzZiBGCstH2yKE2vPUHtXB
	 nv/uUg7VNcsxwwjrLNnPxMqQmE1QRdj/Dk383mriEgLmID17xygd/5IuukYzvNUoaD
	 qZ+pj6Awpoh2Q==
Date: Tue, 28 Oct 2025 18:10:31 -0700
Subject: [PATCH 08/17] fuse2fs: turn on iomap for pagecache IO
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169817708.1429568.16480817405354449021.stgit@frogsfrogsfrogs>
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

Turn on iomap for pagecache IO to regular files.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   61 +++++++++++++++++++++++++++++++++++++++++++++++------
 misc/fuse2fs.c    |   61 +++++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 108 insertions(+), 14 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 0f66a5fedb3c51..4c12c082046ea1 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -6206,9 +6206,6 @@ static int fuse4fs_iomap_begin_read(struct fuse4fs *ff, ext2_ino_t ino,
 				    uint64_t count, uint32_t opflags,
 				    struct fuse_file_iomap *read)
 {
-	if (!(opflags & FUSE_IOMAP_OP_DIRECT))
-		return -ENOSYS;
-
 	/* fall back to slow path for inline data reads */
 	if (inode->i_flags & EXT4_INLINE_DATA_FL)
 		return -ENOSYS;
@@ -6299,9 +6296,6 @@ static int fuse4fs_iomap_begin_write(struct fuse4fs *ff, ext2_ino_t ino,
 	off_t max_size = fuse4fs_max_file_size(ff, inode);
 	int ret;
 
-	if (!(opflags & FUSE_IOMAP_OP_DIRECT))
-		return -ENOSYS;
-
 	if (pos >= max_size)
 		return -EFBIG;
 
@@ -6394,12 +6388,51 @@ static void op_iomap_begin(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
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
@@ -6413,7 +6446,21 @@ static void op_iomap_end(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
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
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index fea0711003b0ed..17195ffadf0ab3 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -5652,9 +5652,6 @@ static int fuse2fs_iomap_begin_read(struct fuse2fs *ff, ext2_ino_t ino,
 				    uint64_t count, uint32_t opflags,
 				    struct fuse_file_iomap *read)
 {
-	if (!(opflags & FUSE_IOMAP_OP_DIRECT))
-		return -ENOSYS;
-
 	/* fall back to slow path for inline data reads */
 	if (inode->i_flags & EXT4_INLINE_DATA_FL)
 		return -ENOSYS;
@@ -5742,9 +5739,6 @@ static int fuse2fs_iomap_begin_write(struct fuse2fs *ff, ext2_ino_t ino,
 	off_t max_size = fuse2fs_max_file_size(ff, inode);
 	int ret;
 
-	if (!(opflags & FUSE_IOMAP_OP_DIRECT))
-		return -ENOSYS;
-
 	if (pos >= max_size)
 		return -EFBIG;
 
@@ -5836,11 +5830,50 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
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
 
@@ -5855,7 +5888,21 @@ static int op_iomap_end(const char *path, uint64_t nodeid, uint64_t attr_ino,
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


