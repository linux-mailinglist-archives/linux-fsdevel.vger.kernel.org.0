Return-Path: <linux-fsdevel+bounces-37992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E689F9CD1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 23:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D09718985B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 22:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BB222757C;
	Fri, 20 Dec 2024 22:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D88PmcTS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566B321A42A
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734734801; cv=none; b=moCJMPGoym7FI6dw6YDxC8lHpasXSX724FpJLDqWNWsoQPYIy0Zs1+R1O5shATra/z09mHdQhaKxH82VeA1qC2jBz7Fls5G94EI4oSuTRy1bZzx2+CPt3iE31SA2rJZz5onYC6kurGWyIy7xGpBGyTFuUiayXuZHwRTl2DJgBok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734734801; c=relaxed/simple;
	bh=29b4/3+w7WrpvUQTK7ryqkju2eK/Tq5EMGwmH9ADIF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHQ9eVOGnGjhHp8nRoui5cy2dq9s4UJImD6rS78ZekrvTVEcvkosg6HAP8nis+GhpvUJLlN7G+rYqEqUo20I3yHtksU2HSnCGnkAgJtsBZ1RSX64+pz5xa7mUbjFUAJWejslZX5R9N9Gj19AxiLH3ddwaLD++/Bx4e4FTOsnE6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D88PmcTS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=eJNIAPCs4sCCfLCR9H+1hO5eJPipcnwMIjpH52PWdqw=; b=D88PmcTSoOzxVddnOYKAZzlvVN
	o9H3qbGh2bafWqgKVwpcWWtIelH5b8DM5BLiexktXirlWdbK7ATFqiejkAXFRrHM2YrfzYNsmgniQ
	BdF3Z4OVTegtmef1fFO77Tp//sGGeZwfNYX9XCmCTnzGG74n5R4Pt9fD1C9vbkYHTrKpGBVWOks19
	9p1ptmOGwwq3sXRxRqbGGVLGc28vmo3vXmCd+yEJFv9HL9vnFKDha82/yiB/zOGgySd9OKQpeqotc
	ePIURSjU9VimYdgFDrKkcgxV5jS0r3xkUH2jbarowo1EeHMmDADuyWj0cH4hBWZkxI/1OItmq2qcC
	2kn6K9cw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tOllU-000000032NL-0G2G;
	Fri, 20 Dec 2024 22:46:36 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 3/5] squashfs: Convert squashfs_readpage_block() to take a folio
Date: Fri, 20 Dec 2024 22:46:26 +0000
Message-ID: <20241220224634.723899-3-willy@infradead.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220224634.723899-1-willy@infradead.org>
References: <20241220224634.723899-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove a few accesses to page->mapping.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/squashfs/file.c        |  2 +-
 fs/squashfs/file_cache.c  |  6 +++---
 fs/squashfs/file_direct.c | 11 +++++------
 fs/squashfs/squashfs.h    |  2 +-
 4 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index 6bd16e12493b..5b81e26b1226 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -472,7 +472,7 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
 		if (res == 0)
 			res = squashfs_readpage_sparse(&folio->page, expected);
 		else
-			res = squashfs_readpage_block(&folio->page, block, res, expected);
+			res = squashfs_readpage_block(folio, block, res, expected);
 	} else
 		res = squashfs_readpage_fragment(folio, expected);
 
diff --git a/fs/squashfs/file_cache.c b/fs/squashfs/file_cache.c
index 54c17b7c85fd..0360d22a77d4 100644
--- a/fs/squashfs/file_cache.c
+++ b/fs/squashfs/file_cache.c
@@ -18,9 +18,9 @@
 #include "squashfs.h"
 
 /* Read separately compressed datablock and memcopy into page cache */
-int squashfs_readpage_block(struct page *page, u64 block, int bsize, int expected)
+int squashfs_readpage_block(struct folio *folio, u64 block, int bsize, int expected)
 {
-	struct inode *i = page->mapping->host;
+	struct inode *i = folio->mapping->host;
 	struct squashfs_cache_entry *buffer = squashfs_get_datablock(i->i_sb,
 		block, bsize);
 	int res = buffer->error;
@@ -29,7 +29,7 @@ int squashfs_readpage_block(struct page *page, u64 block, int bsize, int expecte
 		ERROR("Unable to read page, block %llx, size %x\n", block,
 			bsize);
 	else
-		squashfs_copy_cache(page, buffer, expected, 0);
+		squashfs_copy_cache(&folio->page, buffer, expected, 0);
 
 	squashfs_cache_put(buffer);
 	return res;
diff --git a/fs/squashfs/file_direct.c b/fs/squashfs/file_direct.c
index d19d4db74af8..2c3e809d6891 100644
--- a/fs/squashfs/file_direct.c
+++ b/fs/squashfs/file_direct.c
@@ -19,12 +19,11 @@
 #include "page_actor.h"
 
 /* Read separately compressed datablock directly into page cache */
-int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
-	int expected)
-
+int squashfs_readpage_block(struct folio *folio, u64 block, int bsize,
+		int expected)
 {
-	struct folio *folio = page_folio(target_page);
-	struct inode *inode = target_page->mapping->host;
+	struct page *target_page = &folio->page;
+	struct inode *inode = folio->mapping->host;
 	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
 	loff_t file_end = (i_size_read(inode) - 1) >> PAGE_SHIFT;
 	int mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
@@ -48,7 +47,7 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 	/* Try to grab all the pages covered by the Squashfs block */
 	for (i = 0, index = start_index; index <= end_index; index++) {
 		page[i] = (index == folio->index) ? target_page :
-			grab_cache_page_nowait(target_page->mapping, index);
+			grab_cache_page_nowait(folio->mapping, index);
 
 		if (page[i] == NULL)
 			continue;
diff --git a/fs/squashfs/squashfs.h b/fs/squashfs/squashfs.h
index 5a756e6790b5..0f5373479516 100644
--- a/fs/squashfs/squashfs.h
+++ b/fs/squashfs/squashfs.h
@@ -72,7 +72,7 @@ void squashfs_copy_cache(struct page *, struct squashfs_cache_entry *, int,
 				int);
 
 /* file_xxx.c */
-extern int squashfs_readpage_block(struct page *, u64, int, int);
+int squashfs_readpage_block(struct folio *, u64 block, int bsize, int expected);
 
 /* id.c */
 extern int squashfs_get_id(struct super_block *, unsigned int, unsigned int *);
-- 
2.45.2


