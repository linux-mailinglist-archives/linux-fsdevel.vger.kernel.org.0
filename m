Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2639D6FA037
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 08:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjEHGy5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 02:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjEHGyv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 02:54:51 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17AEA5FC;
        Sun,  7 May 2023 23:54:49 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QFBkl6pXLz18LDr;
        Mon,  8 May 2023 14:50:39 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 14:54:47 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>
CC:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 03/12] mm: page_alloc: move set_zone_contiguous() into mm_init.c
Date:   Mon, 8 May 2023 15:11:51 +0800
Message-ID: <20230508071200.123962-4-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230508071200.123962-1-wangkefeng.wang@huawei.com>
References: <20230508071200.123962-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

set_zone_contiguous() is only used in mm init/hotplug, and
clear_zone_contiguous() only used in hotplug, move them from
page_alloc.c to the more appropriate file.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/memory_hotplug.h |  3 --
 mm/internal.h                  |  7 +++
 mm/mm_init.c                   | 74 +++++++++++++++++++++++++++++++
 mm/page_alloc.c                | 79 ----------------------------------
 4 files changed, 81 insertions(+), 82 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 9fcbf5706595..04bc286eed42 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -326,9 +326,6 @@ static inline int remove_memory(u64 start, u64 size)
 static inline void __remove_memory(u64 start, u64 size) {}
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
-extern void set_zone_contiguous(struct zone *zone);
-extern void clear_zone_contiguous(struct zone *zone);
-
 #ifdef CONFIG_MEMORY_HOTPLUG
 extern void __ref free_area_init_core_hotplug(struct pglist_data *pgdat);
 extern int __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
diff --git a/mm/internal.h b/mm/internal.h
index e28442c0858a..9482862b28cc 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -371,6 +371,13 @@ static inline struct page *pageblock_pfn_to_page(unsigned long start_pfn,
 	return __pageblock_pfn_to_page(start_pfn, end_pfn, zone);
 }
 
+void set_zone_contiguous(struct zone *zone);
+
+static inline void clear_zone_contiguous(struct zone *zone)
+{
+	zone->contiguous = false;
+}
+
 extern int __isolate_free_page(struct page *page, unsigned int order);
 extern void __putback_isolated_page(struct page *page, unsigned int order,
 				    int mt);
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 15201887f8e0..1f30b9e16577 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2330,6 +2330,80 @@ void __init init_cma_reserved_pageblock(struct page *page)
 }
 #endif
 
+/*
+ * Check that the whole (or subset of) a pageblock given by the interval of
+ * [start_pfn, end_pfn) is valid and within the same zone, before scanning it
+ * with the migration of free compaction scanner.
+ *
+ * Return struct page pointer of start_pfn, or NULL if checks were not passed.
+ *
+ * It's possible on some configurations to have a setup like node0 node1 node0
+ * i.e. it's possible that all pages within a zones range of pages do not
+ * belong to a single zone. We assume that a border between node0 and node1
+ * can occur within a single pageblock, but not a node0 node1 node0
+ * interleaving within a single pageblock. It is therefore sufficient to check
+ * the first and last page of a pageblock and avoid checking each individual
+ * page in a pageblock.
+ *
+ * Note: the function may return non-NULL struct page even for a page block
+ * which contains a memory hole (i.e. there is no physical memory for a subset
+ * of the pfn range). For example, if the pageblock order is MAX_ORDER, which
+ * will fall into 2 sub-sections, and the end pfn of the pageblock may be hole
+ * even though the start pfn is online and valid. This should be safe most of
+ * the time because struct pages are still initialized via init_unavailable_range()
+ * and pfn walkers shouldn't touch any physical memory range for which they do
+ * not recognize any specific metadata in struct pages.
+ */
+struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
+				     unsigned long end_pfn, struct zone *zone)
+{
+	struct page *start_page;
+	struct page *end_page;
+
+	/* end_pfn is one past the range we are checking */
+	end_pfn--;
+
+	if (!pfn_valid(end_pfn))
+		return NULL;
+
+	start_page = pfn_to_online_page(start_pfn);
+	if (!start_page)
+		return NULL;
+
+	if (page_zone(start_page) != zone)
+		return NULL;
+
+	end_page = pfn_to_page(end_pfn);
+
+	/* This gives a shorter code than deriving page_zone(end_page) */
+	if (page_zone_id(start_page) != page_zone_id(end_page))
+		return NULL;
+
+	return start_page;
+}
+
+void set_zone_contiguous(struct zone *zone)
+{
+	unsigned long block_start_pfn = zone->zone_start_pfn;
+	unsigned long block_end_pfn;
+
+	block_end_pfn = pageblock_end_pfn(block_start_pfn);
+	for (; block_start_pfn < zone_end_pfn(zone);
+			block_start_pfn = block_end_pfn,
+			 block_end_pfn += pageblock_nr_pages) {
+
+		block_end_pfn = min(block_end_pfn, zone_end_pfn(zone));
+
+		if (!__pageblock_pfn_to_page(block_start_pfn,
+					     block_end_pfn, zone))
+			return;
+		cond_resched();
+	}
+
+	/* We confirm that there is no hole */
+	zone->contiguous = true;
+}
+
 void __init page_alloc_init_late(void)
 {
 	struct zone *zone;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4f094ba7c8fb..fe7c1ee5becd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1480,85 +1480,6 @@ void __free_pages_core(struct page *page, unsigned int order)
 	__free_pages_ok(page, order, FPI_TO_TAIL);
 }
 
