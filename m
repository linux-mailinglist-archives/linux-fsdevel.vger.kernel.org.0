Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351AD5502E8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 07:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbiFRFfo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 01:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiFRFfm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 01:35:42 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2532366AF4
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 22:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+5FFITAWCa9EtnKte0tKJet3PNMEoVIO74X7YjiUBW0=; b=VO/z+nfLG6dKvJ9RzNdMkfO52g
        Mj4vry+eGhj0cWzZ2JEngxjMX/kmvegzCqNateL2QnhnomepKHqX880OLfVxWF/hzFl67z7sBt3vz
        oT0w5+PCW7zKCWQpUTr9IFgwiwcT1ryQ/PVENNOLPCrMT3F7wNh0SNGWDhnyX7qgb6auBZsZQ2iR8
        xOZnHqu7jvPkZCrkvVUoG6zOzjW/B4hcdX3skqO8Cnj85pgykF13A8b1AJUxqwmeNguxs43yJQnHL
        8Mww+cmoKzoUsLKdIdtvYBbyVDiX8+w+Cmc0pi0Up8Id1WGPHtkU44ius31BATwFJZ3xLXMqD2CUV
        f2+JMVyA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2R7T-001VPk-Jd;
        Sat, 18 Jun 2022 05:35:39 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 05/31] ITER_PIPE: fold push_pipe() into __pipe_get_pages()
Date:   Sat, 18 Jun 2022 06:35:11 +0100
Message-Id: <20220618053538.359065-5-viro@zeniv.linux.org.uk>
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

	Expand the only remaining call of push_pipe() (in
__pipe_get_pages()), combine it with the page-collecting loop there.

Note that the only reason it's not a loop doing append_pipe() is
that append_pipe() is advancing, while iov_iter_get_pages() is not.
As soon as it switches to saner semantics, this thing will switch
to using append_pipe().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 80 ++++++++++++++++----------------------------------
 1 file changed, 25 insertions(+), 55 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index d23e4ccd0564..603e5a55fe4e 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -449,46 +449,6 @@ static inline void data_start(const struct iov_iter *i,
 	*offp = off;
 }
 
-static size_t push_pipe(struct iov_iter *i, size_t size,
-			int *iter_headp, size_t *offp)
-{
-	struct pipe_inode_info *pipe = i->pipe;
-	unsigned int iter_head;
-	size_t off;
-	ssize_t left;
-
-	if (unlikely(size > i->count))
-		size = i->count;
-	if (unlikely(!size))
-		return 0;
-
-	left = size;
-	data_start(i, &iter_head, &off);
-	*iter_headp = iter_head;
-	*offp = off;
-	if (off) {
-		struct pipe_buffer *buf = pipe_buf(pipe, iter_head);
-
-		left -= PAGE_SIZE - off;
-		if (left <= 0) {
-			buf->len += size;
-			return size;
-		}
-		buf->len = PAGE_SIZE;
-	}
-	while (!pipe_full(pipe->head, pipe->tail, pipe->max_usage)) {
-		struct page *page = push_anon(pipe,
-					      min_t(ssize_t, left, PAGE_SIZE));
-		if (!page)
-			break;
-
-		left -= PAGE_SIZE;
-		if (left <= 0)
-			return size;
-	}
-	return size - left;
-}
-
 static size_t copy_pipe_to_iter(const void *addr, size_t bytes,
 				struct iov_iter *i)
 {
@@ -1261,23 +1221,33 @@ static inline ssize_t __pipe_get_pages(struct iov_iter *i,
 				size_t maxsize,
 				struct page **pages,
 				int iter_head,
-				size_t *start)
+				size_t off)
 {
 	struct pipe_inode_info *pipe = i->pipe;
-	unsigned int p_mask = pipe->ring_size - 1;
-	ssize_t n = push_pipe(i, maxsize, &iter_head, start);
-	if (!n)
-		return -EFAULT;
+	ssize_t left = maxsize;
 
-	maxsize = n;
-	n += *start;
-	while (n > 0) {
-		get_page(*pages++ = pipe->bufs[iter_head & p_mask].page);
-		iter_head++;
-		n -= PAGE_SIZE;
-	}
+	if (off) {
+		struct pipe_buffer *buf = pipe_buf(pipe, iter_head);
 
-	return maxsize;
+		get_page(*pages++ = buf->page);
+		left -= PAGE_SIZE - off;
+		if (left <= 0) {
+			buf->len += maxsize;
+			return maxsize;
+		}
+		buf->len = PAGE_SIZE;
+	}
+	while (!pipe_full(pipe->head, pipe->tail, pipe->max_usage)) {
+		struct page *page = push_anon(pipe,
+					      min_t(ssize_t, left, PAGE_SIZE));
+		if (!page)
+			break;
+		get_page(*pages++ = page);
+		left -= PAGE_SIZE;
+		if (left <= 0)
+			return maxsize;
+	}
+	return maxsize - left ? : -EFAULT;
 }
 
 static ssize_t pipe_get_pages(struct iov_iter *i,
@@ -1295,7 +1265,7 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 	npages = pipe_space_for_user(iter_head, i->pipe->tail, i->pipe);
 	capacity = min(npages, maxpages) * PAGE_SIZE - *start;
 
-	return __pipe_get_pages(i, min(maxsize, capacity), pages, iter_head, start);
+	return __pipe_get_pages(i, min(maxsize, capacity), pages, iter_head, *start);
 }
 
 static ssize_t iter_xarray_populate_pages(struct page **pages, struct xarray *xa,
@@ -1491,7 +1461,7 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter *i,
 	p = get_pages_array(npages);
 	if (!p)
 		return -ENOMEM;
-	n = __pipe_get_pages(i, maxsize, p, iter_head, start);
+	n = __pipe_get_pages(i, maxsize, p, iter_head, *start);
 	if (n > 0)
 		*pages = p;
 	else
-- 
2.30.2

