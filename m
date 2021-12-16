Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51740477E1E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 22:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241565AbhLPVHW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 16:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241532AbhLPVHV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:07:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16C1C06173F;
        Thu, 16 Dec 2021 13:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=i1uGRLSmQDRzx2wkY5dVs/7U4AY55WJaVteBHDy5RtE=; b=gwxjH/rb5enuTNjKvPygJBHPep
        2C5Jg33thj/JnCT6E3/u0VuI9B5FXhDQJvdmjdfohcy+3Admd9s4h9JVmTaxaq7zP3j5jnaJew4Ko
        oaYzg47cGMhmEQNO4a4AfbAIY5E+sFEcZ1u/myYCozQ7kO+fK0JmnxPjNyqGTOVqAfjybB9WJn67J
        vPQd5i35DNlwEdAVQEJnTIFxxcKUB8BcJ8/2z4EUDInJjKs7HdOF4J2j5tZOlT1kl6GQ/CPpLuy81
        6SQWYLOlTVa9urbqFvcQd7K8D7IVq5lIIXq4SPeGzh+1e5/zW9sAAGFBp2mCxAZqvW/yL5PUaWZlE
        4Ep08g4g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxxyA-00Fx36-VX; Thu, 16 Dec 2021 21:07:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 01/25] block: Add bio_add_folio()
Date:   Thu, 16 Dec 2021 21:06:51 +0000
Message-Id: <20211216210715.3801857-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216210715.3801857-1-willy@infradead.org>
References: <20211216210715.3801857-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a thin wrapper around bio_add_page().  The main advantage here
is the documentation that folios larger than 2GiB are not supported.
It's not currently possible to allocate folios that large, but if it
ever becomes possible, this function will fail gracefully instead of
doing I/O to the wrong bytes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 block/bio.c         | 22 ++++++++++++++++++++++
 include/linux/bio.h |  3 ++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 15ab0d6d1c06..4b3087e20d51 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1033,6 +1033,28 @@ int bio_add_page(struct bio *bio, struct page *page,
 }
 EXPORT_SYMBOL(bio_add_page);
 
+/**
+ * bio_add_folio - Attempt to add part of a folio to a bio.
+ * @bio: BIO to add to.
+ * @folio: Folio to add.
+ * @len: How many bytes from the folio to add.
+ * @off: First byte in this folio to add.
+ *
+ * Filesystems that use folios can call this function instead of calling
+ * bio_add_page() for each page in the folio.  If @off is bigger than
+ * PAGE_SIZE, this function can create a bio_vec that starts in a page
+ * after the bv_page.  BIOs do not support folios that are 4GiB or larger.
+ *
+ * Return: Whether the addition was successful.
+ */
+bool bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
+		   size_t off)
+{
+	if (len > UINT_MAX || off > UINT_MAX)
+		return 0;
+	return bio_add_page(bio, &folio->page, len, off) > 0;
+}
+
 void __bio_release_pages(struct bio *bio, bool mark_dirty)
 {
 	struct bvec_iter_all iter_all;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index fe6bdfbbef66..a783cac49978 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -409,7 +409,8 @@ extern void bio_uninit(struct bio *);
 extern void bio_reset(struct bio *);
 void bio_chain(struct bio *, struct bio *);
 
-extern int bio_add_page(struct bio *, struct page *, unsigned int,unsigned int);
+int bio_add_page(struct bio *, struct page *, unsigned len, unsigned off);
+bool bio_add_folio(struct bio *, struct folio *, size_t len, size_t off);
 extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
 			   unsigned int, unsigned int);
 int bio_add_zone_append_page(struct bio *bio, struct page *page,
-- 
2.33.0

