Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62AC79EF96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 18:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjIMQ61 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 12:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjIMQ6I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:58:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6E7F1BEF
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 09:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694624232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7f30E5rfqXOL8OIlALoKZyRz07q/M/xUz+BJRcAuap4=;
        b=dV+u0wtiTANGPLxaBWYFq83RecyR3pytxNsbqUQh3mZ4ASEnoQHDwKJNhdtf82GhsnYwnK
        eEpj8WbUHe69H+J75aqyqBYNEKwGSXqSdtIVeAoRRLVfk3CK2VAKvYRToXleGEb2pReJ6C
        e0bW2Lej/JAJsg8M/8z2h+zNTwkOQTY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-510-cMka_6aIPNiC8mOgNkW5Mw-1; Wed, 13 Sep 2023 12:57:06 -0400
X-MC-Unique: cMka_6aIPNiC8mOgNkW5Mw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9603B185A797;
        Wed, 13 Sep 2023 16:57:05 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5E5F40C6EBF;
        Wed, 13 Sep 2023 16:57:03 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/13] iov: Move iterator functions to a header file
Date:   Wed, 13 Sep 2023 17:56:40 +0100
Message-ID: <20230913165648.2570623-6-dhowells@redhat.com>
In-Reply-To: <20230913165648.2570623-1-dhowells@redhat.com>
References: <20230913165648.2570623-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the iterator functions to a header file so that other operations that
need to scan over an iterator can be added.  For instance, the rbd driver
could use this to scan a buffer to see if it is all zeros and libceph could
use this to generate a crc.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@lst.de>
cc: Christian Brauner <christian@brauner.io>
cc: Matthew Wilcox <willy@infradead.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: David Laight <David.Laight@ACULAB.COM>
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 include/linux/iov_iter.h | 261 +++++++++++++++++++++++++++++++++++++++
 lib/iov_iter.c           | 197 +----------------------------
 2 files changed, 262 insertions(+), 196 deletions(-)
 create mode 100644 include/linux/iov_iter.h

