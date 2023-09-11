Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E330079ACB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 01:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbjIKUxB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbjIKJ07 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:26:59 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8124FCA
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:26:32 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1befe39630bso9331675ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694424392; x=1695029192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OticL2Ym/Xp3/1qxI1A+TfW6cmSsSh/JXNH+7cjvxw=;
        b=Xog5Xh2Etd8dTva8VIW3a2leGj/E/Fc7mojM4XOrFEaBws3EG6oQdFQtduC8DTURI8
         dss3HtvafZeLFtfki83YwGkArFkx7+ma7PMwt2gXLgEkjlBgEV+mayhIItzBovOJERZB
         fVZFew/+Lz4M9iONAJM+nZSIpcat2fqwR0la6OChkVQk2apQHr/5Y6NC0RpISvd+tsKW
         0qdXep8u1tJHJbNTuwQHAlmitf7XuflkRVZm3LXgniP1csRKfG9W7PbXzQpgRezoWLjA
         I5r6QKhIRBr5hiSrC7NepWS7JkpaRT0jM4XddR0Ozh44q03F7D2f0iReCJ2StU9beBzr
         OBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694424392; x=1695029192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OticL2Ym/Xp3/1qxI1A+TfW6cmSsSh/JXNH+7cjvxw=;
        b=qBZrsU7epne/xPfS0uixwfsYSYvipwTSu/U/qFhCcc+t8HMxXPYsGWfXqVt+ePJuM9
         UXYE7BcNjxpSm0ARaGmRnfM6EWW+X74k4EI+f19LDK2KRo0yCYDlyYHwJ/oUB/ZJQFzp
         4/+KINT0+enl59/o5rvVDF+tLt1DzoVEExOtA7TSfB9hbqq5ru+H5QfAR3XzFj1CTaEu
         RAQUg0Ohrw2vX/ylfTyHmjSHZkWBfkulYa6OMz2FXNIexUTMex6XyXRFbSrDO+hZ00Yb
         lsvaMaNgwYFBTvahmgCt0vsUqIHRoxvT/tem7RP9EUAwpp8xKozD0zsypHl9QjRgl43J
         22BA==
X-Gm-Message-State: AOJu0Yx/wkfGHaZ36oTM/jvUI3RwBUNmh9/lJi5TdGE9WDE4c1wAcWOy
        Ta3DmNMGtXsq1/P5s7hROvGJbYFMsd5atNtDi/Y=
X-Google-Smtp-Source: AGHT+IHqHCcjDv6SGcleO/Iy3SuA6Ef0lm330IesHOCkoVNzn7x2raz6YBTG533lbhtmW62vMDR7bQ==
X-Received: by 2002:a17:902:e546:b0:1bb:9e6e:a9f3 with SMTP id n6-20020a170902e54600b001bb9e6ea9f3mr10956484plf.4.1694424391926;
        Mon, 11 Sep 2023 02:26:31 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902788900b001b89466a5f4sm5964623pll.105.2023.09.11.02.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:26:31 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, joel@joelfernandes.org,
        christian.koenig@amd.com, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH v4 4/4] drm/ttm: introduce pool_shrink_rwsem
Date:   Mon, 11 Sep 2023 17:25:17 +0800
Message-Id: <20230911092517.64141-5-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230911092517.64141-1-zhengqi.arch@bytedance.com>
References: <20230911092517.64141-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
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

