Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC7275C1A6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 19:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbfGARDC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 13:03:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59462 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbfGARDC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:03:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61GnVcT089914;
        Mon, 1 Jul 2019 17:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=HfMHKgO2fOgf/pOgboWfz8PZK6tAjQCIY7TdfabZJFk=;
 b=hRDbQG0I+ZQ7pajcNbiWZADjGEshJ+0VJ/HKk+Jzi8MOCThRxdivxMEjSLvnFdWKvlk7
 HH2jga/oXE5warSGO8Be/GP1PNdrgFbXAIR+RsqsR1Y+/oAinHA4eIIRDqJ17i+tHPEP
 9sg/UYjZlslu7DyFp8YE6zj67xSRerLKFSIaNqTfcRejazbeJHkWNeGfLmgNH+bKYOyQ
 x+O4lbRPX7jGWMY2si1VeekifdQQ1okGMSHLmFWZnxMPbBDxxxQsdIXeh2ShSRJMY2Iw
 OvUbXbhSfWY1Dd9Q3LB58LFFEyVlmN/fRZ2NaR8WUEtnNyfSTIpj9DKhqsChPJSLN11S dA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2te5tbevk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 17:02:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61GmMer154081;
        Mon, 1 Jul 2019 17:02:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2tebqg1h4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 17:02:55 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x61H2stJ032486;
        Mon, 1 Jul 2019 17:02:54 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jul 2019 10:02:54 -0700
Subject: [PATCH 08/11] iomap: move the page management code into a separate
 file
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 01 Jul 2019 10:02:51 -0700
Message-ID: <156200057155.1790352.957552724701420093.stgit@magnolia>
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

Move the page management code into a separate file so that we can group
related functions in a single file instead of having a single enormous
source file.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/iomap.c        |  164 -------------------------------------------------
 fs/iomap/Makefile |    1 
 fs/iomap/page.c   |  177 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 178 insertions(+), 164 deletions(-)
 create mode 100644 fs/iomap/page.c


diff --git a/fs/iomap.c b/fs/iomap.c
index f339fb5fde43..b946418cb8b4 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -97,131 +97,6 @@ iomap_sector(struct iomap *iomap, loff_t pos)
 	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
 }
 
