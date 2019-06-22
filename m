Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B31C04F27A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2019 02:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfFVAFx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jun 2019 20:05:53 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:31210 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727050AbfFVAF1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jun 2019 20:05:27 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5LNsfCk018831
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2019 17:05:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=DNX0Ai841ZgyA6yG9XH0uRWq8DS0N63a6b+fvROsjjM=;
 b=YCqTrT/JYASHpQEOOYkGYg92c16QN3f691f37DMGfg7VNFrKhjAdtGuCBrvVxwNr09w6
 tohmnJ9WfVpElA6TQNfZEgq+itS38qXPwRjZ2zVNgQqSCnX5WEYxVtIX2JEJz15kdQua
 U1qRg8bLRHjdvvworvkgyXymApb4yBziE8Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2t91rg1qmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2019 17:05:26 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 21 Jun 2019 17:05:25 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id DCC9D62E2D56; Fri, 21 Jun 2019 17:05:24 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <matthew.wilcox@oracle.com>, <kirill.shutemov@linux.intel.com>,
        <kernel-team@fb.com>, <william.kucharski@oracle.com>,
        <akpm@linux-foundation.org>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v6 3/6] mm,thp: stats for file backed THP
Date:   Fri, 21 Jun 2019 17:05:09 -0700
Message-ID: <20190622000512.923867-4-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190622000512.923867-1-songliubraving@fb.com>
References: <20190622000512.923867-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-21_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906210182
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for non-shmem THP, this patch adds a few stats and exposes
them in /proc/meminfo, /sys/bus/node/devices/<node>/meminfo, and
/proc/<pid>/task/<tid>/smaps.

This patch is mostly a rewrite of Kirill A. Shutemov's earlier version:
https://lkml.org/lkml/2017/1/26/284.

Acked-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 drivers/base/node.c    | 6 ++++++
 fs/proc/meminfo.c      | 4 ++++
 fs/proc/task_mmu.c     | 4 +++-
 include/linux/mmzone.h | 2 ++
 mm/vmstat.c            | 2 ++
 5 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 8598fcbd2a17..71ae2dc93489 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -426,6 +426,8 @@ static ssize_t node_read_meminfo(struct device *dev,
 		       "Node %d AnonHugePages:  %8lu kB\n"
 		       "Node %d ShmemHugePages: %8lu kB\n"
 		       "Node %d ShmemPmdMapped: %8lu kB\n"
+		       "Node %d FileHugePages: %8lu kB\n"
+		       "Node %d FilePmdMapped: %8lu kB\n"
 #endif
 			,
 		       nid, K(node_page_state(pgdat, NR_FILE_DIRTY)),
@@ -451,6 +453,10 @@ static ssize_t node_read_meminfo(struct device *dev,
 		       nid, K(node_page_state(pgdat, NR_SHMEM_THPS) *
 				       HPAGE_PMD_NR),
 		       nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED) *
+				       HPAGE_PMD_NR),
+		       nid, K(node_page_state(pgdat, NR_FILE_THPS) *
+				       HPAGE_PMD_NR),
+		       nid, K(node_page_state(pgdat, NR_FILE_PMDMAPPED) *
 				       HPAGE_PMD_NR)
 #endif
 		       );
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 568d90e17c17..bac395fc11f9 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -136,6 +136,10 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 		    global_node_page_state(NR_SHMEM_THPS) * HPAGE_PMD_NR);
 	show_val_kb(m, "ShmemPmdMapped: ",
 		    global_node_page_state(NR_SHMEM_PMDMAPPED) * HPAGE_PMD_NR);
+	show_val_kb(m, "FileHugePages: ",
+		    global_node_page_state(NR_FILE_THPS) * HPAGE_PMD_NR);
+	show_val_kb(m, "FilePmdMapped: ",
+		    global_node_page_state(NR_FILE_PMDMAPPED) * HPAGE_PMD_NR);
 #endif
 
 #ifdef CONFIG_CMA
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 01d4eb0e6bd1..0360e3b2ba89 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -413,6 +413,7 @@ struct mem_size_stats {
 	unsigned long lazyfree;
 	unsigned long anonymous_thp;
 	unsigned long shmem_thp;
+	unsigned long file_thp;
 	unsigned long swap;
 	unsigned long shared_hugetlb;
 	unsigned long private_hugetlb;
@@ -563,7 +564,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	else if (is_zone_device_page(page))
 		/* pass */;
 	else
-		VM_BUG_ON_PAGE(1, page);
+		mss->file_thp += HPAGE_PMD_SIZE;
 	smaps_account(mss, page, true, pmd_young(*pmd), pmd_dirty(*pmd), locked);
 }
 #else
@@ -767,6 +768,7 @@ static void __show_smap(struct seq_file *m, const struct mem_size_stats *mss)
 	SEQ_PUT_DEC(" kB\nLazyFree:       ", mss->lazyfree);
 	SEQ_PUT_DEC(" kB\nAnonHugePages:  ", mss->anonymous_thp);
 	SEQ_PUT_DEC(" kB\nShmemPmdMapped: ", mss->shmem_thp);
+	SEQ_PUT_DEC(" kB\nFilePmdMapped: ", mss->file_thp);
 	SEQ_PUT_DEC(" kB\nShared_Hugetlb: ", mss->shared_hugetlb);
 	seq_put_decimal_ull_width(m, " kB\nPrivate_Hugetlb: ",
 				  mss->private_hugetlb >> 10, 7);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 70394cabaf4e..827f9b777938 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -234,6 +234,8 @@ enum node_stat_item {
 	NR_SHMEM,		/* shmem pages (included tmpfs/GEM pages) */
 	NR_SHMEM_THPS,
 	NR_SHMEM_PMDMAPPED,
+	NR_FILE_THPS,
+	NR_FILE_PMDMAPPED,
 	NR_ANON_THPS,
 	NR_UNSTABLE_NFS,	/* NFS unstable pages */
 	NR_VMSCAN_WRITE,
diff --git a/mm/vmstat.c b/mm/vmstat.c
index fd7e16ca6996..6afc892a148a 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1158,6 +1158,8 @@ const char * const vmstat_text[] = {
 	"nr_shmem",
 	"nr_shmem_hugepages",
 	"nr_shmem_pmdmapped",
+	"nr_file_hugepages",
+	"nr_file_pmdmapped",
 	"nr_anon_transparent_hugepages",
 	"nr_unstable",
 	"nr_vmscan_write",
-- 
2.17.1

