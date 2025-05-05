Return-Path: <linux-fsdevel+bounces-48146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BAFAAA87B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 02:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604AC5A5068
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 00:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EBB34AA80;
	Mon,  5 May 2025 22:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f40iSCLh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6992B34B1F3;
	Mon,  5 May 2025 22:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484779; cv=none; b=Iv/+UVBbM1yt9IndilO8TIZcUo4ArB27aJvOOydtCCEh1H6z33VjKja7Nlac+unjzQ77va7H6mwseiK9hrnCo06/wAcnyWn90/Oa7V/YmjQcRcOLj7nJlFEB9X/HggjJZLeIYTYlcslGZ39aX+9dCAt1rCODGZ8Vj39MpYi68GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484779; c=relaxed/simple;
	bh=lBE9T6eyAk7G46xFvpBrMvAHStAdnMON8O4omhTPVCg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oe2jgMdMGq7E3mkYfmcThApibG/pAZW7Gu1NlorNBD+HZbRnoWFnpla+jp/x/Weg40R65d0nYq4hWY1wDCE7ijA+z1/YckaUAtpP7JVELtMfNRWiyNFXhJvkUpvPTDvPbKcTi7JH4OGjKukMJkam6B8wmSgX16iuUQEvsUwvbCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f40iSCLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD90C4CEED;
	Mon,  5 May 2025 22:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484779;
	bh=lBE9T6eyAk7G46xFvpBrMvAHStAdnMON8O4omhTPVCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f40iSCLhnjroxKvwJk0n4DaQdFVg6Cmbl2v3ESM7Na1DTO3nHPxbaHNT/iW/UnzJr
	 fk6HEHXkHazygy+YXgxR0QPrBGSiJ39twgqgYQK7Svbd0gdvSRwR+jLen+gGva41iG
	 gY48PSTkOT5r6ZbZ9JBX5+59RzdDrZIZnteLS3PHNyAPrU9hcnI5KI197nGoDspo4n
	 tNmV55Tv9BsB3xKXPewfK/oXFb0Dl3XBjSjDyEBM7B4noniBDtWK1yLW8Q80aO/9sM
	 lu8MBrQmtgC3Tr01txlB3gblIMlYgycUq6KNQXwaeusWUGklt3Y2BfULxPCrzB9qk0
	 SrSx55/5/a+FA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 009/486] exfat: call bh_read in get_block only when necessary
Date: Mon,  5 May 2025 18:31:25 -0400
Message-Id: <20250505223922.2682012-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Sungjong Seo <sj1557.seo@samsung.com>

[ Upstream commit c73e680d1f84059e1b1ea82a537f6ccc1c563eb4 ]

With commit 11a347fb6cef ("exfat: change to get file size from DataLength"),
exfat_get_block() can now handle valid_size. However, most partial
unwritten blocks that could be mapped with other blocks are being
inefficiently processed separately as individual blocks.

Except for partial unwritten blocks that require independent processing,
let's handle them simply as before.

Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exfat/inode.c | 159 +++++++++++++++++++++++------------------------
 1 file changed, 77 insertions(+), 82 deletions(-)

diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 3801516ac5071..cc4dcb7a32b57 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -274,9 +274,11 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
 	sector_t last_block;
 	sector_t phys = 0;
 	sector_t valid_blks;
+	loff_t i_size;
 
 	mutex_lock(&sbi->s_lock);
-	last_block = EXFAT_B_TO_BLK_ROUND_UP(i_size_read(inode), sb);
+	i_size = i_size_read(inode);
+	last_block = EXFAT_B_TO_BLK_ROUND_UP(i_size, sb);
 	if (iblock >= last_block && !create)
 		goto done;
 
@@ -305,102 +307,95 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
 	if (buffer_delay(bh_result))
 		clear_buffer_delay(bh_result);
 
