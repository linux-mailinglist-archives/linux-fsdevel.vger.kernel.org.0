Return-Path: <linux-fsdevel+bounces-61631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4EAB58A78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57D704828C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020F81AAE28;
	Tue, 16 Sep 2025 01:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EH8Le6Co"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF8F1397;
	Tue, 16 Sep 2025 01:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984466; cv=none; b=CQzlescQq5qfL+coae/lIDdk0rUZKVA90Kmtsn4tTXgoVhiXXMokQO9yqPG3+CSh1zy0zfFe2WDejJb3E7ev9+lT5xIFOl43A7Br9cZXRbK5oOAKGRTSN8GvblURtFVLK76rR6PjinzKWpdDtomujEHRbWpUMtqAr+vmh2cZlG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984466; c=relaxed/simple;
	bh=BfZM1tVIGa/Bc4kv9vGHoPVDmcNpc/Bw62qQyiO8Rl4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yt2x7a/2VVU4dlrWsIp1A3sFO8fYBN8ab84zwV2gqNinAiEsiS+dTGpMos7k52XGNTkRg6BgemqWpAJq4DuIeqxjqByc65qKbsixkLuOM3WSEZWZ1wPSeyaxjdgWVZVK96SNnmmcH70GrP328tJAhsKnmP6xTBm8Q1JQ1v+Qw6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EH8Le6Co; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C66C4CEF1;
	Tue, 16 Sep 2025 01:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984466;
	bh=BfZM1tVIGa/Bc4kv9vGHoPVDmcNpc/Bw62qQyiO8Rl4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=EH8Le6CoUtuenPV8wTvNOfUS/ZvPCyEODwxQy0KN5LfEgh4xF386AkeCWLkqcVN3O
	 p1D3ZbXEfbw5BJsZCCZizXroXJmWIljUPNMVuAuL3quu5/COnzzPSFNls6C5ddX9e3
	 3MVIjmWCtrXarmAKsxxxJwicQhxYg+XGed61b7Uj3f2Z4Aq0qW4YMrUB3ytL8kM7Z9
	 tkZsCk+d23GYAxlOamV/rT7ptqCfqsvDDGEGMs8Q536SG7HWxlYK3IWvFLL8cJfqWE
	 8thUTQWLDFtIf17vsSkUFjkLcxhrpBUDrpIlLHJD3fKEKn0pr8AlN63yhwMXevEvRl
	 0DXVZakEp8XnQ==
Date: Mon, 15 Sep 2025 18:01:05 -0700
Subject: [PATCH 09/17] fuse2fs: don't zero bytes in punch hole
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798161882.390496.14945927624239907333.stgit@frogsfrogsfrogs>
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

When iomap is in use for the pagecache, it will take care of zeroing the
unaligned parts of punched out regions so we don't have to do it
ourselves.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |    8 ++++++++
 misc/fuse2fs.c    |    9 +++++++++
 2 files changed, 17 insertions(+)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 6b5d14e4f044cb..6c9e725d54b87a 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -5333,6 +5333,10 @@ static errcode_t fuse4fs_zero_middle(struct fuse4fs *ff, ext2_ino_t ino,
 	int retflags;
 	errcode_t err;
 
+	/* the kernel does this for us in iomap mode */
+	if (fuse4fs_iomap_enabled(ff))
+		return 0;
+
 	if (!*buf) {
 		err = ext2fs_get_mem(fs->blocksize, buf);
 		if (err)
@@ -5369,6 +5373,10 @@ static errcode_t fuse4fs_zero_edge(struct fuse4fs *ff, ext2_ino_t ino,
 	off_t residue;
 	errcode_t err;
 
+	/* the kernel does this for us in iomap mode */
+	if (fuse4fs_iomap_enabled(ff))
+		return 0;
+
 	residue = FUSE4FS_OFF_IN_FSB(ff, offset);
 	if (residue == 0)
 		return 0;
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index afc65c774dc148..5dbd8c5a17f79d 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -570,6 +570,7 @@ static inline int fuse2fs_iomap_enabled(const struct fuse2fs *ff)
 }
 #else
 # define fuse2fs_iomap_enabled(...)	(0)
+# define fuse2fs_iomap_enabled(...)	(0)
 #endif
 
 static inline void fuse2fs_dump_extents(struct fuse2fs *ff, ext2_ino_t ino,
@@ -4776,6 +4777,10 @@ static errcode_t clean_block_middle(struct fuse2fs *ff, ext2_ino_t ino,
 	int retflags;
 	errcode_t err;
 
+	/* the kernel does this for us in iomap mode */
+	if (fuse2fs_iomap_enabled(ff))
+		return 0;
+
 	if (!*buf) {
 		err = ext2fs_get_mem(fs->blocksize, buf);
 		if (err)
@@ -4812,6 +4817,10 @@ static errcode_t clean_block_edge(struct fuse2fs *ff, ext2_ino_t ino,
 	off_t residue;
 	errcode_t err;
 
+	/* the kernel does this for us in iomap mode */
+	if (fuse2fs_iomap_enabled(ff))
+		return 0;
+
 	residue = FUSE2FS_OFF_IN_FSB(ff, offset);
 	if (residue == 0)
 		return 0;


