Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4973E764C0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 10:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbjG0IUj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 04:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbjG0ITg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:19:36 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E057C7295
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 01:11:37 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6862d4a1376so189200b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 01:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690445466; x=1691050266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjqO/ZPr/Go39gpx6DVg0WzFepitwPif37hI1XuxbyE=;
        b=KWf7bMy1nbQ37OxDK+aLk4UU+d+DpidRt45gsv6WisntZ5r23wZ3pYKMCoLchBsQxQ
         dbRrJ4b0aFwJmGna2/IEy8T8QiKnn2NACgYbVRTrckTcQDGJyAPHMooOCl62MUAwOoyA
         JbZysBi4oQBt301gAOSv+2GS8dKtdtSP0nG8DKgUtI05eGkdQUUBXQMQvZN3o0luNYiw
         8kcVk8roCfN8SKqwYrPgL6wyyB4sigzvUww4WP5NJ+eSnXEpjiht6HKW6ptfgHl7+XLv
         6NnbrWDfXzNY62UnzW5yOMd63/qymxxfuyafQ4go8x2ZHPA9qwKwZ1PQJSZV3Wy/oPgn
         SKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690445466; x=1691050266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjqO/ZPr/Go39gpx6DVg0WzFepitwPif37hI1XuxbyE=;
        b=JWR66oBth/bHqLwdXo//P00eynSs/wwTFr4Hf9f6zRM9VacA6WSm4CVN24yRykNtqt
         1ciO/KZnslSdu3/a8TF6XVkz5SXNS0sj8LA9B7DybutY1XUuVx33JEypBuAR98IIOsWC
         /S62bKI8m0cevP2fJFF89xYimhDjg4UblBl0ARdU9DKjw6dUmTRHGAlZ5wvHOMYZqZR0
         dNnDouNFyWXglOEoPybY/ZN32f9E0wZFgahfME4U5qnq7N8cs49v3EhhL8asvHyHmtim
         yAU7MK3zW/GHtMMqJBZBgmVJ9JBIkCnl0c2/N0rne8ssKxvrPWPecKn/m+kxHgltFBNm
         ZTQQ==
X-Gm-Message-State: ABy/qLYKIDOLM7KNVgPTFvA7jfUDjUD0OI8SigIIe+3loCUGGKqYrrEF
        vQZadoL1+9e6A/PYyjzK+rwslg==
X-Google-Smtp-Source: APBJJlHsQWiMeK1ZGCoT9EMqzV36W3zQjtsLKzuNfdQAXhrStS5DTpZT9lorCJhzpRLn0tDb83CKIQ==
X-Received: by 2002:aa7:8615:0:b0:681:9fe0:b543 with SMTP id p21-20020aa78615000000b006819fe0b543mr4626555pfn.2.1690445465777;
        Thu, 27 Jul 2023 01:11:05 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78d08000000b006828e49c04csm885872pfe.75.2023.07.27.01.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:11:05 -0700 (PDT)
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
Subject: [PATCH v3 26/49] drm/panfrost: dynamically allocate the drm-panfrost shrinker
Date:   Thu, 27 Jul 2023 16:04:39 +0800
Message-Id: <20230727080502.77895-27-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
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

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the drm-panfrost shrinker, so that it can be freed
asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
read-side critical section when releasing the struct panfrost_device.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.h    |  2 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c       |  6 +++-
 drivers/gpu/drm/panfrost/panfrost_gem.h       |  2 +-
 .../gpu/drm/panfrost/panfrost_gem_shrinker.c  | 30 +++++++++++--------
 4 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index b0126b9fbadc..e667e5689353 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -118,7 +118,7 @@ struct panfrost_device {
 
 	struct mutex shrinker_lock;
 	struct list_head shrinker_list;
-	struct shrinker shrinker;
+	struct shrinker *shrinker;
 
 	struct panfrost_devfreq pfdevfreq;
 };
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index a2ab99698ca8..e1d0e3a23757 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -601,10 +601,14 @@ static int panfrost_probe(struct platform_device *pdev)
 	if (err < 0)
 		goto err_out1;
 
