Return-Path: <linux-fsdevel+bounces-12879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79ED868243
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 21:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4219CB20E93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 20:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF80133435;
	Mon, 26 Feb 2024 20:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="Gn40UuZA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S45x2fml"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183D913249D;
	Mon, 26 Feb 2024 20:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708980978; cv=none; b=GT0nnU7WRpRalx3bLxos2scg7SPjgchUL9ZWbmramT+YjqeHnSipaaY9F3Ar/qnHvhOzkzVTj7UuKwQcIi/ptmohOrOjNZCrri1cXH0HLvKtBF/H8UFglfWHM9Mqkq+9LfUjxanuP7w+pJ992zhB0vdIpq1eufubIsYyPpmSYJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708980978; c=relaxed/simple;
	bh=Gj4etBysvHmpgeUpCQUjRlhkDluUaFmpO3rvp/CVp+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MW6O9/zYnkEPXnOp4sziYwU1/aWorA7PQyQB1WwL6BMbZcdTDwDNmQhT2/SsixkKdcwqnA9yknH92nktPVdD/H8UXdSKBFw4/keFPrRSMWAzcJK1vBPsYyD7AvJ98wgf9slUFfwyvzai+IA5p/q4y+q2nfpXQoQRvzIbpM5duaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=Gn40UuZA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S45x2fml; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 604935C00AB;
	Mon, 26 Feb 2024 15:56:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 26 Feb 2024 15:56:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1708980975; x=1709067375; bh=GUAsk26iYl7MhG3zj5r2ZNKBhryTNauvcp1
	OLHy1WRg=; b=Gn40UuZAhb5ftJv5LRfJMIhXiq3QdWSx1my35TaUWUEu5ycpFVl
	IS1nKksLaE2+5rqFt9FR61yW0wY7XwvHpf+SUo6qhQhShH+A+FcTOS9wAX2fsPau
	QoKk6zAp8765ulvAvY4C71FS+BcIRJdBJRNnNSQD4waUHzdg8UlfzS/xhYVMLy2p
	dkB2jOv9CG5Z5h42xNOoWRnOU4RvVZVDRLQzoiAfcAOXfCUnRv2mdsFTxDwlh33U
	gUD26EzxwbG+UnchZ/ABk3WgslLi3yyVXLaovONMbYb0pPySoO/QTltve1MhUD/X
	gI4tSKb+k2mm4W8u+DOD7nRY3ZYLSQfV//Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1708980975; x=1709067375; bh=GUAsk26iYl7MhG3zj5r2ZNKBhryTNauvcp1
	OLHy1WRg=; b=S45x2fml7gmhnMQ2+nlEIwKLi14mFfBfranhr0+4tnF/Zhmlgn4
	v0LkmfYJ3ECXF2pAUUe9H3JchTGeWe490haeAxfAt3SlvZhZlHfM1A7oTcxhBtep
	gsNUSoNiP4Rcf//o9VuNy1gCeFikjL4vGqD66vb/XXztiiuSW+gBQMDMJFSmiaas
	CUM3gCOiUd8fO8BTNnOWhbwjaAl7dGTRqMum3DwmP2exFekMylhIgyMrK/Rsq3HK
	CvpHvOvZtc/1ICI47XPcP9xuVAj+cXKgYn3fVBO+C40csgJ7gEAsz1vTC5idS+4F
	reG2E0mSnFLt4C9LVmZTuCWggrywN5smi5Q==
X-ME-Sender: <xms:7vrcZYf3bm5K2vo7LCw6w4bGJdF6s2_1WGQ8Mq9vu29efnFpGpdhcw>
    <xme:7vrcZaPKDEIlk60tZmwEYXAllPdVNeV806n4E70Jzmx2TEW2fNlUOaWIlwOcF57AH
    HlSVU477DEwZZTBMQ>
