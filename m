Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C332C2D6F2C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 05:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395370AbgLKEYv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 23:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395376AbgLKEYd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 23:24:33 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFB1C061248
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 20:23:32 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id c79so6208079pfc.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 20:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NbJhG/dST+z4diHKFuM1zuN6LseIAyC0A7txgFqKs14=;
        b=GORbjDWZI6+50DEGT4dnLtiziTalV0Lt8P/furd1Fs3XrM/sZzpPQvk7840/8W+QS7
         Uq7HXKX1RrX18znav0P/3a3kxYtMH6NkjZRU26+GCv4Kbo3qjDVfPOkyQQ3p4Wh92kbb
         NtCmT1EPhw04P9OLkJQzyEtvA+V3E4gAbMOEtguB9i062ms/j4E6atxS6ntEm+1/wHv8
         1clU8ncAIiYEXL5poqcfd8klzCtr1AiIoTopGRXAtJSqzloZO1dWTrnbyu7cBgzcLBFu
         ZdYc1WBtXQo9Y0frkW9q6UlrJ1RGH6Mk9/qoxjlOm6bbTzkEnx1dvwnm+xGXrlh/nvTL
         4iTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NbJhG/dST+z4diHKFuM1zuN6LseIAyC0A7txgFqKs14=;
        b=PksN4Mhaj1nQwAkaIKoeCADSTkQEbCaBZvp2b/LEKS/23b1GGbxqFjfwrM9V07wqcg
         1OjKgGkeSeljerOyvbQJFXJe16fDe4bnVIUwBioaaXYFm+GIVN7YiTANalsOlC8RLzDw
         qM8l//sIWuGchT3cXcuGRuapXOAJft9v/DbmpWuudoRCe57Qt7GR4WZ/tyFIcusp9u5z
         TaufdZrwNB0KWohAXEpFW6QQJhDkhbGg8A6QlSh8I42ywox09aheqMPQxTeLgrNvGTk0
         ENLIGjGZ5w89Tbkpsk5cPvlL4woti7SE1Opta7azVK88vvikWq5F5Bu/Vpo8Zt8jywUU
         tiwQ==
X-Gm-Message-State: AOAM533+fxeiQyW8jZZFK+Fjb69M+khlWtV7rUAS8I62w9e3W73u/y/C
        0fx5M+u3clrGYfv761rekdrGHA==
X-Google-Smtp-Source: ABdhPJyos71clKQbmypkn6DJcpPrhNuiTt6C+WbTDEwBPzMpExl/Tq/F9HfnC6T3EcmJ8Ml75UOqew==
X-Received: by 2002:a62:7e09:0:b029:19e:9fdd:80a3 with SMTP id z9-20020a627e090000b029019e9fdd80a3mr8794253pfc.24.1607660612143;
        Thu, 10 Dec 2020 20:23:32 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.66])
        by smtp.gmail.com with ESMTPSA id 19sm8623352pfu.85.2020.12.10.20.23.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Dec 2020 20:23:31 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, shakeelb@google.com,
        guro@fb.com, samitolvanen@google.com, feng.tang@intel.com,
        neilb@suse.de, iamjoonsoo.kim@lge.com, rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 4/7] mm: memcontrol: convert NR_SHMEM_THPS account to pages
Date:   Fri, 11 Dec 2020 12:19:51 +0800
Message-Id: <20201211041954.79543-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201211041954.79543-1-songmuchun@bytedance.com>
References: <20201211041954.79543-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The unit of NR_SHMEM_THPS is HPAGE_PMD_NR. Convert NR_SHMEM_THPS
account to pages

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/node.c    |  3 +--
 fs/proc/meminfo.c      |  2 +-
 include/linux/mmzone.h |  3 ++-
 mm/filemap.c           |  2 +-
 mm/huge_memory.c       |  3 ++-
 mm/khugepaged.c        |  2 +-
 mm/memcontrol.c        | 26 ++------------------------
 mm/page_alloc.c        |  2 +-
 mm/shmem.c             |  3 ++-
 9 files changed, 13 insertions(+), 33 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index d5952f754911..6d5ac6ffb6e1 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -462,8 +462,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 			     ,
 			     nid, K(node_page_state(pgdat, NR_ANON_THPS)),
