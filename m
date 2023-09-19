Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B97B7A68D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 18:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjISQ2W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 12:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjISQ2V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:28:21 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCEAB0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 09:28:13 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230919162809euoutp02b5d1454472087486ca4c880d100d170b~GWahea5Fs2126121261euoutp02z
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 16:28:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230919162809euoutp02b5d1454472087486ca4c880d100d170b~GWahea5Fs2126121261euoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695140889;
        bh=X9Vh3xSdS13+TvaqDkbe6m4bnluDyBDtHOnoCxrZwGo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Mz4pQBv8pTu2ekGs/PNcrj6YTtsiJgRZGHxJUR6NJ4cXM3rPtyuEyutQx9scsVBzk
         MHqyIkeyCLdRbNRSFqIS7UJcWJtfr5FcC7G6v4eXq7gj5xyw8b+Ugexd2yF6o1AdEh
         vUQMOd4RXraUs1tZNHNMu1OwJaU2zb50PSqyvMJY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230919162809eucas1p19a3e25971dc7ec568f69d95ab66e5116~GWahODslI0969909699eucas1p1A;
        Tue, 19 Sep 2023 16:28:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 85.2B.11320.91CC9056; Tue, 19
        Sep 2023 17:28:09 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230919162808eucas1p2d773186479b84364e8adf1a286a92af0~GWag42J7U1672016720eucas1p2t;
        Tue, 19 Sep 2023 16:28:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230919162808eusmtrp2c556456594d71a1a2b7bef03884aee32~GWag4PRUk1247812478eusmtrp2s;
        Tue, 19 Sep 2023 16:28:08 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-4d-6509cc19bd3d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 79.7A.14344.81CC9056; Tue, 19
        Sep 2023 17:28:08 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230919162808eusmtip1b2416a662eb13677c901f2a87854b0ca~GWagpvZDz0507805078eusmtip17;
        Tue, 19 Sep 2023 16:28:08 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Tue, 19 Sep 2023 17:28:07 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Tue, 19 Sep
        2023 17:28:07 +0100
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
Subject: Re: [PATCH v2 6/6] shmem: add large folios support to the write
 path
Thread-Topic: [PATCH v2 6/6] shmem: add large folios support to the write
        path
Thread-Index: AQHZ6wEBFE+DTgi9xUu5khR159FX3LAiLYSAgAAYPoA=
Date:   Tue, 19 Sep 2023 16:28:07 +0000
Message-ID: <20230919162805.m6hbrmwq4gm4iiv5@sarkhan>
In-Reply-To: <ZQm3vywitP+UdIHF@casper.infradead.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.110.32.103]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A4B5720378D78244931EB5E1F49DD8DC@scsc.local>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7djP87qSZzhTDeY+ZLGYs34Nm8Xqu/1s
        Fpef8Fk8/dTHYrH3lrbFnr0nWSwu75rDZnFvzX9Wi11/drBb3JjwlNFi2df37Ba7Ny5is/j9
        Yw6bA6/H7IaLLB4LNpV6bF6h5XH5bKnHplWdbB6bPk1i9zgx4zeLx+dNcgEcUVw2Kak5mWWp
        Rfp2CVwZE07/Zi14KV7x+uRC5gbG4/xdjJwcEgImEnc+fGbsYuTiEBJYwSjx/fw/NgjnC6PE
        hIs32CGcz4wSG54tZINpWdm6ACqxnFFi4ukXbHBVO1edZwWpEhI4wyhxvF8SIrGSUeLv1GPs
        IAk2AU2JfSc3AdkcHCICGhJvthiB1DALHGWVWLJ2EwtIjbCAv8Tyg2/B6kUEAiTa+q8wQdhW
        Ei0n5zKD2CwCqhJ9s24wg8zhFTCVWNZZAmJyAl238asTSAWjgKzEo5W/wKYwC4hL3Hoynwni
        AUGJRbP3MEPYYhL/dj2EekxH4uz1J4wQtoHE1qX7WCBsJYk/HQsZIeboSCzY/YkNwraUWLFs
        BpStLbFs4WuwmbxA80/OfALVO5NL4tIvO5DTJARcJJq+ZECEhSVeHd/CPoFRZxaS62Yh2TAL
        yYZZSDbMQrJhASPrKkbx1NLi3PTUYqO81HK94sTc4tK8dL3k/NxNjMBkd/rf8S87GJe/+qh3
        iJGJg/EQowQHs5II70xDtlQh3pTEyqrUovz4otKc1OJDjNIcLErivNq2J5OFBNITS1KzU1ML
        UotgskwcnFINTG2pn2bKRXx4tVP/5sKDBvc+qz6SFTAufdncpmlpde2YfGHT/Sv+J26qlm4z
        3cexTvPsv22T9qyRO6HrVh9rEvvvQ0VuFL/Qr2s3fk99Wrp6f3sf5yeziS5Xf9+xemMU5/u5
        RWBH+l9O+2Me89Rf33a7MDfiVXVJvz/fcef4N1xzD0od21f4R+CVYYuvr5uU+g49fe3Dnpsa
        IhK/ZTB0nX9r6vB5z747E7JeTVrLFnx737x7hftYFicu99t7miN/+cv1tkevl9zYFPef4az3
        uTWxq7OzFO+K/V59+m1KlNmSPzbXOGdI3g80kpmjU5VYu03V3fhEydqKq8ZvU57ULTow88Uy
        uZ+TYh64374u+S9EiaU4I9FQi7moOBEAwXhDjeUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsVy+t/xu7oSZzhTDTYv0rKYs34Nm8Xqu/1s
        Fpef8Fk8/dTHYrH3lrbFnr0nWSwu75rDZnFvzX9Wi11/drBb3JjwlNFi2df37Ba7Ny5is/j9
        Yw6bA6/H7IaLLB4LNpV6bF6h5XH5bKnHplWdbB6bPk1i9zgx4zeLx+dNcgEcUXo2RfmlJakK
        GfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZE07/Zi14KV7x+uRC
        5gbG4/xdjJwcEgImEitbF7B3MXJxCAksZZTY/2cuE0RCRmLjl6usELawxJ9rXWwQRR8ZJU5+
        O8oE4ZxhlPj/7BYjSJWQwEpGiZXH5EFsNgFNiX0nNwGN5eAQEdCQeLPFCKSeWeAoq8SStZtY
        QGqEBXwl7k3qAtsgIuAn8fPRTSjbSqLl5FxmEJtFQFWib9YNZpA5vAKmEss6SyBWvWaU6J7o
        DRLmBPpg41cnkDCjgKzEo5W/2EFsZgFxiVtP5kP9IiCxZM95ZghbVOLl439Qf+lInL3+hBHC
        NpDYunQfC4StJPGnYyEjxBwdiQW7P7FB2JYSK5bNgLK1JZYtfA02k1dAUOLkzCcsExhlZiFZ
        PQtJ+ywk7bOQtM9C0r6AkXUVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYCrbduznlh2MK199
        1DvEyMTBeIhRgoNZSYR3piFbqhBvSmJlVWpRfnxRaU5q8SFGU2DITWSWEk3OBybTvJJ4QzMD
        U0MTM0sDU0szYyVxXs+CjkQhgfTEktTs1NSC1CKYPiYOTqkGpv49/REhfTdlxG99YdA6pvj6
        1+quDLfN4jMm3dZY8Gl10oKzO/Rr+h9dyfk0fesCa2dv0703etc+OvPYoO74TbbCCqmtOQWm
        EVzLphbyP5tV+zsp6/eGrWwn5znPn7Jy4q/JvT5/yzUZWrn/TjQROPaScZI5oxGbxvt+1jlv
        194QfXssJzRj38uTi+Zn7myLc3k+Y4b0xuLFBUrxHcX18oV/BUPy63n1rhyNi/+qfqxfNeKY
        HfesGaph04xUpixXtvnfvv+m4KR133ac2rZn2fHPwkHc3f3eeX3lYiIVt/wW7hb97WPDwHHl
        2Le3PwsLb03O6P5j9Dnu2rRZJfbPFi1rKVllYcv8gUl8YelW/ltKLMUZiYZazEXFiQCeQcBG
        7gMAAA==
