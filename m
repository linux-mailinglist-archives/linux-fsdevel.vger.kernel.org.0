Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A840719235
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 07:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjFAFfo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 01:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjFAFfn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:35:43 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4928512C;
        Wed, 31 May 2023 22:35:41 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230601053538euoutp010adf47f22b7623a8c54a0994dcebcf80~kcjZfOcRI0492804928euoutp01f;
        Thu,  1 Jun 2023 05:35:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230601053538euoutp010adf47f22b7623a8c54a0994dcebcf80~kcjZfOcRI0492804928euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685597738;
        bh=aUenvpmHVKaOGRWzayQ33h1nr5MyWcwf/XQZl+5lk0c=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=S+XGj64yFyDX/2ZUKbRKMmEGm1+2r1exwJXasOdFT4XnyOnYDxkmO9JFPSUD2oAXT
         tPiM6DdBJqXth3PQ+C3w4oAO24MSL9Nm05fa04TQuhas2TQYy3EgZ9Nj33cUrEFzsK
         y2ytRHQDXSHS29gkMdAekM8DW7jOcED7jUwXjUl0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230601053538eucas1p28e1eb765accfa7c9b0b42254983975c1~kcjZOJkxh3051330513eucas1p2u;
        Thu,  1 Jun 2023 05:35:38 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 74.50.11320.92E28746; Thu,  1
        Jun 2023 06:35:37 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230601053537eucas1p1f1d8e821e9e9b6728072a8e541b8dbfc~kcjYwUIWk3153831538eucas1p1k;
        Thu,  1 Jun 2023 05:35:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230601053537eusmtrp165609602eeefa8d933fd26c91f849636~kcjYvkIki1921519215eusmtrp1K;
        Thu,  1 Jun 2023 05:35:37 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-9a-64782e29ac43
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 81.A1.10549.92E28746; Thu,  1
        Jun 2023 06:35:37 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230601053537eusmtip127e4a767963c24da38a6678480517f99~kcjYheqTQ2607526075eusmtip1U;
        Thu,  1 Jun 2023 05:35:37 +0000 (GMT)
Received: from localhost (106.210.248.78) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 1 Jun 2023 06:35:35 +0100
Date:   Thu, 1 Jun 2023 07:35:34 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     <ebiederm@xmission.com>, <keescook@chromium.org>,
        <yzaikin@google.com>, <dave.hansen@intel.com>, <arnd@arndb.de>,
        <bp@alien8.de>, <James.Bottomley@hansenpartnership.com>,
        <deller@gmx.de>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <luto@kernel.org>,
        <peterz@infradead.org>, <brgerst@gmail.com>,
        <christophe.jaillet@wanadoo.fr>, <kirill.shutemov@linux.intel.com>,
        <jroedel@suse.de>, <akpm@linux-foundation.org>,
        <willy@infradead.org>, <linux-parisc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] sysctl: remove empty dev table
