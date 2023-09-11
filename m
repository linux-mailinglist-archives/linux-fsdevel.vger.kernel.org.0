Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347D479BB87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbjIKUww (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbjIKJrs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:47:48 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382C1E40
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:47:23 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-273e3d8b57aso547851a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425642; x=1695030442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nO5XG1oNP6pUjS3WN2+RrRDElLAKlnsgenuSaZhp694=;
        b=CwGNapEsGEKLOP1WtNH0uwIv9Lr9oKEL35X/KtieiyH9m5IoCCEMLpq2cAk5aBg9wa
         K5Ycps6CA2+bGZuUNVF93Vjtx1PyH2OyaHPcSMsfJfZ8XxVfhcmsHf4xVMkfLfjwtKGc
         /L3HcDLGW2qEUyYkyxNjql2X8XBxk4dW6MppiV+JNYEo2AwcB+DYWtFt4wWNmz2YLKYK
         4UKN5C1e6q0tSUQxE0RQymndbGMCVN9sL4toX1mVbAht8dsRIhuFcF9IH47NvACTC/TY
         IEZxV2scnE31dCjQqTOjdN8Jk3KWmlzjeJeNyKqhUzZIf0nfDNXZEyjyc3t0XbE7GqbC
         DyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425642; x=1695030442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nO5XG1oNP6pUjS3WN2+RrRDElLAKlnsgenuSaZhp694=;
        b=uPIkr1bvmD7KBRRiPnHgc3eGhacZbf1Cq7pISf4SbnZSFHx7HOumI7l+P4Mo+7nYfM
         GAvlHJKWxhnvPbtxzwiVo/xhjVfX2IWVIu7YNUD3a9WP7CzXPN3yFqS2RfUjcJsF9nGK
         v/xmyyAdLRZ03HpZ62RECkF9/aBrxyljsgr9UF6clDeL/Qex2Y0axjK1jMUcuODqApIO
         7rapzSeeQlkSvG10Xh54jtw2S6rwlaiYbiEzLRhYNoh1x1wVik5jEtT/NSNS8HbZUhaY
         IGBmKMAZ/Bae0gTRRvMy2cixqw6TbrYZXvYY+gNaQa13oJCHdNT1qyux8wOmQP00pDXo
         VJ0g==
X-Gm-Message-State: AOJu0Yyp6ZOIvfbNOb/+qL2GYxgDoeG//qIdB68tKLRIxSJSILyMJG/m
        gQYkl1V+EIdZr/RG/Cvn+walEELzKlVIREQ17hU=
X-Google-Smtp-Source: AGHT+IGU0jWm5aUKgo65aoc1FmWqzP1rWPbNbFl1TEnUeGhWf2rII1K9xqSMkpAW8Vpnx3sOpXBIKg==
X-Received: by 2002:a05:6a21:a594:b0:13e:1d49:7249 with SMTP id gd20-20020a056a21a59400b0013e1d497249mr13273426pzc.2.1694425642605;
        Mon, 11 Sep 2023 02:47:22 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:47:22 -0700 (PDT)
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
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH v6 15/45] rcu: dynamically allocate the rcu-lazy shrinker
Date:   Mon, 11 Sep 2023 17:44:14 +0800
Message-Id: <20230911094444.68966-16-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use new APIs to dynamically allocate the rcu-lazy shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
CC: rcu@vger.kernel.org
---
 kernel/rcu/tree_nocb.h | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 5598212d1f27..4efbf7333d4e 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1396,13 +1396,6 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 
 	return count ? count : SHRINK_STOP;
 }
-
-static struct shrinker lazy_rcu_shrinker = {
-	.count_objects = lazy_rcu_shrink_count,
-	.scan_objects = lazy_rcu_shrink_scan,
-	.batch = 0,
-	.seeks = DEFAULT_SEEKS,
-};
 #endif // #ifdef CONFIG_RCU_LAZY
 
 void __init rcu_init_nohz(void)
@@ -1410,6 +1403,7 @@ void __init rcu_init_nohz(void)
 	int cpu;
 	struct rcu_data *rdp;
 	const struct cpumask *cpumask = NULL;
+	struct shrinker * __maybe_unused lazy_rcu_shrinker;
 
 #if defined(CONFIG_NO_HZ_FULL)
 	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
@@ -1436,8 +1430,15 @@ void __init rcu_init_nohz(void)
 		return;
 
 #ifdef CONFIG_RCU_LAZY
-	if (register_shrinker(&lazy_rcu_shrinker, "rcu-lazy"))
-		pr_err("Failed to register lazy_rcu shrinker!\n");
+	lazy_rcu_shrinker = shrinker_alloc(0, "rcu-lazy");
+	if (!lazy_rcu_shrinker) {
+		pr_err("Failed to allocate lazy_rcu shrinker!\n");
+	} else {
+		lazy_rcu_shrinker->count_objects = lazy_rcu_shrink_count;
+		lazy_rcu_shrinker->scan_objects = lazy_rcu_shrink_scan;
+
+		shrinker_register(lazy_rcu_shrinker);
+	}
 #endif // #ifdef CONFIG_RCU_LAZY
 
 	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
-- 
2.30.2

