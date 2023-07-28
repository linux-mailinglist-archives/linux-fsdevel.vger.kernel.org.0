Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6513766585
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 09:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbjG1Hlz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 03:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbjG1Hlx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:41:53 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B7BB6;
        Fri, 28 Jul 2023 00:41:50 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230728074149euoutp02aa03f38d08b21dca519f3165493919e2~1_C1yISzF0427104271euoutp02S;
        Fri, 28 Jul 2023 07:41:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230728074149euoutp02aa03f38d08b21dca519f3165493919e2~1_C1yISzF0427104271euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690530109;
        bh=gb0miwVpBtIdFutOnqdv+X2fb1Y0tMg1ouc2sR7L3Os=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=jP0fYcKVCJeYDv1Gx0jUCRduXfY4vnQsfFN/589lOAwqqHmnGo95sviSApP85HqL/
         b3N2mBa5tzSY5cdpqkjFos0iAVUm5SnHZIO0zPNk6R4D/CcfBpndnhSc1WHJDTctye
         vKJqYYTTS5KjUdaB6JnaFL/A8rqxgZ8sffzJ83hk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230728074148eucas1p2ae388ed7dc413903e0c928858d865465~1_C1hrfZu1594615946eucas1p28;
        Fri, 28 Jul 2023 07:41:48 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 96.02.37758.C3173C46; Fri, 28
        Jul 2023 08:41:48 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230728074148eucas1p119baa7ba630f26611d21a9a78aa4f48c~1_C1C-3SU2160921609eucas1p14;
        Fri, 28 Jul 2023 07:41:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230728074148eusmtrp2dbb0a376f74c12352732d7535784f5c4~1_C1CM1wD1226012260eusmtrp2G;
        Fri, 28 Jul 2023 07:41:48 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-2e-64c3713cfa1f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1D.4C.10549.C3173C46; Fri, 28
        Jul 2023 08:41:48 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230728074148eusmtip28b25f50dcc0ee88f4a41f3cc59f47298~1_C01TN9D2079920799eusmtip2G;
        Fri, 28 Jul 2023 07:41:48 +0000 (GMT)
Received: from localhost (106.210.248.223) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 28 Jul 2023 08:41:47 +0100
Date:   Fri, 28 Jul 2023 09:41:46 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <willy@infradead.org>,
        <josh@joshtriplett.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 06/14] sysctl: Add size to register_sysctl
