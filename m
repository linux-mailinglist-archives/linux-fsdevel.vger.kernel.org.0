Return-Path: <linux-fsdevel+bounces-43971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CA8A605C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 00:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 198337ACAFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 23:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A209204C18;
	Thu, 13 Mar 2025 23:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MYUTdxf5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2A42045B8
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 23:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908919; cv=none; b=bXhz967nnuUREkqsTL79X9U4MtZA83wq30G3rr6WZ5d9WZ3V+dWY5SSC+lHFY1hz8JrdhWiRoxm1CL28QNIFZQW4AqUPprDDoVjuGjYuGSqvCsdDEXiLBushQuu08eHvVWB7l9zNTfVHGg/gEQYYp0J0vxkIgOy8f99jZwX+LvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908919; c=relaxed/simple;
	bh=3fiy4ny7SU0U9G1VFve5WdbbBxtpaSXQoJ3a9FoMPqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOBayU2ZvKBgQvn+falsZiWfHv0aRSVaxtm753U4I1zn8aKXulgUy7iMyPMETv/vCdf8ErnoQqhFKF+B5yYfC3XP3n6oo1YssSBXO7sEaz02Y4WjbCG75RYMkX384tpbm4zG/jZP/E8jmcyUWNvQP91WcQmsyBzh2+ACojPo2rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MYUTdxf5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/hHJAzYYf9ym0VVtgdV6fYyO92FHlFfcLtf50k26yFk=;
	b=MYUTdxf5BKhd5DHnH84OjWjzH+ZtTlMmL21GfYShIlJfvryyWlp58x7FOK9mp4Z7+VyD+s
	H/kiygcoa8nFUfBaq8FQzmxSKqTKsbWl+cq9XkjoSt71DBZtNwsaCAbk0v6ZvrcxWuDJSe
	N5fc2DhJKStD3dofWp+s6i5oRgfncNM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-nrTmkHJOPMyDQVSKYqLXYw-1; Thu,
 13 Mar 2025 19:35:14 -0400
X-MC-Unique: nrTmkHJOPMyDQVSKYqLXYw-1
X-Mimecast-MFC-AGG-ID: nrTmkHJOPMyDQVSKYqLXYw_1741908912
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FB441956046;
	Thu, 13 Mar 2025 23:35:12 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BF7AC1800268;
	Thu, 13 Mar 2025 23:35:09 +0000 (UTC)
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
Subject: [RFC PATCH 22/35] libceph, rbd: Convert ceph_osdc_notify() reply to ceph_databuf
Date: Thu, 13 Mar 2025 23:33:14 +0000
Message-ID: <20250313233341.1675324-23-dhowells@redhat.com>
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

Convert the reply buffer of ceph_osdc_notify() to ceph_databuf rather than
an array of pages.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 drivers/block/rbd.c             | 36 +++++++++++++++++----------
 include/linux/ceph/databuf.h    | 16 ++++++++++++
 include/linux/ceph/osd_client.h |  7 ++----
 net/ceph/osd_client.c           | 44 +++++++++++----------------------
 4 files changed, 55 insertions(+), 48 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index eea12c7ab2a0..a2674077edea 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3585,8 +3585,7 @@ static void rbd_unlock(struct rbd_device *rbd_dev)
 
 static int __rbd_notify_op_lock(struct rbd_device *rbd_dev,
 				enum rbd_notify_op notify_op,
-				struct page ***preply_pages,
-				size_t *preply_len)
+				struct ceph_databuf *reply)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
 	struct rbd_client_id cid = rbd_get_cid(rbd_dev);
