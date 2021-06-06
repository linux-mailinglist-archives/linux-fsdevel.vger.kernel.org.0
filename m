Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FBE39D0B8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhFFTNN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhFFTMv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:12:51 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494C4C061766;
        Sun,  6 Jun 2021 12:10:59 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAh-0056c1-3l; Sun, 06 Jun 2021 19:10:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 29/37] iov_iter: make iterator callbacks use base and len instead of iovec
Date:   Sun,  6 Jun 2021 19:10:43 +0000
Message-Id: <20210606191051.1216821-29-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210606191051.1216821-1-viro@zeniv.linux.org.uk>
References: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk>
 <20210606191051.1216821-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Iterator macros used to provide the arguments for step callbacks in
a structure matching the flavour - iovec for ITER_IOVEC, kvec for
ITER_KVEC and bio_vec for ITER_BVEC.  That already broke down for
ITER_XARRAY (bio_vec there); now that we are using kvec callback
for bvec and xarray cases, we are always passing a pointer + length
(void __user * + size_t for ITER_IOVEC callback, void * + size_t
for everything else).

Note that the original reason for bio_vec (page + offset + len) in
case of ITER_BVEC used to be that we did *not* want to kmap a
page when all we wanted was e.g. to find the alignment of its
subrange.  Now all such users are gone and the ones that are left
want the page mapped anyway for actually copying the data.

So in all cases we have pointer + length, and there's no good
reason for keeping those in struct iovec or struct kvec - we
can just pass them to callback separately.

Again, less boilerplate in callbacks...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 182 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 91 insertions(+), 91 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 14e34f9df490..8a7a8e5f4155 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -17,86 +17,86 @@
 #define PIPE_PARANOIA /* for now */
 
 /* covers iovec and kvec alike */
-#define iterate_iovec(i, n, __v, __off, __p, skip, STEP) {	\
-	size_t __off = 0;					\
+#define iterate_iovec(i, n, base, len, off, __p, skip, STEP) {	\
+	size_t off = 0;						\
 	do {							\
-		__v.iov_len = min(n, __p->iov_len - skip);	\
-		if (likely(__v.iov_len)) {			\
-			__v.iov_base = __p->iov_base + skip;	\
-			__v.iov_len -= (STEP);			\
-			__off += __v.iov_len;			\
-			skip += __v.iov_len;			\
-			n -= __v.iov_len;			\
+		len = min(n, __p->iov_len - skip);		\
+		if (likely(len)) {				\
+			base = __p->iov_base + skip;		\
+			len -= (STEP);				\
+			off += len;				\
+			skip += len;				\
+			n -= len;				\
 			if (skip < __p->iov_len)		\
 				break;				\
 		}						\
 		__p++;						\
 		skip = 0;					\
 	} while (n);						\
-	n = __off;						\
+	n = off;						\
 }
 
-#define iterate_bvec(i, n, __v, __off, p, skip, STEP) {		\
-	size_t __off = 0;					\
+#define iterate_bvec(i, n, base, len, off, p, skip, STEP) {	\
+	size_t off = 0;						\
 	while (n) {						\
 		unsigned offset = p->bv_offset + skip;		\
 		unsigned left;					\
 		void *kaddr = kmap_local_page(p->bv_page +	\
 					offset / PAGE_SIZE);	\
-		__v.iov_base = kaddr + offset % PAGE_SIZE;	\
-		__v.iov_len = min(min(n, p->bv_len - skip),	\
+		base = kaddr + offset % PAGE_SIZE;		\
+		len = min(min(n, p->bv_len - skip),		\
 		     (size_t)(PAGE_SIZE - offset % PAGE_SIZE));	\
 		left = (STEP);					\
 		kunmap_local(kaddr);				\
-		__v.iov_len -= left;				\
-		__off += __v.iov_len;				\
-		skip += __v.iov_len;				\
+		len -= left;					\
+		off += len;					\
+		skip += len;					\
 		if (skip == p->bv_len) {			\
 			skip = 0;				\
 			p++;					\
 		}						\
-		n -= __v.iov_len;				\
+		n -= len;					\
 		if (left)					\
 			break;					\
 	}							\
-	n = __off;						\
+	n = off;						\
 }
 
-#define iterate_xarray(i, n, __v, __off, skip, STEP) {		\
+#define iterate_xarray(i, n, base, len, __off, skip, STEP) {	\
 	__label__ __out;					\
 	size_t __off = 0;					\
 	struct page *head = NULL;				\
-	size_t seg, offset;					\
+	size_t offset;						\
 	loff_t start = i->xarray_start + skip;			\
 	pgoff_t index = start >> PAGE_SHIFT;			\
 	int j;							\
 								\
 	XA_STATE(xas, i->xarray, index);			\
 								\
-	rcu_read_lock();						\
-	xas_for_each(&xas, head, ULONG_MAX) {				\
-		unsigned left;						\
-		if (xas_retry(&xas, head))				\
-			continue;					\
-		if (WARN_ON(xa_is_value(head)))				\
-			break;						\
-		if (WARN_ON(PageHuge(head)))				\
-			break;						\
+	rcu_read_lock();					\
+	xas_for_each(&xas, head, ULONG_MAX) {			\
+		unsigned left;					\
+		if (xas_retry(&xas, head))			\
+			continue;				\
+		if (WARN_ON(xa_is_value(head)))			\
+			break;					\
+		if (WARN_ON(PageHuge(head)))			\
+			break;					\
 		for (j = (head->index < index) ? index - head->index : 0; \
-		     j < thp_nr_pages(head); j++) {			\
+		     j < thp_nr_pages(head); j++) {		\
 			void *kaddr = kmap_local_page(head + j);	\
-			offset = (start + __off) % PAGE_SIZE;		\
-			__v.iov_base = kaddr + offset;			\
-			seg = PAGE_SIZE - offset;			\
-			__v.iov_len = min(n, seg);			\
-			left = (STEP);					\
-			kunmap_local(kaddr);				\
-			__v.iov_len -= left;				\
-			__off += __v.iov_len;				\
-			n -= __v.iov_len;				\
-			if (left || n == 0)				\
-				goto __out;				\
-		}							\
+			offset = (start + __off) % PAGE_SIZE;	\
+			base = kaddr + offset;			\
+			len = PAGE_SIZE - offset;		\
+			len = min(n, len);			\
+			left = (STEP);				\
+			kunmap_local(kaddr);			\
+			len -= left;				\
+			__off += len;				\
+			n -= len;				\
+			if (left || n == 0)			\
+				goto __out;			\
+		}						\
 	}							\
 __out:								\
 	rcu_read_unlock();					\
@@ -104,39 +104,47 @@ __out:								\
 	n = __off;						\
 }
 
-#define __iterate_and_advance(i, n, v, off, I, K) {		\
+#define __iterate_and_advance(i, n, base, len, off, I, K) {	\
 	if (unlikely(i->count < n))				\
 		n = i->count;					\
 	if (likely(n)) {					\
 		size_t skip = i->iov_offset;			\
 		if (likely(iter_is_iovec(i))) {			\
 			const struct iovec *iov = i->iov;	\
-			struct iovec v;				\
-			iterate_iovec(i, n, v, off, iov, skip, (I))	\
+			void __user *base;			\
+			size_t len;				\
+			iterate_iovec(i, n, base, len, off,	\
+						iov, skip, (I))	\
 			i->nr_segs -= iov - i->iov;		\
 			i->iov = iov;				\
 		} else if (iov_iter_is_bvec(i)) {		\
 			const struct bio_vec *bvec = i->bvec;	\
-			struct kvec v;				\
-			iterate_bvec(i, n, v, off, bvec, skip, (K))	\
+			void *base;				\
+			size_t len;				\
+			iterate_bvec(i, n, base, len, off,	\
+					bvec, skip, (K))	\
 			i->nr_segs -= bvec - i->bvec;		\
 			i->bvec = bvec;				\
 		} else if (iov_iter_is_kvec(i)) {		\
 			const struct kvec *kvec = i->kvec;	\
-			struct kvec v;				\
-			iterate_iovec(i, n, v, off, kvec, skip, (K))	\
+			void *base;				\
+			size_t len;				\
+			iterate_iovec(i, n, base, len, off,	\
+					kvec, skip, (K))	\
 			i->nr_segs -= kvec - i->kvec;		\
 			i->kvec = kvec;				\
 		} else if (iov_iter_is_xarray(i)) {		\
-			struct kvec v;				\
-			iterate_xarray(i, n, v, off, skip, (K))	\
+			void *base;				\
+			size_t len;				\
+			iterate_xarray(i, n, base, len, off,	\
+						skip, (K))	\
 		}						\
 		i->count -= n;					\
 		i->iov_offset = skip;				\
 	}							\
 }
-#define iterate_and_advance(i, n, v, off, I, K) \
-	__iterate_and_advance(i, n, v, off, I, ((void)(K),0))
+#define iterate_and_advance(i, n, base, len, off, I, K) \
+	__iterate_and_advance(i, n, base, len, off, I, ((void)(K),0))
 
 static int copyout(void __user *to, const void *from, size_t n)
 {
@@ -624,9 +632,9 @@ size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 		return copy_pipe_to_iter(addr, bytes, i);
 	if (iter_is_iovec(i))
 		might_fault();
-	iterate_and_advance(i, bytes, v, off,
-		copyout(v.iov_base, addr + off, v.iov_len),
-		memcpy(v.iov_base, addr + off, v.iov_len)
+	iterate_and_advance(i, bytes, base, len, off,
+		copyout(base, addr + off, len),
+		memcpy(base, addr + off, len)
 	)
 
 	return bytes;
@@ -719,9 +727,9 @@ size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 		return copy_mc_pipe_to_iter(addr, bytes, i);
 	if (iter_is_iovec(i))
 		might_fault();
-	__iterate_and_advance(i, bytes, v, off,
-		copyout_mc(v.iov_base, addr + off, v.iov_len),
-		copy_mc_to_kernel(v.iov_base, addr + off, v.iov_len)
+	__iterate_and_advance(i, bytes, base, len, off,
+		copyout_mc(base, addr + off, len),
+		copy_mc_to_kernel(base, addr + off, len)
 	)
 
 	return bytes;
@@ -737,9 +745,9 @@ size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 	}
 	if (iter_is_iovec(i))
 		might_fault();
-	iterate_and_advance(i, bytes, v, off,
-		copyin(addr + off, v.iov_base, v.iov_len),
-		memcpy(addr + off, v.iov_base, v.iov_len)
+	iterate_and_advance(i, bytes, base, len, off,
+		copyin(addr + off, base, len),
+		memcpy(addr + off, base, len)
 	)
 
 	return bytes;
@@ -752,10 +760,9 @@ size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i)
 		WARN_ON(1);
 		return 0;
 	}
-	iterate_and_advance(i, bytes, v, off,
-		__copy_from_user_inatomic_nocache(addr + off,
-					 v.iov_base, v.iov_len),
-		memcpy(addr + off, v.iov_base, v.iov_len)
+	iterate_and_advance(i, bytes, base, len, off,
+		__copy_from_user_inatomic_nocache(addr + off, base, len),
+		memcpy(addr + off, base, len)
 	)
 
 	return bytes;
@@ -783,9 +790,9 @@ size_t _copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
 		WARN_ON(1);
 		return 0;
 	}
-	iterate_and_advance(i, bytes, v, off,
-		__copy_from_user_flushcache(addr + off, v.iov_base, v.iov_len),
-		memcpy_flushcache(addr + off, v.iov_base, v.iov_len)
+	iterate_and_advance(i, bytes, base, len, off,
+		__copy_from_user_flushcache(addr + off, base, len),
+		memcpy_flushcache(addr + off, base, len)
 	)
 
 	return bytes;
@@ -914,9 +921,9 @@ size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
 {
 	if (unlikely(iov_iter_is_pipe(i)))
 		return pipe_zero(bytes, i);
-	iterate_and_advance(i, bytes, v, count,
-		clear_user(v.iov_base, v.iov_len),
-		memset(v.iov_base, 0, v.iov_len)
+	iterate_and_advance(i, bytes, base, len, count,
+		clear_user(base, len),
+		memset(base, 0, len)
 	)
 
 	return bytes;
@@ -936,9 +943,9 @@ size_t copy_page_from_iter_atomic(struct page *page, unsigned offset, size_t byt
 		WARN_ON(1);
 		return 0;
 	}
-	iterate_and_advance(i, bytes, v, off,
-		copyin(p + off, v.iov_base, v.iov_len),
-		memcpy(p + off, v.iov_base, v.iov_len)
+	iterate_and_advance(i, bytes, base, len, off,
+		copyin(p + off, base, len),
+		memcpy(p + off, base, len)
 	)
 	kunmap_atomic(kaddr);
 	return bytes;
@@ -1667,16 +1674,13 @@ size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 		WARN_ON(1);
 		return 0;
 	}
-	iterate_and_advance(i, bytes, v, off, ({
-		next = csum_and_copy_from_user(v.iov_base,
-					       addr + off,
-					       v.iov_len);
+	iterate_and_advance(i, bytes, base, len, off, ({
+		next = csum_and_copy_from_user(base, addr + off, len);
 		if (next)
 			sum = csum_block_add(sum, next, off);
-		next ? 0 : v.iov_len;
+		next ? 0 : len;
 	}), ({
-		sum = csum_and_memcpy(addr + off, v.iov_base, v.iov_len,
-				      sum, off);
+		sum = csum_and_memcpy(addr + off, base, len, sum, off);
 	})
 	)
 	*csum = sum;
@@ -1698,17 +1702,13 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *_csstate,
 		WARN_ON(1);	/* for now */
 		return 0;
 	}
-	iterate_and_advance(i, bytes, v, off, ({
-		next = csum_and_copy_to_user(addr + off,
-					     v.iov_base,
-					     v.iov_len);
+	iterate_and_advance(i, bytes, base, len, off, ({
+		next = csum_and_copy_to_user(addr + off, base, len);
 		if (next)
 			sum = csum_block_add(sum, next, off);
-		next ? 0 : v.iov_len;
+		next ? 0 : len;
 	}), ({
-		sum = csum_and_memcpy(v.iov_base,
-				     addr + off,
-				     v.iov_len, sum, off);
+		sum = csum_and_memcpy(base, addr + off, len, sum, off);
 	})
 	)
 	csstate->csum = csum_shift(sum, csstate->off);
-- 
2.11.0

