Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFD84421DC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 21:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhKAUsm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 16:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbhKAUsl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 16:48:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BAFC061714;
        Mon,  1 Nov 2021 13:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=X4II0mlaRa34mCvrogFYkYmOPfzxbRzufI4NZsZo/dA=; b=lC4emPiQ9r+K405RjgD9eQLkkE
        23GBnWz7znfEJVCbDndP4IJFGhbgZS1yVtnZ8xh1bdSBjPfYkg838TWzSWZSYOfZ/gJ+B2jpuqmgF
        HqvvFheQ4kip91LEc7F9xcJCnY5v73m16+uPSo3Rbp3Z+2HOgUvF137b86215NcFaFUdSvzV57D4l
        f5TYWxSkAy6WGo0jTNlqfW0ya1/ukEw0LOT8ZwmgVT+q9v1Og+lXwxq3x9eSj+4NqCMZzQrh7gdFv
        eE7vfetd9iUJYxSo8o6fliHFgGAgyt2ZQNgjOFoOnQgmzJLHVzpoNLqWQQMl51mrSMB1bGhON49cS
        mC2luhWw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhe8m-0040TD-L6; Mon, 01 Nov 2021 20:43:16 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 02/21] block: Add bio_add_folio()
Date:   Mon,  1 Nov 2021 20:39:10 +0000
Message-Id: <20211101203929.954622-3-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211101203929.954622-1-willy@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a thin wrapper around bio_add_page().  The main advantage here
is the documentation that stupidly large folios are not supported.
It's not currently possible to allocate stupidly large folios, but if
it ever becomes possible, this function will fail gracefully instead of
doing I/O to the wrong bytes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 block/bio.c         | 22 ++++++++++++++++++++++
 include/linux/bio.h |  3 ++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 15ab0d6d1c06..0e911c4fb9f2 100644
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
+		size_t off)
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

