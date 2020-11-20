Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256952BACE0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgKTPGd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:06:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21009 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728330AbgKTPGc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:06:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605884789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9xwcEKuW4WfG4WiPWL1/gATo5sx7vYu1cDXiemYomFc=;
        b=H5BkhikUSOa25I6pF/UE6B6Zj9jpQhh+H9lBRj3UIZ8U5IHcNJXa11t1jmTSvHjyFU3T7a
        3P58UPxVn9wwp7SNKZ0lE7B/NJswMXIpc3aCQhdlkdC0ILZJeoAWhmegFkj8CAc4xZzNBR
        f2G7mW6GRjo3V9DDelKaYUl5JnfctIE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-zZG0MiVdPFqRsaR6Ih6J4Q-1; Fri, 20 Nov 2020 10:06:26 -0500
X-MC-Unique: zZG0MiVdPFqRsaR6Ih6J4Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 017188797DC;
        Fri, 20 Nov 2020 15:06:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 223A75C1D5;
        Fri, 20 Nov 2020 15:06:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 17/76] iov_iter: Add ITER_XARRAY
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Matthew Wilcox <willy@infradead.org>, dhowells@redhat.com,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:06:13 +0000
Message-ID: <160588477334.3465195.3608963255682568730.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add an iterator, ITER_XARRAY, that walks through a set of pages attached to
an xarray, starting at a given page and offset and walking for the
specified amount of bytes.  The iterator supports transparent huge pages.

The caller must guarantee that the pages are all present and they must be
locked using PG_locked, PG_writeback or PG_fscache to prevent them from
going away or being migrated whilst they're being accessed.

This is useful for copying data from socket buffers to inodes in network
filesystems and for transferring data between those inodes and the cache
using direct I/O.

Whilst it is true that ITER_BVEC could be used instead, that would require
a bio_vec array to be allocated to refer to all the pages - which should be
redundant if inode->i_pages also points to all these pages.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
---

 include/linux/uio.h |   11 ++
 lib/iov_iter.c      |  312 +++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 300 insertions(+), 23 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 72d88566694e..08b186df54ac 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -10,6 +10,7 @@
 #include <uapi/linux/uio.h>
 
 struct page;
+struct address_space;
 struct pipe_inode_info;
 
 struct kvec {
@@ -24,6 +25,7 @@ enum iter_type {
 	ITER_BVEC = 16,
 	ITER_PIPE = 32,
 	ITER_DISCARD = 64,
+	ITER_XARRAY = 128,
 };
 
 struct iov_iter {
@@ -39,6 +41,7 @@ struct iov_iter {
 		const struct iovec *iov;
 		const struct kvec *kvec;
 		const struct bio_vec *bvec;
+		struct xarray *xarray;
 		struct pipe_inode_info *pipe;
 	};
 	union {
@@ -47,6 +50,7 @@ struct iov_iter {
 			unsigned int head;
 			unsigned int start_head;
 		};
+		loff_t xarray_start;
 	};
 };
 
@@ -80,6 +84,11 @@ static inline bool iov_iter_is_discard(const struct iov_iter *i)
 	return iov_iter_type(i) == ITER_DISCARD;
 }
 
+static inline bool iov_iter_is_xarray(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_XARRAY;
+}
+
 static inline unsigned char iov_iter_rw(const struct iov_iter *i)
 {
 	return i->type & (READ | WRITE);
@@ -221,6 +230,8 @@ void iov_iter_bvec(struct iov_iter *i, unsigned int direction, const struct bio_
 void iov_iter_pipe(struct iov_iter *i, unsigned int direction, struct pipe_inode_info *pipe,
 			size_t count);
 void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count);
+void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
+		     loff_t start, size_t count);
 ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
 ssize_t iov_iter_get_pages_alloc(struct iov_iter *i, struct page ***pages,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 1635111c5bd2..6edf0f290159 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -78,7 +78,44 @@
 	}						\
 }
 
