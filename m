Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1808529B8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 09:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242149AbiEQHzu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 03:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbiEQHzr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 03:55:47 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD59654C
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 May 2022 00:55:45 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220517075541euoutp019f8a21b7250c98c49e77eb9cc62a8cec~v1VM_gxK20840808408euoutp01I
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 May 2022 07:55:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220517075541euoutp019f8a21b7250c98c49e77eb9cc62a8cec~v1VM_gxK20840808408euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652774141;
        bh=bx0GajEor3WyGMo16Q7LjJjnXX5wkXjOwejR898IHlA=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=I8+Az9lIdGVLHbV0AzkHCRWe5RYyWlIrvzpTwFyxkR4fAuFs1sTkhDYjXSuCEBmTc
         RyvVuWdBiuMAOPzKJ93pJHAiB6vESnyFzwC4ID4waMa48KLl4ncMn1aYJhWvELHtXh
         h4vasnqKTB+7eK3SYUBkb2F9kKkJNZvwCJVhzh8M=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220517075541eucas1p28071cc51330ce204f2f8758a16b48970~v1VMfzl7Q0562505625eucas1p2h;
        Tue, 17 May 2022 07:55:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F6.99.10260.DF453826; Tue, 17
        May 2022 08:55:41 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220517075540eucas1p126d19be7cc8d727e072f48bd3212684d~v1VMGc8rS2733227332eucas1p1h;
        Tue, 17 May 2022 07:55:40 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220517075540eusmtrp17e72e2a8e0edb40b9b0ccb6231156131~v1VMFdVfT1822418224eusmtrp1f;
        Tue, 17 May 2022 07:55:40 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-d0-628354fd157b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DE.47.09522.CF453826; Tue, 17
        May 2022 08:55:40 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220517075540eusmtip108cb51d13511e557ffec5666fa5ad2f5~v1VL8TtDG1204312043eusmtip10;
        Tue, 17 May 2022 07:55:40 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.7) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 17 May 2022 08:55:38 +0100
Message-ID: <bfcab01e-dbc8-a990-17b1-4aeadffa5685@samsung.com>
Date:   Tue, 17 May 2022 09:55:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.8.1
Subject: Re: [PATCH v4 05/13] btrfs: zoned: Cache superblock location in
 btrfs_zoned_device_info
