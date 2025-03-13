Return-Path: <linux-fsdevel+bounces-43954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D02A60570
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 00:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558303BF6FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 23:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549AC1FCFC2;
	Thu, 13 Mar 2025 23:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DphnxL+L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89F31FCCEA
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 23:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908855; cv=none; b=Cgn8rMN78l9cVq02gkzjhwoML11WUID1UfefOivPQw0PPN3WH1ZtltlV++gJ+zVQM4ekZciykFt7h7eJl8TkRSXzj3Avqr5YZdQr+ZvEGXG6MX7+qDCTJg/hOOSnfgHem6QCXeNlNVcw7XGVLkUtgCOjtQQ+vWZHc55ZEaggfw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908855; c=relaxed/simple;
	bh=yL4/m2YIxwhUvzkWIB4YZgxW/U4ajUEzgtqGj1sym24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKncBv8QsjfN6BjNSXfgZLwNXWO9b3Ku/4rdfELWVN4ZXjdBt6xE56IxqzO5C03ZQD4MI5VjFTeE073DH+zVoy7TKurWRDqQhY+jjp575HDFWS33ofX3IoBYefVg3Rp9/SSZtyPDGGkUMNXLjPaJH4zanes9uyfS3zYDZ9b4JCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DphnxL+L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f/b4f0Vb/gY4x2pdxmK3KmjPYZhvvjUyHmYb6tyCaWw=;
	b=DphnxL+LN8M13lOTenyvAgR/pb7zGUQ8ZXSGj8zuQkdow861p3z4Mi/b9uKgvkQQFtDmLP
	S99OuxEStrxVowFgs7R5b/Oz38qFxDeLGJJN4wWa8blEM9u3kUdE97csC1wC3bwzrqDwdU
	L2otzkyn7A3iYdRO3jm6fZsSrQHHdCs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-VedX4AZ0PTi6XBDFdDjK7g-1; Thu,
 13 Mar 2025 19:34:11 -0400
X-MC-Unique: VedX4AZ0PTi6XBDFdDjK7g-1
X-Mimecast-MFC-AGG-ID: VedX4AZ0PTi6XBDFdDjK7g_1741908850
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E13501955DCC;
	Thu, 13 Mar 2025 23:34:09 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 57A2C300376F;
	Thu, 13 Mar 2025 23:34:07 +0000 (UTC)
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
Subject: [RFC PATCH 05/35] libceph: Add functions to add ceph_databufs to requests
Date: Thu, 13 Mar 2025 23:32:57 +0000
Message-ID: <20250313233341.1675324-6-dhowells@redhat.com>
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

Add some helper functions to add ceph_databufs to ceph_osd_data structs
attached to ceph_osd_request structs.

