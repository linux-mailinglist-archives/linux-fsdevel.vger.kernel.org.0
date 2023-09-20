Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CA37A754D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 10:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbjITIGc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 04:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjITIGa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:06:30 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F89BB4
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 01:06:24 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230920080622euoutp01e39188c461534c78ec1812962e3a0c80~GjNs8DjP60462804628euoutp01Y
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 08:06:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230920080622euoutp01e39188c461534c78ec1812962e3a0c80~GjNs8DjP60462804628euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695197183;
        bh=rL1dCDLUMScax9S9apPYzcJ5uUxJ+5qWTUoLNXdgSSM=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=Dd5bTxQZJYaAjj/Xc9q6TG0+PCfQ1rQDXsja8Kaz124lXDn174hvziInGxGKf9jiS
         g9lI0xUtQo1VB8eh+wSVENpx1xWuSwPL8efWM+n2aBpCDuatc2VuUo8ZZr4LS8MFVb
         wEcMGJLccpuMYYt6vv1kcta8QlvL7Ej/m2SPglMg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230920080622eucas1p1aecea517ed6ddabc4b068b22a3a174ec~GjNss009E1314313143eucas1p1K;
        Wed, 20 Sep 2023 08:06:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 3D.CD.37758.EF7AA056; Wed, 20
        Sep 2023 09:06:22 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230920080622eucas1p1e49881e06c0abda7eb7e4fdbdc40fe79~GjNsL8kTE1874818748eucas1p1V;
        Wed, 20 Sep 2023 08:06:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230920080622eusmtrp2525e8133b66a51b136356a133cd1ced0~GjNsLTzWx2686926869eusmtrp2a;
        Wed, 20 Sep 2023 08:06:22 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-77-650aa7fe0602
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BA.03.10549.EF7AA056; Wed, 20
        Sep 2023 09:06:22 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230920080621eusmtip1f15a2c8851daacf5095238f550ad26c1~GjNr_bsIn2781827818eusmtip1M;
        Wed, 20 Sep 2023 08:06:21 +0000 (GMT)
