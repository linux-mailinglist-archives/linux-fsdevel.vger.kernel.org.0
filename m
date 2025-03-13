Return-Path: <linux-fsdevel+bounces-43965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9085CA605A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 00:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1987B3B91FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 23:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D7F202960;
	Thu, 13 Mar 2025 23:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="as+oGhMR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D57820103B
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 23:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908896; cv=none; b=fbndLiBkZNKgJxUhhztfWLY/4+tpD1Iw0KdkPG/vVv2OSCz/g6TXgj4c4wXCfjNva76yleHNliHL4poQ/WEOj0U35OTN9NO2oOig5JO8h99TN51658J46IJ3doarABuo7Zq9s4MZ8B4Kq54CuIgc/m5SqTEUnlyU90iuJaWY5p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908896; c=relaxed/simple;
	bh=he/7RSS57ErR9Pdlrnra8tsEUCVVvgw5j8gqeGK+bVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nb0VHMBJ7yd9xu99s0bLMGrGGL1Eh+MuN+iP+pg9lAvQoPmYsyESR+PhRJjsckDXuLmDp+OMar/IcMgp9xfsjAi4gEkjxjyYX05g+HOLHbMg6U12EFwu4KTadIjHXe3QcNbL78RQkAtfNf/DSI+Y1CHhP7/WAd25EkVILkHdtYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=as+oGhMR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gljeAmbGEXrIapBTZuehhzy5uTApUDeOQduXSt57X50=;
	b=as+oGhMRJC+R7x0Wjj4gJ9hSM7UQSm09sqSpTF4eKDxXNeVnNicX8p+EftpXmNRVMJcncF
	xxi24WnUe/GseCdWd0wO/D91+KpB8hI1nt2ko9OoE/0hECjUmEvta90cuueLpC4F0oJBUu
	EPMS7hIdQ6d3xczheb+BQerbCVJENlA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-7_Ni6y33Nf6FnGA1wSI2Og-1; Thu,
 13 Mar 2025 19:34:51 -0400
X-MC-Unique: 7_Ni6y33Nf6FnGA1wSI2Og-1
X-Mimecast-MFC-AGG-ID: 7_Ni6y33Nf6FnGA1wSI2Og_1741908890
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2853E19560B8;
	Thu, 13 Mar 2025 23:34:50 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DABF81801757;
	Thu, 13 Mar 2025 23:34:47 +0000 (UTC)
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
Subject: [RFC PATCH 16/35] libceph: Convert req_page of ceph_osdc_call() to ceph_databuf
Date: Thu, 13 Mar 2025 23:33:08 +0000
Message-ID: <20250313233341.1675324-17-dhowells@redhat.com>
In-Reply-To: <20250313233341.1675324-1-dhowells@redhat.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Convert the request data (req_page) of ceph_osdc_call() to ceph_databuf.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 drivers/block/rbd.c             | 53 +++++++++++-----------
 include/linux/ceph/osd_client.h |  2 +-
 net/ceph/cls_lock_client.c      | 78 ++++++++++++++++++---------------
 net/ceph/osd_client.c           | 25 ++---------
 4 files changed, 74 insertions(+), 84 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index dd22cea7ae89..ec09d578b0b0 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1789,7 +1789,7 @@ static int __rbd_object_map_load(struct rbd_device *rbd_dev)
 	rbd_object_map_name(rbd_dev, rbd_dev->spec->snap_id, &oid);
 	ret = ceph_osdc_call(osdc, &oid, &rbd_dev->header_oloc,
 			     "rbd", "object_map_load", CEPH_OSD_FLAG_READ,
-			     NULL, 0, reply);
+			     NULL, reply);
 	if (ret)
 		goto out;
 
@@ -4553,8 +4553,8 @@ static int rbd_obj_method_sync(struct rbd_device *rbd_dev,
 			     size_t inbound_size)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
