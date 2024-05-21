Return-Path: <linux-fsdevel+bounces-19931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7098CB344
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 20:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5041F2253B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 18:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616DF148843;
	Tue, 21 May 2024 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ke1Bi5bD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C0E14A638;
	Tue, 21 May 2024 17:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716314393; cv=none; b=JemiOJ/Olegs0cJ96ix4BWGofKl02WdYViu7oDPrFmhhbVMLLJqrwFgdKCEcbdawRa/4VrrVoXuSHWzEpVEQ3tEbJCsB0h+eeA0LkBn0uzEbUk5WYKKJwi/IRHi/HjbexVncL6X4a7X5y8xRGQC8WQVeKAjz4hUFdLLpPbDgyrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716314393; c=relaxed/simple;
	bh=61MriWGtPLPpZsrO73fCBAhdwQo0/XaJgc8eagLcVXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRDidvLU26GJ+Y67lt1o/AW7tYxGC7Yq3Sa+d9GnmU+9gS2ZB+AwUMVBaVwqk1BsIv+rQ0BMslVBq6WdCSVxv5+vh/BSZLtK2VcgCoIGYR4dZV05V8zyqylkQuz60hDZCIUPA67ejNsxjx2mZTFMGqaU6Exq5Yw2/wPYwB2wapI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ke1Bi5bD; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ed904c2280so3304305ad.2;
        Tue, 21 May 2024 10:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716314391; x=1716919191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jX6zUCloIMLeC0AtUUIo54oV7OGNQUUzaEpWo4Ucc+8=;
        b=ke1Bi5bDcBWNP3Nf3MDgLLxSoGYKpmrBe6HYtKvwgJguKqRmSAOb5hsHK/Ci5+umRf
         eqK357InbnULcr3Y6ON3lCa6yp8WWAxYuaj5DGPb3TzKoRn2QNqxqq7EsfXHX2mfYLY/
         5z0g7Cw5Da/Rhac8kwpACW2zoNYTFvSVt5z0VbS1gB1Ci1uPjPdZlO571uB2hR229i1y
         QD7M4sj57sSNXh0WnUpn08tE//Qws4pqkM/p4S7Ku7z6UccFYbTMXxQTM2tWI5DqSeIb
         /nN/dhx6m+HEkBXccQIa7QXBxjeQOou5YUzRSpQhqUvvSIJINCmyCfRhyD2ACgwv3IAy
         4Efg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716314391; x=1716919191;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jX6zUCloIMLeC0AtUUIo54oV7OGNQUUzaEpWo4Ucc+8=;
        b=W7FEMkxH9qjt/RLq4QAsNpC1/0Pqhu+HRzf+COH6FiegMI8csVdu2osrY17EKjfsye
         aGUZqAKUU+uWp6Kl6vrzPk+d8xFFumaaPekZqv7PJxhVvqeK6CeIILwnlsPMKJo5TDRa
         I6wNlDIoJhYoWxuUnMdnzV9KJzIHE1kHsoYNZ1K7AREypksLlX++UjjASnAxVrPEEMb5
         pgn40JsvIMnzlEXfQlkX5+i0rkqT0CWPzQDISG4mFH648MuBURmq4AX/THGrryA8FmnF
         VbvzknDNtRfE7R2DKhrQdoUNEBQJ9LYkotkogRnS4zL5Uu2kZxK/q9GsehOjVIPE7040
         GD0g==
X-Forwarded-Encrypted: i=1; AJvYcCUK0FeFEM3lR9cebua1hGlCGavCy65WUbmOavtwwWvP16hQ8tHUs8eIJfbmj2hPQlEmQS0lz6nQOOL2jOUNlddEk8dUIBRGMCEfCtVPwubpoUTFovEO/qQuJAPxIktNcse8WGkf95eqnwTVPQ==
X-Gm-Message-State: AOJu0Ywx0osXnJAzMDDbiS48bpSqNnViLWle0MZsiaDu0wYrpzuSfaqB
	s5p0FCcbLvRlhHbz5kQrAgb4IrVF0InWYSVejk3fScQMue+BOdaF
X-Google-Smtp-Source: AGHT+IExAfgsIwWGDABBN/J81IQxzi7Xmus1MnTq7EO1h5SpSUKVtCl9UBUAT3KpqGVr3jZT+Cbd4w==
X-Received: by 2002:a17:902:bb17:b0:1e0:115c:e03c with SMTP id d9443c01a7336-1ef43f4ce9fmr320876095ad.53.1716314391332;
        Tue, 21 May 2024 10:59:51 -0700 (PDT)
Received: from localhost.localdomain ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f2fcdf87besm44646935ad.105.2024.05.21.10.59.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 May 2024 10:59:50 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Neil Brown <neilb@suse.de>,
	Minchan Kim <minchan@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v6 11/11] mm/swap: reduce swap cache search space
