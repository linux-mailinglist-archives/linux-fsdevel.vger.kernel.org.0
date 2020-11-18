Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177752B7C4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 12:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgKRLUH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 06:20:07 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47262 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgKRLUH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 06:20:07 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AIBDoPB168790;
        Wed, 18 Nov 2020 11:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=wNg6w4sEm7cVX/eob0utM9SLizao3fVQpAEsOaZmiVM=;
 b=UR5zw+Ois3v37wZnKiuZDOn/fjsH9QPBG1B1gvYMpREzwcgBTtn3R+fQGcVoBFlH5z4j
 q39K3xBRMLPCQbRGKDVSOgbJTuVixNI4cS1A0FmHQ+b3Kjju5mxCr+PUJLRnAHHcxlk8
 Y4qTJ0MB0nz+x9IjZ3RslXR3OpYX7QZ5prFf2sHB1zsrVA801fSDQYh6njm3Fi1e0MdG
 BWHdNLYketnZpoSgdSA38I5jJn3UrhGmKHRAudBkNoSgUSN4ohZfykot0ru4hOtUHf2n
 mOonb2tXdObsA/1aLYFoVQeQZc+sXk7Y/VOaOQQLZKvGXNZIFlCSXAEJhox7fIq/u7R1 iQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 34t7vn7g97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Nov 2020 11:19:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AIBEZha138948;
        Wed, 18 Nov 2020 11:17:55 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 34ts5xcvyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Nov 2020 11:17:55 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AIBHrM9022428;
        Wed, 18 Nov 2020 11:17:54 GMT
Received: from [192.168.1.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Nov 2020 03:17:53 -0800
Subject: Re: [PATCH v10 04/41] btrfs: get zone information of zoned block
 devices
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <cf46f0aef5a214cae8bacb2be231efed5febef5f.1605007036.git.naohiro.aota@wdc.com>
 <6df7390f-6656-4795-ac54-a99fdaf67ac6@oracle.com>
 <20201112125734.dcxk5q7cuf5e7hje@naota.dhcp.fujisawa.hgst.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <f75372bf-9dad-1397-21f2-7bfb53c9a94f@oracle.com>
Date:   Wed, 18 Nov 2020 19:17:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201112125734.dcxk5q7cuf5e7hje@naota.dhcp.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=2 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011180079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=2
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011180079
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Also, %device->fs_info is not protected. It is better to avoid using
fs_info when we are still at open_fs_devices(). Yeah, the unknown part
can be better. We need to fix it as a whole. For now, you can use
something like...

-------------------------
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 1223d5b0e411..e857bb304d28 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -130,19 +130,11 @@ int btrfs_get_dev_zone_info(struct btrfs_device 
*device)
          * (device <unknown>) ..."
          */

-       rcu_read_lock();
-       if (device->fs_info)
-               btrfs_info(device->fs_info,
-                       "host-%s zoned block device %s, %u zones of %llu 
bytes",
-                       bdev_zoned_model(bdev) == BLK_ZONED_HM ? 
"managed" : "aware",
-                       rcu_str_deref(device->name), zone_info->nr_zones,
-                       zone_info->zone_size);
-       else
-               pr_info("BTRFS info: host-%s zoned block device %s, %u 
zones of %llu bytes",
-                       bdev_zoned_model(bdev) == BLK_ZONED_HM ? 
"managed" : "aware",
-                       rcu_str_deref(device->name), zone_info->nr_zones,
-                       zone_info->zone_size);
-       rcu_read_unlock();
+       btrfs_info_in_rcu(NULL,
+               "host-%s zoned block device %s, %u zones of %llu bytes",
+               bdev_zoned_model(bdev) == BLK_ZONED_HM ? "managed" : 
"aware",
+               rcu_str_deref(device->name), zone_info->nr_zones,
+               zone_info->zone_size);

         return 0;
  ---------------------------

Thanks, Anand


On 12/11/20 8:57 pm, Naohiro Aota wrote:
> On Thu, Nov 12, 2020 at 02:57:42PM +0800, Anand Jain wrote:
>>
>>
>>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>>> index 8840a4fa81eb..ed55014fd1bd 100644
>>> --- a/fs/btrfs/super.c
>>> +++ b/fs/btrfs/super.c
>>> @@ -2462,6 +2462,11 @@ static void __init btrfs_print_mod_info(void)
>>>  #endif
>>>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>>>              ", ref-verify=on"
>>> +#endif
>>> +#ifdef CONFIG_BLK_DEV_ZONED
>>> +            ", zoned=yes"
>>> +#else
>>> +            ", zoned=no"
>>>  #endif
>>
>> IMO, we don't need this, as most of the generic kernel will be compiled
>> with the CONFIG_BLK_DEV_ZONED defined.
>> For review purpose we may want to know if the mounted device
>> is a zoned device. So log of zone device and its type may be useful
>> when we have verified the zoned devices in the open_ctree().
>>
>>> @@ -374,6 +375,7 @@ void btrfs_free_device(struct btrfs_device *device)
>>>      rcu_string_free(device->name);
>>>      extent_io_tree_release(&device->alloc_state);
>>>      bio_put(device->flush_bio);
>>
>>> +    btrfs_destroy_dev_zone_info(device);
>>
>> Free of btrfs_device::zone_info is already happening in the path..
>>
>> btrfs_close_one_device()
>>   btrfs_destroy_dev_zone_info()
>>
>> We don't need this..
>>
>> btrfs_free_device()
>>  btrfs_destroy_dev_zone_info()
> 
> Ah, yes, I once had it only in btrfs_free_device() and noticed that it does
> not free the device zone info on umount. So, I added one in
> btrfs_close_one_device() and forgot to remove the other one. I'll drop it
> from btrfs_free_device().
> 
>>
>>
>>> @@ -2543,6 +2551,14 @@ int btrfs_init_new_device(struct btrfs_fs_info 
>>> *fs_info, const char *device_path
>>>      }
>>>      rcu_assign_pointer(device->name, name);
>>> +    device->fs_info = fs_info;
>>> +    device->bdev = bdev;
>>> +
>>> +    /* Get zone type information of zoned block devices */
>>> +    ret = btrfs_get_dev_zone_info(device);
>>> +    if (ret)
>>> +        goto error_free_device;
>>> +
>>>      trans = btrfs_start_transaction(root, 0);
>>>      if (IS_ERR(trans)) {
>>>          ret = PTR_ERR(trans);
>>
>> It should be something like goto error_free_zone from here.
>>
>>
>>> @@ -2707,6 +2721,7 @@ int btrfs_init_new_device(struct btrfs_fs_info 
>>> *fs_info, const char *device_path
>>>          sb->s_flags |= SB_RDONLY;
>>>      if (trans)
>>>          btrfs_end_transaction(trans);
>>
>>
>> error_free_zone:
> 
> And, I'll do something like this.
> 
>>> +    btrfs_destroy_dev_zone_info(device);
>>>  error_free_device:
>>>      btrfs_free_device(device);
>>>  error:
>>
>> As mentioned we don't need btrfs_destroy_dev_zone_info()
>> again in  btrfs_free_device(). Otherwise we end up calling
>> btrfs_destroy_dev_zone_info twice here.
>>
>>
>> Thanks, Anand

