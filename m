Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0FA78661D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 05:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239816AbjHXDrW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 23:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239892AbjHXDrA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:47:00 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19091FD6
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:46:10 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-565b053fe58so827753a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848759; x=1693453559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slvH5erABEtW2nvv6nNGvvoe5mGFS1H1V89UwcERxi4=;
        b=cbb6YHTIFEQj4yQfjGUpRvykeBzedoRrcnJeHycSN6zpLxRKFd2K1sA1PClUDZpn4T
         KK49F+aIpE3Kw/cuZzQabHYGj+DcL5bEjWjkQ+qi7ft3Ev2JbxUbeVYCETHKaq602P+Y
         Q7oloE3/wd+SPkhUMg/xXEsiNT4bfTZky090yFESMFjiMV9iGF50YTAJEOHOG/FFlYOk
         wZOQ2hXf37apCQIv1XImuzja1cULLKP8EH8AUaPzctKv1kopSAYqQMUxWCHyKDVoFD4O
         R+sSI8aAT4VztFaIxvs+T3hnulNn+bEQZ9zTNyY0CnFLm+zjLyVeoOaFF/qATgaNLyIK
         PIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848759; x=1693453559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slvH5erABEtW2nvv6nNGvvoe5mGFS1H1V89UwcERxi4=;
        b=ZdnDTRfRd0yHK6vKW9A8LL3Sd/85H1MGBi56oS2bs2czPM/FZXKtKPdHk0RNYD3PR6
         nMtGtZ9Nk3fC8n4S8bVtNh9euc9WJg5Hw/uZHs5urjdKOXh5UPTbWR7Ri/frjFiDU0zZ
         LAstlD48GbipF2/2iINE+hR8RGBglhh5/Dc9FVhV9Lh9HfPAbL3vuEEp5q8b22zoNCqh
         FmSLBI62UFEa953VFFnD1vSx2Z17wcWnBQ1UzvJnCEbaL0evNxX+gWHvKBuSxlvdKMQJ
         ESXA0F1zX/afbeNWw9Zpp3TDfSOGquyX53ZTTsrfkWa4mmseBEMWiVvEFww4yAxdwOcQ
         lzXA==
X-Gm-Message-State: AOJu0YxAdMBST4vGkz43dIGxb8sdXccekUcPiKxDLBFt8V0ZXQoDvmos
        Z/+hj4F1VubdjK4jvYptkTy6YA==
X-Google-Smtp-Source: AGHT+IE20y+zxkxvqCK4atfI05RSclhW6cQ/eTGKWMSl83j87LaqFIyfEPTvaL3BQlf4vLg1/yn0UQ==
X-Received: by 2002:a05:6a00:1f89:b0:68a:33fc:a091 with SMTP id bg9-20020a056a001f8900b0068a33fca091mr13891773pfb.3.1692848758726;
        Wed, 23 Aug 2023 20:45:58 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:45:58 -0700 (PDT)
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
Subject: [PATCH v5 15/45] rcu: dynamically allocate the rcu-lazy shrinker
Date:   Thu, 24 Aug 2023 11:42:34 +0800
Message-Id: <20230824034304.37411-16-zhengqi.arch@bytedance.com>
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

Use new APIs to dynamically allocate the rcu-lazy shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
CC: rcu@vger.kernel.org
---
 kernel/rcu/tree_nocb.h | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 5598212d1f27..e1c59c33738a 100644
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
@@ -1436,8 +1430,16 @@ void __init rcu_init_nohz(void)
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
+		lazy_rcu_shrinker->seeks = DEFAULT_SEEKS;
+
+		shrinker_register(lazy_rcu_shrinker);
+	}
 #endif // #ifdef CONFIG_RCU_LAZY
 
 	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
-- 
2.30.2

