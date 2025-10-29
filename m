Return-Path: <linux-fsdevel+bounces-66104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F354FC17C9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A711D403BBA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFF12D7DC8;
	Wed, 29 Oct 2025 01:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cW8sCl8u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999FE1A7264;
	Wed, 29 Oct 2025 01:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700294; cv=none; b=lSQFzSkJqmGFzX/vuky61wDPP6gXyKupaPeG2BFm+o5aN/1bQdOdidb8veCoaFmy3aGrRo1kPNvRs1LxYPy2ep0QT0cSeiwlKkdjGDekd7Zd40BNFkVBwpOXj5xQx9BJ0sPsw6olJuCxefdsyRFAc53/3SfWmM8dgYlUuIHUS0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700294; c=relaxed/simple;
	bh=z6WduJxUH7SpHFKntzP+XL7f7j3S9lbVZm7fW8Ve1kc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ym5beFM8fEAOk3xR3z4qEi6sVdDuk/P3vvX0eQ5FciNQphJTTINJvy4iH1qck1DXz0VrAdICeleC+DTNthDOmDpfftvPftE6gK+hy9QcTnb2aKrpNqc4teSRKha1ASBdOXF48c//7E8Oi29BCTfLz6fCF8qoHhIoXaUmI2hZRG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cW8sCl8u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18172C4CEE7;
	Wed, 29 Oct 2025 01:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700294;
	bh=z6WduJxUH7SpHFKntzP+XL7f7j3S9lbVZm7fW8Ve1kc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=cW8sCl8uY0ZIM31fzKMIQZanjqFdSzxYpePD3RrcW2qfMO1rDuhhv7dtwYoZDJWQX
	 42VmVGp5HD1oW7eBwjeLqRUVEtQBW2jkQYgpUgv3qA9RWo5TjAtBKXM/Y+FNrYqey4
	 dzw3a5lHnZhjaFkg9mK3pfBcnKUGB7AEtHw608gNGVDWhStq4DT4nwJf8s5OOMLLJ/
	 uw25MRmyR0INay5dB09UqB99cEBL4EebXy6r7So1LTeGeh6/pg937sqSjHLjeCtghH
	 oXGrgo/hlmo3NhrW+u+B0/X3k5K7MG89f4wYpC0ik/9hoFk4s8wGVz1qTPG80b3hBr
	 Fu+Ewm0C4eXcg==
Date: Tue, 28 Oct 2025 18:11:33 -0700
Subject: [PATCH 12/17] fuse2fs: enable file IO to inline data files
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169817782.1429568.13562791536801696879.stgit@frogsfrogsfrogs>
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

Enable file reads and writes from inline data files.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |    3 ++-
 misc/fuse2fs.c    |   42 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 3 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index af5de5bbf12749..c12cc982291b1c 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -6331,7 +6331,8 @@ static int fuse4fs_iomap_begin_read(struct fuse4fs *ff, ext2_ino_t ino,
 {
 	/* fall back to slow path for inline data reads */
 	if (inode->i_flags & EXT4_INLINE_DATA_FL)
-		return -ENOSYS;
+		return fuse4fs_iomap_begin_inline(ff, ino, inode, pos, count,
+						  read);
 
 	if (inode->i_flags & EXT4_EXTENTS_FL)
 		return fuse4fs_iomap_begin_extent(ff, ino, inode, pos, count,
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 24e160185a0c97..1a4efca8beb623 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1831,7 +1831,16 @@ static void *op_init(struct fuse_conn_info *conn,
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
 
 	fuse2fs_detach_losetup(ff);
 
@@ -3818,6 +3827,9 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
 		   size_t len, off_t offset,
 		   struct fuse_file_info *fp)
 {
+	struct fuse2fs_file_handle fhurk = {
+		.magic = FUSE2FS_FILE_MAGIC,
+	};
 	struct fuse2fs *ff = fuse2fs_get();
 	struct fuse2fs_file_handle *fh = fuse2fs_get_handle(fp);
 	ext2_filsys fs;
@@ -3827,10 +3839,21 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
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
@@ -3872,6 +3895,10 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
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
@@ -3881,6 +3908,10 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
+
+	if (!fh)
+		fh = &fhurk;
+
 	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d off=0x%llx len=0x%zx\n", __func__, fh->ino,
 		   (unsigned long long) offset, len);
@@ -3895,6 +3926,12 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
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
@@ -5838,7 +5875,8 @@ static int fuse2fs_iomap_begin_read(struct fuse2fs *ff, ext2_ino_t ino,
 {
 	/* fall back to slow path for inline data reads */
 	if (inode->i_flags & EXT4_INLINE_DATA_FL)
-		return -ENOSYS;
+		return fuse2fs_iomap_begin_inline(ff, ino, inode, pos, count,
+						  read);
 
 	if (inode->i_flags & EXT4_EXTENTS_FL)
 		return fuse2fs_iomap_begin_extent(ff, ino, inode, pos, count,


