Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E198E2AB2DF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 09:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbgKIIxp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 03:53:45 -0500
Received: from verein.lst.de ([213.95.11.211]:57570 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbgKIIxp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 03:53:45 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id AB71E6736F; Mon,  9 Nov 2020 09:53:40 +0100 (CET)
Date:   Mon, 9 Nov 2020 09:53:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/24] nvme: let set_capacity_revalidate_and_notify
 update the bdev size
Message-ID: <20201109085340.GB27483@lst.de>
References: <20201106190337.1973127-1-hch@lst.de> <20201106190337.1973127-4-hch@lst.de> <1d06cdfa-a904-30be-f3ec-08ae2fa85cbd@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d06cdfa-a904-30be-f3ec-08ae2fa85cbd@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 09, 2020 at 08:53:58AM +0100, Hannes Reinecke wrote:
>> index 376096bfc54a83..4e86c9aafd88a7 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -2053,7 +2053,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
>>   			capacity = 0;
>>   	}
>>   -	set_capacity_revalidate_and_notify(disk, capacity, false);
>> +	set_capacity_revalidate_and_notify(disk, capacity, true);
>>     	nvme_config_discard(disk, ns);
>>   	nvme_config_write_zeroes(disk, ns);
>> @@ -2136,7 +2136,6 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>>   		blk_stack_limits(&ns->head->disk->queue->limits,
>>   				 &ns->queue->limits, 0);
>>   		blk_queue_update_readahead(ns->head->disk->queue);
>> -		nvme_update_bdev_size(ns->head->disk);
>>   		blk_mq_unfreeze_queue(ns->head->disk->queue);
>>   	}
>>   #endif
>
> Hold on.
> This, at the very least, should be a separate patch.
> With this you are changing the behaviour of nvme multipath.
>
> Originally nvme multipath would update/change the size of the multipath 
> device according to the underlying path devices.
> With this patch the size of the multipath device will _not_ change if there 
> is a change on the underlying devices.

Yes, it will.  Take a close look at nvme_update_disk_info and how it is
called.
