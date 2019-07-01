Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9477C5C19C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 19:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbfGARCe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 13:02:34 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59102 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729374AbfGARCe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:02:34 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61GnUUd089765;
        Mon, 1 Jul 2019 17:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=CRIfVXr9WCIO4NEavILNCA4g1OFg6LhH/Rd5VKGs1xE=;
 b=Uwc9AY/d5E2CYGOVJ4d+/hK0pZkDtkybfUog2GasIHmphRUyURtPRt/K89+ysxNJFlio
 DwLyZe2y0vw/xpRl9JpvEqwnLZhxtvxEWmeQ5zWkG0GL16FKPYuTTHxatRg5xW4sZLq9
 UyxQZ4AazylxqZc0NVsN+bKuE7epeufx511xMt6a72wvSLAVczWemxN0p8mb6ax02KCV
 +U1nzBpNYHZrs4emMdRE9pH5EgesgGleRqWVZZrDb6XTUTJLZgjgCrn7mOfEqbu2tv0k
 sA7tkPRaZ8YHFbSBgrta/dJU1uPFfa5Izz/qCQDwybaVbIjHmoy8tKDSR7N0lVGhrdQ9 +Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2te5tbevga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 17:02:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61GmMgH080260;
        Mon, 1 Jul 2019 17:02:27 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2tebak9pgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 17:02:27 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x61H2Rx6009853;
        Mon, 1 Jul 2019 17:02:27 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jul 2019 10:02:27 -0700
Subject: [PATCH 04/11] iomap: move the SEEK_HOLE code into a separate file
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 01 Jul 2019 10:02:26 -0700
Message-ID: <156200054604.1790352.7931842977738227442.stgit@magnolia>
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

Move the SEEK_HOLE/SEEK_DATA code into a separate file so that we can
group related functions in a single file instead of having a single
enormous source file.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/iomap.c        |  201 --------------------------------------------------
 fs/iomap/Makefile |    3 -
 fs/iomap/seek.c   |  214 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 216 insertions(+), 202 deletions(-)
 create mode 100644 fs/iomap/seek.c


diff --git a/fs/iomap.c b/fs/iomap.c
index 21a1300fc5b8..471fcb8170e6 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1145,207 +1145,6 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
 }
 EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
 
