Return-Path: <linux-fsdevel+bounces-17535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CEF8AF4F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 19:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7A96B24ED8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 17:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6301422DE;
	Tue, 23 Apr 2024 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSxPWhj8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3601422C7;
	Tue, 23 Apr 2024 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891868; cv=none; b=NiVe0x0DXE3VDaE8iaRnaBKhASi6IVuRLMMcy7avXrMggyADwU+MfDtQfOBpCCYlUPbfEkdb7vCPBoG7JOPkX/eqGCqjfap9U/spZXqToAWFcUbghw8dxI4EM0BJQt5JQtSp+tzK15I6wCm+vynz6xraoDZj4DShtrOhhxeuj4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891868; c=relaxed/simple;
	bh=v/4DZT1o7SWRbUFCwl1q9F0Wyx1rUuOJ0NQJDPbonbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7htv/+9Yn/U6PctrPH+50z7t91OfAp/uMeM6s4bGQyd/UgyShUsC25Hl6/OzkpeX4TCrILw5YF1KTfSLl4vq3k06KxxnYC/hP0cKDMVzpjEgbWaQAaA/6tjSIIzYgQZi48O+IOsO0gvditlIqjz03f0Vn3Co7Dg5LdOt14PQAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSxPWhj8; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2a614b0391dso4688679a91.1;
        Tue, 23 Apr 2024 10:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713891866; x=1714496666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CnMzyp4v7D+bPlM4VXqNTLQwTcA8u3vvnjSU90ZgW/k=;
        b=GSxPWhj8KIm7+7RjVbAQyb86c7kuggpq9L3wHwsAjO5obwBhumrS0Jut7+z4cte5cm
         WFCmNSFdk58Teso/aLUas91RvL9tfVA+6Xh++blfVx6CXhXKJdIA7p93KqZa1QT+BD2W
         5yWXTuyZLyK9mDxwGAcdL6xacKN/6bWREWqvivqYmtR9e8cQM9h1Mj5OOBtTFl/gtzsa
         mLAFIM4UXYlqxU1VJUOPKO+bkT+IKUuOy8kcGUKk5fnPu7z9+3ZqWEdOcmTYM2RgE6Ym
         6WIXYJgI5JU+SQMndw9pIw9/4aDksgrOVjpQkHelTXDUQGFpMAD+JndMfr1qLqMuW//U
         fS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713891866; x=1714496666;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CnMzyp4v7D+bPlM4VXqNTLQwTcA8u3vvnjSU90ZgW/k=;
        b=tSsCeblKz/2C8ABfLcL7UtUfw2+SN2Aw7EvBzYnP/yNnpnJSrHzMldpRqBbsiOH81d
         Z3VvMUevHjzsHcLZ27EP8imFKD/91m1O7Hi8m4Bc9ZGwjJc9RHQIpaYdscrq3laoq9hi
         9Rkc1L30wU47a2Pr7VF3Z/zeuOiFhAIVE9lKLqjISOb/zTUPS7jqbF+lIIx1AmerJuBH
         Go4CsBm/UXWwRxTSiG2m4XKZdHsa/rs8J3S0c4bMlx+oQZpc9HYzvQBdrkzjktWNmyOM
         oijZVK4UFLhoghVH16wMzqGLBz/vm7lb08bWoQTFzIhQO5HggLE/chVlia3kPNWcdZiR
         iZZg==
X-Forwarded-Encrypted: i=1; AJvYcCWpnCWZRfKrf/aEyDBk8y3J36mhVZsHQi58xhYnbrFo+b4ruWc/RCF3GXqXbE+mYjtTN9AQjovRFKDmhXvKAxgdrmMx0xGtHux7g13z0OSV9SSl4YrKU3H1zpaPVtSyFuOjuEr8Q72MLhangA==
X-Gm-Message-State: AOJu0Yzo9IS930YKgVtCwaOyUPIPNn/MtXAbnIHnQsbVfJ5CERJBf8gn
	kx25j5tLTyjesuSreWkVuNTaJ0C+C8gv/VovPLpmMmNoZkUVzRlJ
X-Google-Smtp-Source: AGHT+IHsdf0a0hXaosoeNJct0li+Z9JISuE3KsVNLbRolhiRYgiN4NDjYwA6cqx8BtEiKf1+SehY8w==
X-Received: by 2002:a17:90b:3506:b0:2a7:e71:eb72 with SMTP id ls6-20020a17090b350600b002a70e71eb72mr37270pjb.0.1713891866020;
        Tue, 23 Apr 2024 10:04:26 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id s19-20020a17090a881300b002a5d684a6a7sm9641148pjn.10.2024.04.23.10.04.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Apr 2024 10:04:25 -0700 (PDT)
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
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 8/8] mm/swap: reduce swap cache search space
Date: Wed, 24 Apr 2024 01:03:39 +0800
Message-ID: <20240423170339.54131-9-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423170339.54131-1-ryncsn@gmail.com>
References: <20240423170339.54131-1-ryncsn@gmail.com>
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
big swap file. But when doing swap cache look up or insert, we are
still using the offset of the whole large swap file. This is OK for
correctness, as the offset (key) is unique.

