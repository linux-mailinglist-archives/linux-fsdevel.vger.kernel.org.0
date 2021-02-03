Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D9130D113
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 02:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhBCBwI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 20:52:08 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:41807 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231547AbhBCBwC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 20:52:02 -0500
X-IronPort-AV: E=Sophos;i="5.79,396,1602518400"; 
   d="scan'208";a="104124130"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Feb 2021 09:51:42 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id C1F3D4CE6D74;
        Wed,  3 Feb 2021 09:51:38 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Feb
 2021 09:51:39 +0800
Subject: Re: [PATCH RESEND v2 08/10] md: Implement ->corrupted_range()
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <dm-devel@redhat.com>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <agk@redhat.com>,
        <snitzer@redhat.com>, <rgoldwyn@suse.de>, <qi.fuli@fujitsu.com>,
        <y-goto@fujitsu.com>
References: <20210129062757.1594130-1-ruansy.fnst@cn.fujitsu.com>
 <20210129062757.1594130-9-ruansy.fnst@cn.fujitsu.com>
 <20210202031711.GJ7193@magnolia>
From:   Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <8742625e-8ae7-47a8-fd62-18c201c45a33@cn.fujitsu.com>
Date:   Wed, 3 Feb 2021 09:51:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210202031711.GJ7193@magnolia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: C1F3D4CE6D74.A03BC
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/2/2 上午11:17, Darrick J. Wong wrote:
> On Fri, Jan 29, 2021 at 02:27:55PM +0800, Shiyang Ruan wrote:
>> With the support of ->rmap(), it is possible to obtain the superblock on
>> a mapped device.
>>
>> If a pmem device is used as one target of mapped device, we cannot
>> obtain its superblock directly.  With the help of SYSFS, the mapped
>> device can be found on the target devices.  So, we iterate the
>> bdev->bd_holder_disks to obtain its mapped device.
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
>> ---
>>   drivers/md/dm.c       | 61 +++++++++++++++++++++++++++++++++++++++++++
>>   drivers/nvdimm/pmem.c | 11 +++-----
>>   fs/block_dev.c        | 42 ++++++++++++++++++++++++++++-
> 
> I feel like this ^^^ part that implements the generic ability for a block
> device with a bad sector to notify whatever's holding onto it (fs, other
> block device) should be in patch 2.  That's generic block layer code,
> and it's hard to tell (when you're looking at patch 2) what the bare
> function declaration in it is really supposed to do.
> 
> Also, this patch is still difficult to review because it mixes device
> mapper, nvdimm, and block layer changes!

OK.  I'll split this to make it looks simple.

