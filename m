Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75109779207
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 16:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbjHKOk4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 10:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbjHKOkz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:40:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCEC2728
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 07:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691764807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=u98Q9/3PNuqfp+7F3WU3X/c/FDaKth2LMUF/uwnHzpM=;
        b=doC1b6lsvDFJR32z5FYYBNWge7SelSra/a9/QqLGw1EFHEdJM0eMZjT5sTAgzqMaehIsH9
        nw7WSSjln9QmWqV442DGO/XYOKSIpMqlRXxO+0EfZb8LpXXmFoVig9WbcBk7Hr5FiOV6+F
        OmXT9nQMl1Is2y3xrXlwIuGKCfVOJEw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-v2GgarISMtWvDjCxmikj-g-1; Fri, 11 Aug 2023 10:34:43 -0400
X-MC-Unique: v2GgarISMtWvDjCxmikj-g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 432B785C715;
        Fri, 11 Aug 2023 14:32:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D3891121314;
        Fri, 11 Aug 2023 14:32:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
cc:     dhowells@redhat.com, jlayton@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] iov_iter: Convert iterate*() to inline funcs
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3710260.1691764329.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 11 Aug 2023 15:32:09 +0100
Message-ID: <3710261.1691764329@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert the iov_iter iteration macros to inline functions to make the code
easier to follow.  Ideally, the optimiser would produce much the same code
in both cases, but the revised code ends up a bit bigger.  This may be
because I'm passing in a pointer to somewhere to place the checksum for
those functions that need it - it could instead be passed in the private
information.

The changes in compiled function size on x86_64 look like:

	_copy_from_iter                          chg 0x36e -> 0x401
	_copy_from_iter_flushcache               chg 0x359 -> 0x374
	_copy_from_iter_nocache                  chg 0x36a -> 0x37f
	_copy_mc_to_iter                         chg 0x3a7 -> 0x3be
	_copy_to_iter                            chg 0x358 -> 0x362
	copy_from_user_iter.constprop.0          new 0x32
	copy_page_from_iter_atomic               chg 0x3d2 -> 0x465
	copy_page_to_iter_nofault.part.0         chg 0x3f1 -> 0x3fe
	copy_to_user_iter.constprop.0            new 0x32
	copy_to_user_iter_mc.constprop.0         new 0x2c
	copyin                                   del 0x30
	copyout                                  del 0x2d
	copyout_mc                               del 0x2b
	csum_and_copy_from_iter                  chg 0x3e8 -> 0x44d
	csum_and_copy_to_iter                    chg 0x46a -> 0x48d
	iov_iter_zero                            chg 0x34f -> 0x36b
	memcpy_from_iter                         new 0x19
	memcpy_from_iter.isra.0                  del 0x1f
	memcpy_from_iter_csum                    new 0x22
	memcpy_from_iter_mc                      new 0xf
	memcpy_to_iter_csum                      new 0x1f
	zero_to_user_iter.part.0                 new 0x18

with the .text section increasing by nearly 700 bytes overall.  Removing
the __always_inline tag from iterate_xarray() reduces the text size by ove=
r
2KiB.  That might be worth doing as that's quite an involved algorithm
requiring the RCU lock be taken and doing a bunch of xarray things.

Removing all the __always_inline tags shrinks the text by over 7.5KIB.  I'=
m
not sure of the performance impact of doing that, though.  Jens: I believe
you had a good way of testing the performance?

	"Here's what I get. nullb0 using blk-mq, and submit_queues=3D=3DNPROC.
	iostats and merging disabled, using 8k bs for t/io_uring to ensure we
	have > 1 segment. Everything pinned to the same CPU to ensure
	reproducibility and stability. Kernel has CONFIG_RETPOLINE enabled."

Can you give me a quick crib as to how I set that up?

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@lst.de>,
cc: Christian Brauner <christian@brauner.io>,
cc: Matthew Wilcox <willy@infradead.org>,
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 lib/iov_iter.c |  606 ++++++++++++++++++++++++++++++++++-----------------=
------
 1 file changed, 366 insertions(+), 240 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index b667b1e2f688..8943ac25e202 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -14,188 +14,283 @@
 #include <linux/scatterlist.h>
 #include <linux/instrumented.h>
 =

