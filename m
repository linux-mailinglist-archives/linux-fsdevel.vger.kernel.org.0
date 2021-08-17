Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BDF3EF630
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 01:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbhHQXid (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 19:38:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236442AbhHQXid (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 19:38:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3272261008;
        Tue, 17 Aug 2021 23:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629243479;
        bh=KvI87yrk0izqVPwd2j0JzMQ5KyLDj/89NGR3AMGLtaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SFevmy3Yp5L1NVJDt2KdHlMaVsL/rAJK88ajUJEJbOWOPeYi962gnJvIj1mO7o0G6
         YYPMGd3nSLmsy75hH1hZCIh0qzIUzdyhMszOqvunT6gF4aYsRVdFV5JRn/TBgFdTOM
         YD1NjOL4qHBBLgsaCYoTCs4nsWxVKGjUh5RIvio7VxeSqlAkA+svsDBE7XlFdDnh1p
         xU7toufVVVlnAhp6LaQ917tNZ8b8Lx9p4pg8FM0L1MwVlmA1OywoJweUsTfWRfNpyd
         TzSJxzWcDBQTAZ/fSijyXydtEoPlnLFcS7a5NFSItn5coF8a4cSNE1sHGFPRaeRzlN
         WakI1T8TH71Hg==
Date:   Tue, 17 Aug 2021 16:37:58 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     SelvaKumar S <selvakuma.s1@samsung.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        kbusch@kernel.org, axboe@kernel.dk, damien.lemoal@wdc.com,
        asml.silence@gmail.com, johannes.thumshirn@wdc.com, hch@lst.de,
        willy@infradead.org, kch@kernel.org, martin.petersen@oracle.com,
        mpatocka@redhat.com, bvanassche@acm.org, snitzer@redhat.com,
        agk@redhat.com, selvajove@gmail.com, joshiiitr@gmail.com,
        nj.shetty@samsung.com, nitheshshetty@gmail.com,
        joshi.k@samsung.com, javier.gonz@samsung.com
Subject: Re: [PATCH 0/7] add simple copy support
Message-ID: <20210817233758.GB12597@magnolia>
References: <CGME20210817101741epcas5p174ca0a539587da6a67b9f58cd13f2bad@epcas5p1.samsung.com>
 <20210817101423.12367-1-selvakuma.s1@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817101423.12367-1-selvakuma.s1@samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 17, 2021 at 03:44:16PM +0530, SelvaKumar S wrote:
> This started out as an attempt to support NVMe Simple Copy Command (SCC),
> and evolved during the RFC review process.
> 
> The patchset, at this point, contains -
> 1. SCC support in NVMe driver
> 2. Block-layer infra for copy-offload operation
> 3. ioctl interface to user-space
> 4. copy-emulation infra in the block-layer
> 5. copy-offload plumbing to dm-kcopyd (thus creating couple of in-kernel
> 	users such as dm-clone)
> 
> 
> The SCC specification, i.e. TP4065a can be found in following link
> 
> https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs.zip
> 
> Simple copy is a copy offloading feature and can be used to copy multiple
> contiguous ranges (source_ranges) of LBA's to a single destination LBA
> within the device, reducing traffic between host and device.
> 
> We define a block ioctl for copy and copy payload format similar to
> discard. For device supporting native simple copy, we attach the control
> information as payload to the bio and submit to the device. Copy emulation
> is implemented incase underlaying device does not support copy offload or
> based on sysfs choice. Copy emulation is done by reading each source range
> into buffer and writing it to the destination.

Seems useful.  Would you mind adapting the loop driver to call
copy_file_range (for files) so that anyone interested in making a
filesystem use this capability (cough) can write fstests?

--D

> At present this implementation does not support copy offload for stacked/dm
> devices, rather copy operation is completed through emulation.
> 
> One of the in-kernel use case for copy-offload is implemented by this
> patchset. dm-kcopyd infra has been changed to leverage the copy-offload if
> it is natively available. Other future use-cases could be F2FS GC, BTRFS
> relocation/balance and copy_file_range.
> 
> Following limits are added to queue limits and are exposed via sysfs to
> userspace, which user can use to form a payload.
> 
>  - copy_offload:
> 	configurable, can be used set emulation or copy offload
> 		0 to disable copy offload,
> 		1 to enable copy offloading support. Offload can be only
> 			enabled, if underlaying device supports offload
> 
>  - max_copy_sectors:
> 	total copy length supported by copy offload feature in device.
> 	0 indicates copy offload is not supported.
> 
>  - max_copy_nr_ranges:
> 	maximum number of source range entries supported by copy offload
> 			feature in device
> 
>  - max_copy_range_sectors:
> 	maximum copy length per source range entry
> 
> *blkdev_issue_copy* takes source bdev, no of sources, array of source
> ranges (in sectors), destination bdev and destination offset(in sectors).
> If both source and destination block devices are same and queue parameter
> copy_offload is 1, then copy is done through native copy offloading.
> Copy emulation is used in otherwise.
> 
> Changes from  RFC v5
> 
> 1. Handle copy larger than maximum copy limits
> 2. Create copy context and submit copy offload asynchronously
> 3. Remove BLKDEV_COPY_NOEMULATION opt-in option of copy offload and
> check for copy support before submission from dm and other layers
> 4. Allocate maximum possible allocatable buffer for copy emulation
> rather failing very large copy offload.
> 5. Fix copy_offload sysfs to be either have 0 or 1
> 
> Changes from RFC v4
> 
> 1. Extend dm-kcopyd to leverage copy-offload, while copying within the
> same device. The other approach was to have copy-emulation by moving
> dm-kcopyd to block layer. But it also required moving core dm-io infra,
> causing a massive churn across multiple dm-targets.
> 2. Remove export in bio_map_kern()
> 3. Change copy_offload sysfs to accept 0 or else
> 4. Rename copy support flag to QUEUE_FLAG_SIMPLE_COPY
> 5. Rename payload entries, add source bdev field to be used while
> partition remapping, remove copy_size
> 6. Change the blkdev_issue_copy() interface to accept destination and
> source values in sector rather in bytes
> 7. Add payload to bio using bio_map_kern() for copy_offload case
> 8. Add check to return error if one of the source range length is 0
> 9. Add BLKDEV_COPY_NOEMULATION flag to allow user to not try copy
> emulation incase of copy offload is not supported. Caller can his use
> his existing copying logic to complete the io.
> 10. Bug fix copy checks and reduce size of rcu_lock()
> 
> Changes from RFC v3
> 
> 1. gfp_flag fixes.
> 2. Export bio_map_kern() and use it to allocate and add pages to bio.
> 3. Move copy offload, reading to buf, writing from buf to separate functions
> 4. Send read bio of copy offload by chaining them and submit asynchronously
> 5. Add gendisk->part0 and part->bd_start_sect changes to blk_check_copy().
> 6. Move single source range limit check to blk_check_copy()
> 7. Rename __blkdev_issue_copy() to blkdev_issue_copy and remove old helper.
> 8. Change blkdev_issue_copy() interface generic to accepts destination bdev
>         to support XCOPY as well.
> 9. Add invalidate_kernel_vmap_range() after reading data for vmalloc'ed memory.
> 10. Fix buf allocoation logic to allocate buffer for the total size of copy.
> 11. Reword patch commit description.
> 
> Changes from RFC v2
> 
> 1. Add emulation support for devices not supporting copy.
> 2. Add *copy_offload* sysfs entry to enable and disable copy_offload
>         in devices supporting simple copy.
> 3. Remove simple copy support for stacked devices.
> 
> Changes from RFC v1:
> 
> 1. Fix memory leak in __blkdev_issue_copy
> 2. Unmark blk_check_copy inline
> 3. Fix line break in blk_check_copy_eod
> 4. Remove p checks and made code more readable
> 5. Don't use bio_set_op_attrs and remove op and set
>    bi_opf directly
> 6. Use struct_size to calculate total_size
> 7. Fix partition remap of copy destination
> 8. Remove mcl,mssrl,msrc from nvme_ns
> 9. Initialize copy queue limits to 0 in nvme_config_copy
> 10. Remove return in QUEUE_FLAG_COPY check
> 11. Remove unused OCFS
> 
> 
> Nitesh Shetty (4):
>   block: Introduce queue limits for copy-offload support
>   block: copy offload support infrastructure
>   block: Introduce a new ioctl for simple copy
>   block: add emulation for simple copy
> 
> SelvaKumar S (3):
>   block: make bio_map_kern() non static
>   nvme: add simple copy support
>   dm kcopyd: add simple copy offload support
> 
>  block/blk-core.c          |  84 ++++++++-
>  block/blk-lib.c           | 352 ++++++++++++++++++++++++++++++++++++++
>  block/blk-map.c           |   2 +-
>  block/blk-settings.c      |   4 +
>  block/blk-sysfs.c         |  51 ++++++
>  block/blk-zoned.c         |   1 +
>  block/bounce.c            |   1 +
>  block/ioctl.c             |  33 ++++
>  drivers/md/dm-kcopyd.c    |  56 +++++-
>  drivers/nvme/host/core.c  |  83 +++++++++
>  drivers/nvme/host/trace.c |  19 ++
>  include/linux/bio.h       |   1 +
>  include/linux/blk_types.h |  20 +++
>  include/linux/blkdev.h    |  21 +++
>  include/linux/nvme.h      |  43 ++++-
>  include/uapi/linux/fs.h   |  20 +++
>  16 files changed, 775 insertions(+), 16 deletions(-)
> 
> -- 
> 2.25.1
> 
