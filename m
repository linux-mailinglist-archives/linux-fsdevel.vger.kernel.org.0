Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FF126D7FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 11:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgIQJqT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 05:46:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:52796 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbgIQJqT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 05:46:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6D705AFE5;
        Thu, 17 Sep 2020 09:46:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5E80E1E12E1; Thu, 17 Sep 2020 11:46:15 +0200 (CEST)
Date:   Thu, 17 Sep 2020 11:46:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 02/12] drbd: remove dead code in device_to_statistics
Message-ID: <20200917094615.GI7347@quack2.suse.cz>
References: <20200910144833.742260-1-hch@lst.de>
 <20200910144833.742260-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910144833.742260-3-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 10-09-20 16:48:22, Christoph Hellwig wrote:
> Ever since the switch to blk-mq, a lower device not used for VM
> writeback will not be marked congested, so the check will never
> trigger.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/drbd/drbd_nl.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index 43c8ae4d9fca81..aaff5bde391506 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -3370,7 +3370,6 @@ static void device_to_statistics(struct device_statistics *s,
>  	if (get_ldev(device)) {
>  		struct drbd_md *md = &device->ldev->md;
>  		u64 *history_uuids = (u64 *)s->history_uuids;
> -		struct request_queue *q;
>  		int n;
>  
>  		spin_lock_irq(&md->uuid_lock);
> @@ -3384,11 +3383,6 @@ static void device_to_statistics(struct device_statistics *s,
>  		spin_unlock_irq(&md->uuid_lock);
>  
>  		s->dev_disk_flags = md->flags;
> -		q = bdev_get_queue(device->ldev->backing_bdev);
> -		s->dev_lower_blocked =
> -			bdi_congested(q->backing_dev_info,
> -				      (1 << WB_async_congested) |
> -				      (1 << WB_sync_congested));
>  		put_ldev(device);
>  	}
>  	s->dev_size = drbd_get_capacity(device->this_bdev);
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
