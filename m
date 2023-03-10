Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD346B3392
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 02:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCJBQP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 20:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCJBQO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 20:16:14 -0500
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8004FDDB3A;
        Thu,  9 Mar 2023 17:16:11 -0800 (PST)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230310011606usoutp028ff7a36ba109ecace415a993c1d4b157~K6eHAmKnK1452214522usoutp02i;
        Fri, 10 Mar 2023 01:16:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230310011606usoutp028ff7a36ba109ecace415a993c1d4b157~K6eHAmKnK1452214522usoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678410967;
        bh=m0Ow2bytomyXCbdVijWryXq7yza/hXO0VMWtfpb0usY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Jf7bOhEw13P7w4Ne3B/8VOp05OyWnwcINZoFcDpMH98iGztdH5g4J4QnipU3WCYtk
         PN6j9qwpItJ3zmXQzM7KqVTptMxyYweNhIwt76Tdi3U8tOD1ZAxtngrfFrZ2abaihv
         xBbHo2lUQirF4dstdCcT5q6UcZrYNZm/muLtEidM=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230310011606uscas1p226bd91ecc566d4d8225de90fb8e583e3~K6eG3IbZb0687506875uscas1p2Z;
        Fri, 10 Mar 2023 01:16:06 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 84.44.49129.6D48A046; Thu, 
        9 Mar 2023 20:16:06 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230310011606uscas1p12996a276699fd22c03f06ed017bb3ba9~K6eGayM6V0604406044uscas1p1h;
        Fri, 10 Mar 2023 01:16:06 +0000 (GMT)
X-AuditID: cbfec36f-eddff7000001bfe9-59-640a84d69ac5
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 4F.A6.17110.6D48A046; Thu, 
        9 Mar 2023 20:16:06 -0500 (EST)
Received: from SSI-EX4.ssi.samsung.com (105.128.2.229) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Thu, 9 Mar 2023 17:16:05 -0800
Received: from SSI-EX4.ssi.samsung.com ([105.128.5.229]) by
        SSI-EX4.ssi.samsung.com ([105.128.5.229]) with mapi id 15.01.2375.024; Thu,
        9 Mar 2023 17:16:05 -0800
