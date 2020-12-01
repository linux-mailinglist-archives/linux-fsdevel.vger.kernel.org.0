Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929422C97E8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 08:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbgLAHNK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 02:13:10 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:42270 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbgLAHNK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 02:13:10 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B178sfV144525;
        Tue, 1 Dec 2020 07:12:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=9Z7XNcL/wg6s3DKZAp0HlgDWb0aBZXwpfIljBF35CWA=;
 b=F/kpQkDQ/TV8fWZTgcLVYxIKO2dX//2t/cNxaJwI/2iVOxYG2Kurw79lxzIZqIszTJtv
 TByO+22Tw/jKPFRBwnCE7Lyb06ARdH8E5NHYQitRGmt9dE2iZ9HvgAA8LNEbemQw1zaR
 MMeqtjP+h9IY9yJWDv77gA9wWkzz6nVFD8aTCwBlJ0BMyN+YHtUYF0cWVRjGIZJc9Y0t
 ZjVS57F1MhvYW8kOPZoR7F57Brw3dcx7XdsDNkgDC4+HgDFW/yQSFSkPM/sflwxrYyqZ
 MsHoSk28iOveV28fW1CAGeW5eYYF8MvL+HlFL+LDGSVYh82OVbNL3q+xLuKVObhCFqJ0 /A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 353egkgyb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 01 Dec 2020 07:12:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B176FHs101135;
        Tue, 1 Dec 2020 07:12:17 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 3540artw60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Dec 2020 07:12:17 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B17CDLX009965;
        Tue, 1 Dec 2020 07:12:13 GMT
