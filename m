Return-Path: <linux-fsdevel+bounces-66118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD22C17D28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A43F189A2C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6872D8785;
	Wed, 29 Oct 2025 01:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mgjk1bmB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FC43208;
	Wed, 29 Oct 2025 01:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700513; cv=none; b=VTJpMEF8N0E0S4rLYdLkYcOmul/pQx2z5G7rOHiFh98ZFJ2xvz1Bd9paO3mh8tcxSrvrOKouWPAOJTGP/W+RmZPz+4GpWMOViwW1fwF13x1DB03c4XsU/MMXEP8Coag71z+caVxc5yylJwU98CMAOGSmGa72N3L2vdXJwHlCcLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700513; c=relaxed/simple;
	bh=ixPCr6l5zUy+C8aLvEc0255QiwS75aFl7nftL/2gPbc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N5mZdjftLocKNmh9L5/vdbYrOSwJa1zU8eXGjKEGruMlbl3KcEQHQGOJfuzWKpfiUR/uhqt0nrbdxxmKFY8iSJF2KJKvTxy6U3ts3MdP0cpAFebTT5YHP+AtSGYAzoDjeR0AW+rUl6K6zLTunHOPA3+srxuoLmQnNgi3XkbquqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mgjk1bmB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C76C4CEE7;
	Wed, 29 Oct 2025 01:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700513;
	bh=ixPCr6l5zUy+C8aLvEc0255QiwS75aFl7nftL/2gPbc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Mgjk1bmBp+yxDrac7v5ybqJhIlwK3sG0FKm5AI6NGBTy8H6e7NYurAXyb+pQ1iqnJ
	 FLpQYH7xqM5WT68ohbxhm3Gb1KvoS5E5VISw2AiInPS2I6FIIR7JES0aGauEXAknqv
	 FXvWACo336hMKGc4HwejwlZ6AfC0LveCP72wwlGj5offNGnpy3YU3cx7rk1W7ak7r0
	 FMF1zk/ja5aZ+yG9WjQMqWSXUc8cP24UEWQ52c2JW5EyxWM8ykYM5DpBRkXvyUaTUp
	 +6m8sGsSppy9qlkOOlHjLHFT0occD9Uv85/8MEoc94qPmQNLb3lcJl8d1KPWqP1Zqc
	 uCHcVKQbIxYLQ==
Date: Tue, 28 Oct 2025 18:15:12 -0700
Subject: [PATCH 07/11] fuse2fs: add tracing for retrieving timestamps
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169818350.1430380.9100488831783543731.stgit@frogsfrogsfrogs>
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

Add tracing for retrieving timestamps so we can debug the weird
behavior.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index de712461492e05..10673aaed60dea 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1940,9 +1940,11 @@ static void *op_init(struct fuse_conn_info *conn,
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
@@ -1981,6 +1983,13 @@ static int stat_inode(ext2_filsys fs, ext2_ino_t ino, struct stat *statbuf)
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
@@ -2027,16 +2036,15 @@ static int op_getattr(const char *path, struct stat *statbuf,
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
@@ -3826,7 +3834,7 @@ static int fuse2fs_file_uses_iomap(struct fuse2fs *ff, ext2_ino_t ino)
 	if (!fuse2fs_iomap_enabled(ff))
 		return 0;
 
-	ret = stat_inode(ff->fs, ino, &statbuf);
+	ret = fuse2fs_stat(ff, ino, &statbuf);
 	if (ret)
 		return ret;
 
@@ -4728,7 +4736,7 @@ static int op_readdir_iter(ext2_ino_t dir EXT2FS_ATTR((unused)),
 			(unsigned long long)i->dirpos);
 
 	if (i->flags == FUSE_READDIR_PLUS) {
-		ret = stat_inode(i->fs, dirent->inode, &stat);
+		ret = fuse2fs_stat(i->ff, dirent->inode, &stat);
 		if (ret)
 			return DIRENT_ABORT;
 	}


