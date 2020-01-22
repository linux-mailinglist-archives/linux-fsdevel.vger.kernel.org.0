Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF3814584A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 15:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgAVO6F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 09:58:05 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45477 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725802AbgAVO6F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 09:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579705083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NbFL6Nm+gTuF/ZjfMWiwpz1MxSD+F4ECK+nLjL1DDSs=;
        b=Lm0CKFS/xva2HApHODK7AfPDTuVPPSxnscOww/zLzfuPNbxJ47cn3DGQYB2sScOW1Nd9mE
        tE1AvE2seGgFWpqOHnWKw3bFp1isH8KOSMM0dtqQf3Yyv/YT4gsrzzd2Q+gZdFXOimOunx
        JIcAC6ld7KPA7E+TDLszQzPMTAQEHDA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-rNSeMyMYN423cwcILAiRAw-1; Wed, 22 Jan 2020 09:57:59 -0500
X-MC-Unique: rNSeMyMYN423cwcILAiRAw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1E40800D41;
        Wed, 22 Jan 2020 14:57:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-49.rdu2.redhat.com [10.10.120.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E583C8572D;
        Wed, 22 Jan 2020 14:57:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] iov_iter: Add ITER_MAPPING
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3577429.1579705075.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 22 Jan 2020 14:57:55 +0000
Message-ID: <3577430.1579705075@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add an iterator, ITER_MAPPING, that walks through a set of pages attached
to an address_space, starting at a given file position and length.

The caller must guarantee that the pages are all present and they must be
locked is some way[*] (eg. ref, PG_locked, PG_writeback or PG_fscache) to
prevent them from going away or being migrated whilst they're being
accessed.

[*] Note that I'm assuming that a page cannot get detached from or replace=
d
    in a mapping if it is so 'locked' without permission from the
    appropriate address_space operation.

This is useful for copying data from socket buffers to inodes in network
filesystems and for transferring data between those inodes and the cache
using direct I/O.

Whilst it is true that ITER_BVEC could be used instead, the following
issues arise:

 (1) A bio_vec array would need to be allocated to list to all the pages -
     which is redundant if inode->i_pages *also* points to all these pages=
.

 (2) A bio_vec array might exceed the size of a page (a page-sized bio_vec
     array would correspond to a 1M payload on a 64-bit machine with 4K
     pages).

 (3) The offset and length fields in the bio_vec elements are superfluous
     in this situation.

An alternative could be to have an "ITER_ARRAY" that just has the page
pointers and not the offset/length info.  This decreases the redundancy an=
d
increases the max payload-per-array-page to 2M.

I've been using this in my rewrite of fscache/cachefiles, which can be
found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Dfscache-iter

Signed-off-by: David Howells <dhowells@redhat.com>
---
 include/linux/uio.h |   11 ++
 lib/iov_iter.c      |  282 ++++++++++++++++++++++++++++++++++++++++++++++=
+-----
 2 files changed, 270 insertions(+), 23 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 9576fd8158d7..a0321a740f51 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -11,6 +11,7 @@
 #include <uapi/linux/uio.h>
 =

 struct page;
+struct address_space;
 struct pipe_inode_info;
 =

 struct kvec {
@@ -25,6 +26,7 @@ enum iter_type {
 	ITER_BVEC =3D 16,
 	ITER_PIPE =3D 32,
 	ITER_DISCARD =3D 64,
+	ITER_MAPPING =3D 128,
 };
 =

 struct iov_iter {
@@ -40,6 +42,7 @@ struct iov_iter {
 		const struct iovec *iov;
 		const struct kvec *kvec;
 		const struct bio_vec *bvec;
+		struct address_space *mapping;
 		struct pipe_inode_info *pipe;
 	};
 	union {
@@ -48,6 +51,7 @@ struct iov_iter {
 			unsigned int head;
 			unsigned int start_head;
 		};
+		loff_t mapping_start;
 	};
 };
 =

@@ -81,6 +85,11 @@ static inline bool iov_iter_is_discard(const struct iov=
_iter *i)
 	return iov_iter_type(i) =3D=3D ITER_DISCARD;
 }
 =

