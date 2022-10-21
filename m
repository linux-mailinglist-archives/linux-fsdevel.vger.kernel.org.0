Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128EA6072E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 10:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiJUIuM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 04:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiJUIuF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:50:05 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7F624FEE8;
        Fri, 21 Oct 2022 01:49:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VSikm2i_1666342154;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VSikm2i_1666342154)
          by smtp.aliyun-inc.com;
          Fri, 21 Oct 2022 16:49:16 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org
Cc:     jlayton@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] erofs: use netfs helpers manipulating request and subrequest
Date:   Fri, 21 Oct 2022 16:49:12 +0800
Message-Id: <20221021084912.61468-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20221021084912.61468-1-jefflexu@linux.alibaba.com>
References: <20221021084912.61468-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use netfs_put_subrequest() and netfs_rreq_completed() completing request
and subrequest.

It is worth noting that a noop netfs_request_ops is introduced for erofs
since some netfs routine, e.g. netfs_free_request(), will call into
this ops.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 47 ++++++++++------------------------------------
 1 file changed, 10 insertions(+), 37 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index fe05bc51f9f2..fa3f4ab5e3b6 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2022, Bytedance Inc. All rights reserved.
  */
 #include <linux/fscache.h>
+#include <trace/events/netfs.h>
 #include "internal.h"
 
 static DEFINE_MUTEX(erofs_domain_list_lock);
@@ -11,6 +12,8 @@ static DEFINE_MUTEX(erofs_domain_cookies_lock);
 static LIST_HEAD(erofs_domain_list);
 static struct vfsmount *erofs_pseudo_mnt;
 
+static const struct netfs_request_ops erofs_noop_req_ops;
+
 static struct netfs_io_request *erofs_fscache_alloc_request(struct address_space *mapping,
 					     loff_t start, size_t len)
 {
@@ -24,40 +27,12 @@ static struct netfs_io_request *erofs_fscache_alloc_request(struct address_space
 	rreq->len	= len;
 	rreq->mapping	= mapping;
 	rreq->inode	= mapping->host;
+	rreq->netfs_ops	= &erofs_noop_req_ops;
 	INIT_LIST_HEAD(&rreq->subrequests);
 	refcount_set(&rreq->ref, 1);
 	return rreq;
 }
 
-static void erofs_fscache_put_request(struct netfs_io_request *rreq)
-{
-	if (!refcount_dec_and_test(&rreq->ref))
-		return;
-	if (rreq->cache_resources.ops)
-		rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
-	kfree(rreq);
-}
-
-static void erofs_fscache_put_subrequest(struct netfs_io_subrequest *subreq)
-{
-	if (!refcount_dec_and_test(&subreq->ref))
-		return;
-	erofs_fscache_put_request(subreq->rreq);
-	kfree(subreq);
-}
-
-static void erofs_fscache_clear_subrequests(struct netfs_io_request *rreq)
-{
-	struct netfs_io_subrequest *subreq;
-
-	while (!list_empty(&rreq->subrequests)) {
-		subreq = list_first_entry(&rreq->subrequests,
-				struct netfs_io_subrequest, rreq_link);
-		list_del(&subreq->rreq_link);
-		erofs_fscache_put_subrequest(subreq);
-	}
-}
-
 static void erofs_fscache_rreq_unlock_folios(struct netfs_io_request *rreq)
 {
 	struct netfs_io_subrequest *subreq;
@@ -114,11 +89,10 @@ static void erofs_fscache_rreq_unlock_folios(struct netfs_io_request *rreq)
 static void erofs_fscache_rreq_complete(struct netfs_io_request *rreq)
 {
 	erofs_fscache_rreq_unlock_folios(rreq);
-	erofs_fscache_clear_subrequests(rreq);
-	erofs_fscache_put_request(rreq);
+	netfs_rreq_completed(rreq, false);
 }
 
-static void erofc_fscache_subreq_complete(void *priv,
+static void erofs_fscache_subreq_complete(void *priv,
 		ssize_t transferred_or_error, bool was_async)
 {
 	struct netfs_io_subrequest *subreq = priv;
@@ -130,7 +104,7 @@ static void erofc_fscache_subreq_complete(void *priv,
 	if (atomic_dec_and_test(&rreq->nr_outstanding))
 		erofs_fscache_rreq_complete(rreq);
 
-	erofs_fscache_put_subrequest(subreq);
+	netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_terminated);
 }
 
 /*
@@ -171,9 +145,8 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
 		}
 
 		subreq->start = pstart + done;
-		subreq->len	=  len - done;
+		subreq->len   =  len - done;
 		subreq->flags = 1 << NETFS_SREQ_ONDEMAND;
-
 		list_add_tail(&subreq->rreq_link, &rreq->subrequests);
 
 		source = cres->ops->prepare_read(subreq, LLONG_MAX);
@@ -184,7 +157,7 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
 				  source);
 			ret = -EIO;
 			subreq->error = ret;
-			erofs_fscache_put_subrequest(subreq);
+			netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_failed);
 			goto out;
 		}
 
@@ -195,7 +168,7 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
 
 		ret = fscache_read(cres, subreq->start, &iter,
 				   NETFS_READ_HOLE_FAIL,
-				   erofc_fscache_subreq_complete, subreq);
+				   erofs_fscache_subreq_complete, subreq);
 		if (ret == -EIOCBQUEUED)
 			ret = 0;
 		if (ret) {
-- 
2.19.1.6.gb485710b

