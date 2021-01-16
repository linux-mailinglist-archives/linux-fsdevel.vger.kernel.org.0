Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEA02F8B71
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Jan 2021 06:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbhAPFTD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Jan 2021 00:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbhAPFTD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Jan 2021 00:19:03 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3477C061757;
        Fri, 15 Jan 2021 21:18:22 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l0dyc-00Ai54-Ky; Sat, 16 Jan 2021 05:18:18 +0000
Date:   Sat, 16 Jan 2021 05:18:18 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iov_iter: optimise iter type checking
Message-ID: <20210116051818.GF3579531@ZenIV.linux.org.uk>
References: <a8cdb781384791c30e30036aced4c027c5dfea86.1605969341.git.asml.silence@gmail.com>
 <6e795064-fdbd-d354-4b01-a4f7409debf5@gmail.com>
 <54cd4d1b-d7ec-a74c-8be0-e48780609d56@gmail.com>
 <20210109170359.GT3579531@ZenIV.linux.org.uk>
 <b04df39d77114547811d7bfc2c0d4c8c@AcuMS.aculab.com>
 <1783c58f-1016-0c6b-be7f-a93bc2f8f2a4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1783c58f-1016-0c6b-be7f-a93bc2f8f2a4@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 09, 2021 at 10:11:09PM +0000, Pavel Begunkov wrote:

> > Does any code actually look at the fields as a pair?
> > Would it even be better to use separate bytes?
> > Even growing the on-stack structure by a word won't really matter.
> 
> u8 type, rw;
> 
> That won't bloat the struct. I like the idea. If used together compilers
> can treat it as u16.

Reasonable, and from what I remember from looking through the users,
no readers will bother with looking at both at the same time.

On the write side... it's only set in iov_iter_{kvec,bvec,pipe,discard,init}.
I sincerely doubt anyone would give a fuck, not to mention that something
like
void iov_iter_pipe(struct iov_iter *i, unsigned int direction,
                        struct pipe_inode_info *pipe,
                        size_t count)
{
        BUG_ON(direction != READ);
        WARN_ON(pipe_full(pipe->head, pipe->tail, pipe->ring_size));
	*i = (struct iov_iter) {
		.iter_type = ITER_PIPE,
		.data_source = false,
		.pipe = pipe,
		.head = pipe->head,
		.start_head = pipe->head,
		.count = count,
		.iov_offset = 0
	};
}

would make more sense anyway - we do want to overwrite everything in the
object, and let the compiler do whatever it likes to do.

