Return-Path: <linux-fsdevel+bounces-43970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE48A605BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 00:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930C1421A4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 23:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15931204C03;
	Thu, 13 Mar 2025 23:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0KlkZX2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58EF204695
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 23:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908916; cv=none; b=JU6A2Gf2ZJaz/YmR5zNgmBWH1+ou75CfiwlFbsX0xPuOFxNKIOWkRAzNkPdPxxOcypPwvtfPlD8JEX8YOsPEm8qVqoyw8uk+nYhjFBSyEdgsfQeH3KeC//MenOyPapmdgdWN8bN2Z8c5CORx4cILd0NGT5YUxuFJTLSMJNg9BJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908916; c=relaxed/simple;
	bh=SIRF3c+W95g4vAKDgABYo1J0Uf6hNOLvdEFtKJ+MwOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEcG77JUoSlQLxjtNLqAfArJaNH/CQzuducSkOKtx2unczciOYQ3lkPCmZ6efLp09S7fl5kOGnenh8EVK6GUmPekWU8ISfoolufFXdWEWsBTVC3imc6Jb6sTWIhWdSgtAEWGsVxdpBKcNB1emUZ62PRgaZvbtkp07NwASeWHSb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g0KlkZX2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m4Ip384RhgQAfEUHcpHjr8S8u0Z7qUgyqfCla2grBlE=;
	b=g0KlkZX2OIg+/5PFfqn5c+XinfIJoGDvnfU1wxj0bfGQCVYSgaE6EDYAs7Gy38o/xoCAn8
	7bfgmcC5gOQSVGhWGP90R/mvElntZc4afZO8hGED/EpPN1qvQ3qW0flSOVBRJWH2U42eqN
	e/ngoIHV/D1eTnGxH7HD+kPxS+0ncdo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-mYGjWPVuMhaRJvRUnFsaSg-1; Thu,
 13 Mar 2025 19:35:10 -0400
