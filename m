Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F71B2D028F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 11:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgLFKSV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 05:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgLFKSU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 05:18:20 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB667C08E861
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Dec 2020 02:17:25 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id 4so5589996plk.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Dec 2020 02:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jqJ1l3kUFANKBttrjy8eqm/Bfbx0CB9v1pkRqyyS8to=;
        b=KmA+ORfQc43rX3WMdlp11TQtIwpSJKpCxx5KoM4F25X7T30VLyaba67ZPkmP5cSM7c
         PKM6k/+aB9OVyO/8dQ+UJ86/av3LnTXnc1p/BRBzA0G00SzeU8PcqZ9Urmcf9zAXuAoZ
         xXzf2hK7TGTUPRpZVFDts8Ltd9Zsw1mZc60SLFI1uD+HV5B26N+YKp2clMDnKZYVQEBU
         AL7xPd2zVYSTvthcCID8/4MrAWZvFilD4o1eUb1vzOhLiYzYXGP8SjCSKOeJEG3OUwKx
         hyLQXCGOesN4uzI5XVZPYMZuoUNXP9kiHZSDYi9/0RQPtXc/uXCNVFSZxXt75fOvG6Ln
         Zo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jqJ1l3kUFANKBttrjy8eqm/Bfbx0CB9v1pkRqyyS8to=;
        b=KOTkpLVZ55zPsKnHCChtVAEkVxIiQ+7DA0DCpSrIBTEVh/65DVbC69yMbuJ0tjz1OT
         lrHjws7G7N6VrftBBznhVdKpTW7r+yYKvWtCg7BYllJYldni1qy0gxEK71XvsaOEvBH5
         4WMPseBX0XfSRyDE0LvQnvABl2qMvK8lItCbc9lnrzrbRSwPE2Kp62vGwGS9plyS0irc
         QOu9NL4fX56fAgf6x20prIQmMDSTjlhRPXznrsmO1nFY6Hu3pMX6Ux6sQttu+KN4tBqh
         1lO0FlIy0b/7utbhG1+B3xLFwxJ9q9MudoVWJpcTZLNo7agvVRLU5JtNjiu5lrtH87bz
         DP2w==
X-Gm-Message-State: AOAM532I89PbvGBQkk3HWeI6K95lEXtRzZfIVW9Fp1f4f2cwYBaafNj8
        HV7QMv9zQgCKrS920AF1bV8JGw==
X-Google-Smtp-Source: ABdhPJyATYkKaw9y7vPdixMLM0rw9slgfozfwgOvQwnqmmhL7taHvYOu1U+qJ+3OrLbTIC6GDGWDUg==
X-Received: by 2002:a17:902:7b97:b029:d8:ec6e:5c28 with SMTP id w23-20020a1709027b97b02900d8ec6e5c28mr11410388pll.40.1607249845181;
        Sun, 06 Dec 2020 02:17:25 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id g16sm10337657pfb.201.2020.12.06.02.17.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 02:17:24 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, will@kernel.org,
        guro@fb.com, rppt@kernel.org, tglx@linutronix.de, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com, surenb@google.com,
        avagin@openvz.org, elver@google.com, rdunlap@infradead.org,
        iamjoonsoo.kim@lge.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [RESEND PATCH v2 04/12] mm: memcontrol: convert NR_SHMEM_THPS account to pages
Date:   Sun,  6 Dec 2020 18:14:43 +0800
Message-Id: <20201206101451.14706-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201206101451.14706-1-songmuchun@bytedance.com>
References: <20201206101451.14706-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert NR_SHMEM_THPS account to pages

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/node.c |  3 +--
 fs/proc/meminfo.c   |  2 +-
 mm/filemap.c        |  2 +-
 mm/huge_memory.c    |  3 ++-
 mm/khugepaged.c     |  2 +-
 mm/memcontrol.c     | 26 ++------------------------
 mm/page_alloc.c     |  2 +-
 mm/shmem.c          |  3 ++-
 8 files changed, 11 insertions(+), 32 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 2db28acdaa4f..3e1094717e40 100644
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
index f4157f26cbf5..b4d8a6ee822d 100644
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
diff --git a/mm/filemap.c b/mm/filemap.c
index c4dcb1144883..5fdefbbc1bc2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -204,7 +204,7 @@ static void unaccount_page_cache_page(struct address_space *mapping,
 	if (PageSwapBacked(page)) {
 		__mod_lruvec_page_state(page, NR_SHMEM, -nr);
 		if (PageTransHuge(page))
-			__dec_lruvec_page_state(page, NR_SHMEM_THPS);
+			__mod_lruvec_page_state(page, NR_SHMEM_THPS, -HPAGE_PMD_NR);
 	} else if (PageTransHuge(page)) {
 		__mod_lruvec_page_state(page, NR_FILE_THPS, -HPAGE_PMD_NR);
 		filemap_nr_thps_dec(mapping);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 37840bdeaad0..0e8541bd9f50 100644
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
index 1e1ced2208d0..4fe79ccfc312 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1857,7 +1857,7 @@ static void collapse_file(struct mm_struct *mm,
 	}
 
 	if (is_shmem)
-		__inc_lruvec_page_state(new_page, NR_SHMEM_THPS);
+		__mod_lruvec_page_state(new_page, NR_SHMEM_THPS, HPAGE_PMD_NR);
 	else {
 		__mod_lruvec_page_state(new_page, NR_FILE_THPS, HPAGE_PMD_NR);
 		filemap_nr_thps_inc(mapping);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c4557de2b211..6d4365d2fd1c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1497,7 +1497,7 @@ struct memory_stat {
 	unsigned int idx;
 };
 
-static struct memory_stat memory_stats[] = {
+static const struct memory_stat memory_stats[] = {
 	{ "anon", PAGE_SIZE, NR_ANON_MAPPED },
 	{ "file", PAGE_SIZE, NR_FILE_PAGES },
 	{ "kernel_stack", 1024, NR_KERNEL_STACK_KB },
@@ -1508,14 +1508,9 @@ static struct memory_stat memory_stats[] = {
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
@@ -1540,23 +1535,6 @@ static struct memory_stat memory_stats[] = {
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
index f97ca98d361f..b6a79196e870 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5567,7 +5567,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(node_page_state(pgdat, NR_WRITEBACK)),
 			K(node_page_state(pgdat, NR_SHMEM)),
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-			K(node_page_state(pgdat, NR_SHMEM_THPS) * HPAGE_PMD_NR),
+			K(node_page_state(pgdat, NR_SHMEM_THPS)),
 			K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)
 					* HPAGE_PMD_NR),
 			K(node_page_state(pgdat, NR_ANON_THPS)),
diff --git a/mm/shmem.c b/mm/shmem.c
index 5da4f1a3e663..ea5d8c9ccb5b 100644
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