From:   Dan Helmick <dan.helmick@samsung.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>
CC:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: RE: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Thread-Topic: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Thread-Index: AQHZUswbWM8PXXLn2UKrVhzh6Ch5Aa7y9q84gAAuGYA=
Date:   Fri, 10 Mar 2023 01:16:05 +0000
Message-ID: <dfd0405cf7eb4b9ea8cccba97e31d25d@samsung.com>
In-Reply-To: <yq1ttytbox9.fsf@ca-mkp.ca.oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsWy7djXc7rXWrhSDE690LTYs2gSk8XGfg6L
        SYeuMVrsvaVtsWfvSRaLe2v+s1rse72X2WL58X9MFjcmPGW0aO35yW7x+8ccNgduj2mTTrF5
        bF6h5bFpVSebx6ZPk9g9Jt9YzujRdOYos8fHp7dYPDafrvb4vEkugDOKyyYlNSezLLVI3y6B
        K+PkhodsBdfFKvrvLmFqYDwn1MXIySEhYCKxe/VVti5GLg4hgZWMEkdu/2GHcFqZJBqnb2CF
        qfq14zpU1VpGifuzGqGcj4wSO6Z9gGpZyihx4NN5FpAWNgFtiVuvdwG1c3CICMRKbJ1uBVLD
        LHCGReJ7wyE2kBphAWuJff8mMkPU2EhMOCUJEhYRsJI4198LVsIioCpx58UkZhCbFyj+ZsNP
        FpByTgFjiT07rEHCjAJiEt9PrWECsZkFxCVuPZnPBHG0oMSi2XuYIWwxiX+7HrJB2IoS97+/
        ZIeo15O4MXUKG4StLbFs4WuoVYISJ2c+YYGol5Q4uOIGC8j5EgL/OSQu7JoANdRFou//dEYI
        W1ri791lTBBF6xglFr75wQbhzGCU+Ni2A6rDWuLhpYdQp/JJ/P31iHECo/IsJJfPQnLVLCRX
        zUJy1QJGllWM4qXFxbnpqcVGeanlesWJucWleel6yfm5mxiBKe30v8P5Oxiv3/qod4iRiYPx
        EKMEB7OSCO93KY4UId6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryGtieThQTSE0tSs1NTC1KLYLJM
        HJxSDUwhXcxXU0/sOnDn13MuHqPS4wbxvEGlXww2Se4q6GfIE+2SuKX9Qjnl882qvxrPmwov
        eTlXs2r/V3p0NjnQ8FlOztYziyVZGTq2CL39yb78tMO/qd9KfnpzLdMynHQs44mwntbO02pT
        l52ffEx82vIzt/5fKzHYqJ5+vH/qSvfWdw+FptR/P3a7u+K3WP2p6ZFRZ903vKn5LS92c8lp
        uawjD/QnM8TeXVvVPo+ldPbK5c8kp6z9HZzcdHmC7Ty9yCNPfd6tZ3p94pF6aMKarxPunV8u
        wCwm+uOrRE+L1yTBg4aWN9ufdTd+/mFkmH3CdmnhDeHtKWVHGZccEjqW9NWo1XFus09IRKxo
        kG/wcpUPSizFGYmGWsxFxYkA7DML+NgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsWS2cA0UfdaC1eKwep1PBZ7Fk1istjYz2Ex
        6dA1Rou9t7Qt9uw9yWJxb81/Vot9r/cyWyw//o/J4saEp4wWrT0/2S1+/5jD5sDtMW3SKTaP
        zSu0PDat6mTz2PRpErvH5BvLGT2azhxl9vj49BaLx+bT1R6fN8kFcEZx2aSk5mSWpRbp2yVw
        ZZzc8JCt4LpYRf/dJUwNjOeEuhg5OSQETCR+7bjO1sXIxSEksJpRYs/tj6wQzkdGiesTJrBA
        OEsZJW6+38IO0sImoC1x6/UuoCoODhGBWImt061AapgFzrBIfG84xAZSIyxgLbHv30RmiBob
        iQmnJEHCIgJWEuf6e8FKWARUJe68mMQMYvMCxd9s+Am1ayKrxI6mpywgvZwCxhJ7dliD1DAK
        iEl8P7WGCcRmFhCXuPVkPhPEBwISS/acZ4awRSVePv7HCmErStz//pIdol5P4sbUKWwQtrbE
        soWvofYKSpyc+YQFol5S4uCKGywTGMVnIVkxC0n7LCTts5C0L2BkWcUoXlpcnJteUWyUl1qu
        V5yYW1yal66XnJ+7iREY86f/HY7ewXj71ke9Q4xMHIyHGCU4mJVEeL9LcaQI8aYkVlalFuXH
        F5XmpBYfYpTmYFES530ZNTFeSCA9sSQ1OzW1ILUIJsvEwSnVwLSe+6dE+uwOg+x6njsyF362
        xN3ia75xcK1rNXMI29V9s/jc9I0PcuS4LtRqW3yjsSJzzbnHRSfWvXyzNePmn63VCqGOD5TX
        zDDYNmlZ5XKuT9WGU1ulPSYkvbXSKda9ua7wvKOGb1KI/+ma2eV6ah4Nza11hukdOr6/9z/5
        XNd/cpYhs/rbTT/PWjy47PNHxNnl2r2zXwU6A89GmD6f4qSyP9pbg30Wn3Ii8+eyXvY1TlEz
        /TJX1WbP/mq8dJvVXH65m5I745pnheXt7bXbfk+0UN7tUqv6ncqwxS6fIq4lrE1XE5fiiVq/
        cM2f5kuHlJbdm1Gj+ObLnZwn3qndEvNneW7c6nTUSzTvT/jVH0osxRmJhlrMRcWJAPo+7Gxo
        AwAA