-#define iterate_all_kinds(i, n, v, I, B, K) {			\
+#define iterate_xarray(i, n, __v, skip, STEP) {		\
+	struct page *head = NULL;				\
+	size_t wanted = n, seg, offset;				\
+	loff_t start = i->xarray_start + skip;			\
+	pgoff_t index = start >> PAGE_SHIFT;			\
+	int j;							\
+								\
+	XA_STATE(xas, i->xarray, index);			\
+								\
+	rcu_read_lock();						\
+	xas_for_each(&xas, head, ULONG_MAX) {				\
+		if (xas_retry(&xas, head))				\
+			continue;					\
+		if (WARN_ON(xa_is_value(head)))				\
+			break;						\
+		if (WARN_ON(PageHuge(head)))				\
+			break;						\
+		for (j = (head->index < index) ? index - head->index : 0; \
+		     j < thp_nr_pages(head); j++) {			\
+			__v.bv_page = head + j;				\
+			offset = (i->xarray_start + skip) & ~PAGE_MASK;	\
+			seg = PAGE_SIZE - offset;			\
+			__v.bv_offset = offset;				\
+			__v.bv_len = min(n, seg);			\
+			(void)(STEP);					\
+			n -= __v.bv_len;				\
+			skip += __v.bv_len;				\
+			if (n == 0)					\
+				break;					\
+		}							\
+		if (n == 0)						\
+			break;						\
+	}							\
+	rcu_read_unlock();					\
+	n = wanted - n;						\
+}
+
+#define iterate_all_kinds(i, n, v, I, B, K, X) {		\
 	if (likely(n)) {					\
 		size_t skip = i->iov_offset;			\
 		if (unlikely(i->type & ITER_BVEC)) {		\
@@ -90,6 +127,9 @@
 			struct kvec v;				\
 			iterate_kvec(i, n, v, kvec, skip, (K))	\
 		} else if (unlikely(i->type & ITER_DISCARD)) {	\
+		} else if (unlikely(i->type & ITER_XARRAY)) {	\
+			struct bio_vec v;			\
+			iterate_xarray(i, n, v, skip, (X));	\
 		} else {					\
 			const struct iovec *iov;		\
 			struct iovec v;				\
@@ -98,7 +138,7 @@
 	}							\
 }
 
-#define iterate_and_advance(i, n, v, I, B, K) {			\
+#define iterate_and_advance(i, n, v, I, B, K, X) {		\
 	if (unlikely(i->count < n))				\
 		n = i->count;					\
 	if (i->count) {						\
@@ -123,6 +163,9 @@
 			i->kvec = kvec;				\
 		} else if (unlikely(i->type & ITER_DISCARD)) {	\
 			skip += n;				\
+		} else if (unlikely(i->type & ITER_XARRAY)) {	\
+			struct bio_vec v;			\
+			iterate_xarray(i, n, v, skip, (X))	\
 		} else {					\
 			const struct iovec *iov;		\
 			struct iovec v;				\
@@ -636,7 +679,9 @@ size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 		copyout(v.iov_base, (from += v.iov_len) - v.iov_len, v.iov_len),
 		memcpy_to_page(v.bv_page, v.bv_offset,
 			       (from += v.bv_len) - v.bv_len, v.bv_len),
-		memcpy(v.iov_base, (from += v.iov_len) - v.iov_len, v.iov_len)
+		memcpy(v.iov_base, (from += v.iov_len) - v.iov_len, v.iov_len),
+		memcpy_to_page(v.bv_page, v.bv_offset,
+			       (from += v.bv_len) - v.bv_len, v.bv_len)
 	)
 
 	return bytes;
@@ -752,6 +797,15 @@ size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 			bytes = curr_addr - s_addr - rem;
 			return bytes;
 		}
+		}),
+		({
+		rem = copy_mc_to_page(v.bv_page, v.bv_offset,
+				      (from += v.bv_len) - v.bv_len, v.bv_len);
+		if (rem) {
+			curr_addr = (unsigned long) from;
+			bytes = curr_addr - s_addr - rem;
+			return bytes;
+		}
 		})
 	)
 
