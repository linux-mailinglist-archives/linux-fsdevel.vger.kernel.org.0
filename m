Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA2728DD1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 11:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgJNJW1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 05:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731143AbgJNJVw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:21:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B6FC0F26EA;
        Tue, 13 Oct 2020 20:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=zaip0vMsJG7AN9Csr/40q0m3O27lGYg2jcMuOG9Osec=; b=JtDbuy8/xiVmCy2QAhqgDwxUr0
        sT6664qzppcyCFLAJGVc8Y89wkgGRTAZZJ2mEPQXExHsHocwSSx6IfyfF2FhdvBGgXd1qJwS3z11D
        iEKYLKzhw5utaoblG7UL0HyJCVJMvr8raUUZNCeH8XC5l3hN6milMSz0eiWA+aWQCAriDAyFvegJs
        ew8oZA8iWrcX3TveFeERKgYVZ+l6HJe0xkNrrKeFXzKqO7KncNwHIHbNjJHIvQ1CAcOFEzgQTkqq1
        SGgkgyWqmfL2uHtkPa9rYRaLyUDUdsw9B9HlydFXqNTzTlvG8YuMUgnhYYbOi3Xm3WwuhB80ePWa8
        3GPIRuFw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSX55-0005iI-Th; Wed, 14 Oct 2020 03:03:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 03/14] iomap: Support THPs in BIO completion path
Date:   Wed, 14 Oct 2020 04:03:46 +0100
Message-Id: <20201014030357.21898-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201014030357.21898-1-willy@infradead.org>
References: <20201014030357.21898-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

bio_for_each_segment_all() iterates once per regular sized page.
Use bio_for_each_bvec_all() to iterate once per bvec and handle
merged THPs ourselves, instead of teaching the block layer about THPs.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 62 ++++++++++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 18 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3e1eb40a73fd..935468d79d9d 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -167,32 +167,45 @@ iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len)
 		SetPageUptodate(page);
 }
 
-static void
-iomap_read_page_end_io(struct bio_vec *bvec, int error)
+static void iomap_finish_page_read(struct page *page, size_t offset,
+		size_t length, int error)
 {
-	struct page *page = bvec->bv_page;
 	struct iomap_page *iop = to_iomap_page(page);
 
 	if (unlikely(error)) {
 		ClearPageUptodate(page);
 		SetPageError(page);
 	} else {
-		iomap_set_range_uptodate(page, bvec->bv_offset, bvec->bv_len);
+		iomap_set_range_uptodate(page, offset, length);
 	}
 
-	if (!iop || atomic_sub_and_test(bvec->bv_len, &iop->read_bytes_pending))
+	if (!iop || atomic_sub_and_test(length, &iop->read_bytes_pending))
 		unlock_page(page);
 }
 
-static void
-iomap_read_end_io(struct bio *bio)
+static void iomap_finish_bvec_read(struct page *page, size_t offset,
+		size_t length, int error)
+{
+	while (length > 0) {
+		size_t count = min(thp_size(page) - offset, length);
+
+		iomap_finish_page_read(page, offset, count, error);
+
+		page += (offset + count) / PAGE_SIZE;
+		offset = 0;
+		length -= count;
+	}
+}
+
+static void iomap_read_end_io(struct bio *bio)
 {
-	int error = blk_status_to_errno(bio->bi_status);
+	int i, error = blk_status_to_errno(bio->bi_status);
 	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
 
-	bio_for_each_segment_all(bvec, bio, iter_all)
-		iomap_read_page_end_io(bvec, error);
+	bio_for_each_bvec_all(bvec, bio, i)
+		iomap_finish_bvec_read(bvec->bv_page, bvec->bv_offset,
+				bvec->bv_len, error);
+
 	bio_put(bio);
 }
 
@@ -1035,9 +1048,8 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
 }
 EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
 
-static void
-iomap_finish_page_writeback(struct inode *inode, struct page *page,
-		int error, unsigned int len)
+static void iomap_finish_page_write(struct inode *inode, struct page *page,
+		unsigned int len, int error)
 {
 	struct iomap_page *iop = to_iomap_page(page);
 
@@ -1053,6 +1065,20 @@ iomap_finish_page_writeback(struct inode *inode, struct page *page,
 		end_page_writeback(page);
 }
 
+static void iomap_finish_bvec_write(struct inode *inode, struct page *page,
+		size_t offset, size_t length, int error)
+{
+	while (length > 0) {
+		size_t count = min(thp_size(page) - offset, length);
+
+		iomap_finish_page_write(inode, page, count, error);
+
+		page += (offset + count) / PAGE_SIZE;
+		offset = 0;
+		length -= count;
+	}
+}
+
 /*
  * We're now finished for good with this ioend structure.  Update the page
  * state, release holds on bios, and finally free up memory.  Do not use the
@@ -1070,7 +1096,7 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 
 	for (bio = &ioend->io_inline_bio; bio; bio = next) {
 		struct bio_vec *bv;
-		struct bvec_iter_all iter_all;
+		int i;
 
 		/*
 		 * For the last bio, bi_private points to the ioend, so we
@@ -1082,9 +1108,9 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 			next = bio->bi_private;
 
 		/* walk each page on bio, ending page IO on them */
-		bio_for_each_segment_all(bv, bio, iter_all)
-			iomap_finish_page_writeback(inode, bv->bv_page, error,
-					bv->bv_len);
+		bio_for_each_bvec_all(bv, bio, i)
+			iomap_finish_bvec_write(inode, bv->bv_page,
+					bv->bv_offset, bv->bv_len, error);
 		bio_put(bio);
 	}
 	/* The ioend has been freed by bio_put() */
-- 
2.28.0

