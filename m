Return-Path: <linux-fsdevel+bounces-23670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1C5931190
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 11:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FFDDB2275D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 09:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC821187540;
	Mon, 15 Jul 2024 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="MPzv2L2c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07678A2D;
	Mon, 15 Jul 2024 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721036736; cv=none; b=YWdOKhfCwVVrNjRAyn69fw/C+nPZkVkn+QXViMK8a8QrFSHRkolgyIgZjyVP9fSGWwB2IKjUo5m/K9gg07VPCK1VOjlabUFrSr1obX9NYiZzRDJdyV8WdYHfoz6Fxo3WS1QWk02lCS4+u6kHrxHAxMtZUR2ftkNW1vUL5zDssL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721036736; c=relaxed/simple;
	bh=4U+nanJC1WfCLMeEdone8viB9Jx2tvZx/sLPvwIvLxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTWocOFYZsRlnRwDJ4Op3NI9hODqXPrbVHkYnGL9rDUs9hgP+sMt8ofBHD5eKn+7wkYFqDfRz5Ug+8mWpXXFBrNGpX5DFdEpuzRijqRTCNoDjFQkg3A6JN9bC1U0syrFRK4BCtZr8+nAZUqNPTcDvWMCS1l2p++h9eRgkiHWYNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=MPzv2L2c; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WMy440n14z9sTZ;
	Mon, 15 Jul 2024 11:45:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1721036724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+r0q1aMOVXTo8fjQ8nnAWfzQgFhULOwQhra2cgoZxE8=;
	b=MPzv2L2cbA7bhRj+HBdFq7IV5GhVXEzrexjnJkSoPIfhP2GEZGuhXxyhEOe0Ms7y/ocywO
	L8K4TcQWxWuJQUtPJF8f4gQixz+ygHJ+Pc1fsSWAukfyFfxGFEhVd9kt7hQCCTj14EewnK
	4KpZMXbpnaUcPM47K6StBjFZIytFf8y6EtakBuEYUZsm5rJwDniWRAfGYc+A/qdWdm/EBS
	XTmkLr+RHuetG5Hl7nlqoaXIqnBws83vgzpcrTsDX58GkUHqpYl0EEmhN3y+WKxQzLsncY
	iB561MZ2QwASg5TVPrMXiO2VbVZ56Ujygc4zRbBuOgyK4xKw4RKnnld+tJT7Aw==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: david@fromorbit.com,
	willy@infradead.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	brauner@kernel.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com,
	linux-mm@kvack.org,
	john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org,
	hare@suse.de,
	p.raghav@samsung.com,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org,
	kernel@pankajraghav.com,
	ryan.roberts@arm.com,
	hch@lst.de,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v10 03/10] readahead: allocate folios with mapping_min_order in readahead
Date: Mon, 15 Jul 2024 11:44:50 +0200
Message-ID: <20240715094457.452836-4-kernel@pankajraghav.com>
In-Reply-To: <20240715094457.452836-1-kernel@pankajraghav.com>
References: <20240715094457.452836-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4WMy440n14z9sTZ

From: Pankaj Raghav <p.raghav@samsung.com>

