Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D4C786627
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 05:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239888AbjHXDrh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 23:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239901AbjHXDrC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:47:02 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E661FE7
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:46:13 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6b9cd6876bbso1576337a34.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848767; x=1693453567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbLfXpJ5k+PGfjQYbmEIBs5kJh5lwx6o5Ugx6JEi6xI=;
        b=IiUiN/bjqiAul2GXQb13RT5me6vau/bBJzSckp9JXiUe4upPQ4em6kTToIKAFTll3V
         Od3tGDJwfVOeeuoD7X2EdAVfF3HPWTlZ379KPWAjglBaydKVz0P1Hs1lgLWTBOah8eGj
         9W2J0Tg6X9lao7+B7pf3NZT+M+RtKhGRzRyIYKpYq+oH9zZ4ysBCEvJaRnJQ2l+lgMQs
         g+fM8GGLrltVPCbIHCYmgNFEuprUMghQsdUn/H1ZL0iRuqXsb6LQO6t51GfVcUhEB3FE
         pFTkHgfMldahqqgP2ReV92FlLRtEuIRBNLkFkh+gLZcEWEOsxcxLNSMAqfjCgA5BXPG+
         TcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848767; x=1693453567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbLfXpJ5k+PGfjQYbmEIBs5kJh5lwx6o5Ugx6JEi6xI=;
        b=lEi9RkhZkgknQlHKpQiWx/apxj0NEgPcpsy1ywsP60V7lkOdosbbhslR/zLvZi4KJT
         9WoCoWDMtNIi8ISg+a+MSaKQ54pSMSRnrUwHi37Z9SOECKPP44gcx41eWA3jURP4VUJu
         eYO9OvLgmC5iGGmqpMniZFt0OuNNC/PyH3esSvgKMJGpN1HVQTuCLCwVeTluZJptSFkr
         hCoeqqte0MBGqx2VlJ/QhQNhMqZuTWP8o+jU+OGS6adzp8jztsIZnMCQZoXDYu3jLGDn
         OfrxeXOnp0OTYyb7tWiRD8zKtCRWEW83oxyHfxGL5Tel4ZuTClAYwiX4A7R6PxOJ/aFE
         8gYA==
X-Gm-Message-State: AOJu0Yz5mJXbUJTxFDt9wS1MWv8e0Vpjst6TI3Jm2tbOxMqB5YNaN2Vd
        CPFfMage9vXzqw0PdAz7JwBMPQ==
X-Google-Smtp-Source: AGHT+IElYmAgq8IBCNiz5zLW6QeFhOfwrpP1ZIem3nvpFvdyyt2pB6ZEtNpkzev9+iVdtus0IhkeTA==
X-Received: by 2002:a05:6830:65cb:b0:6b9:db20:4d25 with SMTP id co11-20020a05683065cb00b006b9db204d25mr16409143otb.1.1692848767184;
        Wed, 23 Aug 2023 20:46:07 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:46:06 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Muchun Song <songmuchun@bytedance.com>, rcu@vger.kernel.org
Subject: [PATCH v5 16/45] rcu: dynamically allocate the rcu-kfree shrinker
Date:   Thu, 24 Aug 2023 11:42:35 +0800
Message-Id: <20230824034304.37411-17-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use new APIs to dynamically allocate the rcu-kfree shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
CC: rcu@vger.kernel.org
---
 kernel/rcu/tree.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cb1caefa8bd0..6d2f82f79c65 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3449,13 +3449,6 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 	return freed == 0 ? SHRINK_STOP : freed;
 }
 
-static struct shrinker kfree_rcu_shrinker = {
-	.count_objects = kfree_rcu_shrink_count,
-	.scan_objects = kfree_rcu_shrink_scan,
-	.batch = 0,
-	.seeks = DEFAULT_SEEKS,
-};
-
 void __init kfree_rcu_scheduler_running(void)
 {
 	int cpu;
@@ -4931,6 +4924,7 @@ static void __init kfree_rcu_batch_init(void)
 {
 	int cpu;
 	int i, j;
+	struct shrinker *kfree_rcu_shrinker;
 
 	/* Clamp it to [0:100] seconds interval. */
 	if (rcu_delay_page_cache_fill_msec < 0 ||
@@ -4962,8 +4956,18 @@ static void __init kfree_rcu_batch_init(void)
 		INIT_DELAYED_WORK(&krcp->page_cache_work, fill_page_cache_func);
 		krcp->initialized = true;
 	}
-	if (register_shrinker(&kfree_rcu_shrinker, "rcu-kfree"))
-		pr_err("Failed to register kfree_rcu() shrinker!\n");
+
+	kfree_rcu_shrinker = shrinker_alloc(0, "rcu-kfree");
+	if (!kfree_rcu_shrinker) {
+		pr_err("Failed to allocate kfree_rcu() shrinker!\n");
+		return;
+	}
+
+	kfree_rcu_shrinker->count_objects = kfree_rcu_shrink_count;
+	kfree_rcu_shrinker->scan_objects = kfree_rcu_shrink_scan;
+	kfree_rcu_shrinker->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(kfree_rcu_shrinker);
 }
 
 void __init rcu_init(void)
-- 
2.30.2

