Return-Path: <linux-fsdevel+bounces-55394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A4FB09896
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4854817DE50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346E723A9AD;
	Thu, 17 Jul 2025 23:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDtIivCC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EB523ABBE;
	Thu, 17 Jul 2025 23:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752796033; cv=none; b=jxJ2KU3LMWovTz8adHlpupyBrbjn0Z2iX51SYlElu/+txesEtFJ9Drva4rZJnvulZou4FREOhG/eNqrVBhDNgORLfzfZc/AOCsgn2RogE7Qa1Hisr15vJ7Dhnz3G/mpdsRTYNZ7vJjTH48x8vmHUNyQ6RgRin+t1gxphoUAh9Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752796033; c=relaxed/simple;
	bh=+pdsudZkOF1SHiwo0VIh1fM2U3kZqxAggHl2X6/uzik=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rsK5Tpr69vZkOKI7Q9IBUwtz7C5ww/jQJnn8pnxmo9NvbAe7ZEt20vbyKIpFliJcZKY9onJ+uvKpDWLHcmFohhEJ7jl02bNhAVv6a7RDy1utbW8XpOT+OhNq1wtxqkq98cuye3umMsi4aUe9Vl0WR+r/tloILZCDA0pxDeIqHME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDtIivCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E61C4CEE3;
	Thu, 17 Jul 2025 23:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752796033;
	bh=+pdsudZkOF1SHiwo0VIh1fM2U3kZqxAggHl2X6/uzik=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=mDtIivCCD9AaKKRsKNz9JYBTucT79w2P2BHYU1kvSX5orc08wdi+xf3yJ4ODddLl0
	 UXpH3kWk1UfKHYo3Ecxz1Y+vThDk5z0/MRgaewEnd1BU/Xs4NOJCgTmt5aSQNfAcGS
	 FvTmuD7jYvox/blYm7PCSzWQTYZW0U6jIcbTb4A8+xxC0u8kR+HZxAc4QW66QKwTi/
	 o+kYMwFhgWJ5FFx2LD9O1yOz6TvP5sHnvVi75IYDtw6TNBCM5qpQtX98tIPfViHH5b
	 DWgg26MxDBQsqtNG55Kgly+HSt5jQ1dN9QBPpucbl0Xxlj8KCYB+tMEVo951lKoXfk
	 aDVLWsND6EkLg==
Date: Thu, 17 Jul 2025 16:47:12 -0700
Subject: [PATCH 07/10] fuse2fs: add tracing for retrieving timestamps
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461846.716436.7754256713841778956.stgit@frogsfrogsfrogs>
In-Reply-To: <175279461680.716436.11923939115339176158.stgit@frogsfrogsfrogs>
References: <175279461680.716436.11923939115339176158.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add tracing for retrieving timestamps so we can debug the weird
behavior.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 54f501b36d808b..15595fdf0b19ba 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1502,9 +1502,11 @@ static void *op_init(struct fuse_conn_info *conn
 	goto out;
 }
 
-static int stat_inode(ext2_filsys fs, ext2_ino_t ino, struct stat *statbuf)
+static int fuse2fs_stat(struct fuse2fs *ff, ext2_ino_t ino,
+			struct stat *statbuf)
 {
 	struct ext2_inode_large inode;
+	ext2_filsys fs = ff->fs;
 	dev_t fakedev = 0;
 	errcode_t err;
 	int ret = 0;
@@ -1543,6 +1545,13 @@ static int stat_inode(ext2_filsys fs, ext2_ino_t ino, struct stat *statbuf)
 #else
 	statbuf->st_ctime = tv.tv_sec;
 #endif
+
+	dbg_printf(ff, "%s: ino=%d atime=%lld.%ld mtime=%lld.%ld ctime=%lld.%ld\n",
+		   __func__, ino,
+		   (long long int)statbuf->st_atim.tv_sec, statbuf->st_atim.tv_nsec,
+		   (long long int)statbuf->st_mtim.tv_sec, statbuf->st_mtim.tv_nsec,
+		   (long long int)statbuf->st_ctim.tv_sec, statbuf->st_ctim.tv_nsec);
+
 	if (LINUX_S_ISCHR(inode.i_mode) ||
 	    LINUX_S_ISBLK(inode.i_mode)) {
 		if (inode.i_block[0])
@@ -1602,16 +1611,15 @@ static int op_getattr(const char *path, struct stat *statbuf
 {
 	struct fuse_context *ctxt = fuse_get_context();
 	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
-	ext2_filsys fs;
 	ext2_ino_t ino;
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = fuse2fs_start(ff);
+	fuse2fs_start(ff);
 	ret = fuse2fs_file_ino(ff, path, fi, &ino);
 	if (ret)
 		goto out;
-	ret = stat_inode(fs, ino, statbuf);
+	ret = fuse2fs_stat(ff, ino, statbuf);
 out:
 	fuse2fs_finish(ff, ret);
 	return ret;
@@ -4051,7 +4059,7 @@ static int op_readdir_iter(ext2_ino_t dir EXT2FS_ATTR((unused)),
 
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 	if (i->flags == FUSE_READDIR_PLUS) {
-		ret = stat_inode(i->fs, dirent->inode, &stat);
+		ret = fuse2fs_stat(i->ff, dirent->inode, &stat);
 		if (ret)
 			return DIRENT_ABORT;
 	}
@@ -4342,7 +4350,7 @@ static int op_fgetattr(const char *path EXT2FS_ATTR((unused)),
 	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	fs = fuse2fs_start(ff);
-	ret = stat_inode(fs, fh->ino, statbuf);
+	ret = fuse2fs_stat(ff, fh->ino, statbuf);
 	fuse2fs_finish(ff, ret);
 
 	return ret;


