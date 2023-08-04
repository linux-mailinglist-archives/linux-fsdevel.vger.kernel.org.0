Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9797700F0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 15:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjHDNPO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 09:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjHDNPK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:15:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C7B49EA
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 06:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691154824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jiF+kS1Q7QW8kRXIszx5l4gqFEa5gtRwSd/BWqINlvE=;
        b=iSHisHBSotQ6hPjEjkuwkpPNMZo9UJc/sq4yt4Ntksqe8tHEItE1/yKKVdBRlw/ga+krkb
        eAblUR3FiMsjkdJdp87WMQvwK0oKUR3uNZPtXZijX/cQKNAJuiKEaSZSCeqFISSCccPdHt
        SxU7ZLg47+EI+Y34acKprxr4QliYxQo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549--MKL2r53P3KJADW2FAllNQ-1; Fri, 04 Aug 2023 09:13:38 -0400
X-MC-Unique: -MKL2r53P3KJADW2FAllNQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6E608DC663;
        Fri,  4 Aug 2023 13:13:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90668C5796B;
        Fri,  4 Aug 2023 13:13:36 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 03/18] ceph: Add a new data container type, ceph_databuf
Date:   Fri,  4 Aug 2023 14:13:12 +0100
Message-ID: <20230804131327.2574082-4-dhowells@redhat.com>
In-Reply-To: <20230804131327.2574082-1-dhowells@redhat.com>
References: <20230804131327.2574082-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a new ceph data container type, ceph_databuf, that carries a list of
pages in a bvec and use an iov_iter to handle the addition of data.

This is intended to replace all other types.

Signed-off-by: David Howells <dhowells@redhat.com>
---
 include/linux/ceph/databuf.h    |  65 ++++++++++++++
 include/linux/ceph/messenger.h  |   6 +-
 include/linux/ceph/osd_client.h |   9 ++
 net/ceph/Makefile               |   3 +-
 net/ceph/databuf.c              | 149 ++++++++++++++++++++++++++++++++
 net/ceph/messenger.c            |  22 ++++-
 6 files changed, 251 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/ceph/databuf.h
 create mode 100644 net/ceph/databuf.c

diff --git a/include/linux/ceph/databuf.h b/include/linux/ceph/databuf.h
new file mode 100644
index 000000000000..7146e3484250
--- /dev/null
+++ b/include/linux/ceph/databuf.h
@@ -0,0 +1,65 @@
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
+	struct iov_iter	iter;		/* Iterator holding append point */
+	size_t		length;		/* Amount of data stored */
+	size_t		limit;		/* Maximum length before expansion required */
+	size_t		nr_bvec;	/* Number of bvec[] that have pages */
+	size_t		max_bvec;	/* Size of bvec[] */
+	refcount_t	refcnt;
+};
+
+struct ceph_databuf *ceph_databuf_alloc(size_t min_bvec, size_t space, gfp_t gfp);
+void ceph_databuf_release(struct ceph_databuf *dbuf);
+int ceph_databuf_append(struct ceph_databuf *dbuf, const void *d, size_t l);
+int ceph_databuf_reserve(struct ceph_databuf *dbuf, size_t space, gfp_t gfp);
+int ceph_databuf_insert_frag(struct ceph_databuf *dbuf, unsigned int ix,
+			     size_t len, gfp_t gfp);
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
+#endif /* __FS_CEPH_DATABUF_H */
diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index f6f11bf9d63e..351d00e9632d 100644
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
index 3dabebbdb5dc..2d8cd45f1c34 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -16,6 +16,7 @@
 #include <linux/ceph/msgpool.h>
 #include <linux/ceph/auth.h>
 #include <linux/ceph/pagelist.h>
+#include <linux/ceph/databuf.h>
 
 struct ceph_msg;
 struct ceph_snap_context;