-	panfrost_gem_shrinker_init(ddev);
+	err = panfrost_gem_shrinker_init(ddev);
+	if (err)
+		goto err_out2;
 
 	return 0;
 
+err_out2:
+	drm_dev_unregister(ddev);
 err_out1:
 	pm_runtime_disable(pfdev->dev);
 	panfrost_device_fini(pfdev);
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.h b/drivers/gpu/drm/panfrost/panfrost_gem.h
index ad2877eeeccd..863d2ec8d4f0 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.h
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.h
@@ -81,7 +81,7 @@ panfrost_gem_mapping_get(struct panfrost_gem_object *bo,
 void panfrost_gem_mapping_put(struct panfrost_gem_mapping *mapping);
 void panfrost_gem_teardown_mappings_locked(struct panfrost_gem_object *bo);
 
-void panfrost_gem_shrinker_init(struct drm_device *dev);
+int panfrost_gem_shrinker_init(struct drm_device *dev);
 void panfrost_gem_shrinker_cleanup(struct drm_device *dev);
 
 #endif /* __PANFROST_GEM_H__ */
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
index 6a71a2555f85..3dfe2b7ccdd9 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
@@ -18,8 +18,7 @@
 static unsigned long
 panfrost_gem_shrinker_count(struct shrinker *shrinker, struct shrink_control *sc)
 {
-	struct panfrost_device *pfdev =
-		container_of(shrinker, struct panfrost_device, shrinker);
+	struct panfrost_device *pfdev = shrinker->private_data;
 	struct drm_gem_shmem_object *shmem;
 	unsigned long count = 0;
 
@@ -65,8 +64,7 @@ static bool panfrost_gem_purge(struct drm_gem_object *obj)
 static unsigned long
 panfrost_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
 {
-	struct panfrost_device *pfdev =
-		container_of(shrinker, struct panfrost_device, shrinker);
+	struct panfrost_device *pfdev = shrinker->private_data;
 	struct drm_gem_shmem_object *shmem, *tmp;
 	unsigned long freed = 0;
 
@@ -97,13 +95,22 @@ panfrost_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
  *
  * This function registers and sets up the panfrost shrinker.
  */
-void panfrost_gem_shrinker_init(struct drm_device *dev)
+int panfrost_gem_shrinker_init(struct drm_device *dev)
 {
 	struct panfrost_device *pfdev = dev->dev_private;
-	pfdev->shrinker.count_objects = panfrost_gem_shrinker_count;
-	pfdev->shrinker.scan_objects = panfrost_gem_shrinker_scan;
-	pfdev->shrinker.seeks = DEFAULT_SEEKS;
-	WARN_ON(register_shrinker(&pfdev->shrinker, "drm-panfrost"));
+
+	pfdev->shrinker = shrinker_alloc(0, "drm-panfrost");
+	if (!pfdev->shrinker)
+		return -ENOMEM;
+
+	pfdev->shrinker->count_objects = panfrost_gem_shrinker_count;
+	pfdev->shrinker->scan_objects = panfrost_gem_shrinker_scan;
+	pfdev->shrinker->seeks = DEFAULT_SEEKS;
+	pfdev->shrinker->private_data = pfdev;
+
+	shrinker_register(pfdev->shrinker);
+
+	return 0;
 }
 
 /**
@@ -116,7 +123,6 @@ void panfrost_gem_shrinker_cleanup(struct drm_device *dev)
 {
 	struct panfrost_device *pfdev = dev->dev_private;
 
-	if (pfdev->shrinker.nr_deferred) {
-		unregister_shrinker(&pfdev->shrinker);
-	}
+	if (pfdev->shrinker)
+		shrinker_free(pfdev->shrinker);
 }
-- 
2.30.2

