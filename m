Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7022374796
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 20:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbhEER7Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 13:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbhEER6v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 13:58:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93029C0612EE;
        Wed,  5 May 2021 10:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=p6iosGLR08SJeU1mGDyhL68o4poF65QYXoPTjkLYh+s=; b=KeEgjEgQcyA3Linp3/87Ogtx1E
        LgoSxF2YYaK5f7kVrnIdJ9tmaW3LRYdzuDv+FErBGBp8VyPZul/cfsywvtoDegq0LsQ8SYyDYi9hc
        xAryH+z2eJQ7/WByBFu5naJlh8opxOX26fhjQGSUxzdMESlKb2Hxi4CtNoa7yQWSo2qsSj6KzjoU5
        OvYC3MCSoN82QupyjGY/6DNWaWJCQIEoU4X7Fpz45ZnhYwUn7WIT4HvRNXqPqAQse/JO8KT8KT/sc
        dcWMV2WJS1WvUmu1hVicyE3DA9/UpMQ+e9rJjwi3XGrRmuYIFigL0OJ4JxNh4c5P6yeHGgE7OxfXA
        v8EIvHUQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leLLY-000eYZ-00; Wed, 05 May 2021 17:30:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 93/96] iomap: Convert iomap_read_inline_data to take a folio
Date:   Wed,  5 May 2021 16:06:25 +0100
Message-Id: <20210505150628.111735-94-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Inline data is restricted to being less than a page in size, so we
don't need to handle multi-page folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 1c7e16e6aad1..72fe6741a36c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -194,24 +194,24 @@ struct iomap_readpage_ctx {
 	struct readahead_control *rac;
 };
 
-static void
-iomap_read_inline_data(struct inode *inode, struct page *page,
+static void iomap_read_inline_data(struct inode *inode, struct folio *folio,
 		struct iomap *iomap)
 {
 	size_t size = i_size_read(inode);
 	void *addr;
 
-	if (PageUptodate(page))
+	if (folio_uptodate(folio))
 		return;
 
-	BUG_ON(page->index);
+	BUG_ON(folio->index);
+	BUG_ON(folio_multi(folio));
 	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
 
-	addr = kmap_atomic(page);
+	addr = kmap_local_folio(folio, 0);
 	memcpy(addr, iomap->inline_data, size);
 	memset(addr + size, 0, PAGE_SIZE - size);
-	kunmap_atomic(addr);
-	SetPageUptodate(page);
+	kunmap_local(addr);
+	folio_mark_uptodate(folio);
 }
 
 static inline bool iomap_block_needs_zeroing(struct inode *inode,
@@ -236,7 +236,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 
 	if (iomap->type == IOMAP_INLINE) {
 		WARN_ON_ONCE(pos);
-		iomap_read_inline_data(inode, &folio->page, iomap);
+		iomap_read_inline_data(inode, folio, iomap);
 		return PAGE_SIZE;
 	}
 
@@ -614,7 +614,7 @@ static int iomap_write_begin(struct inode *inode, loff_t pos, size_t len,
 
 	page = folio_file_page(folio, pos >> PAGE_SHIFT);
 	if (srcmap->type == IOMAP_INLINE)
-		iomap_read_inline_data(inode, page, srcmap);
+		iomap_read_inline_data(inode, folio, srcmap);
 	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
 		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
 	else
-- 
2.30.2

