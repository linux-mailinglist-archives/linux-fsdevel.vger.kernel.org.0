Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E219E2C59BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 18:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403944AbgKZRAp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 12:00:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:34486 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403791AbgKZRAo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:00:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2F0B0ACE0;
        Thu, 26 Nov 2020 17:00:43 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EBEA21E10D0; Thu, 26 Nov 2020 18:00:42 +0100 (CET)
Date:   Thu, 26 Nov 2020 18:00:42 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 33/44] block: move holder_dir to struct block_device
Message-ID: <20201126170042.GS422@quack2.suse.cz>
References: <20201126130422.92945-1-hch@lst.de>
 <20201126130422.92945-34-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126130422.92945-34-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 26-11-20 14:04:11, Christoph Hellwig wrote:
> Move the holder_dir field to struct block_device in preparation for
> kill struct hd_struct.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/genhd.c             |  5 +++--
>  block/partitions/core.c   |  8 ++++----
>  fs/block_dev.c            | 11 +++++------
>  include/linux/blk_types.h |  1 +
>  include/linux/genhd.h     |  1 -
>  5 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index fe202a12eec096..a964e7532fedd5 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -673,7 +673,8 @@ static void register_disk(struct device *parent, struct gendisk *disk,
>  	 */
>  	pm_runtime_set_memalloc_noio(ddev, true);
>  
> -	disk->part0.holder_dir = kobject_create_and_add("holders", &ddev->kobj);
> +	disk->part0.bdev->bd_holder_dir =
> +			kobject_create_and_add("holders", &ddev->kobj);
>  	disk->slave_dir = kobject_create_and_add("slaves", &ddev->kobj);
>  
>  	if (disk->flags & GENHD_FL_HIDDEN) {
> @@ -879,7 +880,7 @@ void del_gendisk(struct gendisk *disk)
>  
>  	blk_unregister_queue(disk);
>  
> -	kobject_put(disk->part0.holder_dir);
> +	kobject_put(disk->part0.bdev->bd_holder_dir);
>  	kobject_put(disk->slave_dir);
>  
>  	part_stat_set_all(&disk->part0, 0);
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index 224a22d82fb86f..d1093adf2570e2 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -344,7 +344,7 @@ void delete_partition(struct hd_struct *part)
>  	 */
>  	get_device(disk_to_dev(disk));
>  	rcu_assign_pointer(ptbl->part[part->partno], NULL);
> -	kobject_put(part->holder_dir);
> +	kobject_put(part->bdev->bd_holder_dir);
>  	device_del(part_to_dev(part));
>  
>  	/*
> @@ -452,8 +452,8 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
>  		goto out_put;
>  
>  	err = -ENOMEM;
> -	p->holder_dir = kobject_create_and_add("holders", &pdev->kobj);
> -	if (!p->holder_dir)
> +	bdev->bd_holder_dir = kobject_create_and_add("holders", &pdev->kobj);
> +	if (!bdev->bd_holder_dir)
>  		goto out_del;
>  
>  	dev_set_uevent_suppress(pdev, 0);
> @@ -487,7 +487,7 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
>  out_remove_file:
>  	device_remove_file(pdev, &dev_attr_whole_disk);
>  out_del:
> -	kobject_put(p->holder_dir);
> +	kobject_put(bdev->bd_holder_dir);
>  	device_del(pdev);
>  out_put:
>  	put_device(pdev);
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 62fae6a0e8aa56..2c91c35149787a 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1138,7 +1138,7 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
>  	WARN_ON_ONCE(!bdev->bd_holder);
>  
>  	/* FIXME: remove the following once add_disk() handles errors */
> -	if (WARN_ON(!disk->slave_dir || !bdev->bd_part->holder_dir))
> +	if (WARN_ON(!disk->slave_dir || !bdev->bd_holder_dir))
>  		goto out_unlock;
>  
>  	holder = bd_find_holder_disk(bdev, disk);
> @@ -1161,14 +1161,14 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
>  	if (ret)
>  		goto out_free;
>  
> -	ret = add_symlink(bdev->bd_part->holder_dir, &disk_to_dev(disk)->kobj);
> +	ret = add_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
>  	if (ret)
>  		goto out_del;
>  	/*
>  	 * bdev could be deleted beneath us which would implicitly destroy
>  	 * the holder directory.  Hold on to it.
>  	 */
> -	kobject_get(bdev->bd_part->holder_dir);
> +	kobject_get(bdev->bd_holder_dir);
>  
>  	list_add(&holder->list, &bdev->bd_holder_disks);
>  	goto out_unlock;
> @@ -1203,9 +1203,8 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
>  
>  	if (!WARN_ON_ONCE(holder == NULL) && !--holder->refcnt) {
>  		del_symlink(disk->slave_dir, bdev_kobj(bdev));
> -		del_symlink(bdev->bd_part->holder_dir,
> -			    &disk_to_dev(disk)->kobj);
> -		kobject_put(bdev->bd_part->holder_dir);
> +		del_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
> +		kobject_put(bdev->bd_holder_dir);
>  		list_del_init(&holder->list);
>  		kfree(holder);
>  	}
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 2f8ede04e5a94c..c0591e52d7d7ce 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -35,6 +35,7 @@ struct block_device {
>  #ifdef CONFIG_SYSFS
>  	struct list_head	bd_holder_disks;
>  #endif
> +	struct kobject		*bd_holder_dir;
>  	u8			bd_partno;
>  	struct hd_struct *	bd_part;
>  	/* number of times partitions within this device have been opened. */
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 30d7076155b4d2..b4a5c05593b99c 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -55,7 +55,6 @@ struct hd_struct {
>  
>  	struct block_device *bdev;
>  	struct device __dev;
> -	struct kobject *holder_dir;
>  	int policy, partno;
>  #ifdef CONFIG_FAIL_MAKE_REQUEST
>  	int make_it_fail;
> -- 
> 2.29.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
