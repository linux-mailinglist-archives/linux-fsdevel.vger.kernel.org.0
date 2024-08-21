Return-Path: <linux-fsdevel+bounces-26536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 291D395A551
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 21:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2201C21E64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 19:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7332016F0D0;
	Wed, 21 Aug 2024 19:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pZIcobPr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DD6A31
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724268896; cv=none; b=I9j5r3uGOsFt+jMu0clVFL/2wLHRmAm9vt53wQTV8KH3kmyloCW/rMdSia38ka/OI+hB+NYBUcftZcXIENXAw8e9kzfJPaaNBfxHlef2phRq/IcfEGXCY8ciw/P7G/9qJ+YH1YapTSBYIJclTiFDbNPgAGuPe4+LsP6SwuW6zBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724268896; c=relaxed/simple;
	bh=tFyeK7kop8JgmY8rGHpmnkfu5IjJkAYi0N2n/JThMn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mx2DAzVhkCW+8EC6nKxbl3G7PRQHvBCNmbX1BpVAAKA8ba/axfVTzn56HCAKm1cbA9AWvRfNQhk8MT+mVmSaEeNyFQcHyzi/2rXhZ47YX6WZf41LLDqLlxSxCQ9PMW5t5AbrpMhudY4u7/bHHOXxww7z0xe7j+JHVriH086TnDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pZIcobPr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=jKZijI013UrsY8//D8mSr9BHaGPMIkaEKCgxfvI4RII=; b=pZIcobPrDSGyDZSfT22Thcx82Y
	Bz8gpO59ik5Vo66lFek33lsTTg5neo+jY+1k3MpSbwRC7DBsBOoVpt6Llh+CaDmRcwl+znpv8IykP
	/PQhyZ55sfZ8VEbcPGccP3lnQAxzlaDwWGRmvAYvSYsBlQz6e7fHwSDfH2r1rHPnuL9mKfS397KCn
	iH4nGnTjp/IQtbuIuzRzHc1c9pgmrTfJCbELyFUmgE85hLGwnAqKWlOr7f1uWKYCujHd24z7VChzT
	KT2/dtxA1vy4WR1rSaCp+psxA7LuoEg2kI3oxTrvRSRcW0v5UakYGsMl1DfNgKs4csHeZoHn48rmo
	3DDx2+Xg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgr6V-00000009cqh-0Njj;
	Wed, 21 Aug 2024 19:34:47 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 04/10] mm: Remove PageSwapCache
Date: Wed, 21 Aug 2024 20:34:37 +0100
Message-ID: <20240821193445.2294269-5-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821193445.2294269-1-willy@infradead.org>
References: <20240821193445.2294269-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This flag is now only used on folios, so we can remove all the page
accessors and reword the comments that refer to them.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm_types.h   |  2 +-
 include/linux/page-flags.h | 11 +++--------
 mm/ksm.c                   | 19 ++++++++++---------
 mm/migrate.c               |  3 ++-
 mm/shmem.c                 | 11 ++++++-----
 5 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 2419e60c9a7f..6e3bdf8e38bc 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -109,7 +109,7 @@ struct page {
 			/**
 			 * @private: Mapping-private opaque data.
 			 * Usually used for buffer_heads if PagePrivate.
-			 * Used for swp_entry_t if PageSwapCache.
+			 * Used for swp_entry_t if swapcache flag set.
 			 * Indicates order in the buddy system if PageBuddy.
 			 */
 			unsigned long private;
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 2c2e6106682c..43a7996c53d4 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -574,15 +574,10 @@ static __always_inline bool folio_test_swapcache(const struct folio *folio)
 			test_bit(PG_swapcache, const_folio_flags(folio, 0));
 }
 
-static __always_inline bool PageSwapCache(const struct page *page)
-{
-	return folio_test_swapcache(page_folio(page));
-}
-
-SETPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
-CLEARPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
+FOLIO_SET_FLAG(swapcache, FOLIO_HEAD_PAGE)
+FOLIO_CLEAR_FLAG(swapcache, FOLIO_HEAD_PAGE)
 #else
-PAGEFLAG_FALSE(SwapCache, swapcache)
+FOLIO_FLAG_FALSE(swapcache)
 #endif
 
 PAGEFLAG(Unevictable, unevictable, PF_HEAD)
