Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF032B902E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 11:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgKSKc4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 05:32:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:34386 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbgKSKc4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 05:32:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3937FACBA;
        Thu, 19 Nov 2020 10:32:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D5CBE1E130B; Thu, 19 Nov 2020 11:32:53 +0100 (CET)
Date:   Thu, 19 Nov 2020 11:32:53 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 13/20] block: remove ->bd_contains
Message-ID: <20201119103253.GV1981@quack2.suse.cz>
References: <20201118084800.2339180-1-hch@lst.de>
 <20201118084800.2339180-14-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118084800.2339180-14-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 18-11-20 09:47:53, Christoph Hellwig wrote:
> Now that each hd_struct has a reference to the corresponding
> block_device, there is no need for the bd_contains pointer.  Add
> a bdev_whole() helper to look up the whole device block_device
> struture instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Just two nits below. Otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> @@ -1521,7 +1510,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
>  		if (bdev->bd_bdi == &noop_backing_dev_info)
>  			bdev->bd_bdi = bdi_get(disk->queue->backing_dev_info);
>  	} else {
> -		if (bdev->bd_contains == bdev) {
> +		if (!bdev->bd_partno) {

This should be !bdev_is_partition(bdev) for consistency, right?

>  			ret = 0;
>  			if (bdev->bd_disk->fops->open)
>  				ret = bdev->bd_disk->fops->open(bdev, mode);
...
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 0069bee992063e..453b940b87d8e9 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -32,7 +32,6 @@ struct block_device {
>  #ifdef CONFIG_SYSFS
>  	struct list_head	bd_holder_disks;
>  #endif
> -	struct block_device *	bd_contains;
>  	u8			bd_partno;
>  	struct hd_struct *	bd_part;
>  	/* number of times partitions within this device have been opened. */
> @@ -48,6 +47,9 @@ struct block_device {
>  	struct mutex		bd_fsfreeze_mutex;
>  } __randomize_layout;
>  
> +#define bdev_whole(_bdev) \
> +	((_bdev)->bd_disk->part0.bdev)
> +
>  #define bdev_kobj(_bdev) \
>  	(&part_to_dev((_bdev)->bd_part)->kobj)

I'd somewhat prefer if these helpers could actually be inline functions and
not macros. I guess they are macros because hd_struct isn't in blk_types.h.
But if we moved helpers to blkdev.h, we'd have all definitions we need...
Is that a problem for some users?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
