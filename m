Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919E72D01CB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 09:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgLFI1t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 03:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbgLFI1t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 03:27:49 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED920C0613D0
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Dec 2020 00:27:08 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id z12so5594455pjn.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Dec 2020 00:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S7mNi5PKMwLVHFP7gDd3IF0GOynsG77QNA4M+vj3DJk=;
        b=JzbYatK+jBpxC9rQ+E8UoLjywkl1gybNa7BiZ2QXcdsLHhK8JqOZxog96Gn0AJKEXT
         uJO/yMX7K7vqw1Wvr2a9TBL+MWSEoT0IMgUANo8zYHd8f+NgrljUemnEL7FrR6pZwfqK
         K2uoDXT/QQwxCrlM1cU2FnRImJU5DtT+z/GiGqFKck8rZ+V3o/BwKidBrRf7j8d5aoJM
         8rtIlEoCDWsOOzVPC6aFvdr5osl60WWpft0cQy+dDfpP34pMzRTjfH9wixWN4L5rbemq
         NA8YNVvdeuv7YS3hz6wlWOurx7RfNBqEtmDhxrHF231oqUs9Xa1E7Xx/hnltfSi3BPO/
         3MaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S7mNi5PKMwLVHFP7gDd3IF0GOynsG77QNA4M+vj3DJk=;
        b=galejnhjAH9Ve4xpjMhcn9rKLW3GcjfmF3B8U/tlSfkk8ScwNFTzdPG4yQbbh0hAXf
         DqIM8IzragPFDW71GxwfIWnwPIX2gOixGX4E6DXXXb0fz8IttkG+WEv+967b1WYOyinC
         JdFL7K/8ypHSR2LhtJSltktqvNV+ToIwzFmiRyLPA3s/IjvgL7sEc8W9iUE5sqT8lvxY
         JMQ+MGR/BbaEYdyHwzGewWKiyGOlP10CDmJL3VOxzcPdILx3LsGjYSsSePJe3CiFqHh7
         IlZO0S9khB1WMzdM9MEOoRGXS22Np62UOovLsEJvrOx8eOUssGW6LB1XWP7iAunAoXQX
         lHkQ==
X-Gm-Message-State: AOAM530cWO4II8mVN+U4HIhwvcMVXHEfjrky61ChnSfnmFbt4Vhy7rla
        2IyvTqXxw3Ja4uaMzTMpFfHYZw==
X-Google-Smtp-Source: ABdhPJxQJrZVgxAbBsXWq3TOo8/M/5LAijKnabijGcHm7t65fb1Of3TzoYa+Emy4LaPwPwmxuhCq0Q==
X-Received: by 2002:a17:902:9b8c:b029:da:1469:891d with SMTP id y12-20020a1709029b8cb02900da1469891dmr11066437plp.84.1607243228552;
        Sun, 06 Dec 2020 00:27:08 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id iq3sm6884104pjb.57.2020.12.06.00.26.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 00:27:07 -0800 (PST)
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
Subject: [PATCH 6/9] mm: memcontrol: convert NR_SHMEM_THPS account to pages
Date:   Sun,  6 Dec 2020 16:23:09 +0800
Message-Id: <20201206082318.11532-13-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201206082318.11532-1-songmuchun@bytedance.com>
References: <20201206082318.11532-1-songmuchun@bytedance.com>
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
index f6a9521bbcf8..a64f9c5484a0 100644
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
index 9b2cb770326e..574779b6e48c 100644
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
index dce76dddac61..48d70c1ad301 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1497,7 +1497,7 @@ struct memory_stat {
 	unsigned int idx;
 };
 
-static struct memory_stat memory_stats[] = {
+static const struct memory_stat memory_stats[] = {
 	{ "anon", PAGE_SIZE, NR_ANON_MAPPED },
 	{ "file", PAGE_SIZE, NR_FILE_PAGES },
 	{ "kernel_stack", 1, NR_KERNEL_STACK_B },
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
index fabdbb340806..8fb9f3d38b67 100644
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

