Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EAB2C83ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 13:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgK3MNn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 07:13:43 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33788 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728039AbgK3MNn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 07:13:43 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AUC5HB7160135;
        Mon, 30 Nov 2020 12:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=CqYY2VNgbobPvXOmB4ECShuOxMwJfiKIVd8u7Ta7z0Y=;
 b=dtDzQo9LmgJX1J12c66eYtoTVdqxdW4+QwlE7wHJcgxQqRlgfVkLHgsSi3LiVrwITDs0
 T6BXEx2cOlDh5asoM7xN+Tl4Wdxhr4gKw+lzESUssttuoaO5cAUoQsH3bLoHIoX/rRcJ
 0xelN/NoND6+/eol1nAw89tBz0ZGT4vfcaR3wEkdJ+u8gL+eEUgPLSvRwjEYMT3Ff6P2
 epVZJ5IykDIt+Buce/mKYi7BiUOzc21nSnHJGL2Pf7q/lWQh4HCY0w7qSJvjYEARRMIi
 1HW81JBIhmeyLJxG3yANadAQTaW5IJH0a0CTEGzUc0xYrnX1JDekATsvCC3Mc9p9T3zH aw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 353c2amtyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Nov 2020 12:12:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AUCADq2152369;
        Mon, 30 Nov 2020 12:12:49 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 3540aqh4pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Nov 2020 12:12:49 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AUCCjNA032013;
        Mon, 30 Nov 2020 12:12:46 GMT
Received: from [192.168.1.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Nov 2020 04:12:43 -0800
Subject: Re: [PATCH v10 05/41] btrfs: check and enable ZONED mode
To:     dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <104218b8d66fec2e4121203b90e7673ddac19d6a.1605007036.git.naohiro.aota@wdc.com>
 <51c91510-6014-0dee-a456-b50648f48156@oracle.com>
 <20201127184439.GB6430@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <e3d212c1-057e-a761-6dc2-767f1e82c748@oracle.com>
Date:   Mon, 30 Nov 2020 20:12:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201127184439.GB6430@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9820 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9820 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011300079
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28/11/20 2:44 am, David Sterba wrote:
> On Wed, Nov 18, 2020 at 07:29:20PM +0800, Anand Jain wrote:
>> On 10/11/20 7:26 pm, Naohiro Aota wrote:
>>> This commit introduces the function btrfs_check_zoned_mode() to check if
>>> ZONED flag is enabled on the file system and if the file system consists of
>>> zoned devices with equal zone size.
>>>
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>>> ---
>>>    fs/btrfs/ctree.h       | 11 ++++++
>>>    fs/btrfs/dev-replace.c |  7 ++++
>>>    fs/btrfs/disk-io.c     | 11 ++++++
>>>    fs/btrfs/super.c       |  1 +
>>>    fs/btrfs/volumes.c     |  5 +++
>>>    fs/btrfs/zoned.c       | 81 ++++++++++++++++++++++++++++++++++++++++++
>>>    fs/btrfs/zoned.h       | 26 ++++++++++++++
>>>    7 files changed, 142 insertions(+)
>>>
>>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>>> index aac3d6f4e35b..453f41ca024e 100644
>>> --- a/fs/btrfs/ctree.h
>>> +++ b/fs/btrfs/ctree.h
>>> @@ -948,6 +948,12 @@ struct btrfs_fs_info {
>>>    	/* Type of exclusive operation running */
>>>    	unsigned long exclusive_operation;
>>>    
>>> +	/* Zone size when in ZONED mode */
>>> +	union {
>>> +		u64 zone_size;
>>> +		u64 zoned;
>>> +	};
>>> +
>>>    #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>>>    	spinlock_t ref_verify_lock;
>>>    	struct rb_root block_tree;
>>> @@ -3595,4 +3601,9 @@ static inline int btrfs_is_testing(struct btrfs_fs_info *fs_info)
>>>    }
>>>    #endif
>>>    
>>> +static inline bool btrfs_is_zoned(struct btrfs_fs_info *fs_info)
>>> +{
>>> +	return fs_info->zoned != 0;
>>> +}
>>> +
>>>    #endif
>>> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
>>> index 6f6d77224c2b..db87f1aa604b 100644
>>> --- a/fs/btrfs/dev-replace.c
>>> +++ b/fs/btrfs/dev-replace.c
>>> @@ -238,6 +238,13 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
>>>    		return PTR_ERR(bdev);
>>>    	}
>>>    
>>> +	if (!btrfs_check_device_zone_type(fs_info, bdev)) {
>>> +		btrfs_err(fs_info,
>>> +			  "dev-replace: zoned type of target device mismatch with filesystem");
>>> +		ret = -EINVAL;
>>> +		goto error;
>>> +	}
>>> +
>>>    	sync_blockdev(bdev);
>>>    
>>>    	list_for_each_entry(device, &fs_info->fs_devices->devices, dev_list) {
>>
>>    I am not sure if it is done in some other patch. But we still have to
>>    check for
>>
>>    (model == BLK_ZONED_HA && incompat_zoned))
> 
> Do you really mean BLK_ZONED_HA, ie. host-aware (HA)?
> btrfs_check_device_zone_type checks for _HM.


Still confusing to me. The below function, which is part of this
patch, says we don't support BLK_ZONED_HM. So does it mean we
allow BLK_ZONED_HA only?

+static inline bool btrfs_check_device_zone_type(struct btrfs_fs_info 
*fs_info,
+						struct block_device *bdev)
+{
+	u64 zone_size;
+
+	if (btrfs_is_zoned(fs_info)) {
+		zone_size = (u64)bdev_zone_sectors(bdev) << SECTOR_SHIFT;
+		/* Do not allow non-zoned device */
+		return bdev_is_zoned(bdev) && fs_info->zone_size == zone_size;
+	}
+
+	/* Do not allow Host Manged zoned device */
+	return bdev_zoned_model(bdev) != BLK_ZONED_HM;
+}


Also, if there is a new type of zoned device in the future, the older 
kernel should be able to reject the newer zone device types.

And, if possible could you rename above function to 
btrfs_zone_type_is_valid(). Or better.


>> right? What if in a non-zoned FS, a zoned device is added through the
>> replace. No?
> 
> The types of devices cannot mix, yeah. So I'd like to know the answer as
> well.


>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -2518,6 +2518,11 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>>>    	if (IS_ERR(bdev))
>>>    		return PTR_ERR(bdev);
>>>    
>>> +	if (!btrfs_check_device_zone_type(fs_info, bdev)) {
>>> +		ret = -EINVAL;
>>> +		goto error;
>>> +	}
>>> +
>>>    	if (fs_devices->seeding) {
>>>    		seeding_dev = 1;
>>>    		down_write(&sb->s_umount);
>>
>> Same here too. It can also happen that a zone device is added to a non
>> zoned fs.


Thanks.
