Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BD12BA30E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 08:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgKTHXT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 02:23:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:49774 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgKTHXS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 02:23:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EDB7EAC0C;
        Fri, 20 Nov 2020 07:23:16 +0000 (UTC)
Subject: Re: [PATCH 34/78] block: propagate BLKROSET to all partitions
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
 <20201116145809.410558-35-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <11ea0b89-d8e6-2d5d-59e4-90e928d54042@suse.de>
Date:   Fri, 20 Nov 2020 08:23:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201116145809.410558-35-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/16/20 3:57 PM, Christoph Hellwig wrote:
> When setting the whole device read-only (or clearing the read-only
> state), also update the policy for all partitions.  The s390 dasd
> driver has awlways been doing this and it makes a lot of sense.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/ioctl.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 6b785181344fe1..22f394d118c302 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -354,7 +354,10 @@ static int blkdev_roset(struct block_device *bdev, fmode_t mode,
>   		if (ret)
>   			return ret;
>   	}
> -	bdev->bd_part->policy = n;
> +	if (bdev_is_partition(bdev))
> +		bdev->bd_part->policy = n;
> +	else
> +		set_disk_ro(bdev->bd_disk, n);
>   	return 0;
>   }
>   
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