-/* covers ubuf and kbuf alike */
-#define iterate_buf(i, n, base, len, off, __p, STEP) {		\
-	size_t __maybe_unused off =3D 0;				\
-	len =3D n;						\
-	base =3D __p + i->iov_offset;				\
-	len -=3D (STEP);						\
-	i->iov_offset +=3D len;					\
-	n =3D len;						\
-}
-
-/* covers iovec and kvec alike */
-#define iterate_iovec(i, n, base, len, off, __p, STEP) {	\
-	size_t off =3D 0;						\
-	size_t skip =3D i->iov_offset;				\
-	do {							\
-		len =3D min(n, __p->iov_len - skip);		\
-		if (likely(len)) {				\
-			base =3D __p->iov_base + skip;		\
-			len -=3D (STEP);				\
-			off +=3D len;				\
-			skip +=3D len;				\
-			n -=3D len;				\
-			if (skip < __p->iov_len)		\
-				break;				\
-		}						\
-		__p++;						\
-		skip =3D 0;					\
-	} while (n);						\
-	i->iov_offset =3D skip;					\
-	n =3D off;						\
-}
-
-#define iterate_bvec(i, n, base, len, off, p, STEP) {		\
-	size_t off =3D 0;						\
-	unsigned skip =3D i->iov_offset;				\
-	while (n) {						\
-		unsigned offset =3D p->bv_offset + skip;		\
-		unsigned left;					\
-		void *kaddr =3D kmap_local_page(p->bv_page +	\
-					offset / PAGE_SIZE);	\
-		base =3D kaddr + offset % PAGE_SIZE;		\
-		len =3D min(min(n, (size_t)(p->bv_len - skip)),	\
-		     (size_t)(PAGE_SIZE - offset % PAGE_SIZE));	\
-		left =3D (STEP);					\
-		kunmap_local(kaddr);				\
-		len -=3D left;					\
-		off +=3D len;					\
-		skip +=3D len;					\
-		if (skip =3D=3D p->bv_len) {			\
-			skip =3D 0;				\
-			p++;					\
-		}						\
-		n -=3D len;					\
-		if (left)					\
-			break;					\
-	}							\
-	i->iov_offset =3D skip;					\
-	n =3D off;						\
-}
-
-#define iterate_xarray(i, n, base, len, __off, STEP) {		\
-	__label__ __out;					\
-	size_t __off =3D 0;					\
-	struct folio *folio;					\
-	loff_t start =3D i->xarray_start + i->iov_offset;		\
-	pgoff_t index =3D start / PAGE_SIZE;			\
-	XA_STATE(xas, i->xarray, index);			\
-								\
-	len =3D PAGE_SIZE - offset_in_page(start);		\
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
-		offset =3D offset_in_folio(folio, start + __off);	\
-		while (offset < folio_size(folio)) {		\
-			base =3D kmap_local_folio(folio, offset);	\
-			len =3D min(n, len);			\
-			left =3D (STEP);				\
-			kunmap_local(base);			\
-			len -=3D left;				\
-			__off +=3D len;				\
-			n -=3D len;				\
-			if (left || n =3D=3D 0)			\
-				goto __out;			\
-			offset +=3D len;				\
-			len =3D PAGE_SIZE;			\
-		}						\
-	}							\
-__out:								\
-	rcu_read_unlock();					\
-	i->iov_offset +=3D __off;					\
-	n =3D __off;						\
-}
-
-#define __iterate_and_advance(i, n, base, len, off, I, K) {	\
-	if (unlikely(i->count < n))				\
-		n =3D i->count;					\
-	if (likely(n)) {					\
-		if (likely(iter_is_ubuf(i))) {			\
-			void __user *base;			\
-			size_t len;				\
-			iterate_buf(i, n, base, len, off,	\
-						i->ubuf, (I)) 	\
-		} else if (likely(iter_is_iovec(i))) {		\
-			const struct iovec *iov =3D iter_iov(i);	\
-			void __user *base;			\
-			size_t len;				\
-			iterate_iovec(i, n, base, len, off,	\
-						iov, (I))	\
-			i->nr_segs -=3D iov - iter_iov(i);	\
-			i->__iov =3D iov;				\
-		} else if (iov_iter_is_bvec(i)) {		\
-			const struct bio_vec *bvec =3D i->bvec;	\
-			void *base;				\
-			size_t len;				\
-			iterate_bvec(i, n, base, len, off,	\
-						bvec, (K))	\
-			i->nr_segs -=3D bvec - i->bvec;		\
-			i->bvec =3D bvec;				\
-		} else if (iov_iter_is_kvec(i)) {		\
-			const struct kvec *kvec =3D i->kvec;	\
-			void *base;				\
-			size_t len;				\
-			iterate_iovec(i, n, base, len, off,	\
-						kvec, (K))	\
-			i->nr_segs -=3D kvec - i->kvec;		\
-			i->kvec =3D kvec;				\
-		} else if (iov_iter_is_xarray(i)) {		\
-			void *base;				\
-			size_t len;				\
-			iterate_xarray(i, n, base, len, off,	\
-							(K))	\
-		}						\
-		i->count -=3D n;					\
-	}							\
-}
-#define iterate_and_advance(i, n, base, len, off, I, K) \
-	__iterate_and_advance(i, n, base, len, off, I, ((void)(K),0))
-
-static int copyout(void __user *to, const void *from, size_t n)
+typedef size_t (*iov_step_f)(void *iter_base, size_t progress, size_t len=
,
+			     void *priv, __wsum *csum);
+typedef size_t (*iov_ustep_f)(void __user *iter_base, size_t progress, si=
ze_t len,
+			      void *priv, __wsum *csum);
+
+static __always_inline
+size_t iterate_ubuf(struct iov_iter *iter, size_t len, void *priv, __wsum=
 *csum,
+		    iov_ustep_f step)
+{
+	void __user *base =3D iter->ubuf;
+	size_t remain;
+
+	remain =3D step(base + iter->iov_offset, 0, len, priv, csum);
+	len -=3D remain;
+	iter->iov_offset +=3D len;
+	iter->count -=3D len;
+	return len;
+}
+
+static __always_inline
+size_t iterate_iovec(struct iov_iter *iter, size_t len, void *priv, __wsu=
m *csum,
+		     iov_ustep_f step)
 {
-	if (should_fail_usercopy())
-		return n;
-	if (access_ok(to, n)) {
-		instrument_copy_to_user(to, from, n);
-		n =3D raw_copy_to_user(to, from, n);
+	const struct iovec *p =3D iter->__iov;
+	size_t progress =3D 0, skip =3D iter->iov_offset;
+
+	do {
+		size_t remain, consumed;
+		size_t part =3D min(len, p->iov_len - skip);
+
+		if (likely(part)) {
+			remain =3D step(p->iov_base + skip, progress, part, priv, csum);
+			consumed =3D part - remain;
+			progress +=3D consumed;
+			skip +=3D consumed;
+			len -=3D consumed;
+			if (skip < p->iov_len)
+				break;
+		}
+		p++;
+		skip =3D 0;
+	} while (len);
+
+	iter->iov_offset =3D skip;
+	iter->nr_segs -=3D p - iter->__iov;
+	iter->__iov =3D p;
+	iter->count -=3D progress;
+	return progress;
+}
+
+static __always_inline
+size_t iterate_kvec(struct iov_iter *iter, size_t len, void *priv, __wsum=
 *csum,
+		    iov_step_f step)
+{
+	const struct kvec *p =3D iter->kvec;
+	size_t progress =3D 0, skip =3D iter->iov_offset;
+
+	do {
+		size_t remain, consumed;
+		size_t part =3D min(len, p->iov_len - skip);
+
+		if (likely(part)) {
+			remain =3D step(p->iov_base + skip, progress, part, priv, csum);
+			consumed =3D part - remain;
+			progress +=3D consumed;
+			skip +=3D consumed;
+			len -=3D consumed;
+			if (skip < p->iov_len)
+				break;
+		}
+		p++;
+		skip =3D 0;
+	} while (len);
+
+	iter->iov_offset =3D skip;
+	iter->nr_segs -=3D p - iter->kvec;
+	iter->kvec =3D p;
+	iter->count -=3D progress;
+	return progress;
+}
+
+static __always_inline
+size_t iterate_bvec(struct iov_iter *iter, size_t len, void *priv, __wsum=
 *csum,
+		    iov_step_f step)
+{
+	const struct bio_vec *p =3D iter->bvec;
+	size_t progress =3D 0, skip =3D iter->iov_offset;
+
+	do {
+		size_t remain, consumed;
+		size_t offset =3D p->bv_offset + skip, part;
+		void *kaddr =3D kmap_local_page(p->bv_page + offset / PAGE_SIZE);
+
+		part =3D min3(len,
+			   (size_t)(p->bv_len - skip),
+			   (size_t)(PAGE_SIZE - offset % PAGE_SIZE));
+		remain =3D step(kaddr + offset % PAGE_SIZE, progress, part, priv, csum)=
;
+		kunmap_local(kaddr);
+		consumed =3D part - remain;
+		len -=3D consumed;
+		progress +=3D consumed;
+		skip +=3D consumed;
+		if (skip >=3D p->bv_len) {
+			skip =3D 0;
+			p++;
+		}
+		if (remain)
+			break;
+	} while (len);
+
+	iter->iov_offset =3D skip;
+	iter->nr_segs -=3D p - iter->bvec;
+	iter->bvec =3D p;
+	iter->count -=3D progress;
+	return progress;
+}
+
+static __always_inline
+size_t iterate_xarray(struct iov_iter *iter, size_t len, void *priv, __ws=
um *csum,
+		      iov_step_f step)
+{
+	struct folio *folio;
+	size_t progress =3D 0;
+	loff_t start =3D iter->xarray_start + iter->iov_offset;
+	pgoff_t index =3D start / PAGE_SIZE;
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
+		offset =3D offset_in_folio(folio, start);
+		flen =3D min(folio_size(folio) - offset, len);
+		start +=3D flen;
+
+		while (flen) {
+			void *base =3D kmap_local_folio(folio, offset);
+
+			part =3D min(flen, PAGE_SIZE - offset_in_page(offset));
+			remain =3D step(base, progress, part, priv, csum);
+			kunmap_local(base);
+
+			consumed =3D part - remain;
+			progress +=3D consumed;
+			len -=3D consumed;
+
+			if (remain || len =3D=3D 0)
+				goto out;
+			flen -=3D consumed;
+			offset +=3D consumed;
+		}
+	}
+
+out:
+	rcu_read_unlock();
+	iter->iov_offset +=3D progress;
+	iter->count -=3D progress;
+	return progress;
+}
+
+static __always_inline
+size_t iterate_and_advance(struct iov_iter *iter, size_t len, void *priv,
+			   iov_ustep_f ustep, iov_step_f step)
+{
+	if (unlikely(iter->count < len))
+		len =3D iter->count;
+	if (unlikely(!len))
+		return 0;
+
+	switch (iov_iter_type(iter)) {
+	case ITER_UBUF:
+		return iterate_ubuf(iter, len, priv, NULL, ustep);
+	case ITER_IOVEC:
+		return iterate_iovec(iter, len, priv, NULL, ustep);
+	case ITER_KVEC:
+		return iterate_kvec(iter, len, priv, NULL, step);
+	case ITER_BVEC:
+		return iterate_bvec(iter, len, priv, NULL, step);
+	case ITER_XARRAY:
+		return iterate_xarray(iter, len, priv, NULL, step);
+	case ITER_DISCARD:
+		iter->count -=3D len;
+		return len;
 	}
-	return n;
+	return 0;
 }
 =

