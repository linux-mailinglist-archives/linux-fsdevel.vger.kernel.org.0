Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F383CF95E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 14:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbhGTL35 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 07:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbhGTL3w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 07:29:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D14C061574;
        Tue, 20 Jul 2021 05:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MtxatdXbhNZvTh7UGhO9/QwluOhY6v8V2LIWzk1Y+Vg=; b=CvKkE8nyFHjSpWQPciJOOY6iMk
        DxtbvyucgyuiFkGjPZI9DPia5nopxQafxWFVvGoL1jK2zsiYi81+vBccg6qwPnZCnby1XeJA08zz4
        tJeuUujHGRHemm6eJJeb8xiftiWgcfWgGTe8sLscaTJvVKeVL1aw4cFElzsXihCDxmpAKqtxR/lY2
        ueC3RpFALe2xylbjdUxdzZUwMxRjVeiXkjkU9rJc3PmF0aZSst7maIclyieX9NE9ls3o+BohAHJcR
        n1hMU0h2WmiUseP/2Ujs9We0gSGQ9i/TBe3Rg97chNXPl0ZnsDDJ/wLvH/1r7OYWVeRj4azqHo/2L
        V9Rh226g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5oZY-00856L-80; Tue, 20 Jul 2021 12:10:10 +0000
Date:   Tue, 20 Jul 2021 13:10:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] iomap: simplify iomap_add_to_ioend
Message-ID: <YPa9HFTyJV4qIqJ+@casper.infradead.org>
References: <20210720084320.184877-1-hch@lst.de>
 <20210720084320.184877-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720084320.184877-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 10:43:20AM +0200, Christoph Hellwig wrote:
> Now that the outstanding writes are counted in bytes, there is no need
> to use the low-level __bio_try_merge_page API, we can switch back to
> always using bio_add_page and simply iomap_add_to_ioend again.

These two callers were the only external users of __bio_try_merge_page(),
so it can now be made static to block/bio.c.

From f3599f22b9e107c7a6cb0ace813ca505843316ce Mon Sep 17 00:00:00 2001
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Tue, 20 Jul 2021 08:04:29 -0400
Subject: [PATCH] block: Make __bio_try_merge_page static

iomap was the only external user of __bio_try_merge_page().  Make it
static (and move it above a caller so it doesn't need to be declared
in advance).

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 block/bio.c         | 77 ++++++++++++++++++++++-----------------------
 include/linux/bio.h |  2 --
 2 files changed, 38 insertions(+), 41 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 1fab762e079b..d36a4d3d3cd5 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -709,6 +709,44 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 	return (bv->bv_page + bv_end / PAGE_SIZE) == (page + off / PAGE_SIZE);
 }
 
+/**
+ * __bio_try_merge_page - try appending data to an existing bvec.
+ * @bio: destination bio
+ * @page: start page to add
+ * @len: length of the data to add
+ * @off: offset of the data relative to @page
+ * @same_page: return if the segment has been merged inside the same page
+ *
+ * Try to add the data at @page + @off to the last bvec of @bio.  This is a
+ * useful optimisation for file systems with a block size smaller than the
+ * page size.
+ *
+ * Warn if (@len, @off) crosses pages in case that @same_page is true.
+ *
+ * Return %true on success or %false on failure.
+ */
+static bool __bio_try_merge_page(struct bio *bio, struct page *page,
+		unsigned int len, unsigned int off, bool *same_page)
+{
+	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
+		return false;
+
+	if (bio->bi_vcnt > 0) {
+		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
+
+		if (page_is_mergeable(bv, page, len, off, same_page)) {
+			if (bio->bi_iter.bi_size > UINT_MAX - len) {
+				*same_page = false;
+				return false;
+			}
+			bv->bv_len += len;
+			bio->bi_iter.bi_size += len;
+			return true;
+		}
+	}
+	return false;
+}
+
 /*
  * Try to merge a page into a segment, while obeying the hardware segment
  * size limit.  This is not for normal read/write bios, but for passthrough
@@ -840,45 +878,6 @@ int bio_add_zone_append_page(struct bio *bio, struct page *page,
 }
 EXPORT_SYMBOL_GPL(bio_add_zone_append_page);
 
-/**
- * __bio_try_merge_page - try appending data to an existing bvec.
- * @bio: destination bio
- * @page: start page to add
- * @len: length of the data to add
- * @off: offset of the data relative to @page
- * @same_page: return if the segment has been merged inside the same page
- *
- * Try to add the data at @page + @off to the last bvec of @bio.  This is a
- * useful optimisation for file systems with a block size smaller than the
- * page size.
- *
- * Warn if (@len, @off) crosses pages in case that @same_page is true.
- *
- * Return %true on success or %false on failure.
- */
-bool __bio_try_merge_page(struct bio *bio, struct page *page,
-		unsigned int len, unsigned int off, bool *same_page)
-{
-	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
-		return false;
-
-	if (bio->bi_vcnt > 0) {
-		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
-
-		if (page_is_mergeable(bv, page, len, off, same_page)) {
-			if (bio->bi_iter.bi_size > UINT_MAX - len) {
-				*same_page = false;
-				return false;
-			}
-			bv->bv_len += len;
-			bio->bi_iter.bi_size += len;
-			return true;
-		}
-	}
-	return false;
-}
-EXPORT_SYMBOL_GPL(__bio_try_merge_page);
-
 /**
  * __bio_add_page - add page(s) to a bio in a new segment
  * @bio: destination bio
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 2203b686e1f0..c779e0e3140a 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -467,8 +467,6 @@ extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
 			   unsigned int, unsigned int);
 int bio_add_zone_append_page(struct bio *bio, struct page *page,
 			     unsigned int len, unsigned int offset);
-bool __bio_try_merge_page(struct bio *bio, struct page *page,
-		unsigned int len, unsigned int off, bool *same_page);
 void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off);
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
-- 
2.30.2

