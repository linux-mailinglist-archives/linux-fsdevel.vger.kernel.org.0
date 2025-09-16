Return-Path: <linux-fsdevel+bounces-61651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEF7B58ABB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A336F1AA50C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FA51C8621;
	Tue, 16 Sep 2025 01:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfEduYuL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23B920322;
	Tue, 16 Sep 2025 01:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984763; cv=none; b=Up3f9BRCJ/5NX2Y+u7XjaJYJytK8WHtcXlQKhZ2V9S0OeXNtGgmJau82F+blgyV7OdRIDYlsiE1L8Zh+zFqa6yfys2alX17iuUwYnXSDo1ZDv9Q/KqyLI1TX+IimtTwItAewAdHtBpFrSxc++KNnz4gsAR13sbA0dYKou0mZX8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984763; c=relaxed/simple;
	bh=EyB+EQCU8ods/BVAJmCEFp+ADtS+po+PdFPAQwFUlyM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CsKWCTmyG85krGXDFldEoIao6H4osF9m3VxhESbHAaXW2/PeH1O7e1Ui4JgMEi24U+ZJ9N/8rlMR6BEs1C18wScScOTbVGFp9nS18dBVGzC1pmNcYaD2DL6hjfz2HSqj9xvOKKtWuF2LdwVTOIhgTpjDdS7NqVZpx/CYMIC9jkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfEduYuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5530EC4CEF1;
	Tue, 16 Sep 2025 01:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984763;
	bh=EyB+EQCU8ods/BVAJmCEFp+ADtS+po+PdFPAQwFUlyM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=gfEduYuLLV5t/VRbtORzFm44f+lSxru4EB79AY+Efqh11N1qmaun+3ZTTewmsWQpC
	 aMMQfVX/oD2IPdVwMXcCB8bdmLBA25J7y5QQulz1jjn1jVFQO/nbqWA4UU2E2XGbms
	 UJA/xFZC6elC8g9Q9e+JEY3C2LfqpHmaQXAF0Kuodgsz+xtiY1hK5MVrOhDa+qoJ26
	 pwfhYF0TmG2gWHIpBauPLYmA/LutN8D3RoYWSIPs4XD4WcohtTr7dWqhXZAudYVpxf
	 T5F3IYNlWw0FG1W03oN4XTTli+B1ioHIuK6JHBFsiahM7mkO21t2khXBzSrP7e65JM
	 dN4w0kQ5hsEHw==
