Return-Path: <linux-fsdevel+bounces-11457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F070B853DD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78BBA1F2CEC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 21:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2966340F;
	Tue, 13 Feb 2024 21:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="xNCr4Eyx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kTV0K89w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B439C62156;
	Tue, 13 Feb 2024 21:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861354; cv=none; b=K0mlsU9fOcoN7eyV8+b+Fb+O99kNa4gy+IxpI2Xj3ybuum2L0F4g2+v9rMyWLAQViNBaI19xhA1tKo+I0kft5FWz+AUTVGxDXgNr0qxfwWtZ1+B+SAD5GnE39O948/+GUc2/qXssNGT4MBkPrXa0CFNVQbQFuJm0AaIYMWp//Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861354; c=relaxed/simple;
	bh=JHkEikCgY3i/2eUJc8+QZcCJfr8NUuDadSm26SoKiOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gAY1e5ygThTC0fF5kWJTqIKRDy6TBlehfaBqjgHrjQ1vClGvclPDqR8yJkoPybEGJlw2gHSe06gOgqsjWjYTmFghtjQ35CrjgBaym3Wj6UkExu6XmHN+1ytyrpFu1akQBkPzhjd4nnKoYGVB3vREP1dKAgWbSiZrX+dz26g1Y10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=xNCr4Eyx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kTV0K89w; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id CDA975C010C;
	Tue, 13 Feb 2024 16:55:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 13 Feb 2024 16:55:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1707861350; x=1707947750; bh=53gxtX7iv4MMGU2MQP7E5gE5detLt5TaDUQ
	anNQvBhI=; b=xNCr4EyxjGxqd5ULfKK3OPD5KTVkU9NXO+Lzcrk0IOhb4mSXvlq
	UcfsCv9V6oLlEwlMByomljWq8tGq7IoO5kc9DLSJKn97sNF/wCRtYLb+l+UFfPQK
	lWuhXmydaRbO9+/OnoXoPiuoPP7gK61p5wJzd4wI/ku3tkYP6a/aan4szsYsZ6dF
	xtaIFU1UP1kRIflWHy90+v4V0+MwGNMiasr3yA0H35nShrUfxxzwMP5Zwlu+jafz
	g6Q6K44gxCWbjhLjib6CT2N0u5YF056zZ3lijA+vlMIaT3QZ6pEftWnFkvC3/vIQ
	JuTdL78x+/59LVC0ilI1UbBmoMZPR/Ea5VQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1707861350; x=1707947750; bh=53gxtX7iv4MMGU2MQP7E5gE5detLt5TaDUQ
	anNQvBhI=; b=kTV0K89wR4dDFy2qyiolbWIpksbaSJ3bo6a7ddpoRpQiRviYWSe
	7IxKMPBhhrDQUulsuPyI/9FGyErLQLPENI7Z5yXfK8aTj/kiovVBxIe6liP70IEI
	KBmyUdPW5F5KMdJkIu+otGExEiashwZ1GMhbG0Wa2+ujjLHoc4NudbSpk3gE7fIn
	uXCYOTW1oliAQuvnZh6FXjpqKkBfu5badMEpa/tXUg5yAXZ+q22ApxUhsy3UCTma
	zdwrfq0KS0g1L+o6168BHfZViCRw7tcGDIdIY+vBeVAOY/jXaoDA5DzlCyVRM9CA
	SmjG4sdK6XSgbNOMp+S/djUu0g1e9FGRpdg==
X-ME-Sender: <xms:ZuXLZVd7A-BSXiwO6DTRSkJUbDl9Jzmr1cd1o3qRYxaUIC4G-KRRZw>
    <xme:ZuXLZTPKdfDmuswSpDDagaLQn0AB1gahd28OtzORAn0Cz06biUJxMwBu68dD2Kd2f
    zqwNlk91TvdGUHmsw>
X-ME-Received: <xmr:ZuXLZehBNc5Sg62WZ6oQWGZLaftkpLkEURk6Ji-Qi91ATeATZXtS0_bGy8QYljgfdX55Ob8H5ZrAjmqWAGeK0pcmNWln8HnqIq9CVoJWge79JGg6uECFdxN3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucdnrfhurhgthhgrshgvucdluddtmdenucfjughrpe
    fhvfevufffkffojghfrhggtgfgsehtkeertdertdejnecuhfhrohhmpegkihcujggrnhcu
    oeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeejkeetkeffle
    elkeduffdtfedvtdejjeeutdeutdetgeejgfevtdefudejkeeiveenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrd
    gtohhm
