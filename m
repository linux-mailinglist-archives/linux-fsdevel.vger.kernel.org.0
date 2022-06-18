Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE891550305
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 07:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbiFRFgK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 01:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbiFRFfw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 01:35:52 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CCC67D1C
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 22:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=U/Vouh95gO7o4CX6ALZV3wUKhFui54EiDL5POl5p1/Y=; b=eWw1XxrhVzrXJnha5TrRjPpqum
        WJ1A+gX+RhKbX8HSmYghq9wJYe4jjBPVOq+qualesyXTer+xUXK8ADlIMmfLrpnv2TsbckmwJGt+I
        jSY2N47Vyl1ERG+dcRwNIID+H0TRKEHkztHhswC5q0d1AQD6rOf/+lw3egYls95jCAgOloKuWXuTt
        3UazYiNMh6y656Aj2K/H3bQRakLcS9DkAaZVln8smx9H1r2wFddMEkKVBHRmOr1mpPw2ZmKxynsrS
        unqe09FPCI96mbWp3Ekfqv1B13KabkedOIDocZ20QqQ/NwSQhvA6n5p4oE6QSwYI26MPEQYHqpron
        mqOt9nvg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2R7W-001VQw-2z;
        Sat, 18 Jun 2022 05:35:42 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 19/31] iov_iter: massage calling conventions for first_{iovec,bvec}_segment()
Date:   Sat, 18 Jun 2022 06:35:26 +0100
Message-Id: <20220618053538.359065-20-viro@zeniv.linux.org.uk>
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

Pass maxsize by reference, return length via the same.  And do not
add offset to returned length.  Callers adjusted...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 49 +++++++++++++++++++++----------------------------
 1 file changed, 21 insertions(+), 28 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 8f1d63295f37..1a30783e2b60 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1307,25 +1307,22 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
 }
 
 static unsigned long found_ubuf_segment(unsigned long addr,
-					size_t len,
-					size_t *size, size_t *start)
+					size_t *start)
 {
-	len += (*start = addr % PAGE_SIZE);
-	*size = len;
+	*start = addr % PAGE_SIZE;
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
@@ -1334,28 +1331,26 @@ static unsigned long first_iovec_segment(const struct iov_iter *i,
 
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
-	len += (*start = skip % PAGE_SIZE);
-	*size = len;
+	*start = skip % PAGE_SIZE;
 	return page;
 }
 
@@ -1382,10 +1377,10 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		if (i->nofault)
 			gup_flags |= FOLL_NOFAULT;
 
-		addr = first_iovec_segment(i, &len, start, maxsize);
-		if (len > maxpages * PAGE_SIZE)
-			len = maxpages * PAGE_SIZE;
-		n = DIV_ROUND_UP(len, PAGE_SIZE);
+		addr = first_iovec_segment(i, &maxsize, start);
+		n = DIV_ROUND_UP(maxsize + *start, PAGE_SIZE);
+		if (n > maxpages)
+			n = maxpages;
 		if (*pages) {
 			*pages = get_pages_array(n);
 			if (!*pages)
@@ -1394,18 +1389,16 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		res = get_user_pages_fast(addr, n, gup_flags, *pages);
 		if (unlikely(res <= 0))
 			return res;
-		if (res < n)
-			len = res * PAGE_SIZE;
-		return len - *start;
+		return min_t(size_t, len, res * PAGE_SIZE - *start);
 	}
 	if (iov_iter_is_bvec(i)) {
 		struct page **p;
 		struct page *page;
 
-		page = first_bvec_segment(i, &len, start, maxsize);
-		if (len > maxpages * PAGE_SIZE)
-			len = maxpages * PAGE_SIZE;
-		n = DIV_ROUND_UP(len, PAGE_SIZE);
+		page = first_bvec_segment(i, &maxsize, start);
+		n = DIV_ROUND_UP(maxsize + *start, PAGE_SIZE);
+		if (n > maxpages)
+			n = maxpages;
 		p = *pages;
 		if (!p) {
 			*pages = p = get_pages_array(n);
@@ -1414,7 +1407,7 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		}
 		for (int k = 0; k < n; k++)
 			get_page(*p++ = page++);
-		return len - *start;
+		return min_t(size_t, maxsize, n * PAGE_SIZE - *start);
 	}
 	if (iov_iter_is_pipe(i))
 		return pipe_get_pages(i, pages, maxsize, maxpages, start);
-- 
2.30.2

