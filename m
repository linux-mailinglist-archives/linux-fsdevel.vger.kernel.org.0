Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BEC5984DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 15:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244718AbiHRNxi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 09:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245339AbiHRNxK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:53:10 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455EE659E5
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Aug 2022 06:53:01 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id 2so1596131pll.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Aug 2022 06:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Q3+sIJxzAESYgoNj/gGe5uNrnE6V3K6wR3w/d3iHqFA=;
        b=S891HZY7IwVovb2S3pGJmF1I/jxpC/Cx58Dz4VCcrS4LeuU4B38PvPKR5jL412EoTx
         aDDFzA13FGGTTUEj58LsCYckux/M88Dkv0kW7w/z0s5j/pdNOwqjM+1qussJde2Fq8qF
         XPZ+Xawp1IkhHX2GzDtxavXary6tCvassvl+reP9Yr/wYd384decJjrLBVHLyBI+jgEl
         wXH12rGaBVfnLd+NjWklNxO8uD9ZXocT7byuy1ngo2Q2EKF9bgMnMUYM3f3JX5Lf4fnT
         K9R2w+nQ6t1taVE6456VKK5iV/7/PmPbYzULchJNYuAlckTsA1segPi+0CmmXvY5T92q
         15/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Q3+sIJxzAESYgoNj/gGe5uNrnE6V3K6wR3w/d3iHqFA=;
        b=uh/x6tJ45DqGhD8vkFx3t6OuDp1N6Eu0WLvXxVO2Ejv6ipjGnLf+IKl+UZJOCZPZ3F
         xNwYV+mYZTGOKHv4w+GVldEUIoumdLLv57l4MrwUYodZYjDnoJOiNMtjFcGqaEzNdrnY
         +lMKPW+bxniEoYA8XOSwVAl43zUwu7eqzaCNkcEckFokBOiHAMyo8sitCXiItsFI0B21
         bDq2+a6AEn1xmoiHatAVc8JDRulSM9kMux3eMG8eUnap7N/gnTEvHsD2AzULfE87VFNn
         q5y/kwxkj7Oq/Y2lzh1TNUVEAg0EJuKrO8XgqBMU3R2xR65jQXfKWuJq0eKgrsYDOsOP
         ngxA==
X-Gm-Message-State: ACgBeo3JkTqU+Qn7O4xbBcBdj8P02HcW7sA7wt5/me/Xo7cIeqIQ01bt
        MylguaO14pL6/2zRaQ2atZX75g==
X-Google-Smtp-Source: AA6agR5vruAaYauuniDR7hv2XcV4ouNLjLvo+7M8xNDwBLLOR4XyoMvqf+cSfddJh/MTqflxloa2LA==
X-Received: by 2002:a17:90b:3952:b0:1fa:7f18:110f with SMTP id oe18-20020a17090b395200b001fa7f18110fmr3237446pjb.19.1660830780916;
        Thu, 18 Aug 2022 06:53:00 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902ce1100b0016db0d877e4sm1385697plg.221.2022.08.18.06.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 06:53:00 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     dhowells@redhat.com, xiang@kernel.org, jefflexu@linux.alibaba.com
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, Jia Zhu <zhujia.zj@bytedance.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [RFC PATCH 5/5] cachefiles: add restore command to recover inflight ondemand read requests
Date:   Thu, 18 Aug 2022 21:52:04 +0800
Message-Id: <20220818135204.49878-6-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220818135204.49878-1-zhujia.zj@bytedance.com>
References: <20220818135204.49878-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index b4af67f1cbd6..d504c61a5f03 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -303,6 +303,9 @@ extern ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 extern int cachefiles_ondemand_copen(struct cachefiles_cache *cache,
 				     char *args);
 
+extern int cachefiles_ondemand_restore(struct cachefiles_cache *cache,
+					char *args);
+
 extern int cachefiles_ondemand_init_object(struct cachefiles_object *object);
 extern void cachefiles_ondemand_clean_object(struct cachefiles_object *object);
 
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 79ffb19380cd..5b1c447da976 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -178,6 +178,29 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
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
+	 * Search the requests which being processed before
+	 * the user daemon crashed.
+	 * Set the CACHEFILES_REQ_NEW flag and user daemon will reprocess it.
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

