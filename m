Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2E139D0C5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhFFTN0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhFFTNB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:13:01 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA5BC061766;
        Sun,  6 Jun 2021 12:11:11 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAg-0056bt-VQ; Sun, 06 Jun 2021 19:10:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 28/37] iov_iter: make the amount already copied available to iterator callbacks
Date:   Sun,  6 Jun 2021 19:10:42 +0000
Message-Id: <20210606191051.1216821-28-viro@zeniv.linux.org.uk>
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

Making iterator macros keep track of the amount of data copied is pretty
easy and it has several benefits:
	1) we no longer need the mess like (from += v.iov_len) - v.iov_len
in the callbacks - initial value + total amount copied so far would do
just fine.
	2) less obviously, we no longer need to remember the initial amount
of data we wanted to copy; the loops in iterator macros are along the lines
of
	wanted = bytes;
	while (bytes) {
		copy some
		bytes -= copied
		if short copy
			break
	}
	bytes = wanted - bytes;
Replacement is
	offs = 0;
	while (bytes) {
		copy some
		offs += copied
		bytes -= copied
		if short copy
			break
	}
	bytes = offs;
That wouldn't be a win per se, but unlike the initial value of bytes, the amount
copied so far *is* useful in callbacks.
	3) in some cases (csum_and_copy_..._iter()) we already had offs manually
maintained by the callbacks.  With that change we can drop that.

	Less boilerplate and more readable code...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 120 ++++++++++++++++++++++++---------------------------------
 1 file changed, 50 insertions(+), 70 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 5a871d001e12..14e34f9df490 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -17,15 +17,14 @@
 #define PIPE_PARANOIA /* for now */
 
 /* covers iovec and kvec alike */
-#define iterate_iovec(i, n, __v, __p, skip, STEP) {		\
-	size_t left;						\
-	size_t wanted = n;					\
+#define iterate_iovec(i, n, __v, __off, __p, skip, STEP) {	\
+	size_t __off = 0;					\
 	do {							\
 		__v.iov_len = min(n, __p->iov_len - skip);	\
 		if (likely(__v.iov_len)) {			\
 			__v.iov_base = __p->iov_base + skip;	\
-			left = (STEP);				\
-			__v.iov_len -= left;			\
+			__v.iov_len -= (STEP);			\
+			__off += __v.iov_len;			\
 			skip += __v.iov_len;			\
 			n -= __v.iov_len;			\
 			if (skip < __p->iov_len)		\
@@ -34,11 +33,11 @@
 		__p++;						\
 		skip = 0;					\
 	} while (n);						\
-	n = wanted - n;						\
+	n = __off;						\
 }
 
-#define iterate_bvec(i, n, __v, p, skip, STEP) {		\
-	size_t wanted = n;					\
+#define iterate_bvec(i, n, __v, __off, p, skip, STEP) {		\
+	size_t __off = 0;					\
 	while (n) {						\
 		unsigned offset = p->bv_offset + skip;		\
 		unsigned left;					\
@@ -50,6 +49,7 @@
 		left = (STEP);					\
 		kunmap_local(kaddr);				\
 		__v.iov_len -= left;				\
+		__off += __v.iov_len;				\
 		skip += __v.iov_len;				\
 		if (skip == p->bv_len) {			\
 			skip = 0;				\
@@ -59,13 +59,14 @@
 		if (left)					\
 			break;					\
 	}							\
-	n = wanted - n;						\
+	n = __off;						\
 }
 
-#define iterate_xarray(i, n, __v, skip, STEP) {		\
+#define iterate_xarray(i, n, __v, __off, skip, STEP) {		\
 	__label__ __out;					\
+	size_t __off = 0;					\
 	struct page *head = NULL;				\
-	size_t wanted = n, seg, offset;				\
+	size_t seg, offset;					\
 	loff_t start = i->xarray_start + skip;			\
 	pgoff_t index = start >> PAGE_SHIFT;			\
 	int j;							\
@@ -84,25 +85,26 @@
 		for (j = (head->index < index) ? index - head->index : 0; \
 		     j < thp_nr_pages(head); j++) {			\
 			void *kaddr = kmap_local_page(head + j);	\
-			offset = (i->xarray_start + skip) % PAGE_SIZE;	\
+			offset = (start + __off) % PAGE_SIZE;		\
 			__v.iov_base = kaddr + offset;			\
 			seg = PAGE_SIZE - offset;			\
 			__v.iov_len = min(n, seg);			\
 			left = (STEP);					\
 			kunmap_local(kaddr);				\
 			__v.iov_len -= left;				\
+			__off += __v.iov_len;				\
 			n -= __v.iov_len;				\
-			skip += __v.iov_len;				\
 			if (left || n == 0)				\
 				goto __out;				\
 		}							\
 	}							\
 __out:								\
 	rcu_read_unlock();					\
-	n = wanted - n;						\
+	skip += __off;						\
+	n = __off;						\
 }
 
-#define __iterate_and_advance(i, n, v, I, K) {			\
+#define __iterate_and_advance(i, n, v, off, I, K) {		\
 	if (unlikely(i->count < n))				\
 		n = i->count;					\
 	if (likely(n)) {					\
@@ -110,31 +112,31 @@ __out:								\
 		if (likely(iter_is_iovec(i))) {			\
 			const struct iovec *iov = i->iov;	\
 			struct iovec v;				\
-			iterate_iovec(i, n, v, iov, skip, (I))	\
+			iterate_iovec(i, n, v, off, iov, skip, (I))	\
 			i->nr_segs -= iov - i->iov;		\
 			i->iov = iov;				\
 		} else if (iov_iter_is_bvec(i)) {		\
 			const struct bio_vec *bvec = i->bvec;	\
 			struct kvec v;				\
-			iterate_bvec(i, n, v, bvec, skip, (K))	\
+			iterate_bvec(i, n, v, off, bvec, skip, (K))	\
 			i->nr_segs -= bvec - i->bvec;		\
 			i->bvec = bvec;				\
 		} else if (iov_iter_is_kvec(i)) {		\
 			const struct kvec *kvec = i->kvec;	\
 			struct kvec v;				\
-			iterate_iovec(i, n, v, kvec, skip, (K))	\
+			iterate_iovec(i, n, v, off, kvec, skip, (K))	\
 			i->nr_segs -= kvec - i->kvec;		\
 			i->kvec = kvec;				\
 		} else if (iov_iter_is_xarray(i)) {		\
 			struct kvec v;				\
-			iterate_xarray(i, n, v, skip, (K))	\
+			iterate_xarray(i, n, v, off, skip, (K))	\
 		}						\
 		i->count -= n;					\
 		i->iov_offset = skip;				\
 	}							\
 }
