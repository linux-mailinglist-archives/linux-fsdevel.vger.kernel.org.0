Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C113C4298
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 06:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhGLEIY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 00:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhGLEIY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:08:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9189C0613DD;
        Sun, 11 Jul 2021 21:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=YK2hjj3KBm6xVMc8AhUV42rHwS+WWB0mcwrbnrPn2ao=; b=FQ/hfOI/9QxROSyewmYIbz8Xlm
        4aYWHFVTY7h/OKslce7ajGBAhHWauz5nF9OqNrGY9n2FbRLzxYlVReZIlRq/U4Zb2opSfN4m1Tecx
        6oedU1IXKoroVofJ/fOHz938m9fMmHCOEKT/qJsLNIpIZBXfSwJCJArTfgbP1clPO8neon1uWdmRR
        YeF6qO78uBcSl9donGc+Ad+2u+sMHZ0iUODu+lM9jmCusNSOTfkqo+CR/G/W1fnCMKUUluI/2BhAD
        HHchq1xCgBYy9qtMk2825Ix3UCERZmgy3x+HS2/EUFXt+LXC2qC/Y4eLEZkaH6qcBd7sa7Liv0S0S
        p7TKP9BQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2nBW-00GqrE-83; Mon, 12 Jul 2021 04:04:53 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 110/137] mm/filemap: Convert find_get_entry to return a folio
Date:   Mon, 12 Jul 2021 04:06:34 +0100
Message-Id: <20210712030701.4000097-111-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert callers to cope.  Saves 580 bytes of kernel text; all five
callers are reduced in size.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 129 +++++++++++++++++++++++++--------------------------
 1 file changed, 64 insertions(+), 65 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index a24e26563e9f..4920f52268a3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1907,37 +1907,36 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 }
 EXPORT_SYMBOL(__filemap_get_folio);
 