The osd_data->iter is moved out of the union so that it can be set at the
same time as osd_data->dbuf.  Eventually, the I/O routines will only look
at ->iter; ->dbuf will be used as a pin that gets released at the end of
the I/O.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 include/linux/ceph/osd_client.h | 11 +++++++-
 net/ceph/messenger.c            |  3 ++
 net/ceph/osd_client.c           | 50 +++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index b8fb5a71dd57..172ee515a0f3 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -116,6 +116,7 @@ enum ceph_osd_data_type {
 
 struct ceph_osd_data {
 	enum ceph_osd_data_type	type;
+	struct iov_iter		iter;
 	union {
 		struct ceph_databuf	*dbuf;
 		struct {
@@ -136,7 +137,6 @@ struct ceph_osd_data {
 			struct ceph_bvec_iter	bvec_pos;
 			u32			num_bvecs;
 		};
-		struct iov_iter		iter;
 	};
 };
 
@@ -488,6 +488,9 @@ extern struct ceph_osd_data *osd_req_op_extent_osd_data(
 					struct ceph_osd_request *osd_req,
 					unsigned int which);
 
+void osd_req_op_extent_osd_databuf(struct ceph_osd_request *req,
+				   unsigned int which,
+				   struct ceph_databuf *dbuf);
 extern void osd_req_op_extent_osd_data_pages(struct ceph_osd_request *,
 					unsigned int which,
 					struct page **pages, u64 length,
@@ -512,6 +515,9 @@ void osd_req_op_extent_osd_data_bvec_pos(struct ceph_osd_request *osd_req,
 void osd_req_op_extent_osd_iter(struct ceph_osd_request *osd_req,
 				unsigned int which, struct iov_iter *iter);
 
+void osd_req_op_cls_request_databuf(struct ceph_osd_request *req,
+				    unsigned int which,
+				    struct ceph_databuf *dbuf);
 extern void osd_req_op_cls_request_data_pagelist(struct ceph_osd_request *,
 					unsigned int which,
 					struct ceph_pagelist *pagelist);
@@ -524,6 +530,9 @@ void osd_req_op_cls_request_data_bvecs(struct ceph_osd_request *osd_req,
 				       unsigned int which,
 				       struct bio_vec *bvecs, u32 num_bvecs,
 				       u32 bytes);
+void osd_req_op_cls_response_databuf(struct ceph_osd_request *osd_req,
+				     unsigned int which,
+				     struct ceph_databuf *dbuf);
 extern void osd_req_op_cls_response_data_pages(struct ceph_osd_request *,
 					unsigned int which,
 					struct page **pages, u64 length,
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 802f0b222131..02439b38ec94 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1052,6 +1052,7 @@ static void __ceph_msg_data_cursor_init(struct ceph_msg_data_cursor *cursor)
 	case CEPH_MSG_DATA_BVECS:
 		ceph_msg_data_bvecs_cursor_init(cursor, length);
 		break;
+	case CEPH_MSG_DATA_DATABUF:
 	case CEPH_MSG_DATA_ITER:
 		ceph_msg_data_iter_cursor_init(cursor, length);
 		break;
@@ -1102,6 +1103,7 @@ struct page *ceph_msg_data_next(struct ceph_msg_data_cursor *cursor,
 	case CEPH_MSG_DATA_BVECS:
 		page = ceph_msg_data_bvecs_next(cursor, page_offset, length);
 		break;
+	case CEPH_MSG_DATA_DATABUF:
 	case CEPH_MSG_DATA_ITER:
 		page = ceph_msg_data_iter_next(cursor, page_offset, length);
 		break;
@@ -1143,6 +1145,7 @@ void ceph_msg_data_advance(struct ceph_msg_data_cursor *cursor, size_t bytes)
 	case CEPH_MSG_DATA_BVECS:
 		new_piece = ceph_msg_data_bvecs_advance(cursor, bytes);
 		break;
+	case CEPH_MSG_DATA_DATABUF:
 	case CEPH_MSG_DATA_ITER:
 		new_piece = ceph_msg_data_iter_advance(cursor, bytes);
 		break;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index c84634264377..720d8a605fc4 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -178,6 +178,17 @@ static void ceph_osd_iter_init(struct ceph_osd_data *osd_data,
 	osd_data->iter = *iter;
 }
 
+/*
+ * Consumes a ref on @dbuf.
+ */
+static void ceph_osd_databuf_init(struct ceph_osd_data *osd_data,
+				  struct ceph_databuf *dbuf)
+{
+	osd_data->type = CEPH_OSD_DATA_TYPE_DATABUF;
+	osd_data->dbuf = dbuf;
+	osd_data->iter = dbuf->iter;
+}
+
 static struct ceph_osd_data *
 osd_req_op_raw_data_in(struct ceph_osd_request *osd_req, unsigned int which)
 {
@@ -207,6 +218,17 @@ void osd_req_op_raw_data_in_pages(struct ceph_osd_request *osd_req,
 }
 EXPORT_SYMBOL(osd_req_op_raw_data_in_pages);
 
+void osd_req_op_extent_osd_databuf(struct ceph_osd_request *osd_req,
+				   unsigned int which,
+				   struct ceph_databuf *dbuf)
+{
+	struct ceph_osd_data *osd_data;
+
+	osd_data = osd_req_op_data(osd_req, which, extent, osd_data);
+	ceph_osd_databuf_init(osd_data, dbuf);
+}
+EXPORT_SYMBOL(osd_req_op_extent_osd_databuf);
+
 void osd_req_op_extent_osd_data_pages(struct ceph_osd_request *osd_req,
 			unsigned int which, struct page **pages,
 			u64 length, u32 offset,
@@ -297,6 +319,21 @@ static void osd_req_op_cls_request_info_pagelist(
 	ceph_osd_data_pagelist_init(osd_data, pagelist);
 }
 
+void osd_req_op_cls_request_databuf(struct ceph_osd_request *osd_req,
+				    unsigned int which,
+				    struct ceph_databuf *dbuf)
+{
+	struct ceph_osd_data *osd_data;
+
+	BUG_ON(!ceph_databuf_len(dbuf));
+
+	osd_data = osd_req_op_data(osd_req, which, cls, request_data);
+	ceph_osd_databuf_init(osd_data, dbuf);
+	osd_req->r_ops[which].cls.indata_len += ceph_databuf_len(dbuf);
+	osd_req->r_ops[which].indata_len += ceph_databuf_len(dbuf);
+}
+EXPORT_SYMBOL(osd_req_op_cls_request_databuf);
+
 void osd_req_op_cls_request_data_pagelist(
 			struct ceph_osd_request *osd_req,
 			unsigned int which, struct ceph_pagelist *pagelist)
@@ -342,6 +379,19 @@ void osd_req_op_cls_request_data_bvecs(struct ceph_osd_request *osd_req,
 }
 EXPORT_SYMBOL(osd_req_op_cls_request_data_bvecs);
 
+void osd_req_op_cls_response_databuf(struct ceph_osd_request *osd_req,
+				     unsigned int which,
+				     struct ceph_databuf *dbuf)
+{
+	struct ceph_osd_data *osd_data;
+
+	BUG_ON(!ceph_databuf_len(dbuf));
+
+	osd_data = osd_req_op_data(osd_req, which, cls, response_data);
+	ceph_osd_databuf_init(osd_data, ceph_databuf_get(dbuf));
+}
+EXPORT_SYMBOL(osd_req_op_cls_response_databuf);
+
 void osd_req_op_cls_response_data_pages(struct ceph_osd_request *osd_req,
 			unsigned int which, struct page **pages, u64 length,
 			u32 offset, bool pages_from_pool, bool own_pages)


