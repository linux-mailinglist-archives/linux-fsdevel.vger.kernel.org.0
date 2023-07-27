Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBB9764E0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 10:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjG0Is1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 04:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjG0IrW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:47:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A92E59D1;
        Thu, 27 Jul 2023 01:30:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A03F61DA8;
        Thu, 27 Jul 2023 08:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06711C433C7;
        Thu, 27 Jul 2023 08:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690446606;
        bh=lgMwb11ItIJ27YCsuj2akQ0e0AMgpISaoiuOUrGiITY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Tr4M7HQ3pxhso0Q/eg4xKtwD0lUURtq4zUL2WnDxbX7YJArr/oNtVx0HKmYWbVJCj
         uZ3CjjOq76HigUmfxsBIfU5BJp2UCC8gXysiCMyY4oUiNa0NyuYtXgOb+GgYI2e2UD
         q/DMid3QMY2nJGias56vfjnyYrQ2kAGyvOg7az/lKKcQPYsllW1cAnQl1FfA/ktsaA
         ypQoOxGNqaMUpP2GFbXa8+1QKt5gSsrAShH7O9rxadTFuFxweU5IvbZDayprJj2afQ
         IGlbjA9TtQP0FcoHyTXu4yjcQ81VS0g2mOFp+HrXHsn6/kAwTiNlXyj4HVftm6tXbg
         kxbv5Cd7EwHzQ==
Message-ID: <baaf7de4-9a0e-b953-2b6a-46e60c415614@kernel.org>
Date:   Thu, 27 Jul 2023 17:30:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 28/49] dm zoned: dynamically allocate the dm-zoned-meta
 shrinker
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        david@fromorbit.com, tkhai@ya.ru, vbabka@suse.cz,
        roman.gushchin@linux.dev, djwong@kernel.org, brauner@kernel.org,
        paulmck@kernel.org, tytso@mit.edu, steven.price@arm.com,
        cel@kernel.org, senozhatsky@chromium.org, yujie.liu@intel.com,
        gregkh@linuxfoundation.org, muchun.song@linux.dev
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
        Muchun Song <songmuchun@bytedance.com>
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
 <20230727080502.77895-29-zhengqi.arch@bytedance.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230727080502.77895-29-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/27/23 17:04, Qi Zheng wrote:
> In preparation for implementing lockless slab shrink, use new APIs to
> dynamically allocate the dm-zoned-meta shrinker, so that it can be freed
> asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
> read-side critical section when releasing the struct dmz_metadata.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  drivers/md/dm-zoned-metadata.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
> index 9d3cca8e3dc9..0bcb26a43578 100644
> --- a/drivers/md/dm-zoned-metadata.c
> +++ b/drivers/md/dm-zoned-metadata.c
> @@ -187,7 +187,7 @@ struct dmz_metadata {
>  	struct rb_root		mblk_rbtree;
>  	struct list_head	mblk_lru_list;
>  	struct list_head	mblk_dirty_list;
> -	struct shrinker		mblk_shrinker;
> +	struct shrinker		*mblk_shrinker;
>  
>  	/* Zone allocation management */
>  	struct mutex		map_lock;
> @@ -615,7 +615,7 @@ static unsigned long dmz_shrink_mblock_cache(struct dmz_metadata *zmd,
>  static unsigned long dmz_mblock_shrinker_count(struct shrinker *shrink,
>  					       struct shrink_control *sc)
>  {
> -	struct dmz_metadata *zmd = container_of(shrink, struct dmz_metadata, mblk_shrinker);
> +	struct dmz_metadata *zmd = shrink->private_data;
>  
>  	return atomic_read(&zmd->nr_mblks);
>  }
> @@ -626,7 +626,7 @@ static unsigned long dmz_mblock_shrinker_count(struct shrinker *shrink,
>  static unsigned long dmz_mblock_shrinker_scan(struct shrinker *shrink,
>  					      struct shrink_control *sc)
>  {
> -	struct dmz_metadata *zmd = container_of(shrink, struct dmz_metadata, mblk_shrinker);
> +	struct dmz_metadata *zmd = shrink->private_data;
>  	unsigned long count;
>  
>  	spin_lock(&zmd->mblk_lock);
> @@ -2936,19 +2936,23 @@ int dmz_ctr_metadata(struct dmz_dev *dev, int num_dev,
>  	 */
>  	zmd->min_nr_mblks = 2 + zmd->nr_map_blocks + zmd->zone_nr_bitmap_blocks * 16;
>  	zmd->max_nr_mblks = zmd->min_nr_mblks + 512;
> -	zmd->mblk_shrinker.count_objects = dmz_mblock_shrinker_count;
> -	zmd->mblk_shrinker.scan_objects = dmz_mblock_shrinker_scan;
> -	zmd->mblk_shrinker.seeks = DEFAULT_SEEKS;
>  
>  	/* Metadata cache shrinker */
> -	ret = register_shrinker(&zmd->mblk_shrinker, "dm-zoned-meta:(%u:%u)",
> -				MAJOR(dev->bdev->bd_dev),
> -				MINOR(dev->bdev->bd_dev));
> -	if (ret) {
> -		dmz_zmd_err(zmd, "Register metadata cache shrinker failed");
> +	zmd->mblk_shrinker = shrinker_alloc(0,  "dm-zoned-meta:(%u:%u)",
> +					    MAJOR(dev->bdev->bd_dev),
> +					    MINOR(dev->bdev->bd_dev));
> +	if (!zmd->mblk_shrinker) {
> +		dmz_zmd_err(zmd, "Allocate metadata cache shrinker failed");

ret is not set here, so dmz_ctr_metadata() will return success. You need to add:
		ret = -ENOMEM;
or something.
>  		goto err;
>  	}
>  
> +	zmd->mblk_shrinker->count_objects = dmz_mblock_shrinker_count;
> +	zmd->mblk_shrinker->scan_objects = dmz_mblock_shrinker_scan;
> +	zmd->mblk_shrinker->seeks = DEFAULT_SEEKS;
> +	zmd->mblk_shrinker->private_data = zmd;
> +
> +	shrinker_register(zmd->mblk_shrinker);

I fail to see how this new shrinker API is better... Why isn't there a
shrinker_alloc_and_register() function ? That would avoid adding all this code
all over the place as the new API call would be very similar to the current
shrinker_register() call with static allocation.

> +
>  	dmz_zmd_info(zmd, "DM-Zoned metadata version %d", zmd->sb_version);
>  	for (i = 0; i < zmd->nr_devs; i++)
>  		dmz_print_dev(zmd, i);
> @@ -2995,7 +2999,7 @@ int dmz_ctr_metadata(struct dmz_dev *dev, int num_dev,
>   */
>  void dmz_dtr_metadata(struct dmz_metadata *zmd)
>  {
> -	unregister_shrinker(&zmd->mblk_shrinker);
> +	shrinker_free(zmd->mblk_shrinker);
>  	dmz_cleanup_metadata(zmd);
>  	kfree(zmd);
>  }

-- 
Damien Le Moal
Western Digital Research

