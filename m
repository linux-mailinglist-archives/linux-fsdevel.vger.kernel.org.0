Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262BA77013C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 15:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjHDNRh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 09:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjHDNQl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:16:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363FA4ED0
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 06:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691154847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jzu8fasV+aKxrhKzf7SpDRjT/Fb/KvqzXURcAl/1eC8=;
        b=DxDuIDHYzBSktQi99yEAh1rSaI0+x0dRFeq1z76l7qQw0MfW+Zkl4nmnGKbzbnyBt/zcFa
        lWTXDbIrSaCXNVS0KeV1c14Mr8dYLqS4x7PJMfq6i09d0y0QgSMZni3nQpAEAAkXpLo6N2
        CvJK7SPi9u5HdXJ0NlZ/T1PyiO5WSmg=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-KDnOmyoHPMCfaw7z8GudnA-1; Fri, 04 Aug 2023 09:14:03 -0400
X-MC-Unique: KDnOmyoHPMCfaw7z8GudnA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C08613C0FCB0;
        Fri,  4 Aug 2023 13:14:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93B07492B03;
        Fri,  4 Aug 2023 13:14:01 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 16/18] ceph: Remove CEPH_OS_DATA_TYPE_PAGES and its attendant helpers
Date:   Fri,  4 Aug 2023 14:13:25 +0100
Message-ID: <20230804131327.2574082-17-dhowells@redhat.com>
In-Reply-To: <20230804131327.2574082-1-dhowells@redhat.com>
References: <20230804131327.2574082-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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
 include/linux/ceph/osd_client.h | 20 ++----------
 net/ceph/osd_client.c           | 57 +--------------------------------
 2 files changed, 3 insertions(+), 74 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 3099f923c241..1a1137787487 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -103,23 +103,13 @@ struct ceph_osd {
 enum ceph_osd_data_type {
 	CEPH_OSD_DATA_TYPE_NONE = 0,
 	CEPH_OSD_DATA_TYPE_DATABUF,
-	CEPH_OSD_DATA_TYPE_PAGES,
 	CEPH_OSD_DATA_TYPE_ITER,
 };
 
 struct ceph_osd_data {
 	enum ceph_osd_data_type	type;
-	union {
-		struct ceph_databuf	*dbuf;
-		struct {
-			struct page	**pages;
-			u64		length;
-			u32		offset;
-			bool		pages_from_pool;
-			bool		own_pages;
-		};
-		struct iov_iter		iter;
-	};
+	struct ceph_databuf	*dbuf;
+	struct iov_iter		iter;
 };
 
 struct ceph_osd_req_op {
@@ -451,12 +441,6 @@ void ceph_osdc_clear_abort_err(struct ceph_osd_client *osdc);
 struct ceph_osd_req_op *osd_req_op_init(struct ceph_osd_request *osd_req,
 			    unsigned int which, u16 opcode, u32 flags);
 
-extern void osd_req_op_raw_data_in_pages(struct ceph_osd_request *,
-					unsigned int which,
-					struct page **pages, u64 length,
-					u32 offset, bool pages_from_pool,
-					bool own_pages);
-
 extern void osd_req_op_extent_init(struct ceph_osd_request *osd_req,
 					unsigned int which, u16 opcode,
 					u64 offset, u64 length,
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 0fe16fdc760f..70f81a0b62c0 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -122,21 +122,6 @@ static void ceph_osd_data_init(struct ceph_osd_data *osd_data)
 	osd_data->type = CEPH_OSD_DATA_TYPE_NONE;
 }
 
-/*
- * Consumes @pages if @own_pages is true.
- */
-static void ceph_osd_data_pages_init(struct ceph_osd_data *osd_data,
-			struct page **pages, u64 length, u32 offset,
-			bool pages_from_pool, bool own_pages)
-{
-	osd_data->type = CEPH_OSD_DATA_TYPE_PAGES;
-	osd_data->pages = pages;
-	osd_data->length = length;
-	osd_data->offset = offset;
-	osd_data->pages_from_pool = pages_from_pool;
-	osd_data->own_pages = own_pages;
-}
-
 static void ceph_osd_iter_init(struct ceph_osd_data *osd_data,
 			       struct iov_iter *iter)
 {
@@ -181,19 +166,6 @@ void osd_req_op_raw_data_in_databuf(struct ceph_osd_request *osd_req,
 }
 EXPORT_SYMBOL(osd_req_op_raw_data_in_databuf);
 
-void osd_req_op_raw_data_in_pages(struct ceph_osd_request *osd_req,
-			unsigned int which, struct page **pages,
-			u64 length, u32 offset,
-			bool pages_from_pool, bool own_pages)
-{
-	struct ceph_osd_data *osd_data;
-
-	osd_data = osd_req_op_raw_data_in(osd_req, which);
-	ceph_osd_data_pages_init(osd_data, pages, length, offset,
-				pages_from_pool, own_pages);
-}
-EXPORT_SYMBOL(osd_req_op_raw_data_in_pages);
-
 void osd_req_op_extent_osd_databuf(struct ceph_osd_request *osd_req,
 				   unsigned int which,
 				   struct ceph_databuf *dbuf)
@@ -205,19 +177,6 @@ void osd_req_op_extent_osd_databuf(struct ceph_osd_request *osd_req,
 }
 EXPORT_SYMBOL(osd_req_op_extent_osd_databuf);
 
-void osd_req_op_extent_osd_data_pages(struct ceph_osd_request *osd_req,
-			unsigned int which, struct page **pages,
-			u64 length, u32 offset,
-			bool pages_from_pool, bool own_pages)
-{
-	struct ceph_osd_data *osd_data;
-
-	osd_data = osd_req_op_data(osd_req, which, extent, osd_data);
-	ceph_osd_data_pages_init(osd_data, pages, length, offset,
-				pages_from_pool, own_pages);
-}
-EXPORT_SYMBOL(osd_req_op_extent_osd_data_pages);
-
 /**
  * osd_req_op_extent_osd_iter - Set up an operation with an iterator buffer
  * @osd_req: The request to set up
@@ -285,8 +244,6 @@ static u64 ceph_osd_data_length(struct ceph_osd_data *osd_data)
 	switch (osd_data->type) {
 	case CEPH_OSD_DATA_TYPE_NONE:
 		return 0;
-	case CEPH_OSD_DATA_TYPE_PAGES:
-		return osd_data->length;
 	case CEPH_OSD_DATA_TYPE_ITER:
 		return iov_iter_count(&osd_data->iter);
 	default:
@@ -297,13 +254,6 @@ static u64 ceph_osd_data_length(struct ceph_osd_data *osd_data)
 
 static void ceph_osd_data_release(struct ceph_osd_data *osd_data)
 {
-	if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES && osd_data->own_pages) {
-		int num_pages;
-
-		num_pages = calc_pages_for((u64)osd_data->offset,
-						(u64)osd_data->length);
-		ceph_release_page_vector(osd_data->pages, num_pages);
-	}
 	ceph_osd_data_init(osd_data);
 }
 
@@ -881,12 +831,7 @@ static void ceph_osdc_msg_data_add(struct ceph_msg *msg,
 {
 	u64 length = ceph_osd_data_length(osd_data);
 
-	if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
-		BUG_ON(length > (u64) SIZE_MAX);
-		if (length)
-			ceph_msg_data_add_pages(msg, osd_data->pages,
-					length, osd_data->offset, false);
-	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_ITER) {
+	if (osd_data->type == CEPH_OSD_DATA_TYPE_ITER) {
 		ceph_msg_data_add_iter(msg, &osd_data->iter);
 	} else {
 		BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_NONE);

