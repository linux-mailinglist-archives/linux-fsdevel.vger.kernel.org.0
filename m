Return-Path: <linux-fsdevel+bounces-2639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4767E7360
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 22:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 793DC281401
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 21:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3040374F6;
	Thu,  9 Nov 2023 21:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l8tn+xZh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AB5374EC
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 21:06:35 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A17186
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 13:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=gTy9AWa1qoaeSYWP7pvOeRn5/jbkYSHToiAygTFIVHw=; b=l8tn+xZhuHJgsQ1j+G9CDl+ysQ
	aghQS3jFk/xlC9FFkEJBQORmzNO5gYYw2nL8r82bz/S796xu1Q/c5INHdaR59Ugior4aTFF3Zq0lr
	DIxuawnmyu9VwbiW05UKu9JNBi0pWDivq1Yzm5RMrVi5xsWPBDFGlwD88/Gk5ZzNK2++LNXzK6aSB
	xz6vWBs5ockrl9yngKSRHFKPSo04/24jYbiwGuxUvLAgbDK7cISePI/F4z+mslZNV4JiKDpjZAf3F
	lgR+snleq7p6RGjLH3kPMOs6+xEK/yur5RXi9Uf7CPd3tZFYTiKs1T8BPCppNCnXWFu7seB4wcWfr
	zyv/TicA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r1CE8-009RwD-3s; Thu, 09 Nov 2023 21:06:12 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 7/7] buffer: Fix more functions for block size > PAGE_SIZE
Date: Thu,  9 Nov 2023 21:06:08 +0000
Message-Id: <20231109210608.2252323-8-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231109210608.2252323-1-willy@infradead.org>
References: <20231109210608.2252323-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both __block_write_full_folio() and block_read_full_folio() assumed
that block size <= PAGE_SIZE.  Replace the shift with a divide, which
is probably cheaper than first calculating the shift.  That lets us
remove block_size_bits() as these were the last callers.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index ef444ab53a9b..4eb44ccdc6be 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1742,19 +1742,6 @@ void clean_bdev_aliases(struct block_device *bdev, sector_t block, sector_t len)
 }
 EXPORT_SYMBOL(clean_bdev_aliases);
 
-/*
- * Size is a power-of-two in the range 512..PAGE_SIZE,
- * and the case we care about most is PAGE_SIZE.
- *
- * So this *could* possibly be written with those
- * constraints in mind (relevant mostly if some
- * architecture has a slow bit-scan instruction)
- */
-static inline int block_size_bits(unsigned int blocksize)
-{
-	return ilog2(blocksize);
-}
-
 static struct buffer_head *folio_create_buffers(struct folio *folio,
 						struct inode *inode,
 						unsigned int b_state)
@@ -1807,7 +1794,7 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 	sector_t block;
 	sector_t last_block;
 	struct buffer_head *bh, *head;
-	unsigned int blocksize, bbits;
+	size_t blocksize;
 	int nr_underway = 0;
 	blk_opf_t write_flags = wbc_to_write_flags(wbc);
 
@@ -1826,10 +1813,9 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 
 	bh = head;
 	blocksize = bh->b_size;
-	bbits = block_size_bits(blocksize);
 
-	block = (sector_t)folio->index << (PAGE_SHIFT - bbits);
-	last_block = (i_size_read(inode) - 1) >> bbits;
+	block = div_u64(folio_pos(folio), blocksize);
+	last_block = div_u64(i_size_read(inode) - 1, blocksize);
 
 	/*
 	 * Get all the dirty buffers mapped to disk addresses and
@@ -2355,7 +2341,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 	struct inode *inode = folio->mapping->host;
 	sector_t iblock, lblock;
 	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
-	unsigned int blocksize, bbits;
+	size_t blocksize;
 	int nr, i;
 	int fully_mapped = 1;
 	bool page_error = false;
@@ -2369,10 +2355,9 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 
 	head = folio_create_buffers(folio, inode, 0);
 	blocksize = head->b_size;
-	bbits = block_size_bits(blocksize);
 
-	iblock = (sector_t)folio->index << (PAGE_SHIFT - bbits);
-	lblock = (limit+blocksize-1) >> bbits;
+	iblock = div_u64(folio_pos(folio), blocksize);
+	lblock = div_u64(limit + blocksize - 1, blocksize);
 	bh = head;
 	nr = 0;
 	i = 0;
-- 
2.42.0


