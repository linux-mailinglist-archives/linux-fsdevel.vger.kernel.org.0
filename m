Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD5C55416A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356882AbiFVEQU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356713AbiFVEP7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:15:59 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D5F65B7
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mLj5PkxHc90os+7X5POLttjxS5yvU/rKhJBnE9f5AP0=; b=ERCJGIzfW42WdNHRCev5awl+WF
        SnFavVTAjY5nKaoQvLknbbxzghyeUWiiWrFyXi+6CR9Vbh+B2OnSFm6Tcw0vzXGB48gr7gijqCb+0
        K9J2Lqssye658lW4RCCkCP7JjjOA1w2uZ+mNHxlsTRpRWgJ1RzJgBk8vMXJBAllWFZK6DW1sU7tyd
        okvJf+ztQGOg4zcipX8YLGv2EYv2wojheJynSzaloyHM7lcUFpsORtMVTfpOWqnYf7c0SkErYUItp
        xiJtQwr7eWx2WwNxA9Sm4aoEEW8cX1tmpKSqkvTlycWEUUd2MmhcrJbQtrRStT+UuDeBj1e8cb+BD
        ZzWO/ifQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rmU-0035wg-Vr;
        Wed, 22 Jun 2022 04:15:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 15/44] ITER_PIPE: helpers for adding pipe buffers
Date:   Wed, 22 Jun 2022 05:15:23 +0100
Message-Id: <20220622041552.737754-15-viro@zeniv.linux.org.uk>
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

There are only two kinds of pipe_buffer in the area used by ITER_PIPE.

1) anonymous - copy_to_iter() et.al. end up creating those and copying
data there.  They have zero ->offset, and their ->ops points to
default_pipe_page_ops.

2) zero-copy ones - those come from copy_page_to_iter(), and page
comes from caller.  ->offset is also caller-supplied - it might be
non-zero.  ->ops points to page_cache_pipe_buf_ops.

Move creation and insertion of those into helpers - push_anon(pipe, size)
and push_page(pipe, page, offset, size) resp., separating them from
the "could we avoid creating a new buffer by merging with the current
head?" logics.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 88 ++++++++++++++++++++++++++------------------------
 1 file changed, 46 insertions(+), 42 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 08bb393da677..924854c2a7ce 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -231,15 +231,39 @@ static bool sanity(const struct iov_iter *i)
 #define sanity(i) true
 #endif
 
+static struct page *push_anon(struct pipe_inode_info *pipe, unsigned size)
+{
+	struct page *page = alloc_page(GFP_USER);
+	if (page) {
+		struct pipe_buffer *buf = pipe_buf(pipe, pipe->head++);
+		*buf = (struct pipe_buffer) {
+			.ops = &default_pipe_buf_ops,
+			.page = page,
+			.offset = 0,
+			.len = size
+		};
+	}
+	return page;
+}
+
+static void push_page(struct pipe_inode_info *pipe, struct page *page,
+			unsigned int offset, unsigned int size)
+{
+	struct pipe_buffer *buf = pipe_buf(pipe, pipe->head++);
+	*buf = (struct pipe_buffer) {
+		.ops = &page_cache_pipe_buf_ops,
+		.page = page,
+		.offset = offset,
+		.len = size
+	};
+	get_page(page);
+}
+
 static size_t copy_page_to_iter_pipe(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i)
 {
 	struct pipe_inode_info *pipe = i->pipe;
-	struct pipe_buffer *buf;
-	unsigned int p_tail = pipe->tail;
-	unsigned int p_mask = pipe->ring_size - 1;
-	unsigned int i_head = i->head;
-	size_t off;
+	unsigned int head = pipe->head;
 
 	if (unlikely(bytes > i->count))
 		bytes = i->count;
@@ -250,32 +274,21 @@ static size_t copy_page_to_iter_pipe(struct page *page, size_t offset, size_t by
 	if (!sanity(i))
 		return 0;
 
-	off = i->iov_offset;
-	buf = &pipe->bufs[i_head & p_mask];
-	if (off) {
-		if (offset == off && buf->page == page) {
-			/* merge with the last one */
+	if (offset && i->iov_offset == offset) { // could we merge it?
+		struct pipe_buffer *buf = pipe_buf(pipe, head - 1);
+		if (buf->page == page) {
 			buf->len += bytes;
 			i->iov_offset += bytes;
-			goto out;
+			i->count -= bytes;
+			return bytes;
 		}
-		i_head++;
-		buf = &pipe->bufs[i_head & p_mask];
 	}
-	if (pipe_full(i_head, p_tail, pipe->max_usage))
+	if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
 		return 0;
 
-	buf->ops = &page_cache_pipe_buf_ops;
-	buf->flags = 0;
-	get_page(page);
-	buf->page = page;
-	buf->offset = offset;
-	buf->len = bytes;
-
-	pipe->head = i_head + 1;
+	push_page(pipe, page, offset, bytes);
 	i->iov_offset = offset + bytes;
-	i->head = i_head;
-out:
+	i->head = head;
 	i->count -= bytes;
 	return bytes;
 }
@@ -407,8 +420,6 @@ static size_t push_pipe(struct iov_iter *i, size_t size,
 			int *iter_headp, size_t *offp)
 {
 	struct pipe_inode_info *pipe = i->pipe;
-	unsigned int p_tail = pipe->tail;
-	unsigned int p_mask = pipe->ring_size - 1;
 	unsigned int iter_head;
 	size_t off;
 	ssize_t left;
@@ -423,30 +434,23 @@ static size_t push_pipe(struct iov_iter *i, size_t size,
 	*iter_headp = iter_head;
 	*offp = off;
 	if (off) {
+		struct pipe_buffer *buf = pipe_buf(pipe, iter_head);
+
 		left -= PAGE_SIZE - off;
 		if (left <= 0) {
-			pipe->bufs[iter_head & p_mask].len += size;
+			buf->len += size;
 			return size;
 		}
-		pipe->bufs[iter_head & p_mask].len = PAGE_SIZE;
-		iter_head++;
+		buf->len = PAGE_SIZE;
 	}
-	while (!pipe_full(iter_head, p_tail, pipe->max_usage)) {
-		struct pipe_buffer *buf = &pipe->bufs[iter_head & p_mask];
-		struct page *page = alloc_page(GFP_USER);
+	while (!pipe_full(pipe->head, pipe->tail, pipe->max_usage)) {
+		struct page *page = push_anon(pipe,
+					      min_t(ssize_t, left, PAGE_SIZE));
 		if (!page)
 			break;
 
-		buf->ops = &default_pipe_buf_ops;
-		buf->flags = 0;
-		buf->page = page;
-		buf->offset = 0;
-		buf->len = min_t(ssize_t, left, PAGE_SIZE);
-		left -= buf->len;
-		iter_head++;
-		pipe->head = iter_head;
-
-		if (left == 0)
+		left -= PAGE_SIZE;
+		if (left <= 0)
 			return size;
 	}
 	return size - left;
-- 
2.30.2

