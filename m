Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72E5739BA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 11:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjFVJDu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 05:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjFVJDS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:03:18 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966A44680
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 01:57:29 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b52418c25bso12035505ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 01:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687424219; x=1690016219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOpMuT1tSay47KCV2B0lCCsOSa7MUah7TRoPRzKvzWA=;
        b=ARIMz0kPY37zDpA2KUfwIMWCUvAyZHIYiFTXtRMngKg5guyDvAvZNDKsvB2ZgT8UTW
         A25yLHuKDIGVoaFMSsnctFsAVv7yr9hBv5sSwiDDhv/mHcXUMpPqBe+IawTWyFdB0del
         fl+Pxlo1XCZ20awrxgcMp8gUHyp7xw9pGxosYaiH18lXNbdNEUFeaQtGj4iDzF4J11pb
         jyEKbhwN4kpW66g5W4dvNRCNuWMTsByWhUSRp4GIzQ739D16xyqzHvKa0SrFnLXwxenz
         WdarMgZ86g8pGHWvsC0B3J0QiIU/iI2cSgeTldT8LPJGZSfxzUyvtAnV3WYD0uKX4hXF
         pNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687424219; x=1690016219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOpMuT1tSay47KCV2B0lCCsOSa7MUah7TRoPRzKvzWA=;
        b=W9Ltk1PQQo225fOHVUKEwyaPjAA1sxosGKABBA0HRCDSWYPlUJipN6BW+LWBrakHgb
         ZyDHrOWGkAzBmRtSC8/4p+wT73urPkg4uz/n3LxFxf6+JN4jkg2KytBsL/Zd5AQbOgyf
         1VPaGx/DQ0XL7xBTsYn/VnyL3teIodiqe49ZBD8zhFzJsWR16p0SedRa/B2vGIMOQXg/
         93WNeasrYIgfmwVv8QkZIGOgLaGexoi1Dp54/sqg4HEiUAWufsUO42TIzX5Gtfoi8AlF
         2tEk69zFod+Ay1ZZQ41+7M6RQsLfKbvDcRLm9frE9utLqbUmPQnV2zeAFKug6kMs6v2V
         4/WQ==
X-Gm-Message-State: AC+VfDwUT6vukhuqAub/jaL680yEl1+7+6wBm48hOTKhX8gRBicfVpJD
        QpO/KsQbXMhGzuLe0Ewax5vczg==
X-Google-Smtp-Source: ACHHUZ7DqrxYhESUqlF1zio/fEoWG5nPFDtKmAeSV45runPF4798dCp+1eyZAVtYptcjl0nDKDsZDg==
X-Received: by 2002:a17:903:230c:b0:1b3:ec39:f42c with SMTP id d12-20020a170903230c00b001b3ec39f42cmr21844690plh.5.1687424219648;
        Thu, 22 Jun 2023 01:56:59 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b001b549fce345sm4806971plw.230.2023.06.22.01.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:56:59 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 22/29] drm/ttm: introduce pool_shrink_rwsem
Date:   Thu, 22 Jun 2023 16:53:28 +0800
Message-Id: <20230622085335.77010-23-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
References: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, the synchronize_shrinkers() is only used by TTM
pool. It only requires that no shrinkers run in parallel.

After we use RCU+refcount method to implement the lockless
slab shrink, we can not use shrinker_rwsem or synchronize_rcu()
to guarantee that all shrinker invocations have seen an update
before freeing memory.

So we introduce a new pool_shrink_rwsem to implement a private
synchronize_shrinkers(), so as to achieve the same purpose.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 15 +++++++++++++++
 include/linux/shrinker.h       |  1 -
 mm/vmscan.c                    | 15 ---------------
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index cddb9151d20f..713b1c0a70e1 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -74,6 +74,7 @@ static struct ttm_pool_type global_dma32_uncached[MAX_ORDER + 1];
 static spinlock_t shrinker_lock;
 static struct list_head shrinker_list;
 static struct shrinker mm_shrinker;
+static DECLARE_RWSEM(pool_shrink_rwsem);
 
 /* Allocate pages of size 1 << order with the given gfp_flags */
 static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
@@ -317,6 +318,7 @@ static unsigned int ttm_pool_shrink(void)
 	unsigned int num_pages;
 	struct page *p;
 
+	down_read(&pool_shrink_rwsem);
 	spin_lock(&shrinker_lock);
 	pt = list_first_entry(&shrinker_list, typeof(*pt), shrinker_list);
 	list_move_tail(&pt->shrinker_list, &shrinker_list);
@@ -329,6 +331,7 @@ static unsigned int ttm_pool_shrink(void)
 	} else {
 		num_pages = 0;
 	}
+	up_read(&pool_shrink_rwsem);
 
 	return num_pages;
 }
@@ -572,6 +575,18 @@ void ttm_pool_init(struct ttm_pool *pool, struct device *dev,
 }
 EXPORT_SYMBOL(ttm_pool_init);
 
+/**
+ * synchronize_shrinkers - Wait for all running shrinkers to complete.
+ *
+ * This is useful to guarantee that all shrinker invocations have seen an
+ * update, before freeing memory, similar to rcu.
+ */
+static void synchronize_shrinkers(void)
+{
+	down_write(&pool_shrink_rwsem);
+	up_write(&pool_shrink_rwsem);
+}
+
 /**
  * ttm_pool_fini - Cleanup a pool
  *
diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 8e9ba6fa3fcc..4094e4c44e80 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -105,7 +105,6 @@ extern int __printf(2, 3) register_shrinker(struct shrinker *shrinker,
 					    const char *fmt, ...);
 extern void unregister_shrinker(struct shrinker *shrinker);
 extern void free_prealloced_shrinker(struct shrinker *shrinker);
-extern void synchronize_shrinkers(void);
 
 typedef unsigned long (*count_objects_cb)(struct shrinker *s,
 					  struct shrink_control *sc);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 64ff598fbad9..3a8d50ad6ff6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -844,21 +844,6 @@ void unregister_and_free_shrinker(struct shrinker *shrinker)
 }
 EXPORT_SYMBOL(unregister_and_free_shrinker);
 
-/**
- * synchronize_shrinkers - Wait for all running shrinkers to complete.
- *
- * This is equivalent to calling unregister_shrink() and register_shrinker(),
- * but atomically and with less overhead. This is useful to guarantee that all
- * shrinker invocations have seen an update, before freeing memory, similar to
- * rcu.
- */
-void synchronize_shrinkers(void)
-{
-	down_write(&shrinker_rwsem);
-	up_write(&shrinker_rwsem);
-}
-EXPORT_SYMBOL(synchronize_shrinkers);
-
 #define SHRINK_BATCH 128
 
 static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
-- 
2.30.2

