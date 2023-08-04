Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABEC770125
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 15:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjHDNQx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 09:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjHDNQS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:16:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B214C3B
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 06:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691154841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oVee4rtXMYHUJZK2CEQzZWTxaX9UJNm5zlDFLGqikl8=;
        b=VgZ13kBYU1RxbzUY3W891YR16HzJJiZfSyNraq0C48kBIvtItIKNjyroSXHtp25wUFg3Ys
        1yXKTLPn6hm+tSRLfLWS7NQf70Urgqe4d9U7dKSEJiiU5OBwBFc7gDAIgml+hiJRPWojq9
        /d7uEN3uszJFTYuOcF1Xh71GkF0wYeE=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-X_0h_HJxMUy5w_9McjiieQ-1; Fri, 04 Aug 2023 09:13:59 -0400
X-MC-Unique: X_0h_HJxMUy5w_9McjiieQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29F1B1C060DE;
        Fri,  4 Aug 2023 13:13:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DAABB1401C2E;
        Fri,  4 Aug 2023 13:13:57 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 14/18] ceph: Remove ceph_pagelist
Date:   Fri,  4 Aug 2023 14:13:23 +0100
Message-ID: <20230804131327.2574082-15-dhowells@redhat.com>
In-Reply-To: <20230804131327.2574082-1-dhowells@redhat.com>
References: <20230804131327.2574082-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove ceph_pagelist and its helpers.

Signed-off-by: David Howells <dhowells@redhat.com>
---
 fs/ceph/locks.c                 |   1 -
 fs/ceph/mds_client.c            |   1 -
 fs/ceph/xattr.c                 |   1 -
 include/linux/ceph/messenger.h  |   8 --
 include/linux/ceph/osd_client.h |   9 --
 include/linux/ceph/pagelist.h   |  72 --------------
 net/ceph/Makefile               |   2 +-
 net/ceph/messenger.c            | 110 --------------------
 net/ceph/osd_client.c           |  51 ----------
 net/ceph/pagelist.c             | 171 --------------------------------
 10 files changed, 1 insertion(+), 425 deletions(-)
 delete mode 100644 include/linux/ceph/pagelist.h
 delete mode 100644 net/ceph/pagelist.c

diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index b3c018a8a92f..f80b09304fdc 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -8,7 +8,6 @@
 #include "super.h"
 #include "mds_client.h"
 #include <linux/filelock.h>
-#include <linux/ceph/pagelist.h>
 
 static u64 lock_secret;
 static int ceph_lock_wait_for_completion(struct ceph_mds_client *mdsc,
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 9f5c4f47982e..e94877725824 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -21,7 +21,6 @@
 #include <linux/ceph/ceph_features.h>
 #include <linux/ceph/messenger.h>
 #include <linux/ceph/decode.h>
-#include <linux/ceph/pagelist.h>
 #include <linux/ceph/auth.h>
 #include <linux/ceph/debugfs.h>
 
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index ca3ec5dd0382..d42779d10dc9 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/ceph/ceph_debug.h>
-#include <linux/ceph/pagelist.h>
 
 #include "super.h"
 #include "mds_client.h"
diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 0f4cc6e39da0..a2489e266bff 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -119,7 +119,6 @@ enum ceph_msg_data_type {
 	CEPH_MSG_DATA_NONE,	/* message contains no data payload */
 	CEPH_MSG_DATA_DATABUF,	/* data source/destination is a data buffer */
 	CEPH_MSG_DATA_PAGES,	/* data source/destination is a page array */
-	CEPH_MSG_DATA_PAGELIST,	/* data source/destination is a pagelist */
 	CEPH_MSG_DATA_ITER,	/* data source/destination is an iov_iter */
 };
 
@@ -135,7 +134,6 @@ struct ceph_msg_data {
 			unsigned int	offset;		/* first page */
 			bool		own_pages;
 		};
-		struct ceph_pagelist	*pagelist;
 	};
 };
 
@@ -152,10 +150,6 @@ struct ceph_msg_data_cursor {
 			unsigned short	page_index;	/* index in array */
 			unsigned short	page_count;	/* pages in array */
 		};