Message-ID: <20230601053534.272v4berfml7vytz@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="wy2llykbgglghma3"
Content-Disposition: inline
In-Reply-To: <ZHZ+zsOTBhvn3rfu@bombadil.infradead.org>
X-Originating-IP: [106.210.248.78]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WSfUxTVxjGd24Pt7e44qXVcSgLSmXGyYdzce6s6tBIsusf07EmbtMoNnAH
        ZLR1LQiOuNQoOupwCBNrBQMTC1KmtAUiRT7GHB/t+BhIwM19BCWAfINEtKOOcnEz2X/P+7zP
        7+R5k0PxRB2khEpQJbEalSJRSnrDqqYn7WGvh6fGvjHmlOG8G2Ukns9u4uOZcjeJ2xoRrvwh
        3wtPD/8F8J/TvwH8rOokH+da/LDlGwrnOPIJ/PMZJb47mAfxrdpWiLvteSTud3QSuMP+vRfu
        yxoAuKuhgMDNmQ0EtlnP87BrbiEyV37fC5uqd29HzOP0s5BxPc0GzCXdL5CpNv7OZyanDjIF
        1mQmN9tBMraS9cyVW8MEYy3NIJnx9nY+02JwQeZyaxQzUdezEHCmMTPWwA/E+7y3xrKJCUdY
        zYZ3D3nH95dmwMPfBaUahx2kDhgkeiCgEL0J/VTUBfXAmxLRJQBdaikjuOERQD3WEj43zADU
        pXPwniNllgHALYoBOl9rJv5NmV1zS4gNIPe3LaQeUBSkg9Fo6TsemqRDUcfovcWXVtDrUF1W
        JuHRPLoZosHhcI8W0zLUN/5kERXSb6OM9lCPLaR9UevFB5CLp6LZc04vT4RHB6BiN+WxBfRm
        NG/XQ66nFFXqxwlOH0OOil8XayK6xxsZzuj43CISuY93e3FajB42Vyz5ryJnzteQA3IAqndP
        8rnBDJDp+OzSs1vQyTsPlogdqMR0mvA0QrQP6hvz5Yr6oOyqCzzOFqKvTom49Fpk/mMUZoE1
        xhdOM75wmvG/0zg7FBXUTJP/s0OQqXCEx+lt6Pr1CVgA+KXAj03WKuNY7ZsqNiVcq1Bqk1Vx
        4TFqpRUs/HOnu/nRTVD8cCq8ERAUaATBC3B/ubkTSKBKrWKlK4SivSmxImGs4ugXrEYdrUlO
        ZLWNIICCUj9hyLbWGBEdp0hiP2PZw6zm+ZagBBIdsSmiIj0jWnWNufaYClRSvK2w1rdOYt//
        d0DMlOyVgc7ZT/S9az/qfUtSmJqlG3g6JmsyrbIuN32ZOJEm96/PtUHf2RP20sAGHPfhjT1J
        YXTulaGw4lXNBz4VEKhaHp8fHFSRnhKkzjf6n7gaEJNwbPOPPkXYYhYvW7lzfmhN8PBO+crl
        EevOHZkb2rGnRmzmr7ZZNwhSs6MObvTR56b3NiTMZLSVyQ/kVGz/2PCa6ertscuTF9WuyGjz
        XtnRNkHNIeP+z3enB82drfKvld0/Nf6e8OXCkGXdYzfrX0qz6zN3GW63ycPubCmSRN7bVRR6
        dzAtIh9a9lXahSOnRy5Eyd5/JoXaeMXG9TyNVvEPIqglqGIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsVy+t/xu7qaehUpBl3nZC3mrF/DZvF30jF2
        i88b/rFZnD0kYbH14FxWi08vHzBa3P90m9Hi/7YWdotpG8UtNvZzWEw+NZfJ4kx3rsXN53NY
        LPbsPclicXnXHDaLR6cuMFmc37WW1eLGhKeMFpcOLGCyON57gMli86apzBa/fwCV/NjwmNVi
        2U4/BwmP7619LB6/f01i9JjdcJHFY+esu+weHz7GeSzYVOoxbdIpNo/NK7Q8Fu95yeSxaVUn
        m8e7c+fYPU7M+M3iMe9koMf7fVeBCk5Xe3zeJBcgHKVnU5RfWpKqkJFfXGKrFG1oYaRnaGmh
        Z2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXcfJaP3vBAsWK9vWzGRsYp0l1MXJySAiYSKzZ
        +JSxi5GLQ0hgKaPE0x3vmSESMhIbv1xlhbCFJf5c62KDKPrIKLHwzmYmCGczo8TWq51ADgcH
        i4CKxJtVliANbAI6Euff3AEbJCKgIbFvQi8TiM0scJxF4vlLPRBbWMBK4sa7n2wgrbwC5hKd
        53QgRu5nkpi68iFYPa+AoMTJmU9YQGqYBcokFuyugTClJZb/4wCp4BQwk/i7q4sF4kwlia1d
        75gg7FqJz3+fMU5gFJ6FZNAshEGzEAbNAjtNS+LGv5dMGMLaEssWvmaGsG0l1q17z7KAkX0V
        o0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYDrbduzn5h2M81591DvEyMTBeIhRBajz0YbVFxil
        WPLy81KVRHiFwspThHhTEiurUovy44tKc1KLDzGaAkNwIrOUaHI+MNHmlcQbmhmYGpqYWRqY
        WpoZK4nzehZ0JAoJpCeWpGanphakFsH0MXFwSjUwlYnaVByN27Tia+LWi3Ji0bslGty3Tfm8
        6Nudo3psxlF7U5dpfOpc3fuzLZ31SLXkD+09q5ydLd1r02XPbkq6Y3bz56u0yGILi/Sdyxmd
        ejtqle6fKmA1Kjp45MvDQ4efz1Z9+p35juwEBwMJWVFz029VJ3fvFa/VfCj+ivlB7db7ljUT
        wn7qzJpwOlL0SKj92jjmQ4eSsx2sbh76b+aY3JMyu+ZU6M3FjzYHLNgp/exZQo20WT7LnZ8H
        3SIjfKcWCns0LTrt7yfywi5ou6B9d7f1sovVghwH5lQs22mXenx68H4eHta/1sd36k0obuv7
        fviK4JV+RS+Xy5+Pfg7Qv6KWlt/c/M5zpkXkvMwkJZbijERDLeai4kQA4i9Da/wDAAA=