@@ -773,7 +827,9 @@ size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 		copyin((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
 		memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
 				 v.bv_offset, v.bv_len),
-		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len)
+		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
+		memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
+				 v.bv_offset, v.bv_len)
 	)
 
 	return bytes;
@@ -799,7 +855,9 @@ bool _copy_from_iter_full(void *addr, size_t bytes, struct iov_iter *i)
 		0;}),
 		memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
 				 v.bv_offset, v.bv_len),
-		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len)
+		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
+		memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
+				 v.bv_offset, v.bv_len)
 	)
 
 	iov_iter_advance(i, bytes);
@@ -819,7 +877,9 @@ size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i)
 					 v.iov_base, v.iov_len),
 		memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
 				 v.bv_offset, v.bv_len),
-		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len)
+		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
+		memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
+				 v.bv_offset, v.bv_len)
 	)
 
 	return bytes;
@@ -854,7 +914,9 @@ size_t _copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
 		memcpy_page_flushcache((to += v.bv_len) - v.bv_len, v.bv_page,
 				 v.bv_offset, v.bv_len),
 		memcpy_flushcache((to += v.iov_len) - v.iov_len, v.iov_base,
-			v.iov_len)
+			v.iov_len),
+		memcpy_page_flushcache((to += v.bv_len) - v.bv_len, v.bv_page,
+				 v.bv_offset, v.bv_len)
 	)
 
 	return bytes;
@@ -878,7 +940,9 @@ bool _copy_from_iter_full_nocache(void *addr, size_t bytes, struct iov_iter *i)
 		0;}),
 		memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
 				 v.bv_offset, v.bv_len),
-		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len)
+		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
+		memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
+				 v.bv_offset, v.bv_len)
 	)
 
 	iov_iter_advance(i, bytes);
