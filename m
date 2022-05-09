Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA1851F64F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 10:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbiEIIDU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 04:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbiEIHow (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 03:44:52 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2EF165BC;
        Mon,  9 May 2022 00:40:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VCggc7l_1652082035;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VCggc7l_1652082035)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 09 May 2022 15:40:36 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        yinxin.x@bytedance.com, zhangjiachen.jaycee@bytedance.com,
        zhujia.zj@bytedance.com
Subject: [PATCH v11 04/22] cachefiles: notify the user daemon when withdrawing cookie
Date:   Mon,  9 May 2022 15:40:10 +0800
Message-Id: <20220509074028.74954-5-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220509074028.74954-1-jefflexu@linux.alibaba.com>
References: <20220509074028.74954-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Notify the user daemon that cookie is going to be withdrawn, providing a
hint that the associated anonymous fd can be closed.

Be noted that this is only a hint. The user daemon may close the
associated anonymous fd when receiving the CLOSE request, then it will
receive another anonymous fd when the cookie gets looked up. Or it may
ignore the CLOSE request, and keep writing data through the anonymous
fd. However the next time the cookie gets looked up, the user daemon
will still receive another new anonymous fd.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Acked-by: David Howells <dhowells@redhat.com>
---
 fs/cachefiles/interface.c       |  2 ++
 fs/cachefiles/internal.h        |  5 +++++
 fs/cachefiles/ondemand.c        | 38 +++++++++++++++++++++++++++++++++
 include/uapi/linux/cachefiles.h |  1 +
 4 files changed, 46 insertions(+)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index ae93cee9d25d..a69073a1d3f0 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -362,6 +362,8 @@ static void cachefiles_withdraw_cookie(struct fscache_cookie *cookie)
 		spin_unlock(&cache->object_list_lock);
 	}
 
+	cachefiles_ondemand_clean_object(object);
+
 	if (object->file) {
 		cachefiles_begin_secure(cache, &saved_cred);
 		cachefiles_clean_up_object(object, cache);
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index e5c612888f84..da388ba127eb 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -290,6 +290,7 @@ extern int cachefiles_ondemand_copen(struct cachefiles_cache *cache,
 				     char *args);
 
 extern int cachefiles_ondemand_init_object(struct cachefiles_object *object);
+extern void cachefiles_ondemand_clean_object(struct cachefiles_object *object);
 
 #else
 static inline ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
@@ -302,6 +303,10 @@ static inline int cachefiles_ondemand_init_object(struct cachefiles_object *obje
 {
 	return 0;
 }
+
+static inline void cachefiles_ondemand_clean_object(struct cachefiles_object *object)
+{
+}
 #endif
 
 /*
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 7946ee6c40be..11b1c15ac697 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -229,6 +229,12 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 		goto err_put_fd;
 	}
 
+	/* CLOSE request has no reply */
+	if (msg->opcode == CACHEFILES_OP_CLOSE) {
+		xa_erase(&cache->reqs, id);
+		complete(&req->done);
+	}
+
 	return n;
 
 err_put_fd:
@@ -300,6 +306,13 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 		/* coupled with the barrier in cachefiles_flush_reqs() */
 		smp_mb();
 
+		if (opcode != CACHEFILES_OP_OPEN && object->ondemand_id <= 0) {
+			WARN_ON_ONCE(object->ondemand_id == 0);
+			xas_unlock(&xas);
+			ret = -EIO;
+			goto out;
+		}
+
 		xas.xa_index = 0;
 		xas_find_marked(&xas, UINT_MAX, XA_FREE_MARK);
 		if (xas.xa_node == XAS_RESTART)
@@ -356,6 +369,25 @@ static int cachefiles_ondemand_init_open_req(struct cachefiles_req *req,
 	return 0;
 }
 
+static int cachefiles_ondemand_init_close_req(struct cachefiles_req *req,
+					      void *private)
+{
+	struct cachefiles_object *object = req->object;
+	int object_id = object->ondemand_id;
+
+	/*
+	 * It's possible that object id is still 0 if the cookie looking up
+	 * phase failed before OPEN request has ever been sent. Also avoid
+	 * sending CLOSE request for CACHEFILES_ONDEMAND_ID_CLOSED, which means
+	 * anon_fd has already been closed.
+	 */
+	if (object_id <= 0)
+		return -ENOENT;
+
+	req->msg.object_id = object_id;
+	return 0;
+}
+
 int cachefiles_ondemand_init_object(struct cachefiles_object *object)
 {
 	struct fscache_cookie *cookie = object->cookie;
@@ -379,3 +411,9 @@ int cachefiles_ondemand_init_object(struct cachefiles_object *object)
 	return cachefiles_ondemand_send_req(object, CACHEFILES_OP_OPEN,
 			data_len, cachefiles_ondemand_init_open_req, NULL);
 }
+
+void cachefiles_ondemand_clean_object(struct cachefiles_object *object)
+{
+	cachefiles_ondemand_send_req(object, CACHEFILES_OP_CLOSE, 0,
+			cachefiles_ondemand_init_close_req, NULL);
+}
diff --git a/include/uapi/linux/cachefiles.h b/include/uapi/linux/cachefiles.h
index 521f2fe4fe9c..37a0071037c8 100644
--- a/include/uapi/linux/cachefiles.h
+++ b/include/uapi/linux/cachefiles.h
@@ -12,6 +12,7 @@
 
 enum cachefiles_opcode {
 	CACHEFILES_OP_OPEN,
+	CACHEFILES_OP_CLOSE,
 };
 
 /*
-- 
2.27.0

