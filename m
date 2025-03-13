Return-Path: <linux-fsdevel+bounces-43963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B837A605A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 00:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C5388186E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 23:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA78201012;
	Thu, 13 Mar 2025 23:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJQ1N5Tz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E22200BA9
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 23:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908890; cv=none; b=pRO55CSJUfn4kq5li8E7e1ZVQOFYVfoWhkyDPUuLsqf4vyz7EOjvwQAey0sll5tPWy7OdACMEnuxZI+LkP24HQXszy9PlF3dFywtcw6xF444HwLVLCNBzYapOd4iWPotgOA1l0quT3wNDlJjtdqAsC0eq45blolPrM9AR3W2UzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908890; c=relaxed/simple;
	bh=N3h3xQj7ocvZehZTOpZFvI4y4JkEaB8IInpqcT0rRDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDLggr3W+5KjLh2iMeaiUb8Wh4Bz1tQsFP10ujMoamyPsicd91WsPcJ33bCjPGM8A+3Gzy6430TfljzVjk7CzrAIYCChSNpmlgBLD4bKr/14w8ata7oJejUSWS0ZoglukdDGj37NGpQseaaNACNM2Qxr+bogAuMsUaTsCqDIl+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dJQ1N5Tz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ds+3B/FO8qMYcXcHGziHXc1CnXTOaJvq1Frqia6w9zc=;
	b=dJQ1N5TzMTdWF36WROP2Q4JzMdmxHOlaN8mp1Z3LADo/MqfqT34xHAAh9VSsK85Q8bonNg
	WW1A9Yc79Xqm5pTU4dFLI9KYM/8VMRJqZhiVcinO0ZN8KZ/YGn/I4f2rBbDh5d5i2Univl
	RdhuHRODxgp4gzVbOVohTmahZLddA4I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-7iwvEo4jNHmvV4fm4k8D-A-1; Thu,
 13 Mar 2025 19:34:44 -0400
X-MC-Unique: 7iwvEo4jNHmvV4fm4k8D-A-1
X-Mimecast-MFC-AGG-ID: 7iwvEo4jNHmvV4fm4k8D-A_1741908883
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B8C4195608B;
	Thu, 13 Mar 2025 23:34:43 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B8E4B300376F;
	Thu, 13 Mar 2025 23:34:40 +0000 (UTC)
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
Subject: [RFC PATCH 14/35] libceph: Remove bvec and bio data container types
Date: Thu, 13 Mar 2025 23:33:06 +0000
Message-ID: <20250313233341.1675324-15-dhowells@redhat.com>
In-Reply-To: <20250313233341.1675324-1-dhowells@redhat.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The CEPH_MSG_DATA_BIO and CEPH_MSG_DATA_BVEC data types are now not used,
so remove them.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 include/linux/ceph/messenger.h  | 103 --------------------
 include/linux/ceph/osd_client.h |  31 ------
 net/ceph/messenger.c            | 166 --------------------------------
 net/ceph/osd_client.c           |  94 ------------------
 4 files changed, 394 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 1b646d0dff39..ff0aea6d2d31 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -120,108 +120,15 @@ enum ceph_msg_data_type {
 	CEPH_MSG_DATA_DATABUF,	/* data source/destination is a data buffer */
 	CEPH_MSG_DATA_PAGES,	/* data source/destination is a page array */
 	CEPH_MSG_DATA_PAGELIST,	/* data source/destination is a pagelist */
-#ifdef CONFIG_BLOCK
-	CEPH_MSG_DATA_BIO,	/* data source/destination is a bio list */
-#endif /* CONFIG_BLOCK */
-	CEPH_MSG_DATA_BVECS,	/* data source/destination is a bio_vec array */
 	CEPH_MSG_DATA_ITER,	/* data source/destination is an iov_iter */
 };
 
