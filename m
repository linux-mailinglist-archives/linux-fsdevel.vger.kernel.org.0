Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8116C2E0A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2019 09:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732676AbfJAHQU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Oct 2019 03:16:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45466 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfJAHQU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Oct 2019 03:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6kERW7jgpP3mjKJHjYK3lGhnHgcsnWdX2je3JExn10M=; b=mbKG/sQyOFWkrXQCtKwcWjtKEO
        eVfkzAGs739ybPi2AYcCHxliXaAExCEP3ryUAJQonIOGCVZLiE6sI5O64oVyTabJJ77P+tHdZtuNs
        ygzfW8tQg/RrKaBTk7lo8PsO4OSB4bpDMA+7fJMuH5Xou4eIIqIegapxQVsMmBVV+B9Hg1mzB6bwF
        fse0M49ySGd8CBLTmyu5UJPKcJSczKPpXWNqiWhuy4lPRYZG4G5TbdKhrkXARAAYU2DCBVfQFgEGQ
        fNGHE99Ze3wxu96PjRnhWcmqNiU8ZT+86QbOcd9yGaGEmAehP6B40m5gj4fbjkDxW1HvEmYvX+emt
        K5dKb/+A==;
Received: from 089144211233.atnat0020.highway.a1.net ([89.144.211.233] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFCOP-0001PO-0t; Tue, 01 Oct 2019 07:16:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] iomap: add tracing for the readpage / readpages
Date:   Tue,  1 Oct 2019 09:11:42 +0200
Message-Id: <20191001071152.24403-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001071152.24403-1-hch@lst.de>
References: <20191001071152.24403-1-hch@lst.de>
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
 fs/iomap/buffered-io.c       |  7 +++++++
 include/trace/events/iomap.h | 27 +++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 include/trace/events/iomap.h

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index e25901ae3ff4..099daf0c09b8 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -19,6 +19,9 @@
 
 #include "../internal.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/iomap.h>
+
 static struct iomap_page *
 iomap_page_create(struct inode *inode, struct page *page)
 {
@@ -293,6 +296,8 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
 	unsigned poff;
 	loff_t ret;
 
+	trace_iomap_readpage(page->mapping->host, 1);
+
 	for (poff = 0; poff < PAGE_SIZE; poff += ret) {
 		ret = iomap_apply(inode, page_offset(page) + poff,
 				PAGE_SIZE - poff, 0, ops, &ctx,
@@ -389,6 +394,8 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
 	loff_t last = page_offset(list_entry(pages->next, struct page, lru));
 	loff_t length = last - pos + PAGE_SIZE, ret = 0;
 
+	trace_iomap_readpages(mapping->host, nr_pages);
+
 	while (length > 0) {
 		ret = iomap_apply(mapping->host, pos, length, 0, ops,
 				&ctx, iomap_readpages_actor);
diff --git a/include/trace/events/iomap.h b/include/trace/events/iomap.h
new file mode 100644
index 000000000000..7d2fe2c773f3
--- /dev/null
+++ b/include/trace/events/iomap.h
@@ -0,0 +1,27 @@
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

