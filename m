Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211D452B788
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 12:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbiERJmH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 05:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbiERJkl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 05:40:41 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C9014CDD2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 02:40:27 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220518094026euoutp02e892832bdf30ff7e40a821bbfc5b8b59~wKZ8UGh8D1504915049euoutp02K
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 09:40:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220518094026euoutp02e892832bdf30ff7e40a821bbfc5b8b59~wKZ8UGh8D1504915049euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652866826;
        bh=UINa+NuzB2qcwPdtYD8SfTNgCx/7Du9BqOastcKQAPY=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=shqc2DtzVgGL/PdyLOUSepug1aiuw0mBybg1NT2V3WnWmbVQuRexEIIafnFyxk7nt
         WPUU6OOI9wuFuorqEYxcy2f6RYhPb0JurLw+Rv2k676PySBqE5+qKMj9oxgjqTos9c
         NDcZAb1vKrQWTX86ufx8KjR4YztPOe9IMsP7oaZY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220518094026eucas1p14f9febe6d48605bfce997c4ca867a8aa~wKZ77YK3K1913319133eucas1p1B;
        Wed, 18 May 2022 09:40:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 84.03.10009.90FB4826; Wed, 18
        May 2022 10:40:25 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220518094025eucas1p1a3e35a8f00348154d5ef60e61f69dfec~wKZ7bieyt1910619106eucas1p1C;
        Wed, 18 May 2022 09:40:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220518094025eusmtrp2690bb9439acf332022cabbb049548d8e~wKZ7U22Pu2765427654eusmtrp2c;
        Wed, 18 May 2022 09:40:25 +0000 (GMT)
X-AuditID: cbfec7f2-e95ff70000002719-52-6284bf09d4d0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id AA.0D.09522.90FB4826; Wed, 18
        May 2022 10:40:25 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220518094025eusmtip208fc0da8c94d9d123d11609e50d861a3~wKZ7LAhz31670016700eusmtip2h;
        Wed, 18 May 2022 09:40:25 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.7) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 18 May 2022 10:40:23 +0100
Message-ID: <2b169f03-11d6-9989-84cb-821d67eb6cae@samsung.com>
Date:   Wed, 18 May 2022 11:40:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.8.1
Subject: Re: [PATCH v4 07/13] btrfs: zoned: use generic btrfs zone helpers
 to support npo2 zoned devices
