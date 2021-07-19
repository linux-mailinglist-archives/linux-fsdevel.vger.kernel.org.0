Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975613CD368
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 13:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbhGSK0o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 06:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbhGSK0o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:26:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F16CC061574;
        Mon, 19 Jul 2021 03:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=MpfvbDjH7OF7a+MFzqyZqeNhs9Nt0UJ+KVJWXYbhuC4=; b=jxv8Y7Eh40DpETnurT3NxUATZx
        Vl1G+VlzAbAk3xFa1CPGXY5blTzYtCjS/wgFaKFjCr4LUdc14XKzEqnFZ933JKseZwE9edutss1rx
        wkM88SEcfJ2UDk4mnEa8/zCBVSVN6DxcLlNZumACTkC4wi9/BRWuZwaAxruvn583WVjlSWQy7CkKg
        yIh6DlHMGrrYRhD3TBOfJpQCu6GqVe0Lx6sQ4tUtR8i7lBfdqRiRl8S5cearQdVnpMXJCLhxcLZI+
        QE4B1VDzWCALL1/uZ+4JwQdB+y/4ktkAMHhndWPJVarjm2/mqu/mVXxTZFAexqWlC4SGQG3a44d76
        6BE8jysw==;
Received: from [2001:4bb8:193:7660:d2a4:8d57:2e55:21d0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5R5B-006mbq-Ek; Mon, 19 Jul 2021 11:05:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: [PATCH 27/27] iomap: constify iomap_iter_srcmap
Date:   Mon, 19 Jul 2021 12:35:20 +0200
Message-Id: <20210719103520.495450-28-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719103520.495450-1-hch@lst.de>
References: <20210719103520.495450-1-hch@lst.de>
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
---
 fs/iomap/buffered-io.c | 32 ++++++++++++++++----------------
 include/linux/iomap.h  |  2 +-
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index eb5d742b5bf8b7..a2dd42f3115cfa 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -226,20 +226,20 @@ iomap_read_inline_data(struct inode *inode, struct page *page,
 	SetPageUptodate(page);
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
@@ -355,7 +355,7 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
 }
 EXPORT_SYMBOL_GPL(iomap_readpage);
 
-static loff_t iomap_readahead_iter(struct iomap_iter *iter,
+static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx)
 {
 	loff_t length = iomap_length(iter);
@@ -539,10 +539,10 @@ iomap_read_page_sync(loff_t block_start, struct page *page, unsigned poff,
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
@@ -580,11 +580,11 @@ static int __iomap_write_begin(struct iomap_iter *iter, loff_t pos,
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
 
@@ -655,10 +655,10 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
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
@@ -678,7 +678,7 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 		size_t copied, struct page *page)
 {
 	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
-	struct iomap *srcmap = iomap_iter_srcmap(iter);
+	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	loff_t old_size = iter->inode->i_size;
 	size_t ret;
 
@@ -803,7 +803,7 @@ EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
 static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 {
 	struct iomap *iomap = &iter->iomap;
-	struct iomap *srcmap = iomap_iter_srcmap(iter);
+	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	loff_t pos = iter->pos;
 	loff_t length = iomap_length(iter);
 	long status = 0;
@@ -879,7 +879,7 @@ static s64 __iomap_zero_iter(struct iomap_iter *iter, loff_t pos, u64 length)
 static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 {
 	struct iomap *iomap = &iter->iomap;
-	struct iomap *srcmap = iomap_iter_srcmap(iter);
+	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	loff_t pos = iter->pos;
 	loff_t length = iomap_length(iter);
 	loff_t written = 0;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 719798814bdfdb..a1fb0d22efbd40 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -193,7 +193,7 @@ static inline u64 iomap_length(const struct iomap_iter *iter)
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

