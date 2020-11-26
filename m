Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93B82C5B0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 18:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404555AbgKZRtC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 12:49:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:55244 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404191AbgKZRtC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:49:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6D7F9ACA9;
        Thu, 26 Nov 2020 17:49:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 402A71E10D0; Thu, 26 Nov 2020 18:49:00 +0100 (CET)
Date:   Thu, 26 Nov 2020 18:49:00 +0100
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
Subject: Re: [PATCH 40/44] block: pass a block_device to invalidate_partition
Message-ID: <20201126174900.GZ422@quack2.suse.cz>
References: <20201126130422.92945-1-hch@lst.de>
 <20201126130422.92945-41-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126130422.92945-41-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 26-11-20 14:04:18, Christoph Hellwig wrote:
> Pass the block_device actually needed instead of looking it up using
> bdget_disk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/genhd.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 89cd0ba8e3b84a..28299b24173be1 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -792,14 +792,8 @@ void device_add_disk_no_queue_reg(struct device *parent, struct gendisk *disk)
>  }
>  EXPORT_SYMBOL(device_add_disk_no_queue_reg);
>  
> -static void invalidate_partition(struct gendisk *disk, int partno)
> +static void invalidate_partition(struct block_device *bdev)
>  {
> -	struct block_device *bdev;
> -
> -	bdev = bdget_disk(disk, partno);
> -	if (!bdev)
> -		return;
> -
>  	fsync_bdev(bdev);
>  	__invalidate_device(bdev, true);
>  
> @@ -808,7 +802,6 @@ static void invalidate_partition(struct gendisk *disk, int partno)
>  	 * up any more even if openers still hold references to it.
>  	 */
>  	remove_inode_hash(bdev->bd_inode);
> -	bdput(bdev);
>  }
>  
>  /**
> @@ -853,12 +846,12 @@ void del_gendisk(struct gendisk *disk)
>  	disk_part_iter_init(&piter, disk,
>  			     DISK_PITER_INCL_EMPTY | DISK_PITER_REVERSE);
>  	while ((part = disk_part_iter_next(&piter))) {
> -		invalidate_partition(disk, part->bdev->bd_partno);
> +		invalidate_partition(part->bdev);
>  		delete_partition(part);
>  	}
>  	disk_part_iter_exit(&piter);
>  
> -	invalidate_partition(disk, 0);
> +	invalidate_partition(disk->part0);
>  	set_capacity(disk, 0);
>  	disk->flags &= ~GENHD_FL_UP;
>  	up_write(&bdev_lookup_sem);
> -- 
> 2.29.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