Received: from [192.168.170.212] (106.210.248.121) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 20 Sep 2023 09:06:20 +0100
Message-ID: <361498b3-e83f-a82c-b1e8-e44720d16fdd@samsung.com>
Date:   Wed, 20 Sep 2023 10:06:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.15.1
Subject: Re: [RFC 03/23] filemap: add folio with at least mapping_min_order
 in __filemap_get_folio
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Pankaj Raghav <kernel@pankajraghav.com>
CC:     <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <david@fromorbit.com>, <da.gomez@samsung.com>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <djwong@kernel.org>, <linux-mm@kvack.org>,
        <chandan.babu@oracle.com>, <mcgrof@kernel.org>,
        <gost.dev@samsung.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <ZQSpthmXGzHDbx1h@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.121]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7djP87r/lnOlGlx6rGYxZ/0aNotLR+Us
        thy7x2hx+QmfxZmXn1ks9uw9yWJxedccNot7a/6zWuz6s4Pd4saEp4wWv3/MYXPg9ji1SMJj
        8wotj02rOtk8Nn2axO5xYsZvFo+PT2+xeJxd6ejxeZNcAEcUl01Kak5mWWqRvl0CV8a8zbYF
        fVwVf5ZOYmpgfMPexcjJISFgIvFhz2HmLkYuDiGBFYwS7YtnMkI4Xxgl3j1bwQbhfGaUeNN2
        jBWm5fSbKUwQieWMEhc+72OBq7p68wU7hLOXUWLijEdsIC28AnYSR7/vZgSxWQRUJfpvTIWK
        C0qcnPmEBcQWFYiWmDltIViNsECKxI6Hq5hAbGYBcYlbT+YD2RwcIgLBEq/PmoHMZxZYyiTx
        4exvFpA4m4CWRGMn2EOcQNfd3HibBaJVU6J1+292CFteYvvbOcwQHyhLnNr+HRoAtRKnttwC
        +0ZCYDWnxK7GXUwQCReJGw/fskDYwhKvjm+BapCR+L9zPlRNtcTTG7+ZIZpbGCX6d65nAzlI
        QsBaou9MDkSNo0TLzFvsEGE+iRtvBSHu4ZOYtG068wRG1VlIITELycezkLwwC8kLCxhZVjGK
        p5YW56anFhvnpZbrFSfmFpfmpesl5+duYgSmsNP/jn/dwbji1Ue9Q4xMHIyHGCU4mJVEeHPV
        uFKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ82rbnkwWEkhPLEnNTk0tSC2CyTJxcEo1MAWELXRo
        vMDz0ojX8MqERzXhDxymcue7/zPm+PE4uW3yFYXy1rpV03LMm4VvTuEOTw42n3Li5dznR8Xk
        4ya4T1jQynMjh5fpvsOhVX2S/C1sXl4TJ/uFs3kkPUo/Y2Og0vikcf/Fx68PzrDvWP8/bsPS
        Wi5NpkORKRcEIvR3L/2+WWTy36vHXkRP9Fon/SctxfTc0/Z5K9U8V8k87ukzi9OIkNdkCJfa
        M+nXhqLj62OVvk8LWLLhc42vUWOczptdGseWVdaE9LVlvfFTe1IiHmWwbu2ViUEf6npayyLU
        90TW77IsvzU7RarSZWdmjP8ppl+bVJzPvQp+eETHS/yGWcCmy+XGqwvuWFW3ro1lVmIpzkg0
        1GIuKk4EACaTlwfQAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsVy+t/xu7r/lnOlGvxtY7GYs34Nm8Wlo3IW
        W47dY7S4/ITP4szLzywWe/aeZLG4vGsOm8W9Nf9ZLXb92cFucWPCU0aL3z/msDlwe5xaJOGx
        eYWWx6ZVnWwemz5NYvc4MeM3i8fHp7dYPM6udPT4vEkugCNKz6Yov7QkVSEjv7jEVina0MJI
        z9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2PeZtuCPq6KP0snMTUwvmHvYuTkkBAw
        kTj9ZgpTFyMXh5DAUkaJ+Q9ns0EkZCQ2frnKCmELS/y51sUGUfSRUWJx1wMWCGcvo8SMe1/A
        qngF7CSOft/NCGKzCKhK9N+YygYRF5Q4OfMJUAMHh6hAtETXS2OQsLBAisSGuw1gJcwC4hK3
        nsxnAikREQiWeH3WDGQ8s8BSJokPZ3+zwC0+8u8qO0gRm4CWRGMn2AecQB/c3HibBWKOpkTr
        9t/sELa8xPa3c5ghHlCWOLX9O9THtRKf/z5jnMAoOgvJdbOQnDELyahZSEYtYGRZxSiSWlqc
        m55bbKhXnJhbXJqXrpecn7uJERj324793LyDcd6rj3qHGJk4GA8xSnAwK4nw5qpxpQrxpiRW
        VqUW5ccXleakFh9iNAUG0URmKdHkfGDiySuJNzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnN
        Tk0tSC2C6WPi4JRqYEq9coVTc77y5yOx3/+LLH1+/Urm/POu87NKA/jzjhtmea2OublGU+KF
        W82y3I7FSnKxu/4Kzn+4+Oya1ndH/s/3CtPST1Zfe35lxw//s7prIz/u5z/emHCc53xxzJGE
        /POykX5/b1yRuXOru039Yczf46pzNP2OPn00cVfO6nuz0i7eebnwV+NL72/H2LiPrfyQGbMk
        uetpMM8LgZXarDKWUVGSk9/NlnbOWyKzp2Gf+tf4SykM1baVUx6f83Y9V3FarPl5s9dHnZJM
        IYdllXbFBy8abGI3XC2SfPHv6e023ySSDhc8W9wp+Ouda/9et3/cewoOB0ds9z8UL6XwQbPj
        0L6a2eUqQm4JS4NuLehXYinOSDTUYi4qTgQA56HPEYQDAAA=
X-CMS-MailID: 20230920080622eucas1p1e49881e06c0abda7eb7e4fdbdc40fe79
X-Msg-Generator: CA
X-RootMTR: 20230915190017eucas1p2ae10e22f9bf758d554f20e4cd8d99b0d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230915190017eucas1p2ae10e22f9bf758d554f20e4cd8d99b0d
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
        <20230915183848.1018717-4-kernel@pankajraghav.com>
        <CGME20230915190017eucas1p2ae10e22f9bf758d554f20e4cd8d99b0d@eucas1p2.samsung.com>
        <ZQSpthmXGzHDbx1h@casper.infradead.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-09-15 21:00, Matthew Wilcox wrote:
> On Fri, Sep 15, 2023 at 08:38:28PM +0200, Pankaj Raghav wrote:
>> +++ b/mm/filemap.c
>> @@ -1862,6 +1862,10 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>>  		fgf_t fgp_flags, gfp_t gfp)
>>  {
>>  	struct folio *folio;
>> +	int min_order = mapping_min_folio_order(mapping);
>> +	int nr_of_pages = (1U << min_order);
>> +
>> +	index = round_down(index, nr_of_pages);
>>  
>>  repeat:
>>  	folio = filemap_get_entry(mapping, index);
>> @@ -1929,8 +1933,14 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>>  			err = -ENOMEM;
>>  			if (order == 1)
>>  				order = 0;
>> +			if (order < min_order)
>> +				order = min_order;
> 
> ... oh, you do something similar here to what I recommend in my previous
> response.  I don't understand why you need the previous patch.
> 

Hmm, we made changes here a bit later and that is why it is a duplicated
I guess in both iomap fgf order and clamping the order here to min_order. We could
remove the previous patch and retain this one here.

>> +			if (min_order)
>> +				VM_BUG_ON(index & ((1UL << order) - 1));
> 
> You don't need the 'if' here; index & ((1 << 0) - 1) becomes false.
> 

Sounds good!
