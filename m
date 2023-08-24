Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E36E786629
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 05:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239727AbjHXDrp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 23:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239794AbjHXDrR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:47:17 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48DA19B4
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:46:48 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68a32506e90so1062493b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848804; x=1693453604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwx31tS90WjUWjp0SbR9DGcZF77FU28axltzBJRt4c4=;
        b=M9ObRuet+5GPiY4quY2/78PUkAPB1JrjsB2ESQr8Kn2AmS/yGh61g1cECo/MnMph8R
         EgvmGO9xW7uKzxLJT1EsEhHFDVz8SieDFzxIQZ3yZqdTck2102eAJRDpa6WGxOX6HJI1
         oyAm+jxYdRzKYJXtVMNWxIgInu8jTEmDbViIVQNnJb+aKHQ+v1QOZyzn/AqSRnLbLycj
         6PdLlHtIT8mann8zWwocxLvjESk9x7768MCHxVbB1agjjmBEVTFCGSB2g8quENDN22nn
         MxJ8OICOclnmIuKfUmbWULuOfFSwJIbwJlmI9aW5sqnhTe26+jLXnkYaLv9NGdlm90ol
         LaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848804; x=1693453604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uwx31tS90WjUWjp0SbR9DGcZF77FU28axltzBJRt4c4=;
        b=gljcm/EPpDQIXwv0CtR/tYcFNlldyR/R40/KgLuwixWCaQuphVvgyDIhot81H+XGx5
         UORPt+S1do/fD2PrfV3FtG1LYJnUjLDfhLUIKNkxvwiurOn55L/QwJaw22PCO66vg+zL
         zZptHRITSAw0QBksZffv11r1eE0/WTFX2SLaSNfibRkXZwhFNDQ0lYpHNoh7Vvds3UAx
         aghZwWvzYvYxbUv2MqLIDFsejskfYIJ1lOyF4YAOCKCTifTKrha0roZtfc2xknGnWVTE
         A5ofNJjel40gcd75rl6Hxc6nNpTqrxDZDeQraBukT+cVsh4tV7oQyMq1VheXWMVVGXNs
         3Tvw==
X-Gm-Message-State: AOJu0Yw3Grgj4ah2k9vasMhK1xK1A9LWfVNLtFe7/aBw42hCkX2dqNPU
        g49e2+EFWGN1JQrOhe56rv0y6w==
X-Google-Smtp-Source: AGHT+IEwX5EZusqZS4WDTl8vi+i2E+fjUU28VXYK2I5UDaIClqUUGhB9bFuORRwXdWrDnPbD98IZBQ==
X-Received: by 2002:a05:6a00:1791:b0:68a:42d0:6b9b with SMTP id s17-20020a056a00179100b0068a42d06b9bmr11892145pfg.3.1692848804382;
        Wed, 23 Aug 2023 20:46:44 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:46:43 -0700 (PDT)
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
        Muchun Song <songmuchun@bytedance.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v5 20/45] drm/i915: dynamically allocate the i915_gem_mm shrinker
Date:   Thu, 24 Aug 2023 11:42:39 +0800
Message-Id: <20230824034304.37411-21-zhengqi.arch@bytedance.com>
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
dynamically allocate the i915_gem_mm shrinker, so that it can be freed
asynchronously via RCU. Then it doesn't need to wait for RCU read-side
critical section when releasing the struct drm_i915_private.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
CC: Jani Nikula <jani.nikula@linux.intel.com>
CC: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>
CC: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
CC: David Airlie <airlied@gmail.com>
CC: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/i915/gem/i915_gem_shrinker.c | 30 +++++++++++---------
 drivers/gpu/drm/i915/i915_drv.h              |  2 +-
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c b/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c
index 214763942aa2..4504eb4f31d5 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c
@@ -284,8 +284,7 @@ unsigned long i915_gem_shrink_all(struct drm_i915_private *i915)
 static unsigned long
 i915_gem_shrinker_count(struct shrinker *shrinker, struct shrink_control *sc)
 {
-	struct drm_i915_private *i915 =
-		container_of(shrinker, struct drm_i915_private, mm.shrinker);
+	struct drm_i915_private *i915 = shrinker->private_data;
 	unsigned long num_objects;
 	unsigned long count;
 
@@ -302,8 +301,8 @@ i915_gem_shrinker_count(struct shrinker *shrinker, struct shrink_control *sc)
 	if (num_objects) {
 		unsigned long avg = 2 * count / num_objects;
 
-		i915->mm.shrinker.batch =
-			max((i915->mm.shrinker.batch + avg) >> 1,
+		i915->mm.shrinker->batch =
+			max((i915->mm.shrinker->batch + avg) >> 1,
 			    128ul /* default SHRINK_BATCH */);
 	}
 
@@ -313,8 +312,7 @@ i915_gem_shrinker_count(struct shrinker *shrinker, struct shrink_control *sc)
 static unsigned long
 i915_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
 {
-	struct drm_i915_private *i915 =
-		container_of(shrinker, struct drm_i915_private, mm.shrinker);
+	struct drm_i915_private *i915 = shrinker->private_data;
 	unsigned long freed;
 
 	sc->nr_scanned = 0;
@@ -422,12 +420,18 @@ i915_gem_shrinker_vmap(struct notifier_block *nb, unsigned long event, void *ptr
 
 void i915_gem_driver_register__shrinker(struct drm_i915_private *i915)
 {
-	i915->mm.shrinker.scan_objects = i915_gem_shrinker_scan;
-	i915->mm.shrinker.count_objects = i915_gem_shrinker_count;
-	i915->mm.shrinker.seeks = DEFAULT_SEEKS;
-	i915->mm.shrinker.batch = 4096;
-	drm_WARN_ON(&i915->drm, register_shrinker(&i915->mm.shrinker,
-						  "drm-i915_gem"));
+	i915->mm.shrinker = shrinker_alloc(0, "drm-i915_gem");
+	if (!i915->mm.shrinker) {
+		drm_WARN_ON(&i915->drm, 1);
+	} else {
+		i915->mm.shrinker->scan_objects = i915_gem_shrinker_scan;
+		i915->mm.shrinker->count_objects = i915_gem_shrinker_count;
+		i915->mm.shrinker->seeks = DEFAULT_SEEKS;
+		i915->mm.shrinker->batch = 4096;
+		i915->mm.shrinker->private_data = i915;
+
+		shrinker_register(i915->mm.shrinker);
+	}
 
 	i915->mm.oom_notifier.notifier_call = i915_gem_shrinker_oom;
 	drm_WARN_ON(&i915->drm, register_oom_notifier(&i915->mm.oom_notifier));
@@ -443,7 +447,7 @@ void i915_gem_driver_unregister__shrinker(struct drm_i915_private *i915)
 		    unregister_vmap_purge_notifier(&i915->mm.vmap_notifier));
 	drm_WARN_ON(&i915->drm,
 		    unregister_oom_notifier(&i915->mm.oom_notifier));
-	unregister_shrinker(&i915->mm.shrinker);
+	shrinker_free(i915->mm.shrinker);
 }
 
 void i915_gem_shrinker_taints_mutex(struct drm_i915_private *i915,
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 7a8ce7239bc9..f2f21da4d7f9 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -163,7 +163,7 @@ struct i915_gem_mm {
 
 	struct notifier_block oom_notifier;
 	struct notifier_block vmap_notifier;
-	struct shrinker shrinker;
+	struct shrinker *shrinker;
 
 #ifdef CONFIG_MMU_NOTIFIER
 	/**
-- 
2.30.2

