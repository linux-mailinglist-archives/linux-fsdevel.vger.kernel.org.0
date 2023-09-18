Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CEB7A44FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 10:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbjIRIm2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 04:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240756AbjIRImC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:42:02 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8791612E
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 01:41:41 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230918084139euoutp01277c82d8d4482876ed480073cf39176e~F8Z7qez3Z2969629696euoutp01o
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 08:41:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230918084139euoutp01277c82d8d4482876ed480073cf39176e~F8Z7qez3Z2969629696euoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695026499;
        bh=I6/F7qFZPtrg6H/Jcv8LXXx7VGKpvo96ZTN4LGrf6fw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=dp7Lmea9EJ7tbdvZDslnP6QUxppeaNpFLMQDgxDUVIU2zPqhR6CbI85J5ObViZBoJ
         cwH22lQE2vP1BSZbI1R0uq9/GAveSrl2JxsxypRzcuEtyFqbkS83fuF0mUQMKtNdRt
         7mpIEHsPyhl06C5LPbz1uo0upe7xEJUpeKbeTD+U=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230918084139eucas1p2bca1ce458c270cd2d518ba89853b4b2f~F8Z7Nddnn1417714177eucas1p2d;
        Mon, 18 Sep 2023 08:41:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 63.83.37758.34D08056; Mon, 18
        Sep 2023 09:41:39 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230918084138eucas1p1ecd026f8b438b8023d4a7b1db5b2a776~F8Z6vIPXh1114411144eucas1p1Q;
        Mon, 18 Sep 2023 08:41:38 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230918084138eusmtrp2db991ae9bf97063fa586edd5cedc7b12~F8Z6uUAsB0622806228eusmtrp24;
        Mon, 18 Sep 2023 08:41:38 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-33-65080d43afb8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CC.AB.10549.24D08056; Mon, 18
        Sep 2023 09:41:38 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230918084138eusmtip1ee030262885b16ac08365ff6c0b85118~F8Z6hVy1p1042310423eusmtip1B;
        Mon, 18 Sep 2023 08:41:38 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Mon, 18 Sep 2023 09:41:37 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Mon, 18 Sep
        2023 09:41:37 +0100
From:   Daniel Gomez <da.gomez@samsung.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 1/6] filemap: make the folio order calculation shareable
Thread-Topic: [PATCH 1/6] filemap: make the folio order calculation
        shareable
