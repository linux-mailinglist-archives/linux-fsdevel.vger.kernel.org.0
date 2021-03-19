Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3B23423B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 18:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhCSRwP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 13:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhCSRvy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:51:54 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA7BC06174A;
        Fri, 19 Mar 2021 10:51:54 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id g15so6419743pfq.3;
        Fri, 19 Mar 2021 10:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q5cs7BR95iNbZ6WMCZed7NnR/Mld0Eh7IFrfWwaLHq8=;
        b=ZqvQWkv7qc3+G9XEcpiufuNDs1mOJJbP8ItCeiZtB0Yxsa1x1XSzxYvaB4NFwwHQHt
         0N2GrBu3calLG4NLoPppXrXp7mYrsdzwYiiFfvoFvKLlPSQboreA2U/5GzE4KcCaccLT
         c83g+eos6DixdQ6+x5Eb18c0FyHN9JW98mw8gE7KrPkJqpw+d83dLtww2Wvcg4fMEM0I
         B2wrxY/SM/vzcG9n1cZ3RVdww/y8WsY51LahgLt46zYdWpETOGH8LRWlreb6+kau+KGQ
         1Lf6amVkcHQZ8prVpbVVO34FS9Cljo/O83XbI/VBsmUs0pzMCk9vDCBHPdYQXFOh7xuB
         E16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=q5cs7BR95iNbZ6WMCZed7NnR/Mld0Eh7IFrfWwaLHq8=;
        b=GonHEmPwlgX9c15aJxCGwipEgMqjjVDsw9RFOG0UmnFiDNKXpUdMXSSqxtZH2EumJS
         lJQYXb9GcWkCgfU0F4a12khgnh1RNJQGfJXcURkbtIPYNs/X4bfWaS7tjtDocLFesbUQ
         5QxEZS1g/Ydq0b4AD1ZjDBzc+qmSxRHnClhVudFx5JCKcUAayG5F1oa5hmjqIgb1YXPx
         yA2norVdaOw5I73ke2n3dt8T9X77sGlcmB7Uq6SFd5Ofxuu5WjGpJaGisvDDaYiF+xag
         S/UH67iDvvOhroUnycMzsp2700qRiAPMcehi4llvOuoFaC2HZIlH9Cc5j02B7DKxbDbc
         5SRw==
X-Gm-Message-State: AOAM53146gVe6GgiXd8YmDs/cfSkK8rH3LtNXOdT8dc9DctB67d+IwUh
        7UTzk9hSKOMU5X7gGPDrHhU=
X-Google-Smtp-Source: ABdhPJxA3BmuVyAsv9cP2aECptIsxggqkZ3YsQbA0KajbfUtZGT9Iw5MS6vCF49mYU3xhCxczVdHOQ==
X-Received: by 2002:a62:1713:0:b029:1f1:56e2:8ec6 with SMTP id 19-20020a6217130000b02901f156e28ec6mr10095937pfx.56.1616176314032;
        Fri, 19 Mar 2021 10:51:54 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:913d:5573:c956:f033])
        by smtp.gmail.com with ESMTPSA id w8sm5498287pgk.46.2021.03.19.10.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 10:51:53 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        joaodias@google.com, surenb@google.com, cgoldswo@codeaurora.org,
        willy@infradead.org, mhocko@suse.com, david@redhat.com,
        vbabka@suse.cz, linux-fsdevel@vger.kernel.org,
        oliver.sang@intel.com, Minchan Kim <minchan@kernel.org>
Subject: [PATCH v4 3/3] mm: fs: Invalidate BH LRU during page migration
Date:   Fri, 19 Mar 2021 10:51:27 -0700
Message-Id: <20210319175127.886124-3-minchan@kernel.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210319175127.886124-1-minchan@kernel.org>
References: <20210319175127.886124-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Tested-by: Oliver Sang <oliver.sang@intel.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 fs/buffer.c                 | 36 ++++++++++++++++++++++++++++++------
 include/linux/buffer_head.h |  4 ++++
 mm/swap.c                   |  5 ++++-
 3 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 0cb7ffd4977c..e9872d0dcbf1 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1264,6 +1264,15 @@ static void bh_lru_install(struct buffer_head *bh)
 	int i;
 
 	check_irqs_on();
+	/*
+	 * the refcount of buffer_head in bh_lru prevents dropping the
+	 * attached page(i.e., try_to_free_buffers) so it could cause
+	 * failing page migration.
+	 * Skip putting upcoming bh into bh_lru until migration is done.
+	 */
+	if (lru_cache_disabled())
+		return;
+
 	bh_lru_lock();
 
 	b = this_cpu_ptr(&bh_lrus);
