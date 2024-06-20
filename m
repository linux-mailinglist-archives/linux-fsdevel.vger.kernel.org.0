Return-Path: <linux-fsdevel+bounces-22021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7471910F29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 19:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 465831F21711
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 17:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5591CB30F;
	Thu, 20 Jun 2024 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+AO2kXY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2461CB306
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2024 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904827; cv=none; b=I/nP31KmjkLNkAL38/yG6sgkvceJiGqVDzCzPdukA/75dz9iaDj/PSo/tItZUpTbNAG7z4quxNEKYz7gfuuEba8Zo/geTW+R6sFRp5zd0FOJZnh64TJJkN0BEsrQPwSP+mjOSIzEqv7SEoT5TWllal+WMPv79TkrtiGbhoTN9xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904827; c=relaxed/simple;
	bh=KBaS+U7Y1rIBlPUg/lrlGzmPTiXKMdCDC8Owa+8PBuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EneQjVrmijDr8oR41CsPOAwnrWWXe8RZf+jhGW4ZBZl0UjmaGTKbYtLcPBXn4+us1FD50KRKc3Rx+i9wxR8jzgzl6u56DgLEKFFYHnAKY8X9eiJaLQcHwx5RBykyy2basBMT5Nm+EaGtSp83PHkr3E9pmQgD5/1Np+S4g72Wi30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b+AO2kXY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718904822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gG5hZ5+44vznxIKh5hd9WtB53dbFSaPHyJMjHSD03HM=;
	b=b+AO2kXYFSnaeEy2yv6YQ3CE3hfP5cslCXLawo3vrpQdCX7MbCfglEHY2h8wKrb0efUTY2
	RQOfoX1tG3j+DSX2Noelz+yy8NRAyfnBEhTWua+VFiPK5xQbSxKjLexvAnCnlGHdNFz3h2
	Z4Mndl4NVQdsoYYuFunWDDQAVW7DAEc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-UzIqrurqMCa_Gx5nsIh9ZQ-1; Thu,
 20 Jun 2024 13:33:39 -0400
X-MC-Unique: UzIqrurqMCa_Gx5nsIh9ZQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7614B19560B2;
	Thu, 20 Jun 2024 17:33:35 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.39.195.156])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5847419560AF;
	Thu, 20 Jun 2024 17:33:27 +0000 (UTC)
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
Subject: [PATCH 13/17] mm: Define struct sheaf and ITER_SHEAF to handle a sequence of folios
Date: Thu, 20 Jun 2024 18:31:31 +0100
Message-ID: <20240620173137.610345-14-dhowells@redhat.com>
In-Reply-To: <20240620173137.610345-1-dhowells@redhat.com>
References: <20240620173137.610345-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Define a data structure, struct sheaf, to represent a sequence of folios
and a kernel-internal I/O iterator type, ITER_SHEAF, to allow a list of
sheaf structures to be used to provide a buffer to iov_iter-taking
functions, such as sendmsg and recvmsg.

The sheaf structure looks like:

	struct sheaf {
		struct sheaf	*next;
		struct sheaf	*prev;
		sheaf_slot_t	slots[29];
		u8		orders[29];
	};

It does not use a list_head so that next and/or prev can be set to NULL at
the ends of the list, allowing iov_iter-handling routines to determine that
they *are* the ends without needing to store the head pointer in the
iov_iter struct.

The slots are a folio pointer with the bottom two bits usable for storing
marks.  The intention is to use at least one of them to mark folios that
need putting, but that might not be ultimately necessary.  Accessor
functions are used to access the slots to do the masking and an additional
accessor function is used to indicate the size of the array.

The order of each folio is also stored in the structure to avoid the need
for iov_iter_advance() and iov_iter_revert() to have to query each folio to
find its size.

With careful barriering, this can be used as an extending buffer with new
folios inserted and new sheaf structs added without the need for a lock.
Further, provided we always keep at least one struct in the buffer, we can
also remove consumed folios and consumed structs from the head end as we
without the need for locks.

