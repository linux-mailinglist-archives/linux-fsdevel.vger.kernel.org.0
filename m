Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A27477012E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 15:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjHDNRN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 09:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjHDNQS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:16:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60E04ECA
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 06:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691154845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QWNtQ/nYYrYbr77ZEWyL6um5yN2tXRzHz2RkALfII30=;
        b=c/90+t+t9ezzyMM6Lv73S3IndenLtnO5Cf+Y39bwUbap7MxRmC0D+4UsOcrDBF0iALoJRF
        n6wN5/LxgFjpHsbgU7uRT88fZ9B3DWMwf/PjS7QtkWm6PnuTSnvl76Qvk7s4m3kbmWkYwI
        d343SjJBB1H7MTZQyRVxSB1wtvWcwYQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-YDTrl4H0P9WryLrySiFWrw-1; Fri, 04 Aug 2023 09:14:01 -0400
X-MC-Unique: YDTrl4H0P9WryLrySiFWrw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2866104458D;
        Fri,  4 Aug 2023 13:14:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D51B44087C81;
        Fri,  4 Aug 2023 13:13:59 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 15/18] ceph: Convert ceph_osdc_notify() reply to ceph_databuf
Date:   Fri,  4 Aug 2023 14:13:24 +0100
Message-ID: <20230804131327.2574082-16-dhowells@redhat.com>
In-Reply-To: <20230804131327.2574082-1-dhowells@redhat.com>
References: <20230804131327.2574082-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert the reply buffer of ceph_osdc_notify() to ceph_databuf rather than
an array of pages.

Signed-off-by: David Howells <dhowells@redhat.com>
---
 drivers/block/rbd.c             | 33 ++++++++++++++++++++-------------
 include/linux/ceph/osd_client.h |  7 ++-----
 net/ceph/osd_client.c           | 17 ++++-------------
 3 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 950b63eb41de..7a624e75ac7a 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3455,8 +3455,7 @@ static void rbd_unlock(struct rbd_device *rbd_dev)
 
 static int __rbd_notify_op_lock(struct rbd_device *rbd_dev,
 				enum rbd_notify_op notify_op,
-				struct page ***preply_pages,
-				size_t *preply_len)
+				struct ceph_databuf *reply)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
 	struct rbd_client_id cid = rbd_get_cid(rbd_dev);
@@ -3474,13 +3473,13 @@ static int __rbd_notify_op_lock(struct rbd_device *rbd_dev,
 
 	return ceph_osdc_notify(osdc, &rbd_dev->header_oid,
 				&rbd_dev->header_oloc, buf, buf_size,
-				RBD_NOTIFY_TIMEOUT, preply_pages, preply_len);
+				RBD_NOTIFY_TIMEOUT, reply);
 }
 
 static void rbd_notify_op_lock(struct rbd_device *rbd_dev,
 			       enum rbd_notify_op notify_op)
 {
-	__rbd_notify_op_lock(rbd_dev, notify_op, NULL, NULL);
+	__rbd_notify_op_lock(rbd_dev, notify_op, NULL);
 }
 
 static void rbd_notify_acquired_lock(struct work_struct *work)
