Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB136B0F68
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 17:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjCHQzf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 11:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjCHQys (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 11:54:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861CE94F60
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Mar 2023 08:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678294409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XsRpjIP88f7UuB0TiBadjal83kAgF2un+t2WHwzlM/w=;
        b=ESMTPXwMco0lRhMhs1laDiZ+UdqTuDwSAPQzZe3cnUWV9kP8+FXUBRJm/rLi3Cj7/yxPYC
        45mMTpHW6P1i5rnBNsz7s0jReI9OpT4eLCS5TPo2+wH0vNEleiwrNPOHCzCR0S24PYCdfs
        grxhhZiVW8FE4r/LeRhv3dhuTUWoQiM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-iBdOJoOTPZWMtmN2YA3RcQ-1; Wed, 08 Mar 2023 11:53:22 -0500
X-MC-Unique: iBdOJoOTPZWMtmN2YA3RcQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3AD8857A8E;
        Wed,  8 Mar 2023 16:53:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8EFD492B05;
        Wed,  8 Mar 2023 16:53:19 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v17 08/14] iov_iter: Kill ITER_PIPE
Date:   Wed,  8 Mar 2023 16:52:45 +0000
Message-Id: <20230308165251.2078898-9-dhowells@redhat.com>
In-Reply-To: <20230308165251.2078898-1-dhowells@redhat.com>
References: <20230308165251.2078898-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The ITER_PIPE-type iterator was only used for generic_file_splice_read(),
but that has now been switched to either pull pages directly from the
pagecache for buffered file splice-reads or to use ITER_BVEC instead for
O_DIRECT file splice-reads.  This leaves ITER_PIPE unused - so remove it.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: linux-mm@kvack.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 include/linux/uio.h |  14 --
 lib/iov_iter.c      | 429 +-------------------------------------------
 mm/filemap.c        |   3 +-
 3 files changed, 4 insertions(+), 442 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 27e3fd942960..74598426edb4 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -11,7 +11,6 @@
 #include <uapi/linux/uio.h>
 
 struct page;
-struct pipe_inode_info;
 
 typedef unsigned int __bitwise iov_iter_extraction_t;
 
@@ -25,7 +24,6 @@ enum iter_type {
 	ITER_IOVEC,
 	ITER_KVEC,
 	ITER_BVEC,
-	ITER_PIPE,
 	ITER_XARRAY,
 	ITER_DISCARD,
 	ITER_UBUF,
@@ -55,15 +53,10 @@ struct iov_iter {
 		const struct kvec *kvec;
 		const struct bio_vec *bvec;
 		struct xarray *xarray;
-		struct pipe_inode_info *pipe;
 		void __user *ubuf;
 	};
 	union {
 		unsigned long nr_segs;
-		struct {
-			unsigned int head;
-			unsigned int start_head;
-		};
 		loff_t xarray_start;
 	};
 };
@@ -101,11 +94,6 @@ static inline bool iov_iter_is_bvec(const struct iov_iter *i)
 	return iov_iter_type(i) == ITER_BVEC;
 }
 
-static inline bool iov_iter_is_pipe(const struct iov_iter *i)
-{
-	return iov_iter_type(i) == ITER_PIPE;
-}
-
 static inline bool iov_iter_is_discard(const struct iov_iter *i)
 {
 	return iov_iter_type(i) == ITER_DISCARD;
@@ -247,8 +235,6 @@ void iov_iter_kvec(struct iov_iter *i, unsigned int direction, const struct kvec
 			unsigned long nr_segs, size_t count);
 void iov_iter_bvec(struct iov_iter *i, unsigned int direction, const struct bio_vec *bvec,
 			unsigned long nr_segs, size_t count);
-void iov_iter_pipe(struct iov_iter *i, unsigned int direction, struct pipe_inode_info *pipe,
-			size_t count);
 void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count);
 void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
 		     loff_t start, size_t count);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 274014e4eafe..fad95e4cf372 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -14,8 +14,6 @@
 #include <linux/scatterlist.h>
 #include <linux/instrumented.h>
 
