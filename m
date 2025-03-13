Return-Path: <linux-fsdevel+bounces-43951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C145A60565
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 00:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70653BFA9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 23:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB221FBE9D;
	Thu, 13 Mar 2025 23:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="erAZnhHM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7211D1E9B2E
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 23:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908844; cv=none; b=F2WMI+O3mOJNQw74f1GJSZFJiKOCme2MZo3WQ0xPo/0BnvUhAHVMaxO+64jzWeYBpNdT+FNy9zDoOCVejGkYe6Z8N/WhVHUip5L3FAeJg9OGH9dcNDEXiW/ZGYgsLMylhA3iQEyT7tuI5VKTyFGLf+OznzZzk9M/tczAf6tH6dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908844; c=relaxed/simple;
	bh=a5+wM17zrDIxgoQGyf0nP7R3txTLjuIAWm6gbxEvJl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXI6Yw8ybPrpdHuOvxt8PRQcPJTqLTSrqjkM7BlTJ7oG2ujcMM11GXV/VjvoMxGMeEzquUeUfIPkYO+CwkNBznVB+6Ja1Ce+yyH+ZFL36xmIEvxsnOxWvfny3hVBeG/57FmIw64hpLYOTlk3S77uHGA9q3lYJLaHawCdcP2QJ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=erAZnhHM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zkaBKVJpvKYr2NdYwHCCcrSLhw9yz26BiRgfLhJA8+U=;
	b=erAZnhHMKVSEEBDAGXprcMRLTZYk0SEH1W0biRXcA3LQPugWw+rf2uiGXsCv8pOV6Cnf1Y
	MLId19RHv6GycASsOh8t03rGAEvoEeRx//nNQHoaqCM+tb3lSSopOLA9XpWbYey+WYvnY2
	/RhnLsxTPE3QWAu7wKUorM2ncgD5MeA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-aN_D_xhZNV-InGIDk7kLMQ-1; Thu,
 13 Mar 2025 19:34:00 -0400
X-MC-Unique: aN_D_xhZNV-InGIDk7kLMQ-1
X-Mimecast-MFC-AGG-ID: aN_D_xhZNV-InGIDk7kLMQ_1741908838
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 345BD19560AE;
	Thu, 13 Mar 2025 23:33:58 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E1B1419560AB;
	Thu, 13 Mar 2025 23:33:55 +0000 (UTC)
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
Subject: [RFC PATCH 02/35] libceph: Rename alignment to offset
Date: Thu, 13 Mar 2025 23:32:54 +0000
Message-ID: <20250313233341.1675324-3-dhowells@redhat.com>
In-Reply-To: <20250313233341.1675324-1-dhowells@redhat.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Rename 'alignment' to 'offset' in a number of places where it seems to be
talking about the offset into the first page of a sequence of pages.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/ceph/addr.c                  |  4 ++--
 include/linux/ceph/messenger.h  |  4 ++--
 include/linux/ceph/osd_client.h | 10 +++++-----
 net/ceph/messenger.c            | 10 +++++-----
 net/ceph/osd_client.c           | 24 ++++++++++++------------
 5 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 20b6bd8cd004..482a9f41a685 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -254,7 +254,7 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 
 	if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
 		ceph_put_page_vector(osd_data->pages,
-				     calc_pages_for(osd_data->alignment,
+				     calc_pages_for(osd_data->offset,
 					osd_data->length), false);
 	}
 	if (err > 0) {
@@ -918,7 +918,7 @@ static void writepages_finish(struct ceph_osd_request *req)
 		osd_data = osd_req_op_extent_osd_data(req, i);
 		BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_PAGES);
 		len += osd_data->length;
