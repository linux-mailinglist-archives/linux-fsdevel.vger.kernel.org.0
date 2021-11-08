Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01CE447967
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 05:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbhKHEfI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Nov 2021 23:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbhKHEfH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Nov 2021 23:35:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5FEC061570;
        Sun,  7 Nov 2021 20:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=RSWa6K0pUAnHxgFaPZenOcWe2pyN0Haz/Bc0OfYIlB0=; b=uCfwPUlzhfTU/iXLoZUGvNx9D+
        SxGdFls4BJLDRdCdZjr25+ugez6vrsos6bQ5APzH2w3Gu8K/mkggVHVpqE/pm+F94MLqufMVCUdiV
        +Ozu8y85oV0kgKE/JuYrBboAohXGv0WFb9ZAyTRlFO2JFgJCuMm5lvX1PvPQNrXdw/DGlyvNNRXRX
        MfF5xqDbsPY+UoyDTham/rhUzbU/suYPTtaQs4OIQLWfBECYWe7lqRjaXSRJbeFyojhNSJHm7toZq
        fsexzEYPz5BbuSzhd17MFiNHlMrdCrIiAx6kE4+/BIMC7xLOAmoCshiFkC0jGSpDYblJiFpKLVTnY
        2TY62HYA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjwH2-0089yn-4m; Mon, 08 Nov 2021 04:29:22 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J . Wong " <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 09/28] iomap: Convert iomap_page_create to take a folio
Date:   Mon,  8 Nov 2021 04:05:32 +0000
Message-Id: <20211108040551.1942823-10-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108040551.1942823-1-willy@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function already assumed it was being passed a head page, so
just formalise that.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 236beeeaef42..6972ac8fda77 100644
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
@@ -1290,7 +1292,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
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

