Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D4D39D0A3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhFFTMw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhFFTMn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:12:43 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03168C061795;
        Sun,  6 Jun 2021 12:10:52 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAd-0056ZQ-U4; Sun, 06 Jun 2021 19:10:51 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 10/37] iov_iter: reorder handling of flavours in primitives
Date:   Sun,  6 Jun 2021 19:10:24 +0000
Message-Id: <20210606191051.1216821-10-viro@zeniv.linux.org.uk>
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

iovec is the most common one; test it first and test explicitly,
rather than "not anything else".  Replace all flavour checks with
use of iov_iter_is_...() helpers.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 91 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 45 insertions(+), 46 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index ce9f8b9168ea..bdcf1fbeb2db 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -117,22 +117,21 @@
 #define iterate_all_kinds(i, n, v, I, B, K, X) {		\
 	if (likely(n)) {					\
 		size_t skip = i->iov_offset;			\
-		if (unlikely(i->type & ITER_BVEC)) {		\
+		if (likely(iter_is_iovec(i))) {			\
+			const struct iovec *iov;		\
+			struct iovec v;				\
+			iterate_iovec(i, n, v, iov, skip, (I))	\
+		} else if (iov_iter_is_bvec(i)) {		\
 			struct bio_vec v;			\
 			struct bvec_iter __bi;			\
 			iterate_bvec(i, n, v, __bi, skip, (B))	\
-		} else if (unlikely(i->type & ITER_KVEC)) {	\
+		} else if (iov_iter_is_kvec(i)) {		\
 			const struct kvec *kvec;		\
 			struct kvec v;				\
 			iterate_kvec(i, n, v, kvec, skip, (K))	\
-		} else if (unlikely(i->type & ITER_DISCARD)) {	\
-		} else if (unlikely(i->type & ITER_XARRAY)) {	\
+		} else if (iov_iter_is_xarray(i)) {		\
 			struct bio_vec v;			\
 			iterate_xarray(i, n, v, skip, (X));	\
-		} else {					\
-			const struct iovec *iov;		\
-			struct iovec v;				\
-			iterate_iovec(i, n, v, iov, skip, (I))	\
 		}						\
 	}							\
 }
@@ -142,7 +141,17 @@
 		n = i->count;					\
 	if (i->count) {						\
 		size_t skip = i->iov_offset;			\
-		if (unlikely(i->type & ITER_BVEC)) {		\
+		if (likely(iter_is_iovec(i))) {			\
+			const struct iovec *iov;		\
+			struct iovec v;				\
+			iterate_iovec(i, n, v, iov, skip, (I))	\
+			if (skip == iov->iov_len) {		\
+				iov++;				\
+				skip = 0;			\
+			}					\
+			i->nr_segs -= iov - i->iov;		\
+			i->iov = iov;				\
+		} else if (iov_iter_is_bvec(i)) {		\
 			const struct bio_vec *bvec = i->bvec;	\
 			struct bio_vec v;			\
 			struct bvec_iter __bi;			\
@@ -150,7 +159,7 @@
 			i->bvec = __bvec_iter_bvec(i->bvec, __bi);	\
 			i->nr_segs -= i->bvec - bvec;		\
 			skip = __bi.bi_bvec_done;		\
-		} else if (unlikely(i->type & ITER_KVEC)) {	\
+		} else if (iov_iter_is_kvec(i)) {		\
 			const struct kvec *kvec;		\
 			struct kvec v;				\
 			iterate_kvec(i, n, v, kvec, skip, (K))	\
@@ -160,21 +169,11 @@
 			}					\
 			i->nr_segs -= kvec - i->kvec;		\
 			i->kvec = kvec;				\
-		} else if (unlikely(i->type & ITER_DISCARD)) {	\
-			skip += n;				\
-		} else if (unlikely(i->type & ITER_XARRAY)) {	\
+		} else if (iov_iter_is_xarray(i)) {		\
 			struct bio_vec v;			\
 			iterate_xarray(i, n, v, skip, (X))	\
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
+		} else if (iov_iter_is_discard(i)) {		\
+			skip += n;				\
 		}						\
 		i->count -= n;					\
 		i->iov_offset = skip;				\
@@ -905,20 +904,24 @@ static inline bool page_copy_sane(struct page *page, size_t offset, size_t n)
 static size_t __copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i)
 {
-	if (i->type & (ITER_BVEC | ITER_KVEC | ITER_XARRAY)) {
+	if (likely(iter_is_iovec(i)))
+		return copy_page_to_iter_iovec(page, offset, bytes, i);
+	if (iov_iter_is_bvec(i) || iov_iter_is_kvec(i) || iov_iter_is_xarray(i)) {
 		void *kaddr = kmap_atomic(page);
 		size_t wanted = copy_to_iter(kaddr + offset, bytes, i);
 		kunmap_atomic(kaddr);
 		return wanted;
-	} else if (unlikely(iov_iter_is_discard(i))) {
+	}
+	if (iov_iter_is_pipe(i))
+		return copy_page_to_iter_pipe(page, offset, bytes, i);
+	if (unlikely(iov_iter_is_discard(i))) {
 		if (unlikely(i->count < bytes))
 			bytes = i->count;
 		i->count -= bytes;
 		return bytes;
-	} else if (likely(!iov_iter_is_pipe(i)))
-		return copy_page_to_iter_iovec(page, offset, bytes, i);
-	else
-		return copy_page_to_iter_pipe(page, offset, bytes, i);
+	}
+	WARN_ON(1);
+	return 0;
 }
 
 size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
@@ -951,17 +954,16 @@ size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 {
 	if (unlikely(!page_copy_sane(page, offset, bytes)))
 		return 0;
-	if (unlikely(iov_iter_is_pipe(i) || iov_iter_is_discard(i))) {
-		WARN_ON(1);
-		return 0;
-	}
-	if (i->type & (ITER_BVEC | ITER_KVEC | ITER_XARRAY)) {
+	if (likely(iter_is_iovec(i)))
+		return copy_page_from_iter_iovec(page, offset, bytes, i);
+	if (iov_iter_is_bvec(i) || iov_iter_is_kvec(i) || iov_iter_is_xarray(i)) {
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
 
@@ -1203,16 +1205,13 @@ EXPORT_SYMBOL(iov_iter_revert);
  */
 size_t iov_iter_single_seg_count(const struct iov_iter *i)
 {
-	if (unlikely(iov_iter_is_pipe(i)))
-		return i->count;	// it is a silly place, anyway
-	if (i->nr_segs == 1)
-		return i->count;
-	if (unlikely(iov_iter_is_discard(i) || iov_iter_is_xarray(i)))
-		return i->count;
-	if (iov_iter_is_bvec(i))
-		return min(i->count, i->bvec->bv_len - i->iov_offset);
-	else
-		return min(i->count, i->iov->iov_len - i->iov_offset);
+	if (i->nr_segs > 1) {
+		if (likely(iter_is_iovec(i) || iov_iter_is_kvec(i)))
+			return min(i->count, i->iov->iov_len - i->iov_offset);
+		if (iov_iter_is_bvec(i))
+			return min(i->count, i->bvec->bv_len - i->iov_offset);
+	}
+	return i->count;
 }
 EXPORT_SYMBOL(iov_iter_single_seg_count);
 
-- 
2.11.0

