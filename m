Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7882C7F05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 08:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgK3HrM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 02:47:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:58458 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgK3HrM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 02:47:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5BC21AC55;
        Mon, 30 Nov 2020 07:46:30 +0000 (UTC)
Subject: Re: [PATCH 37/45] block: allocate struct hd_struct as part of struct
 bdev_inode
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
 <20201128161510.347752-38-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <e20d55a3-5d82-6e74-3cad-35b58fe1ceb1@suse.de>
Date:   Mon, 30 Nov 2020 08:46:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201128161510.347752-38-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/28/20 5:15 PM, Christoph Hellwig wrote:
> Allocate hd_struct together with struct block_device to pre-load
> the lifetime rule changes in preparation of merging the two structures.
> 
> Note that part0 was previously embedded into struct gendisk, but is
> a separate allocation now, and already points to the block_device instead
> of the hd_struct.  The lifetime of struct gendisk is still controlled by
> the struct device embedded in the part0 hd_struct.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-core.c                   | 16 ++++---
>   block/blk-flush.c                  |  2 +-
>   block/blk-merge.c                  |  2 -
>   block/blk.h                        | 21 ----------
>   block/genhd.c                      | 50 +++++++++-------------
>   block/partitions/core.c            | 67 +++---------------------------
>   drivers/block/drbd/drbd_receiver.c |  2 +-
>   drivers/block/drbd/drbd_worker.c   |  3 +-
>   drivers/block/zram/zram_drv.c      |  2 +-
>   drivers/md/dm.c                    |  4 +-
>   drivers/md/md.c                    |  2 +-
>   fs/block_dev.c                     | 39 ++++++-----------
>   include/linux/blk_types.h          |  2 +-
>   include/linux/genhd.h              | 14 +++----
>   include/linux/part_stat.h          |  4 +-
>   15 files changed, 61 insertions(+), 169 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
