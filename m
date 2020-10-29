Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB96429F556
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 20:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgJ2TeM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 15:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgJ2TeK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:34:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1351BC0613D3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 12:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XOaTjVTgn8Ke6TW/15Kdkt6j4VR7ZhSGr7eWJqQULJg=; b=jbojzSwRofPkOkoavKlBB6etKE
        oKwiwOJBHnt8IE7ND7Yfl9vL32xfhR4qnQEv+sz7DwBMfod9FW5ivZq1oCFpNvgf5Vbc+FQ4sksOS
        v2hYpQMpqWPu02JNBWDsrjqzoSKEEC49u5htHt1SjBphd3CH7dqgdTG7eMiI14aG9YKNAWjlgyBsw
        pRVkh5j/zPXPkz/VlK9/HecZYO1l673HNjok7L7nieESidCigtnUqOTZtP9jKfLtL3HY4F2CGzE0f
        rgHmsLdAVbFeoP9ygr9SNWgf1wqT1V6GBGekXNJ11BJNfgg0QXAOTBmJC4Os59yfwUtVBNhTXN4ck
        1dMteOFA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYDgW-0007bN-FB; Thu, 29 Oct 2020 19:34:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 04/19] mm: Change NR_FILE_THPS to account in base pages
Date:   Thu, 29 Oct 2020 19:33:50 +0000
Message-Id: <20201029193405.29125-5-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201029193405.29125-1-willy@infradead.org>
References: <20201029193405.29125-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With variable sized THPs, we have to account in number of base pages,
not in number of PMD-sized pages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/base/node.c    | 3 +--
 fs/proc/meminfo.c      | 2 +-
 include/linux/mmzone.h | 2 +-
 mm/filemap.c           | 2 +-
 mm/huge_memory.c       | 3 ++-
 mm/khugepaged.c        | 3 ++-
 6 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 6ffa470e2984..6bcc2e7da775 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -467,8 +467,7 @@ static ssize_t node_read_meminfo(struct device *dev,
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
index 887a5532e449..d1ccee90f0e1 100644
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
index fb3bf696c05e..b0e2c546d5f5 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -193,7 +193,7 @@ enum node_stat_item {
 	NR_SHMEM,		/* shmem pages (included tmpfs/GEM pages) */
 	NR_SHMEM_THPS,
 	NR_SHMEM_PMDMAPPED,
-	NR_FILE_THPS,
+	NR_FILE_THPS,		/* Accounted in base pages */
 	NR_FILE_PMDMAPPED,
 	NR_ANON_THPS,
 	NR_VMSCAN_WRITE,
diff --git a/mm/filemap.c b/mm/filemap.c
index 8537ee86f99f..a68516ddeddc 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -194,7 +194,7 @@ static void unaccount_page_cache_page(struct address_space *mapping,
 		if (PageTransHuge(page))
 			__dec_lruvec_page_state(page, NR_SHMEM_THPS);
 	} else if (PageTransHuge(page)) {
-		__dec_lruvec_page_state(page, NR_FILE_THPS);
+		__mod_lruvec_page_state(page, NR_FILE_THPS, -nr);
 		filemap_nr_thps_dec(mapping);
 	}
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0e900e594e77..03374ec61b45 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2729,7 +2729,8 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 			if (PageSwapBacked(head))
 				__dec_lruvec_page_state(head, NR_SHMEM_THPS);
 			else
-				__dec_lruvec_page_state(head, NR_FILE_THPS);
+				__mod_lruvec_page_state(head, NR_FILE_THPS,
+						-thp_nr_pages(head));
 		}
 
 		__split_huge_page(page, list, end, flags);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 230e62a92ae7..74c90f5d352f 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1844,7 +1844,8 @@ static void collapse_file(struct mm_struct *mm,
 	if (is_shmem)
 		__inc_lruvec_page_state(new_page, NR_SHMEM_THPS);
 	else {
-		__inc_lruvec_page_state(new_page, NR_FILE_THPS);
+		__mod_lruvec_page_state(new_page, NR_FILE_THPS,
+				thp_nr_pages(new_page));
 		filemap_nr_thps_inc(mapping);
 	}
 
-- 
2.28.0