X-ME-Proxy: <xmx:ZuXLZe_rptzdPFSGRFzESsMcjzS2pYPc16Qo3PhRCVnKPpn21-TdFA>
    <xmx:ZuXLZRvzoul_Qio6C_2o-MrnoKVuIBiXyXAUJBEplc5iyxNA6ov6Lw>
    <xmx:ZuXLZdFgluh3Tg5N7jXRNo4g4se3J7ZDn6vG5eaFShg2uEp--Q-rJ7z1JwC8JOc>
    <xmx:ZuXLZVTepJoZdFfbBvHRxuiKGiWvbWmSbj44Lg4fTm1bqiIM2zfPkQ>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Feb 2024 16:55:50 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	linux-mm@kvack.org
Cc: Zi Yan <ziy@nvidia.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <shy828301@gmail.com>,
	Yu Zhao <yuzhao@google.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	"Zach O'Keefe" <zokeefe@google.com>,
	Hugh Dickins <hughd@google.com>,
	Mcgrof Chamberlain <mcgrof@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 5/7] mm: thp: split huge page to any lower order pages (except order-1).
Date: Tue, 13 Feb 2024 16:55:18 -0500
Message-ID: <20240213215520.1048625-6-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213215520.1048625-1-zi.yan@sent.com>
References: <20240213215520.1048625-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Zi Yan <ziy@nvidia.com>

To split a THP to any lower order (except order-1) pages, we need to
reform THPs on subpages at given order and add page refcount based on the
new page order. Also we need to reinitialize page_deferred_list after
removing the page from the split_queue, otherwise a subsequent split will
see list corruption when checking the page_deferred_list again.

It has many uses, like minimizing the number of pages after
truncating a huge pagecache page. For anonymous THPs, we can only split
them to order-0 like before until we add support for any size anonymous
THPs.

Order-1 folio is not supported because _deferred_list, which is used by
partially mapped folios, is stored in subpage 2 and an order-1 folio only
has subpage 0 and 1.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/huge_mm.h |  21 +++++---
 mm/huge_memory.c        | 114 +++++++++++++++++++++++++++++++---------
 2 files changed, 101 insertions(+), 34 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 5adb86af35fc..de0c89105076 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -265,10 +265,11 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
 
 void folio_prep_large_rmappable(struct folio *folio);
 bool can_split_folio(struct folio *folio, int *pextra_pins);
-int split_huge_page_to_list(struct page *page, struct list_head *list);
+int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
+		unsigned int new_order);
 static inline int split_huge_page(struct page *page)
 {
-	return split_huge_page_to_list(page, NULL);
+	return split_huge_page_to_list_to_order(page, NULL, 0);
 }
 void deferred_split_folio(struct folio *folio);
 
@@ -422,7 +423,8 @@ can_split_folio(struct folio *folio, int *pextra_pins)
 	return false;
 }
 static inline int
-split_huge_page_to_list(struct page *page, struct list_head *list)
+split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
+		unsigned int new_order)
 {
 	return 0;
 }
@@ -519,17 +521,20 @@ static inline bool thp_migration_supported(void)
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-static inline int split_folio_to_list(struct folio *folio,
-		struct list_head *list)
+static inline int split_folio_to_list_to_order(struct folio *folio,
+		struct list_head *list, int new_order)
 {
-	return split_huge_page_to_list(&folio->page, list);
+	return split_huge_page_to_list_to_order(&folio->page, list, new_order);
 }
 
-static inline int split_folio(struct folio *folio)
+static inline int split_folio_to_order(struct folio *folio, int new_order)
 {
-	return split_folio_to_list(folio, NULL);
+	return split_folio_to_list_to_order(folio, NULL, new_order);
 }
 
