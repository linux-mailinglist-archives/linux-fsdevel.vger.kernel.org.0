Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343AB331E43
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 06:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhCIFQu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 00:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhCIFQf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 00:16:35 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A16C06174A;
        Mon,  8 Mar 2021 21:16:35 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id t29so8570718pfg.11;
        Mon, 08 Mar 2021 21:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HORwLZBItmmfsgXHtTtePPTuVp6GLP2tVSIDV66WVpQ=;
        b=eYdb52HNI0m9k1dSzBzYPe/yrsDUeQf5/V4fbqkyN1tOZia9b3PlIFcT+8IAiPqp31
         0EnqPEurKW/f5Wz2ZEOljJE6VotAKSGo8eyKcHfa3tdLyuSwT3vBgX9CBiUtempawwfM
         Fkq47xN1Ln/etM3HJSMe7V1aa7YjE4kAiXWRxfVHKTNN50lKeOlXszTj/gZvDwCycLpK
         en4dtCuovMRi7yLuj8x7cXw0K4BYIXtErvrP0b5CQMXjZfMqCbWpqUe9YSxbVcoHMc4W
         FF3kymnBFMVj60tpEl4e+kuk3bKIEqZdJywogZHISlt1opQjO6Pxytc4nS+ZTBXAK5gP
         L1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=HORwLZBItmmfsgXHtTtePPTuVp6GLP2tVSIDV66WVpQ=;
        b=J40vmkKVL7d/gEjIvOrscHV8DgbytlUNfJUHyooPoDHMyBLOCygxwshGx/p9bhKd+H
         Z+kk3yjO8oJ4gMPr8j2iyNVoAbo3hvUmjoMLzW1eh4p8spPNKuoXGxxutLEdmTzIKL/v
         2Thqb8ojUCMO2jgpA0Uiu0N5SweidG8xyduI4z8RrVGMJzizLe0YkG1cyEklpGAQyYiO
         cYEi4l10HXQCAZkbJyby378xKNvJQH6qfX27FRPgC022B4TRV4iEkmwK98sSRGjTsgsQ
         2NUQEU2ZTrokdWoOi8z38yT/+9+vYPn38Pnys+fDZMuNpJpubQYO6Q7SnQ+FXOR/Zn9c
         2Xvg==
X-Gm-Message-State: AOAM531jDPLl/MLEsNcUf+miymixs304YBAf0F+PuXunJohb+BXYIW4d
        TNzcLPrgFOqNipgYRKngR750NHJwdQE=
X-Google-Smtp-Source: ABdhPJxd5K5oogovLzgD2OZCi1I8c5sIi7DN9DXg2E/knjxADowEPx0V6diq32qsKGpQ1QeBNfYM4A==
X-Received: by 2002:aa7:95b5:0:b029:1ef:272f:920c with SMTP id a21-20020aa795b50000b02901ef272f920cmr22146023pfk.21.1615266995451;
        Mon, 08 Mar 2021 21:16:35 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:4ccc:acdd:25da:14d1])
        by smtp.gmail.com with ESMTPSA id b14sm1166576pji.14.2021.03.08.21.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 21:16:34 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        joaodias@google.com, surenb@google.com, cgoldswo@codeaurora.org,
        willy@infradead.org, mhocko@suse.com, david@redhat.com,
        vbabka@suse.cz, linux-fsdevel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2 2/2] mm: fs: Invalidate BH LRU during page migration
Date:   Mon,  8 Mar 2021 21:16:28 -0800
Message-Id: <20210309051628.3105973-2-minchan@kernel.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210309051628.3105973-1-minchan@kernel.org>
References: <20210309051628.3105973-1-minchan@kernel.org>
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

Signed-off-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 fs/buffer.c                 | 12 ++++++++++--
 include/linux/buffer_head.h |  3 +++
 include/linux/swap.h        |  1 +
 mm/swap.c                   |  5 ++++-
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 96c7604f69b3..4492e9d4c9d3 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1301,6 +1301,14 @@ static void bh_lru_install(struct buffer_head *bh)
 	int i;
 
 	check_irqs_on();
+	/*
+	 * buffer_head in bh_lru could increase refcount of the page
+	 * until it will be invalidated. It causes page migraion failure.
+	 * Skip putting upcoming bh into bh_lru until migration is done.
+	 */
+	if (lru_cache_disabled())
+		return;
+
 	bh_lru_lock();
 
 	b = this_cpu_ptr(&bh_lrus);
@@ -1446,7 +1454,7 @@ EXPORT_SYMBOL(__bread_gfp);
  * This doesn't race because it runs in each cpu either in irq
  * or with preempt disabled.
  */
-static void invalidate_bh_lru(void *arg)
+void invalidate_bh_lru(void *arg)
 {
 	struct bh_lru *b = &get_cpu_var(bh_lrus);
 	int i;
@@ -1458,7 +1466,7 @@ static void invalidate_bh_lru(void *arg)
 	put_cpu_var(bh_lrus);
 }
 
-static bool has_bh_in_lru(int cpu, void *dummy)
+bool has_bh_in_lru(int cpu, void *dummy)
 {
 	struct bh_lru *b = per_cpu_ptr(&bh_lrus, cpu);
 	int i;
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 6b47f94378c5..3ae62f3f788e 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -194,6 +194,8 @@ void __breadahead_gfp(struct block_device *, sector_t block, unsigned int size,
 struct buffer_head *__bread_gfp(struct block_device *,
 				sector_t block, unsigned size, gfp_t gfp);
 void invalidate_bh_lrus(void);
+void invalidate_bh_lru(void *arg);
+bool has_bh_in_lru(int cpu, void *dummy);
 struct buffer_head *alloc_buffer_head(gfp_t gfp_flags);
 void free_buffer_head(struct buffer_head * bh);
 void unlock_buffer(struct buffer_head *bh);
@@ -406,6 +408,7 @@ static inline int inode_has_buffers(struct inode *inode) { return 0; }
 static inline void invalidate_inode_buffers(struct inode *inode) {}
 static inline int remove_inode_buffers(struct inode *inode) { return 1; }
 static inline int sync_mapping_buffers(struct address_space *mapping) { return 0; }
+static inline void invalidate_bh_lru(void *arg) {}
 #define buffer_heads_over_limit 0
 
 #endif /* CONFIG_BLOCK */
diff --git a/include/linux/swap.h b/include/linux/swap.h
index aaa6b9cc3f8a..5386cce1a26d 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -341,6 +341,7 @@ extern void lru_cache_add(struct page *);
 extern void mark_page_accessed(struct page *);
 extern void lru_cache_disable(void);
 extern void lru_cache_enable(void);
+extern bool lru_cache_disabled(void);
 extern void lru_add_drain(void);
 extern void lru_add_drain_cpu(int cpu);
 extern void lru_add_drain_cpu_zone(struct zone *zone);
diff --git a/mm/swap.c b/mm/swap.c
index fc8acccb882b..d599d6449154 100644
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
+	invalidate_bh_lru(NULL);
 }
 
 /**
@@ -821,7 +823,8 @@ void __lru_add_drain_all(bool force_all_cpus)
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
2.30.1.766.gb4fecdf3b7-goog

