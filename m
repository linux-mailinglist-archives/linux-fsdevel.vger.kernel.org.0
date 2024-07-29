Return-Path: <linux-fsdevel+bounces-24477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D6693FAE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 18:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD522288618
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 16:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B6E18E771;
	Mon, 29 Jul 2024 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A3p4Qj1R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B0C185E53
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722270117; cv=none; b=Rf0yH1va2KIdkz6+0rCuRvNOAaGWyl7PDFUsk6xsH+podA5wjUwi+YZ1a4zvEamrpGSWXCcSf4s/ywSbkzBqM0luHnmP+Q5ntCI31nSgdlrY8iRuxAeIcCyGMPpQ9KCoWg0QlHdXoKxQe6D5P9YcHYJckttu6veog9zCO1a3FiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722270117; c=relaxed/simple;
	bh=b/9xvZr+8DLGVVBgUM7+BweH8v54fK80zJIDMTkkZA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rRcxiK0cprZlQAZLv0tv2F7ec4q9ij8742RSg56GX9HnfQjdVKV+cNEnbJH69KM3L/dUXlyH4vqwc/21gZ10Rf/Coz0dwgdhJwqO8qoUr4N8XuwIwoyrYgJRHkUc30A0DJqn7FzrLuFWphbEh76CAv4SGK+yM0WfZScJeajIaUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A3p4Qj1R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722270112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8cl3C3Ej4bHRl/eoo7c6wQCczYGfGGuYw62pTsRHbhI=;
	b=A3p4Qj1R5UTQ1lwSUtVfO+4BaUKihWQuf69wZocthG7N+1cPZ39HnDQwB1zAYoQUBOa6YM
	TQt40DOySOFWS9f2hIwkkCkPpdTqLxbmu9b8+KntFTFbg3B/tEx3SfR4Ui9js3XSbS61kx
	IhquRggQeJHxvfotgH6xa44UDM8eaYE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-Z3XflSWcNS-W2HdeZ4NDCg-1; Mon,
 29 Jul 2024 12:21:48 -0400
X-MC-Unique: Z3XflSWcNS-W2HdeZ4NDCg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7DA421955D48;
	Mon, 29 Jul 2024 16:21:44 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.216])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4E7401955D42;
	Mon, 29 Jul 2024 16:21:37 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steve French <sfrench@samba.org>,
	Gao Xiang <xiang@kernel.org>,
	Mike Marshall <hubcap@omnibond.com>,
	devel@lists.orangefs.org
Subject: [PATCH 12/24] mm: Define struct folio_queue and ITER_FOLIOQ to handle a sequence of folios
Date: Mon, 29 Jul 2024 17:19:41 +0100
Message-ID: <20240729162002.3436763-13-dhowells@redhat.com>
In-Reply-To: <20240729162002.3436763-1-dhowells@redhat.com>
References: <20240729162002.3436763-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Define a data structure, struct folio_queue, to represent a sequence of
folios and a kernel-internal I/O iterator type, ITER_FOLIOQ, to allow a
list of folio_queue structures to be used to provide a buffer to
iov_iter-taking functions, such as sendmsg and recvmsg.

The folio_queue structure looks like:

	struct folio_queue {
		struct folio_batch	vec;
		u8			orders[PAGEVEC_SIZE];
		struct folio_queue	*next;
		struct folio_queue	*prev;
		unsigned long		marks;
		unsigned long		marks2;
	};

It does not use a list_head so that next and/or prev can be set to NULL at
the ends of the list, allowing iov_iter-handling routines to determine that
they *are* the ends without needing to store a head pointer in the iov_iter
struct.

A folio_batch struct is used to hold the folio pointers which allows the
batch to be passed to batch handling functions.  Two mark bits are
available per slot.  The intention is to use at least one of them to mark
folios that need putting, but that might not be ultimately necessary.
Accessor functions are used to access the slots to do the masking and an
additional accessor function is used to indicate the size of the array.

The order of each folio is also stored in the structure to avoid the need
for iov_iter_advance() and iov_iter_revert() to have to query each folio to
find its size.

With careful barriering, this can be used as an extending buffer with new
folios inserted and new folio_queue structs added without the need for a
lock.  Further, provided we always keep at least one struct in the buffer,
we can also remove consumed folios and consumed structs from the head end
as we without the need for locks.

[Questions/thoughts]

 (1) To manage this, I need a head pointer, a tail pointer, a tail slot
     number (assuming insertion happens at the tail end and the next
     pointers point from head to tail).  Should I put these into a struct
     of their own, say "folio_queue_head" or "rolling_buffer"?

     I will end up with two of these in netfs_io_request eventually, one
     keeping track of the pagecache I'm dealing with for buffered I/O and
     the other to hold a bounce buffer when we need one.

 (2) Should I make the slots {folio,off,len} or bio_vec?

 (3) This is intended to replace ITER_XARRAY eventually.  Using an xarray
     in I/O iteration requires the taking of the RCU read lock, doing
     copying under the RCU read lock, walking the xarray (which may change
     under us), handling retries and dealing with special values.

     The advantage of ITER_XARRAY is that when we're dealing with the
     pagecache directly, we don't need any allocation - but if we're doing
     encrypted comms, there's a good chance we'd be using a bounce buffer
     anyway.

     This will require afs, erofs, cifs, orangefs and fscache to be
     converted to not use this.  afs still uses it for dirs and symlinks;
     some of erofs usages should be easy to change, but there's one which
     won't be so easy; ceph's use via fscache can be fixed by porting ceph
     to netfslib; cifs is using xarray as a bounce buffer - that can be
     moved to use sheaves instead; and orangefs has a similar problem to
     erofs - maybe orangefs could use netfslib?

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: Steve French <sfrench@samba.org>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Gao Xiang <xiang@kernel.org>
cc: Mike Marshall <hubcap@omnibond.com>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
cc: linux-afs@lists.infradead.org
cc: linux-cifs@vger.kernel.org
cc: ceph-devel@vger.kernel.org
cc: linux-erofs@lists.ozlabs.org
cc: devel@lists.orangefs.org
---
 include/linux/folio_queue.h | 138 +++++++++++++++++++
 include/linux/iov_iter.h    |  57 ++++++++
 include/linux/uio.h         |  12 ++
 lib/iov_iter.c              | 229 ++++++++++++++++++++++++++++++-
 lib/kunit_iov_iter.c        | 259 ++++++++++++++++++++++++++++++++++++
 lib/scatterlist.c           |  69 +++++++++-
 6 files changed, 760 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/folio_queue.h

