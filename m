Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2BE50E00A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 14:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240851AbiDYMZW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 08:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239940AbiDYMZQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:25:16 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A096460A8C;
        Mon, 25 Apr 2022 05:21:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VBG8mfh_1650889313;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VBG8mfh_1650889313)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 25 Apr 2022 20:21:54 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com, zhangjiachen.jaycee@bytedance.com,
        zhujia.zj@bytedance.com
Subject: [PATCH v10 06/21] cachefiles: enable on-demand read mode
Date:   Mon, 25 Apr 2022 20:21:28 +0800
Message-Id: <20220425122143.56815-7-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220425122143.56815-1-jefflexu@linux.alibaba.com>
References: <20220425122143.56815-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Enable on-demand read mode by adding an optional parameter to the "bind"
command.

On-demand mode will be turned on when this parameter is "ondemand", i.e.
"bind ondemand". Otherwise cachefiles will work in the original mode.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/daemon.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 5b1d0642c749..aa4efcabb5e3 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -755,11 +755,6 @@ static int cachefiles_daemon_bind(struct cachefiles_cache *cache, char *args)
 	    cache->brun_percent  >= 100)
 		return -ERANGE;
 
-	if (*args) {
-		pr_err("'bind' command doesn't take an argument\n");
-		return -EINVAL;
-	}
-
 	if (!cache->rootdirname) {
 		pr_err("No cache directory specified\n");
 		return -EINVAL;
@@ -771,6 +766,18 @@ static int cachefiles_daemon_bind(struct cachefiles_cache *cache, char *args)
 		return -EBUSY;
 	}
 
+	if (IS_ENABLED(CONFIG_CACHEFILES_ONDEMAND)) {
+		if (!strcmp(args, "ondemand")) {
+			set_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags);
+		} else if (*args) {
+			pr_err("Invalid argument to the 'bind' command\n");
+			return -EINVAL;
+		}
+	} else if (*args) {
+		pr_err("'bind' command doesn't take an argument\n");
+		return -EINVAL;
+	}
+
 	/* Make sure we have copies of the tag string */
 	if (!cache->tag) {
 		/*
-- 
2.27.0

