Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CACB3C429B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 06:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhGLEJC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 00:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhGLEJB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:09:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533CEC0613DD;
        Sun, 11 Jul 2021 21:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Gbm0utfzsbXXnIAuOZcZguZoSY9jTjSeePDJZQXsoxs=; b=MFsyFDjFnBr1Mnrx+gaOkMhGYG
        WIQUl1S3YKpoUWNkZ0l6sD+yZ/E1M6Y6td5ncFn69TcO3RbcCDhwi9j1baqJZ0AAjjO1C4/n0bboH
        S35StTL+gB4/+rc1MjIpDMe1d9rdS3ZIaGSaWkfk9vVaf5ylUfBqlf6RRCgXF69VO0nLN6z3ROXvM
        wQRka/HhSqupUV0f3TQNPMGlZH/d282J/OICJ5lFzYEKb4GaHSl7x6y5qkGsiDvbC70gaqRnXJLen
        WwJjV3JPFTViW9wNBdj58VZn5W/GHuPJFBnP2p271ST1M/dh5OrTiAyFKfIwTBSoXsHJAAC781X7i
        0X3lMCLw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2nBw-00Gqsi-Gn; Mon, 12 Jul 2021 04:05:27 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 111/137] mm/filemap: Convert filemap_get_read_batch to use folios
Date:   Mon, 12 Jul 2021 04:06:35 +0100
Message-Id: <20210712030701.4000097-112-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The page cache only stores folios, never tail pages.  Saves 29 bytes
due to removing calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 4920f52268a3..3d1a8d5f595b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2272,32 +2272,31 @@ static void filemap_get_read_batch(struct address_space *mapping,
 		pgoff_t index, pgoff_t max, struct pagevec *pvec)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
-	struct page *head;
+	struct folio *folio;
 
 	rcu_read_lock();
-	for (head = xas_load(&xas); head; head = xas_next(&xas)) {
-		if (xas_retry(&xas, head))
+	for (folio = xas_load(&xas); folio; folio = xas_next(&xas)) {
+		if (xas_retry(&xas, folio))
 			continue;
-		if (xas.xa_index > max || xa_is_value(head))
+		if (xas.xa_index > max || xa_is_value(folio))
 			break;
-		if (!page_cache_get_speculative(head))
+		if (!folio_try_get_rcu(folio))
 			goto retry;
 
-		/* Has the page moved or been split? */
-		if (unlikely(head != xas_reload(&xas)))
+		if (unlikely(folio != xas_reload(&xas)))
 			goto put_page;
 
-		if (!pagevec_add(pvec, head))
+		if (!pagevec_add(pvec, &folio->page))
 			break;
-		if (!PageUptodate(head))
+		if (!folio_uptodate(folio))
 			break;
-		if (PageReadahead(head))
+		if (folio_readahead(folio))
 			break;
-		xas.xa_index = head->index + thp_nr_pages(head) - 1;
+		xas.xa_index = folio->index + folio_nr_pages(folio) - 1;
 		xas.xa_offset = (xas.xa_index >> xas.xa_shift) & XA_CHUNK_MASK;
 		continue;
 put_page:
-		put_page(head);
+		folio_put(folio);
 retry:
 		xas_reset(&xas);
 	}
-- 
2.30.2

