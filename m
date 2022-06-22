Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D68554185
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356893AbiFVEQW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356715AbiFVEP7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:15:59 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DC27640
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nCDb/stb7cqyzIfwc4qSCwYKLlHAIJUuROBEbgZA3HU=; b=Cz9UnkT3koep4YkSOXcTkdlKLQ
        OxhMP7Z5sdsx9Sb1H0tLv5ODGYnPEvo34csLMlFVxpr6XCDiNIv9hb94VTRKgssRXpHwvUccVlq+B
        toBdF5xKQy9v5qc7spTGf3nmD1WcbGZk/NvxtjKJx5blKlb1JIk7XiggYeWgic4TIlZVUd7ObnjVr
        a6lFXY+uCRg7PV/Kg2ojxOhKV5rXr/VSyKCddTeIg9JVpp8BgQ8tR9m0Kgj5WR95FhTOvpGB4izns
        qILoH4uy2caSpLeda7+XeinYbbK2MjbfeOjMFQubIjeOCYD9vkIC+pxKTD/eF26E4pI9ukZv76TWB
        79aUMsnA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rmV-0035wq-5a;
        Wed, 22 Jun 2022 04:15:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 16/44] ITER_PIPE: allocate buffers as we go in copy-to-pipe primitives
Date:   Wed, 22 Jun 2022 05:15:24 +0100
Message-Id: <20220622041552.737754-16-viro@zeniv.linux.org.uk>
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

New helper: append_pipe().  Extends the last buffer if possible,
allocates a new one otherwise.  Returns page and offset in it
on success, NULL on failure.  iov_iter is advanced past the
data we've got.

Use that instead of push_pipe() in copy-to-pipe primitives;
they get simpler that way.  Handling of short copy (in "mc" one)
is done simply by iov_iter_revert() - iov_iter is in consistent
state after that one, so we can use that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 159 +++++++++++++++++++++++++++++--------------------
 1 file changed, 93 insertions(+), 66 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 924854c2a7ce..2a445261096e 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -259,6 +259,44 @@ static void push_page(struct pipe_inode_info *pipe, struct page *page,
 	get_page(page);
 }
 
