Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB5F7A42D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 09:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240365AbjIRHdf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 03:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240618AbjIRHd0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:33:26 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DFEE52
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 00:33:03 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230918073300euoutp02e6543491c047cee5d7dcb6c9ccde902c~F7d-VuG782693126931euoutp02W
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 07:33:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230918073300euoutp02e6543491c047cee5d7dcb6c9ccde902c~F7d-VuG782693126931euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695022380;
        bh=dbgURMvRB5vglPwXNEinmDiIBwhTERpqxwujlCbmGpc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=rwf73w9ncRjC3brjfD2715hl1hXTN9ifCUZWS6AqyxjK1saqp/dwicu0ASeLR8B9v
         M8ZAO9HxO0PODwhFOtBXAkg7xHFTwD+U3Tc/kZ5euqBdpJY35IahXFk91ADBGIuXVq
         GpcVCsPJrdp3OqBVb7PXSAHL1CgqA4BkLxv2gXbk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230918073300eucas1p1c9a31881336f26a495b69de4e7d0c071~F7d-DshJ-1309713097eucas1p1g;
        Mon, 18 Sep 2023 07:33:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 6E.9B.11320.B2DF7056; Mon, 18
        Sep 2023 08:33:00 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230918073259eucas1p1cfcfbfd6a8c37c7cebd0b4734beffbc5~F7d_ue6-f0660306603eucas1p1s;
        Mon, 18 Sep 2023 07:32:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230918073259eusmtrp287fc632a8e38eea9a64656ffaf30256d~F7d_s7iJo3259532595eusmtrp2T;
        Mon, 18 Sep 2023 07:32:59 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-9b-6507fd2bc863
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 28.AB.10549.B2DF7056; Mon, 18
        Sep 2023 08:32:59 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230918073259eusmtip2f600a41fd36323b49a478548a33828b6~F7d_frRyu1441814418eusmtip2j;
        Mon, 18 Sep 2023 07:32:59 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Mon, 18 Sep 2023 08:32:58 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Mon, 18 Sep
        2023 08:32:58 +0100
From:   Daniel Gomez <da.gomez@samsung.com>
To:     David Hildenbrand <david@redhat.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 0/6] shmem: high order folios support in write path
Thread-Topic: [PATCH 0/6] shmem: high order folios support in write path
Thread-Index: AQHZ57ou5Qxd50H2CkCAi/G4rRLLzbAb8riAgAQxuQA=
Date:   Mon, 18 Sep 2023 07:32:57 +0000
Message-ID: <20230918073252.7nljdakmdk5kcpdt@sarkhan>
In-Reply-To: <b8f75b8e-77f5-4aa1-ce73-6c90f7d87d43@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.110.32.103]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7FB5FC383E12CC4DB148D262FACCE602@scsc.local>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUxTZxjd297eXmraXFoiT1icpmxjo7UI6naZylAxXlmWmOzHAppoxTvK
        N2utTmIMokamia2bASkkYCcgyCRcwRAsEIvCKh/tIAPGmA65bKSkdPIVPoTNcmvSf+d5znnP
        eU7yEkL5C1EYkZZ9itFnazOVuAR72LnUt1W9Kma2cU8QVVZfh1P3/jTh1Hz9spAa4GTUxMx1
        jGodUVG2VgdGDbSU4dTzuv9EVMvrZjE1bJ5AVNW8V0w9arDi1MpiGR4vo0vzf8XoCtZIP7gb
        SQ/0Gmm29nucZmd+ENO/3FrBaG/bbzg9y753OChZsvskk5l2mtFHxR2X6LoW/kC5bPB3tjGH
        MB9dk11FQQSQO2D8ygS6iiSEnLyLwN3jFvPDHILfC6b9zCyC1qeV+Nsns51eEU9UI2ivuif2
        EeuqzqWjPNGDoKD7J5wfahAU/tUq8qlw8mNoc7DrISFkhwicdYWYjxCSSVBkYtetFORBqC7o
        Qz4cQtLw+MZNEY8/g3+9JW80BIGRH8DiVK5vLSV3wkhpu8C3DiLj4M6Pp31rRG6ClzXLYt49
        FEa4cgHfIBispTYhjzfCWsuYv5kaeoc4xONt0FTZhvFYCa8LbyPeRw0Vj2ZwHseCZ9Tl91dB
        1e0pIX9OMDhKOMxXEchKCXDWm37TBPhn6I4/TAHurkaxGaktAfdZAjIsARmWgAxLQEYFEtWi
        UMZoyEplDDHZzBmNQZtlMGanalJyslj05g92r3XNNaNq9yuNHQkIZEdACJUh0pJonJFLT2rP
        5jH6nGN6YyZjsKN3CUwZKlXtcaTIyVTtKSaDYXIZ/VtWQASF5Qsul7tMxq8S8y90P3tfl3Zr
        skG5qenE8CHdlw1rggMxuheRk87V5UOxyWcU33xd/LLf+Q5TQH0x5m3cmJLLVcSVTiLNlowr
        NvdcvXGhpnn7wtJHRy6GN6uSv43bn25z7ew3JKKExydGP+nvkBbLbeO1ERGePI/VUbP3Wui5
        nPN7NQn2HfRib5RMZi9R7w/veZCYpAqL8MDuss/VU+HTpqSmYUef69N9MY3BK1T62dXYxvOX
        m2RDm53P4m9cGhw8vD3aU1882h8Rbn6e3q4o3zDhzHkybuqwmu2O6/ddGd3xYwej5NNF52Tu
        1V37PuR+Nv9tmUesosiWMs8N2jbXDucpMYNOGx0p1Bu0/wOXt2Ji8gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsVy+t/xe7raf9lTDTYvVLGYs34Nm8Xqu/1s
        Fl/X/2K2uPyEz+Lppz4Wi723tC327D3JYnF51xw2i3tr/rNa7Pqzg93ixoSnjBbLvr5nt9i9
        cRGbxe8fc9gc+DxmN1xk8ViwqdRj8wotj8tnSz02repk89j0aRK7x4kZv1k83u+7yubxeZNc
        AGeUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsbx
        b7cZCzYJVux5eJK5gbGbr4uRk0NCwETi87H3rF2MXBxCAksZJR7NvcoIkZCR2PjlKiuELSzx
        51oXG0TRR0aJ968OskM4ZxglFu7eBdW+klHi5O4lbCAtbAKaEvtObgKrEhE4yCrR/fQVE0iC
        WSBSYlo/SIKTQ1jAXWJ50zmwfSICHhIHJ05hhbCtJD68nwlUw8HBIqAq8eN1AUiYV8BU4tbs
        /WBjhAQOM0o07LEAKeEUsJNYMrkMJMwoICvxaOUvdohN4hK3nsxngvhAQGLJnvPMELaoxMvH
        /6A+05E4e/0J1McGEluX7mOBsJUk/nQsZISYoyOxYPcnNgjbUuLtnQtQ87Ulli18zQxxmqDE
        yZlPWCYwysxCsnoWkvZZSNpnIWmfhaR9ASPrKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMAU
        t+3Yz807GOe9+qh3iJGJg/EQowQHs5II70xDtlQh3pTEyqrUovz4otKc1OJDjKbAkJvILCWa
        nA9Msnkl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUw9R2977tHt
        u7zI1qvx3Dod3s2SM/lsLEM+1mcaNed3dUgfe/55c7jqN/v/L9Zl3hTb5PH7sWDhp8ur+8Vv
        TOPc4/FVQIH98plyFb1bXPdLLmr5XskWC5z/MdA4adGVHxb80i8/tHW6V7DNUnhVYrzmoUHj
        /1uyGx9fn3QiwensvRZPq3/ZR/rTDsbez/odtMArhTP/6N3Kz+lFFzfXR2RZfLr8sUm99Mez
        lX8eWd5982/+Br1TwbVLZe047t2IfrW6ZJ9b9hM2pu7Dz7NOl+65cHz7zI+HVT4G6X1gCHWc
        4nnvdAD/B70rwhFpcyeHyBf+PDs9aU7/4n6LVdW5V1cvNcqyXXBa4H7xJrkyzuizSizFGYmG
        WsxFxYkAyQ+4L/oDAAA=
