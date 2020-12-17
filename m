Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12662DCB72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 04:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbgLQDrK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 22:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728403AbgLQDrJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 22:47:09 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C0FC0611CE
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Dec 2020 19:46:06 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id b5so3312634pjk.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Dec 2020 19:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xPjoCn2Uhs8i6RF8GvQfWf4AwMz+svXGYxnAYdmZuDI=;
        b=FdA31vfhWIaMgeUtFlI+xUN18KN7HWs+1u/iMKZ8h9cFMId0stAFiuLOownLzArh8L
         2fzM9WXVHXZsmTiYNgo8QU7+nQP5UM8beR3pMq/h2X1dBGboRcETj+dNmhqlDaQoz+tu
         jz1pWXsd2WzKOVU326tp4I/9a5CfKgWPYoZN4guHONSWx/6s4ArO6aaZ/yICNOSS3owR
         4Hz/ORKvyCLq6lO7V8pspKM5mgeVd12DulFBRz5iBhBkH0+NqpSvhza0Yo3upeYmRnhj
         nFIsfm6BHRg2N3TztOzHwrCed+GDNCsUpURley6YjEjMkGrm0zE9jNwnxsaMV+iX5M96
         t44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xPjoCn2Uhs8i6RF8GvQfWf4AwMz+svXGYxnAYdmZuDI=;
        b=a7q/mWdDg468hK/vEUrhpa1XHolBQ3eQSEob//OojgYwg+X27zw7B0KAhhU06JqPSF
         NrGDegZGAjBu3eCPGLyo+5M8KPO5kZX6LUf39lyfyj/BOJBV/ZW0tjQ8OxSYmlV5/qPr
         /7KT7gZMzYlEGgHy/1iWtcqgz6EYfjna0erq7WA2atKCL7ytBomXyxP76luBSCHNPBpd
         AEecmihBJuRk4OIoyUNjho0AUjkMPKDBtUy9gCi8oYv5Z9gPI/B19ljdx4Hmhkm4QTmL
         DquEJG12Zj+9oG5gLenwEp+WFG8gQN8x0+Xw2uPDLGA89OXHRgJGHQY87Jbc4jF4QgQF
         Rgfg==
X-Gm-Message-State: AOAM532grtOxAEJDUSO9Y7kFx44vXGiN9ByPzvVZqvGk4a7aBSI9apMT
        USo6tDwvF+B4NQ+4Bje0SJbiMg==
X-Google-Smtp-Source: ABdhPJyslSNhwkUQPenLnPmRpXXnGeJnaiZemfAb8ZSiBZaOJ+bSnMxU+5XmF2/JoA9qIu+/teWM9Q==
X-Received: by 2002:a17:90a:638a:: with SMTP id f10mr6021880pjj.191.1608176765601;
        Wed, 16 Dec 2020 19:46:05 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id b2sm3792412pfo.164.2020.12.16.19.45.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Dec 2020 19:46:05 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, shakeelb@google.com,
        guro@fb.com, samitolvanen@google.com, feng.tang@intel.com,
        neilb@suse.de, iamjoonsoo.kim@lge.com, rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 4/7] mm: memcontrol: convert NR_SHMEM_THPS account to pages
Date:   Thu, 17 Dec 2020 11:43:53 +0800
Message-Id: <20201217034356.4708-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201217034356.4708-1-songmuchun@bytedance.com>
References: <20201217034356.4708-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently we use struct per_cpu_nodestat to cache the vmstat
counters, which leads to inaccurate statistics expecially THP
vmstat counters. In the systems with hundreads of processors
it can be GBs of memory. For example, for a 96 CPUs system,
the threshold is the maximum number of 125. And the per cpu
counters can cache 23.4375 GB in total.

The THP page is already a form of batched addition (it will
add 512 worth of memory in one go) so skipping the batching
seems like sensible. Although every THP stats update overflows
the per-cpu counter, resorting to atomic global updates. But
it can make the statistics more accuracy for the THP vmstat
counters.

