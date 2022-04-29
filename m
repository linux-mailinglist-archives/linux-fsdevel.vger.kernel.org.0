Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BD55151C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbiD2R1T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235805AbiD2R1R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:27:17 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBF053710;
        Fri, 29 Apr 2022 10:23:58 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220429172356usoutp0242676b86c3c639e383c7b829b91b1a80~qbeNobwUC3254732547usoutp02I;
        Fri, 29 Apr 2022 17:23:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220429172356usoutp0242676b86c3c639e383c7b829b91b1a80~qbeNobwUC3254732547usoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651253036;
        bh=CV3ILaM36wPkqi/7uv6GbDScjcp+QLdybCrf3oHF4/8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=OyDGWkA+q6Lv2j8SsWasu+qyRerfQq9/CjwF8DNivnz0FsplGCg8dr9FdDcXpWZlU
         ZyjHK/jNzE6ptXgi6y6I4rdE23Q1MMN5oT54CBnpxkATfW8WExYjxDbkOhuWuLaOc1
         R5qa5K4vStBOC/eXtm29IHyQTXfrGfb/7//15/IY=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220429172356uscas1p1802f8556352f80b43292a97d1692d426~qbeNXtUlU0334603346uscas1p1d;
        Fri, 29 Apr 2022 17:23:56 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 32.01.09642.C2F1C626; Fri,
        29 Apr 2022 13:23:56 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220429172356uscas1p240abbeaccf4d0771ef01c5ada56a19e3~qbeM3iOF-0529505295uscas1p2J;
        Fri, 29 Apr 2022 17:23:56 +0000 (GMT)
X-AuditID: cbfec36f-c15ff700000025aa-51-626c1f2c1d50
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 27.63.09672.B2F1C626; Fri,
        29 Apr 2022 13:23:55 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.7; Fri, 29 Apr 2022 10:23:54 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.007; Fri,
        29 Apr 2022 10:23:54 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
CC:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "hch@lst.de" <hch@lst.de>, "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "naohiro.aota@wdc.com" <naohiro.aota@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "clm@fb.com" <clm@fb.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "jonathan.derrick@linux.dev" <jonathan.derrick@linux.dev>,
        "agk@redhat.com" <agk@redhat.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "matias.bjorling@wdc.com" <matias.bjorling@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 05/16] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Thread-Topic: [PATCH 05/16] nvme: zns: Allow ZNS drives that have
        non-power_of_2 zone size
