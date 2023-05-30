Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A38A716F7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 23:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjE3VOe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 17:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbjE3VOc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 17:14:32 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F67D137;
        Tue, 30 May 2023 14:14:19 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230530211417euoutp0233e89d76ad6863aec1972599ba3ce296~kCEYkK5mB2686326863euoutp02E;
        Tue, 30 May 2023 21:14:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230530211417euoutp0233e89d76ad6863aec1972599ba3ce296~kCEYkK5mB2686326863euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685481257;
        bh=vQxYYjm3Sd4+hDeSDCuukUJhNIR9N74c+Yzqyu6R+98=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=W7UkrxH6NUbOKpg+vyPksOS5nfFeTso67L9BM8wcjmGcARqqE8rYo9mIpVo2UDW0H
         7j7DjU+qgUcpsxcx7W6L04Rb73f9LP6UwiK5d4kmyxuYLLzQr53oyICIjnJB9YZkWW
         bcsn1rly9G2yMlihY2Hj+d9ZB2Iqum++Ug6H4lYk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230530211417eucas1p1006f751f06e812c67a01da995401edaf~kCEX6anh80430704307eucas1p1y;
        Tue, 30 May 2023 21:14:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 40.27.37758.92766746; Tue, 30
        May 2023 22:14:17 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230530211416eucas1p213625172ef8413b964090813f63efce0~kCEXYzpMR1435314353eucas1p2X;
        Tue, 30 May 2023 21:14:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230530211416eusmtrp134f748a4397465bd3724a63ada471c04~kCEXYEg3d2198221982eusmtrp1C;
        Tue, 30 May 2023 21:14:16 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-67-647667295ce4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E7.A7.14344.82766746; Tue, 30
        May 2023 22:14:16 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230530211416eusmtip19656a7d03b6b12a54d7599725eb367e3~kCEXH5W1p2600426004eusmtip1e;
        Tue, 30 May 2023 21:14:16 +0000 (GMT)
Received: from localhost (106.210.248.78) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 30 May 2023 22:14:15 +0100
Date:   Tue, 30 May 2023 23:14:14 +0200
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
Subject: Re: [PATCH v2 2/2] signal: move show_unhandled_signals sysctl to
 its own file
