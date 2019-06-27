Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77339580D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 12:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfF0KtT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 06:49:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52196 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfF0KtR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 06:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=W1ba97vqj5fSXcVc3Fg0+/SxTpVq+Cf6Jfltd57wrXE=; b=JnlFKjeAVzpIZSsUphHn8XsiHd
        Dlp1mHk1n6YRXj8QOaBSJhPEseZXBpAOz91p09O+AVjWD4XK45M31xaaEqwNMd1B7XGe98qak5K4b
        SGsXKLtPPDhfxuFpOWFwT9UcJtBBkBOmg5uMMQsxXH101W//+otWiGTqGiNTTT0xpYe6TV+f12keY
        DUpKdckdJ7sx16y7vDIAz7Fp9RmYo4wAyHr3T+BFeWpWIUYrZ2p4Q5oxgHf5xN+sNmvmLEPgMUY0g
        y4U99IE7HGtEanB/Sbx8PX3JGLoIzcz3M1eRRVNNCrBGtIfH5hKQQJ1+rVmpE72zJwOpVZwlMzArC
        eqH5d2cA==;
Received: from 089144214055.atnat0023.highway.a1.net ([89.144.214.55] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgRxr-0005AG-Ep; Thu, 27 Jun 2019 10:49:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] iomap: add tracing for the address space operations
Date:   Thu, 27 Jun 2019 12:48:36 +0200
Message-Id: <20190627104836.25446-14-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627104836.25446-1-hch@lst.de>
References: <20190627104836.25446-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Lift the xfs code for tracing address space operations to the iomap
layer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap.c                   | 13 +++++-
 fs/xfs/xfs_aops.c            | 27 ++----------
 fs/xfs/xfs_trace.h           | 65 ---------------------------
 include/trace/events/iomap.h | 85 ++++++++++++++++++++++++++++++++++++
 4 files changed, 100 insertions(+), 90 deletions(-)
 create mode 100644 include/trace/events/iomap.h

diff --git a/fs/iomap.c b/fs/iomap.c
index bb5c42561398..5db939468499 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -23,7 +23,8 @@
 #include <linux/task_io_accounting_ops.h>
 #include <linux/dax.h>
 #include <linux/sched/signal.h>
-
+#define CREATE_TRACE_POINTS
+#include <trace/events/iomap.h>
 #include "internal.h"
 
 static struct bio_set iomap_ioend_bioset;
@@ -369,6 +370,8 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
 	unsigned poff;
 	loff_t ret;
 
