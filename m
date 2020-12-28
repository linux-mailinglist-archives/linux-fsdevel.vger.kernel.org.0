Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF642E68F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Dec 2020 17:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634547AbgL1Qng (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Dec 2020 11:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634485AbgL1QnG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Dec 2020 11:43:06 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17191C0617A4
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Dec 2020 08:42:08 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id g3so5883177plp.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Dec 2020 08:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YaFJtCpm29MU+uBDpb/G+3K7mESLV7dCmDUHShvFzbM=;
        b=ilWAlsjD+8hh0dk3tj0v9AZo6cgeL6iXnAxM+EEXIWS5B1uKAHPslM3/R603sirUE5
         T2i8AKcJUhuqvEZ3dgHknYt5eWX6Dd9J9QkVWEZKHMq2GcEs7/VSQpjfkQI9HwYgpguo
         0vEWfvbecx7p7U+QBsWsbosF5ZrmmW2ngbdvLkFknMrF80JIFhRUjxyqdGeG0QtLxw1+
         iTCHgaUeK6voXcFA5Jt49jYTDk465ZGJZrlQmrhh5QNEv5FGPjNdIJMtVnESJPU6SXnj
         f4B35n6CFBZHkfh+bqi7tlHu7Jj5Tr9NmYJmMEqEBIJSh9XRoVOHgM5lSc6hB1namcXQ
         BkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YaFJtCpm29MU+uBDpb/G+3K7mESLV7dCmDUHShvFzbM=;
        b=edTgCshb0S2HYBLhm+2HcyBHtHFC0r+tl4ZcMG39lKWJCkaLYGbompgFZPil1+mTrQ
         7+W6PW5eUbTzcPBvFLs14E8Lzbq/UwzTT/gVCZCp+ItqCQdXabt/DPNl+U/qzEkcdkLG
         9AXz1XRYiox1CyWz9Bts6voOKKxcSx4vIqizOvNpRNcAZKgmNrngA+VzgF8bNNYbLAnd
         gnOJgnte8FCYUzc+snZ8HqYycA3p/enz0sdQ/xx/v3kLaOEdvwocjLr96dJvRuDGs/dX
         rOEwgPpg3yWlLKNDpH+/YRp+NnhLxbjSM6jiezkzFty2hjZMnPiPxtwYJsdAwNmb0G0G
         XvkQ==
X-Gm-Message-State: AOAM5313SYDGpkGKs+zV7kFDpMr2v1W28aOANRmD0wbF4QOVba8hITXV
        qw40jMfM8/sPdrHHZptVDSPV/g==
X-Google-Smtp-Source: ABdhPJyD8+xRO4mhMZ5/qi174NTM/+fcuKddW2cANd4ByLUl5yipCqoAhtgIMm3wyo/66L+o4Bc3cg==
X-Received: by 2002:a17:90b:4396:: with SMTP id in22mr21375961pjb.63.1609173727565;
        Mon, 28 Dec 2020 08:42:07 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id r68sm36686306pfr.113.2020.12.28.08.42.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Dec 2020 08:42:07 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, shakeelb@google.com,
        guro@fb.com, samitolvanen@google.com, feng.tang@intel.com,
        neilb@suse.de, iamjoonsoo.kim@lge.com, rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 3/7] mm: memcontrol: convert NR_FILE_THPS account to pages
Date:   Tue, 29 Dec 2020 00:41:06 +0800
Message-Id: <20201228164110.2838-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201228164110.2838-1-songmuchun@bytedance.com>
References: <20201228164110.2838-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently we use struct per_cpu_nodestat to cache the vmstat
counters, which leads to inaccurate statistics especially THP
vmstat counters. In the systems with if hundreds of processors
it can be GBs of memory. For example, for a 96 CPUs system,
the threshold is the maximum number of 125. And the per cpu
counters can cache 23.4375 GB in total.

The THP page is already a form of batched addition (it will
add 512 worth of memory in one go) so skipping the batching
seems like sensible. Although every THP stats update overflows
the per-cpu counter, resorting to atomic global updates. But
it can make the statistics more accuracy for the THP vmstat
counters.

So we convert the NR_FILE_THPS account to pages. This patch
is consistent with 8f182270dfec ("mm/swap.c: flush lru pvecs
on compound page arrival"). Doing this also can make the unit
of vmstat counters more unified. Finally, the unit of the vmstat
counters are pages, kB and bytes. The B/KB suffix can tell us
that the unit is bytes or kB. The rest which is without suffix
are pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/node.c    | 3 +--
 fs/proc/meminfo.c      | 2 +-
 include/linux/mmzone.h | 3 ++-
 mm/filemap.c           | 2 +-
 mm/huge_memory.c       | 5 ++++-
 mm/khugepaged.c        | 4 +++-
 mm/memcontrol.c        | 5 ++---
 7 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 6da0c3508bc9..d5952f754911 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -466,8 +466,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 				    HPAGE_PMD_NR),
 			     nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED) *
 				    HPAGE_PMD_NR),
