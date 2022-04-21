Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0768F50AC79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 01:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442858AbiDUXxl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 19:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442861AbiDUXwW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:52:22 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363F947AE9;
        Thu, 21 Apr 2022 16:49:05 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id q75so4758029qke.6;
        Thu, 21 Apr 2022 16:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aaKcIjNjF3IwQgxs7vyEXb42UUHeDaL+RKW940GYuHE=;
        b=a0tjhmKMatzGt0SztAxbHSgi9tkuoq0b0Avq27VcC+kWC+951h6K4afxy78BlImIme
         8hwewDxQUByXhjBpdf3GRogZFMXghbYddWPYGObWHaKwar6ZutgSnbKNT7F3FZLqk7wN
         iZppyKJc9qP3jlBDtQPTyi/5r/om31TNT0840qZqtz+vuCG6AlUZg0IcBuGtOpb3ubGg
         NNKJgJqrfumSUdnk3c04fo5WdiHypYP0u2zJ040DG42b0Ps/eBSB7PE57jCggeofy1rQ
         bctqg3CeHEwk/dvoUnReNkmfYLTGm+Cqm1k45E9NSblGTm2QEP4vBQwsNvO+VemICgy1
         gcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aaKcIjNjF3IwQgxs7vyEXb42UUHeDaL+RKW940GYuHE=;
        b=dYZl1j8JBv8yxudvoLOWi6OljcuD7nl/yvdxg/qHKI9RY8GDlNmHt9wFbn9Xgw9U3C
         /xWkVll8r730WR+10+14ABANnANpqhZJ246diEe6DqJl/1c01mg3POSvM1PVwT0/AsyQ
         9iMEYw+9vZVEc58zYbFh/qCrRsApn9BTWCmlUlJtWUT/fmpqSR2onKxrtUZSK0+E0UR8
         LwUeOfogJTNvGdFbgjm36h64qISwpkwXjYBZh6ZOW5vnbQQUNpGao6i2dEY157m0+rbK
         NrXaF2ph0XooiBen763ZP6xzify+2Q4EKGRnM2eYSMqIQExAtfATCmyC1T59XoO+oR05
         UqBQ==
X-Gm-Message-State: AOAM532NdbS+QfEKz26gVlhymAL70KGPTANwuAhsYcfV/+oR+8/35kKE
        1hBKT6cE2ugIaZXOSk/zReM6kd7iHL7J
X-Google-Smtp-Source: ABdhPJwtXpdd8XMsi8NfAgNi48EgWOzVYdEawLNA8H89/n1HqY3g/ULD/amWov5SbJzrqfz2xmZ8eQ==
X-Received: by 2002:a05:620a:bd5:b0:67d:15ed:2fcd with SMTP id s21-20020a05620a0bd500b0067d15ed2fcdmr1185692qki.81.1650584943898;
        Thu, 21 Apr 2022 16:49:03 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id a1-20020a05622a02c100b002f342ccc1c5sm287372qtx.72.2022.04.21.16.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 16:49:03 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, hch@lst.de,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, roman.gushchin@linux.dev
Subject: [PATCH v2 8/8] mm: Centralize & improve oom reporting in show_mem.c
Date:   Thu, 21 Apr 2022 19:48:37 -0400
Message-Id: <20220421234837.3629927-14-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220421234837.3629927-1-kent.overstreet@gmail.com>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch:
 - Changes show_mem() to always report on slab usage
 - Instead of reporting on all slabs, we only report on top 10 slabs,
   and in sorted order
 - Also reports on shrinkers, with the new shrinkers_to_text().
   Shrinkers need to be included in OOM/allocation failure reporting
   because they're responsible for memory reclaim - if a shrinker isn't
   giving up its memory, we need to know which one and why.

More OOM reporting can be moved to show_mem.c and improved, this patch
is only a start.

New example output on OOM/memory allocation failure:

00177 Mem-Info:
00177 active_anon:13706 inactive_anon:32266 isolated_anon:16
00177  active_file:1653 inactive_file:1822 isolated_file:0
00177  unevictable:0 dirty:0 writeback:0
00177  slab_reclaimable:6242 slab_unreclaimable:11168
00177  mapped:3824 shmem:3 pagetables:1266 bounce:0
00177  kernel_misc_reclaimable:0
00177  free:4362 free_pcp:35 free_cma:0
00177 Node 0 active_anon:54824kB inactive_anon:129064kB active_file:6612kB inactive_file:7288kB unevictable:0kB isolated(anon):64kB isolated(file):0kB mapped:15296kB dirty:0kB writeback:0kB shmem:12kB writeback_tmp:0kB kernel_stack:3392kB pagetables:5064kB all_unreclaimable? no
00177 DMA free:2232kB boost:0kB min:88kB low:108kB high:128kB reserved_highatomic:0KB active_anon:2924kB inactive_anon:6596kB active_file:428kB inactive_file:384kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
00177 lowmem_reserve[]: 0 426 426 426
00177 DMA32 free:15092kB boost:5836kB min:8432kB low:9080kB high:9728kB reserved_highatomic:0KB active_anon:52196kB inactive_anon:122392kB active_file:6176kB inactive_file:7068kB unevictable:0kB writepending:0kB present:507760kB managed:441816kB mlocked:0kB bounce:0kB free_pcp:72kB local_pcp:0kB free_cma:0kB
00177 lowmem_reserve[]: 0 0 0 0
00177 DMA: 284*4kB (UM) 53*8kB (UM) 21*16kB (U) 11*32kB (U) 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 2248kB
00177 DMA32: 2765*4kB (UME) 375*8kB (UME) 57*16kB (UM) 5*32kB (U) 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 15132kB
00177 4656 total pagecache pages
00177 1031 pages in swap cache
00177 Swap cache stats: add 6572399, delete 6572173, find 488603/3286476
00177 Free swap  = 509112kB
00177 Total swap = 2097148kB
00177 130938 pages RAM
00177 0 pages HighMem/MovableOnly
00177 16644 pages reserved
00177 Unreclaimable slab info:
00177 9p-fcall-cache    total: 8.25 MiB active: 8.25 MiB
00177 kernfs_node_cache total: 2.15 MiB active: 2.15 MiB
00177 kmalloc-64        total: 2.08 MiB active: 2.07 MiB
00177 task_struct       total: 1.95 MiB active: 1.95 MiB
00177 kmalloc-4k        total: 1.50 MiB active: 1.50 MiB
00177 signal_cache      total: 1.34 MiB active: 1.34 MiB
00177 kmalloc-2k        total: 1.16 MiB active: 1.16 MiB
00177 bch_inode_info    total: 1.02 MiB active: 922 KiB
00177 perf_event        total: 1.02 MiB active: 1.02 MiB
00177 biovec-max        total: 992 KiB active: 960 KiB
00177 Shrinkers:
00177 super_cache_scan: objects: 127
00177 super_cache_scan: objects: 106
00177 jbd2_journal_shrink_scan: objects: 32
00177 ext4_es_scan: objects: 32
00177 bch2_btree_cache_scan: objects: 8
00177   nr nodes:          24
00177   nr dirty:          0
00177   cannibalize lock:  0000000000000000
00177
00177 super_cache_scan: objects: 8
00177 super_cache_scan: objects: 1

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 mm/oom_kill.c    | 23 ---------------------
 mm/show_mem.c    | 14 +++++++++++++
 mm/slab.h        |  6 ++++--
 mm/slab_common.c | 53 ++++++++++++++++++++++++++++++++++++++++--------
 4 files changed, 63 insertions(+), 33 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 832fb33037..659c7d6376 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -171,27 +171,6 @@ static bool oom_unkillable_task(struct task_struct *p)
 	return false;
 }
 
