Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E1773892A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 17:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbjFUPaq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 11:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbjFUPa3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:30:29 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257D21BD3;
        Wed, 21 Jun 2023 08:30:16 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230621153011euoutp01192645862d3e0a543891af4b47de94a9~qtkOS32Qw0899308993euoutp01Q;
        Wed, 21 Jun 2023 15:30:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230621153011euoutp01192645862d3e0a543891af4b47de94a9~qtkOS32Qw0899308993euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687361411;
        bh=4dY3siBIy5sZCkWLAJsADYQ9gjCB2XGjCqHI/EnrzWw=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=pGdGnasdyQVz6DZY4mANhkND5Xrt681cqBfJfy97xUPZInu3VuYDlHeCfy1G2/D4c
         18D/HuBWkadD4OUgQpv80ELCjEHDj40bQ2D16FPNPCKO+6rUNXV2/eSnsXtYqBWKtu
         F5+bvWY/pNIsls2QPTAqoHMPbQjcqWCwFBMbgLgY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230621153011eucas1p2787595ff5b934c65ea1727b5d5deb74f~qtkN_c_kP1922119221eucas1p26;
        Wed, 21 Jun 2023 15:30:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 3D.E0.11320.38713946; Wed, 21
        Jun 2023 16:30:11 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230621153010eucas1p25fabdc546fa653beb103f6f68f4da531~qtkNVQ-cl3128231282eucas1p2P;
        Wed, 21 Jun 2023 15:30:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230621153010eusmtrp230e48834a7a1b40e208c6136e69457d4~qtkNTp7dV2052520525eusmtrp2q;
        Wed, 21 Jun 2023 15:30:10 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-1a-6493178345d8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 53.6C.10549.28713946; Wed, 21
        Jun 2023 16:30:10 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230621153010eusmtip231fdedfd7d7cff792547031f714e18c9~qtkM_OVY70222902229eusmtip2f;
        Wed, 21 Jun 2023 15:30:10 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 21 Jun 2023 16:30:09 +0100
Date:   Wed, 21 Jun 2023 17:30:08 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Petr Mladek <pmladek@suse.com>
CC:     <mcgrof@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Amir Goldstein <amir73il@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <bpf@vger.kernel.org>,
        <kexec@lists.infradead.org>, <linux-trace-kernel@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 08/11] sysctl: Add size to register_sysctl_init
