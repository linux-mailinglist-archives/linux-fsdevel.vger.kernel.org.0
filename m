Return-Path: <linux-fsdevel+bounces-43952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EACA60568
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 00:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA4342120E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 23:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03071FC7EC;
	Thu, 13 Mar 2025 23:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xvwjl/vJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206341F8721
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 23:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908850; cv=none; b=QDVSSkg1LplQ7ECLpuvYRQ18yvspmGNwxpzoJXqHXYfzcQ/9bbbyLLAhj33E6LOZK5FMpRRdFG9BdhxZ6UZ1YfEeEozKhf6bQxe3fTYhpIS0dlIqE6fV+0Gsyk6RAuURPoFrmDcHaDrNYLaz/4186hPuwnY2AR4cetqeis6PYOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908850; c=relaxed/simple;
	bh=93bsT2wHf3/F90g4Octf8J1152N7Qwun0pcje7lTR5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AsXQy78/s08wROB+dZgAk6ABLH0IuA5kuQifIqNEua7CUM+A4x6ficl312fC3BwfW4fRhHAd7HuVuXygex8VsIcjpA3WdRgxAdqtR6omDb8M98QUFjEdp3XmrU8W31TcNeuEGn00JUbvMvf1GUCQ73+k/whjJF6lWG8VYave4S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xvwjl/vJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dx+3jVw5Ls7OLpNlaQ5TGP/nAsdz4S9eFkCPMqACq2w=;
	b=Xvwjl/vJEbaZgwgUbkZE6ybly7pEW/j3ezzrFWdRZMk+Zx5987Xt8SIOzqNgfj/K+jNw68
	B5JdWkShJrsB5Umf8nwFebYqQZdAxWtn4C9eDN1Ih0H7SDTdmaj66tuk+ZvJbA4Er42SPP
	qO4FwWA/w9rdFYmUnz4v0mYZTxAbTaI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-vS8KTAWxMqKA4obt44UXXg-1; Thu,
 13 Mar 2025 19:34:05 -0400
X-MC-Unique: vS8KTAWxMqKA4obt44UXXg-1
X-Mimecast-MFC-AGG-ID: vS8KTAWxMqKA4obt44UXXg_1741908843
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7697E1955DCC;
	Thu, 13 Mar 2025 23:34:02 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8F9F318001F6;
	Thu, 13 Mar 2025 23:33:59 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>
Cc: David Howells <dhowells@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 03/35] libceph: Add a new data container type, ceph_databuf
Date: Thu, 13 Mar 2025 23:32:55 +0000
Message-ID: <20250313233341.1675324-4-dhowells@redhat.com>
In-Reply-To: <20250313233341.1675324-1-dhowells@redhat.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add a new ceph data container type, ceph_databuf, that can carry a list of
pages in a bvec and use an iov_iter to handle describe the data to the next
layer down.  The iterator can also be used to refer to other types, such as
ITER_FOLIOQ.

There are two ways of loading the bvec.  One way is to allocate a buffer
with space in it and then add data, expanding the space as needed; the
other is to splice in pages, expanding the bvec[] as needed.

This is intended to replace all other types.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 include/linux/ceph/databuf.h    | 131 +++++++++++++++++++++
 include/linux/ceph/messenger.h  |   6 +-
 include/linux/ceph/osd_client.h |   3 +
 net/ceph/Makefile               |   3 +-
 net/ceph/databuf.c              | 200 ++++++++++++++++++++++++++++++++
 net/ceph/messenger.c            |  20 +++-
 net/ceph/osd_client.c           |  11 +-
 7 files changed, 369 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/ceph/databuf.h
 create mode 100644 net/ceph/databuf.c