diff --git a/include/linux/folio_queue.h b/include/linux/folio_queue.h
new file mode 100644
index 000000000000..52773613bf23
--- /dev/null
+++ b/include/linux/folio_queue.h
@@ -0,0 +1,138 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Queue of folios definitions
+ *
+ * Copyright (C) 2024 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#ifndef _LINUX_FOLIO_QUEUE_H
+#define _LINUX_FOLIO_QUEUE_H
+
+#include <linux/pagevec.h>
+
+/*
+ * Segment in a queue of running buffers.  Each segment can hold a number of
+ * folios and a portion of the queue can be referenced with the ITER_FOLIOQ
+ * iterator.  The possibility exists of inserting non-folio elements into the
+ * queue (such as gaps).
+ *
+ * Explicit prev and next pointers are used instead of a list_head to make it
+ * easier to add segments to tail and remove them from the head without the
+ * need for a lock.
+ */
+struct folio_queue {
+	struct folio_batch	vec;		/* Folios in the queue segment */
+	u8			orders[PAGEVEC_SIZE]; /* Order of each folio */
+	struct folio_queue	*next;		/* Next queue segment or NULL */
+	struct folio_queue	*prev;		/* Previous queue segment of NULL */
+	unsigned long		marks;		/* 1-bit mark per folio */
+	unsigned long		marks2;		/* Second 1-bit mark per folio */
+#if PAGEVEC_SIZE > BITS_PER_LONG
+#error marks is not big enough
+#endif
+};
+
+static inline void folioq_init(struct folio_queue *folioq)
+{
+	folio_batch_init(&folioq->vec);
+	folioq->next = NULL;
+	folioq->prev = NULL;
+	folioq->marks = 0;
+	folioq->marks2 = 0;
+}
+
+static inline unsigned int folioq_nr_slots(const struct folio_queue *folioq)
+{
+	return PAGEVEC_SIZE;
+}
+
+static inline unsigned int folioq_count(struct folio_queue *folioq)
+{
+	return folio_batch_count(&folioq->vec);
+}
+
+static inline bool folioq_full(struct folio_queue *folioq)
+{
+	//return !folio_batch_space(&folioq->vec);
+	return folioq_count(folioq) >= folioq_nr_slots(folioq);
+}
+
+static inline bool folioq_is_marked(const struct folio_queue *folioq, unsigned int slot)
+{
+	return test_bit(slot, &folioq->marks);
+}
+
+static inline void folioq_mark(struct folio_queue *folioq, unsigned int slot)
+{
+	set_bit(slot, &folioq->marks);
+}
+
+static inline void folioq_unmark(struct folio_queue *folioq, unsigned int slot)
+{
+	clear_bit(slot, &folioq->marks);
+}
+
+static inline bool folioq_is_marked2(const struct folio_queue *folioq, unsigned int slot)
+{
+	return test_bit(slot, &folioq->marks2);
+}
+
+static inline void folioq_mark2(struct folio_queue *folioq, unsigned int slot)
+{
+	set_bit(slot, &folioq->marks2);
+}
+
+static inline void folioq_unmark2(struct folio_queue *folioq, unsigned int slot)
+{
+	clear_bit(slot, &folioq->marks2);
+}
+
+static inline unsigned int __folio_order(struct folio *folio)
+{
+	if (!folio_test_large(folio))
+		return 0;
+	return folio->_flags_1 & 0xff;
+}
+
+static inline unsigned int folioq_append(struct folio_queue *folioq, struct folio *folio)
+{
+	unsigned int slot = folioq->vec.nr++;
+
+	folioq->vec.folios[slot] = folio;
+	folioq->orders[slot] = __folio_order(folio);
+	return slot;
+}
+
+static inline unsigned int folioq_append_mark(struct folio_queue *folioq, struct folio *folio)
+{
+	unsigned int slot = folioq->vec.nr++;
+
+	folioq->vec.folios[slot] = folio;
+	folioq->orders[slot] = __folio_order(folio);
+	folioq_mark(folioq, slot);
+	return slot;
+}
+
+static inline struct folio *folioq_folio(const struct folio_queue *folioq, unsigned int slot)
+{
+	return folioq->vec.folios[slot];
+}
+
+static inline unsigned int folioq_folio_order(const struct folio_queue *folioq, unsigned int slot)
+{
+	return folioq->orders[slot];
+}
+
+static inline size_t folioq_folio_size(const struct folio_queue *folioq, unsigned int slot)
+{
+	return PAGE_SIZE << folioq_folio_order(folioq, slot);
+}
+
+static inline void folioq_clear(struct folio_queue *folioq, unsigned int slot)
+{
+	folioq->vec.folios[slot] = NULL;
+	folioq_unmark(folioq, slot);
+	folioq_unmark2(folioq, slot);
+}
+
+#endif /* _LINUX_FOLIO_QUEUE_H */
diff --git a/include/linux/iov_iter.h b/include/linux/iov_iter.h
index 270454a6703d..a223370a59a7 100644
--- a/include/linux/iov_iter.h
+++ b/include/linux/iov_iter.h
@@ -10,6 +10,7 @@
 
 #include <linux/uio.h>
 #include <linux/bvec.h>
