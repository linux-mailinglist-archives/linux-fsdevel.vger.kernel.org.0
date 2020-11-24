Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C8A2C2801
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 14:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388319AbgKXNcc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 08:32:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:51204 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388291AbgKXNcc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:32:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A52D5AC66;
        Tue, 24 Nov 2020 13:32:30 +0000 (UTC)
Subject: Re: [PATCH 38/45] block: switch partition lookup to use struct
 block_device
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20201124132751.3747337-1-hch@lst.de>
 <20201124132751.3747337-39-hch@lst.de>
From:   Coly Li <colyli@suse.de>
Message-ID: <4cdd6877-f4fd-8022-4a4f-3eabb86af2b9@suse.de>
Date:   Tue, 24 Nov 2020 21:32:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201124132751.3747337-39-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/24/20 9:27 PM, Christoph Hellwig wrote:
> Use struct block_device to lookup partitions on a disk.  This removes
> all usage of struct hd_struct from the I/O path, and this allows removing
> the percpu refcount in struct hd_struct.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>


For the bcache part, Acked-by: Coly Li <colyli@suse.de>

> ---
>  block/bio.c                        |  4 +-
>  block/blk-core.c                   | 66 ++++++++++++++----------------
>  block/blk-flush.c                  |  2 +-
>  block/blk-mq.c                     |  9 ++--
>  block/blk-mq.h                     |  7 ++--
>  block/blk.h                        |  4 +-
>  block/genhd.c                      | 56 +++++++++++++------------
>  block/partitions/core.c            |  7 +---
>  drivers/block/drbd/drbd_receiver.c |  2 +-
>  drivers/block/drbd/drbd_worker.c   |  2 +-
>  drivers/block/zram/zram_drv.c      |  2 +-
>  drivers/md/bcache/request.c        |  4 +-
>  drivers/md/dm.c                    |  4 +-
>  drivers/md/md.c                    |  4 +-
>  drivers/nvme/target/admin-cmd.c    | 20 ++++-----
>  fs/ext4/super.c                    | 18 +++-----
>  fs/ext4/sysfs.c                    | 10 +----
>  fs/f2fs/f2fs.h                     |  2 +-
>  fs/f2fs/super.c                    |  6 +--
>  include/linux/blkdev.h             |  8 ++--
>  include/linux/genhd.h              |  4 +-
>  include/linux/part_stat.h          | 17 ++++----
>  22 files changed, 120 insertions(+), 138 deletions(-)
[snipped]

> diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
> index afac8d07c1bd00..85b1f2a9b72d68 100644
> --- a/drivers/md/bcache/request.c
> +++ b/drivers/md/bcache/request.c
> @@ -475,7 +475,7 @@ struct search {
>  	unsigned int		read_dirty_data:1;
>  	unsigned int		cache_missed:1;
>  
> -	struct hd_struct	*part;
> +	struct block_device	*part;
>  	unsigned long		start_time;
>  
>  	struct btree_op		op;
> @@ -1073,7 +1073,7 @@ struct detached_dev_io_private {
>  	unsigned long		start_time;
>  	bio_end_io_t		*bi_end_io;
>  	void			*bi_private;
> -	struct hd_struct	*part;
> +	struct block_device	*part;
>  };
[snipped]

