Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0342C4FA5F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2019 07:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfFWFsL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Jun 2019 01:48:11 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16602 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726397AbfFWFsK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Jun 2019 01:48:10 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5N5gqs3018656
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Jun 2019 22:48:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=Kr37aYRy2KacRNeWnEOl8WIgUYHSnWgZ3fV+borBCvY=;
 b=aZXkBDUWBAxL6VM2VUmr2HhxlWoVql7hYob6GSLvl5bca4qxkLshU/ThbTI2qq8C0Zdl
 hYLatvDXMiRKVOA23zOhJz0n7mYr8EbPs7aVkeEFv/M0mn0/afxvtD7ZMtRlTsDLnOzg
 D+P+vBel+RxasIlfbOKqC1Qm4wgLJsdOxBE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2t9kmja0y2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Jun 2019 22:48:09 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 22 Jun 2019 22:48:07 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 34DE762E2CFB; Sat, 22 Jun 2019 22:48:02 -0700 (PDT)
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
Subject: [PATCH v7 4/6] khugepaged: rename collapse_shmem() and khugepaged_scan_shmem()
Date:   Sat, 22 Jun 2019 22:47:47 -0700
Message-ID: <20190623054749.4016638-5-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190623054749.4016638-1-songliubraving@fb.com>
References: <20190623054749.4016638-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=631 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906230050
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Next patch will add khugepaged support of non-shmem files. This patch
renames these two functions to reflect the new functionality:

    collapse_shmem()        =>  collapse_file()
    khugepaged_scan_shmem() =>  khugepaged_scan_file()

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 mm/khugepaged.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 0f7419938008..158cad542627 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1287,7 +1287,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 }
 
 /**
- * collapse_shmem - collapse small tmpfs/shmem pages into huge one.
+ * collapse_file - collapse small tmpfs/shmem pages into huge one.
  *
  * Basic scheme is simple, details are more complex:
  *  - allocate and lock a new huge page;
@@ -1304,10 +1304,11 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
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
@@ -1563,11 +1564,11 @@ static void collapse_shmem(struct mm_struct *mm,
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
@@ -1631,16 +1632,15 @@ static void khugepaged_scan_shmem(struct mm_struct *mm,
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
@@ -1722,8 +1722,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
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