X-ME-Received: <xmr:7vrcZZgRJb0Nf7KU7mVJx984C-3-ACwRnUbDsR-InS_dk9sBoS53FEuFSl13PrVkAPX7Pa4z15prkn56D3sMTvaV88o2h5jLRDDRCEVgpckRJVYSlwse93lB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedvgddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrgggtgfesthekredtredtjeenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepje
    ekteekffelleekudfftdefvddtjeejuedtuedtteegjefgvedtfedujeekieevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:7vrcZd95miOhrGcnyqyHx9TCrR7KqThSwrI7CM6C5MSxN0KNLivkgQ>
    <xmx:7vrcZUsCHOrPrU8-ESRuLTHuhAxmjc2gLQxlaKDVkoU_Qxs1gZFZCg>
    <xmx:7vrcZUH4BoBQjm0ZFZ4f8PmzHu390-q4czTis3xSmWd0QkMOPItbbw>
    <xmx:7_rcZUQWsUsOIsgBiFr8Mn9vnr7XcO_yRUH9vzoHqmBfnQroMQAryA>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Feb 2024 15:56:14 -0500 (EST)
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
	Luis Chamberlain <mcgrof@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 7/8] mm: thp: split huge page to any lower order pages
Date: Mon, 26 Feb 2024 15:55:33 -0500
Message-ID: <20240226205534.1603748-8-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226205534.1603748-1-zi.yan@sent.com>
References: <20240226205534.1603748-1-zi.yan@sent.com>
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

To split a THP to any lower order pages, we need to reform THPs on
subpages at given order and add page refcount based on the new page
order. Also we need to reinitialize page_deferred_list after removing
the page from the split_queue, otherwise a subsequent split will
see list corruption when checking the page_deferred_list again.

