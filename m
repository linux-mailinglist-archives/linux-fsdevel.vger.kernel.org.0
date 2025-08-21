Return-Path: <linux-fsdevel+bounces-58529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59777B2EA52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268321CC17C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6866B1F4281;
	Thu, 21 Aug 2025 01:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txmNJiZC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FAB36CE02;
	Thu, 21 Aug 2025 01:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738926; cv=none; b=f3kkXCE/U16d1hfx44prb90Y3IUq31q8d5hG1D2ss3XbraDiu+o3dk+ZweRMN6eYI3u0TEa7ejdWFX7lzjy9q4H7mDw5yUKKzEZyFfeWK2vRmKv5GaYiTsQ9m/NbuW9GvJ+qlhn7X0HgTBfRHgCIaJTISYW2CZssij3Tog7jvEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738926; c=relaxed/simple;
	bh=Z6QA3eH86l+ScYuV6WkeOKtuoS7+liQqlzV6HtcjPqs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NrBlQPqN7oQYLZBRoXUsvWWVcFWiQK3kAoMFT7+POKtaahdxYHxQsM9/LVxhpSFPIAxeN8jRl4r+BQBi2LYzKJ7A2D7SPGrJto4lEKhY4Df588XnIwvPimCgmMSDwg55OHotNIj75HAhxFQUl0DRalfpX8BJa+07OaJgCc2zgOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txmNJiZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417EEC4CEE7;
	Thu, 21 Aug 2025 01:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738926;
	bh=Z6QA3eH86l+ScYuV6WkeOKtuoS7+liQqlzV6HtcjPqs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=txmNJiZCwJGBjuT0OXjc/E51Hjz3xxy5apmBbTWcIMGwrTXyAf/8nhnSz+WsESmwb
	 A7r3Kvwwn14Fg4QHdf0Ks/KMwdXY4q9Sj7XGYKJgmAS24DJ5bqgE0m2c/ES9+nvVZe
	 kseAQdn5seqBvnJiYxbDRKUYqk77uhSt8VcBaI2DK/L1rA9zPIb05Vc6RheUsBX7wN
	 be44lzEltPON80ePymw2hD3IcrQC55PDAiN12KFK/YKzmzyjDgy7UzcbwVTdEL4oq3
	 yTikrx6pnjHUHBHk9cP5uLRBPufXxK9CYB/biJQW0Oj6MMYmPnLUH55LnEPkZnihuU
	 QeZd78e3/D+9g==
Date: Wed, 20 Aug 2025 18:15:25 -0700
Subject: [PATCH 09/10] libext2fs: allow callers to disallow I/O to file data
 blocks
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573713497.21546.14774021956944380330.stgit@frogsfrogsfrogs>
In-Reply-To: <175573713292.21546.5820947765655770281.stgit@frogsfrogsfrogs>
References: <175573713292.21546.5820947765655770281.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add a flag to ext2_file_t to disallow read and write I/O to file data
blocks.  This supports fuse2fs iomap support, which will keep all the
file data I/O inside the kerne.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/ext2fs.h |    3 +++
 lib/ext2fs/fileio.c |   12 +++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)


diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index dee9feb02624ed..7d36b1a839dc57 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -178,6 +178,9 @@ typedef struct ext2_struct_dblist *ext2_dblist;
 #define EXT2_FILE_WRITE		0x0001
 #define EXT2_FILE_CREATE	0x0002
 
+/* no file I/O to disk blocks, only to inline data */
+#define EXT2_FILE_NOBLOCKIO	0x0004
+
 #define EXT2_FILE_MASK		0x00FF
 
 #define EXT2_FILE_BUF_DIRTY	0x4000
diff --git a/lib/ext2fs/fileio.c b/lib/ext2fs/fileio.c
index 3a36e9e7fff43b..95ee45ec7371ae 100644
--- a/lib/ext2fs/fileio.c
+++ b/lib/ext2fs/fileio.c
@@ -314,6 +314,11 @@ errcode_t ext2fs_file_read(ext2_file_t file, void *buf,
 	if (file->inode.i_flags & EXT4_INLINE_DATA_FL)
 		return ext2fs_file_read_inline_data(file, buf, wanted, got);
 
+	if (file->flags & EXT2_FILE_NOBLOCKIO) {
+		retval = EXT2_ET_OP_NOT_SUPPORTED;
+		goto fail;
+	}
+
 	while ((file->pos < EXT2_I_SIZE(&file->inode)) && (wanted > 0)) {
 		retval = sync_buffer_position(file);
 		if (retval)
@@ -441,6 +446,11 @@ errcode_t ext2fs_file_write(ext2_file_t file, const void *buf,
 		retval = 0;
 	}
 
+	if (file->flags & EXT2_FILE_NOBLOCKIO) {
+		retval = EXT2_ET_OP_NOT_SUPPORTED;
+		goto fail;
+	}
+
 	while (nbytes > 0) {
 		retval = sync_buffer_position(file);
 		if (retval)
@@ -609,7 +619,7 @@ static errcode_t ext2fs_file_zero_past_offset(ext2_file_t file,
 	int ret_flags;
 	errcode_t retval;
 
-	if (off == 0)
+	if (off == 0 || (file->flags & EXT2_FILE_NOBLOCKIO))
 		return 0;
 
 	retval = sync_buffer_position(file);


