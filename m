Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0D84CB665
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 06:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiCCF3y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 00:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCCF3v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 00:29:51 -0500
X-Greylist: delayed 422 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Mar 2022 21:29:02 PST
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F4029CAE
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Mar 2022 21:29:02 -0800 (PST)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220303052157usoutp02320a7e99e12621b2796bc1359eac2373~Yx2jdRdFb0227002270usoutp02h;
        Thu,  3 Mar 2022 05:21:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220303052157usoutp02320a7e99e12621b2796bc1359eac2373~Yx2jdRdFb0227002270usoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646284917;
        bh=3ME7q8n9o+nFdKHrORE1LKg82DkguanQX25wTsKO31c=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=TSHq/G9jvfUrTze3dMcvZnig6qkECsP8H0HlpI8yVjKMw/2xVUXaVhYNX44e48QiY
         gmLjGDlA4VHHXmn0vNQ3EmdZ40xLg4t0O9hdGKLUwJ4geJPGYJY5RzxychYBlATpLB
         XXELmCBVuHuGWmTgc2YA80IbclOORiETRid6YRb8=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220303052156uscas1p25a7aa999de9ba6402e9d323dc79f001f~Yx2ikwuMk3082830828uscas1p25;
        Thu,  3 Mar 2022 05:21:56 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 01.07.09687.37050226; Thu, 
        3 Mar 2022 00:21:55 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220303052155uscas1p195fd9fea8e8de3896234a0699937a6be~Yx2iLwv201979019790uscas1p1l;
        Thu,  3 Mar 2022 05:21:55 +0000 (GMT)
X-AuditID: cbfec370-9c5ff700000025d7-1b-622050734b1e
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id AA.6E.10042.37050226; Thu, 
        3 Mar 2022 00:21:55 -0500 (EST)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Wed, 2 Mar 2022 21:21:54 -0800