[Questions/thoughts]

 (1) I'm told that 'sheaf' is now being used for something else mm-related
     out-of-tree, so I should probably change the name to something else -
     but what?  Continuing on the papery theme, "scroll" and "fanfold" have
     occurred to me, but they're probably not the best.  Maybe
     "folio_queue" or "folio_seq"?

 (2) To manage this, I need a head pointer, a tail pointer, a tail slot
     number (assuming insertion happens at the tail end and the next
     pointers point from head to tail).  Should I put these into a struct
     of their own, say "sheaf_list" or "rolling_buffer" or "folio_queue"?

     I will end up with two of these in netfs_io_request eventually, one
     keeping track of the pagecache I'm dealing with for buffered I/O and
     the other to hold a bounce buffer when we need one.

 (3) I have set the number of elements to 29 so that it fits into a 32-word
     allocation (either 256 bytes or 512 bytes).  However, should I replace
     slots[] with a folio_batch struct?

     The disadvantage of that is that adds a bunch of fields I don't need
     for the purpose of the buffer and pushes the size of the struct to a
     non-pow-2 size.  The advantage would be that I can pass the batch
     directly to a variety of mm routines.

 (4) Should I make the slots {folio,off,len} or bio_vec?

 (5) This is intended to replace ITER_XARRAY eventually.  Using an xarray
     in I/O iteration requires the taking of the RCU read lock, doing
     copying under the RCU read lock, walking the xarray (which may change
     under us), handling retries and dealing with special values.

     The advantage of ITER_XARRAY is that when we're dealing with the
     pagecache directly, we don't need any allocation - but if we're doing
     encrypted comms, there's a good chance we'd be using a bounce buffer
     anyway.

     This will require afs, erofs, cifs and fscache to be converted to not
     use this.  afs still uses it for dirs and symlinks; some of erofs
     usages should be easy to change, but there's one which won't be so
     easy; ceph's use via fscache can be fixed by porting ceph to netfslib;
     cifs is using xarray as a bounce buffer - that can be moved to use
     sheaves instead; and orangefs has a similar problem to erofs - maybe
     orangefs could use netfslib?

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
 include/linux/iov_iter.h |  57 +++++++++
 include/linux/sheaf.h    |  83 +++++++++++++
 include/linux/uio.h      |  11 ++
 lib/iov_iter.c           | 222 ++++++++++++++++++++++++++++++++-
 lib/kunit_iov_iter.c     | 259 +++++++++++++++++++++++++++++++++++++++
 lib/scatterlist.c        |  69 ++++++++++-
 6 files changed, 697 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/sheaf.h

diff --git a/include/linux/iov_iter.h b/include/linux/iov_iter.h
index 270454a6703d..39e8df54dffe 100644
--- a/include/linux/iov_iter.h
+++ b/include/linux/iov_iter.h
@@ -10,6 +10,7 @@
 
 #include <linux/uio.h>
 #include <linux/bvec.h>
+#include <linux/sheaf.h>
 
 typedef size_t (*iov_step_f)(void *iter_base, size_t progress, size_t len,
 			     void *priv, void *priv2);
@@ -140,6 +141,60 @@ size_t iterate_bvec(struct iov_iter *iter, size_t len, void *priv, void *priv2,
 	return progress;
 }
 
+/*
+ * Handle ITER_SHEAF.
+ */
+static __always_inline
+size_t iterate_sheaf(struct iov_iter *iter, size_t len, void *priv, void *priv2,
+		     iov_step_f step)
+{
+	const struct sheaf *sheaf = iter->sheaf;
+	unsigned int slot = iter->sheaf_slot;
+	size_t progress = 0, skip = iter->iov_offset;
+
+	if (slot == sheaf_nr_slots(sheaf)) {
+		/* The iterator may have been extended. */
+		sheaf = sheaf->next;
+		slot = 0;
+	}
+
+	do {
+		struct folio *folio = sheaf_slot_folio(sheaf, slot);
+		size_t part, remain, consumed;
+		size_t fsize;
+		void *base;
+
+		if (!folio)
+			break;
+
+		fsize = sheaf_folio_size(sheaf, slot);
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
+			if (slot == sheaf_nr_slots(sheaf) && sheaf->next) {
+				sheaf = sheaf->next;
+				slot = 0;
+			}
+		}
+		if (remain)
+			break;
+	} while (len);
+
+	iter->sheaf_slot = slot;
+	iter->sheaf = sheaf;
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
+	if (iov_iter_is_sheaf(iter))
+		return iterate_sheaf(iter, len, priv, priv2, step);
 	if (iov_iter_is_xarray(iter))
 		return iterate_xarray(iter, len, priv, priv2, step);
 	return iterate_discard(iter, len, priv, priv2, step);
