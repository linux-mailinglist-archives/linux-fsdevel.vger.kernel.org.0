Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61582E68F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Dec 2020 17:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633745AbgL1Qnc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Dec 2020 11:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634494AbgL1QnJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Dec 2020 11:43:09 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5987AC0617BA
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Dec 2020 08:42:23 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id b5so6790193pjl.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Dec 2020 08:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xyLdCKdBPhmYM4XCknvffTIPOc83LRw/uRsfk6wBWlU=;
        b=wCqveK2P/pLx8LQk5UbiAXARTnu3IjXoRrGa7vkHKY8k8eECgUlb3nAtld9UdX3JLH
         fiqt9Fw4ys70tJRNWYKVssKUVN9qXnCuuV5fSiuEqA4MSpcCjsxHY/ZaoucYxBkmQ+2Z
         N8m6k9Ar6xpyNb9qMKdRzv9aAljvM+yA9+ax2hrR+pghnQ4hHMRP7k/A6WkX8d+lo8JH
         a1xedl1iqHi9nG6806AbuKFQcvOr8aARE4L/H+P8Ji+3Hxy4uEuL4ygCN4s0qtObgdqJ
         pRKInsp03V6Zj9J11KrdQcx972Zj3qQNqMkG8y7iZYQEGS/C9e+deEIFoDq4v3+rHN1m
         9qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xyLdCKdBPhmYM4XCknvffTIPOc83LRw/uRsfk6wBWlU=;
        b=lBgU7GsQCni4AlsoAvdjlQmQY7NbHSgnHMgQg6Q6i6Qsrr2zJvdgcGfwwMLuXAu15i
         8Hh0q8WJHOw/68vV/VggOXmghZVYHm4toN8HlUOPM492MxkLil2KUU/rqAEfl8dHgStX
         2Fx9q7aqakgROHXT6jSNBQ9/bNFF6PKJxSpqSarCAN3ly+umz8POXUinuaB1AVnsxUEl
         zED6zx2HVgWL2rzgZ1gfMDFtJz86ZIZzdyCebwKf8hPYRUelL50yEWLuw3K4XhEqwmfn
         5wLJ6lU1XCGEanqxDbOShPOeeH2Q+hbmIjXzYGJ77vqunYTMvUPSFpJhpoZhoVTp+/Id
         77SQ==
X-Gm-Message-State: AOAM5338F3T9yXpmccU+Qs+bLWhrVBhUap0tCi4RBB3dSk0q6iVP8sKq
        Fo747lcynvE9j/vKM2Sgxw9XIA==
X-Google-Smtp-Source: ABdhPJxra25aKR3WylK88qKH/WjpXK2oYA1dqP3VdNKGtSKHIbeg/koZV5lyDt8b8/FkgpvKJvYhQQ==
X-Received: by 2002:a17:902:6bca:b029:dc:34e1:26b1 with SMTP id m10-20020a1709026bcab02900dc34e126b1mr26493019plt.52.1609173742963;
        Mon, 28 Dec 2020 08:42:22 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id r68sm36686306pfr.113.2020.12.28.08.42.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Dec 2020 08:42:22 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, shakeelb@google.com,
        guro@fb.com, samitolvanen@google.com, feng.tang@intel.com,
        neilb@suse.de, iamjoonsoo.kim@lge.com, rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 5/7] mm: memcontrol: convert NR_SHMEM_PMDMAPPED account to pages
Date:   Tue, 29 Dec 2020 00:41:08 +0800
Message-Id: <20201228164110.2838-6-songmuchun@bytedance.com>
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
vmstat counters. In the systems with hundreds of processors
it can be GBs of memory. For example, for a 96 CPUs system,
the threshold is the maximum number of 125. And the per cpu
counters can cache 23.4375 GB in total.

The THP page is already a form of batched addition (it will
add 512 worth of memory in one go) so skipping the batching
seems like sensible. Although every THP stats update overflows
the per-cpu counter, resorting to atomic global updates. But
it can make the statistics more accuracy for the THP vmstat
counters.

