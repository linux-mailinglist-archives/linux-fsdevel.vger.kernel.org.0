Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBC83C9816
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 07:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239140AbhGOFNJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 01:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbhGOFNJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:13:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6C4C06175F;
        Wed, 14 Jul 2021 22:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=iKO5l/n8beUKjqGQiuX0uQAJJo3Y4Gq1sxQOC/iyLJw=; b=VQ6KJ5bT1WcA4EmMH3cUm6l73X
        1hoRrYguQh0g6AOJSYTXkmwwZ8RRPzgQW4+heHreZZ9LogBBNeHVEYSi3cR9FaRmP9eXy89yQ4MQZ
        dUE0uhgWWl3/0N9zqCC4s4w0k9ug5oWRSgqWQ577cmmVHwJK9U14E42ITuiYnYUBpx13ytWDvWBwB
        K+Kq6a+SYLNmn6fh8+jesyqVAx4mUuMzaOjCuOFhBDwBRt83C9EsaEhyiM1XNmpLY5ChXeCTail4j
        Um9B7H1ikUIwJ540h7SYq436wyWFRLxs80X4tS91wI6mdRYBmd8tQjrDWPhui7Pgmdzj38VYHIQUF
        bobh9/GQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3tbv-00308H-1C; Thu, 15 Jul 2021 05:08:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 113/138] mm/filemap: Convert find_get_pages_contig to folios
Date:   Thu, 15 Jul 2021 04:36:39 +0100
Message-Id: <20210715033704.692967-114-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
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
index 04501bf50448..5a273d07eae6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2141,36 +2141,35 @@ unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t index,
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
2.30.2