diff --git a/include/linux/sheaf.h b/include/linux/sheaf.h
new file mode 100644
index 000000000000..57f07214063c
--- /dev/null
+++ b/include/linux/sheaf.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Sheaf of folios definitions
+ *
+ * Copyright (C) 2024 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#ifndef _LINUX_SHEAF_H
+#define _LINUX_SHEAF_H
+
+#include <linux/mm_types.h>
+
+typedef struct sheaf_slot *sheaf_slot_t;
+
+/*
+ * Segment in a queue of running buffers.  Each segment can hold a number of
+ * folios and a portion of the queue can be referenced with the ITER_SHEAF
+ * iterator.  The possibility exists of inserting non-folio elements into the
+ * queue (such as gaps).
+ *
+ * Explicit prev and next pointers are used instead of a list_head to make it
+ * easier to add segments to tail and remove them from the head without the
+ * need for a lock.
+ */
+struct sheaf {
+	struct sheaf	*next;
+	struct sheaf	*prev;
+	sheaf_slot_t	slots[29];
+#define SHEAF_SLOT_FOLIO_MARK	0x01UL	/* Bit 0 in a folio ptr is a generic mark */
+	/* Bit 1 is reserved. */
+#define SHEAF_SLOT_FOLIO_PTR	~0x03UL	/* Bit 2.. are the folio ptr */
+	u8		orders[29];	/* Order of each folio */
+};
+
+static inline unsigned int sheaf_nr_slots(const struct sheaf *sheaf)
+{
+	return ARRAY_SIZE(sheaf->slots);
+}
+
+static inline struct folio *sheaf_slot_folio(const struct sheaf *sheaf, unsigned int slot)
+{
+	return (struct folio *)((unsigned long)sheaf->slots[slot] & SHEAF_SLOT_FOLIO_PTR);
+}
+
+static inline bool sheaf_slot_is_folio(const struct sheaf *sheaf, unsigned int slot)
+{
+	return true;
+}
+
+static inline size_t sheaf_folio_size(const struct sheaf *sheaf, unsigned int slot)
+{
+	return PAGE_SIZE << sheaf->orders[slot];
+}
+
+static inline bool sheaf_slot_is_marked(const struct sheaf *sheaf, unsigned int slot)
+{
+	/* Must check is_folio first */
+	return (unsigned long)sheaf->slots[slot] & SHEAF_SLOT_FOLIO_MARK;
+}
+
+static inline sheaf_slot_t sheaf_make_folio(struct folio *folio, bool mark)
+{
+	return (sheaf_slot_t)((unsigned long)folio | (mark ? SHEAF_SLOT_FOLIO_MARK : 0));
+}
+
+static inline void sheaf_slot_set(struct sheaf *sheaf, unsigned int slot, sheaf_slot_t val)
+{
+	sheaf->slots[slot] = val;
+}
+
+static inline void sheaf_slot_set_folio(struct sheaf *sheaf, unsigned int slot,
+					struct folio *folio)
+{
+	sheaf_slot_set(sheaf, slot, sheaf_make_folio(folio, false));
+}
+
+static inline void sheaf_slot_set_folio_marked(struct sheaf *sheaf, unsigned int slot,
+					       struct folio *folio)
+{
+	sheaf_slot_set(sheaf, slot, sheaf_make_folio(folio, true));
+}
+
+#endif /* _LINUX_SHEAF_H */
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 7020adedfa08..55ca3d0c7d48 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -11,6 +11,7 @@
 #include <uapi/linux/uio.h>
 
 struct page;
+struct sheaf;
 
 typedef unsigned int __bitwise iov_iter_extraction_t;
 
@@ -25,6 +26,7 @@ enum iter_type {
 	ITER_IOVEC,
 	ITER_BVEC,
 	ITER_KVEC,
+	ITER_SHEAF,
 	ITER_XARRAY,
 	ITER_DISCARD,
 };