+#include <linux/folio_queue.h>
 
 typedef size_t (*iov_step_f)(void *iter_base, size_t progress, size_t len,
 			     void *priv, void *priv2);
@@ -140,6 +141,60 @@ size_t iterate_bvec(struct iov_iter *iter, size_t len, void *priv, void *priv2,
 	return progress;
 }
 
+/*
+ * Handle ITER_FOLIOQ.
+ */
+static __always_inline
+size_t iterate_folioq(struct iov_iter *iter, size_t len, void *priv, void *priv2,
+		      iov_step_f step)
+{
+	const struct folio_queue *folioq = iter->folioq;
+	unsigned int slot = iter->folioq_slot;
+	size_t progress = 0, skip = iter->iov_offset;
+
+	if (slot == folioq_nr_slots(folioq)) {
+		/* The iterator may have been extended. */
+		folioq = folioq->next;
+		slot = 0;
+	}
+
+	do {
+		struct folio *folio = folioq_folio(folioq, slot);
+		size_t part, remain, consumed;
+		size_t fsize;
+		void *base;
+
+		if (!folio)
+			break;
+
+		fsize = folioq_folio_size(folioq, slot);
+		base = kmap_local_folio(folio, skip);
+		part = umin(len, PAGE_SIZE - skip % PAGE_SIZE);
+		remain = step(base, progress, part, priv, priv2);
+		kunmap_local(base);
+		consumed = part - remain;
+		len -= consumed;
+		progress += consumed;
+		skip += consumed;
+		if (skip >= fsize) {
+			skip = 0;
+			slot++;
+			if (slot == folioq_nr_slots(folioq) && folioq->next) {
+				folioq = folioq->next;
+				slot = 0;
+			}
+		}
+		if (remain)
+			break;
+	} while (len);
+
+	iter->folioq_slot = slot;
+	iter->folioq = folioq;
+	iter->iov_offset = skip;
+	iter->count -= progress;
+	return progress;
+}
+
 /*
  * Handle ITER_XARRAY.
  */
@@ -249,6 +304,8 @@ size_t iterate_and_advance2(struct iov_iter *iter, size_t len, void *priv,
 		return iterate_bvec(iter, len, priv, priv2, step);
 	if (iov_iter_is_kvec(iter))
 		return iterate_kvec(iter, len, priv, priv2, step);
+	if (iov_iter_is_folioq(iter))
+		return iterate_folioq(iter, len, priv, priv2, step);
 	if (iov_iter_is_xarray(iter))
 		return iterate_xarray(iter, len, priv, priv2, step);
 	return iterate_discard(iter, len, priv, priv2, step);
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 7020adedfa08..845d110acadc 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -11,6 +11,7 @@
 #include <uapi/linux/uio.h>
 
 struct page;
+struct folio_queue;
 
 typedef unsigned int __bitwise iov_iter_extraction_t;
 
@@ -25,6 +26,7 @@ enum iter_type {
 	ITER_IOVEC,
 	ITER_BVEC,
 	ITER_KVEC,
+	ITER_FOLIOQ,
 	ITER_XARRAY,
 	ITER_DISCARD,
 };
@@ -66,6 +68,7 @@ struct iov_iter {
 				const struct iovec *__iov;
 				const struct kvec *kvec;
 				const struct bio_vec *bvec;
+				const struct folio_queue *folioq;
 				struct xarray *xarray;
 				void __user *ubuf;
 			};
@@ -74,6 +77,7 @@ struct iov_iter {
 	};
 	union {
 		unsigned long nr_segs;
+		u8 folioq_slot;
 		loff_t xarray_start;
 	};
 };
@@ -126,6 +130,11 @@ static inline bool iov_iter_is_discard(const struct iov_iter *i)
 	return iov_iter_type(i) == ITER_DISCARD;
 }
 
+static inline bool iov_iter_is_folioq(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_FOLIOQ;
+}
+
 static inline bool iov_iter_is_xarray(const struct iov_iter *i)
 {
 	return iov_iter_type(i) == ITER_XARRAY;
@@ -273,6 +282,9 @@ void iov_iter_kvec(struct iov_iter *i, unsigned int direction, const struct kvec
 void iov_iter_bvec(struct iov_iter *i, unsigned int direction, const struct bio_vec *bvec,
 			unsigned long nr_segs, size_t count);
 void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count);
+void iov_iter_folio_queue(struct iov_iter *i, unsigned int direction,
+			  const struct folio_queue *folioq,
+			  unsigned int first_slot, unsigned int offset, size_t count);
 void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
 		     loff_t start, size_t count);
 ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 4a6a9f419bd7..f410b4b50b16 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -527,6 +527,39 @@ static void iov_iter_iovec_advance(struct iov_iter *i, size_t size)
 	i->__iov = iov;
 }
 
