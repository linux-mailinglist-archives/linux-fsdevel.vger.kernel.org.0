Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C87770117
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 15:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjHDNQY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 09:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbjHDNQC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:16:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4CA4C0C
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 06:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691154831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZWOuVJIT1Pwo2B0GRSCvc5+DgJbRTHYNpPmayB6g4MA=;
        b=dl5oWK/qcxh0ncOn8txTOGqnmAhDU6EVVL4Il78NNYcDu8e75b3/ge2B3ECuDMADQaCMtc
        fsJBVSan+JojXwlaBqVDnjxyUPctgo9xVRZpKOiuM8kBfZ5F37tVJeNcSPQ1NutrQbBTQU
        qiiuSlFb5yNuB5g6cZpXd1EvQ6Nu+Pc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-78-2c7T28m4MdWkpxVj50pZ1Q-1; Fri, 04 Aug 2023 09:13:50 -0400
X-MC-Unique: 2c7T28m4MdWkpxVj50pZ1Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFD738564EF;
        Fri,  4 Aug 2023 13:13:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48D5A477F63;
        Fri,  4 Aug 2023 13:13:48 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 09/18] ceph: Convert notify_id_pages to a ceph_databuf
Date:   Fri,  4 Aug 2023 14:13:18 +0100
Message-ID: <20230804131327.2574082-10-dhowells@redhat.com>
In-Reply-To: <20230804131327.2574082-1-dhowells@redhat.com>
References: <20230804131327.2574082-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert linger->notify_id_pages to a ceph_databuf

Signed-off-by: David Howells <dhowells@redhat.com>
---
 include/linux/ceph/osd_client.h |  2 +-
 net/ceph/osd_client.c           | 18 +++++++-----------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 0b02e272acc2..780bd49d2734 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -348,7 +348,7 @@ struct ceph_osd_linger_request {
 	void *data;
 
 	struct ceph_pagelist *request_pl;
-	struct page **notify_id_pages;
+	struct ceph_databuf *notify_id_buf;
 
 	struct page ***preply_pages;
 	size_t *preply_len;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index aa9d07221149..02c35785ec28 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -2825,11 +2825,8 @@ static void linger_release(struct kref *kref)
 	WARN_ON(!list_empty(&lreq->pending_lworks));
 	WARN_ON(lreq->osd);
 
-	if (lreq->request_pl)
-		ceph_pagelist_release(lreq->request_pl);
-	if (lreq->notify_id_pages)
-		ceph_release_page_vector(lreq->notify_id_pages, 1);
-
+	ceph_pagelist_release(lreq->request_pl);
+	ceph_databuf_release(lreq->notify_id_buf);
 	ceph_osdc_put_request(lreq->reg_req);
 	ceph_osdc_put_request(lreq->ping_req);
 	target_destroy(&lreq->t);
@@ -3210,9 +3207,9 @@ static void send_linger(struct ceph_osd_linger_request *lreq)
 			refcount_inc(&lreq->request_pl->refcnt);
 			osd_req_op_notify_init(req, 0, lreq->linger_id,
 					       lreq->request_pl);
-			ceph_osd_data_pages_init(
+			ceph_osd_databuf_init(
 			    osd_req_op_data(req, 0, notify, response_data),
-			    lreq->notify_id_pages, PAGE_SIZE, 0, false, false);
+			    lreq->notify_id_buf);
 		}
 		dout("lreq %p register\n", lreq);
 		req->r_callback = linger_commit_cb;
@@ -4995,10 +4992,9 @@ int ceph_osdc_notify(struct ceph_osd_client *osdc,
 	}
 
 	/* for notify_id */
-	lreq->notify_id_pages = ceph_alloc_page_vector(1, GFP_NOIO);
-	if (IS_ERR(lreq->notify_id_pages)) {
-		ret = PTR_ERR(lreq->notify_id_pages);
-		lreq->notify_id_pages = NULL;
+	lreq->notify_id_buf = ceph_databuf_alloc(1, PAGE_SIZE, GFP_NOIO);
+	if (!lreq->notify_id_buf) {
+		ret = -ENOMEM;
 		goto out_put_lreq;
 	}
 

