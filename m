Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752477700ED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 15:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjHDNPM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 09:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjHDNPI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:15:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200BD49CC
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 06:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691154819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D2YpTOJ6JRohx3g48R4wgVLcRY5NDi9/xoU8X/XNBX8=;
        b=emF+8LKNaxFcuYQdMgCN7wABEPWsBNREiMJx9OqApC7XCqK0VIQSFXwVOcwUx15DjOG9qg
        6kuNZ+v3Zf3sCCmAKl7zK8j7wi+S6OAj58zoH0obS2jf3739/9Ju6mNrTQv+S2xtG0cJjM
        iLeU9mgFFh+EBIXOOcdWbeRVIEcrBAw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-461-shWclbapMtea_RSsPzgKfg-1; Fri, 04 Aug 2023 09:13:36 -0400
X-MC-Unique: shWclbapMtea_RSsPzgKfg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D52468030AC;
        Fri,  4 Aug 2023 13:13:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8176640282C;
        Fri,  4 Aug 2023 13:13:34 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 02/18] ceph: Rename alignment to offset
Date:   Fri,  4 Aug 2023 14:13:11 +0100
Message-ID: <20230804131327.2574082-3-dhowells@redhat.com>
In-Reply-To: <20230804131327.2574082-1-dhowells@redhat.com>
References: <20230804131327.2574082-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

---
 fs/ceph/addr.c                  |  4 ++--
 include/linux/ceph/messenger.h  |  4 ++--
 include/linux/ceph/osd_client.h | 10 +++++-----
 net/ceph/messenger.c            | 10 +++++-----
 net/ceph/osd_client.c           | 24 ++++++++++++------------
 5 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 228eab6706cd..7571606cf61f 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -279,7 +279,7 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 
 	if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
 		ceph_put_page_vector(osd_data->pages,
-				     calc_pages_for(osd_data->alignment,
+				     calc_pages_for(osd_data->offset,
 					osd_data->length), false);
 	}
 	netfs_subreq_terminated(subreq, err, false);
@@ -881,7 +881,7 @@ static void writepages_finish(struct ceph_osd_request *req)
 		osd_data = osd_req_op_extent_osd_data(req, i);
 		BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_PAGES);
 		len += osd_data->length;
-		num_pages = calc_pages_for((u64)osd_data->alignment,
+		num_pages = calc_pages_for((u64)osd_data->offset,
 					   (u64)osd_data->length);
 		total_pages += num_pages;
 		for (j = 0; j < num_pages; j++) {
diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 2eaaabbe98cb..f6f11bf9d63e 100644
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
index 41bcd71cfa7a..3dabebbdb5dc 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -117,7 +117,7 @@ struct ceph_osd_data {
 		struct {
 			struct page	**pages;
 			u64		length;
-			u32		alignment;
+			u32		offset;
 			bool		pages_from_pool;
 			bool		own_pages;
 		};
@@ -470,7 +470,7 @@ struct ceph_osd_req_op *osd_req_op_init(struct ceph_osd_request *osd_req,
 extern void osd_req_op_raw_data_in_pages(struct ceph_osd_request *,
 					unsigned int which,
 					struct page **pages, u64 length,
-					u32 alignment, bool pages_from_pool,
+					u32 offset, bool pages_from_pool,
 					bool own_pages);
 
 extern void osd_req_op_extent_init(struct ceph_osd_request *osd_req,
@@ -489,7 +489,7 @@ extern struct ceph_osd_data *osd_req_op_extent_osd_data(
 extern void osd_req_op_extent_osd_data_pages(struct ceph_osd_request *,
 					unsigned int which,
 					struct page **pages, u64 length,
-					u32 alignment, bool pages_from_pool,
+					u32 offset, bool pages_from_pool,
 					bool own_pages);
 extern void osd_req_op_extent_osd_data_pagelist(struct ceph_osd_request *,
 					unsigned int which,
@@ -516,7 +516,7 @@ extern void osd_req_op_cls_request_data_pagelist(struct ceph_osd_request *,
 extern void osd_req_op_cls_request_data_pages(struct ceph_osd_request *,
 					unsigned int which,
 					struct page **pages, u64 length,
-					u32 alignment, bool pages_from_pool,
+					u32 offset, bool pages_from_pool,
 					bool own_pages);
 void osd_req_op_cls_request_data_bvecs(struct ceph_osd_request *osd_req,
 				       unsigned int which,
@@ -525,7 +525,7 @@ void osd_req_op_cls_request_data_bvecs(struct ceph_osd_request *osd_req,
 extern void osd_req_op_cls_response_data_pages(struct ceph_osd_request *,
 					unsigned int which,
 					struct page **pages, u64 length,
-					u32 alignment, bool pages_from_pool,
+					u32 offset, bool pages_from_pool,
 					bool own_pages);
 int osd_req_op_cls_init(struct ceph_osd_request *osd_req, unsigned int which,
 			const char *class, const char *method);
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 9dce65fac0bd..6cfc6b69052f 100644
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
index 78b622178a3d..e3152e21418f 100644
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

