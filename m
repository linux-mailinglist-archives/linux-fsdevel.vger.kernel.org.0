Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF23159FFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 05:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgBLETj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 23:19:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53956 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgBLESr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 23:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=OHiH3KAgiS8rCXh8VJ0556v4ieZAW8VpEHQUzRQYEA4=; b=Mzmo0k/aq/GOLignpIcekDR9ml
        +jfxQ5r99fcTR6tkjKnQv+GQzMNXmc1WCJ/KNHxG8Ve3zMTQOW7l6i1FbOfnKUZI3Eiw5yhla3ueI
        4FfrnVuwbS4gv0rvuZ18fFl0Euri8VR5EPuXEGBEDeAcPvpg5GTjUj60tLCPgl1Nw54UJqhAHdv8J
        ZfNRECkJVehwyOcfB2jd5qI1K47e7PzpVG0LUyaRIm/FokguXb3RRqxW7pFJsuk7FQ1D5aVxZP+lr
        32PV2qGten9T2IY8nyUPJKyF9akRp/1wZ/4x0PfXzZR6tRcDH/B3GpgY4cadVwioBtChkzABhkqI0
        7bOQ4Uuw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1jU7-0006oB-4o; Wed, 12 Feb 2020 04:18:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/25] iomap: Support large pages in read paths
Date:   Tue, 11 Feb 2020 20:18:36 -0800
Message-Id: <20200212041845.25879-17-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200212041845.25879-1-willy@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use thp_size() instead of PAGE_SIZE, use offset_in_this_page() and
abstract away how to access the list of readahead pages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index e522039f627f..68f8903ecd6d 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -179,14 +179,16 @@ iomap_read_finish(struct iomap_page *iop, struct page *page)
 static void
 iomap_read_page_end_io(struct bio_vec *bvec, int error)
 {
-	struct page *page = bvec->bv_page;
+	struct page *page = compound_head(bvec->bv_page);
 	struct iomap_page *iop = to_iomap_page(page);
+	unsigned offset = bvec->bv_offset +
+				PAGE_SIZE * (bvec->bv_page - page);
 
 	if (unlikely(error)) {
 		ClearPageUptodate(page);
 		SetPageError(page);
 	} else {
-		iomap_set_range_uptodate(page, bvec->bv_offset, bvec->bv_len);
+		iomap_set_range_uptodate(page, offset, bvec->bv_len);
 	}
 
 	iomap_read_finish(iop, page);
@@ -239,6 +241,16 @@ static inline bool iomap_block_needs_zeroing(struct inode *inode,
 		pos >= i_size_read(inode);
 }
 
+/*
+ * Estimate the number of vectors we need based on the current page size;
+ * if we're wrong we'll end up doing an overly large allocation or needing
+ * to do a second allocation, neither of which is a big deal.
+ */
+static unsigned int iomap_nr_vecs(struct page *page, loff_t length)
+{
+	return (length + thp_size(page) - 1) >> page_shift(page);
+}
+
 static loff_t
 iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		struct iomap *iomap, struct iomap *srcmap)
@@ -263,7 +275,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		goto done;
 
 	if (iomap_block_needs_zeroing(inode, iomap, pos)) {
-		zero_user(page, poff, plen);
+		zero_user_large(page, poff, plen);
 		iomap_set_range_uptodate(page, poff, plen);
 		goto done;
 	}
@@ -294,7 +306,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 
 	if (!ctx->bio || !is_contig || bio_full(ctx->bio, plen)) {
 		gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
-		int nr_vecs = (length + PAGE_SIZE - 1) >> PAGE_SHIFT;
+		int nr_vecs = iomap_nr_vecs(page, length);
 
 		if (ctx->bio)
 			submit_bio(ctx->bio);
@@ -331,9 +343,9 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
 
 	trace_iomap_readpage(page->mapping->host, 1);
 
-	for (poff = 0; poff < PAGE_SIZE; poff += ret) {
-		ret = iomap_apply(inode, page_offset(page) + poff,
-				PAGE_SIZE - poff, 0, ops, &ctx,
+	for (poff = 0; poff < thp_size(page); poff += ret) {
+		ret = iomap_apply(inode, file_offset_of_page(page) + poff,
+				thp_size(page) - poff, 0, ops, &ctx,
 				iomap_readpage_actor);
 		if (ret <= 0) {
 			WARN_ON_ONCE(ret == 0);
@@ -376,7 +388,7 @@ iomap_readahead_actor(struct inode *inode, loff_t pos, loff_t length,
 		if (WARN_ON(ret == 0))
 			break;
 		done += ret;
-		if (offset_in_page(pos + done) == 0) {
+		if (offset_in_this_page(ctx->cur_page, pos + done) == 0) {
 			ctx->rac->nr_pages -= ctx->rac->batch_count;
 			if (!ctx->cur_page_in_bio)
 				unlock_page(ctx->cur_page);
-- 
2.25.0

