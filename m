Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9A24D53A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 19:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732340AbfFTR2a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jun 2019 13:28:30 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6058 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732342AbfFTR2Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:28:24 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5KHKJbt001684
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2019 10:28:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=hD2kmpWpjDtZ0Sd5qjALN5Ckzd1PVypTF/Ew4nsBLJo=;
 b=kTITvPU+VLMLvfdbMFDyZifEq4QY77unhvF7ZNsPRIYRVmsaTTAczOkMqjQbrW4KkNyx
 WRfB20b5+cNT/Nla5uSLnfp54+53I10+wQTxJ6BmSDrwxxjWvi59igHtflD1vYawgI+G
 1bHjUCkL41VroygCaOla9CU8Q2cjtAL1Z0U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2t7ur9kntm-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2019 10:28:23 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 20 Jun 2019 10:28:21 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 51AB362E2004; Thu, 20 Jun 2019 10:28:20 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <matthew.wilcox@oracle.com>, <kirill.shutemov@linux.intel.com>,
        <kernel-team@fb.com>, <william.kucharski@oracle.com>,
        <akpm@linux-foundation.org>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v4 6/6] mm,thp: avoid writes to file with THP in pagecache
Date:   Thu, 20 Jun 2019 10:27:52 -0700
Message-ID: <20190620172752.3300742-7-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620172752.3300742-1-songliubraving@fb.com>
References: <20190620172752.3300742-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-20_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=792 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906200124
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In previous patch, an application could put part of its text section in
THP via madvise(). These THPs will be protected from writes when the
application is still running (TXTBSY). However, after the application
exits, the file is available for writes.

This patch avoids writes to file THP by dropping page cache for the file
when the last vma with VM_DENYWRITE is removed. A new counter nr_thps is
added to struct address_space. In exit_mmap(), if nr_thps is non-zero, we
drop page cache for the whole file.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 fs/inode.c         |  3 +++
 include/linux/fs.h | 31 +++++++++++++++++++++++++++++++
 mm/filemap.c       |  1 +
 mm/khugepaged.c    |  4 +++-
 mm/mmap.c          | 14 ++++++++++++++
 5 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index df6542ec3b88..518113a4e219 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -181,6 +181,9 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	mapping->flags = 0;
 	mapping->wb_err = 0;
 	atomic_set(&mapping->i_mmap_writable, 0);
+#ifdef CONFIG_READ_ONLY_THP_FOR_FS
+	atomic_set(&mapping->nr_thps, 0);
+#endif
 	mapping_set_gfp_mask(mapping, GFP_HIGHUSER_MOVABLE);
 	mapping->private_data = NULL;
 	mapping->writeback_index = 0;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f7fdfe93e25d..3edf4ee42eee 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -444,6 +444,10 @@ struct address_space {
 	struct xarray		i_pages;
 	gfp_t			gfp_mask;
 	atomic_t		i_mmap_writable;
+#ifdef CONFIG_READ_ONLY_THP_FOR_FS
+	/* number of thp, only for non-shmem files */
+	atomic_t		nr_thps;
+#endif
 	struct rb_root_cached	i_mmap;
 	struct rw_semaphore	i_mmap_rwsem;
 	unsigned long		nrpages;
@@ -2790,6 +2794,33 @@ static inline errseq_t filemap_sample_wb_err(struct address_space *mapping)
 	return errseq_sample(&mapping->wb_err);
 }
 
+static inline int filemap_nr_thps(struct address_space *mapping)
+{
+#ifdef CONFIG_READ_ONLY_THP_FOR_FS
+	return atomic_read(&mapping->nr_thps);
+#else
+	return 0;
+#endif
+}
+
+static inline void filemap_nr_thps_inc(struct address_space *mapping)
+{
+#ifdef CONFIG_READ_ONLY_THP_FOR_FS
+	atomic_inc(&mapping->nr_thps);
+#else
+	WARN_ON_ONCE(1);
+#endif
+}
+
+static inline void filemap_nr_thps_dec(struct address_space *mapping)
+{
+#ifdef CONFIG_READ_ONLY_THP_FOR_FS
+	atomic_dec(&mapping->nr_thps);
+#else
+	WARN_ON_ONCE(1);
+#endif
+}
+
 extern int vfs_fsync_range(struct file *file, loff_t start, loff_t end,
 			   int datasync);
 extern int vfs_fsync(struct file *file, int datasync);
diff --git a/mm/filemap.c b/mm/filemap.c
index e79ceccdc6df..a8e86c136381 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -205,6 +205,7 @@ static void unaccount_page_cache_page(struct address_space *mapping,
 			__dec_node_page_state(page, NR_SHMEM_THPS);
 	} else if (PageTransHuge(page)) {
 		__dec_node_page_state(page, NR_FILE_THPS);
+		filemap_nr_thps_dec(mapping);
 	}
 
 	/*
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index fbcff5a1d65a..17ebe9da56ce 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1500,8 +1500,10 @@ static void collapse_file(struct vm_area_struct *vma,
 
 	if (is_shmem)
 		__inc_node_page_state(new_page, NR_SHMEM_THPS);
-	else
+	else {
 		__inc_node_page_state(new_page, NR_FILE_THPS);
+		filemap_nr_thps_inc(mapping);
+	}
 
 	if (nr_none) {
 		struct zone *zone = page_zone(new_page);
diff --git a/mm/mmap.c b/mm/mmap.c
index 7e8c3e8ae75f..8094ce028d74 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3088,6 +3088,18 @@ int vm_brk(unsigned long addr, unsigned long len)
 }
 EXPORT_SYMBOL(vm_brk);
 
+static inline void release_file_thp(struct vm_area_struct *vma)
+{
+#ifdef CONFIG_READ_ONLY_THP_FOR_FS
+	struct file *file = vma->vm_file;
+
+	if (file && (vma->vm_flags & VM_DENYWRITE) &&
+	    atomic_read(&file_inode(file)->i_writecount) == 0 &&
+	    filemap_nr_thps(file_inode(file)->i_mapping))
+		truncate_pagecache(file_inode(file), 0);
+#endif
+}
+
 /* Release all mmaps. */
 void exit_mmap(struct mm_struct *mm)
 {
@@ -3153,6 +3165,8 @@ void exit_mmap(struct mm_struct *mm)
 	while (vma) {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted += vma_pages(vma);
+
+		release_file_thp(vma);
 		vma = remove_vma(vma);
 	}
 	vm_unacct_memory(nr_accounted);
-- 
2.17.1

