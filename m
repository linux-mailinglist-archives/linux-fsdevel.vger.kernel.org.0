Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3A926D82A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 11:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgIQJzL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 05:55:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:58124 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbgIQJzK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 05:55:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 40398AEC8;
        Thu, 17 Sep 2020 09:55:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0A4781E12E1; Thu, 17 Sep 2020 11:55:07 +0200 (CEST)
Date:   Thu, 17 Sep 2020 11:55:07 +0200
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
        cgroups@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 03/12] drbd: remove RB_CONGESTED_REMOTE
Message-ID: <20200917095507.GJ7347@quack2.suse.cz>
References: <20200910144833.742260-1-hch@lst.de>
 <20200910144833.742260-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910144833.742260-4-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 10-09-20 16:48:23, Christoph Hellwig wrote:
> This case isn't ever used.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Are you sure it's never used? As far as I'm reading drdb code the contents
of the disk_conf structure seems to be received through netlink (that code
is really a macro hell) and so read_balancing attribute passed to
remote_due_to_read_balancing() can have any value userspace passed to it.

								Honza

> ---
>  drivers/block/drbd/drbd_req.c | 4 ----
>  include/linux/drbd.h          | 1 -
>  2 files changed, 5 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
> index 5c975af9c15fb8..481bc34fcf386a 100644
> --- a/drivers/block/drbd/drbd_req.c
> +++ b/drivers/block/drbd/drbd_req.c
> @@ -901,13 +901,9 @@ static bool drbd_may_do_local_read(struct drbd_device *device, sector_t sector,
>  static bool remote_due_to_read_balancing(struct drbd_device *device, sector_t sector,
>  		enum drbd_read_balancing rbm)
>  {
> -	struct backing_dev_info *bdi;
>  	int stripe_shift;
>  
>  	switch (rbm) {
> -	case RB_CONGESTED_REMOTE:
> -		bdi = device->ldev->backing_bdev->bd_disk->queue->backing_dev_info;
> -		return bdi_read_congested(bdi);
>  	case RB_LEAST_PENDING:
>  		return atomic_read(&device->local_cnt) >
>  			atomic_read(&device->ap_pending_cnt) + atomic_read(&device->rs_pending_cnt);
> diff --git a/include/linux/drbd.h b/include/linux/drbd.h
> index 5755537b51b114..6a8286132751df 100644
> --- a/include/linux/drbd.h
> +++ b/include/linux/drbd.h
> @@ -94,7 +94,6 @@ enum drbd_read_balancing {
>  	RB_PREFER_REMOTE,
>  	RB_ROUND_ROBIN,
>  	RB_LEAST_PENDING,
> -	RB_CONGESTED_REMOTE,
>  	RB_32K_STRIPING,
>  	RB_64K_STRIPING,
>  	RB_128K_STRIPING,
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
