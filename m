Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C152E5FE748
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 05:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiJNDIl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Oct 2022 23:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiJNDIc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:08:32 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7349819B641
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Oct 2022 20:08:22 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so3591752pjl.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Oct 2022 20:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jexCPXMD1tiAWyMpE7kFB+4P8+aQ3ICPFBRets/3erM=;
        b=fQKg0y8YL2d+gPSn3U4m+mr6kpYvDbcL8R79MD7a8yt/UjbteM2AL2JO0itdPoCRGq
         yOq+0MuO6QP9xkt+pa4kyPCSjPZSVPNGBsC7DSlL2vnJhrvaF0PZACNsmkucaOkdPrfs
         HbOBqneW95mVZ1xhrNFcLKza2gYsSj7YR8Ak629NYES0ZlBDkIQaq1UkF8cMqgh7tTqW
         821pnTxHRtAyTd//3M/lQzRIv+p3T3SOs6pSd+9qXRKaks1qULNxxvJp+saZ16zZXnBA
         1ifgn/iQenujEW5MygPT0hXqfUFW+mXdSKA86vtibFC20EqerxRixNYPGrA010QGI2Ei
         mbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jexCPXMD1tiAWyMpE7kFB+4P8+aQ3ICPFBRets/3erM=;
        b=OeF3hjphV5ucFFS4BdAumnEJE11AO92b0Gne86CicGqmWjncwQ7W9q1YEMhpllJwir
         n7uQjjqSpTqJ9GXXJf3KqtFF7tRz8dAK0aHV1KXT7mEUanauGBpBsNEy8MjC8NqWI+x/
         9fjNpz/wpHeNYnFUTK5PcRF1GbP9GvGbObqvyAb/ZnORYuQkfPCtkvSFFdgSh6Oi6g9U
         jsjbqqQalFV2vEys8sT49RzeBB16pavLXsB0t2A4iBg3lR1Uk0PlQ3moEcUG/aNE9PIt
         P0psljniOU9B16A7aZUeWyqOTenk6WtIkgJDYg9E+ofXTl2B+USjV/c9yvYRmq06t7M3
         CVHw==
X-Gm-Message-State: ACrzQf3A99vA4tV5Sn+nukX05Eyz4N4dMjd6GOq6Sw59FRtA7sTQn8dO
        rEmUBRTDe5iJpkfRdlgutRNJwA==
X-Google-Smtp-Source: AMsMyM78YB9M+cBZTuxUTkzImdqjUWbmVvlLD2pLT3cNXhbrD5aRB2I5bpXJNjdgmo4SqL3aKsN6BQ==
X-Received: by 2002:a17:90b:17c4:b0:20d:4d79:55b1 with SMTP id me4-20020a17090b17c400b0020d4d7955b1mr3240422pjb.125.1665716884249;
        Thu, 13 Oct 2022 20:08:04 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([63.216.146.183])
        by smtp.gmail.com with ESMTPSA id h4-20020a17090a710400b0020ae09e9724sm425524pjk.53.2022.10.13.20.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 20:08:03 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     dhowells@redhat.com, xiang@kernel.org, jefflexu@linux.alibaba.com
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V2 1/5] cachefiles: introduce object ondemand state
Date:   Fri, 14 Oct 2022 11:07:41 +0800
Message-Id: <20221014030745.25748-2-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20221014030745.25748-1-zhujia.zj@bytedance.com>
References: <20221014030745.25748-1-zhujia.zj@bytedance.com>
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

Previously, @ondemand_id field was used not only to identify ondemand
state of the object, but also to represent the index of the xarray.
This commit introduces @state field to decouple the role of @ondemand_id
and adds helpers to access it.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
Reviewed-by: Xin Yin <yinxin.x@bytedance.com>
---
 fs/cachefiles/internal.h | 22 ++++++++++++++++++++++
 fs/cachefiles/ondemand.c | 21 +++++++++------------
 2 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 2ad58c465208..39895bbd149a 100644
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
 
@@ -296,6 +303,21 @@ extern void cachefiles_ondemand_clean_object(struct cachefiles_object *object);
 extern int cachefiles_ondemand_read(struct cachefiles_object *object,
 				    loff_t pos, size_t len);
 
+#define CACHEFILES_OBJECT_STATE_FUNCS(_state)	\
+static inline bool								\
+cachefiles_ondemand_object_is_##_state(const struct cachefiles_object *object) \
+{												\
+	return object->state == CACHEFILES_ONDEMAND_OBJSTATE_##_state; \
+}												\
+												\
+static inline void								\
+cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
+{												\
+	object->state = CACHEFILES_ONDEMAND_OBJSTATE_##_state; \
+}
+
+CACHEFILES_OBJECT_STATE_FUNCS(open);
+CACHEFILES_OBJECT_STATE_FUNCS(close);
 #else
 static inline ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 					char __user *_buffer, size_t buflen)
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 0254ed39f68c..90456b8a4b3e 100644
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
@@ -430,18 +434,11 @@ static int cachefiles_ondemand_init_close_req(struct cachefiles_req *req,
 					      void *private)
 {
 	struct cachefiles_object *object = req->object;
-	int object_id = object->ondemand_id;
 
-	/*
-	 * It's possible that object id is still 0 if the cookie looking up
-	 * phase failed before OPEN request has ever been sent. Also avoid
-	 * sending CLOSE request for CACHEFILES_ONDEMAND_ID_CLOSED, which means
-	 * anon_fd has already been closed.
-	 */
-	if (object_id <= 0)
+	if (!cachefiles_ondemand_object_is_open(object))
 		return -ENOENT;
 
-	req->msg.object_id = object_id;
+	req->msg.object_id = object->ondemand_id;
 	trace_cachefiles_ondemand_close(object, &req->msg);
 	return 0;
 }
@@ -460,7 +457,7 @@ static int cachefiles_ondemand_init_read_req(struct cachefiles_req *req,
 	int object_id = object->ondemand_id;
 
 	/* Stop enqueuing requests when daemon has closed anon_fd. */
-	if (object_id <= 0) {
+	if (!cachefiles_ondemand_object_is_open(object)) {
 		WARN_ON_ONCE(object_id == 0);
 		pr_info_once("READ: anonymous fd closed prematurely.\n");
 		return -EIO;
@@ -485,7 +482,7 @@ int cachefiles_ondemand_init_object(struct cachefiles_object *object)
 	 * creating a new tmpfile as the cache file. Reuse the previously
 	 * allocated object ID if any.
 	 */
-	if (object->ondemand_id > 0)
+	if (cachefiles_ondemand_object_is_open(object))
 		return 0;
 
 	volume_key_size = volume->key[0] + 1;
-- 
2.20.1