So... something like (completely untested) variant below, perhaps?

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 72d88566694e..ed8ad2c5d384 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -19,20 +19,16 @@ struct kvec {
 
 enum iter_type {
 	/* iter types */
-	ITER_IOVEC = 4,
-	ITER_KVEC = 8,
-	ITER_BVEC = 16,
-	ITER_PIPE = 32,
-	ITER_DISCARD = 64,
+	ITER_IOVEC,
+	ITER_KVEC,
+	ITER_BVEC,
+	ITER_PIPE,
+	ITER_DISCARD
 };
 
 struct iov_iter {
-	/*
-	 * Bit 0 is the read/write bit, set if we're writing.
-	 * Bit 1 is the BVEC_FLAG_NO_REF bit, set if type is a bvec and
-	 * the caller isn't expecting to drop a page reference when done.
-	 */
-	unsigned int type;
+	u8 iter_type;
+	bool data_source;
 	size_t iov_offset;
 	size_t count;
 	union {
@@ -52,7 +48,7 @@ struct iov_iter {
 
 static inline enum iter_type iov_iter_type(const struct iov_iter *i)
 {
-	return i->type & ~(READ | WRITE);
+	return i->iter_type;
 }
 
 static inline bool iter_is_iovec(const struct iov_iter *i)
@@ -82,7 +78,7 @@ static inline bool iov_iter_is_discard(const struct iov_iter *i)
 
 static inline unsigned char iov_iter_rw(const struct iov_iter *i)
 {
-	return i->type & (READ | WRITE);
+	return i->data_source ? WRITE : READ;
 }
 
 /*
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 1635111c5bd2..133c03b2dcae 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -81,19 +81,18 @@
 #define iterate_all_kinds(i, n, v, I, B, K) {			\
 	if (likely(n)) {					\
 		size_t skip = i->iov_offset;			\
-		if (unlikely(i->type & ITER_BVEC)) {		\
+		if (likely(i->iter_type == ITER_IOVEC)) {	\
+			const struct iovec *iov;		\
+			struct iovec v;				\
+			iterate_iovec(i, n, v, iov, skip, (I))	\
+		} else if (i->iter_type == ITER_BVEC) {		\
 			struct bio_vec v;			\
 			struct bvec_iter __bi;			\
 			iterate_bvec(i, n, v, __bi, skip, (B))	\
-		} else if (unlikely(i->type & ITER_KVEC)) {	\
+		} else if (i->iter_type == ITER_KVEC) {		\
 			const struct kvec *kvec;		\
 			struct kvec v;				\
 			iterate_kvec(i, n, v, kvec, skip, (K))	\
-		} else if (unlikely(i->type & ITER_DISCARD)) {	\
-		} else {					\
-			const struct iovec *iov;		\
-			struct iovec v;				\
-			iterate_iovec(i, n, v, iov, skip, (I))	\
 		}						\
 	}							\
 }
@@ -103,7 +102,17 @@
 		n = i->count;					\
 	if (i->count) {						\
 		size_t skip = i->iov_offset;			\
-		if (unlikely(i->type & ITER_BVEC)) {		\
+		if (likely(i->iter_type == ITER_IOVEC)) {	\
+			const struct iovec *iov;		\
+			struct iovec v;				\
+			iterate_iovec(i, n, v, iov, skip, (I))	\
+			if (skip == iov->iov_len) {		\
+				iov++;				\
+				skip = 0;			\
+			}					\
+			i->nr_segs -= iov - i->iov;		\
+			i->iov = iov;				\
+		} else if (i->iter_type == ITER_BVEC) {		\
 			const struct bio_vec *bvec = i->bvec;	\
 			struct bio_vec v;			\
 			struct bvec_iter __bi;			\
@@ -111,7 +120,7 @@
 			i->bvec = __bvec_iter_bvec(i->bvec, __bi);	\
 			i->nr_segs -= i->bvec - bvec;		\
 			skip = __bi.bi_bvec_done;		\
-		} else if (unlikely(i->type & ITER_KVEC)) {	\
+		} else if (i->iter_type == ITER_KVEC) {		\
 			const struct kvec *kvec;		\
 			struct kvec v;				\
 			iterate_kvec(i, n, v, kvec, skip, (K))	\
@@ -121,18 +130,8 @@
 			}					\
 			i->nr_segs -= kvec - i->kvec;		\
 			i->kvec = kvec;				\
-		} else if (unlikely(i->type & ITER_DISCARD)) {	\
+		} else if (i->iter_type == ITER_DISCARD) {	\
 			skip += n;				\
-		} else {					\
-			const struct iovec *iov;		\
-			struct iovec v;				\
-			iterate_iovec(i, n, v, iov, skip, (I))	\
-			if (skip == iov->iov_len) {		\
-				iov++;				\
-				skip = 0;			\
-			}					\
-			i->nr_segs -= iov - i->iov;		\
-			i->iov = iov;				\
 		}						\
 		i->count -= n;					\
 		i->iov_offset = skip;				\
@@ -434,7 +433,7 @@ int iov_iter_fault_in_readable(struct iov_iter *i, size_t bytes)
 	int err;
 	struct iovec v;
 
-	if (!(i->type & (ITER_BVEC|ITER_KVEC))) {
+	if (i->iter_type == ITER_IOVEC) {
 		iterate_iovec(i, bytes, v, iov, skip, ({
 			err = fault_in_pages_readable(v.iov_base, v.iov_len);
 			if (unlikely(err))
@@ -450,19 +449,26 @@ void iov_iter_init(struct iov_iter *i, unsigned int direction,
 			size_t count)
 {
 	WARN_ON(direction & ~(READ | WRITE));
-	direction &= READ | WRITE;
 
 	/* It will get better.  Eventually... */
-	if (uaccess_kernel()) {
-		i->type = ITER_KVEC | direction;
-		i->kvec = (struct kvec *)iov;
-	} else {
-		i->type = ITER_IOVEC | direction;
-		i->iov = iov;
-	}
-	i->nr_segs = nr_segs;
-	i->iov_offset = 0;
-	i->count = count;
+	if (uaccess_kernel())
+		*i = (struct iov_iter) {
+			.iter_type = ITER_KVEC,
+			.data_source = direction,
+			.kvec = (struct kvec *)iov,
+			.nr_segs = nr_segs,
+			.iov_offset = 0,
+			.count = count
+		};
+	else
+		*i = (struct iov_iter) {
+			.iter_type = ITER_IOVEC,
+			.data_source = direction,
+			.iov = iov,
+			.nr_segs = nr_segs,
+			.iov_offset = 0,
+			.count = count
+		};
 }
 EXPORT_SYMBOL(iov_iter_init);
 
@@ -915,17 +921,20 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 {
 	if (unlikely(!page_copy_sane(page, offset, bytes)))
 		return 0;
-	if (i->type & (ITER_BVEC|ITER_KVEC)) {
+	if (likely(i->iter_type == ITER_IOVEC))
+		return copy_page_to_iter_iovec(page, offset, bytes, i);
+	if (i->iter_type == ITER_BVEC || i->iter_type == ITER_KVEC) {
 		void *kaddr = kmap_atomic(page);
 		size_t wanted = copy_to_iter(kaddr + offset, bytes, i);
 		kunmap_atomic(kaddr);
 		return wanted;
-	} else if (unlikely(iov_iter_is_discard(i)))
-		return bytes;
-	else if (likely(!iov_iter_is_pipe(i)))
-		return copy_page_to_iter_iovec(page, offset, bytes, i);
-	else
+	}
+	if (i->iter_type == ITER_PIPE)
 		return copy_page_to_iter_pipe(page, offset, bytes, i);
+	if (i->iter_type == ITER_DISCARD)
+		return bytes;
+	WARN_ON(1);
+	return 0;
 }
 EXPORT_SYMBOL(copy_page_to_iter);
 
@@ -934,17 +943,16 @@ size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 {
 	if (unlikely(!page_copy_sane(page, offset, bytes)))
 		return 0;
-	if (unlikely(iov_iter_is_pipe(i) || iov_iter_is_discard(i))) {
-		WARN_ON(1);
-		return 0;
-	}
-	if (i->type & (ITER_BVEC|ITER_KVEC)) {
+	if (likely(i->iter_type == ITER_IOVEC))
+		return copy_page_from_iter_iovec(page, offset, bytes, i);
+	if (i->iter_type == ITER_BVEC || i->iter_type == ITER_KVEC) {
 		void *kaddr = kmap_atomic(page);
 		size_t wanted = _copy_from_iter(kaddr + offset, bytes, i);
 		kunmap_atomic(kaddr);
 		return wanted;
-	} else
-		return copy_page_from_iter_iovec(page, offset, bytes, i);
+	}
+	WARN_ON(1);
+	return 0;
 }
 EXPORT_SYMBOL(copy_page_from_iter);
 
@@ -1172,11 +1180,14 @@ void iov_iter_kvec(struct iov_iter *i, unsigned int direction,
 			size_t count)
 {
 	WARN_ON(direction & ~(READ | WRITE));
-	i->type = ITER_KVEC | (direction & (READ | WRITE));
-	i->kvec = kvec;
-	i->nr_segs = nr_segs;
-	i->iov_offset = 0;
-	i->count = count;
+	*i = (struct iov_iter) {
+		.iter_type = ITER_KVEC,
+		.data_source = direction,
+		.kvec = kvec,
+		.nr_segs = nr_segs,
+		.iov_offset = 0,
+		.count = count
+	};
 }
 EXPORT_SYMBOL(iov_iter_kvec);
 
@@ -1185,11 +1196,14 @@ void iov_iter_bvec(struct iov_iter *i, unsigned int direction,
 			size_t count)
 {
 	WARN_ON(direction & ~(READ | WRITE));
-	i->type = ITER_BVEC | (direction & (READ | WRITE));
-	i->bvec = bvec;
-	i->nr_segs = nr_segs;
-	i->iov_offset = 0;
-	i->count = count;
+	*i = (struct iov_iter) {
+		.iter_type = ITER_BVEC,
+		.data_source = direction,
+		.bvec = bvec,
+		.nr_segs = nr_segs,
+		.iov_offset = 0,
+		.count = count
+	};
 }
 EXPORT_SYMBOL(iov_iter_bvec);
 
@@ -1199,12 +1213,15 @@ void iov_iter_pipe(struct iov_iter *i, unsigned int direction,
 {
 	BUG_ON(direction != READ);
 	WARN_ON(pipe_full(pipe->head, pipe->tail, pipe->ring_size));
-	i->type = ITER_PIPE | READ;
-	i->pipe = pipe;
-	i->head = pipe->head;
-	i->iov_offset = 0;
-	i->count = count;
-	i->start_head = i->head;
+        *i = (struct iov_iter) {
+		.iter_type = ITER_PIPE,
+		.data_source = false,
+		.pipe = pipe,
+		.head = pipe->head,
+		.start_head = pipe->head,
+		.count = count,
+		.iov_offset = 0
+	};
 }
 EXPORT_SYMBOL(iov_iter_pipe);
 
@@ -1220,9 +1237,11 @@ EXPORT_SYMBOL(iov_iter_pipe);
 void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count)
 {
 	BUG_ON(direction != READ);
-	i->type = ITER_DISCARD | READ;
-	i->count = count;
-	i->iov_offset = 0;
+	*i = (struct iov_iter) {
+		.iter_type = ITER_DISCARD,
+		.data_source = false,
+		.count = count,
+	};
 }
 EXPORT_SYMBOL(iov_iter_discard);
 