+#define split_folio_to_list(f, l) split_folio_to_list_to_order(f, l, 0)
+#define split_folio(f) split_folio_to_order(f, 0)
+
 /*
  * archs that select ARCH_WANTS_THP_SWAP but don't support THP_SWP due to
  * limitations in the implementation like arm64 MTE can override this to
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ad7133c97428..d0e555a8ea98 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2718,11 +2718,14 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
 
 static void unmap_folio(struct folio *folio)
 {
-	enum ttu_flags ttu_flags = TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD |
-		TTU_SYNC | TTU_BATCH_FLUSH;
+	enum ttu_flags ttu_flags = TTU_RMAP_LOCKED | TTU_SYNC |
+		TTU_BATCH_FLUSH;
 
 	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
 
+	if (folio_test_pmd_mappable(folio))
+		ttu_flags |= TTU_SPLIT_HUGE_PMD;
+
 	/*
 	 * Anon pages need migration entries to preserve them, but file
 	 * pages can simply be left unmapped, then faulted back on demand.
@@ -2756,7 +2759,6 @@ static void lru_add_page_tail(struct page *head, struct page *tail,
 		struct lruvec *lruvec, struct list_head *list)
 {
 	VM_BUG_ON_PAGE(!PageHead(head), head);
-	VM_BUG_ON_PAGE(PageCompound(tail), head);
 	VM_BUG_ON_PAGE(PageLRU(tail), head);
 	lockdep_assert_held(&lruvec->lru_lock);
 
@@ -2777,7 +2779,8 @@ static void lru_add_page_tail(struct page *head, struct page *tail,
 }
 
 static void __split_huge_page_tail(struct folio *folio, int tail,
-		struct lruvec *lruvec, struct list_head *list)
+		struct lruvec *lruvec, struct list_head *list,
+		unsigned int new_order)
 {
 	struct page *head = &folio->page;
 	struct page *page_tail = head + tail;
@@ -2847,10 +2850,15 @@ static void __split_huge_page_tail(struct folio *folio, int tail,
 	 * which needs correct compound_head().
 	 */
 	clear_compound_head(page_tail);
+	if (new_order) {
+		prep_compound_page(page_tail, new_order);
+		folio_prep_large_rmappable(page_folio(page_tail));
+	}
 
 	/* Finally unfreeze refcount. Additional reference from page cache. */
-	page_ref_unfreeze(page_tail, 1 + (!folio_test_anon(folio) ||
-					  folio_test_swapcache(folio)));
+	page_ref_unfreeze(page_tail,
+		1 + ((!folio_test_anon(folio) || folio_test_swapcache(folio)) ?
+			     folio_nr_pages(page_folio(page_tail)) : 0));
 
 	if (folio_test_young(folio))
 		folio_set_young(new_folio);
