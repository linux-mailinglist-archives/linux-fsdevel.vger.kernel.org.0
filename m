Return-Path: <linux-fsdevel+bounces-61634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEF4B58A80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DC337B067B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244161BD9CE;
	Tue, 16 Sep 2025 01:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+qZ08hG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E88718C933;
	Tue, 16 Sep 2025 01:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984514; cv=none; b=Js6xdQK2tidxWHcDzpa644ssWTL+AvfYTkaqhqGB5CVHZ79Q+fJHm2THJn3fNlP319j8dTypeS0jK/xD/lduymnY670nGEZORbkcFuBvuDKoYj2MJwIVpyyJ7GXFok0gLTyARu4J17mgCUY0jRPUMfE2ahG3oKo8IbDbgBW4vak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984514; c=relaxed/simple;
	bh=ijO8G0nFAPrzVzMLLQ2rQ7S2v4BZCH+mqiIHywoPLhk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aC6raI1cZ/JYzwUyodPiAjIh0AU0WiFUZtw9zC6p2R8TKxla73EJjWpruICUzTMyQrTDsMrqZK4q8peX8Er6aMWAejs6r4vIfqF4FXAHqEHUxw6uWaaxawhCQWe7sBAx9Dt18wdLyVWO5uUmoZ3E3zPojqZMQH+19/AT9SY8r9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+qZ08hG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9FFC4CEF1;
	Tue, 16 Sep 2025 01:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984513;
	bh=ijO8G0nFAPrzVzMLLQ2rQ7S2v4BZCH+mqiIHywoPLhk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Q+qZ08hGoshSODVVIVQEiPZPZ0U0H2C2rgSDv1Vqlk8NumfKM05e0BCRRoI3KfmWs
	 GF8oXZZ7FUlsbT5Q7d/wkWOP4Y1/pmDIyyGzw6Gab2/QKxYixhWWMdbXZQRsSrmMpQ
	 S6MperQRcgdy9HXSywjd72mt1eJVVpvRAFxSzrKcL48Y8f9SwuH5EefGkklItMSbAk
	 7FCXyg+a5hfjIj8BiVT73zwDt1lZLSjblQ0OOtyl4NzpQ58IL7o10bHUJJHEmx2QGk
	 cuCPE8vO2Qo+Pe+3x+ofObOzq7hVqnsXHsEd1Nt7pl/he935x/WHIexQE7S87QCb9g
	 +dkIXlYxXDoAg==
Date: Mon, 15 Sep 2025 18:01:52 -0700
Subject: [PATCH 12/17] fuse2fs: enable file IO to inline data files
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798161936.390496.17237853485831093898.stgit@frogsfrogsfrogs>
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

Enable file reads and writes from inline data files.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |    3 ++-
 misc/fuse2fs.c    |   42 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 3 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 8965edbaf9b834..47ad8215c3e1d1 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -5925,7 +5925,8 @@ static int fuse4fs_iomap_begin_read(struct fuse4fs *ff, ext2_ino_t ino,
 {
 	/* fall back to slow path for inline data reads */
 	if (inode->i_flags & EXT4_INLINE_DATA_FL)
-		return -ENOSYS;
+		return fuse4fs_iomap_begin_inline(ff, ino, inode, pos, count,
+						  read);
 
 	if (inode->i_flags & EXT4_EXTENTS_FL)
 		return fuse4fs_iomap_begin_extent(ff, ino, inode, pos, count,
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 7fa4070dee0367..5dc0b0606112af 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1480,7 +1480,16 @@ static void *op_init(struct fuse_conn_info *conn,
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
 
 	if (ff->kernel) {
 		char uuid[UUID_STR_SIZE];
@@ -3412,6 +3421,9 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
 		   size_t len, off_t offset,
 		   struct fuse_file_info *fp)
 {
+	struct fuse2fs_file_handle fhurk = {
+		.magic = FUSE2FS_FILE_MAGIC,
+	};
 	struct fuse2fs *ff = fuse2fs_get();
 	struct fuse2fs_file_handle *fh = fuse2fs_get_handle(fp);
 	ext2_filsys fs;
@@ -3421,10 +3433,21 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
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
@@ -3466,6 +3489,10 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
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
@@ -3475,6 +3502,10 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
+
+	if (!fh)
+		fh = &fhurk;
+
 	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d off=0x%llx len=0x%zx\n", __func__, fh->ino,
 		   (unsigned long long) offset, len);
@@ -3489,6 +3520,12 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
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
@@ -5429,7 +5466,8 @@ static int fuse2fs_iomap_begin_read(struct fuse2fs *ff, ext2_ino_t ino,
 {
 	/* fall back to slow path for inline data reads */
 	if (inode->i_flags & EXT4_INLINE_DATA_FL)
-		return -ENOSYS;
+		return fuse2fs_iomap_begin_inline(ff, ino, inode, pos, count,
+						  read);
 
 	if (inode->i_flags & EXT4_EXTENTS_FL)
 		return fuse2fs_iomap_begin_extent(ff, ino, inode, pos, count,


