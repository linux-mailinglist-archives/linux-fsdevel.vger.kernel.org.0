Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D7F75EFDB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 11:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjGXJsI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 05:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjGXJr2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:47:28 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842A01BE4
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 02:46:20 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bb85ed352bso2229905ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 02:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690191978; x=1690796778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJ34aDXYlHmjcWHNnO8BUtZL0Yf5ZszuCt3/FkcxObI=;
        b=dPg8Z+s3aha2IvphpVKs8g7PSY6piop3d9NgPI5ubIDitgffw9A2UJF008ettaOzL2
         E1tyNH7CPDs7txXWOfoA23V8TkeR2HnX04I7DoxtzP6sL4XEnTxiiEMAs0kV9Z/otM2W
         0kOcjwbHjS6iULnGuX+LKfjLBZnKtzDuWFv8l1d9/Rkqg83rJ36ocDx6bY7GsC2wtJpk
         Mw6apkZAnLMNttQVQifEE+ksvX6HBpvA7k/G1tddocZPzT2wZK5koTXpHocOk7zUb799
         2LPg0QZl2ME3q58o3tQeyyaY1BlYV7m8Ier04lnGoxRFxPK9Wx4EcovR5xvgXGZWDCe6
         9eCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690191978; x=1690796778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJ34aDXYlHmjcWHNnO8BUtZL0Yf5ZszuCt3/FkcxObI=;
        b=Zustd8a15LOFtUXDx0f7RMY5AEIxacOXOt+RI2PCA2i2UUDrUsZR3Z9gdVLoYtqHC5
         OvD/Kj+vjqTERr5KJWz7qwY12ArpkNwZWY2lMJ6nGyZVxEKYHl4poyEbEpfWy1DewwrL
         O7/bdeagSkRjAYNBbN6JIFDhZC1P8iCWePsYABgG+AxUsLOVo32eEGdsDJj4Gq8q3xZD
         u5cXH6DqDawF73GJRSwpuPipL+a0Is7rA+mg7fIF+Wgx7zaaDO8e1GiqBvZgUNzBVYf/
         XhYgBkPuiZXmOtps7V5jE6pU9/b8JywVTyXzsXr24pRJDfjZ+onoCKaO4/9+2NBMiuFC
         bTVw==
X-Gm-Message-State: ABy/qLbtFG+SvO2tgiGJAzyY0RcgzGblkyj46MLBcjZc68YXvXYtMkr8
        mohJ9V/kn0bq8pDCkTbj10BaRQ==
X-Google-Smtp-Source: APBJJlGS+SYk55mAAJOUNGx8fxUIn0OJAQvX8pDu/8/ugt1o28j6t6h3zVeppHUSF07Rw5MgS0vxBA==
X-Received: by 2002:a17:902:d484:b0:1b8:a27d:f591 with SMTP id c4-20020a170902d48400b001b8a27df591mr12255719plg.5.1690191978640;
        Mon, 24 Jul 2023 02:46:18 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001bb20380bf2sm8467233pld.13.2023.07.24.02.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:46:18 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 06/47] drm/ttm: dynamically allocate the drm-ttm_pool shrinker
Date:   Mon, 24 Jul 2023 17:43:13 +0800
Message-Id: <20230724094354.90817-7-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use new APIs to dynamically allocate the drm-ttm_pool shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index cddb9151d20f..e1eb73d0b72a 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -73,7 +73,7 @@ static struct ttm_pool_type global_dma32_uncached[MAX_ORDER + 1];
 
 static spinlock_t shrinker_lock;
 static struct list_head shrinker_list;
-static struct shrinker mm_shrinker;
+static struct shrinker *mm_shrinker;
 
 /* Allocate pages of size 1 << order with the given gfp_flags */
 static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
@@ -734,8 +734,8 @@ static int ttm_pool_debugfs_shrink_show(struct seq_file *m, void *data)
 	struct shrink_control sc = { .gfp_mask = GFP_NOFS };
 
 	fs_reclaim_acquire(GFP_KERNEL);
-	seq_printf(m, "%lu/%lu\n", ttm_pool_shrinker_count(&mm_shrinker, &sc),
-		   ttm_pool_shrinker_scan(&mm_shrinker, &sc));
+	seq_printf(m, "%lu/%lu\n", ttm_pool_shrinker_count(mm_shrinker, &sc),
+		   ttm_pool_shrinker_scan(mm_shrinker, &sc));
 	fs_reclaim_release(GFP_KERNEL);
 
 	return 0;
@@ -779,10 +779,17 @@ int ttm_pool_mgr_init(unsigned long num_pages)
 			    &ttm_pool_debugfs_shrink_fops);
 #endif
 
-	mm_shrinker.count_objects = ttm_pool_shrinker_count;
-	mm_shrinker.scan_objects = ttm_pool_shrinker_scan;
-	mm_shrinker.seeks = 1;
-	return register_shrinker(&mm_shrinker, "drm-ttm_pool");
+	mm_shrinker = shrinker_alloc(0, "drm-ttm_pool");
+	if (!mm_shrinker)
+		return -ENOMEM;
+
+	mm_shrinker->count_objects = ttm_pool_shrinker_count;
+	mm_shrinker->scan_objects = ttm_pool_shrinker_scan;
+	mm_shrinker->seeks = 1;
+
+	shrinker_register(mm_shrinker);
+
+	return 0;
 }
 
 /**
@@ -802,6 +809,6 @@ void ttm_pool_mgr_fini(void)
 		ttm_pool_type_fini(&global_dma32_uncached[i]);
 	}
 
-	unregister_shrinker(&mm_shrinker);
+	shrinker_unregister(mm_shrinker);
 	WARN_ON(!list_empty(&shrinker_list));
 }
-- 
2.30.2