-/*
- * Check whether unreclaimable slab amount is greater than
- * all user memory(LRU pages).
- * dump_unreclaimable_slab() could help in the case that
- * oom due to too much unreclaimable slab used by kernel.
-*/
-static bool should_dump_unreclaim_slab(void)
-{
-	unsigned long nr_lru;
-
-	nr_lru = global_node_page_state(NR_ACTIVE_ANON) +
-		 global_node_page_state(NR_INACTIVE_ANON) +
-		 global_node_page_state(NR_ACTIVE_FILE) +
-		 global_node_page_state(NR_INACTIVE_FILE) +
-		 global_node_page_state(NR_ISOLATED_ANON) +
-		 global_node_page_state(NR_ISOLATED_FILE) +
-		 global_node_page_state(NR_UNEVICTABLE);
-
-	return (global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B) > nr_lru);
-}
-
 /**
  * oom_badness - heuristic function to determine which candidate task to kill
  * @p: task struct of which task we should calculate
@@ -465,8 +444,6 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
 		mem_cgroup_print_oom_meminfo(oc->memcg);
 	else {
 		show_mem(SHOW_MEM_FILTER_NODES, oc->nodemask);
-		if (should_dump_unreclaim_slab())
-			dump_unreclaimable_slab();
 	}
 	if (sysctl_oom_dump_tasks)
 		dump_tasks(oc);
diff --git a/mm/show_mem.c b/mm/show_mem.c
index 1c26c14ffb..24b662f64d 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -7,11 +7,15 @@
 
 #include <linux/mm.h>
 #include <linux/cma.h>
+#include <linux/printbuf.h>
+
+#include "slab.h"
 
 void show_mem(unsigned int filter, nodemask_t *nodemask)
 {
 	pg_data_t *pgdat;
 	unsigned long total = 0, reserved = 0, highmem = 0;
+	struct printbuf buf = PRINTBUF;
 
 	printk("Mem-Info:\n");
 	show_free_areas(filter, nodemask);
@@ -41,4 +45,14 @@ void show_mem(unsigned int filter, nodemask_t *nodemask)
 #ifdef CONFIG_MEMORY_FAILURE
 	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
 #endif
+
+	pr_info("Unreclaimable slab info:\n");
+	dump_unreclaimable_slab(&buf);
+	printk("%s", printbuf_str(&buf));
+	printbuf_reset(&buf);
+
+	printk("Shrinkers:\n");
+	shrinkers_to_text(&buf);
+	printk("%s", printbuf_str(&buf));
+	printbuf_exit(&buf);
 }
diff --git a/mm/slab.h b/mm/slab.h
index c7f2abc2b1..abefbf7674 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -788,10 +788,12 @@ static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
 
 #endif
 
+struct printbuf;
+
 #if defined(CONFIG_SLAB) || defined(CONFIG_SLUB_DEBUG)
-void dump_unreclaimable_slab(void);
+void dump_unreclaimable_slab(struct printbuf *);
 #else
-static inline void dump_unreclaimable_slab(void)
+static inline void dump_unreclaimable_slab(struct printbuf *out)
 {
 }
 #endif
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 23f2ab0713..1209480797 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -24,6 +24,7 @@
 #include <asm/tlbflush.h>
 #include <asm/page.h>
 #include <linux/memcontrol.h>
+#include <linux/printbuf.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/kmem.h>
@@ -1084,10 +1085,15 @@ static int slab_show(struct seq_file *m, void *p)
 	return 0;
 }
 
-void dump_unreclaimable_slab(void)
+void dump_unreclaimable_slab(struct printbuf *out)
 {
 	struct kmem_cache *s;
 	struct slabinfo sinfo;
+	struct slab_by_mem {
+		struct kmem_cache *s;
+		size_t total, active;
+	} slabs_by_mem[10], n;
+	int i, nr = 0;
 
 	/*
 	 * Here acquiring slab_mutex is risky since we don't prefer to get
@@ -1097,12 +1103,11 @@ void dump_unreclaimable_slab(void)
 	 * without acquiring the mutex.
 	 */
 	if (!mutex_trylock(&slab_mutex)) {
-		pr_warn("excessive unreclaimable slab but cannot dump stats\n");
+		pr_buf(out, "excessive unreclaimable slab but cannot dump stats\n");
 		return;
 	}
 
-	pr_info("Unreclaimable slab info:\n");
-	pr_info("Name                      Used          Total\n");
+	printbuf_atomic_inc(out);
 
 	list_for_each_entry(s, &slab_caches, list) {
 		if (s->flags & SLAB_RECLAIM_ACCOUNT)
@@ -1110,11 +1115,43 @@ void dump_unreclaimable_slab(void)
 
 		get_slabinfo(s, &sinfo);
 
-		if (sinfo.num_objs > 0)
-			pr_info("%-17s %10luKB %10luKB\n", s->name,
-				(sinfo.active_objs * s->size) / 1024,
-				(sinfo.num_objs * s->size) / 1024);
+		if (!sinfo.num_objs)
+			continue;
+
+		n.s = s;
+		n.total = sinfo.num_objs * s->size;
+		n.active = sinfo.active_objs * s->size;
+
+		for (i = 0; i < nr; i++)
+			if (n.total < slabs_by_mem[i].total)
+				break;
+
+		if (nr < ARRAY_SIZE(slabs_by_mem)) {
+			memmove(&slabs_by_mem[i + 1],
+				&slabs_by_mem[i],
+				sizeof(slabs_by_mem[0]) * (nr - i));
+			nr++;
+		} else if (i) {
+			i--;
+			memmove(&slabs_by_mem[0],
+				&slabs_by_mem[1],
+				sizeof(slabs_by_mem[0]) * i);
+		} else {
+			continue;
+		}
+
+		slabs_by_mem[i] = n;
+	}
+
+	for (i = nr - 1; i >= 0; --i) {
+		pr_buf(out, "%-17s total: ", slabs_by_mem[i].s->name);
+		pr_human_readable_u64(out, slabs_by_mem[i].total);
+		pr_buf(out, " active: ");
+		pr_human_readable_u64(out, slabs_by_mem[i].active);
+		pr_newline(out);
 	}
+
+	printbuf_atomic_dec(out);
 	mutex_unlock(&slab_mutex);
 }
 
-- 
2.35.2

