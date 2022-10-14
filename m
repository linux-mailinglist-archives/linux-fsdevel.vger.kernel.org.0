Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294045FEA1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 10:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiJNIHI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 04:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiJNIGy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 04:06:54 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1911BE1C9
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 01:06:44 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 3so4228486pfw.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 01:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGVULqlnaPjYkF0USjRnqm7ODLg1ZE1u+sEwjtklJtE=;
        b=ZnaHc80F0z74ccZGbRte282qVkE7AVhNLGE7GTpp/5BKYUmhGsjOZVollPs0yJH3kX
         MbijmBqRRRmOB4inoSVzXydRct/bJQmTjjVR6SSNbFjvjpuWlA6j2ituZ3XZ9f/xikUD
         ymsrksLwFpheMq+rkEq063Oc3kw4iB0nGfNzG+v74DfIG4kGZxfn9AWF2HvY0wY+HQCy
         10M18tPXRRT4e1QyCx4zIStN3MEs21JhKFszyYolXjZRDFCZWlWsbNY/C1UO5BI/vp8h
         3nauLISt3vaR8T7ZH0gg7pwnhXojsdh3KHrJjQaxT8u5RYnf4rOsAoagPRGfJ2vQc261
         6FcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGVULqlnaPjYkF0USjRnqm7ODLg1ZE1u+sEwjtklJtE=;
        b=wf2crCASVz3c2HhsF0R+UXINnAHiAUgGDEcqQ5zbDMzV+4jCrBsQj4IYq21alRvQ6l
         arBIQLnu/+QN0HEUP/LhF/I42Sofgv/HD3ifeaRSGEVVYsgTXKBwJ3SB19EuThrM3dVY
         jYd/satjr0znmDcAM/ma2IbZky9VyZyrOpRtTnqR65VSCMtzphNQQ1nKYNTeFcZdi/KM
         4FPk+aOyrs/yR8ShPhC4xhtI3xee9Xjdp0jVjIaSqodq7SYDo3WqDwjSZ8xaH3PFRebA
         n4hIaSffb+JQKlYf0wIRdbsRAz5HRoPxJT8dg/t0VgpI5+E5VhnrHdJ4JE805bQAUNjT
         ZJKw==
X-Gm-Message-State: ACrzQf19cq/cw+qe0qA7Va+ghaFrQSYpgnwlSI4yilNnAoWWIub0AdSQ
        8UCWHVczlcWioc6Pwb0NxvHfWg==
X-Google-Smtp-Source: AMsMyM6IQo2RPGH/Gy09tP9fdZ0ryjd08QQSlHSifSKu34dZ/2FKnyRVQ8DKcEgVJoD2ECnfNKjG2w==
X-Received: by 2002:a05:6a00:1809:b0:565:adc8:a5c4 with SMTP id y9-20020a056a00180900b00565adc8a5c4mr3929879pfa.65.1665734804458;
        Fri, 14 Oct 2022 01:06:44 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([63.216.146.188])
        by smtp.gmail.com with ESMTPSA id ik20-20020a170902ab1400b001730a1af0fbsm1119196plb.23.2022.10.14.01.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 01:06:44 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     dhowells@redhat.com, xiang@kernel.org, jefflexu@linux.alibaba.com
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V3 3/5] cachefiles: resend an open request if the read request's object is closed
Date:   Fri, 14 Oct 2022 16:05:57 +0800
Message-Id: <20221014080559.42108-4-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20221014080559.42108-1-zhujia.zj@bytedance.com>
References: <20221014080559.42108-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When an anonymous fd is closed by user daemon, if there is a new read
request for this file comes up, the anonymous fd should be re-opened
to handle that read request rather than fail it directly.

1. Introduce reopening state for objects that are closed but have
   inflight/subsequent read requests.
2. No longer flush READ requests but only CLOSE requests when anonymous
   fd is closed.
3. Enqueue the reopen work to workqueue, thus user daemon could get rid
   of daemon_read context and handle that request smoothly. Otherwise,
   the user daemon will send a reopen request and wait for itself to
   process the request.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
