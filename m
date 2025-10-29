Return-Path: <linux-fsdevel+bounces-66121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3E9C17D56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C69494F64E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF592D2381;
	Wed, 29 Oct 2025 01:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvf/CC4+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A0C18FDDB;
	Wed, 29 Oct 2025 01:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700560; cv=none; b=FsVNHypRpjFd5tkIZRhMO4ckEjD2EyxF36Yx35MGMJJQlQUFVByHrwzU4+DQnmFhqvnPwvkJsaTscNJ0sg15NmH6JJGZzxtOVZ8Vt7RmSvkr74Is6R1jIwBZBugM3iirmIFIj0mO1pcT6Z4DkpLFnUvTN/2CuP4HJrLLPRk0O5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700560; c=relaxed/simple;
	bh=HSivo5PCNWAzm+wah9THW20Y18idIqGWBGA8vJSNL9g=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JB1MQKKmHpzTYBlpS+nDr1C4rLBNL8szcZTpNx+svPfR/WiQcB2n38xxsmfS0ot9tzcxM/C844rLZf1xsi0tVmFoA7ojoB0Q0cRAeO9jNRdwbmfHbjnGCt7GVTyxPIoRY5dt9JflxJP0oV6GkiKhg8wfqG0pzmlx+D6UrhgNLdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvf/CC4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB39C4CEE7;
	Wed, 29 Oct 2025 01:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700560;
	bh=HSivo5PCNWAzm+wah9THW20Y18idIqGWBGA8vJSNL9g=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=fvf/CC4+yYr2mu505V/brSuD8dmGt8NltK9iA01SKzXOvgDakE6xG+KUXe4JdNHtG
	 K6N4r0rsimCV0M1R9c5SfrSChRxbWVnWyUjv2RSdC7cDveqLGCwJd3uXUv8Z8DJ7cp
	 tPSQuoLDiDQYHgD9ekd9tX3CT3VGNx6Qkksr3tIcYPwANJSbykOxK0N0FspEONwktC
	 m71GHw0tAahICHoLrvNdGSLpYMfEytTk6VQi9kC69Jla3gnXDJsvQ1cldi8sTO68OP
	 b8GSd40b19AEOquiRDXQQ1qms1j2IjZ9KLh5D2IYQGF4bYEkQLwA7W1HweAC/n4dol
	 cisBwXNpKmJuQ==
Date: Tue, 28 Oct 2025 18:15:59 -0700
Subject: [PATCH 10/11] fuse2fs: set sync, immutable,
 and append at file load time
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169818405.1430380.11194212025654719284.stgit@frogsfrogsfrogs>
In-Reply-To: <176169818170.1430380.13590456647130347042.stgit@frogsfrogsfrogs>
References: <176169818170.1430380.13590456647130347042.stgit@frogsfrogsfrogs>
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
 fuse4fs/fuse4fs.c |   16 ++++++++++++++++
 misc/fuse2fs.c    |   53 ++++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 54 insertions(+), 15 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index e6a96717dfe415..e08e127eb03563 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -2159,6 +2159,22 @@ static int fuse4fs_stat_inode(struct fuse4fs *ff, ext2_ino_t ino,
 	entry->entry_timeout = FUSE4FS_ATTR_TIMEOUT;
 
 	fstat->iflags = 0;
+
+#ifdef FUSE_IFLAG_SYNC
+	if (inodep->i_flags & EXT2_SYNC_FL)
+		fstat->iflags |= FUSE_IFLAG_SYNC;
+#endif
+
+#ifdef FUSE_IFLAG_IMMUTABLE
+	if (inodep->i_flags & EXT2_IMMUTABLE_FL)
+		fstat->iflags |= FUSE_IFLAG_IMMUTABLE;
+#endif
+
+#ifdef FUSE_IFLAG_APPEND
+	if (inodep->i_flags & EXT2_APPEND_FL)
+		fstat->iflags |= FUSE_IFLAG_APPEND;
+#endif
+
 #ifdef HAVE_FUSE_IOMAP
 	if (fuse4fs_iomap_enabled(ff)) {
 		fstat->iflags |= FUSE_IFLAG_IOMAP;
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 91b48f5d68b0db..c0e8fa35dcf8ed 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1944,7 +1944,7 @@ static void *op_init(struct fuse_conn_info *conn,
 }
 
 static int fuse2fs_stat(struct fuse2fs *ff, ext2_ino_t ino,
-			struct stat *statbuf)
+			struct stat *statbuf, unsigned int *iflags)
 {
 	struct ext2_inode_large inode;
 	ext2_filsys fs = ff->fs;
@@ -2001,6 +2001,7 @@ static int fuse2fs_stat(struct fuse2fs *ff, ext2_ino_t ino,
 			statbuf->st_rdev = inode.i_block[1];
 	}
 
+	*iflags = inode.i_flags;
 	return ret;
 }
 
@@ -2035,22 +2036,31 @@ static int __fuse2fs_file_ino(struct fuse2fs *ff, const char *path,
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
@@ -2058,11 +2068,21 @@ static int op_getattr_iflags(const char *path, struct stat *statbuf,
 			     unsigned int *iflags, struct fuse_file_info *fi)
 {
 	struct fuse2fs *ff = fuse2fs_get();
-	int ret = op_getattr(path, statbuf, fi);
+	unsigned int i_flags;
+	int ret = fuse2fs_getattr(ff, path, statbuf, fi, &i_flags);
 
 	if (ret)
 		return ret;
 
+	if (i_flags & EXT2_SYNC_FL)
+		*iflags |= FUSE_IFLAG_SYNC;
+
+	if (i_flags & EXT2_IMMUTABLE_FL)
+		*iflags |= FUSE_IFLAG_IMMUTABLE;
+
+	if (i_flags & EXT2_APPEND_FL)
+		*iflags |= FUSE_IFLAG_APPEND;
+
 	if (fuse_fs_can_enable_iomap(statbuf)) {
 		*iflags |= FUSE_IFLAG_IOMAP;
 
@@ -3832,12 +3852,13 @@ static int fuse2fs_punch_posteof(struct fuse2fs *ff, ext2_ino_t ino,
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
 
@@ -4739,7 +4760,9 @@ static int op_readdir_iter(ext2_ino_t dir EXT2FS_ATTR((unused)),
 			(unsigned long long)i->dirpos);
 
 	if (i->flags == FUSE_READDIR_PLUS) {
-		ret = fuse2fs_stat(i->ff, dirent->inode, &stat);
+		unsigned int dontcare;
+
+		ret = fuse2fs_stat(i->ff, dirent->inode, &stat, &dontcare);
 		if (ret)
 			return DIRENT_ABORT;
 	}


