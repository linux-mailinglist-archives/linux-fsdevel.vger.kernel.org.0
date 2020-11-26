Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63EE72C5963
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 17:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391540AbgKZQhw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 11:37:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:46680 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391270AbgKZQhw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 11:37:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9A353ACC4;
        Thu, 26 Nov 2020 16:37:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 730531E10D0; Thu, 26 Nov 2020 17:37:50 +0100 (CET)
Date:   Thu, 26 Nov 2020 17:37:50 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 28/44] block: initialize struct block_device in bdev_alloc
Message-ID: <20201126163750.GN422@quack2.suse.cz>
References: <20201126130422.92945-1-hch@lst.de>
 <20201126130422.92945-29-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126130422.92945-29-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 26-11-20 14:04:06, Christoph Hellwig wrote:
> Don't play tricks with slab constructors as bdev structures tends to not
> get reused very much, and this makes the code a lot less error prone.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Tejun Heo <tj@kernel.org>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/block_dev.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index f180ac0e87844f..58e8532d8580a1 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -784,20 +784,11 @@ static void bdev_free_inode(struct inode *inode)
>  	kmem_cache_free(bdev_cachep, BDEV_I(inode));
>  }
>  
> -static void init_once(void *foo)
> +static void init_once(void *data)
>  {
> -	struct bdev_inode *ei = (struct bdev_inode *) foo;
> -	struct block_device *bdev = &ei->bdev;
> +	struct bdev_inode *ei = data;
>  
> -	memset(bdev, 0, sizeof(*bdev));
> -	mutex_init(&bdev->bd_mutex);
> -#ifdef CONFIG_SYSFS
> -	INIT_LIST_HEAD(&bdev->bd_holder_disks);
> -#endif
> -	bdev->bd_bdi = &noop_backing_dev_info;
>  	inode_init_once(&ei->vfs_inode);
> -	/* Initialize mutex for freeze. */
> -	mutex_init(&bdev->bd_fsfreeze_mutex);
>  }
>  
>  static void bdev_evict_inode(struct inode *inode)
> @@ -873,12 +864,17 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
>  	mapping_set_gfp_mask(&inode->i_data, GFP_USER);
>  
>  	bdev = I_BDEV(inode);
> +	memset(bdev, 0, sizeof(*bdev));
> +	mutex_init(&bdev->bd_mutex);
> +	mutex_init(&bdev->bd_fsfreeze_mutex);
>  	spin_lock_init(&bdev->bd_size_lock);
>  	bdev->bd_disk = disk;
>  	bdev->bd_partno = partno;
> -	bdev->bd_super = NULL;
>  	bdev->bd_inode = inode;
> -	bdev->bd_part_count = 0;
> +	bdev->bd_bdi = &noop_backing_dev_info;
> +#ifdef CONFIG_SYSFS
> +	INIT_LIST_HEAD(&bdev->bd_holder_disks);
> +#endif
>  	return bdev;
>  }
>  
> -- 
> 2.29.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
