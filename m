Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E6B55417F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356934AbiFVEQn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356818AbiFVEQI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:16:08 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B609AE75
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=OEd90yREgJWELU2w7cWXJBVJE39zUZSsOryGxe4Q4OQ=; b=ibihlEmo6jUNN/KlWvPzuNjBhs
        hwbAvzzPlOIAdoKxWkkMlkdlkyHMnspJibZkLOThwWKh4pz9YEbhjSbRjOODT3tYk17Q9j43EG91n
        BwuUXbjoZ4Lgkd2U+XFNOeuzz2RxplTJDZOfirW8z6HCDeUftyBab51d3vXrweGMuDY2ZY8IYdDFV
        /bPsn2NFtlhNKBkv7LWUH9rKvwiJSuiuvgiKKSPSArREz0n05auOTLD2VWCnbDCMxIPJ9sqb4BNyA
        th0wuJhTgE2StZaOZARUrfWZNpaZwVqkKW5FbkZl6Mg4oHewY/EFx0ZZuuFeVETIzRRgv3l3F2jXv
        0ZRqjBNQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rmY-0035z3-FY;
        Wed, 22 Jun 2022 04:15:58 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 34/44] fold __pipe_get_pages() into pipe_get_pages()
Date:   Wed, 22 Jun 2022 05:15:42 +0100
Message-Id: <20220622041552.737754-34-viro@zeniv.linux.org.uk>
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

... and don't mangle maxsize there - turn the loop into counting
one instead.  Easier to see that we won't run out of array that
way.  Note that special treatment of the partial buffer in that
thing is an artifact of the non-advancing semantics of
iov_iter_get_pages() - if not for that, it would be append_pipe(),
same as the body of the loop that follows it.  IOW, once we make
iov_iter_get_pages() advancing, the whole thing will turn into
	calculate how many pages do we want
	allocate an array (if needed)
	call append_pipe() that many times.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 75 +++++++++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f455b8ee0d76..9280f865fd6a 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1192,60 +1192,61 @@ static struct page **get_pages_array(size_t n)
 	return kvmalloc_array(n, sizeof(struct page *), GFP_KERNEL);
 }
 
-static inline ssize_t __pipe_get_pages(struct iov_iter *i,
-				size_t maxsize,
-				struct page **pages,
-				size_t off)
-{
-	struct pipe_inode_info *pipe = i->pipe;
-	ssize_t left = maxsize;
-
-	if (off) {
-		struct pipe_buffer *buf = pipe_buf(pipe, pipe->head - 1);
-
-		get_page(*pages++ = buf->page);
-		left -= PAGE_SIZE - off;
-		if (left <= 0) {
-			buf->len += maxsize;
-			return maxsize;
-		}
-		buf->len = PAGE_SIZE;
-	}
-	while (!pipe_full(pipe->head, pipe->tail, pipe->max_usage)) {
-		struct page *page = push_anon(pipe,
-					      min_t(ssize_t, left, PAGE_SIZE));
-		if (!page)
-			break;
-		get_page(*pages++ = page);
-		left -= PAGE_SIZE;
-		if (left <= 0)
-			return maxsize;
-	}
-	return maxsize - left ? : -EFAULT;
-}
-
 static ssize_t pipe_get_pages(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize, unsigned maxpages,
 		   size_t *start)
 {
+	struct pipe_inode_info *pipe = i->pipe;
 	unsigned int npages, off;
 	struct page **p;
-	size_t capacity;
+	ssize_t left;
+	int count;
 
 	if (!sanity(i))
 		return -EFAULT;
 
 	*start = off = pipe_npages(i, &npages);
-	capacity = min(npages, maxpages) * PAGE_SIZE - off;
-	maxsize = min(maxsize, capacity);
+	count = DIV_ROUND_UP(maxsize + off, PAGE_SIZE);
+	if (count > npages)
+		count = npages;
+	if (count > maxpages)
+		count = maxpages;
 	p = *pages;
 	if (!p) {
-		*pages = p = get_pages_array(DIV_ROUND_UP(maxsize + off, PAGE_SIZE));
+		*pages = p = get_pages_array(count);
 		if (!p)
 			return -ENOMEM;
 	}
 
-	return __pipe_get_pages(i, maxsize, p, off);
+	left = maxsize;
+	npages = 0;
+	if (off) {
+		struct pipe_buffer *buf = pipe_buf(pipe, pipe->head - 1);
+
+		get_page(*p++ = buf->page);
+		left -= PAGE_SIZE - off;
+		if (left <= 0) {
+			buf->len += maxsize;
+			return maxsize;
+		}
+		buf->len = PAGE_SIZE;
+		npages = 1;
+	}
+	for ( ; npages < count; npages++) {
+		struct page *page;
+		unsigned int size = min_t(ssize_t, left, PAGE_SIZE);
+
+		if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
+			break;
+		page = push_anon(pipe, size);
+		if (!page)
+			break;
+		get_page(*p++ = page);
+		left -= size;
+	}
+	if (!npages)
+		return -EFAULT;
+	return maxsize - left;
 }
 
 static ssize_t iter_xarray_populate_pages(struct page **pages, struct xarray *xa,
-- 
2.30.2

