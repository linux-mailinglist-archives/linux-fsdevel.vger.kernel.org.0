Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320C13C42C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 06:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhGLESN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 00:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhGLESN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:18:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916CFC0613DD;
        Sun, 11 Jul 2021 21:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=sS8g2PR33XQsHKDwgj6ow7dv71dRAvcFyk/+foTy130=; b=J7cupigrWwkPGff/jNyNUO2Qbo
        DSAgBpiXEZV2PxA5UngMVJ3KDrHkOXx1zR88TGqiMaz60Hj4u8OD7F3QJZ9LGKXaam+1KflD53eCv
        RGdVdgvxX9FROaiICmjFB7pAwqiYcVDgocF27ImPmZ3nHDNmch4JCTyCTQIrl8KUjrPYMlfV1ePdj
        zjFEOfuylq3dvPhfsoaSJdyOv6+i+unEhjdK/ciCKlllBKK+Q91xc0rEUPnCtfG0KFBRHoaZ+jtsG
        w5+XpjLLw6QfF3L4PBXXdw8v54cuEbpy+BOx0LSjVZRJLkzK0NSkN1HWSmj43GlEdGo5jNhNP75Yh
        nkstVz6A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2nKn-00GrVg-1o; Mon, 12 Jul 2021 04:14:27 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 127/137] iomap: Support multi-page folios in invalidatepage
Date:   Mon, 12 Jul 2021 04:06:51 +0100
Message-Id: <20210712030701.4000097-128-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we're punching a hole in a multi-page folio, we need to remove the
per-page iomap data as the folio is about to be split and each page will
need its own.  This means that writepage can now come across a page with
no iop allocated, so remove the assertion that there is already one,
and just create one (with the uptodate bits set) if there isn't one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bd811b3dbe86..18a683cc5c2b 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -474,13 +474,17 @@ iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
 	trace_iomap_invalidatepage(folio->mapping->host, offset, len);
 
 	/*
-	 * If we are invalidating the entire page, clear the dirty state from it
-	 * and release it to avoid unnecessary buildup of the LRU.
+	 * If we are invalidating the entire folio, clear the dirty state
+	 * from it and release it to avoid unnecessary buildup of the LRU.
 	 */
 	if (offset == 0 && len == folio_size(folio)) {
 		WARN_ON_ONCE(folio_writeback(folio));
 		folio_cancel_dirty(folio);
 		iomap_page_release(folio);
+	} else if (folio_multi(folio)) {
+		/* Must release the iop so the page can be split */
+		WARN_ON_ONCE(!folio_uptodate(folio) && folio_dirty(folio));
+		iomap_page_release(folio);
 	}
 }
 EXPORT_SYMBOL_GPL(iomap_invalidatepage);
@@ -1300,7 +1304,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct inode *inode,
 		struct folio *folio, loff_t end_pos)
 {
-	struct iomap_page *iop = to_iomap_page(folio);
+	struct iomap_page *iop = iomap_page_create(inode, folio);
 	struct iomap_ioend *ioend, *next;
 	unsigned len = i_blocksize(inode);
 	unsigned nblocks = i_blocks_per_folio(inode, folio);
@@ -1308,7 +1312,6 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	int error = 0, count = 0, i;
 	LIST_HEAD(submit_list);
 
-	WARN_ON_ONCE(nblocks > 1 && !iop);
 	WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) != 0);
 
 	/*
-- 
2.30.2