-#define PIPE_PARANOIA /* for now */
-
 /* covers ubuf and kbuf alike */
 #define iterate_buf(i, n, base, len, off, __p, STEP) {		\
 	size_t __maybe_unused off = 0;				\
@@ -186,150 +184,6 @@ static int copyin(void *to, const void __user *from, size_t n)
 	return res;
 }
 
-#ifdef PIPE_PARANOIA
-static bool sanity(const struct iov_iter *i)
-{
-	struct pipe_inode_info *pipe = i->pipe;
-	unsigned int p_head = pipe->head;
-	unsigned int p_tail = pipe->tail;
-	unsigned int p_occupancy = pipe_occupancy(p_head, p_tail);
-	unsigned int i_head = i->head;
-	unsigned int idx;
-
-	if (i->last_offset) {
-		struct pipe_buffer *p;
-		if (unlikely(p_occupancy == 0))
-			goto Bad;	// pipe must be non-empty
-		if (unlikely(i_head != p_head - 1))
-			goto Bad;	// must be at the last buffer...
-
-		p = pipe_buf(pipe, i_head);
-		if (unlikely(p->offset + p->len != abs(i->last_offset)))
-			goto Bad;	// ... at the end of segment
-	} else {
-		if (i_head != p_head)
-			goto Bad;	// must be right after the last buffer
-	}
-	return true;
-Bad:
-	printk(KERN_ERR "idx = %d, offset = %d\n", i_head, i->last_offset);
-	printk(KERN_ERR "head = %d, tail = %d, buffers = %d\n",
-			p_head, p_tail, pipe->ring_size);
-	for (idx = 0; idx < pipe->ring_size; idx++)
-		printk(KERN_ERR "[%p %p %d %d]\n",
-			pipe->bufs[idx].ops,
-			pipe->bufs[idx].page,
-			pipe->bufs[idx].offset,
-			pipe->bufs[idx].len);
-	WARN_ON(1);
-	return false;
-}
-#else
-#define sanity(i) true
-#endif
-
-static struct page *push_anon(struct pipe_inode_info *pipe, unsigned size)
-{
-	struct page *page = alloc_page(GFP_USER);
-	if (page) {
-		struct pipe_buffer *buf = pipe_buf(pipe, pipe->head++);
-		*buf = (struct pipe_buffer) {
-			.ops = &default_pipe_buf_ops,
-			.page = page,
-			.offset = 0,
-			.len = size
-		};
-	}
-	return page;
-}
-
-static void push_page(struct pipe_inode_info *pipe, struct page *page,
-			unsigned int offset, unsigned int size)
-{
-	struct pipe_buffer *buf = pipe_buf(pipe, pipe->head++);
-	*buf = (struct pipe_buffer) {
-		.ops = &page_cache_pipe_buf_ops,
-		.page = page,
-		.offset = offset,
-		.len = size
-	};
-	get_page(page);
-}
-
-static inline int last_offset(const struct pipe_buffer *buf)
-{
-	if (buf->ops == &default_pipe_buf_ops)
-		return buf->len;	// buf->offset is 0 for those
-	else
-		return -(buf->offset + buf->len);
-}
-
-static struct page *append_pipe(struct iov_iter *i, size_t size,
-				unsigned int *off)
-{
-	struct pipe_inode_info *pipe = i->pipe;
-	int offset = i->last_offset;
-	struct pipe_buffer *buf;
-	struct page *page;
-
-	if (offset > 0 && offset < PAGE_SIZE) {
-		// some space in the last buffer; add to it
-		buf = pipe_buf(pipe, pipe->head - 1);
-		size = min_t(size_t, size, PAGE_SIZE - offset);
-		buf->len += size;
-		i->last_offset += size;
-		i->count -= size;
-		*off = offset;
-		return buf->page;
-	}
-	// OK, we need a new buffer
-	*off = 0;
-	size = min_t(size_t, size, PAGE_SIZE);
-	if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
-		return NULL;
-	page = push_anon(pipe, size);
-	if (!page)
-		return NULL;
-	i->head = pipe->head - 1;
-	i->last_offset = size;
-	i->count -= size;
-	return page;
-}
-
-static size_t copy_page_to_iter_pipe(struct page *page, size_t offset, size_t bytes,
-			 struct iov_iter *i)
-{
-	struct pipe_inode_info *pipe = i->pipe;
-	unsigned int head = pipe->head;
-
-	if (unlikely(bytes > i->count))
-		bytes = i->count;
-
-	if (unlikely(!bytes))
-		return 0;
-
-	if (!sanity(i))
-		return 0;
-
-	if (offset && i->last_offset == -offset) { // could we merge it?
-		struct pipe_buffer *buf = pipe_buf(pipe, head - 1);
-		if (buf->page == page) {
-			buf->len += bytes;
-			i->last_offset -= bytes;
-			i->count -= bytes;
-			return bytes;
-		}
-	}
-	if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
-		return 0;
-
-	push_page(pipe, page, offset, bytes);
-	i->last_offset = -(offset + bytes);
-	i->head = head;
-	i->count -= bytes;
-	return bytes;
-}
-
 /*
  * fault_in_iov_iter_readable - fault in iov iterator for reading
  * @i: iterator
@@ -433,46 +287,6 @@ void iov_iter_init(struct iov_iter *i, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_init);
 
-// returns the offset in partial buffer (if any)
-static inline unsigned int pipe_npages(const struct iov_iter *i, int *npages)
-{
-	struct pipe_inode_info *pipe = i->pipe;
-	int used = pipe->head - pipe->tail;
-	int off = i->last_offset;
-
-	*npages = max((int)pipe->max_usage - used, 0);
-
-	if (off > 0 && off < PAGE_SIZE) { // anon and not full
-		(*npages)++;
-		return off;
-	}
-	return 0;
-}
-
-static size_t copy_pipe_to_iter(const void *addr, size_t bytes,
-				struct iov_iter *i)
-{
-	unsigned int off, chunk;
-
-	if (unlikely(bytes > i->count))
-		bytes = i->count;
-	if (unlikely(!bytes))
-		return 0;
-
-	if (!sanity(i))
-		return 0;
-
-	for (size_t n = bytes; n; n -= chunk) {
-		struct page *page = append_pipe(i, n, &off);
-		chunk = min_t(size_t, n, PAGE_SIZE - off);
-		if (!page)
-			return bytes - n;
-		memcpy_to_page(page, off, addr, chunk);
-		addr += chunk;
-	}
-	return bytes;
-}
-
 static __wsum csum_and_memcpy(void *to, const void *from, size_t len,
 			      __wsum sum, size_t off)
 {
@@ -480,44 +294,10 @@ static __wsum csum_and_memcpy(void *to, const void *from, size_t len,
 	return csum_block_add(sum, next, off);
 }
 
-static size_t csum_and_copy_to_pipe_iter(const void *addr, size_t bytes,
-					 struct iov_iter *i, __wsum *sump)
-{
-	__wsum sum = *sump;
-	size_t off = 0;
-	unsigned int chunk, r;
-
-	if (unlikely(bytes > i->count))
-		bytes = i->count;
-	if (unlikely(!bytes))
-		return 0;
-
-	if (!sanity(i))
-		return 0;
-
-	while (bytes) {
-		struct page *page = append_pipe(i, bytes, &r);
-		char *p;
-
-		if (!page)
-			break;
-		chunk = min_t(size_t, bytes, PAGE_SIZE - r);
-		p = kmap_local_page(page);
-		sum = csum_and_memcpy(p + r, addr + off, chunk, sum, off);
-		kunmap_local(p);
-		off += chunk;
-		bytes -= chunk;
-	}
-	*sump = sum;
-	return off;
-}
-
 size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 {
 	if (WARN_ON_ONCE(i->data_source))
 		return 0;
-	if (unlikely(iov_iter_is_pipe(i)))
-		return copy_pipe_to_iter(addr, bytes, i);
 	if (user_backed_iter(i))
 		might_fault();
 	iterate_and_advance(i, bytes, base, len, off,
@@ -539,42 +319,6 @@ static int copyout_mc(void __user *to, const void *from, size_t n)
 	return n;
 }
 
-static size_t copy_mc_pipe_to_iter(const void *addr, size_t bytes,
-				struct iov_iter *i)
-{
-	size_t xfer = 0;
-	unsigned int off, chunk;
-
-	if (unlikely(bytes > i->count))
-		bytes = i->count;
-	if (unlikely(!bytes))
-		return 0;
-
-	if (!sanity(i))
-		return 0;
-
-	while (bytes) {
-		struct page *page = append_pipe(i, bytes, &off);
-		unsigned long rem;
-		char *p;
-
-		if (!page)
-			break;
-		chunk = min_t(size_t, bytes, PAGE_SIZE - off);
-		p = kmap_local_page(page);
-		rem = copy_mc_to_kernel(p + off, addr + xfer, chunk);
-		chunk -= rem;
-		kunmap_local(p);
-		xfer += chunk;
-		bytes -= chunk;
-		if (rem) {
-			iov_iter_revert(i, rem);
-			break;
-		}
-	}
-	return xfer;
-}
-
 /**
  * _copy_mc_to_iter - copy to iter with source memory error exception handling
  * @addr: source kernel address
@@ -594,9 +338,8 @@ static size_t copy_mc_pipe_to_iter(const void *addr, size_t bytes,
  *   alignment and poison alignment assumptions to avoid re-triggering
  *   hardware exceptions.
  *
- * * ITER_KVEC, ITER_PIPE, and ITER_BVEC can return short copies.
- *   Compare to copy_to_iter() where only ITER_IOVEC attempts might return
- *   a short copy.
+ * * ITER_KVEC and ITER_BVEC can return short copies.  Compare to
+ *   copy_to_iter() where only ITER_IOVEC attempts might return a short copy.
  *
  * Return: number of bytes copied (may be %0)
  */
