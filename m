Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C39F6D2010
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 14:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjCaMWG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 08:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjCaMVm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:21:42 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97571EFFA
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 05:21:12 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230331122047euoutp023cdaa314321d9051455b3db38e5ba7aa~RgFcODn2x2998929989euoutp02m
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 12:20:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230331122047euoutp023cdaa314321d9051455b3db38e5ba7aa~RgFcODn2x2998929989euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680265247;
        bh=RG0AskesBGxejlTr4JHEhK02MF/IWOxvFzpfN3R7npc=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=sEWO2dKySJf9bqBkoq2fkNFxwAwamiqJ5bOxce1NxpZX61XpF66PidxaF84lkquev
         ++ETNPtaWZbvBoFM+W6uSokTPuVsDNzpbcAsQREz9177zRQ6KDcSJVKD666vQWplV9
         jUBvS2BYT6A/G1RW/hKzXwYnSiqMy+MammGcX9dw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230331122046eucas1p2dd047848b60f9ddc31dd7b266bd86d77~RgFbxwOsi1098310983eucas1p24;
        Fri, 31 Mar 2023 12:20:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 14.78.09503.E10D6246; Fri, 31
        Mar 2023 13:20:46 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230331122046eucas1p247e0cd2d06229a6b7cae9cb26ea43d5b~RgFbZahPc1098310983eucas1p23;
        Fri, 31 Mar 2023 12:20:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230331122046eusmtrp238c8959c39aa187032906ac97e80131b~RgFbYiwNm2670526705eusmtrp2U;
        Fri, 31 Mar 2023 12:20:46 +0000 (GMT)
X-AuditID: cbfec7f2-ea5ff7000000251f-bf-6426d01eee9e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F3.4E.09583.E10D6246; Fri, 31
        Mar 2023 13:20:46 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230331122046eusmtip2b8baf2b87eb1e2370ba007aa92d0a40b~RgFbLcVLU2523725237eusmtip2g;
        Fri, 31 Mar 2023 12:20:46 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 31 Mar 2023 13:20:45 +0100
Date:   Fri, 31 Mar 2023 14:12:29 +0200
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
CC:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "Hannes Reinecke" <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, <linux-block@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <dm-devel@redhat.com>, Song Liu <song@kernel.org>,
        <linux-raid@vger.kernel.org>, Mike Snitzer <snitzer@kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        <jfs-discussion@lists.sourceforge.net>, <cluster-devel@redhat.com>,
        "Bob Peterson" <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        David Sterba <dsterba@suse.com>, <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 01/19] swap: use __bio_add_page to add page to bio