+static void iov_iter_folioq_advance(struct iov_iter *i, size_t size)
+{
+	const struct folio_queue *folioq = i->folioq;
+	unsigned int slot = i->folioq_slot;
+
+	if (!i->count)
+		return;
+	i->count -= size;
+
+	if (slot >= folioq_nr_slots(folioq)) {
+		folioq = folioq->next;
+		slot = 0;
+	}
+
+	size += i->iov_offset; /* From beginning of current segment. */
+	do {
+		size_t fsize = folioq_folio_size(folioq, slot);
+
+		if (likely(size < fsize))
+			break;
+		size -= fsize;
+		slot++;
+		if (slot >= folioq_nr_slots(folioq) && folioq->next) {
+			folioq = folioq->next;
+			slot = 0;
+		}
+	} while (size);
+
+	i->iov_offset = size;
+	i->folioq_slot = slot;
+	i->folioq = folioq;
+}
+
 void iov_iter_advance(struct iov_iter *i, size_t size)
 {
 	if (unlikely(i->count < size))
@@ -539,12 +572,40 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
 		iov_iter_iovec_advance(i, size);
 	} else if (iov_iter_is_bvec(i)) {
 		iov_iter_bvec_advance(i, size);
+	} else if (iov_iter_is_folioq(i)) {
+		iov_iter_folioq_advance(i, size);
 	} else if (iov_iter_is_discard(i)) {
 		i->count -= size;
 	}
 }
 EXPORT_SYMBOL(iov_iter_advance);
 
+static void iov_iter_folioq_revert(struct iov_iter *i, size_t unroll)
+{
+	const struct folio_queue *folioq = i->folioq;
+	unsigned int slot = i->folioq_slot;
+
+	for (;;) {
+		size_t fsize;
+
+		if (slot == 0) {
+			folioq = folioq->prev;
+			slot = folioq_nr_slots(folioq);
+		}
+		slot--;
+
+		fsize = folioq_folio_size(folioq, slot);
+		if (unroll <= fsize) {
+			i->iov_offset = fsize - unroll;
+			break;
+		}
+		unroll -= fsize;
+	}
+
+	i->folioq_slot = slot;
+	i->folioq = folioq;
+}
+
 void iov_iter_revert(struct iov_iter *i, size_t unroll)
 {
 	if (!unroll)
@@ -576,6 +637,9 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 			}
 			unroll -= n;
 		}
+	} else if (iov_iter_is_folioq(i)) {
+		i->iov_offset = 0;
+		iov_iter_folioq_revert(i, unroll);
 	} else { /* same logics for iovec and kvec */
 		const struct iovec *iov = iter_iov(i);
 		while (1) {
@@ -603,6 +667,9 @@ size_t iov_iter_single_seg_count(const struct iov_iter *i)
 		if (iov_iter_is_bvec(i))
 			return min(i->count, i->bvec->bv_len - i->iov_offset);
 	}
+	if (unlikely(iov_iter_is_folioq(i)))
+		return !i->count ? 0 :
+			umin(folioq_folio_size(i->folioq, i->folioq_slot), i->count);
 	return i->count;
 }
 EXPORT_SYMBOL(iov_iter_single_seg_count);
@@ -639,6 +706,36 @@ void iov_iter_bvec(struct iov_iter *i, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_bvec);
 
+/**
+ * iov_iter_folio_queue - Initialise an I/O iterator to use the folios in a folio queue
+ * @i: The iterator to initialise.
+ * @direction: The direction of the transfer.
+ * @folioq: The starting point in the folio queue.
+ * @first_slot: The first slot in the folio queue to use
+ * @offset: The offset into the folio in the first slot to start at
+ * @count: The size of the I/O buffer in bytes.
+ *
+ * Set up an I/O iterator to either draw data out of the pages attached to an
+ * inode or to inject data into those pages.  The pages *must* be prevented
+ * from evaporation, either by taking a ref on them or locking them by the
+ * caller.
+ */
+void iov_iter_folio_queue(struct iov_iter *i, unsigned int direction,
+			  const struct folio_queue *folioq, unsigned int first_slot,
+			  unsigned int offset, size_t count)
+{
+	BUG_ON(direction & ~1);
+	*i = (struct iov_iter) {
+		.iter_type = ITER_FOLIOQ,
+		.data_source = direction,
+		.folioq = folioq,
+		.folioq_slot = first_slot,
+		.count = count,
+		.iov_offset = offset,
+	};
+}
+EXPORT_SYMBOL(iov_iter_folio_queue);
+
 /**
  * iov_iter_xarray - Initialise an I/O iterator to use the pages in an xarray
  * @i: The iterator to initialise.
@@ -765,12 +862,19 @@ bool iov_iter_is_aligned(const struct iov_iter *i, unsigned addr_mask,
 	if (iov_iter_is_bvec(i))
 		return iov_iter_aligned_bvec(i, addr_mask, len_mask);
 
+	/* With both xarray and folioq types, we're dealing with whole folios. */
 	if (iov_iter_is_xarray(i)) {
 		if (i->count & len_mask)
 			return false;
 		if ((i->xarray_start + i->iov_offset) & addr_mask)
 			return false;
 	}
+	if (iov_iter_is_folioq(i)) {
+		if (i->count & len_mask)
+			return false;
+		if (i->iov_offset & addr_mask)
+			return false;
+	}
 
 	return true;
 }
@@ -835,6 +939,9 @@ unsigned long iov_iter_alignment(const struct iov_iter *i)
 	if (iov_iter_is_bvec(i))
 		return iov_iter_alignment_bvec(i);
 