Message-ID: <20230621153008.lpxi5gh6fzvammg5@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="6xqmlcamfjbvcfp2"
Content-Disposition: inline
In-Reply-To: <ZJLgzo1GuykDV8fd@alley>
X-Originating-IP: [106.210.248.248]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTfVBUVRjG59x79t4Fg67gyBEtbTEnP0CxtNfS1NS6QTOVzTTlVEayifGh
        syt+N8GyJpIoLAi1LAGufC6CIOywLK66Mi6oJKAIiksIqCCIinytjLuxXpyc6b/f+7zvM+d5
        /jhi2kMt9hZvidgulUUEhUkYV6y/YPvbN8YrKXhRkX4SaIoLGagv0iEYGUujwdjdimHQ1spC
        nL0MQ2FZNAVPTtoZeFJtYaD3/ACCxs4mBlJ7ojFoei6z4LDeo0CbNUxD98kDCDRXlBj6FWMY
        7iSU0+DQK1mI0RYzYLacYSGlxAvSUmMoUNkSELQ3eYPmxmLoT58BtpwCFoqKtRQoKvIo0F/L
        QFCdrKbBeuQohsu/h4Px0hAF5bcUDNwzxVNwcCQbQ3KKAkHV6VoMVys1DLQVOkTw6FAHA9XF
        dRguXajBoDsRJYLs5gYKCg/mi6Al4Q6CpP67CLS5c+DxmS+h8WwmBTmG2xgaos8i0CU/Y2F0
        bEwErapUDJb4sxQ4OodEYIptp6BxtBeDseQYs+ozfmT/Ycz/0/cM84V/FSI+LaoB82X5Nyj+
        VrYB8Ykx/SxvUFtZXmm6yfKZpZH8deM3vLL6gYg/lTeP11b1UHxcSyPNlxYcZD5/a4Pr8mBp
        2JYdUtnCD35wDfkj/wTeluK1K6HyCB2FTnnGIRcx4d4hw9XZVBxyFXtweYgM1wxNDIOIPDyX
        hpxXHtwTRMx9s184OowVIuEoF5GG9mJGGMaPRhuPT2zKEYlPP0Y7LZh7kxhHzayTGW4BudJ3
        67k+hZOQ+xlW2mmguZGppOJuPeNceHJryOmYLpGT3bh3SZaijxZ4Mqn9sws7meZ2kQF7+XhY
        8ThPJ7l2sVN2GX+rpFKITTgf0mzSMgL/Qi6W3XzejXBNr5CneoNIWKwllsF6SmBPct9Sxgo8
        gzgMGROGJETO2B+xwqBDJCd6aMLxPlFe65pwrCZ5ChVyJiKcO2l5MFkI6k5U+lRakN1I7G8e
        wvUcomvrwwnIR/1SNfVL1dT/VRPkBSTTOMD8T55PcrJ6aYFXkKKihzgTsQXISxopD98slS+O
        kO70kweFyyMjNvtt2hpeisa/7CW7ZbAC5d5/7GdGlBiZ0exxc8dJXT3yxhFbI6SSKW6vlaqC
        PdyCg3bvkcq2bpRFhknlZjRdjCVebvNX1G7y4DYHbZeGSqXbpLIXW0rs4h1F4fSlXr4Fr7fN
        7PfX6QPUc+a+nWH6KnBfyEC/adaOutCpIZ3f7haNBVTVHFXP4vlDuz62KrlQ6/pQv7jFa1KW
        jvgeNyQF7rFMCZt7o1w1Oa9+UlWRgmQ1rz4n8xl0aGxblgwb4390hLZkiRN9JL2Syour8k/L
        O/xrP1pf96zTMe3nda7GAxrbyuZHo1PdVesUryb9tGF/yeH2p/uGTlWgnckfWi/+avb/Yqj4
        Dcfeo/mrl9UNuOQs977Z1Clb1N65t7XEBSxrv5uvWKDnvs5N0GbcDbl2vSDAPrPGEPhpbLRn
        om8Jyly5UNm2cUn8na7b09K//8T9fPdV0Xvd+aZyW2zwsh6dSILlIUH+82iZPOhfCl1C+y0F
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTe0xTdxTH97v39t7iQtYBkzse2VanY6jFUtCDU6N7xGume2TJEuec66Rp
        QdpiC0y3mWHLNmAykYfEUnnYgVDKowgIFCthnR1BozBEEBAFBQqI4zWo5bFCs8xk/31+n9/v
        e87JLzls3KOK8mFHyGJECpkwikuuIloWrfc2qrzTwzepWl8BbbmBhFtlJQhmHdk4mIa7CZi2
        d1OQvFhFgKHqJAZTFYskTFmsJIz+NomgbeA2CVm2kwRobdcpWOodwkCX/zcOwxU/IdDeTCBg
        XOUg4FFqNQ5LNQkUqHXlJDRZr1Jw1ugN2VlqDNLsqQju3/YBbVcwjJ/3A3uhnoKych0Gqtoi
        DGracxFYMjQ49J7OJOD6z1IwtcxgUN2jImHInIJB0mwBARlnVQgarjQT8Ge9loR7hiUW/HWq
        nwRL+Q0CWq79QUBJaTwLCu60YmBIKmZBZ+ojBOnjgwh0F9fBxNVPoK0xD4PCugcEtJ5sRFCS
        sUDBnMPBgu60LAKsKY0YLA3MsMCceB+DtrlRAkzGC+TOD5nZH34hmL6xBYIx5BgQkx3fSjBV
        xV0Y01NQh5gz6nGKqdP0UkyC+S7F5FXGMh2m/UyC5TGLuVQUyOgabBiT3NmGM5X6JPKjgM94
        2xTy2BjRqxK5MmY79wAfgnn8MOAFh4Tx+IItB7cGh3KDdmwLF0VFxIkUQTu+5EmS5t+NzvA+
        Vtg4yIpHRs9k5MamOSF0v6mWtcwenAJE35jEXd6PNk7fZrnYk57vSCaT0SrnmwlEF40+IVyH
        akQXdGtWEgRnLW2aa6KWmeRsoG+O9ax4Lw6XHsntxZcDOGdmNT0yNrBy4cl5h76ifrjSwp2z
        hc5XjeGuMe4huuTXIJd/kW4+95BYZpwTR+vSh5zMdrIvfXGRvazdnH2N9dnINeka+o5ZR7r4
        BD21MIhSkafmmUqaZypp/qvk0oF056IN+59eTxfmj+Iu3k6XlT0h8hClR16iWKVULFXyeUqh
        VBkrE/MOy6WVyLkyNdfsl2pRzsgErwlhbNSEXncm+ytKbiEfQiaXibhe7v6VaeEe7uHC49+I
        FPJDitgokbIJhTp/8Qzu89JhuXP/ZDGH+Js3hfJDNodtCg3bLOB6u++JThR6cMTCGNERkSha
        pPg3h7HdfOKxTw3CAIGgzCywRAX1hXzb7dij3vD9gb6a+bZ15q4GA5K+HZ5+4Csqx99XrA54
        v/NHv+OSo1841AnfRTx/hKWTHT20K1cv0UbqfZWRdGLNwMQay1DipMGnwbZ7+Nh71zwVjfyt
        2w6uvSD4/aH1soxurvDeL+brnu7sWL9oTfp4Mjfw6V11qST65deqgyrdix/bT2y5+kFA3Grb
        6aQXBPveMGJ7DX6jLRulQ/2UNbCzWTtVHZVV8yAg1/F1d++ty4n72m35o9dT9p5nlUbOnxte
        NS3fcTMgz1db1NX+ZktL3Nx0psTex8Hf+vy5TP9du8Pt+eJq40zniLhKb8bq6msrFtpnuYRS
        IuQH4gql8B/pJ17rxwQAAA==
