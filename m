Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B11736FCF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 11:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfGVJvm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 05:51:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40346 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729372AbfGVJuu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8/L1Z1q3gH6LHgMoJG1NkQt2/pkVTqNA5PuMCSiEHLI=; b=sGBRtASUQtW937Lc0X0c2A3Bnm
        FtsH+mq3Dbhac7o+1EP1NaPr15XLNKk6t+G6IpOoUZJv5ppJusMVajWBmv+2nWKE288UC8HezO/cy
        H0xkl85eVnJk74dBnUJsy4ZOdWVqsNGP6SraWfPoew8ec6tmYB5eZLxvllC/dc/COeRgMjH9RnBWs
        ND4BcVe0Aa/0jepRGu/hZEQIXm8MRQXOTJTWpnMmRWS9Wdr3wM50DFYBnlk6R02VBYes2TJNrtPCJ
        4VQPEimQeZEPxDjCAtq0+8oLLVuOpYBFu4B9I+V/xaWofy3Nsmm6UTKVPuIj70UUt0AzpL3tCyp+n
        xCE3Vv1g==;
Received: from 089144207240.atnat0016.highway.bob.at ([89.144.207.240] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpUxz-0005fT-Nf; Mon, 22 Jul 2019 09:50:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] iomap: add tracing for the address space operations
Date:   Mon, 22 Jul 2019 11:50:20 +0200
Message-Id: <20190722095024.19075-9-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722095024.19075-1-hch@lst.de>
References: <20190722095024.19075-1-hch@lst.de>
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
 fs/iomap/buffered-io.c       | 13 ++++++
 fs/xfs/xfs_aops.c            | 27 ++----------
 fs/xfs/xfs_trace.h           | 65 ---------------------------
 include/trace/events/iomap.h | 85 ++++++++++++++++++++++++++++++++++++
 4 files changed, 101 insertions(+), 89 deletions(-)
 create mode 100644 include/trace/events/iomap.h

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ff1f7d2b4d7a..21b50e8cb9f2 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -20,6 +20,9 @@
 
 #include "../internal.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/iomap.h>
+
 static struct bio_set iomap_ioend_bioset;
 
 static struct iomap_page *
@@ -296,6 +299,8 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
 	unsigned poff;
 	loff_t ret;
 
+	trace_iomap_readpage(page->mapping->host, 1);
+
 	for (poff = 0; poff < PAGE_SIZE; poff += ret) {
 		ret = iomap_apply(inode, page_offset(page) + poff,
 				PAGE_SIZE - poff, 0, ops, &ctx,
@@ -392,6 +397,8 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
 	loff_t last = page_offset(list_entry(pages->next, struct page, lru));
 	loff_t length = last - pos + PAGE_SIZE, ret = 0;
 
+	trace_iomap_readpages(mapping->host, nr_pages);
+
 	while (length > 0) {
 		ret = iomap_apply(mapping->host, pos, length, 0, ops,
 				&ctx, iomap_readpages_actor);
@@ -458,6 +465,8 @@ EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
 int
 iomap_releasepage(struct page *page, gfp_t gfp_mask)
 {
+	trace_iomap_releasepage(page->mapping->host, page, 0, 0);
+
 	/*
 	 * mm accommodates an old ext3 case where clean pages might not have had
 	 * the dirty bit cleared. Thus, it can send actual dirty pages to
@@ -473,6 +482,8 @@ EXPORT_SYMBOL_GPL(iomap_releasepage);
 void
 iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
 {
+	trace_iomap_invalidatepage(page->mapping->host, page, offset, len);
+
 	/*
 	 * If we are invalidating the entire page, clear the dirty state from it
 	 * and release it to avoid unnecessary buildup of the LRU.
@@ -1485,6 +1496,8 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 	u64 end_offset;
 	loff_t offset;
 
+	trace_iomap_writepage(inode, page, 0, 0);
+
 	/*
 	 * Refuse to write the page out if we are called from reclaim context.
 	 *
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 6dbad5ac48d3..5f8939f6637a 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -531,16 +531,6 @@ xfs_submit_ioend(
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
@@ -575,7 +565,7 @@ xfs_discard_page(
 	if (error && !XFS_FORCED_SHUTDOWN(mp))
 		xfs_alert(mp, "page discard unable to remove delalloc mapping.");
 out_invalidate:
-	xfs_vm_invalidatepage(page, 0, PAGE_SIZE);
+	iomap_invalidatepage(page, 0, PAGE_SIZE);
 }
 
 static const struct iomap_writeback_ops xfs_writeback_ops = {
@@ -615,15 +605,6 @@ xfs_dax_writepages(
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
@@ -652,7 +633,6 @@ xfs_vm_readpage(
 	struct file		*unused,
 	struct page		*page)
 {
-	trace_xfs_vm_readpage(page->mapping->host, 1);
 	return iomap_readpage(page, &xfs_iomap_ops);
 }
 
@@ -663,7 +643,6 @@ xfs_vm_readpages(
 	struct list_head	*pages,
 	unsigned		nr_pages)
 {
-	trace_xfs_vm_readpages(mapping->host, nr_pages);
 	return iomap_readpages(mapping, pages, nr_pages, &xfs_iomap_ops);
 }
 
@@ -683,8 +662,8 @@ const struct address_space_operations xfs_address_space_operations = {
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
index 8094b1920eef..d1d0ec1c44ad 100644
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

