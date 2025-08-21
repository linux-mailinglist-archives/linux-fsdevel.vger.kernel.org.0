Return-Path: <linux-fsdevel+bounces-58542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D904DB2EA77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 403EA5E4FCC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AE21F463B;
	Thu, 21 Aug 2025 01:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFuiVj0N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24CE1CAA92;
	Thu, 21 Aug 2025 01:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739130; cv=none; b=jORmi6riXE62LDCJHXlRf+mkq9ICJJOIK4yEeTsfk/tQD7JAULwp02YoQ4n7GR276v3NF8S/6MS/7rsxCRkGZ+tdkpO/Fx2ew8rAt4apZvs8xXE8j6XEQLb9jLm6x0AXICxxrwZA96T5yBw6yu68+lS8l9XhIeqgfHZImZOPF9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739130; c=relaxed/simple;
	bh=Q1taKmFXXyT3dKN1BCsgRDSVhZOTaQzSic6s4biQqnw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MWf5xebjyVrBcJHasRs0Vy/9vo4eNC3J8V85WrpGqwJIsn6xaUoepwnVnI970DFpLWfZRpLyRnTA0UfarWmf/ZtNoi2Q1Au3As+/ZejfNG+rOd13bRzrWs+wrAAPE4oBvw5ufuiCjNRy3bb7E6JacaKT09nJxx1wkn9dzkVjCXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFuiVj0N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97435C4CEE7;
	Thu, 21 Aug 2025 01:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755739130;
	bh=Q1taKmFXXyT3dKN1BCsgRDSVhZOTaQzSic6s4biQqnw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=QFuiVj0Ncjspc2fiQ97vzBh7z6WWFE6Ht2a0amO74VlMD/OCvlZfotd9l7Y9/fgwj
	 1s+IKdSJvzotE3DDmK2QJV106VX4MdnhsE+6LCJZVg8N+7wHkRszTlF3YGgIeJAX+y
	 6t1ITMcavKCJqyG+eMYBamxsRcWbUZrS9n0yb8cxWEWw6/dJDrk8DAdsIXwLG1Fwrb
	 vqMZi8rA/FJGN90Z5rI1R/cIjI78ykuqGk7V53Ie5DYkLlqA8eRJXHIl/CV7WX8db0
	 d2pIjj1H/OiA9AiNKZ+djipn34vYmgtPISPXdEzVnAy2vH6j+gvRMg+MIXQ/V8GrDa
	 2XPYWZZNHqr0g==
Date: Wed, 20 Aug 2025 18:18:50 -0700
Subject: [PATCH 12/19] fuse2fs: enable file IO to inline data files
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573713947.21970.1566678961444283000.stgit@frogsfrogsfrogs>
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

Enable file reads and writes from inline data files.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   42 ++++++++++++++++++++++++++++++++++++++++--
 misc/fuse4fs.c |    3 ++-
 2 files changed, 42 insertions(+), 3 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 97b010b8dc1055..fc83d2d21c600b 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1472,7 +1472,16 @@ static void *op_init(struct fuse_conn_info *conn
 	cfg->use_ino = 1;
 	if (ff->debug)
 		cfg->debug = 1;
-	cfg->nullpath_ok = 1;
+
+	/*
+	 * Inline data file io depends on op_read/write being fed a path, so we
+	 * have to slow everyone down to look up the path from the nodeid.
+	 */
+	if (fuse2fs_iomap_enabled(ff) &&
+	    ext2fs_has_feature_inline_data(ff->fs->super))
+		cfg->nullpath_ok = 0;
+	else
+		cfg->nullpath_ok = 1;
 #endif
 
 	if (ff->kernel) {
@@ -3427,6 +3436,9 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
 		   size_t len, off_t offset,
 		   struct fuse_file_info *fp)
 {
+	struct fuse2fs_file_handle fhurk = {
+		.magic = FUSE2FS_FILE_MAGIC,
+	};
 	struct fuse2fs *ff = fuse2fs_get();
 	struct fuse2fs_file_handle *fh = fuse2fs_get_handle(fp);
 	ext2_filsys fs;
@@ -3436,10 +3448,21 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
+
+	if (!fh)
+		fh = &fhurk;
+
 	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d off=0x%llx len=0x%zx\n", __func__, fh->ino,
 		   (unsigned long long)offset, len);
 	fs = fuse2fs_start(ff);
+
+	if (fh == &fhurk) {
+		ret = fuse2fs_file_ino(ff, path, NULL, &fhurk.ino);
+		if (ret)
+			goto out;
+	}
+
 	err = ext2fs_file_open(fs, fh->ino, fh->open_flags, &efp);
 	if (err) {
 		ret = translate_error(fs, fh->ino, err);
@@ -3481,6 +3504,10 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 		    const char *buf, size_t len, off_t offset,
 		    struct fuse_file_info *fp)
 {
+	struct fuse2fs_file_handle fhurk = {
+		.magic = FUSE2FS_FILE_MAGIC,
+		.open_flags = EXT2_FILE_WRITE,
+	};
 	struct fuse2fs *ff = fuse2fs_get();
 	struct fuse2fs_file_handle *fh = fuse2fs_get_handle(fp);
 	ext2_filsys fs;
@@ -3490,6 +3517,10 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
+
+	if (!fh)
+		fh = &fhurk;
+
 	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d off=0x%llx len=0x%zx\n", __func__, fh->ino,
 		   (unsigned long long) offset, len);
@@ -3504,6 +3535,12 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 		goto out;
 	}
 
+	if (fh == &fhurk) {
+		ret = fuse2fs_file_ino(ff, path, NULL, &fhurk.ino);
+		if (ret)
+			goto out;
+	}
+
 	err = ext2fs_file_open(fs, fh->ino, fh->open_flags, &efp);
 	if (err) {
 		ret = translate_error(fs, fh->ino, err);
@@ -5511,7 +5548,8 @@ static int fuse2fs_iomap_begin_read(struct fuse2fs *ff, ext2_ino_t ino,
 {
 	/* fall back to slow path for inline data reads */
 	if (inode->i_flags & EXT4_INLINE_DATA_FL)
-		return -ENOSYS;
+		return fuse2fs_iomap_begin_inline(ff, ino, inode, pos, count,
+						  read);
 
 	if (inode->i_flags & EXT4_EXTENTS_FL)
 		return fuse2fs_iomap_begin_extent(ff, ino, inode, pos, count,
diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index 3bb6140b35570e..6de9f69d05de0b 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -5857,7 +5857,8 @@ static int fuse4fs_iomap_begin_read(struct fuse4fs *ff, ext2_ino_t ino,
 {
 	/* fall back to slow path for inline data reads */
 	if (inode->i_flags & EXT4_INLINE_DATA_FL)
-		return -ENOSYS;
+		return fuse4fs_iomap_begin_inline(ff, ino, inode, pos, count,
+						  read);
 
 	if (inode->i_flags & EXT4_EXTENTS_FL)
 		return fuse4fs_iomap_begin_extent(ff, ino, inode, pos, count,


