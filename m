Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB066E7E62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 17:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjDSPgR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 11:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbjDSPgO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:36:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01552702;
        Wed, 19 Apr 2023 08:36:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 639C962DE1;
        Wed, 19 Apr 2023 15:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27E8C4339B;
        Wed, 19 Apr 2023 15:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681918571;
        bh=7yO8igzR+tFz5qq3cMgXsjgERkys/bHwVVMy1POC8D8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R205qyx40segdQjwa4sPe2Sc+nS3GNhfuo1ay4/1X0J4Z322M+3fHeBTL6jaSdFX2
         ETO4QuLxyb5hBdJnlWFlaPex12/erWxiYBdBGWM+yTFV+QZ4KobI1UGJUL+Z+KwnJJ
         nr0fKap9u9hI52CoGdIHW4vLsLMbyYEuNABfpDi+tEC/WDIl76XRVEPCWUr/OAYe/e
         R2M4MHlzMOMlEWSuWzlzEPp+1PIBoLuS0QxfQg70/92XM//V4esPiz614G4sVDlvkN
         RNB/KGyoc+9dZp757s6QMjwQIkF+rO8xm1J99YMUUwibyKprR+WQNhDGXyp+P7W6PE
         RXeW+jivhAHjw==
Date:   Wed, 19 Apr 2023 08:36:11 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Theodore Ts'o <tytso@mit.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Daniil Lunev <dlunev@google.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [dm-devel] [PATCH v4 1/4] block: Introduce provisioning
 primitives
Message-ID: <20230419153611.GE360885@frogsfrogsfrogs>
References: <20230414000219.92640-1-sarthakkukreti@chromium.org>
 <20230418221207.244685-1-sarthakkukreti@chromium.org>
 <20230418221207.244685-2-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418221207.244685-2-sarthakkukreti@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 18, 2023 at 03:12:04PM -0700, Sarthak Kukreti wrote:
> Introduce block request REQ_OP_PROVISION. The intent of this request
> is to request underlying storage to preallocate disk space for the given
> block range. Block devices that support this capability will export
> a provision limit within their request queues.
> 
> This patch also adds the capability to call fallocate() in mode 0
> on block devices, which will send REQ_OP_PROVISION to the block
> device for the specified range,
> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
>  block/blk-core.c          |  5 ++++
>  block/blk-lib.c           | 53 +++++++++++++++++++++++++++++++++++++++
>  block/blk-merge.c         | 18 +++++++++++++
>  block/blk-settings.c      | 19 ++++++++++++++
>  block/blk-sysfs.c         |  8 ++++++
>  block/bounce.c            |  1 +
>  block/fops.c              | 25 +++++++++++++-----
>  include/linux/bio.h       |  6 +++--
>  include/linux/blk_types.h |  5 +++-
>  include/linux/blkdev.h    | 16 ++++++++++++
>  10 files changed, 147 insertions(+), 9 deletions(-)
> 

<cut to the fallocate part; the block/ changes look fine to /me/ at
first glance, but what do I know... ;)>

> diff --git a/block/fops.c b/block/fops.c
> index d2e6be4e3d1c..e1775269654a 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -611,9 +611,13 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	return ret;
>  }
>  
> +#define	BLKDEV_FALLOC_FL_TRUNCATE				\

At first I thought from this name that you were defining a new truncate
mode for fallocate, then I realized that this is mask for deciding if we
/want/ to truncate the pagecache.

#define		BLKDEV_FALLOC_TRUNCATE_MASK ?

> +		(FALLOC_FL_PUNCH_HOLE |	FALLOC_FL_ZERO_RANGE |	\

Ok, so discarding and writing zeroes truncates the page cache, makes
sense since we're "writing" directly to the block device.

> +		 FALLOC_FL_NO_HIDE_STALE)

Here things get tricky -- some of the FALLOC_FL mode bits are really an
opcode and cannot be specified together, whereas others select optional
behavior for certain opcodes.

IIRC, the mutually exclusive opcodes are:

	PUNCH_HOLE
	ZERO_RANGE
	COLLAPSE_RANGE
	INSERT_RANGE
	(none of the above, for allocation)

and the "variants on a theme are":

	KEEP_SIZE
	NO_HIDE_STALE
	UNSHARE_RANGE

not all of which are supported by all the opcodes.

Does it make sense to truncate the page cache if userspace passes in
mode == NO_HIDE_STALE?  There's currently no defined meaning for this
combination, but I think this means we'll truncate the pagecache before
deciding if we're actually going to issue any commands.

I think that's just a bug in the existing code -- it should be
validating that @mode is any of the supported combinations *before*
truncating the pagecache.

Otherwise you could have a mkfs program that starts writing new fs
metadata, decides to provision the storage (say for a logging region),
doesn't realize it's running on an old kernel, and then oops the
provision attempt fails but have we now shredded the pagecache and lost
all the writes?

--D

