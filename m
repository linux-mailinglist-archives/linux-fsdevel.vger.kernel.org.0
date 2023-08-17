Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF13477F523
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 13:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350195AbjHQLZw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 07:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350265AbjHQLZX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:25:23 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212A92D61
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 04:24:58 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bf11a7cf9fso1078075ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 04:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692271497; x=1692876297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=911+1tsknd0Axh08FSyo1C2XHRSPudC4DWkW5UJVRrk=;
        b=cA4f838cwKDCXl304yY6Bdya3sZtOAKC+Hsn8W3mZrcTRgcxiCgLsQyvfxL1jukZL9
         nKr7MMZpxGVrpwvL2HsAfMZdb1P8xQBG1DppWMK8w9t56teRJ/teUPED6u3L9/uys/xX
         pE6WrpK4I0zbl4vH6z6dOKlI/bR24JFeBwreq4oD73+dC1NHlwxN7wwMH2HpmTViXWud
         XmTi1nDWRHDsKRPmHbck7NCInMFhiWEvBUww2iL0lYBMLx/f3wnp6jV0cS02Na2xFH2J
         b0j9WovTWwU9nWIqbktzYe2d+KJ2M3ejDKtpHkNKcXs1nw21tqUXbZcC+SpD4cHbDcP6
         wTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692271497; x=1692876297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=911+1tsknd0Axh08FSyo1C2XHRSPudC4DWkW5UJVRrk=;
        b=RqkBn6ryfXKLh3mG1E3XmmrXJL1WOTsv7HvZ4/p1ISxCsD+DsX4kVyG2+LXk+lx5Q6
         aHF0IGgITMomlEb2if72WHhxwoJ/NHdJBTicRrAgxWzBNIQvc3WwEEK8+eT3U+Mt39Zv
         9qq7RamCB0Ar621DeUiZISn3WA76VCsH1z5Yi1Dx3fbnWvaRIHZ5ZFVJsf3UbPTnLDs4
         B6lodDHRUvDko/amKWPmqKZWw3IJUFRh4KguSKx1hEkLmIt49JPLNBOrKcU0xNCqkoe/
         0RgpIFFYgzJCFOHNMnE9c6N5n/0z616n8GQ16XPEwZm/ngXyPKvit8aF7ccUbFb3VViJ
         +l+w==
X-Gm-Message-State: AOJu0YyG+vqpLcDVWN06rbffAJnH7dvfulQBkSS+coHmBt8dE+Zfd/nO
        V9Dh1cLNdwaXZ/8CyaSiF0joOQ==
X-Google-Smtp-Source: AGHT+IEi6XCkkhZUGIIuk//7TiBrpWGPkb49JnYoPeW/vawLwjM+O4sUYu0TPRQhIOAxSsp6dmnszA==
X-Received: by 2002:a17:902:db0b:b0:1b3:d8ac:8db3 with SMTP id m11-20020a170902db0b00b001b3d8ac8db3mr5165064plx.6.1692271497563;
        Thu, 17 Aug 2023 04:24:57 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id jd22-20020a170903261600b001bde877a7casm7229309plb.264.2023.08.17.04.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 04:24:57 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, joel@joelfernandes.org,
        christian.koenig@amd.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 4/5] drm/ttm: introduce pool_shrink_rwsem
Date:   Thu, 17 Aug 2023 19:24:01 +0800
Message-Id: <20230817112402.77010-5-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230817112402.77010-1-zhengqi.arch@bytedance.com>
References: <20230817112402.77010-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, the synchronize_shrinkers() is only used by TTM pool. It only
requires that no shrinkers run in parallel.

After we use RCU+refcount method to implement the lockless slab shrink,
we can not use shrinker_rwsem or synchronize_rcu() to guarantee that all
shrinker invocations have seen an update before freeing memory.

So we introduce a new pool_shrink_rwsem to implement a private
ttm_pool_synchronize_shrinkers(), so as to achieve the same purpose.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 17 ++++++++++++++++-
 include/linux/shrinker.h       |  1 -
 mm/shrinker.c                  | 15 ---------------
 3 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index cddb9151d20f..648ca70403a7 100644
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
+ * ttm_pool_synchronize_shrinkers - Wait for all running shrinkers to complete.
+ *
+ * This is useful to guarantee that all shrinker invocations have seen an
+ * update, before freeing memory, similar to rcu.
+ */
+static void ttm_pool_synchronize_shrinkers(void)
+{
+	down_write(&pool_shrink_rwsem);
+	up_write(&pool_shrink_rwsem);
+}
+
 /**
  * ttm_pool_fini - Cleanup a pool
  *
@@ -593,7 +608,7 @@ void ttm_pool_fini(struct ttm_pool *pool)
 	/* We removed the pool types from the LRU, but we need to also make sure
 	 * that no shrinker is concurrently freeing pages from the pool.
 	 */
-	synchronize_shrinkers();
+	ttm_pool_synchronize_shrinkers();
 }
 EXPORT_SYMBOL(ttm_pool_fini);
 
diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 8dc15aa37410..6b5843c3b827 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -103,7 +103,6 @@ extern int __printf(2, 3) register_shrinker(struct shrinker *shrinker,
 					    const char *fmt, ...);
 extern void unregister_shrinker(struct shrinker *shrinker);
 extern void free_prealloced_shrinker(struct shrinker *shrinker);
-extern void synchronize_shrinkers(void);
 
 #ifdef CONFIG_SHRINKER_DEBUG
 extern int __printf(2, 3) shrinker_debugfs_rename(struct shrinker *shrinker,
diff --git a/mm/shrinker.c b/mm/shrinker.c
index 043c87ccfab4..a16cd448b924 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -692,18 +692,3 @@ void unregister_shrinker(struct shrinker *shrinker)
 	shrinker->nr_deferred = NULL;
 }
 EXPORT_SYMBOL(unregister_shrinker);
-
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
-- 
2.30.2

