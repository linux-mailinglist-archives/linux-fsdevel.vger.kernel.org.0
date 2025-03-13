Return-Path: <linux-fsdevel+bounces-43969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 455F0A605B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 00:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6EE73BE65F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 23:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075C52045B7;
	Thu, 13 Mar 2025 23:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ewdZqyGA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C00020371D
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 23:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908913; cv=none; b=hV2qSVPYGPx2MLmulHDRWfanZFH9nD/vLYOZm6enlQ2ysFqs4Oc/AVZTpmQMUU6zI7J9P0qyDyzc2etnf7xN4F+yvWLikzmFumlTIYGPnvg/zebnU2sPQPP0B4+zQmcj+w7yANU0fjiHJ4A4aFB/Y/PW7sg8pVHk8nJvlseT77Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908913; c=relaxed/simple;
	bh=ArM9OWUTAn0K5vjn5Rgh2LuHSghdGpcmrBT0XVNRNfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbgIcZNTLEQb3JVKj3yFyhVoPcJOKx9mp4D/es6aJGh7ugX7wb39QjSbZ5nnEQeuMa1YBQj81YAOr2lsPoD+OB6gxC/4iTB48SRB6MWZ5vObl9gHfjGVm5b3sT7oOeIg7DtaJelSr0/kvyhkfre2iwigYD4Spz/sjQrv8KFeP10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ewdZqyGA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8oqM+bSpor+ZPn2TUfgGU/pxeVwnQi1plAkYuexpVBE=;
	b=ewdZqyGANZE2LH3jzQb7ePfJpFoAOUTHRplsaE71c11kjxlS+bsuwfk0f2RfCDr7KlG0XT
	UMO6BUCQPp1gb04KxBFyC6Nh1iT+DH55wQ3cO8jDTl510fLgovdtOu8freaZzUIDcuPDfj
	65XLd7/QezOeSlU4eFtG29xQFRaaZtI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-oCgbq2qOPNetbFWjbd3yOw-1; Thu,
 13 Mar 2025 19:35:06 -0400
X-MC-Unique: oCgbq2qOPNetbFWjbd3yOw-1
X-Mimecast-MFC-AGG-ID: oCgbq2qOPNetbFWjbd3yOw_1741908904
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B0DB0195608F;
	Thu, 13 Mar 2025 23:35:04 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5A4E018001F6;
	Thu, 13 Mar 2025 23:35:02 +0000 (UTC)
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
Subject: [RFC PATCH 20/35] libceph: Remove ceph_pagelist
Date: Thu, 13 Mar 2025 23:33:12 +0000
Message-ID: <20250313233341.1675324-21-dhowells@redhat.com>
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

Remove ceph_pagelist and its helpers.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/ceph/locks.c                 |   1 -
 fs/ceph/mds_client.c            |   1 -
 fs/ceph/xattr.c                 |   1 -
 include/linux/ceph/messenger.h  |   8 --
 include/linux/ceph/osd_client.h |   9 ---
 include/linux/ceph/pagelist.h   |  60 --------------
 net/ceph/Makefile               |   2 +-
 net/ceph/messenger.c            | 110 --------------------------
 net/ceph/osd_client.c           |  41 ----------
 net/ceph/pagelist.c             | 133 --------------------------------
 10 files changed, 1 insertion(+), 365 deletions(-)
 delete mode 100644 include/linux/ceph/pagelist.h
 delete mode 100644 net/ceph/pagelist.c

diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index 32c7b0f0d61f..451b92d99cf1 100644
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
index f1c6d0ebf548..26fa39d07ef0 100644
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
index b083cd3b3974..de7b1c364bec 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/ceph/ceph_debug.h>
-#include <linux/ceph/pagelist.h>
 
 #include "super.h"
 #include "mds_client.h"
diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index ff0aea6d2d31..36896a71291c 100644
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
 			struct iov_iter		crc_iter;