diff --git a/include/linux/ceph/databuf.h b/include/linux/ceph/databuf.h
new file mode 100644
index 000000000000..14c7a6449467
--- /dev/null
+++ b/include/linux/ceph/databuf.h
@@ -0,0 +1,131 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __FS_CEPH_DATABUF_H
+#define __FS_CEPH_DATABUF_H
+
+#include <asm/byteorder.h>
+#include <linux/refcount.h>
+#include <linux/blk_types.h>
+
+struct ceph_databuf {
+	struct bio_vec	*bvec;		/* List of pages */
+	struct bio_vec	inline_bvec[1];	/* Inline bvecs for small buffers */
+	struct iov_iter	iter;		/* Iterator defining occupied data */
+	size_t		limit;		/* Maximum length before expansion required */
+	size_t		nr_bvec;	/* Number of bvec[] that have pages */
+	size_t		max_bvec;	/* Size of bvec[] */
+	refcount_t	refcnt;
+	bool		put_pages;	/* T if pages in bvec[] need to be put*/
+};
+
+struct ceph_databuf *ceph_databuf_alloc(size_t min_bvec, size_t space,
+					unsigned int data_source, gfp_t gfp);
+struct ceph_databuf *ceph_databuf_get(struct ceph_databuf *dbuf);
+void ceph_databuf_release(struct ceph_databuf *dbuf);
+int ceph_databuf_append(struct ceph_databuf *dbuf, const void *d, size_t l);
+int ceph_databuf_reserve(struct ceph_databuf *dbuf, size_t space, gfp_t gfp);
+int ceph_databuf_insert_frag(struct ceph_databuf *dbuf, unsigned int ix,
+			     size_t len, gfp_t gfp);
+
+static inline
+struct ceph_databuf *ceph_databuf_req_alloc(size_t min_bvec, size_t space, gfp_t gfp)
+{
+	return ceph_databuf_alloc(min_bvec, space, ITER_SOURCE, gfp);
+}
+
+static inline
+struct ceph_databuf *ceph_databuf_reply_alloc(size_t min_bvec, size_t space, gfp_t gfp)
+{
+	struct ceph_databuf *dbuf;
+
+	dbuf = ceph_databuf_alloc(min_bvec, space, ITER_DEST, gfp);
+	if (dbuf)
+		iov_iter_reexpand(&dbuf->iter, space);
+	return dbuf;
+}
+
+static inline struct page *ceph_databuf_page(struct ceph_databuf *dbuf,
+					     unsigned int ix)
+{
+	return dbuf->bvec[ix].bv_page;
+}
+
+#define kmap_ceph_databuf_page(dbuf, ix) \
+	kmap_local_page(ceph_databuf_page(dbuf, ix));
+
+static inline int ceph_databuf_encode_64(struct ceph_databuf *dbuf, u64 v)
+{
+	__le64 ev = cpu_to_le64(v);
+	return ceph_databuf_append(dbuf, &ev, sizeof(ev));
+}
+static inline int ceph_databuf_encode_32(struct ceph_databuf *dbuf, u32 v)
+{
+	__le32 ev = cpu_to_le32(v);
+	return ceph_databuf_append(dbuf, &ev, sizeof(ev));
+}
+static inline int ceph_databuf_encode_16(struct ceph_databuf *dbuf, u16 v)
+{
+	__le16 ev = cpu_to_le16(v);
+	return ceph_databuf_append(dbuf, &ev, sizeof(ev));
+}
+static inline int ceph_databuf_encode_8(struct ceph_databuf *dbuf, u8 v)
+{
+	return ceph_databuf_append(dbuf, &v, 1);
+}
+static inline int ceph_databuf_encode_string(struct ceph_databuf *dbuf,
+					     const char *s, u32 len)
+{
+	int ret = ceph_databuf_encode_32(dbuf, len);
+	if (ret)
+		return ret;
+	if (len)
+		return ceph_databuf_append(dbuf, s, len);
+	return 0;
+}
+
+static inline size_t ceph_databuf_len(struct ceph_databuf *dbuf)
+{
+	return dbuf->iter.count;
+}
+
+static inline void ceph_databuf_added_data(struct ceph_databuf *dbuf,
+					   size_t len)
+{
+	dbuf->iter.count += len;
+}
+
+static inline void ceph_databuf_reply_ready(struct ceph_databuf *reply,
+					    size_t len)
+{
+	reply->iter.data_source = ITER_SOURCE;
+	iov_iter_truncate(&reply->iter, len);
+}
+
+static inline void ceph_databuf_reset_reply(struct ceph_databuf *reply)
+{
+	iov_iter_bvec(&reply->iter, ITER_DEST,
+		      reply->bvec, reply->nr_bvec, reply->limit);
+}
+
+static inline void ceph_databuf_append_page(struct ceph_databuf *dbuf,
+					    struct page *page,
+					    unsigned int offset,
+					    unsigned int len)
+{
+	BUG_ON(dbuf->nr_bvec >= dbuf->max_bvec);
+	bvec_set_page(&dbuf->bvec[dbuf->nr_bvec++], page, len, offset);
+	dbuf->iter.count += len;
+	dbuf->iter.nr_segs++;
+}
+
+static inline void *ceph_databuf_enc_start(struct ceph_databuf *dbuf)
+{
+	return page_address(ceph_databuf_page(dbuf, 0)) + dbuf->iter.count;
+}
+
+static inline void ceph_databuf_enc_stop(struct ceph_databuf *dbuf, void *p)
+{
+	dbuf->iter.count = p - page_address(ceph_databuf_page(dbuf, 0));
+	BUG_ON(dbuf->iter.count > dbuf->limit);
+}
+
+#endif /* __FS_CEPH_DATABUF_H */
diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index db2aba32b8a0..864aad369c91 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -117,6 +117,7 @@ struct ceph_messenger {
 
 enum ceph_msg_data_type {
 	CEPH_MSG_DATA_NONE,	/* message contains no data payload */
+	CEPH_MSG_DATA_DATABUF,	/* data source/destination is a data buffer */
 	CEPH_MSG_DATA_PAGES,	/* data source/destination is a page array */
 	CEPH_MSG_DATA_PAGELIST,	/* data source/destination is a pagelist */
 #ifdef CONFIG_BLOCK
@@ -210,7 +211,10 @@ struct ceph_bvec_iter {
 
 struct ceph_msg_data {
 	enum ceph_msg_data_type		type;
+	struct iov_iter			iter;
+	bool				release_dbuf;
 	union {
+		struct ceph_databuf	*dbuf;
 #ifdef CONFIG_BLOCK
 		struct {
 			struct ceph_bio_iter	bio_pos;
@@ -225,7 +229,6 @@ struct ceph_msg_data {
 			bool		own_pages;
 		};
 		struct ceph_pagelist	*pagelist;
-		struct iov_iter		iter;
 	};
 };
 
@@ -601,6 +604,7 @@ extern void ceph_con_keepalive(struct ceph_connection *con);
 extern bool ceph_con_keepalive_expired(struct ceph_connection *con,
 				       unsigned long interval);
 
+void ceph_msg_data_add_databuf(struct ceph_msg *msg, struct ceph_databuf *dbuf);
 void ceph_msg_data_add_pages(struct ceph_msg *msg, struct page **pages,
 			     size_t length, size_t offset, bool own_pages);
 extern void ceph_msg_data_add_pagelist(struct ceph_msg *msg,
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 8fc84f389aad..b8fb5a71dd57 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -16,6 +16,7 @@
 #include <linux/ceph/msgpool.h>
 #include <linux/ceph/auth.h>
 #include <linux/ceph/pagelist.h>
+#include <linux/ceph/databuf.h>
 
 struct ceph_msg;
 struct ceph_snap_context;
@@ -103,6 +104,7 @@ struct ceph_osd {
 
 enum ceph_osd_data_type {
 	CEPH_OSD_DATA_TYPE_NONE = 0,
+	CEPH_OSD_DATA_TYPE_DATABUF,
 	CEPH_OSD_DATA_TYPE_PAGES,
 	CEPH_OSD_DATA_TYPE_PAGELIST,
 #ifdef CONFIG_BLOCK
@@ -115,6 +117,7 @@ enum ceph_osd_data_type {
 struct ceph_osd_data {
 	enum ceph_osd_data_type	type;
 	union {
+		struct ceph_databuf	*dbuf;
 		struct {
 			struct page	**pages;
 			u64		length;
diff --git a/net/ceph/Makefile b/net/ceph/Makefile
index 8802a0c0155d..4b2e0b654e45 100644
--- a/net/ceph/Makefile
+++ b/net/ceph/Makefile
@@ -15,4 +15,5 @@ libceph-y := ceph_common.o messenger.o msgpool.o buffer.o pagelist.o \
 	auth_x.o \
 	ceph_strings.o ceph_hash.o \
 	pagevec.o snapshot.o string_table.o \
-	messenger_v1.o messenger_v2.o
+	messenger_v1.o messenger_v2.o \
+	databuf.o
diff --git a/net/ceph/databuf.c b/net/ceph/databuf.c
new file mode 100644
index 000000000000..9d108fff5a4f
--- /dev/null
+++ b/net/ceph/databuf.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Data container
+ *
+ * Copyright (C) 2023 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/export.h>
+#include <linux/gfp.h>
+#include <linux/slab.h>
+#include <linux/uio.h>
+#include <linux/pagemap.h>
+#include <linux/highmem.h>
+#include <linux/ceph/databuf.h>
+
+struct ceph_databuf *ceph_databuf_alloc(size_t min_bvec, size_t space,
+					unsigned int data_source, gfp_t gfp)
+{
+	struct ceph_databuf *dbuf;
+	size_t inl = ARRAY_SIZE(dbuf->inline_bvec);
+
+	dbuf = kzalloc(sizeof(*dbuf), gfp);
+	if (!dbuf)
+		return NULL;
+
+	refcount_set(&dbuf->refcnt, 1);
+
+	if (min_bvec == 0 && space == 0) {
+		/* Do nothing */
+	} else if (min_bvec <= inl && space <= inl * PAGE_SIZE) {
+		dbuf->bvec = dbuf->inline_bvec;
+		dbuf->max_bvec = inl;
+		dbuf->limit = space;
+	} else if (min_bvec) {
+		min_bvec = umax(min_bvec, 16);
+
+		dbuf->bvec = kcalloc(min_bvec, sizeof(struct bio_vec), gfp);
+		if (!dbuf->bvec) {
+			kfree(dbuf);
+			return NULL;
+		}
+
+		dbuf->max_bvec = min_bvec;
+	}
+
+	iov_iter_bvec(&dbuf->iter, data_source, dbuf->bvec, 0, 0);
+
+	if (space) {
+		if (ceph_databuf_reserve(dbuf, space, gfp) < 0) {
+			ceph_databuf_release(dbuf);
+			return NULL;
+		}
+	}
+	return dbuf;
+}
+EXPORT_SYMBOL(ceph_databuf_alloc);
+
+struct ceph_databuf *ceph_databuf_get(struct ceph_databuf *dbuf)
+{
+	if (!dbuf)
+		return NULL;
+	refcount_inc(&dbuf->refcnt);
+	return dbuf;
+}
+EXPORT_SYMBOL(ceph_databuf_get);
+
+void ceph_databuf_release(struct ceph_databuf *dbuf)
+{
+	size_t i;
+
+	if (!dbuf || !refcount_dec_and_test(&dbuf->refcnt))
+		return;
+
+	if (dbuf->put_pages)
+		for (i = 0; i < dbuf->nr_bvec; i++)
+			put_page(dbuf->bvec[i].bv_page);
+	if (dbuf->bvec != dbuf->inline_bvec)
+		kfree(dbuf->bvec);
+	kfree(dbuf);
+}
+EXPORT_SYMBOL(ceph_databuf_release);
+
+/*
+ * Expand the bvec[] in the dbuf.
+ */
+static int ceph_databuf_expand(struct ceph_databuf *dbuf, size_t req_bvec,
+			       gfp_t gfp)
+{
+	struct bio_vec *bvec = dbuf->bvec, *old = bvec;
+	size_t size, max_bvec, off = dbuf->iter.bvec - old;
+	size_t inl = ARRAY_SIZE(dbuf->inline_bvec);
+
+	if (req_bvec <= inl) {
+		dbuf->bvec = dbuf->inline_bvec;
+		dbuf->max_bvec = inl;
+		dbuf->iter.bvec = dbuf->inline_bvec + off;
+		return 0;
+	}
+
+	max_bvec = roundup_pow_of_two(req_bvec);
+	size = array_size(max_bvec, sizeof(struct bio_vec));
+
+	if (old == dbuf->inline_bvec) {
+		bvec = kmalloc_array(max_bvec, sizeof(struct bio_vec), gfp);
+		if (!bvec)
+			return -ENOMEM;
+		memcpy(bvec, old, inl);
+	} else {
+		bvec = krealloc(old, size, gfp);
+		if (!bvec)
+			return -ENOMEM;
+	}
+	dbuf->bvec = bvec;
+	dbuf->max_bvec = max_bvec;
+	dbuf->iter.bvec = bvec + off;
+	return 0;
+}
+
+/* Allocate enough pages for a dbuf to append the given amount
+ * of dbuf without allocating.
+ * Returns: 0 on success, -ENOMEM on error.
+ */
+int ceph_databuf_reserve(struct ceph_databuf *dbuf, size_t add_space,
+			 gfp_t gfp)
+{
+	struct bio_vec *bvec;
+	size_t i, req_bvec = DIV_ROUND_UP(dbuf->iter.count + add_space, PAGE_SIZE);
+	int ret;
+
+	dbuf->put_pages = true;
+	if (req_bvec > dbuf->max_bvec) {
+		ret = ceph_databuf_expand(dbuf, req_bvec, gfp);
+		if (ret < 0)
+			return ret;
+	}
+
+	bvec = dbuf->bvec;
+	while (dbuf->nr_bvec < req_bvec) {
+		struct page *pages[16];
+		size_t want = min(req_bvec, ARRAY_SIZE(pages)), got;
+
+		memset(pages, 0, sizeof(pages));
+		got = alloc_pages_bulk(gfp, want, pages);
+		if (!got)
+			return -ENOMEM;
+		for (i = 0; i < got; i++)
+			bvec_set_page(&bvec[dbuf->nr_bvec + i], pages[i],
+				      PAGE_SIZE, 0);
+		dbuf->iter.nr_segs += got;
+		dbuf->nr_bvec += got;
+		dbuf->limit = dbuf->nr_bvec * PAGE_SIZE;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(ceph_databuf_reserve);
+
+int ceph_databuf_append(struct ceph_databuf *dbuf, const void *buf, size_t len)
+{
+	struct iov_iter temp_iter;
+
+	if (!len)
+		return 0;
+	if (dbuf->limit - dbuf->iter.count > len &&
+	    ceph_databuf_reserve(dbuf, len, GFP_NOIO) < 0)
+		return -ENOMEM;
+
+	iov_iter_bvec(&temp_iter, ITER_DEST,
+		      dbuf->bvec, dbuf->nr_bvec, dbuf->limit);
+	iov_iter_advance(&temp_iter, dbuf->iter.count);
+
+	if (copy_to_iter(buf, len, &temp_iter) != len)
+		return -EFAULT;
+	dbuf->iter.count += len;
+	return 0;
+}
+EXPORT_SYMBOL(ceph_databuf_append);
+
+/*
+ * Allocate a fragment and insert it into the buffer at the specified index.
+ */
+int ceph_databuf_insert_frag(struct ceph_databuf *dbuf, unsigned int ix,
+			     size_t len, gfp_t gfp)
+{
+	struct page *page;
+
+	page = alloc_page(gfp);
+	if (!page)
+		return -ENOMEM;
+
+	bvec_set_page(&dbuf->bvec[ix], page, len, 0);
+
+	if (dbuf->nr_bvec == ix) {
+		dbuf->iter.nr_segs = ix + 1;
+		dbuf->nr_bvec = ix + 1;
+		dbuf->iter.count += len;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(ceph_databuf_insert_frag);
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 1df4291cc80b..802f0b222131 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1872,7 +1872,9 @@ static struct ceph_msg_data *ceph_msg_data_add(struct ceph_msg *msg)
 
 static void ceph_msg_data_destroy(struct ceph_msg_data *data)
 {
-	if (data->type == CEPH_MSG_DATA_PAGES && data->own_pages) {
+	if (data->type == CEPH_MSG_DATA_DATABUF) {
+		ceph_databuf_release(data->dbuf);
+	} else if (data->type == CEPH_MSG_DATA_PAGES && data->own_pages) {
 		int num_pages = calc_pages_for(data->offset, data->length);
 		ceph_release_page_vector(data->pages, num_pages);
 	} else if (data->type == CEPH_MSG_DATA_PAGELIST) {
@@ -1880,6 +1882,22 @@ static void ceph_msg_data_destroy(struct ceph_msg_data *data)
 	}
 }
 
+void ceph_msg_data_add_databuf(struct ceph_msg *msg, struct ceph_databuf *dbuf)
+{
+	struct ceph_msg_data *data;
+
+	BUG_ON(!dbuf);
+	BUG_ON(!ceph_databuf_len(dbuf));
+
+	data = ceph_msg_data_add(msg);
+	data->type = CEPH_MSG_DATA_DATABUF;
+	data->dbuf = ceph_databuf_get(dbuf);
+	data->iter = dbuf->iter;
+
+	msg->data_length += ceph_databuf_len(dbuf);
+}
+EXPORT_SYMBOL(ceph_msg_data_add_databuf);
+
 void ceph_msg_data_add_pages(struct ceph_msg *msg, struct page **pages,
 			     size_t length, size_t offset, bool own_pages)
 {
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index e359e70ad47e..c84634264377 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -359,6 +359,8 @@ static u64 ceph_osd_data_length(struct ceph_osd_data *osd_data)
 	switch (osd_data->type) {
 	case CEPH_OSD_DATA_TYPE_NONE:
 		return 0;
+	case CEPH_OSD_DATA_TYPE_DATABUF:
+		return ceph_databuf_len(osd_data->dbuf);
 	case CEPH_OSD_DATA_TYPE_PAGES:
 		return osd_data->length;
 	case CEPH_OSD_DATA_TYPE_PAGELIST:
@@ -379,7 +381,9 @@ static u64 ceph_osd_data_length(struct ceph_osd_data *osd_data)
 
 static void ceph_osd_data_release(struct ceph_osd_data *osd_data)
 {
-	if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES && osd_data->own_pages) {
+	if (osd_data->type == CEPH_OSD_DATA_TYPE_DATABUF) {
+		ceph_databuf_release(osd_data->dbuf);
+	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES && osd_data->own_pages) {
 		int num_pages;
 
 		num_pages = calc_pages_for((u64)osd_data->offset,
@@ -965,7 +969,10 @@ static void ceph_osdc_msg_data_add(struct ceph_msg *msg,
 {
 	u64 length = ceph_osd_data_length(osd_data);
 
-	if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
+	if (osd_data->type == CEPH_OSD_DATA_TYPE_DATABUF) {
+		BUG_ON(!length);
+		ceph_msg_data_add_databuf(msg, osd_data->dbuf);
+	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
 		BUG_ON(length > (u64) SIZE_MAX);
 		if (length)
 			ceph_msg_data_add_pages(msg, osd_data->pages,


