Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576812655C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 01:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgIJXsA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 19:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgIJXrO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 19:47:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD714C061795;
        Thu, 10 Sep 2020 16:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=YZnnUeh245rr7iWDrjGXfBfXbYJAGYznps3srrljZiU=; b=wCNGlfI6LdG1tqwj/rgxtj/Yi1
        ajclpQJXbTGBiRmJQNp0h0kuxHvWNPtQYEP2KwrTas94eB65O8PWGGGxwb56RSjV0+LMt3nF2mlFO
        pBuMOEuhnwNyJSImDEVQkAjLxYKRUKwHVZtD5awLMXeAdL3SvwURjVSXuhziAr5K4riixaH6arnhI
        52Raht5C3F5RxO39z2HfzZf2GNQkNsNe/4lJfC9Lbmc6+O2aHJLbFELrZNCAd+3/O68O3cgAcWlKt
        h3tFSZZMeTUiu74e+5KrVbt67rr3ALVu1rGpSZlsMP5ws6MmCwwLaiACwPu/b1H2PnVczeue86TfG
        PrKnxWcA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGWHX-0001Sb-PU; Thu, 10 Sep 2020 23:47:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 7/9] iomap: Convert write_count to write_bytes_pending
Date:   Fri, 11 Sep 2020 00:47:05 +0100
Message-Id: <20200910234707.5504-8-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200910234707.5504-1-willy@infradead.org>
References: <20200910234707.5504-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of counting bio segments, count the number of bytes submitted.
This insulates us from the block layer's definition of what a 'same page'
is, which is not necessarily clear once THPs are involved.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 1cf976a8e55c..64a5cb383f30 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -27,7 +27,7 @@
  */
 struct iomap_page {
 	atomic_t		read_bytes_pending;
-	atomic_t		write_count;
+	atomic_t		write_bytes_pending;
 	spinlock_t		uptodate_lock;
 	unsigned long		uptodate[];
 };
@@ -73,7 +73,7 @@ iomap_page_release(struct page *page)
 	if (!iop)
 		return;
 	WARN_ON_ONCE(atomic_read(&iop->read_bytes_pending));
-	WARN_ON_ONCE(atomic_read(&iop->write_count));
+	WARN_ON_ONCE(atomic_read(&iop->write_bytes_pending));
 	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
 			PageUptodate(page));
 	kfree(iop);
@@ -1047,7 +1047,7 @@ EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
 
 static void
 iomap_finish_page_writeback(struct inode *inode, struct page *page,
-		int error)
+		int error, unsigned int len)
 {
 	struct iomap_page *iop = to_iomap_page(page);
 
@@ -1057,9 +1057,9 @@ iomap_finish_page_writeback(struct inode *inode, struct page *page,
 	}
 
 	WARN_ON_ONCE(i_blocks_per_page(inode, page) > 1 && !iop);
-	WARN_ON_ONCE(iop && atomic_read(&iop->write_count) <= 0);
+	WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) <= 0);
 
-	if (!iop || atomic_dec_and_test(&iop->write_count))
+	if (!iop || atomic_sub_and_test(len, &iop->write_bytes_pending))
 		end_page_writeback(page);
 }
 
@@ -1093,7 +1093,8 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 
 		/* walk each page on bio, ending page IO on them */
 		bio_for_each_segment_all(bv, bio, iter_all)
-			iomap_finish_page_writeback(inode, bv->bv_page, error);
+			iomap_finish_page_writeback(inode, bv->bv_page, error,
+					bv->bv_len);
 		bio_put(bio);
 	}
 	/* The ioend has been freed by bio_put() */
@@ -1309,8 +1310,8 @@ iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
 
 	merged = __bio_try_merge_page(wpc->ioend->io_bio, page, len, poff,
 			&same_page);
-	if (iop && !same_page)
-		atomic_inc(&iop->write_count);
+	if (iop)
+		atomic_add(len, &iop->write_bytes_pending);
 
 	if (!merged) {
 		if (bio_full(wpc->ioend->io_bio, len)) {
@@ -1353,7 +1354,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	LIST_HEAD(submit_list);
 
 	WARN_ON_ONCE(i_blocks_per_page(inode, page) > 1 && !iop);
-	WARN_ON_ONCE(iop && atomic_read(&iop->write_count) != 0);
+	WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) != 0);
 
 	/*
 	 * Walk through the page to find areas to write back. If we run off the
-- 
2.28.0

