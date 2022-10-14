Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCA55FEA21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 10:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJNIH0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 04:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiJNIHI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 04:07:08 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0252C1BE1FD
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 01:06:52 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 78so3660130pgb.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 01:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJhr9GEso5XW6jomGaYhGKFuz4nHt5uQZJthz4evrwY=;
        b=qVTtmipam3rM6KfQlKjS9oB81qvNT4EbK05pZ/u8KhqTeMxi1fgQuugD0vIdferh4A
         YbPU1ZdtYPR/ZPK5WVwhOLx0PTxgdovGreGSp3BwRvbk/eVN1SZMEkZTSXOGevy3iugB
         AogReglRz/ngZipTLIK2lRwUlzQ7E6noznmewO+dUqWDsZMVyqKhugFDig/QBvybFt8t
         Vsx7w7v2uUUB5MSDzYmRU6/oD4TB2PLfO4YaDpnr5j9n7LFnLE8L91zITpD9smh490eb
         0/OSLFJHUGkje4f/2tYzx91hXBA5zHhogkFUEypk+BKxWcCeQ66erKddmZAiYYVM9FTE
         hyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJhr9GEso5XW6jomGaYhGKFuz4nHt5uQZJthz4evrwY=;
        b=AuJWtyXdgsWz8abAyrhN96Azfbi+sIvKTxtUosSI2jJpaWp2gSV24wGWzozhYGg8zX
         gwiG5n2Lvz+y2+uoSR6/s536x3pOqOdgdDkPXDijFkfEwzEI+e76Nfgnuanb6D7wqCV0
         iJG1sClOkJ6/Hhjo1fCpd+++/B6FXrkc27V15j61cNPgRVdSgoJ9AnRl1Y6JCUUAonL8
         Hs6vztsds3c76Kfh7MrA6TYLbyCJ3oRn+tnJGcLnwKHw5yc7vMOwFmeJ9Nu1t6FyF7m1
         +AGnZs2+EBBwK5/DKl5pYL5/XFaib1mBLOi/AMCzOzVONDGYvSWxOTA4TR+4PScs0CLq
         ze3Q==
X-Gm-Message-State: ACrzQf1Jq3gTaYRiX857AvJTsVvNpD9o5dzepY+9k7XsDfOInsLK2co/
        hiQLOJEVgGtN6a2ZleRqgoV5IpR5bMcBRPz9
X-Google-Smtp-Source: AMsMyM5JxpG9s5zxrgZFOJc1qRRC6V0WPzYraBHHSO028+hk4ZTnTxwCa5/lFVyTrnav5G/YHeoJVg==
X-Received: by 2002:a05:6a00:1a0e:b0:547:1cf9:40e8 with SMTP id g14-20020a056a001a0e00b005471cf940e8mr3894976pfv.82.1665734811751;
        Fri, 14 Oct 2022 01:06:51 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([63.216.146.188])
        by smtp.gmail.com with ESMTPSA id ik20-20020a170902ab1400b001730a1af0fbsm1119196plb.23.2022.10.14.01.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 01:06:51 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     dhowells@redhat.com, xiang@kernel.org, jefflexu@linux.alibaba.com
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, Jia Zhu <zhujia.zj@bytedance.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH V3 5/5] cachefiles: add restore command to recover inflight ondemand read requests
Date:   Fri, 14 Oct 2022 16:05:59 +0800
Message-Id: <20221014080559.42108-6-zhujia.zj@bytedance.com>
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

Previously, in ondemand read scenario, if the anonymous fd was closed by
user daemon, inflight and subsequent read requests would return EIO.
As long as the device connection is not released, user daemon can hold
and restore inflight requests by setting the request flag to
CACHEFILES_REQ_NEW.

Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
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
index 3d94990a8b38..e1f8bd47a315 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -301,6 +301,9 @@ extern ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 extern int cachefiles_ondemand_copen(struct cachefiles_cache *cache,
 				     char *args);
 
+extern int cachefiles_ondemand_restore(struct cachefiles_cache *cache,
+					char *args);
+
 extern int cachefiles_ondemand_init_object(struct cachefiles_object *object);
 extern void cachefiles_ondemand_clean_object(struct cachefiles_object *object);
 
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index d8dce55d907c..c773ea940cc1 100644
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