@@ -511,8 +505,6 @@ extern bool ceph_con_keepalive_expired(struct ceph_connection *con,
 void ceph_msg_data_add_databuf(struct ceph_msg *msg, struct ceph_databuf *dbuf);
 void ceph_msg_data_add_pages(struct ceph_msg *msg, struct page **pages,
 			     size_t length, size_t offset, bool own_pages);
-extern void ceph_msg_data_add_pagelist(struct ceph_msg *msg,
-				struct ceph_pagelist *pagelist);
 void ceph_msg_data_add_iter(struct ceph_msg *msg,
 			    struct iov_iter *iter);
 
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index ce04205b8143..5a1ee66ca216 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -15,7 +15,6 @@
 #include <linux/ceph/messenger.h>
 #include <linux/ceph/msgpool.h>
 #include <linux/ceph/auth.h>
-#include <linux/ceph/pagelist.h>
 #include <linux/ceph/databuf.h>
 
 struct ceph_msg;
@@ -106,7 +105,6 @@ enum ceph_osd_data_type {
 	CEPH_OSD_DATA_TYPE_NONE = 0,
 	CEPH_OSD_DATA_TYPE_DATABUF,
 	CEPH_OSD_DATA_TYPE_PAGES,
-	CEPH_OSD_DATA_TYPE_PAGELIST,
 	CEPH_OSD_DATA_TYPE_ITER,
 };
 
@@ -122,7 +120,6 @@ struct ceph_osd_data {
 			bool		pages_from_pool;
 			bool		own_pages;
 		};
-		struct ceph_pagelist	*pagelist;
 	};
 };
 
@@ -485,18 +482,12 @@ extern void osd_req_op_extent_osd_data_pages(struct ceph_osd_request *,
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
index 879bec0863aa..000000000000
--- a/include/linux/ceph/pagelist.h
+++ /dev/null
@@ -1,60 +0,0 @@
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
index cb66a768bd7c..4b20df1ab8e4 100644
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
@@ -969,9 +884,6 @@ struct page *ceph_msg_data_next(struct ceph_msg_data_cursor *cursor,
 	struct page *page;
 
 	switch (cursor->data->type) {
-	case CEPH_MSG_DATA_PAGELIST:
-		page = ceph_msg_data_pagelist_next(cursor, page_offset, length);
-		break;
 	case CEPH_MSG_DATA_PAGES:
 		page = ceph_msg_data_pages_next(cursor, page_offset, length);
 		break;
@@ -1003,9 +915,6 @@ void ceph_msg_data_advance(struct ceph_msg_data_cursor *cursor, size_t bytes)
 
 	BUG_ON(bytes > cursor->resid);
 	switch (cursor->data->type) {
-	case CEPH_MSG_DATA_PAGELIST:
-		new_piece = ceph_msg_data_pagelist_advance(cursor, bytes);
-		break;
 	case CEPH_MSG_DATA_PAGES:
 		new_piece = ceph_msg_data_pages_advance(cursor, bytes);
 		break;
@@ -1744,8 +1653,6 @@ static void ceph_msg_data_destroy(struct ceph_msg_data *data)
 	} else if (data->type == CEPH_MSG_DATA_PAGES && data->own_pages) {
 		int num_pages = calc_pages_for(data->offset, data->length);
 		ceph_release_page_vector(data->pages, num_pages);
-	} else if (data->type == CEPH_MSG_DATA_PAGELIST) {
-		ceph_pagelist_release(data->pagelist);
 	}
 }
 
@@ -1784,23 +1691,6 @@ void ceph_msg_data_add_pages(struct ceph_msg *msg, struct page **pages,
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
index a967309d01a7..0ac439e7e730 100644
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
@@ -230,16 +219,6 @@ void osd_req_op_extent_osd_data_pages(struct ceph_osd_request *osd_req,
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
@@ -281,19 +260,6 @@ void osd_req_op_cls_request_databuf(struct ceph_osd_request *osd_req,
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
 void osd_req_op_cls_response_databuf(struct ceph_osd_request *osd_req,
 				     unsigned int which,
 				     struct ceph_databuf *dbuf)
@@ -316,8 +282,6 @@ static u64 ceph_osd_data_length(struct ceph_osd_data *osd_data)
 		return ceph_databuf_len(osd_data->dbuf);
 	case CEPH_OSD_DATA_TYPE_PAGES:
 		return osd_data->length;
-	case CEPH_OSD_DATA_TYPE_PAGELIST:
-		return (u64)osd_data->pagelist->length;
 	case CEPH_OSD_DATA_TYPE_ITER:
 		return iov_iter_count(&osd_data->iter);
 	default:
@@ -336,8 +300,6 @@ static void ceph_osd_data_release(struct ceph_osd_data *osd_data)
 		num_pages = calc_pages_for((u64)osd_data->offset,
 						(u64)osd_data->length);
 		ceph_release_page_vector(osd_data->pages, num_pages);
-	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGELIST) {
-		ceph_pagelist_release(osd_data->pagelist);
 	}
 	ceph_osd_data_init(osd_data);
 }
@@ -913,9 +875,6 @@ static void ceph_osdc_msg_data_add(struct ceph_msg *msg,
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
index 5a9c4be5f222..000000000000
--- a/net/ceph/pagelist.c
+++ /dev/null
@@ -1,133 +0,0 @@
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