@@ -604,8 +347,6 @@ size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 {
 	if (WARN_ON_ONCE(i->data_source))
 		return 0;
-	if (unlikely(iov_iter_is_pipe(i)))
-		return copy_mc_pipe_to_iter(addr, bytes, i);
 	if (user_backed_iter(i))
 		might_fault();
 	__iterate_and_advance(i, bytes, base, len, off,
@@ -711,8 +452,6 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 		return 0;
 	if (WARN_ON_ONCE(i->data_source))
 		return 0;
-	if (unlikely(iov_iter_is_pipe(i)))
-		return copy_page_to_iter_pipe(page, offset, bytes, i);
 	page += offset / PAGE_SIZE; // first subpage
 	offset %= PAGE_SIZE;
 	while (1) {
@@ -761,36 +500,8 @@ size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 }
 EXPORT_SYMBOL(copy_page_from_iter);
 
-static size_t pipe_zero(size_t bytes, struct iov_iter *i)
-{
-	unsigned int chunk, off;
-
-	if (unlikely(bytes > i->count))
-		bytes = i->count;
-	if (unlikely(!bytes))
-		return 0;
-
-	if (!sanity(i))
-		return 0;
-
-	for (size_t n = bytes; n; n -= chunk) {
-		struct page *page = append_pipe(i, n, &off);
-		char *p;
-
-		if (!page)
-			return bytes - n;
-		chunk = min_t(size_t, n, PAGE_SIZE - off);
-		p = kmap_local_page(page);
-		memset(p + off, 0, chunk);
-		kunmap_local(p);
-	}
-	return bytes;
-}
-
 size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
 {
-	if (unlikely(iov_iter_is_pipe(i)))
-		return pipe_zero(bytes, i);
 	iterate_and_advance(i, bytes, base, len, count,
 		clear_user(base, len),
 		memset(base, 0, len)
@@ -821,32 +532,6 @@ size_t copy_page_from_iter_atomic(struct page *page, unsigned offset, size_t byt
 }
 EXPORT_SYMBOL(copy_page_from_iter_atomic);
 
-static void pipe_advance(struct iov_iter *i, size_t size)
-{
-	struct pipe_inode_info *pipe = i->pipe;
-	int off = i->last_offset;
-
-	if (!off && !size) {
-		pipe_discard_from(pipe, i->start_head); // discard everything
-		return;
-	}
-	i->count -= size;
-	while (1) {
-		struct pipe_buffer *buf = pipe_buf(pipe, i->head);
-		if (off) /* make it relative to the beginning of buffer */
-			size += abs(off) - buf->offset;
-		if (size <= buf->len) {
-			buf->len = size;
-			i->last_offset = last_offset(buf);
-			break;
-		}
-		size -= buf->len;
-		i->head++;
-		off = 0;
-	}
-	pipe_discard_from(pipe, i->head + 1); // discard everything past this one
-}
-
 static void iov_iter_bvec_advance(struct iov_iter *i, size_t size)
 {
 	const struct bio_vec *bvec, *end;
@@ -898,8 +583,6 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
 		iov_iter_iovec_advance(i, size);
 	} else if (iov_iter_is_bvec(i)) {
 		iov_iter_bvec_advance(i, size);
-	} else if (iov_iter_is_pipe(i)) {
-		pipe_advance(i, size);
 	} else if (iov_iter_is_discard(i)) {
 		i->count -= size;
 	}
@@ -913,26 +596,6 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 	if (WARN_ON(unroll > MAX_RW_COUNT))
 		return;
 	i->count += unroll;
-	if (unlikely(iov_iter_is_pipe(i))) {
-		struct pipe_inode_info *pipe = i->pipe;
-		unsigned int head = pipe->head;
-
-		while (head > i->start_head) {
-			struct pipe_buffer *b = pipe_buf(pipe, --head);
-			if (unroll < b->len) {
-				b->len -= unroll;
-				i->last_offset = last_offset(b);
-				i->head = head;
-				return;
-			}
-			unroll -= b->len;
-			pipe_buf_release(pipe, b);
-			pipe->head--;
-		}
-		i->last_offset = 0;
-		i->head = head;
-		return;
-	}
 	if (unlikely(iov_iter_is_discard(i)))
 		return;
 	if (unroll <= i->iov_offset) {
@@ -1020,24 +683,6 @@ void iov_iter_bvec(struct iov_iter *i, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_bvec);
 
-void iov_iter_pipe(struct iov_iter *i, unsigned int direction,
-			struct pipe_inode_info *pipe,
-			size_t count)
-{
-	BUG_ON(direction != READ);
-	WARN_ON(pipe_full(pipe->head, pipe->tail, pipe->ring_size));
-	*i = (struct iov_iter){
-		.iter_type = ITER_PIPE,
-		.data_source = false,
-		.pipe = pipe,
-		.head = pipe->head,
-		.start_head = pipe->head,
-		.last_offset = 0,
-		.count = count
-	};
-}
-EXPORT_SYMBOL(iov_iter_pipe);
-
 /**
  * iov_iter_xarray - Initialise an I/O iterator to use the pages in an xarray
  * @i: The iterator to initialise.
@@ -1162,19 +807,6 @@ bool iov_iter_is_aligned(const struct iov_iter *i, unsigned addr_mask,
 	if (iov_iter_is_bvec(i))
 		return iov_iter_aligned_bvec(i, addr_mask, len_mask);
 
-	if (iov_iter_is_pipe(i)) {
-		size_t size = i->count;
-
-		if (size & len_mask)
-			return false;
-		if (size && i->last_offset > 0) {
-			if (i->last_offset & addr_mask)
-				return false;
-		}
-
-		return true;
-	}
-
 	if (iov_iter_is_xarray(i)) {
 		if (i->count & len_mask)
 			return false;
@@ -1244,14 +876,6 @@ unsigned long iov_iter_alignment(const struct iov_iter *i)
 	if (iov_iter_is_bvec(i))
 		return iov_iter_alignment_bvec(i);
 
-	if (iov_iter_is_pipe(i)) {
-		size_t size = i->count;
-
-		if (size && i->last_offset > 0)
-			return size | i->last_offset;
-		return size;
-	}
-
 	if (iov_iter_is_xarray(i))
 		return (i->xarray_start + i->iov_offset) | i->count;
 
@@ -1303,36 +927,6 @@ static int want_pages_array(struct page ***res, size_t size,
 	return count;
 }
 
-static ssize_t pipe_get_pages(struct iov_iter *i,
-		   struct page ***pages, size_t maxsize, unsigned maxpages,
-		   size_t *start)
-{
-	unsigned int npages, count, off, chunk;
-	struct page **p;
-	size_t left;
-
-	if (!sanity(i))
-		return -EFAULT;
-
-	*start = off = pipe_npages(i, &npages);
-	if (!npages)
-		return -EFAULT;
-	count = want_pages_array(pages, maxsize, off, min(npages, maxpages));
-	if (!count)
-		return -ENOMEM;
-	p = *pages;
-	for (npages = 0, left = maxsize ; npages < count; npages++, left -= chunk) {
-		struct page *page = append_pipe(i, left, &off);
-		if (!page)
-			break;
-		chunk = min_t(size_t, left, PAGE_SIZE - off);
-		get_page(*p++ = page);
-	}
-	if (!npages)
-		return -EFAULT;
-	return maxsize - left;
-}
-
 static ssize_t iter_xarray_populate_pages(struct page **pages, struct xarray *xa,
 					  pgoff_t index, unsigned int nr_pages)
 {
@@ -1482,8 +1076,6 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		}
 		return maxsize;
 	}
-	if (iov_iter_is_pipe(i))
-		return pipe_get_pages(i, pages, maxsize, maxpages, start);
 	if (iov_iter_is_xarray(i))
 		return iter_xarray_get_pages(i, pages, maxsize, maxpages, start);
 	return -EFAULT;
@@ -1573,9 +1165,7 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *_csstate,
 	}
 
 	sum = csum_shift(csstate->csum, csstate->off);
-	if (unlikely(iov_iter_is_pipe(i)))
-		bytes = csum_and_copy_to_pipe_iter(addr, bytes, i, &sum);
-	else iterate_and_advance(i, bytes, base, len, off, ({
+	iterate_and_advance(i, bytes, base, len, off, ({
 		next = csum_and_copy_to_user(addr + off, base, len);
 		sum = csum_block_add(sum, next, off);
 		next ? 0 : len;
@@ -1660,15 +1250,6 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
 		return iov_npages(i, maxpages);
 	if (iov_iter_is_bvec(i))
 		return bvec_npages(i, maxpages);
-	if (iov_iter_is_pipe(i)) {
-		int npages;
-
-		if (!sanity(i))
-			return 0;
-
-		pipe_npages(i, &npages);
-		return min(npages, maxpages);
-	}
 	if (iov_iter_is_xarray(i)) {
 		unsigned offset = (i->xarray_start + i->iov_offset) % PAGE_SIZE;
 		int npages = DIV_ROUND_UP(offset + i->count, PAGE_SIZE);
@@ -1681,10 +1262,6 @@ EXPORT_SYMBOL(iov_iter_npages);
 const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags)
 {
 	*new = *old;
-	if (unlikely(iov_iter_is_pipe(new))) {
-		WARN_ON(1);
-		return NULL;
-	}
 	if (iov_iter_is_bvec(new))
 		return new->bvec = kmemdup(new->bvec,
 				    new->nr_segs * sizeof(struct bio_vec),
diff --git a/mm/filemap.c b/mm/filemap.c
index 3a93515ae2ed..470be06b6096 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2690,8 +2690,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		if (unlikely(iocb->ki_pos >= i_size_read(inode)))
 			break;
 
-		error = filemap_get_pages(iocb, iter->count, &fbatch,
-					  iov_iter_is_pipe(iter));
+		error = filemap_get_pages(iocb, iter->count, &fbatch, false);
 		if (error < 0)
 			break;
 

