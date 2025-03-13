Return-Path: <linux-fsdevel+bounces-43964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC836A605A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 00:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E01D881AF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 23:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D768A201259;
	Thu, 13 Mar 2025 23:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fgtu75Aq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69695201035
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 23:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908895; cv=none; b=R7ay/u++7YCvDb2lecwA4KynDtQQPaMyaa2EkTlzyjnpfwtPWygSlsJ8nvkGLI8O4HPMQJxczkBwPJzKGES01aXuBQSMS4s+nxUJuqVg+Pcdk2XyGZCxoD3FTUTNB1fKxZiR5CdDNuv4CRfKqwSoMxFVP0f/0eAX6X40B36Z8uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908895; c=relaxed/simple;
	bh=dgaJKJPLu+2m9DfyFnPJ/5d+sJeqh9WzlokmjF3zf3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUaBPwOXLGHVAh7iyzq1QGG9nUszP+7MPmpJvj5sW3ey0xI0LYwnDsl1/7nmFNAtJWXL7Jqpbw6o3saIo5hj7vf+hgid7S/CctmDOKMHi4mmdRdUR3FmLr5li204CitWNipe/whhAQaMHmMCN0/bAjSgv/FieP4P+RyC1O18Yus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fgtu75Aq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBEmQI/3EJ1uZKgrd77H/O1zAeWoD9Sx9X2aQy7MD78=;
	b=Fgtu75AqCNJ7jmUxy/cAOVho6aTNaVcnZKmA9wGXJc4TCScGwONm7nk1stiXmdC/yKww2E
	YcjxF9K5SAVLL0+iet1DoXgatjQjMFOPmashEkTvfKv74cgpJXSqTLYAkKKTzvMbJnDF+0
	1iW+FBM2rBDLE+scZ42jT0dN9aKgPek=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-wUzYjETROGCpdz79VYS9tw-1; Thu,
 13 Mar 2025 19:34:48 -0400
X-MC-Unique: wUzYjETROGCpdz79VYS9tw-1
X-Mimecast-MFC-AGG-ID: wUzYjETROGCpdz79VYS9tw_1741908886
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87AEA180AF4C;
	Thu, 13 Mar 2025 23:34:46 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 50D1E1800945;
	Thu, 13 Mar 2025 23:34:44 +0000 (UTC)
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
Subject: [RFC PATCH 15/35] libceph: Make osd_req_op_cls_init() use a ceph_databuf and map it
Date: Thu, 13 Mar 2025 23:33:07 +0000
Message-ID: <20250313233341.1675324-16-dhowells@redhat.com>
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

Make osd_req_op_cls_init() use a ceph_databuf to hold the request_info data
and then map it and write directly into it rather than using the databuf
encode functions.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 net/ceph/osd_client.c | 55 +++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 33 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 10f65e9b1906..405ccf7e7a91 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -245,14 +245,14 @@ void osd_req_op_extent_osd_iter(struct ceph_osd_request *osd_req,
 }
 EXPORT_SYMBOL(osd_req_op_extent_osd_iter);
 
-static void osd_req_op_cls_request_info_pagelist(
-			struct ceph_osd_request *osd_req,
-			unsigned int which, struct ceph_pagelist *pagelist)
+static void osd_req_op_cls_request_info_databuf(struct ceph_osd_request *osd_req,
+						unsigned int which,
+						struct ceph_databuf *dbuf)
 {
 	struct ceph_osd_data *osd_data;
 
 	osd_data = osd_req_op_data(osd_req, which, cls, request_info);
-	ceph_osd_data_pagelist_init(osd_data, pagelist);
+	ceph_osd_databuf_init(osd_data, dbuf);
 }
 
 void osd_req_op_cls_request_databuf(struct ceph_osd_request *osd_req,
@@ -778,42 +778,31 @@ int osd_req_op_cls_init(struct ceph_osd_request *osd_req, unsigned int which,
 			const char *class, const char *method)
 {
 	struct ceph_osd_req_op *op;
-	struct ceph_pagelist *pagelist;
-	size_t payload_len = 0;
-	size_t size;
-	int ret;
+	struct ceph_databuf *dbuf;
+	size_t csize = strlen(class), msize = strlen(method);
+	void *p;
+
+	BUG_ON(csize > (size_t) U8_MAX);
+	BUG_ON(msize > (size_t) U8_MAX);
 
 	op = osd_req_op_init(osd_req, which, CEPH_OSD_OP_CALL, 0);
+	op->cls.class_name = class;
+	op->cls.class_len  = csize;
+	op->cls.method_name = method;
+	op->cls.method_len  = msize;
 
-	pagelist = ceph_pagelist_alloc(GFP_NOFS);
-	if (!pagelist)
+	dbuf = ceph_databuf_req_alloc(1, PAGE_SIZE, GFP_NOFS);
+	if (!dbuf)
 		return -ENOMEM;
 
-	op->cls.class_name = class;
-	size = strlen(class);
-	BUG_ON(size > (size_t) U8_MAX);
-	op->cls.class_len = size;
-	ret = ceph_pagelist_append(pagelist, class, size);
-	if (ret)
-		goto err_pagelist_free;
-	payload_len += size;
-
-	op->cls.method_name = method;
-	size = strlen(method);
-	BUG_ON(size > (size_t) U8_MAX);
-	op->cls.method_len = size;
-	ret = ceph_pagelist_append(pagelist, method, size);
-	if (ret)
-		goto err_pagelist_free;
-	payload_len += size;
+	p = ceph_databuf_enc_start(dbuf);
+	ceph_encode_copy(&p, class, csize);
+	ceph_encode_copy(&p, method, msize);
+	ceph_databuf_enc_stop(dbuf, p);
 
-	osd_req_op_cls_request_info_pagelist(osd_req, which, pagelist);
-	op->indata_len = payload_len;
+	osd_req_op_cls_request_info_databuf(osd_req, which, dbuf);
+	op->indata_len = ceph_databuf_len(dbuf);
 	return 0;
-
-err_pagelist_free:
-	ceph_pagelist_release(pagelist);
-	return ret;
 }
 EXPORT_SYMBOL(osd_req_op_cls_init);
 