+	/* With both xarray and folioq types, we're dealing with whole folios. */
+	if (iov_iter_is_folioq(i))
+		return i->iov_offset | i->count;
 	if (iov_iter_is_xarray(i))
 		return (i->xarray_start + i->iov_offset) | i->count;
 
@@ -887,6 +994,51 @@ static int want_pages_array(struct page ***res, size_t size,
 	return count;
 }
 
+static ssize_t iter_folioq_get_pages(struct iov_iter *iter,
+				     struct page ***ppages, size_t maxsize,
+				     unsigned maxpages, size_t *_start_offset)
+{
+	const struct folio_queue *folioq = iter->folioq;
+	struct page **pages;
+	unsigned int slot = iter->folioq_slot;
+	size_t extracted = 0;
+
+	maxpages = want_pages_array(ppages, maxsize, iter->iov_offset & ~PAGE_MASK, maxpages);
+	if (!maxpages)
+		return -ENOMEM;
+	*_start_offset = iter->iov_offset & ~PAGE_MASK;
+	pages = *ppages;
+
+	for (;;) {
+		struct folio *folio = folioq_folio(folioq, slot);
+		size_t offset = iter->iov_offset, fsize = folioq_folio_size(folioq, slot);
+		size_t part = PAGE_SIZE - offset % PAGE_SIZE;
+
+		part = umin(part, umin(maxsize - extracted, fsize - offset));
+		iter->count -= part;
+		iter->iov_offset += part;
+		extracted += part;
+
+		*pages++ = folio_page(folio, offset % PAGE_SIZE);
+		maxpages--;
+		if (maxpages == 0 || extracted >= maxsize)
+			break;
+
+		if (offset >= fsize) {
+			iter->iov_offset = 0;
+			slot++;
+			if (slot == folioq_nr_slots(folioq) && folioq->next) {
+				folioq = folioq->next;
+				slot = 0;
+			}
+		}
+	}
+
+	iter->folioq = folioq;
+	iter->folioq_slot = slot;
+	return extracted;
+}
+
 static ssize_t iter_xarray_populate_pages(struct page **pages, struct xarray *xa,
 					  pgoff_t index, unsigned int nr_pages)
 {
@@ -1034,6 +1186,8 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		}
 		return maxsize;
 	}
+	if (iov_iter_is_folioq(i))
+		return iter_folioq_get_pages(i, pages, maxsize, maxpages, start);
 	if (iov_iter_is_xarray(i))
 		return iter_xarray_get_pages(i, pages, maxsize, maxpages, start);
 	return -EFAULT;
@@ -1118,6 +1272,11 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
 		return iov_npages(i, maxpages);
 	if (iov_iter_is_bvec(i))
 		return bvec_npages(i, maxpages);
+	if (iov_iter_is_folioq(i)) {
+		unsigned offset = i->iov_offset % PAGE_SIZE;
+		int npages = DIV_ROUND_UP(offset + i->count, PAGE_SIZE);
+		return min(npages, maxpages);
+	}
 	if (iov_iter_is_xarray(i)) {
 		unsigned offset = (i->xarray_start + i->iov_offset) % PAGE_SIZE;
 		int npages = DIV_ROUND_UP(offset + i->count, PAGE_SIZE);
@@ -1398,6 +1557,68 @@ void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
 	i->nr_segs = state->nr_segs;
 }
 
