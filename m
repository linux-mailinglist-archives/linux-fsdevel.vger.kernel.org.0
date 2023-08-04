Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA54577011F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 15:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjHDNQu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 09:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjHDNQR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:16:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD9D4C2F
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 06:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691154839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8jx2PV1ugV88EZ7bQHh38xuBD59rjqjMHqZUXN4vRtQ=;
        b=eiSmDKUZSgs7dsfzzGXEhsMdAvl+GHN1er3RTo9Ug2HCqhZ+RRDt5gEDobQMeQfpZHDk9i
        LcrHbaMfo3He997wYi/Vcy0VDAtnQrSA2sR17cnz0FqPOoBu/pZuOXvVQvPOPXj4KCNuau
        IOo9EP6La/16nhTEjr588qCZgWkaEYA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-Lnq9KISqNHem0GsIpm5I-Q-1; Fri, 04 Aug 2023 09:13:56 -0400
X-MC-Unique: Lnq9KISqNHem0GsIpm5I-Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E6B180123E;
        Fri,  4 Aug 2023 13:13:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D1EB492B03;
        Fri,  4 Aug 2023 13:13:54 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 12/18] ceph: Convert some page arrays to ceph_databuf
Date:   Fri,  4 Aug 2023 14:13:21 +0100
Message-ID: <20230804131327.2574082-13-dhowells@redhat.com>
In-Reply-To: <20230804131327.2574082-1-dhowells@redhat.com>
References: <20230804131327.2574082-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