-		struct {				/* pagelist */
-			struct page	*page;		/* page from list */
-			size_t		offset;		/* bytes from list */
-		};
 		struct {
 			struct iov_iter		iov_iter;
 			unsigned int		lastlen;
@@ -510,8 +504,6 @@ extern bool ceph_con_keepalive_expired(struct ceph_connection *con,
 void ceph_msg_data_add_databuf(struct ceph_msg *msg, struct ceph_databuf *dbuf);
 void ceph_msg_data_add_pages(struct ceph_msg *msg, struct page **pages,
 			     size_t length, size_t offset, bool own_pages);
-extern void ceph_msg_data_add_pagelist(struct ceph_msg *msg,
-				struct ceph_pagelist *pagelist);
 void ceph_msg_data_add_iter(struct ceph_msg *msg,
 			    struct iov_iter *iter);
 
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 82c1c325861d..83c3073c44bb 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -15,7 +15,6 @@
 #include <linux/ceph/messenger.h>
 #include <linux/ceph/msgpool.h>
 #include <linux/ceph/auth.h>
-#include <linux/ceph/pagelist.h>
 #include <linux/ceph/databuf.h>
 
 struct ceph_msg;
@@ -105,7 +104,6 @@ enum ceph_osd_data_type {
 	CEPH_OSD_DATA_TYPE_NONE = 0,
 	CEPH_OSD_DATA_TYPE_DATABUF,
 	CEPH_OSD_DATA_TYPE_PAGES,
-	CEPH_OSD_DATA_TYPE_PAGELIST,
 	CEPH_OSD_DATA_TYPE_ITER,
 };
 
@@ -120,7 +118,6 @@ struct ceph_osd_data {
 			bool		pages_from_pool;
 			bool		own_pages;
 		};
-		struct ceph_pagelist	*pagelist;
 		struct iov_iter		iter;
 	};
 };