page_cache_ra_unbounded() was allocating single pages (0 order folios)
if there was no folio found in an index. Allocate mapping_min_order folios
as we need to guarantee the minimum order if it is set.

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
Co-developed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 mm/readahead.c | 79 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 61 insertions(+), 18 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 3e5239e9e1777..2078c42777a62 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -206,9 +206,10 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 		unsigned long nr_to_read, unsigned long lookahead_size)
 {
 	struct address_space *mapping = ractl->mapping;
-	unsigned long index = readahead_index(ractl);
+	unsigned long ra_folio_index, index = readahead_index(ractl);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
-	unsigned long i;
+	unsigned long mark, i = 0;
+	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
 
 	/*
 	 * Partway through the readahead operation, we will have added
@@ -223,10 +224,24 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	unsigned int nofs = memalloc_nofs_save();
 
 	filemap_invalidate_lock_shared(mapping);
+	index = mapping_align_index(mapping, index);
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
+	nr_to_read += readahead_index(ractl) - index;
+	ractl->_index = index;
+
 	/*
 	 * Preallocate as many pages as we will need.
 	 */
-	for (i = 0; i < nr_to_read; i++) {
+	while (i < nr_to_read) {
 		struct folio *folio = xa_load(&mapping->i_pages, index + i);
 		int ret;
 
@@ -240,12 +255,13 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			 * not worth getting one just for that.
 			 */
 			read_pages(ractl);
-			ractl->_index++;
-			i = ractl->_index + ractl->_nr_pages - index - 1;
+			ractl->_index += min_nrpages;
+			i = ractl->_index + ractl->_nr_pages - index;
 			continue;
 		}
 
-		folio = filemap_alloc_folio(gfp_mask, 0);
+		folio = filemap_alloc_folio(gfp_mask,
+					    mapping_min_folio_order(mapping));
 		if (!folio)
 			break;
 
@@ -255,14 +271,15 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			if (ret == -ENOMEM)
 				break;
 			read_pages(ractl);
-			ractl->_index++;
-			i = ractl->_index + ractl->_nr_pages - index - 1;
+			ractl->_index += min_nrpages;
+			i = ractl->_index + ractl->_nr_pages - index;
 			continue;
 		}
-		if (i == nr_to_read - lookahead_size)
+		if (i == mark)
 			folio_set_readahead(folio);
 		ractl->_workingset |= folio_test_workingset(folio);
-		ractl->_nr_pages++;
+		ractl->_nr_pages += min_nrpages;
+		i += min_nrpages;
 	}
 
 	/*
@@ -438,13 +455,19 @@ void page_cache_ra_order(struct readahead_control *ractl,
 	struct address_space *mapping = ractl->mapping;
 	pgoff_t start = readahead_index(ractl);
 	pgoff_t index = start;
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
@@ -454,10 +477,19 @@ void page_cache_ra_order(struct readahead_control *ractl,
 
 	new_order = min(mapping_max_folio_order(mapping), new_order);
 	new_order = min_t(unsigned int, new_order, ilog2(ra->size));
+	new_order = max(new_order, min_order);
 
 	/* See comment in page_cache_ra_unbounded() */
 	nofs = memalloc_nofs_save();
 	filemap_invalidate_lock_shared(mapping);
+	/*
+	 * If the new_order is greater than min_order and index is
+	 * already aligned to new_order, then this will be noop as index
+	 * aligned to new_order should also be aligned to min_order.
+	 */
+	ractl->_index = mapping_align_index(mapping, index);
+	index = readahead_index(ractl);
+
 	while (index <= limit) {
 		unsigned int order = new_order;
 
@@ -465,7 +497,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
 		if (index & ((1UL << order) - 1))
 			order = __ffs(index);
 		/* Don't allocate pages past EOF */
-		while (index + (1UL << order) - 1 > limit)
+		while (order > min_order && index + (1UL << order) - 1 > limit)
 			order--;
 		err = ra_alloc_folio(ractl, index, mark, order, gfp);
 		if (err)
@@ -703,8 +735,15 @@ void readahead_expand(struct readahead_control *ractl,
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
@@ -714,9 +753,11 @@ void readahead_expand(struct readahead_control *ractl,
 		if (folio && !xa_is_value(folio))
 			return; /* Folio apparently present */
 
-		folio = filemap_alloc_folio(gfp_mask, 0);
+		folio = filemap_alloc_folio(gfp_mask, min_order);
 		if (!folio)
 			return;
+
+		index = mapping_align_index(mapping, index);
 		if (filemap_add_folio(mapping, folio, index, gfp_mask) < 0) {
 			folio_put(folio);
 			return;
@@ -726,7 +767,7 @@ void readahead_expand(struct readahead_control *ractl,
 			ractl->_workingset = true;
 			psi_memstall_enter(&ractl->_pflags);
 		}
-		ractl->_nr_pages++;
+		ractl->_nr_pages += min_nrpages;
 		ractl->_index = folio->index;
 	}
 
@@ -741,9 +782,11 @@ void readahead_expand(struct readahead_control *ractl,
 		if (folio && !xa_is_value(folio))
 			return; /* Folio apparently present */
 
-		folio = filemap_alloc_folio(gfp_mask, 0);
+		folio = filemap_alloc_folio(gfp_mask, min_order);
 		if (!folio)
 			return;
+
+		index = mapping_align_index(mapping, index);
 		if (filemap_add_folio(mapping, folio, index, gfp_mask) < 0) {
 			folio_put(folio);
 			return;
@@ -753,10 +796,10 @@ void readahead_expand(struct readahead_control *ractl,
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
2.44.1


