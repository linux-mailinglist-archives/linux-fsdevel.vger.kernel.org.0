Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4903184F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 06:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhBKFgu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 00:36:50 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:58836 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229517AbhBKFgq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 00:36:46 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613021785; h=References: In-Reply-To: References:
 In-Reply-To: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=B8HmLNSsE6/W/CveTydOmPsy0Z5CABOvP7+e1kouMu4=; b=lyX8YpIwr/fqkGcDkjqjQuurT/5Cigvlow7AuQpoBbZGxhuMt4D6ysQOAYdmrJ9BXYmnUXaM
 6KPQwawDu2s6lL2LTTtN/ZYuV3gW50czyMGbYBOcRvxU3rtBdk9NY2OycMAZhY3BPnM/Yqni
 0yyrpSN7POjFyqw/KsaDPC/+DxU=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 6024c23cd5a7a3baaebb8f82 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Feb 2021 05:35:56
 GMT
Sender: cgoldswo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DF64FC433C6; Thu, 11 Feb 2021 05:35:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from cgoldswo-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cgoldswo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EE02CC433CA;
        Thu, 11 Feb 2021 05:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EE02CC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=cgoldswo@codeaurora.org
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>
Subject: [PATCH v2] [RFC] mm: fs: Invalidate BH LRU during page migration
Date:   Wed, 10 Feb 2021 21:35:40 -0800
Message-Id: <c083b0ab6e410e33ca880d639f90ef4f6f3b33ff.1613020616.git.cgoldswo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613020616.git.cgoldswo@codeaurora.org>
References: <cover.1613020616.git.cgoldswo@codeaurora.org>
In-Reply-To: <cover.1613020616.git.cgoldswo@codeaurora.org>
References: <cover.1613020616.git.cgoldswo@codeaurora.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pages containing buffer_heads that are in one of the per-CPU
buffer_head LRU caches will be pinned and thus cannot be migrated.
This can prevent CMA allocations from succeeding, which are often used
on platforms with co-processors (such as a DSP) that can only use
physically contiguous memory. It can also prevent memory
hot-unplugging from succeeding, which involves migrating at least
MIN_MEMORY_BLOCK_SIZE bytes of memory, which ranges from 8 MiB to 1
GiB based on the architecture in use.

Correspondingly, invalidate the BH LRU caches before a migration
starts and stop any buffer_head from being cached in the LRU caches,
until migration has finished.

Signed-off-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 fs/buffer.c                 | 54 +++++++++++++++++++++++++++++++++++++++++++--
 include/linux/buffer_head.h |  8 +++++++
 include/linux/migrate.h     |  2 ++
 mm/migrate.c                | 19 ++++++++++++++++
 mm/page_alloc.c             |  3 +++
 mm/swap.c                   |  7 +++++-
 6 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 96c7604..634e474 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1274,6 +1274,10 @@ struct bh_lru {
 
 static DEFINE_PER_CPU(struct bh_lru, bh_lrus) = {{ NULL }};
 
+/* These are used to control the BH LRU invalidation during page migration */
+static struct cpumask lru_needs_invalidation;
+static bool bh_lru_disabled = false;
+
 #ifdef CONFIG_SMP
 #define bh_lru_lock()	local_irq_disable()
 #define bh_lru_unlock()	local_irq_enable()
@@ -1292,7 +1296,9 @@ static inline void check_irqs_on(void)
 /*
  * Install a buffer_head into this cpu's LRU.  If not already in the LRU, it is
  * inserted at the front, and the buffer_head at the back if any is evicted.
- * Or, if already in the LRU it is moved to the front.
+ * Or, if already in the LRU it is moved to the front. Note that if LRU is
+ * disabled because of an ongoing page migration, we won't insert bh into the
+ * LRU.
  */
 static void bh_lru_install(struct buffer_head *bh)
 {
@@ -1303,6 +1309,9 @@ static void bh_lru_install(struct buffer_head *bh)
 	check_irqs_on();
 	bh_lru_lock();
 
+	if (bh_lru_disabled)
+		goto out;
+
 	b = this_cpu_ptr(&bh_lrus);
 	for (i = 0; i < BH_LRU_SIZE; i++) {
 		swap(evictee, b->bhs[i]);
@@ -1313,6 +1322,7 @@ static void bh_lru_install(struct buffer_head *bh)
 	}
 
 	get_bh(bh);
+out:
 	bh_lru_unlock();
 	brelse(evictee);
 }
@@ -1328,6 +1338,10 @@ lookup_bh_lru(struct block_device *bdev, sector_t block, unsigned size)
 
 	check_irqs_on();
 	bh_lru_lock();
+
+	if (bh_lru_disabled)
+		goto out;
+
 	for (i = 0; i < BH_LRU_SIZE; i++) {
 		struct buffer_head *bh = __this_cpu_read(bh_lrus.bhs[i]);
 
@@ -1346,6 +1360,7 @@ lookup_bh_lru(struct block_device *bdev, sector_t block, unsigned size)
 			break;
 		}
 	}
