Return-Path: <linux-fsdevel+bounces-18179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE138B61C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 21:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E710A2842DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1B913C670;
	Mon, 29 Apr 2024 19:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTTtYTxw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68ED13C3F5;
	Mon, 29 Apr 2024 19:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714418011; cv=none; b=ClWne/JdzRg+jwsRXMYIQPJm4+pNXt3KUl1QppfKbxvrr0bsZE71ENAvf3yKtS1Me4ukikR8HCiZXQnb+0UoN9X7I/UPtPRT7OQSTfMTU7n6oa6ufouUMX//vwx9fzOxfBO8shkAxdbvUmkK5esLSudhVSn/bj2/ElUPytd2ggU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714418011; c=relaxed/simple;
	bh=ruPguBGn/jL44gWfkAWdwjzz7mpX0JB5xbh0t/SLx0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E5ATZqSvpwXxTZajrSYcw40XpKxO4gx1or05q5fFtG5zGchEM/q2eG274mGOduhnmrGmvwMhVcuehkOROUuA/g6KivJMohHnnMHHnBodhZDRvhn+LaVsn1Vro7xdkuxNR3kXm7cclShjEpFgKMUFYJpSmx/PFJ8R5ASsSdlUF/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTTtYTxw; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ed04c91c46so4719997b3a.0;
        Mon, 29 Apr 2024 12:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714418009; x=1715022809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PY7g2cpmkbLDRH/cw0JP1fam/luoqXTBgJ66zM17H9Q=;
        b=GTTtYTxwDFAYdzQptdDCoGBF59NtgoI45fU0ErAx9u0bag2QJD7sb8HgwYI0jkPZzt
         JWbxlmdxsGWVZZw89URcMsnXK6K6zxUBX8asuo1SupUveQV6ACTtFzIxDRQwMotP1qAd
         raqMKieFnX9d4qhtj+xJE65YaztIJCv9GIB5u36OKIPQaH+/OyNfZZDP65WzHKL6p28X
         GcoFaQDlUFapdX4UmNn78SpVmfrUVN+xcgQgffwA8CFS9jyyCpQ7YlS8Wrcu+4Eo37Ms
         CGrrpCXMkvCvzgmyvSMtFznsCMJhi6E21DFaj3UD4D9PWiUToTMfAQZvQ2iTxIU2Uzm0
         kxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714418009; x=1715022809;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PY7g2cpmkbLDRH/cw0JP1fam/luoqXTBgJ66zM17H9Q=;
        b=Pqw7GcCKBhBKDvdZF/bo3NfFs8R24XJU3AdlHVRF56PPhTH7yIpHB3smPA93HL1iO2
         hLFfQ+HAfUPmB1a8G6PiCJPtg84b1Drtq1HsFT7CbL2MNPQaZo+FqiixBmjG8WIXY1Kl
         y+cy/j9K9mgOpD+pdK2WRvVd+6q2UhD052mCBXyp0Pw9sS6yE4jqQtWcpNaR8m2tHZcu
         Rns0wGD8D91Cjx7L+Ciw+gXpWdIwoT84fK1pYMDUZjvpNMVKJkjHNuLzatHHJ3CvDOR0
         qpaDU3rewEVFbq23OyqMfK2L3SgTtSv3x3bxwLpLsJL9palACoxr6IwNS4e1YtfWWWxy
         /8iA==
X-Forwarded-Encrypted: i=1; AJvYcCV7drQWt4EKrN0T3k/JvRZakgnAx7o1KXmaD5ERxyNrxD7C0WzKCd8QNglKFPPkmMt4uLsnl6nuYMK+nCjVxEwzur3xFvngYX0G2ldoZ03/ru6+xrfCi5k4/oF9b7wHEdCB26V8m+U08OoInw==
X-Gm-Message-State: AOJu0YzM30hJmJiuWhuJK+/xrsbyLHZ1o3Ep/IOsZ82QWV5mWoxnPAxB
	EvRg4OJTUkXGJeB09qPm4JRMh9BQt7qxy35Ee+igiNG1+vwPr0MX
X-Google-Smtp-Source: AGHT+IExOJ/p/bJW9q/f21ksPY2gdiW8nSTfaSxNTc1Poa54zyXrIO+xTyTWMo/yh/qLCiK2/+zrZA==
X-Received: by 2002:a05:6a20:4386:b0:1a7:ae5d:5fb4 with SMTP id i6-20020a056a20438600b001a7ae5d5fb4mr15127477pzl.28.1714418009348;
        Mon, 29 Apr 2024 12:13:29 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id e10-20020aa7980a000000b006ed38291aebsm20307988pfl.178.2024.04.29.12.13.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Apr 2024 12:13:28 -0700 (PDT)
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
Subject: [PATCH v3 12/12] mm/swap: reduce swap cache search space
Date: Tue, 30 Apr 2024 03:11:38 +0800
Message-ID: <20240429191138.34123-5-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429190500.30979-1-ryncsn@gmail.com>
References: <20240429190500.30979-1-ryncsn@gmail.com>
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
index 8261b5669397..d0c6d30d72f2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2841,7 +2841,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	split_page_memcg(head, order, new_order);
 
 	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
-		offset = swp_offset(folio->swap);
+		offset = swap_cache_index(folio->swap);
 		swap_cache = swap_address_space(folio->swap);
 		xa_lock(&swap_cache->i_pages);
 	}
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 602ad5faad4d..8a75eb6c86cc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5983,7 +5983,7 @@ static struct page *mc_handle_swap_pte(struct vm_area_struct *vma,
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
index fa2a0ed97507..326315c12feb 100644
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
index 642c30d8376c..9994b8d17741 100644
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
index 6f028262898b..81bd61d0a7a6 100644
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
2.44.0


