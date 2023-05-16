Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621E1704535
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 08:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjEPGWD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 02:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjEPGVm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 02:21:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2542744AB;
        Mon, 15 May 2023 23:21:38 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QL5cY0STrzqSHD;
        Tue, 16 May 2023 14:17:17 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 14:21:35 +0800
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
Subject: [PATCH v2 10/13] mm: page_alloc: move pm_* function into power
Date:   Tue, 16 May 2023 14:38:18 +0800
Message-ID: <20230516063821.121844-11-wangkefeng.wang@huawei.com>
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

pm_restrict_gfp_mask()/pm_restore_gfp_mask() only used in power,
let's move them out of page_alloc.c.

Adding a general gfp_has_io_fs() function which return true if
gfp with both __GFP_IO and __GFP_FS flags, then use it inside of
pm_suspended_storage(), also the pm_suspended_storage() is moved
into suspend.h.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/gfp.h     | 15 ++++-----------
 include/linux/suspend.h |  6 ++++++
 kernel/power/main.c     | 27 +++++++++++++++++++++++++++
 kernel/power/power.h    |  5 +++++
 mm/page_alloc.c         | 38 --------------------------------------
 mm/swapfile.c           |  1 +
 6 files changed, 43 insertions(+), 49 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index ed8cb537c6a7..665f06675c83 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -338,19 +338,12 @@ extern gfp_t gfp_allowed_mask;
 /* Returns true if the gfp_mask allows use of ALLOC_NO_WATERMARK */
 bool gfp_pfmemalloc_allowed(gfp_t gfp_mask);
 
-extern void pm_restrict_gfp_mask(void);
-extern void pm_restore_gfp_mask(void);
-
-extern gfp_t vma_thp_gfp_mask(struct vm_area_struct *vma);
-
-#ifdef CONFIG_PM_SLEEP
-extern bool pm_suspended_storage(void);
-#else
-static inline bool pm_suspended_storage(void)
+static inline bool gfp_has_io_fs(gfp_t gfp)
 {
-	return false;
+	return (gfp & (__GFP_IO | __GFP_FS)) == (__GFP_IO | __GFP_FS);
 }
-#endif /* CONFIG_PM_SLEEP */
+
+extern gfp_t vma_thp_gfp_mask(struct vm_area_struct *vma);
 
 #ifdef CONFIG_CONTIG_ALLOC
 /* The below functions must be run on a range from a single zone. */
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 3950a7bf33ae..76923051c03d 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -502,6 +502,11 @@ extern void pm_report_max_hw_sleep(u64 t);
 extern bool events_check_enabled;
 extern suspend_state_t pm_suspend_target_state;
 
+static inline bool pm_suspended_storage(void)
+{
+	return !gfp_has_io_fs(gfp_allowed_mask);
+}
+
 extern bool pm_wakeup_pending(void);
 extern void pm_system_wakeup(void);
 extern void pm_system_cancel_wakeup(void);
@@ -535,6 +540,7 @@ static inline void ksys_sync_helper(void) {}
 
 #define pm_notifier(fn, pri)	do { (void)(fn); } while (0)
 
+static inline bool pm_suspended_storage(void) { return false; }
 static inline bool pm_wakeup_pending(void) { return false; }
 static inline void pm_system_wakeup(void) {}
 static inline void pm_wakeup_clear(bool reset) {}
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 3113ec2f1db4..34fc8359145b 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -21,6 +21,33 @@
 #include "power.h"
 
 #ifdef CONFIG_PM_SLEEP
+/*
+ * The following functions are used by the suspend/hibernate code to temporarily
+ * change gfp_allowed_mask in order to avoid using I/O during memory allocations
+ * while devices are suspended.  To avoid races with the suspend/hibernate code,
+ * they should always be called with system_transition_mutex held
+ * (gfp_allowed_mask also should only be modified with system_transition_mutex
+ * held, unless the suspend/hibernate code is guaranteed not to run in parallel
+ * with that modification).
+ */
+static gfp_t saved_gfp_mask;
+
+void pm_restore_gfp_mask(void)
+{
+	WARN_ON(!mutex_is_locked(&system_transition_mutex));
+	if (saved_gfp_mask) {
+		gfp_allowed_mask = saved_gfp_mask;
+		saved_gfp_mask = 0;
+	}
+}
+
+void pm_restrict_gfp_mask(void)
+{
+	WARN_ON(!mutex_is_locked(&system_transition_mutex));
+	WARN_ON(saved_gfp_mask);
+	saved_gfp_mask = gfp_allowed_mask;
+	gfp_allowed_mask &= ~(__GFP_IO | __GFP_FS);
+}
 
 unsigned int lock_system_sleep(void)
 {
diff --git a/kernel/power/power.h b/kernel/power/power.h
index b83c8d5e188d..ac14d1b463d1 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -216,6 +216,11 @@ static inline void suspend_test_finish(const char *label) {}
 /* kernel/power/main.c */
 extern int pm_notifier_call_chain_robust(unsigned long val_up, unsigned long val_down);
 extern int pm_notifier_call_chain(unsigned long val);
+void pm_restrict_gfp_mask(void);
+void pm_restore_gfp_mask(void);
+#else
+static inline void pm_restrict_gfp_mask(void) {}
+static inline void pm_restore_gfp_mask(void) {}
 #endif
 
 #ifdef CONFIG_HIGHMEM
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 71bfe72be045..2a95e095bb2a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -227,44 +227,6 @@ static inline void set_pcppage_migratetype(struct page *page, int migratetype)
 	page->index = migratetype;
 }
 
-#ifdef CONFIG_PM_SLEEP
-/*
- * The following functions are used by the suspend/hibernate code to temporarily
- * change gfp_allowed_mask in order to avoid using I/O during memory allocations
- * while devices are suspended.  To avoid races with the suspend/hibernate code,
- * they should always be called with system_transition_mutex held
- * (gfp_allowed_mask also should only be modified with system_transition_mutex
- * held, unless the suspend/hibernate code is guaranteed not to run in parallel
- * with that modification).
- */
-
-static gfp_t saved_gfp_mask;
-
-void pm_restore_gfp_mask(void)
-{
-	WARN_ON(!mutex_is_locked(&system_transition_mutex));
-	if (saved_gfp_mask) {
-		gfp_allowed_mask = saved_gfp_mask;
-		saved_gfp_mask = 0;
-	}
-}
-
-void pm_restrict_gfp_mask(void)
-{
-	WARN_ON(!mutex_is_locked(&system_transition_mutex));
-	WARN_ON(saved_gfp_mask);
-	saved_gfp_mask = gfp_allowed_mask;
-	gfp_allowed_mask &= ~(__GFP_IO | __GFP_FS);
-}
-
-bool pm_suspended_storage(void)
-{
-	if ((gfp_allowed_mask & (__GFP_IO | __GFP_FS)) == (__GFP_IO | __GFP_FS))
-		return false;
-	return true;
-}
-#endif /* CONFIG_PM_SLEEP */
-
 #ifdef CONFIG_HUGETLB_PAGE_SIZE_VARIABLE
 unsigned int pageblock_order __read_mostly;
 #endif
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 274bbf797480..c74259001d5e 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -41,6 +41,7 @@
 #include <linux/swap_slots.h>
 #include <linux/sort.h>
 #include <linux/completion.h>
+#include <linux/suspend.h>
 
 #include <asm/tlbflush.h>
 #include <linux/swapops.h>
-- 
2.35.3