+static inline bool allocated(struct pipe_buffer *buf)
+{
+	return buf->ops == &default_pipe_buf_ops;
+}
+
+static struct page *append_pipe(struct iov_iter *i, size_t size, size_t *off)
+{
+	struct pipe_inode_info *pipe = i->pipe;
+	size_t offset = i->iov_offset;
+	struct pipe_buffer *buf;
+	struct page *page;
+
+	if (offset && offset < PAGE_SIZE) {
+		// some space in the last buffer; can we add to it?
+		buf = pipe_buf(pipe, pipe->head - 1);
+		if (allocated(buf)) {
+			size = min_t(size_t, size, PAGE_SIZE - offset);
+			buf->len += size;
+			i->iov_offset += size;
+			i->count -= size;
+			*off = offset;
+			return buf->page;
+		}
+	}
+	// OK, we need a new buffer
+	*off = 0;
+	size = min_t(size_t, size, PAGE_SIZE);
+	if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
+		return NULL;
+	page = push_anon(pipe, size);
+	if (!page)
+		return NULL;
+	i->head = pipe->head - 1;
+	i->iov_offset = size;
+	i->count -= size;
+	return page;
+}
+
 static size_t copy_page_to_iter_pipe(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i)
 {
@@ -396,11 +434,6 @@ void iov_iter_init(struct iov_iter *i, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_init);
 
-static inline bool allocated(struct pipe_buffer *buf)
-{
-	return buf->ops == &default_pipe_buf_ops;
-}
-
 static inline void data_start(const struct iov_iter *i,
 			      unsigned int *iter_headp, size_t *offp)
 {
@@ -459,28 +492,26 @@ static size_t push_pipe(struct iov_iter *i, size_t size,
 static size_t copy_pipe_to_iter(const void *addr, size_t bytes,
 				struct iov_iter *i)
 {
-	struct pipe_inode_info *pipe = i->pipe;
-	unsigned int p_mask = pipe->ring_size - 1;
-	unsigned int i_head;
 	size_t n, off;
 
-	if (!sanity(i))
+	if (unlikely(bytes > i->count))
+		bytes = i->count;
+	if (unlikely(!bytes))
 		return 0;
 
-	bytes = n = push_pipe(i, bytes, &i_head, &off);
-	if (unlikely(!n))
+	if (!sanity(i))
 		return 0;
-	do {
+
+	n = bytes;
+	while (n) {
+		struct page *page = append_pipe(i, n, &off);
 		size_t chunk = min_t(size_t, n, PAGE_SIZE - off);
-		memcpy_to_page(pipe->bufs[i_head & p_mask].page, off, addr, chunk);
-		i->head = i_head;
-		i->iov_offset = off + chunk;
-		n -= chunk;
+		if (!page)
+			break;
+		memcpy_to_page(page, off, addr, chunk);
 		addr += chunk;
-		off = 0;
-		i_head++;
-	} while (n);
-	i->count -= bytes;
+		n -= chunk;
+	}
 	return bytes;
 }
 
@@ -494,31 +525,32 @@ static __wsum csum_and_memcpy(void *to, const void *from, size_t len,
 static size_t csum_and_copy_to_pipe_iter(const void *addr, size_t bytes,
 					 struct iov_iter *i, __wsum *sump)
 {
-	struct pipe_inode_info *pipe = i->pipe;
-	unsigned int p_mask = pipe->ring_size - 1;
 	__wsum sum = *sump;
 	size_t off = 0;
-	unsigned int i_head;
 	size_t r;
 
+	if (unlikely(bytes > i->count))
+		bytes = i->count;
+	if (unlikely(!bytes))
+		return 0;
+
 	if (!sanity(i))
 		return 0;
 
-	bytes = push_pipe(i, bytes, &i_head, &r);
 	while (bytes) {
+		struct page *page = append_pipe(i, bytes, &r);
 		size_t chunk = min_t(size_t, bytes, PAGE_SIZE - r);
-		char *p = kmap_local_page(pipe->bufs[i_head & p_mask].page);
+		char *p;
+
+		if (!page)
+			break;
+		p = kmap_local_page(page);
 		sum = csum_and_memcpy(p + r, addr + off, chunk, sum, off);
 		kunmap_local(p);
-		i->head = i_head;
-		i->iov_offset = r + chunk;
-		bytes -= chunk;
 		off += chunk;
-		r = 0;
-		i_head++;
+		bytes -= chunk;
 	}
 	*sump = sum;
-	i->count -= off;
 	return off;
 }
 
@@ -550,39 +582,35 @@ static int copyout_mc(void __user *to, const void *from, size_t n)
 static size_t copy_mc_pipe_to_iter(const void *addr, size_t bytes,
 				struct iov_iter *i)
 {
-	struct pipe_inode_info *pipe = i->pipe;
-	unsigned int p_mask = pipe->ring_size - 1;
-	unsigned int i_head;
-	unsigned int valid = pipe->head;
-	size_t n, off, xfer = 0;
+	size_t off, xfer = 0;
+
+	if (unlikely(bytes > i->count))
+		bytes = i->count;
+	if (unlikely(!bytes))
+		return 0;
 
 	if (!sanity(i))
 		return 0;
 
-	n = push_pipe(i, bytes, &i_head, &off);
-	while (n) {
-		size_t chunk = min_t(size_t, n, PAGE_SIZE - off);
-		char *p = kmap_local_page(pipe->bufs[i_head & p_mask].page);
+	while (bytes) {
+		struct page *page = append_pipe(i, bytes, &off);
+		size_t chunk = min_t(size_t, bytes, PAGE_SIZE - off);
 		unsigned long rem;
+		char *p;
+
+		if (!page)
+			break;
+		p = kmap_local_page(page);
 		rem = copy_mc_to_kernel(p + off, addr + xfer, chunk);
 		chunk -= rem;
 		kunmap_local(p);
-		if (chunk) {
-			i->head = i_head;
-			i->iov_offset = off + chunk;
-			xfer += chunk;
-			valid = i_head + 1;
-		}
+		xfer += chunk;
+		bytes -= chunk;
 		if (rem) {
-			pipe->bufs[i_head & p_mask].len -= rem;
-			pipe_discard_from(pipe, valid);
+			iov_iter_revert(i, rem);
 			break;
 		}
-		n -= chunk;
-		off = 0;
-		i_head++;
 	}
-	i->count -= xfer;
 	return xfer;
 }
 
@@ -769,30 +797,29 @@ EXPORT_SYMBOL(copy_page_from_iter);
 
 static size_t pipe_zero(size_t bytes, struct iov_iter *i)
 {
-	struct pipe_inode_info *pipe = i->pipe;
-	unsigned int p_mask = pipe->ring_size - 1;
-	unsigned int i_head;
 	size_t n, off;
 
-	if (!sanity(i))
+	if (unlikely(bytes > i->count))
+		bytes = i->count;
+	if (unlikely(!bytes))
 		return 0;
 
-	bytes = n = push_pipe(i, bytes, &i_head, &off);
-	if (unlikely(!n))
+	if (!sanity(i))
 		return 0;
 
-	do {
+	n = bytes;
+	while (n) {
+		struct page *page = append_pipe(i, n, &off);
 		size_t chunk = min_t(size_t, n, PAGE_SIZE - off);
-		char *p = kmap_local_page(pipe->bufs[i_head & p_mask].page);
+		char *p;
+
+		if (!page)
+			break;
+		p = kmap_local_page(page);
 		memset(p + off, 0, chunk);
 		kunmap_local(p);
-		i->head = i_head;
-		i->iov_offset = off + chunk;
 		n -= chunk;
-		off = 0;
-		i_head++;
-	} while (n);
-	i->count -= bytes;
+	}
 	return bytes;
 }
 
-- 
2.30.2