@@ -915,7 +979,7 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 {
 	if (unlikely(!page_copy_sane(page, offset, bytes)))
 		return 0;
-	if (i->type & (ITER_BVEC|ITER_KVEC)) {
+	if (i->type & (ITER_BVEC | ITER_KVEC | ITER_XARRAY)) {
 		void *kaddr = kmap_atomic(page);
 		size_t wanted = copy_to_iter(kaddr + offset, bytes, i);
 		kunmap_atomic(kaddr);
@@ -938,7 +1002,7 @@ size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 		WARN_ON(1);
 		return 0;
 	}
-	if (i->type & (ITER_BVEC|ITER_KVEC)) {
+	if (i->type & (ITER_BVEC | ITER_KVEC | ITER_XARRAY)) {
 		void *kaddr = kmap_atomic(page);
 		size_t wanted = _copy_from_iter(kaddr + offset, bytes, i);
 		kunmap_atomic(kaddr);
@@ -982,7 +1046,8 @@ size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
 	iterate_and_advance(i, bytes, v,
 		clear_user(v.iov_base, v.iov_len),
 		memzero_page(v.bv_page, v.bv_offset, v.bv_len),
-		memset(v.iov_base, 0, v.iov_len)
+		memset(v.iov_base, 0, v.iov_len),
+		memzero_page(v.bv_page, v.bv_offset, v.bv_len)
 	)
 
 	return bytes;
@@ -1006,7 +1071,9 @@ size_t iov_iter_copy_from_user_atomic(struct page *page,
 		copyin((p += v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
 		memcpy_from_page((p += v.bv_len) - v.bv_len, v.bv_page,
 				 v.bv_offset, v.bv_len),
-		memcpy((p += v.iov_len) - v.iov_len, v.iov_base, v.iov_len)
+		memcpy((p += v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
+		memcpy_from_page((p += v.bv_len) - v.bv_len, v.bv_page,
+				 v.bv_offset, v.bv_len)
 	)
 	kunmap_atomic(kaddr);
 	return bytes;
@@ -1077,7 +1144,12 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
 		i->count -= size;
 		return;
 	}
-	iterate_and_advance(i, size, v, 0, 0, 0)
+	if (unlikely(iov_iter_is_xarray(i))) {
+		i->iov_offset += size;
+		i->count -= size;
+		return;
+	}
+	iterate_and_advance(i, size, v, 0, 0, 0, 0)
 }
 EXPORT_SYMBOL(iov_iter_advance);
 
@@ -1121,7 +1193,12 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 		return;
 	}
 	unroll -= i->iov_offset;
-	if (iov_iter_is_bvec(i)) {
+	if (iov_iter_is_xarray(i)) {
+		BUG(); /* We should never go beyond the start of the specified
+			* range since we might then be straying into pages that
+			* aren't pinned.
+			*/
+	} else if (iov_iter_is_bvec(i)) {
 		const struct bio_vec *bvec = i->bvec;
 		while (1) {
 			size_t n = (--bvec)->bv_len;
@@ -1158,9 +1235,9 @@ size_t iov_iter_single_seg_count(const struct iov_iter *i)
 		return i->count;	// it is a silly place, anyway
 	if (i->nr_segs == 1)
 		return i->count;
-	if (unlikely(iov_iter_is_discard(i)))
+	if (unlikely(iov_iter_is_discard(i) || iov_iter_is_xarray(i)))
 		return i->count;
-	else if (iov_iter_is_bvec(i))
+	if (iov_iter_is_bvec(i))
 		return min(i->count, i->bvec->bv_len - i->iov_offset);
 	else
 		return min(i->count, i->iov->iov_len - i->iov_offset);
@@ -1208,6 +1285,31 @@ void iov_iter_pipe(struct iov_iter *i, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_pipe);
 
+/**
+ * iov_iter_xarray - Initialise an I/O iterator to use the pages in an xarray
+ * @i: The iterator to initialise.
+ * @direction: The direction of the transfer.
+ * @xarray: The xarray to access.
+ * @start: The start file position.
+ * @count: The size of the I/O buffer in bytes.
+ *
+ * Set up an I/O iterator to either draw data out of the pages attached to an
+ * inode or to inject data into those pages.  The pages *must* be prevented
+ * from evaporation, either by taking a ref on them or locking them by the
+ * caller.
+ */
+void iov_iter_xarray(struct iov_iter *i, unsigned int direction,
+		     struct xarray *xarray, loff_t start, size_t count)
+{
+	BUG_ON(direction & ~1);
+	i->type = ITER_XARRAY | (direction & (READ | WRITE));
+	i->xarray = xarray;
+	i->xarray_start = start;
+	i->count = count;
+	i->iov_offset = 0;
+}
+EXPORT_SYMBOL(iov_iter_xarray);
+
 /**
  * iov_iter_discard - Initialise an I/O iterator that discards data
  * @i: The iterator to initialise.
@@ -1241,7 +1343,8 @@ unsigned long iov_iter_alignment(const struct iov_iter *i)
 	iterate_all_kinds(i, size, v,
 		(res |= (unsigned long)v.iov_base | v.iov_len, 0),
 		res |= v.bv_offset | v.bv_len,
-		res |= (unsigned long)v.iov_base | v.iov_len
+		res |= (unsigned long)v.iov_base | v.iov_len,
+		res |= v.bv_offset | v.bv_len
 	)
 	return res;
 }
@@ -1263,7 +1366,9 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
 		(res |= (!res ? 0 : (unsigned long)v.bv_offset) |
 			(size != v.bv_len ? size : 0)),
 		(res |= (!res ? 0 : (unsigned long)v.iov_base) |
-			(size != v.iov_len ? size : 0))
+			(size != v.iov_len ? size : 0)),
+		(res |= (!res ? 0 : (unsigned long)v.bv_offset) |
+			(size != v.bv_len ? size : 0))
 		);
 	return res;
 }
@@ -1313,6 +1418,75 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 	return __pipe_get_pages(i, min(maxsize, capacity), pages, iter_head, start);
 }
 
+static ssize_t iter_xarray_copy_pages(struct page **pages, struct xarray *xa,
+				       pgoff_t index, unsigned int nr_pages)
+{
+	XA_STATE(xas, xa, index);
+	struct page *page;
+	unsigned int ret = 0;
+
+	rcu_read_lock();
+	for (page = xas_load(&xas); page; page = xas_next(&xas)) {
+		if (xas_retry(&xas, page))
+			continue;
+
+		/* Has the page moved or been split? */
+		if (unlikely(page != xas_reload(&xas))) {
+			xas_reset(&xas);
+			continue;
+		}
+
+		pages[ret] = find_subpage(page, xas.xa_index);
+		get_page(pages[ret]);
+		if (++ret == nr_pages)
+			break;
+	}
+	rcu_read_unlock();
+	return ret;
+}
+
+static ssize_t iter_xarray_get_pages(struct iov_iter *i,
+				     struct page **pages, size_t maxsize,
+				     unsigned maxpages, size_t *_start_offset)
+{
+	unsigned nr, offset;
+	pgoff_t index, count;
+	size_t size = maxsize, actual;
+	loff_t pos;
+
+	if (!size || !maxpages)
+		return 0;
+
+	pos = i->xarray_start + i->iov_offset;
+	index = pos >> PAGE_SHIFT;
+	offset = pos & ~PAGE_MASK;
+	*_start_offset = offset;
+
+	count = 1;
+	if (size > PAGE_SIZE - offset) {
+		size -= PAGE_SIZE - offset;
+		count += size >> PAGE_SHIFT;
+		size &= ~PAGE_MASK;
+		if (size)
+			count++;
+	}
+
+	if (count > maxpages)
+		count = maxpages;
+
+	nr = iter_xarray_copy_pages(pages, i->xarray, index, count);
+	if (nr == 0)
+		return 0;
+
+	actual = PAGE_SIZE * nr;
+	actual -= offset;
+	if (nr == count && size > 0) {
+		unsigned last_offset = (nr > 1) ? 0 : offset;
+		actual -= PAGE_SIZE - (last_offset + size);
+	}
+	return actual;
+}
+
 ssize_t iov_iter_get_pages(struct iov_iter *i,
 		   struct page **pages, size_t maxsize, unsigned maxpages,
 		   size_t *start)
@@ -1322,6 +1496,8 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 
 	if (unlikely(iov_iter_is_pipe(i)))
 		return pipe_get_pages(i, pages, maxsize, maxpages, start);
+	if (unlikely(iov_iter_is_xarray(i)))
+		return iter_xarray_get_pages(i, pages, maxsize, maxpages, start);
 	if (unlikely(iov_iter_is_discard(i)))
 		return -EFAULT;
 
@@ -1348,7 +1524,8 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 		return v.bv_len;
 	}),({
 		return -EFAULT;
-	})
+	}),
+	0
 	)
 	return 0;
 }
