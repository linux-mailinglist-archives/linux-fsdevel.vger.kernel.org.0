Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D9D71502F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 May 2023 22:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjE2UFK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 May 2023 16:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjE2UFI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 May 2023 16:05:08 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463D5CF;
        Mon, 29 May 2023 13:05:05 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230529200501euoutp02c0189705c6d207d1bbedfaf10dfa2af5~jtenNeigx1288012880euoutp02U;
        Mon, 29 May 2023 20:05:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230529200501euoutp02c0189705c6d207d1bbedfaf10dfa2af5~jtenNeigx1288012880euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685390701;
        bh=1ZhbSdnTUiTPgtnsBQucrlMwpNoKoWYbMJP6KOOw5RE=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=GTF7w6stvq2oS1EysFOer0a/VjdNBLuXv+1Wtq71EH9yOdf4QqrOXFEFSBIA7C/IE
         AQThwzhupChNZJ18JrtplKy9EI35ebJkGF1oK1Zt5E4wY9k+vIYPhzZmbk8hFcYPLU
         vUB2kb/bbIDzRJuL9tWSG8Km64/z1npWYqmJ6QhM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230529200500eucas1p21f2a203b7e2c1503c05b7a626ac10802~jtemeBNch2495924959eucas1p2y;
        Mon, 29 May 2023 20:05:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 19.C5.11320.C6505746; Mon, 29
        May 2023 21:05:00 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230529200459eucas1p17f9c693732db58efc8a814dae3dfd1f3~jtel1xkMp1197511975eucas1p1c;
        Mon, 29 May 2023 20:04:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230529200459eusmtrp1e843d73d12d0d8844a1607841420cc3f~jtel1DpV10725407254eusmtrp1k;
        Mon, 29 May 2023 20:04:59 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-80-6475056c0978
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 41.D2.10549.B6505746; Mon, 29
        May 2023 21:04:59 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230529200459eusmtip2e16232edc4f0565d864cc7a0490bfb86~jtellxGxd0039500395eusmtip2S;
        Mon, 29 May 2023 20:04:59 +0000 (GMT)
Received: from localhost (106.210.248.78) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 29 May 2023 21:04:58 +0100
Date:   Mon, 29 May 2023 22:04:57 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     <keescook@chromium.org>, <yzaikin@google.com>,
        <ebiederm@xmission.com>, <dave.hansen@intel.com>, <arnd@arndb.de>,
        <bp@alien8.de>, <James.Bottomley@HansenPartnership.com>,
        <deller@gmx.de>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <luto@kernel.org>,
        <peterz@infradead.org>, <brgerst@gmail.com>,
        <christophe.jaillet@wanadoo.fr>, <kirill.shutemov@linux.intel.com>,
        <jroedel@suse.de>, <akpm@linux-foundation.org>,
        <willy@infradead.org>, <linux-parisc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] sysctl: remove empty dev table