diff --git a/mm/ksm.c b/mm/ksm.c
index 8e53666bc7b0..a2e2a521df0a 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -909,12 +909,13 @@ static struct folio *ksm_get_folio(struct ksm_stable_node *stable_node,
 	 */
 	while (!folio_try_get(folio)) {
 		/*
-		 * Another check for page->mapping != expected_mapping would
-		 * work here too.  We have chosen the !PageSwapCache test to
-		 * optimize the common case, when the page is or is about to
-		 * be freed: PageSwapCache is cleared (under spin_lock_irq)
-		 * in the ref_freeze section of __remove_mapping(); but Anon
-		 * folio->mapping reset to NULL later, in free_pages_prepare().
+		 * Another check for folio->mapping != expected_mapping
+		 * would work here too.  We have chosen to test the
+		 * swapcache flag to optimize the common case, when the
+		 * folio is or is about to be freed: the swapcache flag
+		 * is cleared (under spin_lock_irq) in the ref_freeze
+		 * section of __remove_mapping(); but anon folio->mapping
+		 * is reset to NULL later, in free_pages_prepare().
 		 */
 		if (!folio_test_swapcache(folio))
 			goto stale;
@@ -945,7 +946,7 @@ static struct folio *ksm_get_folio(struct ksm_stable_node *stable_node,
 
 stale:
 	/*
-	 * We come here from above when page->mapping or !PageSwapCache
+	 * We come here from above when folio->mapping or the swapcache flag
 	 * suggests that the node is stale; but it might be under migration.
 	 * We need smp_rmb(), matching the smp_wmb() in folio_migrate_ksm(),
 	 * before checking whether node->kpfn has been changed.
@@ -1452,7 +1453,7 @@ static int try_to_merge_one_page(struct vm_area_struct *vma,
 		goto out;
 
 	/*
-	 * We need the page lock to read a stable PageSwapCache in
+	 * We need the folio lock to read a stable swapcache flag in
 	 * write_protect_page().  We use trylock_page() instead of
 	 * lock_page() because we don't want to wait here - we
 	 * prefer to continue scanning and merging different pages,
@@ -3123,7 +3124,7 @@ void folio_migrate_ksm(struct folio *newfolio, struct folio *folio)
 		 * newfolio->mapping was set in advance; now we need smp_wmb()
 		 * to make sure that the new stable_node->kpfn is visible
 		 * to ksm_get_folio() before it can see that folio->mapping
-		 * has gone stale (or that folio_test_swapcache has been cleared).
+		 * has gone stale (or that the swapcache flag has been cleared).
 		 */
 		smp_wmb();
 		folio_set_stable_node(folio, NULL);
diff --git a/mm/migrate.c b/mm/migrate.c
index 1248c89d4dbd..4f55f4930fe8 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -666,7 +666,8 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 	folio_migrate_ksm(newfolio, folio);
 	/*
 	 * Please do not reorder this without considering how mm/ksm.c's
-	 * ksm_get_folio() depends upon ksm_migrate_page() and PageSwapCache().
+	 * ksm_get_folio() depends upon ksm_migrate_page() and the
+	 * swapcache flag.
 	 */
 	if (folio_test_swapcache(folio))
 		folio_clear_swapcache(folio);
diff --git a/mm/shmem.c b/mm/shmem.c
index 22a3f3c1897e..752106aca845 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -502,8 +502,8 @@ static int shmem_replace_entry(struct address_space *mapping,
  * Sometimes, before we decide whether to proceed or to fail, we must check
  * that an entry was not already brought back from swap by a racing thread.
  *
- * Checking page is not enough: by the time a SwapCache page is locked, it
- * might be reused, and again be SwapCache, using the same swap as before.
+ * Checking folio is not enough: by the time a swapcache folio is locked, it
+ * might be reused, and again be swapcache, using the same swap as before.
  */
 static bool shmem_confirm_swap(struct address_space *mapping,
 			       pgoff_t index, swp_entry_t swap)
@@ -1940,9 +1940,10 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
 
 	if (unlikely(error)) {
 		/*
-		 * Is this possible?  I think not, now that our callers check
-		 * both PageSwapCache and page_private after getting page lock;
-		 * but be defensive.  Reverse old to newpage for clear and free.
+		 * Is this possible?  I think not, now that our callers
+		 * check both the swapcache flag and folio->private
+		 * after getting the folio lock; but be defensive.
+		 * Reverse old to newpage for clear and free.
 		 */
 		old = new;
 	} else {
-- 
2.43.0


