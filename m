Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB457381DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 13:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjFUKtX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 06:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjFUKsc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:48:32 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562C91988
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 03:47:11 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230621104709euoutp02633b2318b015f2d871c5257b98d1cf1e~qptGy8zPB1894118941euoutp02F
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 10:47:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230621104709euoutp02633b2318b015f2d871c5257b98d1cf1e~qptGy8zPB1894118941euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687344430;
        bh=ybBH16zzryJUqZTMJ88U8esb28oabj3HAmLevnj962c=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=EJvjhFT4tWA+02XgczeW3SwwqcyPqxeL/d5xVWeMFgWHB3aDEeyI3tNEPQJXvggj2
         9/2eq9L8akLVYf7OVtLQ1WEciz2ISJ1QHJX0hfk5HscCe92aFQTqphNDFQA1rGERg7
         O9NLBX2p4wCBYPqVWfYy1VAfRrIYhea+LOamfUps=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230621104709eucas1p2cc9c30fee509a7bd45ad2a0370b6491d~qptGd6u_71652216522eucas1p2C;
        Wed, 21 Jun 2023 10:47:09 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 30.17.42423.D25D2946; Wed, 21
        Jun 2023 11:47:09 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230621104709eucas1p17a5397829a24f96cef40bb747da74967~qptGGA7CS0315503155eucas1p1k;
        Wed, 21 Jun 2023 10:47:09 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230621104709eusmtrp24e693a824154301819deee8c778531e3~qptGFcn2V1387513875eusmtrp2X;
        Wed, 21 Jun 2023 10:47:09 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-fe-6492d52deaaf
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E1.9F.10549.D25D2946; Wed, 21
        Jun 2023 11:47:09 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230621104709eusmtip1091e719f3c3c8a6482e20152436286b2~qptF71fNY1840618406eusmtip16;
        Wed, 21 Jun 2023 10:47:09 +0000 (GMT)
Received: from [106.110.32.65] (106.110.32.65) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 21 Jun 2023 11:47:06 +0100
Message-ID: <13ebdd01-1cfb-f3a9-b1a5-60578bd60ca1@samsung.com>
Date:   Wed, 21 Jun 2023 12:47:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.11.0
Subject: Re: [RFC 4/4] nvme: enable logical block size > PAGE_SIZE
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>, <willy@infradead.org>,
        <david@fromorbit.com>
