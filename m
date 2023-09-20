Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3759C7A74B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 09:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbjITHr2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 03:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbjITHrE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:47:04 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706041B7
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 00:46:42 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230920074639euoutp01232c646a4b448b518cc82c980b8574fe~Gi8ex-SQp1349913499euoutp01s
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 07:46:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230920074639euoutp01232c646a4b448b518cc82c980b8574fe~Gi8ex-SQp1349913499euoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695195999;
        bh=mpadb/9tFj+5PzcSP6XTgQODzpOlX5ctR1kmrU44hZQ=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=RqiJiqir9mni6uSwxjTyCnAyWsdN66fOTrl3lQQdEGPJKUJ45r+ASLOrVcv36+UK1
         0aTPfkQlZE6CZ6N5HikIWQtuv+04NMYz4datyc8HU9DzNSvYtr+77Q/qltcH+TQcK2
         6HcspKq0gtSmF4a45V7nVv9l8Mml8UUX5krX5mNY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230920074639eucas1p2315f875b51eefe3573cc37eed8e420d1~Gi8eV8OOj2272522725eucas1p2x;
        Wed, 20 Sep 2023 07:46:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 23.C8.37758.E53AA056; Wed, 20
        Sep 2023 08:46:39 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230920074638eucas1p2f7dfdd629156a591697f8ba3376446e8~Gi8dldIsw1101511015eucas1p2H;
        Wed, 20 Sep 2023 07:46:38 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230920074638eusmtrp267241c28aabb2e2e221d362156a13169~Gi8dh4NqC1560015600eusmtrp2C;
        Wed, 20 Sep 2023 07:46:38 +0000 (GMT)
X-AuditID: cbfec7f5-01f15a800002937e-11-650aa35e2c32
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A6.EE.10549.E53AA056; Wed, 20
        Sep 2023 08:46:38 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230920074637eusmtip1832c020440adb3cb8ad9bab001921d4e~Gi8dT7wug1555115551eusmtip1w;
        Wed, 20 Sep 2023 07:46:37 +0000 (GMT)
