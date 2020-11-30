Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF1A2C7EC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 08:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgK3Hcj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 02:32:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:45650 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbgK3Hci (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 02:32:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D91FAAC8F;
        Mon, 30 Nov 2020 07:31:56 +0000 (UTC)
Subject: Re: [PATCH 24/45] block: remove i_bdev
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
 <20201128161510.347752-25-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <7ad63383-5f07-3fd2-d39b-b0db7905d094@suse.de>
Date:   Mon, 30 Nov 2020 08:31:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201128161510.347752-25-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/28/20 5:14 PM, Christoph Hellwig wrote:
> Switch the block device lookup interfaces to directly work with a dev_t
> so that struct block_device references are only acquired by the
> blkdev_get variants (and the blk-cgroup special case).  This means that
> we now don't need an extra reference in the inode and can generally
> simplify handling of struct block_device to keep the lookups contained
> in the core block layer code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Acked-by: Tejun Heo <tj@kernel.org>
> Acked-by: Coly Li <colyli@suse.de>		[bcache]
> ---
>   block/ioctl.c                                |   3 +-
>   drivers/block/loop.c                         |   8 +-
>   drivers/md/bcache/super.c                    |  20 +-
>   drivers/md/dm-table.c                        |   9 +-
>   drivers/mtd/mtdsuper.c                       |  17 +-
>   drivers/target/target_core_file.c            |   6 +-
>   drivers/usb/gadget/function/storage_common.c |   8 +-
>   fs/block_dev.c                               | 196 +++++--------------
>   fs/btrfs/volumes.c                           |  13 +-
>   fs/inode.c                                   |   3 -
>   fs/internal.h                                |   7 +-
>   fs/io_uring.c                                |  10 +-
>   fs/pipe.c                                    |   5 +-
>   fs/quota/quota.c                             |  19 +-
>   fs/statfs.c                                  |   2 +-
>   fs/super.c                                   |  44 ++---
>   include/linux/blkdev.h                       |   2 +-
>   include/linux/fs.h                           |   1 -
>   18 files changed, 121 insertions(+), 252 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