@@ -66,6 +68,7 @@ struct iov_iter {
 				const struct iovec *__iov;
 				const struct kvec *kvec;
 				const struct bio_vec *bvec;
+				const struct sheaf *sheaf;
 				struct xarray *xarray;
 				void __user *ubuf;
 			};
@@ -74,6 +77,7 @@ struct iov_iter {
 	};
 	union {
 		unsigned long nr_segs;
+		u8 sheaf_slot;
 		loff_t xarray_start;
 	};
 };
@@ -126,6 +130,11 @@ static inline bool iov_iter_is_discard(const struct iov_iter *i)
 	return iov_iter_type(i) == ITER_DISCARD;
 }
 
+static inline bool iov_iter_is_sheaf(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_SHEAF;
+}
+
 static inline bool iov_iter_is_xarray(const struct iov_iter *i)
 {
 	return iov_iter_type(i) == ITER_XARRAY;
@@ -273,6 +282,8 @@ void iov_iter_kvec(struct iov_iter *i, unsigned int direction, const struct kvec
 void iov_iter_bvec(struct iov_iter *i, unsigned int direction, const struct bio_vec *bvec,
 			unsigned long nr_segs, size_t count);
 void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count);
+void iov_iter_sheaf(struct iov_iter *i, unsigned int direction, const struct sheaf *sheaf,
+		    unsigned int first_slot, unsigned int offset, size_t count);
 void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
 		     loff_t start, size_t count);
 ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 4a6a9f419bd7..d7b36ce32f90 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -527,6 +527,39 @@ static void iov_iter_iovec_advance(struct iov_iter *i, size_t size)
 	i->__iov = iov;
 }
 
+static void iov_iter_sheaf_advance(struct iov_iter *i, size_t size)
+{
+	const struct sheaf *sheaf = i->sheaf;
+	unsigned int slot = i->sheaf_slot;
+
+	if (!i->count)
+		return;
+	i->count -= size;
+
+	if (slot >= sheaf_nr_slots(sheaf)) {
+		sheaf = sheaf->next;
+		slot = 0;
+	}
+
+	size += i->iov_offset; /* From beginning of current segment. */
+	do {
+		size_t fsize = sheaf_folio_size(sheaf, slot);
+
+		if (likely(size < fsize))
+			break;
+		size -= fsize;
+		slot++;
+		if (slot >= sheaf_nr_slots(sheaf) && sheaf->next) {
+			sheaf = sheaf->next;
+			slot = 0;
+		}
+	} while (size);
+
+	i->iov_offset = size;
+	i->sheaf_slot = slot;
+	i->sheaf = sheaf;
+}
+
 void iov_iter_advance(struct iov_iter *i, size_t size)
 {
 	if (unlikely(i->count < size))
@@ -539,12 +572,40 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
 		iov_iter_iovec_advance(i, size);
 	} else if (iov_iter_is_bvec(i)) {
 		iov_iter_bvec_advance(i, size);
+	} else if (iov_iter_is_sheaf(i)) {
+		iov_iter_sheaf_advance(i, size);
 	} else if (iov_iter_is_discard(i)) {
 		i->count -= size;
 	}
 }
 EXPORT_SYMBOL(iov_iter_advance);
 
+static void iov_iter_sheaf_revert(struct iov_iter *i, size_t unroll)
+{
+	const struct sheaf *sheaf = i->sheaf;
+	unsigned int slot = i->sheaf_slot;
+
+	for (;;) {
+		size_t fsize;
+
+		if (slot == 0) {
+			sheaf = sheaf->prev;
+			slot = sheaf_nr_slots(sheaf);
+		}
+		slot--;
+
+		fsize = sheaf_folio_size(sheaf, slot);
+		if (unroll <= fsize) {
+			i->iov_offset = fsize - unroll;
+			break;
+		}
+		unroll -= fsize;
+	}
+
+	i->sheaf_slot = slot;
+	i->sheaf = sheaf;
+}
+
 void iov_iter_revert(struct iov_iter *i, size_t unroll)
 {
 	if (!unroll)
@@ -576,6 +637,9 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 			}
 			unroll -= n;
 		}
