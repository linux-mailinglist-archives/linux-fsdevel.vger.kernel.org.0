Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6150F3E4049
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 08:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbhHIGkz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 02:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbhHIGkz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 02:40:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FB3C0613CF;
        Sun,  8 Aug 2021 23:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/V/BKEJmDEAE7AkgPoIWn/jRt/rFMTo8+kewYlGPwBU=; b=DYN6ij1/L4HmeMlQFaMPaE8PNp
        aQdIxC6UhoLES0vWnkqhK2x6Dd8/aYWxQazfgugEgvxhuS69b4+3BcmgHdzKqfCWL+bfL2ZTIuuKF
        QCxBq3/q+WZDQeajkjN9xLiylEbmJEhmaFWMvEPoPbeID6Dh/BuoMuihnUzy4r2yVMLg22ELpYT/V
        1RdBnyk4CRHgH2F1luQyRZpjAGyP9ECfIdCEq3kS8h9n9zHkmt1q9Pwa7wPKotui3qBmnkcqqNdXs
        1Y3PUjllSBrAqYdPggtsXZFQPrHKLy83iWjH0ihB5anoznPNLS7+1EYpaDPngyADvMjxkWK7YCIm1
        WNbYgTiQ==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCyvh-00AiMG-5b; Mon, 09 Aug 2021 06:38:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: [PATCH 30/30] iomap: constify iomap_iter_srcmap
Date:   Mon,  9 Aug 2021 08:12:44 +0200
Message-Id: <20210809061244.1196573-31-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210809061244.1196573-1-hch@lst.de>
References: <20210809061244.1196573-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The srcmap returned from iomap_iter_srcmap is never modified, so mark
the iomap returned from it const and constify a lot of code that never
modifies the iomap.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 38 +++++++++++++++++++-------------------
 include/linux/iomap.h  |  2 +-
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ef902cc89accca..71b4806266d783 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -205,10 +205,10 @@ struct iomap_readpage_ctx {
 	struct readahead_control *rac;
 };
 
-static loff_t iomap_read_inline_data(struct iomap_iter *iter,
+static loff_t iomap_read_inline_data(const struct iomap_iter *iter,
 		struct page *page)
 {
-	struct iomap *iomap = iomap_iter_srcmap(iter);
+	const struct iomap *iomap = iomap_iter_srcmap(iter);
 	size_t size = i_size_read(iter->inode) - iomap->offset;
 	size_t poff = offset_in_page(iomap->offset);
 	void *addr;
@@ -234,20 +234,20 @@ static loff_t iomap_read_inline_data(struct iomap_iter *iter,
 	return PAGE_SIZE - poff;
 }
 
-static inline bool iomap_block_needs_zeroing(struct iomap_iter *iter,
+static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
 		loff_t pos)
 {
-	struct iomap *srcmap = iomap_iter_srcmap(iter);
+	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 
 	return srcmap->type != IOMAP_MAPPED ||
 		(srcmap->flags & IOMAP_F_NEW) ||
 		pos >= i_size_read(iter->inode);
 }
 
-static loff_t iomap_readpage_iter(struct iomap_iter *iter,
+static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx, loff_t offset)
 {
-	struct iomap *iomap = &iter->iomap;
+	const struct iomap *iomap = &iter->iomap;
 	loff_t pos = iter->pos + offset;
 	loff_t length = iomap_length(iter) - offset;
 	struct page *page = ctx->cur_page;
@@ -352,7 +352,7 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
 }
 EXPORT_SYMBOL_GPL(iomap_readpage);
 
-static loff_t iomap_readahead_iter(struct iomap_iter *iter,
+static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx)
 {
 	loff_t length = iomap_length(iter);
@@ -536,10 +536,10 @@ iomap_read_page_sync(loff_t block_start, struct page *page, unsigned poff,
 	return submit_bio_wait(&bio);
 }
 
-static int __iomap_write_begin(struct iomap_iter *iter, loff_t pos,
+static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 		unsigned len, struct page *page)
 {
-	struct iomap *srcmap = iomap_iter_srcmap(iter);
+	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	struct iomap_page *iop = iomap_page_create(iter->inode, page);
 	loff_t block_size = i_blocksize(iter->inode);
 	loff_t block_start = round_down(pos, block_size);
@@ -577,7 +577,7 @@ static int __iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 	return 0;
 }
 
-static int iomap_write_begin_inline(struct iomap_iter *iter,
+static int iomap_write_begin_inline(const struct iomap_iter *iter,
 		struct page *page)
 {
 	int ret;
@@ -591,11 +591,11 @@ static int iomap_write_begin_inline(struct iomap_iter *iter,
 	return 0;
 }
 
-static int iomap_write_begin(struct iomap_iter *iter, loff_t pos, unsigned len,
-		struct page **pagep)
+static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
+		unsigned len, struct page **pagep)
 {
 	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
-	struct iomap *srcmap = iomap_iter_srcmap(iter);
+	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	struct page *page;
 	int status = 0;
 
@@ -666,10 +666,10 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	return copied;
 }
 
-static size_t iomap_write_end_inline(struct iomap_iter *iter, struct page *page,
-		loff_t pos, size_t copied)
+static size_t iomap_write_end_inline(const struct iomap_iter *iter,
+		struct page *page, loff_t pos, size_t copied)
 {
-	struct iomap *iomap = &iter->iomap;
+	const struct iomap *iomap = &iter->iomap;
 	void *addr;
 
 	WARN_ON_ONCE(!PageUptodate(page));
@@ -689,7 +689,7 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 		size_t copied, struct page *page)
 {
 	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
-	struct iomap *srcmap = iomap_iter_srcmap(iter);
+	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	loff_t old_size = iter->inode->i_size;
 	size_t ret;
 
@@ -814,7 +814,7 @@ EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
 static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 {
 	struct iomap *iomap = &iter->iomap;
-	struct iomap *srcmap = iomap_iter_srcmap(iter);
+	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	loff_t pos = iter->pos;
 	loff_t length = iomap_length(iter);
 	long status = 0;
@@ -890,7 +890,7 @@ static s64 __iomap_zero_iter(struct iomap_iter *iter, loff_t pos, u64 length)
 static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 {
 	struct iomap *iomap = &iter->iomap;
-	struct iomap *srcmap = iomap_iter_srcmap(iter);
+	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	loff_t pos = iter->pos;
 	loff_t length = iomap_length(iter);
 	loff_t written = 0;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index f53c40e9d799fb..24f8489583ca76 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -211,7 +211,7 @@ static inline u64 iomap_length(const struct iomap_iter *iter)
  * for a given operation, which may or may no be identical to the destination
  * map in &i->iomap.
  */
-static inline struct iomap *iomap_iter_srcmap(struct iomap_iter *i)
+static inline const struct iomap *iomap_iter_srcmap(const struct iomap_iter *i)
 {
 	if (i->srcmap.type != IOMAP_HOLE)
 		return &i->srcmap;
-- 
2.30.2