-static int copyout_nofault(void __user *to, const void *from, size_t n)
+static __always_inline
+size_t iterate_and_advance_csum(struct iov_iter *iter, size_t len, void *=
priv,
+				__wsum *csum, iov_ustep_f ustep, iov_step_f step)
 {
-	long res;
+	if (unlikely(iter->count < len))
+		len =3D iter->count;
+	if (unlikely(!len))
+		return 0;
 =

+	switch (iov_iter_type(iter)) {
+	case ITER_UBUF:
+		return iterate_ubuf(iter, len, priv, csum, ustep);
+	case ITER_IOVEC:
+		return iterate_iovec(iter, len, priv, csum, ustep);
+	case ITER_KVEC:
+		return iterate_kvec(iter, len, priv, csum, step);
+	case ITER_BVEC:
+		return iterate_bvec(iter, len, priv, csum, step);
+	case ITER_XARRAY:
+		return iterate_xarray(iter, len, priv, csum, step);
+	case ITER_DISCARD:
+		iter->count -=3D len;
+		return len;
+	}
+	return 0;
+}
+
+static size_t copy_to_user_iter(void __user *iter_to, size_t progress,
+				size_t len, void *from, __wsum *csum)
+{
 	if (should_fail_usercopy())
-		return n;
+		return len;
+	if (access_ok(iter_to, len)) {
+		from +=3D progress;
+		instrument_copy_to_user(iter_to, from, len);
+		len =3D raw_copy_to_user(iter_to, from, len);
+	}
+	return len;
+}
+
+static size_t copy_to_user_iter_nofault(void __user *iter_to, size_t prog=
ress,
+					size_t len, void *from, __wsum *csum)
+{
+	ssize_t res;
 =

-	res =3D copy_to_user_nofault(to, from, n);
+	if (should_fail_usercopy())
+		return len;
 =

-	return res < 0 ? n : res;
+	from +=3D progress;
+	res =3D copy_to_user_nofault(iter_to, from, len);
+	return res < 0 ? len : res;
 }
 =

