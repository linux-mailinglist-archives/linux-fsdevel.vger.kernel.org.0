Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DDB4E72F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 13:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358975AbiCYMYK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 08:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358971AbiCYMYJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:24:09 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA289D4479;
        Fri, 25 Mar 2022 05:22:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0V89aFr5_1648210950;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V89aFr5_1648210950)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Mar 2022 20:22:31 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com
Subject: [PATCH v6 04/22] cachefiles: notify user daemon when withdrawing cookie
Date:   Fri, 25 Mar 2022 20:22:05 +0800
Message-Id: <20220325122223.102958-5-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
References: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Notify user daemon that cookie is going to be withdrawn, providing a
hint that the associated anon_fd can be closed. The anon_fd attached in
the CLOSE request shall be same with that in the previous OPEN request.

Be noted that this is only a hint. User daemon can close the anon_fd
when receiving the CLOSE request, then it will receive another anon_fd
if the cookie gets looked up. Or it can also ignore the CLOSE request,
and keep writing data into the anon_fd. However the next time cookie
gets looked up, the user daemon will still receive another anon_fd.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/interface.c       |  2 ++
 fs/cachefiles/internal.h        |  3 +++
 fs/cachefiles/ondemand.c        | 27 +++++++++++++++++++++++++++
 include/uapi/linux/cachefiles.h |  5 +++++
 4 files changed, 37 insertions(+)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index ae93cee9d25d..c5b8fefd4ccc 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -322,6 +322,8 @@ static void cachefiles_commit_object(struct cachefiles_object *object,
 static void cachefiles_clean_up_object(struct cachefiles_object *object,
 				       struct cachefiles_cache *cache)
 {
+	cachefiles_ondemand_cleanup_object(object);
+
 	if (test_bit(FSCACHE_COOKIE_RETIRED, &object->cookie->flags)) {
 		if (!test_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags)) {
 			cachefiles_see_object(object, cachefiles_obj_see_clean_delete);
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 8a0f1b691aca..c80b519a887b 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -280,6 +280,7 @@ extern int cachefiles_ondemand_cinit(struct cachefiles_cache *cache,
 				     char *args);
 
 extern int cachefiles_ondemand_init_object(struct cachefiles_object *object);
+extern void cachefiles_ondemand_cleanup_object(struct cachefiles_object *object);
 
 #else
 ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
@@ -292,6 +293,8 @@ static inline int cachefiles_ondemand_init_object(struct cachefiles_object *obje
 {
 	return 0;
 }
+
+static inline void cachefiles_ondemand_cleanup_object(struct cachefiles_object *object) {}
 #endif
 
 /*
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 0742c4a7797a..7fd518e01e5a 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -199,6 +199,12 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
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
@@ -322,6 +328,19 @@ static int init_open_req(struct cachefiles_req *req, void *private)
 	return 0;
 }
 
+static int init_close_req(struct cachefiles_req *req, void *private)
+{
+	struct cachefiles_object *object = req->object;
+	struct cachefiles_close *load = (void *)req->msg.data;
+	int fd = object->fd;
+
+	if (WARN_ON_ONCE(fd == -1))
+		return -EIO;
+
+	load->fd = fd;
+	return 0;
+}
+
 int cachefiles_ondemand_init_object(struct cachefiles_object *object)
 {
 	struct fscache_cookie *cookie = object->cookie;
@@ -346,3 +365,11 @@ int cachefiles_ondemand_init_object(struct cachefiles_object *object)
 					    CACHEFILES_OP_OPEN, data_len,
 					    init_open_req, NULL);
 }
+
+void cachefiles_ondemand_cleanup_object(struct cachefiles_object *object)
+{
+	cachefiles_ondemand_send_req(object,
+				     CACHEFILES_OP_CLOSE,
+				     sizeof(struct cachefiles_close),
+				     init_close_req, NULL);
+}
diff --git a/include/uapi/linux/cachefiles.h b/include/uapi/linux/cachefiles.h
index 0c44d68be6bd..03047e4b7df2 100644
--- a/include/uapi/linux/cachefiles.h
+++ b/include/uapi/linux/cachefiles.h
@@ -12,6 +12,7 @@
 
 enum cachefiles_opcode {
 	CACHEFILES_OP_OPEN,
+	CACHEFILES_OP_CLOSE,
 };
 
 /*
@@ -40,4 +41,8 @@ enum cachefiles_open_flags {
 	CACHEFILES_OPEN_WANT_CACHE_SIZE,
 };
 
+struct cachefiles_close {
+	__u32 fd;
+};
+
 #endif
-- 
2.27.0

