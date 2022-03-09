Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E164D27D3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 05:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiCIEYc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 23:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiCIEYa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 23:24:30 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91984522C8
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 20:23:31 -0800 (PST)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220309042328epoutp014e2c7da0b998255c5757c5c60640368d~am7NndpDX2533925339epoutp01H
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Mar 2022 04:23:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220309042328epoutp014e2c7da0b998255c5757c5c60640368d~am7NndpDX2533925339epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646799808;
        bh=R+5MFabA9b+sam2wOPtEv1/EIjHnzZeKhYisnvKky8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s+M1BRzR+OpRQSvmxo/1OjaCszVUm0rHdxjMyHErL3QPX1J2Gk769eUHPebHIbBcV
         WexNuS/vCXUC14I4zhNPWs6uXJY1KFPIhcZ47fuy2mLwNRXIayoXTvqASVCFmfY83J
         mZ1In9oq5O8jxr4QRW/KdGfVSEVDuOxIpK4WyQM8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220309042327epcas1p2e2702303bee5d532b775a7ac167275c1~am7MaRUe62900029000epcas1p2T;
        Wed,  9 Mar 2022 04:23:27 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.248]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KCzb11WpFz4x9Q3; Wed,  9 Mar
        2022 04:23:25 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.22.28648.DBB28226; Wed,  9 Mar 2022 13:23:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220309042324epcas1p111312e20f4429dc3a17172458284a923~am7JxI2_D2642326423epcas1p1k;
        Wed,  9 Mar 2022 04:23:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220309042324epsmtrp2c0e49ce98be7c4a571daa01cf2f7ab5f~am7JwJC_c2497624976epsmtrp2C;
        Wed,  9 Mar 2022 04:23:24 +0000 (GMT)
X-AuditID: b6c32a39-ff1ff70000006fe8-c2-62282bbd690a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.92.29871.CBB28226; Wed,  9 Mar 2022 13:23:24 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.109]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220309042324epsmtip2f332f5ca779a6d3f69bae5aa09ef2c40~am7JhWGXh2495824958epsmtip2Z;
        Wed,  9 Mar 2022 04:23:24 +0000 (GMT)
From:   Manjong Lee <mj0123.lee@samsung.com>
To:     david@fromorbit.com
Cc:     axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-raid@vger.kernel.org,
        sagi@grimberg.me, song@kernel.org, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, nanich.lee@samsung.com,
        woosung2.lee@samsung.com, yt0928.kim@samsung.com,
        junho89.kim@samsung.com, jisoo2146.oh@samsung.com