Date: Wed, 22 May 2024 01:58:53 +0800
Message-ID: <20240521175854.96038-12-ryncsn@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240521175854.96038-1-ryncsn@gmail.com>
References: <20240521175854.96038-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Currently we use one swap_address_space for every 64M chunk to reduce lock
contention, this is like having a set of smaller swap files inside one
swap device. But when doing swap cache look up or insert, we are
still using the offset of the whole large swap device. This is OK for
correctness, as the offset (key) is unique.

But Xarray is specially optimized for small indexes, it creates the
radix tree levels lazily to be just enough to fit the largest key
stored in one Xarray. So we are wasting tree nodes unnecessarily.

For 64M chunk it should only take at most 3 levels to contain everything.
But if we are using the offset from the whole swap device, the offset (key)
value will be way beyond 64M, and so will the tree level.

Optimize this by using a new helper swap_cache_index to get a swap
entry's unique offset in its own 64M swap_address_space.

I see a ~1% performance gain in benchmark and actual workload with
high memory pressure.

Test with `time memhog 128G` inside a 8G memcg using 128G swap (ramdisk
with SWP_SYNCHRONOUS_IO dropped, tested 3 times, results are stable. The
test result is similar but the improvement is smaller if SWP_SYNCHRONOUS_IO
is enabled, as swap out path can never skip swap cache):

Before:
6.07user 250.74system 4:17.26elapsed 99%CPU (0avgtext+0avgdata 8373376maxresident)k
0inputs+0outputs (55major+33555018minor)pagefaults 0swaps

After (1.8% faster):
6.08user 246.09system 4:12.58elapsed 99%CPU (0avgtext+0avgdata 8373248maxresident)k
0inputs+0outputs (54major+33555027minor)pagefaults 0swaps

Similar result with MySQL and sysbench using swap:
Before:
94055.61 qps

After (0.8% faster):
94834.91 qps

Radix tree slab usage is also very slightly lower.

Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
---
 mm/huge_memory.c |  2 +-
 mm/memcontrol.c  |  2 +-
 mm/mincore.c     |  2 +-
 mm/shmem.c       |  2 +-
 mm/swap.h        | 15 +++++++++++++++
 mm/swap_state.c  | 17 +++++++++--------
 mm/swapfile.c    |  6 +++---
 7 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 317de2afd371..fcc0e86a2589 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2838,7 +2838,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	split_page_memcg(head, order, new_order);
 
 	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
-		offset = swp_offset(folio->swap);
+		offset = swap_cache_index(folio->swap);
 		swap_cache = swap_address_space(folio->swap);
 		xa_lock(&swap_cache->i_pages);
 	}
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7fad15b2290c..cee66c30d31e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6148,7 +6148,7 @@ static struct page *mc_handle_swap_pte(struct vm_area_struct *vma,
 	 * Because swap_cache_get_folio() updates some statistics counter,
 	 * we call find_get_page() with swapper_space directly.
 	 */
-	page = find_get_page(swap_address_space(ent), swp_offset(ent));
+	page = find_get_page(swap_address_space(ent), swap_cache_index(ent));
 	entry->val = ent.val;
 
 	return page;
diff --git a/mm/mincore.c b/mm/mincore.c
index dad3622cc963..e31cf1bde614 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -139,7 +139,7 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			} else {
 #ifdef CONFIG_SWAP
 				*vec = mincore_page(swap_address_space(entry),
-						    swp_offset(entry));
+						    swap_cache_index(entry));
 #else
 				WARN_ON(1);
 				*vec = 1;
diff --git a/mm/shmem.c b/mm/shmem.c
index f5d60436b604..f9b0c34c435a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1756,7 +1756,7 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
 
 	old = *foliop;
 	entry = old->swap;
-	swap_index = swp_offset(entry);
+	swap_index = swap_cache_index(entry);
 	swap_mapping = swap_address_space(entry);
 
 	/*
diff --git a/mm/swap.h b/mm/swap.h
index 82023ab93205..2c0e96272d49 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -27,6 +27,7 @@ void __swap_writepage(struct folio *folio, struct writeback_control *wbc);
 /* One swap address space for each 64M swap space */
 #define SWAP_ADDRESS_SPACE_SHIFT	14
 #define SWAP_ADDRESS_SPACE_PAGES	(1 << SWAP_ADDRESS_SPACE_SHIFT)
+#define SWAP_ADDRESS_SPACE_MASK		(SWAP_ADDRESS_SPACE_PAGES - 1)
 extern struct address_space *swapper_spaces[];
 #define swap_address_space(entry)			    \
 	(&swapper_spaces[swp_type(entry)][swp_offset(entry) \
@@ -40,6 +41,15 @@ static inline loff_t swap_dev_pos(swp_entry_t entry)
 	return ((loff_t)swp_offset(entry)) << PAGE_SHIFT;
 }
 
+/*
+ * Return the swap cache index of the swap entry.
+ */
+static inline pgoff_t swap_cache_index(swp_entry_t entry)
+{
+	BUILD_BUG_ON((SWP_OFFSET_MASK | SWAP_ADDRESS_SPACE_MASK) != SWP_OFFSET_MASK);
+	return swp_offset(entry) & SWAP_ADDRESS_SPACE_MASK;
+}
+
 void show_swap_cache_info(void);
 bool add_to_swap(struct folio *folio);
 void *get_shadow_from_swap_cache(swp_entry_t entry);
@@ -86,6 +96,11 @@ static inline struct address_space *swap_address_space(swp_entry_t entry)
 	return NULL;
 }
 
