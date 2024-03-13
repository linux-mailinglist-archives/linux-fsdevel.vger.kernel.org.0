Return-Path: <linux-fsdevel+bounces-14302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E4D87AF0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0B11C237A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40B815043F;
	Wed, 13 Mar 2024 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="ePofVGEs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2211948E8;
	Wed, 13 Mar 2024 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349394; cv=none; b=JhWsHHMYAexyubg7GxEVOHzufseHo5fxlllAWta3VgFUOfCO35J8f43dHHemXWV49NsSlrV6lSxR7wXsaJrnBcPBhvdgl7GRKrRF+rLZozZ0rJRfYm8zTivZK+fdqlI23HlyKRsjKSWkvE1oQlqQzZrcOS5EXV2y73/x0QtT3qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349394; c=relaxed/simple;
	bh=ZMppSe3CLJUbYtty6hKMUnmRewuVLsS/1omALJEd3z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q48zLmQOqJniXjAIMsuUzgeNdqnRVB7TBFbZr4b8EK42Pnhe9iu4i4jAcln32IwMo1+L65TFpseHFYj90wCcWCpUlb7mli0A4p6Y45SJdye0+h8RLIUDl9oZIlpJhbxKhY+D4EKfumHIqhIquXeMVUasgq33n8trrsg2TVEtcUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=ePofVGEs; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TvxfF6kKKz9scJ;
	Wed, 13 Mar 2024 18:03:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1710349381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0O7jkYtxzM0DX7ZIGW+ZLQ370PUm3ZF/59ff/K84oK4=;
	b=ePofVGEsoAuYyqzVJOkLIjTDjgCqkUNNOdF5wzwok0juW1t96f6PLR+0tjm1jOKGs4hvX2
	3677Dz+o7Boi66JMyxVV3+rcqBM/OQu7ZXWHFTDqbmsoC/7VAPHy8TXOPLcs2xNnWRdkls
	5zLtrlq5B3Db6hJMkwoK7tF/b70+gbA+5G2XTJN6N/txcjTwGP+K/vtKUQExim+4ia4n7n
	ufxGGEgxOz5AjhMheKmu+XTB6CPt+uDyD+W2r3Efm4IK01gSenpsNoFRF73WLWeosdEIZA
	+kfkH2IJb5NGiYEd/YRBYCG5IsKjX7RavQEu4I7XeTAXcIo7nWlaRlfBUhvZ4A==
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
	akpm@linux-foundation.org
Subject: [PATCH v3 01/11] mm: Support order-1 folios in the page cache
Date: Wed, 13 Mar 2024 18:02:43 +0100
Message-ID: <20240313170253.2324812-2-kernel@pankajraghav.com>
In-Reply-To: <20240313170253.2324812-1-kernel@pankajraghav.com>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Folios of order 1 have no space to store the deferred list.  This is
not a problem for the page cache as file-backed folios are never
placed on the deferred list.  All we need to do is prevent the core
MM from touching the deferred list for order 1 folios and remove the
code which prevented us from allocating order 1 folios.

Link: https://lore.kernel.org/linux-mm/90344ea7-4eec-47ee-5996-0c22f42d6a6a@google.com/
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/huge_mm.h |  7 +++++--
 mm/filemap.c            |  2 --
 mm/huge_memory.c        | 23 ++++++++++++++++++-----
 mm/internal.h           |  4 +---
 mm/readahead.c          |  3 ---
 5 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 5adb86af35fc..916a2a539517 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -263,7 +263,7 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags);
 
-void folio_prep_large_rmappable(struct folio *folio);
+struct folio *folio_prep_large_rmappable(struct folio *folio);
 bool can_split_folio(struct folio *folio, int *pextra_pins);
 int split_huge_page_to_list(struct page *page, struct list_head *list);
 static inline int split_huge_page(struct page *page)
@@ -410,7 +410,10 @@ static inline unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 	return 0;
 }
 
-static inline void folio_prep_large_rmappable(struct folio *folio) {}
+static inline struct folio *folio_prep_large_rmappable(struct folio *folio)
+{
+	return folio;
+}
 
 #define transparent_hugepage_flags 0UL
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 4a30de98a8c7..a1cb3ea55fb6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1912,8 +1912,6 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			gfp_t alloc_gfp = gfp;
 
 			err = -ENOMEM;
-			if (order == 1)
-				order = 0;
 			if (order > 0)
 				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
 			folio = filemap_alloc_folio(alloc_gfp, order);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 94c958f7ebb5..81fd1ba57088 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -788,11 +788,15 @@ struct deferred_split *get_deferred_split_queue(struct folio *folio)
 }
 #endif
 
-void folio_prep_large_rmappable(struct folio *folio)
+struct folio *folio_prep_large_rmappable(struct folio *folio)
 {
-	VM_BUG_ON_FOLIO(folio_order(folio) < 2, folio);
-	INIT_LIST_HEAD(&folio->_deferred_list);
+	if (!folio || !folio_test_large(folio))
+		return folio;
+	if (folio_order(folio) > 1)
+		INIT_LIST_HEAD(&folio->_deferred_list);
 	folio_set_large_rmappable(folio);
+
+	return folio;
 }
 
 static inline bool is_transparent_hugepage(struct folio *folio)
@@ -3082,7 +3086,8 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	/* Prevent deferred_split_scan() touching ->_refcount */
 	spin_lock(&ds_queue->split_queue_lock);
 	if (folio_ref_freeze(folio, 1 + extra_pins)) {
-		if (!list_empty(&folio->_deferred_list)) {
+		if (folio_order(folio) > 1 &&
+		    !list_empty(&folio->_deferred_list)) {
 			ds_queue->split_queue_len--;
 			list_del(&folio->_deferred_list);
 		}
@@ -3133,6 +3138,9 @@ void folio_undo_large_rmappable(struct folio *folio)
 	struct deferred_split *ds_queue;
 	unsigned long flags;
 
+	if (folio_order(folio) <= 1)
+		return;
+
 	/*
 	 * At this point, there is no one trying to add the folio to
 	 * deferred_list. If folio is not in deferred_list, it's safe
@@ -3158,7 +3166,12 @@ void deferred_split_folio(struct folio *folio)
 #endif
 	unsigned long flags;
 
-	VM_BUG_ON_FOLIO(folio_order(folio) < 2, folio);
+	/*
+	 * Order 1 folios have no space for a deferred list, but we also
+	 * won't waste much memory by not adding them to the deferred list.
+	 */
+	if (folio_order(folio) <= 1)
+		return;
 
 	/*
 	 * The try_to_unmap() in page reclaim path might reach here too,
diff --git a/mm/internal.h b/mm/internal.h
index f309a010d50f..5174b5b0c344 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -419,9 +419,7 @@ static inline struct folio *page_rmappable_folio(struct page *page)
 {
 	struct folio *folio = (struct folio *)page;
 
-	if (folio && folio_order(folio) > 1)
-		folio_prep_large_rmappable(folio);
-	return folio;
+	return folio_prep_large_rmappable(folio);
 }
 
 static inline void prep_compound_head(struct page *page, unsigned int order)
diff --git a/mm/readahead.c b/mm/readahead.c
index 2648ec4f0494..369c70e2be42 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -516,9 +516,6 @@ void page_cache_ra_order(struct readahead_control *ractl,
 		/* Don't allocate pages past EOF */
 		while (index + (1UL << order) - 1 > limit)
 			order--;
-		/* THP machinery does not support order-1 */
-		if (order == 1)
-			order = 0;
 		err = ra_alloc_folio(ractl, index, mark, order, gfp);
 		if (err)
 			break;
-- 
2.43.0