-#define iterate_and_advance(i, n, v, I, K) \
-	__iterate_and_advance(i, n, v, I, ((void)(K),0))
+#define iterate_and_advance(i, n, v, off, I, K) \
+	__iterate_and_advance(i, n, v, off, I, ((void)(K),0))
 
 static int copyout(void __user *to, const void *from, size_t n)
 {
@@ -618,14 +620,13 @@ static size_t csum_and_copy_to_pipe_iter(const void *addr, size_t bytes,
 
 size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 {
-	const char *from = addr;
 	if (unlikely(iov_iter_is_pipe(i)))
 		return copy_pipe_to_iter(addr, bytes, i);
 	if (iter_is_iovec(i))
 		might_fault();
-	iterate_and_advance(i, bytes, v,
-		copyout(v.iov_base, (from += v.iov_len) - v.iov_len, v.iov_len),
-		memcpy(v.iov_base, (from += v.iov_len) - v.iov_len, v.iov_len)
+	iterate_and_advance(i, bytes, v, off,
+		copyout(v.iov_base, addr + off, v.iov_len),
+		memcpy(v.iov_base, addr + off, v.iov_len)
 	)
 
 	return bytes;
@@ -714,17 +715,13 @@ static size_t copy_mc_pipe_to_iter(const void *addr, size_t bytes,
  */
 size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 {
-	const char *from = addr;
-
 	if (unlikely(iov_iter_is_pipe(i)))
 		return copy_mc_pipe_to_iter(addr, bytes, i);
 	if (iter_is_iovec(i))
 		might_fault();
-	__iterate_and_advance(i, bytes, v,
-		copyout_mc(v.iov_base, (from += v.iov_len) - v.iov_len,
-			   v.iov_len),
-		copy_mc_to_kernel(v.iov_base, (from += v.iov_len)
-					- v.iov_len, v.iov_len)
+	__iterate_and_advance(i, bytes, v, off,
+		copyout_mc(v.iov_base, addr + off, v.iov_len),
+		copy_mc_to_kernel(v.iov_base, addr + off, v.iov_len)
 	)
 
 	return bytes;
@@ -734,16 +731,15 @@ EXPORT_SYMBOL_GPL(_copy_mc_to_iter);
 
 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 {
-	char *to = addr;
 	if (unlikely(iov_iter_is_pipe(i))) {
 		WARN_ON(1);
 		return 0;
 	}
 	if (iter_is_iovec(i))
 		might_fault();
-	iterate_and_advance(i, bytes, v,
-		copyin((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
-		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len)
+	iterate_and_advance(i, bytes, v, off,
+		copyin(addr + off, v.iov_base, v.iov_len),
+		memcpy(addr + off, v.iov_base, v.iov_len)
 	)
 
 	return bytes;
@@ -752,15 +748,14 @@ EXPORT_SYMBOL(_copy_from_iter);
 
 size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i)
 {
-	char *to = addr;
 	if (unlikely(iov_iter_is_pipe(i))) {
 		WARN_ON(1);
 		return 0;
 	}
-	iterate_and_advance(i, bytes, v,
-		__copy_from_user_inatomic_nocache((to += v.iov_len) - v.iov_len,
+	iterate_and_advance(i, bytes, v, off,
+		__copy_from_user_inatomic_nocache(addr + off,
 					 v.iov_base, v.iov_len),
-		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len)
+		memcpy(addr + off, v.iov_base, v.iov_len)
 	)
 
 	return bytes;
@@ -784,16 +779,13 @@ EXPORT_SYMBOL(_copy_from_iter_nocache);
  */
 size_t _copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
 {
-	char *to = addr;
 	if (unlikely(iov_iter_is_pipe(i))) {
 		WARN_ON(1);
 		return 0;
 	}
-	iterate_and_advance(i, bytes, v,
-		__copy_from_user_flushcache((to += v.iov_len) - v.iov_len,
-					 v.iov_base, v.iov_len),
-		memcpy_flushcache((to += v.iov_len) - v.iov_len, v.iov_base,
-			v.iov_len)
+	iterate_and_advance(i, bytes, v, off,
+		__copy_from_user_flushcache(addr + off, v.iov_base, v.iov_len),
+		memcpy_flushcache(addr + off, v.iov_base, v.iov_len)
 	)
 
 	return bytes;
@@ -922,7 +914,7 @@ size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
 {
 	if (unlikely(iov_iter_is_pipe(i)))
 		return pipe_zero(bytes, i);
-	iterate_and_advance(i, bytes, v,
+	iterate_and_advance(i, bytes, v, count,
 		clear_user(v.iov_base, v.iov_len),
 		memset(v.iov_base, 0, v.iov_len)
 	)
@@ -944,9 +936,9 @@ size_t copy_page_from_iter_atomic(struct page *page, unsigned offset, size_t byt
 		WARN_ON(1);
 		return 0;
 	}
-	iterate_and_advance(i, bytes, v,
-		copyin((p += v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
-		memcpy((p += v.iov_len) - v.iov_len, v.iov_base, v.iov_len)
+	iterate_and_advance(i, bytes, v, off,
+		copyin(p + off, v.iov_base, v.iov_len),
+		memcpy(p + off, v.iov_base, v.iov_len)
 	)
 	kunmap_atomic(kaddr);
 	return bytes;
@@ -1669,28 +1661,22 @@ EXPORT_SYMBOL(iov_iter_get_pages_alloc);
 size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 			       struct iov_iter *i)
 {
-	char *to = addr;
 	__wsum sum, next;
-	size_t off = 0;
 	sum = *csum;
 	if (unlikely(iov_iter_is_pipe(i) || iov_iter_is_discard(i))) {
 		WARN_ON(1);
 		return 0;
 	}
-	iterate_and_advance(i, bytes, v, ({
+	iterate_and_advance(i, bytes, v, off, ({
 		next = csum_and_copy_from_user(v.iov_base,
-					       (to += v.iov_len) - v.iov_len,
+					       addr + off,
 					       v.iov_len);
-		if (next) {
+		if (next)
 			sum = csum_block_add(sum, next, off);
-			off += v.iov_len;
-		}
 		next ? 0 : v.iov_len;
 	}), ({
-		sum = csum_and_memcpy((to += v.iov_len) - v.iov_len,
-				      v.iov_base, v.iov_len,
+		sum = csum_and_memcpy(addr + off, v.iov_base, v.iov_len,
 				      sum, off);
-		off += v.iov_len;
 	})
 	)
 	*csum = sum;
@@ -1702,33 +1688,27 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *_csstate,
 			     struct iov_iter *i)
 {
 	struct csum_state *csstate = _csstate;
-	const char *from = addr;
 	__wsum sum, next;
-	size_t off;
 
 	if (unlikely(iov_iter_is_pipe(i)))
 		return csum_and_copy_to_pipe_iter(addr, bytes, _csstate, i);
 
 	sum = csum_shift(csstate->csum, csstate->off);
-	off = 0;
 	if (unlikely(iov_iter_is_discard(i))) {
 		WARN_ON(1);	/* for now */
 		return 0;
 	}
-	iterate_and_advance(i, bytes, v, ({
-		next = csum_and_copy_to_user((from += v.iov_len) - v.iov_len,
+	iterate_and_advance(i, bytes, v, off, ({
+		next = csum_and_copy_to_user(addr + off,
 					     v.iov_base,
 					     v.iov_len);
-		if (next) {
+		if (next)
 			sum = csum_block_add(sum, next, off);
-			off += v.iov_len;
-		}
 		next ? 0 : v.iov_len;
 	}), ({
 		sum = csum_and_memcpy(v.iov_base,
-				     (from += v.iov_len) - v.iov_len,
+				     addr + off,
 				     v.iov_len, sum, off);
-		off += v.iov_len;
 	})
 	)
 	csstate->csum = csum_shift(sum, csstate->off);
-- 
2.11.0