+/*
+ * Extract a list of contiguous pages from an ITER_FOLIOQ iterator.  This does
+ * not get references on the pages, nor does it get a pin on them.
+ */
+static ssize_t iov_iter_extract_folioq_pages(struct iov_iter *i,
+					     struct page ***pages, size_t maxsize,
+					     unsigned int maxpages,
+					     iov_iter_extraction_t extraction_flags,
+					     size_t *offset0)
+{
+	const struct folio_queue *folioq = i->folioq;
+	struct page **p;
+	unsigned int nr = 0;
+	size_t extracted = 0, offset, slot = i->folioq_slot;
+
+	if (slot >= folioq_nr_slots(folioq)) {
+		folioq = folioq->next;
+		slot = 0;
+		if (WARN_ON(i->iov_offset != 0))
+			return -EIO;
+	}
+
+	offset = i->iov_offset & ~PAGE_MASK;
+	*offset0 = offset;
+
+	maxpages = want_pages_array(pages, maxsize, offset, maxpages);
+	if (!maxpages)
+		return -ENOMEM;
+	p = *pages;
+
+	for (;;) {
+		struct folio *folio = folioq_folio(folioq, slot);
+		size_t offset = i->iov_offset, fsize = folioq_folio_size(folioq, slot);
+		size_t part = PAGE_SIZE - offset % PAGE_SIZE;
+
+		if (offset < fsize) {
+			part = umin(part, umin(maxsize - extracted, fsize - offset));
+			i->count -= part;
+			i->iov_offset += part;
+			extracted += part;
+
+			p[nr++] = folio_page(folio, offset / PAGE_SIZE);
+		}
+
+		if (nr >= maxpages || extracted >= maxsize)
+			break;
+
+		if (i->iov_offset >= fsize) {
+			i->iov_offset = 0;
+			slot++;
+			if (slot == folioq_nr_slots(folioq) && folioq->next) {
+				folioq = folioq->next;
+				slot = 0;
+			}
+		}
+	}
+
+	i->folioq = folioq;
+	i->folioq_slot = slot;
+	return extracted;
+}
+
 /*
  * Extract a list of contiguous pages from an ITER_XARRAY iterator.  This does not
  * get references on the pages, nor does it get a pin on them.
@@ -1618,8 +1839,8 @@ static ssize_t iov_iter_extract_user_pages(struct iov_iter *i,
  *      added to the pages, but refs will not be taken.
  *      iov_iter_extract_will_pin() will return true.
  *
- *  (*) If the iterator is ITER_KVEC, ITER_BVEC or ITER_XARRAY, the pages are
- *      merely listed; no extra refs or pins are obtained.
+ *  (*) If the iterator is ITER_KVEC, ITER_BVEC, ITER_FOLIOQ or ITER_XARRAY, the
+ *      pages are merely listed; no extra refs or pins are obtained.
  *      iov_iter_extract_will_pin() will return 0.
  *
  * Note also:
@@ -1654,6 +1875,10 @@ ssize_t iov_iter_extract_pages(struct iov_iter *i,
 		return iov_iter_extract_bvec_pages(i, pages, maxsize,
 						   maxpages, extraction_flags,
 						   offset0);
+	if (iov_iter_is_folioq(i))
+		return iov_iter_extract_folioq_pages(i, pages, maxsize,
+						     maxpages, extraction_flags,
+						     offset0);
 	if (iov_iter_is_xarray(i))
 		return iov_iter_extract_xarray_pages(i, pages, maxsize,
 						     maxpages, extraction_flags,
diff --git a/lib/kunit_iov_iter.c b/lib/kunit_iov_iter.c
index 27e0c8ee71d8..13e15687675a 100644
--- a/lib/kunit_iov_iter.c
+++ b/lib/kunit_iov_iter.c
@@ -12,6 +12,7 @@
 #include <linux/mm.h>
 #include <linux/uio.h>
 #include <linux/bvec.h>
+#include <linux/folio_queue.h>
 #include <kunit/test.h>
 
 MODULE_DESCRIPTION("iov_iter testing");
@@ -62,6 +63,9 @@ static void *__init iov_kunit_create_buffer(struct kunit *test,
 		KUNIT_ASSERT_EQ(test, got, npages);
 	}
 
+	for (int i = 0; i < npages; i++)
+		pages[i]->index = i;
+
 	buffer = vmap(pages, npages, VM_MAP | VM_MAP_PUT_PAGES, PAGE_KERNEL);
         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buffer);
 
@@ -362,6 +366,179 @@ static void __init iov_kunit_copy_from_bvec(struct kunit *test)
 	KUNIT_SUCCEED(test);
 }
 
+static void iov_kunit_destroy_folioq(void *data)
+{
+	struct folio_queue *folioq, *next;
+
+	for (folioq = data; folioq; folioq = next) {
+		next = folioq->next;
+		for (int i = 0; i < folioq_nr_slots(folioq); i++)
+			if (folioq_folio(folioq, i))
+				folio_put(folioq_folio(folioq, i));
+		kfree(folioq);
+	}
+}
+
+static void __init iov_kunit_load_folioq(struct kunit *test,
+					struct iov_iter *iter, int dir,
+					struct folio_queue *folioq,
+					struct page **pages, size_t npages)
+{
+	struct folio_queue *p = folioq;
+	size_t size = 0;
+	int i;
+
+	for (i = 0; i < npages; i++) {
+		if (folioq_full(p)) {
+			p->next = kzalloc(sizeof(struct folio_queue), GFP_KERNEL);
+			KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p->next);
+			folioq_init(p->next);
+			p->next->prev = p;
+			p = p->next;
+		}
+		folioq_append(p, page_folio(pages[i]));
+		size += PAGE_SIZE;
+	}
+	iov_iter_folio_queue(iter, dir, folioq, 0, 0, size);
+}
+
+static struct folio_queue *iov_kunit_create_folioq(struct kunit *test)
+{
+	struct folio_queue *folioq;
+
+	folioq = kzalloc(sizeof(struct folio_queue), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, folioq);
+	kunit_add_action_or_reset(test, iov_kunit_destroy_folioq, folioq);
+	folioq_init(folioq);
+	return folioq;
+}
+
+/*
+ * Test copying to a ITER_FOLIOQ-type iterator.
+ */
+static void __init iov_kunit_copy_to_folioq(struct kunit *test)
+{
+	const struct kvec_test_range *pr;
+	struct iov_iter iter;
+	struct folio_queue *folioq;
+	struct page **spages, **bpages;
+	u8 *scratch, *buffer;
+	size_t bufsize, npages, size, copied;
+	int i, patt;
+
+	bufsize = 0x100000;
+	npages = bufsize / PAGE_SIZE;
+
+	folioq = iov_kunit_create_folioq(test);
+
+	scratch = iov_kunit_create_buffer(test, &spages, npages);
+	for (i = 0; i < bufsize; i++)
+		scratch[i] = pattern(i);
+
+	buffer = iov_kunit_create_buffer(test, &bpages, npages);
+	memset(buffer, 0, bufsize);
+
+	iov_kunit_load_folioq(test, &iter, READ, folioq, bpages, npages);
+
+	i = 0;
+	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
+		size = pr->to - pr->from;
+		KUNIT_ASSERT_LE(test, pr->to, bufsize);
+
+		iov_iter_folio_queue(&iter, READ, folioq, 0, 0, pr->to);
+		iov_iter_advance(&iter, pr->from);
+		copied = copy_to_iter(scratch + i, size, &iter);
+
+		KUNIT_EXPECT_EQ(test, copied, size);
+		KUNIT_EXPECT_EQ(test, iter.count, 0);
+		KUNIT_EXPECT_EQ(test, iter.iov_offset, pr->to % PAGE_SIZE);
+		i += size;
+		if (test->status == KUNIT_FAILURE)
+			goto stop;
+	}
+
+	/* Build the expected image in the scratch buffer. */
+	patt = 0;
+	memset(scratch, 0, bufsize);
+	for (pr = kvec_test_ranges; pr->from >= 0; pr++)
+		for (i = pr->from; i < pr->to; i++)
+			scratch[i] = pattern(patt++);
+
+	/* Compare the images */
+	for (i = 0; i < bufsize; i++) {
+		KUNIT_EXPECT_EQ_MSG(test, buffer[i], scratch[i], "at i=%x", i);
+		if (buffer[i] != scratch[i])
+			return;
+	}
+
+stop:
+	KUNIT_SUCCEED(test);
+}
+
+/*
+ * Test copying from a ITER_FOLIOQ-type iterator.
+ */
+static void __init iov_kunit_copy_from_folioq(struct kunit *test)
+{
+	const struct kvec_test_range *pr;
+	struct iov_iter iter;
+	struct folio_queue *folioq;
+	struct page **spages, **bpages;
+	u8 *scratch, *buffer;
+	size_t bufsize, npages, size, copied;
+	int i, j;
+
+	bufsize = 0x100000;
+	npages = bufsize / PAGE_SIZE;
+
+	folioq = iov_kunit_create_folioq(test);
+
+	buffer = iov_kunit_create_buffer(test, &bpages, npages);
+	for (i = 0; i < bufsize; i++)
+		buffer[i] = pattern(i);
+
+	scratch = iov_kunit_create_buffer(test, &spages, npages);
+	memset(scratch, 0, bufsize);
+
+	iov_kunit_load_folioq(test, &iter, READ, folioq, bpages, npages);
+
+	i = 0;
+	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
+		size = pr->to - pr->from;
+		KUNIT_ASSERT_LE(test, pr->to, bufsize);
+
+		iov_iter_folio_queue(&iter, WRITE, folioq, 0, 0, pr->to);
+		iov_iter_advance(&iter, pr->from);
+		copied = copy_from_iter(scratch + i, size, &iter);
+
+		KUNIT_EXPECT_EQ(test, copied, size);
+		KUNIT_EXPECT_EQ(test, iter.count, 0);
+		KUNIT_EXPECT_EQ(test, iter.iov_offset, pr->to % PAGE_SIZE);
+		i += size;
+	}
+
+	/* Build the expected image in the main buffer. */
+	i = 0;
+	memset(buffer, 0, bufsize);
+	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
+		for (j = pr->from; j < pr->to; j++) {
+			buffer[i++] = pattern(j);
+			if (i >= bufsize)
+				goto stop;
+		}
+	}
+stop:
+
+	/* Compare the images */
+	for (i = 0; i < bufsize; i++) {
+		KUNIT_EXPECT_EQ_MSG(test, scratch[i], buffer[i], "at i=%x", i);
+		if (scratch[i] != buffer[i])
+			return;
+	}
+
+	KUNIT_SUCCEED(test);
+}
+
 static void iov_kunit_destroy_xarray(void *data)
 {
 	struct xarray *xarray = data;
@@ -677,6 +854,85 @@ static void __init iov_kunit_extract_pages_bvec(struct kunit *test)
 	KUNIT_SUCCEED(test);
 }
 