diff --git a/include/linux/iov_iter.h b/include/linux/iov_iter.h
new file mode 100644
index 000000000000..836854847cdf
--- /dev/null
+++ b/include/linux/iov_iter.h
@@ -0,0 +1,261 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* I/O iterator iteration building functions.
+ *
+ * Copyright (C) 2023 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#ifndef _LINUX_IOV_ITER_H
+#define _LINUX_IOV_ITER_H
+
+#include <linux/uio.h>
+#include <linux/bvec.h>
+
+typedef size_t (*iov_step_f)(void *iter_base, size_t progress, size_t len,
+			     void *priv, void *priv2);
+typedef size_t (*iov_ustep_f)(void __user *iter_base, size_t progress, size_t len,
+			      void *priv, void *priv2);
+
+/*
+ * Handle ITER_UBUF.
+ */
+static __always_inline
+size_t iterate_ubuf(struct iov_iter *iter, size_t len, void *priv, void *priv2,
+		    iov_ustep_f step)
+{
+	void __user *base = iter->ubuf;
+	size_t progress = 0, remain;
+
+	remain = step(base + iter->iov_offset, 0, len, priv, priv2);
+	progress = len - remain;
+	iter->iov_offset += progress;
+	return progress;
+}
+
+/*
+ * Handle ITER_IOVEC.
+ */
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
+/*
+ * Handle ITER_KVEC.
+ */
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
+	iter->nr_segs -= p - iter->kvec;
+	iter->kvec = p;
+	iter->iov_offset = skip;
+	return progress;
+}
+
+/*
+ * Handle ITER_BVEC.
+ */
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
+	iter->nr_segs -= p - iter->bvec;
+	iter->bvec = p;
+	iter->iov_offset = skip;
+	return progress;
+}
+
+/*
+ * Handle ITER_XARRAY.
+ */
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
+		offset = offset_in_folio(folio, start + progress);
+		flen = min(folio_size(folio) - offset, len);
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
+	}
+
+out:
+	rcu_read_unlock();
+	iter->iov_offset += progress;
+	return progress;
+}
+
+/**
+ * iterate_and_advance2 - Iterate over an iterator
+ * @iter: The iterator to iterate over.
+ * @len: The amount to iterate over.
+ * @priv: Data for the step functions.
+ * @priv2: More data for the step functions.
+ * @ustep: Function for UBUF/IOVEC iterators; given __user addresses.
+ * @step: Function for other iterators; given kernel addresses.
+ *
+ * Iterate over the next part of an iterator, up to the specified length.  The
+ * buffer is presented in segments, which for kernel iteration are broken up by
+ * physical pages and mapped, with the mapped address being presented.
+ *
+ * Two step functions, @step and @ustep, must be provided, one for handling
+ * mapped kernel addresses and the other is given user addresses which have the
+ * potential to fault since no pinning is performed.
+ *
+ * The step functions are passed the address and length of the segment, @priv,
+ * @priv2 and the amount of data so far iterated over (which can, for example,
+ * be added to @priv to point to the right part of a second buffer).  The step
+ * functions should return the amount of the segment they didn't process (ie. 0
+ * indicates complete processsing).
+ *
+ * This function returns the amount of data processed (ie. 0 means nothing was
+ * processed and the value of @len means processes to completion).
+ */
+static __always_inline
+size_t iterate_and_advance2(struct iov_iter *iter, size_t len, void *priv,
+			    void *priv2, iov_ustep_f ustep, iov_step_f step)
+{
+	size_t progress;
+
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
+/**
+ * iterate_and_advance - Iterate over an iterator
+ * @iter: The iterator to iterate over.
+ * @len: The amount to iterate over.
+ * @priv: Data for the step functions.
+ * @ustep: Function for UBUF/IOVEC iterators; given __user addresses.
+ * @step: Function for other iterators; given kernel addresses.
+ *
+ * As iterate_and_advance2(), but priv2 is always NULL.
+ */
+static __always_inline
+size_t iterate_and_advance(struct iov_iter *iter, size_t len, void *priv,
+			   iov_ustep_f ustep, iov_step_f step)
+{
+	return iterate_and_advance2(iter, len, priv, NULL, ustep, step);
+}
+
+#endif /* _LINUX_IOV_ITER_H */
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index b3ce6fa5f7a5..65374ee91ecd 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -13,202 +13,7 @@
 #include <net/checksum.h>
 #include <linux/scatterlist.h>
 #include <linux/instrumented.h>
-
-typedef size_t (*iov_step_f)(void *iter_base, size_t progress, size_t len,
-			     void *priv, void *priv2);
-typedef size_t (*iov_ustep_f)(void __user *iter_base, size_t progress, size_t len,
-			      void *priv, void *priv2);
-
-static __always_inline
-size_t iterate_ubuf(struct iov_iter *iter, size_t len, void *priv, void *priv2,
-		    iov_ustep_f step)
-{
-	void __user *base = iter->ubuf;
-	size_t progress = 0, remain;
-
-	remain = step(base + iter->iov_offset, 0, len, priv, priv2);
-	progress = len - remain;
-	iter->iov_offset += progress;
-	return progress;
-}
-
-static __always_inline
-size_t iterate_iovec(struct iov_iter *iter, size_t len, void *priv, void *priv2,
-		     iov_ustep_f step)
-{
-	const struct iovec *p = iter->__iov;
-	size_t progress = 0, skip = iter->iov_offset;
-
-	do {
-		size_t remain, consumed;
-		size_t part = min(len, p->iov_len - skip);
-
-		if (likely(part)) {
-			remain = step(p->iov_base + skip, progress, part, priv, priv2);
-			consumed = part - remain;
-			progress += consumed;
-			skip += consumed;
-			len -= consumed;
-			if (skip < p->iov_len)
-				break;
-		}
-		p++;
-		skip = 0;
-	} while (len);
-
-	iter->__iov = p;
-	iter->nr_segs -= p - iter->__iov;
-	iter->iov_offset = skip;
-	return progress;
-}
-
-static __always_inline
-size_t iterate_kvec(struct iov_iter *iter, size_t len, void *priv, void *priv2,
-		    iov_step_f step)
-{
-	const struct kvec *p = iter->kvec;
-	size_t progress = 0, skip = iter->iov_offset;
-
-	do {
-		size_t remain, consumed;
-		size_t part = min(len, p->iov_len - skip);
-
-		if (likely(part)) {
-			remain = step(p->iov_base + skip, progress, part, priv, priv2);
-			consumed = part - remain;
-			progress += consumed;
-			skip += consumed;
-			len -= consumed;
-			if (skip < p->iov_len)
-				break;
-		}
-		p++;
-		skip = 0;
-	} while (len);
-
-	iter->nr_segs -= p - iter->kvec;
-	iter->kvec = p;
-	iter->iov_offset = skip;
-	return progress;
-}
-
-static __always_inline
-size_t iterate_bvec(struct iov_iter *iter, size_t len, void *priv, void *priv2,
-		    iov_step_f step)
-{
-	const struct bio_vec *p = iter->bvec;
-	size_t progress = 0, skip = iter->iov_offset;
-
-	do {
-		size_t remain, consumed;
-		size_t offset = p->bv_offset + skip, part;
-		void *kaddr = kmap_local_page(p->bv_page + offset / PAGE_SIZE);
-
-		part = min3(len,
-			   (size_t)(p->bv_len - skip),
-			   (size_t)(PAGE_SIZE - offset % PAGE_SIZE));
-		remain = step(kaddr + offset % PAGE_SIZE, progress, part, priv, priv2);
-		kunmap_local(kaddr);
-		consumed = part - remain;
-		len -= consumed;
-		progress += consumed;
-		skip += consumed;
-		if (skip >= p->bv_len) {
-			skip = 0;
-			p++;
-		}
-		if (remain)
-			break;
-	} while (len);
-
-	iter->nr_segs -= p - iter->bvec;
-	iter->bvec = p;
-	iter->iov_offset = skip;
-	return progress;
-}
-
-static __always_inline
-size_t iterate_xarray(struct iov_iter *iter, size_t len, void *priv, void *priv2,
-		      iov_step_f step)
-{
-	struct folio *folio;
-	size_t progress = 0;
-	loff_t start = iter->xarray_start + iter->iov_offset;
-	pgoff_t index = start / PAGE_SIZE;
-	XA_STATE(xas, iter->xarray, index);
-
-	rcu_read_lock();
-	xas_for_each(&xas, folio, ULONG_MAX) {
-		size_t remain, consumed, offset, part, flen;
-
-		if (xas_retry(&xas, folio))
-			continue;
-		if (WARN_ON(xa_is_value(folio)))
-			break;
-		if (WARN_ON(folio_test_hugetlb(folio)))
-			break;
-
-		offset = offset_in_folio(folio, start + progress);
-		flen = min(folio_size(folio) - offset, len);
-
-		while (flen) {
-			void *base = kmap_local_folio(folio, offset);
-
-			part = min_t(size_t, flen,
-				     PAGE_SIZE - offset_in_page(offset));
-			remain = step(base, progress, part, priv, priv2);
-			kunmap_local(base);
-
-			consumed = part - remain;
-			progress += consumed;
-			len -= consumed;
-
-			if (remain || len == 0)
-				goto out;
-			flen -= consumed;
-			offset += consumed;
-		}
-	}
-
-out:
-	rcu_read_unlock();
-	iter->iov_offset += progress;
-	return progress;
-}
-
-static __always_inline
-size_t iterate_and_advance2(struct iov_iter *iter, size_t len, void *priv,
-			    void *priv2, iov_ustep_f ustep, iov_step_f step)
-{
-	size_t progress;
-
-	if (unlikely(iter->count < len))
-		len = iter->count;
-	if (unlikely(!len))
-		return 0;
-
-	if (likely(iter_is_ubuf(iter)))
-		progress = iterate_ubuf(iter, len, priv, priv2, ustep);
-	else if (likely(iter_is_iovec(iter)))
-		progress = iterate_iovec(iter, len, priv, priv2, ustep);
-	else if (iov_iter_is_bvec(iter))
-		progress = iterate_bvec(iter, len, priv, priv2, step);
-	else if (iov_iter_is_kvec(iter))
-		progress = iterate_kvec(iter, len, priv, priv2, step);
-	else if (iov_iter_is_xarray(iter))
-		progress = iterate_xarray(iter, len, priv, priv2, step);
-	else
-		progress = len;
-	iter->count -= progress;
-	return progress;
-}
-
-static __always_inline
-size_t iterate_and_advance(struct iov_iter *iter, size_t len, void *priv,
-			   iov_ustep_f ustep, iov_step_f step)
-{
-	return iterate_and_advance2(iter, len, priv, NULL, ustep, step);
-}
+#include <linux/iov_iter.h>
 
 static __always_inline
 size_t copy_to_user_iter(void __user *iter_to, size_t progress,

