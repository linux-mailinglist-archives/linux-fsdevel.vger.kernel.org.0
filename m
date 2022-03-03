Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5685B4CC6FD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 21:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbiCCUT2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 15:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiCCUT1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 15:19:27 -0500
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A871201BE;
        Thu,  3 Mar 2022 12:18:37 -0800 (PST)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20220303201833usoutp0185167bd6c1eed7d8b8a9897a40e7d1b8~Y_FZAstZT2748127481usoutp01w;
        Thu,  3 Mar 2022 20:18:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20220303201833usoutp0185167bd6c1eed7d8b8a9897a40e7d1b8~Y_FZAstZT2748127481usoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646338713;
        bh=XNs9o3PiVj/v+GQmw9HUamQ2I4NZjfWYZFfmyjQDoeU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=lylRfP2L+G3r7WhrtnQOkXEPTWmb6jnXJtvL0QH3zrfMs+ZqEn4unROmRfL/u0Zjb
         P64wiE6QwHU8G2SG8zV7SN9xKphtn1FPmWTWaeaLeti70S2iaHv1NCDG3yvfiY27a/
         ak9J4nBTwGsECX4goEsQI8BpLb1i8j+vjZxGMCdE=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220303201832uscas1p119c3cb347257ff94a0772fd4acdfa8dc~Y_FYqrzS52940229402uscas1p1v;
        Thu,  3 Mar 2022 20:18:32 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 7D.6C.09687.89221226; Thu, 
        3 Mar 2022 15:18:32 -0500 (EST)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220303201832uscas1p133de0a86878ca99bdde0c1d59a3b9708~Y_FYWIY7C2940229402uscas1p1u;
        Thu,  3 Mar 2022 20:18:32 +0000 (GMT)
X-AuditID: cbfec370-9ddff700000025d7-6d-6221229894c4
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 84.28.09671.89221226; Thu, 
        3 Mar 2022 15:18:32 -0500 (EST)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Thu, 3 Mar 2022 12:18:31 -0800
