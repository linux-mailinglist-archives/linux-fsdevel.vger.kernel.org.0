Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60328702E03
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 15:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242063AbjEONYA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 09:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242037AbjEONX5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 09:23:57 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C53018E
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 06:23:56 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230515132352euoutp01bdb98b56bf7260d62aee81cac9fbfdbf~fU_YB4-FK0415904159euoutp018
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 13:23:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230515132352euoutp01bdb98b56bf7260d62aee81cac9fbfdbf~fU_YB4-FK0415904159euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684157033;
        bh=orhCRSnOAss1dL+QUGz6I3k7rSvikd5R9ejNEKRBfm8=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=fLu/gDwYCbjQj3xgcW/x++ZwVi5N8xTzHZF20wwdMynl4wpkJySmsSX+wMgU9ihFH
         UK8KiNKl4WoOc2x3BUUyf7E2m9Am98aQnZcEQDLK9dwOZ0WuKpXP2vgQxNhDHKnJwe
         l5uXcX5ksp5u4NMqOsvkSKvOnPs7v2eaN+Z1ufzo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230515132352eucas1p1358cc70b5533d75e364f6bc7539d934a~fU_XUiJZN2059420594eucas1p12;
        Mon, 15 May 2023 13:23:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F1.D5.42423.86232646; Mon, 15
        May 2023 14:23:52 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230515132351eucas1p2cb0cdd49c9a69e310fd356532f423fb9~fU_W83Xkn0832908329eucas1p2d;
        Mon, 15 May 2023 13:23:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230515132351eusmtrp2a73007560fa24a5f3b0e7e70abef681a~fU_W8Rsuq1695116951eusmtrp2P;
        Mon, 15 May 2023 13:23:51 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-d9-646232685ae0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id EC.19.10549.76232646; Mon, 15
        May 2023 14:23:51 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230515132351eusmtip1a4547dce31d74bded00ef41bb499d11c~fU_Ww1buA0829508295eusmtip1H;
        Mon, 15 May 2023 13:23:51 +0000 (GMT)
Received: from [106.110.32.65] (106.110.32.65) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 15 May 2023 14:23:50 +0100
Message-ID: <8dfaac46-e83a-0654-b1b8-974ebfaff421@samsung.com>
Date:   Mon, 15 May 2023 15:23:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.10.0
Subject: Re: [RFCv5 5/5] iomap: Add per-block dirty state tracking to
 improve performance
