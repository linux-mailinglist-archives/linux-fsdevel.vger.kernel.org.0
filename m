Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229F732B4DE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Mar 2021 06:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450140AbhCCFai (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 00:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383538AbhCBVOx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 16:14:53 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C226AC06178A;
        Tue,  2 Mar 2021 13:09:57 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id r5so14610978pfh.13;
        Tue, 02 Mar 2021 13:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jLiR8SYAwchy/DlkrlFgQINPVuwrI0Zg692gmaFjw9k=;
        b=IFUIGqHBTNScTiFWkuY1Ib52OJbHgxUGyzy4qh3Hq9QqhdV+ogJkK7cASh6bZFGKwL
         KvsyArkHNDF1xOobPTIr2kYpT8c7Jx/+o/tkcwbLOF/2fVdJ94ANDy2FUoXgP9tWkWRk
         Mizp3N22UKXAfHWdJz6B4n1jrDa75X9LxHlKJgs5eO7LgqXa0Jc5s5rgMh3EeGl+8ue0
         WOwLGSz+zqvn967hfe4ckjNQrqV3aNifobgpqUU1y3TVJdbWc1oq4k/qBFw2DUHYREHJ
         3vVZrDA9AZKBlzEjuOHxDxw8uvLWxGL7y3Gt2NK5JxlKRp8eSD/h2EbMJKPX6rRfHtE8
         LKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=jLiR8SYAwchy/DlkrlFgQINPVuwrI0Zg692gmaFjw9k=;
        b=J5lSWYHKWwfzmu1Bh2KphvZ2cBDtSSe3uVbq+KlzUSN2G8GVebTe54Z1Rc7MeWyw5j
         RGmpBzuJQyN3CD621zhwLmlWhSv367PmhiYTDlXmnuTPn3zQ2+q6kV+3pugPwjOK0Uwb
         qLjb+vk/6U62saD4qZgcAvd1dQW2o0/Rr5DkIBOE+MtjgpWoBPWAu70Rn3vMPnpTUlam
         Z4Ym2ddYzkeAzR4ZFJU9J2yhFJ//dnqc8RJz9KUE/M9yTaEzi3WAS7IBJrx+F9xp0Xjc
         jZr4UNwkxDKL/7fQ5Hi9DWNL0QMuK25EyhiZQF6A1AAqd4buN1N6QajuZc5zFjq55IZZ
         8CIA==
X-Gm-Message-State: AOAM530aGeeGdIgfFezTGl3N/gmygM5OpGaU9i3a6tWOHKN+ep31J1Oe
        JQp5L5KaCryOYU24XsKoGfY=
X-Google-Smtp-Source: ABdhPJyoEpfHvAYdphZemlUp2UGkVZwJFiTtdWwCsElybLHA9mtTJbCa0aFYiWgzREV6DGTI0ts9hw==
X-Received: by 2002:a62:aa02:0:b029:1ee:3011:114e with SMTP id e2-20020a62aa020000b02901ee3011114emr2306pff.39.1614719396845;
        Tue, 02 Mar 2021 13:09:56 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:c87:c34:99dc:ba23])
        by smtp.gmail.com with ESMTPSA id w17sm18980572pgg.41.2021.03.02.13.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 13:09:55 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        joaodias@google.com, surenb@google.com, cgoldswo@codeaurora.org,
        willy@infradead.org, mhocko@suse.com, david@redhat.com,
        vbabka@suse.cz, linux-fsdevel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH 2/2] mm: fs: Invalidate BH LRU during page migration
Date:   Tue,  2 Mar 2021 13:09:49 -0800
Message-Id: <20210302210949.2440120-2-minchan@kernel.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210302210949.2440120-1-minchan@kernel.org>
References: <20210302210949.2440120-1-minchan@kernel.org>
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

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
* from prev - https://lore.kernel.org/linux-mm/e8f3e042b902156467a5e978b57c14954213ec59.1611642039.git.cgoldswo@codeaurora.org/
  * consolidate bh_lru drain logic into lru pagevec - willy

 fs/buffer.c                 | 12 ++++++++++--
 include/linux/buffer_head.h |  2 ++
 include/linux/swap.h        |  1 +
 mm/swap.c                   |  5 ++++-
 4 files changed, 17 insertions(+), 3 deletions(-)

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
index 6b47f94378c5..3d98bdabaac9 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -194,6 +194,8 @@ void __breadahead_gfp(struct block_device *, sector_t block, unsigned int size,
 struct buffer_head *__bread_gfp(struct block_device *,
 				sector_t block, unsigned size, gfp_t gfp);
 void invalidate_bh_lrus(void);
+void invalidate_bh_lru(void *);
+bool has_bh_in_lru(int cpu, void *dummy);
 struct buffer_head *alloc_buffer_head(gfp_t gfp_flags);
 void free_buffer_head(struct buffer_head * bh);
 void unlock_buffer(struct buffer_head *bh);
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 8ab7ad7157f3..94a77e618dba 100644
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
index c1fa6cac04c1..88d51b9ebc8c 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -36,6 +36,7 @@
 #include <linux/hugetlb.h>
 #include <linux/page_idle.h>
 #include <linux/local_lock.h>
+#include <linux/buffer_head.h>
 
 #include "internal.h"
 
@@ -667,6 +668,7 @@ void lru_add_drain_cpu(int cpu)
 		pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
 
 	activate_page_drain(cpu);
+	invalidate_bh_lru(NULL);
 }
 
 /**
@@ -854,7 +856,8 @@ void lru_add_drain_all(bool force_all_cpus)
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

