Return-Path: <linux-fsdevel+bounces-43968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C6EA605B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 00:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3CBE881B68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 23:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BD420409F;
	Thu, 13 Mar 2025 23:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXkg6RRH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859BF2036ED
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 23:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908911; cv=none; b=F25csavrWPvMHtuFTj7FIoaBAXooguDMRmenrEjlfFvewSDosCmElT1bo6qO1G5EFlWsdHaX5p/6ZzvLXnAkLrlvfQ379UQ3is5D5zKKQJ7U9BRoSmHr+PjRnSfZ8E+lhp1uxNpaBS11VYFPCuhKIe7LARJxhmMfQrqBZfrfSwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908911; c=relaxed/simple;
	bh=12VyivBnSOi6WpeW/ZATShWFHykmsWSaTDt/u9iTSAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWaro8QUkj/lVozZzEQn0xoZI3iWRwVNtKuUMmeI767LeS9zHwxQJ/+bRDAeoMjLrMwtUhGvyQXYoDBI6tgjEONOaGZNxGD4tFmPR6PQMr0DjWXzEYoCLG6lp+kvR1J9NptKTsxSgvSro5Q+6qiEttDZX9P0Z21kv8I0/Hxa16U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IXkg6RRH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lvTo2jsjsdmIbdq+HLumkuZzukCMSYlux8xlKnsNe+k=;
	b=IXkg6RRHiwVOY/ITkFRe1pG85xGLfJ4WxgNojmFTu4QeIo0oWWGsf9hWumRhay0Bo01Zva
	DlC1ktRe5SJPxMz5K6+riessiXTrmHJpPN9JQKKp/RmvQuhmZ6sPz4tstrDbSqfjG+jJqt
	xIGzXFYBB+GCQkfAzfPtJ3e9J+MikdE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-wmIOUuDUOBidYfeKMuS_gA-1; Thu,
 13 Mar 2025 19:35:00 -0400
X-MC-Unique: wmIOUuDUOBidYfeKMuS_gA-1
X-Mimecast-MFC-AGG-ID: wmIOUuDUOBidYfeKMuS_gA_1741908897
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 451E31955DD0;
	Thu, 13 Mar 2025 23:34:57 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E98901955BCB;
	Thu, 13 Mar 2025 23:34:54 +0000 (UTC)
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
Subject: [RFC PATCH 18/35] libceph, rbd: Convert some page arrays to ceph_databuf
Date: Thu, 13 Mar 2025 23:33:10 +0000
Message-ID: <20250313233341.1675324-19-dhowells@redhat.com>
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

