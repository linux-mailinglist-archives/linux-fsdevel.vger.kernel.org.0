Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E48C770116
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 15:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjHDNQS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 09:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjHDNQB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:16:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A3D49FE
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 06:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691154830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OUl7uMEy+JTQsdrmAtNpnxa9ZrZaWquboyFa6P9QWEs=;
        b=f5f/llYifmYai91/LuuowhjzGXHt+JDNbHJ5Zmp9nbrJyv8W3jxlj6vKP6YJAY8oSq0d4Q
        3UHcZI/6D68737oGo8bO8lby6QB5rEpeg46Milw7xzhVtIIhbfBZ4j0U+Ix+JlMlO6mxIG
        BwLWwpPLApE9+G0J8nZjULxmaN2NY3U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-B3KsswKzM_q4O4faPh5uEQ-1; Fri, 04 Aug 2023 09:13:44 -0400
X-MC-Unique: B3KsswKzM_q4O4faPh5uEQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8510D80006E;
        Fri,  4 Aug 2023 13:13:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C3FF1454142;
        Fri,  4 Aug 2023 13:13:42 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 06/18] ceph: Change ceph_osdc_call()'s reply to a ceph_databuf
Date:   Fri,  4 Aug 2023 14:13:15 +0100
Message-ID: <20230804131327.2574082-7-dhowells@redhat.com>
In-Reply-To: <20230804131327.2574082-1-dhowells@redhat.com>
References: <20230804131327.2574082-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change the type of ceph_osdc_call()'s reply to a ceph_databuf struct rather
than a list of pages.

Signed-off-by: David Howells <dhowells@redhat.com>
---
 drivers/block/rbd.c             | 134 ++++++++++++++++++--------------
 include/linux/ceph/osd_client.h |   5 +-
 net/ceph/cls_lock_client.c      |  40 +++++-----
 net/ceph/osd_client.c           |  64 +++++++++++++--
 4 files changed, 158 insertions(+), 85 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 2a161b03dd7a..971fa4a581cf 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1823,9 +1823,8 @@ static int __rbd_object_map_load(struct rbd_device *rbd_dev)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
 	CEPH_DEFINE_OID_ONSTACK(oid);
-	struct page **pages;
-	void *p, *end;
-	size_t reply_len;
+	struct ceph_databuf *reply;
+	void *p, *q, *end;
 	u64 num_objects;
 	u64 object_map_bytes;
 	u64 object_map_size;
@@ -1839,48 +1838,57 @@ static int __rbd_object_map_load(struct rbd_device *rbd_dev)
 	object_map_bytes = DIV_ROUND_UP_ULL(num_objects * BITS_PER_OBJ,
 					    BITS_PER_BYTE);
 	num_pages = calc_pages_for(0, object_map_bytes) + 1;
-	pages = ceph_alloc_page_vector(num_pages, GFP_KERNEL);
-	if (IS_ERR(pages))
-		return PTR_ERR(pages);
 
-	reply_len = num_pages * PAGE_SIZE;
+	reply = ceph_databuf_alloc(num_pages, num_pages * PAGE_SIZE,
+				   GFP_KERNEL);
+	if (!reply)
+		return -ENOMEM;
+
 	rbd_object_map_name(rbd_dev, rbd_dev->spec->snap_id, &oid);
 	ret = ceph_osdc_call(osdc, &oid, &rbd_dev->header_oloc,
 			     "rbd", "object_map_load", CEPH_OSD_FLAG_READ,
-			     NULL, 0, pages, &reply_len);
+			     NULL, 0, reply);
 	if (ret)
 		goto out;
 
-	p = page_address(pages[0]);
-	end = p + min(reply_len, (size_t)PAGE_SIZE);
-	ret = decode_object_map_header(&p, end, &object_map_size);
+	p = kmap_ceph_databuf_page(reply, 0);
+	end = p + min(reply->iter.count, (size_t)PAGE_SIZE);
+	q = p;
+	ret = decode_object_map_header(&q, end, &object_map_size);
 	if (ret)
