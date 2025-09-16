Return-Path: <linux-fsdevel+bounces-61632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC7EB58A7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EBD11B2673F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E138819FA93;
	Tue, 16 Sep 2025 01:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EY+2T2fs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A101397;
	Tue, 16 Sep 2025 01:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984482; cv=none; b=srEWZ82QK3RoO22/YRZ+TjyDxlAFDZ3QWLT3InrseMDY4J6z4HURCvT/rcoj8AulIlUkMyQHLYsTA+ZaLFeRcH1kB0YJeYuWQRjAGJ507nEWWTUz80NsRr+Psmr1oCAV1D+4GDTi4nm4CbITbM0BUR+TM9dANZfV03fPxzttVuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984482; c=relaxed/simple;
	bh=ginj6b2nRSSmrZOjFmGQnQ309xkf9/QvMbceCZFM8EM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hici12xmE8Ms8qF7n4OBzwoGc03RQZwhZJaPy1SNpxHnNH2IePcxnS65T70d/zFAYNR/8/IYS0xq/p/8HmLR4Ubc3vdFhuWbR+p8z7ESG6yNU8I/4YWbWkHdY4ef6IiILsgG+XL/0ObltepuYZPylfTs55EGEMcZY+rHURvoNGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EY+2T2fs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AEAC4CEF1;
	Tue, 16 Sep 2025 01:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984481;
	bh=ginj6b2nRSSmrZOjFmGQnQ309xkf9/QvMbceCZFM8EM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=EY+2T2fskR/+nDYMnAwMkdyKqkOSgTHQSzEuzPZVT64lX3Z33JzuJtjXCb4PBRMZi
	 HSs3E4Ai84m7JoZG+tZQv5VK8PrRn7dlB7a5ExDJG26sVDQ0j8AsuyaOILASWhjjz3
	 l61b0F1+yt4P4Yu6WQdOEJhamEfAXf/2CC2IawXmoREtk2moJiR9YyT7nm4TppoP00
	 maofFkXaODwg+EVJP7LbW5l6bqYE6fIfOfW9TJ1HSARVoUzq+qyTBUnYpQghVZC9cI
	 OFq8Q0mVyzxX6UTm+fO9w42/HX+1V2EbxpXgPrZnf79+z7+pMivYqY4v47JC8xiflj
	 7kjjybw6ZN/7g==
Date: Mon, 15 Sep 2025 18:01:21 -0700
Subject: [PATCH 10/17] fuse2fs: don't do file data block IO when iomap is
 enabled
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798161900.390496.13332466675744316554.stgit@frogsfrogsfrogs>
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

When iomap is in use for the page cache, the kernel will take care of
all the file data block IO for us, including zeroing of punched ranges
and post-EOF bytes.  fuse2fs only needs to do IO for inline data.

Therefore, set the NOBLOCKIO ext2_file flag so that libext2fs will not
do any regular file IO to or from disk blocks at all.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   11 +++++++-
 misc/fuse2fs.c    |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 81 insertions(+), 2 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 6c9e725d54b87a..e482b00f14d572 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -3408,9 +3408,14 @@ static int fuse4fs_truncate(struct fuse4fs *ff, ext2_ino_t ino, off_t new_size)
 	ext2_file_t file;
 	__u64 old_isize;
 	errcode_t err;
+	int flags = EXT2_FILE_WRITE;
 	int ret = 0;
 
-	err = ext2fs_file_open(fs, ino, EXT2_FILE_WRITE, &file);
+	/* the kernel handles all eof zeroing for us in iomap mode */
+	if (fuse4fs_iomap_enabled(ff))
+		flags |= EXT2_FILE_NOBLOCKIO;
+
+	err = ext2fs_file_open(fs, ino, flags, &file);
 	if (err)
 		return translate_error(fs, ino, err);
 
@@ -3505,6 +3510,10 @@ static int fuse4fs_open_file(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 	if (linked)
 		check |= L_OK;
 
+	/* the kernel handles all block IO for us in iomap mode */
+	if (fuse4fs_iomap_enabled(ff))
+		file->open_flags |= EXT2_FILE_NOBLOCKIO;
+
 	/*
 	 * If the caller wants to truncate the file, we need to ask for full
 	 * write access even if the caller claims to be appending.
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 5dbd8c5a17f79d..c13bd6c3baf9c9 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3145,15 +3145,72 @@ static int fuse2fs_punch_posteof(struct fuse2fs *ff, ext2_ino_t ino,
 	return 0;
 }
 
+/*
+ * Decide if file IO for this inode can use iomap.
+ *
+ * It turns out that libfuse creates internal node ids that have nothing to do
+ * with the ext2_ino_t that we give it.  These internal node ids are what
+ * actually gets igetted in the kernel, which means that there can be multiple
+ * fuse_inode objects in the kernel for a single hardlinked ondisk ext2 inode.
+ *
+ * What this means, horrifyingly, is that on a fuse filesystem that supports
+ * hard links, the in-kernel i_rwsem does not protect against concurrent writes
+ * between files that point to the same inode.  That in turn means that the
+ * file mode and size can get desynchronized between the multiple fuse_inode
+ * objects.  This also means that we cannot cache iomaps in the kernel AT ALL
+ * because the caches will get out of sync, leading to WARN_ONs from the iomap
+ * zeroing code and probably data corruption after that.
+ *
+ * Therefore, libfuse won't let us create hardlinks of iomap files, and we must
+ * never turn on iomap for existing hardlinked files.  Long term it means we
+ * have to find a way around this loss of functionality.  fuse4fs gets around
+ * this by being a low level fuse driver and controlling the nodeids itself.
+ *
+ * Returns 0 for no, 1 for yes, or a negative errno.
+ */
+#ifdef HAVE_FUSE_IOMAP
+static int fuse2fs_file_uses_iomap(struct fuse2fs *ff, ext2_ino_t ino)
+{
+	struct stat statbuf;
+	int ret;
+
+	if (!fuse2fs_iomap_enabled(ff))
+		return 0;
+
+	ret = stat_inode(ff->fs, ino, &statbuf);
+	if (ret)
+		return ret;
+
+	/* the kernel handles all block IO for us in iomap mode */
+	return fuse_fs_can_enable_iomap(&statbuf);
+}
+#else
+# define fuse2fs_file_uses_iomap(...)	(0)
+#endif
+
 static int fuse2fs_truncate(struct fuse2fs *ff, ext2_ino_t ino, off_t new_size)
 {
 	ext2_filsys fs = ff->fs;
 	ext2_file_t file;
 	__u64 old_isize;
 	errcode_t err;
+	int flags = EXT2_FILE_WRITE;
 	int ret = 0;
 
-	err = ext2fs_file_open(fs, ino, EXT2_FILE_WRITE, &file);
+	/* the kernel handles all eof zeroing for us in iomap mode */
+	ret = fuse2fs_file_uses_iomap(ff, ino);
+	switch (ret) {
+	case 0:
+		break;
+	case 1:
+		flags |= EXT2_FILE_NOBLOCKIO;
+		ret = 0;
+		break;
+	default:
+		return ret;
+	}
+
+	err = ext2fs_file_open(fs, ino, flags, &file);
 	if (err)
 		return translate_error(fs, ino, err);
 
@@ -3308,6 +3365,19 @@ static int __op_open(struct fuse2fs *ff, const char *path,
 			goto out;
 	}
 
+	/* the kernel handles all block IO for us in iomap mode */
+	ret = fuse2fs_file_uses_iomap(ff, file->ino);
+	switch (ret) {
+	case 0:
+		break;
+	case 1:
+		file->open_flags |= EXT2_FILE_NOBLOCKIO;
+		ret = 0;
+		break;
+	default:
+		goto out;
+	}
+
 	if (fp->flags & O_TRUNC) {
 		ret = fuse2fs_truncate(ff, file->ino, 0);
 		if (ret)


