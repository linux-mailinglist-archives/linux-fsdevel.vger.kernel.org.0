Return-Path: <linux-fsdevel+bounces-43972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B94A605D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 00:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01FC7881826
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 23:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A11205ABB;
	Thu, 13 Mar 2025 23:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ThBN+6Eq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD71204F94
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 23:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908924; cv=none; b=UHvfXBfSWbjrmJ9xP4u6DR2Je7Tit7cMRPU16aYkq/P5bfvZssE9fKEOJRhGUnov5VV08p58ntkgtnR4EEcGerWAwcyglEmsHFns8n2dfvLEDImqw34ebiy02saXK1rwnPpZaBR4He+grIukWKLiW+p5o4Fm61o5dKBMiV/DXAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908924; c=relaxed/simple;
	bh=E2/FfSQEVeXizQhNicf4rR6freuOTQONEexZxKOIxUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FF8Ret0DogudrXSgRc9LPBBEZVny5DEbnPKiAANi8pwj1RdWH26IIv0RUfYfAeaQAYNu8n2uClzv4+MFHuS5G9pGr+NIPtJf0RdEu8onVMsmhFPeQrN/VtQnlDUhlhngyjJKtRzi0JJ7b4L5bLgNVov40RemeCqEfR3c5XDA6nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ThBN+6Eq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ateNCwwhc3gg0uYNIgkikIKVmAOxANHfCT4U4GJyDlA=;
	b=ThBN+6EqWMtDTOIdsDtOZhjeG23IN+7jn6srvatAMHo23B223/auyYTuN4AkvmimczVk95
	H/xN1KE+d+/gaGjaEGthtj0cBYlU7m4L657afpryosHuOncruz/YnuXgaGMNQPN7LV0FMg
	NZXl+TtnHDLXzNjt4JvUgZlQh110OG0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-zdgi842RPDOkS6X_NwWd3w-1; Thu,
 13 Mar 2025 19:35:17 -0400
X-MC-Unique: zdgi842RPDOkS6X_NwWd3w-1
X-Mimecast-MFC-AGG-ID: zdgi842RPDOkS6X_NwWd3w_1741908916
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 188EE1800257;
	Thu, 13 Mar 2025 23:35:16 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BEFA01828A93;
	Thu, 13 Mar 2025 23:35:13 +0000 (UTC)
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
Subject: [RFC PATCH 23/35] rbd: Use ceph_databuf_enc_start/stop()
Date: Thu, 13 Mar 2025 23:33:15 +0000
Message-ID: <20250313233341.1675324-24-dhowells@redhat.com>
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

Make rbd use ceph_databuf_enc_start() and ceph_databuf_enc_stop() when
filling out the request data.  Also use ceph_encode_*() rather than
ceph_databuf_encode_*() as the latter will do an iterator copy to deal with
page crossing and misalignment (the latter being something that the CPU
will handle on some arches).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 drivers/block/rbd.c | 64 ++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index a2674077edea..956fc4a8f1da 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1970,19 +1970,19 @@ static int rbd_cls_object_map_update(struct ceph_osd_request *req,
 				     int which, u64 objno, u8 new_state,
 				     const u8 *current_state)
 {
-	struct ceph_databuf *dbuf;
-	void *p, *start;
+	struct ceph_databuf *request;
+	void *p;
 	int ret;
 
 	ret = osd_req_op_cls_init(req, which, "rbd", "object_map_update");
 	if (ret)
 		return ret;
 
-	dbuf = ceph_databuf_req_alloc(1, PAGE_SIZE, GFP_NOIO);
-	if (!dbuf)
+	request = ceph_databuf_req_alloc(1, 8 * 2 + 3 * 1, GFP_NOIO);
+	if (!request)
 		return -ENOMEM;
 
-	p = start = kmap_ceph_databuf_page(dbuf, 0);
+	p = ceph_databuf_enc_start(request);
 	ceph_encode_64(&p, objno);
 	ceph_encode_64(&p, objno + 1);
 	ceph_encode_8(&p, new_state);
@@ -1992,10 +1992,9 @@ static int rbd_cls_object_map_update(struct ceph_osd_request *req,
 	} else {
 		ceph_encode_8(&p, 0);
 	}
-	kunmap_local(p);
-	ceph_databuf_added_data(dbuf, p - start);
+	ceph_databuf_enc_stop(request, p);
 
-	osd_req_op_cls_request_databuf(req, which, dbuf);
+	osd_req_op_cls_request_databuf(req, which, request);
 	return 0;
 }
 