X-CMS-MailID: 20230919162808eucas1p2d773186479b84364e8adf1a286a92af0
X-Msg-Generator: CA
X-RootMTR: 20230919135556eucas1p19920c52d4af0809499eac6bbf4466117
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230919135556eucas1p19920c52d4af0809499eac6bbf4466117
References: <20230919135536.2165715-1-da.gomez@samsung.com>
        <CGME20230919135556eucas1p19920c52d4af0809499eac6bbf4466117@eucas1p1.samsung.com>
        <20230919135536.2165715-7-da.gomez@samsung.com>
        <ZQm3vywitP+UdIHF@casper.infradead.org>
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

On Tue, Sep 19, 2023 at 04:01:19PM +0100, Matthew Wilcox wrote:
> On Tue, Sep 19, 2023 at 01:55:54PM +0000, Daniel Gomez wrote:
> > Add large folio support for shmem write path matching the same high
> > order preference mechanism used for iomap buffered IO path as used in
> > __filemap_get_folio() with a difference on the max order permitted
> > (being PMD_ORDER-1) to respect the huge mount option when large folio
> > is supported.
>
> I'm strongly opposed to "respecting the huge mount option".  We're
> determining the best order to use for the folios.  Artificially limiting
> the size because the sysadmin read an article from 2005 that said to
> use this option is STUPID.

Then, I would still have the conflict on what to do when the order is
same as huge. I guess huge does not make sense in this new scenario?
unless we add large folios controls as proposal in linux-MM meeting
notes [1]. But I'm missing a bit of context so it's not clear to me
what to do next.

[1] https://lore.kernel.org/all/4966f496-9f71-460c-b2ab-8661384ce626@arm.co=
m/T/#u

In that sense, I wanted to have a big picture of what was this new
strategy implying in terms of folio order when adding to page cache,
so I added tracing for it (same as in readahead). With bpftrace I
can see the following (notes added to explain each field) after running
fsx up to 119M:

@c: 363049108  /* total folio order being traced */
@order[8]: 2 /* order 8 being used 2 times (add_to_page_cache) */
@order[5]: 3249587 */ order 5 being used 3249587 times
(add_to_page_cache) */
@order[4]: 5972205
@order[3]: 8890418
@order[2]: 10380055
@order[0]: 334556841
@order_2: /* linear histogram of folio order */
[0, 1)          334556841 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@|
[1, 2)                 0  |                                                =
    |
[2, 3)          10380055  |@                                               =
    |
[3, 4)           8890418  |@                                               =
    |
[4, 5)           5972205  |                                                =
    |
[5, 6)           3249587  |                                                =
    |
[6, 7)                 0  |                                                =
    |
[7, 8)                 0  |                                                =
    |
[8, 9)                 2  |                                                =
    |

I guess that's not te best workload to see this but would tracing be also
interesting to add to the series?
>
> >  	else
> > -		folio =3D shmem_alloc_folio(gfp, info, index, *order);
> > +		folio =3D shmem_alloc_folio(gfp, info, index, order);
>
> Why did you introduce it as *order, only to change it back to order
> in this patch?  It feels like you just fixed up patch 6 rather than
> percolating the changes all the way back to where they should have
> been done.  This makes the reviewer's life hard.
>

Sorry about that. I missed it in my changes.=