Content-Language: en-US
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
CC:     <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>, <mcgrof@kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <87v8guhu7n.fsf@doe.com>
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.65]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djPc7oZRkkpBidPcVl0vt/GbvHuc5XF
        lmP3GC1OLjrMaLFn70kWi11/drBb3JjwlNFi8cpQi4OnOtgtfv+Yw+bA5XFqkYTHzll32T3e
        nkvx2LxCy2PTqk42jwmLDjB6vN93lc3j8ya5AI4oLpuU1JzMstQifbsErozT8yoLZrJU9D84
        ydLAuJi5i5GDQ0LAROLlIpMuRi4OIYEVjBId85cxQzhfGCX6709k62LkBHI+M0rcWe0CYoM0
        NM5YxwRRtJxR4u7brVAOUNGBxonsEB07GSWW36wAsXkF7CTO/f0Ato5FQFViwQVviLCgxMmZ
        T1hAbFGBaInF+6aA2cJAduezR2BjmAXEJW49mc8EYosIGEk86F3FCLKLWWA3k8TrxzfYQWay
        CWhJNHaC1XMCjZ+6/DALRK+8xPa3c5ghjlaUmHTzPSuEXStxasstsJslBOZzSnxoeMIOkXCR
        OLL4OguELSzx6vgWqLiMxP+dEEdICFRLPL3xmxmiuQUYRDvXs0HC0Vqi70wOiMksoCmxfpc+
        RLmjRMOZY6wQFXwSN94KQpzGJzFp23TmCYyqs5BCYhaSj2ch+WAWwtAFjCyrGMVTS4tz01OL
        DfNSy/WKE3OLS/PS9ZLzczcxAtPV6X/HP+1gnPvqo94hRiYOxkOMEhzMSiK87TPjU4R4UxIr
        q1KL8uOLSnNSiw8xSnOwKInzatueTBYSSE8sSc1OTS1ILYLJMnFwSjUw+SiIPL/7ILjjcdLS
        AteMCMWdizZs2rW3VW7eTTeHtwJ/N/+P356uX3Fywnbr1n9hV1Z7is39LZhQW2zBd+chx5Nt
        nF9bxQ9J1K1p/f4j+ESBdaGc95Fpb45MW8M8t/6E5s4Jc99LzOi+qPPrY9qeYNWslNXPVDmn
        qbavY9/93H5D8AuZ4IC3R7m6BWtlXLJvrIt18vzZdKeQc9ZfU89tW+zaNN849rJ3T/l5xSmQ
        Lemc6L5GF7vsHXNdFq2zdJ9jNW2N3a4ux4+LVazjRBbYX0v3mK+gcXqBbl3b5ziXT3m8Pkms
        j8Iq3gceDHRzYHVTPCwb7/ExgvPKRmantwJTo3uqThbd3py39E5wfI2ZEktxRqKhFnNRcSIA
        wP0tfMYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsVy+t/xu7rpRkkpBrvm6Vl0vt/GbvHuc5XF
        lmP3GC1OLjrMaLFn70kWi11/drBb3JjwlNFi8cpQi4OnOtgtfv+Yw+bA5XFqkYTHzll32T3e
        nkvx2LxCy2PTqk42jwmLDjB6vN93lc3j8ya5AI4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0j
        E0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYzT8yoLZrJU9D84ydLAuJi5i5GTQ0LARKJxxjqm
        LkYuDiGBpYwSjxeeYoJIyEhs/HKVFcIWlvhzrYsNougjo8SmHWtYIZydjBLznz0C6+AVsJM4
        9/cD0FgODhYBVYkFF7whwoISJ2c+YQGxRQWiJW4s/wZWLgxkdzYeYwexmQXEJW49mQ8WFxEw
        knjQu4oRZD6zwG4miQUP3oAlhAQqJCYcncoEMp9NQEuisROslxNo1dTlh1kg5mhKtG7/DTVT
        XmL72zlQXypKTLr5HuqZWonPf58xTmAUnYXkvFlIzpiFZNQsJKMWMLKsYhRJLS3OTc8tNtQr
        TswtLs1L10vOz93ECIz2bcd+bt7BOO/VR71DjEwcjIcYJTiYlUR422fGpwjxpiRWVqUW5ccX
        leakFh9iNAUG0URmKdHkfGC6ySuJNzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C
        6WPi4JRqYGpd6ztBuCE+YpZndqVFFnfnTd2iaV06bSfrTV0+sM58oCF4xMO1glVsZ6pNo/vv
        D1IHK7lqLYK5eebaWHxlV4stUPGMT575y9PujvzP/rrIF3sOW05ck7XAzXqVcvbV9/3LxKfL
        nzvjkfdi+eL1MVGcGy3nXVNrym+7zZcRq3LuoN0645cV9dv6hPu45E7E/ci9VVfSEiQ1f0t/
        Lsui6d9qWE7URQdrKFm9Mqnh0J60f5mfzNJb8+44n2Zn5ZlXFMzltsvmq5/tlL81E9P+Lli6
        JpdrHltAougvi7BpDZWs+pP4C39FB8fuLKnijHwdsahNuGW2yne7v3WLJF4/Wmty9ILQmoJP
        /M4dx+uVWIozEg21mIuKEwF20BuOfwMAAA==
X-CMS-MailID: 20230515132351eucas1p2cb0cdd49c9a69e310fd356532f423fb9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230515083129eucas1p1ffa7194796a9d277274a865401c19a3c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230515083129eucas1p1ffa7194796a9d277274a865401c19a3c
References: <CGME20230515083129eucas1p1ffa7194796a9d277274a865401c19a3c@eucas1p1.samsung.com>
        <87v8guhu7n.fsf@doe.com>
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> 
> We set the per-block dirty status in ->write_begin. The check above happens in the
> writeback path when we are about to write the dirty data to the disk.
> What the check is doing is that, it checks if the block state is not dirty
> then skip it which means the block was not written to in the ->write_begin().
> Also the block with dirty status always means that the block is uptodate
> anyways.
> 
> Hope it helps!
> 

Definitely. I also checked your 1st RFC version to get more context. Thanks for
the explanation.