@@ -1392,6 +1569,51 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter *i,
 	return n;
 }
 
+static ssize_t iter_xarray_get_pages_alloc(struct iov_iter *i,
+					   struct page ***pages, size_t maxsize,
+					   size_t *_start_offset)
+{
+	struct page **p;
+	unsigned nr, offset;
+	pgoff_t index, count;
+	size_t size = maxsize, actual;
+	loff_t pos;
+
+	if (!size)
+		return 0;
+
+	pos = i->xarray_start + i->iov_offset;
+	index = pos >> PAGE_SHIFT;
+	offset = pos & ~PAGE_MASK;
+	*_start_offset = offset;
+
+	count = 1;
+	if (size > PAGE_SIZE - offset) {
+		size -= PAGE_SIZE - offset;
+		count += size >> PAGE_SHIFT;
+		size &= ~PAGE_MASK;
+		if (size)
+			count++;
+	}
+
+	p = get_pages_array(count);
+	if (!p)
+		return -ENOMEM;
+	*pages = p;
+
+	nr = iter_xarray_copy_pages(p, i->xarray, index, count);
+	if (nr == 0)
+		return 0;
+
+	actual = PAGE_SIZE * nr;
+	actual -= offset;
+	if (nr == count && size > 0) {
+		unsigned last_offset = (nr > 1) ? 0 : offset;
+		actual -= PAGE_SIZE - (last_offset + size);
+	}
+	return actual;
+}
+
 ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
 		   size_t *start)