Message-ID: <20230728074146.lwapkrfyn2kqvyec@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="23prfwofjqduce7c"
Content-Disposition: inline
In-Reply-To: <ZMKQSqeKNcJCqkDB@bombadil.infradead.org>
X-Originating-IP: [106.210.248.223]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WSfUxTVxjGc3pvb2+ZxUtp4AwIfxRnnCBsIO4kitkMyW7mR1iMc+jm1tm7
        QoC2aykwN2M7Kp9OG5eM0DmstVRWPrq2SGQgriXho3WUDdjUoQsCcRMaFK2COBz11s1k/z3P
        e37P+5EcEhO6iDgyX17MqOSSQjERgXf0Lfo3bPmkV/qK3bAROXx/EWjybw+B5qzHADrl1+No
        uu8mDw0bH3BR+Vk7gWYabAA9MSnQ5doiNNxxnIuck79yUffFQRyN/HCKQIYz5Ri6YpgGqM8U
        gx74ZgGy2lt5SD+eiZYWVgBr567XY+iWhhZAf6P9Gafbv7vKoU1ODe1qWk9fm8minbZqgjaY
        fwT0pW9beLTLcoSe6xkj6HvOxJxV+yK2SJnC/BJGlbb1w4i8iflKrrIqscx2uhdogRvWAD4J
        qY0wsNiP14AIUkg1AahzjBCsuQ9goPGLsLkHYJ1hAXsW8d6aDkfOATjR04v/S43X9mCsOQ+g
        L3iXG4rg1EvQN9XFC2mCSoH+2fGnrUTUOthj+JITCmBUOQGNN4ZWBpJkNLUVzvsPhBgB9Ro0
        G8e4rI6Cg/VTeEhjVBnsPtuKh3CMiofnlslQmU9tgr/VtRHspknQbVnisfow9LZfezoKUo4I
        6KquBaEspLJhx+T7LBMNb/e3h/kE+KTzdJj/CsBLy3d4rGkG0KoLclhqM9SPToUTb8CWxXqC
        bRoJrwSi2D0j4cmOOowtC2BVhZCl18LmG7O4ASQZn7vM+Nxlxv8uY8sp0NQ1T/yvnAytZ2Yw
        VmfBtrY53AR4NhDLaNRFMkadIWdKU9WSIrVGLks9qChygpW/7FvuD14ATbfvpnoAhwQesGYl
        fPP75mEQh8sVckYsEnhzPFKhQCr59BCjUnyg0hQyag+IJ3FxrCA5a/CgkJJJipkChlEyqmev
        HJIfp+UoL+78iXO9MIgyib0Vek6pu7Px7Xo8b4fhzuDcZ4PZh4JdZdZ8R8HwUKPrxN7jOSaF
        YZK/50VXF7O9WPsI/WlpyCw44UnapkkTjWSMPtrmDax++DHarYxyZ2dVngSlfxwb2E/kPp7/
        6L2Cq5PuusOxfLPC+c7m9AO6CxpLvH3U9kvty6sqdoi0PavpDenbY49KFrviz6MMozm6XTRh
        q9wpW3AnBszCPQ+PLg0N7CtNF3i/7naUqBIGZNn6+TFruVhHtOKPc0t2JboSEtNz/TFr3vKs
        Tf89IaZGurwpufNWWoNyf871JKfZMiP+vNAxcj8/8oV3Vbpqu+3NI1WXTSliXJ0neXU9plJL
        /gF0vnQuRgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRmVeSWpSXmKPExsVy+t/xe7o2hYdTDH5sEbHYePolm8Xjv4fY
        LN4v62G0mHO+hcXi6bFH7BYXZn1jtWhevJ7N4vW8VYwW/xfkW5zpzrW4sK2P1WLT42usFnv2
        nmSxuLxrDpvFhIXNzBY3JjxltDi2QMzi2+k3jBbL1q9lt2i5Y2rx+wdQwbKdfg5iHmvmrWH0
        mN1wkcVjy8qbTB4LNpV6bF6h5XHrta3HplWdbB4TFh1g9Ng/dw27x+Yl9R7v911l8/i8SS6A
        J0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv49ov
        jYI2uYqFl78xNzDul+hi5OSQEDCROPX8KUsXIxeHkMBSRom7h/6yQiRkJDZ+uQplC0v8udbF
        BlH0kVFi/70njBDOVkaJ+5M+sIBUsQioSpx+spsdxGYT0JE4/+YOM4gtIqAhsW9CLxNIA7NA
        M5vErHvngEZxcAgL2El8Oh8HUsMrYC6xaBbINpChp5kk1v5ZxgSREJQ4OfMJ2AJmgTKJZRPe
        s4P0MgtISyz/xwES5hQwk7g+fR0bxKXKEgeX/GaHsGslPv99xjiBUXgWkkmzkEyahTAJIqwl
        cePfSyYMYW2JZQtfM0PYthLr1r1nWcDIvopRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwNW07
        9nPzDsZ5rz7qHWJk4mA8xKgC1Plow+oLjFIsefl5qUoivKcCDqUI8aYkVlalFuXHF5XmpBYf
        YjQFhuJEZinR5Hxg0swriTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCU
        amCaxzk98CTjwqqCHptk3efN3yM279V58FdZinsKz4m7q3l6GOq2bX93sfuN6LSjt6/1dvAw
        CF6ViPji+SpGTq796J4Svv6VEl8DNqy5LuPDuXK9dc4xS9YjBRslZVzjDu9vnsYRdU12sqr+
        maL6Y+vqW5OWlHK2sLfmMnadPn125fxXObWHPE6eLNW6wv/2i7V0tM+582c41Pte3Ui5X7mc
        2dbWv154ycsnBp9nZK222qee9alCdmfD2g/PL3SwJZZYLVrzIWy/0N6zH4PbmdhOXnKdIKU1
        YZ7hyt/7Jsrtvs1q3jAp+ZtqxZcJVSo+a+sddb91HAl4ltUw+2NWLvt9ncayGcf1HxZai2ea
        XH2uxFKckWioxVxUnAgAgo+3peIDAAA=