So we convert the NR_SHMEM_PMDMAPPED account to pages. This
patch is consistent with 8f182270dfec ("mm/swap.c: flush lru
pvecs on compound page arrival"). Doing this also can make the
unit of vmstat counters more unified. Finally, the unit of the
vmstat counters are pages, kB and bytes. The B/KB suffix can
tell us that the unit is bytes or kB. The rest which is without
suffix are pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/node.c    |  3 +--
 fs/proc/meminfo.c      |  2 +-
 include/linux/mmzone.h |  3 ++-
 mm/page_alloc.c        |  3 +--
 mm/rmap.c              | 14 ++++++++++----
 5 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 6d5ac6ffb6e1..7a66aefe4e46 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -463,8 +463,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     ,
 			     nid, K(node_page_state(pgdat, NR_ANON_THPS)),
 			     nid, K(node_page_state(pgdat, NR_SHMEM_THPS)),
-			     nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED) *
-				    HPAGE_PMD_NR),
+			     nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)),
 			     nid, K(node_page_state(pgdat, NR_FILE_THPS)),
 			     nid, K(node_page_state(pgdat, NR_FILE_PMDMAPPED) *
 				    HPAGE_PMD_NR)
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index cfb107eaa3e6..c61f440570f9 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -133,7 +133,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "ShmemHugePages: ",
 		    global_node_page_state(NR_SHMEM_THPS));
 	show_val_kb(m, "ShmemPmdMapped: ",
-		    global_node_page_state(NR_SHMEM_PMDMAPPED) * HPAGE_PMD_NR);
+		    global_node_page_state(NR_SHMEM_PMDMAPPED));
 	show_val_kb(m, "FileHugePages:  ",
 		    global_node_page_state(NR_FILE_THPS));
 	show_val_kb(m, "FilePmdMapped:  ",
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 788837f40b38..7bdbfeeb5c8c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -221,7 +221,8 @@ static __always_inline bool vmstat_item_print_in_thp(enum node_stat_item item)
 
 	return item == NR_ANON_THPS ||
 	       item == NR_FILE_THPS ||
-	       item == NR_SHMEM_THPS;
+	       item == NR_SHMEM_THPS ||
+	       item == NR_SHMEM_PMDMAPPED;
 }
 
 /*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 720fb5a220b6..575fbfeea4b5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5578,8 +5578,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(node_page_state(pgdat, NR_SHMEM)),
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 			K(node_page_state(pgdat, NR_SHMEM_THPS)),
-			K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)
-					* HPAGE_PMD_NR),
+			K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)),
 			K(node_page_state(pgdat, NR_ANON_THPS)),
 #endif
 			K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
diff --git a/mm/rmap.c b/mm/rmap.c
index c4d5c63cfd29..1c1b576c0627 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1211,14 +1211,17 @@ void page_add_file_rmap(struct page *page, bool compound)
 	VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
 	lock_page_memcg(page);
 	if (compound && PageTransHuge(page)) {
-		for (i = 0, nr = 0; i < thp_nr_pages(page); i++) {
+		int nr_pages = thp_nr_pages(page);
+
+		for (i = 0, nr = 0; i < nr_pages; i++) {
 			if (atomic_inc_and_test(&page[i]._mapcount))
 				nr++;
 		}
 		if (!atomic_inc_and_test(compound_mapcount_ptr(page)))
 			goto out;
 		if (PageSwapBacked(page))
-			__inc_node_page_state(page, NR_SHMEM_PMDMAPPED);
+			__mod_lruvec_page_state(page, NR_SHMEM_PMDMAPPED,
+						nr_pages);
 		else
 			__inc_node_page_state(page, NR_FILE_PMDMAPPED);
 	} else {
@@ -1252,14 +1255,17 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 
 	/* page still mapped by someone else? */
 	if (compound && PageTransHuge(page)) {
-		for (i = 0, nr = 0; i < thp_nr_pages(page); i++) {
+		int nr_pages = thp_nr_pages(page);
+
+		for (i = 0, nr = 0; i < nr_pages; i++) {
 			if (atomic_add_negative(-1, &page[i]._mapcount))
 				nr++;
 		}
 		if (!atomic_add_negative(-1, compound_mapcount_ptr(page)))
 			return;
 		if (PageSwapBacked(page))
-			__dec_node_page_state(page, NR_SHMEM_PMDMAPPED);
+			__mod_lruvec_page_state(page, NR_SHMEM_PMDMAPPED,
+						-nr_pages);
 		else
 			__dec_node_page_state(page, NR_FILE_PMDMAPPED);
 	} else {
-- 
2.11.0