But Xarray is specially optimized for small indexes, it creates the
radix tree levels lazily to be just enough to fit the largest key
stored in one Xarray. So we are wasting tree nodes unnecessarily.

For 64M chunk it should only take at most 3 levels to contain everything.
But we are using the offset from the whole swap file, so the offset (key)
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
---
 mm/huge_memory.c |  2 +-
 mm/memcontrol.c  |  2 +-
 mm/mincore.c     |  2 +-
 mm/shmem.c       |  2 +-
 mm/swap.h        | 15 +++++++++++++++
 mm/swap_state.c  | 12 ++++++------
 mm/swapfile.c    |  6 +++---
 7 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9859aa4f7553..1208d60792f0 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2903,7 +2903,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	split_page_memcg(head, order, new_order);
 
 	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
-		offset = swp_offset(folio->swap);
+		offset = swap_cache_index(folio->swap);
 		swap_cache = swap_address_space(folio->swap);
 		xa_lock(&swap_cache->i_pages);
 	}
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index fabce2b50c69..04d7be7f30dc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5934,7 +5934,7 @@ static struct page *mc_handle_swap_pte(struct vm_area_struct *vma,
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
index 0aad0d9a621b..cbe33ab52a73 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1762,7 +1762,7 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
 
 	old = *foliop;
 	entry = old->swap;
-	swap_index = swp_offset(entry);
+	swap_index = swap_cache_index(entry);
 	swap_mapping = swap_address_space(entry);
 
 	/*
diff --git a/mm/swap.h b/mm/swap.h
index 82023ab93205..93e3e1b58a7f 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -27,6 +27,7 @@ void __swap_writepage(struct folio *folio, struct writeback_control *wbc);
 /* One swap address space for each 64M swap space */
 #define SWAP_ADDRESS_SPACE_SHIFT	14
 #define SWAP_ADDRESS_SPACE_PAGES	(1 << SWAP_ADDRESS_SPACE_SHIFT)
+#define SWAP_ADDRESS_SPACE_MASK		(BIT(SWAP_ADDRESS_SPACE_SHIFT) - 1)
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
index bfc7e8c58a6d..9dbb54c72770 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -72,7 +72,7 @@ void show_swap_cache_info(void)
 void *get_shadow_from_swap_cache(swp_entry_t entry)
 {
 	struct address_space *address_space = swap_address_space(entry);
-	pgoff_t idx = swp_offset(entry);
+	pgoff_t idx = swap_cache_index(entry);
 	struct page *page;
 
 	page = xa_load(&address_space->i_pages, idx);
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
@@ -350,7 +350,7 @@ struct folio *swap_cache_get_folio(swp_entry_t entry,
 {
 	struct folio *folio;
 
-	folio = filemap_get_folio(swap_address_space(entry), swp_offset(entry));
+	folio = filemap_get_folio(swap_address_space(entry), swap_cache_index(entry));
 	if (!IS_ERR(folio)) {
 		bool vma_ra = swap_use_vma_readahead();
 		bool readahead;
@@ -420,7 +420,7 @@ struct folio *filemap_get_incore_folio(struct address_space *mapping,
 	si = get_swap_device(swp);
 	if (!si)
 		return ERR_PTR(-ENOENT);
-	index = swp_offset(swp);
+	index = swap_cache_index(swp);
 	folio = filemap_get_folio(swap_address_space(swp), index);
 	put_swap_device(si);
 	return folio;
@@ -447,7 +447,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		 * that would confuse statistics.
 		 */
 		folio = filemap_get_folio(swap_address_space(entry),
-						swp_offset(entry));
+					  swap_cache_index(entry));
 		if (!IS_ERR(folio))
 			goto got_folio;
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 2387f5e131d7..3d838659f55f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -138,7 +138,7 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	struct folio *folio;
 	int ret = 0;
 
-	folio = filemap_get_folio(swap_address_space(entry), offset);
+	folio = filemap_get_folio(swap_address_space(entry), swap_cache_index(entry));
 	if (IS_ERR(folio))
 		return 0;
 	/*
@@ -2110,7 +2110,7 @@ static int try_to_unuse(unsigned int type)
 	       (i = find_next_to_unuse(si, i)) != 0) {
 
 		entry = swp_entry(type, i);
-		folio = filemap_get_folio(swap_address_space(entry), i);
+		folio = filemap_get_folio(swap_address_space(entry), swap_cache_index(entry));
 		if (IS_ERR(folio))
 			continue;
 
@@ -3421,7 +3421,7 @@ EXPORT_SYMBOL_GPL(swapcache_mapping);
 
 pgoff_t __folio_swap_cache_index(struct folio *folio)
 {
-	return swp_offset(folio->swap);
+	return swap_cache_index(folio->swap);
 }
 EXPORT_SYMBOL_GPL(__folio_swap_cache_index);
 
-- 
2.44.0


