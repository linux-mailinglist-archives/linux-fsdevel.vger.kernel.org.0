Return-Path: <linux-fsdevel+bounces-66101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 13840C17C80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05DD34F96ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0582C2D839F;
	Wed, 29 Oct 2025 01:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeaKosPZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C3018FDDB;
	Wed, 29 Oct 2025 01:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700247; cv=none; b=RPC6ZqHt698BxeWlj6RZB4Pif/l3VTPQTT2Z9am2VkdtFNo1mlopQ1Rcb2glMo+oPSUTnQOpYp7TqyVT/gLyUdEEFpdiXaM/GNo1gfLWx4YG+Q0psaEZUzzMv90KHZXtWmaSP2wcPB8qeLbyDnGUm1dksfn00NtaIhypEjzlVLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700247; c=relaxed/simple;
	bh=c9zM/kgu021LmREnFx69t9xgk++6IjDCTaXiB0vCThI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z5iX4HYUBzmDSgyvqvjM3/TKBFyyVxIZIpUjDBWOqVEb2DBHBBTqZL0l6LoSQYn3XSs6IxIsZlubVoLUKn48mn4afV6A/KlK3doQOBR/5KVJB0lk5BYiu3BreXlC1XDjro6olHuGRAr8SIrq+xcg4qiZGsnz/1zPP7IiJfiqXH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeaKosPZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB57C4CEE7;
	Wed, 29 Oct 2025 01:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700247;
	bh=c9zM/kgu021LmREnFx69t9xgk++6IjDCTaXiB0vCThI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=VeaKosPZ7VReEjiDrTqiHwFCXhsjNV4gJPr0DJ83Uz6CWa1nt1BVhnHONQhg3LLMz
	 nioSvP9lw3wrZriREgOXJ5Lgia6JeSrx+2vNLBsb0syzY0J5v60wISHCUL4WpPTTKD
	 3JaverErfM/kJvz2eiUZrsJQ/EZd2Pp3lSTtU6bw+3rJeKnoNpiPFBdK6RKnF4mvFJ
	 KhoYJObdK3yI0ESjSVWzQId6stqH1NMzFBAWMEp9uQkUY8P0bbQJchzJlrc52SNkN8
	 vPkD50GflcyOUsvA/MQuT7YqPs0gYWcMxMXPVWgpSG3lRX2ro2aRTap8vJyKLZ44Tv
	 DDKYaU2X+1lnA==
Date: Tue, 28 Oct 2025 18:10:46 -0700
Subject: [PATCH 09/17] fuse2fs: don't zero bytes in punch hole
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169817726.1429568.17778737880395029886.stgit@frogsfrogsfrogs>
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

When iomap is in use for the pagecache, it will take care of zeroing the
unaligned parts of punched out regions so we don't have to do it
ourselves.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |    8 ++++++++
 misc/fuse2fs.c    |    9 +++++++++
 2 files changed, 17 insertions(+)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 4c12c082046ea1..3cf9610435a44c 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -5636,6 +5636,10 @@ static errcode_t fuse4fs_zero_middle(struct fuse4fs *ff, ext2_ino_t ino,
 	int retflags;
 	errcode_t err;
 
+	/* the kernel does this for us in iomap mode */
+	if (fuse4fs_iomap_enabled(ff))
+		return 0;
+
 	if (!*buf) {
 		err = ext2fs_get_mem(fs->blocksize, buf);
 		if (err)
@@ -5672,6 +5676,10 @@ static errcode_t fuse4fs_zero_edge(struct fuse4fs *ff, ext2_ino_t ino,
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
index 17195ffadf0ab3..55d1fe3dcd4c8d 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -726,6 +726,7 @@ static inline int fuse2fs_iomap_enabled(const struct fuse2fs *ff)
 }
 #else
 # define fuse2fs_iomap_enabled(...)	(0)
+# define fuse2fs_iomap_enabled(...)	(0)
 #endif
 
 static inline void fuse2fs_dump_extents(struct fuse2fs *ff, ext2_ino_t ino,
@@ -5083,6 +5084,10 @@ static errcode_t clean_block_middle(struct fuse2fs *ff, ext2_ino_t ino,
 	int retflags;
 	errcode_t err;
 
+	/* the kernel does this for us in iomap mode */
+	if (fuse2fs_iomap_enabled(ff))
+		return 0;
+
 	if (!*buf) {
 		err = ext2fs_get_mem(fs->blocksize, buf);
 		if (err)
@@ -5119,6 +5124,10 @@ static errcode_t clean_block_edge(struct fuse2fs *ff, ext2_ino_t ino,
 	off_t residue;
 	errcode_t err;
 
+	/* the kernel does this for us in iomap mode */
+	if (fuse2fs_iomap_enabled(ff))
+		return 0;
+
 	residue = FUSE2FS_OFF_IN_FSB(ff, offset);
 	if (residue == 0)
 		return 0;


