Return-Path: <linux-fsdevel+bounces-43966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE32DA605AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 00:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F84A1727D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 23:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1558202F71;
	Thu, 13 Mar 2025 23:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hnr9Wju5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB5C202961
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 23:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908901; cv=none; b=IrDfksS6m5KonMv/IM6WvWWTCMJpT+0tCXJSFizUd2SrPIJvqRr5q+prWZj7kNw1AOgQZHi2zujsnpoZwr8ExKGLYxpbxY4sqi5uMFvY+TAb1HHrbEzTBZrxPmIpLK/7d7xtRmeeyB1JNZMEjxhId3vLMvjvv8j7EcyhcPrSdkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908901; c=relaxed/simple;
	bh=9baOV8Q0rHmzZzcj+dG4AbHLjZPzMvM3nWTOJ5Vha5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NL8nc3Znr8otjwE4B8vZ1910lVMuWDjeqUvUWBDUWxj5x6wi3bJxduqZxhoPtlx++7LjYmJxHgpEOTyd+atqaf7CsS37YQ7eOKBhiNWexyQmPV0hickiXegUY8L+2MTE7m3gcNCa8PphROz0SjkwM/xgg+BDJVBO2c/JzQiExNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hnr9Wju5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T9lsj7CeBQbxlyHDOAiw78Xi6FdJjfh/a7c8DCu2g0I=;
	b=Hnr9Wju55wKRB0D7OXFB0QnmCmi6MrEfuJezavTJ7nLDR8jZopFisfZsdaQRY9Hj+GJpls
	BJiIbQBYplWG45sz+9gCyPou1wfJcSdB3TsN9mNjGu0KLCJxpoWwFVT9CI6pUYJV8fjwfc
	AkD0HaLa3POBeXT10I48H1r1trS8BEI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-fO8r0MaMObuyJAnZgEuUHg-1; Thu,
 13 Mar 2025 19:34:55 -0400
X-MC-Unique: fO8r0MaMObuyJAnZgEuUHg-1
X-Mimecast-MFC-AGG-ID: fO8r0MaMObuyJAnZgEuUHg_1741908893
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99AD219560B7;
	Thu, 13 Mar 2025 23:34:53 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 599B81800945;
	Thu, 13 Mar 2025 23:34:51 +0000 (UTC)
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
Subject: [RFC PATCH 17/35] libceph, rbd: Use ceph_databuf encoding start/stop
Date: Thu, 13 Mar 2025 23:33:09 +0000
Message-ID: <20250313233341.1675324-18-dhowells@redhat.com>
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

Use ceph_databuf_enc_start() and ceph_databuf_enc_stop() to encode RPC
parameter data where possible.  The start function maps the buffer and
returns a pointer to the point to start writing at; the stop function
updates the buffer size.

The code is also made a bit more consistent in the use of size_t for length
variables and using 'request' for a pointer to the request buffer.

The end pointer is dropped from ceph_encode_string() as we shouldn't
overrun with the string length being included in the buffer size
precalculation.  The final pointer is checked by ceph_databuf_enc_stop().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 drivers/block/rbd.c         |   3 +-
 include/linux/ceph/decode.h |   4 +-
 net/ceph/cls_lock_client.c  | 195 +++++++++++++++++-------------------
 net/ceph/mon_client.c       |  10 +-
 net/ceph/osd_client.c       |  26 +++--
 5 files changed, 112 insertions(+), 126 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index ec09d578b0b0..078bb1e3e1da 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5762,8 +5762,7 @@ static char *rbd_dev_image_name(struct rbd_device *rbd_dev)
 		return NULL;
 
 	p = image_id;
-	end = image_id + image_id_size;
-	ceph_encode_string(&p, end, rbd_dev->spec->image_id, (u32)len);
+	ceph_encode_string(&p, rbd_dev->spec->image_id, len);
 
 	size = sizeof (__le32) + RBD_IMAGE_NAME_LEN_MAX;
 	reply_buf = kmalloc(size, GFP_KERNEL);
diff --git a/include/linux/ceph/decode.h b/include/linux/ceph/decode.h
index 8fc1aed64113..e2726c3152db 100644
--- a/include/linux/ceph/decode.h
+++ b/include/linux/ceph/decode.h
@@ -292,10 +292,8 @@ static inline void ceph_encode_filepath(void **p, void *end,
 	*p += len;
 }
 