Thread-Index: AQHYWlBIk1palC1aiUOJGb6L5A1HwK0HnIUA
Date:   Fri, 29 Apr 2022 17:23:54 +0000
Message-ID: <20220429172354.GB174938@bgt-140510-bm01>
In-Reply-To: <20220427160255.300418-6-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0AED4CE52B42814A9FAE9FC027D992A6@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTZxTGfe+9vS2V4qWivILZYiPGDIeAEN9MZYYZdydZZtTFOWewzisQ
        vlxLlZFtwpQJFaVlIlpIgMqKIIzRGsYoX3ZRPhS7Wb7sKKwBtmlni3RMAamjvV3Cf7/znOc9
        5znJy8OFHWQQLyktg5GkiVNEJJ9oujtjfHPT6ynHwqub16KG3rs4umkpJNGVqVkc3Svuw1BR
        4VUumu8z4qjNXspBv7zIwVDNzTsYmmhQ4aigc4pAC/LRRe2cFUcvrRGoyDAI0OSACkNt5lD0
        cPwGFz1Uv4ta23oIZGopI1G5ZpKLFN/M4GhYMQmQskvHQd/bHATqNgfvDKZN/XG0q7uOpJVn
        7VzaONpI0KY+Ga2tzSfpyuxinNZVnaH1FU6M1j/KJumLZ+0k/VPuGId2tA+QdMOtAYJW6Bo5
        tFP72l7/j/nbjzMpSacYyeaYo/xEZ0cHeTJPmGn86xWWDRx+cuDDg1QULD+n5bhZSNUA2Fwf
        wXIuBkdf+MoBz+MZN8aycj2ATdUfygF/kZ8B+HLcQrCFBsCFHAfmdpFUOJzvasTdHEBthH/0
        6zw6TsmXQ0txlJtXUodhi7mHYD2fwDxjDpflSKh8YPcwQYXAttL7wM0CKhr+quvy6D7UNtjZ
        0+mZD6jV8HlvnXd+IDRPlGPsYf5QXdqKs7waulqsJMvr4Njzx1zWvwlW6KdJlmNgtfI375xQ
        qKm04exef9hzbYJg366Bt28Mew6GVCMf2ooM3sYuOPvdde+CYLhg0WCs6TyAU4p2DlsoABx5
        Out1bYOu/EGuAqxXLUmuWpJKtSSVakkq1ZJUFYBTCwJlUmlqAiONTGNOh0nFqVJZWkLYp+mp
        WrD4x++5fk5vBkPmZ2EGgPGAAUAeLgoQ/KNPPCYUHBd/nsVI0uMlshRGagDBPEIUKNAk/SAW
        UgniDCaZYU4ykv+7GM8nKBs7ku9fZ1hzpLL/In6BGJsUhx9cue9P9aPpkbnLm8Xvnfki85Lz
        zq5Dxq1rL+deubBqbzcMWRYz6LexfcQS/FXXzgb74+ZXJfv/7YrmqvNqtzTFzvU6f5+PW1FQ
        tX7+x/iS3lVYxvXobzWz04R1676ZHXtuJw9de7p96LDfnrxiq2C5LC5EWVQY8/bX8qNz99dZ
        dyyz5p7wDfItjyJLbOonOZlRfwuSw+yuA6ovq/TDNuKj/fHqwfoC26kM4XnqtCUyQKwNkF16
        cvAtOis20/SB6sFQbE2yZMv7xhPvrBB260yjCVeVDsvuuVtlWbk9fQma3Z9VNJiJ1mF+pCjU
        0XRoQ5lJNC4ipIniiDdwiVT8H0iZu1FSBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxjGd+69vb10Q6+1yBmYmTVpJDIYdjpOnLrG/bGbzMV9GON0hlW5
        ATIo2FrEuWwFBkHU0HaDaWVSEUsVsNK6OGwZteKgfFg+DWszGOPDARlQ0LmmiqPcLel/v+d9
        n/d5zh+HwoUjvBgqQ3GMVSrkmWJSQGRoMF1C/IbMw0nf9iQjS8cvOKr7rYxEFfMBHHWWd2NI
        X3aOj4LdHhw1z17goZ5/8jF0te4ehsYtBhydcc4T6Fnp8PLsm1EcPR3djPSuBwBNDBow1OyN
        R31jZj7qq34XOZrdBOq/XUmiKtMEH2mLH+NoSDsBkK7NxkPXZ+YI1O6NlcUy/QPvMUvt9SSj
        K5zlM57hRoLp71Yz1munSOaSphxnbDVfM3bjIsbYf9WQzNnCWZJpKhrhMXM/D5KM5eYgwWht
        jTxm0frKB2sOCLanspkZuazy9Z2fCdIXW1rInBJhnufP55gGzK0qBRQF6S1wzLOrFAgoIV0H
        oL7HQnLCvyymz/E4YQLQXF1ClIIIiqSTYLCtEQ+xiI6DkwM2LGTC6ZIX4eNADQgt1tIH4W2v
        m+BMn8Ibnoc8jqVQd3+WH2KClsDmC10r/kh6K+y1tfG5tpbl6uLnKw0R9FvQ6XauMKDXwScd
        9ViIcToaeserVhjSNKxxeHCOo+DU2BKP41fhyJMpPud/DRrtCyTHO2GtzvdfTjw0XZrBuUes
        ge7z4wR3+zK8Yx4itAAawuoMYVGGsChDWJQhLMoIeNdAtFqlykrLU0kV7PFElTxLpVakJR7J
        zrKC5T/YuXT34E/A5/UnugBGAReAFC4WRT6ypx8WRqbKT3zBKrNTlOpMVuUCsRQhjo6cOqBL
        EdJp8mPs5yybwyr/32JURIwG++SdbQ5qj3Ra/3G0uz4orZc5G4qijM/evjJwZc9RUtKVtdGY
        m2D66HhS9WiRSJLyZfDDk/slrdP915Mkf63vncw48sJWWtflo/7Ye2v13kczvt3Br6R5zD7g
        x8t/7zuvu7ixcr521TDG+MH3MaJJscKtudje2posAumOs7IbTZd9MvOmHdr3tQHBfV+cMqH7
        9Bm8trDgRKAkkP/U70yNKhPGqX+syH3z711rC6iF9SmHGnaYUzsocb7jbq3kh3UmfqDC+PCy
        +w19J7oH8dhTM7Imi73SYJVu0C4Ub7GuLtjGPkgbasP2C9tv9R6dCLqYqu2OnOzkk6e/M042
        vHRHTKjS5Zs34UqV/F9M6jft8gMAAA==
