Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61BB507B0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 22:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357667AbiDSUfG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 16:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357656AbiDSUfA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:35:00 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD533C4AB;
        Tue, 19 Apr 2022 13:32:16 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id f22so3956965qtp.13;
        Tue, 19 Apr 2022 13:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hiSsrCjlwcoYpl0/USGlx4MhgXt3RiZFVish54MSnok=;
        b=hicipdWXgw6rsxF8UJHDR0KaJKoyeokPF5PWR6GaAgrllERYJYI/Jg9xtgvUJfkGvD
         eQ0Tn1RWY90G63yyb8TFRYK1YAyDoBqYZpHyMmkemad2g9WorHqYlLgIkxXqgDRyqSD3
         JSI8HI1+65J/hvvAJjRj4sntggxxOZ35CeH1fwN12b0a+lmaR2pa08qEpc5yuHT97nwo
         rTDx3GGrEAOAeBvQJvS2x/TyS3N3gOKoY3aPUB5OcYIP/JzWx6GZP2evEsfvj0XwtP2r
         +AefnAe8wxhqx3vV9dqRsM92MSdMMBlq4LJeGesbsBBKRiRmTUekFCOF0vT4/ZK760CM
         apfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hiSsrCjlwcoYpl0/USGlx4MhgXt3RiZFVish54MSnok=;
        b=LzVnHLup+BREdCziZw1m6Zu//XcNS5lNP9MIrN5BXgfC252lI8e+P8sEgVFO+4gQNC
         Z8pA9Y1ENXKBdinou/e+cBPDX+aVNGPxZb8vg170gHqgz5vQwIuGJOXMxkNMgiRdZazV
         QrPZfMPuZSSGNoiPVQbMoHhdfomFNkat+Zy0PE8V6ClpEiGeDa2cqZ57Gi3MfgfFRyI7
         iISek3PT+WnuQUC0R96KO4zDukM3fh0VhzDJ8/LnU724xOa/XtwWw5d8IUIIT/i1aR+/
         djBcWt2mixDCMdMNEE1mDuYDGH9+8zU/tDdkg9+27D6DOtiJdren4PfFqp1WK+JDKUUP
         WZJA==
X-Gm-Message-State: AOAM531Xp9MdrMdKbahLRAY/5IQMf6TS6i2iFckTNR6ZzMhm67rPUDwI
        DzzJnM1lLMHTSKH/OKcZAKCbDvR+gofB
X-Google-Smtp-Source: ABdhPJygPQpglSpvnfxt1BNztNSw+CtWlN8E1Jml72FeiMubEvfSdNMiyDAjGy1m+t6bYuttfHO2lA==
X-Received: by 2002:ac8:5a16:0:b0:2e1:ea00:b4e1 with SMTP id n22-20020ac85a16000000b002e1ea00b4e1mr11595006qta.329.1650400335194;
        Tue, 19 Apr 2022 13:32:15 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id e9-20020ac84e49000000b002f1fcda1ac7sm611180qtw.82.2022.04.19.13.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 13:32:14 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        roman.gushchin@linux.dev, hannes@cmpxchg.org
Subject: [PATCH 3/4] mm: Centralize & improve oom reporting in show_mem.c
Date:   Tue, 19 Apr 2022 16:32:01 -0400
Message-Id: <20220419203202.2670193-4-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220419203202.2670193-1-kent.overstreet@gmail.com>
References: <20220419203202.2670193-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch:
 - Moves lib/show_mem.c to mm/show_mem.c
 - Changes show_mem() to always report on slab usage
 - Instead of reporting on all slabs, we only report on top 10 slabs,
   and in sorted order
 - Also reports on shrinkers, with the new shrinkers_to_text().

More OOM reporting can be moved to show_mem.c and improved, this patch
is only a small start.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 lib/Makefile           |  2 +-
 mm/Makefile            |  2 +-
 mm/oom_kill.c          | 23 ------------------
 {lib => mm}/show_mem.c | 14 +++++++++++
 mm/slab.h              |  6 +++--
 mm/slab_common.c       | 53 +++++++++++++++++++++++++++++++++++-------
 6 files changed, 65 insertions(+), 35 deletions(-)
 rename {lib => mm}/show_mem.c (78%)

diff --git a/lib/Makefile b/lib/Makefile
index 31a3904eda..c5041d33d0 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -30,7 +30,7 @@ endif
 lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 rbtree.o radix-tree.o timerqueue.o xarray.o \
 	 idr.o extable.o sha1.o irq_regs.o argv_split.o \
-	 flex_proportions.o ratelimit.o show_mem.o \
+	 flex_proportions.o ratelimit.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
 	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
 	 nmi_backtrace.o nodemask.o win_minmax.o memcat_p.o \
diff --git a/mm/Makefile b/mm/Makefile
index 70d4309c9c..97c0be12f3 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -54,7 +54,7 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 			   mm_init.o percpu.o slab_common.o \
 			   compaction.o vmacache.o \
 			   interval_tree.o list_lru.o workingset.o \
-			   debug.o gup.o mmap_lock.o $(mmu-y)
+			   debug.o gup.o mmap_lock.o show_mem.o $(mmu-y)
 
 # Give 'page_alloc' its own module-parameter namespace
 page-alloc-y := page_alloc.o
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
diff --git a/lib/show_mem.c b/mm/show_mem.c
similarity index 78%
rename from lib/show_mem.c
rename to mm/show_mem.c
index 1c26c14ffb..c9f37f13d6 100644
--- a/lib/show_mem.c
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
+	printk("%s", buf.buf);
+	printbuf_reset(&buf);
+
+	printk("Shrinkers:\n");
+	shrinkers_to_text(&buf);
+	printk("%s", buf.buf);
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
index 23f2ab0713..cb1c548c73 100644
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
+	buf->atomic++;
 
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
+	--buf->atomic;
 	mutex_unlock(&slab_mutex);
 }
 
-- 
2.35.2

