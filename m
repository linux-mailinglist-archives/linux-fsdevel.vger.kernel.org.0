Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF35A554186
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356920AbiFVEQk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356821AbiFVEQI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:16:08 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BAEA469
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=maVM+hWdRPpz8NIDpl66Gu92HL5HhGcpaGz+BHhMEqk=; b=KgvM9wL55NwD7arjz2377WijqV
        xH7/zzLOx+tW2S7imH4kmHOYt4c3aofvwcqbAD3RC1ywUaKdOK/DH6CPykpQ8GoVfCbmW5XXsHByX
        4r9MWk8RpWQpYcjcROCydDcbXzrUPdMx8xWfGaWT7Fnpv9O4n1EvDbma820mLkpWy/ZqrONUK5xRx
        ccrzkjvjzsrR0HxrkDW1UWCQ3cYXGEr9GMirGutXSjnTy7A1HgwHvipr0ZqzLcK6Ums/zoXXDOLpn
        2HxE7n6ZyUcKUox/mUfb+qSzonbQhXAhQfRKQqNHDr1RTC6I5TSy5pLuH3ZfvYfniCHmTg3Rjo+jX
        Xpc+CgKA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rmY-0035yp-6V;
        Wed, 22 Jun 2022 04:15:58 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 32/44] iov_iter: massage calling conventions for first_{iovec,bvec}_segment()
Date:   Wed, 22 Jun 2022 05:15:40 +0100
Message-Id: <20220622041552.737754-32-viro@zeniv.linux.org.uk>
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

Pass maxsize by reference, return length via the same.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 0bed684d91d0..fca66ecce7a0 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1306,26 +1306,22 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
 	return min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
 }
 
-static unsigned long found_ubuf_segment(unsigned long addr,
-					size_t len,
-					size_t *size, size_t *start)
+static unsigned long found_ubuf_segment(unsigned long addr, size_t *start)
 {
 	*start = addr % PAGE_SIZE;
-	*size = len;
 	return addr & PAGE_MASK;
 }
 
 /* must be done on non-empty ITER_UBUF or ITER_IOVEC one */
 static unsigned long first_iovec_segment(const struct iov_iter *i,
-					 size_t *size, size_t *start,
-					 size_t maxsize)
+					 size_t *size, size_t *start)
 {
 	size_t skip;
 	long k;
 
 	if (iter_is_ubuf(i)) {
 		unsigned long addr = (unsigned long)i->ubuf + i->iov_offset;
-		return found_ubuf_segment(addr, maxsize, size, start);
+		return found_ubuf_segment(addr, start);
 	}
 
 	for (k = 0, skip = i->iov_offset; k < i->nr_segs; k++, skip = 0) {
@@ -1334,28 +1330,26 @@ static unsigned long first_iovec_segment(const struct iov_iter *i,
 
 		if (unlikely(!len))
 			continue;
-		if (len > maxsize)
-			len = maxsize;
-		return found_ubuf_segment(addr, len, size, start);
+		if (*size > len)
+			*size = len;
+		return found_ubuf_segment(addr, start);
 	}
 	BUG(); // if it had been empty, we wouldn't get called
 }
 
 /* must be done on non-empty ITER_BVEC one */
 static struct page *first_bvec_segment(const struct iov_iter *i,
-				       size_t *size, size_t *start,
-				       size_t maxsize)
+				       size_t *size, size_t *start)
 {
 	struct page *page;
 	size_t skip = i->iov_offset, len;
 
 	len = i->bvec->bv_len - skip;
-	if (len > maxsize)
-		len = maxsize;
+	if (*size > len)
+		*size = len;
 	skip += i->bvec->bv_offset;
 	page = i->bvec->bv_page + skip / PAGE_SIZE;
 	*start = skip % PAGE_SIZE;
-	*size = len;
 	return page;
 }
 
@@ -1363,7 +1357,6 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
 		   unsigned int maxpages, size_t *start)
 {
-	size_t len;
 	int n, res;
 
 	if (maxsize > i->count)
@@ -1382,8 +1375,8 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		if (i->nofault)
 			gup_flags |= FOLL_NOFAULT;
 
-		addr = first_iovec_segment(i, &len, start, maxsize);
-		n = DIV_ROUND_UP(len + *start, PAGE_SIZE);
+		addr = first_iovec_segment(i, &maxsize, start);
+		n = DIV_ROUND_UP(maxsize + *start, PAGE_SIZE);
 		if (n > maxpages)
 			n = maxpages;
 		if (!*pages) {
@@ -1394,14 +1387,14 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		res = get_user_pages_fast(addr, n, gup_flags, *pages);
 		if (unlikely(res <= 0))
 			return res;
-		return min_t(size_t, len, res * PAGE_SIZE - *start);
+		return min_t(size_t, maxsize, res * PAGE_SIZE - *start);
 	}
 	if (iov_iter_is_bvec(i)) {
 		struct page **p;
 		struct page *page;
 
-		page = first_bvec_segment(i, &len, start, maxsize);
-		n = DIV_ROUND_UP(len + *start, PAGE_SIZE);
+		page = first_bvec_segment(i, &maxsize, start);
+		n = DIV_ROUND_UP(maxsize + *start, PAGE_SIZE);
 		if (n > maxpages)
 			n = maxpages;
 		p = *pages;
@@ -1412,7 +1405,7 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		}
 		for (int k = 0; k < n; k++)
 			get_page(*p++ = page++);
-		return min_t(size_t, len, n * PAGE_SIZE - *start);
+		return min_t(size_t, maxsize, n * PAGE_SIZE - *start);
 	}
 	if (iov_iter_is_pipe(i))
 		return pipe_get_pages(i, pages, maxsize, maxpages, start);
-- 
2.30.2