+static inline bool iov_iter_is_mapping(const struct iov_iter *i)
+{
+	return iov_iter_type(i) =3D=3D ITER_MAPPING;
+}
+
 static inline unsigned char iov_iter_rw(const struct iov_iter *i)
 {
 	return i->type & (READ | WRITE);
@@ -222,6 +231,8 @@ void iov_iter_bvec(struct iov_iter *i, unsigned int di=
rection, const struct bio_
 void iov_iter_pipe(struct iov_iter *i, unsigned int direction, struct pip=
e_inode_info *pipe,
 			size_t count);
 void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t =
count);
+void iov_iter_mapping(struct iov_iter *i, unsigned int direction, struct =
address_space *mapping,
+		      loff_t start, size_t count);
 ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
 ssize_t iov_iter_get_pages_alloc(struct iov_iter *i, struct page ***pages=
,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 51595bf3af85..7c108824414c 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -74,7 +74,40 @@
 	}						\
 }
 =

-#define iterate_all_kinds(i, n, v, I, B, K) {			\
+#define iterate_mapping(i, n, __v, skip, STEP) {		\
+	struct page *page;					\
+	size_t wanted =3D n, seg, offset;				\
+	loff_t start =3D i->mapping_start + skip;			\
+	pgoff_t index =3D start >> PAGE_SHIFT;			\
+								\
+	XA_STATE(xas, &i->mapping->i_pages, index);		\
+								\
+	rcu_read_lock();						\
+	for (page =3D xas_load(&xas); page; page =3D xas_next(&xas)) {	\
+		if (xas_retry(&xas, page))				\
+			continue;					\
+		if (xa_is_value(page))					\
+			break;						\
+		if (PageCompound(page))					\
+			break;						\
+		if (page_to_pgoff(page) !=3D xas.xa_index)		\
+			break;						\
+		__v.bv_page =3D page;					\
+		offset =3D (i->mapping_start + skip) & ~PAGE_MASK;	\
+		seg =3D PAGE_SIZE - offset;			\
+		__v.bv_offset =3D offset;				\
+		__v.bv_len =3D min(n, seg);			\
+		(void)(STEP);					\
+		n -=3D __v.bv_len;				\
+		skip +=3D __v.bv_len;				\
+		if (n =3D=3D 0)					\
+			break;					\
+	}							\
+	rcu_read_unlock();					\
+	n =3D wanted - n;						\
+}
+
+#define iterate_all_kinds(i, n, v, I, B, K, M) {		\
 	if (likely(n)) {					\
 		size_t skip =3D i->iov_offset;			\
 		if (unlikely(i->type & ITER_BVEC)) {		\
@@ -86,6 +119,9 @@
 			struct kvec v;				\
 			iterate_kvec(i, n, v, kvec, skip, (K))	\
 		} else if (unlikely(i->type & ITER_DISCARD)) {	\
+		} else if (unlikely(i->type & ITER_MAPPING)) {	\
+			struct bio_vec v;			\
+			iterate_mapping(i, n, v, skip, (M));	\
 		} else {					\
 			const struct iovec *iov;		\
 			struct iovec v;				\
@@ -94,7 +130,7 @@
 	}							\
 }
 =

-#define iterate_and_advance(i, n, v, I, B, K) {			\
+#define iterate_and_advance(i, n, v, I, B, K, M) {		\
 	if (unlikely(i->count < n))				\
 		n =3D i->count;					\
 	if (i->count) {						\
@@ -119,6 +155,9 @@
 			i->kvec =3D kvec;				\
 		} else if (unlikely(i->type & ITER_DISCARD)) {	\
 			skip +=3D n;				\
+		} else if (unlikely(i->type & ITER_MAPPING)) {	\
+			struct bio_vec v;			\
+			iterate_mapping(i, n, v, skip, (M))	\
 		} else {					\
 			const struct iovec *iov;		\
 			struct iovec v;				\
@@ -628,7 +667,9 @@ size_t _copy_to_iter(const void *addr, size_t bytes, s=
truct iov_iter *i)
 		copyout(v.iov_base, (from +=3D v.iov_len) - v.iov_len, v.iov_len),
 		memcpy_to_page(v.bv_page, v.bv_offset,
 			       (from +=3D v.bv_len) - v.bv_len, v.bv_len),
-		memcpy(v.iov_base, (from +=3D v.iov_len) - v.iov_len, v.iov_len)
+		memcpy(v.iov_base, (from +=3D v.iov_len) - v.iov_len, v.iov_len),
+		memcpy_to_page(v.bv_page, v.bv_offset,
+			       (from +=3D v.bv_len) - v.bv_len, v.bv_len)
 	)
 =

 	return bytes;
