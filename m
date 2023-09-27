Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF867B07C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 17:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjI0PLP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 11:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjI0PLN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:11:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F90FC
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 08:11:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B50C433C8;
        Wed, 27 Sep 2023 15:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695827472;
        bh=ijwHRtvcVjwZlw8DlxF2A9CR3VrDg2X/SlDGXz5GCCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XD+HttFidhrZGTKWtosBzx/YQ0TyfI858nJywN6GSWhZxGUU9SnU5dzY2XseOVDtP
         0cTWGIWQAJjtUEQrqnHrTJUBYQVhV8BfNolPGKCNeBEuIgKeOq7tAwqPgqdZMBNHH0
         Ywd/oMUWSra2CRuXlRnjsjsghxkHUKTy1eV4Tyak/aNTKeChEML46mz36jX/tdWYDP
         V9qc6Pi+9bO4XHpFNXRT1tzlrlICDughJmtMJCI1dH49sWRqzxhG8244q+sdtghvG0
         KAIuFza5aZSAbBYLQu0FDvmNYP0XJH8bKojCeG/3OQ/BOiPsUehcEqJmxmaWJvHbB1
         UAamxnVdTwI+Q==
Date:   Wed, 27 Sep 2023 08:11:11 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/7] super: remove bd_fsfreeze_{mutex,sb}
Message-ID: <20230927151111.GE11414@frogsfrogsfrogs>
References: <20230927-vfs-super-freeze-v1-0-ecc36d9ab4d9@kernel.org>
 <20230927-vfs-super-freeze-v1-5-ecc36d9ab4d9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927-vfs-super-freeze-v1-5-ecc36d9ab4d9@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 27, 2023 at 03:21:18PM +0200, Christian Brauner wrote:
> Both bd_fsfreeze_mutex and bd_fsfreeze_sb are now unused and can be
> removed. Also move bd_fsfreeze_count down to not have it weirdly placed
> in the middle of the holder fields.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  block/bdev.c              | 1 -
>  include/linux/blk_types.h | 7 ++-----
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 3deccd0ffcf2..084855b669f7 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -392,7 +392,6 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
>  	mapping_set_gfp_mask(&inode->i_data, GFP_USER);
>  
>  	bdev = I_BDEV(inode);
> -	mutex_init(&bdev->bd_fsfreeze_mutex);
>  	spin_lock_init(&bdev->bd_size_lock);
>  	mutex_init(&bdev->bd_holder_lock);
>  	bdev->bd_partno = partno;
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 88e1848b0869..0238236852b7 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -56,14 +56,11 @@ struct block_device {
>  	void *			bd_holder;

Hmmm.  get_bdev_super from patch 3 now requires that bd_holder is a
pointer to a struct super_block.  AFAICT it's only called in conjunction
with fs_holder_ops, so I suggest that the declaration for that should
grow a comment to that effect:

	/*
	 * For filesystems, the @holder argument passed to blkdev_get_* and
	 * bd_prepare_to_claim must point to a super_block object.
	 */
	extern const struct blk_holder_ops fs_holder_ops;

This patch itself looks ok so:
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  	const struct blk_holder_ops *bd_holder_ops;
>  	struct mutex		bd_holder_lock;
> -	/* The counter of freeze processes */
> -	atomic_t		bd_fsfreeze_count;
>  	int			bd_holders;
>  	struct kobject		*bd_holder_dir;
>  
> -	/* Mutex for freeze */
> -	struct mutex		bd_fsfreeze_mutex;
> -	struct super_block	*bd_fsfreeze_sb;
> +	/* The counter of freeze processes */
> +	atomic_t		bd_fsfreeze_count;
>  
>  	struct partition_meta_info *bd_meta_info;
>  #ifdef CONFIG_FAIL_MAKE_REQUEST
> 
> -- 
> 2.34.1
> 
