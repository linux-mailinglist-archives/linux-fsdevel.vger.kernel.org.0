Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61213CD2C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 12:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbhGSKK2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 06:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235621AbhGSKK1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:10:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C6CC061574;
        Mon, 19 Jul 2021 02:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DgzDilvzv+eYs/yJD8tN3O1jUGQmFMp9JdknTR7V5sE=; b=iYWnwFknJQyv8XP9p653rpxYZc
        sDi4ww+jpTB+Vv0aLgVIzeF5TS7wRwoMvS5mb8KzaInMzYjwUfkYCAGUhSiLTrZ1Gxy2Ixtlyiy6p
        cBOEOMoVAptyk68Of10ZtHIMo1jBuRWjqFMzvWcXpE3rvv3MKXyqSMxbLZzj3mhvB2mX6PNXw9noh
        YHCqHa9uZFyMdGYcCllsvCQCU6oNqlxDSOmuen8KARZ6yLDuE+W//MjN3IsoYxtANm7yfJU37mBWw
        iskkitgTBgj39yPwcd3BWJ7LYpqFH3x0dqPjHAYzI/nvsZgK2u6ODIDRCBUPQl28HqdtUOdNCadBo
        pmO5KaEw==;
Received: from [2001:4bb8:193:7660:d2a4:8d57:2e55:21d0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5QoF-006lGP-BC; Mon, 19 Jul 2021 10:48:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: [PATCH 11/27] iomap: switch iomap_file_unshare to use iomap_iter
Date:   Mon, 19 Jul 2021 12:35:04 +0200
Message-Id: <20210719103520.495450-12-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719103520.495450-1-hch@lst.de>
References: <20210719103520.495450-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch iomap_file_unshare to use iomap_iter.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 7195e82d15775e..59781c72c278e5 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -806,10 +806,12 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
 }
 EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
 
-static loff_t
-iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
-		struct iomap *iomap, struct iomap *srcmap)
+static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 {
+	struct iomap *iomap = &iter->iomap;
+	struct iomap *srcmap = iomap_iter_srcmap(iter);
+	loff_t pos = iter->pos;
+	loff_t length = iomap_length(iter);
 	long status = 0;
 	loff_t written = 0;
 
@@ -825,12 +827,12 @@ iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		unsigned long bytes = min_t(loff_t, PAGE_SIZE - offset, length);
 		struct page *page;
 
-		status = iomap_write_begin(inode, pos, bytes,
+		status = iomap_write_begin(iter->inode, pos, bytes,
 				IOMAP_WRITE_F_UNSHARE, &page, iomap, srcmap);
 		if (unlikely(status))
 			return status;
 
-		status = iomap_write_end(inode, pos, bytes, bytes, page, iomap,
+		status = iomap_write_end(iter->inode, pos, bytes, bytes, page, iomap,
 				srcmap);
 		if (WARN_ON_ONCE(status == 0))
 			return -EIO;
@@ -841,7 +843,7 @@ iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		written += status;
 		length -= status;
 
-		balance_dirty_pages_ratelimited(inode->i_mapping);
+		balance_dirty_pages_ratelimited(iter->inode->i_mapping);
 	} while (length);
 
 	return written;
@@ -851,18 +853,17 @@ int
 iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 		const struct iomap_ops *ops)
 {
-	loff_t ret;
-
-	while (len) {
-		ret = iomap_apply(inode, pos, len, IOMAP_WRITE, ops, NULL,
-				iomap_unshare_actor);
-		if (ret <= 0)
-			return ret;
-		pos += ret;
-		len -= ret;
-	}
+	struct iomap_iter iter = {
+		.inode		= inode,
+		.pos		= pos,
+		.len		= len,
+		.flags		= IOMAP_WRITE,
+	};
+	int ret;
 
-	return 0;
+	while ((ret = iomap_iter(&iter, ops)) > 0)
+		iter.processed = iomap_unshare_iter(&iter);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(iomap_file_unshare);
 
-- 
2.30.2

