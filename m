Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCF72B8EAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 10:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgKSJXo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 04:23:44 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:41430 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgKSJXo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 04:23:44 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AJ9Ax9M014267;
        Thu, 19 Nov 2020 09:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=nvlAUIuiVJQZ8lvFjwG7Oeg2QqJ/OhI2eruXzkgyQ3w=;
 b=l6PCytaVUmQ5nS7iIo69TYAlbTYcGhYJwE0ZcsS6+E8Q5sjxfFbQBhzyz7uIqqK8xhWs
 /wY08XqujA7Bk85lonIgb0/8qavSQCoHC2zSjrFXoD97LldOX4/gdOhK0js8ERD66NRv
 GdpZmZTWFn9NPgTwyfDZYDLVqrI9hpTIyii0mckWwMcbEAo0v3Hxb0NXg9N/iMg2hqmR
 xZJsX6cGJZVKikOnlnP0aqymDvRkQp/1n6KT4oykkcrOEw9siU0MsXCEJKGtMk7aGWdV
 EFQrHWocgxCITBtfmZir67W9VXCUgx82Kh/+dcPFJgAgTNfXkWmAf9Pwdh1uBS5mn4l5 9w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34t76m4avk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Nov 2020 09:23:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AJ99M26081674;
        Thu, 19 Nov 2020 09:23:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 34umd1qcdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Nov 2020 09:23:28 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AJ9NPod007547;
        Thu, 19 Nov 2020 09:23:26 GMT
Received: from [192.168.1.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Nov 2020 01:23:24 -0800
Subject: Re: [PATCH v10 06/41] btrfs: introduce max_zone_append_size
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <173cd5def63acdf094a3b83ce129696c26fd3a3c.1605007036.git.naohiro.aota@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <a6c5cdf0-a880-9c92-cc3d-db0736185489@oracle.com>
Date:   Thu, 19 Nov 2020 17:23:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <173cd5def63acdf094a3b83ce129696c26fd3a3c.1605007036.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9809 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011190068
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9809 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011190068
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/11/20 7:26 pm, Naohiro Aota wrote:
> The zone append write command has a maximum IO size restriction it
> accepts. This is because a zone append write command cannot be split, as
> we ask the device to place the data into a specific target zone and the
> device responds with the actual written location of the data.
> 
> Introduce max_zone_append_size to zone_info and fs_info to track the
> value, so we can limit all I/O to a zoned block device that we want to
> write using the zone append command to the device's limits.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---

Looks good except for - what happens when we replace or add a new zone
device with a different queue_max_zone_append_sectors(queue) value. ?

Nit: IMHO some parts of patch-4, 5 and 6 could have been in one
patch. Now it's fine as they are already at v10 and have rb.

Thanks, Anand


>   fs/btrfs/ctree.h |  3 +++
>   fs/btrfs/zoned.c | 17 +++++++++++++++--
>   fs/btrfs/zoned.h |  1 +
>   3 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 453f41ca024e..c70d3fcc62c2 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -954,6 +954,9 @@ struct btrfs_fs_info {
>   		u64 zoned;
>   	};
>   
> +	/* Max size to emit ZONE_APPEND write command */
> +	u64 max_zone_append_size;
> +
>   #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>   	spinlock_t ref_verify_lock;
>   	struct rb_root block_tree;
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 1223d5b0e411..2897432eb43c 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -48,6 +48,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
>   {
>   	struct btrfs_zoned_device_info *zone_info = NULL;
>   	struct block_device *bdev = device->bdev;
> +	struct request_queue *queue = bdev_get_queue(bdev);
>   	sector_t nr_sectors = bdev->bd_part->nr_sects;
>   	sector_t sector = 0;
>   	struct blk_zone *zones = NULL;
> @@ -69,6 +70,8 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
>   	ASSERT(is_power_of_2(zone_sectors));
>   	zone_info->zone_size = (u64)zone_sectors << SECTOR_SHIFT;
>   	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
> +	zone_info->max_zone_append_size =
> +		(u64)queue_max_zone_append_sectors(queue) << SECTOR_SHIFT;
>   	zone_info->nr_zones = nr_sectors >> ilog2(bdev_zone_sectors(bdev));
>   	if (!IS_ALIGNED(nr_sectors, zone_sectors))
>   		zone_info->nr_zones++;
> @@ -188,6 +191,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
>   	u64 zoned_devices = 0;
>   	u64 nr_devices = 0;
>   	u64 zone_size = 0;
> +	u64 max_zone_append_size = 0;
>   	const bool incompat_zoned = btrfs_is_zoned(fs_info);
>   	int ret = 0;
>   
> @@ -201,10 +205,13 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
>   		model = bdev_zoned_model(device->bdev);
>   		if (model == BLK_ZONED_HM ||
>   		    (model == BLK_ZONED_HA && incompat_zoned)) {
> +			struct btrfs_zoned_device_info *zone_info =
> +				device->zone_info;
> +
>   			zoned_devices++;
>   			if (!zone_size) {
> -				zone_size = device->zone_info->zone_size;
> -			} else if (device->zone_info->zone_size != zone_size) {
> +				zone_size = zone_info->zone_size;
> +			} else if (zone_info->zone_size != zone_size) {
>   				btrfs_err(fs_info,
>   					  "zoned: unequal block device zone sizes: have %llu found %llu",
>   					  device->zone_info->zone_size,
> @@ -212,6 +219,11 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
>   				ret = -EINVAL;
>   				goto out;
>   			}
> +			if (!max_zone_append_size ||
> +			    (zone_info->max_zone_append_size &&
> +			     zone_info->max_zone_append_size < max_zone_append_size))
> +				max_zone_append_size =
> +					zone_info->max_zone_append_size;
>   		}
>   		nr_devices++;
>   	}
> @@ -255,6 +267,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
>   	}
>   
>   	fs_info->zone_size = zone_size;
> +	fs_info->max_zone_append_size = max_zone_append_size;
>   
>   	btrfs_info(fs_info, "zoned mode enabled with zone size %llu",
>   		   fs_info->zone_size);
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index bcb1cb99a4f3..52aa6af5d8dc 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -13,6 +13,7 @@ struct btrfs_zoned_device_info {
>   	 */
>   	u64 zone_size;
>   	u8  zone_size_shift;
> +	u64 max_zone_append_size;
>   	u32 nr_zones;
>   	unsigned long *seq_zones;
>   	unsigned long *empty_zones;
> 

