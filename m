Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DB82AB1EB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 08:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbgKIHyC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 02:54:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:34394 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728904AbgKIHyB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 02:54:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E44CAABAE;
        Mon,  9 Nov 2020 07:53:59 +0000 (UTC)
Subject: Re: [PATCH 03/24] nvme: let set_capacity_revalidate_and_notify update
 the bdev size
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
References: <20201106190337.1973127-1-hch@lst.de>
 <20201106190337.1973127-4-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <1d06cdfa-a904-30be-f3ec-08ae2fa85cbd@suse.de>
Date:   Mon, 9 Nov 2020 08:53:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201106190337.1973127-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/6/20 8:03 PM, Christoph Hellwig wrote:
> There is no good reason to call revalidate_disk_size separately.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 376096bfc54a83..4e86c9aafd88a7 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2053,7 +2053,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
>   			capacity = 0;
>   	}
>   
> -	set_capacity_revalidate_and_notify(disk, capacity, false);
> +	set_capacity_revalidate_and_notify(disk, capacity, true);
>   
>   	nvme_config_discard(disk, ns);
>   	nvme_config_write_zeroes(disk, ns);
> @@ -2136,7 +2136,6 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>   		blk_stack_limits(&ns->head->disk->queue->limits,
>   				 &ns->queue->limits, 0);
>   		blk_queue_update_readahead(ns->head->disk->queue);
> -		nvme_update_bdev_size(ns->head->disk);
>   		blk_mq_unfreeze_queue(ns->head->disk->queue);
>   	}
>   #endif

Hold on.
This, at the very least, should be a separate patch.
With this you are changing the behaviour of nvme multipath.

Originally nvme multipath would update/change the size of the multipath 
device according to the underlying path devices.
With this patch the size of the multipath device will _not_ change if 
there is a change on the underlying devices.

While personally I would _love_ to have this patch, we should at least 
document this by making it a separate patch.
And we possibly should check if both sizes are the same, and think of 
what we should be doing if they are not.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
