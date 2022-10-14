Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DB55FE74C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 05:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJNDJO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Oct 2022 23:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiJNDIi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:08:38 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6772BEF5A1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Oct 2022 20:08:33 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id n18-20020a17090ade9200b0020b0012097cso7077993pjv.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Oct 2022 20:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPYvhf6hYj1gmxvw7dTnMnSbUK/V1sm26ubqcw4lSFY=;
        b=uR1wnjzoh66Ntwurmw7mKwF1tShfnXY9UWfot3dsRbBXUbtebLzF0fV/OdZO1YB5Yw
         PcIMj+Ydd5Hn2ryM/TVGAKfZN0TZjdE6wCe+F3ctIO6FHCtRgJFCsBZIabYASTtj7hln
         XLsFKwqQlgniZqtFO6A/gIowSCRYZAj2hcvGo8DCes9+7qUqhO1J776gtuITkdeK0N+R
         UCWdGHLsKwtvYhGN+SfYD2BTsK0or91WpNavAyzl3NsTvh4cFtEMEUkWSbpWAPS3BfS5
         gfLNCK1IEWcc2/kryI9FvqKKmhhxnFa5vC2Pe9soKZt87Sg2tIscUDwTaTd9N+OwA2hF
         baMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPYvhf6hYj1gmxvw7dTnMnSbUK/V1sm26ubqcw4lSFY=;
        b=DiJ3xunSvISIXcbcPLCB7XDiuShKWkPhxCXnyH6P5SgrkudSMYGHl0flMclUneW5NB
         VekvM+Svu7lYXLL8yrKGoYNKWfj+2T1zAj21i2qyGWztrRJXBs2mwAg+sJAdsClSlO2z
         +MftAiCk7W71baJpQItODIEFT+pa6XBFFZXtmFioVkOTXVrVUrNl1rG7dOPuwWFHmRYL
         oZO4qj5eVZ9+kycCby1lQG4H+ENgwaXpjAuIzFUV//UCR8uGzYb57rDe8Qw1QxmhYJna
         9OivlN2T02NholbycxGJ7qqr9q/9uQ2w2swWzIZxhLqFAMtv4m8Wtknnbk+1fzbXgDD3
         WDvw==
X-Gm-Message-State: ACrzQf0rqJNXEMUQrqUPd1u27tfUGUQCy4086xlbraDnWoTGJAHBW/6p
        kDxH9R3T6VKBqkukhNGO4IpDmg==
X-Google-Smtp-Source: AMsMyM4JUmouJomkbkEP9IQpxtTBmIPr2OqA4geZ0pPrmUDavC6IaCWTRrMaDFGGxduazCATfRujOA==
X-Received: by 2002:a17:902:db11:b0:17d:5e67:c51c with SMTP id m17-20020a170902db1100b0017d5e67c51cmr2829795plx.64.1665716912810;
        Thu, 13 Oct 2022 20:08:32 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([63.216.146.183])
        by smtp.gmail.com with ESMTPSA id h4-20020a17090a710400b0020ae09e9724sm425524pjk.53.2022.10.13.20.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 20:08:32 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     dhowells@redhat.com, xiang@kernel.org, jefflexu@linux.alibaba.com
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, Jia Zhu <zhujia.zj@bytedance.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH V2 5/5] cachefiles: add restore command to recover inflight ondemand read requests
Date:   Fri, 14 Oct 2022 11:07:45 +0800
Message-Id: <20221014030745.25748-6-zhujia.zj@bytedance.com>
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
index 98d6cf58db11..a3cacba57def 100644
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
index c9eea89befec..08677c9d0004 100644
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