Received: from [192.168.8.209] (106.210.248.121) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 20 Sep 2023 08:46:36 +0100
Message-ID: <fb53a533-e430-eb1b-9e2c-ef424e466db4@samsung.com>
Date:   Wed, 20 Sep 2023 09:46:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.15.1
Subject: Re: [RFC 02/23] pagemap: use mapping_min_order in fgf_set_order()
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
In-Reply-To: <ZQSokGztDTbXBxBU@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.121]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7djP87rxi7lSDU6VWsxZv4bN4tJROYst
        x+4xWlx+wmdx5uVnFos9e0+yWFzeNYfN4t6a/6wWu/7sYLe4MeEpo8XvH3PYHLg9Ti2S8Ni8
        Qstj06pONo9Nnyaxe5yY8ZvF4+PTWyweZ1c6enzeJBfAEcVlk5Kak1mWWqRvl8CVcWuZVsFH
        9opj6x+yNDBeZe1i5OSQEDCReHPoC5DNxSEksIJR4vqGOywQzhdGiU1fF7NDOJ8ZJaY2PmKG
        aWnYchCqajmjxPKbl5nhqp6dfwQ1bDdQ/6vd7CAtvAJ2EsvW/GACsVkEVCWu3FzHBhEXlDg5
        8wkLiC0qEC0xc9pCRhBbWMBL4s2Ml2DrmAXEJW49mQ/Uy8EhIhAs8fqsGch8ZoGlTBIfzv5m
        AYmzCWhJNHaCreIEuu7unq9sEK2aEq3bf7ND2PIS29/OgfpAWeLU9u/sEHatxKktt5hAZkoI
        LOeU+Lt8NRtEwkWiqWMrNJSEJV4d3wLVICPxf+d8Jgi7WuLpjd/MEM0tjBL9O9ezgRwkIWAt
        0XcmB6LGUWLR82WMEGE+iRtvBSHu4ZOYtG068wRG1VlIITELycezkLwwC8kLCxhZVjGKp5YW
        56anFhvnpZbrFSfmFpfmpesl5+duYgQmsNP/jn/dwbji1Ue9Q4xMHIyHGCU4mJVEeHPVuFKF
        eFMSK6tSi/Lji0pzUosPMUpzsCiJ82rbnkwWEkhPLEnNTk0tSC2CyTJxcEo1MJXus/rPu/Bt
        /P+/TyXl7pX+fHAyhqfPZ/qlEDWxnQ+q5jptvhyy35n/3I7HsTwzhYuXNX0KFHWUudcjYOEQ
        0yqsyLErZ3r2saUmfvunO1RqLei8xSmbcY+/9GCASLLnSumF50O2L9xsUbZM3PQh499r13cG
        zXvB+OUM0/vfh1/HfV6a/sX9i/eJ+3f/8Kx/Kq8s4bd0jbL0sgn7Np30fquzr1V+I8uqtF+r
        H3rKtwXrpK9OsLXn1VdMn1nxbN9CF9cP01xvhd5LKXBtPZv70FNk8bwdZtFehtfW552eJnir
        6uIl28Ckx/171dZOPHWr3lnvbv2mDdv5na9O6le6uZo9+uab7JAWb7v5wrcEFycqsRRnJBpq
        MRcVJwIAsTFFx88DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsVy+t/xu7pxi7lSDf7cZbOYs34Nm8Wlo3IW
        W47dY7S4/ITP4szLzywWe/aeZLG4vGsOm8W9Nf9ZLXb92cFucWPCU0aL3z/msDlwe5xaJOGx
        eYWWx6ZVnWwemz5NYvc4MeM3i8fHp7dYPM6udPT4vEkugCNKz6Yov7QkVSEjv7jEVina0MJI
        z9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+PWMq2Cj+wVx9Y/ZGlgvMraxcjJISFg
        ItGw5SBLFyMXh5DAUkaJRwuPMEMkZCQ2foEpEpb4c62LDaLoI6PEti0/oDp2M0oc2D+VDaSK
        V8BOYtmaH0wgNouAqsSVm+ug4oISJ2c+AWrg4BAViJboemkMEhYW8JJ4M+Ml2DJmAXGJW0/m
        M4GUiAgES7w+awYynllgKZPEh7O/WeAWNzy6xQZSxCagJdHYyQ7Sywn0wd09X9kg5mhKtG7/
        zQ5hy0tsfzsH6hlliVPbv7ND2LUSn/8+Y5zAKDoLyXWzkJwxC8moWUhGLWBkWcUoklpanJue
        W2yoV5yYW1yal66XnJ+7iREY99uO/dy8g3Heq496hxiZOBgPMUpwMCuJ8OaqcaUK8aYkVlal
        FuXHF5XmpBYfYjQFBtFEZinR5Hxg4skriTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5N
        LUgtgulj4uCUamCy1uEMWfyofLkd3/mAoAvfa/dVvb9eH+YSc+ugsQBLbdntntBttV1zIkoi
        RSfzfSmf9z4rulF807PExjXCzxOyXi5WcZcV9lVvEt20ddaf4zF6WVen1n2YUZwYu6YoxHqu
        Qf5179U9nzWcL26aHWyu3b5W4r5ztNSxLE6tS+dZjntv9S8tiD/BYik4Y/bRapsdP3s1JT1n
        7NwisLzxxoP9FRNZ5EvypuxfmX/GR21ekaLk/cKmxaq6W5YzRi9nE7BaOX1a3m8VazudE+1l
        ASxpy1a7vti8wrJRo9xPXbg0rewfw6dj810FzL87Tmi8OkPh344DjvcWX/xmVXPC4oj5SSb9
        dTGLa5l03+na3FFiKc5INNRiLipOBAAZe6NShAMAAA==
X-CMS-MailID: 20230920074638eucas1p2f7dfdd629156a591697f8ba3376446e8
X-Msg-Generator: CA
X-RootMTR: 20230915185527eucas1p1dc822c08a58effe30e3bf487103b22a0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230915185527eucas1p1dc822c08a58effe30e3bf487103b22a0
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
        <20230915183848.1018717-3-kernel@pankajraghav.com>
        <CGME20230915185527eucas1p1dc822c08a58effe30e3bf487103b22a0@eucas1p1.samsung.com>
        <ZQSokGztDTbXBxBU@casper.infradead.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-09-15 20:55, Matthew Wilcox wrote:
> On Fri, Sep 15, 2023 at 08:38:27PM +0200, Pankaj Raghav wrote:
>> From: Pankaj Raghav <p.raghav@samsung.com>
>>
>> fgf_set_order() encodes optimal order in fgp flags. Set it to at least
>> mapping_min_order from the page cache. Default to the old behaviour if
>> min_order is not set.
> 
> Why not simply:
> 

That is a good idea to move this to filemap instead of changing it in iomap. I will do that!

> +++ b/mm/filemap.c
> @@ -1906,9 +1906,12 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>                 folio_wait_stable(folio);
>  no_page:
>         if (!folio && (fgp_flags & FGP_CREAT)) {
> -               unsigned order = FGF_GET_ORDER(fgp_flags);
> +               unsigned order;
>                 int err;
> 
> +               order = min(mapping_min_folio_order(mapping),
> +                               FGF_GET_ORDER(fgp_flags));
> 

I think this needs to max(mapping..., FGF...)