@@ -746,6 +787,15 @@ size_t _copy_to_iter_mcsafe(const void *addr, size_t =
bytes, struct iov_iter *i)
 			bytes =3D curr_addr - s_addr - rem;
 			return bytes;
 		}
+		}),
+		({
+		rem =3D memcpy_mcsafe_to_page(v.bv_page, v.bv_offset,
+                               (from +=3D v.bv_len) - v.bv_len, v.bv_len)=
;
+		if (rem) {
+			curr_addr =3D (unsigned long) from;
+			bytes =3D curr_addr - s_addr - rem;
+			return bytes;
+		}
 		})
 	)
 =

@@ -767,7 +817,9 @@ size_t _copy_from_iter(void *addr, size_t bytes, struc=
t iov_iter *i)
 		copyin((to +=3D v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
 		memcpy_from_page((to +=3D v.bv_len) - v.bv_len, v.bv_page,
 				 v.bv_offset, v.bv_len),
-		memcpy((to +=3D v.iov_len) - v.iov_len, v.iov_base, v.iov_len)
+		memcpy((to +=3D v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
+		memcpy_from_page((to +=3D v.bv_len) - v.bv_len, v.bv_page,
+				 v.bv_offset, v.bv_len)
 	)
 =

 	return bytes;
@@ -793,7 +845,9 @@ bool _copy_from_iter_full(void *addr, size_t bytes, st=
ruct iov_iter *i)
 		0;}),
 		memcpy_from_page((to +=3D v.bv_len) - v.bv_len, v.bv_page,
 				 v.bv_offset, v.bv_len),
-		memcpy((to +=3D v.iov_len) - v.iov_len, v.iov_base, v.iov_len)
+		memcpy((to +=3D v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
+		memcpy_from_page((to +=3D v.bv_len) - v.bv_len, v.bv_page,
+				 v.bv_offset, v.bv_len)
 	)
 =

 	iov_iter_advance(i, bytes);
@@ -813,7 +867,9 @@ size_t _copy_from_iter_nocache(void *addr, size_t byte=
s, struct iov_iter *i)
 					 v.iov_base, v.iov_len),
 		memcpy_from_page((to +=3D v.bv_len) - v.bv_len, v.bv_page,
 				 v.bv_offset, v.bv_len),
-		memcpy((to +=3D v.iov_len) - v.iov_len, v.iov_base, v.iov_len)
+		memcpy((to +=3D v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
+		memcpy_from_page((to +=3D v.bv_len) - v.bv_len, v.bv_page,
+				 v.bv_offset, v.bv_len)
 	)
 =

 	return bytes;
@@ -848,7 +904,9 @@ size_t _copy_from_iter_flushcache(void *addr, size_t b=
ytes, struct iov_iter *i)
 		memcpy_page_flushcache((to +=3D v.bv_len) - v.bv_len, v.bv_page,
 				 v.bv_offset, v.bv_len),
 		memcpy_flushcache((to +=3D v.iov_len) - v.iov_len, v.iov_base,
-			v.iov_len)
+			v.iov_len),
+		memcpy_page_flushcache((to +=3D v.bv_len) - v.bv_len, v.bv_page,
+				 v.bv_offset, v.bv_len)
 	)
 =

 	return bytes;