> +
>  #define	BLKDEV_FALLOC_FL_SUPPORTED					\
> -		(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |		\
> -		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE)
> +		(BLKDEV_FALLOC_FL_TRUNCATE | FALLOC_FL_KEEP_SIZE |	\
> +		 FALLOC_FL_UNSHARE_RANGE)
>  
>  static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  			     loff_t len)
> @@ -625,7 +629,7 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  	int error;
>  
>  	/* Fail if we don't recognize the flags. */
> -	if (mode & ~BLKDEV_FALLOC_FL_SUPPORTED)
> +	if (mode != 0 && mode & ~BLKDEV_FALLOC_FL_SUPPORTED)
>  		return -EOPNOTSUPP;
>  
>  	/* Don't go off the end of the device. */
> @@ -649,11 +653,20 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  	filemap_invalidate_lock(inode->i_mapping);
>  
>  	/* Invalidate the page cache, including dirty pages. */
> -	error = truncate_bdev_range(bdev, file->f_mode, start, end);
> -	if (error)
> -		goto fail;
> +	if (mode & BLKDEV_FALLOC_FL_TRUNCATE) {
> +		error = truncate_bdev_range(bdev, file->f_mode, start, end);
> +		if (error)
> +			goto fail;
> +	}
>  
>  	switch (mode) {
> +	case 0:
> +	case FALLOC_FL_UNSHARE_RANGE:
> +	case FALLOC_FL_KEEP_SIZE:
> +	case FALLOC_FL_UNSHARE_RANGE | FALLOC_FL_KEEP_SIZE:
> +		error = blkdev_issue_provision(bdev, start >> SECTOR_SHIFT,
> +					       len >> SECTOR_SHIFT, GFP_KERNEL);
> +		break;
>  	case FALLOC_FL_ZERO_RANGE:
>  	case FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE:
>  		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index d766be7152e1..9820b3b039f2 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -57,7 +57,8 @@ static inline bool bio_has_data(struct bio *bio)
>  	    bio->bi_iter.bi_size &&
>  	    bio_op(bio) != REQ_OP_DISCARD &&
>  	    bio_op(bio) != REQ_OP_SECURE_ERASE &&
> -	    bio_op(bio) != REQ_OP_WRITE_ZEROES)
> +	    bio_op(bio) != REQ_OP_WRITE_ZEROES &&
> +	    bio_op(bio) != REQ_OP_PROVISION)
>  		return true;
>  
>  	return false;
> @@ -67,7 +68,8 @@ static inline bool bio_no_advance_iter(const struct bio *bio)
>  {
>  	return bio_op(bio) == REQ_OP_DISCARD ||
>  	       bio_op(bio) == REQ_OP_SECURE_ERASE ||
> -	       bio_op(bio) == REQ_OP_WRITE_ZEROES;
> +	       bio_op(bio) == REQ_OP_WRITE_ZEROES ||
> +	       bio_op(bio) == REQ_OP_PROVISION;
>  }
>  
>  static inline void *bio_data(struct bio *bio)
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 99be590f952f..27bdf88f541c 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -385,7 +385,10 @@ enum req_op {
>  	REQ_OP_DRV_IN		= (__force blk_opf_t)34,
>  	REQ_OP_DRV_OUT		= (__force blk_opf_t)35,
>  
> -	REQ_OP_LAST		= (__force blk_opf_t)36,
> +	/* request device to provision block */
> +	REQ_OP_PROVISION        = (__force blk_opf_t)37,
> +
> +	REQ_OP_LAST		= (__force blk_opf_t)38,
>  };
>  
>  enum req_flag_bits {
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 941304f17492..239e2f418b6e 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -303,6 +303,7 @@ struct queue_limits {
>  	unsigned int		discard_granularity;
>  	unsigned int		discard_alignment;
>  	unsigned int		zone_write_granularity;
> +	unsigned int		max_provision_sectors;
>  
>  	unsigned short		max_segments;
>  	unsigned short		max_integrity_segments;
> @@ -921,6 +922,8 @@ extern void blk_queue_max_discard_sectors(struct request_queue *q,
>  		unsigned int max_discard_sectors);
>  extern void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
>  		unsigned int max_write_same_sectors);
> +extern void blk_queue_max_provision_sectors(struct request_queue *q,
> +		unsigned int max_provision_sectors);
>  extern void blk_queue_logical_block_size(struct request_queue *, unsigned int);
>  extern void blk_queue_max_zone_append_sectors(struct request_queue *q,
>  		unsigned int max_zone_append_sectors);
> @@ -1060,6 +1063,9 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>  int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
>  		sector_t nr_sects, gfp_t gfp);
>  
> +extern int blkdev_issue_provision(struct block_device *bdev, sector_t sector,
> +		sector_t nr_sects, gfp_t gfp_mask);
> +
>  #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
>  #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
>  
> @@ -1139,6 +1145,11 @@ static inline unsigned short queue_max_discard_segments(const struct request_que
>  	return q->limits.max_discard_segments;
>  }
>  
> +static inline unsigned short queue_max_provision_sectors(const struct request_queue *q)
> +{
> +	return q->limits.max_provision_sectors;
> +}
> +
>  static inline unsigned int queue_max_segment_size(const struct request_queue *q)
>  {
>  	return q->limits.max_segment_size;
> @@ -1281,6 +1292,11 @@ static inline bool bdev_nowait(struct block_device *bdev)
>  	return test_bit(QUEUE_FLAG_NOWAIT, &bdev_get_queue(bdev)->queue_flags);
>  }
>  
> +static inline unsigned int bdev_max_provision_sectors(struct block_device *bdev)
> +{
> +	return bdev_get_queue(bdev)->limits.max_provision_sectors;
> +}
> +
>  static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
>  {
>  	return blk_queue_zoned_model(bdev_get_queue(bdev));
> -- 
> 2.40.0.634.g4ca3ef3211-goog
> 
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://listman.redhat.com/mailman/listinfo/dm-devel
> 
