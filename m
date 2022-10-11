Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831BF5FB32F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 15:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiJKNSY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 09:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiJKNR1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:17:27 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD62495E73
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Oct 2022 06:16:33 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id w2so13540509pfb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Oct 2022 06:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kf3ZhctXueFJ0kbJ2xpRhM9KgFk3kGNXq2GUSVGfPOQ=;
        b=QUnuJb+6K78QvzX+CdefQECwtLKILI2InWFSw4OzOu7QHNDVoLPmNqV5UvdKmhyA3N
         KgzM7ww0PT7BkpNoOqo4MHkGexzbg3CK36roe4uoSD9jf26rKZMgpbGHi3D5lBCICVUa
         TyvYGVzJ0S2jFoSNd8eZpaD2WzpZiysKrBycBrHsaku1p37fHRu0BMk7MbT2AU+0Qybg
         egPZv1YRQtXiMlilzSUZlmYMqO2aTY774H89QOao2P8uyAsM5twteFQ8af0GeLWb6u3w
         fYtMjA1cBKSwTDj8DczZffZWgbFXKdahvzKi3fcIjFDujBaA9wqWREOC8QQnajIR9EVB
         Ao/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kf3ZhctXueFJ0kbJ2xpRhM9KgFk3kGNXq2GUSVGfPOQ=;
        b=hjxzhaAZnxR808OFFidetqbxeF1s/jHA+eICBMxjCBFXEjfj07NU1VxbNPU5mNN0C7
         gp/0M1RWu0Qr3gSyV+GHyqDA1UWXJmKnTzCg43SFB3UIOdXqyBJIlshHkAbT93g1nI9F
         WaM3dQpd8696/wSFK0ietxbo7UUjO01aSC4h/mSt6uKjtbAyQ1d00Am1goFVonVGVj2l
         6BHWE2/u3f11kNT8S11weS4vtN+PM964V4Am5CXsX1W3N+rDshoQcq5H6uFNNlQPQjZ/
         eV5FzLrbo2HYsVKR/u3tzp6s3nvGc0HM0UQib+YmaWV8JViNMXTQLRMy30VG/3YdRdZ5
         CPtQ==
X-Gm-Message-State: ACrzQf359XCuDle3me9RQYiVVxacwlVj9UsctLwJ5sKiDiq6pi8GRv4G
        Hyj3B7XyQncO7tKZcn0x1Vui3Q==
X-Google-Smtp-Source: AMsMyM5wocz0IUq2R8PGrFxw3m0trQqxL3DgQyV3I+hO0vivP4bDdgKuFhVD/ihMXnNQhambCbkWpw==
X-Received: by 2002:a63:2c4c:0:b0:434:e001:89fd with SMTP id s73-20020a632c4c000000b00434e00189fdmr21065376pgs.444.1665494183614;
        Tue, 11 Oct 2022 06:16:23 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([63.216.146.190])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902654e00b00181f8523f60sm4773415pln.225.2022.10.11.06.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 06:16:23 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     dhowells@redhat.com, xiang@kernel.org, jefflexu@linux.alibaba.com
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, Jia Zhu <zhujia.zj@bytedance.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 5/5] cachefiles: add restore command to recover inflight ondemand read requests
Date:   Tue, 11 Oct 2022 21:15:52 +0800
Message-Id: <20221011131552.23833-6-zhujia.zj@bytedance.com>
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

Previously, in ondemand read scenario, if the anonymous fd was closed by
user daemon, inflight and subsequent read requests would return EIO.
As long as the device connection is not released, user daemon can hold
and restore inflight requests by setting the request flag to
CACHEFILES_REQ_NEW.

Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
---
 fs/cachefiles/daemon.c   |  1 +
 fs/cachefiles/internal.h |  3 +++
 fs/cachefiles/ondemand.c | 23 +++++++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index c74bd1f4ecf5..014369266cb2 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -77,6 +77,7 @@ static const struct cachefiles_daemon_cmd cachefiles_daemon_cmds[] = {
 	{ "tag",	cachefiles_daemon_tag		},
 #ifdef CONFIG_CACHEFILES_ONDEMAND
 	{ "copen",	cachefiles_ondemand_copen	},
+	{ "restore",	cachefiles_ondemand_restore	},
 #endif
 	{ "",		NULL				}
 };
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 4655b8a14a60..756812fd8f68 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -302,6 +302,9 @@ extern ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 extern int cachefiles_ondemand_copen(struct cachefiles_cache *cache,
 				     char *args);
 
+extern int cachefiles_ondemand_restore(struct cachefiles_cache *cache,
+					char *args);
+
 extern int cachefiles_ondemand_init_object(struct cachefiles_object *object);
 extern void cachefiles_ondemand_clean_object(struct cachefiles_object *object);
 
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 69bf5446cc9c..bf3005dce00f 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -182,6 +182,29 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 	return ret;
 }
 
+int cachefiles_ondemand_restore(struct cachefiles_cache *cache, char *args)
+{
+	struct cachefiles_req *req;
+
+	XA_STATE(xas, &cache->reqs, 0);
+
+	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
+		return -EOPNOTSUPP;
+
+	/*
+	 * Reset the requests to CACHEFILES_REQ_NEW state, so that the
+	 * requests have been processed halfway before the crash of the
+	 * user daemon could be reprocessed after the recovery.
+	 */
+	xas_lock(&xas);
+	xas_for_each(&xas, req, ULONG_MAX)
+		xas_set_mark(&xas, CACHEFILES_REQ_NEW);
+	xas_unlock(&xas);
+
+	wake_up_all(&cache->daemon_pollwq);
+	return 0;
+}
+
 static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
 {
 	struct cachefiles_object *object;
-- 
2.20.1

