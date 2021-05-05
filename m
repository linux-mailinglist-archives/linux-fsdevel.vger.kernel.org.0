Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3220D374776
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 20:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbhEER5X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 13:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbhEER5G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 13:57:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CA5C026CFA;
        Wed,  5 May 2021 10:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=D3JLwlfjudky2TibCuSNjrwbS1szpj7UX+LJHAHL9eg=; b=ptPEvu6a/VQZxlgOXBUzbeWrmJ
        eWvl67Mf8Q+jAR1BJPSdlfVQe5P+dm6Bogr1uP24gUbEa1b42Wv9A1+a2MFArcf4pVpSJzpoSULBr
        ypZFue9Ph/NI3j8B99MM/qgfYzNJyVGMUSeF/odjTHi8WAR6+slnjZV6JECMVDLu4ezsGTORVhYiC
        D1yavSujVXknA2K2e35+RjRE2DGT9Tz8E2dqG4mo0GwHeIpE6kS5gMnBc6OiukOJHeWqgULqBDCH2
        v8t9v9lgbJY3z/a9eqeTHGU7to9RKg4leSAYI3nb7Xgt6Zirb+qwiEKYjbepEiqh4y8i7erXQhZvf
        skvfsetw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leLFO-000dwN-Fp; Wed, 05 May 2021 17:24:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 89/96] iomap: Convert bio completions to use folios
Date:   Wed,  5 May 2021 16:06:21 +0100
Message-Id: <20210505150628.111735-90-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
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
index b61fc7da3d65..354d91bc92c5 100644
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
 
@@ -1044,23 +1037,21 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
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
@@ -1079,8 +1070,7 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 	bool quiet = bio_flagged(bio, BIO_QUIET);
 
 	for (bio = &ioend->io_inline_bio; bio; bio = next) {
-		struct bio_vec *bv;
-		struct bvec_iter_all iter_all;
+		struct folio_iter fi;
 
 		/*
 		 * For the last bio, bi_private points to the ioend, so we
@@ -1091,10 +1081,10 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
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

