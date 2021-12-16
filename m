Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B20A477E2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 22:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241620AbhLPVH3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 16:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241561AbhLPVHW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:07:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B367BC06173F;
        Thu, 16 Dec 2021 13:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ZVgGzvz1GSe5crusiBtnWHvRHdypC4/wy9LeIXeqoUo=; b=XotkDzGNp7MYzrDO59aaaiiExJ
        RlA8Stqb+eFRtpgrpyhiulNnASkD1+Qk+8lMlK3yx9R+ex3oZ2soJobGnLkKo+1TCynANPIS9nngB
        uo7mn3Enn4kyS4mm3HRryHsocFYz9zXehmz9qigPeoQ/PhKnGPazraoUgP+/QjwJxTktdT/Rf7BPL
        qyYnfkYeD6REe93evKnbrCJPrnLssqQOIzy/phRmX3ipp0ELuTPxc3B+wEbbXbGmrYy78f7D4t6ss
        1c2DrflLaFIIGAQBApeag/grHxwO861KxRKTbs47EIijKneP2/3ON8Srz39RhxjCciUpjt5HrGTIe
        GiNbeogA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxxyB-00Fx3s-W2; Thu, 16 Dec 2021 21:07:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 10/25] iomap: Convert bio completions to use folios
Date:   Thu, 16 Dec 2021 21:07:00 +0000
Message-Id: <20211216210715.3801857-11-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216210715.3801857-1-willy@infradead.org>
References: <20211216210715.3801857-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use bio_for_each_folio() to iterate over each folio in the bio
instead of iterating over each page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 50 ++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 856ef62b319e..5730a3317407 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -161,34 +161,29 @@ static void iomap_set_range_uptodate(struct page *page,
 		SetPageUptodate(page);
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
-		ClearPageUptodate(page);
-		SetPageError(page);
+		folio_clear_uptodate(folio);
+		folio_set_error(folio);
 	} else {
-		iomap_set_range_uptodate(page, iop, bvec->bv_offset,
-						bvec->bv_len);
+		iomap_set_range_uptodate(&folio->page, iop, offset, len);
 	}
 
-	if (!iop || atomic_sub_and_test(bvec->bv_len, &iop->read_bytes_pending))
-		unlock_page(page);
+	if (!iop || atomic_sub_and_test(len, &iop->read_bytes_pending))
+		folio_unlock(folio);
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
 
@@ -1019,23 +1014,21 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
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
+		folio_set_error(folio);
 		mapping_set_error(inode->i_mapping, error);
 	}
 
-	WARN_ON_ONCE(i_blocks_per_page(inode, page) > 1 && !iop);
+	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !iop);
 	WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) <= 0);
 
 	if (!iop || atomic_sub_and_test(len, &iop->write_bytes_pending))
-		end_page_writeback(page);
+		folio_end_writeback(folio);
 }
 
 /*
@@ -1054,8 +1047,7 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 	bool quiet = bio_flagged(bio, BIO_QUIET);
 
 	for (bio = &ioend->io_inline_bio; bio; bio = next) {
-		struct bio_vec *bv;
-		struct bvec_iter_all iter_all;
+		struct folio_iter fi;
 
 		/*
 		 * For the last bio, bi_private points to the ioend, so we
@@ -1066,10 +1058,10 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
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
2.33.0

