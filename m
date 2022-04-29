Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4454C515226
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379272AbiD2Rdb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbiD2Rd3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:33:29 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3785F8A;
        Fri, 29 Apr 2022 10:30:10 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20220429173009usoutp015d3c871c6f8424aa3134d0e6d1a90bb4~qbjobwlQB2866728667usoutp01O;
        Fri, 29 Apr 2022 17:30:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20220429173009usoutp015d3c871c6f8424aa3134d0e6d1a90bb4~qbjobwlQB2866728667usoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651253409;
        bh=yGf0OCd0dWX6dkg1UYMVbMN0E+a1xHdi3mCLpp4T8P4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=vQCm+Sb01m417iBw+LpZcgNdScHmgUcXJboSB0T5GpWb9leVJCTOCI5kimS4bK4kY
         6jTmGUuuWZZiJ7VASPMbTjsYTxPRQuN0kTnOHEFcGXLi9h24491vs/zk21YMpKPJu0
         97XdzJSvRc148MCNYwmbOaRrr6+zPIcdWZGatzr0=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220429173009uscas1p2bf30fcd81fced72f645adfac58e2a265~qbjoQPaI62475724757uscas1p23;
        Fri, 29 Apr 2022 17:30:09 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 21.C1.09642.0A02C626; Fri,
        29 Apr 2022 13:30:08 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220429173008uscas1p1cde218cbcd1e37d4069cf9db33f82fbf~qbjnusC8M0356103561uscas1p1I;
        Fri, 29 Apr 2022 17:30:08 +0000 (GMT)
