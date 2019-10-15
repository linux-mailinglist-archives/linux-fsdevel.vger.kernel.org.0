Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 021EED7A36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 17:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387661AbfJOPoR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 11:44:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48102 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387650AbfJOPoR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uEE4/TEUZf6DkBsTypfKTjZtEgJhC5jmAtfD4LRAFQE=; b=i7LzTF5Kz/txPrI7aLwDqypdeu
        H7tEZDQmhJYI/x833Sr6io5JHl2oPB9VrUDysgkLcFwjyW4DXbQRup6oleOIwrn3fWUoKzqgp5i/5
        U5vrlK8b/zcWR0ydEP2hQO7lQzr3St9aYXaA9TWIaGJZbMTy3mHKqdMpNyc321P7up+2nKq+zUiPz
        N/bbsXIW6ZEyCubgKNT9TbPtPnQ6I19s7n80MQYsNE+uznysHXVi5H1TugZTfXM+kiDe2s0ZeYKgO
        PxVuoTk7bzRNvaZI/NOw766Al117xAphojX0QExsxsyBUVvoeK0H0iBlTWtctzOUVSU34v8qQGt0X
        xWrx9UCw==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKOze-0007yB-Br; Tue, 15 Oct 2019 15:44:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] iomap: lift the xfs readpage / readpages tracing to iomap
Date:   Tue, 15 Oct 2019 17:43:41 +0200
Message-Id: <20191015154345.13052-9-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191015154345.13052-1-hch@lst.de>
References: <20191015154345.13052-1-hch@lst.de>
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
 fs/iomap/Makefile      | 16 ++++++++------
 fs/iomap/buffered-io.c |  5 +++++
 fs/iomap/trace.c       | 12 +++++++++++
 fs/iomap/trace.h       | 49 ++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_aops.c      |  2 --
 fs/xfs/xfs_trace.h     | 26 ----------------------
 6 files changed, 75 insertions(+), 35 deletions(-)
 create mode 100644 fs/iomap/trace.c
 create mode 100644 fs/iomap/trace.h

diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
index 93cd11938bf5..eef2722d93a1 100644
--- a/fs/iomap/Makefile
+++ b/fs/iomap/Makefile
@@ -3,13 +3,15 @@
 # Copyright (c) 2019 Oracle.
 # All Rights Reserved.
 #
-obj-$(CONFIG_FS_IOMAP)		+= iomap.o
 
-iomap-y				+= \
-					apply.o \
-					buffered-io.o \
-					direct-io.o \
-					fiemap.o \
-					seek.o
+ccflags-y += -I $(srctree)/$(src)		# needed for trace events
+
+obj-$(CONFIG_FS_IOMAP)		+= iomap.o
 
+iomap-y				+= trace.o \
+				   apply.o \
+				   buffered-io.o \
+				   direct-io.o \
+				   fiemap.o \
+				   seek.o
 iomap-$(CONFIG_SWAP)		+= swapfile.o
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 181ee8477aad..d1620c3f2a4c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -16,6 +16,7 @@
 #include <linux/bio.h>
 #include <linux/sched/signal.h>
 #include <linux/migrate.h>
+#include "trace.h"
 
 #include "../internal.h"
 
@@ -301,6 +302,8 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
 	unsigned poff;
 	loff_t ret;
 
+	trace_iomap_readpage(page->mapping->host, 1);
+
 	for (poff = 0; poff < PAGE_SIZE; poff += ret) {
 		ret = iomap_apply(inode, page_offset(page) + poff,
 				PAGE_SIZE - poff, 0, ops, &ctx,
@@ -397,6 +400,8 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
 	loff_t last = page_offset(list_entry(pages->next, struct page, lru));
 	loff_t length = last - pos + PAGE_SIZE, ret = 0;
 
+	trace_iomap_readpages(mapping->host, nr_pages);
+
 	while (length > 0) {
 		ret = iomap_apply(mapping->host, pos, length, 0, ops,
 				&ctx, iomap_readpages_actor);
diff --git a/fs/iomap/trace.c b/fs/iomap/trace.c
new file mode 100644
index 000000000000..63ce9f0ce4dc
--- /dev/null
+++ b/fs/iomap/trace.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019, Christoph Hellwig
+ */
+#include <linux/iomap.h>
+
+/*
+ * We include this last to have the helpers above available for the trace
+ * event implementations.
+ */
+#define CREATE_TRACE_POINTS
+#include "trace.h"
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
new file mode 100644
index 000000000000..3900de1d871d
--- /dev/null
+++ b/fs/iomap/trace.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2009-2019, Christoph Hellwig
+ *
+ * NOTE: none of these tracepoints shall be consider a stable kernel ABI
+ * as they can change at any time.
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM iomap
+
+#if !defined(_IOMAP_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _IOMAP_TRACE_H
+
+#include <linux/tracepoint.h>
+
+struct inode;
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
+#endif /* _IOMAP_TRACE_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace
+#include <trace/define_trace.h>
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 00fe40b35f72..e2033b070f4a 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -1184,7 +1184,6 @@ xfs_vm_readpage(
 	struct file		*unused,
 	struct page		*page)
 {
-	trace_xfs_vm_readpage(page->mapping->host, 1);
 	return iomap_readpage(page, &xfs_iomap_ops);
 }
 
@@ -1195,7 +1194,6 @@ xfs_vm_readpages(
 	struct list_head	*pages,
 	unsigned		nr_pages)
 {
-	trace_xfs_vm_readpages(mapping->host, nr_pages);
 	return iomap_readpages(mapping, pages, nr_pages, &xfs_iomap_ops);
 }
 
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index eaae275ed430..eae4b29c174e 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1197,32 +1197,6 @@ DEFINE_PAGE_EVENT(xfs_writepage);
 DEFINE_PAGE_EVENT(xfs_releasepage);
 DEFINE_PAGE_EVENT(xfs_invalidatepage);
 
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
-- 
2.20.1

