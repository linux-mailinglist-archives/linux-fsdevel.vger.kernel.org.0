Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFACE2BA413
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 08:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgKTH6T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 02:58:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:46460 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbgKTH6T (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 02:58:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 75B07AC0C;
        Fri, 20 Nov 2020 07:58:17 +0000 (UTC)
Subject: Re: [PATCH 70/78] block: replace bd_mutex with a per-gendisk mutex
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
 <20201116145809.410558-71-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <c854459e-d124-d0fd-2159-d40ef4d6ca75@suse.de>
Date:   Fri, 20 Nov 2020 08:58:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201116145809.410558-71-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/16/20 3:58 PM, Christoph Hellwig wrote:
> bd_mutex is primarily used for synchronizing the block device open and
> release path, which recurses from partitions to the whole disk device.
> The fact that we have two locks makes life unnecessarily complex due
> to lock order constrains.  Replace the two levels of locking with a
> single mutex in the gendisk structure.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/genhd.c                   |  7 ++--
>   block/ioctl.c                   |  4 +-
>   block/partitions/core.c         | 22 +++++-----
>   drivers/block/loop.c            | 14 +++----
>   drivers/block/xen-blkfront.c    |  8 ++--
>   drivers/block/zram/zram_drv.c   |  4 +-
>   drivers/block/zram/zram_drv.h   |  2 +-
>   drivers/md/md.h                 |  7 +---
>   drivers/s390/block/dasd_genhd.c |  8 ++--
>   drivers/scsi/sd.c               |  4 +-
>   fs/block_dev.c                  | 71 +++++++++++++++++----------------
>   fs/btrfs/volumes.c              |  2 +-
>   fs/super.c                      |  8 ++--
>   include/linux/blk_types.h       |  1 -
>   include/linux/genhd.h           |  1 +
>   15 files changed, 80 insertions(+), 83 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