-	struct ceph_databuf *reply;
-	struct page *req_page = NULL;
+	struct ceph_databuf *request = NULL, *reply;
+	void *p;
 	int ret;
 
 	/*
@@ -4568,32 +4568,33 @@ static int rbd_obj_method_sync(struct rbd_device *rbd_dev,
 		if (outbound_size > PAGE_SIZE)
 			return -E2BIG;
 
-		req_page = alloc_page(GFP_KERNEL);
-		if (!req_page)
+		request = ceph_databuf_req_alloc(0, outbound_size, GFP_KERNEL);
+		if (!request)
 			return -ENOMEM;
 
-		memcpy(page_address(req_page), outbound, outbound_size);
+		p = kmap_ceph_databuf_page(request, 0);
+		memcpy(p, outbound, outbound_size);
+		kunmap_local(p);
+		ceph_databuf_added_data(request, outbound_size);
 	}
 
 	reply = ceph_databuf_reply_alloc(1, inbound_size, GFP_KERNEL);
 	if (!reply) {
-		if (req_page)
-			__free_page(req_page);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out;
 	}
 
 	ret = ceph_osdc_call(osdc, oid, oloc, RBD_DRV_NAME, method_name,
-			     CEPH_OSD_FLAG_READ, req_page, outbound_size,
-			     reply);
+			     CEPH_OSD_FLAG_READ, request, reply);
 	if (!ret) {
 		ret = ceph_databuf_len(reply);
 		if (copy_from_iter(inbound, ret, &reply->iter) != ret)
 			ret = -EIO;
 	}
 
-	if (req_page)
-		__free_page(req_page);
 	ceph_databuf_release(reply);
+out:
+	ceph_databuf_release(request);
 	return ret;
 }
 
@@ -5513,7 +5514,7 @@ static int decode_parent_image_spec(void **p, void *end,
 }
 
 static int __get_parent_info(struct rbd_device *rbd_dev,
-			     struct page *req_page,
+			     struct ceph_databuf *request,
 			     struct ceph_databuf *reply,
 			     struct parent_image_info *pii)
 {
@@ -5524,7 +5525,7 @@ static int __get_parent_info(struct rbd_device *rbd_dev,
 
 	ret = ceph_osdc_call(osdc, &rbd_dev->header_oid, &rbd_dev->header_oloc,
 			     "rbd", "parent_get", CEPH_OSD_FLAG_READ,
-			     req_page, sizeof(u64), reply);
+			     request, reply);
 	if (ret)
 		return ret == -EOPNOTSUPP ? 1 : ret;
 
@@ -5539,7 +5540,7 @@ static int __get_parent_info(struct rbd_device *rbd_dev,
 
 	ret = ceph_osdc_call(osdc, &rbd_dev->header_oid, &rbd_dev->header_oloc,
 			     "rbd", "parent_overlap_get", CEPH_OSD_FLAG_READ,
-			     req_page, sizeof(u64), reply);
+			     request, reply);
 	if (ret)
 		return ret;
 
@@ -5563,7 +5564,7 @@ static int __get_parent_info(struct rbd_device *rbd_dev,
  * The caller is responsible for @pii.
  */
 static int __get_parent_info_legacy(struct rbd_device *rbd_dev,
-				    struct page *req_page,
+				    struct ceph_databuf *request,
 				    struct ceph_databuf *reply,
 				    struct parent_image_info *pii)
 {
@@ -5573,7 +5574,7 @@ static int __get_parent_info_legacy(struct rbd_device *rbd_dev,
 
 	ret = ceph_osdc_call(osdc, &rbd_dev->header_oid, &rbd_dev->header_oloc,
 			     "rbd", "get_parent", CEPH_OSD_FLAG_READ,
-			     req_page, sizeof(u64), reply);
+			     request, reply);
 	if (ret)
 		return ret;
 
@@ -5604,29 +5605,29 @@ static int __get_parent_info_legacy(struct rbd_device *rbd_dev,
 static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev,
 				  struct parent_image_info *pii)
 {
-	struct ceph_databuf *reply;
-	struct page *req_page;
+	struct ceph_databuf *request, *reply;
 	void *p;
 	int ret = -ENOMEM;
 
-	req_page = alloc_page(GFP_KERNEL);
-	if (!req_page)
+	request = ceph_databuf_req_alloc(0, sizeof(__le64), GFP_KERNEL);
+	if (!request)
 		goto out;
 
 	reply = ceph_databuf_reply_alloc(1, PAGE_SIZE, GFP_KERNEL);
 	if (!reply)
 		goto out_free;
 
-	p = kmap_local_page(req_page);
+	p = kmap_ceph_databuf_page(request, 0);
 	ceph_encode_64(&p, rbd_dev->spec->snap_id);
 	kunmap_local(p);
-	ret = __get_parent_info(rbd_dev, req_page, reply, pii);
+	ceph_databuf_added_data(request, sizeof(__le64));
+	ret = __get_parent_info(rbd_dev, request, reply, pii);
 	if (ret > 0)
-		ret = __get_parent_info_legacy(rbd_dev, req_page, reply, pii);
+		ret = __get_parent_info_legacy(rbd_dev, request, reply, pii);
 
 	ceph_databuf_release(reply);
 out_free:
-	__free_page(req_page);
+	ceph_databuf_release(request);
 out:
 	return ret;
 }
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 9182aa5075b2..d31e59bd128c 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -568,7 +568,7 @@ int ceph_osdc_call(struct ceph_osd_client *osdc,
 		   struct ceph_object_locator *oloc,
 		   const char *class, const char *method,
 		   unsigned int flags,
-		   struct page *req_page, size_t req_len,
+		   struct ceph_databuf *request,
 		   struct ceph_databuf *response);
 
 /* watch/notify */
diff --git a/net/ceph/cls_lock_client.c b/net/ceph/cls_lock_client.c
index 37bb8708e8bb..6c8608aabe5f 100644
--- a/net/ceph/cls_lock_client.c
+++ b/net/ceph/cls_lock_client.c
@@ -34,7 +34,7 @@ int ceph_cls_lock(struct ceph_osd_client *osdc,
 	int tag_len = strlen(tag);
 	int desc_len = strlen(desc);
 	void *p, *end;
-	struct page *lock_op_page;
+	struct ceph_databuf *lock_op_req;
 	struct timespec64 mtime;
 	int ret;
 
@@ -49,11 +49,11 @@ int ceph_cls_lock(struct ceph_osd_client *osdc,
 	if (lock_op_buf_size > PAGE_SIZE)
 		return -E2BIG;
 
-	lock_op_page = alloc_page(GFP_NOIO);
-	if (!lock_op_page)
+	lock_op_req = ceph_databuf_req_alloc(0, lock_op_buf_size, GFP_NOIO);
+	if (!lock_op_req)
 		return -ENOMEM;
 
-	p = page_address(lock_op_page);
+	p = kmap_ceph_databuf_page(lock_op_req, 0);
 	end = p + lock_op_buf_size;
 
 	/* encode cls_lock_lock_op struct */
@@ -69,15 +69,16 @@ int ceph_cls_lock(struct ceph_osd_client *osdc,
 	ceph_encode_timespec64(p, &mtime);
 	p += sizeof(struct ceph_timespec);
 	ceph_encode_8(&p, flags);
+	kunmap_local(p);
+	ceph_databuf_added_data(lock_op_req, lock_op_buf_size);
 
 	dout("%s lock_name %s type %d cookie %s tag %s desc %s flags 0x%x\n",
 	     __func__, lock_name, type, cookie, tag, desc, flags);
 	ret = ceph_osdc_call(osdc, oid, oloc, "lock", "lock",
-			     CEPH_OSD_FLAG_WRITE, lock_op_page,
-			     lock_op_buf_size, NULL);
+			     CEPH_OSD_FLAG_WRITE, lock_op_req, NULL);
 
 	dout("%s: status %d\n", __func__, ret);
-	__free_page(lock_op_page);
+	ceph_databuf_release(lock_op_req);
 	return ret;
 }
 EXPORT_SYMBOL(ceph_cls_lock);
@@ -99,7 +100,7 @@ int ceph_cls_unlock(struct ceph_osd_client *osdc,
 	int name_len = strlen(lock_name);
 	int cookie_len = strlen(cookie);
 	void *p, *end;
-	struct page *unlock_op_page;
+	struct ceph_databuf *unlock_op_req;
 	int ret;
 
 	unlock_op_buf_size = name_len + sizeof(__le32) +
@@ -108,11 +109,11 @@ int ceph_cls_unlock(struct ceph_osd_client *osdc,
 	if (unlock_op_buf_size > PAGE_SIZE)
 		return -E2BIG;
 
-	unlock_op_page = alloc_page(GFP_NOIO);
-	if (!unlock_op_page)
+	unlock_op_req = ceph_databuf_req_alloc(0, unlock_op_buf_size, GFP_NOIO);
+	if (!unlock_op_req)
 		return -ENOMEM;
 
-	p = page_address(unlock_op_page);
+	p = kmap_ceph_databuf_page(unlock_op_req, 0);
 	end = p + unlock_op_buf_size;
 
 	/* encode cls_lock_unlock_op struct */
@@ -120,14 +121,15 @@ int ceph_cls_unlock(struct ceph_osd_client *osdc,
 			    unlock_op_buf_size - CEPH_ENCODING_START_BLK_LEN);
 	ceph_encode_string(&p, end, lock_name, name_len);
 	ceph_encode_string(&p, end, cookie, cookie_len);
+	kunmap_local(p);
+	ceph_databuf_added_data(unlock_op_req, unlock_op_buf_size);
 
 	dout("%s lock_name %s cookie %s\n", __func__, lock_name, cookie);
 	ret = ceph_osdc_call(osdc, oid, oloc, "lock", "unlock",
-			     CEPH_OSD_FLAG_WRITE, unlock_op_page,
-			     unlock_op_buf_size, NULL);
+			     CEPH_OSD_FLAG_WRITE, unlock_op_req, NULL);
 
 	dout("%s: status %d\n", __func__, ret);
-	__free_page(unlock_op_page);
+	ceph_databuf_release(unlock_op_req);
 	return ret;
 }
 EXPORT_SYMBOL(ceph_cls_unlock);
@@ -150,7 +152,7 @@ int ceph_cls_break_lock(struct ceph_osd_client *osdc,
 	int break_op_buf_size;
 	int name_len = strlen(lock_name);
 	int cookie_len = strlen(cookie);
-	struct page *break_op_page;
+	struct ceph_databuf *break_op_req;
 	void *p, *end;
 	int ret;
 
@@ -161,11 +163,11 @@ int ceph_cls_break_lock(struct ceph_osd_client *osdc,
 	if (break_op_buf_size > PAGE_SIZE)
 		return -E2BIG;
 
-	break_op_page = alloc_page(GFP_NOIO);
-	if (!break_op_page)
+	break_op_req = ceph_databuf_req_alloc(0, break_op_buf_size, GFP_NOIO);
+	if (!break_op_req)
 		return -ENOMEM;
 
-	p = page_address(break_op_page);
+	p = kmap_ceph_databuf_page(break_op_req, 0);
 	end = p + break_op_buf_size;
 
 	/* encode cls_lock_break_op struct */
@@ -174,15 +176,16 @@ int ceph_cls_break_lock(struct ceph_osd_client *osdc,
 	ceph_encode_string(&p, end, lock_name, name_len);
 	ceph_encode_copy(&p, locker, sizeof(*locker));
 	ceph_encode_string(&p, end, cookie, cookie_len);
+	kunmap_local(p);
+	ceph_databuf_added_data(break_op_req, break_op_buf_size);
 
 	dout("%s lock_name %s cookie %s locker %s%llu\n", __func__, lock_name,
 	     cookie, ENTITY_NAME(*locker));
 	ret = ceph_osdc_call(osdc, oid, oloc, "lock", "break_lock",
-			     CEPH_OSD_FLAG_WRITE, break_op_page,
-			     break_op_buf_size, NULL);
+			     CEPH_OSD_FLAG_WRITE, break_op_req, NULL);
 
 	dout("%s: status %d\n", __func__, ret);
-	__free_page(break_op_page);
+	ceph_databuf_release(break_op_req);
 	return ret;
 }
 EXPORT_SYMBOL(ceph_cls_break_lock);
@@ -199,7 +202,7 @@ int ceph_cls_set_cookie(struct ceph_osd_client *osdc,
 	int tag_len = strlen(tag);
 	int new_cookie_len = strlen(new_cookie);
 	void *p, *end;
-	struct page *cookie_op_page;
+	struct ceph_databuf *cookie_op_req;
 	int ret;
 
 	cookie_op_buf_size = name_len + sizeof(__le32) +
@@ -210,11 +213,11 @@ int ceph_cls_set_cookie(struct ceph_osd_client *osdc,
 	if (cookie_op_buf_size > PAGE_SIZE)
 		return -E2BIG;
 
-	cookie_op_page = alloc_page(GFP_NOIO);
-	if (!cookie_op_page)
+	cookie_op_req = ceph_databuf_req_alloc(0, cookie_op_buf_size, GFP_NOIO);
+	if (!cookie_op_req)
 		return -ENOMEM;
 
-	p = page_address(cookie_op_page);
+	p = kmap_ceph_databuf_page(cookie_op_req, 0);
 	end = p + cookie_op_buf_size;
 
 	/* encode cls_lock_set_cookie_op struct */
@@ -225,15 +228,16 @@ int ceph_cls_set_cookie(struct ceph_osd_client *osdc,
 	ceph_encode_string(&p, end, old_cookie, old_cookie_len);
 	ceph_encode_string(&p, end, tag, tag_len);
 	ceph_encode_string(&p, end, new_cookie, new_cookie_len);
+	kunmap_local(p);
+	ceph_databuf_added_data(cookie_op_req, cookie_op_buf_size);
 
 	dout("%s lock_name %s type %d old_cookie %s tag %s new_cookie %s\n",
 	     __func__, lock_name, type, old_cookie, tag, new_cookie);
 	ret = ceph_osdc_call(osdc, oid, oloc, "lock", "set_cookie",
-			     CEPH_OSD_FLAG_WRITE, cookie_op_page,
-			     cookie_op_buf_size, NULL);
+			     CEPH_OSD_FLAG_WRITE, cookie_op_req, NULL);
 
 	dout("%s: status %d\n", __func__, ret);
-	__free_page(cookie_op_page);
+	ceph_databuf_release(cookie_op_req);
 	return ret;
 }
 EXPORT_SYMBOL(ceph_cls_set_cookie);
@@ -340,7 +344,7 @@ int ceph_cls_lock_info(struct ceph_osd_client *osdc,
 	struct ceph_databuf *reply;
 	int get_info_op_buf_size;
 	int name_len = strlen(lock_name);
-	struct page *get_info_op_page;
+	struct ceph_databuf *get_info_op_req;
 	void *p, *end;
 	int ret;
 
@@ -349,28 +353,30 @@ int ceph_cls_lock_info(struct ceph_osd_client *osdc,
 	if (get_info_op_buf_size > PAGE_SIZE)
 		return -E2BIG;
 
-	get_info_op_page = alloc_page(GFP_NOIO);
-	if (!get_info_op_page)
+	get_info_op_req = ceph_databuf_req_alloc(0, get_info_op_buf_size,
+						 GFP_NOIO);
+	if (!get_info_op_req)
 		return -ENOMEM;
 
 	reply = ceph_databuf_reply_alloc(1, PAGE_SIZE, GFP_NOIO);
 	if (!reply) {
-		__free_page(get_info_op_page);
+		ceph_databuf_release(get_info_op_req);
 		return -ENOMEM;
 	}
 
-	p = page_address(get_info_op_page);
+	p = kmap_ceph_databuf_page(get_info_op_req, 0);
 	end = p + get_info_op_buf_size;
 
 	/* encode cls_lock_get_info_op struct */
 	ceph_start_encoding(&p, 1, 1,
 			    get_info_op_buf_size - CEPH_ENCODING_START_BLK_LEN);
 	ceph_encode_string(&p, end, lock_name, name_len);
+	kunmap_local(p);
+	ceph_databuf_added_data(get_info_op_req, get_info_op_buf_size);
 
 	dout("%s lock_name %s\n", __func__, lock_name);
 	ret = ceph_osdc_call(osdc, oid, oloc, "lock", "get_info",
-			     CEPH_OSD_FLAG_READ, get_info_op_page,
-			     get_info_op_buf_size, reply);
+			     CEPH_OSD_FLAG_READ, get_info_op_req, reply);
 
 	dout("%s: status %d\n", __func__, ret);
 	if (ret >= 0) {
@@ -381,8 +387,8 @@ int ceph_cls_lock_info(struct ceph_osd_client *osdc,
 		kunmap_local(p);
 	}
 
-	__free_page(get_info_op_page);
 	ceph_databuf_release(reply);
+	ceph_databuf_release(get_info_op_req);
 	return ret;
 }
 EXPORT_SYMBOL(ceph_cls_lock_info);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 405ccf7e7a91..c4525feb8e26 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -264,7 +264,7 @@ void osd_req_op_cls_request_databuf(struct ceph_osd_request *osd_req,
 	BUG_ON(!ceph_databuf_len(dbuf));
 
 	osd_data = osd_req_op_data(osd_req, which, cls, request_data);
-	ceph_osd_databuf_init(osd_data, dbuf);
+	ceph_osd_databuf_init(osd_data, ceph_databuf_get(dbuf));
 	osd_req->r_ops[which].cls.indata_len += ceph_databuf_len(dbuf);
 	osd_req->r_ops[which].indata_len += ceph_databuf_len(dbuf);
 }
@@ -283,19 +283,6 @@ void osd_req_op_cls_request_data_pagelist(
 }
 EXPORT_SYMBOL(osd_req_op_cls_request_data_pagelist);
 
-static void osd_req_op_cls_request_data_pages(struct ceph_osd_request *osd_req,
-			unsigned int which, struct page **pages, u64 length,
-			u32 offset, bool pages_from_pool, bool own_pages)
-{
-	struct ceph_osd_data *osd_data;
-
-	osd_data = osd_req_op_data(osd_req, which, cls, request_data);
-	ceph_osd_data_pages_init(osd_data, pages, length, offset,
-				pages_from_pool, own_pages);
-	osd_req->r_ops[which].cls.indata_len += length;
-	osd_req->r_ops[which].indata_len += length;
-}
-
 void osd_req_op_cls_response_databuf(struct ceph_osd_request *osd_req,
 				     unsigned int which,
 				     struct ceph_databuf *dbuf)
@@ -5089,15 +5076,12 @@ int ceph_osdc_call(struct ceph_osd_client *osdc,
 		   struct ceph_object_locator *oloc,
 		   const char *class, const char *method,
 		   unsigned int flags,
-		   struct page *req_page, size_t req_len,
+		   struct ceph_databuf *request,
 		   struct ceph_databuf *response)
 {
 	struct ceph_osd_request *req;
 	int ret;
 
-	if (req_len > PAGE_SIZE)
-		return -E2BIG;
-
 	req = ceph_osdc_alloc_request(osdc, NULL, 1, false, GFP_NOIO);
 	if (!req)
 		return -ENOMEM;
@@ -5110,9 +5094,8 @@ int ceph_osdc_call(struct ceph_osd_client *osdc,
 	if (ret)
 		goto out_put_req;
 
-	if (req_page)
-		osd_req_op_cls_request_data_pages(req, 0, &req_page, req_len,
-						  0, false, false);
+	if (request)
+		osd_req_op_cls_request_databuf(req, 0, request);
 	if (response)
 		osd_req_op_cls_response_databuf(req, 0, response);
 