-static inline void ceph_encode_string(void **p, void *end,
-				      const char *s, u32 len)
+static inline void ceph_encode_string(void **p, const char *s, u32 len)
 {
-	BUG_ON(*p + sizeof(len) + len > end);
 	ceph_encode_32(p, len);
 	if (len)
 		memcpy(*p, s, len);
diff --git a/net/ceph/cls_lock_client.c b/net/ceph/cls_lock_client.c
index 6c8608aabe5f..c91259ff8557 100644
--- a/net/ceph/cls_lock_client.c
+++ b/net/ceph/cls_lock_client.c
@@ -28,14 +28,14 @@ int ceph_cls_lock(struct ceph_osd_client *osdc,
 		  char *lock_name, u8 type, char *cookie,
 		  char *tag, char *desc, u8 flags)
 {
-	int lock_op_buf_size;
-	int name_len = strlen(lock_name);
-	int cookie_len = strlen(cookie);
-	int tag_len = strlen(tag);
-	int desc_len = strlen(desc);
-	void *p, *end;
-	struct ceph_databuf *lock_op_req;
+	struct ceph_databuf *request;
 	struct timespec64 mtime;
+	size_t lock_op_buf_size;
+	size_t name_len = strlen(lock_name);
+	size_t cookie_len = strlen(cookie);
+	size_t tag_len = strlen(tag);
+	size_t desc_len = strlen(desc);
+	void *p;
 	int ret;
 
 	lock_op_buf_size = name_len + sizeof(__le32) +
@@ -49,36 +49,34 @@ int ceph_cls_lock(struct ceph_osd_client *osdc,
 	if (lock_op_buf_size > PAGE_SIZE)
 		return -E2BIG;
 
-	lock_op_req = ceph_databuf_req_alloc(0, lock_op_buf_size, GFP_NOIO);
-	if (!lock_op_req)
+	request = ceph_databuf_req_alloc(1, lock_op_buf_size, GFP_NOIO);
+	if (!request)
 		return -ENOMEM;
 
-	p = kmap_ceph_databuf_page(lock_op_req, 0);
-	end = p + lock_op_buf_size;
+	p = ceph_databuf_enc_start(request);
 
 	/* encode cls_lock_lock_op struct */
 	ceph_start_encoding(&p, 1, 1,
 			    lock_op_buf_size - CEPH_ENCODING_START_BLK_LEN);
-	ceph_encode_string(&p, end, lock_name, name_len);
+	ceph_encode_string(&p, lock_name, name_len);
 	ceph_encode_8(&p, type);
-	ceph_encode_string(&p, end, cookie, cookie_len);
-	ceph_encode_string(&p, end, tag, tag_len);
-	ceph_encode_string(&p, end, desc, desc_len);
+	ceph_encode_string(&p, cookie, cookie_len);
+	ceph_encode_string(&p, tag, tag_len);
+	ceph_encode_string(&p, desc, desc_len);
 	/* only support infinite duration */
 	memset(&mtime, 0, sizeof(mtime));
 	ceph_encode_timespec64(p, &mtime);
 	p += sizeof(struct ceph_timespec);
 	ceph_encode_8(&p, flags);
-	kunmap_local(p);
-	ceph_databuf_added_data(lock_op_req, lock_op_buf_size);
+	ceph_databuf_enc_stop(request, p);
 
 	dout("%s lock_name %s type %d cookie %s tag %s desc %s flags 0x%x\n",
 	     __func__, lock_name, type, cookie, tag, desc, flags);
 	ret = ceph_osdc_call(osdc, oid, oloc, "lock", "lock",
-			     CEPH_OSD_FLAG_WRITE, lock_op_req, NULL);
+			     CEPH_OSD_FLAG_WRITE, request, NULL);
 
 	dout("%s: status %d\n", __func__, ret);
-	ceph_databuf_release(lock_op_req);
+	ceph_databuf_release(request);
 	return ret;
 }
 EXPORT_SYMBOL(ceph_cls_lock);
@@ -96,11 +94,11 @@ int ceph_cls_unlock(struct ceph_osd_client *osdc,
 		    struct ceph_object_locator *oloc,
 		    char *lock_name, char *cookie)
 {
-	int unlock_op_buf_size;
-	int name_len = strlen(lock_name);
-	int cookie_len = strlen(cookie);
-	void *p, *end;
-	struct ceph_databuf *unlock_op_req;
+	struct ceph_databuf *request;
+	size_t unlock_op_buf_size;
+	size_t name_len = strlen(lock_name);
+	size_t cookie_len = strlen(cookie);
+	void *p;
 	int ret;
 
 	unlock_op_buf_size = name_len + sizeof(__le32) +
@@ -109,27 +107,25 @@ int ceph_cls_unlock(struct ceph_osd_client *osdc,
 	if (unlock_op_buf_size > PAGE_SIZE)
 		return -E2BIG;
 
-	unlock_op_req = ceph_databuf_req_alloc(0, unlock_op_buf_size, GFP_NOIO);
-	if (!unlock_op_req)
+	request = ceph_databuf_req_alloc(1, unlock_op_buf_size, GFP_NOIO);
+	if (!request)
 		return -ENOMEM;
 
-	p = kmap_ceph_databuf_page(unlock_op_req, 0);
-	end = p + unlock_op_buf_size;
+	p = ceph_databuf_enc_start(request);
 
 	/* encode cls_lock_unlock_op struct */
 	ceph_start_encoding(&p, 1, 1,
 			    unlock_op_buf_size - CEPH_ENCODING_START_BLK_LEN);
-	ceph_encode_string(&p, end, lock_name, name_len);
-	ceph_encode_string(&p, end, cookie, cookie_len);
-	kunmap_local(p);
-	ceph_databuf_added_data(unlock_op_req, unlock_op_buf_size);
+	ceph_encode_string(&p, lock_name, name_len);
+	ceph_encode_string(&p, cookie, cookie_len);
+	ceph_databuf_enc_stop(request, p);
 
 	dout("%s lock_name %s cookie %s\n", __func__, lock_name, cookie);
 	ret = ceph_osdc_call(osdc, oid, oloc, "lock", "unlock",
-			     CEPH_OSD_FLAG_WRITE, unlock_op_req, NULL);
+			     CEPH_OSD_FLAG_WRITE, request, NULL);
 
 	dout("%s: status %d\n", __func__, ret);
-	ceph_databuf_release(unlock_op_req);
+	ceph_databuf_release(request);
 	return ret;
 }
 EXPORT_SYMBOL(ceph_cls_unlock);
@@ -149,11 +145,11 @@ int ceph_cls_break_lock(struct ceph_osd_client *osdc,
 			char *lock_name, char *cookie,
 			struct ceph_entity_name *locker)
 {
-	int break_op_buf_size;
-	int name_len = strlen(lock_name);
-	int cookie_len = strlen(cookie);
-	struct ceph_databuf *break_op_req;
-	void *p, *end;
+	struct ceph_databuf *request;
+	size_t break_op_buf_size;
+	size_t name_len = strlen(lock_name);
+	size_t cookie_len = strlen(cookie);
+	void *p;
 	int ret;
 
 	break_op_buf_size = name_len + sizeof(__le32) +
@@ -163,29 +159,27 @@ int ceph_cls_break_lock(struct ceph_osd_client *osdc,
 	if (break_op_buf_size > PAGE_SIZE)
 		return -E2BIG;
 
-	break_op_req = ceph_databuf_req_alloc(0, break_op_buf_size, GFP_NOIO);
-	if (!break_op_req)
+	request = ceph_databuf_req_alloc(1, break_op_buf_size, GFP_NOIO);
+	if (!request)
 		return -ENOMEM;
 
-	p = kmap_ceph_databuf_page(break_op_req, 0);
-	end = p + break_op_buf_size;
+	p = ceph_databuf_enc_start(request);
 
 	/* encode cls_lock_break_op struct */
 	ceph_start_encoding(&p, 1, 1,
 			    break_op_buf_size - CEPH_ENCODING_START_BLK_LEN);
-	ceph_encode_string(&p, end, lock_name, name_len);
+	ceph_encode_string(&p, lock_name, name_len);
 	ceph_encode_copy(&p, locker, sizeof(*locker));
-	ceph_encode_string(&p, end, cookie, cookie_len);
-	kunmap_local(p);
-	ceph_databuf_added_data(break_op_req, break_op_buf_size);
+	ceph_encode_string(&p, cookie, cookie_len);
+	ceph_databuf_enc_stop(request, p);
 
 	dout("%s lock_name %s cookie %s locker %s%llu\n", __func__, lock_name,
 	     cookie, ENTITY_NAME(*locker));
 	ret = ceph_osdc_call(osdc, oid, oloc, "lock", "break_lock",
-			     CEPH_OSD_FLAG_WRITE, break_op_req, NULL);
+			     CEPH_OSD_FLAG_WRITE, request, NULL);
 
 	dout("%s: status %d\n", __func__, ret);
-	ceph_databuf_release(break_op_req);
+	ceph_databuf_release(request);
 	return ret;
 }
 EXPORT_SYMBOL(ceph_cls_break_lock);
@@ -196,13 +190,13 @@ int ceph_cls_set_cookie(struct ceph_osd_client *osdc,
 			char *lock_name, u8 type, char *old_cookie,
 			char *tag, char *new_cookie)
 {
-	int cookie_op_buf_size;
-	int name_len = strlen(lock_name);
-	int old_cookie_len = strlen(old_cookie);
-	int tag_len = strlen(tag);
-	int new_cookie_len = strlen(new_cookie);
-	void *p, *end;
-	struct ceph_databuf *cookie_op_req;
+	struct ceph_databuf *request;
+	size_t cookie_op_buf_size;
+	size_t name_len = strlen(lock_name);
+	size_t old_cookie_len = strlen(old_cookie);
+	size_t tag_len = strlen(tag);
+	size_t new_cookie_len = strlen(new_cookie);
+	void *p;
 	int ret;
 
 	cookie_op_buf_size = name_len + sizeof(__le32) +
@@ -213,31 +207,29 @@ int ceph_cls_set_cookie(struct ceph_osd_client *osdc,
 	if (cookie_op_buf_size > PAGE_SIZE)
 		return -E2BIG;
 
-	cookie_op_req = ceph_databuf_req_alloc(0, cookie_op_buf_size, GFP_NOIO);
-	if (!cookie_op_req)
+	request = ceph_databuf_req_alloc(1, cookie_op_buf_size, GFP_NOIO);
+	if (!request)
 		return -ENOMEM;
 
-	p = kmap_ceph_databuf_page(cookie_op_req, 0);
-	end = p + cookie_op_buf_size;
+	p = ceph_databuf_enc_start(request);
 
 	/* encode cls_lock_set_cookie_op struct */
 	ceph_start_encoding(&p, 1, 1,
 			    cookie_op_buf_size - CEPH_ENCODING_START_BLK_LEN);
-	ceph_encode_string(&p, end, lock_name, name_len);
+	ceph_encode_string(&p, lock_name, name_len);
 	ceph_encode_8(&p, type);
-	ceph_encode_string(&p, end, old_cookie, old_cookie_len);
-	ceph_encode_string(&p, end, tag, tag_len);
-	ceph_encode_string(&p, end, new_cookie, new_cookie_len);
-	kunmap_local(p);
-	ceph_databuf_added_data(cookie_op_req, cookie_op_buf_size);
+	ceph_encode_string(&p, old_cookie, old_cookie_len);
+	ceph_encode_string(&p, tag, tag_len);
+	ceph_encode_string(&p, new_cookie, new_cookie_len);
+	ceph_databuf_enc_stop(request, p);
 
 	dout("%s lock_name %s type %d old_cookie %s tag %s new_cookie %s\n",
 	     __func__, lock_name, type, old_cookie, tag, new_cookie);
 	ret = ceph_osdc_call(osdc, oid, oloc, "lock", "set_cookie",
-			     CEPH_OSD_FLAG_WRITE, cookie_op_req, NULL);
+			     CEPH_OSD_FLAG_WRITE, request, NULL);
 
 	dout("%s: status %d\n", __func__, ret);
-	ceph_databuf_release(cookie_op_req);
+	ceph_databuf_release(request);
 	return ret;
 }
 EXPORT_SYMBOL(ceph_cls_set_cookie);
@@ -289,9 +281,10 @@ static int decode_locker(void **p, void *end, struct ceph_locker *locker)
 	return 0;
 }
 
