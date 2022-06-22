Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA6C55416D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356980AbiFVEQx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356827AbiFVEQI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:16:08 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E8960E4
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=SmvagF6Vv4nPPylNtEr0z1KTgyZMdUEuo9sZnW9DNAc=; b=sxMhx8urPH3qAK+dOhAYUMb2KL
        S7wgmFU37ImZWt8/NTauT4GhuLRTzFCShQ4JSuviGKIUKAMJJ8o41Cf3YO9CSCOtJOKDRqZFFrDci
        3LyiCh8tgCm3avEvf3u+JBZU9kiQBOPRlbKOWhznhlx2vKY7q+ejQvNBeHqKP+apba+N9reAH+lpc
        5k2PkASZLm0uoVxNs/K+1Tn+x0gIsKE5Sd+XcMMtY60LIioPkjAPKLX16C/A98pswDs3AQk53DnIa
        GtBHhXZD3SAkoFnFOL/VHKPQdmpvN+31UORFBJwXfQk8hJsjskFEA5Ow8LyUngocl2d9pPPcLoQUs
        Hy5peoOg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rmV-0035xN-TC;
        Wed, 22 Jun 2022 04:15:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 21/44] ITER_PIPE: cache the type of last buffer
Date:   Wed, 22 Jun 2022 05:15:29 +0100
Message-Id: <20220622041552.737754-21-viro@zeniv.linux.org.uk>
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

We often need to find whether the last buffer is anon or not, and
currently it's rather clumsy:
	check if ->iov_offset is non-zero (i.e. that pipe is not empty)
	if so, get the corresponding pipe_buffer and check its ->ops
	if it's &default_pipe_buf_ops, we have an anon buffer.

Let's replace the use of ->iov_offset (which is nowhere near similar to
its role for other flavours) with signed field (->last_offset), with
the following rules:
	empty, no buffers occupied:		0
	anon, with bytes up to N-1 filled:	N
	zero-copy, with bytes up to N-1 filled:	-N

That way abs(i->last_offset) is equal to what used to be in i->iov_offset
and empty vs. anon vs. zero-copy can be distinguished by the sign of
i->last_offset.

	Checks for "should we extend the last buffer or should we start
a new one?" become easier to follow that way.

	Note that most of the operations can only be done in a sane
state - i.e. when the pipe has nothing past the current position of
iterator.  About the only thing that could be done outside of that
state is iov_iter_advance(), which transitions to the sane state by
truncating the pipe.  There are only two cases where we leave the
sane state:
	1) iov_iter_get_pages()/iov_iter_get_pages_alloc().  Will be
dealt with later, when we make get_pages advancing - the callers are
actually happier that way.
	2) iov_iter copied, then something is put into the copy.  Since
