Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32092DCB75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 04:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgLQDrL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 22:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728491AbgLQDrK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 22:47:10 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86E7C0611E4
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Dec 2020 19:46:13 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id s2so14382119plr.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Dec 2020 19:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uCtNZ3XPH5CZg3kErhLn4u4ZqNgApfd/QZFgeqYuuAI=;
        b=pcm4215a4X2RNo2dZf7EyXAAYC5KGczkCgIidM57M+/r2ke+P81Ojx8ebrNuwXoYdh
         blqdQ0Fy9Y19G0wNejnxAoH+PRL3/buG8NTNh4djOaI8sHDZFOnaATngcnevJwtKOhXm
         NYZwdtZ05PtuL5ve9dpyV+kRtyfehzRh2B3179sLk6U2mx3joFvWEicyjiaiiv5Y23Wm
         62xm6axFw7nYZ0fMoAnxktTa8c/FcyXJBayaP0OqrNjKjRpzm6YWI9uNZQYnuHjoYjX7
         qhDfJrWK/nJTNhsqmXj3i3UgwFpL2MZTzKipwmpSOLYcw/avMBVh4r+EkK0ydX2WO1rJ
         23Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uCtNZ3XPH5CZg3kErhLn4u4ZqNgApfd/QZFgeqYuuAI=;
        b=FHF2fFlfaYwlQJVo9zDnsvA1chBpJOzF44elLv0ExPUx2N1Nq30l+SICdTY05rwqln
         2VUydHIfbrozcfdNHu5sep5SCjyGWLgggmmEvXxPIrEXMSiy4jacGXYUqbhY40JPToi2
         PsIcYoBDOkzVyK525vCwn80Tinao1QoNzyQU7IYlJsgdNwjn5nFiayOCX8xhBDbcHrC0
         geRY34q6YK5oSknhgOqb7E0COF1ZQctY/dIn/UnZZkq0UZb7yw05sGehoYyFrWd31IOV
         W9XkMIRVBrh7nteTtFsvbcMNJYzb6z37Krd3VfbeTQqUbCwr/k4HC0CkaL6jKjslYZbG
         OwmQ==
X-Gm-Message-State: AOAM533zTvnnkT0N9bVKhJikBvKWG1X+/BI62RqSpDRbND3Zs8tzEB8K
        Jjz8jwtngR42pjb82vb7KeS51Q==
X-Google-Smtp-Source: ABdhPJydrabIcHW4vN8GmUTqrv2fTW8jWRUbABXMbydTMp3cZy/rFGk/PqA2SCgBGY+rBTpsfQILIw==
X-Received: by 2002:a17:90a:73c5:: with SMTP id n5mr5948234pjk.118.1608176773175;
        Wed, 16 Dec 2020 19:46:13 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id b2sm3792412pfo.164.2020.12.16.19.46.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Dec 2020 19:46:12 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, shakeelb@google.com,
        guro@fb.com, samitolvanen@google.com, feng.tang@intel.com,
        neilb@suse.de, iamjoonsoo.kim@lge.com, rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 5/7] mm: memcontrol: convert NR_SHMEM_PMDMAPPED account to pages
Date:   Thu, 17 Dec 2020 11:43:54 +0800
Message-Id: <20201217034356.4708-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201217034356.4708-1-songmuchun@bytedance.com>
References: <20201217034356.4708-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently we use struct per_cpu_nodestat to cache the vmstat
counters, which leads to inaccurate statistics expecially THP
vmstat counters. In the systems with hundreads of processors
it can be GBs of memory. For example, for a 96 CPUs system,
the threshold is the maximum number of 125. And the per cpu
counters can cache 23.4375 GB in total.

The THP page is already a form of batched addition (it will
add 512 worth of memory in one go) so skipping the batching
seems like sensible. Although every THP stats update overflows
the per-cpu counter, resorting to atomic global updates. But
it can make the statistics more accuracy for the THP vmstat
counters.

