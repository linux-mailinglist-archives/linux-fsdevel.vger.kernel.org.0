Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF7F3E3FD8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 08:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhHIGZE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 02:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbhHIGZD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 02:25:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A451C0613CF;
        Sun,  8 Aug 2021 23:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XEbDP9G5QiiKlySv/o2oKL+XeM1XfcYbTX8eY8LVOBk=; b=R+kpG2M7/7Ddlly7BFWf9pYf36
        x9l82cY77TB2Nppu8EyEY6sH4i8hwxdrpixOh5cQSBbOIOGwmpXR9N7qRVAUSZ/KXnI/v2OkKv66t
        UqVPp5KTgcWuTYgE/x714lAFjhhqpTGWrBguFiK//0r/PN2C9AyRdRS9BNZ4K6WBx8u8tYQSn1csS
        WyEZ++glpIjnAuPnv8WvZMAvhx8q80KIyGTzCv14L+H/5o/LBdVjOyBjc1OMVP8lrBvU3jHMhMYTy
        SkqYJM3Njht95ieczQxQ7X2XZxXBJUkm1tzT6V15/ulaAbp8xEdRch+4sEhNWI9qfrMgSgbuTqToB
        XpOH9WMQ==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCygT-00Ah5e-4K; Mon, 09 Aug 2021 06:23:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: [PATCH 13/30] iomap: switch iomap_file_buffered_write to use iomap_iter
Date:   Mon,  9 Aug 2021 08:12:27 +0200
Message-Id: <20210809061244.1196573-14-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210809061244.1196573-1-hch@lst.de>
References: <20210809061244.1196573-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch iomap_file_buffered_write to use iomap_iter.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 49 +++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9cda461887afad..4c7e82928cc546 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -726,13 +726,14 @@ static size_t iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	return ret;
 }
 
-static loff_t
-iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
-		struct iomap *iomap, struct iomap *srcmap)
+static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 {
-	struct iov_iter *i = data;
-	long status = 0;
+	struct iomap *srcmap = iomap_iter_srcmap(iter);
+	struct iomap *iomap = &iter->iomap;
+	loff_t length = iomap_length(iter);
+	loff_t pos = iter->pos;
 	ssize_t written = 0;
+	long status = 0;
 
 	do {
 		struct page *page;
@@ -758,18 +759,18 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 			break;
 		}
 
-		status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap,
-				srcmap);
+		status = iomap_write_begin(iter->inode, pos, bytes, 0, &page,
+					   iomap, srcmap);
 		if (unlikely(status))
 			break;
 
-		if (mapping_writably_mapped(inode->i_mapping))
+		if (mapping_writably_mapped(iter->inode->i_mapping))
 			flush_dcache_page(page);
 
 		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
 
-		status = iomap_write_end(inode, pos, bytes, copied, page, iomap,
-				srcmap);
+		status = iomap_write_end(iter->inode, pos, bytes, copied, page,
+					 iomap, srcmap);
 
 		if (unlikely(copied != status))
 			iov_iter_revert(i, copied - status);
@@ -790,29 +791,29 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		written += status;
 		length -= status;
 
-		balance_dirty_pages_ratelimited(inode->i_mapping);
+		balance_dirty_pages_ratelimited(iter->inode->i_mapping);
 	} while (iov_iter_count(i) && length);
 
 	return written ? written : status;
 }
 
 ssize_t
-iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *iter,
+iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
 		const struct iomap_ops *ops)
 {
-	struct inode *inode = iocb->ki_filp->f_mapping->host;
-	loff_t pos = iocb->ki_pos, ret = 0, written = 0;
-
-	while (iov_iter_count(iter)) {
-		ret = iomap_apply(inode, pos, iov_iter_count(iter),
-				IOMAP_WRITE, ops, iter, iomap_write_actor);
-		if (ret <= 0)
-			break;
-		pos += ret;
-		written += ret;
-	}
+	struct iomap_iter iter = {
+		.inode		= iocb->ki_filp->f_mapping->host,
+		.pos		= iocb->ki_pos,
+		.len		= iov_iter_count(i),
+		.flags		= IOMAP_WRITE,
+	};
+	int ret;
 
-	return written ? written : ret;
+	while ((ret = iomap_iter(&iter, ops)) > 0)
+		iter.processed = iomap_write_iter(&iter, i);
+	if (iter.pos == iocb->ki_pos)
+		return ret;
+	return iter.pos - iocb->ki_pos;
 }
 EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
 
-- 
2.30.2