@@ -3604,13 +3603,13 @@ static int __rbd_notify_op_lock(struct rbd_device *rbd_dev,
 
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
@@ -3631,23 +3630,29 @@ static void rbd_notify_released_lock(struct work_struct *work)
 
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
+	/* The actual reply pages will be allocated in the read path and then
+	 * pasted in in handle_watch_notify().
+	 */
+	reply = ceph_databuf_reply_alloc(0, 0, GFP_KERNEL);
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
+	if (ceph_databuf_len(reply) > 0 && ceph_databuf_len(reply) <= PAGE_SIZE) {
+		void *s = kmap_ceph_databuf_page(reply, 0);
+		void *p = s;
+		void *const end = p + ceph_databuf_len(reply);
 		u32 n;
 
 		ceph_decode_32_safe(&p, end, n, e_inval); /* num_acks */
@@ -3659,10 +3664,12 @@ static int rbd_request_lock(struct rbd_device *rbd_dev)
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
@@ -3673,6 +3680,7 @@ static int rbd_request_lock(struct rbd_device *rbd_dev)
 			ret = ceph_start_decoding(&p, end, 1, "ResponseMessage",
 						  &struct_v, &len);
 			if (ret) {
+				kunmap_local(s);
 				rbd_warn(rbd_dev,
 					 "failed to decode ResponseMessage: %d",
 					 ret);
@@ -3681,6 +3689,8 @@ static int rbd_request_lock(struct rbd_device *rbd_dev)
 
 			ret = ceph_decode_32(&p);
 		}
+
+		kunmap_local(s);
 	}
 
 	if (!lock_owner_responded) {
@@ -3689,7 +3699,7 @@ static int rbd_request_lock(struct rbd_device *rbd_dev)
 	}
 
 out:
-	ceph_release_page_vector(reply_pages, calc_pages_for(0, reply_len));
+	ceph_databuf_release(reply);
 	return ret;
 
 e_inval:
diff --git a/include/linux/ceph/databuf.h b/include/linux/ceph/databuf.h
index 54b76d0c91a0..25154b3d08fa 100644
--- a/include/linux/ceph/databuf.h
+++ b/include/linux/ceph/databuf.h
@@ -150,4 +150,20 @@ static inline bool ceph_databuf_is_all_zero(struct ceph_databuf *dbuf, size_t co
 			    ceph_databuf_scan_for_nonzero) == count;
 }
 