Message-ID: <20230331121156.7c7nbxfhagdufpzo@blixen>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7849b142e073b20f033e5124a39080f59e5f19d2.1680108414.git.johannes.thumshirn@wdc.com>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7djPc7pyF9RSDBZPM7TYtm43u8Xqu/1s
        FidXP2azaG3/xmSx991sVosLPxqZLPYsmsRksXL1USaLix9bmSz+dt1jsnh6dRZQyS1ti0uP
        V7Bb7Nl7ksXi3pr/rBbt83cxWhya3Mxk0TW7lc3i9p0fzBYnbklbHF/+l83i9485bA5iHptX
        aHlcPlvqsWlVJ5vHpk+T2D12L/jM5LH7ZgObR2/zOzaP9/uusnms33KVxWPz6WqPz5vkPNoP
        dDMF8ERx2aSk5mSWpRbp2yVwZcz/doOtYCNzxfprsQ2Mj5i6GDk5JARMJI5NaGHsYuTiEBJY
        wSixunsRG4TzhVFi1+QXrBDOZ0aJ7a+uw7WceLyHBSKxnFFiX9M2Rriq46eeQjlbGCUuntsE
        1sIioCqx4etl9i5GDg42AS2Jxk52kLCIgLHEle8LwSYxC5xmlVh4/QsrSEJYwE2ibepCsCJe
        oHVH7ixnhLAFJU7OfMICYjML6Egs2P2JDWQms4C0xPJ/HCBhToFEiZt7FkBdqiTRsPkMC4Rd
        K7G3+QA7hP2NU+LUCiEI20Vix+rNUPXCEq+Ob4GqkZH4v3M+VLxa4umN38wgd0oItDBK9O9c
        D7ZXQsBaou9MDoTpKLFrii2EySdx460gxJF8EpO2TWeGCPNKdLRBLVWT2NG0lXECo/IsJG/N
        QvLWLIS3FjAyr2IUTy0tzk1PLTbMSy3XK07MLS7NS9dLzs/dxAhMnKf/Hf+0g3Huq496hxiZ
        OBgPMUpwMCuJ8BYaq6YI8aYkVlalFuXHF5XmpBYfYpTmYFES59W2PZksJJCeWJKanZpakFoE
        k2Xi4JRqYGJ/Mq99ttHmVS9fhk9x2O7O7HvTf+/R+lhRfRXOv75H4oX0PF9zSC0zsTrB2Hsi
        eKO1iPxXL+MvIfrzNi9OcG46+ol153PN+JnpYbKbTDaqOVs9D1OquC2Qvc6bJZbv0SouaanZ
        J+X3chn66V2wn3wx+Nano/cD+ev+KYgXdvDKXHV6X3w0czGPM8dGn7d1vwrNFazUsroWMtkd
        +Ls72vL37s3Kn4871TzKdpGfZlo61e5ruFDCKqVOfjP5pt+WNy4fDn79+XDsAe7Oo6avAv35
        39y5bHdLp1fXyF+qKOcGH9MF62viPsXSs85vcJbSfPmjgyG4/s+0ABtmk9XT80s+SRrPL0wQ
        ULNpnrtUiaU4I9FQi7moOBEAP8WwqwsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsVy+t/xe7pyF9RSDK5cErfYtm43u8Xqu/1s
        FidXP2azaG3/xmSx991sVosLPxqZLPYsmsRksXL1USaLix9bmSz+dt1jsnh6dRZQyS1ti0uP
        V7Bb7Nl7ksXi3pr/rBbt83cxWhya3Mxk0TW7lc3i9p0fzBYnbklbHF/+l83i9485bA5iHptX
        aHlcPlvqsWlVJ5vHpk+T2D12L/jM5LH7ZgObR2/zOzaP9/uusnms33KVxWPz6WqPz5vkPNoP
        dDMF8ETp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXo
        Zcz/doOtYCNzxfprsQ2Mj5i6GDk5JARMJE483sMCYgsJLGWUeLRWCiIuI/Hpykd2CFtY4s+1
        LrYuRi6gmo+MEptubYFytjBKfJz6G6yKRUBVYsPXy0A2BwebgJZEYydYWETAWOLK94UsIPXM
        AqdZJT7PfskIkhAWcJNom7oQrIgX6Iojd5YzQlwxhVFi8msViLigxMmZT8CuYxbQkViw+xMb
        yHxmAWmJ5f84QMKcAokSN/csgHpGSaJh8xkWCLtWovPVabYJjMKzkEyahWTSLIRJCxiZVzGK
        pJYW56bnFhvpFSfmFpfmpesl5+duYgQmkG3Hfm7Zwbjy1Ue9Q4xMHIyHGCU4mJVEeAuNVVOE
        eFMSK6tSi/Lji0pzUosPMZoCQ2Iis5Rocj4wheWVxBuaGZgamphZGphamhkrifN6FnQkCgmk
        J5akZqemFqQWwfQxcXBKNTDFVzyrFHN98C7HflXCTe5DketvM5byVt4rXXFnmnXppfPP/gtl
        BZ5b8vLrudR/D3Iz/Fasl/4UvMc041N88wNOBgf+xBThdu+rZRy24sznqrl8jSra+Ll+/Yzt
        3xBydFb+naTaadW32p4G3VITy/E2PH3Ft25+7jOHcJGd0efa9vScOnT3UZHSofkuTbK2e6aF
        OpbGm31dtmbVN/uOqc+ubDQIvfkv/5/Jt4LA442q4pY3XU00w07n5CmwnVj63Te1aaPR/7fN
        6xx/JofOXyfrWGzyV7Sgq/yyyfkbxVGrbKvEPRfzpB0tL9sqLRthkNB5f0FPx8pVbt/eSXo8
        /JRkIvyyfrYM914byRPTBJRYijMSDbWYi4oTAXZ/WI2pAwAA
X-CMS-MailID: 20230331122046eucas1p247e0cd2d06229a6b7cae9cb26ea43d5b
X-Msg-Generator: CA
X-RootMTR: 20230331122046eucas1p247e0cd2d06229a6b7cae9cb26ea43d5b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230331122046eucas1p247e0cd2d06229a6b7cae9cb26ea43d5b
References: <cover.1680108414.git.johannes.thumshirn@wdc.com>
        <7849b142e073b20f033e5124a39080f59e5f19d2.1680108414.git.johannes.thumshirn@wdc.com>
        <CGME20230331122046eucas1p247e0cd2d06229a6b7cae9cb26ea43d5b@eucas1p2.samsung.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 29, 2023 at 10:05:47AM -0700, Johannes Thumshirn wrote:
> The swap code only adds a single page to a newly created bio. So use
> __bio_add_page() to add the page which is guaranteed to succeed in this
> case.
> 
> This brings us closer to marking bio_add_page() as __must_check.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks good,
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
