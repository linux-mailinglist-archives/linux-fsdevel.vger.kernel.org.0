Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F7858D6C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 11:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240571AbiHIJuv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 05:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240176AbiHIJup (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 05:50:45 -0400
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D6CE94;
        Tue,  9 Aug 2022 02:50:44 -0700 (PDT)
Received: from dev011.ch-qa.sw.ru ([172.29.1.16])
        by relay.virtuozzo.com with esmtp (Exim 4.95)
        (envelope-from <alexander.atanasov@virtuozzo.com>)
        id 1oLLqu-00ElUd-O7;
        Tue, 09 Aug 2022 11:49:43 +0200
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@openvz.org,
        Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        David Hildenbrand <david@redhat.com>,
        Wei Liu <wei.liu@kernel.org>, Nadav Amit <namit@vmware.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v1 1/2] Enable balloon drivers to report inflated memory
Date:   Tue,  9 Aug 2022 12:49:32 +0300
Message-Id: <20220809094933.2203087-1-alexander.atanasov@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <7bfac48d-2e50-641b-6523-662ea4df0240@virtuozzo.com>
References: <7bfac48d-2e50-641b-6523-662ea4df0240@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Display reported in /proc/meminfo as:

Inflated(total) or Inflated(free)

depending on the driver.

Drivers use the sign bit to indicate where they do account
the inflated memory.

Amount of inflated memory can be used by:
 - as a hint for the oom a killer
 - user space software that monitors memory pressure

Cc: David Hildenbrand <david@redhat.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Nadav Amit <namit@vmware.com>

Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
---
 Documentation/filesystems/proc.rst |  5 +++++
 fs/proc/meminfo.c                  | 11 +++++++++++
 include/linux/mm.h                 |  4 ++++
 mm/page_alloc.c                    |  4 ++++
 4 files changed, 24 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 1bc91fb8c321..064b5b3d5bd8 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -986,6 +986,7 @@ Example output. You may not have all of these fields.
     VmallocUsed:       40444 kB
     VmallocChunk:          0 kB
     Percpu:            29312 kB
+    Inflated(total):  2097152 kB
     HardwareCorrupted:     0 kB
     AnonHugePages:   4149248 kB
     ShmemHugePages:        0 kB
@@ -1133,6 +1134,10 @@ VmallocChunk
 Percpu
               Memory allocated to the percpu allocator used to back percpu
               allocations. This stat excludes the cost of metadata.
+Inflated(total) or Inflated(free)
+               Amount of memory that is inflated by the balloon driver.
+               Due to differences among balloon drivers inflated memory
+               is either subtracted from TotalRam or from MemFree.
 HardwareCorrupted
               The amount of RAM/memory in KB, the kernel identifies as
               corrupted.
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 6e89f0e2fd20..ebbe52ccbb93 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -38,6 +38,9 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	unsigned long pages[NR_LRU_LISTS];
 	unsigned long sreclaimable, sunreclaim;
 	int lru;
+#ifdef CONFIG_MEMORY_BALLOON
+	long inflated_kb;
+#endif
 
 	si_meminfo(&i);
 	si_swapinfo(&i);
@@ -153,6 +156,14 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 		    global_zone_page_state(NR_FREE_CMA_PAGES));
 #endif
 
+#ifdef CONFIG_MEMORY_BALLOON
+	inflated_kb = atomic_long_read(&mem_balloon_inflated_kb);
+	if (inflated_kb >= 0)
+		seq_printf(m,  "Inflated(total): %8ld kB\n", inflated_kb);
+	else
+		seq_printf(m,  "Inflated(free): %8ld kB\n", -inflated_kb);
+#endif
+
 	hugetlb_report_meminfo(m);
 
 	arch_report_meminfo(m);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7898e29bcfb5..b190811dc16e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2582,6 +2582,10 @@ extern int watermark_boost_factor;
 extern int watermark_scale_factor;
 extern bool arch_has_descending_max_zone_pfns(void);
 
+#ifdef CONFIG_MEMORY_BALLOON
+extern atomic_long_t mem_balloon_inflated_kb;
+#endif
+
 /* nommu.c */
 extern atomic_long_t mmap_pages_allocated;
 extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b0bcab50f0a3..12359179a3a2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -194,6 +194,10 @@ EXPORT_SYMBOL(init_on_alloc);
 DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
 EXPORT_SYMBOL(init_on_free);
 
+#ifdef CONFIG_MEMORY_BALLOON
+atomic_long_t mem_balloon_inflated_kb = ATOMIC_LONG_INIT(0);
+#endif
+
 static bool _init_on_alloc_enabled_early __read_mostly
 				= IS_ENABLED(CONFIG_INIT_ON_ALLOC_DEFAULT_ON);
 static int __init early_init_on_alloc(char *buf)
-- 
2.31.1

