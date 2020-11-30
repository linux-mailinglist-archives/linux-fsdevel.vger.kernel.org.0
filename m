Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA272C7E84
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 08:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgK3HPE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 02:15:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:40204 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgK3HPE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 02:15:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 82ED1AC55;
        Mon, 30 Nov 2020 07:14:22 +0000 (UTC)
Subject: Re: [PATCH 16/45] block: switch bdgrab to use igrab
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20201128161510.347752-1-hch@lst.de>
 <20201128161510.347752-17-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <595de89b-944c-a694-c63e-7600370d28fc@suse.de>
Date:   Mon, 30 Nov 2020 08:14:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201128161510.347752-17-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/28/20 5:14 PM, Christoph Hellwig wrote:
> All of the current callers already have a reference, but to prepare for
> additional users ensure bdgrab returns NULL if the block device is beeing
> freed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/block_dev.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index d707ab376da86e..962fabe8a67b83 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -894,10 +894,14 @@ static struct block_device *bdget(dev_t dev)
>   /**
>    * bdgrab -- Grab a reference to an already referenced block device
>    * @bdev:	Block device to grab a reference to.
> + *
> + * Returns the block_device with an additional reference when successful,
> + * or NULL if the inode is already beeing freed.
>    */
>   struct block_device *bdgrab(struct block_device *bdev)
>   {
> -	ihold(bdev->bd_inode);
> +	if (!igrab(bdev->bd_inode))
> +		return NULL;
>   	return bdev;
>   }
>   EXPORT_SYMBOL(bdgrab);
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
