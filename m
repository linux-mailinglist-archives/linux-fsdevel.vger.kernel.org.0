Return-Path: <linux-fsdevel+bounces-61647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD77B58AA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49015173B1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428A61C8621;
	Tue, 16 Sep 2025 01:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5JJB0dX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA6D199935;
	Tue, 16 Sep 2025 01:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984716; cv=none; b=X0Xk0Ol1yvz2gSZUXz346+Yr1gdht3G6LjMORMzJA3gi8v4CPa8z/nH0HJ6lOHZHxbD1bOTYvLH+p91B4EBGeF1sxROod1QksYiVuCoV9BQH9hO8q7QxMD0CaDPZJ5Z0TFETCTw2VrqesOpTSGVF/xvpw4N76QeTw2VEuDV5+D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984716; c=relaxed/simple;
	bh=8y2s1CJuF/dkSpAGEgjI+tudKeP6KeHBPAu4xws8h7k=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0tA6d7cYnXrtu8mbnhiiRCMl/oavow0o7kRucmcQwSiyytG6xA/XRywmVB6AYaKj5K6SUKtDALCnamO6g8VpnIccYj/nu6AWmB7Zkmgq+YK3yegNpizCtaIyFRyt9v9LK8I1D+3XBK73/7zARYcDmbc/+Wl2lWQr9bZaAMBczo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5JJB0dX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AF8C4CEF1;
	Tue, 16 Sep 2025 01:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984716;
	bh=8y2s1CJuF/dkSpAGEgjI+tudKeP6KeHBPAu4xws8h7k=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Z5JJB0dXf7ziJPRe0uiDlAQe8JqWpsH6aK7EDcpTfvq7VfsODM1r9WhVgNlcmISKK
	 2oiMDjwtUvGMT+2JRpO3u55/7czAYrQ/sZy+cV5dqaK+giF1vGDnEanhtRjhT7Df3e
	 8XeJ6eYAvaJmOiU0VIRikNFmgN/Dv2I0Cni+P2yKM0au0MEaxKpf9vAY0jZ78dFw/g
	 JaCf41rYQItPRZsAD2cJpkln3E9HgfF06iLGX4ErRq7H2o3lrLLSLbgpWNkyztcfHP
	 6gg3LDudpaLEQ3J9WkSDIwSo3hwRN3FZ0QqEo4KL+wthU44Xz5uc+O9b0nbXmuHmBL
	 fuxuZ6MDuAQVg==
Date: Mon, 15 Sep 2025 18:05:16 -0700
Subject: [PATCH 07/10] fuse2fs: add tracing for retrieving timestamps
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798162467.391272.227746098617279902.stgit@frogsfrogsfrogs>
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

Add tracing for retrieving timestamps so we can debug the weird
behavior.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index fa4359133a79fc..00dafec79f7766 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1580,9 +1580,11 @@ static void *op_init(struct fuse_conn_info *conn,
 	return ff;
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
@@ -1621,6 +1623,13 @@ static int stat_inode(ext2_filsys fs, ext2_ino_t ino, struct stat *statbuf)
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
@@ -1667,16 +1676,15 @@ static int op_getattr(const char *path, struct stat *statbuf,
 		      struct fuse_file_info *fi)
 {
 	struct fuse2fs *ff = fuse2fs_get();
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
@@ -3409,7 +3417,7 @@ static int fuse2fs_file_uses_iomap(struct fuse2fs *ff, ext2_ino_t ino)
 	if (!fuse2fs_iomap_enabled(ff))
 		return 0;
 
-	ret = stat_inode(ff->fs, ino, &statbuf);
+	ret = fuse2fs_stat(ff, ino, &statbuf);
 	if (ret)
 		return ret;
 
@@ -4311,7 +4319,7 @@ static int op_readdir_iter(ext2_ino_t dir EXT2FS_ATTR((unused)),
 			(unsigned long long)i->dirpos);
 
 	if (i->flags == FUSE_READDIR_PLUS) {
-		ret = stat_inode(i->fs, dirent->inode, &stat);
+		ret = fuse2fs_stat(i->ff, dirent->inode, &stat);
 		if (ret)
 			return DIRENT_ABORT;
 	}


