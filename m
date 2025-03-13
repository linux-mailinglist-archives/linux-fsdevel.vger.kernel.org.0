Return-Path: <linux-fsdevel+bounces-43956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 154EEA60583
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 00:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C13927ABA8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 23:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D4C1FE474;
	Thu, 13 Mar 2025 23:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jT8cyZkb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E497A1FE457
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 23:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908865; cv=none; b=L1x5sFF5EFAY3xp3Ico0FvvLQCCP7pvkJ2pWf4fBFUxQfNLDEiLqZbQk5kCnp6FDUIWzkk3OU5Kcl960TPxutND96SKwREgvSElts/rKOG3yLlsjHSYugN4eZ9dQQ+rORneVCvbFyK2eB1SWbl/i4iKYCZhD0IFGa/p6FOyAndE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908865; c=relaxed/simple;
	bh=bwe/S77ac/IcKSf788j9Gz7zL6r2dfqzSqkEQJt+8uI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hvl9Q2ZGqaIVxo47j7dZE6s7FTXUILkE5YiPBceDxkPyGGh46pnv1CP9SsLHA3A0NcVpxAnO3S1UdxcC7trHaaajkqc2IbxDxtyuBbxe2AQentqZzBzd7oU14xbzvJgJ3NjEoD8WY0Ar7Ox2FYKxgVW5+6TSk9PRn4dHZFVpuBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jT8cyZkb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AV19c3X2FlLGAowb4crJkltgoZbDv9HiTi9WKc6v+8Q=;
	b=jT8cyZkbYu8rjvceogqUhh7PWbJMxnIuKOhFKryG4gzAxpYzNEeUVSgp5cekdfa2EG+mRG
	05AxhZPQq24vgjRPM2NIKQpU2VJwIj24Agch3Crt6emXWSXktJHkVl3LNUctCVBwuXVMck
	UizN2pMMilw4KRvUmcs4XuNmhPOZlz4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-qbPPz8w_M2-xTacEKN5Bbg-1; Thu,
 13 Mar 2025 19:34:18 -0400
X-MC-Unique: qbPPz8w_M2-xTacEKN5Bbg-1
X-Mimecast-MFC-AGG-ID: qbPPz8w_M2-xTacEKN5Bbg_1741908857
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 418FB1956046;
	Thu, 13 Mar 2025 23:34:17 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C3CC11978F5D;
	Thu, 13 Mar 2025 23:34:14 +0000 (UTC)
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
Subject: [RFC PATCH 07/35] libceph: Change ceph_osdc_call()'s reply to a ceph_databuf
Date: Thu, 13 Mar 2025 23:32:59 +0000
Message-ID: <20250313233341.1675324-8-dhowells@redhat.com>
In-Reply-To: <20250313233341.1675324-1-dhowells@redhat.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Change the type of ceph_osdc_call()'s reply to a ceph_databuf struct rather
than a list of pages and access it with kmap_local rather than
page_address().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 drivers/block/rbd.c             | 135 ++++++++++++++++++--------------
 include/linux/ceph/osd_client.h |   2 +-
 net/ceph/cls_lock_client.c      |  41 +++++-----
 net/ceph/osd_client.c           |  16 ++--
 4 files changed, 109 insertions(+), 85 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index bb953634c7cb..073e80d2d966 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1826,9 +1826,8 @@ static int __rbd_object_map_load(struct rbd_device *rbd_dev)
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
@@ -1842,48 +1841,57 @@ static int __rbd_object_map_load(struct rbd_device *rbd_dev)
 	object_map_bytes = DIV_ROUND_UP_ULL(num_objects * BITS_PER_OBJ,
 					    BITS_PER_BYTE);
 	num_pages = calc_pages_for(0, object_map_bytes) + 1;
-	pages = ceph_alloc_page_vector(num_pages, GFP_KERNEL);
-	if (IS_ERR(pages))
-		return PTR_ERR(pages);
 
