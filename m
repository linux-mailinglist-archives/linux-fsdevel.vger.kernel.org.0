Return-Path: <linux-fsdevel+bounces-17023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 788B88A659B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 10:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E831C223D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 08:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BF612EBD5;
	Tue, 16 Apr 2024 08:02:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49C87FBBA;
	Tue, 16 Apr 2024 08:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713254569; cv=none; b=JfFcHttI/f2N14XkHOBeck/lt8lbnmzNH6Yw6CgreDBkdMzqy5PUZ8DDmFHmLTfPgy8rFSmKKXko/E78OfXuntMwa1UQky1OIQrz6BXMPSiXYZM7lF/ecSca1um18m2tE+SWxmCU0GqBTLrrxQHpWd8+T646+HGR+KNek+lK9Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713254569; c=relaxed/simple;
	bh=tn/GBnRICcJdeKMYnrg62lH25ltqM035b4xvTJV5wYw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SnkxcPXx9a4Wn0I79SqwA/qVabkA9zpyVRY6lplDUSfxALK5V8g+HcEqHiOgpLn70oxBxqryITZSxyAHlR4wPJW92n+Vs0Elr+KMiXQMRB+ioTG3fIVK5dIZV7iclhrMXkIs5pBKbUn3pRKk6UKdqhRzBOVAgYc6BGVrPYG16hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 43G80usQ012685;
	Tue, 16 Apr 2024 16:00:56 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4VJbyL62Z3z2NTBr4;
	Tue, 16 Apr 2024 15:58:34 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 16 Apr 2024 16:00:54 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: <dqminh@cloudflare.com>
CC: <david@fromorbit.com>, <kernel-team@cloudflare.com>,
        <linux-fsdevel@vger.kernel.org>, <steve.kang@unisoc.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] mm: protect xa split stuff under lruvec->lru_lock during migration
Date: Tue, 16 Apr 2024 16:00:46 +0800
Message-ID: <20240416080046.310866-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CA+wXwBS7YTHUmxGP3JrhcKMnYQJcd6=7HE+E1v-guk01L2K3Zw@mail.gmail.com>
References: <CA+wXwBS7YTHUmxGP3JrhcKMnYQJcd6=7HE+E1v-guk01L2K3Zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 43G80usQ012685

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Livelock in [1] is reported multitimes since v515, where the zero-ref
folio is repeatly found on the page cache by find_get_entry. A possible
timing sequence is proposed in [2], which can be described briefly as
the lockless xarray operation could get harmed by an illegal folio
remaining on the slot[offset]. This commit would like to protect
the xa split stuff(folio_ref_freeze and __split_huge_page) under
lruvec->lock to remove the race window.

[1]
[167789.800297] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[167726.780305] rcu: Tasks blocked on level-0 rcu_node (CPUs 0-7): P155
[167726.780319] (detected by 3, t=17256977 jiffies, g=19883597, q=2397394)
[167726.780325] task:kswapd0         state:R  running task     stack:   24 pid:  155 ppid:     2 flags:0x00000008
[167789.800308] rcu: Tasks blocked on level-0 rcu_node (CPUs 0-7): P155
[167789.800322] (detected by 3, t=17272732 jiffies, g=19883597, q=2397470)
[167789.800328] task:kswapd0         state:R  running task     stack:   24 pid:  155 ppid:     2 flags:0x00000008
[167789.800339] Call trace:
[167789.800342]  dump_backtrace.cfi_jt+0x0/0x8
[167789.800355]  show_stack+0x1c/0x2c
[167789.800363]  sched_show_task+0x1ac/0x27c
[167789.800370]  print_other_cpu_stall+0x314/0x4dc
[167789.800377]  check_cpu_stall+0x1c4/0x36c
[167789.800382]  rcu_sched_clock_irq+0xe8/0x388
[167789.800389]  update_process_times+0xa0/0xe0
[167789.800396]  tick_sched_timer+0x7c/0xd4
[167789.800404]  __run_hrtimer+0xd8/0x30c
[167789.800408]  hrtimer_interrupt+0x1e4/0x2d0
[167789.800414]  arch_timer_handler_phys+0x5c/0xa0
[167789.800423]  handle_percpu_devid_irq+0xbc/0x318
[167789.800430]  handle_domain_irq+0x7c/0xf0
[167789.800437]  gic_handle_irq+0x54/0x12c
[167789.800445]  call_on_irq_stack+0x40/0x70
[167789.800451]  do_interrupt_handler+0x44/0xa0
[167789.800457]  el1_interrupt+0x34/0x64
[167789.800464]  el1h_64_irq_handler+0x1c/0x2c
[167789.800470]  el1h_64_irq+0x7c/0x80
[167789.800474]  xas_find+0xb4/0x28c
[167789.800481]  find_get_entry+0x3c/0x178
[167789.800487]  find_lock_entries+0x98/0x2f8
[167789.800492]  __invalidate_mapping_pages.llvm.3657204692649320853+0xc8/0x224
[167789.800500]  invalidate_mapping_pages+0x18/0x28
[167789.800506]  inode_lru_isolate+0x140/0x2a4
[167789.800512]  __list_lru_walk_one+0xd8/0x204
[167789.800519]  list_lru_walk_one+0x64/0x90
[167789.800524]  prune_icache_sb+0x54/0xe0
[167789.800529]  super_cache_scan+0x160/0x1ec
[167789.800535]  do_shrink_slab+0x20c/0x5c0
[167789.800541]  shrink_slab+0xf0/0x20c
[167789.800546]  shrink_node_memcgs+0x98/0x320
[167789.800553]  shrink_node+0xe8/0x45c
[167789.800557]  balance_pgdat+0x464/0x814
[167789.800563]  kswapd+0xfc/0x23c
[167789.800567]  kthread+0x164/0x1c8
[167789.800573]  ret_from_fork+0x10/0x20

[2]
Thread_isolate:
1. alloc_contig_range->isolate_migratepages_block isolate a certain of
pages to cc->migratepages via pfn
       (folio has refcount: 1 + n (alloc_pages, page_cache))

2. alloc_contig_range->migrate_pages->folio_ref_freeze(folio, 1 +
extra_pins) set the folio->refcnt to 0

3. alloc_contig_range->migrate_pages->xas_split split the folios to
each slot as folio from slot[offset] to slot[offset + sibs]

4. alloc_contig_range->migrate_pages->__split_huge_page->folio_lruvec_lock
failed which have the folio be failed in setting refcnt to 2

5. Thread_kswapd enter the livelock by the chain below
      rcu_read_lock();
   retry:
        find_get_entry
            folio = xas_find
            if(!folio_try_get_rcu)
                xas_reset;
            goto retry;
      rcu_read_unlock();

5'. Thread_holdlock as the lruvec->lru_lock holder could be stalled in
the same core of Thread_kswapd.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/huge_memory.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9859aa4f7553..418e8d03480a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2891,7 +2891,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 {
 	struct folio *folio = page_folio(page);
 	struct page *head = &folio->page;
-	struct lruvec *lruvec;
+	struct lruvec *lruvec = folio_lruvec(folio);
 	struct address_space *swap_cache = NULL;
 	unsigned long offset = 0;
 	int i, nr_dropped = 0;
@@ -2908,8 +2908,6 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		xa_lock(&swap_cache->i_pages);
 	}
 
-	/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
-	lruvec = folio_lruvec_lock(folio);
 
 	ClearPageHasHWPoisoned(head);
 
@@ -2942,7 +2940,6 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 
 		folio_set_order(new_folio, new_order);
 	}
-	unlock_page_lruvec(lruvec);
 	/* Caller disabled irqs, so they are still disabled here */
 
 	split_page_owner(head, order, new_order);
@@ -2961,7 +2958,6 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		folio_ref_add(folio, 1 + new_nr);
 		xa_unlock(&folio->mapping->i_pages);
 	}
-	local_irq_enable();
 
 	if (nr_dropped)
 		shmem_uncharge(folio->mapping->host, nr_dropped);
@@ -3048,6 +3044,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	int extra_pins, ret;
 	pgoff_t end;
 	bool is_hzp;
+	struct lruvec *lruvec;
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
@@ -3159,6 +3156,14 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 
 	/* block interrupt reentry in xa_lock and spinlock */
 	local_irq_disable();
+
+	/*
+	 * take lruvec's lock before freeze the folio to prevent the folio
+	 * remains in the page cache with refcnt == 0, which could lead to
+	 * find_get_entry enters livelock by iterating the xarray.
+	 */
+	lruvec = folio_lruvec_lock(folio);
+
 	if (mapping) {
 		/*
 		 * Check if the folio is present in page cache.
@@ -3203,12 +3208,16 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		}
 
 		__split_huge_page(page, list, end, new_order);
+		unlock_page_lruvec(lruvec);
+		local_irq_enable();
 		ret = 0;
 	} else {
 		spin_unlock(&ds_queue->split_queue_lock);
 fail:
 		if (mapping)
 			xas_unlock(&xas);
+
+		unlock_page_lruvec(lruvec);
 		local_irq_enable();
 		remap_page(folio, folio_nr_pages(folio));
 		ret = -EAGAIN;
-- 
2.25.1


