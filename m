Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED456554174
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357004AbiFVERO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356864AbiFVEQK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:16:10 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A840BC86
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=BeoB4cjTFciz31d7M7XFM7Xq9Q0tWo2tlx8HPa0iYL0=; b=eJSQcJkjXQqcnY8UPd1OT3g4Mc
        XJFbZ6NV10qiSLGyQ7LYViPBYpVwWRut5xT+BM2LzUf7JE64qxwg4HXqFpkN+e7u6kh3N9N3AvkjL
        DMIftoW3CerUK+24zHqTOSvEYQYSwDRiRWd2WQ3IYUl9YxDC4NQDxTqcJ6sCkHUtbaBAzaNpFlOz9
        0g/sC9DTy0PlJrqxRSnwSpNJ6uSIZgz4GPDbIPzqvRusj3DmTRuqjfYJXySGC+3ll1OVI8ePR91vn
        eO1sTPGM7K8K/66s6GfYb8dvBKd4DZWPPNcspNnFs6GKg3VEVV25P8njA7AHAqaf2cKA2/mOoG20C
        rRFPa7OA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rma-00360C-7n;
        Wed, 22 Jun 2022 04:16:00 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 42/44] get rid of non-advancing variants
Date:   Wed, 22 Jun 2022 05:15:50 +0100
Message-Id: <20220622041552.737754-42-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622041552.737754-1-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
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
index 1c744f0c0b2c..70736b3e07c5 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1231,6 +1231,7 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 		left -= PAGE_SIZE - off;
 		if (left <= 0) {
 			buf->len += maxsize;
+			iov_iter_advance(i, maxsize);
 			return maxsize;
 		}
 		buf->len = PAGE_SIZE;
@@ -1250,7 +1251,9 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 	}
 	if (!npages)
 		return -EFAULT;
-	return maxsize - left;
+	maxsize -= left;
+	iov_iter_advance(i, maxsize);
+	return maxsize;
 }
 
 static ssize_t iter_xarray_populate_pages(struct page **pages, struct xarray *xa,
@@ -1300,7 +1303,9 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
 	if (nr == 0)
 		return 0;
 
-	return min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
+	maxsize = min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
+	iov_iter_advance(i, maxsize);
+	return maxsize;
 }
 
 /* must be done on non-empty ITER_UBUF or ITER_IOVEC one */
@@ -1372,7 +1377,9 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
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
@@ -1384,8 +1391,10 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 			return -ENOMEM;
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
@@ -1395,7 +1404,7 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 	return -EFAULT;
 }
 
-ssize_t iov_iter_get_pages(struct iov_iter *i,
+ssize_t iov_iter_get_pages2(struct iov_iter *i,
 		   struct page **pages, size_t maxsize, unsigned maxpages,
 		   size_t *start)
 {
@@ -1405,9 +1414,9 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 
 	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages, start);
 }
-EXPORT_SYMBOL(iov_iter_get_pages);
+EXPORT_SYMBOL(iov_iter_get_pages2);
 
-ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
+ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
 		   size_t *start)
 {
@@ -1422,7 +1431,7 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 	}
 	return len;
 }
-EXPORT_SYMBOL(iov_iter_get_pages_alloc);
+EXPORT_SYMBOL(iov_iter_get_pages_alloc2);
 
 size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 			       struct iov_iter *i)
-- 
2.30.2

