Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 450DBCD328
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2019 17:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfJFPse (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Oct 2019 11:48:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53490 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfJFPsa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Oct 2019 11:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fvImIjD1lUeceEN2XdMkTxJvCc5k5pJT064KN6goV7Q=; b=P9y1T4HcLKgR+927ulqk+ydH5z
        P2Kzf9Dm+vf0QKdYKTbdyhBMMi9GEB5gzaiM8ozh98TIL1lknoa3lD9FPcCzCVRWU5zOdC5HK3ayJ
        sxgmyph8+d0tNqzIdGh1NjEqoS01tuD8sUKymhXK3ViK4KfW9mYf8Ymkj/jaI7fTNWFsTBqcCcxll
        jzyM43su+dkMfLkdjYgYoaGysg2ogneOY1nshQWIkcbGOxdLX9iHFThTz+5YRE4piy1iZBAO7+o+D
        R2o20O+0wjVAYx6AHNnpITc3qZ+xttXXOqI9l6FKSG7bKayz9MWRcSm8oyNG1GFXFYWLQc8iqowiC
        RXHZlDNg==;
Received: from [2001:4bb8:18c:4d4a:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iH8ll-0008RR-6k; Sun, 06 Oct 2019 15:48:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] iomap: add tracing for the readpage / readpages
Date:   Sun,  6 Oct 2019 17:45:58 +0200
Message-Id: <20191006154608.24738-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191006154608.24738-1-hch@lst.de>
References: <20191006154608.24738-1-hch@lst.de>
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
 fs/iomap/trace.h       | 49 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 7 deletions(-)
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
index e25901ae3ff4..fb209272765c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -16,6 +16,7 @@
 #include <linux/bio.h>
 #include <linux/sched/signal.h>
 #include <linux/migrate.h>
+#include "trace.h"
 
 #include "../internal.h"
 
@@ -293,6 +294,8 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
 	unsigned poff;
 	loff_t ret;
 
+	trace_iomap_readpage(page->mapping->host, 1);
+
 	for (poff = 0; poff < PAGE_SIZE; poff += ret) {
 		ret = iomap_apply(inode, page_offset(page) + poff,
 				PAGE_SIZE - poff, 0, ops, &ctx,
@@ -389,6 +392,8 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
 	loff_t last = page_offset(list_entry(pages->next, struct page, lru));
 	loff_t length = last - pos + PAGE_SIZE, ret = 0;
 
+	trace_iomap_readpages(mapping->host, nr_pages);
+
 	while (length > 0) {
 		ret = iomap_apply(mapping->host, pos, length, 0, ops,
 				&ctx, iomap_readpages_actor);
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
new file mode 100644
index 000000000000..7798aeda7fb9
--- /dev/null
+++ b/fs/iomap/trace.h
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
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
-- 
2.20.1