Message-ID: <20230529200457.a42hwn7cq6np5ur4@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="5h2emgdaq4yeo4b7"
Content-Disposition: inline
In-Reply-To: <20230526222207.982107-2-mcgrof@kernel.org>
X-Originating-IP: [106.210.248.78]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2VSf1CTdRzu++7du5dd414HxjfsOF3mpfxKivxqziOvrrc6PcvqjwJpB28g
        jWEbS8xRywMMGA6HkI2hJLmNnyK/LoRo7DwmPwKJHzcSXBAEEoICqfxwtPFiedd/z+f5PM/n
        nud7X5Ij7CZ8ycOyREYuk0hFBB+va1noCpRyldEvZPWtR4ZLZQR6qGvhoblKJ4F+sUJU21zA
        RbO3fgfIMXsDoJW6FB7Ku+yDLmtJlNNWgKGOzHg0MG7AUeNPrTjquWIg0EjbdQx1XSnnInv2
        GEC/WgoxZMuyYKi6KpeDlh64JA8q/+AiY/3+MEjfTz2F00uLOkDnq7txul4/xKPv3D1EF1Yp
        6TxdG0FXm7fRRY23MLqqJJ2gpzs7efS1s0s4fa71HXqmqc8laD9Oz1X5HfD6kL87mpEe/pyR
        B+/5mB9bnJ9DHFF7J/VnzgA1uEBlAA8SUi/BngujWAbgk0LKDOCydYnLDvMAGptHCHaYA/DM
        0DnskUXda+exCxOA7Zpl7r8q7Uj9mqUGwPu6RZ7bglPPQW1ZAeHGBBUAu6YGOW7sTT0Pm7Kz
        Vs9yKBsOx7WMG3tRu6B9emFVL6B2wD/zigCL18HW70ZxVp8E9eXdrvukC2+AJifppj0oBPsH
        ynE2qQjWZkyvpU6GbTW/rRaFVB8fDg63EOziNVjQMLaGveCkrYbH4mdge44GZw05AP7svMNj
        h1LXy3z999rZV2BK7+ia41VoNp7E3Ikg5Qntt9exQT2hru5bDksL4DdpQla9BZbenMKzwbP6
        x6rpH6um/68aSwfAwoZZ4n+0PzR+/xeHxWJYUTGDFwJeCfBhlIr4GEYRImOOBikk8QqlLCYo
        KiG+Crh+ervTNv8jME3eDbICjARWsNllHqksvQ58cVmCjBF5C8QSRbRQEC059gUjT4iUK6WM
        wgo2kLjIR+Avbo0SUjGSROZThjnCyB9tMdLDV43tOxvaN9+4mxpW7H+9ogg5+qbCTDL/sg8m
        9ySXdYanSveWXEygE8cWYcTIJ0ablyM41Hgmzlbaf+JSuOXeTF3HDY3GpnJYKs21caef3Pqe
        516V2MY/1iwVN8k1GyOTDM6NqT84Ak5OwPD6jsH38Y92fukQydevpB28ePQQdfUATxYVuOOt
        nXnXlicLh0+ElwTnd0X0vvz2OG54tzwyZGZz4D1z8tMN+47zp+Nub1pJt4dFvhmi+spCqrYU
        d+v9rMFUsV91rk5zngygwACWHrK16Ime2CKP05scV3eFpqQNZWpNxT3gqYmIm7lKwfbzqoc1
        XE75welTKnqh7o2EiRc/E+GKWMn2bRy5QvIPrjYEiWQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsVy+t/xe7rZrKUpBrfadSzmrF/DZvF30jF2
        i88b/rFZnD0kYbH14FxWi08vHzBa3P90m9Hi/7YWdotpG8UtNvZzWEw+NZfJ4kx3rsXN53NY
        LPbsPclicXnXHDaLR6cuMFmc37WW1eLGhKeMFpcOLGCyON57gMli86apzBa/fwCV/NjwmNVi
        2U4/BwmP7619LB6/f01i9JjdcJHFY+esu+weHz7GeSzYVOoxbdIpNo/NK7Q8Fu95yeSxaVUn
        m8e7c+fYPU7M+M3iMe9koMf7fVeBCk5Xe3zeJBcgHKVnU5RfWpKqkJFfXGKrFG1oYaRnaGmh
        Z2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXsWDxL6aCf8IV5//PY2lgXCDQxcjJISFgItFw
        5QZ7FyMXh5DAUkaJ3b83sUMkZCQ2frnKCmELS/y51sUGUfSRUeJPYz8rhLOFUWLlxquMIFUs
        AqoS/WvmsoHYbAI6Euff3GEGsUUENCT2TehlArGZBY6zSDzvTwWxhQWsJG68+wlWzytgLvFs
        2mKwOUICOxkl7s9OhogLSpyc+YQFordM4sj2hUDXcQDZ0hLL/3GAhDkFLCSu3VzLAnGoksTW
        rndMEHatxOe/zxgnMArPQjJpFpJJsxAmQYS1JG78e8mEIawtsWzha2YI21Zi3br3LAsY2Vcx
        iqSWFuem5xYb6hUn5haX5qXrJefnbmIEJrVtx35u3sE479VHvUOMTByMhxhVgDofbVh9gVGK
        JS8/L1VJhNc2sThFiDclsbIqtSg/vqg0J7X4EKMpMBAnMkuJJucD021eSbyhmYGpoYmZpYGp
        pZmxkjivZ0FHopBAemJJanZqakFqEUwfEwenVANT+fEJwgdNtuiX3lb/dvRn4RyhZGO9O48n
        bM+pdL3ZeabIm3Nf45rc8KXm5UyiaSuuHFrVcm1See7TbwLbWTtOF05PudTz/Dv/86//D2mU
        tHEedU2YoLDG/zhL5dpbr29uk1O6X9Zz5pTrVSEzzfxcjiupC2Zdt+B1WnNwn4A0Wyh/4MmJ
        9V0aHEHND3clr/Fjk1ytbPiVUft4knFXXuhFmZaP5+3YYpcl2vOFLpzQIRP8i2UzLzvH9Yjf
        AXNX295/IvRs8g7uCplNkh6VavPZZUMX25/Ut+2cMidV0P96/iw3/ue2VRcWZ3/aEPztwOc3
        2mW7+h6rxnmWuH0UU9//jZ3bX33nBc2EEzXX+f8osRRnJBpqMRcVJwIA6exiRv8DAAA=