-	reply_len = num_pages * PAGE_SIZE;
+	reply = ceph_databuf_reply_alloc(num_pages, num_pages * PAGE_SIZE,
+					 GFP_KERNEL);
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
+	end = p + min(ceph_databuf_len(reply), (size_t)PAGE_SIZE);
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
+	if (object_map_bytes > ceph_databuf_len(reply)) {
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
 
@@ -1952,6 +1960,7 @@ static int rbd_object_map_update_finish(struct rbd_obj_request *obj_req,
 {
 	struct rbd_device *rbd_dev = obj_req->img_request->rbd_dev;
 	struct ceph_osd_data *osd_data;
+	struct ceph_databuf *dbuf;
 	u64 objno;
 	u8 state, new_state, current_state;
 	bool has_current_state;
@@ -1971,9 +1980,10 @@ static int rbd_object_map_update_finish(struct rbd_obj_request *obj_req,
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
@@ -1981,6 +1991,7 @@ static int rbd_object_map_update_finish(struct rbd_obj_request *obj_req,
 	has_current_state = ceph_decode_8(&p);
 	if (has_current_state)
 		current_state = ceph_decode_8(&p);
+	kunmap_local(p);
 
 	spin_lock(&rbd_dev->object_map_lock);
 	state = __rbd_object_map_get(rbd_dev, objno);
@@ -2020,7 +2031,7 @@ static int rbd_cls_object_map_update(struct ceph_osd_request *req,
 				     int which, u64 objno, u8 new_state,
 				     const u8 *current_state)
 {
-	struct page **pages;
+	struct ceph_databuf *dbuf;
 	void *p, *start;
 	int ret;
 
@@ -2028,11 +2039,11 @@ static int rbd_cls_object_map_update(struct ceph_osd_request *req,
 	if (ret)
 		return ret;
 
-	pages = ceph_alloc_page_vector(1, GFP_NOIO);
-	if (IS_ERR(pages))
-		return PTR_ERR(pages);
+	dbuf = ceph_databuf_req_alloc(1, PAGE_SIZE, GFP_NOIO);
+	if (!dbuf)
+		return -ENOMEM;
 
-	p = start = page_address(pages[0]);
+	p = start = kmap_ceph_databuf_page(dbuf, 0);
 	ceph_encode_64(&p, objno);
 	ceph_encode_64(&p, objno + 1);
 	ceph_encode_8(&p, new_state);
@@ -2042,9 +2053,10 @@ static int rbd_cls_object_map_update(struct ceph_osd_request *req,
 	} else {
 		ceph_encode_8(&p, 0);
 	}
+	kunmap_local(p);
+	ceph_databuf_added_data(dbuf, p - start);
 
-	osd_req_op_cls_request_data_pages(req, which, pages, p - start, 0,
-					  false, true);
+	osd_req_op_cls_request_databuf(req, which, dbuf);
 	return 0;
 }
 
@@ -4673,8 +4685,8 @@ static int rbd_obj_method_sync(struct rbd_device *rbd_dev,
 			     size_t inbound_size)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
+	struct ceph_databuf *reply;
 	struct page *req_page = NULL;
-	struct page *reply_page;
 	int ret;
 
 	/*
@@ -4695,8 +4707,8 @@ static int rbd_obj_method_sync(struct rbd_device *rbd_dev,
 		memcpy(page_address(req_page), outbound, outbound_size);
 	}
 
-	reply_page = alloc_page(GFP_KERNEL);
-	if (!reply_page) {
+	reply = ceph_databuf_reply_alloc(1, inbound_size, GFP_KERNEL);
+	if (!reply) {
 		if (req_page)
 			__free_page(req_page);
 		return -ENOMEM;
@@ -4704,15 +4716,16 @@ static int rbd_obj_method_sync(struct rbd_device *rbd_dev,
 
 	ret = ceph_osdc_call(osdc, oid, oloc, RBD_DRV_NAME, method_name,
 			     CEPH_OSD_FLAG_READ, req_page, outbound_size,
-			     &reply_page, &inbound_size);
+			     reply);
 	if (!ret) {
-		memcpy(inbound, page_address(reply_page), inbound_size);
-		ret = inbound_size;
+		ret = ceph_databuf_len(reply);
+		if (copy_from_iter(inbound, ret, &reply->iter) != ret)
+			ret = -EIO;
 	}
 
 	if (req_page)
 		__free_page(req_page);
-	__free_page(reply_page);
+	ceph_databuf_release(reply);
 	return ret;
 }
 
@@ -5633,7 +5646,7 @@ static int decode_parent_image_spec(void **p, void *end,
 
 static int __get_parent_info(struct rbd_device *rbd_dev,
 			     struct page *req_page,
-			     struct page *reply_page,
+			     struct ceph_databuf *reply,
 			     struct parent_image_info *pii)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
@@ -5643,27 +5656,31 @@ static int __get_parent_info(struct rbd_device *rbd_dev,
 
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
 
+	ceph_databuf_reset_reply(reply);
+
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
 
 	dout("%s pool_id %llu pool_ns %s image_id %s snap_id %llu has_overlap %d overlap %llu\n",
 	     __func__, pii->pool_id, pii->pool_ns, pii->image_id, pii->snap_id,
@@ -5679,25 +5696,25 @@ static int __get_parent_info(struct rbd_device *rbd_dev,
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
+	end = p + ceph_databuf_len(reply);
 	ceph_decode_64_safe(&p, end, pii->pool_id, e_inval);
 	pii->image_id = ceph_extract_encoded_string(&p, end, NULL, GFP_KERNEL);
 	if (IS_ERR(pii->image_id)) {
+		kunmap_local(p);
 		ret = PTR_ERR(pii->image_id);
 		pii->image_id = NULL;
 		return ret;
@@ -5705,6 +5722,7 @@ static int __get_parent_info_legacy(struct rbd_device *rbd_dev,
 	ceph_decode_64_safe(&p, end, pii->snap_id, e_inval);
 	pii->has_overlap = true;
 	ceph_decode_64_safe(&p, end, pii->overlap, e_inval);
+	kunmap_local(p);
 
 	dout("%s pool_id %llu pool_ns %s image_id %s snap_id %llu has_overlap %d overlap %llu\n",
 	     __func__, pii->pool_id, pii->pool_ns, pii->image_id, pii->snap_id,
@@ -5718,29 +5736,30 @@ static int __get_parent_info_legacy(struct rbd_device *rbd_dev,
 static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev,
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
+	reply = ceph_databuf_reply_alloc(1, PAGE_SIZE, GFP_KERNEL);
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
index 172ee515a0f3..57b8aff53f28 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -610,7 +610,7 @@ int ceph_osdc_call(struct ceph_osd_client *osdc,
 		   const char *class, const char *method,
 		   unsigned int flags,
 		   struct page *req_page, size_t req_len,
-		   struct page **resp_pages, size_t *resp_len);
+		   struct ceph_databuf *response);
 
 /* watch/notify */
 struct ceph_osd_linger_request *
diff --git a/net/ceph/cls_lock_client.c b/net/ceph/cls_lock_client.c
index 66136a4c1ce7..37bb8708e8bb 100644
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
+	reply = ceph_databuf_reply_alloc(1, PAGE_SIZE, GFP_NOIO);
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
+		end = p + ceph_databuf_len(reply);
 
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
+	dbuf = ceph_databuf_req_alloc(1, PAGE_SIZE, GFP_NOIO);
+	if (!dbuf)
+		return -ENOMEM;
 
-	p = page_address(pages[0]);
+	p = kmap_ceph_databuf_page(dbuf, 0);
 	end = p + assert_op_buf_size;
 
 	/* encode cls_lock_assert_op struct */
@@ -422,10 +423,12 @@ int ceph_cls_assert_locked(struct ceph_osd_request *req, int which,
 	ceph_encode_8(&p, type);
 	ceph_encode_string(&p, end, cookie, cookie_len);
 	ceph_encode_string(&p, end, tag, tag_len);
+	kunmap(p);
 	WARN_ON(p != end);
+	ceph_databuf_added_data(dbuf, assert_op_buf_size);
 
-	osd_req_op_cls_request_data_pages(req, which, pages, assert_op_buf_size,
-					  0, false, true);
+	osd_req_op_cls_request_databuf(req, which, dbuf);
 	return 0;
 }
 EXPORT_SYMBOL(ceph_cls_assert_locked);
+
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 720d8a605fc4..b6cf875d3de4 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -5195,7 +5195,10 @@ EXPORT_SYMBOL(ceph_osdc_maybe_request_map);
  * Execute an OSD class method on an object.
  *
  * @flags: CEPH_OSD_FLAG_*
- * @resp_len: in/out param for reply length
+ * @response: Pointer to the storage descriptor for the reply or NULL.
+ *
+ * The size of the response buffer is set by the caller in @response->limit and
+ * the size of the response obtained is set in @response->iter.
  */
 int ceph_osdc_call(struct ceph_osd_client *osdc,
 		   struct ceph_object_id *oid,
@@ -5203,7 +5206,7 @@ int ceph_osdc_call(struct ceph_osd_client *osdc,
 		   const char *class, const char *method,
 		   unsigned int flags,
 		   struct page *req_page, size_t req_len,
-		   struct page **resp_pages, size_t *resp_len)
+		   struct ceph_databuf *response)
 {
 	struct ceph_osd_request *req;
 	int ret;
@@ -5226,9 +5229,8 @@ int ceph_osdc_call(struct ceph_osd_client *osdc,
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
@@ -5238,8 +5240,8 @@ int ceph_osdc_call(struct ceph_osd_client *osdc,
 	ret = ceph_osdc_wait_request(osdc, req);
 	if (ret >= 0) {
 		ret = req->r_ops[0].rval;
-		if (resp_pages)
-			*resp_len = req->r_ops[0].outdata_len;
+		if (response)
+			ceph_databuf_reply_ready(response, req->r_ops[0].outdata_len);
 	}
 
 out_put_req:


