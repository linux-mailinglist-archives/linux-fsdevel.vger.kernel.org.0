Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4536877E120
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 14:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjHPMJE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 08:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244959AbjHPMIr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:08:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9921E2136
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 05:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692187679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ROhK//9C7npYS4YCKPkIYJubo9kN7OrTey+LSWwnT4=;
        b=dvblIB8YLF+4vHCugyj5QLcNkYrPB0onxNfq1KxFI7HaLTTRzT1klfmTKr6GSE7YA2Vn8k
        k9uDSGpmvy43U0YNWRac2nXgL9trE7trnVX+8sqFBLwlDXvm6D33UzBptFkew/KagtWkep
        MiS9R9Vr7iM8iBeTiEZ6RBpf9abKuAg=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-TlHIBK7IPzKzraEWQSsN4A-1; Wed, 16 Aug 2023 08:07:56 -0400
X-MC-Unique: TlHIBK7IPzKzraEWQSsN4A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 942513801BCE;
        Wed, 16 Aug 2023 12:07:55 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D18C3C15BAD;
        Wed, 16 Aug 2023 12:07:52 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@list.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 1/2] iov_iter: Convert iterate*() to inline funcs
Date:   Wed, 16 Aug 2023 13:07:40 +0100
Message-ID: <20230816120741.534415-2-dhowells@redhat.com>
In-Reply-To: <20230816120741.534415-1-dhowells@redhat.com>
References: <20230816120741.534415-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert the iov_iter iteration macros to inline functions to make the code
easier to follow.

The functions are marked __always_inline as we don't want to end up with
indirect calls in the code.  This, however, leaves dealing with ->copy_mc
in an awkard situation since the step function (memcpy_from_iter_mc())
needs to test the flag in the iterator, but isn't passed the iterator.
This will be dealt with in a follow-up patch.

The variable names in the per-type iterator functions have been harmonised
as much as possible and made clearer as to the variable purpose.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@lst.de>,
cc: Christian Brauner <christian@brauner.io>,
cc: Matthew Wilcox <willy@infradead.org>,
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: David Laight <David.Laight@ACULAB.COM>
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
Link: https://lore.kernel.org/r/3710261.1691764329@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/855.1692047347@warthog.procyon.org.uk/ # v2
---

Notes:
    Changes
    =======
    ver #3)
     - Use min_t(size_t,) not min() to avoid a warning on Hexagon.
     - Inline all the step functions.
    
    ver #2)
     - Rebased on top of Willy's changes in linux-next.
     - Change the checksum argument to the iteration functions to be a general
       void* and use it to pass iter->copy_mc flag to memcpy_from_iter_mc() to
       avoid using a function pointer.
     - Arrange the end of the iterate_*() functions to look the same to give
       the optimiser the best chance.
     - Make iterate_and_advance() a wrapper around iterate_and_advance2().
     - Adjust iterate_and_advance2() to use if-else-if-else-if-else rather than
       switch(), to put ITER_BVEC before KVEC and to mark UBUF and IOVEC as
       likely().
     - Move "iter->count += progress" into iterate_and_advance2() from the
       iterate functions.
     - Mark a number of the iterator helpers with __always_inline.
     - Fix _copy_from_iter_flushcache() to use memcpy_from_iter_flushcache()
       not memcpy_from_iter().

 lib/iov_iter.c | 612 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 371 insertions(+), 241 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 424737045b97..378da0cb3069 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -14,188 +14,264 @@
 #include <linux/scatterlist.h>
 #include <linux/instrumented.h>
 
