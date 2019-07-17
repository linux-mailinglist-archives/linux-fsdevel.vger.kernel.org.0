Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21A506B635
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 08:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfGQF7c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 01:59:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44546 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfGQF7c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 01:59:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H5xCRD033706;
        Wed, 17 Jul 2019 05:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=T3iWapj2nhLhDp0vy3J9mW+zC57IU5IfqFMczhoAiTI=;
 b=5VqdLlOI2lVQqRPp1wrMFm/WsiDSsICzashIJvdPruZ6TUeDzhTfJfDYkJRGpqAEdBYt
 7B/YVSmqYr+ONuzUwrT/9p4X1Cp9PqfpaD8EGzCiB1dQjPaYWgZn4fX4p9Ve3RCPzhM5
 h1cKZGI19QaPaIZulnMqTPp5UP9L29uLogURWHzMVWWUkNoN5S4DdoI8uT3Zc/blcTUP
 fpvRq1ZoI64mlRSe5X6BSVXA0XLhi8+S246Tm6SF1udLNo+6p8ISgP1wAA5+C9laAeEA
 s30MTpUkJfNwpgCHYu5v7RogG2TQ/jWYUt+tqYbP5kZh1emu54L6ut222iG8snGWaHCM 0Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2tq7xr0a5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 05:59:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H5wP1J095657;
        Wed, 17 Jul 2019 05:59:11 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2tsctwsdts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 05:59:11 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6H5x9Or011400;
        Wed, 17 Jul 2019 05:59:09 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jul 2019 05:59:09 +0000
Subject: [PATCH 2/8] iomap: move the swapfile code into a separate file
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, agruenba@redhat.com
Date:   Tue, 16 Jul 2019 22:59:07 -0700
Message-ID: <156334314788.360395.4396832582735213514.stgit@magnolia>
In-Reply-To: <156334313527.360395.511547592522547578.stgit@magnolia>
References: <156334313527.360395.511547592522547578.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170074
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Move the swapfile activation code into a separate file so that we can
group related functions in a single file instead of having a single
enormous source file.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap.c          |  170 ------------------------------------------------
 fs/iomap/Makefile   |    3 +
 fs/iomap/swapfile.c |  180 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 183 insertions(+), 170 deletions(-)
 create mode 100644 fs/iomap/swapfile.c


diff --git a/fs/iomap.c b/fs/iomap.c
index 217c3e5a13d6..521e90825dbe 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -2000,176 +2000,6 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 }
 EXPORT_SYMBOL_GPL(iomap_dio_rw);
 