Content-Language: en-US
To:     <dsterba@suse.cz>
CC:     <pankydev8@gmail.com>, <dsterba@suse.com>, <hch@lst.de>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-btrfs@vger.kernel.org>, <jiangbo.365@bytedance.com>,
        <linux-block@vger.kernel.org>, <gost.dev@samsung.com>,
        <linux-kernel@vger.kernel.org>, <dm-devel@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20220516215826.GZ18596@twin.jikos.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.7]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7djP87p/Q5qTDFbf47HY+242q8WFH41M
        Fot/f2exWLn6KJNFz4EPLBZ7b2lbXHq8gt1iz96TLBaXd81hs5i/7Cm7xY0JTxkt1tx8yuLA
        4/HvxBo2j52z7rJ7bFrVyeaxeUm9x+6bDWwe7/ddZfNYv+Uqi8eZBUfYPT5vkgvgjOKySUnN
        ySxLLdK3S+DKWNKcW9DGUdH08w5TA+NRti5GTg4JAROJpoP32EFsIYEVjBK/DjlC2F8YJW7v
        suxi5AKyPzNKzP9xEa7h4o6TLBCJ5YwSt07/ZIKrern7LFRmJ6PEufNfgOZycPAK2EkcWCcC
        0s0ioCrRvfsbI4jNKyAocXLmExYQW1QgQmLarDNgG4QFkiR2PPgAVsMsIC5x68l8JhBbREBU
        4tL+FWDzmQVuMEksu7KXBWQ+m4CWRGMn2AucAsYSr1u3sUD0akq0bv/NDmHLS2x/O4cZ4gNF
        iZsrf0F9Uyux9tgZdpCZEgKHOSV+XYVJuEis+nodqkFY4tXxLewQtozE6ck9LBB2tcTTG7+Z
        IZpbGCX6d65nAzlIQsBaou9MDkSNo0RT3weoMJ/EjbeCEPfwSUzaNp15AqPqLKSgmIXk5VlI
        XpiF5IUFjCyrGMVTS4tz01OLjfNSy/WKE3OLS/PS9ZLzczcxAhPb6X/Hv+5gXPHqo94hRiYO
        xkOMEhzMSiK8BhUNSUK8KYmVValF+fFFpTmpxYcYpTlYlMR5kzM3JAoJpCeWpGanphakFsFk
        mTg4pRqYOOIuqSb8XmOhYnp4e2LYfZ0qOaMYVW3PG7tbNZ8LXHH46RuqJVws1WXkxGtnInz/
        6Z5D4W4Nsvy/Vq5MY7D3jNBbvvSBw/fpgbol2ZOrmFVuz7dx+6V+z/HsKpeipKeRG3981Lpf
        +qyW+YXv/8aTk4VPP7X+ZXlKi9v8ue7xRQrP1LJ6eWp0NA9mZCp659274l2etUGOx8zodj+r
        saiJ/x+ZSXU8F7ITbws/5YrtVpz0hG3XKsM7X177bmYMSnmwXF7OTL91fzFvR6WFVKlR8D79
        jd98qz91SjCHTt0j45qZsXB2CouGhb/Oj7gDYfI3+7wOlqZHMXxSPS3f8DvdWOWtyJHfF/Km
        cW82VmIpzkg01GIuKk4EAN5Uwi7bAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsVy+t/xu7p/QpqTDI5/1rXY+242q8WFH41M
        Fot/f2exWLn6KJNFz4EPLBZ7b2lbXHq8gt1iz96TLBaXd81hs5i/7Cm7xY0JTxkt1tx8yuLA
        4/HvxBo2j52z7rJ7bFrVyeaxeUm9x+6bDWwe7/ddZfNYv+Uqi8eZBUfYPT5vkgvgjNKzKcov
        LUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLWNKcW9DGUdH0
        8w5TA+NRti5GTg4JAROJiztOsnQxcnEICSxllOj40scIkZCR+HTlIzuELSzx51oXG0TRR0aJ
        eRu3MUM4Oxkl/h55w9TFyMHBK2AncWCdCEgDi4CqRPfub2CDeAUEJU7OfMICYosKREg82H2W
        FcQWFkiS2PHgA1gNs4C4xK0n85lAbBEBUYlL+1dAXfSCUaL/0nKwzcwCN5gkll3ZywKyjE1A
        S6KxE+w6TgFjidet21ggBmlKtG7/zQ5hy0tsfzuHGeIDRYmbK39BvVwr8er+bsYJjKKzkNw3
        C8kds5CMmoVk1AJGllWMIqmlxbnpucWGesWJucWleel6yfm5mxiBKWHbsZ+bdzDOe/VR7xAj
        EwfjIUYJDmYlEV6DioYkId6UxMqq1KL8+KLSnNTiQ4ymwECayCwlmpwPTEp5JfGGZgamhiZm
        lgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1MUeHPhW7ptaWvmbnOQvlmVln5oQDB
        U8xe0uvK7ViXp9qK3Xfa/lrnhkKfjPL5CHf3fXsYJuSzfn0p+FfFjjP59L/HWy/ETpHQVNtW
        q53T8v2hFtu5+NwF/wOrdhQLXE2xXjb7vYXS8uVr9/e6n1qp2GEVnqC7wuSvTctb80VnHK2D
        dScxBykzWLL9EC+Z1edpENz66dSstLMFXot3dBgc0r7DFDr7yu5L5xeaSWaa575g3bc/JY4r
        RNE7MTO5qOa1wK+3uSqeCbZTElis+ZdoGwe3eJ8KmTb3cChD5PaDbskrD74542l+JvnnjWsv
        A700wpriP2w49jtMy8OhlyGTZ73ivY5/Kl2Ox24ENiixFGckGmoxFxUnAgCKt6OGkgMAAA==
X-CMS-MailID: 20220517075540eucas1p126d19be7cc8d727e072f48bd3212684d
X-Msg-Generator: CA
X-RootMTR: 20220516165425eucas1p29fcd11d7051d9d3a9a9efc17cd3b6999
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220516165425eucas1p29fcd11d7051d9d3a9a9efc17cd3b6999
References: <20220516165416.171196-1-p.raghav@samsung.com>
        <CGME20220516165425eucas1p29fcd11d7051d9d3a9a9efc17cd3b6999@eucas1p2.samsung.com>
        <20220516165416.171196-6-p.raghav@samsung.com>
        <20220516215826.GZ18596@twin.jikos.cz>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-05-16 23:58, David Sterba wrote:
>> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>> ---
>>  fs/btrfs/zoned.c | 13 +++++++++----
>>  fs/btrfs/zoned.h |  1 +
>>  2 files changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
>> index 06f22c021..e8c7cebb2 100644
>> --- a/fs/btrfs/zoned.c
>> +++ b/fs/btrfs/zoned.c
>> @@ -511,6 +511,11 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
>>  			   max_active_zones - nactive);
>>  	}
>>  
>> +	/* Cache the sb zone number */
>> +	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; ++i) {
>> +		zone_info->sb_zone_location[i] =
>> +			sb_zone_number(zone_info->zone_size_shift, i);
>> +	}
> 
> I don't think we need to cache the value right now, it's not in any hot
> path and call to bdev_zone_no is relatively cheap (only dereferencing a
> few pointers, all in-memory values).
Ok. I will fix it up in the next revision! Thanks.
