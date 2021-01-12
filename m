Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C312F2F62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 13:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388295AbhALMvQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 07:51:16 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:20199 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388277AbhALMvO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 07:51:14 -0500
X-IronPort-AV: E=Sophos;i="5.79,341,1602518400"; 
   d="scan'208";a="103404320"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 12 Jan 2021 20:45:45 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 713454CE602E;
        Tue, 12 Jan 2021 20:45:40 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 12 Jan
 2021 20:45:40 +0800
Subject: Re: [PATCH 08/10] md: Implement ->corrupted_range()
To:     Jan Kara <jack@suse.cz>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <song@kernel.org>,
        <rgoldwyn@suse.de>, <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>
References: <20201230165601.845024-1-ruansy.fnst@cn.fujitsu.com>
 <20201230165601.845024-9-ruansy.fnst@cn.fujitsu.com>
 <20210106171429.GE29271@quack2.suse.cz>
From:   Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <fdabf9b7-33ef-db52-2697-8452a47518b7@cn.fujitsu.com>
Date:   Tue, 12 Jan 2021 20:45:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210106171429.GE29271@quack2.suse.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 713454CE602E.AB184
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/1/7 上午1:14, Jan Kara wrote:
> On Thu 31-12-20 00:55:59, Shiyang Ruan wrote:
>> With the support of ->rmap(), it is possible to obtain the superblock on
>> a mapped device.
>>
>> If a pmem device is used as one target of mapped device, we cannot
>> obtain its superblock directly.  With the help of SYSFS, the mapped
>> device can be found on the target devices.  So, we iterate the
>> bdev->bd_holder_disks to obtain its mapped device.
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
> 
> Thanks for the patch. Two comments below.
> 
>> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
>> index 4688bff19c20..9f9a2f3bf73b 100644
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
> 
> This (and the fs/block_dev.c change below) is just refining the function
> you've implemented in the patch 6. I think it's confusing to split changes
> like this - why not implement things correctly from the start in patch 6?

This change added a helper function to find the md devices created on a 
low-level block device, such as a LVM on /dev/pmem0, and calls 
->corrupted_range() for each md device.  The md parts were introduced 
starts from patch 7.  So, I add this change in this patch.

> 
>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>> index 9e84b1928b94..0e50f0e8e8af 100644
>> --- a/fs/block_dev.c
>> +++ b/fs/block_dev.c
>> @@ -1171,6 +1171,27 @@ struct bd_holder_disk {
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
> 
> This will not compile for !CONFIG_SYSFS kernels. Not that it would be
> common but still. Also I'm not sure whether using bd_holder_disks like this
> is really the right thing to do (when it seems to be only a sysfs thing),
> although admittedly I'm not aware of a better way of getting this
> information.

I did a lot of tries and finally found this way.  I think I should add a 
judgement that whether CONFIG_SYSFS is turned on.


--
Thanks,
Ruan Shiyang.

> 
> 								Honza
> 
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
>> @@ -1378,6 +1399,22 @@ void bd_set_nr_sectors(struct block_device *bdev, sector_t sectors)
>>   }
>>   EXPORT_SYMBOL(bd_set_nr_sectors);
>>   
>> +int bd_corrupted_range(struct block_device *bdev, loff_t disk_off, loff_t bdev_off, size_t len, void *data)
>> +{
>> +	struct super_block *sb = get_super(bdev);
>> +	int rc = 0;
>> +
>> +	if (!sb) {
>> +		rc = bd_disk_holder_corrupted_range(bdev, disk_off, len, data);
>> +		return rc;
>> +	} else if (sb->s_op->corrupted_range)
>> +		rc = sb->s_op->corrupted_range(sb, bdev, bdev_off, len, data);
>> +	drop_super(sb);
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL(bd_corrupted_range);
>> +
>>   static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
>>   
>>   int bdev_disk_changed(struct block_device *bdev, bool invalidate)
>> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
>> index ed06209008b8..42290470810d 100644
>> --- a/include/linux/genhd.h
>> +++ b/include/linux/genhd.h
>> @@ -376,6 +376,8 @@ void revalidate_disk_size(struct gendisk *disk, bool verbose);
>>   bool bdev_check_media_change(struct block_device *bdev);
>>   int __invalidate_device(struct block_device *bdev, bool kill_dirty);
>>   void bd_set_nr_sectors(struct block_device *bdev, sector_t sectors);
>> +int bd_corrupted_range(struct block_device *bdev, loff_t disk_off,
>> +		       loff_t bdev_off, size_t len, void *data);
>>   
>>   /* for drivers/char/raw.c: */
>>   int blkdev_ioctl(struct block_device *, fmode_t, unsigned, unsigned long);
>> -- 
>> 2.29.2
>>
>>
>>


