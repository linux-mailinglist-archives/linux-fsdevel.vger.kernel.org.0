Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DFA7700FB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 15:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjHDNPv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 09:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjHDNPt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:15:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DC049F3
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 06:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691154826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nK+6S5TQSOROUKofSZxk0bUWlSH0idxuyqDla86u+E0=;
        b=djLVXWTPnng7og66s5cbCiX8h4U1t0bjNs8vFWFCaNO+4zvDoXXJmW/+IvKZX8kybXcR++
        yqjesRuhkv4bhJW6/egM3VqJjxOHhCuN7UNayMNbAqgIhCBWn9Vzy6sSJ8dGW4P4dXiCp5
        pveWt5SbLG8zIZO8L2PUUkVrj/g0nDw=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-523-igfYme5DNIumTow1k6A3tA-1; Fri, 04 Aug 2023 09:13:45 -0400
X-MC-Unique: igfYme5DNIumTow1k6A3tA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 428F42815E37;
        Fri,  4 Aug 2023 13:13:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2463E1121325;
        Fri,  4 Aug 2023 13:13:44 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 07/18] ceph: Unexport osd_req_op_cls_request_data_pages()
Date:   Fri,  4 Aug 2023 14:13:16 +0100
Message-ID: <20230804131327.2574082-8-dhowells@redhat.com>
In-Reply-To: <20230804131327.2574082-1-dhowells@redhat.com>
References: <20230804131327.2574082-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Unexport osd_req_op_cls_request_data_pages() as it's not used outside of
the file in which it is defined and it will be replaced.

Signed-off-by: David Howells <dhowells@redhat.com>
---
 include/linux/ceph/osd_client.h | 5 -----
 net/ceph/osd_client.c           | 3 +--
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 0e008837dac1..e1533f3314ad 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -522,11 +522,6 @@ void osd_req_op_cls_request_databuf(struct ceph_osd_request *req,
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
index 7ce3aef55755..2ba6f2ce5fb6 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -344,7 +344,7 @@ void osd_req_op_cls_request_data_pagelist(
 }
 EXPORT_SYMBOL(osd_req_op_cls_request_data_pagelist);
 
-void osd_req_op_cls_request_data_pages(struct ceph_osd_request *osd_req,
+static void osd_req_op_cls_request_data_pages(struct ceph_osd_request *osd_req,
 			unsigned int which, struct page **pages, u64 length,
 			u32 offset, bool pages_from_pool, bool own_pages)
 {
@@ -356,7 +356,6 @@ void osd_req_op_cls_request_data_pages(struct ceph_osd_request *osd_req,
 	osd_req->r_ops[which].cls.indata_len += length;
 	osd_req->r_ops[which].indata_len += length;
 }
-EXPORT_SYMBOL(osd_req_op_cls_request_data_pages);
 
 void osd_req_op_cls_request_data_bvecs(struct ceph_osd_request *osd_req,
 				       unsigned int which,

