Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1AE73CEF2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 00:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386793AbhGSVcE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 17:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349215AbhGSSF5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:05:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF15C061787;
        Mon, 19 Jul 2021 11:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=EgqZeV+YXoPwC3VyWrO7ZM46UKPgEwS7pK1czp7B0BA=; b=tfu7I2yHFOHf8awsTxvo5f++kx
        dINVZ/N6uYDnoqiJVwhlku5qlhqjRTFCDBZ70qH8G/9lsTWtpvPTViL338LYYFuRf9gHI680GL458
        b51zrdYW9KX8h+ZUW8NVEPLRA2I/gFhE9VSquXorCJ6lQPKpJcUAywEOOzScQx+GXqQtkrVFe4sjI
        yLBA/2XCSwp/O68IjtVFQTYfvAOyKbOVFTne3NiKWquuRxVD8lVip4/8b7xoTpWRZt0gqVEYZl6Ia
        EBfuOVsRAFcDb0aqmoWgIyb8OnIXI/cZieT6hTujGFYfuCw/XRxLJEDM9QdN3uHRrHzK8ZJzglpgB
        k57w7W0Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5YCr-007LWK-KZ; Mon, 19 Jul 2021 18:41:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v15 03/17] iomap: Convert to_iomap_page to take a folio
Date:   Mon, 19 Jul 2021 19:39:47 +0100
Message-Id: <20210719184001.1750630-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210719184001.1750630-1-willy@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The big comment about only using a head page can go away now that
it takes a folio argument.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 87ccb3438bec..d4870a2691f9 100644
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
@@ -435,7 +431,8 @@ int
 iomap_is_partially_uptodate(struct page *page, unsigned long from,
 		unsigned long count)
 {
-	struct iomap_page *iop = to_iomap_page(page);
+	struct folio *folio = page_folio(page);
+	struct iomap_page *iop = to_iomap_page(folio);
 	struct inode *inode = page->mapping->host;
 	unsigned len, first, last;
 	unsigned i;
@@ -1012,7 +1009,8 @@ static void
 iomap_finish_page_writeback(struct inode *inode, struct page *page,
 		int error, unsigned int len)
 {
-	struct iomap_page *iop = to_iomap_page(page);
+	struct folio *folio = page_folio(page);
+	struct iomap_page *iop = to_iomap_page(folio);
 
 	if (error) {
 		SetPageError(page);
-- 
2.30.2

