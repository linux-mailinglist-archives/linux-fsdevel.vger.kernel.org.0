Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9560A5FEA1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 10:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiJNIHK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 04:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiJNIHG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 04:07:06 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC73C1BE1EE
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 01:06:49 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so4113282pjl.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 01:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8u8C9HdOyOb3+ICBwFZcrFBPJwehJIZsy+qDOHaF19g=;
        b=PR9/JKqA3+BUVhsO9JjYtGBtjxZi6CZawKro8WxV/0VxazHeT12xhp3alzz7CcN/vE
         knyqS/WNxyrwZ6WBVJAhIOGy9XpFWo15nnMqQIk+/acXb3/SeYy3QFly9jhTjQOCvZBD
         SlbDyFfwjhZXE+zZSEH/q2Hf4WKMDv5IjHBtWoEuCCknzdNmLXSo6UsSxXjZFPGZJKkE
         AxUZ7JRU6rdZfWzIANN+B2LEGuvx/jQwto7FKT6WeAS3QrHTepOUv9ljgAgYHp8dSWKj
         dnVcqoV8pNmlCvHlbhqmFcxn1Bymi7WwZKpYyCpjgghgVkGolVB/ntojWYCZVCd6+h7B
         lFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8u8C9HdOyOb3+ICBwFZcrFBPJwehJIZsy+qDOHaF19g=;
        b=6Z3fFCtInDW1Vtq4S56LpMKg60jpFmbewVWBN6ldODivdjyRTFVtBV9YfoATdnyfvb
         kEiBHgMs9KOHcAoujav2SKbf+JXttGbfY9/ddo6i+ZK2nfih47ZxFzW86ucTJZ9CG3Re
         wiat8L3uoDn5QBoll6OLVNdjE4+vuFXvktGr6xvvfo2TGPf/d5TBKArVa6tpjMraYLLK
         59iIczYM5BrDdv5C7AQdgc07tfIZ1zQ206NFNfqdc9lIPG2tvNVOh4gMoTw1US9xr8cN
         j9BAPTrPE3EMBG5AxR4qQCG8NExOj9LgszEsQ2eCWMZP5UokE8NWvSeGWyxbCj6HUdHk
         FgFg==
X-Gm-Message-State: ACrzQf2AXQTIL4yepa6bKDW3rn0dmBGt6Jt3tZemueGG9AeniqZryr5E
        /+H2+iji19FgVuJfhWJEDwTmgA==
X-Google-Smtp-Source: AMsMyM7TCUHthbVDEp84KteEgCPGCvN3NhsLBH4YrIOYaqV0E051pLrr551rlUd5+pw1LXug+HVuIA==
X-Received: by 2002:a17:902:b901:b0:184:5b9a:24f0 with SMTP id bf1-20020a170902b90100b001845b9a24f0mr4142759plb.17.1665734807934;
        Fri, 14 Oct 2022 01:06:47 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([63.216.146.188])
        by smtp.gmail.com with ESMTPSA id ik20-20020a170902ab1400b001730a1af0fbsm1119196plb.23.2022.10.14.01.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 01:06:47 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     dhowells@redhat.com, xiang@kernel.org, jefflexu@linux.alibaba.com
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V3 4/5] cachefiles: narrow the scope of triggering EPOLLIN events in ondemand mode
Date:   Fri, 14 Oct 2022 16:05:58 +0800
Message-Id: <20221014080559.42108-5-zhujia.zj@bytedance.com>
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

Don't trigger EPOLLIN when there are only reopening read requests in
xarray.

Suggested-by: Xin Yin <yinxin.x@bytedance.com>
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/daemon.c   | 13 +++++++++++--
 fs/cachefiles/internal.h | 12 ++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index aa4efcabb5e3..c74bd1f4ecf5 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -355,14 +355,23 @@ static __poll_t cachefiles_daemon_poll(struct file *file,
 					   struct poll_table_struct *poll)
 {
 	struct cachefiles_cache *cache = file->private_data;
+	struct xarray *xa = &cache->reqs;
+	struct cachefiles_req *req;
+	unsigned long index;
 	__poll_t mask;
 
 	poll_wait(file, &cache->daemon_pollwq, poll);
 	mask = 0;
 
 	if (cachefiles_in_ondemand_mode(cache)) {
-		if (!xa_empty(&cache->reqs))
-			mask |= EPOLLIN;
+		if (!xa_empty(xa)) {
+			xa_for_each_marked(xa, index, req, CACHEFILES_REQ_NEW) {
+				if (!cachefiles_ondemand_is_reopening_read(req)) {
+					mask |= EPOLLIN;
+					break;
+				}
+			}
+		}
 	} else {
 		if (test_bit(CACHEFILES_STATE_CHANGED, &cache->flags))
 			mask |= EPOLLIN;
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 2ed836d4169e..3d94990a8b38 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -326,6 +326,13 @@ cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
 CACHEFILES_OBJECT_STATE_FUNCS(open);
 CACHEFILES_OBJECT_STATE_FUNCS(close);
 CACHEFILES_OBJECT_STATE_FUNCS(reopening);
+
+static inline bool cachefiles_ondemand_is_reopening_read(struct cachefiles_req *req)
+{
+	return cachefiles_ondemand_object_is_reopening(req->object) &&
+			req->msg.opcode == CACHEFILES_OP_READ;
+}
+
 #else
 static inline ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 					char __user *_buffer, size_t buflen)
@@ -353,6 +360,11 @@ static inline int cachefiles_ondemand_init_obj_info(struct cachefiles_object *ob
 {
 	return 0;
 }
+
+static inline bool cachefiles_ondemand_is_reopening_read(struct cachefiles_req *req)
+{
+	return false;
+}
 #endif
 
 /*
-- 
2.20.1

