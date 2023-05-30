Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6195B716F73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 23:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjE3VN6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 17:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjE3VN5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 17:13:57 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15ADAC0;
        Tue, 30 May 2023 14:13:55 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230530211353euoutp010fd9569312c89b106ed45638ac13be2b~kCEBYk8WF0406404064euoutp01j;
        Tue, 30 May 2023 21:13:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230530211353euoutp010fd9569312c89b106ed45638ac13be2b~kCEBYk8WF0406404064euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685481233;
        bh=jEm05W5GcBUVigMjgbQvsUeHSUTN7UnO2SvK7Ym///E=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=hBiUFn/d3T0EysP6R752xwXC7ChFEeTXlexPr+blBXDrBfd2UZhKrv4tXSvILpMLh
         wllO+GaRI22eHtOqo2T9qcpNPbpCktvAeRigVVHUyts9Ms1N645rmJbV5/lzpugxQy
         /7BKcw2zRBBdWpaYKlHpFFkNu9x5gR5Vwer9+TU8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230530211352eucas1p28fb5efcb81cb5b98f66c0ace8a0ad637~kCEA-epMI0777607776eucas1p2i;
        Tue, 30 May 2023 21:13:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F2.A2.42423.01766746; Tue, 30
        May 2023 22:13:52 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230530211351eucas1p19a40e60cdf057ee20e779d6698daaba5~kCEALBveq0430304303eucas1p12;
        Tue, 30 May 2023 21:13:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230530211351eusmtrp225751b624bef9b6a39560704e59549ae~kCEAKQavJ1557415574eusmtrp2U;
        Tue, 30 May 2023 21:13:51 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-27-6476671085c0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B5.A7.14344.F0766746; Tue, 30
        May 2023 22:13:51 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230530211351eusmtip217553679e9642cfdceef9eb4cc7eb123~kCD-6_7SA1177611776eusmtip2i;
        Tue, 30 May 2023 21:13:51 +0000 (GMT)
