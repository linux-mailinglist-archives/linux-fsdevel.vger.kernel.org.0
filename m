Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3A146CC6A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244260AbhLHE1j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240071AbhLHE0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B53EC061D5E
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/Jrg5K2lm0b8mctZUfSr5Z1cNwHiyfe9P0jRf7cbjh8=; b=EUeKL+/oZub5WS+fcIk5TDXrNv
        b/hrZwkF/9xfkhxX1ONt53rcg6HvZ+Wez9MHjE4HWnpz5AIJeyn2cPHRJ+mJRP65IyfWNKKPoj4m1
        YDWG9bcS9duVzCCrf1rQcugMsCXXvgb7KV6ubJvkQAKubjI9DSuzCJPB4CVys3CyszJQaRVjEltoV
        5vpEvMy9vUhUSI9/Hlrri3UKEj6HgIBi4xLGXPnxZBpwEOXqY+wgZo8pqJeDfeny8hQlAoW5sq5v6
        ClPlMoyS+NgLHcmNTZDGqMaKDfeb0Do6In0fqHYoQ2FB+gruQdONAnkdfQSGUOpzBlm3nAYW5O2iQ
        +0hhvB0g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU3-0084Y6-HU; Wed, 08 Dec 2021 04:23:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 17/48] filemap: Convert find_get_pages_contig to folios
Date:   Wed,  8 Dec 2021 04:22:25 +0000
Message-Id: <20211208042256.1923824-18-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

None of the callers of find_get_pages_contig() want tail pages.  They all
use order-0 pages today, but if they were converted, they'd want folios.
So just remove the call to find_subpage() instead of replacing it with
folio_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 120df74f3c7c..33e638f1ca34 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2208,36 +2208,35 @@ unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t index,
 			       unsigned int nr_pages, struct page **pages)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
-	struct page *page;
+	struct folio *folio;
 	unsigned int ret = 0;
 
 	if (unlikely(!nr_pages))
 		return 0;
 
 	rcu_read_lock();
-	for (page = xas_load(&xas); page; page = xas_next(&xas)) {
-		if (xas_retry(&xas, page))
+	for (folio = xas_load(&xas); folio; folio = xas_next(&xas)) {
+		if (xas_retry(&xas, folio))
 			continue;
 		/*
 		 * If the entry has been swapped out, we can stop looking.
 		 * No current caller is looking for DAX entries.
 		 */
-		if (xa_is_value(page))
+		if (xa_is_value(folio))
 			break;
 
-		if (!page_cache_get_speculative(page))
+		if (!folio_try_get_rcu(folio))
 			goto retry;
 
-		/* Has the page moved or been split? */
-		if (unlikely(page != xas_reload(&xas)))
+		if (unlikely(folio != xas_reload(&xas)))
 			goto put_page;
 
-		pages[ret] = find_subpage(page, xas.xa_index);
+		pages[ret] = &folio->page;
 		if (++ret == nr_pages)
 			break;
 		continue;
 put_page:
-		put_page(page);
+		folio_put(folio);
 retry:
 		xas_reset(&xas);
 	}
-- 
2.33.0

