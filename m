Return-Path: <linux-fsdevel+bounces-66102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA41C17C98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2205F500295
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB9A2DAFAC;
	Wed, 29 Oct 2025 01:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBekQrl1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0116A2D9ED7;
	Wed, 29 Oct 2025 01:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700263; cv=none; b=BdTHvYPEsdmvxmUMKzKDf43ETbGOsPCIqjdSG7F73nVb387pWSloBQojlet50aOjaB0s4qj4+Trql5Wm3JFrG6x2I2xU+bv709JECOVGWqbb34S/Btx+NMtf38YcmySJVew8Ty1OlBPGoYbBoZbvtpRVbzhiSXtdvRPOQSUxMHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700263; c=relaxed/simple;
	bh=HwysEEEfkDJulHeEI7Vb5QA3pBKD9YRsn45bXNFFdns=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/tHIOJydlF39NfJ1/DnmskstXe9FeYGd0FVq62RE1Ir1tOlq+ktfAmEOnMH1eerTaqQwc+yFkmmUYp1Br83OoSFCwRYXLL6bwFt9ib7jjkSdGb+Y1YwWjGq7j8xApDYdvLZxG22FF5vow8xhoXgtwULpiZ0zItH2ttiSnIVP34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBekQrl1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE376C4CEE7;
	Wed, 29 Oct 2025 01:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700262;
	bh=HwysEEEfkDJulHeEI7Vb5QA3pBKD9YRsn45bXNFFdns=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=HBekQrl1aoJ3cnXC4yjGJrbcj85xXAqFG6T3Blmv2q+IcxspShqXJFWcoHDpmo6wP
	 B0paYA6OtBXkRxyojyS3B1ROA5vrPK7ynEmbNPXnESez6qQYBpwvJMUr7f8a9eJZnm
	 dXFXTWKEu4natHU4Itf8XY5ttx9VLtZwGaNy7rnNkzOxjtRd+VnC4KpQOTKYuy0ocq
	 9rtCnJzpgNjJUBjl8PJ8YNi2Ww65M+X4IOWArl987B3CgH9VmvXjnTDfWJ0Tigbuav
	 bNT38/j8tshzWyiiX6nBdAKnO9+Ogs79JjZ+8LdG3iKIR1EJeELysWMQenEjD4sGJA
	 3p3xgoBjc5fpQ==
Date: Tue, 28 Oct 2025 18:11:02 -0700
Subject: [PATCH 10/17] fuse2fs: don't do file data block IO when iomap is
 enabled
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169817744.1429568.4365910811410016784.stgit@frogsfrogsfrogs>
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
index 3cf9610435a44c..10ad29236264a1 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -3708,9 +3708,14 @@ static int fuse4fs_truncate(struct fuse4fs *ff, ext2_ino_t ino, off_t new_size)
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
 
@@ -3805,6 +3810,10 @@ static int fuse4fs_open_file(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
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
index 55d1fe3dcd4c8d..7e74603f5f4eee 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3449,15 +3449,72 @@ static int fuse2fs_punch_posteof(struct fuse2fs *ff, ext2_ino_t ino,
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
 
@@ -3612,6 +3669,19 @@ static int __op_open(struct fuse2fs *ff, const char *path,
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


