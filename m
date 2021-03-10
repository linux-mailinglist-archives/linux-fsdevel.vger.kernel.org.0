Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20C13342CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 17:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhCJQOp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 11:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhCJQOj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:14:39 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46878C061760;
        Wed, 10 Mar 2021 08:14:39 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id w34so10640768pga.8;
        Wed, 10 Mar 2021 08:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2lZIChPtI3p/aQ6I3GH7R9vIF95h/LXfK2s4My5ecFY=;
        b=PpJW7kp5pzBkHhRmXGWgHhfCoR5r78l0ND0ggR1yOLv9HV1gPw2Ucrv9D1FahpYdNX
         v/Pq+6lsYoRIRGMfHS9cp+RFs5LOFR4izsjtsBv3ctsddBwDVuUBJos2yKEW0g/I8CIy
         GZaSi5mU7jBOOTlw6J9itpKWr2FrElsM6Nz5PVwFamSgbcaN9/vIs24Qkol7SQq8xJPN
         diOupJhOcJ7Jv+3wbA3GI3OLkZI7pJhQCMsrPwzOtlw5oWxeSuXNSoq2guC86l5HRGqI
         /iIhvjog/gC5R0GSdyCFa8oavOc9B8gg+M1WVWD60fKpBBTm3FKaWDS+9OtiqPDbA/eo
         kYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2lZIChPtI3p/aQ6I3GH7R9vIF95h/LXfK2s4My5ecFY=;
        b=px4eyER33OsZkGbAma4t0aBgcOYcGJpdr5kQDPuoMjKXpkkV6EilunEVl9btfiShLZ
         ZHcrv5LMzUv1puN6irlhB5PB6NcnXWdzSXeN/d0QEnZfxFRAuoxpNAlZuGIQhaIgA9wI
         y2gD1hB17XSDCjOkQuvJmqFS7klR5sj8yUbtpYSjhmtNBBNwchSM6G1MP0fgVpaHMQEt
         Sj61cb984gddSu1MYmWsT08a53xkxeL7UHzH315/WQK4QtQ5ClvhnBzCji+eQ1YnUgIw
         ejSpy8qjip79TtmXt+Y540vFwBAUAqqxBh9+tsVsSom/ly85x9jAAw8rXs1i5v65lZBJ
         c4mw==
X-Gm-Message-State: AOAM533wlDWWcR/cvM1v074gMC115h+jmU2ndvrIAZ+tlZqSSWOZEDMs
        COiF9+Kyj3fpCaDFQriVUK8=
X-Google-Smtp-Source: ABdhPJyPQhcFlW2wScizcKfaE6eSRP+gjVd97qisGxEWmX7zZWVrW7WndKT1z6Wy60BgoWv6yGaykA==
X-Received: by 2002:a05:6a00:3:b029:1f3:1959:2e3b with SMTP id h3-20020a056a000003b02901f319592e3bmr3444355pfk.11.1615392878842;
        Wed, 10 Mar 2021 08:14:38 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:64cb:74c7:f2c:e5e0])
        by smtp.gmail.com with ESMTPSA id d1sm7121189pjc.24.2021.03.10.08.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 08:14:38 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        joaodias@google.com, surenb@google.com, cgoldswo@codeaurora.org,
        willy@infradead.org, mhocko@suse.com, david@redhat.com,
        vbabka@suse.cz, linux-fsdevel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v3 3/3] mm: fs: Invalidate BH LRU during page migration
Date:   Wed, 10 Mar 2021 08:14:29 -0800
Message-Id: <20210310161429.399432-3-minchan@kernel.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210310161429.399432-1-minchan@kernel.org>
References: <20210310161429.399432-1-minchan@kernel.org>
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
 include/linux/buffer_head.h |  4 ++++
 mm/swap.c                   |  5 ++++-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 0cb7ffd4977c..ca9dd736bcb8 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1264,6 +1264,14 @@ static void bh_lru_install(struct buffer_head *bh)
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
@@ -1409,7 +1417,7 @@ EXPORT_SYMBOL(__bread_gfp);
  * This doesn't race because it runs in each cpu either in irq
  * or with preempt disabled.
  */
-static void invalidate_bh_lru(void *arg)
+void invalidate_bh_lru(void *arg)
 {
 	struct bh_lru *b = &get_cpu_var(bh_lrus);
 	int i;
@@ -1421,7 +1429,7 @@ static void invalidate_bh_lru(void *arg)
 	put_cpu_var(bh_lrus);
 }
 
-static bool has_bh_in_lru(int cpu, void *dummy)
+bool has_bh_in_lru(int cpu, void *dummy)
 {
 	struct bh_lru *b = per_cpu_ptr(&bh_lrus, cpu);
 	int i;
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 6b47f94378c5..05998b5947a2 100644
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
@@ -406,6 +408,8 @@ static inline int inode_has_buffers(struct inode *inode) { return 0; }
 static inline void invalidate_inode_buffers(struct inode *inode) {}
 static inline int remove_inode_buffers(struct inode *inode) { return 1; }
 static inline int sync_mapping_buffers(struct address_space *mapping) { return 0; }
+static inline void invalidate_bh_lru(void *arg) {}
+static inline bool has_bh_in_lru(int cpu, void *dummy) { return 0; }
 #define buffer_heads_over_limit 0
 
 #endif /* CONFIG_BLOCK */
diff --git a/mm/swap.c b/mm/swap.c
index fbdf6ac05aec..2a431959a45d 100644
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
@@ -828,7 +830,8 @@ static void __lru_add_drain_all(bool force_all_cpus)
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