-struct iomap_page *
-iomap_page_create(struct inode *inode, struct page *page)
-{
-	struct iomap_page *iop = to_iomap_page(page);
-
-	if (iop || i_blocksize(inode) == PAGE_SIZE)
-		return iop;
-
-	iop = kmalloc(sizeof(*iop), GFP_NOFS | __GFP_NOFAIL);
-	atomic_set(&iop->read_count, 0);
-	atomic_set(&iop->write_count, 0);
-	bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
-
-	/*
-	 * migrate_page_move_mapping() assumes that pages with private data have
-	 * their count elevated by 1.
-	 */
-	get_page(page);
-	set_page_private(page, (unsigned long)iop);
-	SetPagePrivate(page);
-	return iop;
-}
-
-static void
-iomap_page_release(struct page *page)
-{
-	struct iomap_page *iop = to_iomap_page(page);
-
-	if (!iop)
-		return;
-	WARN_ON_ONCE(atomic_read(&iop->read_count));
-	WARN_ON_ONCE(atomic_read(&iop->write_count));
-	ClearPagePrivate(page);
-	set_page_private(page, 0);
-	put_page(page);
-	kfree(iop);
-}
-
-void
-iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len)
-{
-	struct iomap_page *iop = to_iomap_page(page);
-	struct inode *inode = page->mapping->host;
-	unsigned first = off >> inode->i_blkbits;
-	unsigned last = (off + len - 1) >> inode->i_blkbits;
-	unsigned int i;
-	bool uptodate = true;
-
-	if (iop) {
-		for (i = 0; i < PAGE_SIZE / i_blocksize(inode); i++) {
-			if (i >= first && i <= last)
-				set_bit(i, iop->uptodate);
-			else if (!test_bit(i, iop->uptodate))
-				uptodate = false;
-		}
-	}
-
-	if (uptodate && !PageError(page))
-		SetPageUptodate(page);
-}
-
-/*
- * iomap_is_partially_uptodate checks whether blocks within a page are
- * uptodate or not.
- *
- * Returns true if all blocks which correspond to a file portion
- * we want to read within the page are uptodate.
- */
-int
-iomap_is_partially_uptodate(struct page *page, unsigned long from,
-		unsigned long count)
-{
-	struct iomap_page *iop = to_iomap_page(page);
-	struct inode *inode = page->mapping->host;
-	unsigned len, first, last;
-	unsigned i;
-
-	/* Limit range to one page */
-	len = min_t(unsigned, PAGE_SIZE - from, count);
-
-	/* First and last blocks in range within page */
-	first = from >> inode->i_blkbits;
-	last = (from + len - 1) >> inode->i_blkbits;
-
-	if (iop) {
-		for (i = first; i <= last; i++)
-			if (!test_bit(i, iop->uptodate))
-				return 0;
-		return 1;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
-
-int
-iomap_releasepage(struct page *page, gfp_t gfp_mask)
-{
-	/*
-	 * mm accommodates an old ext3 case where clean pages might not have had
-	 * the dirty bit cleared. Thus, it can send actual dirty pages to
-	 * ->releasepage() via shrink_active_list(), skip those here.
-	 */
-	if (PageDirty(page) || PageWriteback(page))
-		return 0;
-	iomap_page_release(page);
-	return 1;
-}
-EXPORT_SYMBOL_GPL(iomap_releasepage);
-
-void
-iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
-{
-	/*
-	 * If we are invalidating the entire page, clear the dirty state from it
-	 * and release it to avoid unnecessary buildup of the LRU.
-	 */
-	if (offset == 0 && len == PAGE_SIZE) {
-		WARN_ON_ONCE(PageWriteback(page));
-		cancel_dirty_page(page);
-		iomap_page_release(page);
-	}
-}
-EXPORT_SYMBOL_GPL(iomap_invalidatepage);
-
 #ifdef CONFIG_MIGRATION
 int
 iomap_migrate_page(struct address_space *mapping, struct page *newpage,
@@ -250,42 +125,3 @@ iomap_migrate_page(struct address_space *mapping, struct page *newpage,
 }
 EXPORT_SYMBOL_GPL(iomap_migrate_page);
 #endif /* CONFIG_MIGRATION */
-
-int
-iomap_set_page_dirty(struct page *page)
-{
-	struct address_space *mapping = page_mapping(page);
-	int newly_dirty;
-
-	if (unlikely(!mapping))
-		return !TestSetPageDirty(page);
-
-	/*
-	 * Lock out page->mem_cgroup migration to keep PageDirty
-	 * synchronized with per-memcg dirty page counters.
-	 */
-	lock_page_memcg(page);
-	newly_dirty = !TestSetPageDirty(page);
-	if (newly_dirty)
-		__set_page_dirty(page, mapping, 0);
-	unlock_page_memcg(page);
-
-	if (newly_dirty)
-		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
-	return newly_dirty;
-}
-EXPORT_SYMBOL_GPL(iomap_set_page_dirty);
-
-int
-iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
-		const struct iomap_ops *ops)
-{
-	unsigned int blocksize = i_blocksize(inode);
-	unsigned int off = pos & (blocksize - 1);
-
-	/* Block boundary? Nothing to do */
-	if (!off)
-		return 0;
-	return iomap_zero_range(inode, pos, blocksize - off, did_zero, ops);
-}
-EXPORT_SYMBOL_GPL(iomap_truncate_page);
diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
index 651bd66bfce7..754eea00ac79 100644
--- a/fs/iomap/Makefile
+++ b/fs/iomap/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_FS_IOMAP)		+= iomap.o
 iomap-y				+= \
 					direct-io.o \
 					fiemap.o \
+					page.o \
 					read.o \
 					seek.o \
 					write.o
diff --git a/fs/iomap/page.c b/fs/iomap/page.c
new file mode 100644
index 000000000000..1de513d5b1f7
--- /dev/null
+++ b/fs/iomap/page.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2010 Red Hat, Inc.
+ * Copyright (c) 2016-2018 Christoph Hellwig.
+ */
+#include <linux/module.h>
+#include <linux/compiler.h>
+#include <linux/fs.h>
+#include <linux/iomap.h>
+#include <linux/memcontrol.h>
+#include <linux/blkdev.h>
+
+#include "internal.h"
+
+struct iomap_page *
+iomap_page_create(struct inode *inode, struct page *page)
+{
+	struct iomap_page *iop = to_iomap_page(page);
+
+	if (iop || i_blocksize(inode) == PAGE_SIZE)
+		return iop;
+
+	iop = kmalloc(sizeof(*iop), GFP_NOFS | __GFP_NOFAIL);
+	atomic_set(&iop->read_count, 0);
+	atomic_set(&iop->write_count, 0);
+	bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
+
+	/*
+	 * migrate_page_move_mapping() assumes that pages with private data have
+	 * their count elevated by 1.
+	 */
+	get_page(page);
+	set_page_private(page, (unsigned long)iop);
+	SetPagePrivate(page);
+	return iop;
+}
+
+static void
+iomap_page_release(struct page *page)
+{
+	struct iomap_page *iop = to_iomap_page(page);
+
+	if (!iop)
+		return;
+	WARN_ON_ONCE(atomic_read(&iop->read_count));
+	WARN_ON_ONCE(atomic_read(&iop->write_count));
+	ClearPagePrivate(page);
+	set_page_private(page, 0);
+	put_page(page);
+	kfree(iop);
+}
+
+void
+iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len)
+{
+	struct iomap_page *iop = to_iomap_page(page);
+	struct inode *inode = page->mapping->host;
+	unsigned first = off >> inode->i_blkbits;
+	unsigned last = (off + len - 1) >> inode->i_blkbits;
+	unsigned int i;
+	bool uptodate = true;
+
+	if (iop) {
+		for (i = 0; i < PAGE_SIZE / i_blocksize(inode); i++) {
+			if (i >= first && i <= last)
+				set_bit(i, iop->uptodate);
+			else if (!test_bit(i, iop->uptodate))
+				uptodate = false;
+		}
+	}
+
+	if (uptodate && !PageError(page))
+		SetPageUptodate(page);
+}
+
+/*
+ * iomap_is_partially_uptodate checks whether blocks within a page are
+ * uptodate or not.
+ *
+ * Returns true if all blocks which correspond to a file portion
+ * we want to read within the page are uptodate.
+ */
+int
+iomap_is_partially_uptodate(struct page *page, unsigned long from,
+		unsigned long count)
+{
+	struct iomap_page *iop = to_iomap_page(page);
+	struct inode *inode = page->mapping->host;
+	unsigned len, first, last;
+	unsigned i;
+
+	/* Limit range to one page */
+	len = min_t(unsigned, PAGE_SIZE - from, count);
+
+	/* First and last blocks in range within page */
+	first = from >> inode->i_blkbits;
+	last = (from + len - 1) >> inode->i_blkbits;
+
+	if (iop) {
+		for (i = first; i <= last; i++)
+			if (!test_bit(i, iop->uptodate))
+				return 0;
+		return 1;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
+
+int
+iomap_releasepage(struct page *page, gfp_t gfp_mask)
+{
+	/*
+	 * mm accommodates an old ext3 case where clean pages might not have had
+	 * the dirty bit cleared. Thus, it can send actual dirty pages to
+	 * ->releasepage() via shrink_active_list(), skip those here.
+	 */
+	if (PageDirty(page) || PageWriteback(page))
+		return 0;
+	iomap_page_release(page);
+	return 1;
+}
+EXPORT_SYMBOL_GPL(iomap_releasepage);
+
+void
+iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
+{
+	/*
+	 * If we are invalidating the entire page, clear the dirty state from it
+	 * and release it to avoid unnecessary buildup of the LRU.
+	 */
+	if (offset == 0 && len == PAGE_SIZE) {
+		WARN_ON_ONCE(PageWriteback(page));
+		cancel_dirty_page(page);
+		iomap_page_release(page);
+	}
+}
+EXPORT_SYMBOL_GPL(iomap_invalidatepage);
+
+int
+iomap_set_page_dirty(struct page *page)
+{
+	struct address_space *mapping = page_mapping(page);
+	int newly_dirty;
+
+	if (unlikely(!mapping))
+		return !TestSetPageDirty(page);
+
+	/*
+	 * Lock out page->mem_cgroup migration to keep PageDirty
+	 * synchronized with per-memcg dirty page counters.
+	 */
+	lock_page_memcg(page);
+	newly_dirty = !TestSetPageDirty(page);
+	if (newly_dirty)
+		__set_page_dirty(page, mapping, 0);
+	unlock_page_memcg(page);
+
+	if (newly_dirty)
+		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
+	return newly_dirty;
+}
+EXPORT_SYMBOL_GPL(iomap_set_page_dirty);
+
+int
+iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
+		const struct iomap_ops *ops)
+{
+	unsigned int blocksize = i_blocksize(inode);
+	unsigned int off = pos & (blocksize - 1);
+
+	/* Block boundary? Nothing to do */
+	if (!off)
+		return 0;
+	return iomap_zero_range(inode, pos, blocksize - off, did_zero, ops);
+}
+EXPORT_SYMBOL_GPL(iomap_truncate_page);

