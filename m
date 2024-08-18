Return-Path: <linux-fsdevel+bounces-26213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A5D95603A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 01:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6E01F21EC8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2024 23:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F35715665C;
	Sun, 18 Aug 2024 23:58:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-06.prod.sxb1.secureserver.net (sxb1plsmtpa01-06.prod.sxb1.secureserver.net [188.121.53.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9547C1BC59
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Aug 2024 23:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724025538; cv=none; b=X/NQ48lFgt+H343k8DGyviMbVUKGjexPj4xxGKvpqcNBujLM5Lzj59FjjWI8TjiTN2PBId/j/HdBofr0hHm4iwWA7ODjPHX8f8adc6b/+LV88UITw5eLvWE63Cr5sm/Fy4zUJ0wMSvc7QfoU+Rgs09tIKFyCnko4fEnpwxFfLtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724025538; c=relaxed/simple;
	bh=AZ57LPeQ04mzM+QuuWSVbk/W3te3QhYFAyBfKK3jk9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MykPCmIJxQ5k3KJzfT8FJhFuIgbZ37KqN++oiXnz37oSXlx3TJkFJQlUfwxT1faHjEeF7sBbG+tly8ofuK3HmgDepemzY+8JK0Hm+EZRTAr0FEq9HWd84/5M5JoD5GPQQdRUcW/jFciOhzAV4JUbexwRkfvEmdhuHK/rv/hZl8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from phoenix.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id fpn7sTYC0QGHUfpnLsxSIc; Sun, 18 Aug 2024 16:58:48 -0700
X-CMAE-Analysis: v=2.4 cv=LJ6tQ4W9 c=1 sm=1 tr=0 ts=66c28ab8
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=FXvPX3liAAAA:8
 a=zvuxCLvZWVJikxbZp60A:9 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: willy@infradead.org,
	lizetao1@huawei.com,
	Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH 2/4] Squashfs: Update squashfs_readahead() to not use page->index
Date: Mon, 19 Aug 2024 00:58:45 +0100
Message-Id: <20240818235847.170468-3-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240818235847.170468-1-phillip@squashfs.org.uk>
References: <20240818235847.170468-1-phillip@squashfs.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFb2ovMBOh8BLMyp5LuvcpONdolk5ZxlPm3dw/0yXCFT9HYtOK8GhpUQKtPX8DJpbXCfsaSFc5Tcuf9G1s3nIil/jU5CC0PlhIhECCK5zW3bJfoaNM4Y
 M3Rq61j4sHsz4lnW1U0bmkKsGVBNorkUDnoG9yKnp8Ayj9gIWUCfjNnO5VgU2EhkVfURNTCSqlnsvtu/137uSsy/mCOXbzwBaWA7SH4YeIOlxtMXM5URuVbx
 Em8Q+akYJwoWeU0tWjAYvY3kxaDzEWmlVpXeA3n5RO9DIbM48tZ1r/6go+5oaeZHgCwZINJphtdaxghkyV6FUR/L9wPDrhF5GpqsW7flIfoEcJi/X19TtcG/
 n5nIDXSX2Cq6hzKREbsLDOBtiUV2AFZfxFZjfoItUU90FoWCeUY=

This commit removes references to page->index in the pages returned
from __readahead_batch(), and instead uses the 'start' variable.

This does reveal a bug in the previous code in that 'start' was
not updated every time around the loop.  This is fixed in this
commit.

Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
 fs/squashfs/file.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index 2b6b63f4ccd1..50fe5a078b83 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -551,7 +551,6 @@ static void squashfs_readahead(struct readahead_control *ractl)
 		return;
 
 	for (;;) {
-		pgoff_t index;
 		int res, bsize;
 		u64 block = 0;
 		unsigned int expected;
@@ -570,13 +569,8 @@ static void squashfs_readahead(struct readahead_control *ractl)
 		if (readahead_pos(ractl) >= i_size_read(inode))
 			goto skip_pages;
 
-		index = pages[0]->index >> shift;
-
-		if ((pages[nr_pages - 1]->index >> shift) != index)
-			goto skip_pages;
-
-		if (index == file_end && squashfs_i(inode)->fragment_block !=
-						SQUASHFS_INVALID_BLK) {
+		if (start >> msblk->block_log == file_end &&
+				squashfs_i(inode)->fragment_block != SQUASHFS_INVALID_BLK) {
 			res = squashfs_readahead_fragment(pages, nr_pages,
 							  expected);
 			if (res)
@@ -584,7 +578,7 @@ static void squashfs_readahead(struct readahead_control *ractl)
 			continue;
 		}
 
-		bsize = read_blocklist(inode, index, &block);
+		bsize = read_blocklist(inode, start >> msblk->block_log, &block);
 		if (bsize == 0)
 			goto skip_pages;
 
@@ -602,7 +596,7 @@ static void squashfs_readahead(struct readahead_control *ractl)
 
 			/* Last page (if present) may have trailing bytes not filled */
 			bytes = res % PAGE_SIZE;
-			if (index == file_end && bytes && last_page)
+			if (start >> msblk->block_log == file_end && bytes && last_page)
 				memzero_page(last_page, bytes,
 					     PAGE_SIZE - bytes);
 
@@ -616,6 +610,8 @@ static void squashfs_readahead(struct readahead_control *ractl)
 			unlock_page(pages[i]);
 			put_page(pages[i]);
 		}
+
+		start += readahead_batch_length(ractl);
 	}
 
 	kfree(pages);
-- 
2.39.2


