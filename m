Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8755679BDD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238940AbjIKU4K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235978AbjIKJr4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:47:56 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A22E4F
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:47:31 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1befe39630bso9365705ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425651; x=1695030451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ig/SU8otDOD6RD9FAzIUrJXv86Es+SJs+TyE8glTevc=;
        b=NEUmRffRhJaSTKXqZCM78mZ4dMBvqfR9KeknpYAgTEREv+TRYLiPKZJmR7aGmfFtJw
         lA59Bjsg5SzSwzFrVxGPWMBjMMEySoPECKsYU3wBFAzF8c3UKOcvCQ45D5Ufk8I5ddoz
         AnjnmQGkqsjefSc2q7X+LMUF1a2JGByUSm0bKiMLb0MdZ+dpXjr9CNa5+uoX06+RkRky
         aj8NXVADZTjHHo37DDGVBnma+NOkXMCbbzhwRBM/LHGYsLYpg3owvb8fCEeWIcgB3nEq
         xeNqwZtudadfyaYUr3xwHvLs86zt/DwobyjxcosNgVbm8uLs3HIonBE/lbFnuyN0R34a
         +7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425651; x=1695030451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ig/SU8otDOD6RD9FAzIUrJXv86Es+SJs+TyE8glTevc=;
        b=tVaN7zr6qQR/Nxhdqw4d4GqFVY5bGIBgmL5VrZrqtRdy0yl36daWfzN5f71DKNmdZu
         6Rk12JT1NT9a5+Y/JPzI1ui135nvXc9CjPSOQRN6YR+oEerOqBljiJjRs90IRj2gK9rr
         wqImAM6rUuAML5d5LWFKHht66ZzDiowj6gencfDoNUR8t6UxNcz4tupO5x1B4FVRT0Cf
         mFeIAwvN025H2/gnQfXzDxtVSYZYIVaUocBdRwn08ltS/F2fYhDMx2maXLOUCNy0BTDt
         IEt929CCvHKS0WVpHsMxqI+yhKsMG5nhv8o/1UscnKC4wz09KLJEw927hpgdiHp36tvq
         zf/A==
X-Gm-Message-State: AOJu0YxPkdnU4yAXcrEefIUHeZFGh6hAKD4DhOrDI1EktBVU/bBlXcLf
        CjnZmaRcYtv6yKZGxMBa/ZGIFg==
X-Google-Smtp-Source: AGHT+IEl2mpYTODnECMCuBDNAite2AZ131Yxo4SMEA3+9uaLlCuqsjdY37DnC78Awa2ltcDCzu5lqA==
X-Received: by 2002:a17:902:d4c3:b0:1c3:411c:9b98 with SMTP id o3-20020a170902d4c300b001c3411c9b98mr11085339plg.3.1694425650814;
        Mon, 11 Sep 2023 02:47:30 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:47:30 -0700 (PDT)
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
Subject: [PATCH v6 16/45] rcu: dynamically allocate the rcu-kfree shrinker
Date:   Mon, 11 Sep 2023 17:44:15 +0800
Message-Id: <20230911094444.68966-17-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 kernel/rcu/tree.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cb1caefa8bd0..06e2ed495c02 100644
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
@@ -4962,8 +4956,17 @@ static void __init kfree_rcu_batch_init(void)
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
+
+	shrinker_register(kfree_rcu_shrinker);
 }
 
 void __init rcu_init(void)
-- 
2.30.2