-/*
- * Check that the whole (or subset of) a pageblock given by the interval of
- * [start_pfn, end_pfn) is valid and within the same zone, before scanning it
- * with the migration of free compaction scanner.
- *
- * Return struct page pointer of start_pfn, or NULL if checks were not passed.
- *
- * It's possible on some configurations to have a setup like node0 node1 node0
- * i.e. it's possible that all pages within a zones range of pages do not
- * belong to a single zone. We assume that a border between node0 and node1
- * can occur within a single pageblock, but not a node0 node1 node0
- * interleaving within a single pageblock. It is therefore sufficient to check
- * the first and last page of a pageblock and avoid checking each individual
- * page in a pageblock.
- *
- * Note: the function may return non-NULL struct page even for a page block
- * which contains a memory hole (i.e. there is no physical memory for a subset
- * of the pfn range). For example, if the pageblock order is MAX_ORDER, which
- * will fall into 2 sub-sections, and the end pfn of the pageblock may be hole
- * even though the start pfn is online and valid. This should be safe most of
- * the time because struct pages are still initialized via init_unavailable_range()
- * and pfn walkers shouldn't touch any physical memory range for which they do
- * not recognize any specific metadata in struct pages.
- */
-struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
-				     unsigned long end_pfn, struct zone *zone)
-{
-	struct page *start_page;
-	struct page *end_page;
-
-	/* end_pfn is one past the range we are checking */
-	end_pfn--;
-
-	if (!pfn_valid(end_pfn))
-		return NULL;
-
-	start_page = pfn_to_online_page(start_pfn);
-	if (!start_page)
-		return NULL;
-
-	if (page_zone(start_page) != zone)
-		return NULL;
-
-	end_page = pfn_to_page(end_pfn);
-
-	/* This gives a shorter code than deriving page_zone(end_page) */
-	if (page_zone_id(start_page) != page_zone_id(end_page))
-		return NULL;
-
-	return start_page;
-}
-
-void set_zone_contiguous(struct zone *zone)
-{
-	unsigned long block_start_pfn = zone->zone_start_pfn;
-	unsigned long block_end_pfn;
-
-	block_end_pfn = pageblock_end_pfn(block_start_pfn);
-	for (; block_start_pfn < zone_end_pfn(zone);
-			block_start_pfn = block_end_pfn,
-			 block_end_pfn += pageblock_nr_pages) {
-
-		block_end_pfn = min(block_end_pfn, zone_end_pfn(zone));
-
-		if (!__pageblock_pfn_to_page(block_start_pfn,
-					     block_end_pfn, zone))
-			return;
-		cond_resched();
-	}
-
-	/* We confirm that there is no hole */
-	zone->contiguous = true;
-}
-
-void clear_zone_contiguous(struct zone *zone)
-{
-	zone->contiguous = false;
-}
-
 /*
  * The order of subdivision here is critical for the IO subsystem.
  * Please do not alter this order without good reasons and regression
-- 
2.35.3

