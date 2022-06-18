Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF075502FD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 07:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbiFRFgR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 01:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbiFRFgD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 01:36:03 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADCD689A1
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 22:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=DwWZinKLfaZ/aYLwFrkoLpkb/vb2WYVCTyLHLJEZCLc=; b=KYmPz8HgWA2/23LC8f8KW1xwt1
        iYsIYl0fYTs4+OW8K0NCETD0cyineq82tBYgpSO8FqCr+XnvSPR1OJQMixxWMBnUYEupBZ/wJ7pfV
        vY90lVXv7I4qR638dBK3ZLzJGRXPCBMWkF3j67aosF7LaINTshUUnN4+9nwGqoveWrWMyXMEnSMK4
        CBE74Ylzq2nQQb03aaAmio051Oktdf+tTbBbLqKXL/ddmGhwj7wf8StqJosidA4lALX7FUCZd640B
        DQ4Ph7Sl+SxIDP6fMLy5gIRqi+cEPTCZBRo57w6EM3vMY2vLxdr+4e+BaZIW1kB5w8wKLishwCR6p
        S/17f79g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2R7X-001VS5-OJ;
        Sat, 18 Jun 2022 05:35:43 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 29/31] get rid of non-advancing variants
Date:   Sat, 18 Jun 2022 06:35:36 +0100
Message-Id: <20220618053538.359065-30-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220618053538.359065-1-viro@zeniv.linux.org.uk>
References: <Yq1iNHboD+9fz60M@ZenIV>
 <20220618053538.359065-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

mechanical change; will be further massaged in subsequent commits

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/uio.h | 24 ++----------------------
 lib/iov_iter.c      | 27 ++++++++++++++++++---------
 2 files changed, 20 insertions(+), 31 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index ab1cc218b9de..f2fc55f88e45 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -245,9 +245,9 @@ void iov_iter_pipe(struct iov_iter *i, unsigned int direction, struct pipe_inode
 void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count);
 void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
 		     loff_t start, size_t count);
-ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
+ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
-ssize_t iov_iter_get_pages_alloc(struct iov_iter *i, struct page ***pages,
+ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
 			size_t maxsize, size_t *start);
 int iov_iter_npages(const struct iov_iter *i, int maxpages);
 void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state);
@@ -349,24 +349,4 @@ static inline void iov_iter_ubuf(struct iov_iter *i, unsigned int direction,
 	};
 }
 
-static inline ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
-			size_t maxsize, unsigned maxpages, size_t *start)
-{
-	ssize_t res = iov_iter_get_pages(i, pages, maxsize, maxpages, start);
-
-	if (res >= 0)
-		iov_iter_advance(i, res);
-	return res;
-}
-
-static inline ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
-			size_t maxsize, size_t *start)
-{
-	ssize_t res = iov_iter_get_pages_alloc(i, pages, maxsize, start);
-
-	if (res >= 0)
-		iov_iter_advance(i, res);
-	return res;
-}
-
 #endif
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index a137bfaaaa77..c1e5de842fe3 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1229,6 +1229,7 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 		left -= PAGE_SIZE - off;
 		if (left <= 0) {
 			buf->len += maxsize;
+			iov_iter_advance(i, maxsize);
 			return maxsize;
 		}
 		buf->len = PAGE_SIZE;
@@ -1248,7 +1249,9 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 	}
 	if (!npages)
 		return -EFAULT;
-	return maxsize - left;
+	maxsize -= left;
+	iov_iter_advance(i, maxsize);
+	return maxsize;
 }
 
 static ssize_t iter_xarray_populate_pages(struct page **pages, struct xarray *xa,
@@ -1298,7 +1301,9 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
 	if (nr == 0)
 		return 0;
 
-	return min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
+	maxsize = min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
+	iov_iter_advance(i, maxsize);
+	return maxsize;
 }
 
 /* must be done on non-empty ITER_UBUF or ITER_IOVEC one */
@@ -1370,7 +1375,9 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		res = get_user_pages_fast(addr, n, gup_flags, *pages);
 		if (unlikely(res <= 0))
 			return res;
-		return min_t(size_t, len, res * PAGE_SIZE - *start);
+		len = min_t(size_t, len, res * PAGE_SIZE - *start);
+		iov_iter_advance(i, len);
+		return len;
 	}
 	if (iov_iter_is_bvec(i)) {
 		struct page **p;
@@ -1382,8 +1389,10 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 			return n;
 		p = *pages;
 		for (int k = 0; k < n; k++)
-			get_page(*p++ = page++);
-		return min_t(size_t, maxsize, n * PAGE_SIZE - *start);
+			get_page(p[k] = page + k);
+		len = min_t(size_t, len, n * PAGE_SIZE - *start);
+		iov_iter_advance(i, len);
+		return len;
 	}
 	if (iov_iter_is_pipe(i))
 		return pipe_get_pages(i, pages, maxsize, maxpages, start);
@@ -1393,7 +1402,7 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 	return -EFAULT;
 }
 
-ssize_t iov_iter_get_pages(struct iov_iter *i,
+ssize_t iov_iter_get_pages2(struct iov_iter *i,
 		   struct page **pages, size_t maxsize, unsigned maxpages,
 		   size_t *start)
 {
@@ -1403,9 +1412,9 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 
 	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages, start);
 }
-EXPORT_SYMBOL(iov_iter_get_pages);
+EXPORT_SYMBOL(iov_iter_get_pages2);
 
-ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
+ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
 		   size_t *start)
 {
@@ -1420,7 +1429,7 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 	}
 	return len;
 }
-EXPORT_SYMBOL(iov_iter_get_pages_alloc);
+EXPORT_SYMBOL(iov_iter_get_pages_alloc2);
 
 size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 			       struct iov_iter *i)
-- 
2.30.2