Message-ID: <20230530211414.gorx4m5cs6jliset@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="etcb4mwp7uwhqc3g"
Content-Disposition: inline
In-Reply-To: <20230526222207.982107-3-mcgrof@kernel.org>
X-Originating-IP: [106.210.248.78]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WSfUxTVxjGd24v7aWx7NIyOWlli1U3EEEXXXaisLhJzI0uxiVuYZB9NHAD
        blBIS4XJMMXBPuoQUgQFwTFlbSOVj7Z0AzrELrEWpC0KXf3ekIXBCkJrB0jsRr3dZrL/fu/z
        Pk/yPieHYPGH2ULioLSIlkkleWI2FzdfXnIkJeQcyt6iDOCoqUPPRo/VlznI3xlko2ErRN2X
        miOQb+oXgO75bgH0l7mCg+q7YlFXNYFqB5sxdPVYProx2YQjy492HF3vbWKj8UEXhpy9FyKQ
        p+Y3gK4NtGDIVjWAIaOhjoWWF1csi533I5CmZ99OSC1UHsep5UdqQJ1WjuBUT+MdDjU3/z7V
        YlBQ9epBNmXUbaTOWaYwynD+KzY163BwqCunlnHqjP0t6kH/2IphqJTyG57fL8jgpmTTeQcP
        0bLNr33IzR2ZJgqNa0v6gzO4EriEKhBJQHIb/KJLz1IBLsEndQCec3bizPAQQFO7GjCDH8Ab
        J5oiVIB4EhmZ3x5K80ktgD3NxL+eBkeAwyxMAB69AkOMkxvgw8qrIMRschN0em+zQhxDxsP+
        miosxCzShsPJajrEAjId9mpHn3h45Kvwe7MzzNHQ3jCBM/4SOOU8yQ7dwyJFUBskQnIkiaDf
        7QZMMzHsVs1iDJfBQdNNLHQnJMe40HHtDodZpEH32bmwSQCnbaawvgYO1X6NM4FaAC8G5zjM
        0AagpjwQTuyAFaMT4cTrcPZ+D2BeKAp6ZqKZQ6Og2nySxcg8+OXnfMb9Imy768VrwLrGp6o1
        PlWt8b9qjLwJtvT5/i8nQs23f7AYToXt7Q/wFsA5D2JphTw/h5ZvldLFyXJJvlwhzUnOKsg3
        gJVfPhS0BX4Auun5ZCvACGAF61fC451tLiDEpQVSWhzDS5XIs/m8bMknh2lZwQcyRR4ttwIR
        gYtjeYmp9iw+mSMpoj+m6UJa9s8WIyKFSmz36ecs6sqEvuhMKbx4yZSyrTu4Nm1ps97tyHK1
        /jQ61/cu3j05FbtflqrJsH86qhikbAPP+Dq8pUUJ6k59iirurn9e681853pasfB3S/qYsTTZ
        SHVUDZkn3FGtglOf1dU+eqkiyrqqYyEzEDd9vIiM2enp6y9x6LZbMu/97E0+4I0oFVQ3rp5R
        xJkK0x+XO8S/DmfWvFK55YW9nDdvJvpEnt2L6zLc9YcT5sr26RXaXeUNhQuLUnrNlE6/sLqd
        bm3b8YZIdDvVkFu8vu6Mq8vjVO3aKo8f2PORxmg5ogSrBEefPXYhJue91m/+XFLTR27Fjycl
        lS2dPbGX1/Od6G2fGJfnSl7eyJLJJX8D1Kwxa2AEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsVy+t/xu7oa6WUpBlu3yFjMWb+GzeLvpGPs
        Fp83/GOzOHtIwmLrwbmsFp9ePmC0uP/pNqPF/20t7BbTNopbbOznsJh8ai6TxZnuXIubz+ew
        WOzZe5LF4vKuOWwWj05dYLI4v2stq8WNCU8ZLS4dWMBkcbz3AJPF5k1TmS1+/wAq+bHhMavF
        sp1+DhIe31v7WDx+/5rE6DG74SKLx85Zd9k9PnyM81iwqdRj2qRTbB6bV2h5LN7zkslj06pO
        No93586xe5yY8ZvFY97JQI/3+64CFZyu9vi8SS5AOErPpii/tCRVISO/uMRWKdrQwkjP0NJC
        z8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvo//XbbaCjYoVp7q+sTcwnpPqYuTgkBAwkbj4
        0aqLkYtDSGApo8T0X99Zuxg5geIyEhu/XIWyhSX+XOtigyj6yChxdO5WFghnC6PEthv3GEGq
        WARUJb60ngGz2QR0JM6/ucMMYosIaEjsm9DLBGIzCxxnkXjenwpiCwtESHSv/scOYvMKmEts
        33aeGWLoTkaJKzPPMUEkBCVOznzCAtFcJrF/5hF2kLOZBaQllv/jAAlzClhIfL52jRHiUiWJ
        rV3vmCDsWonPf58xTmAUnoVk0iwkk2YhTIIIa0nc+PeSCUNYW2LZwtfMELatxLp171kWMLKv
        YhRJLS3OTc8tNtIrTswtLs1L10vOz93ECExq24793LKDceWrj3qHGJk4GA8xqgB1Ptqw+gKj
        FEtefl6qkgivbWJxihBvSmJlVWpRfnxRaU5q8SFGU2AoTmSWEk3OB6bbvJJ4QzMDU0MTM0sD
        U0szYyVxXs+CjkQhgfTEktTs1NSC1CKYPiYOTqkGJm5hm2uh1+cUL+f6vZsrdwG7w3qDvpWF
        GZv07719OW3m8odbXab8ODwxv+rTVY4o/fNrn5nm31/EeoCtyj7Hdt5c6SccIs8OpUxlnRK9
        JC7NRJe7aqHds4gzZw8kT6x+vc2dcaOeL//tGF723NaXCd59ETfdNRSu3GWaOfVkP990zpQz
        Kqf3Gc16IzaDI7k+X8KKU1SARURFvLfJ8jbjzCT3q4+dd8zQtd/07dCKn0c0+W/6Ov8Rf6R7
        juXbP77UxSU8rnJ5OraT/7cdVMs0XhO+jNX+JDdb9uqZN+o09pUe9/A8K/xfgPVokN6/a24h
        H2ME9Y7t2+Tzmvv/8dsSMcW7dLLl5ixrZLyx+dZDJSWW4oxEQy3mouJEAKd2BZz/AwAA
X-CMS-MailID: 20230530211416eucas1p213625172ef8413b964090813f63efce0
X-Msg-Generator: CA
X-RootMTR: 20230526222248eucas1p2c21183361439f3a9e36c84545265395e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230526222248eucas1p2c21183361439f3a9e36c84545265395e
References: <20230526222207.982107-1-mcgrof@kernel.org>
        <CGME20230526222248eucas1p2c21183361439f3a9e36c84545265395e@eucas1p2.samsung.com>
        <20230526222207.982107-3-mcgrof@kernel.org>
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

