Return-Path: <linux-fsdevel+bounces-20440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B7F8D383E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 15:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109E81F24E02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 13:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCA524B5B;
	Wed, 29 May 2024 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="T0Lrlfmv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B8D3FBA5;
	Wed, 29 May 2024 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716990348; cv=none; b=mQ7kGty/CY4NZae780hdtaY6RTsBKg8wjWahlYEF3J8LRzwsc/lKEuqs8qhZiH3PUlGCEAEyURMDV8X0DCNVbz2kzSlj0fAniogp60K+ZAvCYoq82iWzJz4ev6Rx17MAVQewGbkGwlpcGtX5ZfPqRA1pbkR6GYZpvznnWTGro/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716990348; c=relaxed/simple;
	bh=cStaz4K0Q3P6YgfmwYpPr5zXAvaUylDPFNFAU07MLks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Am/3IHqA27mfNFX5sCSdQ+lQTjnSuyj72YaZD5FVE1+Q4BO8hzegR6j7gDouOFEBQYi1V3sAqq6pnQvXSGsQhVa8qcTzARxUyk015EN7anqLDGtfQ1YwbuMjvpbus1wFbQPip5W8QpubDY5fSM0DMgcYQRp8DMCIqScp4qkUXbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=T0Lrlfmv; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Vq9cv680Kz9spR;
	Wed, 29 May 2024 15:45:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1716990335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pUdfC/WKWCQctCsU2EgKroiARXKN//2pAERfC44xAGs=;
	b=T0LrlfmvkXeRbIR3+6/v8cSGJSLZyoRswYQNTCKEHVMiH7oMeWPQcJKoD1ZFu28aOgz76c
	/IJskjrRKDmRjdBnrKmDPnohP25Yb+Nk4ZcD7EmD3YKfSUwtQXHSmead6J+1Yq7OcPmCR3
	mh2rB45o21CM8eVOz023SuA09Dsd1z6Q1YafkaB7hRhzCUHaUxQ/8r99BH2+1jtU2tr/g9
	6+Z6Trj6r5EsKCNs8F+YKT44Z3++o27zlUp9OXvH56eS6eXx01tCaMsx+qhFE2mkZQvaaf
	hZskk6uFN9pIu+ysb51utULD6AY3exPLes+tMw+jURSijS3Awtx1HKv7kZmAjA==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: david@fromorbit.com,
	chandan.babu@oracle.com,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	willy@infradead.org,
	djwong@kernel.org
Cc: linux-kernel@vger.kernel.org,
	hare@suse.de,
	john.g.garry@oracle.com,
	gost.dev@samsung.com,
	yang@os.amperecomputing.com,
	p.raghav@samsung.com,
	cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org,
	hch@lst.de,
	mcgrof@kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 04/11] readahead: allocate folios with mapping_min_order in readahead
Date: Wed, 29 May 2024 15:45:02 +0200
Message-Id: <20240529134509.120826-5-kernel@pankajraghav.com>
In-Reply-To: <20240529134509.120826-1-kernel@pankajraghav.com>
References: <20240529134509.120826-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Vq9cv680Kz9spR

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
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 mm/readahead.c | 85 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 71 insertions(+), 14 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index da34b28da02c..389cd802da63 100644
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
@@ -230,7 +247,9 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 		struct folio *folio = xa_load(&mapping->i_pages, index + i);
 		int ret;
 
+
 		if (folio && !xa_is_value(folio)) {
+			long nr_pages = folio_nr_pages(folio);
 			/*
 			 * Page already present?  Kick off the current batch
 			 * of contiguous pages before continuing with the
@@ -240,12 +259,24 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
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
 
@@ -255,11 +286,11 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			if (ret == -ENOMEM)
 				break;
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
@@ -493,13 +524,19 @@ void page_cache_ra_order(struct readahead_control *ractl,
 {
 	struct address_space *mapping = ractl->mapping;
 	pgoff_t index = readahead_index(ractl);
+	unsigned int min_order = mapping_min_folio_order(mapping);
 	pgoff_t limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
 	pgoff_t mark = index + ra->size - ra->async_size;
 	unsigned int nofs;
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
@@ -508,11 +545,20 @@ void page_cache_ra_order(struct readahead_control *ractl,
 		new_order += 2;
 		new_order = min(mapping_max_folio_order(mapping), new_order);
 		new_order = min_t(unsigned int, new_order, ilog2(ra->size));
+		new_order = max(new_order, min_order);
 	}
 
 	/* See comment in page_cache_ra_unbounded() */
 	nofs = memalloc_nofs_save();
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
 
@@ -520,7 +566,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
 		if (index & ((1UL << order) - 1))
 			order = __ffs(index);
 		/* Don't allocate pages past EOF */
-		while (index + (1UL << order) - 1 > limit)
+		while (order > min_order && index + (1UL << order) - 1 > limit)
 			order--;
 		err = ra_alloc_folio(ractl, index, mark, order, gfp);
 		if (err)
@@ -784,8 +830,15 @@ void readahead_expand(struct readahead_control *ractl,
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
@@ -795,9 +848,11 @@ void readahead_expand(struct readahead_control *ractl,
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
@@ -807,7 +862,7 @@ void readahead_expand(struct readahead_control *ractl,
 			ractl->_workingset = true;
 			psi_memstall_enter(&ractl->_pflags);
 		}
-		ractl->_nr_pages++;
+		ractl->_nr_pages += min_nrpages;
 		ractl->_index = folio->index;
 	}
 
@@ -822,9 +877,11 @@ void readahead_expand(struct readahead_control *ractl,
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
@@ -834,10 +891,10 @@ void readahead_expand(struct readahead_control *ractl,
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
2.34.1


