Return-Path: <linux-fsdevel+bounces-18595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FF98BAA50
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 11:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E52A9B222F3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 09:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C9A152518;
	Fri,  3 May 2024 09:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xv9gfv03"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33AC14F9D8;
	Fri,  3 May 2024 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730044; cv=none; b=H7JRuZkKHKHhWdpTLBTwADSx8GR0kAKjlN9L6lfNS8jj+kCqx1sloN4zSyjbdyn0xXJYxf8jCR0pBaIR+IpAaEZUiwwXV3fb/qnVbsBut7T2+bY9SqdFHLSNjM2Amrs23bfmB0vJkywdKRp/ZK3CM1H1MYGGFSYpe00w0bGYMrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730044; c=relaxed/simple;
	bh=hbeQFU7yPP2c+0Ma7iKTBZ1hAAXO+GOY/UFm5uVTRd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gf5rl4+E1MPCXoLP+GSV5OuJkL9XTHb2ZS8ZbfhoZl0JtPt0k5Mu9YSMsNGGue6uDMfzN3EX/ZDqcSMC/xTGzLA1rSgPXIbw0VRcXBqmIua/HULYm3Vvf+E2IXtY77uywzHZPvu2+f+STPWp8J5uHTuKYmOkJHfcDmLWI+grum0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xv9gfv03; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hzpQR52f1pIER/Yxm7Bb5ZUs5rgGX4bePjdfUN3SCwc=; b=Xv9gfv034bxuebpMEtwXuYpXnY
	BW69tkw7DZg8Eppm8Ws/SIElOHOUfo5uMr24RqSAS+M5KHXqRAPI3YRJ17dxJJs8jE/V9qg0rIJW/
	Hbyxsd0AWEc5PVfRXunIaYSktJRB7AwTvHV6Ej27tjKWZ7ca1MGnLOWQH7qxwHMGmswKqtwc8mnV9
	jO1XJXrqJOG8Dh/2OpkTTmUxZy+Kn2yuxmQ+CbRFt/gMZ06zFVQSOPksqyGuJIkjrzrpha1FI9gkj
	/tK9l04/r/m0aXHqC+Un5kf6TFsb8Bwiwhna3mvZOAopoiLJejsQEjZ0/M8dL6JaPAIJ6a4V6W3gw
	6FzzX9WA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2pc3-0000000Fw3e-0d0o;
	Fri, 03 May 2024 09:53:55 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: akpm@linux-foundation.org,
	willy@infradead.org,
	djwong@kernel.org,
	brauner@kernel.org,
	david@fromorbit.com,
	chandan.babu@oracle.com
Cc: hare@suse.de,
	ritesh.list@gmail.com,
	john.g.garry@oracle.com,
	ziy@nvidia.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [PATCH v5 04/11] readahead: allocate folios with mapping_min_order in readahead
Date: Fri,  3 May 2024 02:53:46 -0700
Message-ID: <20240503095353.3798063-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240503095353.3798063-1-mcgrof@kernel.org>
References: <20240503095353.3798063-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

From: Pankaj Raghav <p.raghav@samsung.com>

page_cache_ra_unbounded() was allocating single pages (0 order folios)
if there was no folio found in an index. Allocate mapping_min_order folios
as we need to guarantee the minimum order if it is set.
When read_pages() is triggered and if a page is already present, check
for truncation and move the ractl->_index by mapping_min_nrpages if that
folio was truncated. This is done to ensure we keep the alignment
requirement while adding a folio to the page cache.

page_cache_ra_order() tries to allocate folio to the page cache with a
higher order if the index aligns with that order. Modify it so that the
order does not go below the mapping_min_order requirement of the page
cache. This function will do the right thing even if the new_order passed
is less than the mapping_min_order.
When adding new folios to the page cache we must also ensure the index
used is aligned to the mapping_min_order as the page cache requires the
index to be aligned to the order of the folio.

