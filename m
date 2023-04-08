Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D28D6DBBEA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Apr 2023 17:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjDHPaZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Apr 2023 11:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjDHPaY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Apr 2023 11:30:24 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECE31707;
        Sat,  8 Apr 2023 08:30:21 -0700 (PDT)
Received: from [192.168.1.190] (ip5b426bea.dynamic.kabel-deutschland.de [91.66.107.234])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: buczek)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 14E8E60027FE8;
        Sat,  8 Apr 2023 17:30:20 +0200 (CEST)
Message-ID: <793db44e-9e6d-d118-3f88-cdbffc9ad018@molgen.mpg.de>
Date:   Sat, 8 Apr 2023 17:30:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 02/11] block: Block Device Filtering Mechanism
Content-Language: en-US
To:     Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk,
        hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org,
        kch@nvidia.com, martin.petersen@oracle.com, vkoul@kernel.org,
        ming.lei@redhat.com, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230404140835.25166-1-sergei.shtepa@veeam.com>
 <20230404140835.25166-3-sergei.shtepa@veeam.com>
From:   Donald Buczek <buczek@molgen.mpg.de>
In-Reply-To: <20230404140835.25166-3-sergei.shtepa@veeam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear Sergei,

On 4/4/23 16:08, Sergei Shtepa wrote:
> The block device filtering mechanism is an API that allows to attach
> block device filters. Block device filters allow perform additional
> processing for I/O units.
> 
> The idea of handling I/O units on block devices is not new. Back in the
> 2.6 kernel, there was an undocumented possibility of handling I/O units
> by substituting the make_request_fn() function, which belonged to the
> request_queue structure. But none of the in-tree kernel modules used
> this feature, and it was eliminated in the 5.10 kernel.
> 
> The block device filtering mechanism returns the ability to handle I/O
> units. It is possible to safely attach filter to a block device "on the
> fly" without changing the structure of block devices stack.
> 
> Co-developed-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
> ---
>   MAINTAINERS                     |   3 +
>   block/Makefile                  |   2 +-
>   block/bdev.c                    |   1 +
>   block/blk-core.c                |  40 ++++++-
>   block/blk-filter.c              | 199 ++++++++++++++++++++++++++++++++
>   block/blk.h                     |  10 ++
>   block/genhd.c                   |   2 +
>   block/ioctl.c                   |   7 ++
>   block/partitions/core.c         |   2 +
>   include/linux/blk-filter.h      |  51 ++++++++
>   include/linux/blk_types.h       |   2 +
>   include/linux/blkdev.h          |   1 +
>   include/uapi/linux/blk-filter.h |  35 ++++++
>   include/uapi/linux/fs.h         |   5 +
>   14 files changed, 357 insertions(+), 3 deletions(-)
>   create mode 100644 block/blk-filter.c
>   create mode 100644 include/linux/blk-filter.h
>   create mode 100644 include/uapi/linux/blk-filter.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2cbe4331ac97..fb6b7abe83e1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3576,6 +3576,9 @@ M:	Sergei Shtepa <sergei.shtepa@veeam.com>
>   L:	linux-block@vger.kernel.org
>   S:	Supported
>   F:	Documentation/block/blkfilter.rst
> +F:	block/blk-filter.c
> +F:	include/linux/blk-filter.h
> +F:	include/uapi/linux/blk-filter.h
>   
>   BLOCK LAYER
>   M:	Jens Axboe <axboe@kernel.dk>
> diff --git a/block/Makefile b/block/Makefile
> index 4e01bb71ad6e..d4671c7e499c 100644
> --- a/block/Makefile
> +++ b/block/Makefile
> @@ -9,7 +9,7 @@ obj-y		:= bdev.o fops.o bio.o elevator.o blk-core.o blk-sysfs.o \
>   			blk-lib.o blk-mq.o blk-mq-tag.o blk-stat.o \
>   			blk-mq-sysfs.o blk-mq-cpumap.o blk-mq-sched.o ioctl.o \
>   			genhd.o ioprio.o badblocks.o partitions/ blk-rq-qos.o \
> -			disk-events.o blk-ia-ranges.o
> +			disk-events.o blk-ia-ranges.o blk-filter.o
>   
>   obj-$(CONFIG_BOUNCE)		+= bounce.o
>   obj-$(CONFIG_BLK_DEV_BSG_COMMON) += bsg.o
> diff --git a/block/bdev.c b/block/bdev.c
> index 1795c7d4b99e..e290020810dd 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -424,6 +424,7 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
>   		return NULL;
>   	}
>   	bdev->bd_disk = disk;
> +	bdev->bd_filter = NULL;
>   	return bdev;
>   }
>   
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 42926e6cb83c..179a1c9ecc90 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -18,6 +18,7 @@
>   #include <linux/blkdev.h>
>   #include <linux/blk-pm.h>
>   #include <linux/blk-integrity.h>
> +#include <linux/blk-filter.h>
>   #include <linux/highmem.h>
>   #include <linux/mm.h>
>   #include <linux/pagemap.h>
> @@ -591,10 +592,32 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
>   	return BLK_STS_OK;
>   }
>   
> +static bool submit_bio_filter(struct bio *bio)
> +{
> +	/*
> +	 * If this bio came from the filter driver, send it straight down to the
> +	 * actual device and clear the filtered flag, as the bio could be passed
> +	 * on to another device that might have a filter attached again.
> +	 */
> +	if (bio_flagged(bio, BIO_FILTERED)) {
> +		bio_clear_flag(bio, BIO_FILTERED);
> +		return false;
> +	}
> +	bio_set_flag(bio, BIO_FILTERED);
> +	return bio->bi_bdev->bd_filter->ops->submit_bio(bio);
> +}
> +
>   static void __submit_bio(struct bio *bio)
>   {
>   	struct gendisk *disk = bio->bi_bdev->bd_disk;
>   
> +	/*
> +	 * If there is a filter driver attached, check if the BIO needs to go to
> +	 * the filter driver first, which can then pass on the bio or consume it.
> +	 */
> +	if (bio->bi_bdev->bd_filter && submit_bio_filter(bio))
> +		return;
> +
>   	if (unlikely(!blk_crypto_bio_prep(&bio)))
>   		return;
>   
> @@ -682,6 +705,15 @@ static void __submit_bio_noacct_mq(struct bio *bio)
>   	current->bio_list = NULL;
>   }
>   
> +/**
> + * submit_bio_noacct_nocheck - re-submit a bio to the block device layer for I/O
> + *	from block device filter.
> + * @bio:  The bio describing the location in memory and on the device.
> + *
> + * This is a version of submit_bio() that shall only be used for I/O that is
> + * resubmitted to lower level by block device filters.  All file  systems and
> + * other upper level users of the block layer should use submit_bio() instead.
> + */
>   void submit_bio_noacct_nocheck(struct bio *bio)
>   {
>   	blk_cgroup_bio_start(bio);
> @@ -702,13 +734,17 @@ void submit_bio_noacct_nocheck(struct bio *bio)
>   	 * to collect a list of requests submited by a ->submit_bio method while
>   	 * it is active, and then process them after it returned.
>   	 */
> -	if (current->bio_list)
> +	if (current->bio_list) {
>   		bio_list_add(&current->bio_list[0], bio);
> -	else if (!bio->bi_bdev->bd_disk->fops->submit_bio)
> +		return;
> +	}
> +
> +	if (!bio->bi_bdev->bd_disk->fops->submit_bio)
>   		__submit_bio_noacct_mq(bio);
>   	else
>   		__submit_bio_noacct(bio);
>   }
> +EXPORT_SYMBOL_GPL(submit_bio_noacct_nocheck);
>   
>   /**
>    * submit_bio_noacct - re-submit a bio to the block device layer for I/O
> diff --git a/block/blk-filter.c b/block/blk-filter.c
> new file mode 100644
> index 000000000000..5e9d884fad4d
> --- /dev/null
> +++ b/block/blk-filter.c
> @@ -0,0 +1,199 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2023 Veeam Software Group GmbH */
> +#include <linux/blk-filter.h>
> +#include <linux/blk-mq.h>
> +#include <linux/module.h>
> +
> +#include "blk.h"
> +
> +static LIST_HEAD(blkfilters);
> +static DEFINE_SPINLOCK(blkfilters_lock);
> +
> +static inline struct blkfilter_operations *__blkfilter_find(const char *name)
> +{
> +	struct blkfilter_operations *ops;
> +
> +	list_for_each_entry(ops, &blkfilters, link)
> +		if (strncmp(ops->name, name, BLKFILTER_NAME_LENGTH) == 0)
> +			return ops;
> +
> +	return NULL;
> +}
> +
> +static inline struct blkfilter_operations *blkfilter_find_get(const char *name)
> +{
> +	struct blkfilter_operations *ops;
> +
> +	spin_lock(&blkfilters_lock);
> +	ops = __blkfilter_find(name);
> +	if (ops && !try_module_get(ops->owner))
> +		ops = NULL;
> +	spin_unlock(&blkfilters_lock);
> +
> +	return ops;
> +}
> +
> +int blkfilter_ioctl_attach(struct block_device *bdev,
> +		    struct blkfilter_name __user *argp)
> +{
> +	struct blkfilter_name name;
> +	struct blkfilter_operations *ops;
> +	struct blkfilter *flt;
> +	int ret;
> +
> +	if (copy_from_user(&name, argp, sizeof(name)))
> +		return -EFAULT;
> +
> +	ops = blkfilter_find_get(name.name);
> +	if (!ops)
> +		return -ENOENT;
> +
> +	ret = freeze_bdev(bdev);
> +	if (ret)
> +		goto out_put_module;
> +	blk_mq_freeze_queue(bdev->bd_queue);
> +
> +	if (bdev->bd_filter) {
> +		if (bdev->bd_filter->ops == ops)
> +			ret = -EALREADY;
> +		else
> +			ret = -EBUSY;
> +		goto out_unfreeze;
> +	}

Maybe detach the old filter and attach the new one instead? An atomic replace might be usefull and it wouldn't complicate the code to do that instead. If its the same filter, maybe just return success and don't go through ops->detach and ops->attach?

D.

> [...]

-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433
