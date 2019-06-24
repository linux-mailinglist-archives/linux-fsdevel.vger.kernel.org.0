Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 432C251E48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 00:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfFXWaT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 18:30:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62916 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727139AbfFXWaS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 18:30:18 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OMIE4w000694
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2019 15:30:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=1YmphlJ3H8jOCDJ7k4G2S7xvfsjoBsLcepmZ6MADQ8Y=;
 b=bDtECx7JjGTraAQgcG+LiSc0bC+DOB+jM2yn4IYkK2W7vzJreSCkFUik5nANicKPctGH
 GEVwBJchObVFymR3+HxGxfiY0ESoyufbZdV3sAYjbm4gpcIuIgq1f+GyrXDCCZutciMc
 81z1y+YcZ+IWajUeJ1ItDgGTxIa7xRIEgMg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2tb6j2g6a8-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2019 15:30:17 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 24 Jun 2019 15:30:16 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id E384862E206E; Mon, 24 Jun 2019 15:30:11 -0700 (PDT)
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
Subject: [PATCH v8 6/6] mm,thp: avoid writes to file with THP in pagecache
Date:   Mon, 24 Jun 2019 15:29:51 -0700
Message-ID: <20190624222951.37076-7-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190624222951.37076-1-songliubraving@fb.com>
References: <20190624222951.37076-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=804 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240176
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
when the file is open for write. A new counter nr_thps is added to struct
address_space. In do_last(), if the file is open for write and nr_thps
is non-zero, we drop page cache for the whole file.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 fs/inode.c         |  2 ++
 fs/namei.c         | 23 ++++++++++++++++++++++-
 include/linux/fs.h | 28 ++++++++++++++++++++++++++++
 mm/filemap.c       |  1 +
 mm/khugepaged.c    |  4 +++-
 5 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index df6542ec3b88..7f27a5fd147b 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -181,6 +181,8 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	mapping->flags = 0;
 	mapping->wb_err = 0;
 	atomic_set(&mapping->i_mmap_writable, 0);
+	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS))
+		atomic_set(&mapping->nr_thps, 0);
 	mapping_set_gfp_mask(mapping, GFP_HIGHUSER_MOVABLE);
 	mapping->private_data = NULL;
 	mapping->writeback_index = 0;
diff --git a/fs/namei.c b/fs/namei.c
index 20831c2fbb34..3d95e94029cc 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3249,6 +3249,23 @@ static int lookup_open(struct nameidata *nd, struct path *path,
 	return error;
 }
 
+/*
+ * The file is open for write, so it is not mmapped with VM_DENYWRITE. If
+ * it still has THP in page cache, drop the whole file from pagecache
+ * before processing writes. This helps us avoid handling write back of
+ * THP for now.
+ */
+static inline void release_file_thp(struct file *file)
+{
+	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS)) {
+		struct inode *inode = file_inode(file);
+
+		if (inode_is_open_for_write(inode) &&
+		    filemap_nr_thps(inode->i_mapping))
+			truncate_pagecache(inode, 0);
+	}
+}
+
 /*
  * Handle the last step of open()
  */
@@ -3418,7 +3435,11 @@ static int do_last(struct nameidata *nd,
 		goto out;
 opened:
 	error = ima_file_check(file, op->acc_mode);
-	if (!error && will_truncate)
+	if (error)
+		goto out;
+
+	release_file_thp(file);
+	if (will_truncate)
 		error = handle_truncate(file);
 out:
 	if (unlikely(error > 0)) {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f7fdfe93e25d..20443d63692e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -427,6 +427,7 @@ int pagecache_write_end(struct file *, struct address_space *mapping,
  * @i_pages: Cached pages.
  * @gfp_mask: Memory allocation flags to use for allocating pages.
  * @i_mmap_writable: Number of VM_SHARED mappings.
+ * @nr_thps: Number of THPs in the pagecache (non-shmem only).
  * @i_mmap: Tree of private and shared mappings.
  * @i_mmap_rwsem: Protects @i_mmap and @i_mmap_writable.
  * @nrpages: Number of page entries, protected by the i_pages lock.
@@ -444,6 +445,10 @@ struct address_space {
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
@@ -2790,6 +2795,29 @@ static inline errseq_t filemap_sample_wb_err(struct address_space *mapping)
 	return errseq_sample(&mapping->wb_err);
 }
 
+static inline int filemap_nr_thps(struct address_space *mapping)
+{
+	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS))
+		return atomic_read(&mapping->nr_thps);
+	return 0;
+}
+
+static inline void filemap_nr_thps_inc(struct address_space *mapping)
+{
+	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS))
+		atomic_inc(&mapping->nr_thps);
+	else
+		WARN_ON_ONCE(1);
+}
+
+static inline void filemap_nr_thps_dec(struct address_space *mapping)
+{
+	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS))
+		atomic_dec(&mapping->nr_thps);
+	else
+		WARN_ON_ONCE(1);
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
index acbbbeaa083c..0bbc6be51197 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1503,8 +1503,10 @@ static void collapse_file(struct mm_struct *mm,
 
 	if (is_shmem)
 		__inc_node_page_state(new_page, NR_SHMEM_THPS);
-	else
+	else {
 		__inc_node_page_state(new_page, NR_FILE_THPS);
+		filemap_nr_thps_inc(mapping);
+	}
 
 	if (nr_none) {
 		struct zone *zone = page_zone(new_page);
-- 
2.17.1

