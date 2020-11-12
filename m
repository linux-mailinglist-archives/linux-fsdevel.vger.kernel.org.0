Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFEF2AFFF6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 08:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgKLHAO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 02:00:14 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57422 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgKLHAN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 02:00:13 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AC6xv2f009607;
        Thu, 12 Nov 2020 06:59:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=25kIuoOZqrrZ+0n/oN52xLR6OQst+UhOFRXLWGDY7a4=;
 b=quICPlViqYC1FuHsGaDUgH+z4Q3nR0HK3OxZ+WdKnK6307D77FUjSJNCDESMGwXoJj+u
 zowYH4He05a6M8FcPsjkAyG3H7FyR4TAbuMm9TWSEwjV5bEkSBwwH9Gc77uMXoT99pf+
 mymVBKMdQIZ1200FQ7yBq4ozO8pJKt2TrkwaNBIRDIuhGWZB6MNDmqYYdi8Lmhw/RyAz
 Lq3AX6mHBcwjyGoEsky5tZodHPLnzYPXaOjd7xoa3RBWeqCIATuL7BjESvCRoVy3yFcs
 z+9TADfIsVkRbQ2dYv2q3NyjNAiY5UUwbHAsJ5UfiqiBPUJJUKBVcyTQxuOucJQr6rS0 6w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 34nkhm3r2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 06:59:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AC6uDpk037709;
        Thu, 12 Nov 2020 06:57:56 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 34rtkr9cgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Nov 2020 06:57:56 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AC6vnk8018449;
        Thu, 12 Nov 2020 06:57:52 GMT
Received: from [192.168.1.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Nov 2020 22:57:49 -0800
Subject: Re: [PATCH v10 04/41] btrfs: get zone information of zoned block
 devices
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <cf46f0aef5a214cae8bacb2be231efed5febef5f.1605007036.git.naohiro.aota@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <6df7390f-6656-4795-ac54-a99fdaf67ac6@oracle.com>
Date:   Thu, 12 Nov 2020 14:57:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <cf46f0aef5a214cae8bacb2be231efed5febef5f.1605007036.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9802 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=2 bulkscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011120040
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9802 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=2 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1011 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011120040
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 8840a4fa81eb..ed55014fd1bd 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2462,6 +2462,11 @@ static void __init btrfs_print_mod_info(void)
>   #endif
>   #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>   			", ref-verify=on"
> +#endif
> +#ifdef CONFIG_BLK_DEV_ZONED
> +			", zoned=yes"
> +#else
> +			", zoned=no"
>   #endif

IMO, we don't need this, as most of the generic kernel will be compiled
with the CONFIG_BLK_DEV_ZONED defined.
For review purpose we may want to know if the mounted device
is a zoned device. So log of zone device and its type may be useful
when we have verified the zoned devices in the open_ctree().

> @@ -374,6 +375,7 @@ void btrfs_free_device(struct btrfs_device *device)
>   	rcu_string_free(device->name);
>   	extent_io_tree_release(&device->alloc_state);
>   	bio_put(device->flush_bio);

> +	btrfs_destroy_dev_zone_info(device);

Free of btrfs_device::zone_info is already happening in the path..

  btrfs_close_one_device()
    btrfs_destroy_dev_zone_info()

  We don't need this..

  btrfs_free_device()
   btrfs_destroy_dev_zone_info()


> @@ -2543,6 +2551,14 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>   	}
>   	rcu_assign_pointer(device->name, name);
>   
> +	device->fs_info = fs_info;
> +	device->bdev = bdev;
> +
> +	/* Get zone type information of zoned block devices */
> +	ret = btrfs_get_dev_zone_info(device);
> +	if (ret)
> +		goto error_free_device;
> +
>   	trans = btrfs_start_transaction(root, 0);
>   	if (IS_ERR(trans)) {
>   		ret = PTR_ERR(trans);

It should be something like goto error_free_zone from here.


> @@ -2707,6 +2721,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>   		sb->s_flags |= SB_RDONLY;
>   	if (trans)
>   		btrfs_end_transaction(trans);


error_free_zone:
> +	btrfs_destroy_dev_zone_info(device);
>   error_free_device:
>   	btrfs_free_device(device);
>   error:

  As mentioned we don't need btrfs_destroy_dev_zone_info()
  again in  btrfs_free_device(). Otherwise we end up calling
  btrfs_destroy_dev_zone_info twice here.


Thanks, Anand
