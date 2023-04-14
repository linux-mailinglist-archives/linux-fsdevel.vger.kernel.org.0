Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B386E293F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 19:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjDNRYZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 13:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjDNRYE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:24:04 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10D8AF0A
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 10:23:33 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id cm18-20020a17090afa1200b0024713adf69dso6833899pjb.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 10:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681493013; x=1684085013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLxzEPuRQOpnZLaEq6SfAsMRmsFnFoLhYkxVpQU9ODc=;
        b=BRc8Yf2ckf5lO1OvMNsi2GkZVI1sUHHIDltwlGPKACNCk2hxZYP/2q9ufEFgfGe1Or
         xu4A8QcOoUfxEbg2hhp7/ABNsHHUmPVfdSW6w+bSy1/eAwuabrxosHFmZprBL+3okRGB
         jFUBYONWr5DWLd5EzT82YnoOYRtfeVPw3ykOmYXtk59XYAa7kM2DcIJNbMnvZWrN2VsO
         sNpcT7ALv+c0DAvVkTbO+7v5ixjLbGDC54ch1VQiLWOKbryDhpiVBCpBpXONm36qMKDN
         umkVSBDGT5zvnuhKVqqetE4d0+mbpfT1lH0hjGbZvIWkAkfy4cWGt4GMiwjhyD56ljra
         Om0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681493013; x=1684085013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jLxzEPuRQOpnZLaEq6SfAsMRmsFnFoLhYkxVpQU9ODc=;
        b=M6u6z1QFe18uHkdwVSts8Sz4uC3PHDvol9AniHi4NWAd85NHlkkS3g+q+xf52fJW61
         w1mOeZ3c7jSYQrdlI5UpK6t2XNs7ZbR7SrEJpv6/iuuKVwszF04f7KmeJBqajsAYR63h
         ikR64TPsF6cw0YgN56EbjyhH24pYAdDSP9YsTmGpy/dx91yCCgw/0mDWMa8aIa+kXGX7
         HNx8T0oYg+uDJdpp2H8o6B7stWC/Y+VFuYx2kZkn545Zs5CnkS6FguiTxhsIWEF5oxh2
         2fPhR8KZ748TYJ8UL2Bme2xstmBKa988hQcE4Xo/qCP6XRFzQ5bK4a5ROGWQak5cQBUu
         ryoQ==
X-Gm-Message-State: AAQBX9foF+lCJoI+qSibz5x5b+u9sCT075lLkDqXWCA7f6Mnzc7u/fh8
        eroGX3sV848tjnMus8Wk+hHZ9w==
X-Google-Smtp-Source: AKy350ZlZsrNyqeh3U1slp9rUpz0KUQlUzMaBR9xIRDcSaraCogNI9a9HQahcjC0ZgcUIst42pl5Dw==
X-Received: by 2002:a05:6a20:7347:b0:ee:818a:3497 with SMTP id v7-20020a056a20734700b000ee818a3497mr1941553pzc.35.1681493013176;
        Fri, 14 Apr 2023 10:23:33 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id q12-20020a631f4c000000b0051b8172fa68sm370315pgm.38.2023.04.14.10.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 10:23:32 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com
Cc:     linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, jefflexu@linux.alibaba.com,
        hsiangkao@linux.alibaba.com, Jia Zhu <zhujia.zj@bytedance.com>,
        Xin Yin <yinxin.x@bytedance.com>
Subject: [PATCH V6 4/5] cachefiles: narrow the scope of triggering EPOLLIN events in ondemand mode
Date:   Sat, 15 Apr 2023 01:22:38 +0800
Message-Id: <20230414172239.33743-5-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230414172239.33743-1-zhujia.zj@bytedance.com>
References: <20230414172239.33743-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Don't trigger EPOLLIN when there are only reopening read requests in
xarray.

Suggested-by: Xin Yin <yinxin.x@bytedance.com>
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/cachefiles/daemon.c   | 14 ++++++++++++--
 fs/cachefiles/internal.h | 12 ++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index aa4efcabb5e37..70caa1946207d 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -355,14 +355,24 @@ static __poll_t cachefiles_daemon_poll(struct file *file,
 					   struct poll_table_struct *poll)
 {
 	struct cachefiles_cache *cache = file->private_data;
+	XA_STATE(xas, &cache->reqs, 0);
+	struct cachefiles_req *req;
 	__poll_t mask;
 
 	poll_wait(file, &cache->daemon_pollwq, poll);
 	mask = 0;
 
 	if (cachefiles_in_ondemand_mode(cache)) {
-		if (!xa_empty(&cache->reqs))
-			mask |= EPOLLIN;
+		if (!xa_empty(&cache->reqs)) {
+			rcu_read_lock();
+			xas_for_each_marked(&xas, req, ULONG_MAX, CACHEFILES_REQ_NEW) {
+				if (!cachefiles_ondemand_is_reopening_read(req)) {
+					mask |= EPOLLIN;
+					break;
+				}
+			}
+			rcu_read_unlock();
+		}
 	} else {
 		if (test_bit(CACHEFILES_STATE_CHANGED, &cache->flags))
 			mask |= EPOLLIN;
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index b9a90f1a0c015..26e5f8f123ef1 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -329,6 +329,13 @@ cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
 CACHEFILES_OBJECT_STATE_FUNCS(open, OPEN);
 CACHEFILES_OBJECT_STATE_FUNCS(close, CLOSE);
 CACHEFILES_OBJECT_STATE_FUNCS(reopening, REOPENING);
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
@@ -359,6 +366,11 @@ static inline int cachefiles_ondemand_init_obj_info(struct cachefiles_object *ob
 static inline void cachefiles_ondemand_deinit_obj_info(struct cachefiles_object *obj)
 {
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