Subject: Re: [PATCH 2/2] block: remove the per-bio/request write hint.
Date:   Wed,  9 Mar 2022 22:31:19 +0900
Message-Id: <20220309133119.6915-1-mj0123.lee@samsung.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220306231727.GP3927073@dread.disaster.area>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRmVeSWpSXmKPExsWy7bCmru5ebY0kg8XvWC1W3+1ns9hy7B6j
        xcrVR5ksep40sVp8fVhsMenQNUaLvbe0LfbsPcliMX/ZU3aL9vm7GC2u3T/DbrHu9XsWi3Mn
        P7FaHF/+l81i3mMHi1M7JjNbrN/7k81B0OPUIgmP8/c2snhcPlvqsWlVJ5vH5iX1HrtvNrB5
        9G1ZxejxeZNcAEdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKL
        T4CuW2YO0AdKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKzAr3ixNzi0rx0vbzU
        EitDAwMjU6DChOyMiyunsBSc4K24cpWrgfEpVxcjJ4eEgInEw3kbmbsYuTiEBHYwSiz5cJ8V
        wvnEKPHg5HomCOcbo8TLZUcZYVruLj/EDpHYyyix+9dfqJbPjBLzTs5iBaliE9CSWP7sAjuI
        LSIgLnGvrResiFmgi1ni8u5uli5GDg5hATeJE4v8QWpYBFQlOntusIHYvAJWEi13f7BBbJOX
        OLXsIBOIzSlgLTFt/TNWiBpBiZMzn7CA2MxANc1bZ4M9ISFwgkOife9vJohmF4kVU5awQ9jC
        Eq+Ob4GypSQ+v9sLtaBYYsutyWD3SAhUSPR2xUKEjSU+ff7MCBJmFtCUWL9LHyKsKLHz91xG
        iLV8Eu++9rBCdPJKdLQJQZSoSOxu/ga36M2rA4wQJR4SZ485QkKqj1Hi2/23jBMYFWYheWYW
        kmdmISxewMi8ilEstaA4Nz212LDAFB6/yfm5mxjB6VnLcgfj9Lcf9A4xMnEwHmKU4GBWEuG9
        f14lSYg3JbGyKrUoP76oNCe1+BCjKTCoJzJLiSbnAzNEXkm8oYmlgYmZkYmFsaWxmZI476pp
        pxOFBNITS1KzU1MLUotg+pg4OKUamFZaCW8PWsDeFJnhUmR875LkuQdWcS1vr+++GO60yyY8
        0Z6xPU/IwHzSh3IV/7d3K7bt+xpydPX8djXDkn478/6mHF2ZRz8WmiRJsqgFOZvxd226qvb2
        p1TiofUfJjJof9Hf9v18usW9bz/Sa33t+Z4r/ZH51/njEr/jGY6NMcq/9MI1eupytZ46f3R5
        tFD69302uxD+bRacekfjDorGWl/fuKH+wbype7Y6cOcu5+IoW/DzO8e6UkXBo0d5dl0037Wr
        5t+sHF2jyd0hNawfdN65Wx9aXmu754RZ0RP1Y3v9ebUPvdNQXHelurbyCpeJjaHrSybPcJ5I
        5xOsB6JknSU+33fN91c8lZxx6LCwEktxRqKhFnNRcSIAEcYqGlgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42LZdlhJXnePtkaSwZRNIhar7/azWWw5do/R
        YuXqo0wWPU+aWC2+Piy2mHToGqPF3lvaFnv2nmSxmL/sKbtF+/xdjBbX7p9ht1j3+j2LxbmT
        n1gtji//y2Yx77GDxakdk5kt1u/9yeYg6HFqkYTH+XsbWTwuny312LSqk81j85J6j903G9g8
        +rasYvT4vEkugCOKyyYlNSezLLVI3y6BK+PiyiksBSd4K65c5WpgfMrVxcjJISFgInF3+SH2
        LkYuDiGB3YwS86++YoVISEnMW9vA1sXIAWQLSxw+XAxR85FR4sP5dkaQGjYBLYnlzy6wg9gi
        AuIS99p6WUGKmAXmMUvMWT6RBaRZWMBN4sQif5AaFgFVic6eG2wgNq+AlUTL3R9sELvkJU4t
        O8gEYnMKWEtMW/8M7AYhoJrOE+eYIeoFJU7OfMICYjMD1Tdvnc08gVFgFpLULCSpBYxMqxgl
        UwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgiNJS3MH4/ZVH/QOMTJxMB5ilOBgVhLhvX9e
        JUmINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGJuX9D/0d
        s6bdPntEzXbbMb+ZeyL+ZckWbkwvDTo+YZN0nbDPjAzBDYuKH/voBeYdlosy+eIXpfZV78ez
        2M40Xv0/+87v0zJ8m/y64EPz/Ufl1k4XvHOlNmaeO6UdfHjZvRuS/vG7lzh2BK3KDzv244fb
        X4PpkjtXZ39RmZE45UN/jc5D7ZNbbr/ZHaPz8e+8wP2HGg98m/NixkTWzK8TdZr0bC/utY21
        qlY2Tzphv+bqq23Ms7LOzntw6ty/sOoDwkIatkdWp97KFU+qnrXYkt33+BuJGVuee/XLHJ9V
        Pu3iu/r0CuHFCjcdzH0Wfc5RbrY4q9MreyFOvd55od3a4p7ER/vEu9rEkiY8Tn7ySFiJpTgj
        0VCLuag4EQAjGlMpEwMAAA==
X-CMS-MailID: 20220309042324epcas1p111312e20f4429dc3a17172458284a923
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220309042324epcas1p111312e20f4429dc3a17172458284a923
References: <20220306231727.GP3927073@dread.disaster.area>
        <CGME20220309042324epcas1p111312e20f4429dc3a17172458284a923@epcas1p1.samsung.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>On Sun, ddMar 06, 2022 at 11:06:12AM -0700, Jens Axboe wrote:
>> On 3/6/22 11:01 AM, Christoph Hellwig wrote:
>> > On Sun, Mar 06, 2022 at 10:11:46AM -0700, Jens Axboe wrote:
>> >> Yes, I think we should kill it. If we retain the inode hint, the f2fs
>> >> doesn't need a any changes. And it should be safe to make the per-file
>> >> fcntl hints return EINVAL, which they would on older kernels anyway.
>> >> Untested, but something like the below.
>> > 
>> > I've sent this off to the testing farm this morning, but EINVAL might
>> > be even better:
>> > 
>> > http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/more-hint-removal
>
>Yup, I like that.
>
>> I do think EINVAL is better, as it just tells the app it's not available
>> like we would've done before. With just doing zeroes, that might break
>> applications that set-and-verify. Of course there's also the risk of
>> that since we retain inode hints (so they work), but fail file hints.
>> That's a lesser risk though, and we only know of the inode hints being
>> used.
>
>Agreed, I think EINVAL would be better here - jsut make it behave
>like it would on a kernel that never supported this functionality in
>the first place. Seems simpler to me for user applications if we do
>that.
>
>Cheers,
>
>Dave.
>-- 
>Dave Chinner
>david@fromorbit.com
>

Currently, UFS device also supports hot/cold data separation 
and uses existing write_hint code.

In other words, the function is also being used in storage other than NVMe,
and if it is removed, it is thought that there will be an operation problem.

If the code is removed, I am worried about how other devices
that use the function.

Is there a good alternative?