-		num_pages = calc_pages_for((u64)osd_data->alignment,
+		num_pages = calc_pages_for((u64)osd_data->offset,
 					   (u64)osd_data->length);
 		total_pages += num_pages;
 		for (j = 0; j < num_pages; j++) {
diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 1717cc57cdac..db2aba32b8a0 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -221,7 +221,7 @@ struct ceph_msg_data {
 		struct {
 			struct page	**pages;
 			size_t		length;		/* total # bytes */
-			unsigned int	alignment;	/* first page */
+			unsigned int	offset;		/* first page */
 			bool		own_pages;
 		};
 		struct ceph_pagelist	*pagelist;
@@ -602,7 +602,7 @@ extern bool ceph_con_keepalive_expired(struct ceph_connection *con,
 				       unsigned long interval);
 
 void ceph_msg_data_add_pages(struct ceph_msg *msg, struct page **pages,
-			     size_t length, size_t alignment, bool own_pages);
+			     size_t length, size_t offset, bool own_pages);
 extern void ceph_msg_data_add_pagelist(struct ceph_msg *msg,
 				struct ceph_pagelist *pagelist);
 #ifdef CONFIG_BLOCK
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index d55b30057a45..8fc84f389aad 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -118,7 +118,7 @@ struct ceph_osd_data {
 		struct {
 			struct page	**pages;
 			u64		length;
-			u32		alignment;
+			u32		offset;
 			bool		pages_from_pool;
 			bool		own_pages;
 		};
@@ -469,7 +469,7 @@ struct ceph_osd_req_op *osd_req_op_init(struct ceph_osd_request *osd_req,
 extern void osd_req_op_raw_data_in_pages(struct ceph_osd_request *,
 					unsigned int which,
 					struct page **pages, u64 length,
-					u32 alignment, bool pages_from_pool,
+					u32 offset, bool pages_from_pool,
 					bool own_pages);
 
 extern void osd_req_op_extent_init(struct ceph_osd_request *osd_req,
@@ -488,7 +488,7 @@ extern struct ceph_osd_data *osd_req_op_extent_osd_data(
 extern void osd_req_op_extent_osd_data_pages(struct ceph_osd_request *,
 					unsigned int which,
 					struct page **pages, u64 length,
-					u32 alignment, bool pages_from_pool,
+					u32 offset, bool pages_from_pool,
 					bool own_pages);
 extern void osd_req_op_extent_osd_data_pagelist(struct ceph_osd_request *,
 					unsigned int which,
@@ -515,7 +515,7 @@ extern void osd_req_op_cls_request_data_pagelist(struct ceph_osd_request *,
 extern void osd_req_op_cls_request_data_pages(struct ceph_osd_request *,
 					unsigned int which,
 					struct page **pages, u64 length,
-					u32 alignment, bool pages_from_pool,
+					u32 offset, bool pages_from_pool,
 					bool own_pages);
 void osd_req_op_cls_request_data_bvecs(struct ceph_osd_request *osd_req,
 				       unsigned int which,
@@ -524,7 +524,7 @@ void osd_req_op_cls_request_data_bvecs(struct ceph_osd_request *osd_req,
 extern void osd_req_op_cls_response_data_pages(struct ceph_osd_request *,
 					unsigned int which,
 					struct page **pages, u64 length,
-					u32 alignment, bool pages_from_pool,
+					u32 offset, bool pages_from_pool,
 					bool own_pages);
 int osd_req_op_cls_init(struct ceph_osd_request *osd_req, unsigned int which,
 			const char *class, const char *method);
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index d1b5705dc0c6..1df4291cc80b 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -840,8 +840,8 @@ static void ceph_msg_data_pages_cursor_init(struct ceph_msg_data_cursor *cursor,
 	BUG_ON(!data->length);
 
 	cursor->resid = min(length, data->length);
-	page_count = calc_pages_for(data->alignment, (u64)data->length);
-	cursor->page_offset = data->alignment & ~PAGE_MASK;
+	page_count = calc_pages_for(data->offset, (u64)data->length);
+	cursor->page_offset = data->offset & ~PAGE_MASK;
 	cursor->page_index = 0;
 	BUG_ON(page_count > (int)USHRT_MAX);
 	cursor->page_count = (unsigned short)page_count;
@@ -1873,7 +1873,7 @@ static struct ceph_msg_data *ceph_msg_data_add(struct ceph_msg *msg)
 static void ceph_msg_data_destroy(struct ceph_msg_data *data)
 {
 	if (data->type == CEPH_MSG_DATA_PAGES && data->own_pages) {
-		int num_pages = calc_pages_for(data->alignment, data->length);
+		int num_pages = calc_pages_for(data->offset, data->length);
 		ceph_release_page_vector(data->pages, num_pages);
 	} else if (data->type == CEPH_MSG_DATA_PAGELIST) {
 		ceph_pagelist_release(data->pagelist);
@@ -1881,7 +1881,7 @@ static void ceph_msg_data_destroy(struct ceph_msg_data *data)
 }
 
 void ceph_msg_data_add_pages(struct ceph_msg *msg, struct page **pages,
-			     size_t length, size_t alignment, bool own_pages)
+			     size_t length, size_t offset, bool own_pages)
 {
 	struct ceph_msg_data *data;
 
@@ -1892,7 +1892,7 @@ void ceph_msg_data_add_pages(struct ceph_msg *msg, struct page **pages,
 	data->type = CEPH_MSG_DATA_PAGES;
 	data->pages = pages;
 	data->length = length;
-	data->alignment = alignment & ~PAGE_MASK;
+	data->offset = offset & ~PAGE_MASK;
 	data->own_pages = own_pages;
 
 	msg->data_length += length;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index b24afec24138..e359e70ad47e 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -130,13 +130,13 @@ static void ceph_osd_data_init(struct ceph_osd_data *osd_data)
  * Consumes @pages if @own_pages is true.
  */
 static void ceph_osd_data_pages_init(struct ceph_osd_data *osd_data,
-			struct page **pages, u64 length, u32 alignment,
+			struct page **pages, u64 length, u32 offset,
 			bool pages_from_pool, bool own_pages)
 {
 	osd_data->type = CEPH_OSD_DATA_TYPE_PAGES;
 	osd_data->pages = pages;
 	osd_data->length = length;
-	osd_data->alignment = alignment;
+	osd_data->offset = offset;
 	osd_data->pages_from_pool = pages_from_pool;
 	osd_data->own_pages = own_pages;
 }
@@ -196,26 +196,26 @@ EXPORT_SYMBOL(osd_req_op_extent_osd_data);
 
 void osd_req_op_raw_data_in_pages(struct ceph_osd_request *osd_req,
 			unsigned int which, struct page **pages,
-			u64 length, u32 alignment,
+			u64 length, u32 offset,
 			bool pages_from_pool, bool own_pages)
 {
 	struct ceph_osd_data *osd_data;
 
 	osd_data = osd_req_op_raw_data_in(osd_req, which);
-	ceph_osd_data_pages_init(osd_data, pages, length, alignment,
+	ceph_osd_data_pages_init(osd_data, pages, length, offset,
 				pages_from_pool, own_pages);
 }
 EXPORT_SYMBOL(osd_req_op_raw_data_in_pages);
 
 void osd_req_op_extent_osd_data_pages(struct ceph_osd_request *osd_req,
 			unsigned int which, struct page **pages,
-			u64 length, u32 alignment,
+			u64 length, u32 offset,
 			bool pages_from_pool, bool own_pages)
 {
 	struct ceph_osd_data *osd_data;
 
 	osd_data = osd_req_op_data(osd_req, which, extent, osd_data);
-	ceph_osd_data_pages_init(osd_data, pages, length, alignment,
+	ceph_osd_data_pages_init(osd_data, pages, length, offset,
 				pages_from_pool, own_pages);
 }
 EXPORT_SYMBOL(osd_req_op_extent_osd_data_pages);
@@ -312,12 +312,12 @@ EXPORT_SYMBOL(osd_req_op_cls_request_data_pagelist);
 
 void osd_req_op_cls_request_data_pages(struct ceph_osd_request *osd_req,
 			unsigned int which, struct page **pages, u64 length,
-			u32 alignment, bool pages_from_pool, bool own_pages)
+			u32 offset, bool pages_from_pool, bool own_pages)
 {
 	struct ceph_osd_data *osd_data;
 
 	osd_data = osd_req_op_data(osd_req, which, cls, request_data);
-	ceph_osd_data_pages_init(osd_data, pages, length, alignment,
+	ceph_osd_data_pages_init(osd_data, pages, length, offset,
 				pages_from_pool, own_pages);
 	osd_req->r_ops[which].cls.indata_len += length;
 	osd_req->r_ops[which].indata_len += length;
@@ -344,12 +344,12 @@ EXPORT_SYMBOL(osd_req_op_cls_request_data_bvecs);
 
 void osd_req_op_cls_response_data_pages(struct ceph_osd_request *osd_req,
 			unsigned int which, struct page **pages, u64 length,
-			u32 alignment, bool pages_from_pool, bool own_pages)
+			u32 offset, bool pages_from_pool, bool own_pages)
 {
 	struct ceph_osd_data *osd_data;
 
 	osd_data = osd_req_op_data(osd_req, which, cls, response_data);
-	ceph_osd_data_pages_init(osd_data, pages, length, alignment,
+	ceph_osd_data_pages_init(osd_data, pages, length, offset,
 				pages_from_pool, own_pages);
 }
 EXPORT_SYMBOL(osd_req_op_cls_response_data_pages);
@@ -382,7 +382,7 @@ static void ceph_osd_data_release(struct ceph_osd_data *osd_data)
 	if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES && osd_data->own_pages) {
 		int num_pages;
 
-		num_pages = calc_pages_for((u64)osd_data->alignment,
+		num_pages = calc_pages_for((u64)osd_data->offset,
 						(u64)osd_data->length);
 		ceph_release_page_vector(osd_data->pages, num_pages);
 	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGELIST) {
@@ -969,7 +969,7 @@ static void ceph_osdc_msg_data_add(struct ceph_msg *msg,
 		BUG_ON(length > (u64) SIZE_MAX);
 		if (length)
 			ceph_msg_data_add_pages(msg, osd_data->pages,
-					length, osd_data->alignment, false);
+					length, osd_data->offset, false);
 	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGELIST) {
 		BUG_ON(!length);
 		ceph_msg_data_add_pagelist(msg, osd_data->pagelist);