Note: Anonymous order-1 folio is not supported because _deferred_list,
which is used by partially mapped folios, is stored in subpage 2 and an
order-1 folio only has subpage 0 and 1. File-backed order-1 folios are
fine, since they do not use _deferred_list.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/huge_mm.h |  21 +++++---
 mm/huge_memory.c        | 110 +++++++++++++++++++++++++++++++---------
 2 files changed, 99 insertions(+), 32 deletions(-)

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
index b2df788c11fa..8b47a96a28f9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2770,7 +2770,6 @@ static void lru_add_page_tail(struct page *head, struct page *tail,
 		struct lruvec *lruvec, struct list_head *list)
 {
 	VM_BUG_ON_PAGE(!PageHead(head), head);
-	VM_BUG_ON_PAGE(PageCompound(tail), head);
 	VM_BUG_ON_PAGE(PageLRU(tail), head);
 	lockdep_assert_held(&lruvec->lru_lock);
 
@@ -2791,7 +2790,8 @@ static void lru_add_page_tail(struct page *head, struct page *tail,
 }
 
 static void __split_huge_page_tail(struct folio *folio, int tail,
-		struct lruvec *lruvec, struct list_head *list)
+		struct lruvec *lruvec, struct list_head *list,
+		unsigned int new_order)
 {
 	struct page *head = &folio->page;
 	struct page *page_tail = head + tail;
@@ -2861,10 +2861,15 @@ static void __split_huge_page_tail(struct folio *folio, int tail,
 	 * which needs correct compound_head().
 	 */
 	clear_compound_head(page_tail);
+	if (new_order) {
+		prep_compound_page(page_tail, new_order);
+		folio_prep_large_rmappable(new_folio);
+	}
 
 	/* Finally unfreeze refcount. Additional reference from page cache. */
-	page_ref_unfreeze(page_tail, 1 + (!folio_test_anon(folio) ||
-					  folio_test_swapcache(folio)));
+	page_ref_unfreeze(page_tail,
+		1 + ((!folio_test_anon(folio) || folio_test_swapcache(folio)) ?
+			     folio_nr_pages(new_folio) : 0));
 
 	if (folio_test_young(folio))
 		folio_set_young(new_folio);
@@ -2882,7 +2887,7 @@ static void __split_huge_page_tail(struct folio *folio, int tail,
 }
 
 static void __split_huge_page(struct page *page, struct list_head *list,
-		pgoff_t end)
+		pgoff_t end, unsigned int new_order)
 {
 	struct folio *folio = page_folio(page);
 	struct page *head = &folio->page;
@@ -2890,11 +2895,12 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	struct address_space *swap_cache = NULL;
 	unsigned long offset = 0;
 	int i, nr_dropped = 0;
+	unsigned int new_nr = 1 << new_order;
 	int order = folio_order(folio);
 	unsigned int nr = 1 << order;
 
 	/* complete memcg works before add pages to LRU */
-	split_page_memcg(head, order, 0);
+	split_page_memcg(head, order, new_order);
 
 	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
 		offset = swp_offset(folio->swap);
@@ -2907,8 +2913,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 
 	ClearPageHasHWPoisoned(head);
 
-	for (i = nr - 1; i >= 1; i--) {
-		__split_huge_page_tail(folio, i, lruvec, list);
+	for (i = nr - new_nr; i >= new_nr; i -= new_nr) {
+		__split_huge_page_tail(folio, i, lruvec, list, new_order);
 		/* Some pages can be beyond EOF: drop them from page cache */
 		if (head[i].index >= end) {
 			struct folio *tail = page_folio(head + i);
@@ -2929,24 +2935,30 @@ static void __split_huge_page(struct page *page, struct list_head *list,
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
@@ -2958,7 +2970,15 @@ static void __split_huge_page(struct page *page, struct list_head *list,
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
@@ -2992,29 +3012,36 @@ bool can_split_folio(struct folio *folio, int *pextra_pins)
 }
 
 /*
- * This function splits huge page into normal pages. @page can point to any
- * subpage of huge page to split. Split doesn't change the position of @page.
+ * This function splits huge page into pages in @new_order. @page can point to
+ * any subpage of huge page to split. Split doesn't change the position of
+ * @page.
+ *
+ * NOTE: order-1 anonymous folio is not supported because _deferred_list,
+ * which is used by partially mapped folios, is stored in subpage 2 and an
+ * order-1 folio only has subpage 0 and 1. File-backed order-1 folios are OK,
+ * since they do not use _deferred_list.
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
@@ -3024,6 +3051,34 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
 
+	/* Cannot split anonymous THP to order-1 */
+	if (new_order == 1 && folio_test_anon(folio)) {
+		VM_WARN_ONCE(1, "Cannot split to order-1 folio");
+		return -EINVAL;
+	}
+
+	if (new_order) {
+		/* Only swapping a whole PMD-mapped folio is supported */
+		if (folio_test_swapcache(folio)) {
+			VM_WARN_ONCE(1,
+				"Cannot split swap-cached folio to non-0 order");
+			return -EINVAL;
+		}
+		/* Split shmem folio to non-zero order not supported */
+		if (shmem_mapping(folio->mapping)) {
+			VM_WARN_ONCE(1,
+				"Cannot split shmem folio to non-0 order");
+			return -EINVAL;
+		}
+		/* No split if the file system does not support large folio */
+		if (!mapping_large_folio_support(folio->mapping)) {
+			VM_WARN_ONCE(1,
+				"Cannot split file folio to non-0 order");
+			return -EINVAL;
+		}
+	}
+
+
 	is_hzp = is_huge_zero_page(&folio->page);
 	if (is_hzp) {
 		pr_warn_ratelimited("Called split_huge_page for huge zero page\n");
@@ -3120,14 +3175,21 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		if (folio_order(folio) > 1 &&
 		    !list_empty(&folio->_deferred_list)) {
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
@@ -3139,7 +3201,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 			}
 		}
 
-		__split_huge_page(page, list, end);
+		__split_huge_page(page, list, end, new_order);
 		ret = 0;
 	} else {
 		spin_unlock(&ds_queue->split_queue_lock);
-- 
2.43.0