+static inline pgoff_t swap_cache_index(swp_entry_t entry)
+{
+	return 0;
+}
+
 static inline void show_swap_cache_info(void)
 {
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 642c30d8376c..6e86c759dc1d 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -72,7 +72,7 @@ void show_swap_cache_info(void)
 void *get_shadow_from_swap_cache(swp_entry_t entry)
 {
 	struct address_space *address_space = swap_address_space(entry);
-	pgoff_t idx = swp_offset(entry);
+	pgoff_t idx = swap_cache_index(entry);
 	void *shadow;
 
 	shadow = xa_load(&address_space->i_pages, idx);
@@ -89,7 +89,7 @@ int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
 			gfp_t gfp, void **shadowp)
 {
 	struct address_space *address_space = swap_address_space(entry);
-	pgoff_t idx = swp_offset(entry);
+	pgoff_t idx = swap_cache_index(entry);
 	XA_STATE_ORDER(xas, &address_space->i_pages, idx, folio_order(folio));
 	unsigned long i, nr = folio_nr_pages(folio);
 	void *old;
@@ -144,7 +144,7 @@ void __delete_from_swap_cache(struct folio *folio,
 	struct address_space *address_space = swap_address_space(entry);
 	int i;
 	long nr = folio_nr_pages(folio);
-	pgoff_t idx = swp_offset(entry);
+	pgoff_t idx = swap_cache_index(entry);
 	XA_STATE(xas, &address_space->i_pages, idx);
 
 	xas_set_update(&xas, workingset_update_node);
@@ -253,13 +253,14 @@ void clear_shadow_from_swap_cache(int type, unsigned long begin,
 
 	for (;;) {
 		swp_entry_t entry = swp_entry(type, curr);
+		unsigned long index = curr & SWAP_ADDRESS_SPACE_MASK;
 		struct address_space *address_space = swap_address_space(entry);
-		XA_STATE(xas, &address_space->i_pages, curr);
+		XA_STATE(xas, &address_space->i_pages, index);
 
 		xas_set_update(&xas, workingset_update_node);
 
 		xa_lock_irq(&address_space->i_pages);
-		xas_for_each(&xas, old, end) {
+		xas_for_each(&xas, old, min(index + (end - curr), SWAP_ADDRESS_SPACE_PAGES)) {
 			if (!xa_is_value(old))
 				continue;
 			xas_store(&xas, NULL);
@@ -350,7 +351,7 @@ struct folio *swap_cache_get_folio(swp_entry_t entry,
 {
 	struct folio *folio;
 
-	folio = filemap_get_folio(swap_address_space(entry), swp_offset(entry));
+	folio = filemap_get_folio(swap_address_space(entry), swap_cache_index(entry));
 	if (!IS_ERR(folio)) {
 		bool vma_ra = swap_use_vma_readahead();
 		bool readahead;
@@ -420,7 +421,7 @@ struct folio *filemap_get_incore_folio(struct address_space *mapping,
 	si = get_swap_device(swp);
 	if (!si)
 		return ERR_PTR(-ENOENT);
-	index = swp_offset(swp);
+	index = swap_cache_index(swp);
 	folio = filemap_get_folio(swap_address_space(swp), index);
 	put_swap_device(si);
 	return folio;
@@ -447,7 +448,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		 * that would confuse statistics.
 		 */
 		folio = filemap_get_folio(swap_address_space(entry),
-						swp_offset(entry));
+					  swap_cache_index(entry));
 		if (!IS_ERR(folio))
 			goto got_folio;
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 0b0ae6e8c764..4f0e8b2ac8aa 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -142,7 +142,7 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	struct folio *folio;
 	int ret = 0;
 
-	folio = filemap_get_folio(swap_address_space(entry), offset);
+	folio = filemap_get_folio(swap_address_space(entry), swap_cache_index(entry));
 	if (IS_ERR(folio))
 		return 0;
 	/*
@@ -2158,7 +2158,7 @@ static int try_to_unuse(unsigned int type)
 	       (i = find_next_to_unuse(si, i)) != 0) {
 
 		entry = swp_entry(type, i);
-		folio = filemap_get_folio(swap_address_space(entry), i);
+		folio = filemap_get_folio(swap_address_space(entry), swap_cache_index(entry));
 		if (IS_ERR(folio))
 			continue;
 
@@ -3476,7 +3476,7 @@ EXPORT_SYMBOL_GPL(swapcache_mapping);
 
 pgoff_t __folio_swap_cache_index(struct folio *folio)
 {
-	return swp_offset(folio->swap);
+	return swap_cache_index(folio->swap);
 }
 EXPORT_SYMBOL_GPL(__folio_swap_cache_index);
 
-- 
2.45.0


