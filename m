Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5947F6BCC0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 11:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjCPKIW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 06:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjCPKIT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:08:19 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AC9A1FD4
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Mar 2023 03:07:45 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230316100744euoutp027cc91195fb90abff3f1e2873c5a95c1c~M3l-ctCWC1436614366euoutp02I
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Mar 2023 10:07:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230316100744euoutp027cc91195fb90abff3f1e2873c5a95c1c~M3l-ctCWC1436614366euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678961264;
        bh=/5KVLbY5EbFI+IEYeOG53hyhtyXgaXrgX9fqrbvA2kY=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=JUQuVLfWUqLd6aIm6j9/zDDnvQ0O1SoTxe/hf0KO8t6DZqznCIT/LBHc/D/ceuCBN
         4/e1kTHpq/vMsn+XFC0rGgcix9fGawMKYWPJZYt0FjqPspKhXzgqYvGf1BfGBAF8sM
         uKgM0WAUwybd5MN8RB0zUOLgeURGWLd49sLgE824=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230316100744eucas1p2091c328f81b5c7d3530f9b9a8e2cabec~M3l-M20OT0459504595eucas1p2X;
        Thu, 16 Mar 2023 10:07:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 68.36.09503.07AE2146; Thu, 16
        Mar 2023 10:07:44 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230316100743eucas1p2c47958a35d977b3cdc8f2624a25e7bfe~M3l_02bb_0456104561eucas1p26;
        Thu, 16 Mar 2023 10:07:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230316100743eusmtrp179409928ca5693e6acda839d27d15524~M3l_zqiuW1198011980eusmtrp1P;
        Thu, 16 Mar 2023 10:07:43 +0000 (GMT)
X-AuditID: cbfec7f2-e8fff7000000251f-92-6412ea70950b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5C.36.09583.F6AE2146; Thu, 16
        Mar 2023 10:07:43 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230316100743eusmtip2c14a68e7c74e1e30e25a0f1511fa316f~M3l_oOcme0556805568eusmtip2x;
        Thu, 16 Mar 2023 10:07:43 +0000 (GMT)
Received: from [192.168.8.107] (106.210.248.172) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 16 Mar 2023 10:07:23 +0000
Message-ID: <7121c937-adea-a495-eb15-8e0d7fe0838c@samsung.com>
Date:   Thu, 16 Mar 2023 11:07:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.8.0
Subject: Re: [RFC PATCH 2/3] mpage: use bio_for_each_folio_all in
 mpage_end_io()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Hannes Reinecke <hare@suse.de>
