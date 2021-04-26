Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B135636B5C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 17:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbhDZP2Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 11:28:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58095 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233674AbhDZP2Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 11:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619450854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oYm6s7pNYd6O8onb5kD82cZdiZxfOGydPD7lvHhTzpY=;
        b=TX8Vdx3Vz4La1b/dVCBxYzyNNMGphE08Fm4bCdkmhbX2HEnioILX1pL8doMaNN0yh3rwLp
        wLl//suMWLDmczLBeBX6YNrSYPfSL1Hhj+3HhMyJKg7GROneSkosawArG9og2JsqGbTKXO
        lPz10rZInXGA0Su4ZFZANixcyL2MfIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-ZYv6uZpdNPGR1bAuH4txUQ-1; Mon, 26 Apr 2021 11:27:30 -0400
X-MC-Unique: ZYv6uZpdNPGR1bAuH4txUQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 744216D4F9;
        Mon, 26 Apr 2021 15:27:29 +0000 (UTC)
Received: from T590 (ovpn-12-94.pek2.redhat.com [10.72.12.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 42E28687DA;
        Mon, 26 Apr 2021 15:27:21 +0000 (UTC)
Date:   Mon, 26 Apr 2021 23:27:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/12] block: switch polling to be bio based
Message-ID: <YIbb4BFg/j36HlgD@T590>
References: <20210426134821.2191160-1-hch@lst.de>
 <20210426134821.2191160-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426134821.2191160-13-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 26, 2021 at 03:48:21PM +0200, Christoph Hellwig wrote:
> Replace the blk_poll interface that requires the caller to keep a queue
> and cookie from the submissions with polling based on the bio.
> 
> Polling for the bio itself leads to a few advantages:
> 
>  - the cookie construction can made entirely private in blk-mq.c
>  - the caller does not need to remember the request_queue and cookie
>    separately and thus sidesteps their lifetime issues
>  - keeping the device and the cookie inside the bio allows to trivially
>    support polling BIOs remapping by stacking drivers
>  - a lot of code to propagate the cookie back up the submission path can
>    be removed entirely.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/m68k/emu/nfblock.c             |   3 +-
>  arch/xtensa/platforms/iss/simdisk.c |   3 +-
>  block/bio.c                         |   1 +
>  block/blk-core.c                    | 103 +++++++++++++++++++---------
>  block/blk-mq.c                      |  75 +++++++-------------
>  block/blk-mq.h                      |   2 +
>  drivers/block/brd.c                 |  12 ++--
>  drivers/block/drbd/drbd_int.h       |   2 +-
>  drivers/block/drbd/drbd_req.c       |   3 +-
>  drivers/block/n64cart.c             |  12 ++--
>  drivers/block/null_blk/main.c       |   3 +-
>  drivers/block/pktcdvd.c             |   7 +-
>  drivers/block/ps3vram.c             |   6 +-
>  drivers/block/rsxx/dev.c            |   7 +-
>  drivers/block/umem.c                |   4 +-
>  drivers/block/zram/zram_drv.c       |  10 +--
>  drivers/lightnvm/pblk-init.c        |   6 +-
>  drivers/md/bcache/request.c         |  13 ++--
>  drivers/md/bcache/request.h         |   4 +-
>  drivers/md/dm.c                     |  28 +++-----
>  drivers/md/md.c                     |  10 ++-
>  drivers/nvdimm/blk.c                |   5 +-
>  drivers/nvdimm/btt.c                |   5 +-
>  drivers/nvdimm/pmem.c               |   3 +-
>  drivers/nvme/host/core.c            |   2 +-
>  drivers/nvme/host/multipath.c       |   6 +-
>  drivers/nvme/host/nvme.h            |   2 +-
>  drivers/s390/block/dcssblk.c        |   7 +-
>  drivers/s390/block/xpram.c          |   5 +-
>  fs/block_dev.c                      |  25 +++----
>  fs/btrfs/inode.c                    |   8 +--
>  fs/ext4/file.c                      |   2 +-
>  fs/gfs2/file.c                      |   4 +-
>  fs/iomap/direct-io.c                |  39 ++++-------
>  fs/xfs/xfs_file.c                   |   2 +-
>  fs/zonefs/super.c                   |   2 +-
>  include/linux/bio.h                 |   2 +-
>  include/linux/blk-mq.h              |  15 +---
>  include/linux/blk_types.h           |  12 ++--
>  include/linux/blkdev.h              |   8 ++-
>  include/linux/fs.h                  |   6 +-
>  include/linux/iomap.h               |   3 +-
>  mm/page_io.c                        |   8 +--
>  43 files changed, 208 insertions(+), 277 deletions(-)
> 
> diff --git a/arch/m68k/emu/nfblock.c b/arch/m68k/emu/nfblock.c
> index ba808543161a..dd36808f0d5e 100644
> --- a/arch/m68k/emu/nfblock.c
> +++ b/arch/m68k/emu/nfblock.c
> @@ -59,7 +59,7 @@ struct nfhd_device {
>  	struct gendisk *disk;
>  };
>  
> -static blk_qc_t nfhd_submit_bio(struct bio *bio)
> +static void nfhd_submit_bio(struct bio *bio)
>  {
>  	struct nfhd_device *dev = bio->bi_bdev->bd_disk->private_data;
>  	struct bio_vec bvec;
> @@ -77,7 +77,6 @@ static blk_qc_t nfhd_submit_bio(struct bio *bio)
>  		sec += len;
>  	}
>  	bio_endio(bio);
> -	return BLK_QC_T_NONE;
>  }
>  
>  static int nfhd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
> diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
> index fc09be7b1347..182825d639e2 100644
> --- a/arch/xtensa/platforms/iss/simdisk.c
> +++ b/arch/xtensa/platforms/iss/simdisk.c
> @@ -101,7 +101,7 @@ static void simdisk_transfer(struct simdisk *dev, unsigned long sector,
>  	spin_unlock(&dev->lock);
>  }
>  
> -static blk_qc_t simdisk_submit_bio(struct bio *bio)
> +static void simdisk_submit_bio(struct bio *bio)
>  {
>  	struct simdisk *dev = bio->bi_bdev->bd_disk->private_data;
>  	struct bio_vec bvec;
> @@ -119,7 +119,6 @@ static blk_qc_t simdisk_submit_bio(struct bio *bio)
>  	}
>  
>  	bio_endio(bio);
> -	return BLK_QC_T_NONE;
>  }
>  
>  static int simdisk_open(struct block_device *bdev, fmode_t mode)
> diff --git a/block/bio.c b/block/bio.c
> index 7296abe293de..484b6d786857 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -259,6 +259,7 @@ void bio_init(struct bio *bio, struct bio_vec *table,
>  	memset(bio, 0, sizeof(*bio));
>  	atomic_set(&bio->__bi_remaining, 1);
>  	atomic_set(&bio->__bi_cnt, 1);
> +	bio->bi_cookie = BLK_QC_T_NONE;
>  
>  	bio->bi_io_vec = table;
>  	bio->bi_max_vecs = max_vecs;
> diff --git a/block/blk-core.c b/block/blk-core.c
> index adfab5976be0..77fdb00fcad3 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -910,18 +910,18 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
>  	return false;
>  }
>  
> -static blk_qc_t __submit_bio(struct bio *bio)
> +static void __submit_bio(struct bio *bio)
>  {
>  	struct gendisk *disk = bio->bi_bdev->bd_disk;
> -	blk_qc_t ret = BLK_QC_T_NONE;
>  
>  	if (blk_crypto_bio_prep(&bio)) {
> -		if (!disk->fops->submit_bio)
> -			return blk_mq_submit_bio(bio);
> -		ret = disk->fops->submit_bio(bio);
> +		if (!disk->fops->submit_bio) {
> +			blk_mq_submit_bio(bio);
> +			return;
> +		}
> +		disk->fops->submit_bio(bio);
>  	}
>  	blk_queue_exit(disk->queue);
> -	return ret;
>  }
>  
>  /*
> @@ -943,10 +943,9 @@ static blk_qc_t __submit_bio(struct bio *bio)
>   * bio_list_on_stack[1] contains bios that were submitted before the current
>   *	->submit_bio_bio, but that haven't been processed yet.
>   */
> -static blk_qc_t __submit_bio_noacct(struct bio *bio)
> +static void __submit_bio_noacct(struct bio *bio)
>  {
>  	struct bio_list bio_list_on_stack[2];
> -	blk_qc_t ret = BLK_QC_T_NONE;
>  
>  	BUG_ON(bio->bi_next);
>  
> @@ -966,7 +965,7 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
>  		bio_list_on_stack[1] = bio_list_on_stack[0];
>  		bio_list_init(&bio_list_on_stack[0]);
>  
> -		ret = __submit_bio(bio);
> +		__submit_bio(bio);
>  
>  		/*
>  		 * Sort new bios into those for a lower level and those for the
> @@ -989,13 +988,11 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
>  	} while ((bio = bio_list_pop(&bio_list_on_stack[0])));
>  
>  	current->bio_list = NULL;
> -	return ret;
>  }
>  
> -static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
> +static void __submit_bio_noacct_mq(struct bio *bio)
>  {
>  	struct bio_list bio_list[2] = { };
> -	blk_qc_t ret = BLK_QC_T_NONE;
>  
>  	current->bio_list = bio_list;
>  
> @@ -1007,15 +1004,13 @@ static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
>  
>  		if (!blk_crypto_bio_prep(&bio)) {
>  			blk_queue_exit(disk->queue);
> -			ret = BLK_QC_T_NONE;
>  			continue;
>  		}
>  
> -		ret = blk_mq_submit_bio(bio);
> +		blk_mq_submit_bio(bio);
>  	} while ((bio = bio_list_pop(&bio_list[0])));
>  
>  	current->bio_list = NULL;
> -	return ret;
>  }
>  
>  /**
> @@ -1027,10 +1022,10 @@ static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
>   * systems and other upper level users of the block layer should use
>   * submit_bio() instead.
>   */
> -blk_qc_t submit_bio_noacct(struct bio *bio)
> +void submit_bio_noacct(struct bio *bio)
>  {
>  	if (!submit_bio_checks(bio))
> -		return BLK_QC_T_NONE;
> +		return;
>  
>  	/*
>  	 * We only want one ->submit_bio to be active at a time, else stack
> @@ -1038,14 +1033,12 @@ blk_qc_t submit_bio_noacct(struct bio *bio)
>  	 * to collect a list of requests submited by a ->submit_bio method while
>  	 * it is active, and then process them after it returned.
>  	 */
> -	if (current->bio_list) {
> +	if (current->bio_list)
>  		bio_list_add(&current->bio_list[0], bio);
> -		return BLK_QC_T_NONE;
> -	}
> -
> -	if (!bio->bi_bdev->bd_disk->fops->submit_bio)
> -		return __submit_bio_noacct_mq(bio);
> -	return __submit_bio_noacct(bio);
> +	else if (!bio->bi_bdev->bd_disk->fops->submit_bio)
> +		__submit_bio_noacct_mq(bio);
> +	else
> +		__submit_bio_noacct(bio);
>  }
>  EXPORT_SYMBOL(submit_bio_noacct);
>  
> @@ -1062,10 +1055,10 @@ EXPORT_SYMBOL(submit_bio_noacct);
>   * in @bio.  The bio must NOT be touched by thecaller until ->bi_end_io() has
>   * been called.
>   */
> -blk_qc_t submit_bio(struct bio *bio)
> +void submit_bio(struct bio *bio)
>  {
>  	if (blkcg_punt_bio_submit(bio))
> -		return BLK_QC_T_NONE;
> +		return;
>  
>  	/*
>  	 * If it's a regular read/write or a barrier with data attached,
> @@ -1106,19 +1099,67 @@ blk_qc_t submit_bio(struct bio *bio)
>  	if (unlikely(bio_op(bio) == REQ_OP_READ &&
>  	    bio_flagged(bio, BIO_WORKINGSET))) {
>  		unsigned long pflags;
> -		blk_qc_t ret;
>  
>  		psi_memstall_enter(&pflags);
> -		ret = submit_bio_noacct(bio);
> +		submit_bio_noacct(bio);
>  		psi_memstall_leave(&pflags);
> -
> -		return ret;
> +		return;
>  	}
>  
> -	return submit_bio_noacct(bio);
> +	submit_bio_noacct(bio);
>  }
>  EXPORT_SYMBOL(submit_bio);
>  
> +/**
> + * bio_poll - poll for BIO completions
> + * @bio: bio to poll for
> + *
> + * Poll for completions on queue associated with the bio. Returns number of
> + * completed entries found. If @spin is true, then bio_poll will continue
> + * looping until at least one completion is found, unless the task is
> + * otherwise marked running (or we need to reschedule).
> + *
> + * Note: the caller must either be the context that submitted @bio, or
> + * be in a RCU critical section to prevent freeing of @bio.
> + */
> +int bio_poll(struct bio *bio, bool spin)
> +{
> +	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
> +	blk_qc_t cookie = READ_ONCE(bio->bi_cookie);
> +
> +	if (cookie == BLK_QC_T_NONE ||
> +	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
> +		return 0;
> +
> +	if (current->plug)
> +		blk_flush_plug_list(current->plug, false);
> +
> +	/* not yet implemented, so this should not happen */
> +	if (WARN_ON_ONCE(!queue_is_mq(q)))
> +		return 0;
> +	return blk_mq_poll(q, cookie, spin);
> +}
> +EXPORT_SYMBOL_GPL(bio_poll);
> +
> +/*
> + * Helper to implements file_operations.iopoll.  Requires the bio to be stored
> + * in iocb->private, and cleared before freeing the bio.
> + */
> +int iocb_bio_iopoll(struct kiocb *kiocb, bool spin)
> +{
> +	struct bio *bio;
> +	int ret = 0;
> +
> +	rcu_read_lock();
> +	bio = READ_ONCE(kiocb->private);
> +	if (bio)
> +		ret = bio_poll(bio, spin);
> +	rcu_read_unlock();

If bio_poll() sleeps in case of 'spin', rcu_read_lock() can't be used.
And the POLLED bio may be ended by iocb_bio_iopoll() explicitly via
one bio flag.

Thanks,
Ming

