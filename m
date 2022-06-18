Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E4E5502FF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 07:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236009AbiFRFgN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 01:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbiFRFfw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 01:35:52 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4E467D2E
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 22:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ETxY5mjDtSBkCQY5lsVrrdsQQgPrqJDh3y/qSZDGdYg=; b=N4nYlRTF8i3zq8roShTD/aDZIs
        jYd+LNl7rNpfrrkrzATk2AD5xO07Q+4dGCjT8iDMy5Nrt3p7sa7rJvlHKokTDboMDwWvC/czvwcIG
        +xd4+vUI02eNDApSwZtAf0jXl0+2h548lrOaTJZ8dKW0eROU9pDvS6jIo+WhWbnLI7zWB4FfY5XEj
        ZTM2KkjaQr6BWMVMWY0Jmr7SuZYSinBbWQgvRJ2eANfD6vvMfQ5fb4dbzBMLI8mX/gIZcq7UwzZ6d
        Es8ZmTH/c/tlxU4ziVYdVj3Ct5WvPOtZIzMDSnC26BCagcmQW91XrcetUyZ8ILPilaIPZWx4PuoAo
        xHidoLcQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2R7W-001VR6-Du;
        Sat, 18 Jun 2022 05:35:42 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 21/31] fold __pipe_get_pages() into pipe_get_pages()
Date:   Sat, 18 Jun 2022 06:35:28 +0100
Message-Id: <20220618053538.359065-22-viro@zeniv.linux.org.uk>
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
index 96cf7a05946d..f20ba33f48da 100644
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

