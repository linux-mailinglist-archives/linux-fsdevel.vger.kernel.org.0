Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0CD39D0AD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhFFTNB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhFFTMq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:12:46 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEC2C0617A6;
        Sun,  6 Jun 2021 12:10:55 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAg-0056bj-Qr; Sun, 06 Jun 2021 19:10:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 27/37] iov_iter: get rid of separate bvec and xarray callbacks
Date:   Sun,  6 Jun 2021 19:10:41 +0000
Message-Id: <20210606191051.1216821-27-viro@zeniv.linux.org.uk>
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

After the previous commit we have
	* xarray and bvec callbacks idential in all cases
	* both equivalent to kvec callback wrapped into
kmap_local_page()/kunmap_local() pair.

So we can pass only two (iovec and kvec) callbacks to
iterate_and_advance() and let iterate_{bvec,xarray} wrap
it into kmap_local_page()/kunmap_local_page().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 112 ++++++++++++++++-----------------------------------------
 1 file changed, 30 insertions(+), 82 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 9dc36deddb68..5a871d001e12 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -42,18 +42,20 @@
 	while (n) {						\
 		unsigned offset = p->bv_offset + skip;		\
 		unsigned left;					\
-		__v.bv_offset = offset % PAGE_SIZE;		\
-		__v.bv_page = p->bv_page + offset / PAGE_SIZE;	\
-		__v.bv_len = min(min(n, p->bv_len - skip),	\
+		void *kaddr = kmap_local_page(p->bv_page +	\
+					offset / PAGE_SIZE);	\
+		__v.iov_base = kaddr + offset % PAGE_SIZE;	\
+		__v.iov_len = min(min(n, p->bv_len - skip),	\
 		     (size_t)(PAGE_SIZE - offset % PAGE_SIZE));	\
 		left = (STEP);					\
-		__v.bv_len -= left;				\
-		skip += __v.bv_len;				\
+		kunmap_local(kaddr);				\
+		__v.iov_len -= left;				\
+		skip += __v.iov_len;				\
 		if (skip == p->bv_len) {			\
 			skip = 0;				\
 			p++;					\
 		}						\
-		n -= __v.bv_len;				\
+		n -= __v.iov_len;				\
 		if (left)					\
 			break;					\
 	}							\
@@ -81,15 +83,16 @@
 			break;						\
 		for (j = (head->index < index) ? index - head->index : 0; \
 		     j < thp_nr_pages(head); j++) {			\
-			__v.bv_page = head + j;				\
-			offset = (i->xarray_start + skip) & ~PAGE_MASK;	\
+			void *kaddr = kmap_local_page(head + j);	\
+			offset = (i->xarray_start + skip) % PAGE_SIZE;	\
+			__v.iov_base = kaddr + offset;			\
 			seg = PAGE_SIZE - offset;			\
-			__v.bv_offset = offset;				\
-			__v.bv_len = min(n, seg);			\
+			__v.iov_len = min(n, seg);			\
 			left = (STEP);					\
-			__v.bv_len -= left;				\
-			n -= __v.bv_len;				\
-			skip += __v.bv_len;				\
+			kunmap_local(kaddr);				\
+			__v.iov_len -= left;				\
+			n -= __v.iov_len;				\
+			skip += __v.iov_len;				\
 			if (left || n == 0)				\
 				goto __out;				\
 		}							\
@@ -99,7 +102,7 @@ __out:								\
 	n = wanted - n;						\
 }
 
-#define __iterate_and_advance(i, n, v, I, B, K, X) {		\
+#define __iterate_and_advance(i, n, v, I, K) {			\
 	if (unlikely(i->count < n))				\
 		n = i->count;					\
 	if (likely(n)) {					\
@@ -112,8 +115,8 @@ __out:								\
 			i->iov = iov;				\
 		} else if (iov_iter_is_bvec(i)) {		\
 			const struct bio_vec *bvec = i->bvec;	\
-			struct bio_vec v;			\
-			iterate_bvec(i, n, v, bvec, skip, (B))	\
+			struct kvec v;				\
+			iterate_bvec(i, n, v, bvec, skip, (K))	\
 			i->nr_segs -= bvec - i->bvec;		\
 			i->bvec = bvec;				\
 		} else if (iov_iter_is_kvec(i)) {		\
@@ -123,16 +126,15 @@ __out:								\
 			i->nr_segs -= kvec - i->kvec;		\
 			i->kvec = kvec;				\
 		} else if (iov_iter_is_xarray(i)) {		\
-			struct bio_vec v;			\
-			iterate_xarray(i, n, v, skip, (X))	\
+			struct kvec v;				\
+			iterate_xarray(i, n, v, skip, (K))	\
 		}						\
 		i->count -= n;					\
 		i->iov_offset = skip;				\
 	}							\
 }