-/*
- * Seek for SEEK_DATA / SEEK_HOLE within @page, starting at @lastoff.
- * Returns true if found and updates @lastoff to the offset in file.
- */
-static bool
-page_seek_hole_data(struct inode *inode, struct page *page, loff_t *lastoff,
-		int whence)
-{
-	const struct address_space_operations *ops = inode->i_mapping->a_ops;
-	unsigned int bsize = i_blocksize(inode), off;
-	bool seek_data = whence == SEEK_DATA;
-	loff_t poff = page_offset(page);
-
-	if (WARN_ON_ONCE(*lastoff >= poff + PAGE_SIZE))
-		return false;
-
-	if (*lastoff < poff) {
-		/*
-		 * Last offset smaller than the start of the page means we found
-		 * a hole:
-		 */
-		if (whence == SEEK_HOLE)
-			return true;
-		*lastoff = poff;
-	}
-
-	/*
-	 * Just check the page unless we can and should check block ranges:
-	 */
-	if (bsize == PAGE_SIZE || !ops->is_partially_uptodate)
-		return PageUptodate(page) == seek_data;
-
-	lock_page(page);
-	if (unlikely(page->mapping != inode->i_mapping))
-		goto out_unlock_not_found;
-
-	for (off = 0; off < PAGE_SIZE; off += bsize) {
-		if (offset_in_page(*lastoff) >= off + bsize)
-			continue;
-		if (ops->is_partially_uptodate(page, off, bsize) == seek_data) {
-			unlock_page(page);
-			return true;
-		}
-		*lastoff = poff + off + bsize;
-	}
-
-out_unlock_not_found:
-	unlock_page(page);
-	return false;
-}
-
-/*
- * Seek for SEEK_DATA / SEEK_HOLE in the page cache.
- *
- * Within unwritten extents, the page cache determines which parts are holes
- * and which are data: uptodate buffer heads count as data; everything else
- * counts as a hole.
- *
- * Returns the resulting offset on successs, and -ENOENT otherwise.
- */
-static loff_t
-page_cache_seek_hole_data(struct inode *inode, loff_t offset, loff_t length,
-		int whence)
-{
-	pgoff_t index = offset >> PAGE_SHIFT;
-	pgoff_t end = DIV_ROUND_UP(offset + length, PAGE_SIZE);
-	loff_t lastoff = offset;
-	struct pagevec pvec;
-
-	if (length <= 0)
-		return -ENOENT;
-
-	pagevec_init(&pvec);
-
-	do {
-		unsigned nr_pages, i;
-
-		nr_pages = pagevec_lookup_range(&pvec, inode->i_mapping, &index,
-						end - 1);
-		if (nr_pages == 0)
-			break;
-
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
-
-			if (page_seek_hole_data(inode, page, &lastoff, whence))
-				goto check_range;
-			lastoff = page_offset(page) + PAGE_SIZE;
-		}
-		pagevec_release(&pvec);
-	} while (index < end);
-
-	/* When no page at lastoff and we are not done, we found a hole. */
-	if (whence != SEEK_HOLE)
-		goto not_found;
-
-check_range:
-	if (lastoff < offset + length)
-		goto out;
-not_found:
-	lastoff = -ENOENT;
-out:
-	pagevec_release(&pvec);
-	return lastoff;
-}
-
-
-static loff_t
-iomap_seek_hole_actor(struct inode *inode, loff_t offset, loff_t length,
-		      void *data, struct iomap *iomap)
-{
-	switch (iomap->type) {
-	case IOMAP_UNWRITTEN:
-		offset = page_cache_seek_hole_data(inode, offset, length,
-						   SEEK_HOLE);
-		if (offset < 0)
-			return length;
-		/* fall through */
-	case IOMAP_HOLE:
-		*(loff_t *)data = offset;
-		return 0;
-	default:
-		return length;
-	}
-}
-
-loff_t
-iomap_seek_hole(struct inode *inode, loff_t offset, const struct iomap_ops *ops)
-{
-	loff_t size = i_size_read(inode);
-	loff_t length = size - offset;
-	loff_t ret;
-
-	/* Nothing to be found before or beyond the end of the file. */
-	if (offset < 0 || offset >= size)
-		return -ENXIO;
-
-	while (length > 0) {
-		ret = iomap_apply(inode, offset, length, IOMAP_REPORT, ops,
-				  &offset, iomap_seek_hole_actor);
-		if (ret < 0)
-			return ret;
-		if (ret == 0)
-			break;
-
-		offset += ret;
-		length -= ret;
-	}
-
-	return offset;
-}
-EXPORT_SYMBOL_GPL(iomap_seek_hole);
-
-static loff_t
-iomap_seek_data_actor(struct inode *inode, loff_t offset, loff_t length,
-		      void *data, struct iomap *iomap)
-{
-	switch (iomap->type) {
-	case IOMAP_HOLE:
-		return length;
-	case IOMAP_UNWRITTEN:
-		offset = page_cache_seek_hole_data(inode, offset, length,
-						   SEEK_DATA);
-		if (offset < 0)
-			return length;
-		/*FALLTHRU*/
-	default:
-		*(loff_t *)data = offset;
-		return 0;
-	}
-}
-
-loff_t
-iomap_seek_data(struct inode *inode, loff_t offset, const struct iomap_ops *ops)
-{
-	loff_t size = i_size_read(inode);
-	loff_t length = size - offset;
-	loff_t ret;
-
-	/* Nothing to be found before or beyond the end of the file. */
-	if (offset < 0 || offset >= size)
-		return -ENXIO;
-
-	while (length > 0) {
-		ret = iomap_apply(inode, offset, length, IOMAP_REPORT, ops,
-				  &offset, iomap_seek_data_actor);
-		if (ret < 0)
-			return ret;
-		if (ret == 0)
-			break;
-
-		offset += ret;
-		length -= ret;
-	}
-
-	if (length <= 0)
-		return -ENXIO;
-	return offset;
-}
-EXPORT_SYMBOL_GPL(iomap_seek_data);
-
 /*
  * Private flags for iomap_dio, must not overlap with the public ones in
  * iomap.h:
diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
index 861c07137792..12dc7f844bbd 100644
--- a/fs/iomap/Makefile
+++ b/fs/iomap/Makefile
@@ -9,6 +9,7 @@ ccflags-y += -I $(srctree)/$(src)/..
 obj-$(CONFIG_FS_IOMAP)		+= iomap.o
 
 iomap-y				+= \
-					fiemap.o
+					fiemap.o \
+					seek.o
 
 iomap-$(CONFIG_SWAP)		+= swapfile.o
diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
new file mode 100644
index 000000000000..0c36bef46522
--- /dev/null
+++ b/fs/iomap/seek.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2010 Red Hat, Inc.
+ * Copyright (c) 2016-2018 Christoph Hellwig.
+ */
+#include <linux/module.h>
+#include <linux/compiler.h>
+#include <linux/fs.h>
+#include <linux/iomap.h>
+#include <linux/pagemap.h>
+#include <linux/pagevec.h>
+
+#include "internal.h"
+
+/*
+ * Seek for SEEK_DATA / SEEK_HOLE within @page, starting at @lastoff.
+ * Returns true if found and updates @lastoff to the offset in file.
+ */
+static bool
+page_seek_hole_data(struct inode *inode, struct page *page, loff_t *lastoff,
+		int whence)
+{
+	const struct address_space_operations *ops = inode->i_mapping->a_ops;
+	unsigned int bsize = i_blocksize(inode), off;
+	bool seek_data = whence == SEEK_DATA;
+	loff_t poff = page_offset(page);
+
+	if (WARN_ON_ONCE(*lastoff >= poff + PAGE_SIZE))
+		return false;
+
+	if (*lastoff < poff) {
+		/*
+		 * Last offset smaller than the start of the page means we found
+		 * a hole:
+		 */
+		if (whence == SEEK_HOLE)
+			return true;
+		*lastoff = poff;
+	}
+
+	/*
+	 * Just check the page unless we can and should check block ranges:
+	 */
+	if (bsize == PAGE_SIZE || !ops->is_partially_uptodate)
+		return PageUptodate(page) == seek_data;
+
+	lock_page(page);
+	if (unlikely(page->mapping != inode->i_mapping))
+		goto out_unlock_not_found;
+
+	for (off = 0; off < PAGE_SIZE; off += bsize) {
+		if (offset_in_page(*lastoff) >= off + bsize)
+			continue;
+		if (ops->is_partially_uptodate(page, off, bsize) == seek_data) {
+			unlock_page(page);
+			return true;
+		}
+		*lastoff = poff + off + bsize;
+	}
+
+out_unlock_not_found:
+	unlock_page(page);
+	return false;
+}
+
+/*
+ * Seek for SEEK_DATA / SEEK_HOLE in the page cache.
+ *
+ * Within unwritten extents, the page cache determines which parts are holes
+ * and which are data: uptodate buffer heads count as data; everything else
+ * counts as a hole.
+ *
+ * Returns the resulting offset on successs, and -ENOENT otherwise.
+ */
+static loff_t
+page_cache_seek_hole_data(struct inode *inode, loff_t offset, loff_t length,
+		int whence)
+{
+	pgoff_t index = offset >> PAGE_SHIFT;
+	pgoff_t end = DIV_ROUND_UP(offset + length, PAGE_SIZE);
+	loff_t lastoff = offset;
+	struct pagevec pvec;
+
+	if (length <= 0)
+		return -ENOENT;
+
+	pagevec_init(&pvec);
+
+	do {
+		unsigned nr_pages, i;
+
+		nr_pages = pagevec_lookup_range(&pvec, inode->i_mapping, &index,
+						end - 1);
+		if (nr_pages == 0)
+			break;
+
+		for (i = 0; i < nr_pages; i++) {
+			struct page *page = pvec.pages[i];
+
+			if (page_seek_hole_data(inode, page, &lastoff, whence))
+				goto check_range;
+			lastoff = page_offset(page) + PAGE_SIZE;
+		}
+		pagevec_release(&pvec);
+	} while (index < end);
+
+	/* When no page at lastoff and we are not done, we found a hole. */
+	if (whence != SEEK_HOLE)
+		goto not_found;
+
+check_range:
+	if (lastoff < offset + length)
+		goto out;
+not_found:
+	lastoff = -ENOENT;
+out:
+	pagevec_release(&pvec);
+	return lastoff;
+}
+
+
+static loff_t
+iomap_seek_hole_actor(struct inode *inode, loff_t offset, loff_t length,
+		      void *data, struct iomap *iomap)
+{
+	switch (iomap->type) {
+	case IOMAP_UNWRITTEN:
+		offset = page_cache_seek_hole_data(inode, offset, length,
+						   SEEK_HOLE);
+		if (offset < 0)
+			return length;
+		/* fall through */
+	case IOMAP_HOLE:
+		*(loff_t *)data = offset;
+		return 0;
+	default:
+		return length;
+	}
+}
+
+loff_t
+iomap_seek_hole(struct inode *inode, loff_t offset, const struct iomap_ops *ops)
+{
+	loff_t size = i_size_read(inode);
+	loff_t length = size - offset;
+	loff_t ret;
+
+	/* Nothing to be found before or beyond the end of the file. */
+	if (offset < 0 || offset >= size)
+		return -ENXIO;
+
+	while (length > 0) {
+		ret = iomap_apply(inode, offset, length, IOMAP_REPORT, ops,
+				  &offset, iomap_seek_hole_actor);
+		if (ret < 0)
+			return ret;
+		if (ret == 0)
+			break;
+
+		offset += ret;
+		length -= ret;
+	}
+
+	return offset;
+}
+EXPORT_SYMBOL_GPL(iomap_seek_hole);
+
+static loff_t
+iomap_seek_data_actor(struct inode *inode, loff_t offset, loff_t length,
+		      void *data, struct iomap *iomap)
+{
+	switch (iomap->type) {
+	case IOMAP_HOLE:
+		return length;
+	case IOMAP_UNWRITTEN:
+		offset = page_cache_seek_hole_data(inode, offset, length,
+						   SEEK_DATA);
+		if (offset < 0)
+			return length;
+		/*FALLTHRU*/
+	default:
+		*(loff_t *)data = offset;
+		return 0;
+	}
+}
+
+loff_t
+iomap_seek_data(struct inode *inode, loff_t offset, const struct iomap_ops *ops)
+{
+	loff_t size = i_size_read(inode);
+	loff_t length = size - offset;
+	loff_t ret;
+
+	/* Nothing to be found before or beyond the end of the file. */
+	if (offset < 0 || offset >= size)
+		return -ENXIO;
+
+	while (length > 0) {
+		ret = iomap_apply(inode, offset, length, IOMAP_REPORT, ops,
+				  &offset, iomap_seek_data_actor);
+		if (ret < 0)
+			return ret;
+		if (ret == 0)
+			break;
+
+		offset += ret;
+		length -= ret;
+	}
+
+	if (length <= 0)
+		return -ENXIO;
+	return offset;
+}
+EXPORT_SYMBOL_GPL(iomap_seek_data);