-		goto out;
+		goto out_unmap;
 
 	if (object_map_size != num_objects) {
 		rbd_warn(rbd_dev, "object map size mismatch: %llu vs %llu",
 			 object_map_size, num_objects);
 		ret = -EINVAL;
-		goto out;
+		goto out_unmap;
 	}
+	iov_iter_advance(&reply->iter, q - p);
 
-	if (offset_in_page(p) + object_map_bytes > reply_len) {
+	if (object_map_bytes > reply->iter.count) {
 		ret = -EINVAL;
-		goto out;
+		goto out_unmap;
 	}
 
 	rbd_dev->object_map = kvmalloc(object_map_bytes, GFP_KERNEL);
 	if (!rbd_dev->object_map) {
 		ret = -ENOMEM;
-		goto out;
+		goto out_unmap;
 	}
 
 	rbd_dev->object_map_size = object_map_size;
-	ceph_copy_from_page_vector(pages, rbd_dev->object_map,
-				   offset_in_page(p), object_map_bytes);
 
+	ret = -EIO;
+	if (copy_from_iter(rbd_dev->object_map, object_map_bytes,
+			   &reply->iter) != object_map_bytes)
+		goto out_unmap;
+
+	ret = 0;
+out_unmap:
+	kunmap_local(p);
 out:
-	ceph_release_page_vector(pages, num_pages);
+	ceph_databuf_release(reply);
 	return ret;
 }
 