So we convert the NR_SHMEM_THPS account to pages. This patch
is consistent with 8f182270dfec ("mm/swap.c: flush lru pvecs
on compound page arrival"). Doing this also can make the unit
of vmstat counters more unified. Finally, the unit of the vmstat
counters are pages, kB and bytes. The B/KB suffix can tell us
that the unit is bytes or kB. The rest which is without suffix
are pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/node.c    |  3 +--
 fs/proc/meminfo.c      |  2 +-
 include/linux/mmzone.h |  3 ++-
 mm/filemap.c           |  2 +-
 mm/huge_memory.c       |  3 ++-
 mm/khugepaged.c        |  2 +-
 mm/memcontrol.c        | 26 ++------------------------
 mm/page_alloc.c        |  2 +-
 mm/shmem.c             |  2 +-
 9 files changed, 12 insertions(+), 33 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index d5952f754911..6d5ac6ffb6e1 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -462,8 +462,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 			     ,
 			     nid, K(node_page_state(pgdat, NR_ANON_THPS)),
-			     nid, K(node_page_state(pgdat, NR_SHMEM_THPS) *
-				    HPAGE_PMD_NR),
+			     nid, K(node_page_state(pgdat, NR_SHMEM_THPS)),
 			     nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED) *
 				    HPAGE_PMD_NR),
 			     nid, K(node_page_state(pgdat, NR_FILE_THPS)),
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 7ea4679880c8..cfb107eaa3e6 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -131,7 +131,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "AnonHugePages:  ",
 		    global_node_page_state(NR_ANON_THPS));
 	show_val_kb(m, "ShmemHugePages: ",
-		    global_node_page_state(NR_SHMEM_THPS) * HPAGE_PMD_NR);
+		    global_node_page_state(NR_SHMEM_THPS));
 	show_val_kb(m, "ShmemPmdMapped: ",
 		    global_node_page_state(NR_SHMEM_PMDMAPPED) * HPAGE_PMD_NR);
 	show_val_kb(m, "FileHugePages:  ",
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 19e77f656410..3b45f39011ab 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -217,7 +217,8 @@ enum node_stat_item {
 static __always_inline bool vmstat_item_print_in_thp(enum node_stat_item item)
 {
 	return item == NR_ANON_THPS ||
-	       item == NR_FILE_THPS;
+	       item == NR_FILE_THPS ||
+	       item == NR_SHMEM_THPS;
 }
 
 /*
diff --git a/mm/filemap.c b/mm/filemap.c
index c5e6f5202476..1952e923cc2e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -205,7 +205,7 @@ static void unaccount_page_cache_page(struct address_space *mapping,
 	if (PageSwapBacked(page)) {
 		__mod_lruvec_page_state(page, NR_SHMEM, -nr);
 		if (PageTransHuge(page))
-			__dec_lruvec_page_state(page, NR_SHMEM_THPS);
+			__mod_lruvec_page_state(page, NR_SHMEM_THPS, -nr);
 	} else if (PageTransHuge(page)) {
 		__mod_lruvec_page_state(page, NR_FILE_THPS, -nr);
 		filemap_nr_thps_dec(mapping);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index cdf61596ef76..5aa045e3b5dc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2748,7 +2748,8 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 			int nr = thp_nr_pages(head);
 
 			if (PageSwapBacked(head))
-				__dec_lruvec_page_state(head, NR_SHMEM_THPS);
+				__mod_lruvec_page_state(head, NR_SHMEM_THPS,
+							-nr);
 			else
 				__mod_lruvec_page_state(head, NR_FILE_THPS,
 							-nr);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 23f93a3e2e69..8369d9620f6d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1869,7 +1869,7 @@ static void collapse_file(struct mm_struct *mm,
 	nr = thp_nr_pages(new_page);
 
 	if (is_shmem)
-		__inc_lruvec_page_state(new_page, NR_SHMEM_THPS);
+		__mod_lruvec_page_state(new_page, NR_SHMEM_THPS, nr);
 	else {
 		__mod_lruvec_page_state(new_page, NR_FILE_THPS, nr);
 		filemap_nr_thps_inc(mapping);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 04985c8c6a0a..a40797a27f87 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1515,7 +1515,7 @@ struct memory_stat {
 	unsigned int idx;
 };
 
-static struct memory_stat memory_stats[] = {
+static const struct memory_stat memory_stats[] = {
 	{ "anon", PAGE_SIZE, NR_ANON_MAPPED },
 	{ "file", PAGE_SIZE, NR_FILE_PAGES },
 	{ "kernel_stack", 1024, NR_KERNEL_STACK_KB },
@@ -1527,14 +1527,9 @@ static struct memory_stat memory_stats[] = {
 	{ "file_dirty", PAGE_SIZE, NR_FILE_DIRTY },
 	{ "file_writeback", PAGE_SIZE, NR_WRITEBACK },
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	/*
-	 * The ratio will be initialized in memory_stats_init(). Because
-	 * on some architectures, the macro of HPAGE_PMD_SIZE is not
-	 * constant(e.g. powerpc).
-	 */
 	{ "anon_thp", PAGE_SIZE, NR_ANON_THPS },
 	{ "file_thp", PAGE_SIZE, NR_FILE_THPS },
-	{ "shmem_thp", 0, NR_SHMEM_THPS },
+	{ "shmem_thp", PAGE_SIZE, NR_SHMEM_THPS },
 #endif
 	{ "inactive_anon", PAGE_SIZE, NR_INACTIVE_ANON },
 	{ "active_anon", PAGE_SIZE, NR_ACTIVE_ANON },
@@ -1559,23 +1554,6 @@ static struct memory_stat memory_stats[] = {
 	{ "workingset_nodereclaim", 1, WORKINGSET_NODERECLAIM },
 };
 
-static int __init memory_stats_init(void)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-		if (memory_stats[i].idx == NR_SHMEM_THPS)
-			memory_stats[i].ratio = HPAGE_PMD_SIZE;
-#endif
-		VM_BUG_ON(!memory_stats[i].ratio);
-		VM_BUG_ON(memory_stats[i].idx >= MEMCG_NR_STAT);
-	}
-
-	return 0;
-}
-pure_initcall(memory_stats_init);
-
 static char *memory_stat_format(struct mem_cgroup *memcg)
 {
 	struct seq_buf s;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1700f52b7869..720fb5a220b6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5577,7 +5577,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(node_page_state(pgdat, NR_WRITEBACK)),
 			K(node_page_state(pgdat, NR_SHMEM)),
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-			K(node_page_state(pgdat, NR_SHMEM_THPS) * HPAGE_PMD_NR),
+			K(node_page_state(pgdat, NR_SHMEM_THPS)),
 			K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)
 					* HPAGE_PMD_NR),
 			K(node_page_state(pgdat, NR_ANON_THPS)),
diff --git a/mm/shmem.c b/mm/shmem.c
index 53d84d2c9fe5..de261cfbf987 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -713,7 +713,7 @@ static int shmem_add_to_page_cache(struct page *page,
 		}
 		if (PageTransHuge(page)) {
 			count_vm_event(THP_FILE_ALLOC);
-			__inc_lruvec_page_state(page, NR_SHMEM_THPS);
+			__mod_lruvec_page_state(page, NR_SHMEM_THPS, nr);
 		}
 		mapping->nrpages += nr;
 		__mod_lruvec_page_state(page, NR_FILE_PAGES, nr);
-- 
2.11.0

