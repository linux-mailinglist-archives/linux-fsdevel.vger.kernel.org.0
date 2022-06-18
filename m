Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25019550430
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 13:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiFRLP0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 07:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbiFRLOh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 07:14:37 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F4915837
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jun 2022 04:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2LNCDgceGa+jwJgzIqAe4YUdlUKGkCK9nw/15+tF2Mo=; b=WGwPqRaJW1zNMFUwJXi00pheOI
        DmknWD7C9zEl45p/pqDM/lhoYRaCyYSiEAkoVdZkv5C8btrtHgtViAuy3D528Z3JDFNl/1yhG1exA
        GjwmrHXN0AeEkLwvx1uMfxvdViWDla1qQ9oiPbjkwzXECdLtSmR50TXUVqV+igDwFfwZcfkvOlrcD
        +5zd8FR2lN8NkNVbOd/cAaqTC7peAqggoUC7wNgKwaoyY/c8CcP7xTaEd1v6HUesIsqgfcJGjkjfQ
        d7cqK0p3qmT4GjF6FGNL2KHnPUESwzjVJuCbUB3NL6ZrIj2cUoWIgpPDLlghuKqxeQfoiQ/nZWiGx
        AXKJhkTQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2WPT-001akS-EK;
        Sat, 18 Jun 2022 11:14:35 +0000
Date:   Sat, 18 Jun 2022 12:14:35 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 29/31] get rid of non-advancing variants
Message-ID: <Yq2zm6GxVVgYpD9p@ZenIV>
References: <Yq1iNHboD+9fz60M@ZenIV>
 <20220618053538.359065-1-viro@zeniv.linux.org.uk>
 <20220618053538.359065-30-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618053538.359065-30-viro@zeniv.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[braino fixed]
From 808b5178c97c4e6789ff727988c571d77b42acf7 Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Fri, 10 Jun 2022 13:05:12 -0400
Subject: [PATCH 29/31] get rid of non-advancing variants

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
index 2ce062f1817d..d581a204c256 100644
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
@@ -1369,7 +1374,9 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		res = get_user_pages_fast(addr, n, gup_flags, *pages);
 		if (unlikely(res <= 0))
 			return res;
-		return min_t(size_t, maxsize, res * PAGE_SIZE - *start);
+		maxsize = min_t(size_t, maxsize, res * PAGE_SIZE - *start);
+		iov_iter_advance(i, maxsize);
+		return maxsize;
 	}
 	if (iov_iter_is_bvec(i)) {
 		struct page **p;
@@ -1381,8 +1388,10 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 			return n;
 		p = *pages;
 		for (int k = 0; k < n; k++)
-			get_page(*p++ = page++);
-		return min_t(size_t, maxsize, n * PAGE_SIZE - *start);
+			get_page(p[k] = page + k);
+		maxsize = min_t(size_t, maxsize, n * PAGE_SIZE - *start);
+		iov_iter_advance(i, maxsize);
+		return maxsize;
 	}
 	if (iov_iter_is_pipe(i))
 		return pipe_get_pages(i, pages, maxsize, maxpages, start);
@@ -1392,7 +1401,7 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 	return -EFAULT;
 }
 
-ssize_t iov_iter_get_pages(struct iov_iter *i,
+ssize_t iov_iter_get_pages2(struct iov_iter *i,
 		   struct page **pages, size_t maxsize, unsigned maxpages,
 		   size_t *start)
 {
@@ -1402,9 +1411,9 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 
 	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages, start);
 }
-EXPORT_SYMBOL(iov_iter_get_pages);
+EXPORT_SYMBOL(iov_iter_get_pages2);
 
-ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
+ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
 		   size_t *start)
 {
@@ -1419,7 +1428,7 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 	}
 	return len;
 }
-EXPORT_SYMBOL(iov_iter_get_pages_alloc);
+EXPORT_SYMBOL(iov_iter_get_pages_alloc2);
 
 size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 			       struct iov_iter *i)
-- 
2.30.2