@@ -102,6 +103,7 @@ struct ceph_osd {
 
 enum ceph_osd_data_type {
 	CEPH_OSD_DATA_TYPE_NONE = 0,
+	CEPH_OSD_DATA_TYPE_DATABUF,
 	CEPH_OSD_DATA_TYPE_PAGES,
 	CEPH_OSD_DATA_TYPE_PAGELIST,
 #ifdef CONFIG_BLOCK
@@ -114,6 +116,7 @@ enum ceph_osd_data_type {
 struct ceph_osd_data {
 	enum ceph_osd_data_type	type;
 	union {
+		struct ceph_databuf	*dbuf;
 		struct {
 			struct page	**pages;
 			u64		length;
@@ -486,6 +489,9 @@ extern struct ceph_osd_data *osd_req_op_extent_osd_data(
 					struct ceph_osd_request *osd_req,
 					unsigned int which);
 
+extern void osd_req_op_extent_osd_databuf(struct ceph_osd_request *req,
+					  unsigned int which,
+					  struct ceph_databuf *dbuf);
 extern void osd_req_op_extent_osd_data_pages(struct ceph_osd_request *,
 					unsigned int which,
 					struct page **pages, u64 length,
@@ -510,6 +516,9 @@ void osd_req_op_extent_osd_data_bvec_pos(struct ceph_osd_request *osd_req,
 void osd_req_op_extent_osd_iter(struct ceph_osd_request *osd_req,
 				unsigned int which, struct iov_iter *iter);
 
+void osd_req_op_cls_request_databuf(struct ceph_osd_request *req,
+				    unsigned int which,
+				    struct ceph_databuf *dbuf);
 extern void osd_req_op_cls_request_data_pagelist(struct ceph_osd_request *,
 					unsigned int which,
 					struct ceph_pagelist *pagelist);
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
index 000000000000..cb070cedc5d9
--- /dev/null
+++ b/net/ceph/databuf.c
@@ -0,0 +1,149 @@
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
+struct ceph_databuf *ceph_databuf_alloc(size_t min_bvec, size_t space, gfp_t gfp)
+{
+	struct ceph_databuf *dbuf;
+
+	dbuf = kzalloc(sizeof(*dbuf), gfp);
+	if (!dbuf)
+		return NULL;
+
+	min_bvec = max_t(size_t, min_bvec, 16);
+
+	dbuf->bvec = kcalloc(min_bvec, sizeof(struct bio_vec), gfp);
+	if (!dbuf->bvec) {
+		kfree(dbuf);
+		return NULL;
+	}
+
+	dbuf->max_bvec = min_bvec;
+	iov_iter_bvec(&dbuf->iter, ITER_DEST, dbuf->bvec, 0, 0);
+	refcount_set(&dbuf->refcnt, 1);
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
+void ceph_databuf_release(struct ceph_databuf *dbuf)
+{
+	size_t i;
+
+	if (!dbuf || !refcount_dec_and_test(&dbuf->refcnt))
+		return;
+
+	for (i = 0; i < dbuf->nr_bvec; i++)
+		__free_page(dbuf->bvec[i].bv_page);
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
+	size_t size, max_bvec;
+
+	max_bvec = roundup_pow_of_two(req_bvec);
+	size = array_size(max_bvec, sizeof(struct bio_vec));
+
+	bvec = krealloc(old, size, gfp);
+	if (!bvec)
+		return -ENOMEM;
+	dbuf->bvec = bvec;
+	dbuf->max_bvec = max_bvec;
+	dbuf->iter.bvec = bvec + (dbuf->iter.bvec - old);
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
+	struct bio_vec *bvec = dbuf->bvec;
+	size_t i, req_bvec = DIV_ROUND_UP(dbuf->length + add_space, PAGE_SIZE);
+	int ret;
+
+	if (req_bvec > dbuf->max_bvec) {
+		ret = ceph_databuf_expand(dbuf, req_bvec, gfp);
+		if (ret < 0)
+			return ret;
+	}
+
+	while (dbuf->nr_bvec < req_bvec) {
+		struct page *pages[16];
+		size_t want = min(req_bvec, ARRAY_SIZE(pages)), got;
+
+		memset(&pages, 0, sizeof(pages));
+		got = alloc_pages_bulk_array(gfp, want, pages);
+		if (!got)
+			return -ENOMEM;
+		for (i = 0; i < got; i++)
+			bvec_set_page(&bvec[dbuf->nr_bvec + i], pages[i],
+				      PAGE_SIZE, 0);
+		dbuf->iter.count += got * PAGE_SIZE;
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
+	if (dbuf->limit - dbuf->length > len &&
+	    ceph_databuf_reserve(dbuf, len, GFP_NOIO) < 0)
+		return -ENOMEM;
+
+	if (copy_to_iter(buf, len, &dbuf->iter) != len)
+		return -EFAULT;
+	dbuf->length += len;
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
+	struct bio_vec *bv = &dbuf->bvec[ix];
+
+	bv->bv_page = alloc_page(gfp);
+	if (!bv->bv_page)
+		return -ENOMEM;
+	bv->bv_offset = 0;
+	bv->bv_len = len;
+
+	if (dbuf->nr_bvec == ix)
+		dbuf->nr_bvec = ix + 1;
+	return 0;
+}
+EXPORT_SYMBOL(ceph_databuf_insert_frag);
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 6cfc6b69052f..4c8899c26e1e 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1872,7 +1872,9 @@ static struct ceph_msg_data *ceph_msg_data_add(struct ceph_msg *msg)
 
 static void ceph_msg_data_destroy(struct ceph_msg_data *data)
 {
-	if (data->type == CEPH_MSG_DATA_PAGES && data->own_pages) {
+	if (data->release_dbuf) {
+		ceph_databuf_release(data->dbuf);
+	} else if (data->type == CEPH_MSG_DATA_PAGES && data->own_pages) {
 		int num_pages = calc_pages_for(data->offset, data->length);
 		ceph_release_page_vector(data->pages, num_pages);
 	} else if (data->type == CEPH_MSG_DATA_PAGELIST) {
@@ -1880,6 +1882,24 @@ static void ceph_msg_data_destroy(struct ceph_msg_data *data)
 	}
 }
 
+void ceph_msg_data_add_databuf(struct ceph_msg *msg, struct ceph_databuf *dbuf)
+{
+	struct ceph_msg_data *data;
+
+	BUG_ON(!dbuf);
+	BUG_ON(!dbuf->length);
+
+	data = ceph_msg_data_add(msg);
+	data->type = CEPH_MSG_DATA_ITER;
+	data->dbuf = dbuf;
+	refcount_inc(&dbuf->refcnt);
+
+	iov_iter_bvec(&data->iter, ITER_SOURCE,
+		      dbuf->bvec, dbuf->nr_bvec, dbuf->length);
+	msg->data_length += dbuf->length;
+}
+EXPORT_SYMBOL(ceph_msg_data_add_databuf);
+
 void ceph_msg_data_add_pages(struct ceph_msg *msg, struct page **pages,
 			     size_t length, size_t offset, bool own_pages)
 {

