Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4E453DE05
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jun 2022 21:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347248AbiFETjL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jun 2022 15:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347104AbiFETjF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jun 2022 15:39:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E2A65F8;
        Sun,  5 Jun 2022 12:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=kW7acvpugaZzYgKpNVxP3YXlqqo8ej9HniApAt9C7Wk=; b=GayB5dkNyETT1aj143hZpJ9xJr
        2W3PmmqCmdsuLmQY9SEJ2F5XCz/p7+bPpCYBl4Z5FqoKlX63+mesk72QIxc8GbTFN6Vj7N693OPSz
        EAzmfYVOvCExzpQVT6Eo/3ppcpw0dDWOCBIJT0J9+VT3SAskMmWebD7iZwtwga09wxGXdZq+DsWH5
        zr7rRtR8Ot38QThbkmEFP5sH8mKV2McSI3M5hohoBkIJ5y1yhfwz8O//gZN4YDvKQv5lqJ1I98SFm
        mt+aJZdCZBveBW7dWweDqSqXxJAfQ3m2/dVOOj384TYkN3SRcXmxaAndo0qADxxP6/AoDc9ozluPC
        6SRvx5Ow==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nxw5R-009wsh-Ac; Sun, 05 Jun 2022 19:38:57 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-nilfs@vger.kernel.org
Subject: [PATCH 10/10] filemap: Remove find_get_pages_range() and associated functions
Date:   Sun,  5 Jun 2022 20:38:54 +0100
Message-Id: <20220605193854.2371230-11-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220605193854.2371230-1-willy@infradead.org>
References: <20220605193854.2371230-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All callers of find_get_pages_range(), pagevec_lookup_range() and
pagevec_lookup() have now been removed.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |  3 --
 include/linux/pagevec.h | 10 ------
 mm/filemap.c            | 67 -----------------------------------------
 mm/swap.c               | 29 ------------------
 4 files changed, 109 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 50e57b2d845f..1caccb9f99aa 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -720,9 +720,6 @@ static inline struct page *find_subpage(struct page *head, pgoff_t index)
 
 unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch);
-unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
-			pgoff_t end, unsigned int nr_pages,
-			struct page **pages);
 unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t start,
 			       unsigned int nr_pages, struct page **pages);
 unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 67b1246f136b..6649154a2115 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -27,16 +27,6 @@ struct pagevec {
 
 void __pagevec_release(struct pagevec *pvec);
 void __pagevec_lru_add(struct pagevec *pvec);
-unsigned pagevec_lookup_range(struct pagevec *pvec,
-			      struct address_space *mapping,
-			      pgoff_t *start, pgoff_t end);
-static inline unsigned pagevec_lookup(struct pagevec *pvec,
-				      struct address_space *mapping,
-				      pgoff_t *start)
-{
-	return pagevec_lookup_range(pvec, mapping, start, (pgoff_t)-1);
-}
-
 unsigned pagevec_lookup_range_tag(struct pagevec *pvec,
 		struct address_space *mapping, pgoff_t *index, pgoff_t end,
 		xa_mark_t tag);
diff --git a/mm/filemap.c b/mm/filemap.c
index ea4145b7a84c..340ccb37f6b6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2192,73 +2192,6 @@ bool folio_more_pages(struct folio *folio, pgoff_t index, pgoff_t max)
 	return index < folio->index + folio_nr_pages(folio) - 1;
 }
 
-/**
- * find_get_pages_range - gang pagecache lookup
- * @mapping:	The address_space to search
- * @start:	The starting page index
- * @end:	The final page index (inclusive)
- * @nr_pages:	The maximum number of pages
- * @pages:	Where the resulting pages are placed
- *
- * find_get_pages_range() will search for and return a group of up to @nr_pages
- * pages in the mapping starting at index @start and up to index @end
- * (inclusive).  The pages are placed at @pages.  find_get_pages_range() takes
- * a reference against the returned pages.
- *
- * The search returns a group of mapping-contiguous pages with ascending
- * indexes.  There may be holes in the indices due to not-present pages.
- * We also update @start to index the next page for the traversal.
- *
- * Return: the number of pages which were found. If this number is
- * smaller than @nr_pages, the end of specified range has been
- * reached.
- */
-unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
-			      pgoff_t end, unsigned int nr_pages,
-			      struct page **pages)
-{
-	XA_STATE(xas, &mapping->i_pages, *start);
-	struct folio *folio;
-	unsigned ret = 0;
-
-	if (unlikely(!nr_pages))
-		return 0;
-
-	rcu_read_lock();
-	while ((folio = find_get_entry(&xas, end, XA_PRESENT))) {
-		/* Skip over shadow, swap and DAX entries */
-		if (xa_is_value(folio))
-			continue;
-
-again:
-		pages[ret] = folio_file_page(folio, xas.xa_index);
-		if (++ret == nr_pages) {
-			*start = xas.xa_index + 1;
-			goto out;
-		}
-		if (folio_more_pages(folio, xas.xa_index, end)) {
-			xas.xa_index++;
-			folio_ref_inc(folio);
-			goto again;
-		}
-	}
-
-	/*
-	 * We come here when there is no page beyond @end. We take care to not
-	 * overflow the index @start as it confuses some of the callers. This
-	 * breaks the iteration when there is a page at index -1 but that is
-	 * already broken anyway.
-	 */
-	if (end == (pgoff_t)-1)
-		*start = (pgoff_t)-1;
-	else
-		*start = end + 1;
-out:
-	rcu_read_unlock();
-
-	return ret;
-}
-
 /**
  * find_get_pages_contig - gang contiguous pagecache lookup
  * @mapping:	The address_space to search
diff --git a/mm/swap.c b/mm/swap.c
index f3922a96b2e9..f65e284247b2 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1086,35 +1086,6 @@ void folio_batch_remove_exceptionals(struct folio_batch *fbatch)
 	fbatch->nr = j;
 }
 
-/**
- * pagevec_lookup_range - gang pagecache lookup
- * @pvec:	Where the resulting pages are placed
- * @mapping:	The address_space to search
- * @start:	The starting page index
- * @end:	The final page index
- *
- * pagevec_lookup_range() will search for & return a group of up to PAGEVEC_SIZE
- * pages in the mapping starting from index @start and upto index @end
- * (inclusive).  The pages are placed in @pvec.  pagevec_lookup() takes a
- * reference against the pages in @pvec.
- *
- * The search returns a group of mapping-contiguous pages with ascending
- * indexes.  There may be holes in the indices due to not-present pages. We
- * also update @start to index the next page for the traversal.
- *
- * pagevec_lookup_range() returns the number of pages which were found. If this
- * number is smaller than PAGEVEC_SIZE, the end of specified range has been
- * reached.
- */
-unsigned pagevec_lookup_range(struct pagevec *pvec,
-		struct address_space *mapping, pgoff_t *start, pgoff_t end)
-{
-	pvec->nr = find_get_pages_range(mapping, start, end, PAGEVEC_SIZE,
-					pvec->pages);
-	return pagevec_count(pvec);
-}
-EXPORT_SYMBOL(pagevec_lookup_range);
-
 unsigned pagevec_lookup_range_tag(struct pagevec *pvec,
 		struct address_space *mapping, pgoff_t *index, pgoff_t end,
 		xa_mark_t tag)
-- 
2.35.1

