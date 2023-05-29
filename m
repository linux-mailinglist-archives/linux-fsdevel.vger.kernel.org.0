Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EAF715044
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 May 2023 22:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjE2UGd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 May 2023 16:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjE2UGc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 May 2023 16:06:32 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9C713D;
        Mon, 29 May 2023 13:05:58 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230529200542euoutp021214b3bb62b79dd32d5ad368126a4268~jtfNsD1Mz1164011640euoutp02b;
        Mon, 29 May 2023 20:05:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230529200542euoutp021214b3bb62b79dd32d5ad368126a4268~jtfNsD1Mz1164011640euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685390742;
        bh=pIKJ/0pTFVod4oct0Ya5kXe8iwtRftZQzHN3BQjmhKA=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=hY2bCm/lXgY5xARnEJv9icirNk2CWpi+nhiIBDpm1CpL835Yr+OtYl0jIWRXauuOX
         AAuVeSG17ywfgOe3kknJ2ySoO5c36TLQx33ukAZNaBYo6A6Py4PXallIo1wJD2NCd7
         nzV+k7f/S2owc2iw42QDYZym4aX/9R5GhpRCJUNE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230529200542eucas1p1a7eab0e6643f3c129c498d541cc84e62~jtfNhJJz30669106691eucas1p1k;
        Mon, 29 May 2023 20:05:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C2.11.37758.69505746; Mon, 29
        May 2023 21:05:42 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230529200542eucas1p17aaabea06538cf7591abea0d37085426~jtfNGZmFJ0800408004eucas1p18;
        Mon, 29 May 2023 20:05:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230529200541eusmtrp2889d1ec7946385a3bdaadecb8f538e87~jtfNEjDYS2796827968eusmtrp2c;
        Mon, 29 May 2023 20:05:41 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-4d-647505969f3f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E5.E4.14344.59505746; Mon, 29
        May 2023 21:05:41 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230529200541eusmtip2f15a406eeefc8d43e2569de5e8f7b5a5~jtfMy5-g10618906189eusmtip2R;
        Mon, 29 May 2023 20:05:41 +0000 (GMT)