X-CMS-MailID: 20230728074148eucas1p119baa7ba630f26611d21a9a78aa4f48c
X-Msg-Generator: CA
X-RootMTR: 20230726140659eucas1p2c3cd9f57dd13c71ddeb78d2480587e72
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230726140659eucas1p2c3cd9f57dd13c71ddeb78d2480587e72
References: <20230726140635.2059334-1-j.granados@samsung.com>
        <CGME20230726140659eucas1p2c3cd9f57dd13c71ddeb78d2480587e72@eucas1p2.samsung.com>
        <20230726140635.2059334-7-j.granados@samsung.com>
        <ZMFexmOcfyORkRRs@bombadil.infradead.org>
        <20230727122200.r5o2mj5qgah5yfwm@localhost>
        <ZMKQSqeKNcJCqkDB@bombadil.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--23prfwofjqduce7c
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 08:42:02AM -0700, Luis Chamberlain wrote:
> On Thu, Jul 27, 2023 at 02:22:00PM +0200, Joel Granados wrote:
> > On Wed, Jul 26, 2023 at 10:58:30AM -0700, Luis Chamberlain wrote:
> > > On Wed, Jul 26, 2023 at 04:06:26PM +0200, Joel Granados wrote:
> > > > In order to remove the end element from the ctl_table struct arrays=
, we
> > > > replace the register_syctl function with a macro that will add the
> > > > ARRAY_SIZE to the new register_sysctl_sz function. In this way the
> > > > callers that are already using an array of ctl_table structs do not=
 have
> > > > to change. We *do* change the callers that pass the ctl_table array=
 as a
> > > > pointer.
> > >=20
> > > Thanks for doing this and this series!
> > >=20
> > > > Signed-off-by: Joel Granados <j.granados@samsung.com>
> > > > ---
> > > > diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> > > > index 0495c858989f..b1168ae281c9 100644
> > > > --- a/include/linux/sysctl.h
> > > > +++ b/include/linux/sysctl.h
> > > > @@ -215,6 +215,9 @@ struct ctl_path {
> > > >  	const char *procname;
> > > >  };
> > > > =20
> > > > +#define register_sysctl(path, table)	\
> > > > +	register_sysctl_sz(path, table, ARRAY_SIZE(table))
> > > > +
> > > >  #ifdef CONFIG_SYSCTL
> > >=20
> > > Wasn't it Greg who had suggested this? Maybe add Suggested-by with him
> > > on it.
> > Yes. I mentioned him in the cover letter and did not add the tag because
> > I had not asked for permission to use it. I'll drop him a mail and
> > include the suggested-by if he agrees.
>=20
> FWIW, I never ask, if they ask for it, clearly they suggested it.
I was following Documentation/process/submitting-patches.rst:
"... Please note that this tag should not be added without the
reporter's permission... ".
In any case, Greg has already said yes :)

>=20
> > > Also, your cover letter and first few patches are not CC'd to the net=
dev
> > > list or others. What you want to do is collect all the email addresses
> > > for this small patch series and add them to who you email for your
> > > entire series, otherwise at times they won't be able to properly revi=
ew
> > > or understand the exact context of the changes. You want folks to do =
less
> > > work to review, not more.
> > Here I wanted to avoid very big e-mail headers as I have received
> > rejections from lists in the past. But I for this set, the number of
> > e-mails is ok to just include everyone.
>=20
> I hear that from time to time, if you have issues with adding folks on
> the To address it may be an SMTP server issue, ie, corp email SMTP
> server issues. To fix that I avoid corp email SMTP servers.
My experience was more from the lists rejecting the e-mail because the
header was too big. With that said, I'll look into SMTP alternatives to
reduce possible errors

>=20
>   Luis

--=20

Joel Granados

--23prfwofjqduce7c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmTDcToACgkQupfNUreW
QU8ebwv/XlR1FEHFz9SLvGQjHETNnsFs3RVx30G5KCg+zWiSQoVJOlNktqeQbH35
CmMfVi3M7mt/wJZ8MiyXFowzmGqVF7lNCpOYIH4s8ppDEylmxhowVw8QKFYLd74Q
SksNllHUi2tmbhnpH+YuIDL1HTPt+p6ejYhq3kCFTB2DbibH+1uCiNMTYTov3Hq0
/sLMgb7zpqQviJPX0rR0ctXcwY2w04MQmyAjN4ot8qskmckzvLmoP3ILVFdvbkb/
/+zuPvocJZxuizrgxUNbpcz7m+4v0yzbTMl+xRl2RnGfHIKNU/jGmT2mDPVAoaOj
bb9PqgILxfxkhh6arsoTPt0HjTihLhGiJnxSGzyCBJzGjpF98y5g6PU52t0JGid9
0kX4/EPh31hklspwHaqbhRqWafJy6iU5xW2FkjFHOAPfdEtpRK9Ubwh8Roxa9KR9
EUjgl6+Bgg0TvcSOjxgEK7HmeudqheOIU939bFeQFh6vs2KCnc3IdxOuhTtC3IHR
B9dgJcCy
=qAfE
-----END PGP SIGNATURE-----

--23prfwofjqduce7c--
