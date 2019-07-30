Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4B7B79DDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 03:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfG3BU0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 21:20:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35908 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfG3BU0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:20:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6U18dp6095536;
        Tue, 30 Jul 2019 01:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=X2rsGFHkGZ94nkySTuDjLMBJ5ZESU5Yu/01bzdPGpKc=;
 b=TCYEB+CK+T39rtxIawFwdRx/XFCSMHSbwLWkWvTr7uZKBF430JCRzdUCrlLdyGUttiBj
 iRa5hke2xoxk2v3yFO36fIJT4s+H+agfHvFxgCK5QbNmBugMjSIPnOysH5fFITdfuT/C
 P6A/8BfTxvb5gDrCBmW9AacpvFDXNk6S3A+ciTiQy38CH1nTc5Vnkuv0XbN887Z1xlS/
 i11BB4gPzLyrSN811Tv1ScGOjUHAOx7/ZLV8t+OGNShbfa0UtQ1FHyQcvZnl5p3KslaX
 ngLoCtENW6biAwk3aG7720091CyApY11PD3Z/j44krc0vGCreod+765dpzB7YyoAqQ0l IA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2u0ejpb0fk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 01:18:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6U1D9ui033894;
        Tue, 30 Jul 2019 01:18:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2u0dxqmrhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 01:18:01 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6U1I0i1016849;
        Tue, 30 Jul 2019 01:18:00 GMT
Received: from localhost (/10.159.132.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Jul 2019 18:17:59 -0700
Subject: [PATCH 3/6] iomap: add tracing for the address space operations
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Damien.LeMoal@wdc.com, Christoph Hellwig <hch@lst.de>,
        agruenba@redhat.com
Date:   Mon, 29 Jul 2019 18:17:59 -0700
Message-ID: <156444947938.2682261.6673442000849449944.stgit@magnolia>
In-Reply-To: <156444945993.2682261.3926017251626679029.stgit@magnolia>
References: <156444945993.2682261.3926017251626679029.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9333 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907300010
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9333 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907300010
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Lift the xfs code for tracing address space operations to the iomap
layer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
[darrick: remove deletion of xfs writeback tracepoints]
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/iomap/buffered-io.c       |   13 ++++++
 include/trace/events/iomap.h |   85 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)
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