@@ -486,18 +483,12 @@ extern void osd_req_op_extent_osd_data_pages(struct ceph_osd_request *,
 void osd_req_op_raw_data_in_databuf(struct ceph_osd_request *osd_req,
 				    unsigned int which,
 				    struct ceph_databuf *databuf);
-extern void osd_req_op_extent_osd_data_pagelist(struct ceph_osd_request *,
-					unsigned int which,
-					struct ceph_pagelist *pagelist);
 void osd_req_op_extent_osd_iter(struct ceph_osd_request *osd_req,
 				unsigned int which, struct iov_iter *iter);
 
 void osd_req_op_cls_request_databuf(struct ceph_osd_request *req,
 				    unsigned int which,
 				    struct ceph_databuf *dbuf);
-extern void osd_req_op_cls_request_data_pagelist(struct ceph_osd_request *,
-					unsigned int which,
-					struct ceph_pagelist *pagelist);
 void osd_req_op_cls_response_databuf(struct ceph_osd_request *osd_req,
 				     unsigned int which,
 				     struct ceph_databuf *dbuf);
diff --git a/include/linux/ceph/pagelist.h b/include/linux/ceph/pagelist.h
deleted file mode 100644
index 5dead8486fd8..000000000000
--- a/include/linux/ceph/pagelist.h
+++ /dev/null
@@ -1,72 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __FS_CEPH_PAGELIST_H
-#define __FS_CEPH_PAGELIST_H
-
-#include <asm/byteorder.h>
-#include <linux/refcount.h>
-#include <linux/list.h>
-#include <linux/types.h>
-
-struct ceph_pagelist {
-	struct list_head head;
-	void *mapped_tail;
-	size_t length;
-	size_t room;
-	struct list_head free_list;
-	size_t num_pages_free;
-	refcount_t refcnt;
-};
-
-struct ceph_pagelist_cursor {
-	struct ceph_pagelist *pl;   /* pagelist, for error checking */
-	struct list_head *page_lru; /* page in list */
-	size_t room;		    /* room remaining to reset to */
-};
-
-struct ceph_pagelist *ceph_pagelist_alloc(gfp_t gfp_flags);
-
-extern void ceph_pagelist_release(struct ceph_pagelist *pl);
-
-extern int ceph_pagelist_append(struct ceph_pagelist *pl, const void *d, size_t l);
-
-extern int ceph_pagelist_reserve(struct ceph_pagelist *pl, size_t space);
-
-extern int ceph_pagelist_free_reserve(struct ceph_pagelist *pl);
-
-extern void ceph_pagelist_set_cursor(struct ceph_pagelist *pl,
-				     struct ceph_pagelist_cursor *c);
-
-extern int ceph_pagelist_truncate(struct ceph_pagelist *pl,
-				  struct ceph_pagelist_cursor *c);
-
-static inline int ceph_pagelist_encode_64(struct ceph_pagelist *pl, u64 v)
-{
-	__le64 ev = cpu_to_le64(v);
-	return ceph_pagelist_append(pl, &ev, sizeof(ev));
-}
-static inline int ceph_pagelist_encode_32(struct ceph_pagelist *pl, u32 v)
-{
-	__le32 ev = cpu_to_le32(v);
-	return ceph_pagelist_append(pl, &ev, sizeof(ev));
-}
-static inline int ceph_pagelist_encode_16(struct ceph_pagelist *pl, u16 v)
-{
-	__le16 ev = cpu_to_le16(v);
-	return ceph_pagelist_append(pl, &ev, sizeof(ev));
-}
-static inline int ceph_pagelist_encode_8(struct ceph_pagelist *pl, u8 v)
-{
-	return ceph_pagelist_append(pl, &v, 1);
-}
-static inline int ceph_pagelist_encode_string(struct ceph_pagelist *pl,
-					      char *s, u32 len)
-{
-	int ret = ceph_pagelist_encode_32(pl, len);
-	if (ret)
-		return ret;
-	if (len)
-		return ceph_pagelist_append(pl, s, len);
-	return 0;
-}
-
-#endif
diff --git a/net/ceph/Makefile b/net/ceph/Makefile
index 4b2e0b654e45..0c8787e2e733 100644
--- a/net/ceph/Makefile
+++ b/net/ceph/Makefile
@@ -4,7 +4,7 @@
 #
 obj-$(CONFIG_CEPH_LIB) += libceph.o
 
-libceph-y := ceph_common.o messenger.o msgpool.o buffer.o pagelist.o \
+libceph-y := ceph_common.o messenger.o msgpool.o buffer.o \
 	mon_client.o decode.o \
 	cls_lock_client.o \
 	osd_client.o osdmap.o crush/crush.o crush/mapper.o crush/hash.o \
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 1ef3576c930d..5b28c27858b2 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -20,7 +20,6 @@
 #include <linux/ceph/libceph.h>
 #include <linux/ceph/messenger.h>
 #include <linux/ceph/decode.h>
-#include <linux/ceph/pagelist.h>
 #include <linux/export.h>
 
 /*
@@ -775,87 +774,6 @@ static bool ceph_msg_data_pages_advance(struct ceph_msg_data_cursor *cursor,
 	return true;
 }
 
-/*
- * For a pagelist, a piece is whatever remains to be consumed in the
- * first page in the list, or the front of the next page.
- */
-static void
-ceph_msg_data_pagelist_cursor_init(struct ceph_msg_data_cursor *cursor,
-					size_t length)
-{
-	struct ceph_msg_data *data = cursor->data;
-	struct ceph_pagelist *pagelist;
-	struct page *page;
-
-	BUG_ON(data->type != CEPH_MSG_DATA_PAGELIST);
-
-	pagelist = data->pagelist;
-	BUG_ON(!pagelist);
-
-	if (!length)
-		return;		/* pagelist can be assigned but empty */
-
-	BUG_ON(list_empty(&pagelist->head));
-	page = list_first_entry(&pagelist->head, struct page, lru);
-
-	cursor->resid = min(length, pagelist->length);
-	cursor->page = page;
-	cursor->offset = 0;
-}
-
-static struct page *
-ceph_msg_data_pagelist_next(struct ceph_msg_data_cursor *cursor,
-				size_t *page_offset, size_t *length)
-{
-	struct ceph_msg_data *data = cursor->data;
-	struct ceph_pagelist *pagelist;
-
-	BUG_ON(data->type != CEPH_MSG_DATA_PAGELIST);
-
-	pagelist = data->pagelist;
-	BUG_ON(!pagelist);
-
-	BUG_ON(!cursor->page);
-	BUG_ON(cursor->offset + cursor->resid != pagelist->length);
-
-	/* offset of first page in pagelist is always 0 */
-	*page_offset = cursor->offset & ~PAGE_MASK;
-	*length = min_t(size_t, cursor->resid, PAGE_SIZE - *page_offset);
-	return cursor->page;
-}
-
-static bool ceph_msg_data_pagelist_advance(struct ceph_msg_data_cursor *cursor,
-						size_t bytes)
-{
-	struct ceph_msg_data *data = cursor->data;
-	struct ceph_pagelist *pagelist;
-
-	BUG_ON(data->type != CEPH_MSG_DATA_PAGELIST);
-
-	pagelist = data->pagelist;
-	BUG_ON(!pagelist);
-
-	BUG_ON(cursor->offset + cursor->resid != pagelist->length);
-	BUG_ON((cursor->offset & ~PAGE_MASK) + bytes > PAGE_SIZE);
-
-	/* Advance the cursor offset */
-
-	cursor->resid -= bytes;
-	cursor->offset += bytes;
-	/* offset of first page in pagelist is always 0 */
-	if (!bytes || cursor->offset & ~PAGE_MASK)
-		return false;	/* more bytes to process in the current page */
-
-	if (!cursor->resid)
-		return false;   /* no more data */
-
-	/* Move on to the next page */
-
-	BUG_ON(list_is_last(&cursor->page->lru, &pagelist->head));
-	cursor->page = list_next_entry(cursor->page, lru);
-	return true;
-}
-
 static void ceph_msg_data_iter_cursor_init(struct ceph_msg_data_cursor *cursor,
 					size_t length)
 {
@@ -926,9 +844,6 @@ static void __ceph_msg_data_cursor_init(struct ceph_msg_data_cursor *cursor)
 	size_t length = cursor->total_resid;
 
 	switch (cursor->data->type) {
-	case CEPH_MSG_DATA_PAGELIST:
-		ceph_msg_data_pagelist_cursor_init(cursor, length);
-		break;
 	case CEPH_MSG_DATA_PAGES:
 		ceph_msg_data_pages_cursor_init(cursor, length);
 		break;
@@ -968,9 +883,6 @@ struct page *ceph_msg_data_next(struct ceph_msg_data_cursor *cursor,
 	struct page *page;
 
 	switch (cursor->data->type) {
-	case CEPH_MSG_DATA_PAGELIST:
-		page = ceph_msg_data_pagelist_next(cursor, page_offset, length);
-		break;
 	case CEPH_MSG_DATA_PAGES:
 		page = ceph_msg_data_pages_next(cursor, page_offset, length);
 		break;
@@ -1001,9 +913,6 @@ void ceph_msg_data_advance(struct ceph_msg_data_cursor *cursor, size_t bytes)
 
 	BUG_ON(bytes > cursor->resid);
 	switch (cursor->data->type) {
-	case CEPH_MSG_DATA_PAGELIST:
-		new_piece = ceph_msg_data_pagelist_advance(cursor, bytes);
-		break;
 	case CEPH_MSG_DATA_PAGES:
 		new_piece = ceph_msg_data_pages_advance(cursor, bytes);
 		break;
@@ -1740,8 +1649,6 @@ static void ceph_msg_data_destroy(struct ceph_msg_data *data)
 	} else if (data->type == CEPH_MSG_DATA_PAGES && data->own_pages) {
 		int num_pages = calc_pages_for(data->offset, data->length);
 		ceph_release_page_vector(data->pages, num_pages);
-	} else if (data->type == CEPH_MSG_DATA_PAGELIST) {
-		ceph_pagelist_release(data->pagelist);
 	}
 }
 
@@ -1782,23 +1689,6 @@ void ceph_msg_data_add_pages(struct ceph_msg *msg, struct page **pages,
 }
 EXPORT_SYMBOL(ceph_msg_data_add_pages);
 
-void ceph_msg_data_add_pagelist(struct ceph_msg *msg,
-				struct ceph_pagelist *pagelist)
-{
-	struct ceph_msg_data *data;
-
-	BUG_ON(!pagelist);
-	BUG_ON(!pagelist->length);
-
-	data = ceph_msg_data_add(msg);
-	data->type = CEPH_MSG_DATA_PAGELIST;
-	refcount_inc(&pagelist->refcnt);
-	data->pagelist = pagelist;
-
-	msg->data_length += pagelist->length;
-}
-EXPORT_SYMBOL(ceph_msg_data_add_pagelist);
-
 void ceph_msg_data_add_iter(struct ceph_msg *msg,
 			    struct iov_iter *iter)
 {
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index c4486799f54b..8cbe06d2e16d 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -16,7 +16,6 @@
 #include <linux/ceph/messenger.h>
 #include <linux/ceph/decode.h>
 #include <linux/ceph/auth.h>
-#include <linux/ceph/pagelist.h>
 #include <linux/ceph/striper.h>
 
 #define OSD_OPREPLY_FRONT_LEN	512
@@ -138,16 +137,6 @@ static void ceph_osd_data_pages_init(struct ceph_osd_data *osd_data,
 	osd_data->own_pages = own_pages;
 }
 
-/*
- * Consumes a ref on @pagelist.
- */
-static void ceph_osd_data_pagelist_init(struct ceph_osd_data *osd_data,
-			struct ceph_pagelist *pagelist)
-{
-	osd_data->type = CEPH_OSD_DATA_TYPE_PAGELIST;
-	osd_data->pagelist = pagelist;
-}
-
 static void ceph_osd_iter_init(struct ceph_osd_data *osd_data,
 			       struct iov_iter *iter)
 {
@@ -229,16 +218,6 @@ void osd_req_op_extent_osd_data_pages(struct ceph_osd_request *osd_req,
 }
 EXPORT_SYMBOL(osd_req_op_extent_osd_data_pages);
 
-void osd_req_op_extent_osd_data_pagelist(struct ceph_osd_request *osd_req,
-			unsigned int which, struct ceph_pagelist *pagelist)
-{
-	struct ceph_osd_data *osd_data;
-
-	osd_data = osd_req_op_data(osd_req, which, extent, osd_data);
-	ceph_osd_data_pagelist_init(osd_data, pagelist);
-}
-EXPORT_SYMBOL(osd_req_op_extent_osd_data_pagelist);
-
 /**
  * osd_req_op_extent_osd_iter - Set up an operation with an iterator buffer
  * @osd_req: The request to set up
@@ -265,16 +244,6 @@ static void osd_req_op_cls_request_info_databuf(struct ceph_osd_request *osd_req
 	ceph_osd_databuf_init(osd_data, dbuf);
 }
 
-static void osd_req_op_cls_request_info_pagelist(
-			struct ceph_osd_request *osd_req,
-			unsigned int which, struct ceph_pagelist *pagelist)
-{
-	struct ceph_osd_data *osd_data;
-
-	osd_data = osd_req_op_data(osd_req, which, cls, request_info);
-	ceph_osd_data_pagelist_init(osd_data, pagelist);
-}
-
 void osd_req_op_cls_request_databuf(struct ceph_osd_request *osd_req,
 				    unsigned int which,
 				    struct ceph_databuf *dbuf)
@@ -288,19 +257,6 @@ void osd_req_op_cls_request_databuf(struct ceph_osd_request *osd_req,
 }
 EXPORT_SYMBOL(osd_req_op_cls_request_databuf);
 
-void osd_req_op_cls_request_data_pagelist(
-			struct ceph_osd_request *osd_req,
-			unsigned int which, struct ceph_pagelist *pagelist)
-{
-	struct ceph_osd_data *osd_data;
-
-	osd_data = osd_req_op_data(osd_req, which, cls, request_data);
-	ceph_osd_data_pagelist_init(osd_data, pagelist);
-	osd_req->r_ops[which].cls.indata_len += pagelist->length;
-	osd_req->r_ops[which].indata_len += pagelist->length;
-}
-EXPORT_SYMBOL(osd_req_op_cls_request_data_pagelist);
-
 static void osd_req_op_cls_request_data_iter(
 			struct ceph_osd_request *osd_req,
 			unsigned int which, struct iov_iter *iter)
@@ -331,8 +287,6 @@ static u64 ceph_osd_data_length(struct ceph_osd_data *osd_data)
 		return 0;
 	case CEPH_OSD_DATA_TYPE_PAGES:
 		return osd_data->length;
-	case CEPH_OSD_DATA_TYPE_PAGELIST:
-		return (u64)osd_data->pagelist->length;
 	case CEPH_OSD_DATA_TYPE_ITER:
 		return iov_iter_count(&osd_data->iter);
 	default:
@@ -349,8 +303,6 @@ static void ceph_osd_data_release(struct ceph_osd_data *osd_data)
 		num_pages = calc_pages_for((u64)osd_data->offset,
 						(u64)osd_data->length);
 		ceph_release_page_vector(osd_data->pages, num_pages);
-	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGELIST) {
-		ceph_pagelist_release(osd_data->pagelist);
 	}
 	ceph_osd_data_init(osd_data);
 }
@@ -934,9 +886,6 @@ static void ceph_osdc_msg_data_add(struct ceph_msg *msg,
 		if (length)
 			ceph_msg_data_add_pages(msg, osd_data->pages,
 					length, osd_data->offset, false);
-	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGELIST) {
-		BUG_ON(!length);
-		ceph_msg_data_add_pagelist(msg, osd_data->pagelist);
 	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_ITER) {
 		ceph_msg_data_add_iter(msg, &osd_data->iter);
 	} else {
diff --git a/net/ceph/pagelist.c b/net/ceph/pagelist.c
deleted file mode 100644
index 74622b278d57..000000000000
--- a/net/ceph/pagelist.c
+++ /dev/null
@@ -1,171 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/module.h>
-#include <linux/gfp.h>
-#include <linux/slab.h>
-#include <linux/pagemap.h>
-#include <linux/highmem.h>
-#include <linux/ceph/pagelist.h>
-
-struct ceph_pagelist *ceph_pagelist_alloc(gfp_t gfp_flags)
-{
-	struct ceph_pagelist *pl;
-
-	pl = kmalloc(sizeof(*pl), gfp_flags);
-	if (!pl)
-		return NULL;
-
-	INIT_LIST_HEAD(&pl->head);
-	pl->mapped_tail = NULL;
-	pl->length = 0;
-	pl->room = 0;
-	INIT_LIST_HEAD(&pl->free_list);
-	pl->num_pages_free = 0;
-	refcount_set(&pl->refcnt, 1);
-
-	return pl;
-}
-EXPORT_SYMBOL(ceph_pagelist_alloc);
-
-static void ceph_pagelist_unmap_tail(struct ceph_pagelist *pl)
-{
-	if (pl->mapped_tail) {
-		struct page *page = list_entry(pl->head.prev, struct page, lru);
-		kunmap(page);
-		pl->mapped_tail = NULL;
-	}
-}
-
-void ceph_pagelist_release(struct ceph_pagelist *pl)
-{
-	if (!refcount_dec_and_test(&pl->refcnt))
-		return;
-	ceph_pagelist_unmap_tail(pl);
-	while (!list_empty(&pl->head)) {
-		struct page *page = list_first_entry(&pl->head, struct page,
-						     lru);
-		list_del(&page->lru);
-		__free_page(page);
-	}
-	ceph_pagelist_free_reserve(pl);
-	kfree(pl);
-}
-EXPORT_SYMBOL(ceph_pagelist_release);
-
-static int ceph_pagelist_addpage(struct ceph_pagelist *pl)
-{
-	struct page *page;
-
-	if (!pl->num_pages_free) {
-		page = __page_cache_alloc(GFP_NOFS);
-	} else {
-		page = list_first_entry(&pl->free_list, struct page, lru);
-		list_del(&page->lru);
-		--pl->num_pages_free;
-	}
-	if (!page)
-		return -ENOMEM;
-	pl->room += PAGE_SIZE;
-	ceph_pagelist_unmap_tail(pl);
-	list_add_tail(&page->lru, &pl->head);
-	pl->mapped_tail = kmap(page);
-	return 0;
-}
-
-int ceph_pagelist_append(struct ceph_pagelist *pl, const void *buf, size_t len)
-{
-	while (pl->room < len) {
-		size_t bit = pl->room;
-		int ret;
-
-		memcpy(pl->mapped_tail + (pl->length & ~PAGE_MASK),
-		       buf, bit);
-		pl->length += bit;
-		pl->room -= bit;
-		buf += bit;
-		len -= bit;
-		ret = ceph_pagelist_addpage(pl);
-		if (ret)
-			return ret;
-	}
-
-	memcpy(pl->mapped_tail + (pl->length & ~PAGE_MASK), buf, len);
-	pl->length += len;
-	pl->room -= len;
-	return 0;
-}
-EXPORT_SYMBOL(ceph_pagelist_append);
-
-/* Allocate enough pages for a pagelist to append the given amount
- * of data without allocating.
- * Returns: 0 on success, -ENOMEM on error.
- */
-int ceph_pagelist_reserve(struct ceph_pagelist *pl, size_t space)
-{
-	if (space <= pl->room)
-		return 0;
-	space -= pl->room;
-	space = (space + PAGE_SIZE - 1) >> PAGE_SHIFT;   /* conv to num pages */
-
-	while (space > pl->num_pages_free) {
-		struct page *page = __page_cache_alloc(GFP_NOFS);
-		if (!page)
-			return -ENOMEM;
-		list_add_tail(&page->lru, &pl->free_list);
-		++pl->num_pages_free;
-	}
-	return 0;
-}
-EXPORT_SYMBOL(ceph_pagelist_reserve);
-
-/* Free any pages that have been preallocated. */
-int ceph_pagelist_free_reserve(struct ceph_pagelist *pl)
-{
-	while (!list_empty(&pl->free_list)) {
-		struct page *page = list_first_entry(&pl->free_list,
-						     struct page, lru);
-		list_del(&page->lru);
-		__free_page(page);
-		--pl->num_pages_free;
-	}
-	BUG_ON(pl->num_pages_free);
-	return 0;
-}
-EXPORT_SYMBOL(ceph_pagelist_free_reserve);
-
-/* Create a truncation point. */
-void ceph_pagelist_set_cursor(struct ceph_pagelist *pl,
-			      struct ceph_pagelist_cursor *c)
-{
-	c->pl = pl;
-	c->page_lru = pl->head.prev;
-	c->room = pl->room;
-}
-EXPORT_SYMBOL(ceph_pagelist_set_cursor);
-
-/* Truncate a pagelist to the given point. Move extra pages to reserve.
- * This won't sleep.
- * Returns: 0 on success,
- *          -EINVAL if the pagelist doesn't match the trunc point pagelist
- */
-int ceph_pagelist_truncate(struct ceph_pagelist *pl,
-			   struct ceph_pagelist_cursor *c)
-{
-	struct page *page;
-
-	if (pl != c->pl)
-		return -EINVAL;
-	ceph_pagelist_unmap_tail(pl);
-	while (pl->head.prev != c->page_lru) {
-		page = list_entry(pl->head.prev, struct page, lru);
-		/* move from pagelist to reserve */
-		list_move_tail(&page->lru, &pl->free_list);
-		++pl->num_pages_free;
-	}
-	pl->room = c->room;
-	if (!list_empty(&pl->head)) {
-		page = list_entry(pl->head.prev, struct page, lru);
-		pl->mapped_tail = kmap(page);
-	}
-	return 0;
-}
-EXPORT_SYMBOL(ceph_pagelist_truncate);

