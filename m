Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E176F78428B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 15:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbjHVN42 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 09:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbjHVN42 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:56:28 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCD71B0
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Aug 2023 06:56:24 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31c5ee810e3so184738f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Aug 2023 06:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1692712583; x=1693317383;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXzMnEM8moHL5KfliVx5cD1lb3aAd5NGNjk14fqFYLY=;
        b=OvQvaauBf9P71X6OM3iV6zJjVstVKwDXVeR2TcNPjDcJz2f399JP5BZxFUiXHkTWc/
         r5lP7XQ7vkvpSMptW40PFm8KnzYip/IftCKI/V7U1LWv+OZcsOEZqcqKXDKRf7oBDJOP
         RNOespNYAQNJ9FavrWx3YuWYiBeKAeIF+XsTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692712583; x=1693317383;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LXzMnEM8moHL5KfliVx5cD1lb3aAd5NGNjk14fqFYLY=;
        b=ZFHrTbYMMj373EddIbpJqNZj3Ct7elZgxqT20Dok37PkXiT7KZC1V/tkeDk+xTu5sM
         mYUgVhm0soRyKobxM0kDqjPl+z7JV+VRjI/Nu21oSkHbeHUgZC1s39eWDYrufnJi3zEN
         51rRLiqTwVAqLbm2s6z5XNFHlWqMykJdvY4YuPm0DngEymza7MCi30DDNzIbBjkVhWgH
         AKB+Ugjn8cAinazxX812b6NiFzCuQAD1HtMJCmMJUUZjd7QIlYX1OqrQKvtdMY3idJ3u
         xPGTS6/VhgKhrLalNlAISWCcmj/sK+hi0/mVZ0hFAK+pi9gbzh6AkuIWvzJrb+Ww2hCt
         I4Jw==
X-Gm-Message-State: AOJu0Yz1Q62QwEQw8ZhF/mik8OERtWx0MKz5DwDcDpe0InTjuGUyg/KM
        7JdnwgCSl94qRpLgDMH8A011EA==
X-Google-Smtp-Source: AGHT+IHJQrlSrCu8WgUX5s8XkdDm6/hR/jwfxds8mVBdQgFEL5tBYnuf/oIT+VMpj8Z6S8wRiH/+Kw==
X-Received: by 2002:a5d:65c5:0:b0:319:8dcf:5c10 with SMTP id e5-20020a5d65c5000000b003198dcf5c10mr6979657wrw.6.1692712582669;
        Tue, 22 Aug 2023 06:56:22 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u5-20020a05600c210500b003fc02e8ea68sm19456835wml.13.2023.08.22.06.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 06:56:22 -0700 (PDT)
Date:   Tue, 22 Aug 2023 15:56:19 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, simon.horman@corigine.com,
        dlemoal@kernel.org, kvm@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        dm-devel@redhat.com, linux-mtd@lists.infradead.org, x86@kernel.org,
        cluster-devel@redhat.com, xen-devel@lists.xenproject.org,
        linux-ext4@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rcu@vger.kernel.org, linux-bcache@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 43/48] drm/ttm: introduce pool_shrink_rwsem
Message-ID: <ZOS+g51Yx9PsYkGU@phenom.ffwll.local>
Mail-Followup-To: Qi Zheng <zhengqi.arch@bytedance.com>,
        akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, simon.horman@corigine.com,
        dlemoal@kernel.org, kvm@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        dm-devel@redhat.com, linux-mtd@lists.infradead.org, x86@kernel.org,
        cluster-devel@redhat.com, xen-devel@lists.xenproject.org,
        linux-ext4@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rcu@vger.kernel.org, linux-bcache@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>, linux-raid@vger.kernel.org,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-btrfs@vger.kernel.org
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
 <20230807110936.21819-44-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807110936.21819-44-zhengqi.arch@bytedance.com>