+static inline void ceph_databuf_transfer(struct ceph_databuf *to,
+					 struct ceph_databuf *from)
+{
+	BUG_ON(to->nr_bvec || to->bvec);
+	to->bvec	= from->bvec;
+	to->nr_bvec	= from->nr_bvec;
+	to->max_bvec	= from->max_bvec;
+	to->limit	= from->limit;
+	to->iter	= from->iter;
+
+	from->bvec = NULL;
+	from->nr_bvec = from->max_bvec = 0;
+	from->limit = 0;
+	iov_iter_discard(&from->iter, ITER_DEST, 0);
+}
+
 #endif /* __FS_CEPH_DATABUF_H */
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 5a1ee66ca216..7eff589711cc 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -333,9 +333,7 @@ struct ceph_osd_linger_request {
 
 	struct ceph_databuf *request_pl;
 	struct ceph_databuf *notify_id_buf;
-
-	struct page ***preply_pages;
-	size_t *preply_len;
+	struct ceph_databuf *reply;
 };
 
 struct ceph_watch_item {
@@ -589,8 +587,7 @@ int ceph_osdc_notify(struct ceph_osd_client *osdc,
 		     void *payload,
 		     u32 payload_len,
 		     u32 timeout,
-		     struct page ***preply_pages,
-		     size_t *preply_len);
+		     struct ceph_databuf *reply);
 int ceph_osdc_list_watchers(struct ceph_osd_client *osdc,
 			    struct ceph_object_id *oid,
 			    struct ceph_object_locator *oloc,
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 1a0cb2cdcc52..92aaa5ed9145 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -4523,17 +4523,11 @@ static void handle_watch_notify(struct ceph_osd_client *osdc,
 			dout("lreq %p notify_id %llu != %llu, ignoring\n", lreq,
 			     lreq->notify_id, notify_id);
 		} else if (!completion_done(&lreq->notify_finish_wait)) {
-			struct ceph_msg_data *data =
-			    msg->num_data_items ? &msg->data[0] : NULL;
-
-			if (data) {
-				if (lreq->preply_pages) {
-					WARN_ON(data->type !=
-							CEPH_MSG_DATA_PAGES);
-					*lreq->preply_pages = data->pages;
-					*lreq->preply_len = data->length;
-					data->own_pages = false;
-				}
+			if (msg->num_data_items && lreq->reply) {
+				struct ceph_msg_data *data = &msg->data[0];
+
+				WARN_ON(data->type != CEPH_MSG_DATA_DATABUF);
+				ceph_databuf_transfer(lreq->reply, data->dbuf);
 			}
 			lreq->notify_finish_error = return_code;
 			complete_all(&lreq->notify_finish_wait);
@@ -4823,10 +4817,7 @@ EXPORT_SYMBOL(ceph_osdc_notify_ack);
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
@@ -4834,8 +4825,7 @@ int ceph_osdc_notify(struct ceph_osd_client *osdc,
 		     void *payload,
 		     u32 payload_len,
 		     u32 timeout,
-		     struct page ***preply_pages,
-		     size_t *preply_len)
+		     struct ceph_databuf *reply)
 {
 	struct ceph_osd_linger_request *lreq;
 	void *p;
@@ -4845,10 +4835,6 @@ int ceph_osdc_notify(struct ceph_osd_client *osdc,
 		return -EIO;
 
 	WARN_ON(!timeout);
-	if (preply_pages) {
-		*preply_pages = NULL;
-		*preply_len = 0;
-	}
 
 	lreq = linger_alloc(osdc);
 	if (!lreq)
@@ -4875,8 +4861,7 @@ int ceph_osdc_notify(struct ceph_osd_client *osdc,
 		goto out_put_lreq;
 	}
 
-	lreq->preply_pages = preply_pages;
-	lreq->preply_len = preply_len;
+	lreq->reply = reply;
 
 	ceph_oid_copy(&lreq->t.base_oid, oid);
 	ceph_oloc_copy(&lreq->t.base_oloc, oloc);
@@ -5383,7 +5368,7 @@ static struct ceph_msg *get_reply(struct ceph_connection *con,
 	return m;
 }
 
-static struct ceph_msg *alloc_msg_with_page_vector(struct ceph_msg_header *hdr)
+static struct ceph_msg *alloc_msg_with_data_buffer(struct ceph_msg_header *hdr)
 {
 	struct ceph_msg *m;
 	int type = le16_to_cpu(hdr->type);
@@ -5395,16 +5380,15 @@ static struct ceph_msg *alloc_msg_with_page_vector(struct ceph_msg_header *hdr)
 		return NULL;
 
 	if (data_len) {
-		struct page **pages;
+		struct ceph_databuf *dbuf;
 
-		pages = ceph_alloc_page_vector(calc_pages_for(0, data_len),
-					       GFP_NOIO);
-		if (IS_ERR(pages)) {
+		dbuf = ceph_databuf_reply_alloc(0, data_len, GFP_NOIO);
+		if (!dbuf) {
 			ceph_msg_put(m);
 			return NULL;
 		}
 
-		ceph_msg_data_add_pages(m, pages, data_len, 0, true);
+		ceph_msg_data_add_databuf(m, dbuf);
 	}
 
 	return m;
@@ -5422,7 +5406,7 @@ static struct ceph_msg *osd_alloc_msg(struct ceph_connection *con,
 	case CEPH_MSG_OSD_MAP:
 	case CEPH_MSG_OSD_BACKOFF:
 	case CEPH_MSG_WATCH_NOTIFY:
-		return alloc_msg_with_page_vector(hdr);
+		return alloc_msg_with_data_buffer(hdr);
 	case CEPH_MSG_OSD_OPREPLY:
 		return get_reply(con, hdr, skip);
 	default:


