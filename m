Return-Path: <linux-fsdevel+bounces-58540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA11BB2EA65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55D41C237A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2734B1F9A89;
	Thu, 21 Aug 2025 01:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0ChXSR1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8471F36CE02;
	Thu, 21 Aug 2025 01:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739099; cv=none; b=TobQAkkbRBNaOPJXS5WdDcjWbDSKoQs2nlc8JzdbBFZpOl8d3FTegkRoOzBbjyagGQdMWSsrEejziZQoTXlB7kvmleNsyRcKXupss4IUTMrm/inDYAnsbiH+Jos0NhUfGjAGUUxEVZnLgIV5lZDtkCCQBkiZ6LoIX9OmLBT/e2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739099; c=relaxed/simple;
	bh=muvZo+H/gQjNtsUUjd2MzO03K6bEwjdULby8divz+N0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbIlswbrouxENNOrtLfeXOfT2wGQkOMMIp/9mtyw4gv88nY6IdNTNrDverZFhKCaJ7eer38Ip1kNf3akQNqQXhSPvK9LGWa0SohVmcLFHj5jF0otHPvYWIwkElOi8XEGYgAqByWKTAubtEE6p5tCn5Ud3W5K5bcpasPx1spjkLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0ChXSR1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC73C4CEE7;
	Thu, 21 Aug 2025 01:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755739099;
	bh=muvZo+H/gQjNtsUUjd2MzO03K6bEwjdULby8divz+N0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=p0ChXSR1Ki3bXFU/mvLmHTPHM36BlfRv9BQQCqAG1lCQl1HaVDcehkbw+rFSLnwLb
	 S9UaNPmAIJ2LRJ94u0OuTeyZRlDAMytfr52xgLfxdf3ZDfUVLFOr2B5xCy6OCvWyjm
	 tKiWdhUMAWIu98OWJqyQwZeWzoa+s4bjKAyDd1uPvaMKCxP9v5DEK6c1AYdoRTEQ1y
	 X0VIAiFfQeb+E49GwFdeTU7oFZS/AEgAwnf5AB4myeIeBXm7Ut0scfMF/E5Waq27r/
	 VzQJyapTXVLOwFiyENfWSf6DgCNU6HCEOQ7DFa/UPnzzDGuF3Ww9RI8uAQ0klD6KrN
	 Il42I+SN60FPQ==
Date: Wed, 20 Aug 2025 18:18:18 -0700
Subject: [PATCH 10/19] fuse2fs: don't do file data block IO when iomap is
 enabled
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573713910.21970.597991894155936504.stgit@frogsfrogsfrogs>
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

When iomap is in use for the page cache, the kernel will take care of
all the file data block IO for us, including zeroing of punched ranges
and post-EOF bytes.  fuse2fs only needs to do IO for inline data.

Therefore, set the NOBLOCKIO ext2_file flag so that libext2fs will not
do any regular file IO to or from disk blocks at all.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   72 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 misc/fuse4fs.c |   11 ++++++++-
 2 files changed, 81 insertions(+), 2 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index dcf002f380b843..588b0053f43c95 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3158,15 +3158,72 @@ static int fuse2fs_punch_posteof(struct fuse2fs *ff, ext2_ino_t ino,
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
 
@@ -3324,6 +3381,19 @@ static int __op_open(struct fuse2fs *ff, const char *path,
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
diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index 3082c23e398adf..e08c5af5abfd27 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -3375,9 +3375,14 @@ static int fuse4fs_truncate(struct fuse4fs *ff, ext2_ino_t ino, off_t new_size)
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
 
@@ -3472,6 +3477,10 @@ static int fuse4fs_open_file(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 	if (linked)
 		check |= L_OK;
 
+	/* the kernel handles all block IO for us in iomap mode */
+	if (fuse4fs_iomap_enabled(ff))
+		file->open_flags |= EXT2_FILE_NOBLOCKIO;
+
 	/*
 	 * If the caller wants to truncate the file, we need to ask for full
 	 * write access even if the caller claims to be appending.


