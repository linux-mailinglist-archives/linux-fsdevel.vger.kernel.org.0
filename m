Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF82562019
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 18:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbiF3QSa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 12:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbiF3QS2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:18:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171A21EC7F;
        Thu, 30 Jun 2022 09:18:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9987661FFB;
        Thu, 30 Jun 2022 16:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1484C34115;
        Thu, 30 Jun 2022 16:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656605906;
        bh=FNqG9nClUfdn9TnASVFMj5V788rc3hGSwKyxEuvVVFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J5p3lhbJI8VOen72bxecwV8g5Ml7LefIqf5OH1zPkd9Jt3JcxXB+X+moMJ1nrh5I2
         Imlltepf26S9tc6h8M/0MBSitMRtaUPlhbs6HsPORqcITAtCb90jpRmV4rYU5M/7OF
         JrCUtb7D3e3clNn2akgZUIT0+8C85A6j/57/wRgCD/aKydbpyPrSDydOtVt5H5xY4+
         OYCzkxo3S9M1z6qgEsf9QpB69x911R8quDYLNIya88m3jta3ld3JKUpkrAS82yQ+9T
         UtDO3ClLaNbklWNJwTPsZB5oys2NrzgXdO7/r8bLWKcGLlhSHPNhYA3APv5EEiqmke
         hGr3o8VkSEGPw==
Date:   Thu, 30 Jun 2022 09:18:25 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, agk@redhat.com, song@kernel.org,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, javier@javigon.com,
        johannes.thumshirn@wdc.com, bvanassche@acm.org,
        dongli.zhang@oracle.com, ming.lei@redhat.com, willy@infradead.org,
        jefflexu@linux.alibaba.com, josef@toxicpanda.com, clm@fb.com,
        dsterba@suse.com, jack@suse.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, jlayton@kernel.org, idryomov@gmail.com,
        danil.kipnis@cloud.ionos.com, ebiggers@google.com,
        jinpu.wang@cloud.ionos.com
Subject: Re: [PATCH 1/6] block: add support for REQ_OP_VERIFY
Message-ID: <Yr3M0W5T/CwMtvte@magnolia>
References: <20220630091406.19624-1-kch@nvidia.com>
 <20220630091406.19624-2-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630091406.19624-2-kch@nvidia.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 30, 2022 at 02:14:01AM -0700, Chaitanya Kulkarni wrote:
> This adds a new block layer operation to offload verifying a range of
> LBAs. This support is needed in order to provide file systems and
> fabrics, kernel components to offload LBA verification when it is
> supported by the hardware controller. In case hardware offloading is
> not supported then we provide API to emulate the same. The prominent
> example of that is SCSI and NVMe Verify command. We also provide
> an emulation of the same operation that can be used in case H/W does
> not support verify. This is still useful when block device is remotely
> attached e.g. using NVMeOF.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  Documentation/ABI/stable/sysfs-block |  12 +++
>  block/blk-core.c                     |   5 +
>  block/blk-lib.c                      | 155 +++++++++++++++++++++++++++
>  block/blk-merge.c                    |  18 ++++
>  block/blk-settings.c                 |  17 +++
>  block/blk-sysfs.c                    |   8 ++
>  block/blk.h                          |   4 +
>  block/ioctl.c                        |  35 ++++++
>  include/linux/bio.h                  |   9 +-
>  include/linux/blk_types.h            |   2 +
>  include/linux/blkdev.h               |  22 ++++
>  include/uapi/linux/fs.h              |   1 +
>  12 files changed, 285 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> index e8797cd09aff..a71d9c41cf8b 100644
> --- a/Documentation/ABI/stable/sysfs-block
> +++ b/Documentation/ABI/stable/sysfs-block
> @@ -657,6 +657,18 @@ Description:
>  		in a single write zeroes command. If write_zeroes_max_bytes is
>  		0, write zeroes is not supported by the device.
>  
> +What:		/sys/block/<disk>/queue/verify_max_bytes
> +Date:		April 2022
> +Contact:	Chaitanya Kulkarni <kch@nvidia.com>
> +Description:
> +		Devices that support verify operation in which a single
> +		request can be issued to verify the range of the contiguous
> +		blocks on the storage without any payload in the request.
> +		This can be used to optimize verifying LBAs on the device
> +		without reading by offloading functionality. verify_max_bytes
> +		indicates how many bytes can be written in a single verify
> +		command. If verify_max_bytes is 0, verify operation is not
> +		supported by the device.
>  
>  What:		/sys/block/<disk>/queue/zone_append_max_bytes
>  Date:		May 2020
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 06ff5bbfe8f6..9ad52247dcdf 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -123,6 +123,7 @@ static const char *const blk_op_name[] = {
>  	REQ_OP_NAME(ZONE_FINISH),
>  	REQ_OP_NAME(ZONE_APPEND),
>  	REQ_OP_NAME(WRITE_ZEROES),
> +	REQ_OP_NAME(VERIFY),
>  	REQ_OP_NAME(DRV_IN),
>  	REQ_OP_NAME(DRV_OUT),
>  };
> @@ -842,6 +843,10 @@ void submit_bio_noacct(struct bio *bio)
>  		if (!q->limits.max_write_zeroes_sectors)
>  			goto not_supported;
>  		break;
> +	case REQ_OP_VERIFY:
> +		if (!q->limits.max_verify_sectors)
> +			goto not_supported;
> +		break;
>  	default:
>  		break;
>  	}
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index 09b7e1200c0f..4624d68bb3cb 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -340,3 +340,158 @@ int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
>  	return ret;
>  }
>  EXPORT_SYMBOL(blkdev_issue_secure_erase);
> +
> +/**
> + * __blkdev_emulate_verify - emulate number of verify operations
> + * 				asynchronously
> + * @bdev:	blockdev to issue
> + * @sector:	start sector
> + * @nr_sects:	number of sectors to verify
> + * @gfp_mask:	memory allocation flags (for bio_alloc)
> + * @biop:	pointer to anchor bio
> + * @buf:	data buffer to mapped on bio
> + *
> + * Description:
> + *  Verify a block range by emulating REQ_OP_VERIFY into REQ_OP_READ,
> + *  use this when H/W offloading is not supported asynchronously.
> + *  Caller is responsible to handle anchored bio.
> + */
> +static int __blkdev_emulate_verify(struct block_device *bdev, sector_t sector,
> +		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop, char *buf)
> +{
> +	struct bio *bio = *biop;
> +	unsigned int sz;
> +	int bi_size;
> +
> +	while (nr_sects != 0) {
> +		bio = blk_next_bio(bio, bdev,
> +				__blkdev_sectors_to_bio_pages(nr_sects),
> +				REQ_OP_READ, gfp_mask);
> +		bio->bi_iter.bi_sector = sector;
> +
> +		while (nr_sects != 0) {
> +			bool is_vaddr = is_vmalloc_addr(buf);
> +			struct page *p;
> +
> +			p = is_vaddr ? vmalloc_to_page(buf) : virt_to_page(buf);
> +			sz = min((sector_t) PAGE_SIZE, nr_sects << 9);
> +
> +			bi_size = bio_add_page(bio, p, sz, offset_in_page(buf));
> +			if (bi_size < sz)
> +				return -EIO;
> +
> +			nr_sects -= bi_size >> 9;
> +			sector += bi_size >> 9;
> +			buf += bi_size;
> +		}
> +		cond_resched();
> +	}
> +
> +	*biop = bio;
> +	return 0;
> +}
> +
> +/**
> + * __blkdev_issue_verify - generate number of verify operations
> + * @bdev:	blockdev to issue
> + * @sector:	start sector
> + * @nr_sects:	number of sectors to verify
> + * @gfp_mask:	memory allocation flags (for bio_alloc())
> + * @biop:	pointer to anchor bio
> + *
> + * Description:
> + *  Verify a block range using hardware offload.
> + *
> + * The function will emulate verify operation if no explicit hardware
> + * offloading for verifying is provided.
> + */
> +int __blkdev_issue_verify(struct block_device *bdev, sector_t sector,
> +		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop)
> +{
> +	unsigned int max_verify_sectors = bdev_verify_sectors(bdev);
> +	sector_t min_io_sect = (BIO_MAX_VECS << PAGE_SHIFT) >> 9;
> +	struct bio *bio = *biop;
> +	sector_t curr_sects;
> +	char *buf;
> +
> +	if (!max_verify_sectors) {
> +		int ret = 0;
> +
> +		buf = kzalloc(min_io_sect << 9, GFP_KERNEL);

k*z*alloc?  I don't think you need to zero a buffer that we're reading
into, right?

--D

> +		if (!buf)
> +			return -ENOMEM;
> +
> +		while (nr_sects > 0) {
> +			curr_sects = min_t(sector_t, nr_sects, min_io_sect);
> +			ret = __blkdev_emulate_verify(bdev, sector, curr_sects,
> +						      gfp_mask, &bio, buf);
> +			if (ret)
> +				break;
> +
> +			if (bio) {
> +				ret = submit_bio_wait(bio);
> +				bio_put(bio);
> +				bio = NULL;
> +			}
> +
> +			nr_sects -= curr_sects;
> +			sector += curr_sects;
> +
> +		}
> +		/* set the biop to NULL since we have alrady completed above */
> +		*biop = NULL;
> +		kfree(buf);
> +		return ret;
> +	}
> +
> +	while (nr_sects) {
> +		bio = blk_next_bio(bio, bdev, 0, REQ_OP_VERIFY, gfp_mask);
> +		bio->bi_iter.bi_sector = sector;
> +
> +		if (nr_sects > max_verify_sectors) {
> +			bio->bi_iter.bi_size = max_verify_sectors << 9;
> +			nr_sects -= max_verify_sectors;
> +			sector += max_verify_sectors;
> +		} else {
> +			bio->bi_iter.bi_size = nr_sects << 9;
> +			nr_sects = 0;
> +		}
> +		cond_resched();
> +	}
> +	*biop = bio;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(__blkdev_issue_verify);
> +
> +/**
> + * blkdev_issue_verify - verify a block range
> + * @bdev:	blockdev to verify
> + * @sector:	start sector
> + * @nr_sects:	number of sectors to verify
> + * @gfp_mask:	memory allocation flags (for bio_alloc)
> + *
> + * Description:
> + *  Verify a block range using hardware offload.
> + */
> +int blkdev_issue_verify(struct block_device *bdev, sector_t sector,
> +		sector_t nr_sects, gfp_t gfp_mask)
> +{
> +	sector_t bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
> +	struct bio *bio = NULL;
> +	struct blk_plug plug;
> +	int ret = 0;
> +
> +	if ((sector | nr_sects) & bs_mask)
> +		return -EINVAL;
> +
> +	blk_start_plug(&plug);
> +	ret = __blkdev_issue_verify(bdev, sector, nr_sects, gfp_mask, &bio);
> +	if (ret == 0 && bio) {
> +		ret = submit_bio_wait(bio);
> +		bio_put(bio);
> +	}
> +	blk_finish_plug(&plug);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(blkdev_issue_verify);
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 7771dacc99cb..8ff305377b5a 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -153,6 +153,20 @@ static struct bio *blk_bio_write_zeroes_split(struct request_queue *q,
>  	return bio_split(bio, q->limits.max_write_zeroes_sectors, GFP_NOIO, bs);
>  }
>  
> +static struct bio *blk_bio_verify_split(struct request_queue *q,
> +		struct bio *bio, struct bio_set *bs, unsigned *nsegs)
> +{
> +	*nsegs = 0;
> +
> +	if (!q->limits.max_verify_sectors)
> +		return NULL;
> +
> +	if (bio_sectors(bio) <= q->limits.max_verify_sectors)
> +		return NULL;
> +
> +	return bio_split(bio, q->limits.max_verify_sectors, GFP_NOIO, bs);
> +}
> +
>  /*
>   * Return the maximum number of sectors from the start of a bio that may be
>   * submitted as a single request to a block device. If enough sectors remain,
> @@ -336,6 +350,10 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
>  		split = blk_bio_write_zeroes_split(q, *bio, &q->bio_split,
>  				nr_segs);
>  		break;
> +	case REQ_OP_VERIFY:
> +		split = blk_bio_verify_split(q, *bio, &q->bio_split,
> +				nr_segs);
> +		break;
>  	default:
>  		split = blk_bio_segment_split(q, *bio, &q->bio_split, nr_segs);
>  		break;
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 6ccceb421ed2..c77697290bc5 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -43,6 +43,7 @@ void blk_set_default_limits(struct queue_limits *lim)
>  	lim->max_dev_sectors = 0;
>  	lim->chunk_sectors = 0;
>  	lim->max_write_zeroes_sectors = 0;
> +	lim->max_verify_sectors = 0;
>  	lim->max_zone_append_sectors = 0;
>  	lim->max_discard_sectors = 0;
>  	lim->max_hw_discard_sectors = 0;
> @@ -80,6 +81,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
>  	lim->max_sectors = UINT_MAX;
>  	lim->max_dev_sectors = UINT_MAX;
>  	lim->max_write_zeroes_sectors = UINT_MAX;
> +	lim->max_verify_sectors = UINT_MAX;
>  	lim->max_zone_append_sectors = UINT_MAX;
>  }
>  EXPORT_SYMBOL(blk_set_stacking_limits);
> @@ -202,6 +204,19 @@ void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
>  }
>  EXPORT_SYMBOL(blk_queue_max_write_zeroes_sectors);
>  
> +/**
> + * blk_queue_max_verify_sectors - set max sectors for a single verify
> + *
> + * @q:  the request queue for the device
> + * @max_verify_sectors: maximum number of sectors to verify per command
> + **/
> +void blk_queue_max_verify_sectors(struct request_queue *q,
> +		unsigned int max_verify_sectors)
> +{
> +	q->limits.max_verify_sectors = max_verify_sectors;
> +}
> +EXPORT_SYMBOL(blk_queue_max_verify_sectors);
> +
>  /**
>   * blk_queue_max_zone_append_sectors - set max sectors for a single zone append
>   * @q:  the request queue for the device
> @@ -554,6 +569,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>  	t->max_dev_sectors = min_not_zero(t->max_dev_sectors, b->max_dev_sectors);
>  	t->max_write_zeroes_sectors = min(t->max_write_zeroes_sectors,
>  					b->max_write_zeroes_sectors);
> +	t->max_verify_sectors = min(t->max_verify_sectors,
> +				    b->max_verify_sectors);
>  	t->max_zone_append_sectors = min(t->max_zone_append_sectors,
>  					b->max_zone_append_sectors);
>  	t->bounce = max(t->bounce, b->bounce);
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 88bd41d4cb59..4fb6a731acad 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -113,6 +113,12 @@ queue_ra_store(struct request_queue *q, const char *page, size_t count)
>  	return ret;
>  }
>  
> +static ssize_t queue_verify_max_show(struct request_queue *q, char *page)
> +{
> +	return sprintf(page, "%llu\n",
> +		(unsigned long long)q->limits.max_verify_sectors << 9);
> +}
> +
>  static ssize_t queue_max_sectors_show(struct request_queue *q, char *page)
>  {
>  	int max_sectors_kb = queue_max_sectors(q) >> 1;
> @@ -588,6 +594,7 @@ QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
>  
>  QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");
>  QUEUE_RO_ENTRY(queue_write_zeroes_max, "write_zeroes_max_bytes");
> +QUEUE_RO_ENTRY(queue_verify_max, "verify_max_bytes");
>  QUEUE_RO_ENTRY(queue_zone_append_max, "zone_append_max_bytes");
>  QUEUE_RO_ENTRY(queue_zone_write_granularity, "zone_write_granularity");
>  
> @@ -644,6 +651,7 @@ static struct attribute *queue_attrs[] = {
>  	&queue_discard_zeroes_data_entry.attr,
>  	&queue_write_same_max_entry.attr,
>  	&queue_write_zeroes_max_entry.attr,
> +	&queue_verify_max_entry.attr,
>  	&queue_zone_append_max_entry.attr,
>  	&queue_zone_write_granularity_entry.attr,
>  	&queue_nonrot_entry.attr,
> diff --git a/block/blk.h b/block/blk.h
> index 434017701403..63a0e3aca7e0 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -132,6 +132,9 @@ static inline bool rq_mergeable(struct request *rq)
>  	if (req_op(rq) == REQ_OP_WRITE_ZEROES)
>  		return false;
>  
> +	if (req_op(rq) == REQ_OP_VERIFY)
> +		return false;
> +
>  	if (req_op(rq) == REQ_OP_ZONE_APPEND)
>  		return false;
>  
> @@ -286,6 +289,7 @@ static inline bool blk_may_split(struct request_queue *q, struct bio *bio)
>  	case REQ_OP_DISCARD:
>  	case REQ_OP_SECURE_ERASE:
>  	case REQ_OP_WRITE_ZEROES:
> +	case REQ_OP_VERIFY:
>  		return true; /* non-trivial splitting decisions */
>  	default:
>  		break;
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 46949f1b0dba..60a48e24b82d 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -192,6 +192,39 @@ static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
>  	return err;
>  }
>  
> +static int blk_ioctl_verify(struct block_device *bdev, fmode_t mode,
> +		unsigned long arg)
> +{
> +	uint64_t range[2];
> +	struct address_space *mapping;
> +	uint64_t start, end, len;
> +
> +	if (!(mode & FMODE_READ))
> +		return -EBADF;
> +
> +	if (copy_from_user(range, (void __user *)arg, sizeof(range)))
> +		return -EFAULT;
> +
> +	start = range[0];
> +	len = range[1];
> +	end = start + len - 1;
> +
> +	if (start & 511)
> +		return -EINVAL;
> +	if (len & 511)
> +		return -EINVAL;
> +	if (end >= (uint64_t)i_size_read(bdev->bd_inode))
> +		return -EINVAL;
> +	if (end < start)
> +		return -EINVAL;
> +
> +	/* Invalidate the page cache, including dirty pages */
> +	mapping = bdev->bd_inode->i_mapping;
> +	truncate_inode_pages_range(mapping, start, end);

You might want to write any dirty pagecache contents to disk before you
invalidate them all...

> +
> +	return blkdev_issue_verify(bdev, start >> 9, len >> 9, GFP_KERNEL);
> +}
> +
>  static int put_ushort(unsigned short __user *argp, unsigned short val)
>  {
>  	return put_user(val, argp);
> @@ -483,6 +516,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
>  		return blk_ioctl_secure_erase(bdev, mode, argp);
>  	case BLKZEROOUT:
>  		return blk_ioctl_zeroout(bdev, mode, arg);
> +	case BLKVERIFY:
> +		return blk_ioctl_verify(bdev, mode, arg);
>  	case BLKGETDISKSEQ:
>  		return put_u64(argp, bdev->bd_disk->diskseq);
>  	case BLKREPORTZONE:
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 1cf3738ef1ea..3dfafe1da098 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -55,7 +55,8 @@ static inline bool bio_has_data(struct bio *bio)
>  	    bio->bi_iter.bi_size &&
>  	    bio_op(bio) != REQ_OP_DISCARD &&
>  	    bio_op(bio) != REQ_OP_SECURE_ERASE &&
> -	    bio_op(bio) != REQ_OP_WRITE_ZEROES)
> +	    bio_op(bio) != REQ_OP_WRITE_ZEROES &&
> +	    bio_op(bio) != REQ_OP_VERIFY)
>  		return true;
>  
>  	return false;
> @@ -65,7 +66,8 @@ static inline bool bio_no_advance_iter(const struct bio *bio)
>  {
>  	return bio_op(bio) == REQ_OP_DISCARD ||
>  	       bio_op(bio) == REQ_OP_SECURE_ERASE ||
> -	       bio_op(bio) == REQ_OP_WRITE_ZEROES;
> +	       bio_op(bio) == REQ_OP_WRITE_ZEROES ||
> +	       bio_op(bio) == REQ_OP_VERIFY;
>  }
>  
>  static inline void *bio_data(struct bio *bio)
> @@ -176,7 +178,7 @@ static inline unsigned bio_segments(struct bio *bio)
>  	struct bvec_iter iter;
>  
>  	/*
> -	 * We special case discard/write same/write zeroes, because they
> +	 * We special case discard/write same/write zeroes/verify, because they
>  	 * interpret bi_size differently:
>  	 */
>  
> @@ -184,6 +186,7 @@ static inline unsigned bio_segments(struct bio *bio)
>  	case REQ_OP_DISCARD:
>  	case REQ_OP_SECURE_ERASE:
>  	case REQ_OP_WRITE_ZEROES:
> +	case REQ_OP_VERIFY:
>  		return 0;
>  	default:
>  		break;
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index a24d4078fb21..0d5383fc84ed 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -363,6 +363,8 @@ enum req_opf {
>  	REQ_OP_FLUSH		= 2,
>  	/* discard sectors */
>  	REQ_OP_DISCARD		= 3,
> +	/* Verify the sectors */
> +	REQ_OP_VERIFY		= 6,
>  	/* securely erase sectors */
>  	REQ_OP_SECURE_ERASE	= 5,
>  	/* write the zero filled sector many times */
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 608d577734c2..78fd6c5530d7 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -266,6 +266,7 @@ struct queue_limits {
>  	unsigned int		max_hw_discard_sectors;
>  	unsigned int		max_secure_erase_sectors;
>  	unsigned int		max_write_zeroes_sectors;
> +	unsigned int		max_verify_sectors;
>  	unsigned int		max_zone_append_sectors;
>  	unsigned int		discard_granularity;
>  	unsigned int		discard_alignment;
> @@ -925,6 +926,9 @@ static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
>  	if (unlikely(op == REQ_OP_WRITE_ZEROES))
>  		return q->limits.max_write_zeroes_sectors;
>  
> +	if (unlikely(op == REQ_OP_VERIFY))
> +		return q->limits.max_verify_sectors;
> +
>  	return q->limits.max_sectors;
>  }
>  
> @@ -968,6 +972,8 @@ extern void blk_queue_max_discard_sectors(struct request_queue *q,
>  		unsigned int max_discard_sectors);
>  extern void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
>  		unsigned int max_write_same_sectors);
> +extern void blk_queue_max_verify_sectors(struct request_queue *q,
> +		unsigned int max_verify_sectors);
>  extern void blk_queue_logical_block_size(struct request_queue *, unsigned int);
>  extern void blk_queue_max_zone_append_sectors(struct request_queue *q,
>  		unsigned int max_zone_append_sectors);
> @@ -1119,6 +1125,12 @@ extern int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
>  extern int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
>  		sector_t nr_sects, gfp_t gfp_mask, unsigned flags);
>  
> +extern int __blkdev_issue_verify(struct block_device *bdev,
> +		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
> +		struct bio **biop);
> +extern int blkdev_issue_verify(struct block_device *bdev, sector_t sector,
> +		sector_t nr_sects, gfp_t gfp_mask);
> +
>  static inline int sb_issue_discard(struct super_block *sb, sector_t block,
>  		sector_t nr_blocks, gfp_t gfp_mask, unsigned long flags)
>  {
> @@ -1293,6 +1305,16 @@ static inline unsigned int bdev_write_zeroes_sectors(struct block_device *bdev)
>  	return 0;
>  }
>  
> +static inline unsigned int bdev_verify_sectors(struct block_device *bdev)
> +{
> +	struct request_queue *q = bdev_get_queue(bdev);
> +
> +	if (q)
> +		return q->limits.max_verify_sectors;
> +
> +	return 0;
> +}
> +
>  static inline bool bdev_nonrot(struct block_device *bdev)
>  {
>  	return blk_queue_nonrot(bdev_get_queue(bdev));
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index bdf7b404b3e7..ad0e5cb5cac4 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -185,6 +185,7 @@ struct fsxattr {
>  #define BLKROTATIONAL _IO(0x12,126)
>  #define BLKZEROOUT _IO(0x12,127)
>  #define BLKGETDISKSEQ _IOR(0x12,128,__u64)
> +#define BLKVERIFY _IO(0x12,129)
>  /*
>   * A jump here: 130-136 are reserved for zoned block devices
>   * (see uapi/linux/blkzoned.h)
> -- 
> 2.29.0
> 
