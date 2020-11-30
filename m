Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91B02C8097
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 10:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgK3JKH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 04:10:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:38752 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbgK3JKH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 04:10:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 84675AC6A;
        Mon, 30 Nov 2020 09:09:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0D4011E131B; Mon, 30 Nov 2020 10:09:25 +0100 (CET)
Date:   Mon, 30 Nov 2020 10:09:25 +0100
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
Subject: Re: [PATCH 16/45] block: switch bdgrab to use igrab
Message-ID: <20201130090925.GB11250@quack2.suse.cz>
References: <20201128161510.347752-1-hch@lst.de>
 <20201128161510.347752-17-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201128161510.347752-17-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 28-11-20 17:14:41, Christoph Hellwig wrote:
> All of the current callers already have a reference, but to prepare for
> additional users ensure bdgrab returns NULL if the block device is beeing
								     ^^^ being

> freed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Otherwise looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/block_dev.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index d707ab376da86e..962fabe8a67b83 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -894,10 +894,14 @@ static struct block_device *bdget(dev_t dev)
>  /**
>   * bdgrab -- Grab a reference to an already referenced block device
>   * @bdev:	Block device to grab a reference to.
> + *
> + * Returns the block_device with an additional reference when successful,
> + * or NULL if the inode is already beeing freed.
>   */
>  struct block_device *bdgrab(struct block_device *bdev)
>  {
> -	ihold(bdev->bd_inode);
> +	if (!igrab(bdev->bd_inode))
> +		return NULL;
>  	return bdev;
>  }
>  EXPORT_SYMBOL(bdgrab);
> -- 
> 2.29.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