Date: Mon, 15 Sep 2025 18:06:02 -0700
Subject: [PATCH 10/10] fuse2fs: set sync, immutable,
 and append at file load time
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798162522.391272.2262955147071484342.stgit@frogsfrogsfrogs>
In-Reply-To: <175798162297.391272.17812368866586383182.stgit@frogsfrogsfrogs>
References: <175798162297.391272.17812368866586383182.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Convey these three inode flags to the kernel when we're loading a file.
This way the kernel can advertise and enforce those flags so that the
fuse server doesn't have to.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   10 ++++++++++
 misc/fuse2fs.c    |   53 ++++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 48 insertions(+), 15 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 4f5618e64a93c3..a7709a7e6fb699 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -1800,6 +1800,16 @@ static int fuse4fs_stat_inode(struct fuse4fs *ff, ext2_ino_t ino,
 	entry->entry_timeout = FUSE4FS_ATTR_TIMEOUT;
 
 	fstat->iflags = 0;
+
+	if (inodep->i_flags & EXT2_SYNC_FL)
+		fstat->iflags |= FUSE_IFLAG_SYNC;
+
+	if (inodep->i_flags & EXT2_IMMUTABLE_FL)
+		fstat->iflags |= FUSE_IFLAG_IMMUTABLE;
+
+	if (inodep->i_flags & EXT2_APPEND_FL)
+		fstat->iflags |= FUSE_IFLAG_APPEND;
+
 #ifdef HAVE_FUSE_IOMAP
 	if (fuse4fs_iomap_enabled(ff)) {
 		fstat->iflags |= FUSE_IFLAG_IOMAP;
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index b193e0b2c06b69..260d1b77e3f24b 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1584,7 +1584,7 @@ static void *op_init(struct fuse_conn_info *conn,
 }
 
 static int fuse2fs_stat(struct fuse2fs *ff, ext2_ino_t ino,
-			struct stat *statbuf)
+			struct stat *statbuf, unsigned int *iflags)
 {
 	struct ext2_inode_large inode;
 	ext2_filsys fs = ff->fs;
@@ -1641,6 +1641,7 @@ static int fuse2fs_stat(struct fuse2fs *ff, ext2_ino_t ino,
 			statbuf->st_rdev = inode.i_block[1];
 	}
 
+	*iflags = inode.i_flags;
 	return ret;
 }
 
@@ -1675,22 +1676,31 @@ static int __fuse2fs_file_ino(struct fuse2fs *ff, const char *path,
 # define fuse2fs_file_ino(ff, path, fp, inop) \
 	__fuse2fs_file_ino((ff), (path), (fp), (inop), __func__, __LINE__)
 
+static int fuse2fs_getattr(struct fuse2fs *ff, const char *path,
+			   struct stat *statbuf, struct fuse_file_info *fi,
+			   unsigned int *iflags)
+{
+	ext2_ino_t ino;
+	int ret = 0;
+
+	FUSE2FS_CHECK_CONTEXT(ff);
+	fuse2fs_start(ff);
+	ret = fuse2fs_file_ino(ff, path, fi, &ino);
+	if (ret)
+		goto out;
+	ret = fuse2fs_stat(ff, ino, statbuf, iflags);
+out:
+	fuse2fs_finish(ff, ret);
+	return ret;
+}
+
 static int op_getattr(const char *path, struct stat *statbuf,
 		      struct fuse_file_info *fi)
 {
 	struct fuse2fs *ff = fuse2fs_get();
-	ext2_ino_t ino;
-	int ret = 0;
+	unsigned int dontcare;
 
-	FUSE2FS_CHECK_CONTEXT(ff);
-	fuse2fs_start(ff);
-	ret = fuse2fs_file_ino(ff, path, fi, &ino);
-	if (ret)
-		goto out;
-	ret = fuse2fs_stat(ff, ino, statbuf);
-out:
-	fuse2fs_finish(ff, ret);
-	return ret;
+	return fuse2fs_getattr(ff, path, statbuf, fi, &dontcare);
 }
 
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 99)
@@ -1698,11 +1708,21 @@ static int op_getattr_iflags(const char *path, struct stat *statbuf,
 			     unsigned int *iflags, struct fuse_file_info *fi)
 {
 	struct fuse2fs *ff = fuse2fs_get();
-	int ret = op_getattr(path, statbuf, fi);
+	unsigned int i_flags;
+	int ret = fuse2fs_getattr(ff, path, statbuf, fi, &i_flags);
 
 	if (ret)
 		return ret;
 
+	if (i_flags & EXT2_IMMUTABLE_FL)
+		*iflags |= FUSE_IFLAG_IMMUTABLE;
+
+	if (i_flags & EXT2_SYNC_FL)
+		*iflags |= FUSE_IFLAG_SYNC;
+
+	if (i_flags & EXT2_APPEND_FL)
+		*iflags |= FUSE_IFLAG_APPEND;
+
 	if (fuse_fs_can_enable_iomap(statbuf)) {
 		*iflags |= FUSE_IFLAG_IOMAP;
 
@@ -3415,12 +3435,13 @@ static int fuse2fs_punch_posteof(struct fuse2fs *ff, ext2_ino_t ino,
 static int fuse2fs_file_uses_iomap(struct fuse2fs *ff, ext2_ino_t ino)
 {
 	struct stat statbuf;
+	unsigned int dontcare;
 	int ret;
 
 	if (!fuse2fs_iomap_enabled(ff))
 		return 0;
 
-	ret = fuse2fs_stat(ff, ino, &statbuf);
+	ret = fuse2fs_stat(ff, ino, &statbuf, &dontcare);
 	if (ret)
 		return ret;
 
@@ -4322,7 +4343,9 @@ static int op_readdir_iter(ext2_ino_t dir EXT2FS_ATTR((unused)),
 			(unsigned long long)i->dirpos);
 
 	if (i->flags == FUSE_READDIR_PLUS) {
-		ret = fuse2fs_stat(i->ff, dirent->inode, &stat);
+		unsigned int dontcare;
+
+		ret = fuse2fs_stat(i->ff, dirent->inode, &stat, &dontcare);
 		if (ret)
 			return DIRENT_ABORT;
 	}