X-CMS-MailID: 20230918073259eucas1p1cfcfbfd6a8c37c7cebd0b4734beffbc5
X-Msg-Generator: CA
X-RootMTR: 20230915095123eucas1p2c23d8a8d910f5a8e9fd077dd9579ad0a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230915095123eucas1p2c23d8a8d910f5a8e9fd077dd9579ad0a
References: <CGME20230915095123eucas1p2c23d8a8d910f5a8e9fd077dd9579ad0a@eucas1p2.samsung.com>
        <20230915095042.1320180-1-da.gomez@samsung.com>
        <b8f75b8e-77f5-4aa1-ce73-6c90f7d87d43@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 05:29:51PM +0200, David Hildenbrand wrote:
> On 15.09.23 11:51, Daniel Gomez wrote:
> > This series add support for high order folios in shmem write
> > path.
> >
> > This is a continuation of the shmem work from Luis here [1]
> > following Matthew Wilcox's suggestion [2] regarding the path to take
> > for the folio allocation order calculation.
> >
> > [1] RFC v2 add support for blocksize > PAGE_SIZE
> > https://lore.kernel.org/all/ZHBowMEDfyrAAOWH@bombadil.infradead.org/T/#=
md3e93ab46ce2ad9254e1eb54ffe71211988b5632
> > [2] https://lore.kernel.org/all/ZHD9zmIeNXICDaRJ@casper.infradead.org/
> >
> > Patches have been tested and sent from next-230911. They do apply
> > cleanly to the latest next-230914.
> >
> > fsx and fstests has been performed on tmpfs with noswap with the
> > following results:
> > - fsx: 2d test, 21,5B
> > - fstests: Same result as baseline for next-230911 [3][4][5]
> >
> > [3] Baseline next-230911 failures are: generic/080 generic/126
> > generic/193 generic/633 generic/689
> > [4] fstests logs baseline: https://gitlab.com/-/snippets/3598621
> > [5] fstests logs patches: https://gitlab.com/-/snippets/3598628
> >
> > There are at least 2 cases/topics to handle that I'd appreciate
> > feedback.
> > 1. With the new strategy, you might end up with a folio order matching
> > HPAGE_PMD_ORDER. However, we won't respect the 'huge' flag anymore if
> > THP is enabled.
> > 2. When the above (1.) occurs, the code skips the huge path, so
> > xa_find with hindex is skipped.
>
> Similar to large anon folios (but different to large non-shmem folios in =
the
> pagecache), this can result in memory waste.
>
> We discussed that topic in the last bi-weekly mm meeting, and also how to
> eventually configure that for shmem.
>
> Refer to of a summary. [1]
>
> [1] https://lkml.kernel.org/r/4966f496-9f71-460c-b2ab-8661384ce626@arm.co=
m

Thanks for the summary David (I was missing linux-MM from kvack in lei).

I think the PMD_ORDER-1 as max would suffice here to honor/respect the
huge flag. Although, we would end up having a different max value
than pagecache/readahead.
>
> --
> Cheers,
>
> David / dhildenb
>=