@@ -2108,7 +2107,7 @@ static int rbd_obj_calc_img_extents(struct rbd_obj_request *obj_req,
 
 static int rbd_osd_setup_stat(struct ceph_osd_request *osd_req, int which)
 {
-	struct ceph_databuf *dbuf;
+	struct ceph_databuf *request;
 
 	/*
 	 * The response data for a STAT call consists of:
@@ -2118,12 +2117,12 @@ static int rbd_osd_setup_stat(struct ceph_osd_request *osd_req, int which)
 	 *         le32 tv_nsec;
 	 *     } mtime;
 	 */
-	dbuf = ceph_databuf_reply_alloc(1, 8 + sizeof(struct ceph_timespec), GFP_NOIO);
-	if (!dbuf)
+	request = ceph_databuf_reply_alloc(1, 8 + sizeof(struct ceph_timespec), GFP_NOIO);
+	if (!request)
 		return -ENOMEM;
 
 	osd_req_op_init(osd_req, which, CEPH_OSD_OP_STAT, 0);
-	osd_req_op_raw_data_in_databuf(osd_req, which, dbuf);
+	osd_req_op_raw_data_in_databuf(osd_req, which, request);
 	return 0;
 }
 
@@ -2964,16 +2963,16 @@ static int rbd_obj_copyup_current_snapc(struct rbd_obj_request *obj_req,
 
 static int setup_copyup_buf(struct rbd_obj_request *obj_req, u64 obj_overlap)
 {
-	struct ceph_databuf *dbuf;
+	struct ceph_databuf *request;
 
 	rbd_assert(!obj_req->copyup_buf);
 
-	dbuf = ceph_databuf_req_alloc(calc_pages_for(0, obj_overlap),
+	request = ceph_databuf_req_alloc(calc_pages_for(0, obj_overlap),
 				      obj_overlap, GFP_NOIO);
-	if (!dbuf)
+	if (!request)
 		return -ENOMEM;
 
-	obj_req->copyup_buf = dbuf;
+	obj_req->copyup_buf = request;
 	return 0;
 }
 
@@ -4580,10 +4579,9 @@ static int rbd_obj_method_sync(struct rbd_device *rbd_dev,
 		if (!request)
 			return -ENOMEM;
 
-		p = kmap_ceph_databuf_page(request, 0);
-		memcpy(p, outbound, outbound_size);
-		kunmap_local(p);
-		ceph_databuf_added_data(request, outbound_size);
+		p = ceph_databuf_enc_start(request);
+		ceph_encode_copy(&p, outbound, outbound_size);
+		ceph_databuf_enc_stop(request, p);
 	}
 
 	reply = ceph_databuf_reply_alloc(1, inbound_size, GFP_KERNEL);
@@ -4712,7 +4710,7 @@ static void rbd_free_disk(struct rbd_device *rbd_dev)
 static int rbd_obj_read_sync(struct rbd_device *rbd_dev,
 			     struct ceph_object_id *oid,
 			     struct ceph_object_locator *oloc,
-			     struct ceph_databuf *dbuf, int len)
+			     struct ceph_databuf *request, int len)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
 	struct ceph_osd_request *req;
@@ -4727,7 +4725,7 @@ static int rbd_obj_read_sync(struct rbd_device *rbd_dev,
 	req->r_flags = CEPH_OSD_FLAG_READ;
 
 	osd_req_op_extent_init(req, 0, CEPH_OSD_OP_READ, 0, len, 0, 0);
-	osd_req_op_extent_osd_databuf(req, 0, dbuf);
+	osd_req_op_extent_osd_databuf(req, 0, request);
 
 	ret = ceph_osdc_alloc_messages(req, GFP_KERNEL);
 	if (ret)
@@ -4750,16 +4748,16 @@ static int rbd_dev_v1_header_info(struct rbd_device *rbd_dev,
 				  bool first_time)
 {
 	struct rbd_image_header_ondisk *ondisk;
-	struct ceph_databuf *dbuf = NULL;
+	struct ceph_databuf *request = NULL;
 	u32 snap_count = 0;
 	u64 names_size = 0;
 	u32 want_count;
 	int ret;
 
-	dbuf = ceph_databuf_req_alloc(1, sizeof(*ondisk), GFP_KERNEL);
-	if (!dbuf)
+	request = ceph_databuf_req_alloc(1, sizeof(*ondisk), GFP_KERNEL);
+	if (!request)
 		return -ENOMEM;
-	ondisk = kmap_ceph_databuf_page(dbuf, 0);
+	ondisk = kmap_ceph_databuf_page(request, 0);
 
 	/*
 	 * The complete header will include an array of its 64-bit
@@ -4776,13 +4774,13 @@ static int rbd_dev_v1_header_info(struct rbd_device *rbd_dev,
 		size += names_size;
 
 		ret = -ENOMEM;
-		if (size > dbuf->limit &&
-		    ceph_databuf_reserve(dbuf, size - dbuf->limit,
+		if (size > request->limit &&
+		    ceph_databuf_reserve(request, size - request->limit,
 					 GFP_KERNEL) < 0)
 			goto out;
 
 		ret = rbd_obj_read_sync(rbd_dev, &rbd_dev->header_oid,
-					&rbd_dev->header_oloc, dbuf, size);
+					&rbd_dev->header_oloc, request, size);
 		if (ret < 0)
 			goto out;
 		if ((size_t)ret < size) {
@@ -4806,7 +4804,7 @@ static int rbd_dev_v1_header_info(struct rbd_device *rbd_dev,
 	ret = rbd_header_from_disk(header, ondisk, first_time);
 out:
 	kunmap_local(ondisk);
-	ceph_databuf_release(dbuf);
+	ceph_databuf_release(request);
 	return ret;
 }
 
@@ -5625,10 +5623,10 @@ static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev,
 	if (!reply)
 		goto out_free;
 
-	p = kmap_ceph_databuf_page(request, 0);
+	p = ceph_databuf_enc_start(request);
 	ceph_encode_64(&p, rbd_dev->spec->snap_id);
-	kunmap_local(p);
-	ceph_databuf_added_data(request, sizeof(__le64));
+	ceph_databuf_enc_stop(request, p);
+
 	ret = __get_parent_info(rbd_dev, request, reply, pii);
 	if (ret > 0)
 		ret = __get_parent_info_legacy(rbd_dev, request, reply, pii);