-#define iterate_and_advance(i, n, v, I, B, K, X) \
-	__iterate_and_advance(i, n, v, I, ((void)(B),0),	\
-				((void)(K),0), ((void)(X),0))
+#define iterate_and_advance(i, n, v, I, K) \
+	__iterate_and_advance(i, n, v, I, ((void)(K),0))
 
 static int copyout(void __user *to, const void *from, size_t n)
 {
@@ -623,11 +625,7 @@ size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 		might_fault();
 	iterate_and_advance(i, bytes, v,
 		copyout(v.iov_base, (from += v.iov_len) - v.iov_len, v.iov_len),
-		memcpy_to_page(v.bv_page, v.bv_offset,
-			       (from += v.bv_len) - v.bv_len, v.bv_len),
-		memcpy(v.iov_base, (from += v.iov_len) - v.iov_len, v.iov_len),
-		memcpy_to_page(v.bv_page, v.bv_offset,
-			       (from += v.bv_len) - v.bv_len, v.bv_len)
+		memcpy(v.iov_base, (from += v.iov_len) - v.iov_len, v.iov_len)
 	)
 
 	return bytes;
@@ -725,12 +723,8 @@ size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 	__iterate_and_advance(i, bytes, v,
 		copyout_mc(v.iov_base, (from += v.iov_len) - v.iov_len,
 			   v.iov_len),
-		copy_mc_to_page(v.bv_page, v.bv_offset,
-				      (from += v.bv_len) - v.bv_len, v.bv_len),
 		copy_mc_to_kernel(v.iov_base, (from += v.iov_len)
-					- v.iov_len, v.iov_len),
-		copy_mc_to_page(v.bv_page, v.bv_offset,
-				      (from += v.bv_len) - v.bv_len, v.bv_len)
+					- v.iov_len, v.iov_len)
 	)
 
 	return bytes;
@@ -749,11 +743,7 @@ size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 		might_fault();
 	iterate_and_advance(i, bytes, v,
 		copyin((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
-		memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
-				 v.bv_offset, v.bv_len),
-		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
-		memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
-				 v.bv_offset, v.bv_len)
+		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len)
 	)
 
 	return bytes;
@@ -770,11 +760,7 @@ size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i)
 	iterate_and_advance(i, bytes, v,
 		__copy_from_user_inatomic_nocache((to += v.iov_len) - v.iov_len,
 					 v.iov_base, v.iov_len),
-		memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
-				 v.bv_offset, v.bv_len),
-		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
-		memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
-				 v.bv_offset, v.bv_len)
+		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len)
 	)
 
 	return bytes;
@@ -806,12 +792,8 @@ size_t _copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
 	iterate_and_advance(i, bytes, v,
 		__copy_from_user_flushcache((to += v.iov_len) - v.iov_len,
 					 v.iov_base, v.iov_len),
-		memcpy_page_flushcache((to += v.bv_len) - v.bv_len, v.bv_page,
-				 v.bv_offset, v.bv_len),
 		memcpy_flushcache((to += v.iov_len) - v.iov_len, v.iov_base,
-			v.iov_len),
-		memcpy_page_flushcache((to += v.bv_len) - v.bv_len, v.bv_page,
-				 v.bv_offset, v.bv_len)
+			v.iov_len)
 	)
 
 	return bytes;
@@ -942,9 +924,7 @@ size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
 		return pipe_zero(bytes, i);
 	iterate_and_advance(i, bytes, v,
 		clear_user(v.iov_base, v.iov_len),
-		memzero_page(v.bv_page, v.bv_offset, v.bv_len),
-		memset(v.iov_base, 0, v.iov_len),
-		memzero_page(v.bv_page, v.bv_offset, v.bv_len)
+		memset(v.iov_base, 0, v.iov_len)
 	)
 
 	return bytes;
@@ -966,11 +946,7 @@ size_t copy_page_from_iter_atomic(struct page *page, unsigned offset, size_t byt
 	}
 	iterate_and_advance(i, bytes, v,
 		copyin((p += v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
-		memcpy_from_page((p += v.bv_len) - v.bv_len, v.bv_page,
-				 v.bv_offset, v.bv_len),
-		memcpy((p += v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
-		memcpy_from_page((p += v.bv_len) - v.bv_len, v.bv_page,
-				 v.bv_offset, v.bv_len)
+		memcpy((p += v.iov_len) - v.iov_len, v.iov_base, v.iov_len)
 	)
 	kunmap_atomic(kaddr);
 	return bytes;
@@ -1711,24 +1687,10 @@ size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 		}
 		next ? 0 : v.iov_len;
 	}), ({
-		char *p = kmap_atomic(v.bv_page);
-		sum = csum_and_memcpy((to += v.bv_len) - v.bv_len,
-				      p + v.bv_offset, v.bv_len,
-				      sum, off);
-		kunmap_atomic(p);
-		off += v.bv_len;
-	}),({
 		sum = csum_and_memcpy((to += v.iov_len) - v.iov_len,
 				      v.iov_base, v.iov_len,
 				      sum, off);
 		off += v.iov_len;
-	}), ({
-		char *p = kmap_atomic(v.bv_page);
-		sum = csum_and_memcpy((to += v.bv_len) - v.bv_len,
-				      p + v.bv_offset, v.bv_len,
-				      sum, off);
-		kunmap_atomic(p);
-		off += v.bv_len;
 	})
 	)
 	*csum = sum;
@@ -1763,24 +1725,10 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *_csstate,
 		}
 		next ? 0 : v.iov_len;
 	}), ({
-		char *p = kmap_atomic(v.bv_page);
-		sum = csum_and_memcpy(p + v.bv_offset,
-				      (from += v.bv_len) - v.bv_len,
-				      v.bv_len, sum, off);
-		kunmap_atomic(p);
-		off += v.bv_len;
-	}),({
 		sum = csum_and_memcpy(v.iov_base,
 				     (from += v.iov_len) - v.iov_len,
 				     v.iov_len, sum, off);
 		off += v.iov_len;
-	}), ({
-		char *p = kmap_atomic(v.bv_page);
-		sum = csum_and_memcpy(p + v.bv_offset,
-				      (from += v.bv_len) - v.bv_len,
-				      v.bv_len, sum, off);
-		kunmap_atomic(p);
-		off += v.bv_len;
 	})
 	)
 	csstate->csum = csum_shift(sum, csstate->off);
-- 
2.11.0