Received: from SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36]) by
        SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36%3]) with mapi id
        15.01.2242.008; Wed, 2 Mar 2022 21:21:51 -0800
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     =?iso-8859-1?Q?Matias_Bj=F8rling?= <Matias.Bjorling@wdc.com>
CC:     Bart Van Assche <bvanassche@acm.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "Keith Busch" <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Topic: [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Index: AQHYLpmb9dDgbycJL0eB2NODtYgLP6ytZjoAgAAx7ACAAA3tgA==
Date:   Thu, 3 Mar 2022 05:21:51 +0000
Message-ID: <20220303052146.GA4578@bgt-140510-bm01>
In-Reply-To: <BYAPR04MB496825C09F9428D725E9F712F1049@BYAPR04MB4968.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <1590AFAC29E35E49A5A8B5E3D8377B51@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRmVeSWpSXmKPExsWy7djXc7rFAQpJBlN3WlpM+/CT2aK1/RuT
        xd+ue0wW2/YfZLPYe0vbYs/ekywW+17vZbaY0PaV2eLGhKeMFhOPb2a1WHPzKYsDt8flK94e
        O2fdZffYtKqTzWPyjeWMHp83yXm0H+hmCmCL4rJJSc3JLEst0rdL4MrYdfkQc8E8voolW6ay
        NzBe5O5i5OSQEDCROPuxh7mLkYtDSGAlo8Tx9U/ZIJxWJom56z+wwFQtff8UzBYSWMsocX6e
        BIT9gVHixGEfCHs/o8Sku2IgNpuAgcTv4xuZQWwRAQeJzZO3MYEMZRb4ySJx90gDUIKDQ1jA
        WOLF1nqIGqArXh9lg7CdJFbNncQEYrMIqEj8eruBEaScF6j8wkV5kDCnQKzEtju9YOWMAmIS
        30+tAStnFhCXuPVkPhPEyYISi2bvYYawxST+7XrIBmErStz//pIdol5P4sbUKWwQtp3Elwuf
        oGxtiWULX4P18gLNOTnzCTQYJCUOrrjBAvKKhMB/Dom23+8ZIRIuEr9PXIAqkpb4e3cZE0TR
        KkaJKd/a2CGczYwSM35dgDrPWuJf5zX2CYwqs5BcPgvJVbOQXDULyVWzkFy1gJF1FaN4aXFx
        bnpqsXFearlecWJucWleul5yfu4mRmAyO/3vcMEOxlu3PuodYmTiYDzEKMHBrCTCa6mpkCTE
        m5JYWZValB9fVJqTWnyIUZqDRUmcd1nmhkQhgfTEktTs1NSC1CKYLBMHp1QDk23ekdS4e7zv
        Vu5Y2bE6yG6VkblRztwS1sT6hPCCOhlB/iZ7jUZWJoXfCgdEfWu+XhM4oKTysu/5sxJ5ncgv
        BV8F1GYd2nLGe8tTa4f0onNXDuy6ea7h//ztoWt8EvzLmOe9aLg6+f8WpYPazKIzft/7Ga6m
        zLAhWzW/6nzRJg6BmpuLBDusdlreLLL+vHf6+aJXnc3ThDWKr7pNyiy/84Bj+4w5T5v+ym0z
        u9eVYOnbKc+mZ/I98uwXrT23vvmd57Ny1Eh1DVy7X4Q1zUW35Oz7oLfF19Zv5/b9f+e7/3n1
        cLGpl9dezlGY/yDtqIuo67XrliwSDr9rDfmWs3x6VSIS/pVpxsGYmLYoa/lqJZbijERDLeai
        4kQAZZpGXtUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsWS2cA0Sbc4QCHJYNVlPYtpH34yW7S2f2Oy
        +Nt1j8li2/6DbBZ7b2lb7Nl7ksVi3+u9zBYT2r4yW9yY8JTRYuLxzawWa24+ZXHg9rh8xdtj
        56y77B6bVnWyeUy+sZzR4/MmOY/2A91MAWxRXDYpqTmZZalF+nYJXBm7Lh9iLpjHV7Fky1T2
        BsaL3F2MnBwSAiYSS98/Zeli5OIQEljNKPFnwxwmkISQwAdGiR2LnCAS+xkl7v1pYAFJsAkY
        SPw+vpEZxBYRcJDYPHkbE0gRs8BPFokVr2azdTFycAgLGEu82FoPUWMicfb1UTYI20li1dxJ
        YAtYBFQkfr3dwAhSzgtUfuGiPMSuXiaJTzfXgtVwCsRKbLvTC9bLKCAm8f3UGrA4s4C4xK0n
        85kgPhCQWLLnPDOELSrx8vE/VghbUeL+95fsEPV6EjemTmGDsO0kvlz4BGVrSyxb+Bqsl1dA
        UOLkzCcsEL2SEgdX3GCZwCgxC8m6WUhGzUIyahaSUbOQjFrAyLqKUby0uDg3vaLYKC+1XK84
        Mbe4NC9dLzk/dxMjMBGc/nc4egfj7Vsf9Q4xMnEwHmKU4GBWEuG11FRIEuJNSaysSi3Kjy8q
        zUktPsQozcGiJM77MmpivJBAemJJanZqakFqEUyWiYNTqoFp4sYtfs/umxydIZ17p6u4L0sg
        5ZDPH4uG5JnxWl9+6C5/0tWWl3FbRHzqhoIQtxqe27pPpjKUfn6yxrT20eNn83bHurSUnNO6
        Ly4ZF2tnkr432HBlvsYmk6yIa1//1AUs28TO7PS1U+rFGoFwhp+Mwur293Orp9e0NCaL3dj2
        MLL74r/XP9Pmc1+UMVavLcrxntdfFrnvmv+m1B+TfZ1sn1fv1vZWESr2S1XMZC/VeOlvq3d3
        0WW2Fas5+3ZMvvFA8ovZpEe7H8517VnDbth4+ZH1Xl5v/uU9L4+mWXY+bj+htUN2YrnkvYS2
        LIuESW9UZ7KufOgeZxy3rq9E7cUKi4m9KeYrbV5ezop+/USJpTgj0VCLuag4EQByghNdcwMA
        AA==
X-CMS-MailID: 20220303052155uscas1p195fd9fea8e8de3896234a0699937a6be
CMS-TYPE: 301P
X-CMS-RootMailID: 20220303043207uscas1p1dc256d10ab8581a900dfc1b2fcf0bd13
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
        <a1efd5b0-f64a-9170-61e3-e723d44aa04f@acm.org>
        <CGME20220303043207uscas1p1dc256d10ab8581a900dfc1b2fcf0bd13@uscas1p1.samsung.com>
        <BYAPR04MB496825C09F9428D725E9F712F1049@BYAPR04MB4968.namprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 03, 2022 at 04:31:58AM +0000, Matias Bj=F8rling wrote:
> Good idea to bring up zoned storage topics. I'd like to participate as we=
ll.
>=20
> Best, Matias

I'm also working on zoned storage ATM so count me in as well.

>=20
> -----Original Message-----
> From: Bart Van Assche <bvanassche@acm.org>=20
> Sent: Thursday, 3 March 2022 02.33
> To: Luis Chamberlain <mcgrof@kernel.org>; linux-block@vger.kernel.org; li=
nux-fsdevel@vger.kernel.org; lsf-pc@lists.linux-foundation.org
> Cc: Matias Bj=F8rling <Matias.Bjorling@wdc.com>; Javier Gonz=E1lez <javie=
r.gonz@samsung.com>; Damien Le Moal <Damien.LeMoal@wdc.com>; Adam Manzanare=
s <a.manzanares@samsung.com>; Keith Busch <Keith.Busch@wdc.com>; Johannes T=
humshirn <Johannes.Thumshirn@wdc.com>; Naohiro Aota <Naohiro.Aota@wdc.com>;=
 Pankaj Raghav <pankydev8@gmail.com>; Kanchan Joshi <joshi.k@samsung.com>; =
Nitesh Shetty <nj.shetty@samsung.com>
> Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
>=20
> On 3/2/22 16:56, Luis Chamberlain wrote:
> > Thinking proactively about LSFMM, regarding just Zone storage..
> >=20
> > I'd like to propose a BoF for Zoned Storage. The point of it is to=20
> > address the existing point points we have and take advantage of having=
=20
> > folks in the room we can likely settle on things faster which=20
> > otherwise would take years.
> >=20
> > I'll throw at least one topic out:
> >=20
> >    * Raw access for zone append for microbenchmarks:
> >    	- are we really happy with the status quo?
> > 	- if not what outlets do we have?
> >=20
> > I think the nvme passthrogh stuff deserves it's own shared discussion=20
> > though and should not make it part of the BoF.
>=20
> Since I'm working on zoned storage I'd like to participate.
>=20
> Thanks,
>=20
> Bart.=
