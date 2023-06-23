Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4100073B451
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jun 2023 12:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjFWKBY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jun 2023 06:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjFWKBV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:01:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC52D189;
        Fri, 23 Jun 2023 03:01:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61950C14;
        Fri, 23 Jun 2023 03:02:02 -0700 (PDT)
Received: from [10.1.30.17] (e122027.cambridge.arm.com [10.1.30.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E25C23F64C;
        Fri, 23 Jun 2023 03:01:13 -0700 (PDT)
Message-ID: <35f80572-0ba2-be54-c947-fcbe2d71ed5e@arm.com>
Date:   Fri, 23 Jun 2023 11:01:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 05/29] drm/panfrost: dynamically allocate the drm-panfrost
 shrinker
To:     Qi Zheng <qi.zheng@linux.dev>, akpm@linux-foundation.org,
        david@fromorbit.com, tkhai@ya.ru, vbabka@suse.cz,
        roman.gushchin@linux.dev, djwong@kernel.org, brauner@kernel.org,
        paulmck@kernel.org, tytso@mit.edu
Cc:     linux-bcache@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-raid@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-btrfs@vger.kernel.org
References: <20230622083932.4090339-1-qi.zheng@linux.dev>
 <20230622083932.4090339-6-qi.zheng@linux.dev>
Content-Language: en-GB
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20230622083932.4090339-6-qi.zheng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/06/2023 09:39, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> In preparation for implementing lockless slab shrink,
> we need to dynamically allocate the drm-panfrost shrinker,
> so that it can be freed asynchronously using kfree_rcu().
> Then it doesn't need to wait for RCU read-side critical
> section when releasing the struct panfrost_device.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.h    |  2 +-
>  .../gpu/drm/panfrost/panfrost_gem_shrinker.c  | 24 ++++++++++---------
>  2 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> index b0126b9fbadc..e667e5689353 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -118,7 +118,7 @@ struct panfrost_device {
>  
>  	struct mutex shrinker_lock;
>  	struct list_head shrinker_list;
> -	struct shrinker shrinker;
> +	struct shrinker *shrinker;
>  
>  	struct panfrost_devfreq pfdevfreq;
>  };
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
> index bf0170782f25..2a5513eb9e1f 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
> @@ -18,8 +18,7 @@
>  static unsigned long
>  panfrost_gem_shrinker_count(struct shrinker *shrinker, struct shrink_control *sc)
>  {
> -	struct panfrost_device *pfdev =
> -		container_of(shrinker, struct panfrost_device, shrinker);
> +	struct panfrost_device *pfdev = shrinker->private_data;
>  	struct drm_gem_shmem_object *shmem;
>  	unsigned long count = 0;
>  
> @@ -65,8 +64,7 @@ static bool panfrost_gem_purge(struct drm_gem_object *obj)
>  static unsigned long
>  panfrost_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
>  {
> -	struct panfrost_device *pfdev =
> -		container_of(shrinker, struct panfrost_device, shrinker);
> +	struct panfrost_device *pfdev = shrinker->private_data;
>  	struct drm_gem_shmem_object *shmem, *tmp;
>  	unsigned long freed = 0;
>  
> @@ -100,10 +98,15 @@ panfrost_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
>  void panfrost_gem_shrinker_init(struct drm_device *dev)
>  {
>  	struct panfrost_device *pfdev = dev->dev_private;
> -	pfdev->shrinker.count_objects = panfrost_gem_shrinker_count;
> -	pfdev->shrinker.scan_objects = panfrost_gem_shrinker_scan;
> -	pfdev->shrinker.seeks = DEFAULT_SEEKS;
> -	WARN_ON(register_shrinker(&pfdev->shrinker, "drm-panfrost"));
> +
> +	pfdev->shrinker = shrinker_alloc_and_init(panfrost_gem_shrinker_count,
> +						  panfrost_gem_shrinker_scan, 0,
> +						  DEFAULT_SEEKS, 0, pfdev);
> +	if (pfdev->shrinker &&
> +	    register_shrinker(pfdev->shrinker, "drm-panfrost")) {
> +		shrinker_free(pfdev->shrinker);
> +		WARN_ON(1);
> +	}

So we didn't have good error handling here before, but this is
significantly worse. Previously if register_shrinker() failed then the
driver could safely continue without a shrinker - it would waste memory
but still function.

However we now have two failure conditions:
 * shrinker_alloc_init() returns NULL. No warning and NULL deferences
   will happen later.

 * register_shrinker() fails, shrinker_free() will free pdev->shrinker
   we get a warning, but followed by a use-after-free later.

I think we need to modify panfrost_gem_shrinker_init() to be able to
return an error, so a change something like the below (untested) before
your change.

Steve

----8<---
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c
b/drivers/gpu/drm/panfrost/panfrost_drv.c
index bbada731bbbd..f705bbdea360 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -598,10 +598,14 @@ static int panfrost_probe(struct platform_device
*pdev)
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
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.h
b/drivers/gpu/drm/panfrost/panfrost_gem.h
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
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
index bf0170782f25..90265b37636f 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
@@ -97,13 +97,17 @@ panfrost_gem_shrinker_scan(struct shrinker
*shrinker, struct shrink_control *sc)
  *
  * This function registers and sets up the panfrost shrinker.
  */
-void panfrost_gem_shrinker_init(struct drm_device *dev)
+int panfrost_gem_shrinker_init(struct drm_device *dev)
 {
 	struct panfrost_device *pfdev = dev->dev_private;
+	int ret;
+
 	pfdev->shrinker.count_objects = panfrost_gem_shrinker_count;
 	pfdev->shrinker.scan_objects = panfrost_gem_shrinker_scan;
 	pfdev->shrinker.seeks = DEFAULT_SEEKS;
-	WARN_ON(register_shrinker(&pfdev->shrinker, "drm-panfrost"));
+	ret = register_shrinker(&pfdev->shrinker, "drm-panfrost");
+
+	return ret;
 }

 /**

