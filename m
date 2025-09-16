Return-Path: <linux-fsdevel+bounces-61644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6FAB58A98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1FB01B2691D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957081CEAD6;
	Tue, 16 Sep 2025 01:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHRvmVcs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C58198E91;
	Tue, 16 Sep 2025 01:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984670; cv=none; b=DRluXIbaBK+LSKDSU2E0uXjAk5208QUL24Ibbeo2PIti2ttLRp/vRCoMrsT9o9Ake8FHUGWjNg9+P7qqqq1i3bfr0F9UI1zQZsnueO/CvcfhzaIeB2C53IkXX8NBCU+7mP5kKLd26g6EODTs8eVPN79fcxed5WfpyVyS8nWthoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984670; c=relaxed/simple;
	bh=Tq0CVVWRI6gFwaO7Vk2KLX95v/9KLB6DMwpOVhR5/vs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NkeeQCfHmi6BiqdY0yG27NXxPndtmO1hO0IT/aUzfDqBXnf2CRTE4EeEvirJkJRBSsJBuO0/uHIlJM7NVb4TnBK+vXxC6JKMYWU7j8KpowDioiqGy1Vso8mDkxQT1SE5UPwm4IfWWd97N4wF7Mmvg8TW1i6bRRTrv03ggevcmg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHRvmVcs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D310C4CEF1;
	Tue, 16 Sep 2025 01:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984669;
	bh=Tq0CVVWRI6gFwaO7Vk2KLX95v/9KLB6DMwpOVhR5/vs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=JHRvmVcss5AIXj/GyxENbE9ldUvK+WMbpp2+dnp0PPatCwElp/6rgqo0SCDxjZhuY
	 OruhgtENRSIZb8AERaV1O0i2T2fXu8LVLxk585QS/LFiZfD0tJF96o+jCBepAzM1Io
	 n18+CBCB3fnZyCg9Pxu6g2rN01XpUTotokW9ltEvQI6UUAPQpw0dPC3VHao5fJl3rP
	 fSh5XdG6G+/8qBFq9kyjiJTYyZixAwWVHtnQ2CMMu3tLovJ9jL6uuqYfDte256AxfA
	 2vQf2q13EsIrqhENULvjw8CX6ZarV0ZH1Ysrg2NVhS48hAV9z7M6497a6/xK6MYBzI
	 nIko1ENYzdPBQ==
Date: Mon, 15 Sep 2025 18:04:29 -0700
Subject: [PATCH 04/10] fuse2fs: better debugging for file mode updates
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798162412.391272.11129523293683525156.stgit@frogsfrogsfrogs>
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

Improve the tracing of a chmod operation so that we can debug file mode
updates.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   10 ++++++----
 misc/fuse2fs.c    |   12 +++++++-----
 2 files changed, 13 insertions(+), 9 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 184066855517b1..ab807f1479870c 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -3495,6 +3495,7 @@ static int fuse4fs_chmod(struct fuse4fs *ff, fuse_req_t req, ext2_ino_t ino,
 			 mode_t mode, struct ext2_inode_large *inode)
 {
 	const struct fuse_ctx *ctxt = fuse_req_ctx(req);
+	mode_t new_mode;
 	int ret = 0;
 
 	dbg_printf(ff, "%s: ino=%d mode=0%o\n", __func__, ino, mode);
@@ -3521,11 +3522,12 @@ static int fuse4fs_chmod(struct fuse4fs *ff, fuse_req_t req, ext2_ino_t ino,
 			mode &= ~S_ISGID;
 	}
 
-	inode->i_mode &= ~0xFFF;
-	inode->i_mode |= mode & 0xFFF;
+	new_mode = (inode->i_mode & ~0xFFF) | (mode & 0xFFF);
 
-	dbg_printf(ff, "%s: ino=%d new_mode=0%o\n",
-		   __func__, ino, inode->i_mode);
+	dbg_printf(ff, "%s: ino=%d old_mode=0%o new_mode=0%o\n",
+		   __func__, ino, inode->i_mode, new_mode);
+
+	inode->i_mode = new_mode;
 
 	return 0;
 }
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 2b3c09a59270bc..53adf8542e2f42 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3184,6 +3184,7 @@ static int op_chmod(const char *path, mode_t mode, struct fuse_file_info *fi)
 	errcode_t err;
 	ext2_ino_t ino;
 	struct ext2_inode_large inode;
+	mode_t new_mode;
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
@@ -3222,11 +3223,12 @@ static int op_chmod(const char *path, mode_t mode, struct fuse_file_info *fi)
 			mode &= ~S_ISGID;
 	}
 
-	inode.i_mode &= ~0xFFF;
-	inode.i_mode |= mode & 0xFFF;
+	new_mode = (inode.i_mode & ~0xFFF) | (mode & 0xFFF);
 
-	dbg_printf(ff, "%s: path=%s new_mode=0%o ino=%d\n", __func__,
-		   path, inode.i_mode, ino);
+	dbg_printf(ff, "%s: path=%s old_mode=0%o new_mode=0%o ino=%d\n",
+		   __func__, path, inode.i_mode, new_mode, ino);
+
+	inode.i_mode = new_mode;
 
 	ret = update_ctime(fs, ino, &inode);
 	if (ret)
@@ -3246,12 +3248,12 @@ static int op_chmod(const char *path, mode_t mode, struct fuse_file_info *fi)
 static int op_chown(const char *path, uid_t owner, gid_t group,
 		    struct fuse_file_info *fi)
 {
+	struct ext2_inode_large inode;
 	struct fuse_context *ctxt = fuse_get_context();
 	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	errcode_t err;
 	ext2_ino_t ino;
-	struct ext2_inode_large inode;
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);