X-CMS-MailID: 20230529200459eucas1p17f9c693732db58efc8a814dae3dfd1f3
X-Msg-Generator: CA
X-RootMTR: 20230526222249eucas1p1d38aca6c5a5163bd6c48b3a56e2618b4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230526222249eucas1p1d38aca6c5a5163bd6c48b3a56e2618b4
References: <20230526222207.982107-1-mcgrof@kernel.org>
        <CGME20230526222249eucas1p1d38aca6c5a5163bd6c48b3a56e2618b4@eucas1p1.samsung.com>
        <20230526222207.982107-2-mcgrof@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--5h2emgdaq4yeo4b7
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2023 at 03:22:05PM -0700, Luis Chamberlain wrote:
> Now that all the dev sysctls have been moved out we can remove the
> dev sysctl base directory. We don't need to create base directories,
> they are created for you as if using 'mkdir -p' with register_syctl()
> and register_sysctl_init(). For details refer to sysctl_mkdir_p()
> usage.
>=20
> We save 90 bytes with this changes:
>=20
> ./scripts/bloat-o-meter vmlinux.2.remove-sysctl-table vmlinux.3-remove-de=
v-table
> add/remove: 0/1 grow/shrink: 0/1 up/down: 0/-90 (-90)
> Function                                     old     new   delta
> sysctl_init_bases                            111      85     -26
> dev_table                                     64       -     -64
> Total: Before=3D21257057, After=3D21256967, chg -0.00%
>=20
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  kernel/sysctl.c | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index fa2aa8bd32b6..a7fdb828afb6 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2344,16 +2344,11 @@ static struct ctl_table debug_table[] =3D {
>  	{ }
>  };
> =20
> -static struct ctl_table dev_table[] =3D {
> -	{ }
> -};
> -
>  int __init sysctl_init_bases(void)
>  {
>  	register_sysctl_init("kernel", kern_table);
>  	register_sysctl_init("vm", vm_table);
>  	register_sysctl_init("debug", debug_table);
> -	register_sysctl_init("dev", dev_table);
> =20
>  	return 0;
>  }
> --=20
> 2.39.2
>=20
LGTM.

Review
But why was dev there to begin with?

Best

--=20

Joel Granados

--5h2emgdaq4yeo4b7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmR1BWcACgkQupfNUreW
QU/t3gv3c4diMWueMMeFZjElEqAeuF66TElSTtKZbqNst1WFgpzBrHNLH0hAGhLO
vRbWOFmYgjh6U31lrVti+jcw+Ha8t+SRjASrYvefYjw9XIv7geaaE7eJZFtYWfJF
yAuSAlbtrl6xLDBudHTD80jXFDEoj+9FrADIyViWyRALRBvsePkRQqiNJPi498yt
nhHAuEStiqJLqLqcnEZ5eERoWOtSxU31cOXl0SdLpUGt6uNYzIiWHLzz2POOtmjP
4hxAW9Uod+yHAWNjOnec5UnQfiMHZtyjAYe6S3ljbiEtjde2rrM599NpznWrrcRQ
7FEz/3wIu/4qL90gj78krhwyiYeC/VlchrC0sOdgV5Gi3ooSO/bMdvD5MST4rN1q
xIL4tVsUQ8LySQNfk1zYfavLqXllSEoHvQc3txw2X6K0ArB3mqkHv/1qIr1sn+Px
PAsWXbMeVeYZHyIkHzzUWPpKGyaqHyho5VQ0MJfqL1cgEva1Xol9xaiePbPRijvA
3BJT2UU=
=Aua/
-----END PGP SIGNATURE-----

--5h2emgdaq4yeo4b7--
