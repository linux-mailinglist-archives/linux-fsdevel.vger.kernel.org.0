Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 210708FA74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 07:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfHPFql (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 01:46:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37062 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfHPFqk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 01:46:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7G5j2Jt011982;
        Fri, 16 Aug 2019 05:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=DmGydtyDfX/ydHP0RWEoumGUxSxJlW29NrmSrTvdFjw=;
 b=jnILjE1I2JGhjhPfUSrPYzKIb38QAe6uxWcYunNnAvkWBw1nJFzO8vlOcpphIcwpv92P
 +48Uc2lpWdEUbpi7L4zYrS56ZJ0UiLAX+1vRwvIX+xJyKZwZ59ToWqaLVlAwHXDI+wl9
 tsaTgemiVBwdHmT4HhIE3+xH0Ri08nVoqF7bN5+xiuMsSmVzJ8LsOm6HbVoCGbNlnE5I
 l8OiY5NQDCLNJ5u3HZz2qfmKIaygbEC89xVSsifRY64mcqjmZ760AEyhCl0bX5X4Z8z3
 vqrJ4PrDvSI1qIQXtN8J0sFb0T8kdMQ/ShH7ThfjrsnKBy1qqOSUvgnPEqdwcmhyE6uu Nw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2u9nbtxg5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 05:46:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7G5hS1R121069;
        Fri, 16 Aug 2019 05:46:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2udgqfr2c0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 05:46:08 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7G5k79e007090;
        Fri, 16 Aug 2019 05:46:07 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Aug 2019 22:46:06 -0700
Subject: Re: [PATCH v3 03/27] btrfs: Check and enable HMZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
 <20190808093038.4163421-4-naohiro.aota@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <edcb46f5-1c3e-0b69-a2d9-66164e64b07e@oracle.com>
Date:   Fri, 16 Aug 2019 13:46:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808093038.4163421-4-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908160062
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908160062
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/8/19 5:30 PM, Naohiro Aota wrote:
> HMZONED mode cannot be used together with the RAID5/6 profile for now.
> Introduce the function btrfs_check_hmzoned_mode() to check this. This
> function will also check if HMZONED flag is enabled on the file system and
> if the file system consists of zoned devices with equal zone size.
> 
> Additionally, as updates to the space cache are in-place, the space cache
> cannot be located over sequential zones and there is no guarantees that the
> device will have enough conventional zones to store this cache. Resolve
> this problem by disabling completely the space cache.  This does not
> introduces any problems with sequential block groups: all the free space is
> located after the allocation pointer and no free space before the pointer.
> There is no need to have such cache.
> 
> For the same reason, NODATACOW is also disabled.
> 
> Also INODE_MAP_CACHE is also disabled to avoid preallocation in the
> INODE_MAP_CACHE inode.

  A list of incompatibility features with zoned devices. This need better
  documentation, may be a table and its reason is better.


> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/ctree.h       |  3 ++
>   fs/btrfs/dev-replace.c |  8 +++++
>   fs/btrfs/disk-io.c     |  8 +++++
>   fs/btrfs/hmzoned.c     | 67 ++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/hmzoned.h     | 18 ++++++++++++
>   fs/btrfs/super.c       |  1 +
>   fs/btrfs/volumes.c     |  5 ++++
>   7 files changed, 110 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 299e11e6c554..a00ce8c4d678 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -713,6 +713,9 @@ struct btrfs_fs_info {
>   	struct btrfs_root *uuid_root;
>   	struct btrfs_root *free_space_root;
>   
> +	/* Zone size when in HMZONED mode */
> +	u64 zone_size;
> +
>   	/* the log root tree is a directory of all the other log roots */
>   	struct btrfs_root *log_root_tree;
>   
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index 6b2e9aa83ffa..2cc3ac4d101d 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -20,6 +20,7 @@
>   #include "rcu-string.h"
>   #include "dev-replace.h"
>   #include "sysfs.h"
> +#include "hmzoned.h"
>   
>   static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
>   				       int scrub_ret);
> @@ -201,6 +202,13 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
>   		return PTR_ERR(bdev);
>   	}
>   
> +	if (!btrfs_check_device_zone_type(fs_info, bdev)) {
> +		btrfs_err(fs_info,
> +			  "zone type of target device mismatch with the filesystem!");
> +		ret = -EINVAL;
> +		goto error;
> +	}
> +
>   	sync_blockdev(bdev);
>   
>   	devices = &fs_info->fs_devices->devices;
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 5f7ee70b3d1a..8854ff2e5fa5 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -40,6 +40,7 @@
>   #include "compression.h"
>   #include "tree-checker.h"
>   #include "ref-verify.h"
> +#include "hmzoned.h"
>   
>   #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
>   				 BTRFS_HEADER_FLAG_RELOC |\
> @@ -3123,6 +3124,13 @@ int open_ctree(struct super_block *sb,
>   
>   	btrfs_free_extra_devids(fs_devices, 1);
>   
> +	ret = btrfs_check_hmzoned_mode(fs_info);
> +	if (ret) {
> +		btrfs_err(fs_info, "failed to init hmzoned mode: %d",
> +				ret);
> +		goto fail_block_groups;
> +	}
> +
>   	ret = btrfs_sysfs_add_fsid(fs_devices, NULL);
>   	if (ret) {
>   		btrfs_err(fs_info, "failed to init sysfs fsid interface: %d",
> diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
> index bfd04792dd62..512674d8f488 100644
> --- a/fs/btrfs/hmzoned.c
> +++ b/fs/btrfs/hmzoned.c
> @@ -160,3 +160,70 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>   
>   	return 0;
>   }
> +
> +int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
> +	struct btrfs_device *device;
> +	u64 hmzoned_devices = 0;
> +	u64 nr_devices = 0;
> +	u64 zone_size = 0;
> +	int incompat_hmzoned = btrfs_fs_incompat(fs_info, HMZONED);
> +	int ret = 0;
> +
> +	/* Count zoned devices */
> +	list_for_each_entry(device, &fs_devices->devices, dev_list) {
> +		if (!device->bdev)
> +			continue;
> +		if (bdev_zoned_model(device->bdev) == BLK_ZONED_HM ||
> +		    (bdev_zoned_model(device->bdev) == BLK_ZONED_HA &&
> +		     incompat_hmzoned)) {
> +			hmzoned_devices++;
> +			if (!zone_size) {
> +				zone_size = device->zone_info->zone_size;
> +			} else if (device->zone_info->zone_size != zone_size) {
> +				btrfs_err(fs_info,
> +					  "Zoned block devices must have equal zone sizes");
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +		}
> +		nr_devices++;
> +	}
> +
> +	if (!hmzoned_devices && incompat_hmzoned) {
> +		/* No zoned block device found on HMZONED FS */
> +		btrfs_err(fs_info, "HMZONED enabled file system should have zoned devices");
> +		ret = -EINVAL;
> +		goto out;


  When does the HMZONED gets enabled? I presume during mkfs. Where are
  the related btrfs-progs patches? Searching for the related btrfs-progs
  patches doesn't show up anything in the ML. Looks like I am missing
  something, nor the cover letter said anything about the progs part.

Thanks, Anand

> +	}
> +
> +	if (!hmzoned_devices && !incompat_hmzoned)
> +		goto out;
> +
> +	fs_info->zone_size = zone_size;
> +
> +	if (hmzoned_devices != nr_devices) {
> +		btrfs_err(fs_info,
> +			  "zoned devices cannot be mixed with regular devices");
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
> +			  "zone size is not aligned to BTRFS_STRIPE_LEN");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	btrfs_info(fs_info, "HMZONED mode enabled, zone size %llu B",
> +		   fs_info->zone_size);
> +out:
> +	return ret;
> +}
> diff --git a/fs/btrfs/hmzoned.h b/fs/btrfs/hmzoned.h
> index ffc70842135e..29cfdcabff2f 100644
> --- a/fs/btrfs/hmzoned.h
> +++ b/fs/btrfs/hmzoned.h
> @@ -9,6 +9,8 @@
>   #ifndef BTRFS_HMZONED_H
>   #define BTRFS_HMZONED_H
>   
> +#include <linux/blkdev.h>
> +
>   struct btrfs_zoned_device_info {
>   	/*
>   	 * Number of zones, zone size and types of zones if bdev is a
> @@ -25,6 +27,7 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>   		       struct blk_zone *zone, gfp_t gfp_mask);
>   int btrfs_get_dev_zone_info(struct btrfs_device *device);
>   void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
> +int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info);
>   
>   static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
>   {
> @@ -76,4 +79,19 @@ static inline void btrfs_dev_clear_zone_empty(struct btrfs_device *device,
>   	btrfs_dev_set_empty_zone_bit(device, pos, false);
>   }
>   
> +static inline bool btrfs_check_device_zone_type(struct btrfs_fs_info *fs_info,
> +						struct block_device *bdev)
> +{
> +	u64 zone_size;
> +
> +	if (btrfs_fs_incompat(fs_info, HMZONED)) {
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
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 78de9d5d80c6..d7879a5a2536 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -43,6 +43,7 @@
>   #include "free-space-cache.h"
>   #include "backref.h"
>   #include "space-info.h"
> +#include "hmzoned.h"
>   #include "tests/btrfs-tests.h"
>   
>   #include "qgroup.h"
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 8e5a894e7bde..755b2ec1e0de 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2572,6 +2572,11 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
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
> 