-static int decode_lockers(void **p, void *end, u8 *type, char **tag,
+static int decode_lockers(void **p, size_t size, u8 *type, char **tag,
 			  struct ceph_locker **lockers, u32 *num_lockers)
 {
+	void *end = *p + size;
 	u8 struct_v;
 	u32 struct_len;
 	char *s;
@@ -341,11 +334,10 @@ int ceph_cls_lock_info(struct ceph_osd_client *osdc,
 		       char *lock_name, u8 *type, char **tag,
 		       struct ceph_locker **lockers, u32 *num_lockers)
 {
-	struct ceph_databuf *reply;
-	int get_info_op_buf_size;
-	int name_len = strlen(lock_name);
-	struct ceph_databuf *get_info_op_req;
-	void *p, *end;
+	struct ceph_databuf *request, *reply;
+	size_t get_info_op_buf_size;
+	size_t name_len = strlen(lock_name);
+	void *p;
 	int ret;
 
 	get_info_op_buf_size = name_len + sizeof(__le32) +
@@ -353,42 +345,39 @@ int ceph_cls_lock_info(struct ceph_osd_client *osdc,
 	if (get_info_op_buf_size > PAGE_SIZE)
 		return -E2BIG;
 
-	get_info_op_req = ceph_databuf_req_alloc(0, get_info_op_buf_size,
-						 GFP_NOIO);
-	if (!get_info_op_req)
+	request = ceph_databuf_req_alloc(1, get_info_op_buf_size, GFP_NOIO);
+	if (!request)
 		return -ENOMEM;
 
 	reply = ceph_databuf_reply_alloc(1, PAGE_SIZE, GFP_NOIO);
 	if (!reply) {
-		ceph_databuf_release(get_info_op_req);
+		ceph_databuf_release(request);
 		return -ENOMEM;
 	}
 
-	p = kmap_ceph_databuf_page(get_info_op_req, 0);
-	end = p + get_info_op_buf_size;
+	p = ceph_databuf_enc_start(request);
 
 	/* encode cls_lock_get_info_op struct */
 	ceph_start_encoding(&p, 1, 1,
 			    get_info_op_buf_size - CEPH_ENCODING_START_BLK_LEN);
-	ceph_encode_string(&p, end, lock_name, name_len);
-	kunmap_local(p);
-	ceph_databuf_added_data(get_info_op_req, get_info_op_buf_size);
+	ceph_encode_string(&p, lock_name, name_len);
+	ceph_databuf_enc_stop(request, p);
 
 	dout("%s lock_name %s\n", __func__, lock_name);
 	ret = ceph_osdc_call(osdc, oid, oloc, "lock", "get_info",
-			     CEPH_OSD_FLAG_READ, get_info_op_req, reply);
+			     CEPH_OSD_FLAG_READ, request, reply);
 
 	dout("%s: status %d\n", __func__, ret);
 	if (ret >= 0) {
 		p = kmap_ceph_databuf_page(reply, 0);
-		end = p + ceph_databuf_len(reply);
 
-		ret = decode_lockers(&p, end, type, tag, lockers, num_lockers);
+		ret = decode_lockers(&p, ceph_databuf_len(reply),
+				     type, tag, lockers, num_lockers);
 		kunmap_local(p);
 	}
 
 	ceph_databuf_release(reply);
-	ceph_databuf_release(get_info_op_req);
+	ceph_databuf_release(request);
 	return ret;
 }
 EXPORT_SYMBOL(ceph_cls_lock_info);
@@ -396,12 +385,12 @@ EXPORT_SYMBOL(ceph_cls_lock_info);
 int ceph_cls_assert_locked(struct ceph_osd_request *req, int which,
 			   char *lock_name, u8 type, char *cookie, char *tag)
 {
-	struct ceph_databuf *dbuf;
-	int assert_op_buf_size;
-	int name_len = strlen(lock_name);
-	int cookie_len = strlen(cookie);
-	int tag_len = strlen(tag);
-	void *p, *end;
+	struct ceph_databuf *request;
+	size_t assert_op_buf_size;
+	size_t name_len = strlen(lock_name);
+	size_t cookie_len = strlen(cookie);
+	size_t tag_len = strlen(tag);
+	void *p;
 	int ret;
 
 	assert_op_buf_size = name_len + sizeof(__le32) +
@@ -415,25 +404,23 @@ int ceph_cls_assert_locked(struct ceph_osd_request *req, int which,
 	if (ret)
 		return ret;
 
-	dbuf = ceph_databuf_req_alloc(1, PAGE_SIZE, GFP_NOIO);
-	if (!dbuf)
+	request = ceph_databuf_req_alloc(1, assert_op_buf_size, GFP_NOIO);
+	if (!request)
 		return -ENOMEM;
 
-	p = kmap_ceph_databuf_page(dbuf, 0);
-	end = p + assert_op_buf_size;
+	p = ceph_databuf_enc_start(request);
 
 	/* encode cls_lock_assert_op struct */
 	ceph_start_encoding(&p, 1, 1,
 			    assert_op_buf_size - CEPH_ENCODING_START_BLK_LEN);
-	ceph_encode_string(&p, end, lock_name, name_len);
+	ceph_encode_string(&p, lock_name, name_len);
 	ceph_encode_8(&p, type);
-	ceph_encode_string(&p, end, cookie, cookie_len);
-	ceph_encode_string(&p, end, tag, tag_len);
-	kunmap(p);
-	WARN_ON(p != end);
-	ceph_databuf_added_data(dbuf, assert_op_buf_size);
+	ceph_encode_string(&p, cookie, cookie_len);
+	ceph_encode_string(&p, tag, tag_len);
+	ceph_databuf_enc_stop(request, p);
+	WARN_ON(ceph_databuf_len(request) != assert_op_buf_size);
 
-	osd_req_op_cls_request_databuf(req, which, dbuf);
+	osd_req_op_cls_request_databuf(req, which, request);
 	return 0;
 }
 EXPORT_SYMBOL(ceph_cls_assert_locked);
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index ab66b599ac47..39103e4bb07d 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -367,7 +367,8 @@ static void __send_subscribe(struct ceph_mon_client *monc)
 		dout("%s %s start %llu flags 0x%x\n", __func__, buf,
 		     le64_to_cpu(monc->subs[i].item.start),
 		     monc->subs[i].item.flags);
-		ceph_encode_string(&p, end, buf, len);
+		BUG_ON(p + sizeof(__le32) + len > end);
+		ceph_encode_string(&p, buf, len);
 		memcpy(p, &monc->subs[i].item, sizeof(monc->subs[i].item));
 		p += sizeof(monc->subs[i].item);
 	}
@@ -854,13 +855,14 @@ __ceph_monc_get_version(struct ceph_mon_client *monc, const char *what,
 			ceph_monc_callback_t cb, u64 private_data)
 {
 	struct ceph_mon_generic_request *req;
+	size_t wsize = strlen(what);
 
 	req = alloc_generic_request(monc, GFP_NOIO);
 	if (!req)
 		goto err_put_req;
 
 	req->request = ceph_msg_new(CEPH_MSG_MON_GET_VERSION,
-				    sizeof(u64) + sizeof(u32) + strlen(what),
+				    sizeof(u64) + sizeof(u32) + wsize,
 				    GFP_NOIO, true);
 	if (!req->request)
 		goto err_put_req;
@@ -873,6 +875,8 @@ __ceph_monc_get_version(struct ceph_mon_client *monc, const char *what,
 	req->complete_cb = cb;
 	req->private_data = private_data;
 
+	BUG_ON(sizeof(__le64) + sizeof(__le32) + wsize > req->request->front_alloc_len);
+
 	mutex_lock(&monc->mutex);
 	register_generic_request(req);
 	{
@@ -880,7 +884,7 @@ __ceph_monc_get_version(struct ceph_mon_client *monc, const char *what,
 		void *const end = p + req->request->front_alloc_len;
 
 		ceph_encode_64(&p, req->tid); /* handle */
-		ceph_encode_string(&p, end, what, strlen(what));
+		ceph_encode_string(&p, what, wsize);
 		WARN_ON(p != end);
 	}
 	send_generic_request(monc, req);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index c4525feb8e26..b4adb299f9cd 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1831,15 +1831,15 @@ static int hoid_encoding_size(const struct ceph_hobject_id *hoid)
 	       4 + hoid->key_len + 4 + hoid->oid_len + 4 + hoid->nspace_len;
 }
 
-static void encode_hoid(void **p, void *end, const struct ceph_hobject_id *hoid)
+static void encode_hoid(void **p, const struct ceph_hobject_id *hoid)
 {
 	ceph_start_encoding(p, 4, 3, hoid_encoding_size(hoid));
-	ceph_encode_string(p, end, hoid->key, hoid->key_len);
-	ceph_encode_string(p, end, hoid->oid, hoid->oid_len);
+	ceph_encode_string(p, hoid->key, hoid->key_len);
+	ceph_encode_string(p, hoid->oid, hoid->oid_len);
 	ceph_encode_64(p, hoid->snapid);
 	ceph_encode_32(p, hoid->hash);
 	ceph_encode_8(p, hoid->is_max);
-	ceph_encode_string(p, end, hoid->nspace, hoid->nspace_len);
+	ceph_encode_string(p, hoid->nspace, hoid->nspace_len);
 	ceph_encode_64(p, hoid->pool);
 }
 
@@ -2072,16 +2072,14 @@ static void encode_spgid(void **p, const struct ceph_spg *spgid)
 	ceph_encode_8(p, spgid->shard);
 }
 
-static void encode_oloc(void **p, void *end,
-			const struct ceph_object_locator *oloc)
+static void encode_oloc(void **p, const struct ceph_object_locator *oloc)
 {
 	ceph_start_encoding(p, 5, 4, ceph_oloc_encoding_size(oloc));
 	ceph_encode_64(p, oloc->pool);
 	ceph_encode_32(p, -1); /* preferred */
 	ceph_encode_32(p, 0);  /* key len */
 	if (oloc->pool_ns)
-		ceph_encode_string(p, end, oloc->pool_ns->str,
-				   oloc->pool_ns->len);
+		ceph_encode_string(p, oloc->pool_ns->str, oloc->pool_ns->len);
 	else
 		ceph_encode_32(p, 0);
 }
@@ -2122,8 +2120,8 @@ static void encode_request_partial(struct ceph_osd_request *req,
 	ceph_encode_timespec64(p, &req->r_mtime);
 	p += sizeof(struct ceph_timespec);
 
-	encode_oloc(&p, end, &req->r_t.target_oloc);
-	ceph_encode_string(&p, end, req->r_t.target_oid.name,
+	encode_oloc(&p, &req->r_t.target_oloc);
+	ceph_encode_string(&p, req->r_t.target_oid.name,
 			   req->r_t.target_oid.name_len);
 
 	/* ops, can imply data */
@@ -4329,8 +4327,8 @@ static struct ceph_msg *create_backoff_message(
 	ceph_encode_32(&p, map_epoch);
 	ceph_encode_8(&p, CEPH_OSD_BACKOFF_OP_ACK_BLOCK);
 	ceph_encode_64(&p, backoff->id);
-	encode_hoid(&p, end, backoff->begin);
-	encode_hoid(&p, end, backoff->end);
+	encode_hoid(&p, backoff->begin);
+	encode_hoid(&p, backoff->end);
 	BUG_ON(p != end);
 
 	msg->front.iov_len = p - msg->front.iov_base;
@@ -5264,8 +5262,8 @@ int osd_req_op_copy_from_init(struct ceph_osd_request *req,
 
 	p = page_address(pages[0]);
 	end = p + PAGE_SIZE;
-	ceph_encode_string(&p, end, src_oid->name, src_oid->name_len);
-	encode_oloc(&p, end, src_oloc);
+	ceph_encode_string(&p, src_oid->name, src_oid->name_len);
+	encode_oloc(&p, src_oloc);
 	ceph_encode_32(&p, truncate_seq);
 	ceph_encode_64(&p, truncate_size);
 	op->indata_len = PAGE_SIZE - (end - p);


