Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46566FA044
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 08:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbjEHGzK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 02:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbjEHGyz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 02:54:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB8E49F7;
        Sun,  7 May 2023 23:54:53 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QFBmL1rJ3zLpGc;
        Mon,  8 May 2023 14:52:02 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 14:54:50 +0800
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
Subject: [PATCH 08/12] mm: page_alloc: split out DEBUG_PAGEALLOC
Date:   Mon, 8 May 2023 15:11:56 +0800
Message-ID: <20230508071200.123962-9-wangkefeng.wang@huawei.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move DEBUG_PAGEALLOC related functions into a single file to
reduce a bit of page_alloc.c.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/mm.h    | 76 ++++++++++++++++++++++++++++---------------
 mm/Makefile           |  1 +
 mm/debug_page_alloc.c | 59 +++++++++++++++++++++++++++++++++
 mm/page_alloc.c       | 69 ---------------------------------------
 4 files changed, 109 insertions(+), 96 deletions(-)
 create mode 100644 mm/debug_page_alloc.c

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e5d7b65075a0..fc8732a119cf 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3534,9 +3534,58 @@ static inline void debug_pagealloc_unmap_pages(struct page *page, int numpages)
 	if (debug_pagealloc_enabled_static())
 		__kernel_map_pages(page, numpages, 0);
 }
+
+extern unsigned int _debug_guardpage_minorder;
+DECLARE_STATIC_KEY_FALSE(_debug_guardpage_enabled);
+
+static inline unsigned int debug_guardpage_minorder(void)
+{
+	return _debug_guardpage_minorder;
+}
+
+static inline bool debug_guardpage_enabled(void)
+{
+	return static_branch_unlikely(&_debug_guardpage_enabled);
+}
+
+static inline bool page_is_guard(struct page *page)
+{
+	if (!debug_guardpage_enabled())
+		return false;
+
+	return PageGuard(page);
+}
+
+bool __set_page_guard(struct zone *zone, struct page *page, unsigned int order,
+		      int migratetype);
+static inline bool set_page_guard(struct zone *zone, struct page *page,
+				  unsigned int order, int migratetype)
+{
+	if (!debug_guardpage_enabled())
+		return false;
+	return __set_page_guard(zone, page, order, migratetype);
+}
+
+void __clear_page_guard(struct zone *zone, struct page *page, unsigned int order,
+			int migratetype);
+static inline void clear_page_guard(struct zone *zone, struct page *page,
+				    unsigned int order, int migratetype)
+{
+	if (!debug_guardpage_enabled())
+		return;
+	__clear_page_guard(zone, page, order, migratetype);
+}
+
 #else	/* CONFIG_DEBUG_PAGEALLOC */
 static inline void debug_pagealloc_map_pages(struct page *page, int numpages) {}
 static inline void debug_pagealloc_unmap_pages(struct page *page, int numpages) {}
+static inline unsigned int debug_guardpage_minorder(void) { return 0; }
+static inline bool debug_guardpage_enabled(void) { return false; }
+static inline bool page_is_guard(struct page *page) { return false; }
+static inline bool set_page_guard(struct zone *zone, struct page *page,
+			unsigned int order, int migratetype) { return false; }
+static inline void clear_page_guard(struct zone *zone, struct page *page,
+				unsigned int order, int migratetype) {}
 #endif	/* CONFIG_DEBUG_PAGEALLOC */
 
 #ifdef __HAVE_ARCH_GATE_AREA
@@ -3775,33 +3824,6 @@ static inline bool vma_is_special_huge(const struct vm_area_struct *vma)
 
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
 
-#ifdef CONFIG_DEBUG_PAGEALLOC
-extern unsigned int _debug_guardpage_minorder;
-DECLARE_STATIC_KEY_FALSE(_debug_guardpage_enabled);
-
-static inline unsigned int debug_guardpage_minorder(void)
-{
-	return _debug_guardpage_minorder;
-}
-
-static inline bool debug_guardpage_enabled(void)
-{
-	return static_branch_unlikely(&_debug_guardpage_enabled);
-}
-
-static inline bool page_is_guard(struct page *page)
-{
-	if (!debug_guardpage_enabled())
-		return false;
-
-	return PageGuard(page);
-}
-#else
-static inline unsigned int debug_guardpage_minorder(void) { return 0; }
-static inline bool debug_guardpage_enabled(void) { return false; }
-static inline bool page_is_guard(struct page *page) { return false; }
-#endif /* CONFIG_DEBUG_PAGEALLOC */
-
 #if MAX_NUMNODES > 1
 void __init setup_nr_node_ids(void);
 #else
diff --git a/mm/Makefile b/mm/Makefile
index 0eec4bc72d3f..678530a07326 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -124,6 +124,7 @@ obj-$(CONFIG_SECRETMEM) += secretmem.o
 obj-$(CONFIG_CMA_SYSFS) += cma_sysfs.o
 obj-$(CONFIG_USERFAULTFD) += userfaultfd.o
 obj-$(CONFIG_IDLE_PAGE_TRACKING) += page_idle.o
+obj-$(CONFIG_DEBUG_PAGEALLOC) += debug_page_alloc.o
 obj-$(CONFIG_DEBUG_PAGE_REF) += debug_page_ref.o
 obj-$(CONFIG_DAMON) += damon/
 obj-$(CONFIG_HARDENED_USERCOPY) += usercopy.o
diff --git a/mm/debug_page_alloc.c b/mm/debug_page_alloc.c
new file mode 100644
index 000000000000..f9d145730fd1
--- /dev/null
+++ b/mm/debug_page_alloc.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/mm.h>
+#include <linux/page-isolation.h>
+
+unsigned int _debug_guardpage_minorder;
+
+bool _debug_pagealloc_enabled_early __read_mostly
+			= IS_ENABLED(CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT);
+EXPORT_SYMBOL(_debug_pagealloc_enabled_early);
+DEFINE_STATIC_KEY_FALSE(_debug_pagealloc_enabled);
+EXPORT_SYMBOL(_debug_pagealloc_enabled);
+
+DEFINE_STATIC_KEY_FALSE(_debug_guardpage_enabled);
+
+static int __init early_debug_pagealloc(char *buf)
+{
+	return kstrtobool(buf, &_debug_pagealloc_enabled_early);
+}
+early_param("debug_pagealloc", early_debug_pagealloc);
+
+static int __init debug_guardpage_minorder_setup(char *buf)
+{
+	unsigned long res;
+
+	if (kstrtoul(buf, 10, &res) < 0 ||  res > MAX_ORDER / 2) {
+		pr_err("Bad debug_guardpage_minorder value\n");
+		return 0;
+	}
+	_debug_guardpage_minorder = res;
+	pr_info("Setting debug_guardpage_minorder to %lu\n", res);
+	return 0;
+}
+early_param("debug_guardpage_minorder", debug_guardpage_minorder_setup);
+
+bool __set_page_guard(struct zone *zone, struct page *page, unsigned int order,
+		      int migratetype)
+{
+	if (order >= debug_guardpage_minorder())
+		return false;
+
+	__SetPageGuard(page);
+	INIT_LIST_HEAD(&page->buddy_list);
+	set_page_private(page, order);
+	/* Guard pages are not available for any usage */
+	if (!is_migrate_isolate(migratetype))
+		__mod_zone_freepage_state(zone, -(1 << order), migratetype);
+
+	return true;
+}
+
+void __clear_page_guard(struct zone *zone, struct page *page, unsigned int order,
+		      int migratetype)
+{
+	__ClearPageGuard(page);
+
+	set_page_private(page, 0);
+	if (!is_migrate_isolate(migratetype))
+		__mod_zone_freepage_state(zone, (1 << order), migratetype);
+}
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fce47ccbcb3a..78d8a59f2afa 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -664,75 +664,6 @@ void destroy_large_folio(struct folio *folio)
 	compound_page_dtors[dtor](&folio->page);
 }
 
-#ifdef CONFIG_DEBUG_PAGEALLOC
-unsigned int _debug_guardpage_minorder;
-
-bool _debug_pagealloc_enabled_early __read_mostly
-			= IS_ENABLED(CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT);
-EXPORT_SYMBOL(_debug_pagealloc_enabled_early);
-DEFINE_STATIC_KEY_FALSE(_debug_pagealloc_enabled);
-EXPORT_SYMBOL(_debug_pagealloc_enabled);
-
-DEFINE_STATIC_KEY_FALSE(_debug_guardpage_enabled);
-
-static int __init early_debug_pagealloc(char *buf)
-{
-	return kstrtobool(buf, &_debug_pagealloc_enabled_early);
-}
-early_param("debug_pagealloc", early_debug_pagealloc);
-
-static int __init debug_guardpage_minorder_setup(char *buf)
-{
-	unsigned long res;
-
-	if (kstrtoul(buf, 10, &res) < 0 ||  res > MAX_ORDER / 2) {
-		pr_err("Bad debug_guardpage_minorder value\n");
-		return 0;
-	}
-	_debug_guardpage_minorder = res;
-	pr_info("Setting debug_guardpage_minorder to %lu\n", res);
-	return 0;
-}
-early_param("debug_guardpage_minorder", debug_guardpage_minorder_setup);
-
-static inline bool set_page_guard(struct zone *zone, struct page *page,
-				unsigned int order, int migratetype)
-{
-	if (!debug_guardpage_enabled())
-		return false;
-
-	if (order >= debug_guardpage_minorder())
-		return false;
-
-	__SetPageGuard(page);
-	INIT_LIST_HEAD(&page->buddy_list);
-	set_page_private(page, order);
-	/* Guard pages are not available for any usage */
-	if (!is_migrate_isolate(migratetype))
-		__mod_zone_freepage_state(zone, -(1 << order), migratetype);
-
-	return true;
-}
-
-static inline void clear_page_guard(struct zone *zone, struct page *page,
-				unsigned int order, int migratetype)
-{
-	if (!debug_guardpage_enabled())
-		return;
-
-	__ClearPageGuard(page);
-
-	set_page_private(page, 0);
-	if (!is_migrate_isolate(migratetype))
-		__mod_zone_freepage_state(zone, (1 << order), migratetype);
-}
-#else
-static inline bool set_page_guard(struct zone *zone, struct page *page,
-			unsigned int order, int migratetype) { return false; }
-static inline void clear_page_guard(struct zone *zone, struct page *page,
-				unsigned int order, int migratetype) {}
-#endif
-
 static inline void set_buddy_order(struct page *page, unsigned int order)
 {
 	set_page_private(page, order);
-- 
2.35.3