-/* Swapfile activation */
-
-#ifdef CONFIG_SWAP
-struct iomap_swapfile_info {
-	struct iomap iomap;		/* accumulated iomap */
-	struct swap_info_struct *sis;
-	uint64_t lowest_ppage;		/* lowest physical addr seen (pages) */
-	uint64_t highest_ppage;		/* highest physical addr seen (pages) */
-	unsigned long nr_pages;		/* number of pages collected */
-	int nr_extents;			/* extent count */
-};
-
-/*
- * Collect physical extents for this swap file.  Physical extents reported to
- * the swap code must be trimmed to align to a page boundary.  The logical
- * offset within the file is irrelevant since the swapfile code maps logical
- * page numbers of the swap device to the physical page-aligned extents.
- */
-static int iomap_swapfile_add_extent(struct iomap_swapfile_info *isi)
-{
-	struct iomap *iomap = &isi->iomap;
-	unsigned long nr_pages;
-	uint64_t first_ppage;
-	uint64_t first_ppage_reported;
-	uint64_t next_ppage;
-	int error;
-
-	/*
-	 * Round the start up and the end down so that the physical
-	 * extent aligns to a page boundary.
-	 */
-	first_ppage = ALIGN(iomap->addr, PAGE_SIZE) >> PAGE_SHIFT;
-	next_ppage = ALIGN_DOWN(iomap->addr + iomap->length, PAGE_SIZE) >>
-			PAGE_SHIFT;
-
-	/* Skip too-short physical extents. */
-	if (first_ppage >= next_ppage)
-		return 0;
-	nr_pages = next_ppage - first_ppage;
-
-	/*
-	 * Calculate how much swap space we're adding; the first page contains
-	 * the swap header and doesn't count.  The mm still wants that first
-	 * page fed to add_swap_extent, however.
-	 */
-	first_ppage_reported = first_ppage;
-	if (iomap->offset == 0)
-		first_ppage_reported++;
-	if (isi->lowest_ppage > first_ppage_reported)
-		isi->lowest_ppage = first_ppage_reported;
-	if (isi->highest_ppage < (next_ppage - 1))
-		isi->highest_ppage = next_ppage - 1;
-
-	/* Add extent, set up for the next call. */
-	error = add_swap_extent(isi->sis, isi->nr_pages, nr_pages, first_ppage);
-	if (error < 0)
-		return error;
-	isi->nr_extents += error;
-	isi->nr_pages += nr_pages;
-	return 0;
-}
-
-/*
- * Accumulate iomaps for this swap file.  We have to accumulate iomaps because
- * swap only cares about contiguous page-aligned physical extents and makes no
- * distinction between written and unwritten extents.
- */
-static loff_t iomap_swapfile_activate_actor(struct inode *inode, loff_t pos,
-		loff_t count, void *data, struct iomap *iomap)
-{
-	struct iomap_swapfile_info *isi = data;
-	int error;
-
-	switch (iomap->type) {
-	case IOMAP_MAPPED:
-	case IOMAP_UNWRITTEN:
-		/* Only real or unwritten extents. */
-		break;
-	case IOMAP_INLINE:
-		/* No inline data. */
-		pr_err("swapon: file is inline\n");
-		return -EINVAL;
-	default:
-		pr_err("swapon: file has unallocated extents\n");
-		return -EINVAL;
-	}
-
-	/* No uncommitted metadata or shared blocks. */
-	if (iomap->flags & IOMAP_F_DIRTY) {
-		pr_err("swapon: file is not committed\n");
-		return -EINVAL;
-	}
-	if (iomap->flags & IOMAP_F_SHARED) {
-		pr_err("swapon: file has shared extents\n");
-		return -EINVAL;
-	}
-
-	/* Only one bdev per swap file. */
-	if (iomap->bdev != isi->sis->bdev) {
-		pr_err("swapon: file is on multiple devices\n");
-		return -EINVAL;
-	}
-
-	if (isi->iomap.length == 0) {
-		/* No accumulated extent, so just store it. */
-		memcpy(&isi->iomap, iomap, sizeof(isi->iomap));
-	} else if (isi->iomap.addr + isi->iomap.length == iomap->addr) {
-		/* Append this to the accumulated extent. */
-		isi->iomap.length += iomap->length;
-	} else {
-		/* Otherwise, add the retained iomap and store this one. */
-		error = iomap_swapfile_add_extent(isi);
-		if (error)
-			return error;
-		memcpy(&isi->iomap, iomap, sizeof(isi->iomap));
-	}
-	return count;
-}
-
-/*
- * Iterate a swap file's iomaps to construct physical extents that can be
- * passed to the swapfile subsystem.
- */
-int iomap_swapfile_activate(struct swap_info_struct *sis,
-		struct file *swap_file, sector_t *pagespan,
-		const struct iomap_ops *ops)
-{
-	struct iomap_swapfile_info isi = {
-		.sis = sis,
-		.lowest_ppage = (sector_t)-1ULL,
-	};
-	struct address_space *mapping = swap_file->f_mapping;
-	struct inode *inode = mapping->host;
-	loff_t pos = 0;
-	loff_t len = ALIGN_DOWN(i_size_read(inode), PAGE_SIZE);
-	loff_t ret;
-
-	/*
-	 * Persist all file mapping metadata so that we won't have any
-	 * IOMAP_F_DIRTY iomaps.
-	 */
-	ret = vfs_fsync(swap_file, 1);
-	if (ret)
-		return ret;
-
-	while (len > 0) {
-		ret = iomap_apply(inode, pos, len, IOMAP_REPORT,
-				ops, &isi, iomap_swapfile_activate_actor);
-		if (ret <= 0)
-			return ret;
-
-		pos += ret;
-		len -= ret;
-	}
-
-	if (isi.iomap.length) {
-		ret = iomap_swapfile_add_extent(&isi);
-		if (ret)
-			return ret;
-	}
-
-	*pagespan = 1 + isi.highest_ppage - isi.lowest_ppage;
-	sis->max = isi.nr_pages;
-	sis->pages = isi.nr_pages - 1;
-	sis->highest_bit = isi.nr_pages - 1;
-	return isi.nr_extents;
-}
-EXPORT_SYMBOL_GPL(iomap_swapfile_activate);
-#endif /* CONFIG_SWAP */
-
 static loff_t
 iomap_bmap_actor(struct inode *inode, loff_t pos, loff_t length,
 		void *data, struct iomap *iomap)
diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
index de5a1f914b2c..f88eca22ae80 100644
--- a/fs/iomap/Makefile
+++ b/fs/iomap/Makefile
@@ -3,3 +3,6 @@
 # Copyright (c) 2019 Oracle.
 # All Rights Reserved.
 #
+obj-$(CONFIG_FS_IOMAP)		+= iomap.o
+
+iomap-$(CONFIG_SWAP)		+= swapfile.o
diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
new file mode 100644
index 000000000000..b79c33631263
--- /dev/null
+++ b/fs/iomap/swapfile.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <darrick.wong@oracle.com>
+ */
+#include <linux/module.h>
+#include <linux/compiler.h>
+#include <linux/fs.h>
+#include <linux/iomap.h>
+#include <linux/swap.h>
+
+#include "../internal.h"
+
+/* Swapfile activation */
+
+struct iomap_swapfile_info {
+	struct iomap iomap;		/* accumulated iomap */
+	struct swap_info_struct *sis;
+	uint64_t lowest_ppage;		/* lowest physical addr seen (pages) */
+	uint64_t highest_ppage;		/* highest physical addr seen (pages) */
+	unsigned long nr_pages;		/* number of pages collected */
+	int nr_extents;			/* extent count */
+};
+
+/*
+ * Collect physical extents for this swap file.  Physical extents reported to
+ * the swap code must be trimmed to align to a page boundary.  The logical
+ * offset within the file is irrelevant since the swapfile code maps logical
+ * page numbers of the swap device to the physical page-aligned extents.
+ */
+static int iomap_swapfile_add_extent(struct iomap_swapfile_info *isi)
+{
+	struct iomap *iomap = &isi->iomap;
+	unsigned long nr_pages;
+	uint64_t first_ppage;
+	uint64_t first_ppage_reported;
+	uint64_t next_ppage;
+	int error;
+
+	/*
+	 * Round the start up and the end down so that the physical
+	 * extent aligns to a page boundary.
+	 */
+	first_ppage = ALIGN(iomap->addr, PAGE_SIZE) >> PAGE_SHIFT;
+	next_ppage = ALIGN_DOWN(iomap->addr + iomap->length, PAGE_SIZE) >>
+			PAGE_SHIFT;
+
+	/* Skip too-short physical extents. */
+	if (first_ppage >= next_ppage)
+		return 0;
+	nr_pages = next_ppage - first_ppage;
+
+	/*
+	 * Calculate how much swap space we're adding; the first page contains
+	 * the swap header and doesn't count.  The mm still wants that first
+	 * page fed to add_swap_extent, however.
+	 */
+	first_ppage_reported = first_ppage;
+	if (iomap->offset == 0)
+		first_ppage_reported++;
+	if (isi->lowest_ppage > first_ppage_reported)
+		isi->lowest_ppage = first_ppage_reported;
+	if (isi->highest_ppage < (next_ppage - 1))
+		isi->highest_ppage = next_ppage - 1;
+
+	/* Add extent, set up for the next call. */
+	error = add_swap_extent(isi->sis, isi->nr_pages, nr_pages, first_ppage);
+	if (error < 0)
+		return error;
+	isi->nr_extents += error;
+	isi->nr_pages += nr_pages;
+	return 0;
+}
+
+/*
+ * Accumulate iomaps for this swap file.  We have to accumulate iomaps because
+ * swap only cares about contiguous page-aligned physical extents and makes no
+ * distinction between written and unwritten extents.
+ */
+static loff_t iomap_swapfile_activate_actor(struct inode *inode, loff_t pos,
+		loff_t count, void *data, struct iomap *iomap)
+{
+	struct iomap_swapfile_info *isi = data;
+	int error;
+
+	switch (iomap->type) {
+	case IOMAP_MAPPED:
+	case IOMAP_UNWRITTEN:
+		/* Only real or unwritten extents. */
+		break;
+	case IOMAP_INLINE:
+		/* No inline data. */
+		pr_err("swapon: file is inline\n");
+		return -EINVAL;
+	default:
+		pr_err("swapon: file has unallocated extents\n");
+		return -EINVAL;
+	}
+
+	/* No uncommitted metadata or shared blocks. */
+	if (iomap->flags & IOMAP_F_DIRTY) {
+		pr_err("swapon: file is not committed\n");
+		return -EINVAL;
+	}
+	if (iomap->flags & IOMAP_F_SHARED) {
+		pr_err("swapon: file has shared extents\n");
+		return -EINVAL;
+	}
+
+	/* Only one bdev per swap file. */
+	if (iomap->bdev != isi->sis->bdev) {
+		pr_err("swapon: file is on multiple devices\n");
+		return -EINVAL;
+	}
+
+	if (isi->iomap.length == 0) {
+		/* No accumulated extent, so just store it. */
+		memcpy(&isi->iomap, iomap, sizeof(isi->iomap));
+	} else if (isi->iomap.addr + isi->iomap.length == iomap->addr) {
+		/* Append this to the accumulated extent. */
+		isi->iomap.length += iomap->length;
+	} else {
+		/* Otherwise, add the retained iomap and store this one. */
+		error = iomap_swapfile_add_extent(isi);
+		if (error)
+			return error;
+		memcpy(&isi->iomap, iomap, sizeof(isi->iomap));
+	}
+	return count;
+}
+
+/*
+ * Iterate a swap file's iomaps to construct physical extents that can be
+ * passed to the swapfile subsystem.
+ */
+int iomap_swapfile_activate(struct swap_info_struct *sis,
+		struct file *swap_file, sector_t *pagespan,
+		const struct iomap_ops *ops)
+{
+	struct iomap_swapfile_info isi = {
+		.sis = sis,
+		.lowest_ppage = (sector_t)-1ULL,
+	};
+	struct address_space *mapping = swap_file->f_mapping;
+	struct inode *inode = mapping->host;
+	loff_t pos = 0;
+	loff_t len = ALIGN_DOWN(i_size_read(inode), PAGE_SIZE);
+	loff_t ret;
+
+	/*
+	 * Persist all file mapping metadata so that we won't have any
+	 * IOMAP_F_DIRTY iomaps.
+	 */
+	ret = vfs_fsync(swap_file, 1);
+	if (ret)
+		return ret;
+
+	while (len > 0) {
+		ret = iomap_apply(inode, pos, len, IOMAP_REPORT,
+				ops, &isi, iomap_swapfile_activate_actor);
+		if (ret <= 0)
+			return ret;
+
+		pos += ret;
+		len -= ret;
+	}
+
+	if (isi.iomap.length) {
+		ret = iomap_swapfile_add_extent(&isi);
+		if (ret)
+			return ret;
+	}
+
+	*pagespan = 1 + isi.highest_ppage - isi.lowest_ppage;
+	sis->max = isi.nr_pages;
+	sis->pages = isi.nr_pages - 1;
+	sis->highest_bit = isi.nr_pages - 1;
+	return isi.nr_extents;
+}
+EXPORT_SYMBOL_GPL(iomap_swapfile_activate);

