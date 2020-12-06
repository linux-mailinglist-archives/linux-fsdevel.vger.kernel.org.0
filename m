Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D133D2D0292
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 11:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgLFKSY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 05:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbgLFKSX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 05:18:23 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FDAC08C5F2
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Dec 2020 02:17:17 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id q3so6467733pgr.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Dec 2020 02:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i2WmQI9Q0soqzGFU1vD0NNfzSFXtCmp1bcFtyNd4sgI=;
        b=Ms1jKhSa+qgJDEXhLIQ4samWqeYhB2vhUcYFQ9kIBfeKOFDxvVzFk87TrixWrRD6Rr
         +vaXPRp3mQ8tdRqpuDAFtslhGGYCDSz9lAeIhR+7d3Au95mDEpciTi58EJCUbOV74boF
         irHf7UgHfqeYxqPOZMX694NrAsulQCs6XWfG4XayIwUmc6E7MAPpDhiT8R6HB7wMt/sK
         SNrLW1p5/PnRMUlJ+0fav+HcOTb1EAz0rIYHqUEVW3GpZpT1zdHfzbuDuyQrNuUcrO3L
         MmsEJi3uDyzEQa2sWlVjoK6VcSbmc9uIkM5UCU+YCzAwjoR5Wi2Lk1tuSgR+J6AkErEc
         KAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i2WmQI9Q0soqzGFU1vD0NNfzSFXtCmp1bcFtyNd4sgI=;
        b=dCCY536UorofQDUORJzW8iuUSfHGsvMsELtsyLfD4PTnwCQO6hqvCXjFgl0LXdtkdC
         r8vHXZttJgKry6ykKNekPILMnXXdttS0EXF2kaglhmor/xuiKNqrmyvPunXqfYpIGsSc
         eFw6bP5NGX1KQL24TR25ddnR+1IbVX1KrPPMgsZxNEND1DGEYHxHlM+IXUhzXro4IUdC
         FNRT8uEi7wXk27Ty4qNI8tyyDLDtRnE/wOSyuxbiEJ9zpE/oq2wbguuARd/4fCMLEB+X
         cPBOetYEdYiKDdr0gpfZSzAonPup0QmwU3HuaFQ0wUrCBUkkLS9mdTBoYBDT4KoaSZTg
         OSPA==
X-Gm-Message-State: AOAM532IZ0LX2Rkdb13vLAkiq/YtzNr4M50E2pLYmKTNVS601+2QQOCe
        ANvPLQNRuzJ+/Bza8N8F7NIJrg==
X-Google-Smtp-Source: ABdhPJxX4VV3xHN6Lrb6jwWVudCM8xvy7cP+M5Gcg95AHBIo8KyIJoYWtLsufEfRR9NNE3e7JelnGw==
X-Received: by 2002:a62:8f03:0:b029:18c:968a:4cf9 with SMTP id n3-20020a628f030000b029018c968a4cf9mr11487716pfd.59.1607249836594;
        Sun, 06 Dec 2020 02:17:16 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id g16sm10337657pfb.201.2020.12.06.02.17.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 02:17:16 -0800 (PST)
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
Subject: [RESEND PATCH v2 03/12] mm: memcontrol: convert NR_FILE_THPS account to pages
Date:   Sun,  6 Dec 2020 18:14:42 +0800
Message-Id: <20201206101451.14706-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201206101451.14706-1-songmuchun@bytedance.com>
References: <20201206101451.14706-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Converrt NR_FILE_THPS account to pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/node.c | 3 +--
 fs/proc/meminfo.c   | 2 +-
 mm/filemap.c        | 2 +-
 mm/huge_memory.c    | 3 ++-
 mm/khugepaged.c     | 2 +-
 mm/memcontrol.c     | 5 ++---
 6 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 7ebe4c2f64d1..2db28acdaa4f 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -466,8 +466,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 				    HPAGE_PMD_NR),
 			     nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED) *
 				    HPAGE_PMD_NR),
-			     nid, K(node_page_state(pgdat, NR_FILE_THPS) *
-				    HPAGE_PMD_NR),
+			     nid, K(node_page_state(pgdat, NR_FILE_THPS)),
 			     nid, K(node_page_state(pgdat, NR_FILE_PMDMAPPED) *
 				    HPAGE_PMD_NR)
 #endif
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 1f7e1945c313..f4157f26cbf5 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -135,7 +135,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "ShmemPmdMapped: ",
 		    global_node_page_state(NR_SHMEM_PMDMAPPED) * HPAGE_PMD_NR);
 	show_val_kb(m, "FileHugePages:  ",
-		    global_node_page_state(NR_FILE_THPS) * HPAGE_PMD_NR);
+		    global_node_page_state(NR_FILE_THPS));
 	show_val_kb(m, "FilePmdMapped:  ",
 		    global_node_page_state(NR_FILE_PMDMAPPED) * HPAGE_PMD_NR);
 #endif
diff --git a/mm/filemap.c b/mm/filemap.c
index 28e7309c29c8..c4dcb1144883 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -206,7 +206,7 @@ static void unaccount_page_cache_page(struct address_space *mapping,
 		if (PageTransHuge(page))
 			__dec_lruvec_page_state(page, NR_SHMEM_THPS);
 	} else if (PageTransHuge(page)) {
-		__dec_lruvec_page_state(page, NR_FILE_THPS);
+		__mod_lruvec_page_state(page, NR_FILE_THPS, -HPAGE_PMD_NR);
 		filemap_nr_thps_dec(mapping);
 	}
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1a13e1dab3ec..37840bdeaad0 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2748,7 +2748,8 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 			if (PageSwapBacked(head))
 				__dec_lruvec_page_state(head, NR_SHMEM_THPS);
 			else
-				__dec_lruvec_page_state(head, NR_FILE_THPS);
+				__mod_lruvec_page_state(head, NR_FILE_THPS,
+							-HPAGE_PMD_NR);
 		}
 
 		__split_huge_page(page, list, end);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index ad316d2e1fee..1e1ced2208d0 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1859,7 +1859,7 @@ static void collapse_file(struct mm_struct *mm,
 	if (is_shmem)
 		__inc_lruvec_page_state(new_page, NR_SHMEM_THPS);
 	else {
-		__inc_lruvec_page_state(new_page, NR_FILE_THPS);
+		__mod_lruvec_page_state(new_page, NR_FILE_THPS, HPAGE_PMD_NR);
 		filemap_nr_thps_inc(mapping);
 	}
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2700c1db5a1a..c4557de2b211 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1514,7 +1514,7 @@ static struct memory_stat memory_stats[] = {
 	 * constant(e.g. powerpc).
 	 */
 	{ "anon_thp", PAGE_SIZE, NR_ANON_THPS },
-	{ "file_thp", 0, NR_FILE_THPS },
+	{ "file_thp", PAGE_SIZE, NR_FILE_THPS },
 	{ "shmem_thp", 0, NR_SHMEM_THPS },
 #endif
 	{ "inactive_anon", PAGE_SIZE, NR_INACTIVE_ANON },
@@ -1546,8 +1546,7 @@ static int __init memory_stats_init(void)
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-		if (memory_stats[i].idx == NR_FILE_THPS ||
-		    memory_stats[i].idx == NR_SHMEM_THPS)
+		if (memory_stats[i].idx == NR_SHMEM_THPS)
 			memory_stats[i].ratio = HPAGE_PMD_SIZE;
 #endif
 		VM_BUG_ON(!memory_stats[i].ratio);
-- 
2.11.0