they share the underlying pipe, the original gets behind.  When we
decide that we are done with the copy (original is not usable until then)
we advance the original.  direct_io used to be done that way; nowadays
it operates on the original and we do iov_iter_revert() to discard
the excessive data.  At the moment there's nothing in the kernel that
could do that to ITER_PIPE iterators, so this reason for insane state
is theoretical right now.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/uio.h |  5 +++-
 lib/iov_iter.c      | 72 ++++++++++++++++++++++-----------------------
 2 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 6ab4260c3d6c..d3e13b37ea72 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -40,7 +40,10 @@ struct iov_iter {
 	bool nofault;
 	bool data_source;
 	bool user_backed;
-	size_t iov_offset;
+	union {
+		size_t iov_offset;
+		int last_offset;
+	};
 	size_t count;
 	union {
 		const struct iovec *iov;
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 4e2b000b0466..27ad2ef93dbc 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -199,7 +199,7 @@ static bool sanity(const struct iov_iter *i)
 	unsigned int i_head = i->head;
 	unsigned int idx;
 
-	if (i->iov_offset) {
+	if (i->last_offset) {
 		struct pipe_buffer *p;
 		if (unlikely(p_occupancy == 0))
 			goto Bad;	// pipe must be non-empty
@@ -207,7 +207,7 @@ static bool sanity(const struct iov_iter *i)
 			goto Bad;	// must be at the last buffer...
 
 		p = pipe_buf(pipe, i_head);
-		if (unlikely(p->offset + p->len != i->iov_offset))
+		if (unlikely(p->offset + p->len != abs(i->last_offset)))
 			goto Bad;	// ... at the end of segment
 	} else {
 		if (i_head != p_head)
@@ -215,7 +215,7 @@ static bool sanity(const struct iov_iter *i)
 	}
 	return true;
 Bad:
-	printk(KERN_ERR "idx = %d, offset = %zd\n", i_head, i->iov_offset);
+	printk(KERN_ERR "idx = %d, offset = %d\n", i_head, i->last_offset);
 	printk(KERN_ERR "head = %d, tail = %d, buffers = %d\n",
 			p_head, p_tail, pipe->ring_size);
 	for (idx = 0; idx < pipe->ring_size; idx++)
@@ -259,29 +259,30 @@ static void push_page(struct pipe_inode_info *pipe, struct page *page,
 	get_page(page);
 }
 
-static inline bool allocated(struct pipe_buffer *buf)
+static inline int last_offset(const struct pipe_buffer *buf)
 {
-	return buf->ops == &default_pipe_buf_ops;
+	if (buf->ops == &default_pipe_buf_ops)
+		return buf->len;	// buf->offset is 0 for those
+	else
+		return -(buf->offset + buf->len);
 }
 
 static struct page *append_pipe(struct iov_iter *i, size_t size, size_t *off)
 {
 	struct pipe_inode_info *pipe = i->pipe;
-	size_t offset = i->iov_offset;
+	int offset = i->last_offset;
 	struct pipe_buffer *buf;
 	struct page *page;
 
-	if (offset && offset < PAGE_SIZE) {
-		// some space in the last buffer; can we add to it?
+	if (offset > 0 && offset < PAGE_SIZE) {
+		// some space in the last buffer; add to it
 		buf = pipe_buf(pipe, pipe->head - 1);
-		if (allocated(buf)) {
-			size = min_t(size_t, size, PAGE_SIZE - offset);
-			buf->len += size;
-			i->iov_offset += size;
-			i->count -= size;
-			*off = offset;
-			return buf->page;
-		}
+		size = min_t(size_t, size, PAGE_SIZE - offset);
+		buf->len += size;
+		i->last_offset += size;
+		i->count -= size;
+		*off = offset;
+		return buf->page;
 	}
 	// OK, we need a new buffer
 	*off = 0;
@@ -292,7 +293,7 @@ static struct page *append_pipe(struct iov_iter *i, size_t size, size_t *off)
 	if (!page)
 		return NULL;
 	i->head = pipe->head - 1;
-	i->iov_offset = size;
+	i->last_offset = size;
 	i->count -= size;
 	return page;
 }
@@ -312,11 +313,11 @@ static size_t copy_page_to_iter_pipe(struct page *page, size_t offset, size_t by
 	if (!sanity(i))
 		return 0;
 
-	if (offset && i->iov_offset == offset) { // could we merge it?
+	if (offset && i->last_offset == -offset) { // could we merge it?
 		struct pipe_buffer *buf = pipe_buf(pipe, head - 1);
 		if (buf->page == page) {
 			buf->len += bytes;
-			i->iov_offset += bytes;
+			i->last_offset -= bytes;
 			i->count -= bytes;
 			return bytes;
 		}
@@ -325,7 +326,7 @@ static size_t copy_page_to_iter_pipe(struct page *page, size_t offset, size_t by
 		return 0;
 
 	push_page(pipe, page, offset, bytes);
-	i->iov_offset = offset + bytes;
+	i->last_offset = -(offset + bytes);
 	i->head = head;
 	i->count -= bytes;
 	return bytes;
@@ -437,16 +438,15 @@ EXPORT_SYMBOL(iov_iter_init);
 static inline void data_start(const struct iov_iter *i,
 			      unsigned int *iter_headp, size_t *offp)
 {
-	unsigned int iter_head = i->head;
-	size_t off = i->iov_offset;
+	int off = i->last_offset;
 
-	if (off && (!allocated(pipe_buf(i->pipe, iter_head)) ||
-		    off == PAGE_SIZE)) {
-		iter_head++;
-		off = 0;
+	if (off > 0 && off < PAGE_SIZE) { // anon and not full
+		*iter_headp = i->pipe->head - 1;
+		*offp = off;
+	} else {
+		*iter_headp = i->pipe->head;
+		*offp = 0;
 	}
-	*iter_headp = iter_head;
-	*offp = off;
 }
 
 static size_t copy_pipe_to_iter(const void *addr, size_t bytes,
@@ -821,7 +821,7 @@ EXPORT_SYMBOL(copy_page_from_iter_atomic);
 static void pipe_advance(struct iov_iter *i, size_t size)
 {
 	struct pipe_inode_info *pipe = i->pipe;
-	unsigned int off = i->iov_offset;
+	int off = i->last_offset;
 
 	if (!off && !size) {
 		pipe_discard_from(pipe, i->start_head); // discard everything
@@ -831,10 +831,10 @@ static void pipe_advance(struct iov_iter *i, size_t size)
 	while (1) {
 		struct pipe_buffer *buf = pipe_buf(pipe, i->head);
 		if (off) /* make it relative to the beginning of buffer */
-			size += off - buf->offset;
+			size += abs(off) - buf->offset;
 		if (size <= buf->len) {
 			buf->len = size;
-			i->iov_offset = buf->offset + size;
+			i->last_offset = last_offset(buf);
 			break;
 		}
 		size -= buf->len;
@@ -918,7 +918,7 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 			struct pipe_buffer *b = pipe_buf(pipe, --head);
 			if (unroll < b->len) {
 				b->len -= unroll;
-				i->iov_offset = b->offset + b->len;
+				i->last_offset = last_offset(b);
 				i->head = head;
 				return;
 			}
@@ -926,7 +926,7 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 			pipe_buf_release(pipe, b);
 			pipe->head--;
 		}
-		i->iov_offset = 0;
+		i->last_offset = 0;
 		i->head = head;
 		return;
 	}
@@ -1029,7 +1029,7 @@ void iov_iter_pipe(struct iov_iter *i, unsigned int direction,
 		.pipe = pipe,
 		.head = pipe->head,
 		.start_head = pipe->head,
-		.iov_offset = 0,
+		.last_offset = 0,
 		.count = count
 	};
 }
@@ -1145,8 +1145,8 @@ unsigned long iov_iter_alignment(const struct iov_iter *i)
 	if (iov_iter_is_pipe(i)) {
 		size_t size = i->count;
 
-		if (size && i->iov_offset && allocated(pipe_buf(i->pipe, i->head)))
-			return size | i->iov_offset;
+		if (size && i->last_offset > 0)
+			return size | i->last_offset;
 		return size;
 	}
 
-- 
2.30.2

