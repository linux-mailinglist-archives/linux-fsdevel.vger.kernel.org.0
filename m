Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5BC2CFCE2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Dec 2020 19:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgLESTY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Dec 2020 13:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbgLERx0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Dec 2020 12:53:26 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC76EC094256
        for <linux-fsdevel@vger.kernel.org>; Sat,  5 Dec 2020 05:03:26 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id f17so5310742pge.6
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Dec 2020 05:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OePvIMZNKUN5Y3sDnnNomk9XQLTkzEVnsUhWUrUZogc=;
        b=WoXWAA5JojNk8kyuAW6gJqdYWZlwQnOCLR7Q5khaKLVJcZPcegnRLzSkXjT9L44vo4
         gMebG3LUcJpd2o/hfnDrx4QCainJdKIEHFCRezmXO/GNHXBG9b2zM/Yco6il+mw18Asw
         tpK8F/iN8ncgW1Sxop6wxdpkNTxUPGdYyCudrLqVxLPR593KPuLvVBTG5O2waEp4DfcD
         s3KeMl2fsXxi7SgNOuX/HFQh9P1829Cd5x34/Bgx20Ck01y1SManhV9Mt+5pthxcfMdS
         GjItzyfUc2ZeOaiZrxZIVCKUoTsPsOpkHw/r/BPFjr0rpuXXqpMbDQgJQMkzu0tXt1jK
         uJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OePvIMZNKUN5Y3sDnnNomk9XQLTkzEVnsUhWUrUZogc=;
        b=Y3MKSjNol5/Vyi5pLB33iJ4tx1GMRaWzUwbGHxS6gdujEWp3DkKVlYNuDmo09uZpB7
         dTHAN/3pJR/XW5ujDMUNfKWB5o8AaddA+7WqA66O49SK9BoCfZBhLn3a+gOcx69/HETb
         +476hrt3Em6nhMSauDAtaUpHzqAvfyDPKPhhPmyMUWRcuajO9zP90Ln2aIw1qIXxa0e5
         o+Gi3vfqLGUTKjs1+sl/LbTvSw5QIaqmqgTCz9IBuSxaTBjQQu6ILGR4IFR95B3d6AOp
         ShP8cfN3kDIjII4gHiYfC3tBepjBzJ48cRMXo1nz1/ncAVioI3u80nPeBWBWbfUIBLPa
         fy4g==
X-Gm-Message-State: AOAM532GWMUyE8kec1kBe59J4f1uswXWZ0gBDwQXWzlaw1VApmfHKEf9
        UlnIB34KCUg70ohd6eoPr2+/Ig==
X-Google-Smtp-Source: ABdhPJx3PGE321iKpyLYXtBK9QOB0oxnrpnk2BUwF7TQjHOd7yU12KO+bBfach6O7MPRuv53jDc8aA==
X-Received: by 2002:a63:985:: with SMTP id 127mr11363907pgj.449.1607173406403;
        Sat, 05 Dec 2020 05:03:26 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.220.120])
        by smtp.gmail.com with ESMTPSA id kb12sm5047790pjb.2.2020.12.05.05.03.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Dec 2020 05:03:25 -0800 (PST)
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
Subject: [PATCH 5/9] mm: memcontrol: convert NR_FILE_THPS account to pages
Date:   Sat,  5 Dec 2020 21:02:20 +0800
Message-Id: <20201205130224.81607-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201205130224.81607-1-songmuchun@bytedance.com>
References: <20201205130224.81607-1-songmuchun@bytedance.com>
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
index 05c369e93e16..f6a9521bbcf8 100644
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
index f447ac191d24..9b2cb770326e 100644
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
index 39cb7f1b00d3..dce76dddac61 100644
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