X-CMS-MailID: 20230310011606uscas1p12996a276699fd22c03f06ed017bb3ba9
CMS-TYPE: 301P
X-CMS-RootMailID: 20230308181355eucas1p1c94ffee59e210fb762540c888e8eae8a
References: <0b70deae-9fc7-ca33-5737-85d7532b3d33@suse.de>
        <ZAWi5KwrsYL+0Uru@casper.infradead.org> <20230306161214.GB959362@mit.edu>
        <ZAjLhkfRqwQ+vkHI@casper.infradead.org>
        <CGME20230308181355eucas1p1c94ffee59e210fb762540c888e8eae8a@eucas1p1.samsung.com>
        <1367983d4fa09dcb63e29db2e8be3030ae6f6e8c.camel@HansenPartnership.com>
        <20230309080434.tnr33rhzh3a5yc5q@ArmHalley.local>
        <260064c68b61f4a7bc49f09499e1c107e2a28f31.camel@HansenPartnership.com>
        <yq11qlygevs.fsf@ca-mkp.ca.oracle.com>
        <f929f8d8e61da345be525ab06d4bb34ed2ce878b.camel@HansenPartnership.com>
        <ZApMC8NLDfI6/ImD@bombadil.infradead.org>
        <yq1ttytbox9.fsf@ca-mkp.ca.oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> -----Original Message-----
> From: Martin K. Petersen [mailto:martin.petersen@oracle.com]
> Sent: Thursday, March 9, 2023 2:28 PM
> To: Luis Chamberlain <mcgrof@kernel.org>
> Cc: James Bottomley <James.Bottomley@hansenpartnership.com>; Dan
> Helmick <dan.helmick@samsung.com>; Martin K. Petersen
> <martin.petersen@oracle.com>; Javier Gonz=E1lez
> <javier.gonz@samsung.com>; Matthew Wilcox <willy@infradead.org>;
> Theodore Ts'o <tytso@mit.edu>; Hannes Reinecke <hare@suse.de>; Keith
> Busch <kbusch@kernel.org>; Pankaj Raghav <p.raghav@samsung.com>;
> Daniel Gomez <da.gomez@samsung.com>; lsf-pc@lists.linux-foundation.org;
> linux-fsdevel@vger.kernel.org; linux-mm@kvack.org; linux-
> block@vger.kernel.org
> Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
>=20
>=20
> Luis,
>=20
> > A big future question is of course how / when to use these for
> > filesystems.  Should there be, for instance a 'mkfs --optimal-bs' or
> > something which may look whatever hints the media uses ? Or do we just
> > leaves the magic incantations to the admins?
>=20
> mkfs already considers the reported queue limits (for the filesystems mos=
t
> people use, anyway).
>=20
> The problem is mainly that the devices don't report them. At least not ve=
ry
> often in the NVMe space. For SCSI devices, reporting these parameters is
> quite common.
>=20
> --
> Martin K. Petersen	Oracle Linux Engineering

Support for the NVMe Optimal Performance parameters is increasing in the ve=
ndor ecosystem.  Customers are requiring this more and more from the vendor=
s.  For example, the OCP DC NVMe SSD spec has NVMe-AD-2 and NVMe-OPT-7 [1].=
  Momentum is continuing as Optimal Read parameters were recently added to =
NVMe too.  More companies adding these parameters as a drive requirement to=
 drive vendors would definitely help the momentum further. =20

I think there has been confusion among the vendors in the past on how to se=
t various values for the best Host behavior.  There are multiple (sometimes=
 minor) inflection points in the performance of a drive.  Sure.  4KB is too=
 small to report by the drive, but shall we report our 16KB, 128KB, or some=
 other inflection?  How big of a value can we push this?  We would always f=
avor the bigger number. =20

There are benefits for both Host and Drive (HDD and SSD) to have larger IOs=
.  Even if you have a drive reporting incorrect optimal parameters today, o=
ne can incubate the SW changes with larger IOs.  If nothing else, you'll in=
stantly save on the overheads of communicating the higher number of command=
s.  Further doing an IO sized to be a multiple of the optimal parameters is=
 also optimal.  Enabling anything in the range 16KB - 64KB would likely be =
a great start. =20

[1] https://www.opencompute.org/documents/datacenter-nvme-ssd-specification=
-v2-0r21-pdf


Dan