X-CMS-MailID: 20230621153010eucas1p25fabdc546fa653beb103f6f68f4da531
X-Msg-Generator: CA
X-RootMTR: 20230621091037eucas1p188e11d8064526a5a0549217d5a419647
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621091037eucas1p188e11d8064526a5a0549217d5a419647
References: <20230621091000.424843-1-j.granados@samsung.com>
        <CGME20230621091037eucas1p188e11d8064526a5a0549217d5a419647@eucas1p1.samsung.com>
        <20230621091000.424843-9-j.granados@samsung.com> <ZJLgzo1GuykDV8fd@alley>
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

--6xqmlcamfjbvcfp2
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 01:36:46PM +0200, Petr Mladek wrote:
> On Wed 2023-06-21 11:09:57, Joel Granados wrote:
> > In order to remove the end element from the ctl_table struct arrays, we
> > explicitly define the size when registering the targes. We add a size
> > argument to the register_sysctl_init call and pass an ARRAY_SIZE for all
> > the callers.
>=20
> This does not explain the motivatin why the end element is removed.
I also see that the cover letter also lacks this. Let me clarify in my
V2.

>=20
> I agree with Jiri that saving 9k is a questionable gain. According to
> the cover letter it saved 0,00%. It is because it saved 9k with allyes
> config which produces huge kernel. IMHO, the 9k might be interesting
> only for a tiny kernel. But I guess that it would safe much less
> bytes there.
I put the 9K as a upper bound kind of value. To get an idea of exactly
how much we are talking about. A lower bound with tiny config and sysctl
enabled is a good idea to give a range.

>=20
> And the code with the added ARRAY_SIZE() parameter looks worse than befor=
e.
This might not even be an issue in V2. After analysing Greg's feedback,
these might just go away.
>=20
> > diff --git a/kernel/printk/sysctl.c b/kernel/printk/sysctl.c
> > index c228343eeb97..28f37b86414e 100644
> > --- a/kernel/printk/sysctl.c
> > +++ b/kernel/printk/sysctl.c
> > @@ -81,5 +81,6 @@ static struct ctl_table printk_sysctls[] =3D {
> > =20
> >  void __init printk_sysctl_init(void)
> >  {
> > -	register_sysctl_init("kernel", printk_sysctls);
> > +	register_sysctl_init("kernel", printk_sysctls,
> > +			     ARRAY_SIZE(printk_sysctls));
> >  }
>=20
> Is register_sysctl_init() still ready to handle the last empty element,
nope, after all the patch set, this functionality would be gone.

> please? I am not in Cc on the related patches.
Not sure what happened there. Should I just add you for the next batch?

>=20
> Best Regards,
> Petr

Thx for the feedback

Best
--=20

Joel Granados

--6xqmlcamfjbvcfp2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmSTF34ACgkQupfNUreW
QU8CgQv/WDyYibe7/IonBVPexXNQGTVuyKh61uOYtHRK+2k13K3RLUk48Z0C+Q5+
vfTq/uCCkVwy/eYrMqn1RFGRzZ2NY6UkXXd7X6g8UVGLIiTCl2TEA235HjpPCxuh
/RcNXUoYsrzVCc6s4XtIScbySNGho9BtuXw1vInVQy08FiO21l2apZYCWtOqRzdA
GFUepViYRcMqGClksHNZKDND+JZWRjB1sqPr5UfLVo89RxrSGbDqZFP2DCU3ehNx
vbSg+kcYu3PBOZQuhA9Eu4h1ErwKlk6PQJhJ04lpMwJU3eSR8+t6A/9iKE305ufv
lulowZS/J4q8c+8IDMZR/g9Ire50DzZ0MzEENUn43oqh7EVc+C5XgG28Gxyb7P+l
aXq/uiZNg8e1cD54e+l01DjFU8aEVz1KN3YE4NF2VW/EDUyiOJU3a+mkBSPSIt7C
MSeQHeJvDOffcGjCWsyGwiiplObWKHl4WApjE/sA0UtkNFCc0178hmKbFf9ayZvv
J2+uWQKH
=taMy
-----END PGP SIGNATURE-----

--6xqmlcamfjbvcfp2--
