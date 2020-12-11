Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DC52D6F2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 05:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395389AbgLKEYp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 23:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395371AbgLKEY1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 23:24:27 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51128C06138C
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 20:23:25 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 11so6205993pfu.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 20:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+zNdjlNjaGbBbTl1joNFBgmnXlFZ8pwX/30snPIOtJc=;
        b=1XiX5y0gJqbD5SSIiumZ0LyPZNM1ekosj+wN+jmqz4Ib2jLVWgjuCp2gKxmvofctEf
         o3J0QyOC89ir8SyzeYt99WS5VUbpEO1OD0lVZwJV11nzX8zLpcPF4Aat9WzIpoDxUZ/D
         AnUZwFPC04zWG63iJBONvyedsRogVFB1S6ZRxCLS8ywA8NY36S94ra0DufLlrOnRnawL
         W4ZogsZtWEgQYVR2y4tzXeLpigm1HAJSHvf7pfe41BBxlbcpPfbdLyLo1YVH9Udzs+f5
         Jkyy5hE2kUJeB3FLEnOglA71C3Z67W5YhPHafNMjSIs6bvYaooS0m2QwqcioXcEm+dQA
         ielA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+zNdjlNjaGbBbTl1joNFBgmnXlFZ8pwX/30snPIOtJc=;
        b=kkebhQn8eKR+x2U5xhLUbgEDwzyRFiGhahysHT9m3qS7T12YP7eLWshcypI4iK1wn7
         xm7Z4MAUsoUgYDDb/6Kvo/8m4Lx1WfgnuiDQgX+VVTLYLCEQ+XQ9uxRfsmQwcM1YOuqt
         U7MbIS7ySDCLkVZfzOMgwdzjswb+xH+B9XcJbybHh/e+X1dcYDWGlv5Ck/H3hIre7ADF
         l76g4AD8sbbZvd7x5qrJhUEdaXpNt1PolPP1Ef8lzjLGjkPJOTpj8TPJhQnvADmtjZFb
         ne5LJAT//BU6lNl9lJ/r7xsiSHITLH7nBNRH4LDfdkTcEvaW2LMKn+RHsFBG7FjU0Cae
         o0hQ==
X-Gm-Message-State: AOAM533TFDsU4xM9bRqkTBlsnZtwUEr8kbMWmHHlVBlWJFG8Ek+gOQaO
        0hDSJAb83kKfi8utE+Cvi0O0Ow==
X-Google-Smtp-Source: ABdhPJxr55yXFTu3oGTg5HJKqTWWlt1XbAYA22QdUZ72kpiYjt+UFd6FsjrFKMq14umappTGj9ibRA==
X-Received: by 2002:a63:da03:: with SMTP id c3mr9789954pgh.133.1607660604856;
        Thu, 10 Dec 2020 20:23:24 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.66])
        by smtp.gmail.com with ESMTPSA id 19sm8623352pfu.85.2020.12.10.20.23.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Dec 2020 20:23:24 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, shakeelb@google.com,
        guro@fb.com, samitolvanen@google.com, feng.tang@intel.com,
        neilb@suse.de, iamjoonsoo.kim@lge.com, rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 3/7] mm: memcontrol: convert NR_FILE_THPS account to pages
Date:   Fri, 11 Dec 2020 12:19:50 +0800
Message-Id: <20201211041954.79543-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201211041954.79543-1-songmuchun@bytedance.com>
References: <20201211041954.79543-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The unit of NR_FILE_THPS is HPAGE_PMD_NR. Converrt NR_FILE_THPS
account to pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/node.c    | 3 +--
 fs/proc/meminfo.c      | 2 +-
 include/linux/mmzone.h | 3 ++-
 mm/filemap.c           | 2 +-
 mm/huge_memory.c       | 3 ++-
 mm/khugepaged.c        | 2 +-
 mm/memcontrol.c        | 5 ++---
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 6da0c3508bc9..d5952f754911 100644
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
index a635c8a84ddf..7ea4679880c8 100644
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
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 4ac95448421c..67b6598c9ea4 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -215,7 +215,8 @@ enum node_stat_item {
  */
 static __always_inline bool vmstat_item_print_in_thp(enum node_stat_item item)
 {
-	return item == NR_ANON_THPS;
+	return item == NR_ANON_THPS ||
+	       item == NR_FILE_THPS;
 }
 
 /*
diff --git a/mm/filemap.c b/mm/filemap.c
index 78090ee08ac2..9cc8b3ac9eac 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -207,7 +207,7 @@ static void unaccount_page_cache_page(struct address_space *mapping,
 		if (PageTransHuge(page))
 			__dec_lruvec_page_state(page, NR_SHMEM_THPS);
 	} else if (PageTransHuge(page)) {
-		__dec_lruvec_page_state(page, NR_FILE_THPS);
+		__mod_lruvec_page_state(page, NR_FILE_THPS, -HPAGE_PMD_NR);
 		filemap_nr_thps_dec(mapping);
 	}
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 66ec454120de..1e24165fa53a 100644
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
index 494d3cb0b58a..76b3e064a72a 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1869,7 +1869,7 @@ static void collapse_file(struct mm_struct *mm,
 	if (is_shmem)
 		__inc_lruvec_page_state(new_page, NR_SHMEM_THPS);
 	else {
-		__inc_lruvec_page_state(new_page, NR_FILE_THPS);
+		__mod_lruvec_page_state(new_page, NR_FILE_THPS, HPAGE_PMD_NR);
 		filemap_nr_thps_inc(mapping);
 	}
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b18e25a5cdf3..04985c8c6a0a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1533,7 +1533,7 @@ static struct memory_stat memory_stats[] = {
 	 * constant(e.g. powerpc).
 	 */
 	{ "anon_thp", PAGE_SIZE, NR_ANON_THPS },
-	{ "file_thp", 0, NR_FILE_THPS },
+	{ "file_thp", PAGE_SIZE, NR_FILE_THPS },
 	{ "shmem_thp", 0, NR_SHMEM_THPS },
 #endif
 	{ "inactive_anon", PAGE_SIZE, NR_INACTIVE_ANON },
@@ -1565,8 +1565,7 @@ static int __init memory_stats_init(void)
 
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