@@ -872,7 +930,9 @@ bool _copy_from_iter_full_nocache(void *addr, size_t b=
ytes, struct iov_iter *i)
 		0;}),
 		memcpy_from_page((to +=3D v.bv_len) - v.bv_len, v.bv_page,
 				 v.bv_offset, v.bv_len),
-		memcpy((to +=3D v.iov_len) - v.iov_len, v.iov_base, v.iov_len)
+		memcpy((to +=3D v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
+		memcpy_from_page((to +=3D v.bv_len) - v.bv_len, v.bv_page,
+				 v.bv_offset, v.bv_len)
 	)
 =

 	iov_iter_advance(i, bytes);
@@ -909,7 +969,7 @@ size_t copy_page_to_iter(struct page *page, size_t off=
set, size_t bytes,
 {
 	if (unlikely(!page_copy_sane(page, offset, bytes)))
 		return 0;
-	if (i->type & (ITER_BVEC|ITER_KVEC)) {
+	if (i->type & (ITER_BVEC | ITER_KVEC | ITER_MAPPING)) {
 		void *kaddr =3D kmap_atomic(page);
 		size_t wanted =3D copy_to_iter(kaddr + offset, bytes, i);
 		kunmap_atomic(kaddr);
@@ -932,7 +992,7 @@ size_t copy_page_from_iter(struct page *page, size_t o=
ffset, size_t bytes,
 		WARN_ON(1);
 		return 0;
 	}
-	if (i->type & (ITER_BVEC|ITER_KVEC)) {
+	if (i->type & (ITER_BVEC | ITER_KVEC | ITER_MAPPING)) {
 		void *kaddr =3D kmap_atomic(page);
 		size_t wanted =3D _copy_from_iter(kaddr + offset, bytes, i);
 		kunmap_atomic(kaddr);
@@ -976,7 +1036,8 @@ size_t iov_iter_zero(size_t bytes, struct iov_iter *i=
)
 	iterate_and_advance(i, bytes, v,
 		clear_user(v.iov_base, v.iov_len),
 		memzero_page(v.bv_page, v.bv_offset, v.bv_len),
-		memset(v.iov_base, 0, v.iov_len)
+		memset(v.iov_base, 0, v.iov_len),
+		memzero_page(v.bv_page, v.bv_offset, v.bv_len)
 	)
 =

 	return bytes;
@@ -1000,7 +1061,9 @@ size_t iov_iter_copy_from_user_atomic(struct page *p=
age,
 		copyin((p +=3D v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
 		memcpy_from_page((p +=3D v.bv_len) - v.bv_len, v.bv_page,
 				 v.bv_offset, v.bv_len),
-		memcpy((p +=3D v.iov_len) - v.iov_len, v.iov_base, v.iov_len)
+		memcpy((p +=3D v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
+		memcpy_from_page((p +=3D v.bv_len) - v.bv_len, v.bv_page,
+				 v.bv_offset, v.bv_len)
 	)
 	kunmap_atomic(kaddr);
 	return bytes;
@@ -1071,7 +1134,13 @@ void iov_iter_advance(struct iov_iter *i, size_t si=
ze)
 		i->count -=3D size;
 		return;
 	}
-	iterate_and_advance(i, size, v, 0, 0, 0)
+	if (unlikely(iov_iter_is_mapping(i))) {
+		/* We really don't want to fetch pages if we can avoid it */
+		i->iov_offset +=3D size;
+		i->count -=3D size;
+		return;
+	}
+	iterate_and_advance(i, size, v, 0, 0, 0, 0)
 }
 EXPORT_SYMBOL(iov_iter_advance);
 =

@@ -1115,7 +1184,12 @@ void iov_iter_revert(struct iov_iter *i, size_t unr=
oll)
 		return;
 	}
 	unroll -=3D i->iov_offset;
-	if (iov_iter_is_bvec(i)) {
+	if (iov_iter_is_mapping(i)) {
+		BUG(); /* We should never go beyond the start of the specified
+			* range since we might then be straying into pages that
+			* aren't pinned.
+			*/
+	} else if (iov_iter_is_bvec(i)) {
 		const struct bio_vec *bvec =3D i->bvec;
 		while (1) {
 			size_t n =3D (--bvec)->bv_len;
@@ -1152,9 +1226,9 @@ size_t iov_iter_single_seg_count(const struct iov_it=
er *i)
 		return i->count;	// it is a silly place, anyway
 	if (i->nr_segs =3D=3D 1)
 		return i->count;
-	if (unlikely(iov_iter_is_discard(i)))
+	if (unlikely(iov_iter_is_discard(i) || iov_iter_is_mapping(i)))
 		return i->count;
-	else if (iov_iter_is_bvec(i))
+	if (iov_iter_is_bvec(i))
 		return min(i->count, i->bvec->bv_len - i->iov_offset);
 	else
 		return min(i->count, i->iov->iov_len - i->iov_offset);
@@ -1202,6 +1276,32 @@ void iov_iter_pipe(struct iov_iter *i, unsigned int=
 direction,
 }
 EXPORT_SYMBOL(iov_iter_pipe);
 =

+/**
+ * iov_iter_mapping - Initialise an I/O iterator to use the pages in a ma=
pping
+ * @i: The iterator to initialise.
+ * @direction: The direction of the transfer.
+ * @mapping: The mapping to access.
+ * @start: The start file position.
+ * @count: The size of the I/O buffer in bytes.
+ *
+ * Set up an I/O iterator to either draw data out of the pages attached t=
o an
+ * inode or to inject data into those pages.  The pages *must* be prevent=
ed
+ * from evaporation, either by taking a ref on them or locking them by th=
e
+ * caller.
+ */
+void iov_iter_mapping(struct iov_iter *i, unsigned int direction,
+		      struct address_space *mapping,
+		      loff_t start, size_t count)
+{
+	BUG_ON(direction & ~1);
+	i->type =3D ITER_MAPPING | (direction & (READ | WRITE));
+	i->mapping =3D mapping;
+	i->mapping_start =3D start;
+	i->count =3D count;
+	i->iov_offset =3D 0;
+}
+EXPORT_SYMBOL(iov_iter_mapping);
+
 /**
  * iov_iter_discard - Initialise an I/O iterator that discards data
  * @i: The iterator to initialise.
@@ -1235,7 +1335,8 @@ unsigned long iov_iter_alignment(const struct iov_it=
er *i)
 	iterate_all_kinds(i, size, v,
 		(res |=3D (unsigned long)v.iov_base | v.iov_len, 0),
 		res |=3D v.bv_offset | v.bv_len,
-		res |=3D (unsigned long)v.iov_base | v.iov_len
+		res |=3D (unsigned long)v.iov_base | v.iov_len,
+		res |=3D v.bv_offset | v.bv_len
 	)
 	return res;
 }
@@ -1257,7 +1358,9 @@ unsigned long iov_iter_gap_alignment(const struct io=
v_iter *i)
 		(res |=3D (!res ? 0 : (unsigned long)v.bv_offset) |
 			(size !=3D v.bv_len ? size : 0)),
 		(res |=3D (!res ? 0 : (unsigned long)v.iov_base) |
-			(size !=3D v.iov_len ? size : 0))
+			(size !=3D v.iov_len ? size : 0)),
+		(res |=3D (!res ? 0 : (unsigned long)v.bv_offset) |
+			(size !=3D v.bv_len ? size : 0))
 		);
 	return res;
 }
@@ -1307,6 +1410,46 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 	return __pipe_get_pages(i, min(maxsize, capacity), pages, iter_head, sta=
rt);
 }
 =

+static ssize_t iter_mapping_get_pages(struct iov_iter *i,
+				      struct page **pages, size_t maxsize,
+				      unsigned maxpages, size_t *_start_offset)
+{
+	unsigned nr, offset;
+	pgoff_t index, count;
+	size_t size =3D maxsize, actual;
+	loff_t pos;
+
+	if (!size || !maxpages)
+		return 0;
+
+	pos =3D i->mapping_start + i->iov_offset;
+	index =3D pos >> PAGE_SHIFT;
+	offset =3D pos & ~PAGE_MASK;
+	*_start_offset =3D offset;
+
+	count =3D 1;
+	if (size > PAGE_SIZE - offset) {
+		size -=3D PAGE_SIZE - offset;
+		count +=3D size >> PAGE_SHIFT;
+		size &=3D ~PAGE_MASK;
+		if (size)
+			count++;
+	}
+
+	if (count > maxpages)
+		count =3D maxpages;
+
+	nr =3D find_get_pages_contig(i->mapping, index, count, pages);
+	if (nr =3D=3D 0)
+		return 0;
+
+	actual =3D PAGE_SIZE * nr;
+	actual -=3D offset;
+	if (nr =3D=3D count && size > 0)
+		actual -=3D PAGE_SIZE - size;
+	return actual;
+}
+
 ssize_t iov_iter_get_pages(struct iov_iter *i,
 		   struct page **pages, size_t maxsize, unsigned maxpages,
 		   size_t *start)
@@ -1316,6 +1459,8 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 =

 	if (unlikely(iov_iter_is_pipe(i)))
 		return pipe_get_pages(i, pages, maxsize, maxpages, start);
+	if (unlikely(iov_iter_is_mapping(i)))
+		return iter_mapping_get_pages(i, pages, maxsize, maxpages, start);
 	if (unlikely(iov_iter_is_discard(i)))
 		return -EFAULT;
 =

@@ -1342,7 +1487,8 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 		return v.bv_len;
 	}),({
 		return -EFAULT;
-	})
+	}),
+	0
 	)
 	return 0;
 }
@@ -1386,6 +1532,49 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter=
 *i,
 	return n;
 }
 =

+static ssize_t iter_mapping_get_pages_alloc(struct iov_iter *i,
+					    struct page ***pages, size_t maxsize,
+					    size_t *_start_offset)
+{
+	struct page **p;
+	unsigned nr, offset;
+	pgoff_t index, count;
+	size_t size =3D maxsize, actual;
+	loff_t pos;
+
+	if (!size)
+		return 0;
+
+	pos =3D i->mapping_start + i->iov_offset;
+	index =3D pos >> PAGE_SHIFT;
+	offset =3D pos & ~PAGE_MASK;
+	*_start_offset =3D offset;
+
+	count =3D 1;
+	if (size > PAGE_SIZE - offset) {
+		size -=3D PAGE_SIZE - offset;
+		count +=3D size >> PAGE_SHIFT;
+		size &=3D ~PAGE_MASK;
+		if (size)
+			count++;
+	}
+
+	p =3D get_pages_array(count);
+	if (!p)
+		return -ENOMEM;
+	*pages =3D p;
+
+	nr =3D find_get_pages_contig(i->mapping, index, count, p);
+	if (nr =3D=3D 0)
+		return 0;
+
+	actual =3D PAGE_SIZE * nr;
+	actual -=3D offset;
+	if (nr =3D=3D count && size > 0)
+		actual -=3D PAGE_SIZE - size;
+	return actual;
+}
+
 ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
 		   size_t *start)
@@ -1397,6 +1586,8 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 =

 	if (unlikely(iov_iter_is_pipe(i)))
 		return pipe_get_pages_alloc(i, pages, maxsize, start);
+	if (unlikely(iov_iter_is_mapping(i)))
+		return iter_mapping_get_pages_alloc(i, pages, maxsize, start);
 	if (unlikely(iov_iter_is_discard(i)))
 		return -EFAULT;
 =

@@ -1429,7 +1620,7 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		return v.bv_len;
 	}),({
 		return -EFAULT;
-	})
+	}), 0
 	)
 	return 0;
 }
@@ -1468,6 +1659,14 @@ size_t csum_and_copy_from_iter(void *addr, size_t b=
ytes, __wsum *csum,
 				      v.iov_base, v.iov_len,
 				      sum, off);
 		off +=3D v.iov_len;
+	}), ({
+		char *p =3D kmap_atomic(v.bv_page);
+		next =3D csum_partial_copy_nocheck(p + v.bv_offset,
+						 (to +=3D v.bv_len) - v.bv_len,
+						 v.bv_len, 0);
+		kunmap_atomic(p);
+		sum =3D csum_block_add(sum, next, off);
+		off +=3D v.bv_len;
 	})
 	)
 	*csum =3D sum;
@@ -1510,6 +1709,14 @@ bool csum_and_copy_from_iter_full(void *addr, size_=
t bytes, __wsum *csum,
 				      v.iov_base, v.iov_len,
 				      sum, off);
 		off +=3D v.iov_len;
+	}), ({
+		char *p =3D kmap_atomic(v.bv_page);
+		next =3D csum_partial_copy_nocheck(p + v.bv_offset,
+						 (to +=3D v.bv_len) - v.bv_len,
+						 v.bv_len, 0);
+		kunmap_atomic(p);
+		sum =3D csum_block_add(sum, next, off);
+		off +=3D v.bv_len;
 	})
 	)
 	*csum =3D sum;
@@ -1556,6 +1763,14 @@ size_t csum_and_copy_to_iter(const void *addr, size=
_t bytes, void *csump,
 				     (from +=3D v.iov_len) - v.iov_len,
 				     v.iov_len, sum, off);
 		off +=3D v.iov_len;
+	}), ({
+		char *p =3D kmap_atomic(v.bv_page);
+		next =3D csum_partial_copy_nocheck((from +=3D v.bv_len) - v.bv_len,
+						 p + v.bv_offset,
+						 v.bv_len, 0);
+		kunmap_atomic(p);
+		sum =3D csum_block_add(sum, next, off);
+		off +=3D v.bv_len;
 	})
 	)
 	*csum =3D sum;
@@ -1605,6 +1820,21 @@ int iov_iter_npages(const struct iov_iter *i, int m=
axpages)
 		npages =3D pipe_space_for_user(iter_head, pipe->tail, pipe);
 		if (npages >=3D maxpages)
 			return maxpages;
+	} else if (unlikely(iov_iter_is_mapping(i))) {
+		unsigned offset;
+
+		offset =3D (i->mapping_start + i->iov_offset) & ~PAGE_MASK;
+
+		npages =3D 1;
+		if (size > PAGE_SIZE - offset) {
+			size -=3D PAGE_SIZE - offset;
+			npages +=3D size >> PAGE_SHIFT;
+			size &=3D ~PAGE_MASK;
+			if (size)
+				npages++;
+		}
+		if (npages >=3D maxpages)
+			return maxpages;
 	} else iterate_all_kinds(i, size, v, ({
 		unsigned long p =3D (unsigned long)v.iov_base;
 		npages +=3D DIV_ROUND_UP(p + v.iov_len, PAGE_SIZE)
@@ -1621,7 +1851,8 @@ int iov_iter_npages(const struct iov_iter *i, int ma=
xpages)
 			- p / PAGE_SIZE;
 		if (npages >=3D maxpages)
 			return maxpages;
-	})
+	}),
+	0
 	)
 	return npages;
 }
@@ -1634,7 +1865,7 @@ const void *dup_iter(struct iov_iter *new, struct io=
v_iter *old, gfp_t flags)
 		WARN_ON(1);
 		return NULL;
 	}
-	if (unlikely(iov_iter_is_discard(new)))
+	if (unlikely(iov_iter_is_discard(new) || iov_iter_is_mapping(new)))
 		return NULL;
 	if (iov_iter_is_bvec(new))
 		return new->bvec =3D kmemdup(new->bvec,
@@ -1746,7 +1977,12 @@ int iov_iter_for_each_range(struct iov_iter *i, siz=
e_t bytes,
 		kunmap(v.bv_page);
 		err;}), ({
 		w =3D v;
-		err =3D f(&w, context);})
+		err =3D f(&w, context);}), ({
+		w.iov_base =3D kmap(v.bv_page) + v.bv_offset;
+		w.iov_len =3D v.bv_len;
+		err =3D f(&w, context);
+		kunmap(v.bv_page);
+		err;})
 	)
 	return err;
 }