+out:
 	bh_lru_unlock();
 	return ret;
 }
@@ -1446,7 +1461,7 @@ EXPORT_SYMBOL(__bread_gfp);
  * This doesn't race because it runs in each cpu either in irq
  * or with preempt disabled.
  */
-static void invalidate_bh_lru(void *arg)
+void invalidate_bh_lru(void *arg)
 {
 	struct bh_lru *b = &get_cpu_var(bh_lrus);
 	int i;
@@ -1477,6 +1492,41 @@ void invalidate_bh_lrus(void)
 }
 EXPORT_SYMBOL_GPL(invalidate_bh_lrus);
 
+bool need_bh_lru_invalidation(int cpu)
+{
+	return cpumask_test_cpu(cpu, &lru_needs_invalidation);
+}
+
+void bh_lru_disable(void)
+{
+	int cpu;
+
+	bh_lru_disabled = true;
+
+	/*
+	 * This barrier ensures that invocations of bh_lru_install()
+	 * after this barrier see that bh_lru_disabled == true (until
+	 * bh_lru_enable() is eventually called)..
+	 */
+	smp_mb();
+
+	/*
+	 * It's alright if someone comes along and hot-plugs a new CPU,
+	 * since we have that bh_lru_dsiabled == true.  The hot-remove
+	 * case is handled in buffer_exit_cpu_dead().
+	 */
+	for_each_online_cpu(cpu) {
+		if (has_bh_in_lru(cpu, NULL))
+			cpumask_set_cpu(cpu, &lru_needs_invalidation);
+	}
+}
+
+void bh_lru_enable(void)
+{
+	bh_lru_disabled = false;
+	cpumask_clear(&lru_needs_invalidation);
+}
+
 void set_bh_page(struct buffer_head *bh,
 		struct page *page, unsigned long offset)
 {
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 6b47f94..78eb5ee 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -193,7 +193,11 @@ void __breadahead_gfp(struct block_device *, sector_t block, unsigned int size,
 		  gfp_t gfp);
 struct buffer_head *__bread_gfp(struct block_device *,
 				sector_t block, unsigned size, gfp_t gfp);
+void invalidate_bh_lru(void *arg);
 void invalidate_bh_lrus(void);
+bool need_bh_lru_invalidation(int cpu);
+void bh_lru_disable(void);
+void bh_lru_enable(void);
 struct buffer_head *alloc_buffer_head(gfp_t gfp_flags);
 void free_buffer_head(struct buffer_head * bh);
 void unlock_buffer(struct buffer_head *bh);
@@ -401,6 +405,10 @@ extern int __set_page_dirty_buffers(struct page *page);
 #else /* CONFIG_BLOCK */
 
 static inline void buffer_init(void) {}
+static inline void invalidate_bh_lru(void) {}
+static inline bool need_bh_lru_invalidation(int cpu) { return false; }
+static inline void bh_lru_disable(void) {}
+static inline void bh_lru_enable(void) {}
 static inline int try_to_free_buffers(struct page *page) { return 1; }
 static inline int inode_has_buffers(struct inode *inode) { return 0; }
 static inline void invalidate_inode_buffers(struct inode *inode) {}
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 3a38963..9e4a2dc 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -46,6 +46,7 @@ extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
 extern void putback_movable_page(struct page *page);
 
 extern void migrate_prep(void);
+extern void migrate_finish(void);
 extern void migrate_prep_local(void);
 extern void migrate_page_states(struct page *newpage, struct page *page);
 extern void migrate_page_copy(struct page *newpage, struct page *page);
@@ -67,6 +68,7 @@ static inline int isolate_movable_page(struct page *page, isolate_mode_t mode)
 	{ return -EBUSY; }
 
 static inline int migrate_prep(void) { return -ENOSYS; }
+static inline int migrate_finish(void) { return -ENOSYS; }
 static inline int migrate_prep_local(void) { return -ENOSYS; }
 
 static inline void migrate_page_states(struct page *newpage, struct page *page)
diff --git a/mm/migrate.c b/mm/migrate.c
index a69da8a..a8928ee7 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -65,6 +65,16 @@
 void migrate_prep(void)
 {
 	/*
+	 * If a page has buffer_heads contained in one of the per-cpu
+	 * BH LRU caches, that page can't be migrated.  Accordingly, we
+	 * call bh_lru_disable() to prevent further buffer_heads from
+	 * being cached, before we invalidate the LRUs in
+	 * lru_add_drain_all().  The LRUs are re-enabled in
+	 * migrate_finish().
+	 */
+	bh_lru_disable();
+
+	/*
 	 * Clear the LRU lists so pages can be isolated.
 	 * Note that pages may be moved off the LRU after we have
 	 * drained them. Those pages will fail to migrate like other
@@ -73,6 +83,15 @@ void migrate_prep(void)
 	lru_add_drain_all();
 }
 
+void migrate_finish(void)
+{
+	/*
+	 * Renable the per-cpu BH LRU caches, after having disabled them
+	 * in migrate_prep().
+	 */
+	bh_lru_enable();
+}
+
 /* Do the necessary work of migrate_prep but not if it involves other CPUs */
 void migrate_prep_local(void)
 {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6446778..e4cb959 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8493,6 +8493,9 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 		ret = migrate_pages(&cc->migratepages, alloc_migration_target,
 				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
 	}
+
+	migrate_finish();
+
 	if (ret < 0) {
 		putback_movable_pages(&cc->migratepages);
 		return ret;
diff --git a/mm/swap.c b/mm/swap.c
index 31b844d..c733c95 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -36,6 +36,7 @@
 #include <linux/hugetlb.h>
 #include <linux/page_idle.h>
 #include <linux/local_lock.h>
+#include <linux/buffer_head.h>
 
 #include "internal.h"
 
@@ -628,6 +629,9 @@ void lru_add_drain_cpu(int cpu)
 	if (pagevec_count(pvec))
 		pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
 
+	if (need_bh_lru_invalidation(cpu))
+		invalidate_bh_lru(NULL);
+
 	activate_page_drain(cpu);
 }
 
@@ -815,7 +819,8 @@ void lru_add_drain_all(void)
 		    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate_file, cpu)) ||
 		    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate, cpu)) ||
 		    pagevec_count(&per_cpu(lru_pvecs.lru_lazyfree, cpu)) ||
-		    need_activate_page_drain(cpu)) {
+		    need_activate_page_drain(cpu) ||
+		    need_bh_lru_invalidation(cpu)) {
 			INIT_WORK(work, lru_add_drain_per_cpu);
 			queue_work_on(cpu, mm_percpu_wq, work);
 			__cpumask_set_cpu(cpu, &has_work);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

