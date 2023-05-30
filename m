Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD55716F69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 23:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjE3VKt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 17:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjE3VKr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 17:10:47 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE2D97;
        Tue, 30 May 2023 14:10:41 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230530211036euoutp02eac18b4276a73ab20e259e2e9c250483~kCBKt2l1f1749817498euoutp02o;
        Tue, 30 May 2023 21:10:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230530211036euoutp02eac18b4276a73ab20e259e2e9c250483~kCBKt2l1f1749817498euoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685481036;
        bh=sZAf05WADsdDIifa+qzKZumCG0WkKZfjyhZ03tXaAv0=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=TorfnvGkGXBPhnUjuWFQROp/akRpmirxtOUOHWInFniHnS+SpF1poKwVJUpKtjDft
         B+tLbaY0oREPyRsl1XSxIgmkQmxmdpREzG21STfp33EUP0MLuAVH3fvRTHpim7RREL
         lturt6vEWwiYaTQZqZodd1xs0ACnTMNkIPrfYwi0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230530211035eucas1p2293841065ff9b093184e9e4e92d66d8b~kCBJ4xpsP1328013280eucas1p29;
        Tue, 30 May 2023 21:10:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F2.07.37758.B4666746; Tue, 30
        May 2023 22:10:35 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230530211034eucas1p1e4d14adc03515b243ce9b7dcf218e7d1~kCBImjRyP0430204302eucas1p1G;
        Tue, 30 May 2023 21:10:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230530211034eusmtrp21dd3fd59eb98ea88a7e82dd480ec66b6~kCBIlhm4-1313313133eusmtrp2R;
        Tue, 30 May 2023 21:10:34 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-56-6476664b2bfa
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4E.06.10549.A4666746; Tue, 30
        May 2023 22:10:34 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230530211034eusmtip2096dde54a065b6b52a4759a885cf83a4~kCBIWXrtQ0210502105eusmtip2b;
        Tue, 30 May 2023 21:10:34 +0000 (GMT)
Received: from localhost (106.210.248.78) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 30 May 2023 22:10:33 +0100
Date:   Tue, 30 May 2023 23:10:32 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     <keescook@chromium.org>, <yzaikin@google.com>,
        <ebiederm@xmission.com>, <dave.hansen@intel.com>, <arnd@arndb.de>,
        <bp@alien8.de>, <James.Bottomley@hansenpartnership.com>,
        <deller@gmx.de>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <luto@kernel.org>,
        <peterz@infradead.org>, <brgerst@gmail.com>,
        <christophe.jaillet@wanadoo.fr>, <kirill.shutemov@linux.intel.com>,
        <jroedel@suse.de>, <akpm@linux-foundation.org>,
        <willy@infradead.org>, <linux-parisc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] sysctl: remove empty dev table