Reviewed-by: Xin Yin <yinxin.x@bytedance.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/internal.h |  3 ++
 fs/cachefiles/ondemand.c | 96 ++++++++++++++++++++++++++++------------
 2 files changed, 70 insertions(+), 29 deletions(-)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index beaf3a8785ce..2ed836d4169e 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -47,9 +47,11 @@ struct cachefiles_volume {
 enum cachefiles_object_state {
 	CACHEFILES_ONDEMAND_OBJSTATE_close, /* Anonymous fd closed by daemon or initial state */
 	CACHEFILES_ONDEMAND_OBJSTATE_open, /* Anonymous fd associated with object is available */
+	CACHEFILES_ONDEMAND_OBJSTATE_reopening, /* Object that was closed and is being reopened. */
 };
 
 struct cachefiles_ondemand_info {
+	struct work_struct		work;
 	int				ondemand_id;
 	enum cachefiles_object_state	state;
 	struct cachefiles_object	*object;
@@ -323,6 +325,7 @@ cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
 
 CACHEFILES_OBJECT_STATE_FUNCS(open);
 CACHEFILES_OBJECT_STATE_FUNCS(close);
+CACHEFILES_OBJECT_STATE_FUNCS(reopening);
 #else
 static inline ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 					char __user *_buffer, size_t buflen)
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 6e47667c6690..d8dce55d907c 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -18,14 +18,10 @@ static int cachefiles_ondemand_fd_release(struct inode *inode,
 	info->ondemand_id = CACHEFILES_ONDEMAND_ID_CLOSED;
 	cachefiles_ondemand_set_object_close(object);
 
-	/*
-	 * Flush all pending READ requests since their completion depends on
-	 * anon_fd.
-	 */
-	xas_for_each(&xas, req, ULONG_MAX) {
+	/* Only flush CACHEFILES_REQ_NEW marked req to avoid race with daemon_read */
+	xas_for_each_marked(&xas, req, ULONG_MAX, CACHEFILES_REQ_NEW) {
 		if (req->msg.object_id == object_id &&
-		    req->msg.opcode == CACHEFILES_OP_READ) {
-			req->error = -EIO;
+		    req->msg.opcode == CACHEFILES_OP_CLOSE) {
 			complete(&req->done);
 			xas_store(&xas, NULL);
 		}
@@ -179,6 +175,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 	trace_cachefiles_ondemand_copen(req->object, id, size);
 
 	cachefiles_ondemand_set_object_open(req->object);
+	wake_up_all(&cache->daemon_pollwq);
 
 out:
 	complete(&req->done);
@@ -222,7 +219,6 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
 
 	load = (void *)req->msg.data;
 	load->fd = fd;
-	req->msg.object_id = object_id;
 	object->private->ondemand_id = object_id;
 
 	cachefiles_get_unbind_pincount(cache);
@@ -238,6 +234,41 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
 	return ret;
 }
 
+static void ondemand_object_worker(struct work_struct *work)
+{
+	struct cachefiles_object *object =
+		((struct cachefiles_ondemand_info *)work)->object;
+
+	cachefiles_ondemand_init_object(object);
+}
+
+/*
+ * If there are any inflight or subsequent READ requests on the
+ * closed object, reopen it.
+ * Skip read requests whose related object is reopening.
+ */
+static struct cachefiles_req *cachefiles_ondemand_select_req(struct xa_state *xas,
+							      unsigned long xa_max)
+{
+	struct cachefiles_req *req;
+	struct cachefiles_ondemand_info *info;
+
+	xas_for_each_marked(xas, req, xa_max, CACHEFILES_REQ_NEW) {
+		if (req->msg.opcode != CACHEFILES_OP_READ)
+			return req;
+		info = req->object->private;
+		if (info->state == CACHEFILES_ONDEMAND_OBJSTATE_close) {
+			cachefiles_ondemand_set_object_reopening(req->object);
+			queue_work(fscache_wq, &info->work);
+			continue;
+		} else if (info->state == CACHEFILES_ONDEMAND_OBJSTATE_reopening) {
+			continue;
+		}
+		return req;
+	}
+	return NULL;
+}
+
 ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 					char __user *_buffer, size_t buflen)
 {
@@ -248,16 +279,16 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 	int ret = 0;
 	XA_STATE(xas, &cache->reqs, cache->req_id_next);
 
+	xa_lock(&cache->reqs);
 	/*
 	 * Cyclically search for a request that has not ever been processed,
 	 * to prevent requests from being processed repeatedly, and make
 	 * request distribution fair.
 	 */
-	xa_lock(&cache->reqs);
-	req = xas_find_marked(&xas, UINT_MAX, CACHEFILES_REQ_NEW);
+	req = cachefiles_ondemand_select_req(&xas, ULONG_MAX);
 	if (!req && cache->req_id_next > 0) {
 		xas_set(&xas, 0);
-		req = xas_find_marked(&xas, cache->req_id_next - 1, CACHEFILES_REQ_NEW);
+		req = cachefiles_ondemand_select_req(&xas, cache->req_id_next - 1);
 	}
 	if (!req) {
 		xa_unlock(&cache->reqs);
@@ -277,14 +308,18 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 	xa_unlock(&cache->reqs);
 
 	id = xas.xa_index;
-	msg->msg_id = id;
 
 	if (msg->opcode == CACHEFILES_OP_OPEN) {
 		ret = cachefiles_ondemand_get_fd(req);
-		if (ret)
+		if (ret) {
+			cachefiles_ondemand_set_object_close(req->object);
 			goto error;
+		}
 	}
 
+	msg->msg_id = id;
+	msg->object_id = req->object->private->ondemand_id;
+
 	if (copy_to_user(_buffer, msg, n) != 0) {
 		ret = -EFAULT;
 		goto err_put_fd;
@@ -317,19 +352,23 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 					void *private)
 {
 	struct cachefiles_cache *cache = object->volume->cache;
-	struct cachefiles_req *req;
+	struct cachefiles_req *req = NULL;
 	XA_STATE(xas, &cache->reqs, 0);
 	int ret;
 
 	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
 		return 0;
 
-	if (test_bit(CACHEFILES_DEAD, &cache->flags))
-		return -EIO;
+	if (test_bit(CACHEFILES_DEAD, &cache->flags)) {
+		ret = -EIO;
+		goto out;
+	}
 
 	req = kzalloc(sizeof(*req) + data_len, GFP_KERNEL);
-	if (!req)
-		return -ENOMEM;
+	if (!req) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	req->object = object;
 	init_completion(&req->done);
@@ -367,7 +406,7 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 		/* coupled with the barrier in cachefiles_flush_reqs() */
 		smp_mb();
 
-		if (opcode != CACHEFILES_OP_OPEN &&
+		if (opcode == CACHEFILES_OP_CLOSE &&
 			!cachefiles_ondemand_object_is_open(object)) {
 			WARN_ON_ONCE(object->private->ondemand_id == 0);
 			xas_unlock(&xas);
@@ -392,7 +431,15 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 	wake_up_all(&cache->daemon_pollwq);
 	wait_for_completion(&req->done);
 	ret = req->error;
+	kfree(req);
+	return ret;
 out:
+	/* Reset the object to close state in error handling path.
+	 * If error occurs after creating the anonymous fd,
+	 * cachefiles_ondemand_fd_release() will set object to close.
+	 */
+	if (opcode == CACHEFILES_OP_OPEN)
+		cachefiles_ondemand_set_object_close(req->object);
 	kfree(req);
 	return ret;
 }
@@ -439,7 +486,6 @@ static int cachefiles_ondemand_init_close_req(struct cachefiles_req *req,
 	if (!cachefiles_ondemand_object_is_open(object))
 		return -ENOENT;
 
-	req->msg.object_id = object->private->ondemand_id;
 	trace_cachefiles_ondemand_close(object, &req->msg);
 	return 0;
 }
@@ -455,16 +501,7 @@ static int cachefiles_ondemand_init_read_req(struct cachefiles_req *req,
 	struct cachefiles_object *object = req->object;
 	struct cachefiles_read *load = (void *)req->msg.data;
 	struct cachefiles_read_ctx *read_ctx = private;
-	int object_id = object->private->ondemand_id;
-
-	/* Stop enqueuing requests when daemon has closed anon_fd. */
-	if (!cachefiles_ondemand_object_is_open(object)) {
-		WARN_ON_ONCE(object_id == 0);
-		pr_info_once("READ: anonymous fd closed prematurely.\n");
-		return -EIO;
-	}
 
-	req->msg.object_id = object_id;
 	load->off = read_ctx->off;
 	load->len = read_ctx->len;
 	trace_cachefiles_ondemand_read(object, &req->msg, load);
@@ -513,6 +550,7 @@ int cachefiles_ondemand_init_obj_info(struct cachefiles_object *object,
 		return -ENOMEM;
 
 	object->private->object = object;
+	INIT_WORK(&object->private->work, ondemand_object_worker);
 	return 0;
 }
 
-- 
2.20.1

