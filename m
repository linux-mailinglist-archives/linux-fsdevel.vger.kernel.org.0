Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62DF9447962
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 05:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbhKHEdG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Nov 2021 23:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbhKHEdF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Nov 2021 23:33:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0497DC061570;
        Sun,  7 Nov 2021 20:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vOKnloFwyILMUGc+FrSHFMnIPkUr1ZUZ+n3e/FqYtOo=; b=d5z4YzmzsXCT/4NnmIscKUefxI
        943tpjLInSam89eqPVdbcEqKd0sWaNIDENIu6dK9pEOcWBm/oxbZcxXXG3pgalms681dWBaS/htlf
        eWJH5kG5f33HbKg/9v2kll3Dig52QvTBPzCEuSD9WBhgN/VyteHsrbMM1gdHypicPAlgMegqaVEY7
        PMLvamWSvjUsAZJwInmY+4JJ1PFsxf6N45VhNrdLcsRi5aj8rYoaQDvnEI2Ny3oz/RSbknGOvP676
        hAFpIERpMcXTHRi5fnKLrtUYM3C6SA6p+zwvVYNwkLcOZUyL8O8HrJA56NthtOkwI7DYSZvSFBDbx
        zHinNoNg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjwEU-0089vQ-Qs; Mon, 08 Nov 2021 04:27:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J . Wong " <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 08/28] iomap: Convert to_iomap_page to take a folio
Date:   Mon,  8 Nov 2021 04:05:31 +0000
Message-Id: <20211108040551.1942823-9-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108040551.1942823-1-willy@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The big comment about only using a head page can go away now that
it takes a folio argument.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4e09ea823148..236beeeaef42 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -22,8 +22,8 @@
 #include "../internal.h"
 
 /*
- * Structure allocated for each page or THP when block size < page size
- * to track sub-page uptodate status and I/O completions.
+ * Structure allocated for each folio when block size < folio size
+ * to track sub-folio uptodate status and I/O completions.
  */
 struct iomap_page {
 	atomic_t		read_bytes_pending;
@@ -32,17 +32,10 @@ struct iomap_page {
 	unsigned long		uptodate[];
 };
 
-static inline struct iomap_page *to_iomap_page(struct page *page)
+static inline struct iomap_page *to_iomap_page(struct folio *folio)
 {
-	/*
-	 * per-block data is stored in the head page.  Callers should
-	 * not be dealing with tail pages, and if they are, they can
-	 * call thp_head() first.
-	 */
-	VM_BUG_ON_PGFLAGS(PageTail(page), page);
-
-	if (page_has_private(page))
-		return (struct iomap_page *)page_private(page);
+	if (folio_test_private(folio))
+		return folio_get_private(folio);
 	return NULL;
 }
 
@@ -51,7 +44,8 @@ static struct bio_set iomap_ioend_bioset;
 static struct iomap_page *
 iomap_page_create(struct inode *inode, struct page *page)
 {
-	struct iomap_page *iop = to_iomap_page(page);
+	struct folio *folio = page_folio(page);
+	struct iomap_page *iop = to_iomap_page(folio);
 	unsigned int nr_blocks = i_blocks_per_page(inode, page);
 
 	if (iop || nr_blocks <= 1)
@@ -144,7 +138,8 @@ iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
 static void
 iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
 {
-	struct iomap_page *iop = to_iomap_page(page);
+	struct folio *folio = page_folio(page);
+	struct iomap_page *iop = to_iomap_page(folio);
 	struct inode *inode = page->mapping->host;
 	unsigned first = off >> inode->i_blkbits;
 	unsigned last = (off + len - 1) >> inode->i_blkbits;
@@ -173,7 +168,8 @@ static void
 iomap_read_page_end_io(struct bio_vec *bvec, int error)
 {
 	struct page *page = bvec->bv_page;
-	struct iomap_page *iop = to_iomap_page(page);
+	struct folio *folio = page_folio(page);
+	struct iomap_page *iop = to_iomap_page(folio);
 
 	if (unlikely(error)) {
 		ClearPageUptodate(page);
@@ -427,7 +423,8 @@ int
 iomap_is_partially_uptodate(struct page *page, unsigned long from,
 		unsigned long count)
 {
-	struct iomap_page *iop = to_iomap_page(page);
+	struct folio *folio = page_folio(page);
+	struct iomap_page *iop = to_iomap_page(folio);
 	struct inode *inode = page->mapping->host;
 	unsigned len, first, last;
 	unsigned i;
@@ -1006,7 +1003,8 @@ static void
 iomap_finish_page_writeback(struct inode *inode, struct page *page,
 		int error, unsigned int len)
 {
-	struct iomap_page *iop = to_iomap_page(page);
+	struct folio *folio = page_folio(page);
+	struct iomap_page *iop = to_iomap_page(folio);
 
 	if (error) {
 		SetPageError(page);
-- 
2.33.0

