Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5A679BE02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241734AbjIKU5R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbjIKJsf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:48:35 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E731116
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:48:09 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c3aa44c0faso1785055ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425689; x=1695030489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TH2SdUyTcD6fjHvcYPnGAz08JEgs2WamZypN/j9OP1o=;
        b=bRMi4TBPOjNknIvrzTjTvxA5Cs+S6gtmahE1U+OIcJw2d+SlBF9ZlyiKyOp54udgXC
         5Nja87CouZRVpO/FEjXGlQyoLsbhrnJ23lzxeoXpUvToOxfu0DkmIvkdQzrs9Pb3IOW4
         uQHRxWZ3LOKAdD0ZYv3i9Otel2h2vOaxtd/XKeiAZ3pZFkzKdvLVHSRxRVkSUWy1hmIn
         br6gcCJ3VjgJIyf6W9bSWONDlIUgSTJgbQF9/uUsFQEhNbHoCINy9/n0dHf7YbHgoEaV
         XAyGnrfjyLjaC9/jWLEwJAYXu0McXPdNVm7oyJ2WbPP51bVKbYtqJMua7q/vUfwjZon0
         l2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425689; x=1695030489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TH2SdUyTcD6fjHvcYPnGAz08JEgs2WamZypN/j9OP1o=;
        b=W5aw3R3wj23+gO8yK9dBh82rexlfSalpWtoLPUqSyUTQmwzjCGlEt159CL75Cumg2e
         HbNLHyzDS6PobtJ6WzLjJ/4KhoJPYZ3pCsoDOZncFPHL2djo/ycUyqMgvcA9p80Pb9A2
         oueKAKU9PhebUM8Wj31sCcDEkyf7073e/30kUz0mzeD8pH5GoA+e2IkbkeUyFkZUb1Wh
         M8TmIY5DZO3qDVxVV6y95M7cqggfxiQYqtaNmNNFpGfrOyXQizQEbtFhxMt8Ipsx0uvT
         PltmfA/vRhVPNVCQgFyMx+7asFUz58Cz9+PDEzc0He2bbrJE8NpFZ6qTdPZIr6E7PeKD
         oeDQ==
X-Gm-Message-State: AOJu0Yz+y0fl0HVOYTFaOy8mjUsuZPuMtDH38qqoRMOvXUE5Hgqo86ze
        ZxGj4NCGg/ZnEVYxx9Vdnb7kFQ==
X-Google-Smtp-Source: AGHT+IFXsoJn9CE40v3H4M+g/tTzTAY/D+R7L1IYVyxz9f8XJyNRX7PJqlNVDB6THijf5N8OiFzBVQ==
X-Received: by 2002:a17:902:e750:b0:1c1:fbec:bc3f with SMTP id p16-20020a170902e75000b001c1fbecbc3fmr11507909plf.5.1694425688824;
        Mon, 11 Sep 2023 02:48:08 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:48:08 -0700 (PDT)
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
Subject: [PATCH v6 20/45] drm/i915: dynamically allocate the i915_gem_mm shrinker
Date:   Mon, 11 Sep 2023 17:44:19 +0800
Message-Id: <20230911094444.68966-21-zhengqi.arch@bytedance.com>
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
 drivers/gpu/drm/i915/gem/i915_gem_shrinker.c | 29 +++++++++++---------
 drivers/gpu/drm/i915/i915_drv.h              |  2 +-
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c b/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c
index 214763942aa2..e07ffbd9eab3 100644
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
@@ -422,12 +420,17 @@ i915_gem_shrinker_vmap(struct notifier_block *nb, unsigned long event, void *ptr
 
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
+		i915->mm.shrinker->batch = 4096;
+		i915->mm.shrinker->private_data = i915;
+
+		shrinker_register(i915->mm.shrinker);
+	}
 
 	i915->mm.oom_notifier.notifier_call = i915_gem_shrinker_oom;
 	drm_WARN_ON(&i915->drm, register_oom_notifier(&i915->mm.oom_notifier));
@@ -443,7 +446,7 @@ void i915_gem_driver_unregister__shrinker(struct drm_i915_private *i915)
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