Content-Language: en-US
To:     <dsterba@suse.cz>
CC:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <pankydev8@gmail.com>, <dsterba@suse.com>, <hch@lst.de>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-btrfs@vger.kernel.org>, <jiangbo.365@bytedance.com>,
        <linux-block@vger.kernel.org>, <gost.dev@samsung.com>,
        <linux-kernel@vger.kernel.org>, <dm-devel@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20220517123008.GC18596@twin.jikos.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.7]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7djP87qc+1uSDM4cMbdYfbefzeL32fPM
        FnvfzWa1uPCjkcli8e/vLBYrVx9lsug58IHFYu8tbYtLj1ewW+zZe5LF4vKuOWwW85c9Zbe4
        MeEpo8Wam09ZHPg8/p1Yw+axc9Zddo/LZ0s9Nq3qZPPYvKTeY/fNBqBw631Wj/f7rrJ5rN9y
        lcXjzIIj7B6fN8kFcEdx2aSk5mSWpRbp2yVwZTT0PWEt2CRXcbzjJFsD4weJLkZODgkBE4kJ
        O/YwdjFycQgJrGCUWPt5MRuE84VR4s35I+wgVUICnxklOppLYTrOnfnFDBFfzihx/Jw/RANQ
        zexNn6FG7WSUeNCyixWkilfATuLYo3Y2EJtFQFVi95QtzBBxQYmTM5+wgNiiAhES02adAasR
        FsiSmLJtI1gvs4C4xK0n85lAbBEBUYlL+1ewgCxgFpjILDHpxWSgbRwcbAJaEo2dYJdyChhL
        rG09yQbRqynRuv03O4QtL7H97RxmiA8UJW6u/MUGYddKrD12hh1kpoTAPU6Jq7/PQxW5SFz+
        v4QRwhaWeHV8CzuELSPxfyfEQRIC1RJPb/xmhmhuYZTo37meDeQgCQFrib4zORA1jhIzHu9l
        hQjzSdx4KwhxD5/EpG3TmScwqs5CCopZSF6eheSFWUheWMDIsopRPLW0ODc9tdgwL7Vcrzgx
        t7g0L10vOT93EyMwBZ7+d/zTDsa5rz7qHWJk4mA8xCjBwawkwsuY25IkxJuSWFmVWpQfX1Sa
        k1p8iFGag0VJnDc5c0OikEB6YklqdmpqQWoRTJaJg1OqgalPhd+O73Je1X5TLlPObz8fT05U
        M2iV2mW/5Ovduivb1mqt/3Nsx7XJC6JFDJ/MmqUaduRx1GIG46AYf6cNzWrCCUwreLit9z//
        kG4v2jtD8Wqx7e2bdTVu0vYzLyXrJj74zDmxJ3jlIcsDnWtXPJ9ss3/Xec/S80XtAtvXGxp2
        CL9Q9tnSoM1/6vaH1y9DJrxMmHjrwvpigeSNL5KPXNQSS1jgW5s6882a8IY5QT5z8++XzZHv
        mtw/WUApr1Gq4aat3b8tmte75z+IYtz9zWJpYZaCobR+gc9fWZULqqrvmbatdvee7TDZVCrx
        0duaFW2fDmYeuVXFfKr92fkNMkdd/3zOnmE5xUt5uez3Qi0lluKMREMt5qLiRABuMXZT8AMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsVy+t/xe7qc+1uSDBbPF7FYfbefzeL32fPM
        FnvfzWa1uPCjkcli8e/vLBYrVx9lsug58IHFYu8tbYtLj1ewW+zZe5LF4vKuOWwW85c9Zbe4
        MeEpo8Wam09ZHPg8/p1Yw+axc9Zddo/LZ0s9Nq3qZPPYvKTeY/fNBqBw631Wj/f7rrJ5rN9y
        lcXjzIIj7B6fN8kFcEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk
        5mSWpRbp2yXoZTT0PWEt2CRXcbzjJFsD4weJLkZODgkBE4lzZ34xdzFycQgJLGWUWPfoHiNE
        Qkbi05WP7BC2sMSfa11sEEUfGSWu7z/NAuHsZJTYuKaZBaSKV8BO4tijdjYQm0VAVWL3lC3M
        EHFBiZMzn4DViApESDzYfZYVxBYWyJJ4dncH2AZmAXGJW0/mM4HYIgKiEpf2r4Ba8IJR4t7O
        OWD3MQtMZJaY9GIy0H0cHGwCWhKNnWDNnALGEmtbT7JBDNKUaN3+G2qovMT2t3OYIV5QlLi5
        8hcbhF0r8er+bsYJjKKzkNw3C8kds5CMmoVk1AJGllWMIqmlxbnpucWGesWJucWleel6yfm5
        mxiByWPbsZ+bdzDOe/VR7xAjEwfjIUYJDmYlEV7G3JYkId6UxMqq1KL8+KLSnNTiQ4ymwECa
        yCwlmpwPTF95JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1MysxO
        i9cVPvq+N+ltWGp05wv/qpSYo45sQv/mbJ0174TLhKLrEvpn/686/EK+Z17ZdA3TN8cLuSLk
        N/F2OHZv3mpnI9gaMXvibIHA6u9Kby+uPbvF2jvCv/nxNbFNTicDlfMn9nFXGfUKdEYc+FRj
        eunYLOvXs269CFY9Fm+ZVq8Ua/zzyw6Gkrc/65xmHZs7lZuDQ/T11O2clg7zP2f/q+TLb976
        6kVrQYRTp9ej6Z0ZzIfy5iu2KbgHsn62iJi4p13utk4Lr/vP8zuVpRnOrrj5+5LPU3OPNMHV
        p06snnng1/GIqrRdl5a+39bYGXFv9Yu4AxVChclr5kVXBqv/NPfoOxgdNLH4nIHVv213lViK
        MxINtZiLihMBD9bssacDAAA=