Thread-Index: AQHZ57ovaMdf9q/cjECRh1BbWSoXsbAb1A+AgARjlAA=
Date:   Mon, 18 Sep 2023 08:41:37 +0000
Message-ID: <20230918084134.d276vadcmkvwonmb@sarkhan>
In-Reply-To: <ZQRet4w5VSbvKvKB@casper.infradead.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.110.32.103]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DE33310D18359544AC6BBC07702B73B0@scsc.local>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUiTYRzHefa+e/dutHib14ORwSgzNc0OeCuNousljFSiQLpWvbmxTWVv
        6zCijYJSQs1Y6bSaS6fzyHw7pistVmnrorDWtDJddrAiUbND7XC+K/bf58fzPX4/eHBE8owf
        jisy99CaTJlKionQa20/H89ZIcbpud1WhCxrqMPI2tcFGNnRN5l8N5iPki1dMeSNFidKdtjL
        MLK77g+ftI81CUh34TtAWob7BeT1RjNGjv4ow5aJqVLdU5QysVrqcnU01fFIS7E1uRjFDhYJ
        qHvFoyg1xEak4OmixF20SrGX1sQv3S6SX31Vx8vWifb3NFciOvBNkAeEOCQWwCf9Ll4eEOES
        ohpAV5HbP3wF0FTkBdwwBGCl1cL7ZzlydBj4WEJUAfjnqeK/qNtY5Xc8BLD14oA/ywqg0dbN
        91kwYjZsdbLj7TgeTETBz1fm+TQIcZcPK+pZ1KcJIpLhYLttoi6YWA+7btoQjhfDzsvnEZ8X
        JWbCWyeCfCgmFsK3lxJ9CuH4cs6KhokUQEyDHuvIxJ0IEQa7+s77D5gCzaU3EI5D4W97L8Zx
        LHz0og9wPBderWxFOZbCsePlgMuJhabrgxjHi+Azp53PcQy0lH+ayBSP5ztL+lDfWZAwiKC5
        psQfuhKOfi/2LxEEve1XBIUg1hiwnzGgwxjQYQzoMAZ0mAC/BoTRWkadQTPzM+l9cYxMzWgz
        M+J2ZqlZMP7xHvxuH24C1d6BOAfg4cABII5Ig8UlCRgtEe+SHcihNVnbNFoVzTjAVByVholj
        kpw7JUSGbA+tpOlsWvPvlYcLw3W86S8jj+Wo3UkvxjZW6JRZxHM3eUIzNLO/1JUfeakw124D
        kjPNIdpOxQqXvjbxgNcqarwTdTbJY0uuGli7AMtPPWiomR1xPzI1V7x/9aYLjnXL2/Vj2oX1
        StZc+16boEkJ/SVMjWea03K/Hsou3oq4ez/u69XLDA8sR11N0QVvBiKuhWy+F9uzRmBpW7ZF
        dNehCrNFHw8/V16ww8P/IM8aEubhux0f9aYZd1Z5XuNyxeEm+bn0nzm3RpTepOkpLvSNUnWs
        onEkeVYa9QFUzdAbeqzLg257QhhpT17+Z/Maz5fJhpOHJx2pVUundnUknw6+vZ09tWFJfMOP
        zg0thTukKCOXJUQjGkb2F87yX4HnAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsVy+t/xu7pOvBypBtOnKlrMWb+GzWL13X42
        i8tP+Cyefupjsdh7S9tiz96TLBaXd81hs7i35j+rxa4/O9gtbkx4ymix7Ot7dovdGxexWfz+
        MYfNgddjdsNFFo8Fm0o9Nq/Q8rh8ttRj06pONo9Nnyaxe5yY8ZvF4/MmuQCOKD2bovzSklSF
        jPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MrXfWMBU0cFU82LmU
        uYHxG3sXIyeHhICJRHPLV8YuRi4OIYGljBJbZ+1jgUjISGz8cpUVwhaW+HOtiw2i6COjRMN7
        kASIc4ZRYn3zemYIZyWjxLvdZ5lAWtgENCX2ndwEtIODQ0RAQ+LNFiOQGmaBo6wSS9ZuAlsh
        LOAj8en4drB6EQFfiS0ntrBB2FYSNzfPZwbpZRFQlTjQIwxi8gqYSjzeYAOx6jWjRN/8V2DX
        cQK9cHLJerCRjAKyEo9W/gJ7jVlAXOLWk/lMEB8ISCzZc54ZwhaVePn4H9RnOhJnrz9hhLAN
        JLYuhfleSeJPx0JGiDk6Egt2f2KDsC0lrpzcxQpha0ssW/gabCavgKDEyZlPWCYwysxCsnoW
        kvZZSNpnIWmfhaR9ASPrKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMB0tu3Yz807GOe9+qh3
        iJGJg/EQowQHs5II70xDtlQh3pTEyqrUovz4otKc1OJDjKbAoJvILCWanA9MqHkl8YZmBqaG
        JmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUzqE5p+C8s3fn24MzO31Z9L+ml6
        96zLRptVFfdaF+V9n8K63/IJ9/LNXoyNupcVv268tNsxMSz1HdsDCU6r79/cnbVkFnxf0aZU
        0HJoQx2j2M/sIoZnxnt2iPJLHl/vOCPIVX772y1VdbNdJd4VN3MFs4YJPHmazqAo5nCiovs7
        4y3jrkUdcvJmi3jVKjVZ+82XvF4hu0tc7VfrvsripN3aqVyrg8WKp62YKnnp7GN2bpY24anr
        VnHaP7m2LN5B6fPH+4u9u9icZv+JE1Ccb/Po/JRbFtNMm55/FrLZu7Bp2qKE/VPF2XOSIpx5
        hBcseLPxW0Tk/9bm/fdv2pgcEJ+0fvU81RW7siyfnmDXElNiKc5INNRiLipOBACzjsVg8AMA
        AA==
X-CMS-MailID: 20230918084138eucas1p1ecd026f8b438b8023d4a7b1db5b2a776
X-Msg-Generator: CA
X-RootMTR: 20230915095124eucas1p1eb0e0ef883f6316cf14c349404a51150
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230915095124eucas1p1eb0e0ef883f6316cf14c349404a51150
References: <20230915095042.1320180-1-da.gomez@samsung.com>
        <CGME20230915095124eucas1p1eb0e0ef883f6316cf14c349404a51150@eucas1p1.samsung.com>
        <20230915095042.1320180-2-da.gomez@samsung.com>
        <ZQRet4w5VSbvKvKB@casper.infradead.org>
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

On Fri, Sep 15, 2023 at 02:40:07PM +0100, Matthew Wilcox wrote:
> On Fri, Sep 15, 2023 at 09:51:23AM +0000, Daniel Gomez wrote:
> > To make the code that clamps the folio order in the __filemap_get_folio
> > routine reusable to others, move and merge it to the fgf_set_order
> > new subroutine (mapping_size_order), so when mapping the size at a
> > given index, the order calculated is already valid and ready to be
> > used when order is retrieved from fgp_flags with FGF_GET_ORDER.
> >
> > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> > ---
> >  fs/iomap/buffered-io.c  |  6 ++++--
> >  include/linux/pagemap.h | 42 ++++++++++++++++++++++++++++++++++++-----
> >  mm/filemap.c            |  8 --------
> >  3 files changed, 41 insertions(+), 15 deletions(-)
>
> That seems like a lot of extra code to add in order to avoid copying
> six lines of code and one comment into the shmem code.
>
> It's not wrong, but it seems like a bad tradeoff to me.

I saw some value in sharing the logic but I'll merge this code directly
in shmem and add a comment 'Like filemap_' similar to the one in
shmem_add_to_page_cache.

Thanks for the quick feedback and review Matthew. I'll do a V2 with the
changes and retest the series again using latest next tag.=