@@ -1403,6 +1625,8 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 
 	if (unlikely(iov_iter_is_pipe(i)))
 		return pipe_get_pages_alloc(i, pages, maxsize, start);
+	if (unlikely(iov_iter_is_xarray(i)))
+		return iter_xarray_get_pages_alloc(i, pages, maxsize, start);
 	if (unlikely(iov_iter_is_discard(i)))
 		return -EFAULT;
 
@@ -1435,7 +1659,7 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		return v.bv_len;
 	}),({
 		return -EFAULT;
-	})
+	}), 0
 	)
 	return 0;
 }
@@ -1473,6 +1697,13 @@ size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 				      v.iov_base, v.iov_len,
 				      sum, off);
 		off += v.iov_len;
+	}), ({
+		char *p = kmap_atomic(v.bv_page);
+		sum = csum_and_memcpy((to += v.bv_len) - v.bv_len,
+				      p + v.bv_offset, v.bv_len,
+				      sum, off);
+		kunmap_atomic(p);
+		off += v.bv_len;
 	})
 	)
 	*csum = sum;
@@ -1514,6 +1745,13 @@ bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum,
 				      v.iov_base, v.iov_len,
 				      sum, off);
 		off += v.iov_len;
+	}), ({
+		char *p = kmap_atomic(v.bv_page);
+		sum = csum_and_memcpy((to += v.bv_len) - v.bv_len,
+				      p + v.bv_offset, v.bv_len,
+				      sum, off);
+		kunmap_atomic(p);
+		off += v.bv_len;
 	})
 	)
 	*csum = sum;
@@ -1559,6 +1797,13 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *csump,
 				     (from += v.iov_len) - v.iov_len,
 				     v.iov_len, sum, off);
 		off += v.iov_len;
+	}), ({
+		char *p = kmap_atomic(v.bv_page);
+		sum = csum_and_memcpy(p + v.bv_offset,
+				      (from += v.bv_len) - v.bv_len,
+				      v.bv_len, sum, off);
+		kunmap_atomic(p);
+		off += v.bv_len;
 	})
 	)
 	*csum = sum;
@@ -1608,6 +1853,21 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
 		npages = pipe_space_for_user(iter_head, pipe->tail, pipe);
 		if (npages >= maxpages)
 			return maxpages;
+	} else if (unlikely(iov_iter_is_xarray(i))) {
+		unsigned offset;
+
+		offset = (i->xarray_start + i->iov_offset) & ~PAGE_MASK;
+
+		npages = 1;
+		if (size > PAGE_SIZE - offset) {
+			size -= PAGE_SIZE - offset;
+			npages += size >> PAGE_SHIFT;
+			size &= ~PAGE_MASK;
+			if (size)
+				npages++;
+		}
+		if (npages >= maxpages)
+			return maxpages;
 	} else iterate_all_kinds(i, size, v, ({
 		unsigned long p = (unsigned long)v.iov_base;
 		npages += DIV_ROUND_UP(p + v.iov_len, PAGE_SIZE)
@@ -1624,7 +1884,8 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
 			- p / PAGE_SIZE;
 		if (npages >= maxpages)
 			return maxpages;
-	})
+	}),
+	0
 	)
 	return npages;
 }
@@ -1637,7 +1898,7 @@ const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags)
 		WARN_ON(1);
 		return NULL;
 	}
-	if (unlikely(iov_iter_is_discard(new)))
+	if (unlikely(iov_iter_is_discard(new) || iov_iter_is_xarray(new)))
 		return NULL;
 	if (iov_iter_is_bvec(new))
 		return new->bvec = kmemdup(new->bvec,
@@ -1842,7 +2103,12 @@ int iov_iter_for_each_range(struct iov_iter *i, size_t bytes,
 		kunmap(v.bv_page);
 		err;}), ({
 		w = v;
-		err = f(&w, context);})
+		err = f(&w, context);}), ({
+		w.iov_base = kmap(v.bv_page) + v.bv_offset;
+		w.iov_len = v.bv_len;
+		err = f(&w, context);
+		kunmap(v.bv_page);
+		err;})
 	)
 	return err;
 }