Message-ID: <20230530211032.mfrmvv64vfzgb7fx@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="x47pof7mcp2uyogs"
Content-Disposition: inline
In-Reply-To: <ZHYnXKb8g0zSJe7+@bombadil.infradead.org>
X-Originating-IP: [106.210.248.78]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WSe0xTZxjG852entOyoMeC4+MyIwWHFETNvHzMscjcsqMk7EJiHJluRzhS
        tRRtxeEFxVB0YlSG0EkFgbi0HbdBBRS8jPUPSqFc5iRjVvACc8JKgQKK64C1HOZM9t/vfd7n
        Od/7JEfAE3USfoLd8gOsQs7IxIQHXt/8omNFzK6Diavsz1ahwh8qCDSd20yi8eoZArUbIar7
        qYiPHIMPAXrgsAI0W68ikbrGB9WcF6ALrUUYspxJRr/9UYijm7fMOPqlsZBAj1u7MNTZWMlH
        PTm/A3SnqQRDprNNGLpqyOch55TLMlXdz0fahtiNkH6edQ6nnX/lAvpSxs843aDpJenRsR10
        iSGVVue2EvRVvYS+cnMQow1lpwna3tFB0i0XnTh92fwJPXK722VoO0KPG5Z87BXv8U4iK9t9
        kFWsfPdLD6nNKdxX55dWcX5pBrB7ZwOhAFJroGHgO+BmEaUHcFQdmw08XDwBYJG+GeeGcQCf
        FOjIl4krDoJb6AC8ZM4EL1262bskN9QC2HTfRLgjOLUMDvY9mIsTVDjstN3nudmbWg5v55zF
        3AEeZcLh93VP5wJe1Nuwx/5ijj2p9fDU8AjJ8SJoLhjA3cyj0qBt+iE/Gwhc7A91MwK3LKTW
        wYo8G487VQzrsu0Yx+mwtfbe3FuQ6vaA7QWFfG7xPrx28t58Ny84ZKqd5wA421A8H7gA4I8z
        oyQ3lAOoPTE5/9kNUHV3YD4RDfXaU5j7IkgtgD3Di7hDF8Dc+m95nOwJvz4p4txvwvI+G54D
        gjSvVNO8Uk3zXzVODoclNxzE/+QwqC39k8dxFKyqGsFLAFkGfNhUZXISq3xLzn4VoWSSlany
        pIiElGQDcP3nbTOmyetAPzQWYQSYABhBsCv8uLq8C/jh8hQ5K/b2jGKUiSLPRObQYVaR8oUi
        VcYqjcBfgIt9PMOizAkiKok5wO5l2X2s4t8tJhD6ZWBhG4TSykImpYhSzTzL2mqJkzL7Hy1R
        1fiXmheWLm8JTdCHNb6RvybSed36YcCZZeWBssvhK/OeME1ryxZbZL0LHe2n2b29e65Z9Xdu
        SIw7z+Xs2nkxVLE9LmxPgW/goejXxm59sLk/1ha3aXVwQIg6b2343xrt8ZDoOtWW+i0ngp5/
        FrNesh1L0x/J3DwcmKlvC14cc7g43jrWkvS54fWpHnVHMb/BJDoamaoxBdUfG82SdMWm+3zT
        uik2aULr/CjBN9nX1L1Vaqm0DJVuzK85VvFpZITWIjQP9B0PCW2cNOr6d4RYtu3XpQfEkzXb
        KqoerXv63lHlr5ErVE3WaXxp/kS6GFdKmdUSnkLJ/AO5IiWyYgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHKsWRmVeSWpSXmKPExsVy+t/xe7peaWUpBst7pS3mrF/DZvF30jF2
        i88b/rFZnD0kYbH14FxWi08vHzBa3P90m9Hi/7YWdotpG8UtNvZzWEw+NZfJ4kx3rsXN53NY
        LPbsPclicXnXHDaLR6cuMFmc37WW1eLGhKeMFpcOLGCyON57gMli86apzBa/fwCV/NjwmNVi
        2U4/BwmP7619LB6/f01i9JjdcJHFY+esu+weHz7GeSzYVOoxbdIpNo/NK7Q8Fu95yeSxaVUn
        m8e7c+fYPU7M+M3iMe9koMf7fVeBCk5Xe3zeJBcgHKVnU5RfWpKqkJFfXGKrFG1oYaRnaGmh
        Z2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX0XvrCnPBZqmK92fbWBoY34h0MXJySAiYSGxa
        /Imti5GLQ0hgKaPEo0+zmCESMhIbv1xlhbCFJf5c64Iq+sgo8XHKJUYIZwujxP59S1lAqlgE
        VCVe3rvPDmKzCehInH9zB2ySiICGxL4JvUwgDcwCx1kkVm59wQaSEBawkrjx7ieYzStgLtH+
        9j07xNTJTBLrp89jhEgISpyc+QRsA7NAmcStSzeBbuIAsqUllv/jAAlzCphJrJnyBupsJYmt
        Xe+YIOxaic9/nzFOYBSehWTSLCSTZiFMgghrSdz495IJQ1hbYtnC18wQtq3EunXvWRYwsq9i
        FEktLc5Nzy021CtOzC0uzUvXS87P3cQITGzbjv3cvINx3quPeocYmTgYDzGqAHU+2rD6AqMU
        S15+XqqSCK9tYnGKEG9KYmVValF+fFFpTmrxIUZTYDBOZJYSTc4Hpty8knhDMwNTQxMzSwNT
        SzNjJXFez4KORCGB9MSS1OzU1ILUIpg+Jg5OqQYm21XS988e9Zxjuna67C2hY5cfJ/z/OCux
        aLrzWfFKViMumQtxMfM4g5zmLQoW+XD8n1Uwk1R8PK95j4GTkjbL8R0zz3mJvViw6sLm1omM
        Jz6ZOuxWdPtqeylod0j7c+ZL+RdF6vjNZjpf6lYslv11+qMEW3aNGIuFfP0URf0DUe76mk/c
        Z3RVt5vtVhPM7fy7yN1AttY27Qi/kF8Sq8z76CV3Vl7b0nTD4lPjKV3Jw5vFlBO6mxbeq9FT
        O3g26c27WRN6/y6Xy8s5o1ItdGrzmRcLc5bnTu518byQmvdWz1q/6rZveNTevOviKctWfTf5
        0MNn++9yutLS3EMLdhgsebi3gZvB3S87ZEvh7IdKLMUZiYZazEXFiQBJjy1PAQQAAA==