+	} else if (iov_iter_is_sheaf(i)) {
+		i->iov_offset = 0;
+		iov_iter_sheaf_revert(i, unroll);
 	} else { /* same logics for iovec and kvec */
 		const struct iovec *iov = iter_iov(i);
 		while (1) {
@@ -603,6 +667,9 @@ size_t iov_iter_single_seg_count(const struct iov_iter *i)
 		if (iov_iter_is_bvec(i))
 			return min(i->count, i->bvec->bv_len - i->iov_offset);
 	}
+	if (unlikely(iov_iter_is_sheaf(i)))
+		return !i->count ? 0 :
+			umin(sheaf_folio_size(i->sheaf, i->sheaf_slot), i->count);
 	return i->count;
 }
 EXPORT_SYMBOL(iov_iter_single_seg_count);
@@ -639,6 +706,36 @@ void iov_iter_bvec(struct iov_iter *i, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_bvec);
 
+/**
+ * iov_iter_sheaf - Initialise an I/O iterator to use the folios in a sheaf
+ * @i: The iterator to initialise.
+ * @direction: The direction of the transfer.
+ * @sheaf: The starting point in the sheaf.
+ * @first_slot: The first slot in the sheaf to use
+ * @offset: The offset into the folio in the first slot to start at
+ * @count: The size of the I/O buffer in bytes.
+ *
+ * Set up an I/O iterator to either draw data out of the pages attached to an
+ * inode or to inject data into those pages.  The pages *must* be prevented
+ * from evaporation, either by taking a ref on them or locking them by the
+ * caller.
+ */
+void iov_iter_sheaf(struct iov_iter *i, unsigned int direction,
+		    const struct sheaf *sheaf, unsigned int first_slot,
+		    unsigned int offset, size_t count)
+{
+	BUG_ON(direction & ~1);
+	*i = (struct iov_iter) {
+		.iter_type = ITER_SHEAF,
+		.data_source = direction,
+		.sheaf = sheaf,
+		.sheaf_slot = first_slot,
+		.count = count,
+		.iov_offset = offset,
+	};
+}
+EXPORT_SYMBOL(iov_iter_sheaf);
+
 /**
  * iov_iter_xarray - Initialise an I/O iterator to use the pages in an xarray
  * @i: The iterator to initialise.
@@ -765,12 +862,19 @@ bool iov_iter_is_aligned(const struct iov_iter *i, unsigned addr_mask,
 	if (iov_iter_is_bvec(i))
 		return iov_iter_aligned_bvec(i, addr_mask, len_mask);
 
+	/* With both xarray and sheaf types, we're dealing with whole folios. */
 	if (iov_iter_is_xarray(i)) {
 		if (i->count & len_mask)
 			return false;
 		if ((i->xarray_start + i->iov_offset) & addr_mask)
 			return false;
 	}