X-AuditID: cbfec36f-bfdff700000025aa-73-626c20a0d0f0
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 29.F1.09702.0A02C626; Fri,
        29 Apr 2022 13:30:08 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.7; Fri, 29 Apr 2022 10:30:07 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.007; Fri,
        29 Apr 2022 10:30:07 -0700
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
Subject: Re: [PATCH 13/16] null_blk: allow non power of 2 zoned devices
Thread-Topic: [PATCH 13/16] null_blk: allow non power of 2 zoned devices
Thread-Index: AQHYWlBN4zB7Wf7sW0aEyMwWol2CyK0HnkAA
Date:   Fri, 29 Apr 2022 17:30:07 +0000
Message-ID: <20220429173006.GD174938@bgt-140510-bm01>
In-Reply-To: <20220427160255.300418-14-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B4D2F0A8C589E242945A08E1571AAD23@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTVxzHPffe3l46gdvOwJlsPghbCkwERHfMFIgz46pZ5hI1vqKr4/LY
        Sktai4OxiDBxMKWlG1PK29mO1wYUHUiBuYqCMGTjUVzDIwwwYSDgCnPiqKNcTPrf5/x+39/5
        fXJyKFzUTK6lYmWnWYVMIvUmBcRPd+fvbyreID0VeO1RMKpqv4ujikE1ib6dfYqjjpxODGnV
        V/joWWcXjpqm83jot3/PYais4g6Gxqp0OLp4a5ZAi5lDS7UvRnD030gQ0potAI336TDUZPVH
        3aOlfNR9NQI1Nt0jUE9DPomKDON8pEmfx9EDzThA2a21PPTj5AyB2qxe4V5MT+8+xt5WSTLZ
        adN8pmuohmB6OlWMsTyDZEpScnCm9tpZxlRswxjTHykkcyltmmRunh/mMTPNfSRTdb2PYDS1
        NTzGZly3X3hUsCOSlcYmsIrNoR8KYqYsZiI+P+jTUts5fgqofiMTuFCQDoE17TbgYBFdBmBZ
        XngmECzxeQwuZNXzX4QGU9NIrvEDgPcHFnBu4jGAXw77cg0DgDftU5ijQdKB8FlrzXJoDS2G
        D3trl+s4nfkSHMwJcfDLdAS8XbqwVKeWMgxse36Yw2B4ueeAI0HQr8MB29ekg13prXCy/wrP
        wS70DmipGlh2A7QHfNJeuXK7J7SOFWGcsxBezWvEOfaA9oYRkuONcPjJBJ/LvwmLTX+THIfC
        DmMFzrE/NJRM4txeIbyXO0Zws6/AX0ofrPANAexddON4N+zTm1d2ecG+/hzc8SSQvgDgrKaZ
        xx00AA48erpi8Ta0Z1j4GuCjcxLXOUnpnKR0TlI6J6liwCsHniqlMi6aVQbL2DMBSkmcUiWL
        DvhIHmcES1+8w35bXg/6rY8DzACjgBlACvde4zpnijklco2UJCaxCvlJhUrKKs3AiyK8PV0N
        sdUSER0tOc1+wrLxrOJFF6Nc1qZg7iyoGUz/Z2KgR7trMfDVM9XfFRaKk+Z6y96JSOkXrPIO
        9RPbdm9vPAA2t2pS7dmqeP2WFt2JW1T0w9+Nicc2hW/3Pxml37O1YXLIs7H7M3Vl7tmLJ9aX
        vE+ltsxNJhd1joaFMH89nzmU/I1vbqT1uIc0Pc/yc4cpsK4uebRjShz0rqxgw1uJ2nkGX63O
        rS84Fmr21b8m2uaTtTHssnaLzL5tKiEqy90tdvaDz4vELV/FT5XvdZdHCQvfW60X/7rzgtpw
        MPTQnwF762hl+Pf5ipCS68Iu/Ph+QrTKGn1nV4GpKF83HLa+fsLfbSzp46qjGY1+lgSjnDxy
        MH5uHf+Gz+EjO70JZYwkyA9XKCX/AwoKenNRBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTZxjG951zenro7Hbo1H6TZJslYwqO22D5zJgxu+hJdMDiZsREocoR
        OkshPXTCsmxVmCK62ULZsCOhLA0rFK1csiAFgmXcbLAqhUHDRQeYsE7AdYyLs47ubEn/+73v
        87zP+33JS+GSScEWSqHKZ9UquVJGigiFFtO/bnpFeSy2cngTst3sxZF14hKJvl1cxZGzYhBD
        ZZcqhejxoAtHHfPfC9DtldMYqrP2YGjGZsTRxa5FAj0pnVzvFd/H0d/341CZYwSg2WEjhjo8
        UejutEWI7v6wF7V3DBBoqK2KRNW1s0KkO7uEo1HdLED6vmYBuupdIFC/J2x3GDPk3sf4+xtI
        Rl80L2Rck40EMzSoYZrqz5NMjbYCZ5rNXzJ2kw9j7GNakvm6aJ5krn81JWAWOodJxtYyTDC6
        5kYB42t6KTX0sCgpk1UqPmXVMbsyRNm/jziIvKq4AovvtFALrkWUghAK0glw4kwRWQpElIS2
        Aui3WQi+eARgm/OygC9qAZxo1RGBEZKOhY/7GvEAb6S3wQfuZixgwumSZ+HSqhkEhBfovbDb
        srYuUOsmBvY/PcRjPPxu6KOAg6BfheO+cjLAYjoRen+p/G9XF4CdXbp/hRA6CY7YxoUBBvRm
        uHyzAQswTkuhZ6Ya479AQ3O7C+d5E5yb9gt43gqnlueEvH8HNNn/IHneBZ1NVpznKFhb48X5
        R4TCgcszBD/7IrxhGSV0ABqD1hmDooxBUcagKGNQlAkI6oFUw3E5WQVcnIo9Fc3JcziNKiv6
        eG5OE1g/Qae/O60V9HgeRTsARgEHgBQu2yj+0559TCLOlBd+xqpz09UaJcs5QBhFyKRiyfv6
        dAmdJc9nT7JsHqv+X8WokC1arCax/ojXTN0+H31FVFazZwe1sp1Qi2QPe35MRYkPimydMbeS
        u9sORqXYP9xwVKTv112cm9izcj3ljj/h1gqMdHe6R/dhXsmq8Z3yzRnVJ/uOHk6PuRBlvPaM
        2/CaqcSjGZsTd6gGpcXFFblrackHbyyWRLwRry1wnpk/Llj4pD0zUkzvfnNM4d7vipAuPZ88
        HrPhp61EleasobUwb5xLNRvCz4VTum8+PvDkDvHrgZfVSbY+j7L63hdYeJ7i88WcI6c+SIg9
        sXOgt+GvE/F1FVpZhqU+v8WQcq9l2tDb0/pu6HNpieVXGN/TC2+Vp005zr3d6wotrNr/2887
        15br3A/fs8oILlseF4mrOfk/Z5cgv/EDAAA=
X-CMS-MailID: 20220429173008uscas1p1cde218cbcd1e37d4069cf9db33f82fbf
CMS-TYPE: 301P
X-CMS-RootMailID: 20220427160310eucas1p28cd3c5ff4fb7a04bc77c4c0b9d96bb74
References: <20220427160255.300418-1-p.raghav@samsung.com>
        <CGME20220427160310eucas1p28cd3c5ff4fb7a04bc77c4c0b9d96bb74@eucas1p2.samsung.com>
        <20220427160255.300418-14-p.raghav@samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 27, 2022 at 06:02:52PM +0200, Pankaj Raghav wrote:
> Convert the power of 2 based calculation with zone size to be generic in
> null_zone_no with optimization for power of 2 based zone sizes.
>=20
> The nr_zones calculation in null_init_zoned_dev has been replaced with a
> division without special handling for power of 2 based zone sizes as
> this function is called only during the initialization and will not
> invoked in the hot path.
>=20
> Performance Measurement:
>=20
> Device:
> zone size =3D 128M, blocksize=3D4k
>=20
> FIO cmd:
>=20
> fio --name=3Dzbc --filename=3D/dev/nullb0 --direct=3D1 --zonemode=3Dzbd  =
--size=3D23G
> --io_size=3D<iosize> --ioengine=3Dio_uring --iodepth=3D<iod> --rw=3D<mode=
> --bs=3D4k
> --loops=3D4
>=20
> The following results are an average of 4 runs on AMD Ryzen 5 5600X with
> 32GB of RAM:
>=20
> Sequential Write:
>=20
> x-----------------x---------------------------------x--------------------=
-------------x
> |     IOdepth     |            8                    |            16      =
             |