-/* covers ubuf and kbuf alike */
-#define iterate_buf(i, n, base, len, off, __p, STEP) {		\
-	size_t __maybe_unused off = 0;				\
-	len = n;						\
-	base = __p + i->iov_offset;				\
-	len -= (STEP);						\
-	i->iov_offset += len;					\
-	n = len;						\
-}
-
-/* covers iovec and kvec alike */
-#define iterate_iovec(i, n, base, len, off, __p, STEP) {	\
-	size_t off = 0;						\
-	size_t skip = i->iov_offset;				\
-	do {							\
-		len = min(n, __p->iov_len - skip);		\
-		if (likely(len)) {				\
-			base = __p->iov_base + skip;		\
-			len -= (STEP);				\
-			off += len;				\
-			skip += len;				\
-			n -= len;				\
-			if (skip < __p->iov_len)		\
-				break;				\
-		}						\
-		__p++;						\
-		skip = 0;					\
-	} while (n);						\
-	i->iov_offset = skip;					\
-	n = off;						\
-}
-
-#define iterate_bvec(i, n, base, len, off, p, STEP) {		\
-	size_t off = 0;						\
-	unsigned skip = i->iov_offset;				\
-	while (n) {						\
-		unsigned offset = p->bv_offset + skip;		\
-		unsigned left;					\
-		void *kaddr = kmap_local_page(p->bv_page +	\
-					offset / PAGE_SIZE);	\
-		base = kaddr + offset % PAGE_SIZE;		\
-		len = min(min(n, (size_t)(p->bv_len - skip)),	\
-		     (size_t)(PAGE_SIZE - offset % PAGE_SIZE));	\
-		left = (STEP);					\
-		kunmap_local(kaddr);				\
-		len -= left;					\
-		off += len;					\
-		skip += len;					\
-		if (skip == p->bv_len) {			\
-			skip = 0;				\
-			p++;					\
-		}						\
-		n -= len;					\
-		if (left)					\
-			break;					\
-	}							\
-	i->iov_offset = skip;					\
-	n = off;						\
-}
-
-#define iterate_xarray(i, n, base, len, __off, STEP) {		\
-	__label__ __out;					\
-	size_t __off = 0;					\
-	struct folio *folio;					\
-	loff_t start = i->xarray_start + i->iov_offset;		\
-	pgoff_t index = start / PAGE_SIZE;			\
-	XA_STATE(xas, i->xarray, index);			\
-								\
-	len = PAGE_SIZE - offset_in_page(start);		\
-	rcu_read_lock();					\
-	xas_for_each(&xas, folio, ULONG_MAX) {			\
-		unsigned left;					\
-		size_t offset;					\
-		if (xas_retry(&xas, folio))			\
-			continue;				\
-		if (WARN_ON(xa_is_value(folio)))		\
-			break;					\
-		if (WARN_ON(folio_test_hugetlb(folio)))		\
-			break;					\
-		offset = offset_in_folio(folio, start + __off);	\
-		while (offset < folio_size(folio)) {		\
-			base = kmap_local_folio(folio, offset);	\
-			len = min(n, len);			\
-			left = (STEP);				\
-			kunmap_local(base);			\
-			len -= left;				\
-			__off += len;				\
-			n -= len;				\
-			if (left || n == 0)			\
-				goto __out;			\
-			offset += len;				\
-			len = PAGE_SIZE;			\
-		}						\
-	}							\
-__out:								\
-	rcu_read_unlock();					\
-	i->iov_offset += __off;					\
-	n = __off;						\
-}
-
-#define __iterate_and_advance(i, n, base, len, off, I, K) {	\
-	if (unlikely(i->count < n))				\
-		n = i->count;					\
-	if (likely(n)) {					\
-		if (likely(iter_is_ubuf(i))) {			\
-			void __user *base;			\
-			size_t len;				\
-			iterate_buf(i, n, base, len, off,	\
-						i->ubuf, (I)) 	\
-		} else if (likely(iter_is_iovec(i))) {		\
-			const struct iovec *iov = iter_iov(i);	\
-			void __user *base;			\
-			size_t len;				\
-			iterate_iovec(i, n, base, len, off,	\
-						iov, (I))	\
-			i->nr_segs -= iov - iter_iov(i);	\
-			i->__iov = iov;				\
-		} else if (iov_iter_is_bvec(i)) {		\
-			const struct bio_vec *bvec = i->bvec;	\
-			void *base;				\
-			size_t len;				\
-			iterate_bvec(i, n, base, len, off,	\
-						bvec, (K))	\
-			i->nr_segs -= bvec - i->bvec;		\
-			i->bvec = bvec;				\
-		} else if (iov_iter_is_kvec(i)) {		\
-			const struct kvec *kvec = i->kvec;	\
-			void *base;				\
-			size_t len;				\
-			iterate_iovec(i, n, base, len, off,	\
-						kvec, (K))	\
-			i->nr_segs -= kvec - i->kvec;		\
-			i->kvec = kvec;				\
-		} else if (iov_iter_is_xarray(i)) {		\
-			void *base;				\
-			size_t len;				\
-			iterate_xarray(i, n, base, len, off,	\
-							(K))	\
-		}						\
-		i->count -= n;					\
-	}							\
-}
-#define iterate_and_advance(i, n, base, len, off, I, K) \
-	__iterate_and_advance(i, n, base, len, off, I, ((void)(K),0))
-
-static int copyout(void __user *to, const void *from, size_t n)
+typedef size_t (*iov_step_f)(void *iter_base, size_t progress, size_t len,
+			     void *priv, void *priv2);
+typedef size_t (*iov_ustep_f)(void __user *iter_base, size_t progress, size_t len,
+			      void *priv, void *priv2);
+
+static __always_inline
+size_t iterate_ubuf(struct iov_iter *iter, size_t len, void *priv, void *priv2,
+		    iov_ustep_f step)
 {
-	if (should_fail_usercopy())
-		return n;
-	if (access_ok(to, n)) {
-		instrument_copy_to_user(to, from, n);
-		n = raw_copy_to_user(to, from, n);
+	void __user *base = iter->ubuf;
+	size_t progress = 0, remain;
+
+	remain = step(base + iter->iov_offset, 0, len, priv, priv2);
+	progress = len - remain;
+	iter->iov_offset += progress;
+	return progress;
+}
+
+static __always_inline
+size_t iterate_iovec(struct iov_iter *iter, size_t len, void *priv, void *priv2,
+		     iov_ustep_f step)
+{
+	const struct iovec *p = iter->__iov;
+	size_t progress = 0, skip = iter->iov_offset;
+
+	do {
+		size_t remain, consumed;
+		size_t part = min(len, p->iov_len - skip);
+
+		if (likely(part)) {
+			remain = step(p->iov_base + skip, progress, part, priv, priv2);
+			consumed = part - remain;
+			progress += consumed;
+			skip += consumed;
+			len -= consumed;
+			if (skip < p->iov_len)
+				break;
+		}
+		p++;
+		skip = 0;
+	} while (len);
+
+	iter->__iov = p;
+	iter->nr_segs -= p - iter->__iov;
+	iter->iov_offset = skip;
+	return progress;
+}
+
+static __always_inline
+size_t iterate_kvec(struct iov_iter *iter, size_t len, void *priv, void *priv2,
+		    iov_step_f step)
+{
+	const struct kvec *p = iter->kvec;
+	size_t progress = 0, skip = iter->iov_offset;
+
+	do {
+		size_t remain, consumed;
+		size_t part = min(len, p->iov_len - skip);
+
+		if (likely(part)) {
+			remain = step(p->iov_base + skip, progress, part, priv, priv2);
+			consumed = part - remain;
+			progress += consumed;
+			skip += consumed;
+			len -= consumed;
+			if (skip < p->iov_len)
+				break;
+		}
+		p++;
+		skip = 0;
+	} while (len);
+
+	iter->kvec = p;
+	iter->nr_segs -= p - iter->kvec;
+	iter->iov_offset = skip;
+	return progress;
+}
+
+static __always_inline
+size_t iterate_bvec(struct iov_iter *iter, size_t len, void *priv, void *priv2,
+		    iov_step_f step)
+{
+	const struct bio_vec *p = iter->bvec;
+	size_t progress = 0, skip = iter->iov_offset;
+
+	do {
+		size_t remain, consumed;
+		size_t offset = p->bv_offset + skip, part;
+		void *kaddr = kmap_local_page(p->bv_page + offset / PAGE_SIZE);
+
+		part = min3(len,
+			   (size_t)(p->bv_len - skip),
+			   (size_t)(PAGE_SIZE - offset % PAGE_SIZE));
+		remain = step(kaddr + offset % PAGE_SIZE, progress, part, priv, priv2);
+		kunmap_local(kaddr);
+		consumed = part - remain;
+		len -= consumed;
+		progress += consumed;
+		skip += consumed;
+		if (skip >= p->bv_len) {
+			skip = 0;
+			p++;
+		}
+		if (remain)
+			break;
+	} while (len);
+
+	iter->bvec = p;
+	iter->nr_segs -= p - iter->bvec;
+	iter->iov_offset = skip;
+	return progress;
+}
+
+static __always_inline
+size_t iterate_xarray(struct iov_iter *iter, size_t len, void *priv, void *priv2,
+		      iov_step_f step)
+{
+	struct folio *folio;
+	size_t progress = 0;
+	loff_t start = iter->xarray_start + iter->iov_offset;
+	pgoff_t index = start / PAGE_SIZE;
+	XA_STATE(xas, iter->xarray, index);
+
+	rcu_read_lock();
+	xas_for_each(&xas, folio, ULONG_MAX) {
+		size_t remain, consumed, offset, part, flen;
+
+		if (xas_retry(&xas, folio))
+			continue;
+		if (WARN_ON(xa_is_value(folio)))
+			break;
+		if (WARN_ON(folio_test_hugetlb(folio)))
+			break;
+
+		offset = offset_in_folio(folio, start);
+		flen = min(folio_size(folio) - offset, len);
+		start += flen;
+
+		while (flen) {
+			void *base = kmap_local_folio(folio, offset);
+
+			part = min_t(size_t, flen,
+				     PAGE_SIZE - offset_in_page(offset));
+			remain = step(base, progress, part, priv, priv2);
+			kunmap_local(base);
+
+			consumed = part - remain;
+			progress += consumed;
+			len -= consumed;
+
+			if (remain || len == 0)
+				goto out;
+			flen -= consumed;
+			offset += consumed;
+		}
 	}
-	return n;
+
+out:
+	rcu_read_unlock();
+	iter->iov_offset += progress;
+	return progress;
 }
 
-static int copyout_nofault(void __user *to, const void *from, size_t n)
+static __always_inline
+size_t iterate_and_advance2(struct iov_iter *iter, size_t len, void *priv,
+			    void *priv2, iov_ustep_f ustep, iov_step_f step)
 {
-	long res;
+	size_t progress;
 
+	if (unlikely(iter->count < len))
+		len = iter->count;
+	if (unlikely(!len))
+		return 0;
+
+	if (likely(iter_is_ubuf(iter)))
+		progress = iterate_ubuf(iter, len, priv, priv2, ustep);
+	else if (likely(iter_is_iovec(iter)))
+		progress = iterate_iovec(iter, len, priv, priv2, ustep);
+	else if (iov_iter_is_bvec(iter))
+		progress = iterate_bvec(iter, len, priv, priv2, step);
+	else if (iov_iter_is_kvec(iter))
+		progress = iterate_kvec(iter, len, priv, priv2, step);
+	else if (iov_iter_is_xarray(iter))
+		progress = iterate_xarray(iter, len, priv, priv2, step);
+	else
+		progress = len;
+	iter->count -= progress;
+	return progress;
+}
+
+static __always_inline
+size_t iterate_and_advance(struct iov_iter *iter, size_t len, void *priv,
+			   iov_ustep_f ustep, iov_step_f step)
+{
+	return iterate_and_advance2(iter, len, priv, NULL, ustep, step);
+}
+
+static __always_inline
+size_t copy_to_user_iter(void __user *iter_to, size_t progress,
+			 size_t len, void *from, void *priv2)
+{
 	if (should_fail_usercopy())
-		return n;
+		return len;
+	if (access_ok(iter_to, len)) {
+		from += progress;
+		instrument_copy_to_user(iter_to, from, len);
+		len = raw_copy_to_user(iter_to, from, len);
+	}
+	return len;
+}
 
-	res = copy_to_user_nofault(to, from, n);
+static __always_inline
+size_t copy_to_user_iter_nofault(void __user *iter_to, size_t progress,
+				 size_t len, void *from, void *priv2)
+{
+	ssize_t res;
 
-	return res < 0 ? n : res;
+	if (should_fail_usercopy())
+		return len;
+
+	from += progress;
+	res = copy_to_user_nofault(iter_to, from, len);
+	return res < 0 ? len : res;
 }
 
-static int copyin(void *to, const void __user *from, size_t n)
+static __always_inline
+size_t copy_from_user_iter(void __user *iter_from, size_t progress,
+			   size_t len, void *to, void *priv2)
 {
-	size_t res = n;
+	size_t res = len;
 
 	if (should_fail_usercopy())
-		return n;
-	if (access_ok(from, n)) {
-		instrument_copy_from_user_before(to, from, n);
-		res = raw_copy_from_user(to, from, n);
-		instrument_copy_from_user_after(to, from, n, res);
+		return len;
+	if (access_ok(iter_from, len)) {
+		to += progress;
+		instrument_copy_from_user_before(to, iter_from, len);
+		res = raw_copy_from_user(to, iter_from, len);
+		instrument_copy_from_user_after(to, iter_from, len, res);
 	}
 	return res;
 }
 
+static __always_inline
+size_t memcpy_to_iter(void *iter_to, size_t progress,
+		      size_t len, void *from, void *priv2)
+{
+	memcpy(iter_to, from + progress, len);
+	return 0;
+}
+
+static __always_inline
+size_t memcpy_from_iter(void *iter_from, size_t progress,
+			size_t len, void *to, void *priv2)
+{
+	memcpy(to + progress, iter_from, len);
+	return 0;
+}
+
 /*
  * fault_in_iov_iter_readable - fault in iov iterator for reading
  * @i: iterator
@@ -313,23 +389,29 @@ size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 		return 0;
 	if (user_backed_iter(i))
 		might_fault();
-	iterate_and_advance(i, bytes, base, len, off,
-		copyout(base, addr + off, len),
-		memcpy(base, addr + off, len)
-	)
-
-	return bytes;
+	return iterate_and_advance(i, bytes, (void *)addr,
+				   copy_to_user_iter, memcpy_to_iter);
 }
 EXPORT_SYMBOL(_copy_to_iter);
 
 #ifdef CONFIG_ARCH_HAS_COPY_MC
-static int copyout_mc(void __user *to, const void *from, size_t n)
-{
-	if (access_ok(to, n)) {
-		instrument_copy_to_user(to, from, n);
-		n = copy_mc_to_user((__force void *) to, from, n);
+static __always_inline
+size_t copy_to_user_iter_mc(void __user *iter_to, size_t progress,
+			    size_t len, void *from, void *priv2)
+{
+	if (access_ok(iter_to, len)) {
+		from += progress;
+		instrument_copy_to_user(iter_to, from, len);
+		len = copy_mc_to_user(iter_to, from, len);
 	}
-	return n;
+	return len;
+}
+
+static __always_inline
+size_t memcpy_to_iter_mc(void *iter_to, size_t progress,
+			 size_t len, void *from, void *priv2)
+{
+	return copy_mc_to_kernel(iter_to, from + progress, len);
 }
 
 /**
@@ -362,22 +444,20 @@ size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 		return 0;
 	if (user_backed_iter(i))
 		might_fault();
-	__iterate_and_advance(i, bytes, base, len, off,
-		copyout_mc(base, addr + off, len),
-		copy_mc_to_kernel(base, addr + off, len)
-	)
-
-	return bytes;
+	return iterate_and_advance(i, bytes, (void *)addr,
+				   copy_to_user_iter_mc, memcpy_to_iter_mc);
 }
 EXPORT_SYMBOL_GPL(_copy_mc_to_iter);
 #endif /* CONFIG_ARCH_HAS_COPY_MC */
 
-static void *memcpy_from_iter(struct iov_iter *i, void *to, const void *from,
-				 size_t size)
+static size_t memcpy_from_iter_mc(void *iter_from, size_t progress,
+				  size_t len, void *to, void *priv2)
 {
-	if (iov_iter_is_copy_mc(i))
-		return (void *)copy_mc_to_kernel(to, from, size);
-	return memcpy(to, from, size);
+	struct iov_iter *iter = priv2;
+
+	if (iov_iter_is_copy_mc(iter))
+		return copy_mc_to_kernel(to + progress, iter_from, len);
+	return memcpy_from_iter(iter_from, progress, len, to, priv2);
 }
 
 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
@@ -387,30 +467,46 @@ size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 
 	if (user_backed_iter(i))
 		might_fault();
-	iterate_and_advance(i, bytes, base, len, off,
-		copyin(addr + off, base, len),
-		memcpy_from_iter(i, addr + off, base, len)
-	)
-
-	return bytes;
+	return iterate_and_advance2(i, bytes, addr, i,
+				    copy_from_user_iter,
+				    memcpy_from_iter_mc);
 }
 EXPORT_SYMBOL(_copy_from_iter);
 
+static __always_inline
+size_t copy_from_user_iter_nocache(void __user *iter_from, size_t progress,
+				   size_t len, void *to, void *priv2)
+{
+	return __copy_from_user_inatomic_nocache(to + progress, iter_from, len);
+}
+
 size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i)
 {
 	if (WARN_ON_ONCE(!i->data_source))
 		return 0;
 
-	iterate_and_advance(i, bytes, base, len, off,
-		__copy_from_user_inatomic_nocache(addr + off, base, len),
-		memcpy(addr + off, base, len)
-	)
-
-	return bytes;
+	return iterate_and_advance(i, bytes, addr,
+				   copy_from_user_iter_nocache,
+				   memcpy_from_iter);
 }
 EXPORT_SYMBOL(_copy_from_iter_nocache);
 
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
+static __always_inline
+size_t copy_from_user_iter_flushcache(void __user *iter_from, size_t progress,
+				      size_t len, void *to, void *priv2)
+{
+	return __copy_from_user_flushcache(to + progress, iter_from, len);
+}
+
+static __always_inline
+size_t memcpy_from_iter_flushcache(void *iter_from, size_t progress,
+				   size_t len, void *to, void *priv2)
+{
+	memcpy_flushcache(to + progress, iter_from, len);
+	return 0;
+}
+
 /**
  * _copy_from_iter_flushcache - write destination through cpu cache
  * @addr: destination kernel address
@@ -432,12 +528,9 @@ size_t _copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
 	if (WARN_ON_ONCE(!i->data_source))
 		return 0;
 
-	iterate_and_advance(i, bytes, base, len, off,
-		__copy_from_user_flushcache(addr + off, base, len),
-		memcpy_flushcache(addr + off, base, len)
-	)
-
-	return bytes;
+	return iterate_and_advance(i, bytes, addr,
+				   copy_from_user_iter_flushcache,
+				   memcpy_from_iter_flushcache);
 }
 EXPORT_SYMBOL_GPL(_copy_from_iter_flushcache);
 #endif
@@ -509,10 +602,9 @@ size_t copy_page_to_iter_nofault(struct page *page, unsigned offset, size_t byte
 		void *kaddr = kmap_local_page(page);
 		size_t n = min(bytes, (size_t)PAGE_SIZE - offset);
 
-		iterate_and_advance(i, n, base, len, off,
-			copyout_nofault(base, kaddr + offset + off, len),
-			memcpy(base, kaddr + offset + off, len)
-		)
+		n = iterate_and_advance(i, bytes, kaddr,
+					copy_to_user_iter_nofault,
+					memcpy_to_iter);
 		kunmap_local(kaddr);
 		res += n;
 		bytes -= n;
@@ -555,14 +647,25 @@ size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 }
 EXPORT_SYMBOL(copy_page_from_iter);
 
-size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
+static __always_inline
+size_t zero_to_user_iter(void __user *iter_to, size_t progress,
+			 size_t len, void *priv, void *priv2)
 {
-	iterate_and_advance(i, bytes, base, len, count,
-		clear_user(base, len),
-		memset(base, 0, len)
-	)
+	return clear_user(iter_to, len);
+}
 
-	return bytes;
+static __always_inline
+size_t zero_to_iter(void *iter_to, size_t progress,
+		    size_t len, void *priv, void *priv2)
+{
+	memset(iter_to, 0, len);
+	return 0;
+}
+
+size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
+{
+	return iterate_and_advance(i, bytes, NULL,
+				   zero_to_user_iter, zero_to_iter);
 }
 EXPORT_SYMBOL(iov_iter_zero);
 
@@ -587,10 +690,9 @@ size_t copy_page_from_iter_atomic(struct page *page, size_t offset,
 		}
 
 		p = kmap_atomic(page) + offset;
-		iterate_and_advance(i, n, base, len, off,
-			copyin(p + off, base, len),
-			memcpy_from_iter(i, p + off, base, len)
-		)
+		n = iterate_and_advance2(i, n, p, i,
+					 copy_from_user_iter,
+					 memcpy_from_iter_mc);
 		kunmap_atomic(p);
 		copied += n;
 		offset += n;
@@ -1181,32 +1283,64 @@ ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
 }
 EXPORT_SYMBOL(iov_iter_get_pages_alloc2);
 
+static __always_inline
+size_t copy_from_user_iter_csum(void __user *iter_from, size_t progress,
+				size_t len, void *to, void *priv2)
+{
+	__wsum next, *csum = priv2;
+
+	next = csum_and_copy_from_user(iter_from, to + progress, len);
+	*csum = csum_block_add(*csum, next, progress);
+	return next ? 0 : len;
+}
+
+static __always_inline
+size_t memcpy_from_iter_csum(void *iter_from, size_t progress,
+			     size_t len, void *to, void *priv2)
+{
+	__wsum *csum = priv2;
+
+	*csum = csum_and_memcpy(to + progress, iter_from, len, *csum, progress);
+	return 0;
+}
+
 size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 			       struct iov_iter *i)
 {
-	__wsum sum, next;
-	sum = *csum;
 	if (WARN_ON_ONCE(!i->data_source))
 		return 0;
-
-	iterate_and_advance(i, bytes, base, len, off, ({
-		next = csum_and_copy_from_user(base, addr + off, len);
-		sum = csum_block_add(sum, next, off);
-		next ? 0 : len;
-	}), ({
-		sum = csum_and_memcpy(addr + off, base, len, sum, off);
-	})
-	)
-	*csum = sum;
-	return bytes;
+	return iterate_and_advance2(i, bytes, addr, csum,
+				    copy_from_user_iter_csum,
+				    memcpy_from_iter_csum);
 }
 EXPORT_SYMBOL(csum_and_copy_from_iter);
 
+static __always_inline
+size_t copy_to_user_iter_csum(void __user *iter_to, size_t progress,
+			      size_t len, void *from, void *priv2)
+{
+	__wsum next, *csum = priv2;
+
+	next = csum_and_copy_to_user(from + progress, iter_to, len);
+	*csum = csum_block_add(*csum, next, progress);
+	return next ? 0 : len;
+}
+
+static __always_inline
+size_t memcpy_to_iter_csum(void *iter_to, size_t progress,
+			   size_t len, void *from, void *priv2)
+{
+	__wsum *csum = priv2;
+
+	*csum = csum_and_memcpy(iter_to, from + progress, len, *csum, progress);
+	return 0;
+}
+
 size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *_csstate,
 			     struct iov_iter *i)
 {
 	struct csum_state *csstate = _csstate;
-	__wsum sum, next;
+	__wsum sum;
 
 	if (WARN_ON_ONCE(i->data_source))
 		return 0;
@@ -1220,14 +1354,10 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *_csstate,
 	}
 
 	sum = csum_shift(csstate->csum, csstate->off);
-	iterate_and_advance(i, bytes, base, len, off, ({
-		next = csum_and_copy_to_user(addr + off, base, len);
-		sum = csum_block_add(sum, next, off);
-		next ? 0 : len;
-	}), ({
-		sum = csum_and_memcpy(base, addr + off, len, sum, off);
-	})
-	)
+	
+	bytes = iterate_and_advance2(i, bytes, (void *)addr, &sum,
+				     copy_to_user_iter_csum,
+				     memcpy_to_iter_csum);
 	csstate->csum = csum_shift(sum, csstate->off);
 	csstate->off += bytes;
 	return bytes;