-			     nid, K(node_page_state(pgdat, NR_SHMEM_THPS) *
-				    HPAGE_PMD_NR),
+			     nid, K(node_page_state(pgdat, NR_SHMEM_THPS)),
 			     nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED) *
 				    HPAGE_PMD_NR),
 			     nid, K(node_page_state(pgdat, NR_FILE_THPS)),
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 7ea4679880c8..cfb107eaa3e6 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -131,7 +131,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "AnonHugePages:  ",
 		    global_node_page_state(NR_ANON_THPS));
 	show_val_kb(m, "ShmemHugePages: ",
-		    global_node_page_state(NR_SHMEM_THPS) * HPAGE_PMD_NR);
+		    global_node_page_state(NR_SHMEM_THPS));
 	show_val_kb(m, "ShmemPmdMapped: ",
 		    global_node_page_state(NR_SHMEM_PMDMAPPED) * HPAGE_PMD_NR);
 	show_val_kb(m, "FileHugePages:  ",
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 67b6598c9ea4..4f49af38dced 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -216,7 +216,8 @@ enum node_stat_item {
 static __always_inline bool vmstat_item_print_in_thp(enum node_stat_item item)
 {
 	return item == NR_ANON_THPS ||
-	       item == NR_FILE_THPS;
+	       item == NR_FILE_THPS ||
+	       item == NR_SHMEM_THPS;
 }
 
 /*
diff --git a/mm/filemap.c b/mm/filemap.c
index 9cc8b3ac9eac..c653717b92b6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -205,7 +205,7 @@ static void unaccount_page_cache_page(struct address_space *mapping,
 	if (PageSwapBacked(page)) {
 		__mod_lruvec_page_state(page, NR_SHMEM, -nr);
 		if (PageTransHuge(page))
-			__dec_lruvec_page_state(page, NR_SHMEM_THPS);
+			__mod_lruvec_page_state(page, NR_SHMEM_THPS, -HPAGE_PMD_NR);
 	} else if (PageTransHuge(page)) {
 		__mod_lruvec_page_state(page, NR_FILE_THPS, -HPAGE_PMD_NR);
 		filemap_nr_thps_dec(mapping);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1e24165fa53a..ac552807492e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2746,7 +2746,8 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		spin_unlock(&ds_queue->split_queue_lock);
 		if (mapping) {
 			if (PageSwapBacked(head))
-				__dec_lruvec_page_state(head, NR_SHMEM_THPS);
+				__mod_lruvec_page_state(head, NR_SHMEM_THPS,
+							-HPAGE_PMD_NR);
 			else
 				__mod_lruvec_page_state(head, NR_FILE_THPS,
 							-HPAGE_PMD_NR);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 76b3e064a72a..2f1c22331188 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1867,7 +1867,7 @@ static void collapse_file(struct mm_struct *mm,
 	}
 
 	if (is_shmem)
-		__inc_lruvec_page_state(new_page, NR_SHMEM_THPS);
+		__mod_lruvec_page_state(new_page, NR_SHMEM_THPS, HPAGE_PMD_NR);
 	else {
 		__mod_lruvec_page_state(new_page, NR_FILE_THPS, HPAGE_PMD_NR);
 		filemap_nr_thps_inc(mapping);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 04985c8c6a0a..a40797a27f87 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1515,7 +1515,7 @@ struct memory_stat {
 	unsigned int idx;
 };
 
-static struct memory_stat memory_stats[] = {
+static const struct memory_stat memory_stats[] = {
 	{ "anon", PAGE_SIZE, NR_ANON_MAPPED },
 	{ "file", PAGE_SIZE, NR_FILE_PAGES },
 	{ "kernel_stack", 1024, NR_KERNEL_STACK_KB },
@@ -1527,14 +1527,9 @@ static struct memory_stat memory_stats[] = {
 	{ "file_dirty", PAGE_SIZE, NR_FILE_DIRTY },
 	{ "file_writeback", PAGE_SIZE, NR_WRITEBACK },
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	/*
-	 * The ratio will be initialized in memory_stats_init(). Because
-	 * on some architectures, the macro of HPAGE_PMD_SIZE is not
-	 * constant(e.g. powerpc).
-	 */
 	{ "anon_thp", PAGE_SIZE, NR_ANON_THPS },
 	{ "file_thp", PAGE_SIZE, NR_FILE_THPS },
-	{ "shmem_thp", 0, NR_SHMEM_THPS },
+	{ "shmem_thp", PAGE_SIZE, NR_SHMEM_THPS },
 #endif
 	{ "inactive_anon", PAGE_SIZE, NR_INACTIVE_ANON },
 	{ "active_anon", PAGE_SIZE, NR_ACTIVE_ANON },
@@ -1559,23 +1554,6 @@ static struct memory_stat memory_stats[] = {
 	{ "workingset_nodereclaim", 1, WORKINGSET_NODERECLAIM },
 };
 
-static int __init memory_stats_init(void)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-		if (memory_stats[i].idx == NR_SHMEM_THPS)
-			memory_stats[i].ratio = HPAGE_PMD_SIZE;
-#endif
-		VM_BUG_ON(!memory_stats[i].ratio);
-		VM_BUG_ON(memory_stats[i].idx >= MEMCG_NR_STAT);
-	}
-
-	return 0;
-}
-pure_initcall(memory_stats_init);
-
 static char *memory_stat_format(struct mem_cgroup *memcg)
 {
 	struct seq_buf s;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1700f52b7869..720fb5a220b6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5577,7 +5577,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(node_page_state(pgdat, NR_WRITEBACK)),
 			K(node_page_state(pgdat, NR_SHMEM)),
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-			K(node_page_state(pgdat, NR_SHMEM_THPS) * HPAGE_PMD_NR),
+			K(node_page_state(pgdat, NR_SHMEM_THPS)),
 			K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)
 					* HPAGE_PMD_NR),
 			K(node_page_state(pgdat, NR_ANON_THPS)),
diff --git a/mm/shmem.c b/mm/shmem.c
index 53d84d2c9fe5..b2ca3beabc19 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -713,7 +713,8 @@ static int shmem_add_to_page_cache(struct page *page,
 		}
 		if (PageTransHuge(page)) {
 			count_vm_event(THP_FILE_ALLOC);
-			__inc_lruvec_page_state(page, NR_SHMEM_THPS);
+			__mod_lruvec_page_state(page, NR_SHMEM_THPS,
+						HPAGE_PMD_NR);
 		}
 		mapping->nrpages += nr;
 		__mod_lruvec_page_state(page, NR_FILE_PAGES, nr);
-- 
2.11.0

