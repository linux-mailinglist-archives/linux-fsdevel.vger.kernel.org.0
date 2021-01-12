Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1982F2622
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 03:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbhALCNC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 21:13:02 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10708 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbhALCNC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 21:13:02 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DFDZb0Nhwzl3KW;
        Tue, 12 Jan 2021 10:11:03 +0800 (CST)
Received: from huawei.com (10.174.176.179) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Tue, 12 Jan 2021
 10:12:13 +0800
From:   wangbin <wangbin224@huawei.com>
To:     <adobriyan@gmail.com>, <akpm@linux-foundation.org>, <guro@fb.com>,
        <shakeelb@google.com>, <hannes@cmpxchg.org>, <will@kernel.org>,
        <wangbin224@huawei.com>, <feng.tang@intel.com>, <neilb@suse.de>,
        <kirill.shutemov@linux.intel.com>, <samitolvanen@google.com>,
        <rppt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <hushiyuan@huawei.com>
Subject: [PATCH] mm: thp: introduce NR_PARTIAL_THPS
Date:   Tue, 12 Jan 2021 10:12:08 +0800
Message-ID: <20210112021208.1875-1-wangbin224@huawei.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.176.179]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Bin Wang <wangbin224@huawei.com>

Currently we don't split transhuge pages on partial unmap. After using the
deferred_split_huge_page() to solve the memory overhead, we still have a
problem with memory count. We have no idea about how much partial unmap
memory there is because the partial unmap memory is covered in transhuge
pages until the pages are split.

Why should we know this? Just image that there is a process, which does the
following:
1)Mmap() 1GB memory and all the memory is transferred to transhuge pages by
kernel.
What happened: System free memory decreases 1GB. AnonHugePages increases
1GB.
2)Call madvise() don't need 1MB per transhuge page.
What happened: Rss of the process decreases 512MB. AnonHugePages decreases
1GB. System free memory doesn't increase.

It's confusing that the system free memory is less than expected. And this
is because that we just call split_huge_pmd() on partial unmap. I think we
shouldn't roll back to split_huge_page(), but we can add NR_PARTIAL_THPS
in node_stat_item to show the count of partial unmap pages.

We can follow the deferred_split_huge_page() codepath to record the
partial unmap pages. And reduce the count when transhuge pages are split
eventually.

Signed-off-by: Bin Wang <wangbin224@huawei.com>
---
 fs/proc/meminfo.c      | 2 ++
 include/linux/mmzone.h | 1 +
 mm/huge_memory.c       | 7 ++++++-
 mm/rmap.c              | 9 +++++++--
 mm/vmstat.c            | 1 +
 5 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index d6fc74619625..f6f02469dd9e 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -138,6 +138,8 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 		    global_node_page_state(NR_FILE_THPS) * HPAGE_PMD_NR);
 	show_val_kb(m, "FilePmdMapped:  ",
 		    global_node_page_state(NR_FILE_PMDMAPPED) * HPAGE_PMD_NR);
+	show_val_kb(m, "PartFreePages:  ",
+		    global_node_page_state(NR_PARTIAL_THPS));
 #endif
 
 #ifdef CONFIG_CMA
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b593316bff3d..cc417c9870ad 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -194,6 +194,7 @@ enum node_stat_item {
 	NR_FILE_THPS,
 	NR_FILE_PMDMAPPED,
 	NR_ANON_THPS,
+	NR_PARTIAL_THPS,	/* partial free pages of transhuge pages */
 	NR_VMSCAN_WRITE,
 	NR_VMSCAN_IMMEDIATE,	/* Prioritise for reclaim when writeback ends */
 	NR_DIRTIED,		/* page dirtyings since bootup */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9237976abe72..2f2856cf1ed0 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2788,6 +2788,8 @@ void free_transhuge_page(struct page *page)
 	if (!list_empty(page_deferred_list(page))) {
 		ds_queue->split_queue_len--;
 		list_del(page_deferred_list(page));
+		__mod_node_page_state(page_pgdat(page), NR_PARTIAL_THPS,
+				      -HPAGE_PMD_NR);
 	}
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
 	free_compound_page(page);
@@ -2880,8 +2882,11 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 		if (!trylock_page(page))
 			goto next;
 		/* split_huge_page() removes page from list on success */
-		if (!split_huge_page(page))
+		if (!split_huge_page(page)) {
 			split++;
+			__mod_node_page_state(page_pgdat(page),
+					      NR_PARTIAL_THPS, -HPAGE_PMD_NR);
+		}
 		unlock_page(page);
 next:
 		put_page(page);
diff --git a/mm/rmap.c b/mm/rmap.c
index 08c56aaf72eb..269edf41ccd7 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1309,8 +1309,11 @@ static void page_remove_anon_compound_rmap(struct page *page)
 		 * page of the compound page is unmapped, but at least one
 		 * small page is still mapped.
 		 */
-		if (nr && nr < thp_nr_pages(page))
+		if (nr && nr < thp_nr_pages(page)) {
+			__mod_node_page_state(page_pgdat(page),
+					      NR_PARTIAL_THPS, nr);
 			deferred_split_huge_page(page);
+		}
 	} else {
 		nr = thp_nr_pages(page);
 	}
@@ -1357,8 +1360,10 @@ void page_remove_rmap(struct page *page, bool compound)
 	if (unlikely(PageMlocked(page)))
 		clear_page_mlock(page);
 
-	if (PageTransCompound(page))
+	if (PageTransCompound(page)) {
+		__inc_node_page_state(page, NR_PARTIAL_THPS);
 		deferred_split_huge_page(compound_head(page));
+	}
 
 	/*
 	 * It would be tidy to reset the PageAnon mapping here,
diff --git a/mm/vmstat.c b/mm/vmstat.c
index f8942160fc95..93459dde0dcd 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1203,6 +1203,7 @@ const char * const vmstat_text[] = {
 	"nr_file_hugepages",
 	"nr_file_pmdmapped",
 	"nr_anon_transparent_hugepages",
+	"nr_partial_free_pages",
 	"nr_vmscan_write",
 	"nr_vmscan_immediate_reclaim",
 	"nr_dirtied",
-- 
2.23.0

