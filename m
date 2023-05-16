Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BCF70451E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 08:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjEPGVh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 02:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjEPGVe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 02:21:34 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2B82D66;
        Mon, 15 May 2023 23:21:33 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QL5bw68MrzTkk2;
        Tue, 16 May 2023 14:16:44 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 14:21:30 +0800
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
        <linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 03/13] mm: page_alloc: move set_zone_contiguous() into mm_init.c
Date:   Tue, 16 May 2023 14:38:11 +0800
Message-ID: <20230516063821.121844-4-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230516063821.121844-1-wangkefeng.wang@huawei.com>
References: <20230516063821.121844-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 include/linux/memory_hotplug.h |  3 ---
 mm/internal.h                  |  7 +++++++
 mm/mm_init.c                   | 22 ++++++++++++++++++++++
 mm/page_alloc.c                | 27 ---------------------------
 4 files changed, 29 insertions(+), 30 deletions(-)

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
index 644fa8b761f5..79324b7f2bc8 100644
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
index 15201887f8e0..0fd4ddfdfb2e 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2330,6 +2330,28 @@ void __init init_cma_reserved_pageblock(struct page *page)
 }
 #endif
 
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
index bc69a0474069..1b84b86fd33d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1532,33 +1532,6 @@ struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
 	return start_page;
 }
 
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

