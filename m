Return-Path: <linux-fsdevel+bounces-66097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EA2C17C6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91481401505
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947E32D94B5;
	Wed, 29 Oct 2025 01:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="paxpAahJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDED3A1CD;
	Wed, 29 Oct 2025 01:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700185; cv=none; b=uvOOFCL2wwBRK2aI8O2A9WubuEQP1gYbqCCc42mSaLms3c7zQQ9DQwOj8T6M5ihBA4uWFsIO3E6CWZgqePAn+CSP5e7g2WhVDcvURPMrk+AMAUHgLLufbcT+4fgUc/oBat/m/2hF6FvWSPY2oN5nEc5k1IrF0zEjLAq79fquYWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700185; c=relaxed/simple;
	bh=malePp2LbcVs8DxuFVHE1bWc3QVieYmk6rTjWeqO0ZE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VENHZWig6rA4V1laVIjFUCOTFoGSCogh6ExaPE2M44KGKzvUK2eaADlTvVaXZgd87WW45IFlE58PNc7sJp+WOI7Qn12gFaTC3E8WItQWdnuFnj+xONMZL+yRaLQzxgjQ/3gmx3LP+Zsn1cP70eG14j7ad83E7JTMVOwhIkhFNos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=paxpAahJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81385C4CEE7;
	Wed, 29 Oct 2025 01:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700184;
	bh=malePp2LbcVs8DxuFVHE1bWc3QVieYmk6rTjWeqO0ZE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=paxpAahJTjx3oX0HZQ2dztHqvJOiArRRooJBurGOTvcNomIVsg+ojTj3Kap00dCLs
	 fo02fla49+xnZudwhD6pV09UIpUccRpju27+Au+v9ocFWIkozagnUiqhSrCGiXeKU4
	 X1n/OABgyjXkdK+T/FUqiapmXYBsN4eiQaIDSAkVLhrHqCUlcyRXlhKeODJEYM52Jv
	 b6HI2yRiCCIbLFQ57PLsVS2SjxunVRgHN6sQp/ahSb78+T9oOAe9+gVzqT1f5P3yoX
	 Vx2rkKQmpki77SWmzacC1mgJ2YQFfn0Gz+7Ou/DZRbaSK4cHdvc0/YVY1IgmZgkFg7
	 BfeyUgQ8thqKQ==
Date: Tue, 28 Oct 2025 18:09:44 -0700
Subject: [PATCH 05/17] fuse2fs: implement directio file reads
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169817652.1429568.15117424981553294515.stgit@frogsfrogsfrogs>
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

Implement file reads via iomap.  Currently only directio is supported.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   14 +++++++++++++-
 misc/fuse2fs.c    |   14 +++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index fba04feaa5770b..d8523ec8bbecc9 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -6138,7 +6138,19 @@ static int fuse4fs_iomap_begin_read(struct fuse4fs *ff, ext2_ino_t ino,
 				    uint64_t count, uint32_t opflags,
 				    struct fuse_file_iomap *read)
 {
-	return -ENOSYS;
+	if (!(opflags & FUSE_IOMAP_OP_DIRECT))
+		return -ENOSYS;
+
+	/* fall back to slow path for inline data reads */
+	if (inode->i_flags & EXT4_INLINE_DATA_FL)
+		return -ENOSYS;
+
+	if (inode->i_flags & EXT4_EXTENTS_FL)
+		return fuse4fs_iomap_begin_extent(ff, ino, inode, pos, count,
+						  opflags, read);
+
+	return fuse4fs_iomap_begin_indirect(ff, ino, inode, pos, count,
+					    opflags, read);
 }
 
 static int fuse4fs_iomap_begin_write(struct fuse4fs *ff, ext2_ino_t ino,
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 8738e0b78f45f2..f0bb19ef4c8b30 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -5584,7 +5584,19 @@ static int fuse2fs_iomap_begin_read(struct fuse2fs *ff, ext2_ino_t ino,
 				    uint64_t count, uint32_t opflags,
 				    struct fuse_file_iomap *read)
 {
-	return -ENOSYS;
+	if (!(opflags & FUSE_IOMAP_OP_DIRECT))
+		return -ENOSYS;
+
+	/* fall back to slow path for inline data reads */
+	if (inode->i_flags & EXT4_INLINE_DATA_FL)
+		return -ENOSYS;
+
+	if (inode->i_flags & EXT4_EXTENTS_FL)
+		return fuse2fs_iomap_begin_extent(ff, ino, inode, pos, count,
+						  opflags, read);
+
+	return fuse2fs_iomap_begin_indirect(ff, ino, inode, pos, count,
+					    opflags, read);
 }
 
 static int fuse2fs_iomap_begin_write(struct fuse2fs *ff, ext2_ino_t ino,


