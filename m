Return-Path: <linux-fsdevel+bounces-58557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B16FB2EA98
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79D355E5F56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6CD214A97;
	Thu, 21 Aug 2025 01:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2LzuKrS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2037820B81B;
	Thu, 21 Aug 2025 01:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739365; cv=none; b=t4jkayezcKJ+AcXttLP/wXO/YN14pA+JTY/c65Wph/CwG9bR7sWbV6XNIVPvWNmK/yALzhy0sY1etwY1cAOCi+FFxPLqftXnaDveeJLlN1VGVWFBdxjZ5n+/y66Gsxvpyua3kM9fJV8cw2KvsXMXtLBm+PgpFSQR9OZokk9g6p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739365; c=relaxed/simple;
	bh=h4Pcom8ldBg+W2ll8X+p8nHWLpZy79IpaBkWuNxeHXY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/dOnY83hHbf9PUPeDa106s+JjkRAEuGb6jiOyu6vhUcjnfre9BIz2OEijcKTmWMrCX1uRhwv5oxlGmnShJxtPRhfgVizcIBgx5NvFCcXDjlWtd8Pr5rpfvI269z+XsnuSpG9HICblsu2dfqUiuRj9f3TD6rUkKIAdEArDuMbkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2LzuKrS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB04BC4CEE7;
	Thu, 21 Aug 2025 01:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755739365;
	bh=h4Pcom8ldBg+W2ll8X+p8nHWLpZy79IpaBkWuNxeHXY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=B2LzuKrSDgoc82IKUAA3nhrfb5QaX7g58OaGH90cYNCgFaM21+7Ho4jr8RjN5a9pM
	 sedGuMUctAAcaok3IkXWJr39ieGI1/oLmN0X3gD7ZkFHEGJSsJgZHOubWi4awAE5Pq
	 rCb/A/MdwQiDogLi4uqitZwB3rbNXYJSd3B4tENt4GOFm955wDJKfeynuhyTGFNqbU
	 EXdRMCQLPif5ZDCN646+/DRnnnR/jdx/b/F5wfesW6a3ySxvrRZqFCqllVuMuFmv1O
	 NH1mOo4/2B9Cj2ohftMScxhy1nGeYPLkXyinMoGSe5TIk0x0J5Wyr9XKf0ZW25Qiy2
	 OvtNdSl4327/g==
Date: Wed, 20 Aug 2025 18:22:44 -0700
Subject: [PATCH 6/8] fuse2fs: add tracing for retrieving timestamps
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573714501.22854.12509350759198668701.stgit@frogsfrogsfrogs>
In-Reply-To: <175573714359.22854.5198450217393478706.stgit@frogsfrogsfrogs>
References: <175573714359.22854.5198450217393478706.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index df84884ba6b7d0..80bd47549925bf 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1571,9 +1571,11 @@ static void *op_init(struct fuse_conn_info *conn
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
@@ -1612,6 +1614,13 @@ static int stat_inode(ext2_filsys fs, ext2_ino_t ino, struct stat *statbuf)
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
@@ -1669,16 +1678,15 @@ static int op_getattr(const char *path, struct stat *statbuf
 			)
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
@@ -3423,7 +3431,7 @@ static int fuse2fs_file_uses_iomap(struct fuse2fs *ff, ext2_ino_t ino)
 	if (!fuse2fs_iomap_enabled(ff))
 		return 0;
 
-	ret = stat_inode(ff->fs, ino, &statbuf);
+	ret = fuse2fs_stat(ff, ino, &statbuf);
 	if (ret)
 		return ret;
 
@@ -4334,7 +4342,7 @@ static int op_readdir_iter(ext2_ino_t dir EXT2FS_ATTR((unused)),
 
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 	if (i->flags == FUSE_READDIR_PLUS) {
-		ret = stat_inode(i->fs, dirent->inode, &stat);
+		ret = fuse2fs_stat(i->ff, dirent->inode, &stat);
 		if (ret)
 			return DIRENT_ABORT;
 	}
@@ -4618,7 +4626,7 @@ static int op_fgetattr(const char *path EXT2FS_ATTR((unused)),
 	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	fs = fuse2fs_start(ff);
-	ret = stat_inode(fs, fh->ino, statbuf);
+	ret = fuse2fs_stat(ff, fh->ino, statbuf);
 	fuse2fs_finish(ff, ret);
 
 	return ret;