@@ -1404,6 +1413,15 @@ __bread_gfp(struct block_device *bdev, sector_t block,
 }
 EXPORT_SYMBOL(__bread_gfp);
 
+static void __invalidate_bh_lrus(struct bh_lru *b)
+{
+	int i;
+
+	for (i = 0; i < BH_LRU_SIZE; i++) {
+		brelse(b->bhs[i]);
+		b->bhs[i] = NULL;
+	}
+}
 /*
  * invalidate_bh_lrus() is called rarely - but not only at unmount.
  * This doesn't race because it runs in each cpu either in irq
@@ -1412,16 +1430,12 @@ EXPORT_SYMBOL(__bread_gfp);
 static void invalidate_bh_lru(void *arg)
 {
 	struct bh_lru *b = &get_cpu_var(bh_lrus);
-	int i;
 
-	for (i = 0; i < BH_LRU_SIZE; i++) {
-		brelse(b->bhs[i]);
-		b->bhs[i] = NULL;
-	}
+	__invalidate_bh_lrus(b);
 	put_cpu_var(bh_lrus);
 }
 
-static bool has_bh_in_lru(int cpu, void *dummy)
+bool has_bh_in_lru(int cpu, void *dummy)
 {
 	struct bh_lru *b = per_cpu_ptr(&bh_lrus, cpu);
 	int i;
@@ -1440,6 +1454,16 @@ void invalidate_bh_lrus(void)
 }
 EXPORT_SYMBOL_GPL(invalidate_bh_lrus);
 
+void invalidate_bh_lrus_cpu(int cpu)
+{
+	struct bh_lru *b;
+
+	bh_lru_lock();
+	b = per_cpu_ptr(&bh_lrus, cpu);
+	__invalidate_bh_lrus(b);
+	bh_lru_unlock();
+}
+
 void set_bh_page(struct buffer_head *bh,
 		struct page *page, unsigned long offset)
 {
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 6b47f94378c5..e7e99da31349 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -194,6 +194,8 @@ void __breadahead_gfp(struct block_device *, sector_t block, unsigned int size,
 struct buffer_head *__bread_gfp(struct block_device *,
 				sector_t block, unsigned size, gfp_t gfp);
 void invalidate_bh_lrus(void);
+void invalidate_bh_lrus_cpu(int cpu);
+bool has_bh_in_lru(int cpu, void *dummy);
 struct buffer_head *alloc_buffer_head(gfp_t gfp_flags);
 void free_buffer_head(struct buffer_head * bh);
 void unlock_buffer(struct buffer_head *bh);
@@ -406,6 +408,8 @@ static inline int inode_has_buffers(struct inode *inode) { return 0; }
 static inline void invalidate_inode_buffers(struct inode *inode) {}
 static inline int remove_inode_buffers(struct inode *inode) { return 1; }
 static inline int sync_mapping_buffers(struct address_space *mapping) { return 0; }
+static inline void invalidate_bh_lrus_cpu(int cpu) {}
+static inline bool has_bh_in_lru(int cpu, void *dummy) { return 0; }
 #define buffer_heads_over_limit 0
 
 #endif /* CONFIG_BLOCK */
diff --git a/mm/swap.c b/mm/swap.c
index c94f55e7b649..a75a8265302b 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -36,6 +36,7 @@
 #include <linux/hugetlb.h>
 #include <linux/page_idle.h>
 #include <linux/local_lock.h>
+#include <linux/buffer_head.h>
 
 #include "internal.h"
 
@@ -641,6 +642,7 @@ void lru_add_drain_cpu(int cpu)
 		pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
 
 	activate_page_drain(cpu);
+	invalidate_bh_lrus_cpu(cpu);
 }
 
 /**
@@ -828,7 +830,8 @@ inline void __lru_add_drain_all(bool force_all_cpus)
 		    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate_file, cpu)) ||
 		    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate, cpu)) ||
 		    pagevec_count(&per_cpu(lru_pvecs.lru_lazyfree, cpu)) ||
-		    need_activate_page_drain(cpu)) {
+		    need_activate_page_drain(cpu) ||
+		    has_bh_in_lru(cpu, NULL)) {
 			INIT_WORK(work, lru_add_drain_per_cpu);
 			queue_work_on(cpu, mm_percpu_wq, work);
 			__cpumask_set_cpu(cpu, &has_work);
-- 
2.31.0.rc2.261.g7f71774620-goog

