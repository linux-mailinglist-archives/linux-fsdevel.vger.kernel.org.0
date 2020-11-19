Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF1F2B94E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 15:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgKSOjY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 09:39:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:51602 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728124AbgKSOjX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:39:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3CBF6AA4F;
        Thu, 19 Nov 2020 14:39:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E1C061E130B; Thu, 19 Nov 2020 15:39:21 +0100 (CET)
Date:   Thu, 19 Nov 2020 15:39:21 +0100
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
Subject: Re: [PATCH 15/20] block: merge struct block_device and struct
 hd_struct
Message-ID: <20201119143921.GX1981@quack2.suse.cz>
References: <20201118084800.2339180-1-hch@lst.de>
 <20201118084800.2339180-16-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118084800.2339180-16-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 18-11-20 09:47:55, Christoph Hellwig wrote:
> Instead of having two structures that represent each block device with
> different lift time rules merged them into a single one.  This also
            ^^^ :) life     ^^^^ merge

> greatly simplifies the reference counting rules, as we can use the inode
> reference count as the main reference count for the new struct
> block_device, with the device model reference front ending it for device
> model interaction.  The percpu refcount in struct hd_struct is entirely
> gone given that struct block_device must be opened and thus valid for
> the duration of the I/O.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This patch is kind of difficult to review due to the size of mostly
mechanical changes mixed with not completely mechanical changes. Can we
perhaps split out the mechanical bits? E.g. the rq->part => rq->bdev
renaming is mechanical and notable part of the patch. Similarly the
part->foo => part->bd_foo bits...

Also I'm kind of wondering: AFAIU the new lifetime rules, gendisk holds
bdev reference and bdev is created on gendisk allocation so bdev lifetime is
strictly larger than gendisk lifetime. But what now keeps bdev->bd_disk
reference safe in presence device hot unplug? In most cases we are still
protected by gendisk reference taken in __blkdev_get() but how about
disk->lookup_sem and disk->flags dereferences before we actually grab the
reference?

Also I find it rather non-obvious (although elegant ;) that bdev->bd_device
rules the lifetime of gendisk. Can you perhaps explain this in the
changelog and probably also add somewhere to source a documentation about
the new lifetime rules?

> diff --git a/block/blk.h b/block/blk.h
> index 09cee7024fb43e..90dd2047c6cd29 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -215,7 +215,15 @@ static inline void elevator_exit(struct request_queue *q,
>  	__elevator_exit(q, e);
>  }
>  
> -struct hd_struct *__disk_get_part(struct gendisk *disk, int partno);
> +static inline struct block_device *__bdget_disk(struct gendisk *disk,
> +		int partno)
> +{
> +	struct disk_part_tbl *ptbl = rcu_dereference(disk->part_tbl);
> +
> +	if (unlikely(partno < 0 || partno >= ptbl->len))
> +		return NULL;
> +	return rcu_dereference(ptbl->part[partno]);
> +}

I understand this is lower-level counterpart of bdget_disk() but it is
confusing to me that this has 'bdget' in the name and returns no bdev
reference. Can we call it like __bdev_from_disk() or something like that?

>  
>  ssize_t part_size_show(struct device *dev, struct device_attribute *attr,
>  		char *buf);


									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