CC:     <hubcap@omnibond.com>, <senozhatsky@chromium.org>,
        <martin@omnibond.com>, <minchan@kernel.org>,
        <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <axboe@kernel.dk>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <gost.dev@samsung.com>, <mcgrof@kernel.org>,
        <devel@lists.orangefs.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <ZBHtjrk52/TTPU/F@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.172]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7djPc7oFr4RSDH5eY7GYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFnkWTmCza7/YxWey9pW2xZ+9JFovLu+awWdxb85/V4uT6/8wWNyY8ZbRY
        9vU9u8XujYvYLM7/Pc5q8fvHHDYHAY/ZDRdZPDav0PK4fLbUY9OqTjaPTZ8msXucmPGbxaNh
        6i02j1+377B6bD5d7fF5k5zHpidvmQK4o7hsUlJzMstSi/TtErgytvS2sxW0cVasWivQwDiF
        vYuRk0NCwETi0LxGVhBbSGAFo8TytzJdjFxA9hdGic/rZrBBOJ8ZJX7/es4I09G37TALRMdy
        Rom7t4Xgip6+nMQO4exmlFjSeQpsLq+AnUTDrFlg3SwCqhLLzr5ghogLSpyc+QRoEgeHqECU
        xIvXZSBhYYEgiXsbHrOB2MwC4hK3nsxnArFFBDwk/l9azgIyn1mgh1li7t3TjCC9bAJaEo2d
        YO9wAh3Xun8nK0SvpkTr9t/sELa8xPa3c5ghHlCWmPN6B5RdK3Fqyy0mCPsZp0TXFBsI20Xi
        xZ//UDXCEq+Ob4EGl4zE6ck9LBB2tcTTG7+ZQe6REGhhlOjfuZ4N5B4JAWuJvjM5EDWOEpsW
        TWGFCPNJ3HgrCHEOn8SkbdOZJzCqzkIKiFlIPp6F5INZSD5YwMiyilE8tbQ4Nz212DAvtVyv
        ODG3uDQvXS85P3cTIzAdnv53/NMOxrmvPuodYmTiYDzEKMHBrCTCG84ikCLEm5JYWZValB9f
        VJqTWnyIUZqDRUmcV9v2ZLKQQHpiSWp2ampBahFMlomDU6qBKUrZakG/X6yxrdB8TxbT2+n3
        JQtuct0NvGO3o61u8ekD57vtGK39l2/bcmPtn3UWnI6RNp1rn2059S2g7Jvp1JZdcf1eOpc2
        SXfOC7316PiPcz9u8345tvhMr/4y/nUiyxfuXH/j0nyh3/nCZ87/nHjQM3WC3ncOW+PJW8P/
        9Pyoq5E2Mvj49VVHQ6CqgNfF+11td1+/XVh1PGPij0+XloZcve5ZsWhHVZbxzPo/3yPS/u/W
        s3J9v6gpwstT/PJc9acenFbb55629ZnG0LFxb09O4rclBTtW1d+cz3h1Udei6SUL5Zjn8l5w
        vzLnXUCAdrlm5Ozn/4uNZXw9M42OsocfFKiwYxJQSUj36RfbulGJpTgj0VCLuag4EQAdOwYz
        9gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsVy+t/xe7r5r4RSDC7MU7eYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFnkWTmCza7/YxWey9pW2xZ+9JFovLu+awWdxb85/V4uT6/8wWNyY8ZbRY
        9vU9u8XujYvYLM7/Pc5q8fvHHDYHAY/ZDRdZPDav0PK4fLbUY9OqTjaPTZ8msXucmPGbxaNh
        6i02j1+377B6bD5d7fF5k5zHpidvmQK4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyN
        zWOtjEyV9O1sUlJzMstSi/TtEvQytvS2sxW0cVasWivQwDiFvYuRk0NCwESib9thFhBbSGAp
        o8S1PX4QcRmJT1c+QtUIS/y51sXWxcgFVPORUeJH51omCGc3o8SJ+1dZQap4BewkGmbNYgSx
        WQRUJZadfcEMEReUODnzCdgGUYEoiad3DoHFhQWCJO5teMwGYjMLiEvcejKfCcQWEfCQ+H9p
        OQtEvIdZ4lNbDcSyWUwSq6a/AEpwcLAJaEk0doJdxwn0Qev+nawQ9ZoSrdt/s0PY8hLb385h
        hvhAWWLO6x1Qdq3E57/PGCcwis5Cct4sJGfMQjJqFpJRCxhZVjGKpJYW56bnFhvpFSfmFpfm
        pesl5+duYgQmkm3Hfm7Zwbjy1Ue9Q4xMHIyHGCU4mJVEeMNZBFKEeFMSK6tSi/Lji0pzUosP
        MZoCw2gis5Rocj4wleWVxBuaGZgamphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBK
        NTBprS2/MfPhyn23GttEVmpOt7Pd9f3wh5wvOX93P/h26wyzm5Gh+omF4i458lP+tGhEPBVJ
        zdfYNEExYd6am3Hv89exTalwu33xy5GeijdytUmJDWqaUa+vx7BLv/GX3DYx+t1/seMfm6IL
        JgjInmv0qc06KbWN79Ur44xZXDrbje23JW0JeSI4/ckft/OPv048Fhm5f0ZCRO4q9oNvn8Yn
        lPSnd9yKcb+ozlT5rbTpaImd6/yMY1HvuPoELmQk/b8V3/Z3laavTNX1c/P59nfO4/67jWXp
        I59jW3YtdGe1nvRhrUPAkhePrl44LLWrwVNx5Tzvi7ycmwvL/Sb+MF3RvKjhvax91x2lf5zT
        +pOtlFiKMxINtZiLihMBweWkw60DAAA=
X-CMS-MailID: 20230316100743eucas1p2c47958a35d977b3cdc8f2624a25e7bfe
X-Msg-Generator: CA
X-RootMTR: 20230315123235eucas1p1bd62cb2aab435727880769f2e57624fd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230315123235eucas1p1bd62cb2aab435727880769f2e57624fd
References: <20230315123233.121593-1-p.raghav@samsung.com>
        <CGME20230315123235eucas1p1bd62cb2aab435727880769f2e57624fd@eucas1p1.samsung.com>
        <20230315123233.121593-3-p.raghav@samsung.com>
        <64a5e85e-4018-ed7d-29d4-db12af290899@suse.de>
        <ZBHtjrk52/TTPU/F@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-03-15 17:08, Matthew Wilcox wrote:
> On Wed, Mar 15, 2023 at 03:52:15PM +0100, Hannes Reinecke wrote:
>> On 3/15/23 13:32, Pankaj Raghav wrote:
>>> Use bio_for_each_folio_all to iterate through folios in a bio so that
>>> the folios can be directly passed to the folio_endio() function.
>>> +	bio_for_each_folio_all(fi, bio)
>>> +		folio_endio(fi.folio, bio_op(bio),
>>> +			    blk_status_to_errno(bio->bi_status));
>>>   	bio_put(bio);
>>>   }
>>
>> Ah. Here it is.
>>
>> I would suggest merge these two patches.
> 
> The right way to have handled this patch series was:
> 
> 1. Introduce a new folio_endio() [but see Christoph's mail on why we
> shouldn't do that]
> 2-n convert callers to use folios directly
> n+1 remove page_endio() entirely.
> 
> Note that patch n+1 might not be part of this patch series; sometimes
> it takes a while to convert all callers to use folios.
> 

This is definitely a much better way to handle these changes. Thanks willy.

> I very much dislike the way this was done by pushing the page_folio()
> call into each of the callers because it makes the entire series hard to
> review.
