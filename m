Return-Path: <linux-fsdevel+bounces-43957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA208A60587
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 00:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2037A4213C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 23:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B2B1FECD4;
	Thu, 13 Mar 2025 23:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FPVXXWXt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DA61FECA2
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 23:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908868; cv=none; b=ehCd4apaRf8xE18RR1FJzse4JJMVbNtpw0TssfFB5iwWThCfafwPLs8ID/kuXSIFNN1zlZ0HGXperxR4dqsflW8nhk+i7kt6YKBiVGFKFks0L7FsUGhKT1lFiimCa2PB5tFsr5h/ltuo4JaOuN4EYpQRllqr3WHcv7SjvHmTT3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908868; c=relaxed/simple;
	bh=+sr01K5oPvodn2YTEK+84j3VIa1heezoCkpS6TEEYWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1EKPVueBbiOf+j5P1zJ1otUEqXX6D0JniI81Zqk0q31uOYRkNLE1bC/7T+B6gBMTBxyhto0MpxsmAIecll7DYCFgbNWf13+vNeCj1GEnsLIBHS9tYjYUxzParCVJ1ztDSPsTc+kI5uxWuvpXsZ7udROHrhrsTywiGDyYEJX8mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FPVXXWXt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OtHeyZXbJzwFdbyx00ozzozwEOHhSdJdgcRqDuoiMJw=;
	b=FPVXXWXtg3/2xpmWv+BJkxVytoRDyXyrc+DqYRO5lXHZ9Fbv8afTyZeaMNtHRbcwpC6R0R
	2ZrguHTDa7Qh4X6KoLEtgotLsSTv9BTu8iWN4Hq7CceZWnaBTN3iBNka7rf8xXjdf7WK1W
	N0ViqYUJhuDIWvDeHVinpm/XTNDRpxU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-LkokaXSAPJWj8EmEgOthtg-1; Thu,
 13 Mar 2025 19:34:22 -0400
X-MC-Unique: LkokaXSAPJWj8EmEgOthtg-1
X-Mimecast-MFC-AGG-ID: LkokaXSAPJWj8EmEgOthtg_1741908861
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1830419560B2;
	Thu, 13 Mar 2025 23:34:21 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7D4EF1955BCB;
	Thu, 13 Mar 2025 23:34:18 +0000 (UTC)
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
Subject: [RFC PATCH 08/35] libceph: Unexport osd_req_op_cls_request_data_pages()
Date: Thu, 13 Mar 2025 23:33:00 +0000
Message-ID: <20250313233341.1675324-9-dhowells@redhat.com>
In-Reply-To: <20250313233341.1675324-1-dhowells@redhat.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Unexport osd_req_op_cls_request_data_pages() as it's not used outside of
the file in which it is defined and it will be replaced.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 include/linux/ceph/osd_client.h | 5 -----
 net/ceph/osd_client.c           | 3 +--
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 57b8aff53f28..60f28fc0238b 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -521,11 +521,6 @@ void osd_req_op_cls_request_databuf(struct ceph_osd_request *req,
 extern void osd_req_op_cls_request_data_pagelist(struct ceph_osd_request *,
 					unsigned int which,
 					struct ceph_pagelist *pagelist);
-extern void osd_req_op_cls_request_data_pages(struct ceph_osd_request *,
-					unsigned int which,
-					struct page **pages, u64 length,
-					u32 offset, bool pages_from_pool,
-					bool own_pages);
 void osd_req_op_cls_request_data_bvecs(struct ceph_osd_request *osd_req,
 				       unsigned int which,
 				       struct bio_vec *bvecs, u32 num_bvecs,
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index b6cf875d3de4..10827b1227e4 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -347,7 +347,7 @@ void osd_req_op_cls_request_data_pagelist(
 }
 EXPORT_SYMBOL(osd_req_op_cls_request_data_pagelist);
 
-void osd_req_op_cls_request_data_pages(struct ceph_osd_request *osd_req,
+static void osd_req_op_cls_request_data_pages(struct ceph_osd_request *osd_req,
 			unsigned int which, struct page **pages, u64 length,
 			u32 offset, bool pages_from_pool, bool own_pages)
 {
@@ -359,7 +359,6 @@ void osd_req_op_cls_request_data_pages(struct ceph_osd_request *osd_req,
 	osd_req->r_ops[which].cls.indata_len += length;
 	osd_req->r_ops[which].indata_len += length;
 }
-EXPORT_SYMBOL(osd_req_op_cls_request_data_pages);
 
 void osd_req_op_cls_request_data_bvecs(struct ceph_osd_request *osd_req,
 				       unsigned int which,