+	if (iov_iter_is_sheaf(i)) {
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
 
+	/* With both xarray and sheaf types, we're dealing with whole folios. */
+	if (iov_iter_is_sheaf(i))
+		return i->iov_offset | i->count;
 	if (iov_iter_is_xarray(i))
 		return (i->xarray_start + i->iov_offset) | i->count;
 
@@ -887,6 +994,51 @@ static int want_pages_array(struct page ***res, size_t size,
 	return count;
 }
 
+static ssize_t iter_sheaf_get_pages(struct iov_iter *iter,
+				    struct page ***ppages, size_t maxsize,
+				    unsigned maxpages, size_t *_start_offset)
+{
+	const struct sheaf *sheaf = iter->sheaf;
+	struct page **pages;
+	unsigned int slot = iter->sheaf_slot;
+	size_t extracted = 0;
+
+	maxpages = want_pages_array(ppages, maxsize, iter->iov_offset & ~PAGE_MASK, maxpages);
+	if (!maxpages)
+		return -ENOMEM;
+	*_start_offset = iter->iov_offset & ~PAGE_MASK;
+	pages = *ppages;
+
+	for (;;) {
+		struct folio *folio = sheaf_slot_folio(sheaf, slot);
+		size_t offset = iter->iov_offset, fsize = sheaf_folio_size(sheaf, slot);
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
+			if (slot == sheaf_nr_slots(sheaf) && sheaf->next) {
+				sheaf = sheaf->next;
+				slot = 0;
+			}
+		}
+	}
+
+	iter->sheaf = sheaf;
+	iter->sheaf_slot = slot;
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
+	if (iov_iter_is_sheaf(i))
+		return iter_sheaf_get_pages(i, pages, maxsize, maxpages, start);
 	if (iov_iter_is_xarray(i))
 		return iter_xarray_get_pages(i, pages, maxsize, maxpages, start);
 	return -EFAULT;
@@ -1118,6 +1272,11 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
 		return iov_npages(i, maxpages);
 	if (iov_iter_is_bvec(i))
 		return bvec_npages(i, maxpages);
+	if (iov_iter_is_sheaf(i)) {
+		unsigned offset = i->iov_offset % PAGE_SIZE;
+		int npages = DIV_ROUND_UP(offset + i->count, PAGE_SIZE);
+		return min(npages, maxpages);
+	}
 	if (iov_iter_is_xarray(i)) {
 		unsigned offset = (i->xarray_start + i->iov_offset) % PAGE_SIZE;
 		int npages = DIV_ROUND_UP(offset + i->count, PAGE_SIZE);
@@ -1398,6 +1557,61 @@ void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
 	i->nr_segs = state->nr_segs;
 }
 
+/*
+ * Extract a list of contiguous pages from an ITER_SHEAF iterator.  This does not
+ * get references on the pages, nor does it get a pin on them.
+ */
+static ssize_t iov_iter_extract_sheaf_pages(struct iov_iter *i,
+					    struct page ***pages, size_t maxsize,
+					    unsigned int maxpages,
+					    iov_iter_extraction_t extraction_flags,
+					    size_t *offset0)
+{
+	const struct sheaf *sheaf = i->sheaf;
+	struct page **p;
+	unsigned int nr = 0;
+	size_t extracted = 0, offset, slot = i->sheaf_slot;
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
+		struct folio *folio = sheaf_slot_folio(sheaf, slot);
+		size_t offset = i->iov_offset, fsize = sheaf_folio_size(sheaf, slot);
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
+			if (slot == sheaf_nr_slots(sheaf) && sheaf->next) {
+				sheaf = sheaf->next;
+				slot = 0;
+			}
+		}
+	}
+
+	i->sheaf = sheaf;
+	i->sheaf_slot = slot;
+	return extracted;
+}
+
 /*
  * Extract a list of contiguous pages from an ITER_XARRAY iterator.  This does not
  * get references on the pages, nor does it get a pin on them.
@@ -1618,8 +1832,8 @@ static ssize_t iov_iter_extract_user_pages(struct iov_iter *i,
  *      added to the pages, but refs will not be taken.
  *      iov_iter_extract_will_pin() will return true.
  *
- *  (*) If the iterator is ITER_KVEC, ITER_BVEC or ITER_XARRAY, the pages are
- *      merely listed; no extra refs or pins are obtained.
+ *  (*) If the iterator is ITER_KVEC, ITER_BVEC, ITER_SHEAF or ITER_XARRAY, the
+ *      pages are merely listed; no extra refs or pins are obtained.
  *      iov_iter_extract_will_pin() will return 0.
  *
  * Note also:
@@ -1654,6 +1868,10 @@ ssize_t iov_iter_extract_pages(struct iov_iter *i,
 		return iov_iter_extract_bvec_pages(i, pages, maxsize,
 						   maxpages, extraction_flags,
 						   offset0);
+	if (iov_iter_is_sheaf(i))
+		return iov_iter_extract_sheaf_pages(i, pages, maxsize,
+						    maxpages, extraction_flags,
+						    offset0);
 	if (iov_iter_is_xarray(i))
 		return iov_iter_extract_xarray_pages(i, pages, maxsize,
 						     maxpages, extraction_flags,
diff --git a/lib/kunit_iov_iter.c b/lib/kunit_iov_iter.c
index 27e0c8ee71d8..423bf280393f 100644
--- a/lib/kunit_iov_iter.c
+++ b/lib/kunit_iov_iter.c
@@ -12,6 +12,7 @@
 #include <linux/mm.h>
 #include <linux/uio.h>
 #include <linux/bvec.h>
+#include <linux/sheaf.h>
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
 
+static void iov_kunit_destroy_sheaf(void *data)
+{
+	struct sheaf *sheaf, *next;
+
+	for (sheaf = data; sheaf; sheaf = next) {
+		next = sheaf->next;
+		for (int i = 0; i < sheaf_nr_slots(sheaf); i++)
+			if (sheaf->slots[i])
+				folio_put(sheaf_slot_folio(sheaf, i));
+		kfree(sheaf);
+	}
+}
+
+static void __init iov_kunit_load_sheaf(struct kunit *test,
+					struct iov_iter *iter, int dir,
+					struct sheaf *sheaf,
+					struct page **pages, size_t npages)
+{
+	struct sheaf *p = sheaf;
+	unsigned int slot = 0;
+	size_t size = 0;
+	int i;
+
+	for (i = 0; i < npages; i++) {
+		if (slot >= sheaf_nr_slots(p)) {
+			p->next = kzalloc(sizeof(struct sheaf), GFP_KERNEL);
+			KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p->next);
+			p->next->prev = p;
+			p = p->next;
+			slot = 0;
+		}
+		sheaf_slot_set_folio(p, slot++, page_folio(pages[i]));
+		size += PAGE_SIZE;
+	}
+	iov_iter_sheaf(iter, dir, sheaf, 0, 0, size);
+}
+
+static struct sheaf *iov_kunit_create_sheaf(struct kunit *test)
+{
+	struct sheaf *sheaf;
+
+	sheaf = kzalloc(sizeof(struct sheaf), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sheaf);
+	kunit_add_action_or_reset(test, iov_kunit_destroy_sheaf, sheaf);
+	return sheaf;
+}
+
+/*
+ * Test copying to a ITER_SHEAF-type iterator.
+ */
+static void __init iov_kunit_copy_to_sheaf(struct kunit *test)
+{
+	const struct kvec_test_range *pr;
+	struct iov_iter iter;
+	struct sheaf *sheaf;
+	struct page **spages, **bpages;
+	u8 *scratch, *buffer;
+	size_t bufsize, npages, size, copied;
+	int i, patt;
+
+	bufsize = 0x100000;
+	npages = bufsize / PAGE_SIZE;
+
+	sheaf = iov_kunit_create_sheaf(test);
+
+	scratch = iov_kunit_create_buffer(test, &spages, npages);
+	for (i = 0; i < bufsize; i++)
+		scratch[i] = pattern(i);
+
+	buffer = iov_kunit_create_buffer(test, &bpages, npages);
+	memset(buffer, 0, bufsize);
+
+	iov_kunit_load_sheaf(test, &iter, READ, sheaf, bpages, npages);
+
+	i = 0;
+	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
+		size = pr->to - pr->from;
+		KUNIT_ASSERT_LE(test, pr->to, bufsize);
+
+		iov_iter_sheaf(&iter, READ, sheaf, 0, 0, pr->to);
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
+ * Test copying from a ITER_SHEAF-type iterator.
+ */
+static void __init iov_kunit_copy_from_sheaf(struct kunit *test)
+{
+	const struct kvec_test_range *pr;
+	struct iov_iter iter;
+	struct sheaf *sheaf;
+	struct page **spages, **bpages;
+	u8 *scratch, *buffer;
+	size_t bufsize, npages, size, copied;
+	int i, j;
+
+	bufsize = 0x100000;
+	npages = bufsize / PAGE_SIZE;
+
+	sheaf = iov_kunit_create_sheaf(test);
+
+	buffer = iov_kunit_create_buffer(test, &bpages, npages);
+	for (i = 0; i < bufsize; i++)
+		buffer[i] = pattern(i);
+
+	scratch = iov_kunit_create_buffer(test, &spages, npages);
+	memset(scratch, 0, bufsize);
+
+	iov_kunit_load_sheaf(test, &iter, READ, sheaf, bpages, npages);
+
+	i = 0;
+	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
+		size = pr->to - pr->from;
+		KUNIT_ASSERT_LE(test, pr->to, bufsize);
+
+		iov_iter_sheaf(&iter, WRITE, sheaf, 0, 0, pr->to);
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
+ * Test the extraction of ITER_SHEAF-type iterators.
+ */
+static void __init iov_kunit_extract_pages_sheaf(struct kunit *test)
+{
+	const struct kvec_test_range *pr;
+	struct iov_iter iter;
+	struct sheaf *sheaf;
+	struct page **bpages, *pagelist[8], **pages = pagelist;
+	ssize_t len;
+	size_t bufsize, size = 0, npages;
+	int i, from;
+
+	bufsize = 0x100000;
+	npages = bufsize / PAGE_SIZE;
+
+	sheaf = iov_kunit_create_sheaf(test);
+
+	iov_kunit_create_buffer(test, &bpages, npages);
+	iov_kunit_load_sheaf(test, &iter, READ, sheaf, bpages, npages);
+
+	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
+		from = pr->from;
+		size = pr->to - from;
+		KUNIT_ASSERT_LE(test, pr->to, bufsize);
+
+		iov_iter_sheaf(&iter, WRITE, sheaf, 0, 0, pr->to);
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
+	KUNIT_CASE(iov_kunit_copy_to_sheaf),
+	KUNIT_CASE(iov_kunit_copy_from_sheaf),
 	KUNIT_CASE(iov_kunit_copy_to_xarray),
 	KUNIT_CASE(iov_kunit_copy_from_xarray),
 	KUNIT_CASE(iov_kunit_extract_pages_kvec),
 	KUNIT_CASE(iov_kunit_extract_pages_bvec),
+	KUNIT_CASE(iov_kunit_extract_pages_sheaf),
 	KUNIT_CASE(iov_kunit_extract_pages_xarray),
 	{}
 };
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 7bc2220fea80..87075f9d759b 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -11,6 +11,7 @@
 #include <linux/kmemleak.h>
 #include <linux/bvec.h>
 #include <linux/uio.h>
+#include <linux/sheaf.h>
 
 /**
  * sg_next - return the next scatterlist entry in a list
@@ -1261,6 +1262,67 @@ static ssize_t extract_kvec_to_sg(struct iov_iter *iter,
 	return ret;
 }
 
+/*
+ * Extract up to sg_max folios from an SHEAF-type iterator and add them to
+ * the scatterlist.  The pages are not pinned.
+ */
+static ssize_t extract_sheaf_to_sg(struct iov_iter *iter,
+				   ssize_t maxsize,
+				   struct sg_table *sgtable,
+				   unsigned int sg_max,
+				   iov_iter_extraction_t extraction_flags)
+{
+	const struct sheaf *sheaf = iter->sheaf;
+	struct scatterlist *sg = sgtable->sgl + sgtable->nents;
+	unsigned int slot = iter->sheaf_slot;
+	ssize_t ret = 0;
+	size_t offset = iter->iov_offset;
+
+	BUG_ON(!sheaf);
+
+	if (slot >= sheaf_nr_slots(sheaf)) {
+		sheaf = sheaf->next;
+		if (WARN_ON_ONCE(!sheaf))
+			return 0;
+		slot = 0;
+	}
+
+	do {
+		struct folio *folio = sheaf_slot_folio(sheaf, slot);
+		size_t fsize = sheaf_folio_size(sheaf, slot);
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
+			if (slot >= sheaf_nr_slots(sheaf)) {
+				if (!sheaf->next) {
+					WARN_ON_ONCE(ret < iter->count);
+					break;
+				}
+				sheaf = sheaf->next;
+				slot = 0;
+			}
+		}
+	} while (sg_max > 0 && ret < maxsize);
+
+	iter->sheaf = sheaf;
+	iter->sheaf_slot = slot;
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
+ * pinned; BVEC-, KVEC-, SHEAF- and XARRAY-type are extracted but aren't
+ * pinned; DISCARD-type is not supported.
  *
  * No end mark is placed on the scatterlist; that's left to the caller.
  *
@@ -1356,6 +1418,9 @@ ssize_t extract_iter_to_sg(struct iov_iter *iter, size_t maxsize,
 	case ITER_KVEC:
 		return extract_kvec_to_sg(iter, maxsize, sgtable, sg_max,
 					  extraction_flags);
+	case ITER_SHEAF:
+		return extract_sheaf_to_sg(iter, maxsize, sgtable, sg_max,
+					   extraction_flags);
 	case ITER_XARRAY:
 		return extract_xarray_to_sg(iter, maxsize, sgtable, sg_max,
 					    extraction_flags);


