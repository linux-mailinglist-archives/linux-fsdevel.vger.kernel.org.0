Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7582F786634
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 05:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239744AbjHXDtr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 23:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239834AbjHXDr4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:47:56 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E662199F
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:47:04 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1a2dd615ddcso1128051fac.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848823; x=1693453623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdtMxNmz/cn41h0wkDab4HUSCBdbEij6eu1+GgqexQY=;
        b=LJZYEmbSlDASLCkgz3hrEPH3dcI0rjqxRg5VcsDNmoqL0ZXgf1o1Y0h/XgghMDeH/K
         HNX4yAoxBp9QNokVvRY5nZw0cXdicizMAkH4jh7h0xLuD7ZTgWgj+TBan6hPOXN7Z6TU
         hktNUzMuauvT8xDdnVT3ksoiQbTyrLpmA4jYKOLqpQSWkN7+e8l+DAsYGtPGUoX88dMa
         MhAVrmwr61P7V2VVrv3ap/Xuz77qa49/YegrwTqoRUio1edOetxqGxTMb//9/u6Zu5JA
         fSsi178BoJRqOiBvb1O12Z7bFpYPDTJqk3QV2EuyDZ9LfRM9vXhUXI0bl2tIzM0ow6yb
         EmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848823; x=1693453623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdtMxNmz/cn41h0wkDab4HUSCBdbEij6eu1+GgqexQY=;
        b=eJtVx1Jo6L9CSZBGPi2GNyU757hz8Sr6xunCdk2+IqjRabRxDFffr6LYRebqC9T2ag
         MakRWxDlwrHqevZIlmOeRAINf2EMpcCp2oad6BuXYFktElHEKL2Hf7jOLjQy5H4RsXb8
         /tlCF5N96rAw15vNX1FKZZxIWP5k5aTZsI49T0AEA6kQG7xGPU2D4aX+nHbUr8aHMsrK
         tkydYlNqAy+gc69pGjZsXdZt3NpXVg//wJi3fZeWs1kzLlS8QF2pSlACzyctwkikQW9o
         n3roGdCtZOYpQ/I/PMQF6NMlBBBwhLrCo2F5mI2ZpqTI+50+a2IPhUkFmo+xnCqdocF0
         JWTg==
X-Gm-Message-State: AOJu0YwMPPIVrS9BP5qRXuR6Unw3XgkLdrEpbjAVIYZ7xfWWT5+UfOat
        0vLSToeqGkBTGVZoSniKq4UQ8w==
X-Google-Smtp-Source: AGHT+IGdyhShqM39wj/kCYItFqjS8mjsUh5O2g0IqPZkGOxiCTY+W38pTQGVR8rjRvn0DxKx8gxMAA==
X-Received: by 2002:a05:6830:6782:b0:6bd:990:1a2 with SMTP id cs2-20020a056830678200b006bd099001a2mr16253906otb.0.1692848823235;
        Wed, 23 Aug 2023 20:47:03 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:47:02 -0700 (PDT)
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
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v5 22/45] drm/panfrost: dynamically allocate the drm-panfrost shrinker
Date:   Thu, 24 Aug 2023 11:42:41 +0800
Message-Id: <20230824034304.37411-23-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
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

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the drm-panfrost shrinker, so that it can be freed
asynchronously via RCU. Then it doesn't need to wait for RCU read-side
critical section when releasing the struct panfrost_device.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
CC: Rob Herring <robh@kernel.org>
CC: Tomeu Vizoso <tomeu.vizoso@collabora.com>
CC: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
CC: David Airlie <airlied@gmail.com>
CC: dri-devel@lists.freedesktop.org
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