X-CMS-MailID: 20230601053537eucas1p1f1d8e821e9e9b6728072a8e541b8dbfc
X-Msg-Generator: CA
X-RootMTR: 20230526222249eucas1p1d38aca6c5a5163bd6c48b3a56e2618b4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230526222249eucas1p1d38aca6c5a5163bd6c48b3a56e2618b4
References: <20230526222207.982107-1-mcgrof@kernel.org>
        <CGME20230526222249eucas1p1d38aca6c5a5163bd6c48b3a56e2618b4@eucas1p1.samsung.com>
        <20230526222207.982107-2-mcgrof@kernel.org>
        <20230529200457.a42hwn7cq6np5ur4@localhost>
        <ZHYnXKb8g0zSJe7+@bombadil.infradead.org>
        <ZHZ+zsOTBhvn3rfu@bombadil.infradead.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--wy2llykbgglghma3
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2023 at 03:55:10PM -0700, Luis Chamberlain wrote:
> On Tue, May 30, 2023 at 09:42:04AM -0700, Luis Chamberlain wrote:
> > On Mon, May 29, 2023 at 10:04:57PM +0200, Joel Granados wrote:
> > > On Fri, May 26, 2023 at 03:22:05PM -0700, Luis Chamberlain wrote:
> > > > Now that all the dev sysctls have been moved out we can remove the
> > > > dev sysctl base directory. We don't need to create base directories,
> > > > they are created for you as if using 'mkdir -p' with register_syctl=
()
> > > > and register_sysctl_init(). For details refer to sysctl_mkdir_p()
> > > > usage.
> > > >=20
> > > > We save 90 bytes with this changes:
> > > >=20
> > > > ./scripts/bloat-o-meter vmlinux.2.remove-sysctl-table vmlinux.3-rem=
ove-dev-table
> > > > add/remove: 0/1 grow/shrink: 0/1 up/down: 0/-90 (-90)
> > > > Function                                     old     new   delta
> > > > sysctl_init_bases                            111      85     -26
> > > > dev_table                                     64       -     -64
> > > > Total: Before=3D21257057, After=3D21256967, chg -0.00%
> > > >=20
> > > > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > > > ---
> > > >  kernel/sysctl.c | 5 -----
> > > >  1 file changed, 5 deletions(-)
> > > >=20
> > > > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > > > index fa2aa8bd32b6..a7fdb828afb6 100644
> > > > --- a/kernel/sysctl.c
> > > > +++ b/kernel/sysctl.c
> > > > @@ -2344,16 +2344,11 @@ static struct ctl_table debug_table[] =3D {
> > > >  	{ }
> > > >  };
> > > > =20
> > > > -static struct ctl_table dev_table[] =3D {
> > > > -	{ }
> > > > -};
> > > > -
> > > >  int __init sysctl_init_bases(void)
> > > >  {
> > > >  	register_sysctl_init("kernel", kern_table);
> > > >  	register_sysctl_init("vm", vm_table);
> > > >  	register_sysctl_init("debug", debug_table);
> > > > -	register_sysctl_init("dev", dev_table);
> > > > =20
> > > >  	return 0;
> > > >  }
> > > > --=20
> > > > 2.39.2
> > > >=20
> > > LGTM.
> >=20
> > BTW, please use proper tags like Reviewed-by, and so on even if you use
> > LGTM so that then if anyone uses things like b4 it can pick the tags for
> > you.
> >=20
> > > But why was dev there to begin with?
> >=20
> > I will enhance the commit log to mention that, it was there because
> > old APIs didn't create the directory for you, and now it is clear it
> > is not needed. I checked ant he dev table was there since the beginning
> > of sysctl.c on v2.5.0.
>=20
> I've extended the commmit log with this very importance piece of
> information:
Awesome!

>=20
> The empty dev table has been in place since the v2.5.0 days because back
> then ordering was essentialy. But later commit 7ec66d06362d ("sysctl:
*essential ?

> Stop requiring explicit management of sysctl directories"), merged as of
> v3.4-rc1, the entire ordering of directories was replaced by allowing
> sysctl directory autogeneration. This new mechanism introduced on v3.4
> allows for sysctl directories to automatically be created for sysctl
> tables when they are needed and automatically removes them when no
> sysctl tables use them.  That commit also added a dedicated struct
> ctl_dir as a new type for these autogenerated directories.
>=20
>   Luis

--=20

Joel Granados

--wy2llykbgglghma3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmR4LiUACgkQupfNUreW
QU/qwAwAi6rcnhYVI2BuX2hsdFpNbcKsqn0J/y2RcDEfRQtNs8gWQ2Cm0VMoeTHi
c+UsyYfMPX1Ehcu4Pyec0PVJDw1ri5pYDCvXJqO1VqDwMWHiezUCZd4gmHTpqhna
Kfn2RCeXz/ca1049pWMTbAhO+f1xc3KMO5HvxBjR2ZLMMQLHpclbDmRCLpDb6OTa
AsKDmzux+8HlMZJZZ05zKcbCsIUdNbPr0utkawKPvF9xbpy3aDuCMOgqAbyyVB9k
oAcl0yxltlE1xk1JV/aKBYa2A1ly072EE5euFHJCWmvyGTdPd5Kt/HUkprcjGvE2
z38jAd3gAiLyQyNycMStGY9FuzfHIu89Yib3lIHHQCzK1R/+UZCozWVb+iDZeS0d
Lm90XB8VcMn80Aw9itPyNMNuQ6W9DVgW0rTXU8XcOSA2gXhFWxJRFs0uW7GntViL
Tld4mOTKqevvMu20/HTbYCxbHGhQK2qunuULMtc2gcmIoH2OlWp+y51qen9171gM
D1wam5Ff
=EOBb
-----END PGP SIGNATURE-----

--wy2llykbgglghma3--