X-Operating-System: Linux phenom 6.3.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 07, 2023 at 07:09:31PM +0800, Qi Zheng wrote:
> Currently, the synchronize_shrinkers() is only used by TTM pool. It only
> requires that no shrinkers run in parallel.
> 
> After we use RCU+refcount method to implement the lockless slab shrink,
> we can not use shrinker_rwsem or synchronize_rcu() to guarantee that all
> shrinker invocations have seen an update before freeing memory.
> 
> So we introduce a new pool_shrink_rwsem to implement a private
> synchronize_shrinkers(), so as to achieve the same purpose.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>

On the 5 drm patches (I counted 2 ttm and 3 drivers) for merging through
some other tree (since I'm assuming that's how this will land):

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/ttm/ttm_pool.c | 15 +++++++++++++++
>  include/linux/shrinker.h       |  2 --
>  mm/shrinker.c                  | 15 ---------------
>  3 files changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> index c9c9618c0dce..38b4c280725c 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -74,6 +74,7 @@ static struct ttm_pool_type global_dma32_uncached[MAX_ORDER + 1];
>  static spinlock_t shrinker_lock;
>  static struct list_head shrinker_list;
>  static struct shrinker *mm_shrinker;
> +static DECLARE_RWSEM(pool_shrink_rwsem);
>  
>  /* Allocate pages of size 1 << order with the given gfp_flags */
>  static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
> @@ -317,6 +318,7 @@ static unsigned int ttm_pool_shrink(void)
>  	unsigned int num_pages;
>  	struct page *p;
>  
> +	down_read(&pool_shrink_rwsem);
>  	spin_lock(&shrinker_lock);
>  	pt = list_first_entry(&shrinker_list, typeof(*pt), shrinker_list);
>  	list_move_tail(&pt->shrinker_list, &shrinker_list);
> @@ -329,6 +331,7 @@ static unsigned int ttm_pool_shrink(void)
>  	} else {
>  		num_pages = 0;
>  	}
> +	up_read(&pool_shrink_rwsem);
>  
>  	return num_pages;
>  }
> @@ -572,6 +575,18 @@ void ttm_pool_init(struct ttm_pool *pool, struct device *dev,
>  }
>  EXPORT_SYMBOL(ttm_pool_init);
>  
> +/**
> + * synchronize_shrinkers - Wait for all running shrinkers to complete.
> + *
> + * This is useful to guarantee that all shrinker invocations have seen an
> + * update, before freeing memory, similar to rcu.
> + */
> +static void synchronize_shrinkers(void)
> +{
> +	down_write(&pool_shrink_rwsem);
> +	up_write(&pool_shrink_rwsem);
> +}
> +
>  /**
>   * ttm_pool_fini - Cleanup a pool
>   *
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index c55c07c3f0cb..025c8070dd86 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -103,8 +103,6 @@ struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...);
>  void shrinker_register(struct shrinker *shrinker);
>  void shrinker_free(struct shrinker *shrinker);
>  
> -extern void synchronize_shrinkers(void);
> -
>  #ifdef CONFIG_SHRINKER_DEBUG
>  extern int __printf(2, 3) shrinker_debugfs_rename(struct shrinker *shrinker,
>  						  const char *fmt, ...);
> diff --git a/mm/shrinker.c b/mm/shrinker.c
> index 3ab301ff122d..a27779ed3798 100644
> --- a/mm/shrinker.c
> +++ b/mm/shrinker.c
> @@ -650,18 +650,3 @@ void shrinker_free(struct shrinker *shrinker)
>  	kfree(shrinker);
>  }
>  EXPORT_SYMBOL_GPL(shrinker_free);
> -
> -/**
> - * synchronize_shrinkers - Wait for all running shrinkers to complete.
> - *
> - * This is equivalent to calling unregister_shrink() and register_shrinker(),
> - * but atomically and with less overhead. This is useful to guarantee that all
> - * shrinker invocations have seen an update, before freeing memory, similar to
> - * rcu.
> - */
> -void synchronize_shrinkers(void)
> -{
> -	down_write(&shrinker_rwsem);
> -	up_write(&shrinker_rwsem);
> -}
> -EXPORT_SYMBOL(synchronize_shrinkers);
> -- 
> 2.30.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
