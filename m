Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F7F2C7F0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 08:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgK3HsF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 02:48:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:59046 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbgK3HsF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 02:48:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 935D2ACC0;
        Mon, 30 Nov 2020 07:47:23 +0000 (UTC)
Subject: Re: [PATCH 38/45] block: switch partition lookup to use struct
 block_device
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Chao Yu <yuchao0@huawei.com>
References: <20201128161510.347752-1-hch@lst.de>
 <20201128161510.347752-39-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <45ba93f5-a00d-7e09-e839-afd12c65b067@suse.de>
Date:   Mon, 30 Nov 2020 08:47:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201128161510.347752-39-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/28/20 5:15 PM, Christoph Hellwig wrote:
> Use struct block_device to lookup partitions on a disk.  This removes
> all usage of struct hd_struct from the I/O path.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Acked-by: Coly Li <colyli@suse.de>			[bcache]
> Acked-by: Chao Yu <yuchao0@huawei.com>			[f2fs]
> ---
>   block/bio.c                        |  4 +-
>   block/blk-core.c                   | 66 ++++++++++++++----------------
>   block/blk-flush.c                  |  2 +-
>   block/blk-mq.c                     |  9 ++--
>   block/blk-mq.h                     |  7 ++--
>   block/blk.h                        |  4 +-
>   block/genhd.c                      | 57 +++++++++++++++-----------
>   block/partitions/core.c            |  7 +---
>   drivers/block/drbd/drbd_receiver.c |  2 +-
>   drivers/block/drbd/drbd_worker.c   |  2 +-
>   drivers/block/zram/zram_drv.c      |  2 +-
>   drivers/md/bcache/request.c        |  4 +-
>   drivers/md/dm.c                    |  4 +-
>   drivers/md/md.c                    |  4 +-
>   drivers/nvme/target/admin-cmd.c    | 20 ++++-----
>   fs/ext4/super.c                    | 18 +++-----
>   fs/ext4/sysfs.c                    | 10 +----
>   fs/f2fs/f2fs.h                     |  2 +-
>   fs/f2fs/super.c                    |  6 +--
>   include/linux/blkdev.h             |  8 ++--
>   include/linux/genhd.h              |  4 +-
>   include/linux/part_stat.h          | 17 ++++----
>   22 files changed, 122 insertions(+), 137 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
