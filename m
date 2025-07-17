Return-Path: <linux-fsdevel+bounces-55383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7600DB09870
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BBFC1C26DD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52C6262FCC;
	Thu, 17 Jul 2025 23:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6GmL1z/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4598023FC5A;
	Thu, 17 Jul 2025 23:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795861; cv=none; b=VHGaIaHmkg4PGP+mSc6Yv/2gtBXoBzgSbzZhstqivSsjxPrKBdJt4xaeBnP8ZRHhBDoQCLktrVh5XRD38aB/95h1AcSnb3x+H9sNtc4YdQJfD+FVaAsldRiAGs5yRPWJVIxtPaiv1DNmV7iw0TSBVk9X2ah7BMvs3E3FCog3YTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795861; c=relaxed/simple;
	bh=+XY+7wQDuMqUT0GJjXyFJf1E3MrUJSr53l11/gIguRE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O2131b+JaLhuuBCh9WnG8lcZOEri1vKsfO6p1M2SSo7l15AUJoJHV0QXihMyuT+qedeqox8JeqafV3Vu9ulxDolCnAvU54CpWpEasgrCyka7jHcVJA+Y/gTqxbxDZKxDSAf1IEHX6sMR2HTfMDRKqlikUPk+SxXVvfzJjIszlbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6GmL1z/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C788FC4CEE3;
	Thu, 17 Jul 2025 23:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795860;
	bh=+XY+7wQDuMqUT0GJjXyFJf1E3MrUJSr53l11/gIguRE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=s6GmL1z/DmekxWvQq0c5e6HoAUZNwLn2ko36d5y+AVLQcgyT1Ae8mPybyh6US3aUO
	 jefI/h5ZXBVprTgQeehcKmSzikm1H/QRiJeZpq2xd8LakmSmfNdt/GyhIZ9y9sB64u
	 LoXtxTmOXhLfDjugFLL53Ead8J9KozxDZPRIVLJUuXYruq8ZseLKM2ftO3eZSYGnbf
	 8v6pUc4dO443gRwnMJG675kdUWesBG5c/Taz9Ms6RVUM+INjgiMSTmQv2iXAw49RLg
	 q+RQGkPsUNOLQ2ikjRZjq24J+7At19kuLog/K+BNnNxeRAszmsRsJ75AmRxTsgfcyo
	 HPaxsUMxNvB9g==
Date: Thu, 17 Jul 2025 16:44:20 -0700
Subject: [PATCH 19/22] fuse2fs: enable file IO to inline data files
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461377.715479.11226401438001422129.stgit@frogsfrogsfrogs>
In-Reply-To: <175279460935.715479.15460687085573767955.stgit@frogsfrogsfrogs>
References: <175279460935.715479.15460687085573767955.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |   39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index e281b5fc589d82..c21a95b6920d5c 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1407,6 +1407,14 @@ static void *op_init(struct fuse_conn_info *conn
 	if (fuse2fs_iomap_enabled(ff)) {
 		ff->unmount_in_destroy = 1;
 		ff->can_hardlink = 0;
+
+		/*
+		 * XXX: inline data file io depends on op_read/write being fed
+		 * a path, so we have to slow everyone down to look up the path
+		 * from the nodeid
+		 */
+		if (ext2fs_has_feature_inline_data(ff->fs->super))
+			cfg->nullpath_ok = 0;
 	}
 
 	/* Clear the valid flag so that an unclean shutdown forces a fsck */
@@ -3294,6 +3302,9 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
 		   size_t len, off_t offset,
 		   struct fuse_file_info *fp)
 {
+	struct fuse2fs_file_handle fhurk = {
+		.magic = FUSE2FS_FILE_MAGIC,
+	};
 	struct fuse_context *ctxt = fuse_get_context();
 	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
 	struct fuse2fs_file_handle *fh =
@@ -3305,10 +3316,21 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
+
+	if (!fh)
+		fh = &fhurk;
+
 	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d off=%jd len=%jd\n", __func__, fh->ino,
 		   (intmax_t) offset, len);
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
@@ -3350,6 +3372,10 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 		    const char *buf, size_t len, off_t offset,
 		    struct fuse_file_info *fp)
 {
+	struct fuse2fs_file_handle fhurk = {
+		.magic = FUSE2FS_FILE_MAGIC,
+		.open_flags = EXT2_FILE_WRITE,
+	};
 	struct fuse_context *ctxt = fuse_get_context();
 	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
 	struct fuse2fs_file_handle *fh =
@@ -3361,6 +3387,10 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
+
+	if (!fh)
+		fh = &fhurk;
+
 	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d off=%jd len=%jd\n", __func__, fh->ino,
 		   (intmax_t) offset, (intmax_t) len);
@@ -3375,6 +3405,12 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
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
@@ -5325,7 +5361,8 @@ static int fuse2fs_iomap_begin_read(struct fuse2fs *ff, ext2_ino_t ino,
 
 	/* fall back to slow path for inline data reads */
 	if (inode->i_flags & EXT4_INLINE_DATA_FL)
-		return -ENOSYS;
+		return fuse2fs_iomap_begin_inline(ff, ino, inode, pos, count,
+						  read_iomap);
 
 	/* flush dirty io_channel buffers to disk before iomap reads them */
 	if (!fuse2fs_iomap_does_fileio(ff)) {