@@ -2868,7 +2876,7 @@ static void __split_huge_page_tail(struct folio *folio, int tail,
 }
 
 static void __split_huge_page(struct page *page, struct list_head *list,
-		pgoff_t end)
+		pgoff_t end, unsigned int new_order)
 {
 	struct folio *folio = page_folio(page);
 	struct page *head = &folio->page;
@@ -2877,10 +2885,11 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	unsigned long offset = 0;
 	unsigned int nr = thp_nr_pages(head);
 	int i, nr_dropped = 0;
+	unsigned int new_nr = 1 << new_order;
 	int order = folio_order(folio);
 
 	/* complete memcg works before add pages to LRU */
-	split_page_memcg(head, order, 0);
+	split_page_memcg(head, order, new_order);
 
 	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
 		offset = swp_offset(folio->swap);
@@ -2893,8 +2902,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 
 	ClearPageHasHWPoisoned(head);
 
-	for (i = nr - 1; i >= 1; i--) {
-		__split_huge_page_tail(folio, i, lruvec, list);
+	for (i = nr - new_nr; i >= new_nr; i -= new_nr) {
+		__split_huge_page_tail(folio, i, lruvec, list, new_order);
 		/* Some pages can be beyond EOF: drop them from page cache */
 		if (head[i].index >= end) {
 			struct folio *tail = page_folio(head + i);
@@ -2910,29 +2919,41 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 			__xa_store(&head->mapping->i_pages, head[i].index,
 					head + i, 0);
 		} else if (swap_cache) {
+			/*
+			 * split anonymous THPs (including swapped out ones) to
+			 * non-zero order not supported
+			 */
+			VM_WARN_ONCE(new_order,
+				"Split swap-cached anon folio to non-0 order not supported");
 			__xa_store(&swap_cache->i_pages, offset + i,
 					head + i, 0);
 		}
 	}
 
-	ClearPageCompound(head);
+	if (!new_order)
+		ClearPageCompound(head);
+	else {
+		struct folio *new_folio = (struct folio *)head;
+
+		folio_set_order(new_folio, new_order);
+	}
 	unlock_page_lruvec(lruvec);
 	/* Caller disabled irqs, so they are still disabled here */
 
-	split_page_owner(head, order, 0);
+	split_page_owner(head, order, new_order);
 
 	/* See comment in __split_huge_page_tail() */
 	if (PageAnon(head)) {
 		/* Additional pin to swap cache */
 		if (PageSwapCache(head)) {
-			page_ref_add(head, 2);
+			page_ref_add(head, 1 + new_nr);
 			xa_unlock(&swap_cache->i_pages);
 		} else {
 			page_ref_inc(head);
 		}
 	} else {
 		/* Additional pin to page cache */
-		page_ref_add(head, 2);
+		page_ref_add(head, 1 + new_nr);
 		xa_unlock(&head->mapping->i_pages);
 	}
 	local_irq_enable();
@@ -2944,7 +2965,15 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	if (folio_test_swapcache(folio))
 		split_swap_cluster(folio->swap);
 
-	for (i = 0; i < nr; i++) {
+	/*
+	 * set page to its compound_head when split to non order-0 pages, so
+	 * we can skip unlocking it below, since PG_locked is transferred to
+	 * the compound_head of the page and the caller will unlock it.
+	 */
+	if (new_order)
+		page = compound_head(page);
+
+	for (i = 0; i < nr; i += new_nr) {
 		struct page *subpage = head + i;
 		if (subpage == page)
 			continue;
@@ -2978,29 +3007,35 @@ bool can_split_folio(struct folio *folio, int *pextra_pins)
 }
 
 /*
- * This function splits huge page into normal pages. @page can point to any
- * subpage of huge page to split. Split doesn't change the position of @page.
+ * This function splits huge page into pages in @new_order. @page can point to
+ * any subpage of huge page to split. Split doesn't change the position of
+ * @page.
+ *
+ * NOTE: order-1 folio is not supported because _deferred_list, which is used
+ * by partially mapped folios, is stored in subpage 2 and an order-1 folio
+ * only has subpage 0 and 1.
  *
  * Only caller must hold pin on the @page, otherwise split fails with -EBUSY.
  * The huge page must be locked.
  *
  * If @list is null, tail pages will be added to LRU list, otherwise, to @list.
  *
- * Both head page and tail pages will inherit mapping, flags, and so on from
- * the hugepage.
+ * Pages in new_order will inherit mapping, flags, and so on from the hugepage.
  *
- * GUP pin and PG_locked transferred to @page. Rest subpages can be freed if
- * they are not mapped.
+ * GUP pin and PG_locked transferred to @page or the compound page @page belongs
+ * to. Rest subpages can be freed if they are not mapped.
  *
  * Returns 0 if the hugepage is split successfully.
  * Returns -EBUSY if the page is pinned or if anon_vma disappeared from under
  * us.
  */
-int split_huge_page_to_list(struct page *page, struct list_head *list)
+int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
+				     unsigned int new_order)
 {
 	struct folio *folio = page_folio(page);
 	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
-	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
+	/* reset xarray order to new order after split */
+	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
 	int extra_pins, ret;
@@ -3010,6 +3045,26 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
 
+	/* Cannot split THP to order-1 (no order-1 THPs) */
+	if (new_order == 1) {
+		VM_WARN_ONCE(1, "Cannot split to order-1 folio");
+		return -EINVAL;
+	}
+
+	if (new_order) {
+		/* Split shmem folio to non-zero order not supported */
+		if (shmem_mapping(folio->mapping)) {
+			VM_WARN_ONCE(1, "Split shmem folio to non-0 order not support");
+			return -EINVAL;
+		}
+		/* No split if the file system does not support large folio */
+		if (!mapping_large_folio_support(folio->mapping)) {
+			VM_WARN_ONCE(1, "Split file folio to non-0 order not support");
+			return -EINVAL;
+		}
+	}
+
+
 	is_hzp = is_huge_zero_page(&folio->page);
 	if (is_hzp) {
 		pr_warn_ratelimited("Called split_huge_page for huge zero page\n");
@@ -3105,14 +3160,21 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	if (folio_ref_freeze(folio, 1 + extra_pins)) {
 		if (!list_empty(&folio->_deferred_list)) {
 			ds_queue->split_queue_len--;
-			list_del(&folio->_deferred_list);
+			/*
+			 * Reinitialize page_deferred_list after removing the
+			 * page from the split_queue, otherwise a subsequent
+			 * split will see list corruption when checking the
+			 * page_deferred_list.
+			 */
+			list_del_init(&folio->_deferred_list);
 		}
 		spin_unlock(&ds_queue->split_queue_lock);
 		if (mapping) {
 			int nr = folio_nr_pages(folio);
 
 			xas_split(&xas, folio, folio_order(folio));
-			if (folio_test_pmd_mappable(folio)) {
+			if (folio_test_pmd_mappable(folio) &&
+			    new_order < HPAGE_PMD_ORDER) {
 				if (folio_test_swapbacked(folio)) {
 					__lruvec_stat_mod_folio(folio,
 							NR_SHMEM_THPS, -nr);
@@ -3124,7 +3186,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 			}
 		}
 
-		__split_huge_page(page, list, end);
+		__split_huge_page(page, list, end, new_order);
 		ret = 0;
 	} else {
 		spin_unlock(&ds_queue->split_queue_lock);
-- 
2.43.0


