Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6445FB32C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 15:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiJKNSB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 09:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiJKNRS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:17:18 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43983BC77
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Oct 2022 06:16:27 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id d7-20020a17090a2a4700b0020d268b1f02so6552139pjg.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Oct 2022 06:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dX9f5qZPLVHrgCUiGgy5JOsn3quuTKMm5YppO0P4KlY=;
        b=F65b2P/G06eaZvAyboOoRaXh7m+6agjce1dFZUanFKLUUaBMRPvPytdz6aG/A2p9L2
         LQU9Ga6MtZpeLnIa+DgP8/C5+SxccG8Sh9VG0OfGE3Jwesgnvo00+D0qPCzi3MFUTvof
         ekuDjZgPlMF/CqSvumHBpryDcTnQHmcaIkdJNm/Wz7ffETRrRS9MluJaoWMHM5PKjDIb
         VCexd3Wztbj4W6kda0U6rtFfniOgBf7oW9PWko0NEwPs9ksrBlwQohgxjVOFmZhNcu12
         RdA6woNdXgvbuNd6bI03lWZvMQ27FTSuU5CUnfFzaLjqF1UPg9YwaJhJpBps9+8xudW6
         hfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dX9f5qZPLVHrgCUiGgy5JOsn3quuTKMm5YppO0P4KlY=;
        b=HaxkUQyUpEU4DHPXj6yhociZ7kCA/iDacktAs7nsb4+R1mEAg13G6fVMFDZzmfyLyU
         RsD6hz8aTcME2lAsUqRSnLtRcqMKYPIVhcTut75qFdNpvF4dYNnwR6htXwqqFjZh+/Ds
         NMxK3yqj3ye0+1ySOOFXEXbpzdkPA3V3b5svH56W72WtAHGBnDc7ksvOPZhbaR4lG+OY
         i3rr93jXUhiAcL8HssJF2337zdJ6YxH67kL26jcwFAwGw/I8I73ktj2OPZalZYq80fgo
         p351XnMt3D/IaNPbjH5Iygfiv2fXyMggSZJgR2tazkH3XrnefldasNoHwfNuDL5+60b9
         vnUw==
X-Gm-Message-State: ACrzQf1qwRHfVKw23aLS41RsHQfnLqxc2Ppkuwo14zR79mLW6R4YzV7s
        U4aEOcUhFOKR3UOnsqUwiS0rHw==
X-Google-Smtp-Source: AMsMyM5M1kdoVlE9SD7ymSYsYWkm721nNHEJuvsfj+0wdDFP0LFHuJwLHPWAuzMOSqoAaY3HtHK/6g==
X-Received: by 2002:a17:902:848c:b0:17a:b4c0:a02b with SMTP id c12-20020a170902848c00b0017ab4c0a02bmr24145709plo.122.1665494179680;
        Tue, 11 Oct 2022 06:16:19 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([63.216.146.190])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902654e00b00181f8523f60sm4773415pln.225.2022.10.11.06.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 06:16:19 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     dhowells@redhat.com, xiang@kernel.org, jefflexu@linux.alibaba.com
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH 4/5] cachefiles: narrow the scope of triggering EPOLLIN events in ondemand mode
Date:   Tue, 11 Oct 2022 21:15:51 +0800
Message-Id: <20221011131552.23833-5-zhujia.zj@bytedance.com>
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
index a9f45972945d..4655b8a14a60 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -340,6 +340,13 @@ cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
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
@@ -367,6 +374,11 @@ static inline int cachefiles_ondemand_init_obj_info(struct cachefiles_object *ob
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

