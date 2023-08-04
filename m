Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4A9770100
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 15:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjHDNP6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 09:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjHDNP4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:15:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32944C12
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 06:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691154834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gbjb/YYdIOUUhZdLEroEhaRlSVdUPTLF9fvAMDU2jQ8=;
        b=S6CFu2+selPRAPpR1bTBnZuWF9foVCIC9LOSG//pBqK+huJR/b3wr1UASeHTmBV9CDJ5YK
        S9XholejuWn4Grw8NDbsXSVBbbAMl5y/zed92WokacK8bo7EOCBm9yoI8CEfA7bCkbvvx9
        m/nv8mRQIoG6vUDT5RN9x0DRo20JWlA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-BJ1T9Z3_MXqFOhJ9Rx3dIg-1; Fri, 04 Aug 2023 09:13:48 -0400
X-MC-Unique: BJ1T9Z3_MXqFOhJ9Rx3dIg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8ED88104458D;
        Fri,  4 Aug 2023 13:13:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFBFCC5796B;
        Fri,  4 Aug 2023 13:13:45 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 08/18] ceph: Remove osd_req_op_cls_response_data_pages()
Date:   Fri,  4 Aug 2023 14:13:17 +0100
Message-ID: <20230804131327.2574082-9-dhowells@redhat.com>
In-Reply-To: <20230804131327.2574082-1-dhowells@redhat.com>
References: <20230804131327.2574082-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove osd_req_op_cls_response_data_pages() as it's no longer used.

Signed-off-by: David Howells <dhowells@redhat.com>
---
 include/linux/ceph/osd_client.h |  5 -----
 net/ceph/osd_client.c           | 12 ------------
 2 files changed, 17 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index e1533f3314ad..0b02e272acc2 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -529,11 +529,6 @@ void osd_req_op_cls_request_data_bvecs(struct ceph_osd_request *osd_req,
 void osd_req_op_cls_response_databuf(struct ceph_osd_request *osd_req,
 				     unsigned int which,
 				     struct ceph_databuf *dbuf);
-extern void osd_req_op_cls_response_data_pages(struct ceph_osd_request *,
-					unsigned int which,
-					struct page **pages, u64 length,
-					u32 offset, bool pages_from_pool,
-					bool own_pages);
 int osd_req_op_cls_init(struct ceph_osd_request *osd_req, unsigned int which,
 			const char *class, const char *method);
 extern int osd_req_op_xattr_init(struct ceph_osd_request *osd_req, unsigned int which,
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 2ba6f2ce5fb6..aa9d07221149 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -386,18 +386,6 @@ void osd_req_op_cls_response_databuf(struct ceph_osd_request *osd_req,
 }
 EXPORT_SYMBOL(osd_req_op_cls_response_databuf);
 
-void osd_req_op_cls_response_data_pages(struct ceph_osd_request *osd_req,
-			unsigned int which, struct page **pages, u64 length,
-			u32 offset, bool pages_from_pool, bool own_pages)
-{
-	struct ceph_osd_data *osd_data;
-
-	osd_data = osd_req_op_data(osd_req, which, cls, response_data);
-	ceph_osd_data_pages_init(osd_data, pages, length, offset,
-				pages_from_pool, own_pages);
-}
-EXPORT_SYMBOL(osd_req_op_cls_response_data_pages);
-
 static u64 ceph_osd_data_length(struct ceph_osd_data *osd_data)
 {
 	switch (osd_data->type) {

