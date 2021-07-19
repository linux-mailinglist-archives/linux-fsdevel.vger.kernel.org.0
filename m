Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216ED3CD2E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 13:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbhGSKRM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 06:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbhGSKRK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:17:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E118C061574;
        Mon, 19 Jul 2021 03:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ReK5P1Aw8wvnIZx+Mz9u/dmVMpqMQ64b3rX3XMv3GdU=; b=onm5jvyihyowIk/S3pOvF2O/n4
        73USgPkMxu+BvegS9LtzofK/wLOYmPyghNos4cyhmZe8Qy0o3mckJ9S+7KGuWDpeHfTZY4lkWd/x6
        ez1KmUQvXaztIAkEuL6ykpNnXEY9heUCQuNqXQ7qSQ8GkVzXICmcjB0B1VK+mX5LN6OLOxwWFSaOn
        o9fV0Lp3m49DBp3ojqcAXNuwStHSEq+bRRyg6C6z3gFRiQB08cFk8hVtwE/LSArW0ezvmTWKBoB/I
        t2aVyfMDvRGTl3IovWH6ucxolQAXlCvIaG8CZtKm6nB2GTn2TI+bgKJ7bBRkyqS+GEt6SJ1Z1RnHQ
        vL4kkFaw==;
Received: from [2001:4bb8:193:7660:d2a4:8d57:2e55:21d0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5QvV-006lx6-Hf; Mon, 19 Jul 2021 10:55:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: [PATCH 17/27] iomap: switch iomap_seek_hole to use iomap_iter
Date:   Mon, 19 Jul 2021 12:35:10 +0200
Message-Id: <20210719103520.495450-18-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719103520.495450-1-hch@lst.de>
References: <20210719103520.495450-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rewrite iomap_seek_hole to use iomap_iter.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/seek.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
index ce6fb810854fec..7d6ed9af925e96 100644
--- a/fs/iomap/seek.c
+++ b/fs/iomap/seek.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2017 Red Hat, Inc.
- * Copyright (c) 2018 Christoph Hellwig.
+ * Copyright (c) 2018-2021 Christoph Hellwig.
  */
 #include <linux/module.h>
 #include <linux/compiler.h>
@@ -10,21 +10,19 @@
 #include <linux/pagemap.h>
 #include <linux/pagevec.h>
 
-static loff_t
-iomap_seek_hole_actor(struct inode *inode, loff_t start, loff_t length,
-		      void *data, struct iomap *iomap, struct iomap *srcmap)
+static loff_t iomap_seek_hole_iter(const struct iomap_iter *iter, loff_t *pos)
 {
-	loff_t offset = start;
+	loff_t length = iomap_length(iter);
 
-	switch (iomap->type) {
+	switch (iter->iomap.type) {
 	case IOMAP_UNWRITTEN:
-		offset = mapping_seek_hole_data(inode->i_mapping, start,
-				start + length, SEEK_HOLE);
-		if (offset == start + length)
+		*pos = mapping_seek_hole_data(iter->inode->i_mapping,
+				iter->pos, iter->pos + length, SEEK_HOLE);
+		if (*pos == iter->pos + length)
 			return length;
-		fallthrough;
+		return 0;
 	case IOMAP_HOLE:
-		*(loff_t *)data = offset;
+		*pos = iter->pos;
 		return 0;
 	default:
 		return length;
@@ -35,23 +33,25 @@ loff_t
 iomap_seek_hole(struct inode *inode, loff_t offset, const struct iomap_ops *ops)
 {
 	loff_t size = i_size_read(inode);
-	loff_t ret;
+	struct iomap_iter iter = {
+		.inode	= inode,
+		.pos	= offset,
+		.flags	= IOMAP_REPORT,
+	};
+	int ret;
 
 	/* Nothing to be found before or beyond the end of the file. */
 	if (offset < 0 || offset >= size)
 		return -ENXIO;
 
-	while (offset < size) {
-		ret = iomap_apply(inode, offset, size - offset, IOMAP_REPORT,
-				  ops, &offset, iomap_seek_hole_actor);
-		if (ret < 0)
-			return ret;
-		if (ret == 0)
-			break;
-		offset += ret;
-	}
-
-	return offset;
+	iter.len = size - offset;
+	while ((ret = iomap_iter(&iter, ops)) > 0)
+		iter.processed = iomap_seek_hole_iter(&iter, &offset);
+	if (ret < 0)
+		return ret;
+	if (iter.len)
+		return offset;
+	return size;
 }
 EXPORT_SYMBOL_GPL(iomap_seek_hole);
 
-- 
2.30.2