> x-----------------x---------------------------------x--------------------=
-------------x
> |                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s)=
 | Lat(usec) |
> x-----------------x---------------------------------x--------------------=
-------------x
> | Without patch   |  578     |  2257    |   12.80   |  576     |  2248   =
 |   25.78   |
> x-----------------x---------------------------------x--------------------=
-------------x
> |  With patch     |  581     |  2268    |   12.74   |  576     |  2248   =
 |   25.85   |
> x-----------------x---------------------------------x--------------------=
-------------x
>=20
> Sequential read:
>=20
> x-----------------x---------------------------------x--------------------=
-------------x
> | IOdepth         |            8                    |            16      =
             |
> x-----------------x---------------------------------x--------------------=
-------------x
> |                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s)=
 | Lat(usec) |
> x-----------------x---------------------------------x--------------------=
-------------x
> | Without patch   |  667     |  2605    |   11.79   |  675     |  2637   =
 |   23.49   |
> x-----------------x---------------------------------x--------------------=
-------------x
> |  With patch     |  667     |  2605    |   11.79   |  675     |  2638   =
 |   23.48   |
> x-----------------x---------------------------------x--------------------=
-------------x
>=20
> Random read:
>=20
> x-----------------x---------------------------------x--------------------=
-------------x
> | IOdepth         |            8                    |            16      =
             |
> x-----------------x---------------------------------x--------------------=
-------------x
> |                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s)=
 | Lat(usec) |
> x-----------------x---------------------------------x--------------------=
-------------x
> | Without patch   |  522     |  2038    |   15.05   |  514     |  2006   =
 |   30.87   |
> x-----------------x---------------------------------x--------------------=
-------------x
> |  With patch     |  522     |  2039    |   15.04   |  523     |  2042   =
 |   30.33   |
> x-----------------x---------------------------------x--------------------=
-------------x
>=20
> Minor variations are noticed in Sequential write with io depth 8 and
> in random read with io depth 16. But overall no noticeable differences
> were noticed
>=20
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/block/null_blk/main.c  |  4 ++--
>  drivers/block/null_blk/zoned.c | 14 +++++++-------
>  2 files changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
> index c441a4972064..82a62b543782 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1931,8 +1931,8 @@ static int null_validate_conf(struct nullb_device *=
dev)
>  		dev->mbps =3D 0;
> =20
>  	if (dev->zoned &&
> -	    (!dev->zone_size || !is_power_of_2(dev->zone_size))) {
> -		pr_err("zone_size must be power-of-two\n");
> +	    (!dev->zone_size)) {
> +		pr_err("zone_size must not be zero\n");
>  		return -EINVAL;
>  	}
> =20
> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zone=
d.c
> index dae54dd1aeac..00c34e65ef0a 100644
> --- a/drivers/block/null_blk/zoned.c
> +++ b/drivers/block/null_blk/zoned.c
> @@ -13,7 +13,10 @@ static inline sector_t mb_to_sects(unsigned long mb)
> =20
>  static inline unsigned int null_zone_no(struct nullb_device *dev, sector=
_t sect)
>  {
> -	return sect >> ilog2(dev->zone_size_sects);
> +	if (is_power_of_2(dev->zone_size_sects))
> +		return sect >> ilog2(dev->zone_size_sects);
> +
> +	return div64_u64(sect, dev->zone_size_sects);
>  }
> =20
>  static inline void null_lock_zone_res(struct nullb_device *dev)
> @@ -62,10 +65,6 @@ int null_init_zoned_dev(struct nullb_device *dev, stru=
ct request_queue *q)
>  	sector_t sector =3D 0;
>  	unsigned int i;
> =20
> -	if (!is_power_of_2(dev->zone_size)) {
> -		pr_err("zone_size must be power-of-two\n");
> -		return -EINVAL;
> -	}
>  	if (dev->zone_size > dev->size) {
>  		pr_err("Zone size larger than device capacity\n");
>  		return -EINVAL;
> @@ -83,8 +82,9 @@ int null_init_zoned_dev(struct nullb_device *dev, struc=
t request_queue *q)
>  	zone_capacity_sects =3D mb_to_sects(dev->zone_capacity);
>  	dev_capacity_sects =3D mb_to_sects(dev->size);
>  	dev->zone_size_sects =3D mb_to_sects(dev->zone_size);
> -	dev->nr_zones =3D round_up(dev_capacity_sects, dev->zone_size_sects)
> -		>> ilog2(dev->zone_size_sects);
> +	dev->nr_zones =3D
> +		div64_u64(roundup(dev_capacity_sects, dev->zone_size_sects),
> +			  dev->zone_size_sects);
> =20
>  	dev->zones =3D kvmalloc_array(dev->nr_zones, sizeof(struct nullb_zone),
>  				    GFP_KERNEL | __GFP_ZERO);
> --=20
> 2.25.1
>


Looks good.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>=
