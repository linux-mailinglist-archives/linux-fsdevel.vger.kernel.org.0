Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28A795C1B6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 19:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfGAREW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 13:04:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41998 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbfGAREV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:04:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61GnTbg192794;
        Mon, 1 Jul 2019 17:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=P4a2vrXGMZ4LCn/j7WXj6mkpA8nWKNPlO1l2nzATDI8=;
 b=Z3Tv9Bsmc2I83ZTZjggZX/YkeTwGqzYM9FYU4ygRnUTyz8Cj3fPeHth043Wlp8a8rhMB
 2fC8oH9YHdZwy1tqeqaLFYAiunNJBxjsxRNk6L9MtOt7W4NUGz+uJUaAv+IV79atkOUG
 0KXYr58TTYxdIkBDQ+C0IKMZTtN1+zX3F6i8mrCjQbB1UG7Tvio7cEmc7pqUEZ54bxyA
 r37M2VcpNQpoxVDuMY9XEOWSkCLxalKA8IGRzosweXPWMbdPn71RjjnlJw2p8JwPfwwR
 8gjbXJqpSI62B3VpNMfliu0IC/K4kmnVQ9gXq7soDJYl2ieRwIS0jjh5D5hegjmv3ddM 3w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2te61ppuhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 17:04:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61GmNHG011405;
        Mon, 1 Jul 2019 17:02:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2tebbj9q85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 17:02:15 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x61H2EEl009685;
        Mon, 1 Jul 2019 17:02:14 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jul 2019 10:02:14 -0700
Subject: [PATCH 02/11] iomap: move the swapfile code into a separate file
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 01 Jul 2019 10:02:13 -0700
Message-ID: <156200053326.1790352.12592337513023365627.stgit@magnolia>
In-Reply-To: <156200051933.1790352.5147420943973755350.stgit@magnolia>
References: <156200051933.1790352.5147420943973755350.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907010201
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907010201
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Move the swapfile activation code into a separate file so that we can
group related functions in a single file instead of having a single
enormous source file.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/iomap.c          |  170 ------------------------------------------------
 fs/iomap/Makefile   |    4 +
 fs/iomap/swapfile.c |  180 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 184 insertions(+), 170 deletions(-)
 create mode 100644 fs/iomap/swapfile.c


diff --git a/fs/iomap.c b/fs/iomap.c
index f15c705c5a93..b0887e94d4ce 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -2002,176 +2002,6 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
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
index b778a05acac3..e38061f2b901 100644
--- a/fs/iomap/Makefile
+++ b/fs/iomap/Makefile
@@ -5,3 +5,7 @@
 #
 
 ccflags-y += -I $(srctree)/$(src)/..
+
+obj-$(CONFIG_FS_IOMAP)		+= iomap.o
+
+iomap-$(CONFIG_SWAP)		+= swapfile.o
diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
new file mode 100644
index 000000000000..4ca214d1e88d
--- /dev/null
+++ b/fs/iomap/swapfile.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2010 Red Hat, Inc.
+ * Copyright (c) 2016-2018 Christoph Hellwig.
+ */
+#include <linux/module.h>
+#include <linux/compiler.h>
+#include <linux/fs.h>
+#include <linux/iomap.h>
+#include <linux/swap.h>
+
+#include "internal.h"
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