Received: from SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36]) by
        SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36%3]) with mapi id
        15.01.2242.008; Thu, 3 Mar 2022 12:18:31 -0800
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     =?iso-8859-1?Q?Matias_Bj=F8rling?= <Matias.Bjorling@wdc.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "Bart Van Assche" <bvanassche@acm.org>,
        Keith Busch <Keith.Busch@wdc.com>,
        "Johannes Thumshirn" <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Topic: [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Index: AQHYLpmb9dDgbycJL0eB2NODtYgLP6ytqQyAgAAQCACAADetAIAAVbuAgAAHhQCAAB4RAIAALQUAgAAHhYA=
Date:   Thu, 3 Mar 2022 20:18:31 +0000
Message-ID: <20220303201831.GC11082@bgt-140510-bm01>
In-Reply-To: <BYAPR04MB4968506D0A8CAB26AC266F8DF1049@BYAPR04MB4968.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <37E6E00FD8E83D4181B716A5803952FC@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTURRG82amM9Nq41gXnoIL1dQgiCISxqjYRBMbiVESN1yirY6AUqgd
        cd8rCFRjETC1TRQhwVItaBEiamURRFwRFwqluLUiVhONAiqKUgaT/jtf3ndvzk0eiYoaeWPJ
        hKQdjDpJnijGBVj53a4n0/TiQMWMV6+D6DNffqJ06vFuhM540IjQfzLbEbq8shqnba3B9C1b
        A0bf9thQWpfWhdJ2nRvQWfWlPPpyixuTDpU9ex4tqzA4CZkmrw2TWc0ZuCzbfhHIvlnHy45X
        aZFlxBrB3M1MYsJORj09aqMg3q11YqpLo3aX/NYSh8F3KhPwSUjNgqeyHoNMICBFVBGAltMm
        nAupCDQfvYL+b1mqfw22LACarmt4XPgCoCM/D+NCJYDXjrVh3hGcmgF7668OjI+kpLA0uxzx
        llCqG4O69qr+EkmOoMLhh7JDXGcWfOSpwzlWwCKTZ2AWoybD7zojz8vC/k7Zh46B/XxqPSwu
        yCa8DKjRsOf+ZcTLKOUHW13nEU57OMw33ho8YTTsu/EG5zgQvurpJLh+KLTn5uAcR8HX7lqU
        42BYeIFzEPbvaTjrwrjZMbDaZB84GFJaPmxrqOBxDwuh80UH4NgfvmjORbmSGcCc7jSCC6UA
        6n81DurNgX0ZLwkdmGzwMTf4WBl8rAw+VgYfqzzAMwO/FJZVxjFseBKzK5SVK9mUpLjQTclK
        K+j/dA/67qiug9bWr6E1ACFBDYAkKh4pnB00USESbpbv2cuokzeoUxIZtgb4k5jYT1iYcEUu
        ouLkO5htDKNi1P9fEZI/9jBisuozmujmYx5FBfi7yOSoXzm9x/jRyF/03lUzUZGyJCzmZ2Fg
        0IHw9NWR8wrG/QgBnWujb6ouNN33Z/RNASLhyXWaiNjZubaXmpCn2rsS92Ks7rk0xP9d5FYp
        3m5b73qbK8Vj9Cvq9u1qmd+77sZ+R69rzENVp3bVvWKrMrb20oblkvrgLs3ctpyjQqTAcaQq
        rWTE1Gh2/JbmBfkd51aeNU8qCun549mXntySXtHrtC9HPs+njcvc7u0ThhTHD7NME6SlZlpE
        xEHlNYcsXSpJjThhi4wNa/lb7nw0pbZq1aeZxRIpvzKAjRj1fkHUb4n4REnZmpgnErMha2nA
        QqJUjLHx8rCpqJqV/wOgHzJV4wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsWS2cA0UXeGkmKSwZtnwhbTPvxktmht/8Zk
        0Xn6ApPF3657TBbb9h9ks9h7S9tiz96TLBb7Xu9ltpjQ9pXZ4saEp4wWE49vZrVYc/MpiwOP
        x+Ur3h47Z91l92hecIfFY9OqTjaPyTeWM3p83iTn0X6gmymAPYrLJiU1J7MstUjfLoEr42n3
        XZaC1aIV6/90szcwfhHoYuTkkBAwkVh78BdjFyMXh5DAakaJf0dnsEI4HxglPu5/yATh7GeU
        2L7lBTtIC5uAgcTv4xuZQWwRAQeJzZO3gRUxC3xhkdj6ew1QOweHsICxxIut9RA1JhJnXx9l
        g7CTJFaueA3WyyKgIvFlwmxWEJsXqGbri+csEMuaWCRmLL0BtoxTIFZi3eLJYDajgJjE91Nr
        mEBsZgFxiVtP5jNB/CAgsWTPeWYIW1Ti5eN/rBC2osT97y/ZIer1JG5MncIGYdtJPHh6hBnC
        1pZYthDiIF4BQYmTM5+wQPRKShxccYNlAqPELCTrZiEZNQvJqFlIRs1CMmoBI+sqRvHS4uLc
        9Ipiw7zUcr3ixNzi0rx0veT83E2MwARx+t/hyB2MR2991DvEyMTBeIhRgoNZSYTXUlMhSYg3
        JbGyKrUoP76oNCe1+BCjNAeLkjivkOvEeCGB9MSS1OzU1ILUIpgsEwenVAMTp6iYyOJkLeO/
        ZzfuFZuxd1bOeY7DFWKnin9MKnLdMklW8PSZbzuPlhrLMhk9YFwmPeXgA0aDfwfa502MOJEf
        uOHuLJ7zR3R5DsRblp1KupBfuHz184LD0Ta3XH35VtS/mFBc9ka8s2ebc/rGKwnlVxtMQh49
        E7HQmlLuuPPutu4PcZJVsySM4q/ahAR/PXTztPsfvWMK9rocf6wtHRR+TlE9zHPdxOJ4yn0u
        Oe7GXQrya4T49BrVPx+IifkeZhniW39y25IS7lM7ViX6sjlsdf1z+//3/Rc2XrrUd/LLIt2/
        kYfPnjeZcjG2vTaI+8rGasGV84q/VvQyi4mIZ3yY9qLH/YqNYlDBIvacftdWJZbijERDLeai
        4kQAXi5OfH8DAAA=
X-CMS-MailID: 20220303201832uscas1p133de0a86878ca99bdde0c1d59a3b9708
CMS-TYPE: 301P
X-CMS-RootMailID: 20220303094915uscas1p20491e1e17088cfe8acda899a77dce98b
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
        <B3F227F7-4BF0-4735-9D0F-786B68871963@javigon.com>
        <20220303062950.srhm5bn3mcjlwbca@ArmHalley.localdomain>
        <CGME20220303094915uscas1p20491e1e17088cfe8acda899a77dce98b@uscas1p2.samsung.com>
        <8386a6b9-3f06-0963-a132-5562b9c93283@wdc.com>
        <20220303145551.GA7057@bgt-140510-bm01>
        <4526a529-4faa-388a-a873-3dfe92b0279b@wdc.com>
        <20220303171025.GA11082@bgt-140510-bm01>
        <BYAPR04MB4968506D0A8CAB26AC266F8DF1049@BYAPR04MB4968.namprd04.prod.outlook.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 03, 2022 at 07:51:36PM +0000, Matias Bj=F8rling wrote:
> > Sounds like you voluntered to teach zoned storage use 101. Can you teac=
h me
> > how to calculate an LBA offset given a zone number when zone capacity i=
s not
> > equal to zone size?
>=20
> zonesize_pow =3D x; // e.g., x =3D 32 if 2GiB Zone size /w 512B block siz=
e
> zone_id =3D y; // valid zone id
>=20
> struct blk_zone zone =3D zones[zone_id]; // zones is a linear array of bl=
k_zone structs that holds per zone information.
>=20
> With that, one can do the following
> 1a) first_lba_of_zone =3D  zone_id << zonesize_pow;
> 1b) first_lba_of_zone =3D zone.start;