X-CMS-MailID: 20230530211034eucas1p1e4d14adc03515b243ce9b7dcf218e7d1
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
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--x47pof7mcp2uyogs
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2023 at 09:42:04AM -0700, Luis Chamberlain wrote:
> On Mon, May 29, 2023 at 10:04:57PM +0200, Joel Granados wrote:
> > On Fri, May 26, 2023 at 03:22:05PM -0700, Luis Chamberlain wrote:
> > > Now that all the dev sysctls have been moved out we can remove the
> > > dev sysctl base directory. We don't need to create base directories,
> > > they are created for you as if using 'mkdir -p' with register_syctl()
> > > and register_sysctl_init(). For details refer to sysctl_mkdir_p()
> > > usage.
> > >=20
> > > We save 90 bytes with this changes:
> > >=20
> > > ./scripts/bloat-o-meter vmlinux.2.remove-sysctl-table vmlinux.3-remov=
e-dev-table
> > > add/remove: 0/1 grow/shrink: 0/1 up/down: 0/-90 (-90)
> > > Function                                     old     new   delta
> > > sysctl_init_bases                            111      85     -26
> > > dev_table                                     64       -     -64
> > > Total: Before=3D21257057, After=3D21256967, chg -0.00%
> > >=20
> > > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > > ---
> > >  kernel/sysctl.c | 5 -----
> > >  1 file changed, 5 deletions(-)
> > >=20
> > > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > > index fa2aa8bd32b6..a7fdb828afb6 100644
> > > --- a/kernel/sysctl.c
> > > +++ b/kernel/sysctl.c
> > > @@ -2344,16 +2344,11 @@ static struct ctl_table debug_table[] =3D {
> > >  	{ }
> > >  };
> > > =20
> > > -static struct ctl_table dev_table[] =3D {
> > > -	{ }
> > > -};
> > > -
> > >  int __init sysctl_init_bases(void)
> > >  {
> > >  	register_sysctl_init("kernel", kern_table);
> > >  	register_sysctl_init("vm", vm_table);
> > >  	register_sysctl_init("debug", debug_table);
> > > -	register_sysctl_init("dev", dev_table);
> > > =20
> > >  	return 0;
> > >  }
> > > --=20
> > > 2.39.2
> > >=20
> > LGTM.
>=20
> BTW, please use proper tags like Reviewed-by, and so on even if you use
> LGTM so that then if anyone uses things like b4 it can pick the tags for
> you.
Sure thing. Will send the reviewed-by for the patches

>=20
> > But why was dev there to begin with?
>=20
> I will enhance the commit log to mention that, it was there because
> old APIs didn't create the directory for you, and now it is clear it
> is not needed. I checked ant he dev table was there since the beginning
> of sysctl.c on v2.5.0.
That would be great!

>=20
>   Luis

--=20

Joel Granados

--x47pof7mcp2uyogs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmR2ZkUACgkQupfNUreW
QU8p3gv9E28zq3xql4Zt9T4J2AYBgwOc074GmjXf007UpYleHSi7d5Pokj5gSquF
mvyuxKFtjRCMaMGaot+0FhH/kVBYBFpm+bBtpkuF3Yr9wBh4KQfrKVPbDrnClX5V
NPABq3FlYG29Dowfd/TnboLZKt95Go8GgXo4wlIr+DhQzNkkU29+PF7vnwgwFi0J
1gz+CC92Mu+816n7FQE7nphv+24yJe7RWLe9BlhGNbvhQIEL1bJpSu06KWbkvXZZ
yne9TGOjDUa3GvoZihHSPkuSHZMMxQHTJSnD8yNOhz8zAUXFRwp6IrXX64k4fKst
wAVLa/HKPWwVdy9X6j5VWluoLRTsIZEj49qh0R7FtoPgku/DNWI8yumeotJwhVsW
FAKDIGYIwRQ5tOBbRWoxOTsovo0TD3i7S3WcYpCr1yrbD8tbqpNNLGlD5wTiaMmO
jp7deMehOblVlS76Zdu7Dxnojiw5IOZGxiDcC/RoVLbVGgzM67kJCorJ2n565gPa
zyABUu5Y
=m47J
-----END PGP SIGNATURE-----

--x47pof7mcp2uyogs--
