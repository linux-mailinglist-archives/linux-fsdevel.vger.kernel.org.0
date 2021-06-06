Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E916F39D0B3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhFFTNI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhFFTMq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:12:46 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA05C0613A3;
        Sun,  6 Jun 2021 12:10:56 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAg-0056bd-Md; Sun, 06 Jun 2021 19:10:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 26/37] iov_iter: teach iterate_{bvec,xarray}() about possible short copies
Date:   Sun,  6 Jun 2021 19:10:40 +0000
Message-Id: <20210606191051.1216821-26-viro@zeniv.linux.org.uk>
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

... and now we finally can sort out the mess in _copy_mc_to_iter().
Provide a variant of iterate_and_advance() that does *NOT* ignore
the return values of bvec, xarray and kvec callbacks, use that in
_copy_mc_to_iter().  That gets rid of magic in those callbacks -
we used to need it so we'd get at least the right return value in
case of failure halfway through.

As a bonus, now iterator is advanced by the amount actually copied
for all flavours.  That's what the callers expect and it used to do that
correctly in iovec and xarray cases.  However, in kvec and bvec cases
the iterator had not been advanced on such failures, breaking the users.
Fixed now...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 65 ++++++++++++++++++++++------------------------------------
 1 file changed, 24 insertions(+), 41 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index af9525c21c77..9dc36deddb68 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -41,22 +41,27 @@
 	size_t wanted = n;					\
 	while (n) {						\
 		unsigned offset = p->bv_offset + skip;		\
+		unsigned left;					\
 		__v.bv_offset = offset % PAGE_SIZE;		\
 		__v.bv_page = p->bv_page + offset / PAGE_SIZE;	\
 		__v.bv_len = min(min(n, p->bv_len - skip),	\
 		     (size_t)(PAGE_SIZE - offset % PAGE_SIZE));	\
-		(void)(STEP);					\
+		left = (STEP);					\
+		__v.bv_len -= left;				\
 		skip += __v.bv_len;				\
 		if (skip == p->bv_len) {			\
 			skip = 0;				\
 			p++;					\
 		}						\
 		n -= __v.bv_len;				\
+		if (left)					\
+			break;					\
 	}							\
 	n = wanted - n;						\
 }
 
 #define iterate_xarray(i, n, __v, skip, STEP) {		\
+	__label__ __out;					\
 	struct page *head = NULL;				\
 	size_t wanted = n, seg, offset;				\
 	loff_t start = i->xarray_start + skip;			\
@@ -67,6 +72,7 @@
 								\
 	rcu_read_lock();						\
 	xas_for_each(&xas, head, ULONG_MAX) {				\
+		unsigned left;						\
 		if (xas_retry(&xas, head))				\
 			continue;					\
 		if (WARN_ON(xa_is_value(head)))				\
@@ -80,20 +86,20 @@
 			seg = PAGE_SIZE - offset;			\
 			__v.bv_offset = offset;				\
 			__v.bv_len = min(n, seg);			\
-			(void)(STEP);					\
+			left = (STEP);					\
+			__v.bv_len -= left;				\
 			n -= __v.bv_len;				\
 			skip += __v.bv_len;				\
-			if (n == 0)					\
-				break;					\
+			if (left || n == 0)				\
+				goto __out;				\
 		}							\
-		if (n == 0)						\
-			break;						\
 	}							\
+__out:								\
 	rcu_read_unlock();					\
 	n = wanted - n;						\
 }
 
-#define iterate_and_advance(i, n, v, I, B, K, X) {		\
+#define __iterate_and_advance(i, n, v, I, B, K, X) {		\
 	if (unlikely(i->count < n))				\
 		n = i->count;					\
 	if (likely(n)) {					\
@@ -113,8 +119,7 @@
 		} else if (iov_iter_is_kvec(i)) {		\
 			const struct kvec *kvec = i->kvec;	\
 			struct kvec v;				\
-			iterate_iovec(i, n, v, kvec, skip,	\
-						((void)(K),0))	\
+			iterate_iovec(i, n, v, kvec, skip, (K))	\
 			i->nr_segs -= kvec - i->kvec;		\
 			i->kvec = kvec;				\
 		} else if (iov_iter_is_xarray(i)) {		\
@@ -125,6 +130,9 @@
 		i->iov_offset = skip;				\
 	}							\
 }
+#define iterate_and_advance(i, n, v, I, B, K, X) \
+	__iterate_and_advance(i, n, v, I, ((void)(B),0),	\
+				((void)(K),0), ((void)(X),0))
 
 static int copyout(void __user *to, const void *from, size_t n)
 {
@@ -709,45 +717,20 @@ static size_t copy_mc_pipe_to_iter(const void *addr, size_t bytes,
 size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 {
 	const char *from = addr;
-	unsigned long rem, curr_addr, s_addr = (unsigned long) addr;
 
 	if (unlikely(iov_iter_is_pipe(i)))
 		return copy_mc_pipe_to_iter(addr, bytes, i);
 	if (iter_is_iovec(i))
 		might_fault();
-	iterate_and_advance(i, bytes, v,
+	__iterate_and_advance(i, bytes, v,
 		copyout_mc(v.iov_base, (from += v.iov_len) - v.iov_len,
 			   v.iov_len),
-		({
-		rem = copy_mc_to_page(v.bv_page, v.bv_offset,
-				      (from += v.bv_len) - v.bv_len, v.bv_len);
-		if (rem) {
-			curr_addr = (unsigned long) from;
-			bytes = curr_addr - s_addr - rem;
-			return bytes;
-		}
-		}),
-		({
-		rem = copy_mc_to_kernel(v.iov_base, (from += v.iov_len)
-					- v.iov_len, v.iov_len);
-		if (rem) {
-			curr_addr = (unsigned long) from;
-			bytes = curr_addr - s_addr - rem;
-			return bytes;
-		}
-		}),
-		({
-		rem = copy_mc_to_page(v.bv_page, v.bv_offset,
-				      (from += v.bv_len) - v.bv_len, v.bv_len);
-		if (rem) {
-			curr_addr = (unsigned long) from;
-			bytes = curr_addr - s_addr - rem;
-			rcu_read_unlock();
-			i->iov_offset += bytes;
-			i->count -= bytes;
-			return bytes;
-		}
-		})
+		copy_mc_to_page(v.bv_page, v.bv_offset,
+				      (from += v.bv_len) - v.bv_len, v.bv_len),
+		copy_mc_to_kernel(v.iov_base, (from += v.iov_len)
+					- v.iov_len, v.iov_len),
+		copy_mc_to_page(v.bv_page, v.bv_offset,
+				      (from += v.bv_len) - v.bv_len, v.bv_len)
 	)
 
 	return bytes;
-- 
2.11.0