-static inline struct page *find_get_entry(struct xa_state *xas, pgoff_t max,
+static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
 		xa_mark_t mark)
 {
-	struct page *page;
+	struct folio *folio;
 
 retry:
 	if (mark == XA_PRESENT)
-		page = xas_find(xas, max);
+		folio = xas_find(xas, max);
 	else
-		page = xas_find_marked(xas, max, mark);
+		folio = xas_find_marked(xas, max, mark);
 
-	if (xas_retry(xas, page))
+	if (xas_retry(xas, folio))
 		goto retry;
 	/*
 	 * A shadow entry of a recently evicted page, a swap
 	 * entry from shmem/tmpfs or a DAX entry.  Return it
 	 * without attempting to raise page count.
 	 */
-	if (!page || xa_is_value(page))
-		return page;
+	if (!folio || xa_is_value(folio))
+		return folio;
 
-	if (!page_cache_get_speculative(page))
+	if (!folio_try_get_rcu(folio))
 		goto reset;
 
-	/* Has the page moved or been split? */
-	if (unlikely(page != xas_reload(xas))) {
-		put_page(page);
+	if (unlikely(folio != xas_reload(xas))) {
+		folio_put(folio);
 		goto reset;
 	}
 
-	return page;
+	return folio;
 reset:
 	xas_reset(xas);
 	goto retry;
@@ -1978,7 +1977,7 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
 	unsigned nr_entries = PAGEVEC_SIZE;
 
 	rcu_read_lock();
-	while ((page = find_get_entry(&xas, end, XA_PRESENT))) {
+	while ((page = &find_get_entry(&xas, end, XA_PRESENT)->page)) {
 		/*
 		 * Terminate early on finding a THP, to allow the caller to
 		 * handle it all at once; but continue if this is hugetlbfs.
@@ -2025,38 +2024,38 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
 		pgoff_t end, struct pagevec *pvec, pgoff_t *indices)
 {
 	XA_STATE(xas, &mapping->i_pages, start);
-	struct page *page;
+	struct folio *folio;
 
 	rcu_read_lock();
-	while ((page = find_get_entry(&xas, end, XA_PRESENT))) {
-		if (!xa_is_value(page)) {
-			if (page->index < start)
+	while ((folio = find_get_entry(&xas, end, XA_PRESENT))) {
+		if (!xa_is_value(folio)) {
+			if (folio->index < start)
 				goto put;
-			VM_BUG_ON_PAGE(page->index != xas.xa_index, page);
-			if (page->index + thp_nr_pages(page) - 1 > end)
+			VM_BUG_ON_FOLIO(folio->index != xas.xa_index,
+					folio);
+			if (folio->index + folio_nr_pages(folio) - 1 > end)
 				goto put;
-			if (!trylock_page(page))
+			if (!folio_trylock(folio))
 				goto put;
-			if (page->mapping != mapping || PageWriteback(page))
+			if (folio->mapping != mapping ||
+			    folio_writeback(folio))
 				goto unlock;
-			VM_BUG_ON_PAGE(!thp_contains(page, xas.xa_index),
-					page);
+			VM_BUG_ON_FOLIO(!folio_contains(folio, xas.xa_index),
+					folio);
 		}
 		indices[pvec->nr] = xas.xa_index;
-		if (!pagevec_add(pvec, page))
+		if (!pagevec_add(pvec, &folio->page))
 			break;
 		goto next;
 unlock:
-		unlock_page(page);
+		folio_unlock(folio);
 put:
-		put_page(page);
+		folio_put(folio);
 next:
-		if (!xa_is_value(page) && PageTransHuge(page)) {
-			unsigned int nr_pages = thp_nr_pages(page);
-
-			/* Final THP may cross MAX_LFS_FILESIZE on 32-bit */
-			xas_set(&xas, page->index + nr_pages);
-			if (xas.xa_index < nr_pages)
+		if (!xa_is_value(folio) && folio_multi(folio)) {
+			xas_set(&xas, folio->index + folio_nr_pages(folio));
+			/* Did we wrap on 32-bit? */
+			if (!xas.xa_index)
 				break;
 		}
 	}
@@ -2091,19 +2090,19 @@ unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
 			      struct page **pages)
 {
 	XA_STATE(xas, &mapping->i_pages, *start);
-	struct page *page;
+	struct folio *folio;
 	unsigned ret = 0;
 
 	if (unlikely(!nr_pages))
 		return 0;
 
 	rcu_read_lock();
-	while ((page = find_get_entry(&xas, end, XA_PRESENT))) {
+	while ((folio = find_get_entry(&xas, end, XA_PRESENT))) {
 		/* Skip over shadow, swap and DAX entries */
-		if (xa_is_value(page))
+		if (xa_is_value(folio))
 			continue;
 
-		pages[ret] = find_subpage(page, xas.xa_index);
+		pages[ret] = folio_file_page(folio, xas.xa_index);
 		if (++ret == nr_pages) {
 			*start = xas.xa_index + 1;
 			goto out;
@@ -2200,25 +2199,25 @@ unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
 			struct page **pages)
 {
 	XA_STATE(xas, &mapping->i_pages, *index);
-	struct page *page;
+	struct folio *folio;
 	unsigned ret = 0;
 
 	if (unlikely(!nr_pages))
 		return 0;
 
 	rcu_read_lock();
-	while ((page = find_get_entry(&xas, end, tag))) {
+	while ((folio = find_get_entry(&xas, end, tag))) {
 		/*
 		 * Shadow entries should never be tagged, but this iteration
 		 * is lockless so there is a window for page reclaim to evict
 		 * a page we saw tagged.  Skip over it.
 		 */
-		if (xa_is_value(page))
+		if (xa_is_value(folio))
 			continue;
 
-		pages[ret] = page;
+		pages[ret] = &folio->page;
 		if (++ret == nr_pages) {
-			*index = page->index + thp_nr_pages(page);
+			*index = folio->index + folio_nr_pages(folio);
 			goto out;
 		}
 	}
@@ -2697,44 +2696,44 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 }
 EXPORT_SYMBOL(generic_file_read_iter);
 
-static inline loff_t page_seek_hole_data(struct xa_state *xas,
-		struct address_space *mapping, struct page *page,
+static inline loff_t folio_seek_hole_data(struct xa_state *xas,
+		struct address_space *mapping, struct folio *folio,
 		loff_t start, loff_t end, bool seek_data)
 {
 	const struct address_space_operations *ops = mapping->a_ops;
 	size_t offset, bsz = i_blocksize(mapping->host);
 
-	if (xa_is_value(page) || PageUptodate(page))
+	if (xa_is_value(folio) || folio_uptodate(folio))
 		return seek_data ? start : end;
 	if (!ops->is_partially_uptodate)
 		return seek_data ? end : start;
 
 	xas_pause(xas);
 	rcu_read_unlock();
-	lock_page(page);
-	if (unlikely(page->mapping != mapping))
+	folio_lock(folio);
+	if (unlikely(folio->mapping != mapping))
 		goto unlock;
 
-	offset = offset_in_thp(page, start) & ~(bsz - 1);
+	offset = offset_in_folio(folio, start) & ~(bsz - 1);
 
 	do {
-		if (ops->is_partially_uptodate(page, offset, bsz) == seek_data)
+		if (ops->is_partially_uptodate(&folio->page, offset, bsz) ==
+							seek_data)
 			break;
 		start = (start + bsz) & ~(bsz - 1);
 		offset += bsz;
-	} while (offset < thp_size(page));
+	} while (offset < folio_size(folio));
 unlock:
-	unlock_page(page);
+	folio_unlock(folio);
 	rcu_read_lock();
 	return start;
 }
 
-static inline
-unsigned int seek_page_size(struct xa_state *xas, struct page *page)
+static inline size_t seek_folio_size(struct xa_state *xas, struct folio *folio)
 {
-	if (xa_is_value(page))
+	if (xa_is_value(folio))
 		return PAGE_SIZE << xa_get_order(xas->xa, xas->xa_index);
-	return thp_size(page);
+	return folio_size(folio);
 }
 
 /**
@@ -2761,15 +2760,15 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
 	XA_STATE(xas, &mapping->i_pages, start >> PAGE_SHIFT);
 	pgoff_t max = (end - 1) >> PAGE_SHIFT;
 	bool seek_data = (whence == SEEK_DATA);
-	struct page *page;
+	struct folio *folio;
 
 	if (end <= start)
 		return -ENXIO;
 
 	rcu_read_lock();
-	while ((page = find_get_entry(&xas, max, XA_PRESENT))) {
-		loff_t pos = (u64)xas.xa_index << PAGE_SHIFT;
-		unsigned int seek_size;
+	while ((folio = find_get_entry(&xas, max, XA_PRESENT))) {
+		loff_t pos = xas.xa_index * PAGE_SIZE;
+		size_t seek_size;
 
 		if (start < pos) {
 			if (!seek_data)
@@ -2777,9 +2776,9 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
 			start = pos;
 		}
 
-		seek_size = seek_page_size(&xas, page);
-		pos = round_up(pos + 1, seek_size);
-		start = page_seek_hole_data(&xas, mapping, page, start, pos,
+		seek_size = seek_folio_size(&xas, folio);
+		pos = round_up((u64)pos + 1, seek_size);
+		start = folio_seek_hole_data(&xas, mapping, folio, start, pos,
 				seek_data);
 		if (start < pos)
 			goto unlock;
@@ -2787,15 +2786,15 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
 			break;
 		if (seek_size > PAGE_SIZE)
 			xas_set(&xas, pos >> PAGE_SHIFT);
-		if (!xa_is_value(page))
-			put_page(page);
+		if (!xa_is_value(folio))
+			folio_put(folio);
 	}
 	if (seek_data)
 		start = -ENXIO;
 unlock:
 	rcu_read_unlock();
-	if (page && !xa_is_value(page))
-		put_page(page);
+	if (folio && !xa_is_value(folio))
+		folio_put(folio);
 	if (start > end)
 		return end;
 	return start;
-- 
2.30.2

