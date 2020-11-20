Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6DE2BA3AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 08:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgKTHnF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 02:43:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:36314 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgKTHnE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 02:43:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E6A77AB3D;
        Fri, 20 Nov 2020 07:43:02 +0000 (UTC)
Subject: Re: [PATCH 65/78] dm: remove the block_device reference in struct
 mapped_device
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20201116145809.410558-1-hch@lst.de>
 <20201116145809.410558-66-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <310bff8b-dbda-609a-a392-619733b86bd1@suse.de>
Date:   Fri, 20 Nov 2020 08:43:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201116145809.410558-66-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/16/20 3:57 PM, Christoph Hellwig wrote:
> Get rid of the long-lasting struct block_device reference in
> struct mapped_device.  The only remaining user is the freeze code,
> where we can trivially look up the block device at freeze time
> and release the reference at thaw time.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/md/dm-core.h |  2 --
>   drivers/md/dm.c      | 22 +++++++++++-----------
>   2 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
> index d522093cb39dda..b1b400ed76fe90 100644
> --- a/drivers/md/dm-core.h
> +++ b/drivers/md/dm-core.h
> @@ -107,8 +107,6 @@ struct mapped_device {
>   	/* kobject and completion */
>   	struct dm_kobject_holder kobj_holder;
>   
> -	struct block_device *bdev;
> -
>   	struct dm_stats stats;
>   
>   	/* for blk-mq request-based DM support */
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 6d7eb72d41f9ea..c789ffea2badde 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1744,11 +1744,6 @@ static void cleanup_mapped_device(struct mapped_device *md)
>   
>   	cleanup_srcu_struct(&md->io_barrier);
>   
> -	if (md->bdev) {
> -		bdput(md->bdev);
> -		md->bdev = NULL;
> -	}
> -
>   	mutex_destroy(&md->suspend_lock);
>   	mutex_destroy(&md->type_lock);
>   	mutex_destroy(&md->table_devices_lock);
> @@ -1840,10 +1835,6 @@ static struct mapped_device *alloc_dev(int minor)
>   	if (!md->wq)
>   		goto bad;
>   
> -	md->bdev = bdget_disk(md->disk, 0);
> -	if (!md->bdev)
> -		goto bad;
> -
>   	dm_stats_init(&md->stats);
>   
>   	/* Populate the mapping, nobody knows we exist yet */
> @@ -2384,12 +2375,17 @@ struct dm_table *dm_swap_table(struct mapped_device *md, struct dm_table *table)
>    */
>   static int lock_fs(struct mapped_device *md)
>   {
> +	struct block_device *bdev;
>   	int r;
>   
>   	WARN_ON(md->frozen_sb);
>   
> -	md->frozen_sb = freeze_bdev(md->bdev);
> +	bdev = bdget_disk(md->disk, 0);
> +	if (!bdev)
> +		return -ENOMEM;
> +	md->frozen_sb = freeze_bdev(bdev);
>   	if (IS_ERR(md->frozen_sb)) {
> +		bdput(bdev);
>   		r = PTR_ERR(md->frozen_sb);
>   		md->frozen_sb = NULL;
>   		return r;
> @@ -2402,10 +2398,14 @@ static int lock_fs(struct mapped_device *md)
>   
>   static void unlock_fs(struct mapped_device *md)
>   {
> +	struct block_device *bdev;
> +
>   	if (!test_bit(DMF_FROZEN, &md->flags))
>   		return;
>   
> -	thaw_bdev(md->bdev, md->frozen_sb);
> +	bdev = md->frozen_sb->s_bdev;
> +	thaw_bdev(bdev, md->frozen_sb);
> +	bdput(bdev);
>   	md->frozen_sb = NULL;
>   	clear_bit(DMF_FROZEN, &md->flags);
>   }
> 
Yay. Just what I need for the blk-interposer code, where the ->bdev
pointer is really getting in the way.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
