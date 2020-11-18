Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A5C2B7CA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 12:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbgKRL3p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 06:29:45 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54846 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgKRL3o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 06:29:44 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AIBOTeF124696;
        Wed, 18 Nov 2020 11:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=XAeqb6bllarw+ynfEu725flmBK9UHndOzLHtR+CCrkg=;
 b=BkR5ZqFzBvKiLgdBx5ooRE/+11xWOQlRt6ME8DY/lyc3U7xD9erICEb29+/GxtlBWGLJ
 8LTIEml8nphNjWzFgbCI2+FOrGyEgdGirv7xv4mv5o55Y7570yGJk7oqiQM4Il+3IbBf
 gU7myb3YADEebEDG901QmcOpJIBRH0w/hns7n4ooBfue3+G7DAwO3ULk2rM4hwD710He
 vq1CGR2Upv1is2rz4PD31jcTqInFxm7SfWBZvSymV7wDXJg9TCJDFMEl/26mo7HL5Xol
 aPjF2hsWw6k9i6Jxyx9eFRJvSx9ySl5Q95PP+klR6IXT8DkP5NK6UzzoNX5JqC79jE7p kA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 34t4rayq2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Nov 2020 11:29:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AIBPKi5168669;
        Wed, 18 Nov 2020 11:29:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 34umd0fehn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Nov 2020 11:29:29 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AIBTRd0008882;
        Wed, 18 Nov 2020 11:29:27 GMT
Received: from [192.168.1.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Nov 2020 03:29:27 -0800
Subject: Re: [PATCH v10 05/41] btrfs: check and enable ZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <104218b8d66fec2e4121203b90e7673ddac19d6a.1605007036.git.naohiro.aota@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <51c91510-6014-0dee-a456-b50648f48156@oracle.com>
Date:   Wed, 18 Nov 2020 19:29:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <104218b8d66fec2e4121203b90e7673ddac19d6a.1605007036.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011180080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=2 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011180080
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/11/20 7:26 pm, Naohiro Aota wrote:
> This commit introduces the function btrfs_check_zoned_mode() to check if
> ZONED flag is enabled on the file system and if the file system consists of
> zoned devices with equal zone size.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/ctree.h       | 11 ++++++
>   fs/btrfs/dev-replace.c |  7 ++++
>   fs/btrfs/disk-io.c     | 11 ++++++
>   fs/btrfs/super.c       |  1 +
>   fs/btrfs/volumes.c     |  5 +++
>   fs/btrfs/zoned.c       | 81 ++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/zoned.h       | 26 ++++++++++++++
>   7 files changed, 142 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index aac3d6f4e35b..453f41ca024e 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -948,6 +948,12 @@ struct btrfs_fs_info {
>   	/* Type of exclusive operation running */
>   	unsigned long exclusive_operation;
>   
> +	/* Zone size when in ZONED mode */
> +	union {
> +		u64 zone_size;
> +		u64 zoned;
> +	};
> +
>   #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>   	spinlock_t ref_verify_lock;
>   	struct rb_root block_tree;
> @@ -3595,4 +3601,9 @@ static inline int btrfs_is_testing(struct btrfs_fs_info *fs_info)
>   }
>   #endif
>   
> +static inline bool btrfs_is_zoned(struct btrfs_fs_info *fs_info)
> +{
> +	return fs_info->zoned != 0;
> +}
> +
>   #endif
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index 6f6d77224c2b..db87f1aa604b 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -238,6 +238,13 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
>   		return PTR_ERR(bdev);
>   	}
>   
> +	if (!btrfs_check_device_zone_type(fs_info, bdev)) {
> +		btrfs_err(fs_info,
> +			  "dev-replace: zoned type of target device mismatch with filesystem");
> +		ret = -EINVAL;
> +		goto error;
> +	}
> +
>   	sync_blockdev(bdev);
>   
>   	list_for_each_entry(device, &fs_info->fs_devices->devices, dev_list) {

  I am not sure if it is done in some other patch. But we still have to
  check for

  (model == BLK_ZONED_HA && incompat_zoned))

right? What if in a non-zoned FS, a zoned device is added through the
replace. No?


> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 764001609a15..e76ac4da208d 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -42,6 +42,7 @@
>   #include "block-group.h"
>   #include "discard.h"
>   #include "space-info.h"
> +#include "zoned.h"
>   
>   #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
>   				 BTRFS_HEADER_FLAG_RELOC |\
> @@ -2976,6 +2977,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>   	if (features & BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA)
>   		btrfs_info(fs_info, "has skinny extents");
>   
> +	fs_info->zoned = features & BTRFS_FEATURE_INCOMPAT_ZONED;
> +
>   	/*
>   	 * flag our filesystem as having big metadata blocks if
>   	 * they are bigger than the page size
> @@ -3130,7 +3133,15 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>   
>   	btrfs_free_extra_devids(fs_devices, 1);
>   
> +	ret = btrfs_check_zoned_mode(fs_info);
> +	if (ret) {
> +		btrfs_err(fs_info, "failed to inititialize zoned mode: %d",
> +			  ret);
> +		goto fail_block_groups;
> +	}
> +
>   	ret = btrfs_sysfs_add_fsid(fs_devices);
> +
>   	if (ret) {
>   		btrfs_err(fs_info, "failed to init sysfs fsid interface: %d",
>   				ret);
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index ed55014fd1bd..3312fe08168f 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -44,6 +44,7 @@
>   #include "backref.h"
>   #include "space-info.h"
>   #include "sysfs.h"
> +#include "zoned.h"
>   #include "tests/btrfs-tests.h"
>   #include "block-group.h"
>   #include "discard.h"
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index e787bf89f761..10827892c086 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2518,6 +2518,11 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>   	if (IS_ERR(bdev))
>   		return PTR_ERR(bdev);
>   
> +	if (!btrfs_check_device_zone_type(fs_info, bdev)) {
> +		ret = -EINVAL;
> +		goto error;
> +	}
> +
>   	if (fs_devices->seeding) {
>   		seeding_dev = 1;
>   		down_write(&sb->s_umount);


Same here too. It can also happen that a zone device is added to a non 
zoned fs.

Thanks, Anand


> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index b7ffe6670d3a..1223d5b0e411 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -180,3 +180,84 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>   
>   	return 0;
>   }
> +
> +int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
> +	struct btrfs_device *device;
> +	u64 zoned_devices = 0;
> +	u64 nr_devices = 0;
> +	u64 zone_size = 0;
> +	const bool incompat_zoned = btrfs_is_zoned(fs_info);
> +	int ret = 0;
> +
> +	/* Count zoned devices */
> +	list_for_each_entry(device, &fs_devices->devices, dev_list) {
> +		enum blk_zoned_model model;
> +
> +		if (!device->bdev)
> +			continue;
> +
> +		model = bdev_zoned_model(device->bdev);
> +		if (model == BLK_ZONED_HM ||
> +		    (model == BLK_ZONED_HA && incompat_zoned)) {
> +			zoned_devices++;
> +			if (!zone_size) {
> +				zone_size = device->zone_info->zone_size;
> +			} else if (device->zone_info->zone_size != zone_size) {
> +				btrfs_err(fs_info,
> +					  "zoned: unequal block device zone sizes: have %llu found %llu",
> +					  device->zone_info->zone_size,
> +					  zone_size);
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +		}
> +		nr_devices++;
> +	}
> +
> +	if (!zoned_devices && !incompat_zoned)
> +		goto out;
> +
> +	if (!zoned_devices && incompat_zoned) {
> +		/* No zoned block device found on ZONED FS */
> +		btrfs_err(fs_info,
> +			  "zoned: no zoned devices found on a zoned filesystem");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (zoned_devices && !incompat_zoned) {
> +		btrfs_err(fs_info,
> +			  "zoned: mode not enabled but zoned device found");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (zoned_devices != nr_devices) {
> +		btrfs_err(fs_info,
> +			  "zoned: cannot mix zoned and regular devices");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/*
> +	 * stripe_size is always aligned to BTRFS_STRIPE_LEN in
> +	 * __btrfs_alloc_chunk(). Since we want stripe_len == zone_size,
> +	 * check the alignment here.
> +	 */
> +	if (!IS_ALIGNED(zone_size, BTRFS_STRIPE_LEN)) {
> +		btrfs_err(fs_info,
> +			  "zoned: zone size not aligned to stripe %u",
> +			  BTRFS_STRIPE_LEN);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	fs_info->zone_size = zone_size;
> +
> +	btrfs_info(fs_info, "zoned mode enabled with zone size %llu",
> +		   fs_info->zone_size);
> +out:
> +	return ret;
> +}
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index c9e69ff87ab9..bcb1cb99a4f3 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -4,6 +4,7 @@
>   #define BTRFS_ZONED_H
>   
>   #include <linux/types.h>
> +#include <linux/blkdev.h>
>   
>   struct btrfs_zoned_device_info {
>   	/*
> @@ -22,6 +23,7 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>   		       struct blk_zone *zone);
>   int btrfs_get_dev_zone_info(struct btrfs_device *device);
>   void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
> +int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info);
>   #else /* CONFIG_BLK_DEV_ZONED */
>   static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>   				     struct blk_zone *zone)
> @@ -36,6 +38,15 @@ static inline int btrfs_get_dev_zone_info(struct btrfs_device *device)
>   
>   static inline void btrfs_destroy_dev_zone_info(struct btrfs_device *device) { }
>   
> +static inline int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
> +{
> +	if (!btrfs_is_zoned(fs_info))
> +		return 0;
> +
> +	btrfs_err(fs_info, "Zoned block devices support is not enabled");
> +	return -EOPNOTSUPP;
> +}
> +
>   #endif
>   
>   static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
> @@ -88,4 +99,19 @@ static inline void btrfs_dev_clear_zone_empty(struct btrfs_device *device,
>   	btrfs_dev_set_empty_zone_bit(device, pos, false);
>   }
>   
> +static inline bool btrfs_check_device_zone_type(struct btrfs_fs_info *fs_info,
> +						struct block_device *bdev)
> +{
> +	u64 zone_size;
> +
> +	if (btrfs_is_zoned(fs_info)) {
> +		zone_size = (u64)bdev_zone_sectors(bdev) << SECTOR_SHIFT;
> +		/* Do not allow non-zoned device */
> +		return bdev_is_zoned(bdev) && fs_info->zone_size == zone_size;
> +	}
> +
> +	/* Do not allow Host Manged zoned device */
> +	return bdev_zoned_model(bdev) != BLK_ZONED_HM;
> +}
> +
>   #endif
> 

