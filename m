Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDB955042F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 13:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbiFRLPZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 07:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbiFRLNa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 07:13:30 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526BF15837
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jun 2022 04:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GWT5w+pFhg/YK9TYYVCfAIZhGvME9EpV3zgbyYAfr9M=; b=bOPtrWeOiOsnuRRFIXrDo2oGpA
        FLVuezHlTUr+Jabwa2de/0uWY36SEHpR2/LDPcGCtAALuvPHOk7IJEcCfHhjc16eyQxzbc0WjA9Hm
        8fy4v677mkLhq7yNfxviRebh5jRWdyX62trouzVpeg21UXI6B2OIRaip8yWoOk1M1cvmoa+5Uy14V
        Mi5IOsvM2BGDtrNyfrpOI6ff6CgOs8ZiBBc3/UCeyaUtoOoOoz2QyKkUwB98IzI8ufofnPVUNtJNL
        haZiee+jM1qWXojj17X7O5ldbVfgTsKbYj0rknhSD2r5t3ycs0VM4H3FVQdOTTyA+rijxsmGOzA/s
        SimzxtxA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2WOM-001ajf-Q4;
        Sat, 18 Jun 2022 11:13:27 +0000
Date:   Sat, 18 Jun 2022 12:13:26 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 19/31] iov_iter: massage calling conventions for
 first_{iovec,bvec}_segment()
Message-ID: <Yq2zVpWI252Mryg5@ZenIV>
References: <Yq1iNHboD+9fz60M@ZenIV>
 <20220618053538.359065-1-viro@zeniv.linux.org.uk>
 <20220618053538.359065-20-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618053538.359065-20-viro@zeniv.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[with braino fixed]
From 3893e9565ad55a8514f5f819545bf9df5a339c76 Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Fri, 10 Jun 2022 22:19:25 -0400
Subject: [PATCH 19/31] iov_iter: massage calling conventions for
 first_{iovec,bvec}_segment()

Pass maxsize by reference, return length via the same.  And do not
add offset to returned length.  Callers adjusted...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 50 +++++++++++++++++++++-----------------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 8f1d63295f37..b789728678d2 100644
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
 
@@ -1363,7 +1358,6 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
 		   unsigned int maxpages, size_t *start)
 {
-	size_t len;
 	int n, res;
 
 	if (maxsize > i->count)
@@ -1382,10 +1376,10 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
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
@@ -1394,18 +1388,16 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		res = get_user_pages_fast(addr, n, gup_flags, *pages);
 		if (unlikely(res <= 0))
 			return res;
-		if (res < n)
-			len = res * PAGE_SIZE;
-		return len - *start;
+		return min_t(size_t, maxsize, res * PAGE_SIZE - *start);
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
@@ -1414,7 +1406,7 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
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

