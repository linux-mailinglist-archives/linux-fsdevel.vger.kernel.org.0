Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED1D31CE9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 18:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhBPREm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 12:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhBPREi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 12:04:38 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1305FC06174A;
        Tue, 16 Feb 2021 09:03:58 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id p21so963822pgl.12;
        Tue, 16 Feb 2021 09:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DfwDzVk1NHB5T9HsjyNqMcwEKAYtkzgp0UAGcMX/HB8=;
        b=htEorIJ+dmdnPpGtj13u9TsG6Q+w5Ev61teJTqxY2tyiVQO37h7AKhrxgdoYqBwrI4
         J5JXCLJOII5fcMCWbDF/FG9CF3Xodb7T3d4+jzYHOoKQ06gDHgIM/wmK/bdCalH/O3Kn
         6vqppxjqTTllh+RS4X+NKy5kIcTUnjiGazOkpTMh1DAx323RC6wYSMURn6wNyN+inqeQ
         LTQCrayW73nESN71nCh45bqFss2G1e1YfUdw1gvmj2YhGZy8ydqP1uwZP2iUEv/R6qvy
         R5tgTG4l4/JkXh4GOuYW2S6eZvOs+WmeTRfQmiqSD8LZpKNZ3ZOW6P0IV0OnnH8zxmAl
         R5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=DfwDzVk1NHB5T9HsjyNqMcwEKAYtkzgp0UAGcMX/HB8=;
        b=ADjpRy+NQW2rLfr1XgiJIFKCaauAxi83fbR3Zx8Yp0d2rUOJJ1OmpMbl/ka32acM82
         UwQWEheW+h4fcXfWMzwwYGCNuclDV8in6w2PVKWCEDrg3Ik3+wfk/EH+iG4+QDZxKcaS
         O2JqufBvsWPDakjPurVruxCGZHjtKknQwXHPCoUrIjUwU1hjZdVZVA2DbP75DO6tY97H
         7AtcP255wZJ0qvs2JTtmfW0ckMzE5yfuvHD2D1E87kEoV0MyGFgNcYJR1/TqyAhJsgtv
         Sb9uWc7UrP1gWVLewSs8QXASms+I7mXE7P6yNYu87DgRljp16cLJezuKxLMWE3j+DB+C
         Ef7g==
X-Gm-Message-State: AOAM533qhAnJqNNTRFshDEZhYTcxulA1VprEVFNJFS32lHWyBmkZEwnx
        gK/yIPIWudHug5RMhj897Ew=
X-Google-Smtp-Source: ABdhPJxPi89JXusezEuR2+j63Tw5YX1JwuFnLkLpfGiQLYi3zEz/6/51oQ/ZtclHZTMYeYxxgvTlvQ==
X-Received: by 2002:a65:4942:: with SMTP id q2mr16931626pgs.34.1613495037636;
        Tue, 16 Feb 2021 09:03:57 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:fc2a:a664:489d:d48f])
        by smtp.gmail.com with ESMTPSA id 143sm21876424pfw.3.2021.02.16.09.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 09:03:56 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        cgoldswo@codeaurora.org, linux-fsdevel@vger.kernel.org,
        willy@infradead.org, mhocko@suse.com, david@redhat.com,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, joaodias@google.com,
        Minchan Kim <minchan@kernel.org>
Subject: [RFC 2/2] mm: fs: Invalidate BH LRU during page migration
Date:   Tue, 16 Feb 2021 09:03:48 -0800
Message-Id: <20210216170348.1513483-2-minchan@kernel.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210216170348.1513483-1-minchan@kernel.org>
References: <20210216170348.1513483-1-minchan@kernel.org>
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
 fs/buffer.c                 | 13 +++++++++++--
 include/linux/buffer_head.h |  2 ++
 mm/swap.c                   |  5 ++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 96c7604f69b3..de62e75d0ed0 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -45,6 +45,7 @@
 #include <linux/mpage.h>
 #include <linux/bit_spinlock.h>
 #include <linux/pagevec.h>
+#include <linux/migrate.h>
 #include <linux/sched/mm.h>
 #include <trace/events/block.h>
 #include <linux/fscrypt.h>
@@ -1301,6 +1302,14 @@ static void bh_lru_install(struct buffer_head *bh)
 	int i;
 
 	check_irqs_on();
+	/*
+	 * buffer_head in bh_lru could increase refcount of the page
+	 * until it will be invalidated. It causes page migraion failure.
+	 * Skip putting upcoming bh into bh_lru until migration is done.
+	 */
+	if (migrate_pending())
+		return;
+
 	bh_lru_lock();
 
 	b = this_cpu_ptr(&bh_lrus);
@@ -1446,7 +1455,7 @@ EXPORT_SYMBOL(__bread_gfp);
  * This doesn't race because it runs in each cpu either in irq
  * or with preempt disabled.
  */
-static void invalidate_bh_lru(void *arg)
+void invalidate_bh_lru(void *arg)
 {
 	struct bh_lru *b = &get_cpu_var(bh_lrus);
 	int i;
@@ -1458,7 +1467,7 @@ static void invalidate_bh_lru(void *arg)
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
diff --git a/mm/swap.c b/mm/swap.c
index e42c4b4bf2b3..14faf558347b 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -37,6 +37,7 @@
 #include <linux/page_idle.h>
 #include <linux/local_lock.h>
 #include <linux/migrate.h>
+#include <linux/buffer_head.h>
 
 #include "internal.h"
 
@@ -641,6 +642,7 @@ void lru_add_drain_cpu(int cpu)
 		pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
 
 	activate_page_drain(cpu);
+	invalidate_bh_lru(NULL);
 }
 
 /**
@@ -827,7 +829,8 @@ void lru_add_drain_all(void)
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
2.30.0.478.g8a0d178c01-goog