--etcb4mwp7uwhqc3g
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2023 at 03:22:06PM -0700, Luis Chamberlain wrote:
> The show_unhandled_signals sysctl is the only sysctl for debug
> left on kernel/sysctl.c. We've been moving the syctls out from
> kernel/sysctl.c so to help avoid merge conflicts as the shared
> array gets out of hand.
>=20
> This change incurs simplifies sysctl registration by localizing
> it where it should go for a penalty in size of increasing the
> kernel by 23 bytes, we accept this given recent cleanups have
> actually already saved us 1465 bytes in the prior commits.
>=20
> ./scripts/bloat-o-meter vmlinux.3-remove-dev-table vmlinux.4-remove-debug=
-table
> add/remove: 3/1 grow/shrink: 0/1 up/down: 177/-154 (23)
> Function                                     old     new   delta
> signal_debug_table                             -     128    +128
> init_signal_sysctls                            -      33     +33
> __pfx_init_signal_sysctls                      -      16     +16
> sysctl_init_bases                             85      59     -26
> debug_table                                  128       -    -128
> Total: Before=3D21256967, After=3D21256990, chg +0.00%
>=20
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  kernel/signal.c | 23 +++++++++++++++++++++++
>  kernel/sysctl.c | 14 --------------
>  2 files changed, 23 insertions(+), 14 deletions(-)
>=20
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 8f6330f0e9ca..5ba4150c01a7 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -45,6 +45,7 @@
>  #include <linux/posix-timers.h>
>  #include <linux/cgroup.h>
>  #include <linux/audit.h>
> +#include <linux/sysctl.h>
> =20
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/signal.h>
> @@ -4771,6 +4772,28 @@ static inline void siginfo_buildtime_checks(void)
>  #endif
>  }
> =20
> +#if defined(CONFIG_SYSCTL)
> +static struct ctl_table signal_debug_table[] =3D {
> +#ifdef CONFIG_SYSCTL_EXCEPTION_TRACE
> +	{
> +		.procname	=3D "exception-trace",
> +		.data		=3D &show_unhandled_signals,
> +		.maxlen		=3D sizeof(int),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_dointvec
> +	},
> +#endif
> +	{ }
> +};
> +
> +static int __init init_signal_sysctls(void)
> +{
> +	register_sysctl_init("debug", signal_debug_table);
> +	return 0;
> +}
> +early_initcall(init_signal_sysctls);
> +#endif /* CONFIG_SYSCTL */
> +
>  void __init signals_init(void)
>  {
>  	siginfo_buildtime_checks();
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index a7fdb828afb6..43240955dcad 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2331,24 +2331,10 @@ static struct ctl_table vm_table[] =3D {
>  	{ }
>  };
> =20
> -static struct ctl_table debug_table[] =3D {
> -#ifdef CONFIG_SYSCTL_EXCEPTION_TRACE
> -	{
> -		.procname	=3D "exception-trace",
> -		.data		=3D &show_unhandled_signals,
> -		.maxlen		=3D sizeof(int),
> -		.mode		=3D 0644,
> -		.proc_handler	=3D proc_dointvec
> -	},
> -#endif
> -	{ }
> -};
> -
>  int __init sysctl_init_bases(void)
>  {
>  	register_sysctl_init("kernel", kern_table);
>  	register_sysctl_init("vm", vm_table);
> -	register_sysctl_init("debug", debug_table);
> =20
>  	return 0;
>  }
> --=20
> 2.39.2
>=20

Reviewed-by: Joel Granados <j.granados@samsung.com>
--=20

Joel Granados

--etcb4mwp7uwhqc3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmR2ZyYACgkQupfNUreW
QU9QSAv/YxvYBKHMzu6qIJDRm2z06uQf8MbkJI5LkiPkxOLNZSy67pCuvRhEFB4I
Qi2PO1Q9VUecUaOtC4EKD/hD71xYyacRMEc8nvjqWpcOi7ap+wdn7RjscLXkpkgZ
oMAqYKlKzkInKIxmg087VKMPRCw5sCixJrUJicBoK/43T/LSp5OlUwk21QcJJ3Hn
GjOz/2KluhP4WnoTGVDGc8BtIuuZhNX2DVa2/jOJng6GLIND2bK2T5tBxKm2xC88
9esgRntrj6QKqGFyxno7A5rK8UAzN9zGZgdSgGYoSVMypdGiAl+Y5hdNyTRCEvvy
9VbZenQXwRJfiooiC0rBjEYsl3J1d3uo27nfhmCoUunsbddwVsZp5iDQ7Fm+URYP
eTzeZ+9C0dCCGGcsKnPamVEZiv3N9qxEx+tOMbvf9tvpJNAJmqBEHjkhml8b1nha
YQdexvk/hwasmW/UcogYDftOAzqUxuwabylAz6jUKR20W/mqHfcjrII0BLMVbPXA
2PNRu95E
=dTvY
-----END PGP SIGNATURE-----

--etcb4mwp7uwhqc3g--