Received: from localhost (106.210.248.78) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 30 May 2023 22:13:50 +0100
Date:   Tue, 30 May 2023 23:13:49 +0200
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
Message-ID: <20230530211349.olrowajsp3idiurd@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="ocfcrlwnlg7a4bub"
Content-Disposition: inline
In-Reply-To: <20230526222207.982107-2-mcgrof@kernel.org>
X-Originating-IP: [106.210.248.78]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WSe0xTZxjG952enpaGkkNr5LOaZisbQ25e2OWbGzCdW874w2CMcdkWXScn
        BVcKtqLM3TBDEBBpiuBaCivZUoio0FrAQnVaI6XouAyUgiLCcIhDhBbklsFaDttM9t/veb7n
        ffM+ycdlCW4RIm6y4hCtVEjlEoKH1zfPtUeSssOJG40n1yB9zTkC/aVp5iBP7SKBfrVDVHet
        jI3cow8AGnDfBWipPouDSkxByFTIRUWtZRi6lZ+Cekf0OLJdduKoq1FPoKHWDgy1N55nI5f6
        IUC/XTVgyFFwFUMXzcUstDDrjczW/s5GRuuOdyE1c/wUTi3MawBVmtmJU1ZdP4eamNxLGczp
        VImmlaAuVoVRP9lGMcp8NpegxtvaOFTLDws4Ve7cST29ctsbuPkV5TGLE4Qf895JpOXJh2nl
        htjPeEkW9e60Z8IMrWGWnQmMZB7w40LyNdiwNALyAI8rIKsALJy/jjNiCsDBe0srwgNgQ2O/
        N8ZdHpnRJfqmBWQlgJeccf9mSie+xxhhAVDTXYf5Ujj5CnzkLsF9TJARsH3sHsvHq8hQeEVd
        sJxhkQ4cjhTSPhaSW6BrfI7wMZ98E7pOVnEYDoRO7TDO5DNgj2EG8x3EItfCykWuz/YjEbzT
        ex5nqklgXd44xvA3sNXSt8K9PFg0ncJ02Q6PD4QythA+dlg4DK+DS9Yfl6tAsgjAXxYnOIyo
        BtB4bHpl0dswq3t4ZWIrrDLmYMzSAOh6EsicGQA19WdYjM2HJ7IFTDoEVt8fw9UgWPdcMd1z
        xXT/FWPsCGhochP/s8OhseJPFsMx8MKFp7gBcM6CIDpdlSKjVZsU9JEolTRFla6QRe1PTTED
        7ye/uehwXwJljyej7ADjAjt42Ts8VFvdAUS4IlVBS1bxY6SqRAE/UfrlUVqZuk+ZLqdVdrCW
        i0uC+OExzv0CUiY9RH9B02m08p9XjOsnysSSsqVF92tCxMKxkdzmT2oIkFkb/aoqwDh1IGP3
        JOu9b/0/WDN6Q9tyt3/r5hdjP1oXGXHH37SRHKpP6DKL8xvWJw/aLQ8HNVN9B+aDm053FPcY
        HLJOTzEWWm6yvXC7VPShYhe7vyI780g8tWencEN4yLY32GM55dH8Z92Cg68XCI5Ni6oiLae2
        PzlY36IFqz+lNYHit+Q74vpu/GzNEvV8PqyIdlTrS3tWy/9ICJ6Jh0H+xlJPRu2j3rA5sevE
        REMTKY1rQ5XkS9prlVlnNHuSdPHvx1437DM96CRt+EBahf67c7t0rgD/ozmaLvVe2zbrZtjS
        /nXu5JaG/Hks//J6Ca5Kkm4KYylV0r8BLP5k7V8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA2WSe0xTZxjG852eXmDpdtYy+VIWs3VbYth2oAj4FcVpFuNZgkzWuRgNukLP
        CtoL6wUm6MIWSLYqtyKgpUVgg6GCtIAVkBlswqVFoZbIcOqcIFM6Uwa4KHaWtWuWmey/3/vk
        eZ68efNyGDwvU8DJVelojUqqELIi8bHAyC/vviTPl8W7m19H5s52FnpmHGajZWuAha46IDp/
        2cJES/O/AnRn6SZAq/YSNqq1RSNbBQdVuywYunJUiW7cN+No4Ecnjib7zSw043JjaKK/g4mm
        K+cA8gw2YmikbBBD3V01DOR/ErQ8sc4yUWtf+hZIPS4txyn/UyOg6ouv4VSf6Tab+mNxH9XY
        padqjS4W1d0WS303MI9RXWe+ZVG+8XE2NXrCj1MNzgxq4dL1oGGsiFruWruTv4fcpFHrdfRr
        OWqtLlW4V4QSSJEYkQmJYlK0fkNmSkKSMG7zJhmtyM2nNXGbPyVzShZKGHmP+F80l2cVg+8J
        A+BwIJEIH5tkBhDJ4REtAJ7qsQADiAjqr0Lbo+vMMPPhX1MGVti0CGB/nRsLDz0Adte0s0Iu
        nHgLPliqxUPMIt6BEw9vMUIcRayDlyrLsBAziBEc3q+gQ8wnUuC0b+WfLJfYAKePtbFDzCP6
        ALxTnx3WX4bOk/fwcDYfetsvskNbM4gY+EOAE5IjCASnbnTg4UWF8LzBh4X5CFx+9huoBHzT
        c02m55pM/zWF5Vg4HZjH/ie/DVubfmeEORWeO7eANwL2GRBF67VKuVKbQGqlSq1eJSez1cou
        EHw0+/BKTy847V0kHQDjAAd4M5icsZ51AwGuUqtoYRQ3VaqV8bgy6aFCWqPer9EraK0DJAWP
        WMUQvJKtDn6tSrdflByfJEpMFscniZPXC6O5H+R9I+URcqmOPkjTebTm3xzGiRAUYzHHC1Kd
        X7kO7/bOCWeqX9hR8FmVQGGt2zomGfZGmccnStd8ndk8X7jVGT3DPXvyz9xI6dKoJHDLKBCW
        vjcrcbxf8GFVdNYnd2vX8releV5MafCd2vXg+M8bC5YlHyUxy+XefZWDQz9hqCFbeHd7eubK
        zNHmMbfNY+qIWfrSNdvN0Vp2XdxtLSr1njgYL7lApniy8ibr2uxTTZ3bWzMqevZk2XslN7cd
        K752u0VstF+erHbGfdzpeyNj0FZmmywqUw2JCulDOCpMg965er956IJl9ECg7vRVH899OK1J
        Mep0Gv1XqHvUxs9hUU1v+uqWgQOruZ4ja3rIp3l7SebDFiGuzZGKYhkarfRvUWjTHv0DAAA=
X-CMS-MailID: 20230530211351eucas1p19a40e60cdf057ee20e779d6698daaba5
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
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--ocfcrlwnlg7a4bub
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
Reviewed-by: Joel Granados <j.granados@samsung.com>

--=20

Joel Granados

--ocfcrlwnlg7a4bub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmR2Zw0ACgkQupfNUreW
QU/sFwv/Szlm33QSWmZp4jNZj0nRdiSW/Bhzrw0gvEHK8N2xTpMMLoWL4ZyVOOq1
/UXJQszbKqDSHCuGcvx8PeLsJc+YD47MTS41BzsU3T+EYFaxQbMgzWGmOi+ysl3g
XWmlmvNz+B6Jn2i/dyqccml9IsaXKGkMT0ujvSDD9J90fB6LhS+cXGpTFmTJPRm5
fphQxo8+5DMNn8fV21pIYwKhLTGzE9i3VXbtJgUa8cjv+OeUIELsRSI3YizjNx/t
baJZch/yR5a7CJYyVk9Vu4Hl7LN6tG7kqu333a9D71G8vkeS9myqPnwJDwoHE0GL
jSZLy13uIlLXpQz5QLHX/4vI29T2jwfVTJ08t+ufA7CwRrKU0Vmn78pj3qSGzRO3
l0Y758g/AxA75+cWoE2cQUBkb5TnVLzzgBjLzehn8TzXLWtN3hJDCpsWYJSRa8q6
fXnmEt1+fh5ikvKO54H0vm9HVRC+DYDCaZhDzbsZoECI55ziH529IcQfTUZ9+QTe
hz5X//5S
=i/vQ
-----END PGP SIGNATURE-----

--ocfcrlwnlg7a4bub--