Received: from [192.168.10.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Nov 2020 23:12:12 -0800
Subject: Re: [PATCH v10 05/41] btrfs: check and enable ZONED mode
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <104218b8d66fec2e4121203b90e7673ddac19d6a.1605007036.git.naohiro.aota@wdc.com>
 <51c91510-6014-0dee-a456-b50648f48156@oracle.com>
 <20201127184439.GB6430@twin.jikos.cz>
 <e3d212c1-057e-a761-6dc2-767f1e82c748@oracle.com>
 <CH2PR04MB6522A370F9D092A42E22527BE7F50@CH2PR04MB6522.namprd04.prod.outlook.com>
 <4a784d16-b325-bf32-5ce5-0718c6bce252@oracle.com>
 <CH2PR04MB65221794BF271B9A0E76388EE7F40@CH2PR04MB6522.namprd04.prod.outlook.com>
 <47fffa8d-a495-5588-f970-1ab04ece19b6@oracle.com>
 <CH2PR04MB652224DE2A682FADE28F443DE7F40@CH2PR04MB6522.namprd04.prod.outlook.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <51806a37-ccbd-85b2-9760-1393d59c98de@oracle.com>
Date:   Tue, 1 Dec 2020 15:12:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CH2PR04MB652224DE2A682FADE28F443DE7F40@CH2PR04MB6522.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010046
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012010046
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1/12/20 2:09 pm, Damien Le Moal wrote:
> On 2020/12/01 14:54, Anand Jain wrote:
>> On 1/12/20 10:29 am, Damien Le Moal wrote:
>>> On 2020/12/01 11:20, Anand Jain wrote:
>>>> On 30/11/20 9:15 pm, Damien Le Moal wrote:
>>>>> On 2020/11/30 21:13, Anand Jain wrote:
>>>>>> On 28/11/20 2:44 am, David Sterba wrote:
>>>>>>> On Wed, Nov 18, 2020 at 07:29:20PM +0800, Anand Jain wrote:
>>>>>>>> On 10/11/20 7:26 pm, Naohiro Aota wrote:
>>>>>>>>> This commit introduces the function btrfs_check_zoned_mode() to check if
>>>>>>>>> ZONED flag is enabled on the file system and if the file system consists of
>>>>>>>>> zoned devices with equal zone size.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>>>>>>>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>>>>>>>>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>>>>>>>> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>>>>>>>>> ---
>>>>>>>>>       fs/btrfs/ctree.h       | 11 ++++++
>>>>>>>>>       fs/btrfs/dev-replace.c |  7 ++++
>>>>>>>>>       fs/btrfs/disk-io.c     | 11 ++++++
>>>>>>>>>       fs/btrfs/super.c       |  1 +
>>>>>>>>>       fs/btrfs/volumes.c     |  5 +++
>>>>>>>>>       fs/btrfs/zoned.c       | 81 ++++++++++++++++++++++++++++++++++++++++++
>>>>>>>>>       fs/btrfs/zoned.h       | 26 ++++++++++++++
>>>>>>>>>       7 files changed, 142 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>>>>>>>>> index aac3d6f4e35b..453f41ca024e 100644
>>>>>>>>> --- a/fs/btrfs/ctree.h
>>>>>>>>> +++ b/fs/btrfs/ctree.h
>>>>>>>>> @@ -948,6 +948,12 @@ struct btrfs_fs_info {
>>>>>>>>>       	/* Type of exclusive operation running */
>>>>>>>>>       	unsigned long exclusive_operation;
>>>>>>>>>       
>>>>>>>>> +	/* Zone size when in ZONED mode */
>>>>>>>>> +	union {
>>>>>>>>> +		u64 zone_size;
>>>>>>>>> +		u64 zoned;
>>>>>>>>> +	};
>>>>>>>>> +
>>>>>>>>>       #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>>>>>>>>>       	spinlock_t ref_verify_lock;
>>>>>>>>>       	struct rb_root block_tree;
>>>>>>>>> @@ -3595,4 +3601,9 @@ static inline int btrfs_is_testing(struct btrfs_fs_info *fs_info)
>>>>>>>>>       }
>>>>>>>>>       #endif
>>>>>>>>>       
>>>>>>>>> +static inline bool btrfs_is_zoned(struct btrfs_fs_info *fs_info)
>>>>>>>>> +{
>>>>>>>>> +	return fs_info->zoned != 0;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>>       #endif
>>>>>>>>> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
>>>>>>>>> index 6f6d77224c2b..db87f1aa604b 100644
>>>>>>>>> --- a/fs/btrfs/dev-replace.c
>>>>>>>>> +++ b/fs/btrfs/dev-replace.c
>>>>>>>>> @@ -238,6 +238,13 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
>>>>>>>>>       		return PTR_ERR(bdev);
>>>>>>>>>       	}
>>>>>>>>>       
>>>>>>>>> +	if (!btrfs_check_device_zone_type(fs_info, bdev)) {
>>>>>>>>> +		btrfs_err(fs_info,
>>>>>>>>> +			  "dev-replace: zoned type of target device mismatch with filesystem");
>>>>>>>>> +		ret = -EINVAL;
>>>>>>>>> +		goto error;
>>>>>>>>> +	}
>>>>>>>>> +
>>>>>>>>>       	sync_blockdev(bdev);
>>>>>>>>>       
>>>>>>>>>       	list_for_each_entry(device, &fs_info->fs_devices->devices, dev_list) {
>>>>>>>>
>>>>>>>>       I am not sure if it is done in some other patch. But we still have to
>>>>>>>>       check for
>>>>>>>>
>>>>>>>>       (model == BLK_ZONED_HA && incompat_zoned))
>>>>>>>
>>>>>>> Do you really mean BLK_ZONED_HA, ie. host-aware (HA)?
>>>>>>> btrfs_check_device_zone_type checks for _HM.
>>>>>>
>>>>>>
>>>>>> Still confusing to me. The below function, which is part of this
>>>>>> patch, says we don't support BLK_ZONED_HM. So does it mean we
>>>>>> allow BLK_ZONED_HA only?
>>>>>>
>>>>>> +static inline bool btrfs_check_device_zone_type(struct btrfs_fs_info
>>>>>> *fs_info,
>>>>>> +						struct block_device *bdev)
>>>>>> +{
>>>>>> +	u64 zone_size;
>>>>>> +
>>>>>> +	if (btrfs_is_zoned(fs_info)) {
>>>>>> +		zone_size = (u64)bdev_zone_sectors(bdev) << SECTOR_SHIFT;
>>>>>> +		/* Do not allow non-zoned device */
>>>>>
>>>>> This comment does not make sense. It should be:
>>>>>
>>>>> 		/* Only allow zoned devices with the same zone size */
>>>>>
>>>>>> +		return bdev_is_zoned(bdev) && fs_info->zone_size == zone_size;
>>>>>> +	}
>>>>>> +
>>>>>> +	/* Do not allow Host Manged zoned device */
>>>>>> +	return bdev_zoned_model(bdev) != BLK_ZONED_HM;
>>>>>
>>>>> The comment is also wrong. It should read:
>>>>>
>>>>> 	/* Allow only host managed zoned devices */
>>>>>
>>>>> This is because we decided to treat host aware devices in the same way as
>>>>> regular block devices, since HA drives are backward compatible with regular
>>>>> block devices.
>>>>
>>>>
>>>> Yeah, I read about them, but I have questions like do an FS work on top
>>>> of a BLK_ZONED_HA without modification?
>>>
>>> Yes. These drives are fully backward compatible and accept random writes
>>> anywhere. Performance however is potentially a different story as the drive will
>>> eventually need to do internal garbage collection of some sort, exactly like an
>>> SSD, but definitely not at SSD speeds :)
>>>
>>>>     Are we ok to replace an HM device with a HA device? Or add a HA device
>>>> to a btrfs on an HM device.
>>>
>>> We have a choice here: we can treat HA drives as regular devices or treat them
>>> as HM devices. Anything in between does not make sense. I am fine either way,
>>> the main reason being that there are no HA drive on the market today that I know
>>> of (this model did not have a lot of success due to the potentially very
>>> unpredictable performance depending on the use case).
>>>
>>> So the simplest thing to do is, in my opinion, to ignore their "zone"
>>> characteristics and treat them as regular disks. But treating them as HM drives
>>> is a simple to do too.
>>>> Of note is that a host-aware drive will be reported by the block layer as
>>> BLK_ZONED_HA only as long as the drive does not have any partition. If it does,
>>> then the block layer will treat the drive as a regular disk.
>>
>> IMO. For now, it is better to check for the BLK_ZONED_HA explicitly in a
>> non-zoned-btrfs. And check for BLK_ZONED_HM explicitly in a zoned-btrfs.
> 
> Sure, we can. But since HA drives are backward compatible, not sure the HA check
> for non-zoned make sense. As long as the zoned flag is not set, the drive can be
> used like a regular disk. If the user really want to use it as a zoned drive,
> then it can format with force selecting the zoned flag in btrfs super. Then the
> HA drive will be used as a zoned disk, exactly like HM disks.
> 
>> This way, if there is another type of BLK_ZONED_xx in the future, we
>> have the opportunity to review to support it. As below [1]...
> 
> It is very unlikely that we will see any other zone model. ZNS adopted the HM
> model in purpose, to avoid multiplying the possible models, making the ecosystem
> effort a nightmare.
> 
>>
>> [1]
>> bool btrfs_check_device_type()
>> {
>> 	if (bdev_is_zoned()) {
>> 		if (btrfs_is_zoned())
>> 			if (bdev_zoned_model == BLK_ZONED_HM)
>> 			/* also check the zone_size. */
>> 				return true;
>> 		else
>> 			if (bdev_zoned_model == BLK_ZONED_HA)
>> 			/* a regular device and FS, no zone_size to check I think? */
>> 				return true;
>> 	} else {
>> 		if (!btrfs_is_zoned())
>> 			return true
>> 	}
>>
>> 	return false;
>> }
>>
>> Thanks.
> 
> Works for me. May be reverse the conditions to make things easier to read and
> understand:
> 
> bool btrfs_check_device_type()
> {
> 	if (btrfs_is_zoned()) {
> 		if (bdev_is_zoned()) {
> 			/* also check the zone_size. */
> 			return true;
> 		}
> 
> 		/*
> 		 * Regular device: emulate zones with zone size equal
> 		 * to device extent size.
> 		 */
> 		return true;
> 	}
> 
> 	if (bdev_zoned_model == BLK_ZONED_HM) {
> 		/* Zoned HM device require zoned btrfs */
> 		return false;
> 	}
> 
> 	/* Regular device or zoned HA device used as a regular device */
> 	return true;
> }
> 
> 

Yeah. Makes sense.

Thanks.
