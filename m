Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB96E46CC85
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240345AbhLHE3G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240099AbhLHE0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC165C061D7E
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=t4pwlbtmjecL2V1Nz4HoWruFyvYom5U3vixCYsyX2S8=; b=EOFAdrF9B0cYq4AWYNj0NL4Oka
        6cEb9SbPxApoqG/263g/BskuoT/olUn8FAQqUbnMGLiplE9Ekj+NVGb09QaF/1f6GaCwS5SRSFzN7
        f91kISzGCXDOnc1oqctDBkdf0njk4VfnvGdvPDP2rCPDB+JsADIeyvR4PcXP9xleJcCBE+JW6UhJD
        H2SZ03zyxCKA0pbSQvd49klJvNiONagFNHKFCDEkiMabQMw30eP7MvEIDtvjUyuBw/gH0Gcr1HY+A
        oomCJ1z5wCSpNtAZo7vgB6/QHm1CADFYEmhsleHTVY67AIprbs4HKgp2kAv8SrtSjyR4cDzaH9tjM
        Jvw+rrtQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU4-0084Yh-52; Wed, 08 Dec 2021 04:23:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 22/48] readahead: Convert page_cache_ra_unbounded to folios
Date:   Wed,  8 Dec 2021 04:22:30 +0000
Message-Id: <20211208042256.1923824-23-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This saves 99 bytes of kernel text.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/readahead.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index e48e78641772..cf0dcf89eb69 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -196,9 +196,9 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	 * Preallocate as many pages as we will need.
 	 */
 	for (i = 0; i < nr_to_read; i++) {
-		struct page *page = xa_load(&mapping->i_pages, index + i);
+		struct folio *folio = xa_load(&mapping->i_pages, index + i);
 
-		if (page && !xa_is_value(page)) {
+		if (folio && !xa_is_value(folio)) {
 			/*
 			 * Page already present?  Kick off the current batch
 			 * of contiguous pages before continuing with the
@@ -212,21 +212,21 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			continue;
 		}
 
-		page = __page_cache_alloc(gfp_mask);
-		if (!page)
+		folio = filemap_alloc_folio(gfp_mask, 0);
+		if (!folio)
 			break;
 		if (mapping->a_ops->readpages) {
-			page->index = index + i;
-			list_add(&page->lru, &page_pool);
-		} else if (add_to_page_cache_lru(page, mapping, index + i,
+			folio->index = index + i;
+			list_add(&folio->lru, &page_pool);
+		} else if (filemap_add_folio(mapping, folio, index + i,
 					gfp_mask) < 0) {
-			put_page(page);
+			folio_put(folio);
 			read_pages(ractl, &page_pool, true);
 			i = ractl->_index + ractl->_nr_pages - index - 1;
 			continue;
 		}
 		if (i == nr_to_read - lookahead_size)
-			SetPageReadahead(page);
+			folio_set_readahead(folio);
 		ractl->_nr_pages++;
 	}
 
-- 
2.33.0