CC:     <gost.dev@samsung.com>, <mcgrof@kernel.org>, <hch@lst.de>,
        <jwong@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <210519c3-b843-c2f5-f2eb-633543e2cc7f@suse.de>
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.110.32.65]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsWy7djPc7q6VyelGFz4qmyx5dg9Ros9iyYx
        WaxcfZTJ4tqZHiaLPXtPslhc3jWHzeLGhKeMFr9/zGFz4PA4tUjCY/MKLY9NqzrZPHbfbGDz
        2Hy62uPzJrkAtigum5TUnMyy1CJ9uwSujFnnHrAVTOSpWLhlC3MD4x/OLkZODgkBE4n/m9rZ
        uhi5OIQEVjBKLPvziR0kISTwhVFi3e50CPszo8SH+cYwDd07u9khGpYzSixfvIAFwgEq+nZp
        OSOEs5NR4tPjXWwgLbwCdhL/z+0Gsjk4WARUJc59DYQIC0qcnPmEBcQWFYiWaF12H6xcWMBJ
        4s78LUwgNrOAuMStJ/PBbBGBIImjnafANjMLTAPafPEKI8hMNgEticZOsKs5BawlNq6/xAzR
        Ky/RvHU2M8TVihKTbr5nhbBrJU5tucUEMkdCoJ9TYsXun1BFLhJXn5xjg7CFJV4d38IOYctI
        /N8JcYSEQLXE0xu/mSGaWxgl+neuB3tMAmhz35kcEJNZQFNi/S59iHJHiVWPFzNBVPBJ3Hgr
        CHEan8SkbdOZJzCqzkIKiVlIPp6F5INZCEMXMLKsYhRPLS3OTU8tNsxLLdcrTswtLs1L10vO
        z93ECExHp/8d/7SDce6rj3qHGJk4GA8xSnAwK4nwym6alCLEm5JYWZValB9fVJqTWnyIUZqD
        RUmcV9v2ZLKQQHpiSWp2ampBahFMlomDU6qBKfCVQav+kwWPZylfObfl6GEXyfYdurM1350L
        vvjCQTx+w8a2J17HZKU/JtseuT5By3WDW9b+52uYP93+lX7c6e/cdVterPzDrf7/wPrSp5EZ
        6+UUnVduumepmL2MVSLhvtY1ntNxmVkMBYsWGuXxLEszmBw7xYGxivPaxWPnVj7MqVsV4yv4
        vG+yzU2j3bEz5h7ZNfHSK6bZy7Z4vtAS+z3LMEvoU5jBfz+V+I7fsjNval+PY5JcmqC04h73
        39cJE45m9kQ/STxWdFpkaRX7EYbud0mXVOQ3Jd6tyRM/suQoqzf7nZpTLG+lz7qut9axEeDz
        TBSaIv9rztV5u2SKTDqO3ony+rV+JoNz/oeZfA+VWIozEg21mIuKEwGmjS3ctgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsVy+t/xu7q6VyelGLx8xmWx5dg9Ros9iyYx
        WaxcfZTJ4tqZHiaLPXtPslhc3jWHzeLGhKeMFr9/zGFz4PA4tUjCY/MKLY9NqzrZPHbfbGDz
        2Hy62uPzJrkAtig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy
        1CJ9uwS9jFnnHrAVTOSpWLhlC3MD4x/OLkZODgkBE4nund3sXYxcHEICSxkl1ly7zwSRkJHY
        +OUqK4QtLPHnWhcbRNFHRonTW38wQzg7GSU6Gqexg1TxCthJ/D+3G6iKg4NFQFXi3NdAiLCg
        xMmZT1hAbFGBaInVny+ADRUWcJK4M38L2DJmAXGJW0/mg9kiAkESRztPgV3ELDCNUWL5xSuM
        EMs+MUqs3jafGWQBm4CWRGMn2F5OAWuJjesvMUMM0pRo3f6bHcKWl2jeOpsZ4gNFiUk330N9
        Uyvx+e8zxgmMorOQ3DcLyR2zkIyahWTUAkaWVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIHR
        vO3Yz807GOe9+qh3iJGJg/EQowQHs5IIr+ymSSlCvCmJlVWpRfnxRaU5qcWHGE2BYTSRWUo0
        OR+YTvJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGpjmLNEK8/qR
        HvK1kPnIFoWZq6yajv3bvylL8svBmwvf8ZhO38k5VzGhQEZtKtvOacJaTprn5jb/U7Z0qxd1
        3x3AdJHVt0Sw9TLL4ds9cmeknkb1NHzuZvC6LyLV9fF2iFwe2+JPQbIfL2zlyNUPeJaZIXFi
        2Qwxe8fTuwymxyz52rfsu5FIgyF7mV7vBH2DlbyJhqw5zv89koN4m+4tWzVrr6OqtTvLgw5D
        jmDxrOcLF3y5ucI3OUZq4Z+2zAOfFffNL/Fq/xBxNuaBypLfx3vPKFyIOC2l9t5m/4+4N50u
        m39dOno+POzFxPel+nddfx9Yu61tgXSN/WxDKRmXcsW5/nL9p609uBLX7SqTm6HEUpyRaKjF
        XFScCACBwQjXbwMAAA==
X-CMS-MailID: 20230621104709eucas1p17a5397829a24f96cef40bb747da74967
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230621083830eucas1p1c7e6ea9e23949a9688aac6f9f3ea25fb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621083830eucas1p1c7e6ea9e23949a9688aac6f9f3ea25fb
References: <20230621083823.1724337-1-p.raghav@samsung.com>
        <CGME20230621083830eucas1p1c7e6ea9e23949a9688aac6f9f3ea25fb@eucas1p1.samsung.com>
        <20230621083823.1724337-5-p.raghav@samsung.com>
        <210519c3-b843-c2f5-f2eb-633543e2cc7f@suse.de>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-06-21 11:07, Hannes Reinecke wrote:
> On 6/21/23 10:38, Pankaj Raghav wrote:
>> Don't set the capacity to zero for when logical block size > PAGE_SIZE
>> as the block device with iomap aops support allocating block cache with
>> a minimum folio order.
>>
>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>> ---
>>   drivers/nvme/host/core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 98bfb3d9c22a..36cf610f938c 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -1886,7 +1886,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
>>        * The block layer can't support LBA sizes larger than the page size
>>        * yet, so catch this early and don't allow block I/O.
>>        */
>> -    if (ns->lba_shift > PAGE_SHIFT) {
>> +    if ((ns->lba_shift > PAGE_SHIFT) && IS_ENABLED(CONFIG_BUFFER_HEAD)) {
>>           capacity = 0;
>>           bs = (1 << 9);
>>       }
> Again, I can't see why this would be contingent on CONFIG_BUFFER_HEAD.
> I'll be rebasing my patchset on your mapping_set_orders() patches and repost.
> 

As I explained in the previous email, I get a BUG from buffer.c when I don't make it conditional.
The hope is when we move to iomap based aops for the block cache, we can just get rid of
`if (ns->lba_shift > PAGE_SHIFT)` block and no dependence on CONFIG_BUFFER_HEAD.

> Cheers,
> 
> Hannes
> 
