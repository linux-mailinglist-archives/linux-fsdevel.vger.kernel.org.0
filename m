Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F455FE74D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 05:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJNDJX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Oct 2022 23:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiJNDIk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:08:40 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8637FEF585
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Oct 2022 20:08:38 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id l1so3522868pld.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Oct 2022 20:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1R7QPYLS3htwC9+m+eMmhkdxMHPXqw45xmXhqmncaA=;
        b=22pn9Os6EXT6UWfc9ZeKQ71GM5Bhmq9AlSEpgZrKl0IUo/yufgpYJMahaOmGApuHFQ
         0HjgOrbOd3sJY2g4HJFuY1sgb4TaAlQP3aRsz10/ANjJZl4lMgHQsK7sWfd8Y0DMkh+C
         Dnl17PUMBTdKkOZPaPAnFJ/golfWNeftyDK3tNB7RN8JVIyFOYWbhGQkwRm4hg/oIKKh
         XWwkEhfZvnj2wPG3jNFSKte8oOALG7BsAxuzpit/Iy/IXoZtVY0BmdVKoGN2ayiG8T6J
         v607OE1Wb3Zg/vDA9PphT7Zvanzlont5JanwatBkMlDh5o+XUUb8SSx2FdIDrQQBfhxj
         TvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1R7QPYLS3htwC9+m+eMmhkdxMHPXqw45xmXhqmncaA=;
        b=HVQ680msu11RTqfCPFaecxlbGXf3tIpbBMeI51yql4Mn76T1SQFCGtdyKpKGXUzrqu
         IkuqeVaX+hptxLZqTozx7fjwH6QSTwW9zQLYskrN8jOzEaZWmdVyAByjnvwCDybuASkl
         k+pjh3OeO89ddJhmiQvdv0OVKP/A5nNhzqy8BMaVg6IklQwAABOI2ncg5nP5nAorbUwh
         Gcof6nLAxB8mTH0ZoyKNXAufL4r1V7NQsWqruIcewhH4mLxMY5/9B6BF3Hy5CbG2Rtxm
         hNjO8PYArFSOoorfT8CQXo+O3bqNG4DlYFj436kVBwWqpsreljueYvqBG/1IvSjo7ioj
         wnUw==
X-Gm-Message-State: ACrzQf3+caPcxwvK8KqTC8lyB2dv3dH9CPVIbh3B7mXznZNQ4M9cZttd
        8EKxmZO0zetkjiHf3DqO3vCLD9bxGsVzhKH3
X-Google-Smtp-Source: AMsMyM5Ejyc0D+AQNsiKQu3QB+Vg9yCW8ZNFcTSVKsMfVupUu0uJQ3sNLvSheHGNJWaShgZirb4OmA==
X-Received: by 2002:a17:903:1003:b0:181:6c26:1114 with SMTP id a3-20020a170903100300b001816c261114mr2921922plb.75.1665716906763;
        Thu, 13 Oct 2022 20:08:26 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([63.216.146.183])
        by smtp.gmail.com with ESMTPSA id h4-20020a17090a710400b0020ae09e9724sm425524pjk.53.2022.10.13.20.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 20:08:26 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     dhowells@redhat.com, xiang@kernel.org, jefflexu@linux.alibaba.com
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V2 4/5] cachefiles: narrow the scope of triggering EPOLLIN events in ondemand mode
Date:   Fri, 14 Oct 2022 11:07:44 +0800
Message-Id: <20221014030745.25748-5-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20221014030745.25748-1-zhujia.zj@bytedance.com>
References: <20221014030745.25748-1-zhujia.zj@bytedance.com>
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

Don't trigger EPOLLIN when there are only reopening read requests in
xarray.

Suggested-by: Xin Yin <yinxin.x@bytedance.com>
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
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
index 21ef5007f488..98d6cf58db11 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -327,6 +327,13 @@ cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
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
@@ -354,6 +361,11 @@ static inline int cachefiles_ondemand_init_obj_info(struct cachefiles_object *ob
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