> 
>>   include/linux/genhd.h |  2 ++
>>   4 files changed, 107 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
>> index 7bac564f3faa..31b0c340b695 100644
>> --- a/drivers/md/dm.c
>> +++ b/drivers/md/dm.c
>> @@ -507,6 +507,66 @@ static int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
>>   #define dm_blk_report_zones		NULL
>>   #endif /* CONFIG_BLK_DEV_ZONED */
>>   
>> +struct corrupted_hit_info {
>> +	struct block_device *bdev;
>> +	sector_t offset;
>> +};
>> +
>> +static int dm_blk_corrupted_hit(struct dm_target *ti, struct dm_dev *dev,
>> +				sector_t start, sector_t count, void *data)
>> +{
>> +	struct corrupted_hit_info *bc = data;
>> +
>> +	return bc->bdev == (void *)dev->bdev &&
>> +			(start <= bc->offset && bc->offset < start + count);
>> +
>> +}
>> +
>> +struct corrupted_do_info {
>> +	size_t length;
>> +	void *data;
>> +};
>> +
>> +static int dm_blk_corrupted_do(struct dm_target *ti, struct block_device *bdev,
>> +			       sector_t disk_sect, void *data)
>> +{
>> +	struct corrupted_do_info *bc = data;
>> +	loff_t disk_off = to_bytes(disk_sect);
>> +	loff_t bdev_off = to_bytes(disk_sect - get_start_sect(bdev));
>> +
>> +	return bd_corrupted_range(bdev, disk_off, bdev_off, bc->length, bc->data);
>> +}
>> +
>> +static int dm_blk_corrupted_range(struct gendisk *disk,
>> +				  struct block_device *target_bdev,
>> +				  loff_t target_offset, size_t len, void *data)
>> +{
>> +	struct mapped_device *md = disk->private_data;
>> +	struct dm_table *map;
>> +	struct dm_target *ti;
>> +	sector_t target_sect = to_sector(target_offset);
>> +	struct corrupted_hit_info hi = {target_bdev, target_sect};
>> +	struct corrupted_do_info di = {len, data};
>> +	int srcu_idx, i, rc = -ENODEV;
>> +
>> +	map = dm_get_live_table(md, &srcu_idx);
>> +	if (!map)
>> +		return rc;
>> +
>> +	for (i = 0; i < dm_table_get_num_targets(map); i++) {
>> +		ti = dm_table_get_target(map, i);
>> +		if (!(ti->type->iterate_devices && ti->type->rmap))
>> +			continue;
>> +		if (!ti->type->iterate_devices(ti, dm_blk_corrupted_hit, &hi))
>> +			continue;
>> +
>> +		rc = ti->type->rmap(ti, target_sect, dm_blk_corrupted_do, &di);
> 
> Why is it necessary to call ->iterate_devices here?

->iterate_devices() here is to find out which target is the pmem device 
which is corrupted now.  Then call ->rmap() on this target.  Other 
targets will be ignored.

> 
> If you pass the target_bdev, offset, and length to the dm-target's
> ->rmap function, it should be able to work backwards through its mapping
> logic to come up with all the LBA ranges of the mapped_device that
> are affected, and then it can call bd_corrupted_range on each of those
> reverse mappings.
> 
> It would be helpful to have the changes to dm-linear.c in this patch
> too, since that's the only real implementation at this point.
> 
>> +		break;
>> +	}
>> +
>> +	dm_put_live_table(md, srcu_idx);
>> +	return rc;
>> +}
>> +
>>   static int dm_prepare_ioctl(struct mapped_device *md, int *srcu_idx,
>>   			    struct block_device **bdev)
>>   {
>> @@ -3062,6 +3122,7 @@ static const struct block_device_operations dm_blk_dops = {
>>   	.getgeo = dm_blk_getgeo,
>>   	.report_zones = dm_blk_report_zones,
>>   	.pr_ops = &dm_pr_ops,
>> +	.corrupted_range = dm_blk_corrupted_range,
>>   	.owner = THIS_MODULE
>>   };
>>   
>> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
>> index 501959947d48..3d9f4ccbbd9e 100644
>> --- a/drivers/nvdimm/pmem.c
>> +++ b/drivers/nvdimm/pmem.c
>> @@ -256,21 +256,16 @@ static int pmem_rw_page(struct block_device *bdev, sector_t sector,
>>   static int pmem_corrupted_range(struct gendisk *disk, struct block_device *bdev,
>>   				loff_t disk_offset, size_t len, void *data)
>>   {
>> -	struct super_block *sb;
>>   	loff_t bdev_offset;
>>   	sector_t disk_sector = disk_offset >> SECTOR_SHIFT;
>> -	int rc = 0;
>> +	int rc = -ENODEV;
>>   
>>   	bdev = bdget_disk_sector(disk, disk_sector);
>>   	if (!bdev)
>> -		return -ENODEV;
>> +		return rc;
>>   
>>   	bdev_offset = (disk_sector - get_start_sect(bdev)) << SECTOR_SHIFT;
>> -	sb = get_super(bdev);
>> -	if (sb && sb->s_op->corrupted_range) {
>> -		rc = sb->s_op->corrupted_range(sb, bdev, bdev_offset, len, data);
>> -		drop_super(sb);
>> -	}
>> +	rc = bd_corrupted_range(bdev, bdev_offset, bdev_offset, len, data);
>>   
>>   	bdput(bdev);
>>   	return rc;
>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>> index 3b8963e228a1..3cc2b2911e3a 100644
>> --- a/fs/block_dev.c
>> +++ b/fs/block_dev.c
>> @@ -1079,6 +1079,27 @@ struct bd_holder_disk {
>>   	int			refcnt;
>>   };
>>   
>> +static int bd_disk_holder_corrupted_range(struct block_device *bdev, loff_t off,
>> +					  size_t len, void *data)
>> +{
>> +	struct bd_holder_disk *holder;
>> +	struct gendisk *disk;
>> +	int rc = 0;
>> +
>> +	if (list_empty(&(bdev->bd_holder_disks)))
>> +		return -ENODEV;
>> +
>> +	list_for_each_entry(holder, &bdev->bd_holder_disks, list) {
>> +		disk = holder->disk;
>> +		if (disk->fops->corrupted_range) {
>> +			rc = disk->fops->corrupted_range(disk, bdev, off, len, data);
>> +			if (rc != -ENODEV)
>> +				break;
>> +		}
>> +	}
>> +	return rc;
>> +}
>> +
>>   static struct bd_holder_disk *bd_find_holder_disk(struct block_device *bdev,
>>   						  struct gendisk *disk)
>>   {
>> @@ -1212,7 +1233,26 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
>>   	mutex_unlock(&bdev->bd_mutex);
>>   }
>>   EXPORT_SYMBOL_GPL(bd_unlink_disk_holder);
>> -#endif
>> +#endif /* CONFIG_SYSFS */
>> +
>> +int bd_corrupted_range(struct block_device *bdev, loff_t disk_off,
>> +		       loff_t bdev_off, size_t len, void *data)
>> +{
>> +	struct super_block *sb = get_super(bdev);
>> +	int rc = -EOPNOTSUPP;
>> +
>> +	if (!sb) {
>> +#ifdef CONFIG_SYSFS
>> +		rc = bd_disk_holder_corrupted_range(bdev, disk_off, len, data);
>> +#endif /* CONFIG_SYSFS */
> 
> Normal kernel convention is that you'd provide a empty shell for the
> CONFIG_SYSFS=n case, e.g.
> 
> #ifdef CONFIG_SYSFS
> int bd_corrupted_range(...) {
> 	/* real code */
> }
> #else
> static inline bd_corrupted_range(...) { return -EOPNOTSUPP; }
> #endif
> 
> so that you don't have preprocessor directives making this function
> choppy.

I'll fix it.


--
Thanks,
Ruan Shiyang.

> 
> --D
> 
>> +		return rc;
>> +	} else if (sb->s_op->corrupted_range)
>> +		rc = sb->s_op->corrupted_range(sb, bdev, bdev_off, len, data);
>> +	drop_super(sb);
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL(bd_corrupted_range);
>>   
>>   static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
>>   
>> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
>> index 4da480798955..996f91b08d48 100644
>> --- a/include/linux/genhd.h
>> +++ b/include/linux/genhd.h
>> @@ -315,6 +315,8 @@ void unregister_blkdev(unsigned int major, const char *name);
>>   bool bdev_check_media_change(struct block_device *bdev);
>>   int __invalidate_device(struct block_device *bdev, bool kill_dirty);
>>   void set_capacity(struct gendisk *disk, sector_t size);
>> +int bd_corrupted_range(struct block_device *bdev, loff_t disk_off,
>> +		       loff_t bdev_off, size_t len, void *data);
>>   
>>   /* for drivers/char/raw.c: */
>>   int blkdev_ioctl(struct block_device *, fmode_t, unsigned, unsigned long);
>> -- 
>> 2.30.0
>>
>>
>>
> 
> 


