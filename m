Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 560767E279
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 20:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732904AbfHASnY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 14:43:24 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58938 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733225AbfHASnV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 14:43:21 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71IgBIa001277
        for <linux-fsdevel@vger.kernel.org>; Thu, 1 Aug 2019 11:43:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=AzYai9sTcIKTsjMHtj4n9MazMkcrW4fTxycCVLF20+Q=;
 b=PFEjq2jjC9LTyDyDwNC7HQFn1A/r25tzdX3bUfGIUvc2iC20XaQqeApxuSuSKTxL8YcM
 /zXquoKzDH5QrHVenNuHrklRnI5oTJkTte6rI6x8OEAZ/I8kO9wd8R6Iw57+LTZjwMnV
 lTblVg9TuIpzjqqzAfZzPj+BkLVDW3XFkvI= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2u427wrwcg-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Aug 2019 11:43:19 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 1 Aug 2019 11:43:15 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 527C562E1E18; Thu,  1 Aug 2019 11:43:13 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <matthew.wilcox@oracle.com>, <kirill.shutemov@linux.intel.com>,
        <kernel-team@fb.com>, <william.kucharski@oracle.com>,
        <akpm@linux-foundation.org>, <hdanton@sina.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v10 5/7] khugepaged: rename collapse_shmem() and khugepaged_scan_shmem()
Date:   Thu, 1 Aug 2019 11:42:42 -0700
Message-ID: <20190801184244.3169074-6-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801184244.3169074-1-songliubraving@fb.com>
References: <20190801184244.3169074-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=647 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010194
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Next patch will add khugepaged support of non-shmem files. This patch
renames these two functions to reflect the new functionality:

    collapse_shmem()        =>  collapse_file()
    khugepaged_scan_shmem() =>  khugepaged_scan_file()

Acked-by: Rik van Riel <riel@surriel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 mm/khugepaged.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b9949014346b..9d3cc2061960 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1426,7 +1426,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 }
 
 /**
- * collapse_shmem - collapse small tmpfs/shmem pages into huge one.
+ * collapse_file - collapse small tmpfs/shmem pages into huge one.
  *
  * Basic scheme is simple, details are more complex:
  *  - allocate and lock a new huge page;
@@ -1443,10 +1443,11 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
  *    + restore gaps in the page cache;
  *    + unlock and free huge page;
  */
-static void collapse_shmem(struct mm_struct *mm,
-		struct address_space *mapping, pgoff_t start,
+static void collapse_file(struct mm_struct *mm,
+		struct file *file, pgoff_t start,
 		struct page **hpage, int node)
 {
+	struct address_space *mapping = file->f_mapping;
 	gfp_t gfp;
 	struct page *new_page;
 	struct mem_cgroup *memcg;
@@ -1702,11 +1703,11 @@ static void collapse_shmem(struct mm_struct *mm,
 	/* TODO: tracepoints */
 }
 
-static void khugepaged_scan_shmem(struct mm_struct *mm,
-		struct address_space *mapping,
-		pgoff_t start, struct page **hpage)
+static void khugepaged_scan_file(struct mm_struct *mm,
+		struct file *file, pgoff_t start, struct page **hpage)
 {
 	struct page *page = NULL;
+	struct address_space *mapping = file->f_mapping;
 	XA_STATE(xas, &mapping->i_pages, start);
 	int present, swap;
 	int node = NUMA_NO_NODE;
@@ -1770,16 +1771,15 @@ static void khugepaged_scan_shmem(struct mm_struct *mm,
 			result = SCAN_EXCEED_NONE_PTE;
 		} else {
 			node = khugepaged_find_target_node();
-			collapse_shmem(mm, mapping, start, hpage, node);
+			collapse_file(mm, file, start, hpage, node);
 		}
 	}
 
 	/* TODO: tracepoints */
 }
 #else
-static void khugepaged_scan_shmem(struct mm_struct *mm,
-		struct address_space *mapping,
-		pgoff_t start, struct page **hpage)
+static void khugepaged_scan_file(struct mm_struct *mm,
+		struct file *file, pgoff_t start, struct page **hpage)
 {
 	BUILD_BUG();
 }
@@ -1862,8 +1862,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
 				file = get_file(vma->vm_file);
 				up_read(&mm->mmap_sem);
 				ret = 1;
-				khugepaged_scan_shmem(mm, file->f_mapping,
-						pgoff, hpage);
+				khugepaged_scan_file(mm, file, pgoff, hpage);
 				fput(file);
 			} else {
 				ret = khugepaged_scan_pmd(mm, vma,
-- 
2.17.1

