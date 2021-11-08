Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9154E447951
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 05:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237419AbhKHE0k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Nov 2021 23:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbhKHE0k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Nov 2021 23:26:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AAEC061570;
        Sun,  7 Nov 2021 20:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2JSXpb5tUGpO4uv4zOD//k8Fp1xchYDz8xInP/Cvu8c=; b=Dzn/hpcE+ClIXi70b6ktdmN7z/
        5z9Ubls1YKvXezJs/tUgd6w9EkAqTLPWPR29F6fC8dQpYMSlRZAdNYo7tNwyvHGPGNd9X7Mu1rpam
        LgL3lyKagLr5ndrI0cqJbGMF0znWeNaTKO82U88Pf7vid2X+EAKXCXJNwICGs2J8kyFYKuzlAHi65
        6XcQNUalhMn4Mk5VaOYUHZk5MWHlBUQ4DInmtNjOUpmtvgy1dux/EEswp+qzshKpuBrYijwg93GF2
        QyosuHuVELZGJkLsKG0ATh8z7urb3DkHrxGpqdZmd3tgQXJVmLKD061HZpKNy5UT/sEOQzfP/Npmy
        myrh9WCA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjw6N-0089i2-V3; Mon, 08 Nov 2021 04:18:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J . Wong " <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 05/28] block: Add bio_add_folio()
Date:   Mon,  8 Nov 2021 04:05:28 +0000
Message-Id: <20211108040551.1942823-6-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108040551.1942823-1-willy@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
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