1b is interesting. What happens if i don't have struct blk_zone and zone si=
ze=20
is not equal to zone capacity?

> 2a) next_writeable_lba =3D (zoneid << zonesize_pow) + zone.wp;
> 2b) next_writeable_lba =3D zone.start + zone.wp;

Can we modify 2b to not use zone.start?

> 3)   writeable_lbas_left =3D zone.len - zone.wp;
> 4)   lbas_written =3D zone.wp - 1;
>=20
> > The second thing I would like to know is what happens when an applicati=
on
> > wants to map an object that spans multiple consecutive zones. Does the
> > application have to be aware of the difference in zone capacity and zon=
e size?
>=20
> The zoned namespace command set specification does not allow variable zon=
e size. The zone size is fixed for all zones in a namespace. Only the zone =
capacity has the capability to be variable. Usually, the zone capacity is f=
ixed, I have not yet seen implementations that have variable zone capacitie=
s.
>=20

IDK where variable zone size came from. I am talking about the fact that th=
e=20
zone size does not have to equal zone capacity.=20

> An application that wants to place a single object across a set of zones =
would have to be explicitly handled by the application. E.g., as well as th=
e application, should be aware of a zone's capacity, it should also be awar=
e that it should reset the set of zones and not a single zone. I.e., the ap=
plication must always be aware of the zones it uses.
>=20
> However, an end-user application should not (in my opinion) have to deal =
with this. It should use helper functions from a library that provides the =
appropriate abstraction to the application, such that the applications don'=
t have to care about either specific zone capacity/size, or multiple resets=
. This is similar to how file systems work with file system semantics. For =
example, a file can span multiple extents on disk, but all an application s=
ees is the file semantics.=20
>=20

I don't want to go so far as to say what the end user application should an=
d=20
should not do.=
