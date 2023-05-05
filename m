Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1AE6F88AD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 20:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjEEShw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 14:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjEEShv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 14:37:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFB81436C;
        Fri,  5 May 2023 11:37:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F74E63E75;
        Fri,  5 May 2023 18:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9727CC433D2;
        Fri,  5 May 2023 18:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683311869;
        bh=bhM78iv9h2kHBexih6lljlTJ/h5ct0IfRAMYM/JXOqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oc7Vbp/mjqXM1ov0eOQZB571U6bQOA1MF8be+ovf2l0ogUW/F8Hc5zK6Hm7KyTu6N
         ybgZuWZ83BFT0gK/Uvilr81mJK//MX/CuxONkwBtraqQ95qj98LDPU6J1urB7AY/xr
         t3PQfN/nRMxXRNGhFhQOSdjSB7cxlzlVkRowN1k5VCByEEa0/vx0jmE1My9r018CKT
         0r/5bwm/e/0VohFUeN3zqIXZO2pfBB9fFoY9D4GbfYiD4Ay6owHgJPck95bUs5k7DX
         0Hi7wm+3HyI+gSgxfTlDldj6FYCs8Ad/X9eLMAF7v2l+j+ahK8+45/25bJ2ngGHsWO
         X8fieSPq7krvg==
Date:   Fri, 5 May 2023 11:37:49 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 6/9] block: add a mark_dead holder operation
Message-ID: <20230505183749.GG15394@frogsfrogsfrogs>
References: <20230505175132.2236632-1-hch@lst.de>
 <20230505175132.2236632-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505175132.2236632-7-hch@lst.de>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 05, 2023 at 01:51:29PM -0400, Christoph Hellwig wrote:
> Add a mark_dead method to blk_holder_ops that is called from blk_mark_disk_dead
> to notify the holder that the block device it is using has been marked dead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/genhd.c          | 24 ++++++++++++++++++++++++
>  include/linux/blkdev.h |  1 +
>  2 files changed, 25 insertions(+)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index d1c673b967c254..af97a4ef1e926c 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -575,6 +575,28 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
>  }
>  EXPORT_SYMBOL(device_add_disk);
>  
> +static void blk_report_disk_dead(struct gendisk *disk)
> +{
> +	struct block_device *bdev;
> +	unsigned long idx;
> +
> +	rcu_read_lock();
> +	xa_for_each(&disk->part_tbl, idx, bdev) {
> +		if (!kobject_get_unless_zero(&bdev->bd_device.kobj))
> +			continue;
> +		rcu_read_unlock();
> +
> +		mutex_lock(&bdev->bd_holder_lock);
> +		if (bdev->bd_holder_ops && bdev->bd_holder_ops->mark_dead)
> +			bdev->bd_holder_ops->mark_dead(bdev);
> +		mutex_unlock(&bdev->bd_holder_lock);
> +
> +		put_device(&bdev->bd_device);
> +		rcu_read_lock();
> +	}
> +	rcu_read_unlock();
> +}
> +
>  /**
>   * blk_mark_disk_dead - mark a disk as dead
>   * @disk: disk to mark as dead
> @@ -602,6 +624,8 @@ void blk_mark_disk_dead(struct gendisk *disk)
>  	 * Prevent new I/O from crossing bio_queue_enter().
>  	 */
>  	blk_queue_start_drain(disk->queue);
> +
> +	blk_report_disk_dead(disk);
>  }
>  EXPORT_SYMBOL_GPL(blk_mark_disk_dead);
>  
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 3f41f8c9b103cf..9706bec2be16a5 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1469,6 +1469,7 @@ void blkdev_show(struct seq_file *seqf, off_t offset);
>  #endif
>  
>  struct blk_holder_ops {
> +	void (*mark_dead)(struct block_device *bdev);

Now that we have blockdev callbacks, can we add a pair for freeze_bdev
and thaw_bdev so that LVM snapshotting an xfs log device can actually
quiesce the filesystem?

This patch itself looks ok,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  };
>  
>  struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder,
> -- 
> 2.39.2
> 