-#ifdef CONFIG_BLOCK
-
-struct ceph_bio_iter {
-	struct bio *bio;
-	struct bvec_iter iter;
-};
-
-#define __ceph_bio_iter_advance_step(it, n, STEP) do {			      \
-	unsigned int __n = (n), __cur_n;				      \
-									      \
-	while (__n) {							      \
-		BUG_ON(!(it)->iter.bi_size);				      \
-		__cur_n = min((it)->iter.bi_size, __n);			      \
-		(void)(STEP);						      \
-		bio_advance_iter((it)->bio, &(it)->iter, __cur_n);	      \
-		if (!(it)->iter.bi_size && (it)->bio->bi_next) {	      \
-			dout("__ceph_bio_iter_advance_step next bio\n");      \
-			(it)->bio = (it)->bio->bi_next;			      \
-			(it)->iter = (it)->bio->bi_iter;		      \
-		}							      \
-		__n -= __cur_n;						      \
-	}								      \
-} while (0)
-
-/*
- * Advance @it by @n bytes.
- */
-#define ceph_bio_iter_advance(it, n)					      \
-	__ceph_bio_iter_advance_step(it, n, 0)
-
-/*
- * Advance @it by @n bytes, executing BVEC_STEP for each bio_vec.
- */
-#define ceph_bio_iter_advance_step(it, n, BVEC_STEP)			      \
-	__ceph_bio_iter_advance_step(it, n, ({				      \
-		struct bio_vec bv;					      \
-		struct bvec_iter __cur_iter;				      \
-									      \
-		__cur_iter = (it)->iter;				      \
-		__cur_iter.bi_size = __cur_n;				      \
-		__bio_for_each_segment(bv, (it)->bio, __cur_iter, __cur_iter) \
-			(void)(BVEC_STEP);				      \
-	}))
-
-#endif /* CONFIG_BLOCK */
-
-struct ceph_bvec_iter {
-	struct bio_vec *bvecs;
-	struct bvec_iter iter;
-};
-
-#define __ceph_bvec_iter_advance_step(it, n, STEP) do {			      \
-	BUG_ON((n) > (it)->iter.bi_size);				      \
-	(void)(STEP);							      \
-	bvec_iter_advance((it)->bvecs, &(it)->iter, (n));		      \
-} while (0)
-
-/*
- * Advance @it by @n bytes.
- */
-#define ceph_bvec_iter_advance(it, n)					      \
-	__ceph_bvec_iter_advance_step(it, n, 0)
-
-/*
- * Advance @it by @n bytes, executing BVEC_STEP for each bio_vec.
- */
-#define ceph_bvec_iter_advance_step(it, n, BVEC_STEP)			      \
-	__ceph_bvec_iter_advance_step(it, n, ({				      \
-		struct bio_vec bv;					      \
-		struct bvec_iter __cur_iter;				      \
-									      \
-		__cur_iter = (it)->iter;				      \
-		__cur_iter.bi_size = (n);				      \
-		for_each_bvec(bv, (it)->bvecs, __cur_iter, __cur_iter)	      \
-			(void)(BVEC_STEP);				      \
-	}))
-
-#define ceph_bvec_iter_shorten(it, n) do {				      \
-	BUG_ON((n) > (it)->iter.bi_size);				      \
-	(it)->iter.bi_size = (n);					      \
-} while (0)
-
 struct ceph_msg_data {
 	enum ceph_msg_data_type		type;
 	struct iov_iter			iter;
 	bool				release_dbuf;
 	union {
 		struct ceph_databuf	*dbuf;
-#ifdef CONFIG_BLOCK
-		struct {
-			struct ceph_bio_iter	bio_pos;
-			u32			bio_length;
-		};
-#endif /* CONFIG_BLOCK */
-		struct ceph_bvec_iter	bvec_pos;
 		struct {
 			struct page	**pages;
 			size_t		length;		/* total # bytes */
@@ -240,10 +147,6 @@ struct ceph_msg_data_cursor {
 	int			sr_resid;	/* residual sparse_read len */
 	bool			need_crc;	/* crc update needed */
 	union {
-#ifdef CONFIG_BLOCK
-		struct ceph_bio_iter	bio_iter;
-#endif /* CONFIG_BLOCK */
-		struct bvec_iter	bvec_iter;
 		struct {				/* pages */
 			unsigned int	page_offset;	/* offset in page */
 			unsigned short	page_index;	/* index in array */
@@ -610,12 +513,6 @@ void ceph_msg_data_add_pages(struct ceph_msg *msg, struct page **pages,
 			     size_t length, size_t offset, bool own_pages);
 extern void ceph_msg_data_add_pagelist(struct ceph_msg *msg,
 				struct ceph_pagelist *pagelist);
-#ifdef CONFIG_BLOCK
-void ceph_msg_data_add_bio(struct ceph_msg *msg, struct ceph_bio_iter *bio_pos,
-			   u32 length);
-#endif /* CONFIG_BLOCK */
-void ceph_msg_data_add_bvecs(struct ceph_msg *msg,
-			     struct ceph_bvec_iter *bvec_pos);
 void ceph_msg_data_add_iter(struct ceph_msg *msg,
 			    struct iov_iter *iter);
 
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 5ac4c0b4dfcd..9182aa5075b2 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -107,10 +107,6 @@ enum ceph_osd_data_type {
 	CEPH_OSD_DATA_TYPE_DATABUF,
 	CEPH_OSD_DATA_TYPE_PAGES,
 	CEPH_OSD_DATA_TYPE_PAGELIST,
-#ifdef CONFIG_BLOCK
-	CEPH_OSD_DATA_TYPE_BIO,
-#endif /* CONFIG_BLOCK */
-	CEPH_OSD_DATA_TYPE_BVECS,
 	CEPH_OSD_DATA_TYPE_ITER,
 };
 
@@ -127,16 +123,6 @@ struct ceph_osd_data {
 			bool		own_pages;
 		};
 		struct ceph_pagelist	*pagelist;
-#ifdef CONFIG_BLOCK
-		struct {
-			struct ceph_bio_iter	bio_pos;
-			u32			bio_length;
-		};
-#endif /* CONFIG_BLOCK */
-		struct {
-			struct ceph_bvec_iter	bvec_pos;
-			u32			num_bvecs;
-		};
 	};
 };
 
@@ -499,19 +485,6 @@ extern void osd_req_op_extent_osd_data_pages(struct ceph_osd_request *,
 extern void osd_req_op_extent_osd_data_pagelist(struct ceph_osd_request *,
 					unsigned int which,
 					struct ceph_pagelist *pagelist);
-#ifdef CONFIG_BLOCK
-void osd_req_op_extent_osd_data_bio(struct ceph_osd_request *osd_req,
-				    unsigned int which,
-				    struct ceph_bio_iter *bio_pos,
-				    u32 bio_length);
-#endif /* CONFIG_BLOCK */
-void osd_req_op_extent_osd_data_bvecs(struct ceph_osd_request *osd_req,
-				      unsigned int which,
-				      struct bio_vec *bvecs, u32 num_bvecs,
-				      u32 bytes);
-void osd_req_op_extent_osd_data_bvec_pos(struct ceph_osd_request *osd_req,
-					 unsigned int which,
-					 struct ceph_bvec_iter *bvec_pos);
 void osd_req_op_extent_osd_iter(struct ceph_osd_request *osd_req,
 				unsigned int which, struct iov_iter *iter);
 
@@ -521,10 +494,6 @@ void osd_req_op_cls_request_databuf(struct ceph_osd_request *req,
 extern void osd_req_op_cls_request_data_pagelist(struct ceph_osd_request *,
 					unsigned int which,
 					struct ceph_pagelist *pagelist);
-void osd_req_op_cls_request_data_bvecs(struct ceph_osd_request *osd_req,
-				       unsigned int which,
-				       struct bio_vec *bvecs, u32 num_bvecs,
-				       u32 bytes);
 void osd_req_op_cls_response_databuf(struct ceph_osd_request *osd_req,
 				     unsigned int which,
 				     struct ceph_databuf *dbuf);
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index dc8082575e4f..cb66a768bd7c 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -12,9 +12,6 @@
 #include <linux/slab.h>
 #include <linux/socket.h>
 #include <linux/string.h>
-#ifdef	CONFIG_BLOCK
-#include <linux/bio.h>
-#endif	/* CONFIG_BLOCK */
 #include <linux/dns_resolver.h>
 #include <net/tcp.h>
 #include <trace/events/sock.h>
@@ -714,116 +711,6 @@ void ceph_con_discard_requeued(struct ceph_connection *con, u64 reconnect_seq)
 	}
 }
 
-#ifdef CONFIG_BLOCK
-
-/*
- * For a bio data item, a piece is whatever remains of the next
- * entry in the current bio iovec, or the first entry in the next
- * bio in the list.
- */
-static void ceph_msg_data_bio_cursor_init(struct ceph_msg_data_cursor *cursor,
-					size_t length)
-{
-	struct ceph_msg_data *data = cursor->data;
-	struct ceph_bio_iter *it = &cursor->bio_iter;
-
-	cursor->resid = min_t(size_t, length, data->bio_length);
-	*it = data->bio_pos;
-	if (cursor->resid < it->iter.bi_size)
-		it->iter.bi_size = cursor->resid;
-
-	BUG_ON(cursor->resid < bio_iter_len(it->bio, it->iter));
-}
-
-static struct page *ceph_msg_data_bio_next(struct ceph_msg_data_cursor *cursor,
-						size_t *page_offset,
-						size_t *length)
-{
-	struct bio_vec bv = bio_iter_iovec(cursor->bio_iter.bio,
-					   cursor->bio_iter.iter);
-
-	*page_offset = bv.bv_offset;
-	*length = bv.bv_len;
-	return bv.bv_page;
-}
-
-static bool ceph_msg_data_bio_advance(struct ceph_msg_data_cursor *cursor,
-					size_t bytes)
-{
-	struct ceph_bio_iter *it = &cursor->bio_iter;
-	struct page *page = bio_iter_page(it->bio, it->iter);
-
-	BUG_ON(bytes > cursor->resid);
-	BUG_ON(bytes > bio_iter_len(it->bio, it->iter));
-	cursor->resid -= bytes;
-	bio_advance_iter(it->bio, &it->iter, bytes);
-
-	if (!cursor->resid)
-		return false;   /* no more data */
-
-	if (!bytes || (it->iter.bi_size && it->iter.bi_bvec_done &&
-		       page == bio_iter_page(it->bio, it->iter)))
-		return false;	/* more bytes to process in this segment */
-
-	if (!it->iter.bi_size) {
-		it->bio = it->bio->bi_next;
-		it->iter = it->bio->bi_iter;
-		if (cursor->resid < it->iter.bi_size)
-			it->iter.bi_size = cursor->resid;
-	}
-
-	BUG_ON(cursor->resid < bio_iter_len(it->bio, it->iter));
-	return true;
-}
-#endif /* CONFIG_BLOCK */
-
-static void ceph_msg_data_bvecs_cursor_init(struct ceph_msg_data_cursor *cursor,
-					size_t length)
-{
-	struct ceph_msg_data *data = cursor->data;
-	struct bio_vec *bvecs = data->bvec_pos.bvecs;
-
-	cursor->resid = min_t(size_t, length, data->bvec_pos.iter.bi_size);
-	cursor->bvec_iter = data->bvec_pos.iter;
-	cursor->bvec_iter.bi_size = cursor->resid;
-
-	BUG_ON(cursor->resid < bvec_iter_len(bvecs, cursor->bvec_iter));
-}
-
-static struct page *ceph_msg_data_bvecs_next(struct ceph_msg_data_cursor *cursor,
-						size_t *page_offset,
-						size_t *length)
-{
-	struct bio_vec bv = bvec_iter_bvec(cursor->data->bvec_pos.bvecs,
-					   cursor->bvec_iter);
-
-	*page_offset = bv.bv_offset;
-	*length = bv.bv_len;
-	return bv.bv_page;
-}
-
-static bool ceph_msg_data_bvecs_advance(struct ceph_msg_data_cursor *cursor,
-					size_t bytes)
-{
-	struct bio_vec *bvecs = cursor->data->bvec_pos.bvecs;
-	struct page *page = bvec_iter_page(bvecs, cursor->bvec_iter);
-
-	BUG_ON(bytes > cursor->resid);
-	BUG_ON(bytes > bvec_iter_len(bvecs, cursor->bvec_iter));
-	cursor->resid -= bytes;
-	bvec_iter_advance(bvecs, &cursor->bvec_iter, bytes);
-
-	if (!cursor->resid)
-		return false;   /* no more data */
-
-	if (!bytes || (cursor->bvec_iter.bi_bvec_done &&
-		       page == bvec_iter_page(bvecs, cursor->bvec_iter)))
-		return false;	/* more bytes to process in this segment */
-
-	BUG_ON(cursor->resid < bvec_iter_len(bvecs, cursor->bvec_iter));
-	return true;
-}
-
 /*
  * For a page array, a piece comes from the first page in the array
  * that has not already been fully consumed.
@@ -1045,14 +932,6 @@ static void __ceph_msg_data_cursor_init(struct ceph_msg_data_cursor *cursor)
 	case CEPH_MSG_DATA_PAGES:
 		ceph_msg_data_pages_cursor_init(cursor, length);
 		break;
-#ifdef CONFIG_BLOCK
-	case CEPH_MSG_DATA_BIO:
-		ceph_msg_data_bio_cursor_init(cursor, length);
-		break;
-#endif /* CONFIG_BLOCK */
-	case CEPH_MSG_DATA_BVECS:
-		ceph_msg_data_bvecs_cursor_init(cursor, length);
-		break;
 	case CEPH_MSG_DATA_DATABUF:
 	case CEPH_MSG_DATA_ITER:
 		ceph_msg_data_iter_cursor_init(cursor, length);
@@ -1096,14 +975,6 @@ struct page *ceph_msg_data_next(struct ceph_msg_data_cursor *cursor,
 	case CEPH_MSG_DATA_PAGES:
 		page = ceph_msg_data_pages_next(cursor, page_offset, length);
 		break;
-#ifdef CONFIG_BLOCK
-	case CEPH_MSG_DATA_BIO:
-		page = ceph_msg_data_bio_next(cursor, page_offset, length);
-		break;
-#endif /* CONFIG_BLOCK */
-	case CEPH_MSG_DATA_BVECS:
-		page = ceph_msg_data_bvecs_next(cursor, page_offset, length);
-		break;
 	case CEPH_MSG_DATA_DATABUF:
 	case CEPH_MSG_DATA_ITER:
 		page = ceph_msg_data_iter_next(cursor, page_offset, length);
@@ -1138,14 +1009,6 @@ void ceph_msg_data_advance(struct ceph_msg_data_cursor *cursor, size_t bytes)
 	case CEPH_MSG_DATA_PAGES:
 		new_piece = ceph_msg_data_pages_advance(cursor, bytes);
 		break;
-#ifdef CONFIG_BLOCK
-	case CEPH_MSG_DATA_BIO:
-		new_piece = ceph_msg_data_bio_advance(cursor, bytes);
-		break;
-#endif /* CONFIG_BLOCK */
-	case CEPH_MSG_DATA_BVECS:
-		new_piece = ceph_msg_data_bvecs_advance(cursor, bytes);
-		break;
 	case CEPH_MSG_DATA_DATABUF:
 	case CEPH_MSG_DATA_ITER:
 		new_piece = ceph_msg_data_iter_advance(cursor, bytes);
@@ -1938,35 +1801,6 @@ void ceph_msg_data_add_pagelist(struct ceph_msg *msg,
 }
 EXPORT_SYMBOL(ceph_msg_data_add_pagelist);
 
-#ifdef	CONFIG_BLOCK
-void ceph_msg_data_add_bio(struct ceph_msg *msg, struct ceph_bio_iter *bio_pos,
-			   u32 length)
-{
-	struct ceph_msg_data *data;
-
-	data = ceph_msg_data_add(msg);
-	data->type = CEPH_MSG_DATA_BIO;
-	data->bio_pos = *bio_pos;
-	data->bio_length = length;
-
-	msg->data_length += length;
-}
-EXPORT_SYMBOL(ceph_msg_data_add_bio);
-#endif	/* CONFIG_BLOCK */
-
-void ceph_msg_data_add_bvecs(struct ceph_msg *msg,
-			     struct ceph_bvec_iter *bvec_pos)
-{
-	struct ceph_msg_data *data;
-
-	data = ceph_msg_data_add(msg);
-	data->type = CEPH_MSG_DATA_BVECS;
-	data->bvec_pos = *bvec_pos;
-
-	msg->data_length += bvec_pos->iter.bi_size;
-}
-EXPORT_SYMBOL(ceph_msg_data_add_bvecs);
-
 void ceph_msg_data_add_iter(struct ceph_msg *msg,
 			    struct iov_iter *iter)
 {
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index fc5c136e793d..10f65e9b1906 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -9,9 +9,6 @@
 #include <linux/pagemap.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
-#ifdef CONFIG_BLOCK
-#include <linux/bio.h>
-#endif
 
 #include <linux/ceph/ceph_features.h>
 #include <linux/ceph/libceph.h>
@@ -151,26 +148,6 @@ static void ceph_osd_data_pagelist_init(struct ceph_osd_data *osd_data,
 	osd_data->pagelist = pagelist;
 }
 
-#ifdef CONFIG_BLOCK
-static void ceph_osd_data_bio_init(struct ceph_osd_data *osd_data,
-				   struct ceph_bio_iter *bio_pos,
-				   u32 bio_length)
-{
-	osd_data->type = CEPH_OSD_DATA_TYPE_BIO;
-	osd_data->bio_pos = *bio_pos;
-	osd_data->bio_length = bio_length;
-}
-#endif /* CONFIG_BLOCK */
-
-static void ceph_osd_data_bvecs_init(struct ceph_osd_data *osd_data,
-				     struct ceph_bvec_iter *bvec_pos,
-				     u32 num_bvecs)
-{
-	osd_data->type = CEPH_OSD_DATA_TYPE_BVECS;
-	osd_data->bvec_pos = *bvec_pos;
-	osd_data->num_bvecs = num_bvecs;
-}
-
 static void ceph_osd_iter_init(struct ceph_osd_data *osd_data,
 			       struct iov_iter *iter)
 {
@@ -252,47 +229,6 @@ void osd_req_op_extent_osd_data_pagelist(struct ceph_osd_request *osd_req,
 }
 EXPORT_SYMBOL(osd_req_op_extent_osd_data_pagelist);
 
-#ifdef CONFIG_BLOCK
-void osd_req_op_extent_osd_data_bio(struct ceph_osd_request *osd_req,
-				    unsigned int which,
-				    struct ceph_bio_iter *bio_pos,
-				    u32 bio_length)
-{
-	struct ceph_osd_data *osd_data;
-
-	osd_data = osd_req_op_data(osd_req, which, extent, osd_data);
-	ceph_osd_data_bio_init(osd_data, bio_pos, bio_length);
-}
-EXPORT_SYMBOL(osd_req_op_extent_osd_data_bio);
-#endif /* CONFIG_BLOCK */
-
-void osd_req_op_extent_osd_data_bvecs(struct ceph_osd_request *osd_req,
-				      unsigned int which,
-				      struct bio_vec *bvecs, u32 num_bvecs,
-				      u32 bytes)
-{
-	struct ceph_osd_data *osd_data;
-	struct ceph_bvec_iter it = {
-		.bvecs = bvecs,
-		.iter = { .bi_size = bytes },
-	};
-
-	osd_data = osd_req_op_data(osd_req, which, extent, osd_data);
-	ceph_osd_data_bvecs_init(osd_data, &it, num_bvecs);
-}
-EXPORT_SYMBOL(osd_req_op_extent_osd_data_bvecs);
-
-void osd_req_op_extent_osd_data_bvec_pos(struct ceph_osd_request *osd_req,
-					 unsigned int which,
-					 struct ceph_bvec_iter *bvec_pos)
-{
-	struct ceph_osd_data *osd_data;
-
-	osd_data = osd_req_op_data(osd_req, which, extent, osd_data);
-	ceph_osd_data_bvecs_init(osd_data, bvec_pos, 0);
-}
-EXPORT_SYMBOL(osd_req_op_extent_osd_data_bvec_pos);
-
 /**
  * osd_req_op_extent_osd_iter - Set up an operation with an iterator buffer
  * @osd_req: The request to set up
@@ -360,24 +296,6 @@ static void osd_req_op_cls_request_data_pages(struct ceph_osd_request *osd_req,
 	osd_req->r_ops[which].indata_len += length;
 }
 
-void osd_req_op_cls_request_data_bvecs(struct ceph_osd_request *osd_req,
-				       unsigned int which,
-				       struct bio_vec *bvecs, u32 num_bvecs,
-				       u32 bytes)
-{
-	struct ceph_osd_data *osd_data;
-	struct ceph_bvec_iter it = {
-		.bvecs = bvecs,
-		.iter = { .bi_size = bytes },
-	};
-
-	osd_data = osd_req_op_data(osd_req, which, cls, request_data);
-	ceph_osd_data_bvecs_init(osd_data, &it, num_bvecs);
-	osd_req->r_ops[which].cls.indata_len += bytes;
-	osd_req->r_ops[which].indata_len += bytes;
-}
-EXPORT_SYMBOL(osd_req_op_cls_request_data_bvecs);
-
 void osd_req_op_cls_response_databuf(struct ceph_osd_request *osd_req,
 				     unsigned int which,
 				     struct ceph_databuf *dbuf)
@@ -402,12 +320,6 @@ static u64 ceph_osd_data_length(struct ceph_osd_data *osd_data)
 		return osd_data->length;
 	case CEPH_OSD_DATA_TYPE_PAGELIST:
 		return (u64)osd_data->pagelist->length;
-#ifdef CONFIG_BLOCK
-	case CEPH_OSD_DATA_TYPE_BIO:
-		return (u64)osd_data->bio_length;
-#endif /* CONFIG_BLOCK */
-	case CEPH_OSD_DATA_TYPE_BVECS:
-		return osd_data->bvec_pos.iter.bi_size;
 	case CEPH_OSD_DATA_TYPE_ITER:
 		return iov_iter_count(&osd_data->iter);
 	default:
@@ -1017,12 +929,6 @@ static void ceph_osdc_msg_data_add(struct ceph_msg *msg,
 	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGELIST) {
 		BUG_ON(!length);
 		ceph_msg_data_add_pagelist(msg, osd_data->pagelist);
-#ifdef CONFIG_BLOCK
-	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_BIO) {
-		ceph_msg_data_add_bio(msg, &osd_data->bio_pos, length);
-#endif
-	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_BVECS) {
-		ceph_msg_data_add_bvecs(msg, &osd_data->bvec_pos);
 	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_ITER) {
 		ceph_msg_data_add_iter(msg, &osd_data->iter);
 	} else {