So we convert the NR_SHMEM_PMDMAPPED account to pages. This
patch is consistent with 8f182270dfec ("mm/swap.c: flush lru
pvecs on compound page arrival"). Doing this also can make the
unit of vmstat counters more unified. Finally, the unit of the
vmstat counters are pages, kB and bytes. The B/KB suffix can
tell us that the unit is bytes or kB. The rest which is without
suffix are pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/node.c    |  3 +--
 fs/proc/meminfo.c      |  2 +-
 include/linux/mmzone.h |  3 ++-
 mm/page_alloc.c        |  3 +--
 mm/rmap.c              | 14 ++++++++++----
 5 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 6d5ac6ffb6e1..7a66aefe4e46 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -463,8 +463,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     ,
 			     nid, K(node_page_state(pgdat, NR_ANON_THPS)),
 			     nid, K(node_page_state(pgdat, NR_SHMEM_THPS)),
-			     nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED) *
-				    HPAGE_PMD_NR),
+			     nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)),
 			     nid, K(node_page_state(pgdat, NR_FILE_THPS)),
 			     nid, K(node_page_state(pgdat, NR_FILE_PMDMAPPED) *
 				    HPAGE_PMD_NR)
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index cfb107eaa3e6..c61f440570f9 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -133,7 +133,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "ShmemHugePages: ",
 		    global_node_page_state(NR_SHMEM_THPS));
 	show_val_kb(m, "ShmemPmdMapped: ",
-		    global_node_page_state(NR_SHMEM_PMDMAPPED) * HPAGE_PMD_NR);
+		    global_node_page_state(NR_SHMEM_PMDMAPPED));
 	show_val_kb(m, "FileHugePages:  ",
 		    global_node_page_state(NR_FILE_THPS));
 	show_val_kb(m, "FilePmdMapped:  ",
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 3b45f39011ab..1ca6a34f6a4a 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -218,7 +218,8 @@ static __always_inline bool vmstat_item_print_in_thp(enum node_stat_item item)
 {
 	return item == NR_ANON_THPS ||
 	       item == NR_FILE_THPS ||
-	       item == NR_SHMEM_THPS;
+	       item == NR_SHMEM_THPS ||
+	       item == NR_SHMEM_PMDMAPPED;
 }
 
 /*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 720fb5a220b6..575fbfeea4b5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5578,8 +5578,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(node_page_state(pgdat, NR_SHMEM)),
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 			K(node_page_state(pgdat, NR_SHMEM_THPS)),
-			K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)
-					* HPAGE_PMD_NR),
+			K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)),
 			K(node_page_state(pgdat, NR_ANON_THPS)),
 #endif
 			K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
diff --git a/mm/rmap.c b/mm/rmap.c
index c4d5c63cfd29..1c1b576c0627 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1211,14 +1211,17 @@ void page_add_file_rmap(struct page *page, bool compound)
 	VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
 	lock_page_memcg(page);
 	if (compound && PageTransHuge(page)) {
-		for (i = 0, nr = 0; i < thp_nr_pages(page); i++) {
+		int nr_pages = thp_nr_pages(page);
+
+		for (i = 0, nr = 0; i < nr_pages; i++) {
 			if (atomic_inc_and_test(&page[i]._mapcount))
 				nr++;
 		}
 		if (!atomic_inc_and_test(compound_mapcount_ptr(page)))
 			goto out;
 		if (PageSwapBacked(page))
-			__inc_node_page_state(page, NR_SHMEM_PMDMAPPED);
+			__mod_lruvec_page_state(page, NR_SHMEM_PMDMAPPED,
+						nr_pages);
 		else
 			__inc_node_page_state(page, NR_FILE_PMDMAPPED);
 	} else {
@@ -1252,14 +1255,17 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 
 	/* page still mapped by someone else? */
 	if (compound && PageTransHuge(page)) {
-		for (i = 0, nr = 0; i < thp_nr_pages(page); i++) {
+		int nr_pages = thp_nr_pages(page);
+
+		for (i = 0, nr = 0; i < nr_pages; i++) {
 			if (atomic_add_negative(-1, &page[i]._mapcount))
 				nr++;
 		}
 		if (!atomic_add_negative(-1, compound_mapcount_ptr(page)))
 			return;
 		if (PageSwapBacked(page))
-			__dec_node_page_state(page, NR_SHMEM_PMDMAPPED);
+			__mod_lruvec_page_state(page, NR_SHMEM_PMDMAPPED,
+						-nr_pages);
 		else
 			__dec_node_page_state(page, NR_FILE_PMDMAPPED);
 	} else {
-- 
2.11.0

