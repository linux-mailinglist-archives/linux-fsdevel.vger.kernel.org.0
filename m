Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606E22C57D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 16:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391302AbgKZPFi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 10:05:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:36374 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389884AbgKZPFi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 10:05:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3A9DEACE0;
        Thu, 26 Nov 2020 15:05:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C51F51E10D0; Thu, 26 Nov 2020 16:05:36 +0100 (CET)
Date:   Thu, 26 Nov 2020 16:05:36 +0100
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
Subject: Re: [PATCH 21/44] block: move bdput() to the callers of __blkdev_get
Message-ID: <20201126150536.GH422@quack2.suse.cz>
References: <20201126130422.92945-1-hch@lst.de>
 <20201126130422.92945-22-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126130422.92945-22-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 26-11-20 14:03:59, Christoph Hellwig wrote:
> This will allow for a more symmetric calling convention going forward.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/block_dev.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 86a61a2141f642..d0783c55a0ce65 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1458,6 +1458,7 @@ static int __blkdev_get(struct block_device *bdev, struct gendisk *disk,
>  			if (!(disk->flags & GENHD_FL_UP) ||
>  			    !bdev->bd_part || !bdev->bd_part->nr_sects) {
>  				__blkdev_put(whole, mode, 1);
> +				bdput(whole);
>  				ret = -ENXIO;
>  				goto out_clear;
>  			}
> @@ -1740,9 +1741,10 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part)
>  			disk->fops->release(disk, mode);
>  	}
>  	mutex_unlock(&bdev->bd_mutex);
> -	bdput(bdev);
> -	if (victim)
> +	if (victim) {
>  		__blkdev_put(victim, mode, 1);
> +		bdput(victim);
> +	}
>  }
>  
>  void blkdev_put(struct block_device *bdev, fmode_t mode)
> @@ -1792,6 +1794,7 @@ void blkdev_put(struct block_device *bdev, fmode_t mode)
>  	mutex_unlock(&bdev->bd_mutex);
>  
>  	__blkdev_put(bdev, mode, 0);
> +	bdput(bdev);
>  	put_disk_and_module(disk);
>  }
>  EXPORT_SYMBOL(blkdev_put);
> -- 
> 2.29.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