-static int copyin(void *to, const void __user *from, size_t n)
+static size_t copy_from_user_iter(void __user *iter_from, size_t progress=
,
+				  size_t len, void *to, __wsum *csum)
 {
-	size_t res =3D n;
+	size_t res =3D len;
 =

 	if (should_fail_usercopy())
-		return n;
-	if (access_ok(from, n)) {
-		instrument_copy_from_user_before(to, from, n);
-		res =3D raw_copy_from_user(to, from, n);
-		instrument_copy_from_user_after(to, from, n, res);
+		return len;
+	if (access_ok(iter_from, len)) {
+		to +=3D progress;
+		instrument_copy_from_user_before(to, iter_from, len);
+		res =3D raw_copy_from_user(to, iter_from, len);
+		instrument_copy_from_user_after(to, iter_from, len, res);
 	}
 	return res;
 }
 =

+static size_t memcpy_to_iter(void *iter_to, size_t progress,
+			     size_t len, void *from, __wsum *csum)
+{
+	memcpy(iter_to, from + progress, len);
+	return 0;
+}
+
+static size_t memcpy_from_iter(void *iter_from, size_t progress,
+			       size_t len, void *to, __wsum *csum)
+{
+	memcpy(to + progress, iter_from, len);
+	return 0;
+}
+
 /*
  * fault_in_iov_iter_readable - fault in iov iterator for reading
  * @i: iterator
@@ -313,23 +408,27 @@ size_t _copy_to_iter(const void *addr, size_t bytes,=
 struct iov_iter *i)
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
 =

 #ifdef CONFIG_ARCH_HAS_COPY_MC
-static int copyout_mc(void __user *to, const void *from, size_t n)
+static size_t copy_to_user_iter_mc(void __user *iter_to, size_t progress,
+				   size_t len, void *from, __wsum *csum)
 {
-	if (access_ok(to, n)) {
-		instrument_copy_to_user(to, from, n);
-		n =3D copy_mc_to_user((__force void *) to, from, n);
+	if (access_ok(iter_to, len)) {
+		from +=3D progress;
+		instrument_copy_to_user(iter_to, from, len);
+		len =3D copy_mc_to_user(iter_to, from, len);
 	}
-	return n;
+	return len;
+}
+
+static size_t memcpy_to_iter_mc(void *iter_to, size_t progress,
+				size_t len, void *from, __wsum *csum)
+{
+	return copy_mc_to_kernel(iter_to, from + progress, len);
 }
 =

 /**
@@ -362,22 +461,16 @@ size_t _copy_mc_to_iter(const void *addr, size_t byt=
es, struct iov_iter *i)
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
 =

-static void *memcpy_from_iter(struct iov_iter *i, void *to, const void *f=
rom,
-				 size_t size)
+static size_t memcpy_from_iter_mc(void *iter_from, size_t progress,
+				  size_t len, void *to, __wsum *csum)
 {
-	if (iov_iter_is_copy_mc(i))
-		return (void *)copy_mc_to_kernel(to, from, size);
-	return memcpy(to, from, size);
+	return copy_mc_to_kernel(to + progress, iter_from, len);
 }
 =

 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
@@ -387,30 +480,37 @@ size_t _copy_from_iter(void *addr, size_t bytes, str=
uct iov_iter *i)
 =

 	if (user_backed_iter(i))
 		might_fault();
-	iterate_and_advance(i, bytes, base, len, off,
-		copyin(addr + off, base, len),
-		memcpy_from_iter(i, addr + off, base, len)
-	)
-
-	return bytes;
+	return iterate_and_advance(i, bytes, addr,
+				   copy_from_user_iter,
+				   iov_iter_is_copy_mc(i) ?
+				   memcpy_from_iter_mc : memcpy_from_iter);
 }
 EXPORT_SYMBOL(_copy_from_iter);
 =

+static size_t copy_from_user_iter_nocache(void __user *iter_from, size_t =
progress,
+					  size_t len, void *to, __wsum *csum)
+{
+	return __copy_from_user_inatomic_nocache(to + progress, iter_from, len);
+}
+
 size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter =
*i)
 {
 	if (WARN_ON_ONCE(!i->data_source))
 		return 0;
 =

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
 =

 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
+static size_t copy_from_user_iter_flushcache(void __user *iter_from, size=
_t progress,
+					     size_t len, void *to, __wsum *csum)
+{
+	return __copy_from_user_flushcache(to + progress, iter_from, len);
+}
+
 /**
  * _copy_from_iter_flushcache - write destination through cpu cache
  * @addr: destination kernel address
@@ -432,12 +532,9 @@ size_t _copy_from_iter_flushcache(void *addr, size_t =
bytes, struct iov_iter *i)
 	if (WARN_ON_ONCE(!i->data_source))
 		return 0;
 =

-	iterate_and_advance(i, bytes, base, len, off,
-		__copy_from_user_flushcache(addr + off, base, len),
-		memcpy_flushcache(addr + off, base, len)
-	)
-
-	return bytes;
+	return iterate_and_advance(i, bytes, addr,
+				   copy_from_user_iter_flushcache,
+				   memcpy_from_iter);
 }
 EXPORT_SYMBOL_GPL(_copy_from_iter_flushcache);
 #endif
@@ -509,10 +606,9 @@ size_t copy_page_to_iter_nofault(struct page *page, u=
nsigned offset, size_t byte
 		void *kaddr =3D kmap_local_page(page);
 		size_t n =3D min(bytes, (size_t)PAGE_SIZE - offset);
 =

-		iterate_and_advance(i, n, base, len, off,
-			copyout_nofault(base, kaddr + offset + off, len),
-			memcpy(base, kaddr + offset + off, len)
-		)
+		n =3D iterate_and_advance(i, bytes, kaddr,
+					copy_to_user_iter_nofault,
+					memcpy_to_iter);
 		kunmap_local(kaddr);
 		res +=3D n;
 		bytes -=3D n;
@@ -555,14 +651,23 @@ size_t copy_page_from_iter(struct page *page, size_t=
 offset, size_t bytes,
 }
 EXPORT_SYMBOL(copy_page_from_iter);
 =

-size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
+static size_t zero_to_user_iter(void __user *iter_to, size_t progress,
+				size_t len, void *from, __wsum *csum)
 {
-	iterate_and_advance(i, bytes, base, len, count,
-		clear_user(base, len),
-		memset(base, 0, len)
-	)
+	return clear_user(iter_to, len);
+}
 =

-	return bytes;
+static size_t zero_to_iter(void *iter_to, size_t progress,
+			   size_t len, void *from, __wsum *csum)
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
 =

@@ -578,10 +683,11 @@ size_t copy_page_from_iter_atomic(struct page *page,=
 unsigned offset, size_t byt
 		kunmap_atomic(kaddr);
 		return 0;
 	}
-	iterate_and_advance(i, bytes, base, len, off,
-		copyin(p + off, base, len),
-		memcpy_from_iter(i, p + off, base, len)
-	)
+
+	bytes =3D iterate_and_advance(i, bytes, p,
+				    copy_from_user_iter,
+				    iov_iter_is_copy_mc(i) ?
+				    memcpy_from_iter_mc : memcpy_from_iter);
 	kunmap_atomic(kaddr);
 	return bytes;
 }
@@ -1168,32 +1274,56 @@ ssize_t iov_iter_get_pages_alloc2(struct iov_iter =
*i,
 }
 EXPORT_SYMBOL(iov_iter_get_pages_alloc2);
 =

+static size_t copy_from_user_iter_csum(void __user *iter_from, size_t pro=
gress,
+				       size_t len, void *to, __wsum *csum)
+{
+	__wsum next;
+
+	next =3D csum_and_copy_from_user(iter_from, to + progress, len);
+	*csum =3D csum_block_add(*csum, next, progress);
+	return next ? 0 : len;
+}
+
+static size_t memcpy_from_iter_csum(void *iter_from, size_t progress,
+				    size_t len, void *to, __wsum *csum)
+{
+	*csum =3D csum_and_memcpy(to + progress, iter_from, len, *csum, progress=
);
+	return 0;
+}
+
 size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 			       struct iov_iter *i)
 {
-	__wsum sum, next;
-	sum =3D *csum;
 	if (WARN_ON_ONCE(!i->data_source))
 		return 0;
-
-	iterate_and_advance(i, bytes, base, len, off, ({
-		next =3D csum_and_copy_from_user(base, addr + off, len);
-		sum =3D csum_block_add(sum, next, off);
-		next ? 0 : len;
-	}), ({
-		sum =3D csum_and_memcpy(addr + off, base, len, sum, off);
-	})
-	)
-	*csum =3D sum;
-	return bytes;
+	return iterate_and_advance_csum(i, bytes, addr, csum,
+					copy_from_user_iter_csum,
+					memcpy_from_iter_csum);
 }
 EXPORT_SYMBOL(csum_and_copy_from_iter);
 =

+static size_t copy_to_user_iter_csum(void __user *iter_to, size_t progres=
s,
+				     size_t len, void *from, __wsum *csum)
+{
+	__wsum next;
+
+	next =3D csum_and_copy_to_user(from + progress, iter_to, len);
+	*csum =3D csum_block_add(*csum, next, progress);
+	return next ? 0 : len;
+}
+
+static size_t memcpy_to_iter_csum(void *iter_to, size_t progress,
+				  size_t len, void *from, __wsum *csum)
+{
+	*csum =3D csum_and_memcpy(iter_to, from + progress, len, *csum, progress=
);
+	return 0;
+}
+
 size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *_cssta=
te,
 			     struct iov_iter *i)
 {
 	struct csum_state *csstate =3D _csstate;
-	__wsum sum, next;
+	__wsum sum;
 =

 	if (WARN_ON_ONCE(i->data_source))
 		return 0;
@@ -1207,14 +1337,10 @@ size_t csum_and_copy_to_iter(const void *addr, siz=
e_t bytes, void *_csstate,
 	}
 =

 	sum =3D csum_shift(csstate->csum, csstate->off);
-	iterate_and_advance(i, bytes, base, len, off, ({
-		next =3D csum_and_copy_to_user(addr + off, base, len);
-		sum =3D csum_block_add(sum, next, off);
-		next ? 0 : len;
-	}), ({
-		sum =3D csum_and_memcpy(base, addr + off, len, sum, off);
-	})
-	)
+	=

+	bytes =3D iterate_and_advance_csum(i, bytes, (void *)addr, &sum,
+					 copy_to_user_iter_csum,
+					 memcpy_to_iter_csum);
 	csstate->csum =3D csum_shift(sum, csstate->off);
 	csstate->off +=3D bytes;
 	return bytes;

