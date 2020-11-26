Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4772C5B00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 18:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404524AbgKZRq4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 12:46:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:52718 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404191AbgKZRq4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:46:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7386EAC48;
        Thu, 26 Nov 2020 17:46:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3D0481E10D0; Thu, 26 Nov 2020 18:46:54 +0100 (CET)
Date:   Thu, 26 Nov 2020 18:46:54 +0100
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
Subject: Re: [PATCH 38/44] block: remove the partno field from struct
 hd_struct
Message-ID: <20201126174654.GX422@quack2.suse.cz>
References: <20201126130422.92945-1-hch@lst.de>
 <20201126130422.92945-39-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126130422.92945-39-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 26-11-20 14:04:16, Christoph Hellwig wrote:
> Just use the bd_partno field in struct block_device everywhere.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/genhd.c           | 12 ++++++------
>  block/partitions/core.c |  9 ++++-----
>  include/linux/genhd.h   |  1 -
>  init/do_mounts.c        |  2 +-
>  4 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 282fde159bd125..a85ffd7385718d 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -578,8 +578,8 @@ int blk_alloc_devt(struct hd_struct *part, dev_t *devt)
>  	int idx;
>  
>  	/* in consecutive minor range? */
> -	if (part->partno < disk->minors) {
> -		*devt = MKDEV(disk->major, disk->first_minor + part->partno);
> +	if (part->bdev->bd_partno < disk->minors) {
> +		*devt = MKDEV(disk->major, disk->first_minor + part->bdev->bd_partno);
>  		return 0;
>  	}
>  
> @@ -853,7 +853,7 @@ void del_gendisk(struct gendisk *disk)
>  	disk_part_iter_init(&piter, disk,
>  			     DISK_PITER_INCL_EMPTY | DISK_PITER_REVERSE);
>  	while ((part = disk_part_iter_next(&piter))) {
> -		invalidate_partition(disk, part->partno);
> +		invalidate_partition(disk, part->bdev->bd_partno);
>  		delete_partition(part);
>  	}
>  	disk_part_iter_exit(&piter);
> @@ -997,7 +997,7 @@ void __init printk_all_partitions(void)
>  			printk("%s%s %10llu %s %s", is_part0 ? "" : "  ",
>  			       bdevt_str(part_devt(part), devt_buf),
>  			       bdev_nr_sectors(part->bdev) >> 1,
> -			       disk_name(disk, part->partno, name_buf),
> +			       disk_name(disk, part->bdev->bd_partno, name_buf),
>  			       part->bdev->bd_meta_info ?
>  					part->bdev->bd_meta_info->uuid : "");
>  			if (is_part0) {
> @@ -1091,7 +1091,7 @@ static int show_partition(struct seq_file *seqf, void *v)
>  		seq_printf(seqf, "%4d  %7d %10llu %s\n",
>  			   MAJOR(part_devt(part)), MINOR(part_devt(part)),
>  			   bdev_nr_sectors(part->bdev) >> 1,
> -			   disk_name(sgp, part->partno, buf));
> +			   disk_name(sgp, part->bdev->bd_partno, buf));
>  	disk_part_iter_exit(&piter);
>  
>  	return 0;
> @@ -1514,7 +1514,7 @@ static int diskstats_show(struct seq_file *seqf, void *v)
>  			   "%lu %u"
>  			   "\n",
>  			   MAJOR(part_devt(hd)), MINOR(part_devt(hd)),
> -			   disk_name(gp, hd->partno, buf),
> +			   disk_name(gp, hd->bdev->bd_partno, buf),
>  			   stat.ios[STAT_READ],
>  			   stat.merges[STAT_READ],
>  			   stat.sectors[STAT_READ],
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index aba750825aa0d0..ecc3228a086956 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -184,7 +184,7 @@ static ssize_t part_partition_show(struct device *dev,
>  {
>  	struct hd_struct *p = dev_to_part(dev);
>  
> -	return sprintf(buf, "%d\n", p->partno);
> +	return sprintf(buf, "%d\n", p->bdev->bd_partno);
>  }
>  
>  static ssize_t part_start_show(struct device *dev,
> @@ -274,7 +274,7 @@ static int part_uevent(struct device *dev, struct kobj_uevent_env *env)
>  {
>  	struct hd_struct *part = dev_to_part(dev);
>  
> -	add_uevent_var(env, "PARTN=%u", part->partno);
> +	add_uevent_var(env, "PARTN=%u", part->bdev->bd_partno);
>  	if (part->bdev->bd_meta_info && part->bdev->bd_meta_info->volname[0])
>  		add_uevent_var(env, "PARTNAME=%s",
>  			       part->bdev->bd_meta_info->volname);
> @@ -298,7 +298,7 @@ void delete_partition(struct hd_struct *part)
>  	struct disk_part_tbl *ptbl =
>  		rcu_dereference_protected(disk->part_tbl, 1);
>  
> -	rcu_assign_pointer(ptbl->part[part->partno], NULL);
> +	rcu_assign_pointer(ptbl->part[part->bdev->bd_partno], NULL);
>  	rcu_assign_pointer(ptbl->last_lookup, NULL);
>  
>  	kobject_put(part->bdev->bd_holder_dir);
> @@ -372,7 +372,6 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
>  
>  	bdev->bd_start_sect = start;
>  	bdev_set_nr_sectors(bdev, len);
> -	p->partno = partno;
>  	bdev->bd_read_only = get_disk_ro(disk);
>  
>  	if (info) {
> @@ -445,7 +444,7 @@ static bool partition_overlaps(struct gendisk *disk, sector_t start,
>  
>  	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY);
>  	while ((part = disk_part_iter_next(&piter))) {
> -		if (part->partno == skip_partno ||
> +		if (part->bdev->bd_partno == skip_partno ||
>  		    start >= part->bdev->bd_start_sect +
>  			bdev_nr_sectors(part->bdev) ||
>  		    start + length <= part->bdev->bd_start_sect)
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index fe6fee77e2b9df..3c13d4708e3f9d 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -54,7 +54,6 @@ struct partition_meta_info {
>  struct hd_struct {
>  	struct block_device *bdev;
>  	struct device __dev;
> -	int partno;
>  };
>  
>  /**
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index 368ccb71850126..86bef93e72ebd6 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -136,7 +136,7 @@ static dev_t devt_from_partuuid(const char *uuid_str)
>  		struct hd_struct *part;
>  
>  		part = disk_get_part(dev_to_disk(dev),
> -				     dev_to_part(dev)->partno + offset);
> +				     dev_to_part(dev)->bdev->bd_partno + offset);
>  		if (part) {
>  			devt = part_devt(part);
>  			put_device(part_to_dev(part));
> -- 
> 2.29.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