X-MC-Unique: mYGjWPVuMhaRJvRUnFsaSg-1
X-Mimecast-MFC-AGG-ID: mYGjWPVuMhaRJvRUnFsaSg_1741908908
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79693195608B;
	Thu, 13 Mar 2025 23:35:08 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E4FA819560AB;
	Thu, 13 Mar 2025 23:35:05 +0000 (UTC)
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
Subject: [RFC PATCH 21/35] libceph: Make notify code use ceph_databuf_enc_start/stop
Date: Thu, 13 Mar 2025 23:33:13 +0000
Message-ID: <20250313233341.1675324-22-dhowells@redhat.com>
In-Reply-To: <20250313233341.1675324-1-dhowells@redhat.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Make the ceph_osdc_notify*() functions use ceph_databuf_enc_start() and
ceph_databuf_enc_stop() when filling out the request data.  Also use
ceph_encode_*() rather than ceph_databuf_encode_*() as the latter will do
an iterator copy to deal with page crossing and misalignment (the latter
being something that the CPU will handle on some arches).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 net/ceph/osd_client.c | 55 +++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 0ac439e7e730..1a0cb2cdcc52 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -4759,7 +4759,10 @@ static int osd_req_op_notify_ack_init(struct ceph_osd_request *req, int which,
 {
 	struct ceph_osd_req_op *op;
 	struct ceph_databuf *dbuf;
-	int ret;
+	void *p;
+
+	if (!payload)
+		payload_len = 0;
 
 	op = osd_req_op_init(req, which, CEPH_OSD_OP_NOTIFY_ACK, 0);
 
@@ -4767,18 +4770,13 @@ static int osd_req_op_notify_ack_init(struct ceph_osd_request *req, int which,
 	if (!dbuf)
 		return -ENOMEM;
 
-	ret = ceph_databuf_encode_64(dbuf, notify_id);
-	ret |= ceph_databuf_encode_64(dbuf, cookie);
-	if (payload) {
-		ret |= ceph_databuf_encode_32(dbuf, payload_len);
-		ret |= ceph_databuf_append(dbuf, payload, payload_len);
-	} else {
-		ret |= ceph_databuf_encode_32(dbuf, 0);
-	}
-	if (ret) {
-		ceph_databuf_release(dbuf);
-		return -ENOMEM;
-	}
+	p = ceph_databuf_enc_start(dbuf);
+	ceph_encode_64(&p, notify_id);
+	ceph_encode_64(&p, cookie);
+	ceph_encode_32(&p, payload_len);
+	if (payload)
+		ceph_encode_copy(&p, payload, payload_len);
+	ceph_databuf_enc_stop(dbuf, p);
 
 	ceph_osd_databuf_init(&op->notify_ack.request_data, dbuf);
 	op->indata_len = ceph_databuf_len(dbuf);
@@ -4840,8 +4838,12 @@ int ceph_osdc_notify(struct ceph_osd_client *osdc,
 		     size_t *preply_len)
 {
 	struct ceph_osd_linger_request *lreq;
+	void *p;
 	int ret;
 
+	if (WARN_ON_ONCE(payload_len > PAGE_SIZE - 3 * 4))
+		return -EIO;
+
 	WARN_ON(!timeout);
 	if (preply_pages) {
 		*preply_pages = NULL;
@@ -4852,20 +4854,19 @@ int ceph_osdc_notify(struct ceph_osd_client *osdc,
 	if (!lreq)
 		return -ENOMEM;
 
-	lreq->request_pl = ceph_databuf_req_alloc(1, PAGE_SIZE, GFP_NOIO);
+	lreq->request_pl = ceph_databuf_req_alloc(0, 3 * 4 + payload_len,
+						  GFP_NOIO);
 	if (!lreq->request_pl) {
 		ret = -ENOMEM;
 		goto out_put_lreq;
 	}
 
-	ret = ceph_databuf_encode_32(lreq->request_pl, 1); /* prot_ver */
-	ret |= ceph_databuf_encode_32(lreq->request_pl, timeout);
-	ret |= ceph_databuf_encode_32(lreq->request_pl, payload_len);
-	ret |= ceph_databuf_append(lreq->request_pl, payload, payload_len);
-	if (ret) {
-		ret = -ENOMEM;
-		goto out_put_lreq;
-	}
+	p = ceph_databuf_enc_start(lreq->request_pl);
+	ceph_encode_32(&p, 1); /* prot_ver */
+	ceph_encode_32(&p, timeout);
+	ceph_encode_32(&p, payload_len);
+	ceph_encode_copy(&p, payload, payload_len);
+	ceph_databuf_enc_stop(lreq->request_pl, p);
 
 	/* for notify_id */
 	lreq->notify_id_buf = ceph_databuf_reply_alloc(1, PAGE_SIZE, GFP_NOIO);
@@ -5217,7 +5218,7 @@ int osd_req_op_copy_from_init(struct ceph_osd_request *req,
 {
 	struct ceph_osd_req_op *op;
 	struct ceph_databuf *dbuf;
-	void *p, *end;
+	void *p;
 
 	dbuf = ceph_databuf_req_alloc(1, PAGE_SIZE, GFP_KERNEL);
 	if (!dbuf)
@@ -5230,15 +5231,13 @@ int osd_req_op_copy_from_init(struct ceph_osd_request *req,
 	op->copy_from.flags = copy_from_flags;
 	op->copy_from.src_fadvise_flags = src_fadvise_flags;
 
-	p = kmap_ceph_databuf_page(dbuf, 0);
-	end = p + PAGE_SIZE;
+	p = ceph_databuf_enc_start(dbuf);
 	ceph_encode_string(&p, src_oid->name, src_oid->name_len);
 	encode_oloc(&p, src_oloc);
 	ceph_encode_32(&p, truncate_seq);
 	ceph_encode_64(&p, truncate_size);
-	op->indata_len = PAGE_SIZE - (end - p);
-	ceph_databuf_added_data(dbuf, op->indata_len);
-	kunmap_local(p);
+	ceph_databuf_enc_stop(dbuf, p);
+	op->indata_len = ceph_databuf_len(dbuf);
 
 	ceph_osd_databuf_init(&op->copy_from.osd_data, dbuf);
 	return 0;