@@ -1949,6 +1957,7 @@ static int rbd_object_map_update_finish(struct rbd_obj_request *obj_req,
 {
 	struct rbd_device *rbd_dev = obj_req->img_request->rbd_dev;
 	struct ceph_osd_data *osd_data;
+	struct ceph_databuf *dbuf;
 	u64 objno;
 	u8 state, new_state, current_state;
 	bool has_current_state;
@@ -1968,9 +1977,10 @@ static int rbd_object_map_update_finish(struct rbd_obj_request *obj_req,
 	 */
 	rbd_assert(osd_req->r_num_ops == 2);
 	osd_data = osd_req_op_data(osd_req, 1, cls, request_data);
-	rbd_assert(osd_data->type == CEPH_OSD_DATA_TYPE_PAGES);
+	rbd_assert(osd_data->type == CEPH_OSD_DATA_TYPE_DATABUF);
+	dbuf = osd_data->dbuf;
 
-	p = page_address(osd_data->pages[0]);
+	p = kmap_ceph_databuf_page(dbuf, 0);
 	objno = ceph_decode_64(&p);
 	rbd_assert(objno == obj_req->ex.oe_objno);
 	rbd_assert(ceph_decode_64(&p) == objno + 1);
@@ -1978,6 +1988,7 @@ static int rbd_object_map_update_finish(struct rbd_obj_request *obj_req,
 	has_current_state = ceph_decode_8(&p);
 	if (has_current_state)
 		current_state = ceph_decode_8(&p);
+	kunmap_local(p);
 
 	spin_lock(&rbd_dev->object_map_lock);
 	state = __rbd_object_map_get(rbd_dev, objno);
@@ -2017,7 +2028,7 @@ static int rbd_cls_object_map_update(struct ceph_osd_request *req,
 				     int which, u64 objno, u8 new_state,
 				     const u8 *current_state)
 {
-	struct page **pages;
+	struct ceph_databuf *dbuf;
 	void *p, *start;
 	int ret;
 
@@ -2025,11 +2036,11 @@ static int rbd_cls_object_map_update(struct ceph_osd_request *req,
 	if (ret)
 		return ret;
 
-	pages = ceph_alloc_page_vector(1, GFP_NOIO);
-	if (IS_ERR(pages))
-		return PTR_ERR(pages);
+	dbuf = ceph_databuf_alloc(1, PAGE_SIZE, GFP_NOIO);
+	if (!dbuf)
+		return -ENOMEM;
 
-	p = start = page_address(pages[0]);
+	p = start = kmap_ceph_databuf_page(dbuf, 0);
 	ceph_encode_64(&p, objno);
 	ceph_encode_64(&p, objno + 1);
 	ceph_encode_8(&p, new_state);
@@ -2039,9 +2050,11 @@ static int rbd_cls_object_map_update(struct ceph_osd_request *req,
 	} else {
 		ceph_encode_8(&p, 0);
 	}
+	kunmap_local(p);
+	dbuf->length = p - start;
 
-	osd_req_op_cls_request_data_pages(req, which, pages, p - start, 0,
-					  false, true);
+	osd_req_op_cls_request_databuf(req, which, dbuf);
+	ceph_databuf_release(dbuf);
 	return 0;
 }
 
@@ -4613,8 +4626,8 @@ static int rbd_obj_method_sync(struct rbd_device *rbd_dev,
 			     size_t inbound_size)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
+	struct ceph_databuf *reply;
 	struct page *req_page = NULL;
-	struct page *reply_page;
 	int ret;
 
 	/*
@@ -4635,8 +4648,8 @@ static int rbd_obj_method_sync(struct rbd_device *rbd_dev,
 		memcpy(page_address(req_page), outbound, outbound_size);
 	}
 
-	reply_page = alloc_page(GFP_KERNEL);
-	if (!reply_page) {
+	reply = ceph_databuf_alloc(1, inbound_size, GFP_KERNEL);
+	if (!reply) {
 		if (req_page)
 			__free_page(req_page);
 		return -ENOMEM;
@@ -4644,15 +4657,16 @@ static int rbd_obj_method_sync(struct rbd_device *rbd_dev,
 
 	ret = ceph_osdc_call(osdc, oid, oloc, RBD_DRV_NAME, method_name,
 			     CEPH_OSD_FLAG_READ, req_page, outbound_size,
-			     &reply_page, &inbound_size);
+			     reply);
 	if (!ret) {
-		memcpy(inbound, page_address(reply_page), inbound_size);
-		ret = inbound_size;
+		ret = reply->length;
+		if (copy_from_iter(inbound, reply->length, &reply->iter) != ret)
+			ret = -EIO;
 	}
 
 	if (req_page)
 		__free_page(req_page);
-	__free_page(reply_page);
+	ceph_databuf_release(reply);
 	return ret;
 }
 
@@ -5615,7 +5629,7 @@ static int decode_parent_image_spec(void **p, void *end,
 
 static int __get_parent_info(struct rbd_device *rbd_dev,
 			     struct page *req_page,
-			     struct page *reply_page,
+			     struct ceph_databuf *reply,
 			     struct parent_image_info *pii)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
@@ -5625,27 +5639,29 @@ static int __get_parent_info(struct rbd_device *rbd_dev,
 
 	ret = ceph_osdc_call(osdc, &rbd_dev->header_oid, &rbd_dev->header_oloc,
 			     "rbd", "parent_get", CEPH_OSD_FLAG_READ,
-			     req_page, sizeof(u64), &reply_page, &reply_len);
+			     req_page, sizeof(u64), reply);
 	if (ret)
 		return ret == -EOPNOTSUPP ? 1 : ret;
 
-	p = page_address(reply_page);
+	p = kmap_ceph_databuf_page(reply, 0);
 	end = p + reply_len;
 	ret = decode_parent_image_spec(&p, end, pii);
+	kunmap_local(p);
 	if (ret)
 		return ret;
 
 	ret = ceph_osdc_call(osdc, &rbd_dev->header_oid, &rbd_dev->header_oloc,
 			     "rbd", "parent_overlap_get", CEPH_OSD_FLAG_READ,
-			     req_page, sizeof(u64), &reply_page, &reply_len);
+			     req_page, sizeof(u64), reply);
 	if (ret)
 		return ret;
 
-	p = page_address(reply_page);
+	p = kmap_ceph_databuf_page(reply, 0);
 	end = p + reply_len;
 	ceph_decode_8_safe(&p, end, pii->has_overlap, e_inval);
 	if (pii->has_overlap)
 		ceph_decode_64_safe(&p, end, pii->overlap, e_inval);
+	kunmap_local(p);
 
 	return 0;
 
@@ -5658,25 +5674,25 @@ static int __get_parent_info(struct rbd_device *rbd_dev,
  */
 static int __get_parent_info_legacy(struct rbd_device *rbd_dev,
 				    struct page *req_page,
-				    struct page *reply_page,
+				    struct ceph_databuf *reply,
 				    struct parent_image_info *pii)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
-	size_t reply_len = PAGE_SIZE;
 	void *p, *end;
 	int ret;
 
 	ret = ceph_osdc_call(osdc, &rbd_dev->header_oid, &rbd_dev->header_oloc,
 			     "rbd", "get_parent", CEPH_OSD_FLAG_READ,
-			     req_page, sizeof(u64), &reply_page, &reply_len);
+			     req_page, sizeof(u64), reply);
 	if (ret)
 		return ret;
 
-	p = page_address(reply_page);
-	end = p + reply_len;
+	p = kmap_ceph_databuf_page(reply, 0);
+	end = p + reply->length;
 	ceph_decode_64_safe(&p, end, pii->pool_id, e_inval);
 	pii->image_id = ceph_extract_encoded_string(&p, end, NULL, GFP_KERNEL);
 	if (IS_ERR(pii->image_id)) {
+		kunmap_local(p);
 		ret = PTR_ERR(pii->image_id);
 		pii->image_id = NULL;
 		return ret;
@@ -5684,6 +5700,7 @@ static int __get_parent_info_legacy(struct rbd_device *rbd_dev,
 	ceph_decode_64_safe(&p, end, pii->snap_id, e_inval);
 	pii->has_overlap = true;
 	ceph_decode_64_safe(&p, end, pii->overlap, e_inval);
+	kunmap_local(p);
 
 	return 0;
 
@@ -5694,29 +5711,30 @@ static int __get_parent_info_legacy(struct rbd_device *rbd_dev,
 static int get_parent_info(struct rbd_device *rbd_dev,
 			   struct parent_image_info *pii)
 {
-	struct page *req_page, *reply_page;
+	struct ceph_databuf *reply;
+	struct page *req_page;
 	void *p;
-	int ret;
+	int ret = -ENOMEM;
 
 	req_page = alloc_page(GFP_KERNEL);
 	if (!req_page)
-		return -ENOMEM;
+		goto out;
 
-	reply_page = alloc_page(GFP_KERNEL);
-	if (!reply_page) {
-		__free_page(req_page);
-		return -ENOMEM;
-	}
+	reply = ceph_databuf_alloc(1, PAGE_SIZE, GFP_KERNEL);
+	if (!reply)
+		goto out_free;
 
-	p = page_address(req_page);
+	p = kmap_local_page(req_page);
 	ceph_encode_64(&p, rbd_dev->spec->snap_id);
-	ret = __get_parent_info(rbd_dev, req_page, reply_page, pii);
+	kunmap_local(p);
+	ret = __get_parent_info(rbd_dev, req_page, reply, pii);
 	if (ret > 0)
-		ret = __get_parent_info_legacy(rbd_dev, req_page, reply_page,
-					       pii);
+		ret = __get_parent_info_legacy(rbd_dev, req_page, reply, pii);
 
+	ceph_databuf_release(reply);
+out_free:
 	__free_page(req_page);
-	__free_page(reply_page);
+out:
 	return ret;
 }
 
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 2d8cd45f1c34..0e008837dac1 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -531,6 +531,9 @@ void osd_req_op_cls_request_data_bvecs(struct ceph_osd_request *osd_req,
 				       unsigned int which,
 				       struct bio_vec *bvecs, u32 num_bvecs,
 				       u32 bytes);
+void osd_req_op_cls_response_databuf(struct ceph_osd_request *osd_req,
+				     unsigned int which,
+				     struct ceph_databuf *dbuf);
 extern void osd_req_op_cls_response_data_pages(struct ceph_osd_request *,
 					unsigned int which,
 					struct page **pages, u64 length,
@@ -605,7 +608,7 @@ int ceph_osdc_call(struct ceph_osd_client *osdc,
 		   const char *class, const char *method,
 		   unsigned int flags,
 		   struct page *req_page, size_t req_len,
-		   struct page **resp_pages, size_t *resp_len);
+		   struct ceph_databuf *response);
 
 /* watch/notify */
 struct ceph_osd_linger_request *
diff --git a/net/ceph/cls_lock_client.c b/net/ceph/cls_lock_client.c
index 66136a4c1ce7..e2f508704c29 100644
--- a/net/ceph/cls_lock_client.c
+++ b/net/ceph/cls_lock_client.c
@@ -74,7 +74,7 @@ int ceph_cls_lock(struct ceph_osd_client *osdc,
 	     __func__, lock_name, type, cookie, tag, desc, flags);
 	ret = ceph_osdc_call(osdc, oid, oloc, "lock", "lock",
 			     CEPH_OSD_FLAG_WRITE, lock_op_page,
-			     lock_op_buf_size, NULL, NULL);
+			     lock_op_buf_size, NULL);
 
 	dout("%s: status %d\n", __func__, ret);
 	__free_page(lock_op_page);
@@ -124,7 +124,7 @@ int ceph_cls_unlock(struct ceph_osd_client *osdc,
 	dout("%s lock_name %s cookie %s\n", __func__, lock_name, cookie);
 	ret = ceph_osdc_call(osdc, oid, oloc, "lock", "unlock",
 			     CEPH_OSD_FLAG_WRITE, unlock_op_page,
-			     unlock_op_buf_size, NULL, NULL);
+			     unlock_op_buf_size, NULL);
 
 	dout("%s: status %d\n", __func__, ret);
 	__free_page(unlock_op_page);
@@ -179,7 +179,7 @@ int ceph_cls_break_lock(struct ceph_osd_client *osdc,
 	     cookie, ENTITY_NAME(*locker));
 	ret = ceph_osdc_call(osdc, oid, oloc, "lock", "break_lock",
 			     CEPH_OSD_FLAG_WRITE, break_op_page,
-			     break_op_buf_size, NULL, NULL);
+			     break_op_buf_size, NULL);
 
 	dout("%s: status %d\n", __func__, ret);
 	__free_page(break_op_page);
@@ -230,7 +230,7 @@ int ceph_cls_set_cookie(struct ceph_osd_client *osdc,
 	     __func__, lock_name, type, old_cookie, tag, new_cookie);
 	ret = ceph_osdc_call(osdc, oid, oloc, "lock", "set_cookie",
 			     CEPH_OSD_FLAG_WRITE, cookie_op_page,
-			     cookie_op_buf_size, NULL, NULL);
+			     cookie_op_buf_size, NULL);
 
 	dout("%s: status %d\n", __func__, ret);
 	__free_page(cookie_op_page);
@@ -337,10 +337,10 @@ int ceph_cls_lock_info(struct ceph_osd_client *osdc,
 		       char *lock_name, u8 *type, char **tag,
 		       struct ceph_locker **lockers, u32 *num_lockers)
 {
+	struct ceph_databuf *reply;
 	int get_info_op_buf_size;
 	int name_len = strlen(lock_name);
-	struct page *get_info_op_page, *reply_page;
-	size_t reply_len = PAGE_SIZE;
+	struct page *get_info_op_page;
 	void *p, *end;
 	int ret;
 
@@ -353,8 +353,8 @@ int ceph_cls_lock_info(struct ceph_osd_client *osdc,
 	if (!get_info_op_page)
 		return -ENOMEM;
 
-	reply_page = alloc_page(GFP_NOIO);
-	if (!reply_page) {
+	reply = ceph_databuf_alloc(1, PAGE_SIZE, GFP_NOIO);
+	if (!reply) {
 		__free_page(get_info_op_page);
 		return -ENOMEM;
 	}
@@ -370,18 +370,19 @@ int ceph_cls_lock_info(struct ceph_osd_client *osdc,
 	dout("%s lock_name %s\n", __func__, lock_name);
 	ret = ceph_osdc_call(osdc, oid, oloc, "lock", "get_info",
 			     CEPH_OSD_FLAG_READ, get_info_op_page,
-			     get_info_op_buf_size, &reply_page, &reply_len);
+			     get_info_op_buf_size, reply);
 
 	dout("%s: status %d\n", __func__, ret);
 	if (ret >= 0) {
-		p = page_address(reply_page);
-		end = p + reply_len;
+		p = kmap_ceph_databuf_page(reply, 0);
+		end = p + reply->length;
 
 		ret = decode_lockers(&p, end, type, tag, lockers, num_lockers);
+		kunmap_local(p);
 	}
 
 	__free_page(get_info_op_page);
-	__free_page(reply_page);
+	ceph_databuf_release(reply);
 	return ret;
 }
 EXPORT_SYMBOL(ceph_cls_lock_info);
@@ -389,11 +390,11 @@ EXPORT_SYMBOL(ceph_cls_lock_info);
 int ceph_cls_assert_locked(struct ceph_osd_request *req, int which,
 			   char *lock_name, u8 type, char *cookie, char *tag)
 {
+	struct ceph_databuf *dbuf;
 	int assert_op_buf_size;
 	int name_len = strlen(lock_name);
 	int cookie_len = strlen(cookie);
 	int tag_len = strlen(tag);
-	struct page **pages;
 	void *p, *end;
 	int ret;
 
@@ -408,11 +409,11 @@ int ceph_cls_assert_locked(struct ceph_osd_request *req, int which,
 	if (ret)
 		return ret;
 
-	pages = ceph_alloc_page_vector(1, GFP_NOIO);
-	if (IS_ERR(pages))
-		return PTR_ERR(pages);
+	dbuf = ceph_databuf_alloc(1, PAGE_SIZE, GFP_NOIO);
+	if (!dbuf)
+		return -ENOMEM;
 
-	p = page_address(pages[0]);
+	p = kmap_ceph_databuf_page(dbuf, 0);
 	end = p + assert_op_buf_size;
 
 	/* encode cls_lock_assert_op struct */
@@ -422,10 +423,11 @@ int ceph_cls_assert_locked(struct ceph_osd_request *req, int which,
 	ceph_encode_8(&p, type);
 	ceph_encode_string(&p, end, cookie, cookie_len);
 	ceph_encode_string(&p, end, tag, tag_len);
+	kunmap(p);
 	WARN_ON(p != end);
+	dbuf->length = assert_op_buf_size;
 
-	osd_req_op_cls_request_data_pages(req, which, pages, assert_op_buf_size,
-					  0, false, true);
+	osd_req_op_cls_request_databuf(req, which, dbuf);
 	return 0;
 }
 EXPORT_SYMBOL(ceph_cls_assert_locked);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index e3152e21418f..7ce3aef55755 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -178,6 +178,16 @@ static void ceph_osd_iter_init(struct ceph_osd_data *osd_data,
 	osd_data->iter = *iter;
 }
 
+/*
+ * Consumes a ref on @dbuf.
+ */
+static void ceph_osd_databuf_init(struct ceph_osd_data *osd_data,
+				  struct ceph_databuf *dbuf)
+{
+	ceph_osd_iter_init(osd_data, &dbuf->iter);
+	osd_data->dbuf = dbuf;
+}
+
 static struct ceph_osd_data *
 osd_req_op_raw_data_in(struct ceph_osd_request *osd_req, unsigned int which)
 {
@@ -207,6 +217,17 @@ void osd_req_op_raw_data_in_pages(struct ceph_osd_request *osd_req,
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
@@ -297,6 +318,19 @@ static void osd_req_op_cls_request_info_pagelist(
 	ceph_osd_data_pagelist_init(osd_data, pagelist);
 }
 
+void osd_req_op_cls_request_databuf(struct ceph_osd_request *osd_req,
+				    unsigned int which,
+				    struct ceph_databuf *dbuf)
+{
+	struct ceph_osd_data *osd_data;
+
+	osd_data = osd_req_op_data(osd_req, which, cls, request_data);
+	ceph_osd_databuf_init(osd_data, dbuf);
+	osd_req->r_ops[which].cls.indata_len += dbuf->length;
+	osd_req->r_ops[which].indata_len += dbuf->length;
+}
+EXPORT_SYMBOL(osd_req_op_cls_request_databuf);
+
 void osd_req_op_cls_request_data_pagelist(
 			struct ceph_osd_request *osd_req,
 			unsigned int which, struct ceph_pagelist *pagelist)
@@ -342,6 +376,17 @@ void osd_req_op_cls_request_data_bvecs(struct ceph_osd_request *osd_req,
 }
 EXPORT_SYMBOL(osd_req_op_cls_request_data_bvecs);
 
+void osd_req_op_cls_response_databuf(struct ceph_osd_request *osd_req,
+				     unsigned int which,
+				     struct ceph_databuf *dbuf)
+{
+	struct ceph_osd_data *osd_data;
+
+	osd_data = osd_req_op_data(osd_req, which, cls, response_data);
+	ceph_osd_databuf_init(osd_data, dbuf);
+}
+EXPORT_SYMBOL(osd_req_op_cls_response_databuf);
+
 void osd_req_op_cls_response_data_pages(struct ceph_osd_request *osd_req,
 			unsigned int which, struct page **pages, u64 length,
 			u32 offset, bool pages_from_pool, bool own_pages)
@@ -5162,7 +5207,11 @@ EXPORT_SYMBOL(ceph_osdc_maybe_request_map);
  * Execute an OSD class method on an object.
  *
  * @flags: CEPH_OSD_FLAG_*
- * @resp_len: in/out param for reply length
+ * @response: Pointer to the storage descriptor for the reply or NULL.
+ *
+ * The size of the response buffer is set by the caller in @response->limit and
+ * the size of the response obtained is set in @response->length and
+ * @response->iter.count.
  */
 int ceph_osdc_call(struct ceph_osd_client *osdc,
 		   struct ceph_object_id *oid,
@@ -5170,7 +5219,7 @@ int ceph_osdc_call(struct ceph_osd_client *osdc,
 		   const char *class, const char *method,
 		   unsigned int flags,
 		   struct page *req_page, size_t req_len,
-		   struct page **resp_pages, size_t *resp_len)
+		   struct ceph_databuf *response)
 {
 	struct ceph_osd_request *req;
 	int ret;
@@ -5193,9 +5242,8 @@ int ceph_osdc_call(struct ceph_osd_client *osdc,
 	if (req_page)
 		osd_req_op_cls_request_data_pages(req, 0, &req_page, req_len,
 						  0, false, false);
-	if (resp_pages)
-		osd_req_op_cls_response_data_pages(req, 0, resp_pages,
-						   *resp_len, 0, false, false);
+	if (response)
+		osd_req_op_cls_response_databuf(req, 0, response);
 
 	ret = ceph_osdc_alloc_messages(req, GFP_NOIO);
 	if (ret)
@@ -5205,8 +5253,10 @@ int ceph_osdc_call(struct ceph_osd_client *osdc,
 	ret = ceph_osdc_wait_request(osdc, req);
 	if (ret >= 0) {
 		ret = req->r_ops[0].rval;
-		if (resp_pages)
-			*resp_len = req->r_ops[0].outdata_len;
+		if (response) {
+			response->length = req->r_ops[0].outdata_len;
+			response->iter.count = response->length;
+		}
 	}
 
 out_put_req:

