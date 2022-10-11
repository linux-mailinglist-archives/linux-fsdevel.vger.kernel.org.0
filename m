Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC4B5FB324
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 15:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiJKNRa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 09:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiJKNRH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:17:07 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B225F95E6B
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Oct 2022 06:16:17 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gf8so12436132pjb.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Oct 2022 06:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJfl8b4fc5aHHIhFWhzN2k2LY2nGC5nCZll+W9C835A=;
        b=lvAIf4QBk0UcFLO6PiJJg86w0laxYXesd9zaLggmiI/bPsWMs/y59FRYN5a2MlkrFB
         kHNNUct/0KTw0+If7O/z6FgHMjtQLvxk2uZMDNd47THzMJgaJKXEioNyZqI3+CN3e2td
         DsfNCgLHtf9+DCUaxUSjg/FyyognjZPJR0InKcFMDXYV+WLLG2k84URhECvX1RT6j5Rf
         sx5JvSfCr169NupNT7BbriSQjpmaQOM67tmUKTra+hC2u1xPQbghzgqhzNqmYe3A7Ov6
         k0dkO3PmiyARZtqcZgmTNp7dRrzdqyjfgRUE4/1BpgI5eN2qLTvzSi4n/NzqLBCpeqq2
         bcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJfl8b4fc5aHHIhFWhzN2k2LY2nGC5nCZll+W9C835A=;
        b=z+w7P2QXnHUs40AiQ9ADT82xn3XcR4QZsBuxgDeWkvAAkyL9nxcNx/TDQtaXU1oe5X
         9k8Xi4HFc93j5AssKuiOzPU0h3G39kMVitd5zyF9as7Ao3QLTUvV1YCy4frvX6qANoLq
         GUl0RaEPM/BuOQJQz40yFq0V5LwzlA36kT7+4P+gl27jcSDLH614JBOR1v1UtIk55GTT
         i+dQwjLw+WA+ptKiz7xwBglHh0xT4/enshjVe7SAmksp+AbssJdqjam6BUst6qgI0RvG
         6Y0zBY7gLJsuMa7WikBfc0qcOUAoxnWaSP7dQ34BuGpwTqCqFByho5bxBlEMvBAANWK7
         rbnw==
X-Gm-Message-State: ACrzQf2EpLVnXD9up01OMHSJ9AImbNXHtml6i6aQNOJUj9XYvAf9qlfq
        VpkFvVdZrF6bgVGFNOvvQx/56A==
X-Google-Smtp-Source: AMsMyM4bERKRfHpegTRstSNduCPP4P/YDOsG9rkyWHCwP9qmDoL4zBWQ/GXsIDwjiawN6FCg/OzgWg==
X-Received: by 2002:a17:90a:4d4d:b0:20b:1f3f:f19a with SMTP id l13-20020a17090a4d4d00b0020b1f3ff19amr26256108pjh.36.1665494169071;
        Tue, 11 Oct 2022 06:16:09 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([63.216.146.190])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902654e00b00181f8523f60sm4773415pln.225.2022.10.11.06.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 06:16:08 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     dhowells@redhat.com, xiang@kernel.org, jefflexu@linux.alibaba.com
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH 1/5] cachefiles: introduce object ondemand state
Date:   Tue, 11 Oct 2022 21:15:48 +0800
Message-Id: <20221011131552.23833-2-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20221011131552.23833-1-zhujia.zj@bytedance.com>
References: <20221011131552.23833-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Previously, @ondemand_id field was used not only to identify ondemand
state of the object, but also to represent the index of the xarray.
This commit introduces @state field to decouple the role of @ondemand_id
and adds helpers to access it.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
Reviewed-by: Xin Yin <yinxin.x@bytedance.com>
---
 fs/cachefiles/internal.h | 33 +++++++++++++++++++++++++++++++++
 fs/cachefiles/ondemand.c | 15 +++++++++------
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 2ad58c465208..2dcc8b6ad536 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -17,6 +17,7 @@
 #include <linux/security.h>
 #include <linux/xarray.h>
 #include <linux/cachefiles.h>
+#include <linux/atomic.h>
 
 #define CACHEFILES_DIO_BLOCK_SIZE 4096
 
@@ -44,6 +45,11 @@ struct cachefiles_volume {
 	struct dentry			*fanout[256];	/* Fanout subdirs */
 };
 
+enum cachefiles_object_state {
+	CACHEFILES_ONDEMAND_OBJSTATE_close, /* Anonymous fd closed by daemon or initial state */
+	CACHEFILES_ONDEMAND_OBJSTATE_open, /* Anonymous fd associated with object is available */
+};
+
 /*
  * Backing file state.
  */
