Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796434421F5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 21:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhKAUyU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 16:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhKAUyP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 16:54:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF786C0613F5;
        Mon,  1 Nov 2021 13:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=pKipNU+lEAjhVSQ3Tkmyv/GLC/BUcwk9tw9WCTfJskE=; b=LqT0G71GR1gkLCLLNaPbl9C66p
        QFXnREZphQMAeql5Q3yS0YG4oMDQq5uQvKeLWLEer5BGMr+p2lqg6FD/zRm5EQnVDfI05dNMwxkhj
        epBMupQkWCGsIHAktS/Z4LP1HLH6sRQ8Z+Ocy9uc+2RVbcmUjeWRSvID2r1/Ppg+nSSEujqo9+aIq
        4L+bKKFG+gYTCq4COx7erDu9Dd4Deaftl1+W6nPc6aOG1CXa558fspI+moKoo77zXlarwErE+igjL
        p4JotIX6Ql1hxIzfG7BEaVzhC+Jt10PSKmXpfPEFat3XRr4NpkdsCBW+7dD1hjVyR8Q7lCU7TFvIP
        ARDCJdPg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mheDR-0040dW-Gj; Mon, 01 Nov 2021 20:48:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 05/21] iomap: Convert iomap_page_create to take a folio
Date:   Mon,  1 Nov 2021 20:39:13 +0000
Message-Id: <20211101203929.954622-6-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211101203929.954622-1-willy@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function already assumed it was being passed a head page, so
just formalise that.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 24a2aa69c467..d96c00c1e9e3 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -42,11 +42,10 @@ static inline struct iomap_page *to_iomap_page(struct folio *folio)
 static struct bio_set iomap_ioend_bioset;
 
 static struct iomap_page *
-iomap_page_create(struct inode *inode, struct page *page)
+iomap_page_create(struct inode *inode, struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	struct iomap_page *iop = to_iomap_page(folio);
-	unsigned int nr_blocks = i_blocks_per_page(inode, page);
+	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
 
 	if (iop || nr_blocks <= 1)
 		return iop;
@@ -54,9 +53,9 @@ iomap_page_create(struct inode *inode, struct page *page)
 	iop = kzalloc(struct_size(iop, uptodate, BITS_TO_LONGS(nr_blocks)),
 			GFP_NOFS | __GFP_NOFAIL);
 	spin_lock_init(&iop->uptodate_lock);
-	if (PageUptodate(page))
+	if (folio_test_uptodate(folio))
 		bitmap_fill(iop->uptodate, nr_blocks);
-	attach_page_private(page, iop);
+	folio_attach_private(folio, iop);
 	return iop;
 }
 
@@ -204,6 +203,7 @@ struct iomap_readpage_ctx {
 static loff_t iomap_read_inline_data(const struct iomap_iter *iter,
 		struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	const struct iomap *iomap = iomap_iter_srcmap(iter);
 	size_t size = i_size_read(iter->inode) - iomap->offset;
 	size_t poff = offset_in_page(iomap->offset);
@@ -220,7 +220,7 @@ static loff_t iomap_read_inline_data(const struct iomap_iter *iter,
 	if (WARN_ON_ONCE(size > iomap->length))
 		return -EIO;
 	if (poff > 0)
-		iomap_page_create(iter->inode, page);
+		iomap_page_create(iter->inode, folio);
 
 	addr = kmap_local_page(page) + poff;
 	memcpy(addr, iomap->inline_data, size);
@@ -247,6 +247,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	loff_t pos = iter->pos + offset;
 	loff_t length = iomap_length(iter) - offset;
 	struct page *page = ctx->cur_page;
+	struct folio *folio = page_folio(page);
 	struct iomap_page *iop;
 	loff_t orig_pos = pos;
 	unsigned poff, plen;
@@ -256,7 +257,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 		return min(iomap_read_inline_data(iter, page), length);
 
 	/* zero post-eof blocks as the page may be mapped */
-	iop = iomap_page_create(iter->inode, page);
+	iop = iomap_page_create(iter->inode, folio);
 	iomap_adjust_read_range(iter->inode, iop, &pos, length, &poff, &plen);
 	if (plen == 0)
 		goto done;
@@ -536,8 +537,9 @@ iomap_read_page_sync(loff_t block_start, struct page *page, unsigned poff,
 static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 		unsigned len, struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
-	struct iomap_page *iop = iomap_page_create(iter->inode, page);
+	struct iomap_page *iop = iomap_page_create(iter->inode, folio);
 	loff_t block_size = i_blocksize(iter->inode);
 	loff_t block_start = round_down(pos, block_size);
 	loff_t block_end = round_up(pos + len, block_size);
@@ -1287,7 +1289,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct inode *inode,
 		struct page *page, u64 end_offset)
 {
-	struct iomap_page *iop = iomap_page_create(inode, page);
+	struct folio *folio = page_folio(page);
+	struct iomap_page *iop = iomap_page_create(inode, folio);
 	struct iomap_ioend *ioend, *next;
 	unsigned len = i_blocksize(inode);
 	u64 file_offset; /* file offset of page */
-- 
2.33.0