X-CMS-MailID: 20220429172356uscas1p240abbeaccf4d0771ef01c5ada56a19e3
CMS-TYPE: 301P
X-CMS-RootMailID: 20220427160301eucas1p147d0dced70946e20dd2dd046b94b8224
References: <20220427160255.300418-1-p.raghav@samsung.com>
        <CGME20220427160301eucas1p147d0dced70946e20dd2dd046b94b8224@eucas1p1.samsung.com>
        <20220427160255.300418-6-p.raghav@samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 27, 2022 at 06:02:44PM +0200, Pankaj Raghav wrote:
> Remove the condition which disallows non-power_of_2 zone size ZNS drive
> to be updated and use generic method to calculate number of zones
> instead of relying on log and shift based calculation on zone size.
>=20
> The power_of_2 calculation has been replaced directly with generic
> calculation without special handling. Both modified functions are not
> used in hot paths, they are only used during initialization &
> revalidation of the ZNS device.
>=20
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/nvme/host/zns.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 9f81beb4df4e..2087de0768ee 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -101,13 +101,6 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsign=
ed lbaf)
>  	}
> =20
>  	ns->zsze =3D nvme_lba_to_sect(ns, le64_to_cpu(id->lbafe[lbaf].zsze));
> -	if (!is_power_of_2(ns->zsze)) {
> -		dev_warn(ns->ctrl->device,
> -			"invalid zone size:%llu for namespace:%u\n",
> -			ns->zsze, ns->head->ns_id);
> -		status =3D -ENODEV;
> -		goto free_data;
> -	}
> =20
>  	blk_queue_set_zoned(ns->disk, BLK_ZONED_HM);
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
> @@ -129,7 +122,7 @@ static void *nvme_zns_alloc_report_buffer(struct nvme=
_ns *ns,
>  				   sizeof(struct nvme_zone_descriptor);
> =20
>  	nr_zones =3D min_t(unsigned int, nr_zones,
> -			 get_capacity(ns->disk) >> ilog2(ns->zsze));
> +			 div64_u64(get_capacity(ns->disk), ns->zsze));
> =20
>  	bufsize =3D sizeof(struct nvme_zone_report) +
>  		nr_zones * sizeof(struct nvme_zone_descriptor);
> @@ -197,7 +190,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t=
 sector,
>  	c.zmr.zrasf =3D NVME_ZRASF_ZONE_REPORT_ALL;
>  	c.zmr.pr =3D NVME_REPORT_ZONE_PARTIAL;
> =20
> -	sector &=3D ~(ns->zsze - 1);
> +	sector =3D rounddown(sector, ns->zsze);
>  	while (zone_idx < nr_zones && sector < get_capacity(ns->disk)) {
>  		memset(report, 0, buflen);
> =20
> --=20
> 2.25.1
>


Looks good.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>=