@@ -62,6 +68,7 @@ struct cachefiles_object {
 #define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
 #ifdef CONFIG_CACHEFILES_ONDEMAND
 	int				ondemand_id;
+	enum cachefiles_object_state	state;
 #endif
 };
 
@@ -296,6 +303,32 @@ extern void cachefiles_ondemand_clean_object(struct cachefiles_object *object);
 extern int cachefiles_ondemand_read(struct cachefiles_object *object,
 				    loff_t pos, size_t len);
 
+#define CACHEFILES_OBJECT_STATE_FUNCS(_state)	\
+static inline bool								\
+cachefiles_ondemand_object_is_##_state(const struct cachefiles_object *object) \
+{												\
+	/*
+	 * Pairs with smp_store_release() in set_object_##_state()
+	 * I.e. another task can publish state concurrently, by executing
+	 * a RELEASE barrier. We need to use smp_load_acquire() here
+	 * to safely ACQUIRE the memory the other task published.
+	 */											\
+	return smp_load_acquire(&object->state) == CACHEFILES_ONDEMAND_OBJSTATE_##_state; \
+}												\
+												\
+static inline void								\
+cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
+{												\
+	/*
+	 * Pairs with smp_load_acquire() in object_is_##_state()
+	 * I.e. here we publish a state with a RELEASE barrier
+	 * so that concurrent tasks can ACQUIRE it.
+	 */											\
+	smp_store_release(&object->state, CACHEFILES_ONDEMAND_OBJSTATE_##_state); \
+}
+
+CACHEFILES_OBJECT_STATE_FUNCS(open);
+CACHEFILES_OBJECT_STATE_FUNCS(close);
 #else
 static inline ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 					char __user *_buffer, size_t buflen)
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 0254ed39f68c..e81d72c7bb4c 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -15,6 +15,7 @@ static int cachefiles_ondemand_fd_release(struct inode *inode,
 
 	xa_lock(&cache->reqs);
 	object->ondemand_id = CACHEFILES_ONDEMAND_ID_CLOSED;
+	cachefiles_ondemand_set_object_close(object);
 
 	/*
 	 * Flush all pending READ requests since their completion depends on
@@ -176,6 +177,8 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 		set_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
 	trace_cachefiles_ondemand_copen(req->object, id, size);
 
+	cachefiles_ondemand_set_object_open(req->object);
+
 out:
 	complete(&req->done);
 	return ret;
@@ -363,7 +366,8 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 		/* coupled with the barrier in cachefiles_flush_reqs() */
 		smp_mb();
 
-		if (opcode != CACHEFILES_OP_OPEN && object->ondemand_id <= 0) {
+		if (opcode != CACHEFILES_OP_OPEN &&
+			!cachefiles_ondemand_object_is_open(object)) {
 			WARN_ON_ONCE(object->ondemand_id == 0);
 			xas_unlock(&xas);
 			ret = -EIO;
@@ -430,7 +434,6 @@ static int cachefiles_ondemand_init_close_req(struct cachefiles_req *req,
 					      void *private)
 {
 	struct cachefiles_object *object = req->object;
-	int object_id = object->ondemand_id;
 
 	/*
 	 * It's possible that object id is still 0 if the cookie looking up
@@ -438,10 +441,10 @@ static int cachefiles_ondemand_init_close_req(struct cachefiles_req *req,
 	 * sending CLOSE request for CACHEFILES_ONDEMAND_ID_CLOSED, which means
 	 * anon_fd has already been closed.
 	 */
-	if (object_id <= 0)
+	if (!cachefiles_ondemand_object_is_open(object))
 		return -ENOENT;
 
-	req->msg.object_id = object_id;
+	req->msg.object_id = object->ondemand_id;
 	trace_cachefiles_ondemand_close(object, &req->msg);
 	return 0;
 }
@@ -460,7 +463,7 @@ static int cachefiles_ondemand_init_read_req(struct cachefiles_req *req,
 	int object_id = object->ondemand_id;
 
 	/* Stop enqueuing requests when daemon has closed anon_fd. */
-	if (object_id <= 0) {
+	if (!cachefiles_ondemand_object_is_open(object)) {
 		WARN_ON_ONCE(object_id == 0);
 		pr_info_once("READ: anonymous fd closed prematurely.\n");
 		return -EIO;
@@ -485,7 +488,7 @@ int cachefiles_ondemand_init_object(struct cachefiles_object *object)
 	 * creating a new tmpfile as the cache file. Reuse the previously
 	 * allocated object ID if any.
 	 */
-	if (object->ondemand_id > 0)
+	if (cachefiles_ondemand_object_is_open(object))
 		return 0;
 
 	volume_key_size = volume->key[0] + 1;
-- 
2.20.1

