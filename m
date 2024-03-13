Return-Path: <linux-fsdevel+bounces-14305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E28D187AF18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A377286577
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACBF198738;
	Wed, 13 Mar 2024 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="TTj6XlQF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F11198721;
	Wed, 13 Mar 2024 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349406; cv=none; b=WTV5h02vhWJCd5V/dS9Ooiisu3eSsEzV/kkrZZSnOkTkJTko0LOCyMFnlhjadxVYd+54UxQGSWYOQ3in5LiYrjYhzp1Y+oIUfaS3wXNM7qjWfugdT2D1hJ1Yju4/qUpkBhaCOyhoQUZ4PmS9WxqvawGaZ5CAEOdW1r+EcKs7zns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349406; c=relaxed/simple;
	bh=oDNHNt2aySA06Gwd4USIX2lFcP+MCPQWTnRxxPtPQ9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCtFkRln1zrrEvxQEfd5iRFlofG6VAk01FrxB8DaE2ukMrOT+4fZNSu2U8TCL/pv91N/FJbtO5Rhq7b7Y4P62ShHCLbeWgDvr2zoxPrgxgI22vwS42HQup3rc2K5A6dSp8gvzlZvSyEbCZAVovQrg4zhAU/Ox/J/YaTOGXTJMXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=TTj6XlQF; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Tvxfc5Ylyz9svD;
	Wed, 13 Mar 2024 18:03:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1710349400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RU7wAkeEZDBqdQxVOpHCiR4r3AW1LNpG/Tc03yCcuTY=;
	b=TTj6XlQFpuWaG2HRYwVUmyL+mGDOj1YyE4BzeSzFG1uBTNOYHvqLSLJTAqTzOXnojbUFav
	VaI6Qsori+supnIjfxd7QOIIRBt1r3AjdYofmkNSsGr1IzJ+kCMctOkAAwm7VlS4HYxEwd
	xhBIKghw4OfU+qFZghRdae1Y3kRqk8ielVKILzxzoDayVYCCt3MRCU1hTX/PN4sZvgQ33s
	ldT65trmEXqfRbC8rb0GhMPrB26/1wbc37xM1ESEazL9aNIsjbMNJiTV0XGU5MF3Oqr4YQ
	tKChz4zQjWYPgbXBOzZwEHxjNui6cK8PvepNc7H9MPPB3lVOeKaxX9IUrPkHog==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: willy@infradead.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: gost.dev@samsung.com,
	chandan.babu@oracle.com,
	hare@suse.de,
	mcgrof@kernel.org,
	djwong@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	david@fromorbit.com,
	akpm@linux-foundation.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v3 05/11] readahead: allocate folios with mapping_min_order in readahead
Date: Wed, 13 Mar 2024 18:02:47 +0100
Message-ID: <20240313170253.2324812-6-kernel@pankajraghav.com>
In-Reply-To: <20240313170253.2324812-1-kernel@pankajraghav.com>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Tvxfc5Ylyz9svD

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
order does not go below the min_order requirement of the page cache.

When adding new folios to the page cache we must also ensure the index
used is aligned to the mapping_min_order as the page cache requires the
index to be aligned to the order of the folio.

readahead_expand() is called from readahead aops to extend the range of
the readahead so this function can assume ractl->_index to be aligned with
min_order.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 mm/readahead.c | 86 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 72 insertions(+), 14 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 37b938f4b54f..650834c033f0 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -206,9 +206,10 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 		unsigned long nr_to_read, unsigned long lookahead_size)
 {
 	struct address_space *mapping = ractl->mapping;
-	unsigned long index = readahead_index(ractl);
+	unsigned long index = readahead_index(ractl), ra_folio_index;
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
-	unsigned long i = 0;
+	unsigned long i = 0, mark;
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
@@ -505,9 +542,19 @@ void page_cache_ra_order(struct readahead_control *ractl,
 			new_order = MAX_PAGECACHE_ORDER;
 		while ((1 << new_order) > ra->size)
 			new_order--;
+		if (new_order < min_order)
+			new_order = min_order;
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
 
@@ -515,7 +562,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
 		if (index & ((1UL << order) - 1))
 			order = __ffs(index);
 		/* Don't allocate pages past EOF */
-		while (index + (1UL << order) - 1 > limit)
+		while (order > min_order && index + (1UL << order) - 1 > limit)
 			order--;
 		err = ra_alloc_folio(ractl, index, mark, order, gfp);
 		if (err)
@@ -778,8 +825,15 @@ void readahead_expand(struct readahead_control *ractl,
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
@@ -789,9 +843,11 @@ void readahead_expand(struct readahead_control *ractl,
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
@@ -801,7 +857,7 @@ void readahead_expand(struct readahead_control *ractl,
 			ractl->_workingset = true;
 			psi_memstall_enter(&ractl->_pflags);
 		}
-		ractl->_nr_pages++;
+		ractl->_nr_pages += min_nrpages;
 		ractl->_index = folio->index;
 	}
 
@@ -816,9 +872,11 @@ void readahead_expand(struct readahead_control *ractl,
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
@@ -828,10 +886,10 @@ void readahead_expand(struct readahead_control *ractl,
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


