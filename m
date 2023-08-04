Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900CB7700FC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 15:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjHDNPw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 09:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjHDNPt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:15:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCB749E4
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 06:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691154826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/PSucnWQdCSSwhW59bqPEA79MtMmsRFldRQW3qSRU0U=;
        b=gyNPo7/QljuymfiR30r8aVx/dDczMvr+2DPYQHsXJnLOBdjVDxmMGq4ipehdqt/Kb0OgZv
        NAntFmzWsaRTCEHKEI7V0g5gjKQhiljOPUclDfrFy9OQiYsir0fyvy8O91Vx49Ze58hxpP
        VxXAW9ovfBnmHl+7Uyyu/N6XQxMjxb4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-UfFS_D__P02OO0SOFrv8qw-1; Fri, 04 Aug 2023 09:13:42 -0400
X-MC-Unique: UfFS_D__P02OO0SOFrv8qw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 950FD8022EF;
        Fri,  4 Aug 2023 13:13:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4AE8DF7FB6;
        Fri,  4 Aug 2023 13:13:40 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 05/18] rbd: Use ceph_databuf for rbd_obj_read_sync()
Date:   Fri,  4 Aug 2023 14:13:14 +0100
Message-ID: <20230804131327.2574082-6-dhowells@redhat.com>
In-Reply-To: <20230804131327.2574082-1-dhowells@redhat.com>
References: <20230804131327.2574082-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Supply a ceph_databuf to rbd_obj_read_sync() to convey the data.

Signed-off-by: David Howells <dhowells@redhat.com>
---
 drivers/block/rbd.c | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 08d0908d0583..2a161b03dd7a 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4762,13 +4762,10 @@ static void rbd_free_disk(struct rbd_device *rbd_dev)
 static int rbd_obj_read_sync(struct rbd_device *rbd_dev,
 			     struct ceph_object_id *oid,
 			     struct ceph_object_locator *oloc,
-			     void *buf, int buf_len)
-
+			     struct ceph_databuf *dbuf, int len)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
 	struct ceph_osd_request *req;
-	struct page **pages;
-	int num_pages = calc_pages_for(0, buf_len);
 	int ret;
 
 	req = ceph_osdc_alloc_request(osdc, NULL, 1, false, GFP_KERNEL);
@@ -4779,15 +4776,8 @@ static int rbd_obj_read_sync(struct rbd_device *rbd_dev,
 	ceph_oloc_copy(&req->r_base_oloc, oloc);
 	req->r_flags = CEPH_OSD_FLAG_READ;
 
-	pages = ceph_alloc_page_vector(num_pages, GFP_KERNEL);
-	if (IS_ERR(pages)) {
-		ret = PTR_ERR(pages);
-		goto out_req;
-	}
-
-	osd_req_op_extent_init(req, 0, CEPH_OSD_OP_READ, 0, buf_len, 0, 0);
-	osd_req_op_extent_osd_data_pages(req, 0, pages, buf_len, 0, false,
-					 true);
+	osd_req_op_extent_init(req, 0, CEPH_OSD_OP_READ, 0, len, 0, 0);
+	osd_req_op_extent_osd_databuf(req, 0, dbuf);
 
 	ret = ceph_osdc_alloc_messages(req, GFP_KERNEL);
 	if (ret)
@@ -4795,9 +4785,6 @@ static int rbd_obj_read_sync(struct rbd_device *rbd_dev,
 
 	ceph_osdc_start_request(osdc, req);
 	ret = ceph_osdc_wait_request(osdc, req);
-	if (ret >= 0)
-		ceph_copy_from_page_vector(pages, buf, 0, ret);
-
 out_req:
 	ceph_osdc_put_request(req);
 	return ret;
@@ -4810,12 +4797,18 @@ static int rbd_obj_read_sync(struct rbd_device *rbd_dev,
  */
 static int rbd_dev_v1_header_info(struct rbd_device *rbd_dev)
 {
-	struct rbd_image_header_ondisk *ondisk = NULL;
+	struct rbd_image_header_ondisk *ondisk;
+	struct ceph_databuf *dbuf = NULL;
 	u32 snap_count = 0;
 	u64 names_size = 0;
 	u32 want_count;
 	int ret;
 
+	dbuf = ceph_databuf_alloc(1, sizeof(*ondisk), GFP_KERNEL);
+	if (!dbuf)
+		return -ENOMEM;
+	ondisk = kmap_ceph_databuf_page(dbuf, 0);
+
 	/*
 	 * The complete header will include an array of its 64-bit
 	 * snapshot ids, followed by the names of those snapshots as
@@ -4826,17 +4819,18 @@ static int rbd_dev_v1_header_info(struct rbd_device *rbd_dev)
 	do {
 		size_t size;
 
-		kfree(ondisk);
-
 		size = sizeof (*ondisk);
 		size += snap_count * sizeof (struct rbd_image_snap_ondisk);
 		size += names_size;
-		ondisk = kmalloc(size, GFP_KERNEL);
-		if (!ondisk)
-			return -ENOMEM;
+
+		ret = -ENOMEM;
+		if (size > dbuf->limit &&
+		    ceph_databuf_reserve(dbuf, size - dbuf->limit,
+					 GFP_KERNEL) < 0)
+			goto out;
 
 		ret = rbd_obj_read_sync(rbd_dev, &rbd_dev->header_oid,
-					&rbd_dev->header_oloc, ondisk, size);
+					&rbd_dev->header_oloc, dbuf, size);
 		if (ret < 0)
 			goto out;
 		if ((size_t)ret < size) {
@@ -4845,6 +4839,7 @@ static int rbd_dev_v1_header_info(struct rbd_device *rbd_dev)
 				size, ret);
 			goto out;
 		}
+
 		if (!rbd_dev_ondisk_valid(ondisk)) {
 			ret = -ENXIO;
 			rbd_warn(rbd_dev, "invalid header");
@@ -4858,8 +4853,8 @@ static int rbd_dev_v1_header_info(struct rbd_device *rbd_dev)
 
 	ret = rbd_header_from_disk(rbd_dev, ondisk);
 out:
-	kfree(ondisk);
-
+	kunmap_local(ondisk);
+	ceph_databuf_release(dbuf);
 	return ret;
 }
 