-			     nid, K(node_page_state(pgdat, NR_FILE_THPS) *
-				    HPAGE_PMD_NR),
+			     nid, K(node_page_state(pgdat, NR_FILE_THPS)),
 			     nid, K(node_page_state(pgdat, NR_FILE_PMDMAPPED) *
 				    HPAGE_PMD_NR)
 #endif
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index a635c8a84ddf..7ea4679880c8 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -135,7 +135,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "ShmemPmdMapped: ",
 		    global_node_page_state(NR_SHMEM_PMDMAPPED) * HPAGE_PMD_NR);
 	show_val_kb(m, "FileHugePages:  ",
-		    global_node_page_state(NR_FILE_THPS) * HPAGE_PMD_NR);
+		    global_node_page_state(NR_FILE_THPS));
 	show_val_kb(m, "FilePmdMapped:  ",
 		    global_node_page_state(NR_FILE_PMDMAPPED) * HPAGE_PMD_NR);
 #endif
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 67d50ef5dd20..b751a9898bb6 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -219,7 +219,8 @@ static __always_inline bool vmstat_item_print_in_thp(enum node_stat_item item)
 	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
 		return false;
 
-	return item == NR_ANON_THPS;
+	return item == NR_ANON_THPS ||
+	       item == NR_FILE_THPS;
 }
 
 /*
diff --git a/mm/filemap.c b/mm/filemap.c
index 78090ee08ac2..c5e6f5202476 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -207,7 +207,7 @@ static void unaccount_page_cache_page(struct address_space *mapping,
 		if (PageTransHuge(page))
 			__dec_lruvec_page_state(page, NR_SHMEM_THPS);
 	} else if (PageTransHuge(page)) {
-		__dec_lruvec_page_state(page, NR_FILE_THPS);
+		__mod_lruvec_page_state(page, NR_FILE_THPS, -nr);
 		filemap_nr_thps_dec(mapping);
 	}
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 66ec454120de..cdf61596ef76 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2745,10 +2745,13 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		}
 		spin_unlock(&ds_queue->split_queue_lock);
 		if (mapping) {
+			int nr = thp_nr_pages(head);
+
 			if (PageSwapBacked(head))
 				__dec_lruvec_page_state(head, NR_SHMEM_THPS);
 			else
-				__dec_lruvec_page_state(head, NR_FILE_THPS);
+				__mod_lruvec_page_state(head, NR_FILE_THPS,
+							-nr);
 		}
 
 		__split_huge_page(page, list, end);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 494d3cb0b58a..23f93a3e2e69 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1654,6 +1654,7 @@ static void collapse_file(struct mm_struct *mm,
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
 	int nr_none = 0, result = SCAN_SUCCEED;
 	bool is_shmem = shmem_file(file);
+	int nr;
 
 	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
 	VM_BUG_ON(start & (HPAGE_PMD_NR - 1));
@@ -1865,11 +1866,12 @@ static void collapse_file(struct mm_struct *mm,
 		put_page(page);
 		goto xa_unlocked;
 	}
+	nr = thp_nr_pages(new_page);
 
 	if (is_shmem)
 		__inc_lruvec_page_state(new_page, NR_SHMEM_THPS);
 	else {
-		__inc_lruvec_page_state(new_page, NR_FILE_THPS);
+		__mod_lruvec_page_state(new_page, NR_FILE_THPS, nr);
 		filemap_nr_thps_inc(mapping);
 	}
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b18e25a5cdf3..04985c8c6a0a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1533,7 +1533,7 @@ static struct memory_stat memory_stats[] = {
 	 * constant(e.g. powerpc).
 	 */
 	{ "anon_thp", PAGE_SIZE, NR_ANON_THPS },
-	{ "file_thp", 0, NR_FILE_THPS },
+	{ "file_thp", PAGE_SIZE, NR_FILE_THPS },
 	{ "shmem_thp", 0, NR_SHMEM_THPS },
 #endif
 	{ "inactive_anon", PAGE_SIZE, NR_INACTIVE_ANON },
@@ -1565,8 +1565,7 @@ static int __init memory_stats_init(void)
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-		if (memory_stats[i].idx == NR_FILE_THPS ||
-		    memory_stats[i].idx == NR_SHMEM_THPS)
+		if (memory_stats[i].idx == NR_SHMEM_THPS)
 			memory_stats[i].ratio = HPAGE_PMD_SIZE;
 #endif
 		VM_BUG_ON(!memory_stats[i].ratio);
-- 
2.11.0