@@ -3501,23 +3500,26 @@ static void rbd_notify_released_lock(struct work_struct *work)
 
 static int rbd_request_lock(struct rbd_device *rbd_dev)
 {
-	struct page **reply_pages;
-	size_t reply_len;
+	struct ceph_databuf *reply;
 	bool lock_owner_responded = false;
 	int ret;
 
 	dout("%s rbd_dev %p\n", __func__, rbd_dev);
 
-	ret = __rbd_notify_op_lock(rbd_dev, RBD_NOTIFY_OP_REQUEST_LOCK,
-				   &reply_pages, &reply_len);
+	reply = ceph_databuf_alloc(0, 0, GFP_KERNEL);
+	if (!reply)
+		return -ENOMEM;
+
+	ret = __rbd_notify_op_lock(rbd_dev, RBD_NOTIFY_OP_REQUEST_LOCK, reply);
 	if (ret && ret != -ETIMEDOUT) {
 		rbd_warn(rbd_dev, "failed to request lock: %d", ret);
 		goto out;
 	}
 
-	if (reply_len > 0 && reply_len <= PAGE_SIZE) {
-		void *p = page_address(reply_pages[0]);
-		void *const end = p + reply_len;
+	if (reply->length > 0 && reply->length <= PAGE_SIZE) {
+		void *s = kmap_ceph_databuf_page(reply, 0);
+		void *p = s;
+		void *const end = p + reply->length;
 		u32 n;
 
 		ceph_decode_32_safe(&p, end, n, e_inval); /* num_acks */
@@ -3529,10 +3531,12 @@ static int rbd_request_lock(struct rbd_device *rbd_dev)
 			p += 8 + 8; /* skip gid and cookie */
 
 			ceph_decode_32_safe(&p, end, len, e_inval);
-			if (!len)
+			if (!len) {
 				continue;
+			}
 
 			if (lock_owner_responded) {
+				kunmap_local(s);
 				rbd_warn(rbd_dev,
 					 "duplicate lock owners detected");
 				ret = -EIO;
@@ -3543,6 +3547,7 @@ static int rbd_request_lock(struct rbd_device *rbd_dev)
 			ret = ceph_start_decoding(&p, end, 1, "ResponseMessage",
 						  &struct_v, &len);
 			if (ret) {
+				kunmap_local(s);
 				rbd_warn(rbd_dev,
 					 "failed to decode ResponseMessage: %d",
 					 ret);
@@ -3551,6 +3556,8 @@ static int rbd_request_lock(struct rbd_device *rbd_dev)
 
 			ret = ceph_decode_32(&p);
 		}
+
+		kunmap_local(s);
 	}
 
 	if (!lock_owner_responded) {
@@ -3559,7 +3566,7 @@ static int rbd_request_lock(struct rbd_device *rbd_dev)
 	}
 
 out:
-	ceph_release_page_vector(reply_pages, calc_pages_for(0, reply_len));
+	ceph_databuf_release(reply);
 	return ret;
 
 e_inval:
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 83c3073c44bb..3099f923c241 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -332,9 +332,7 @@ struct ceph_osd_linger_request {
 
 	struct ceph_databuf *request_pl;
 	struct ceph_databuf *notify_id_buf;
-
-	struct page ***preply_pages;
-	size_t *preply_len;
+	struct ceph_databuf *reply;
 };
 
 struct ceph_watch_item {
@@ -587,8 +585,7 @@ int ceph_osdc_notify(struct ceph_osd_client *osdc,
 		     void *payload,
 		     u32 payload_len,
 		     u32 timeout,
-		     struct page ***preply_pages,
-		     size_t *preply_len);
+		     struct ceph_databuf *reply);
 int ceph_osdc_watch_check(struct ceph_osd_client *osdc,
 			  struct ceph_osd_linger_request *lreq);
 int ceph_osdc_list_watchers(struct ceph_osd_client *osdc,
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 8cbe06d2e16d..0fe16fdc760f 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -4530,7 +4530,7 @@ static void handle_watch_notify(struct ceph_osd_client *osdc,
 			    msg->num_data_items ? &msg->data[0] : NULL;
 
 			if (data) {
-				if (lreq->preply_pages) {
+				if (lreq->reply) {
 					WARN_ON(data->type !=
 							CEPH_MSG_DATA_PAGES);
 					*lreq->preply_pages = data->pages;
@@ -4828,10 +4828,7 @@ EXPORT_SYMBOL(ceph_osdc_notify_ack);
 /*
  * @timeout: in seconds
  *
- * @preply_{pages,len} are initialized both on success and error.
- * The caller is responsible for:
- *
- *     ceph_release_page_vector(reply_pages, calc_pages_for(0, reply_len))
+ * @reply should be an empty ceph_databuf.
  */
 int ceph_osdc_notify(struct ceph_osd_client *osdc,
 		     struct ceph_object_id *oid,
@@ -4839,17 +4836,12 @@ int ceph_osdc_notify(struct ceph_osd_client *osdc,
 		     void *payload,
 		     u32 payload_len,
 		     u32 timeout,
-		     struct page ***preply_pages,
-		     size_t *preply_len)
+		     struct ceph_databuf *reply)
 {
 	struct ceph_osd_linger_request *lreq;
 	int ret;
 
 	WARN_ON(!timeout);
-	if (preply_pages) {
-		*preply_pages = NULL;
-		*preply_len = 0;
-	}
 
 	lreq = linger_alloc(osdc);
 	if (!lreq)
@@ -4877,8 +4869,7 @@ int ceph_osdc_notify(struct ceph_osd_client *osdc,
 		goto out_put_lreq;
 	}
 
-	lreq->preply_pages = preply_pages;
-	lreq->preply_len = preply_len;
+	lreq->reply = reply;
 
 	ceph_oid_copy(&lreq->t.base_oid, oid);
 	ceph_oloc_copy(&lreq->t.base_oloc, oloc);

