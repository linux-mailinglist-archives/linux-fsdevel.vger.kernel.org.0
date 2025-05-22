Return-Path: <linux-fsdevel+bounces-49635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F04AC011D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E376C9E5483
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5667320EB;
	Thu, 22 May 2025 00:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhcvTMjW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B159A195;
	Thu, 22 May 2025 00:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872651; cv=none; b=PSI31pzrlvWJcwoBvrXMjuvq0xHOzoaqlKL+z1NZjMi76cFQxG8NGtc1k5c/MtaYRE7etdGs0ZBeIivuuRxdVBgu8tL1FDhRvfCFUrYMjy9B/w74Qk556qUhwRNTVnRlHMyMz7yq8INUlxjlY48+Y4p6s31NBfWhMgtMYK9yYBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872651; c=relaxed/simple;
	bh=uNtwVlBAT3mkikzNDiMQeLKktekyUg/vxN1usCa8w/E=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PHN1tzo07aZ0tP7ePa5K0jenCqi32BEwHbQ3gCEWe3f1cL4LAaXVJN0cQBQ8ctW3jp1NkZYXLVZx6VIhJptlkq7uxxWqm5ZTC0m78KxsnbHXcWxYziWVHRmfeZ+/FjivrutY74dMqIYjc97zJJXcxn8JH6x2c4AtGAQfZ/ir5qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhcvTMjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DAA2C4CEE4;
	Thu, 22 May 2025 00:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872651;
	bh=uNtwVlBAT3mkikzNDiMQeLKktekyUg/vxN1usCa8w/E=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=KhcvTMjWTfsU0fktiMeUftkwTOIt1dpqDSD4UL2POZ66fTktesliaFrrTDKkB5JEd
	 JJIZYcagMGypkBBs9DNbIkfeU/z/KYpMeRHZf2iYe6a+kOF7nuPHfhUiUNwlAm4pV2
	 g7d+zPIRULbTXqyL/j9mAd7etwEgVPv2eKTGbFl8jzDhon+nCYXrXPhlMZAOjGOTVs
	 JUdmUHTkAxj1BxLPeBMEg5o9XYjw11bQAat2BfJE+1/9WSchOVW0kbXVm/LTOtXuHX
	 rCRkQJ6xMtFh3oAQlRDFk7pnbklQRnkWy+QAEx4CX0Ff9yNvhVTiZlJ9/EDETknNMF
	 iqcV9ut/YItsQ==
Date: Wed, 21 May 2025 17:10:50 -0700
Subject: [PATCH 10/10] libext2fs: allow callers to disallow I/O to file data
 blocks
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, linux-ext4@vger.kernel.org, miklos@szeredi.hu,
 joannelkoong@gmail.com, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
Message-ID: <174787198247.1484572.14212630663324181608.stgit@frogsfrogsfrogs>
In-Reply-To: <174787198025.1484572.10345977324531146086.stgit@frogsfrogsfrogs>
References: <174787198025.1484572.10345977324531146086.stgit@frogsfrogsfrogs>
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
index 22d56ad7554496..2c8e2cc2b55416 100644
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
index 1b7e88d990036b..229ae6da7f448b 100644
--- a/lib/ext2fs/fileio.c
+++ b/lib/ext2fs/fileio.c
@@ -300,6 +300,11 @@ errcode_t ext2fs_file_read(ext2_file_t file, void *buf,
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
@@ -416,6 +421,11 @@ errcode_t ext2fs_file_write(ext2_file_t file, const void *buf,
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
@@ -584,7 +594,7 @@ static errcode_t ext2fs_file_zero_past_offset(ext2_file_t file,
 	int ret_flags;
 	errcode_t retval;
 
-	if (off == 0)
+	if (off == 0 || (file->flags & EXT2_FILE_NOBLOCKIO))
 		return 0;
 
 	retval = sync_buffer_position(file);


