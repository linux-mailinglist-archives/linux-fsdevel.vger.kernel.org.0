Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D83770452A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 08:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjEPGV5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 02:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjEPGVj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 02:21:39 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FA3423A;
        Mon, 15 May 2023 23:21:37 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QL5h00Tw4zLmCd;
        Tue, 16 May 2023 14:20:16 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 14:21:34 +0800
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
Subject: [PATCH v2 09/13] mm: page_alloc: move mark_free_page() into snapshot.c
Date:   Tue, 16 May 2023 14:38:17 +0800
Message-ID: <20230516063821.121844-10-wangkefeng.wang@huawei.com>
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

The mark_free_page() is only used in kernel/power/snapshot.c,
move it out to reduce a bit of page_alloc.c

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/suspend.h |  3 ---
 kernel/power/snapshot.c | 52 ++++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c         | 55 -----------------------------------------
 3 files changed, 52 insertions(+), 58 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index d0d4598a7b3f..3950a7bf33ae 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -364,9 +364,6 @@ struct pbe {
 	struct pbe *next;
 };
 
-/* mm/page_alloc.c */
-extern void mark_free_pages(struct zone *zone);
-
 /**
  * struct platform_hibernation_ops - hibernation platform support
  *
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index cd8b7b35f1e8..45ef0bf81c85 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1228,6 +1228,58 @@ unsigned int snapshot_additional_pages(struct zone *zone)
 	return 2 * rtree;
 }
 
+/*
+ * Touch the watchdog for every WD_PAGE_COUNT pages.
+ */
+#define WD_PAGE_COUNT	(128*1024)
+
+static void mark_free_pages(struct zone *zone)
+{
+	unsigned long pfn, max_zone_pfn, page_count = WD_PAGE_COUNT;
+	unsigned long flags;
+	unsigned int order, t;
+	struct page *page;
+
+	if (zone_is_empty(zone))
+		return;
+
+	spin_lock_irqsave(&zone->lock, flags);
+
+	max_zone_pfn = zone_end_pfn(zone);
+	for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++)
+		if (pfn_valid(pfn)) {
+			page = pfn_to_page(pfn);
+
+			if (!--page_count) {
+				touch_nmi_watchdog();
+				page_count = WD_PAGE_COUNT;
+			}
+
+			if (page_zone(page) != zone)
+				continue;
+
+			if (!swsusp_page_is_forbidden(page))
+				swsusp_unset_page_free(page);
+		}
+
+	for_each_migratetype_order(order, t) {
+		list_for_each_entry(page,
+				&zone->free_area[order].free_list[t], buddy_list) {
+			unsigned long i;
+
+			pfn = page_to_pfn(page);
+			for (i = 0; i < (1UL << order); i++) {
+				if (!--page_count) {
+					touch_nmi_watchdog();
+					page_count = WD_PAGE_COUNT;
+				}
+				swsusp_set_page_free(pfn_to_page(pfn + i));
+			}
+		}
+	}
+	spin_unlock_irqrestore(&zone->lock, flags);
+}
+
 #ifdef CONFIG_HIGHMEM
 /**
  * count_free_highmem_pages - Compute the total number of free highmem pages.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index dc9820466377..71bfe72be045 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2401,61 +2401,6 @@ void drain_all_pages(struct zone *zone)
 	__drain_all_pages(zone, false);
 }
 
-#ifdef CONFIG_HIBERNATION
-
-/*
- * Touch the watchdog for every WD_PAGE_COUNT pages.
- */
-#define WD_PAGE_COUNT	(128*1024)
-
-void mark_free_pages(struct zone *zone)
-{
-	unsigned long pfn, max_zone_pfn, page_count = WD_PAGE_COUNT;
-	unsigned long flags;
-	unsigned int order, t;
-	struct page *page;
-
-	if (zone_is_empty(zone))
-		return;
-
-	spin_lock_irqsave(&zone->lock, flags);
-
-	max_zone_pfn = zone_end_pfn(zone);
-	for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++)
-		if (pfn_valid(pfn)) {
-			page = pfn_to_page(pfn);
-
-			if (!--page_count) {
-				touch_nmi_watchdog();
-				page_count = WD_PAGE_COUNT;
-			}
-
-			if (page_zone(page) != zone)
-				continue;
-
-			if (!swsusp_page_is_forbidden(page))
-				swsusp_unset_page_free(page);
-		}
-
-	for_each_migratetype_order(order, t) {
-		list_for_each_entry(page,
-				&zone->free_area[order].free_list[t], buddy_list) {
-			unsigned long i;
-
-			pfn = page_to_pfn(page);
-			for (i = 0; i < (1UL << order); i++) {
-				if (!--page_count) {
-					touch_nmi_watchdog();
-					page_count = WD_PAGE_COUNT;
-				}
-				swsusp_set_page_free(pfn_to_page(pfn + i));
-			}
-		}
-	}
-	spin_unlock_irqrestore(&zone->lock, flags);
-}
-#endif /* CONFIG_PM */
-
 static bool free_unref_page_prepare(struct page *page, unsigned long pfn,
 							unsigned int order)
 {
-- 
2.35.3