---
 drivers/block/rbd.c             | 12 +++---
 include/linux/ceph/osd_client.h |  3 ++
 net/ceph/osd_client.c           | 74 +++++++++++++++++++++------------
 3 files changed, 55 insertions(+), 34 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 1756973b696f..950b63eb41de 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2108,7 +2108,7 @@ static int rbd_obj_calc_img_extents(struct rbd_obj_request *obj_req,
 
 static int rbd_osd_setup_stat(struct ceph_osd_request *osd_req, int which)
 {
-	struct page **pages;
+	struct ceph_databuf *dbuf;
 
 	/*
 	 * The response data for a STAT call consists of:
@@ -2118,14 +2118,12 @@ static int rbd_osd_setup_stat(struct ceph_osd_request *osd_req, int which)
 	 *         le32 tv_nsec;
 	 *     } mtime;
 	 */
-	pages = ceph_alloc_page_vector(1, GFP_NOIO);
-	if (IS_ERR(pages))
-		return PTR_ERR(pages);
+	dbuf = ceph_databuf_alloc(1, 8 + sizeof(struct ceph_timespec), GFP_NOIO);
+	if (!dbuf)
+		return -ENOMEM;
 
 	osd_req_op_init(osd_req, which, CEPH_OSD_OP_STAT, 0);
-	osd_req_op_raw_data_in_pages(osd_req, which, pages,
-				     8 + sizeof(struct ceph_timespec),
-				     0, false, true);
+	osd_req_op_raw_data_in_databuf(osd_req, which, dbuf);
 	return 0;
 }
 
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index fd91c5d92600..fec78550d5ce 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -483,6 +483,9 @@ extern void osd_req_op_extent_osd_data_pages(struct ceph_osd_request *,
 					struct page **pages, u64 length,
 					u32 offset, bool pages_from_pool,
 					bool own_pages);
+void osd_req_op_raw_data_in_databuf(struct ceph_osd_request *osd_req,
+				    unsigned int which,
+				    struct ceph_databuf *databuf);
 extern void osd_req_op_extent_osd_data_pagelist(struct ceph_osd_request *,
 					unsigned int which,
 					struct ceph_pagelist *pagelist);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 6bbd9fe780c3..c83ae9bb335e 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -181,6 +181,17 @@ osd_req_op_extent_osd_data(struct ceph_osd_request *osd_req,
 }
 EXPORT_SYMBOL(osd_req_op_extent_osd_data);
 
+void osd_req_op_raw_data_in_databuf(struct ceph_osd_request *osd_req,
+				    unsigned int which,
+				    struct ceph_databuf *dbuf)
+{
+	struct ceph_osd_data *osd_data;
+
+	osd_data = osd_req_op_raw_data_in(osd_req, which);
+	ceph_osd_databuf_init(osd_data, dbuf);
+}
+EXPORT_SYMBOL(osd_req_op_raw_data_in_databuf);
+
 void osd_req_op_raw_data_in_pages(struct ceph_osd_request *osd_req,
 			unsigned int which, struct page **pages,
 			u64 length, u32 offset,
@@ -280,17 +291,16 @@ void osd_req_op_cls_request_data_pagelist(
 }
 EXPORT_SYMBOL(osd_req_op_cls_request_data_pagelist);
 
-static void osd_req_op_cls_request_data_pages(struct ceph_osd_request *osd_req,
-			unsigned int which, struct page **pages, u64 length,
-			u32 offset, bool pages_from_pool, bool own_pages)
+static void osd_req_op_cls_request_data_iter(
+			struct ceph_osd_request *osd_req,
+			unsigned int which, struct iov_iter *iter)
 {
 	struct ceph_osd_data *osd_data;
 
 	osd_data = osd_req_op_data(osd_req, which, cls, request_data);
-	ceph_osd_data_pages_init(osd_data, pages, length, offset,
-				pages_from_pool, own_pages);
-	osd_req->r_ops[which].cls.indata_len += length;
-	osd_req->r_ops[which].indata_len += length;
+	ceph_osd_iter_init(osd_data, iter);
+	osd_req->r_ops[which].cls.indata_len += iter->count;
+	osd_req->r_ops[which].indata_len += iter->count;
 }
 
 void osd_req_op_cls_response_databuf(struct ceph_osd_request *osd_req,
@@ -3017,10 +3027,12 @@ static void linger_commit_cb(struct ceph_osd_request *req)
 	if (!lreq->is_watch) {
 		struct ceph_osd_data *osd_data =
 		    osd_req_op_data(req, 0, notify, response_data);
-		void *p = page_address(osd_data->pages[0]);
+		void *p;
 
 		WARN_ON(req->r_ops[0].op != CEPH_OSD_OP_NOTIFY ||
-			osd_data->type != CEPH_OSD_DATA_TYPE_PAGES);
+			osd_data->type != CEPH_OSD_DATA_TYPE_PAGELIST);
+
+		p = kmap_ceph_databuf_page(osd_data->dbuf, 0);
 
 		/* make note of the notify_id */
 		if (req->r_ops[0].outdata_len >= sizeof(u64)) {
@@ -3030,6 +3042,8 @@ static void linger_commit_cb(struct ceph_osd_request *req)
 		} else {
 			dout("lreq %p no notify_id\n", lreq);
 		}
+
+		kunmap_local(p);
 	}
 
 out:
@@ -5032,7 +5046,7 @@ int ceph_osdc_list_watchers(struct ceph_osd_client *osdc,
 			    u32 *num_watchers)
 {
 	struct ceph_osd_request *req;
-	struct page **pages;
+	struct ceph_databuf *dbuf;
 	int ret;
 
 	req = ceph_osdc_alloc_request(osdc, NULL, 1, false, GFP_NOIO);
@@ -5043,16 +5057,16 @@ int ceph_osdc_list_watchers(struct ceph_osd_client *osdc,
 	ceph_oloc_copy(&req->r_base_oloc, oloc);
 	req->r_flags = CEPH_OSD_FLAG_READ;
 
-	pages = ceph_alloc_page_vector(1, GFP_NOIO);
-	if (IS_ERR(pages)) {
-		ret = PTR_ERR(pages);
+	dbuf = ceph_databuf_alloc(1, PAGE_SIZE, GFP_NOIO);
+	if (!dbuf) {
+		ret = -ENOMEM;
 		goto out_put_req;
 	}
 
 	osd_req_op_init(req, 0, CEPH_OSD_OP_LIST_WATCHERS, 0);
-	ceph_osd_data_pages_init(osd_req_op_data(req, 0, list_watchers,
-						 response_data),
-				 pages, PAGE_SIZE, 0, false, true);
+	ceph_osd_databuf_init(osd_req_op_data(req, 0, list_watchers,
+					      response_data),
+			      dbuf);
 
 	ret = ceph_osdc_alloc_messages(req, GFP_NOIO);
 	if (ret)
@@ -5061,10 +5075,11 @@ int ceph_osdc_list_watchers(struct ceph_osd_client *osdc,
 	ceph_osdc_start_request(osdc, req);
 	ret = ceph_osdc_wait_request(osdc, req);
 	if (ret >= 0) {
-		void *p = page_address(pages[0]);
+		void *p = kmap_ceph_databuf_page(dbuf, 0);
 		void *const end = p + req->r_ops[0].outdata_len;
 
 		ret = decode_watchers(&p, end, watchers, num_watchers);
+		kunmap(p);
 	}
 
 out_put_req:
@@ -5111,6 +5126,8 @@ int ceph_osdc_call(struct ceph_osd_client *osdc,
 		   struct ceph_databuf *response)
 {
 	struct ceph_osd_request *req;
+	struct iov_iter iter;
+	struct bio_vec bv;
 	int ret;
 
 	if (req_len > PAGE_SIZE)
@@ -5128,9 +5145,11 @@ int ceph_osdc_call(struct ceph_osd_client *osdc,
 	if (ret)
 		goto out_put_req;
 
-	if (req_page)
-		osd_req_op_cls_request_data_pages(req, 0, &req_page, req_len,
-						  0, false, false);
+	if (req_page) {
+		bvec_set_page(&bv, req_page, 0, req_len);
+		iov_iter_bvec(&iter, ITER_SOURCE, &bv, 1, req_len);
+		osd_req_op_cls_request_data_iter(req, 0, &iter);
+	}
 	if (response)
 		osd_req_op_cls_response_databuf(req, 0, response);
 
@@ -5285,12 +5304,12 @@ int osd_req_op_copy_from_init(struct ceph_osd_request *req,
 			      u8 copy_from_flags)
 {
 	struct ceph_osd_req_op *op;
-	struct page **pages;
+	struct ceph_databuf *dbuf;
 	void *p, *end;
 
-	pages = ceph_alloc_page_vector(1, GFP_KERNEL);
-	if (IS_ERR(pages))
-		return PTR_ERR(pages);
+	dbuf = ceph_databuf_alloc(1, PAGE_SIZE, GFP_KERNEL);
+	if (!dbuf)
+		return -ENOMEM;
 
 	op = osd_req_op_init(req, 0, CEPH_OSD_OP_COPY_FROM2,
 			     dst_fadvise_flags);
@@ -5299,16 +5318,17 @@ int osd_req_op_copy_from_init(struct ceph_osd_request *req,
 	op->copy_from.flags = copy_from_flags;
 	op->copy_from.src_fadvise_flags = src_fadvise_flags;
 
-	p = page_address(pages[0]);
+	p = kmap_ceph_databuf_page(dbuf, 0);
 	end = p + PAGE_SIZE;
 	ceph_encode_string(&p, end, src_oid->name, src_oid->name_len);
 	encode_oloc(&p, end, src_oloc);
 	ceph_encode_32(&p, truncate_seq);
 	ceph_encode_64(&p, truncate_size);
 	op->indata_len = PAGE_SIZE - (end - p);
+	dbuf->length = op->indata_len;
+	kunmap_local(p);
 
-	ceph_osd_data_pages_init(&op->copy_from.osd_data, pages,
-				 op->indata_len, 0, false, true);
+	ceph_osd_databuf_init(&op->copy_from.osd_data, dbuf);
 	return 0;
 }
 EXPORT_SYMBOL(osd_req_op_copy_from_init);