Convert some miscellaneous page arrays to ceph_databuf containers.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 drivers/block/rbd.c             | 12 ++++-----
 include/linux/ceph/osd_client.h |  3 +++
 net/ceph/osd_client.c           | 43 +++++++++++++++++++++------------
 3 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 078bb1e3e1da..eea12c7ab2a0 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2108,7 +2108,7 @@ static int rbd_obj_calc_img_extents(struct rbd_obj_request *obj_req,
 
 static int rbd_osd_setup_stat(struct ceph_osd_request *osd_req, int which)
 {
-	struct page **pages;
+	struct ceph_databuf *dbuf;
 
 	/*
 	 * The response data for a STAT call consists of:
@@ -2118,14 +2118,12 @@ static int rbd_osd_setup_stat(struct ceph_osd_request *osd_req, int which)
 	 *         le32 tv_nsec;
 	 *     } mtime;
 	 */
-	pages = ceph_alloc_page_vector(1, GFP_NOIO);
-	if (IS_ERR(pages))
-		return PTR_ERR(pages);
+	dbuf = ceph_databuf_reply_alloc(1, 8 + sizeof(struct ceph_timespec), GFP_NOIO);
+	if (!dbuf)
+		return -ENOMEM;
 
 	osd_req_op_init(osd_req, which, CEPH_OSD_OP_STAT, 0);
-	osd_req_op_raw_data_in_pages(osd_req, which, pages,
-				     8 + sizeof(struct ceph_timespec),
-				     0, false, true);
+	osd_req_op_raw_data_in_databuf(osd_req, which, dbuf);
 	return 0;
 }
 
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index d31e59bd128c..6e126e212271 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -482,6 +482,9 @@ extern void osd_req_op_extent_osd_data_pages(struct ceph_osd_request *,
 					struct page **pages, u64 length,
 					u32 offset, bool pages_from_pool,
 					bool own_pages);
+void osd_req_op_raw_data_in_databuf(struct ceph_osd_request *osd_req,
+				    unsigned int which,
+				    struct ceph_databuf *databuf);
 extern void osd_req_op_extent_osd_data_pagelist(struct ceph_osd_request *,
 					unsigned int which,
 					struct ceph_pagelist *pagelist);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index b4adb299f9cd..64a06267e7b3 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -182,6 +182,17 @@ osd_req_op_extent_osd_data(struct ceph_osd_request *osd_req,
 }
 EXPORT_SYMBOL(osd_req_op_extent_osd_data);
 
+void osd_req_op_raw_data_in_databuf(struct ceph_osd_request *osd_req,
+				    unsigned int which,
+				    struct ceph_databuf *dbuf)
+{
+	struct ceph_osd_data *osd_data;
+
+	osd_data = osd_req_op_raw_data_in(osd_req, which);
+	ceph_osd_databuf_init(osd_data, dbuf);
+}
+EXPORT_SYMBOL(osd_req_op_raw_data_in_databuf);
+
 void osd_req_op_raw_data_in_pages(struct ceph_osd_request *osd_req,
 			unsigned int which, struct page **pages,
 			u64 length, u32 offset,
@@ -5000,7 +5011,7 @@ int ceph_osdc_list_watchers(struct ceph_osd_client *osdc,
 			    u32 *num_watchers)
 {
 	struct ceph_osd_request *req;
-	struct page **pages;
+	struct ceph_databuf *dbuf;
 	int ret;
 
 	req = ceph_osdc_alloc_request(osdc, NULL, 1, false, GFP_NOIO);
@@ -5011,16 +5022,16 @@ int ceph_osdc_list_watchers(struct ceph_osd_client *osdc,
 	ceph_oloc_copy(&req->r_base_oloc, oloc);
 	req->r_flags = CEPH_OSD_FLAG_READ;
 
-	pages = ceph_alloc_page_vector(1, GFP_NOIO);
-	if (IS_ERR(pages)) {
-		ret = PTR_ERR(pages);
+	dbuf = ceph_databuf_reply_alloc(1, PAGE_SIZE, GFP_NOIO);
+	if (!dbuf) {
+		ret = -ENOMEM;
 		goto out_put_req;
 	}
 
 	osd_req_op_init(req, 0, CEPH_OSD_OP_LIST_WATCHERS, 0);
-	ceph_osd_data_pages_init(osd_req_op_data(req, 0, list_watchers,
-						 response_data),
-				 pages, PAGE_SIZE, 0, false, true);
+	ceph_osd_databuf_init(osd_req_op_data(req, 0, list_watchers,
+					      response_data),
+			      dbuf);
 
 	ret = ceph_osdc_alloc_messages(req, GFP_NOIO);
 	if (ret)
@@ -5029,10 +5040,11 @@ int ceph_osdc_list_watchers(struct ceph_osd_client *osdc,
 	ceph_osdc_start_request(osdc, req);
 	ret = ceph_osdc_wait_request(osdc, req);
 	if (ret >= 0) {
-		void *p = page_address(pages[0]);
+		void *p = kmap_ceph_databuf_page(dbuf, 0);
 		void *const end = p + req->r_ops[0].outdata_len;
 
 		ret = decode_watchers(&p, end, watchers, num_watchers);
+		kunmap(p);
 	}
 
 out_put_req:
@@ -5246,12 +5258,12 @@ int osd_req_op_copy_from_init(struct ceph_osd_request *req,
 			      u8 copy_from_flags)
 {
 	struct ceph_osd_req_op *op;
-	struct page **pages;
+	struct ceph_databuf *dbuf;
 	void *p, *end;
 
-	pages = ceph_alloc_page_vector(1, GFP_KERNEL);
-	if (IS_ERR(pages))
-		return PTR_ERR(pages);
+	dbuf = ceph_databuf_req_alloc(1, PAGE_SIZE, GFP_KERNEL);
+	if (!dbuf)
+		return -ENOMEM;
 
 	op = osd_req_op_init(req, 0, CEPH_OSD_OP_COPY_FROM2,
 			     dst_fadvise_flags);
@@ -5260,16 +5272,17 @@ int osd_req_op_copy_from_init(struct ceph_osd_request *req,
 	op->copy_from.flags = copy_from_flags;
 	op->copy_from.src_fadvise_flags = src_fadvise_flags;
 
-	p = page_address(pages[0]);
+	p = kmap_ceph_databuf_page(dbuf, 0);
 	end = p + PAGE_SIZE;
 	ceph_encode_string(&p, src_oid->name, src_oid->name_len);
 	encode_oloc(&p, src_oloc);
 	ceph_encode_32(&p, truncate_seq);
 	ceph_encode_64(&p, truncate_size);
 	op->indata_len = PAGE_SIZE - (end - p);
+	ceph_databuf_added_data(dbuf, op->indata_len);
+	kunmap_local(p);
 
-	ceph_osd_data_pages_init(&op->copy_from.osd_data, pages,
-				 op->indata_len, 0, false, true);
+	ceph_osd_databuf_init(&op->copy_from.osd_data, dbuf);
 	return 0;
 }
 EXPORT_SYMBOL(osd_req_op_copy_from_init);