Received: from localhost (106.210.248.78) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 29 May 2023 21:05:41 +0100
Date:   Mon, 29 May 2023 22:05:39 +0200
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
Message-ID: <20230529200539.limexmxhrpfyya7p@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="xtz7dcv4hf5tve4g"
Content-Disposition: inline
In-Reply-To: <20230526222207.982107-3-mcgrof@kernel.org>
X-Originating-IP: [106.210.248.78]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WSfUxTZxTGeW9vey81ZdfWhDeVuYzNRYEBk2W+YcO5xGUXt4m47CPq0CI3
        4ISL64c4FwIKWOxEsArOClqB0EpZKcjHysAxdEALA3GAlE+HX5MhCh0qI+Aot5tL9t/vPc9z
        Ts5z8pI8cbtASu5mlYyclcX7CoR4TfNM56t5fFVM8OVuCcovLxOgOW0zgZyWeQH6pQmi6p8K
        +Gjq3g2ARqYGAHpak06gvApvVJFNohP2Agy1f5OAHHfzcVTfYMPRr3X5AjRqv4qhzrrv+Kgv
        5zZA1xr1GGrJasTQxcpcHpp9smB5YrnJRyXWTesh/TjjGE7P/qUF9JnULpy26oYI+uFkFK2v
        VNF5WruAvmj0o4vq72F0ZekRAT3R0UHQrd/O4vRZWyT94FLPgqHta9pZuWKzZKvwrRgmfvc+
        Rh60bqcwrjr3Otib/uL+OntKKiiWaoAnCanX4anjp3gaICTFlBHAOYOF7xLE1J8ATles5gQn
        gH2DcwsCudjxSIdxdQOAaoeN+Nc0oO52K1UAtg07CNconFoJbQUO4GIBFQA7xwd5Ll5GrYKX
        crIwF/OoFhzezWZcLKE+g3WG7kWPiFoLS7vGCI6XQtvpW7hrCx61Hx5Vh3C4HBrmSZfDk0LQ
        2dsLuGS+sFozgXGcDO1V/YurQapHCIvUToITNkDH7/VulsCxlio3+8Cn1nPuhhMA/jj/kOAe
        JgBLDk67x74J07tvuTvegRM3rYA7kRfsu7+Uy+UFtTWu+7rKIph5WMy5X4Gm4XE8B7yk+08y
        3bNkumfJdItzAqD+hynB/8r+sOT8HzyOw6DZ/ADXA6IUeDMqRUIsowhhmaRAhSxBoWJjA3cl
        JlSChU/eNt8y/T0wjk0GNgGMBE3g5YXmUYvpKpDibCLL+C4ThckUMWJRjOyrA4w8cYdcFc8o
        msByEvf1FvmH2XaJqViZktnDMHsZ+T8qRnpKU7HPtw0qrYVdPrOF4z3VF8i1SZ2hYxH2++n9
        1p2iw8PhxvyZ8PVx7AvH3343w8zGvf+JpLA8osNjuxcr6Nyj9K8dvVP70cDHG6mJLRbNc637
        TEm3i835RV98aj4yKU070KD4cFp7XbsxKDaFF860p52MKktZ1TrgkbzVVFZ9p6orq1Z29IMr
        oTWPD814ZCb3V12RNJ7UZB0zpl3ISs80b3hjzaMlKwt6tgT8rC4bGDzXsn2kg8Cl0REN20ZO
        s+PeUZEV1+I39eT61Kx7Pjm61/+3NaGKYOPBgiWxN3acCaot8gtZbfDkH3KyXwaffc8glCcZ
        i1uzh5TR+vJmRxIK98m4HDm0whdXxMle8+PJFbK/AZ32uhlfBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsVy+t/xe7pTWUtTDG5/MLSYs34Nm8XfScfY
        LT5v+MdmcfaQhMXWg3NZLT69fMBocf/TbUaL/9ta2C2mbRS32NjPYTH51FwmizPduRY3n89h
        sdiz9ySLxeVdc9gsHp26wGRxftdaVosbE54yWlw6sIDJ4njvASaLzZumMlv8/gFU8mPDY1aL
        ZTv9HCQ8vrf2sXj8/jWJ0WN2w0UWj52z7rJ7fPgY57FgU6nHtEmn2Dw2r9DyWLznJZPHplWd
        bB7vzp1j9zgx4zeLx7yTgR7v910FKjhd7fF5k1yAcJSeTVF+aUmqQkZ+cYmtUrShhZGeoaWF
        npGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJeRtvDL6wFTYoVf07dYGlgXCTVxcjBISFgIvFt
        FlMXIxeHkMBSRolZU/6ydzFyAsVlJDZ+ucoKYQtL/LnWxQZR9JFR4vL7K+wQzhZGiYlz1oJV
        sQioSpyce5MRxGYT0JE4/+YOM4gtIqAhsW9CLxOIzSxwnEXieX8qiC0sECHRvfof2DZeAXOJ
        VRdfQQ3dyShxZeY5JoiEoMTJmU9YIJrLJN4v+s8IcjazgLTE8n8cIGFOAQuJz9euMUJcqiSx
        tesdE4RdK/H57zPGCYzCs5BMmoVk0iyESRBhLYkb/14yYQhrSyxb+JoZwraVWLfuPcsCRvZV
        jCKppcW56bnFRnrFibnFpXnpesn5uZsYgUlt27GfW3Ywrnz1Ue8QIxMH4yFGFaDORxtWX2CU
        YsnLz0tVEuG1TSxOEeJNSaysSi3Kjy8qzUktPsRoCgzFicxSosn5wHSbVxJvaGZgamhiZmlg
        amlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXA1KEQK7LbdYumOM8qp3WVro27Nt/ZOsdI
        qXiNQcG7S7neu3L9PcK7cjm5Da4xXZm2vkXeX+zJhWMmdWtUZuQpJYj8lK8LTpFesVueNdx6
        yrP4xUctjPntfhfckDMNuKA/e0byiTI/meTLGpxT0ndoXwn/3MlyNCg14ZPwnaqKo/YXXzKV
        Pa7KnvUu86tdpaCx1ZJrunmOh9gLGiUlDjYdZGp2sN9UuUhFa+LalEM6Pa+X5X2O9M8ymrsw
        aoXAdcOJZx8Ks32ufMey/ctzCb0EvzmvI1Qu3DC/vI7tSta8+CZ9PfVle6R+PEv1FfrA9fWi
        8atw8dc7Nsy/bX/G9/HqPzN38t4x/iom+t7b/8NUJZbijERDLeai4kQAUP1uy/8DAAA=
X-CMS-MailID: 20230529200542eucas1p17aaabea06538cf7591abea0d37085426
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--xtz7dcv4hf5tve4g
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

LGTM
--=20

Joel Granados

--xtz7dcv4hf5tve4g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmR1BZMACgkQupfNUreW
QU+RNgwAk/Z2mYaycPxMeef8lQvY2yVWUf5q2MCjPy06wUObCXySaXq7LCvkxJPF
7JUVXIQ81yZNNNdQ8dWnP0M1gF7Gy1/FuVZwE4FagWhT9nelpF3kmBll4JfkbnG0
1fJVvS4HDK3RB1h7MwIyy1loRFrZvOC7oPf25qwK7PHfjrbAfZvHIda88CH8uQoY
Ro2letTYBeYIcSp/YXSd7QjvnlWMWZbJuLHodgm1GK5MmZFARCxCKydYczFta8kC
/hT/VaYTnxs1uG8eI55Bb69LJF9kZNKsZYwzNus9wJxKWJgkhkpgJvJyFoJP2pXf
2Wdrufh/b73bRTGolMe4zZmqtMeFLctMSXSMglftViTkJzQSRKi+goiwnH//dt3+
JpvVex4Z1k9hz6MBRpCPys3kSmXjOW5EwI1hTNtH9Hp3xeotJEN6n3ncwHpOuL2E
D5i7AXkoFQa4D731FlAsfCxxuelF98CHS3CNaqDK9cRqOa9Gzco1TafXtc9DD8T3
RWpFL98a
=5oKi
-----END PGP SIGNATURE-----

--xtz7dcv4hf5tve4g--