readahead_expand() is called from readahead aops to extend the range of
the readahead so this function can assume ractl->_index to be aligned with
min_order.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 mm/readahead.c | 85 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 71 insertions(+), 14 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 2361634a84fd..646a90ada59a 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -206,9 +206,10 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 		unsigned long nr_to_read, unsigned long lookahead_size)
 {
 	struct address_space *mapping = ractl->mapping;
-	unsigned long index = readahead_index(ractl);
+	unsigned long ra_folio_index, index = readahead_index(ractl);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
-	unsigned long i = 0;
+	unsigned long mark, i = 0;
+	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
 
 	/*
 	 * Partway through the readahead operation, we will have added
@@ -223,6 +224,22 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	unsigned int nofs = memalloc_nofs_save();
 
 	filemap_invalidate_lock_shared(mapping);
+	index = mapping_align_start_index(mapping, index);
+
+	/*
+	 * As iterator `i` is aligned to min_nrpages, round_up the
+	 * difference between nr_to_read and lookahead_size to mark the
+	 * index that only has lookahead or "async_region" to set the
+	 * readahead flag.
+	 */
+	ra_folio_index = round_up(readahead_index(ractl) + nr_to_read - lookahead_size,
+				  min_nrpages);
+	mark = ra_folio_index - index;
+	if (index != readahead_index(ractl)) {
+		nr_to_read += readahead_index(ractl) - index;
+		ractl->_index = index;
+	}
+
 	/*
 	 * Preallocate as many pages as we will need.
 	 */
@@ -230,6 +247,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 		struct folio *folio = xa_load(&mapping->i_pages, index + i);
 
 		if (folio && !xa_is_value(folio)) {
+			long nr_pages = folio_nr_pages(folio);
+
 			/*
 			 * Page already present?  Kick off the current batch
 			 * of contiguous pages before continuing with the
@@ -239,23 +258,35 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			 * not worth getting one just for that.
 			 */
 			read_pages(ractl);
-			ractl->_index += folio_nr_pages(folio);
+
+			/*
+			 * Move the ractl->_index by at least min_pages
+			 * if the folio got truncated to respect the
+			 * alignment constraint in the page cache.
+			 *
+			 */
+			if (mapping != folio->mapping)
+				nr_pages = min_nrpages;
+
+			VM_BUG_ON_FOLIO(nr_pages < min_nrpages, folio);
+			ractl->_index += nr_pages;
 			i = ractl->_index + ractl->_nr_pages - index;
 			continue;
 		}
 
-		folio = filemap_alloc_folio(gfp_mask, 0);
+		folio = filemap_alloc_folio(gfp_mask,
+					    mapping_min_folio_order(mapping));
 		if (!folio)
 			break;
 		if (filemap_add_folio(mapping, folio, index + i,
 					gfp_mask) < 0) {
 			folio_put(folio);
 			read_pages(ractl);
-			ractl->_index++;
+			ractl->_index += min_nrpages;
 			i = ractl->_index + ractl->_nr_pages - index;
 			continue;
 		}
-		if (i == nr_to_read - lookahead_size)
+		if (i == mark)
 			folio_set_readahead(folio);
 		ractl->_workingset |= folio_test_workingset(folio);
 		ractl->_nr_pages += folio_nr_pages(folio);
@@ -489,12 +520,18 @@ void page_cache_ra_order(struct readahead_control *ractl,
 {
 	struct address_space *mapping = ractl->mapping;
 	pgoff_t index = readahead_index(ractl);
+	unsigned int min_order = mapping_min_folio_order(mapping);
 	pgoff_t limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
 	pgoff_t mark = index + ra->size - ra->async_size;
 	int err = 0;
 	gfp_t gfp = readahead_gfp_mask(mapping);
+	unsigned int min_ra_size = max(4, mapping_min_folio_nrpages(mapping));
 
-	if (!mapping_large_folio_support(mapping) || ra->size < 4)
+	/*
+	 * Fallback when size < min_nrpages as each folio should be
+	 * at least min_nrpages anyway.
+	 */
+	if (!mapping_large_folio_support(mapping) || ra->size < min_ra_size)
 		goto fallback;
 
 	limit = min(limit, index + ra->size - 1);
@@ -503,9 +540,18 @@ void page_cache_ra_order(struct readahead_control *ractl,
 		new_order += 2;
 		new_order = min_t(unsigned int, MAX_PAGECACHE_ORDER, new_order);
 		new_order = min_t(unsigned int, new_order, ilog2(ra->size));
+		new_order = max(new_order, min_order);
 	}
 
 	filemap_invalidate_lock_shared(mapping);
+	/*
+	 * If the new_order is greater than min_order and index is
+	 * already aligned to new_order, then this will be noop as index
+	 * aligned to new_order should also be aligned to min_order.
+	 */
+	ractl->_index = mapping_align_start_index(mapping, index);
+	index = readahead_index(ractl);
+
 	while (index <= limit) {
 		unsigned int order = new_order;
 
@@ -513,7 +559,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
 		if (index & ((1UL << order) - 1))
 			order = __ffs(index);
 		/* Don't allocate pages past EOF */
-		while (index + (1UL << order) - 1 > limit)
+		while (order > min_order && index + (1UL << order) - 1 > limit)
 			order--;
 		err = ra_alloc_folio(ractl, index, mark, order, gfp);
 		if (err)
@@ -776,8 +822,15 @@ void readahead_expand(struct readahead_control *ractl,
 	struct file_ra_state *ra = ractl->ra;
 	pgoff_t new_index, new_nr_pages;
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
+	unsigned long min_nrpages = mapping_min_folio_nrpages(mapping);
+	unsigned int min_order = mapping_min_folio_order(mapping);
 
 	new_index = new_start / PAGE_SIZE;
+	/*
+	 * Readahead code should have aligned the ractl->_index to
+	 * min_nrpages before calling readahead aops.
+	 */
+	VM_BUG_ON(!IS_ALIGNED(ractl->_index, min_nrpages));
 
 	/* Expand the leading edge downwards */
 	while (ractl->_index > new_index) {
@@ -787,9 +840,11 @@ void readahead_expand(struct readahead_control *ractl,
 		if (folio && !xa_is_value(folio))
 			return; /* Folio apparently present */
 
-		folio = filemap_alloc_folio(gfp_mask, 0);
+		folio = filemap_alloc_folio(gfp_mask, min_order);
 		if (!folio)
 			return;
+
+		index = mapping_align_start_index(mapping, index);
 		if (filemap_add_folio(mapping, folio, index, gfp_mask) < 0) {
 			folio_put(folio);
 			return;
@@ -799,7 +854,7 @@ void readahead_expand(struct readahead_control *ractl,
 			ractl->_workingset = true;
 			psi_memstall_enter(&ractl->_pflags);
 		}
-		ractl->_nr_pages++;
+		ractl->_nr_pages += min_nrpages;
 		ractl->_index = folio->index;
 	}
 
@@ -814,9 +869,11 @@ void readahead_expand(struct readahead_control *ractl,
 		if (folio && !xa_is_value(folio))
 			return; /* Folio apparently present */
 
-		folio = filemap_alloc_folio(gfp_mask, 0);
+		folio = filemap_alloc_folio(gfp_mask, min_order);
 		if (!folio)
 			return;
+
+		index = mapping_align_start_index(mapping, index);
 		if (filemap_add_folio(mapping, folio, index, gfp_mask) < 0) {
 			folio_put(folio);
 			return;
@@ -826,10 +883,10 @@ void readahead_expand(struct readahead_control *ractl,
 			ractl->_workingset = true;
 			psi_memstall_enter(&ractl->_pflags);
 		}
-		ractl->_nr_pages++;
+		ractl->_nr_pages += min_nrpages;
 		if (ra) {
-			ra->size++;
-			ra->async_size++;
+			ra->size += min_nrpages;
+			ra->async_size += min_nrpages;
 		}
 	}
 }
-- 
2.43.0


