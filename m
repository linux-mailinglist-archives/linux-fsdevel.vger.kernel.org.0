Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48E726D7C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 11:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgIQJgU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 05:36:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:46578 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgIQJgT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 05:36:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ED480B13B;
        Thu, 17 Sep 2020 09:36:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E128D1E12E1; Thu, 17 Sep 2020 11:36:14 +0200 (CEST)
Date:   Thu, 17 Sep 2020 11:36:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 08/12] bdi: remove BDI_CAP_SYNCHRONOUS_IO
Message-ID: <20200917093614.GF7347@quack2.suse.cz>
References: <20200910144833.742260-1-hch@lst.de>
 <20200910144833.742260-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910144833.742260-9-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 10-09-20 16:48:28, Christoph Hellwig wrote:
> BDI_CAP_SYNCHRONOUS_IO is only checked in the swap code, and used to
> decided if ->rw_page can be used on a block device.  Just check up for
> the method instead.  The only complication is that zram needs a second
> set of block_device_operations as it can switch between modes that
> actually support ->rw_page and those who don't.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/brd.c           |  1 -
>  drivers/block/zram/zram_drv.c | 19 +++++++++++++------
>  drivers/nvdimm/btt.c          |  2 --
>  drivers/nvdimm/pmem.c         |  1 -
>  include/linux/backing-dev.h   |  9 ---------
>  mm/swapfile.c                 |  2 +-
>  6 files changed, 14 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index 2723a70eb85593..cc49a921339f77 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -403,7 +403,6 @@ static struct brd_device *brd_alloc(int i)
>  	disk->flags		= GENHD_FL_EXT_DEVT;
>  	sprintf(disk->disk_name, "ram%d", i);
>  	set_capacity(disk, rd_size * 2);
> -	brd->brd_queue->backing_dev_info->capabilities |= BDI_CAP_SYNCHRONOUS_IO;
>  
>  	/* Tell the block layer that this is not a rotational device */
>  	blk_queue_flag_set(QUEUE_FLAG_NONROT, brd->brd_queue);
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index a356275605b104..1b51bb664f91f5 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -52,6 +52,9 @@ static unsigned int num_devices = 1;
>   */
>  static size_t huge_class_size;
>  
> +static const struct block_device_operations zram_devops;
> +static const struct block_device_operations zram_wb_devops;
> +
>  static void zram_free_page(struct zram *zram, size_t index);
>  static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
>  				u32 index, int offset, struct bio *bio);
> @@ -408,8 +411,7 @@ static void reset_bdev(struct zram *zram)
>  	zram->backing_dev = NULL;
>  	zram->old_block_size = 0;
>  	zram->bdev = NULL;
> -	zram->disk->queue->backing_dev_info->capabilities |=
> -				BDI_CAP_SYNCHRONOUS_IO;
> +	zram->disk->fops = &zram_devops;
>  	kvfree(zram->bitmap);
>  	zram->bitmap = NULL;
>  }
> @@ -528,8 +530,7 @@ static ssize_t backing_dev_store(struct device *dev,
>  	 * freely but in fact, IO is going on so finally could cause
>  	 * use-after-free when the IO is really done.
>  	 */
> -	zram->disk->queue->backing_dev_info->capabilities &=
> -			~BDI_CAP_SYNCHRONOUS_IO;
> +	zram->disk->fops = &zram_wb_devops;
>  	up_write(&zram->init_lock);
>  
>  	pr_info("setup backing device %s\n", file_name);
> @@ -1819,6 +1820,13 @@ static const struct block_device_operations zram_devops = {
>  	.owner = THIS_MODULE
>  };
>  
> +static const struct block_device_operations zram_wb_devops = {
> +	.open = zram_open,
> +	.submit_bio = zram_submit_bio,
> +	.swap_slot_free_notify = zram_slot_free_notify,
> +	.owner = THIS_MODULE
> +};
> +
>  static DEVICE_ATTR_WO(compact);
>  static DEVICE_ATTR_RW(disksize);
>  static DEVICE_ATTR_RO(initstate);
> @@ -1946,8 +1954,7 @@ static int zram_add(void)
>  	if (ZRAM_LOGICAL_BLOCK_SIZE == PAGE_SIZE)
>  		blk_queue_max_write_zeroes_sectors(zram->disk->queue, UINT_MAX);
>  
> -	zram->disk->queue->backing_dev_info->capabilities |=
> -			(BDI_CAP_STABLE_WRITES | BDI_CAP_SYNCHRONOUS_IO);
> +	zram->disk->queue->backing_dev_info->capabilities |= BDI_CAP_STABLE_WRITES;
>  	device_add_disk(NULL, zram->disk, zram_disk_attr_groups);
>  
>  	strlcpy(zram->compressor, default_compressor, sizeof(zram->compressor));
> diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
> index 0d710140bf93be..12ff6f8784ac11 100644
> --- a/drivers/nvdimm/btt.c
> +++ b/drivers/nvdimm/btt.c
> @@ -1537,8 +1537,6 @@ static int btt_blk_init(struct btt *btt)
>  	btt->btt_disk->private_data = btt;
>  	btt->btt_disk->queue = btt->btt_queue;
>  	btt->btt_disk->flags = GENHD_FL_EXT_DEVT;
> -	btt->btt_disk->queue->backing_dev_info->capabilities |=
> -			BDI_CAP_SYNCHRONOUS_IO;
>  
>  	blk_queue_logical_block_size(btt->btt_queue, btt->sector_size);
>  	blk_queue_max_hw_sectors(btt->btt_queue, UINT_MAX);
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 140cf3b9000c60..1711fdfd8d2816 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -475,7 +475,6 @@ static int pmem_attach_disk(struct device *dev,
>  	disk->queue		= q;
>  	disk->flags		= GENHD_FL_EXT_DEVT;
>  	disk->private_data	= pmem;
> -	disk->queue->backing_dev_info->capabilities |= BDI_CAP_SYNCHRONOUS_IO;
>  	nvdimm_namespace_disk_name(ndns, disk->disk_name);
>  	set_capacity(disk, (pmem->size - pmem->pfn_pad - pmem->data_offset)
>  			/ 512);
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index 52583b6f2ea05d..860ea33571bce5 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -122,9 +122,6 @@ int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_ratio);
>   * BDI_CAP_NO_WRITEBACK:   Don't write pages back
>   * BDI_CAP_NO_ACCT_WB:     Don't automatically account writeback pages
>   * BDI_CAP_STRICTLIMIT:    Keep number of dirty pages below bdi threshold.
> - *
> - * BDI_CAP_SYNCHRONOUS_IO: Device is so fast that asynchronous IO would be
> - *			   inefficient.
>   */
>  #define BDI_CAP_NO_ACCT_DIRTY	0x00000001
>  #define BDI_CAP_NO_WRITEBACK	0x00000002
> @@ -132,7 +129,6 @@ int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_ratio);
>  #define BDI_CAP_STABLE_WRITES	0x00000008
>  #define BDI_CAP_STRICTLIMIT	0x00000010
>  #define BDI_CAP_CGROUP_WRITEBACK 0x00000020
> -#define BDI_CAP_SYNCHRONOUS_IO	0x00000040
>  
>  #define BDI_CAP_NO_ACCT_AND_WRITEBACK \
>  	(BDI_CAP_NO_WRITEBACK | BDI_CAP_NO_ACCT_DIRTY | BDI_CAP_NO_ACCT_WB)
> @@ -174,11 +170,6 @@ static inline int wb_congested(struct bdi_writeback *wb, int cong_bits)
>  long congestion_wait(int sync, long timeout);
>  long wait_iff_congested(int sync, long timeout);
>  
> -static inline bool bdi_cap_synchronous_io(struct backing_dev_info *bdi)
> -{
> -	return bdi->capabilities & BDI_CAP_SYNCHRONOUS_IO;
> -}
> -
>  static inline bool bdi_cap_stable_pages_required(struct backing_dev_info *bdi)
>  {
>  	return bdi->capabilities & BDI_CAP_STABLE_WRITES;
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 12f59e641b5e29..986fe5aad30e18 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3237,7 +3237,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  	if (bdi_cap_stable_pages_required(inode_to_bdi(inode)))
>  		p->flags |= SWP_STABLE_WRITES;
>  
> -	if (bdi_cap_synchronous_io(inode_to_bdi(inode)))
> +	if (p->bdev && p->bdev->bd_disk->fops->rw_page)
>  		p->flags |= SWP_SYNCHRONOUS_IO;
>  
>  	if (p->bdev && blk_queue_nonrot(bdev_get_queue(p->bdev))) {
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
