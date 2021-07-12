Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC523C4279
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhGLECc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 00:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhGLECb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:02:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6F7C0613DD;
        Sun, 11 Jul 2021 20:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=1VxVAER2WoN9bRCzfSLJBgKZ2elY35emYxLJan5Dqrg=; b=ZqnJxyKLanQUGJhyk0g5ihLNQZ
        x0kjoAEg19XYWYNz+zliCFluH3sEAvf7bdpBADEz2iuccqAHv9uAaqQmF9akooYwOeO1fx5oa8LW5
        PmiwLerjywYboD9PLCT3TXGKk2FdTd+tTNN59Bhjtlh2zySsRIPX0QrKacdhU8/0XSJ3A5TE3Fcft
        ibLhmc03hBPE0wDqH0aKU8KZhXzTw44i+n2bNOe12Z8MvlmcfM999aWkxcGbd6KlV+HB29njGWb0e
        iQfFuSmYxpQw9Gk9L6s3b2s1N0uVtcwdc6OLP09z1z2Qhs43K5xMnfw2/nTzjpKkGc+RoVEeFIHTT
        2atJwpIQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2n5K-00GqP1-7k; Mon, 12 Jul 2021 03:58:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 098/137] iomap: Convert bio completions to use folios
Date:   Mon, 12 Jul 2021 04:06:22 +0100
Message-Id: <20210712030701.4000097-99-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use bio_for_each_folio() to iterate over each folio in the bio
instead of iterating over each page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 46 +++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3a0572ee10dc..05f7321fbd66 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -161,36 +161,29 @@ static void iomap_set_range_uptodate(struct folio *folio,
 		folio_mark_uptodate(folio);
 }
 
-static void
-iomap_read_page_end_io(struct bio_vec *bvec, int error)
+static void iomap_finish_folio_read(struct folio *folio, size_t offset,
+		size_t len, int error)
 {
-	struct page *page = bvec->bv_page;
-	struct folio *folio = page_folio(page);
 	struct iomap_page *iop = to_iomap_page(folio);
 
 	if (unlikely(error)) {
 		folio_clear_uptodate_flag(folio);
 		folio_set_error_flag(folio);
 	} else {
-		size_t off = (page - &folio->page) * PAGE_SIZE +
-				bvec->bv_offset;
-
-		iomap_set_range_uptodate(folio, iop, off, bvec->bv_len);
+		iomap_set_range_uptodate(folio, iop, offset, len);
 	}
 
-	if (!iop || atomic_sub_and_test(bvec->bv_len, &iop->read_bytes_pending))
+	if (!iop || atomic_sub_and_test(len, &iop->read_bytes_pending))
 		folio_unlock(folio);
 }
 
-static void
-iomap_read_end_io(struct bio *bio)
+static void iomap_read_end_io(struct bio *bio)
 {
 	int error = blk_status_to_errno(bio->bi_status);
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
+	struct folio_iter fi;
 
-	bio_for_each_segment_all(bvec, bio, iter_all)
-		iomap_read_page_end_io(bvec, error);
+	bio_for_each_folio_all(fi, bio)
+		iomap_finish_folio_read(fi.folio, fi.offset, fi.length, error);
 	bio_put(bio);
 }
 
@@ -1014,23 +1007,21 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
 }
 EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
 
-static void
-iomap_finish_page_writeback(struct inode *inode, struct page *page,
-		int error, unsigned int len)
+static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
+		size_t len, int error)
 {
-	struct folio *folio = page_folio(page);
 	struct iomap_page *iop = to_iomap_page(folio);
 
 	if (error) {
-		SetPageError(page);
+		folio_set_error_flag(folio);
 		mapping_set_error(inode->i_mapping, -EIO);
 	}
 
-	WARN_ON_ONCE(i_blocks_per_page(inode, page) > 1 && !iop);
+	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !iop);
 	WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) <= 0);
 
 	if (!iop || atomic_sub_and_test(len, &iop->write_bytes_pending))
-		end_page_writeback(page);
+		folio_end_writeback(folio);
 }
 
 /*
@@ -1049,8 +1040,7 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 	bool quiet = bio_flagged(bio, BIO_QUIET);
 
 	for (bio = &ioend->io_inline_bio; bio; bio = next) {
-		struct bio_vec *bv;
-		struct bvec_iter_all iter_all;
+		struct folio_iter fi;
 
 		/*
 		 * For the last bio, bi_private points to the ioend, so we
@@ -1061,10 +1051,10 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 		else
 			next = bio->bi_private;
 
-		/* walk each page on bio, ending page IO on them */
-		bio_for_each_segment_all(bv, bio, iter_all)
-			iomap_finish_page_writeback(inode, bv->bv_page, error,
-					bv->bv_len);
+		/* walk all folios in bio, ending page IO on them */
+		bio_for_each_folio_all(fi, bio)
+			iomap_finish_folio_write(inode, fi.folio, fi.length,
+					error);
 		bio_put(bio);
 	}
 	/* The ioend has been freed by bio_put() */
-- 
2.30.2

