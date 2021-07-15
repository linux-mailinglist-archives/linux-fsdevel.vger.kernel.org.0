Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325B83C97BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238405AbhGOEyL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhGOEyJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:54:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFD4C06175F;
        Wed, 14 Jul 2021 21:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2KpmNuKLiK5ZYO19bJdoGPIqxKSeXt3hnU6HI4Rc9NE=; b=nky4SLrO48mT8+vurxROT4XMyi
        bTjcrohko+HTfCUc2Pd4PatEQ0PyVHNozKBxsUrRe/uU3MvK7IRYP967M0Fr2akHMmTdzDUdw62Is
        lWLYYewo876UrQRMebptn9FlbmJcU1TRJvyTU5+HOPwU727t44VLKEiT7LuhIDUhRnGctdsZbYrs5
        xyTmtdNNfGjakoTo2mAEOPVAuS3ihJZvGa3p0zNXF9bksZnd8K/5Ke5C3wKkJ3LH7d4SRFg17F2BZ
        Th2nAVDVQEqvf9/Qh25n8xKV3KRqR2h3Z42dAze++ofsBBcQvhwk1P9yAiCyJIAoZn0q5D4uIHs/K
        HptGTFTA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3tJL-002ypl-9Y; Thu, 15 Jul 2021 04:49:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 092/138] iomap: Convert to_iomap_page to take a folio
Date:   Thu, 15 Jul 2021 04:36:18 +0100
Message-Id: <20210715033704.692967-93-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The big comment about only using a head page can go away now that
it takes a folio argument.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 41da4f14c00b..cd5c2f24cb7e 100644
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
-	 * not be dealing with tail pages (and if they are, they can
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
@@ -433,7 +429,8 @@ int
 iomap_is_partially_uptodate(struct page *page, unsigned long from,
 		unsigned long count)
 {
-	struct iomap_page *iop = to_iomap_page(page);
+	struct folio *folio = page_folio(page);
+	struct iomap_page *iop = to_iomap_page(folio);
 	struct inode *inode = page->mapping->host;
 	unsigned len, first, last;
 	unsigned i;
@@ -1011,7 +1008,8 @@ static void
 iomap_finish_page_writeback(struct inode *inode, struct page *page,
 		int error, unsigned int len)
 {
-	struct iomap_page *iop = to_iomap_page(page);
+	struct folio *folio = page_folio(page);
+	struct iomap_page *iop = to_iomap_page(folio);
 
 	if (error) {
 		SetPageError(page);
@@ -1304,7 +1302,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct inode *inode,
 		struct page *page, u64 end_offset)
 {
-	struct iomap_page *iop = to_iomap_page(page);
+	struct folio *folio = page_folio(page);
+	struct iomap_page *iop = to_iomap_page(folio);
 	struct iomap_ioend *ioend, *next;
 	unsigned len = i_blocksize(inode);
 	u64 file_offset; /* file offset of page */
-- 
2.30.2