+	trace_iomap_readpage(page->mapping->host, 1);
+
 	for (poff = 0; poff < PAGE_SIZE; poff += ret) {
 		ret = iomap_apply(inode, page_offset(page) + poff,
 				PAGE_SIZE - poff, 0, ops, &ctx,
@@ -465,6 +468,8 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
 	loff_t last = page_offset(list_entry(pages->next, struct page, lru));
 	loff_t length = last - pos + PAGE_SIZE, ret = 0;
 
+	trace_iomap_readpages(mapping->host, nr_pages);
+
 	while (length > 0) {
 		ret = iomap_apply(mapping->host, pos, length, 0, ops,
 				&ctx, iomap_readpages_actor);
@@ -531,6 +536,8 @@ EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
 int
 iomap_releasepage(struct page *page, gfp_t gfp_mask)
 {
+	trace_iomap_releasepage(page->mapping->host, page, 0, 0);
+
 	/*
 	 * mm accommodates an old ext3 case where clean pages might not have had
 	 * the dirty bit cleared. Thus, it can send actual dirty pages to
@@ -546,6 +553,8 @@ EXPORT_SYMBOL_GPL(iomap_releasepage);
 void
 iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
 {
+	trace_iomap_invalidatepage(page->mapping->host, page, offset, len);
+
 	/*
 	 * If we are invalidating the entire page, clear the dirty state from it
 	 * and release it to avoid unnecessary buildup of the LRU.
@@ -2586,6 +2595,8 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 	u64 end_offset;
 	loff_t offset;
 
+	trace_iomap_writepage(inode, page, 0, 0);
+
 	/*
 	 * Refuse to write the page out if we are called from reclaim context.
 	 *
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 072750f34fe6..bdcde2ece779 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -540,16 +540,6 @@ xfs_submit_ioend(
 	return status;
 }
 
-STATIC void
-xfs_vm_invalidatepage(
-	struct page		*page,
-	unsigned int		offset,
-	unsigned int		length)
-{
-	trace_xfs_invalidatepage(page->mapping->host, page, offset, length);
-	iomap_invalidatepage(page, offset, length);
-}
-
 /*
  * If the page has delalloc blocks on it, we need to punch them out before we
  * invalidate the page.  If we don't, we leave a stale delalloc mapping on the
@@ -584,7 +574,7 @@ xfs_discard_page(
 	if (error && !XFS_FORCED_SHUTDOWN(mp))
 		xfs_alert(mp, "page discard unable to remove delalloc mapping.");
 out_invalidate:
-	xfs_vm_invalidatepage(page, 0, PAGE_SIZE);
+	iomap_invalidatepage(page, 0, PAGE_SIZE);
 }
 
 static const struct iomap_writeback_ops xfs_writeback_ops = {
@@ -624,15 +614,6 @@ xfs_dax_writepages(
 			xfs_find_bdev_for_inode(mapping->host), wbc);
 }
 
-STATIC int
-xfs_vm_releasepage(
-	struct page		*page,
-	gfp_t			gfp_mask)
-{
-	trace_xfs_releasepage(page->mapping->host, page, 0, 0);
-	return iomap_releasepage(page, gfp_mask);
-}
-
 STATIC sector_t
 xfs_vm_bmap(
 	struct address_space	*mapping,
@@ -661,7 +642,6 @@ xfs_vm_readpage(
 	struct file		*unused,
 	struct page		*page)
 {
-	trace_xfs_vm_readpage(page->mapping->host, 1);
 	return iomap_readpage(page, &xfs_iomap_ops);
 }
 
@@ -672,7 +652,6 @@ xfs_vm_readpages(
 	struct list_head	*pages,
 	unsigned		nr_pages)
 {
-	trace_xfs_vm_readpages(mapping->host, nr_pages);
 	return iomap_readpages(mapping, pages, nr_pages, &xfs_iomap_ops);
 }
 
@@ -692,8 +671,8 @@ const struct address_space_operations xfs_address_space_operations = {
 	.writepage		= xfs_vm_writepage,
 	.writepages		= xfs_vm_writepages,
 	.set_page_dirty		= iomap_set_page_dirty,
-	.releasepage		= xfs_vm_releasepage,
-	.invalidatepage		= xfs_vm_invalidatepage,
+	.releasepage		= iomap_releasepage,
+	.invalidatepage		= iomap_invalidatepage,
 	.bmap			= xfs_vm_bmap,
 	.direct_IO		= noop_direct_IO,
 	.migratepage		= iomap_migrate_page,
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 65c920554b96..c44dadb6faba 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1153,71 +1153,6 @@ DEFINE_RW_EVENT(xfs_file_buffered_write);
 DEFINE_RW_EVENT(xfs_file_direct_write);
 DEFINE_RW_EVENT(xfs_file_dax_write);
 
-DECLARE_EVENT_CLASS(xfs_page_class,
-	TP_PROTO(struct inode *inode, struct page *page, unsigned long off,
-		 unsigned int len),
-	TP_ARGS(inode, page, off, len),
-	TP_STRUCT__entry(
-		__field(dev_t, dev)
-		__field(xfs_ino_t, ino)
-		__field(pgoff_t, pgoff)
-		__field(loff_t, size)
-		__field(unsigned long, offset)
-		__field(unsigned int, length)
-	),
-	TP_fast_assign(
-		__entry->dev = inode->i_sb->s_dev;
-		__entry->ino = XFS_I(inode)->i_ino;
-		__entry->pgoff = page_offset(page);
-		__entry->size = i_size_read(inode);
-		__entry->offset = off;
-		__entry->length = len;
-	),
-	TP_printk("dev %d:%d ino 0x%llx pgoff 0x%lx size 0x%llx offset %lx "
-		  "length %x",
-		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  __entry->ino,
-		  __entry->pgoff,
-		  __entry->size,
-		  __entry->offset,
-		  __entry->length)
-)
-
-#define DEFINE_PAGE_EVENT(name)		\
-DEFINE_EVENT(xfs_page_class, name,	\
-	TP_PROTO(struct inode *inode, struct page *page, unsigned long off, \
-		 unsigned int len),	\
-	TP_ARGS(inode, page, off, len))
-DEFINE_PAGE_EVENT(xfs_writepage);
-DEFINE_PAGE_EVENT(xfs_releasepage);
-DEFINE_PAGE_EVENT(xfs_invalidatepage);
-
-DECLARE_EVENT_CLASS(xfs_readpage_class,
-	TP_PROTO(struct inode *inode, int nr_pages),
-	TP_ARGS(inode, nr_pages),
-	TP_STRUCT__entry(
-		__field(dev_t, dev)
-		__field(xfs_ino_t, ino)
-		__field(int, nr_pages)
-	),
-	TP_fast_assign(
-		__entry->dev = inode->i_sb->s_dev;
-		__entry->ino = inode->i_ino;
-		__entry->nr_pages = nr_pages;
-	),
-	TP_printk("dev %d:%d ino 0x%llx nr_pages %d",
-		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  __entry->ino,
-		  __entry->nr_pages)
-)
-
-#define DEFINE_READPAGE_EVENT(name)		\
-DEFINE_EVENT(xfs_readpage_class, name,	\
-	TP_PROTO(struct inode *inode, int nr_pages), \
-	TP_ARGS(inode, nr_pages))
-DEFINE_READPAGE_EVENT(xfs_vm_readpage);
-DEFINE_READPAGE_EVENT(xfs_vm_readpages);
-
 DECLARE_EVENT_CLASS(xfs_imap_class,
 	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, ssize_t count,
 		 int whichfork, struct xfs_bmbt_irec *irec),
diff --git a/include/trace/events/iomap.h b/include/trace/events/iomap.h
new file mode 100644
index 000000000000..1da90e743e6e
--- /dev/null
+++ b/include/trace/events/iomap.h
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2009-2019, Christoph Hellwig
+ * All Rights Reserved.
+ *
+ * NOTE: none of these tracepoints shall be consider a stable kernel ABI
+ * as they can change at any time.
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM iomap
+
+#if !defined(_TRACE_IOMAP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_IOMAP_H
+
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(iomap_page_class,
+	TP_PROTO(struct inode *inode, struct page *page, unsigned long off,
+		 unsigned int len),
+	TP_ARGS(inode, page, off, len),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(u64, ino)
+		__field(pgoff_t, pgoff)
+		__field(loff_t, size)
+		__field(unsigned long, offset)
+		__field(unsigned int, length)
+	),
+	TP_fast_assign(
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->ino = inode->i_ino;
+		__entry->pgoff = page_offset(page);
+		__entry->size = i_size_read(inode);
+		__entry->offset = off;
+		__entry->length = len;
+	),
+	TP_printk("dev %d:%d ino 0x%llx pgoff 0x%lx size 0x%llx offset %lx "
+		  "length %x",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino,
+		  __entry->pgoff,
+		  __entry->size,
+		  __entry->offset,
+		  __entry->length)
+)
+
+#define DEFINE_PAGE_EVENT(name)		\
+DEFINE_EVENT(iomap_page_class, name,	\
+	TP_PROTO(struct inode *inode, struct page *page, unsigned long off, \
+		 unsigned int len),	\
+	TP_ARGS(inode, page, off, len))
+DEFINE_PAGE_EVENT(iomap_writepage);
+DEFINE_PAGE_EVENT(iomap_releasepage);
+DEFINE_PAGE_EVENT(iomap_invalidatepage);
+
+DECLARE_EVENT_CLASS(iomap_readpage_class,
+	TP_PROTO(struct inode *inode, int nr_pages),
+	TP_ARGS(inode, nr_pages),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(u64, ino)
+		__field(int, nr_pages)
+	),
+	TP_fast_assign(
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->ino = inode->i_ino;
+		__entry->nr_pages = nr_pages;
+	),
+	TP_printk("dev %d:%d ino 0x%llx nr_pages %d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino,
+		  __entry->nr_pages)
+)
+
+#define DEFINE_READPAGE_EVENT(name)		\
+DEFINE_EVENT(iomap_readpage_class, name,	\
+	TP_PROTO(struct inode *inode, int nr_pages), \
+	TP_ARGS(inode, nr_pages))
+DEFINE_READPAGE_EVENT(iomap_readpage);
+DEFINE_READPAGE_EVENT(iomap_readpages);
+
+#endif /* _TRACE_IOMAP_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.20.1