+/*
+ * Test the extraction of ITER_FOLIOQ-type iterators.
+ */
+static void __init iov_kunit_extract_pages_folioq(struct kunit *test)
+{
+	const struct kvec_test_range *pr;
+	struct folio_queue *folioq;
+	struct iov_iter iter;
+	struct page **bpages, *pagelist[8], **pages = pagelist;
+	ssize_t len;
+	size_t bufsize, size = 0, npages;
+	int i, from;
+
+	bufsize = 0x100000;
+	npages = bufsize / PAGE_SIZE;
+
+	folioq = iov_kunit_create_folioq(test);
+
+	iov_kunit_create_buffer(test, &bpages, npages);
+	iov_kunit_load_folioq(test, &iter, READ, folioq, bpages, npages);
+
+	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
+		from = pr->from;
+		size = pr->to - from;
+		KUNIT_ASSERT_LE(test, pr->to, bufsize);
+
+		iov_iter_folio_queue(&iter, WRITE, folioq, 0, 0, pr->to);
+		iov_iter_advance(&iter, from);
+
+		do {
+			size_t offset0 = LONG_MAX;
+
+			for (i = 0; i < ARRAY_SIZE(pagelist); i++)
+				pagelist[i] = (void *)(unsigned long)0xaa55aa55aa55aa55ULL;
+
+			len = iov_iter_extract_pages(&iter, &pages, 100 * 1024,
+						     ARRAY_SIZE(pagelist), 0, &offset0);
+			KUNIT_EXPECT_GE(test, len, 0);
+			if (len < 0)
+				break;
+			KUNIT_EXPECT_LE(test, len, size);
+			KUNIT_EXPECT_EQ(test, iter.count, size - len);
+			if (len == 0)
+				break;
+			size -= len;
+			KUNIT_EXPECT_GE(test, (ssize_t)offset0, 0);
+			KUNIT_EXPECT_LT(test, offset0, PAGE_SIZE);
+
+			for (i = 0; i < ARRAY_SIZE(pagelist); i++) {
+				struct page *p;
+				ssize_t part = min_t(ssize_t, len, PAGE_SIZE - offset0);
+				int ix;
+
+				KUNIT_ASSERT_GE(test, part, 0);
+				ix = from / PAGE_SIZE;
+				KUNIT_ASSERT_LT(test, ix, npages);
+				p = bpages[ix];
+				KUNIT_EXPECT_PTR_EQ(test, pagelist[i], p);
+				KUNIT_EXPECT_EQ(test, offset0, from % PAGE_SIZE);
+				from += part;
+				len -= part;
+				KUNIT_ASSERT_GE(test, len, 0);
+				if (len == 0)
+					break;
+				offset0 = 0;
+			}
+
+			if (test->status == KUNIT_FAILURE)
+				goto stop;
+		} while (iov_iter_count(&iter) > 0);
+
+		KUNIT_EXPECT_EQ(test, size, 0);
+		KUNIT_EXPECT_EQ(test, iter.count, 0);
+	}
+
+stop:
+	KUNIT_SUCCEED(test);
+}
+
 /*
  * Test the extraction of ITER_XARRAY-type iterators.
  */
@@ -761,10 +1017,13 @@ static struct kunit_case __refdata iov_kunit_cases[] = {
 	KUNIT_CASE(iov_kunit_copy_from_kvec),
 	KUNIT_CASE(iov_kunit_copy_to_bvec),
 	KUNIT_CASE(iov_kunit_copy_from_bvec),
+	KUNIT_CASE(iov_kunit_copy_to_folioq),
+	KUNIT_CASE(iov_kunit_copy_from_folioq),
 	KUNIT_CASE(iov_kunit_copy_to_xarray),
 	KUNIT_CASE(iov_kunit_copy_from_xarray),
 	KUNIT_CASE(iov_kunit_extract_pages_kvec),
 	KUNIT_CASE(iov_kunit_extract_pages_bvec),
+	KUNIT_CASE(iov_kunit_extract_pages_folioq),
 	KUNIT_CASE(iov_kunit_extract_pages_xarray),
 	{}
 };
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 7bc2220fea80..473b2646f71c 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -11,6 +11,7 @@
 #include <linux/kmemleak.h>
 #include <linux/bvec.h>
 #include <linux/uio.h>
+#include <linux/folio_queue.h>
 
 /**
  * sg_next - return the next scatterlist entry in a list
@@ -1261,6 +1262,67 @@ static ssize_t extract_kvec_to_sg(struct iov_iter *iter,
 	return ret;
 }
 
+/*
+ * Extract up to sg_max folios from an FOLIOQ-type iterator and add them to
+ * the scatterlist.  The pages are not pinned.
+ */
+static ssize_t extract_folioq_to_sg(struct iov_iter *iter,
+				   ssize_t maxsize,
+				   struct sg_table *sgtable,
+				   unsigned int sg_max,
+				   iov_iter_extraction_t extraction_flags)
+{
+	const struct folio_queue *folioq = iter->folioq;
+	struct scatterlist *sg = sgtable->sgl + sgtable->nents;
+	unsigned int slot = iter->folioq_slot;
+	ssize_t ret = 0;
+	size_t offset = iter->iov_offset;
+
+	BUG_ON(!folioq);
+
+	if (slot >= folioq_nr_slots(folioq)) {
+		folioq = folioq->next;
+		if (WARN_ON_ONCE(!folioq))
+			return 0;
+		slot = 0;
+	}
+
+	do {
+		struct folio *folio = folioq_folio(folioq, slot);
+		size_t fsize = folioq_folio_size(folioq, slot);
+
+		if (offset < fsize) {
+			size_t part = umin(maxsize - ret, fsize - offset);
+
+			sg_set_page(sg, folio_page(folio, 0), part, offset);
+			sgtable->nents++;
+			sg++;
+			sg_max--;
+			offset += part;
+			ret += part;
+		}
+
+		if (offset >= fsize) {
+			offset = 0;
+			slot++;
+			if (slot >= folioq_nr_slots(folioq)) {
+				if (!folioq->next) {
+					WARN_ON_ONCE(ret < iter->count);
+					break;
+				}
+				folioq = folioq->next;
+				slot = 0;
+			}
+		}
+	} while (sg_max > 0 && ret < maxsize);
+
+	iter->folioq = folioq;
+	iter->folioq_slot = slot;
+	iter->iov_offset = offset;
+	iter->count -= ret;
+	return ret;
+}
+
 /*
  * Extract up to sg_max folios from an XARRAY-type iterator and add them to
  * the scatterlist.  The pages are not pinned.
@@ -1323,8 +1385,8 @@ static ssize_t extract_xarray_to_sg(struct iov_iter *iter,
  * addition of @sg_max elements.
  *
  * The pages referred to by UBUF- and IOVEC-type iterators are extracted and
- * pinned; BVEC-, KVEC- and XARRAY-type are extracted but aren't pinned; PIPE-
- * and DISCARD-type are not supported.
+ * pinned; BVEC-, KVEC-, FOLIOQ- and XARRAY-type are extracted but aren't
+ * pinned; DISCARD-type is not supported.
  *
  * No end mark is placed on the scatterlist; that's left to the caller.
  *
@@ -1356,6 +1418,9 @@ ssize_t extract_iter_to_sg(struct iov_iter *iter, size_t maxsize,
 	case ITER_KVEC:
 		return extract_kvec_to_sg(iter, maxsize, sgtable, sg_max,
 					  extraction_flags);
+	case ITER_FOLIOQ:
+		return extract_folioq_to_sg(iter, maxsize, sgtable, sg_max,
+					    extraction_flags);
 	case ITER_XARRAY:
 		return extract_xarray_to_sg(iter, maxsize, sgtable, sg_max,
 					    extraction_flags);


