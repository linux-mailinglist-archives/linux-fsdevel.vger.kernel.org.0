Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141512655C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 01:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgIJXsE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 19:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgIJXrN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 19:47:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF5AC0613ED;
        Thu, 10 Sep 2020 16:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ldPCHrf1j5mleYrfsHCzGqCm1zQB/iX5hoqH8XIbE8U=; b=IgXVRZE2DYIOQuzM9HNd431Z4E
        ZY/7B3nvSrPnIiW67vgG8bRk+caYifYshuqnW/zTEMcL8sTwU6dSyOtU2IctEI1Jf2mQu0LWItEDu
        i6BymYHp/YZcjuEH+QIZQTf8bfeAiMcYUyQYyy9JmPePYcO0NDy9LjuDyHQzjRG/a2gLJo31wBfqh
        hspM/mScCQNXwr/EYroURtlNv2wzwSMRmamePhn9UxOpHJcaozir0P//EQ1wnVtN6QQ+w/ckE8+cH
        4KMsRyY3Z02xE3uJh/AdIuCbLmzptYzZtlT2/tAJl4WZtBlFnus9UlCyCmx+NkaTIyhgnLnTtKY7i
        F6yTcn0Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGWHW-0001S7-W2; Thu, 10 Sep 2020 23:47:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net,
        Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v2 5/9] iomap: Support arbitrarily many blocks per page
Date:   Fri, 11 Sep 2020 00:47:03 +0100
Message-Id: <20200910234707.5504-6-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200910234707.5504-1-willy@infradead.org>
References: <20200910234707.5504-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Size the uptodate array dynamically to support larger pages in the
page cache.  With a 64kB page, we're only saving 8 bytes per page today,
but with a 2MB maximum page size, we'd have to allocate more than 4kB
per page.  Add a few debugging assertions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
---
 fs/iomap/buffered-io.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 7fc0e02d27b0..9670c096b83e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -22,18 +22,25 @@
 #include "../internal.h"
 
 /*
- * Structure allocated for each page when block size < PAGE_SIZE to track
- * sub-page uptodate status and I/O completions.
+ * Structure allocated for each page or THP when block size < page size
+ * to track sub-page uptodate status and I/O completions.
  */
 struct iomap_page {
 	atomic_t		read_count;
 	atomic_t		write_count;
 	spinlock_t		uptodate_lock;
-	DECLARE_BITMAP(uptodate, PAGE_SIZE / 512);
+	unsigned long		uptodate[];
 };
 
 static inline struct iomap_page *to_iomap_page(struct page *page)
 {
+	/*
+	 * per-block data is stored in the head page.  Callers should
+	 * not be dealing with tail pages (and if they are, they can
+	 * call thp_head() first.
+	 */
+	VM_BUG_ON_PGFLAGS(PageTail(page), page);
+
 	if (page_has_private(page))
 		return (struct iomap_page *)page_private(page);
 	return NULL;
@@ -45,11 +52,13 @@ static struct iomap_page *
 iomap_page_create(struct inode *inode, struct page *page)
 {
 	struct iomap_page *iop = to_iomap_page(page);
+	unsigned int nr_blocks = i_blocks_per_page(inode, page);
 
-	if (iop || i_blocks_per_page(inode, page) <= 1)
+	if (iop || nr_blocks <= 1)
 		return iop;
 
-	iop = kzalloc(sizeof(*iop), GFP_NOFS | __GFP_NOFAIL);
+	iop = kzalloc(struct_size(iop, uptodate, BITS_TO_LONGS(nr_blocks)),
+			GFP_NOFS | __GFP_NOFAIL);
 	spin_lock_init(&iop->uptodate_lock);
 	attach_page_private(page, iop);
 	return iop;
@@ -59,11 +68,14 @@ static void
 iomap_page_release(struct page *page)
 {
 	struct iomap_page *iop = detach_page_private(page);
+	unsigned int nr_blocks = i_blocks_per_page(page->mapping->host, page);
 
 	if (!iop)
 		return;
 	WARN_ON_ONCE(atomic_read(&iop->read_count));
 	WARN_ON_ONCE(atomic_read(&iop->write_count));
+	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
+			PageUptodate(page));
 	kfree(iop);
 }
 
-- 
2.28.0

