Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E98E2C7EE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 08:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgK3Hk3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 02:40:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:52520 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgK3Hk3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 02:40:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 691E2AD45;
        Mon, 30 Nov 2020 07:39:47 +0000 (UTC)
Subject: Re: [PATCH 30/45] block: remove the nr_sects field in struct
 hd_struct
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
 <20201128161510.347752-31-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <1c42fdb8-9c10-e5fd-e1c8-cfedc3922097@suse.de>
Date:   Mon, 30 Nov 2020 08:39:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201128161510.347752-31-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/28/20 5:14 PM, Christoph Hellwig wrote:
> Now that the hd_struct always has a block device attached to it, there is
> no need for having two size field that just get out of sync.
> 
> Additionally the field in hd_struct did not use proper serialization,
> possibly allowing for torn writes.  By only using the block_device field
> this problem also gets fixed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Coly Li <colyli@suse.de>			[bcache]
> Acked-by: Chao Yu <yuchao0@huawei.com>			[f2fs]
> ---
>   block/bio.c                        |  4 +-
>   block/blk-core.c                   |  2 +-
>   block/blk.h                        | 53 ----------------------
>   block/genhd.c                      | 55 +++++++++++-----------
>   block/partitions/core.c            | 17 ++++---
>   drivers/block/loop.c               |  1 -
>   drivers/block/nbd.c                |  2 +-
>   drivers/block/xen-blkback/common.h |  4 +-
>   drivers/md/bcache/super.c          |  2 +-
>   drivers/s390/block/dasd_ioctl.c    |  4 +-
>   drivers/target/target_core_pscsi.c |  5 +-
>   fs/block_dev.c                     | 73 +-----------------------------
>   fs/f2fs/super.c                    |  2 +-
>   fs/pstore/blk.c                    |  2 +-
>   include/linux/genhd.h              | 29 +++---------
>   kernel/trace/blktrace.c            |  2 +-
>   16 files changed, 61 insertions(+), 196 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
