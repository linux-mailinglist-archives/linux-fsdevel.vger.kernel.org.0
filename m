Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7242FAE0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 01:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbhASA3f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 19:29:35 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:56114 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730466AbhASA3e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 19:29:34 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10J0FU5n168357;
        Tue, 19 Jan 2021 00:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=2ao4MDsp9rAiFU5VVLiQKoMbqbNy+6VSRgxjFTFpfm0=;
 b=CXpAPQDQvmEFuXyUwTY54YwH7UfNZYOpKhTgNxWW9phfEdIfXz6ZpN+gvX8akbI82+4k
 893+MFl8PWfoSvAbVijFmOAgvIqBVP+fgctR0+PjiWLrXSFXLyoWyKNKO6dsdLAbvarm
 OHUTByHA8RO8f4KkZ0VbFF/nSzPMLd8sUBj9cCw3Zq0UfxYhoggGOUm//YylKDhRojb/
 vgasZ2lQpQcMeZ74VBfFwtm8t2akoADY3rGgPkepsRAP0E9gg2QZarHE8ZmesUHvnYSH
 RhoRuKhqEcD0zmv5pbP1OrUhr+dxTDXRu7Apfq7WghqDzAv5T5jerpYVN0+w4veYYWTn 3w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 363xyhpae7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 00:28:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10J0EtD1169971;
        Tue, 19 Jan 2021 00:28:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 3649wqk5h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 00:28:36 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10J0SYm5024413;
        Tue, 19 Jan 2021 00:28:34 GMT
Received: from [192.168.10.137] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Jan 2021 16:28:34 -0800
Subject: Re: [PATCH v12 08/41] btrfs: allow zoned mode on non-zoned block
 devices
To:     Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
 <b80a551167d92406924050e9ccbcd872f84fa857.1610693037.git.naohiro.aota@wdc.com>
 <e026431f-1cbe-fd28-c4f8-0bee4b26de16@toxicpanda.com>
 <20210118141555.lljrdbuhok4y4d23@naota.dhcp.fujisawa.hgst.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <be54fab4-216e-ca83-346b-a3fcf096be40@oracle.com>
Date:   Tue, 19 Jan 2021 08:28:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210118141555.lljrdbuhok4y4d23@naota.dhcp.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9868 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101190000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9868 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501 spamscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101190000
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 18/1/21 10:15 pm, Naohiro Aota wrote:
> On Fri, Jan 15, 2021 at 05:07:26PM -0500, Josef Bacik wrote:
>> On 1/15/21 1:53 AM, Naohiro Aota wrote:
>>> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>>
>>> Run zoned btrfs mode on non-zoned devices. This is done by "slicing
>>> up" the block-device into static sized chunks and fake a conventional 
>>> zone
>>> on each of them. The emulated zone size is determined from the size of
>>> device extent.
>>>
>>> This is mainly aimed at testing parts of the zoned mode, i.e. the zoned
>>> chunk allocator, on regular block devices.
>>>
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>> ---
>>>  fs/btrfs/zoned.c | 149 +++++++++++++++++++++++++++++++++++++++++++----
>>>  fs/btrfs/zoned.h |  14 +++--
>>>  2 files changed, 147 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
>>> index 684dad749a8c..13b240e5db4e 100644
>>> --- a/fs/btrfs/zoned.c
>>> +++ b/fs/btrfs/zoned.c
>>> @@ -119,6 +119,37 @@ static inline u32 sb_zone_number(int shift, int 
>>> mirror)
>>>      return 0;
>>>  }
>>> +/*
>>> + * Emulate blkdev_report_zones() for a non-zoned device. It slice up
>>> + * the block device into static sized chunks and fake a conventional 
>>> zone
>>> + * on each of them.
>>> + */
>>> +static int emulate_report_zones(struct btrfs_device *device, u64 pos,
>>> +                struct blk_zone *zones, unsigned int nr_zones)
>>> +{
>>> +    const sector_t zone_sectors =
>>> +        device->fs_info->zone_size >> SECTOR_SHIFT;
>>> +    sector_t bdev_size = device->bdev->bd_part->nr_sects;
>>
>> This needs to be changed to bdev_nr_sectors(), it fails to compile on 
>> misc-next.  This patch also fails to apply to misc-next as well. Thanks,
>>
>> Josef
> 
> Oh, I'll rebase on the latest misc-next and fix them all in v13. Thanks.


Patch 12 was conflicting in zone.c which was due to line number changes,
and again I was stuck with the patch 19 due to conflicts. I will wait 
for v13.

Thanks, Anand
