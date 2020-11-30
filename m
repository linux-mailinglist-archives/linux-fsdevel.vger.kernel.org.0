Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1ED2C7EC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 08:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgK3HhD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 02:37:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:50970 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgK3HhD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 02:37:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 09E40AC6A;
        Mon, 30 Nov 2020 07:36:21 +0000 (UTC)
Subject: Re: [PATCH 25/45] block: simplify bdev/disk lookup in blkdev_get
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
 <20201128161510.347752-26-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <daa050e6-8758-a458-91fe-046c5690a336@suse.de>
Date:   Mon, 30 Nov 2020 08:36:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201128161510.347752-26-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/28/20 5:14 PM, Christoph Hellwig wrote:
> To simplify block device lookup and a few other upcoming areas, make sure
> that we always have a struct block_device available for each disk and
> each partition, and only find existing block devices in bdget.  The only
> downside of this is that each device and partition uses a little more
> memory.  The upside will be that a lot of code can be simplified.
> 
> With that all we need to look up the block device is to lookup the inode
> and do a few sanity checks on the gendisk, instead of the separate lookup
> for the gendisk.  For blk-cgroup which wants to access a gendisk without
> opening it, a new blkdev_{get,put}_no_open low-level interface is added
> to replace the previous get_gendisk use.
> 
> Note that the change to look up block device directly instead of the two
> step lookup using struct gendisk causes a subtile change in behavior:
> accessing a non-existing partition on an existing block device can now
> cause a call to request_module.  That call is harmless, and in practice
> no recent system will access these nodes as they aren't created by udev
> and static /dev/ setups are unusual.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-cgroup.c         |  42 ++++----
>   block/blk-iocost.c         |  36 +++----
>   block/blk.h                |   2 +-
>   block/genhd.c              | 210 +++++--------------------------------
>   block/partitions/core.c    |  29 ++---
>   fs/block_dev.c             | 177 +++++++++++++++++--------------
>   include/linux/blk-cgroup.h |   4 +-
>   include/linux/blkdev.h     |   6 ++
>   include/linux/genhd.h      |   7 +-
>   9 files changed, 194 insertions(+), 319 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