-	if (create) {
+	/*
+	 * In most cases, we just need to set bh_result to mapped, unmapped
+	 * or new status as follows:
+	 *  1. i_size == valid_size
+	 *  2. write case (create == 1)
+	 *  3. direct_read (!bh_result->b_folio)
+	 *     -> the unwritten part will be zeroed in exfat_direct_IO()
+	 *
+	 * Otherwise, in the case of buffered read, it is necessary to take
+	 * care the last nested block if valid_size is not equal to i_size.
+	 */
+	if (i_size == ei->valid_size || create || !bh_result->b_folio)
 		valid_blks = EXFAT_B_TO_BLK_ROUND_UP(ei->valid_size, sb);
+	else
+		valid_blks = EXFAT_B_TO_BLK(ei->valid_size, sb);
 
-		if (iblock + max_blocks < valid_blks) {
-			/* The range has been written, map it */
-			goto done;
-		} else if (iblock < valid_blks) {
-			/*
-			 * The range has been partially written,
-			 * map the written part.
-			 */
-			max_blocks = valid_blks - iblock;
-			goto done;
-		}
+	/* The range has been fully written, map it */
+	if (iblock + max_blocks < valid_blks)
+		goto done;
 
-		/* The area has not been written, map and mark as new. */
-		set_buffer_new(bh_result);
+	/* The range has been partially written, map the written part */
+	if (iblock < valid_blks) {
+		max_blocks = valid_blks - iblock;
+		goto done;
+	}
 
+	/* The area has not been written, map and mark as new for create case */
+	if (create) {
+		set_buffer_new(bh_result);
 		ei->valid_size = EXFAT_BLK_TO_B(iblock + max_blocks, sb);
 		mark_inode_dirty(inode);
-	} else {
-		valid_blks = EXFAT_B_TO_BLK(ei->valid_size, sb);
+		goto done;
+	}
 
-		if (iblock + max_blocks < valid_blks) {
-			/* The range has been written, map it */
-			goto done;
-		} else if (iblock < valid_blks) {
-			/*
-			 * The area has been partially written,
-			 * map the written part.
-			 */
-			max_blocks = valid_blks - iblock;
+	/*
+	 * The area has just one block partially written.
+	 * In that case, we should read and fill the unwritten part of
+	 * a block with zero.
+	 */
+	if (bh_result->b_folio && iblock == valid_blks &&
+	    (ei->valid_size & (sb->s_blocksize - 1))) {
+		loff_t size, pos;
+		void *addr;
+
+		max_blocks = 1;
+
+		/*
+		 * No buffer_head is allocated.
+		 * (1) bmap: It's enough to set blocknr without I/O.
+		 * (2) read: The unwritten part should be filled with zero.
+		 *           If a folio does not have any buffers,
+		 *           let's returns -EAGAIN to fallback to
+		 *           block_read_full_folio() for per-bh IO.
+		 */
+		if (!folio_buffers(bh_result->b_folio)) {
+			err = -EAGAIN;
 			goto done;
-		} else if (iblock == valid_blks &&
-			   (ei->valid_size & (sb->s_blocksize - 1))) {
-			/*
-			 * The block has been partially written,
-			 * zero the unwritten part and map the block.
-			 */
-			loff_t size, pos;
-			void *addr;
-
-			max_blocks = 1;
-
-			/*
-			 * For direct read, the unwritten part will be zeroed in
-			 * exfat_direct_IO()
-			 */
-			if (!bh_result->b_folio)
-				goto done;
-
-			/*
-			 * No buffer_head is allocated.
-			 * (1) bmap: It's enough to fill bh_result without I/O.
-			 * (2) read: The unwritten part should be filled with 0
-			 *           If a folio does not have any buffers,
-			 *           let's returns -EAGAIN to fallback to
-			 *           per-bh IO like block_read_full_folio().
-			 */
-			if (!folio_buffers(bh_result->b_folio)) {
-				err = -EAGAIN;
-				goto done;
-			}
+		}
 
-			pos = EXFAT_BLK_TO_B(iblock, sb);
-			size = ei->valid_size - pos;
-			addr = folio_address(bh_result->b_folio) +
-			       offset_in_folio(bh_result->b_folio, pos);
+		pos = EXFAT_BLK_TO_B(iblock, sb);
+		size = ei->valid_size - pos;
+		addr = folio_address(bh_result->b_folio) +
+			offset_in_folio(bh_result->b_folio, pos);
 
-			/* Check if bh->b_data points to proper addr in folio */
-			if (bh_result->b_data != addr) {
-				exfat_fs_error_ratelimit(sb,
+		/* Check if bh->b_data points to proper addr in folio */
+		if (bh_result->b_data != addr) {
+			exfat_fs_error_ratelimit(sb,
 					"b_data(%p) != folio_addr(%p)",
 					bh_result->b_data, addr);
-				err = -EINVAL;
-				goto done;
-			}
-
-			/* Read a block */
-			err = bh_read(bh_result, 0);
-			if (err < 0)
-				goto done;
+			err = -EINVAL;
+			goto done;
+		}
 
-			/* Zero unwritten part of a block */
-			memset(bh_result->b_data + size, 0,
-			       bh_result->b_size - size);
+		/* Read a block */
+		err = bh_read(bh_result, 0);
+		if (err < 0)
+			goto done;
 
-			err = 0;
-		} else {
-			/*
-			 * The range has not been written, clear the mapped flag
-			 * to only zero the cache and do not read from disk.
-			 */
-			clear_buffer_mapped(bh_result);
-		}
+		/* Zero unwritten part of a block */
+		memset(bh_result->b_data + size, 0, bh_result->b_size - size);
+		err = 0;
+		goto done;
 	}
+
+	/*
+	 * The area has not been written, clear mapped for read/bmap cases.
+	 * If so, it will be filled with zero without reading from disk.
+	 */
+	clear_buffer_mapped(bh_result);
 done:
 	bh_result->b_size = EXFAT_BLK_TO_B(max_blocks, sb);
 	if (err < 0)
-- 
2.39.5