X-CMS-MailID: 20220518094025eucas1p1a3e35a8f00348154d5ef60e61f69dfec
X-Msg-Generator: CA
X-RootMTR: 20220516165428eucas1p1374b5f9592db3ca6a6551aff975537ce
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220516165428eucas1p1374b5f9592db3ca6a6551aff975537ce
References: <20220516165416.171196-1-p.raghav@samsung.com>
        <CGME20220516165428eucas1p1374b5f9592db3ca6a6551aff975537ce@eucas1p1.samsung.com>
        <20220516165416.171196-8-p.raghav@samsung.com>
        <20220517123008.GC18596@twin.jikos.cz>
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-05-17 14:30, David Sterba wrote:
> On Mon, May 16, 2022 at 06:54:10PM +0200, Pankaj Raghav wrote:
>> Add helpers to calculate alignment, round up and round down
>> for zoned devices. These helpers encapsulates the necessary handling for
>> power_of_2 and non-power_of_2 zone sizes. Optimized calculations are
>> performed for zone sizes that are power_of_2 with log and shifts.
>>
>> btrfs_zoned_is_aligned() is added instead of reusing bdev_zone_aligned()
>> helper due to some use cases in btrfs where zone alignment is checked
>> before having access to the underlying block device such as in this
>> function: btrfs_load_block_group_zone_info().
>>
>> Use the generic btrfs zone helpers to calculate zone index, check zone
>> alignment, round up and round down operations.
>>
>> The zone_size_shift field is not needed anymore as generic helpers are
>> used for calculation.
> 
> Overall this looks reasonable to me.
> 
>> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>> ---
>>  fs/btrfs/volumes.c | 24 +++++++++-------
>>  fs/btrfs/zoned.c   | 72 ++++++++++++++++++++++------------------------
>>  fs/btrfs/zoned.h   | 43 +++++++++++++++++++++++----
>>  3 files changed, 85 insertions(+), 54 deletions(-)
>>
>> --- a/fs/btrfs/zoned.c
>> +++ b/fs/btrfs/zoned.c
>> @@ -1108,14 +1101,14 @@ int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
>>  int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
>>  {
>>  	struct btrfs_zoned_device_info *zinfo = device->zone_info;
>> -	const u8 shift = zinfo->zone_size_shift;
>> -	unsigned long begin = start >> shift;
>> -	unsigned long end = (start + size) >> shift;
>> +	unsigned long begin = bdev_zone_no(device->bdev, start >> SECTOR_SHIFT);
>> +	unsigned long end =
>> +		bdev_zone_no(device->bdev, (start + size) >> SECTOR_SHIFT);
> 
> There are unsinged long types here though I'd rather see u64, better for
> a separate patch. Fixed width types are cleaner here and in the zoned
> code as there's always some conversion to/from sectors.
> 
Ok. I will probably send a separate patch to convert them to fix width
types. Is it ok if I do it as a separate patch instead of including it
in this series?
>>  	u64 pos;
>>  	int ret;
>>  
>> -	ASSERT(IS_ALIGNED(start, zinfo->zone_size));
>> -	ASSERT(IS_ALIGNED(size, zinfo->zone_size));
>> +	ASSERT(btrfs_zoned_is_aligned(start, zinfo->zone_size));
>> +	ASSERT(btrfs_zoned_is_aligned(size, zinfo->zone_size));
>>  
>>  	if (end > zinfo->nr_zones)
>>  		return -ERANGE;
>> --- a/fs/btrfs/zoned.h
>> +++ b/fs/btrfs/zoned.h
>> @@ -30,6 +30,36 @@ struct btrfs_zoned_device_info {
>>  	u32 sb_zone_location[BTRFS_SUPER_MIRROR_MAX];
>>  };
>>  
>> +static inline bool btrfs_zoned_is_aligned(u64 pos, u64 zone_size)
>> +{
>> +	u64 remainder = 0;
>> +
>> +	if (is_power_of_two_u64(zone_size))
>> +		return IS_ALIGNED(pos, zone_size);
>> +
>> +	div64_u64_rem(pos, zone_size, &remainder);
>> +	return remainder == 0;
>> +}
>> +
>> +static inline u64 btrfs_zoned_roundup(u64 pos, u64 zone_size)
>> +{
>> +	if (is_power_of_two_u64(zone_size))
>> +		return ALIGN(pos, zone_size);
> 
> Please use round_up as the rounddown helper uses round_down
> 
Ah, good catch. I will use it instead. Thanks.
>> +
>> +	return div64_u64(pos + zone_size - 1, zone_size) * zone_size;
>> +}
>> +
>> +static inline u64 btrfs_zoned_rounddown(u64 pos, u64 zone_size)
>> +{
>> +	u64 remainder = 0;
>> +	if (is_power_of_two_u64(zone_size))
>> +		return round_down(pos, zone_size);
>> +
>> +	div64_u64_rem(pos, zone_size, &remainder);
>> +	pos -= remainder;
>> +	return pos;
>> +}
>> +
>>  #ifdef CONFIG_BLK_DEV_ZONED
>>  int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>>  		       struct blk_zone *zone);
