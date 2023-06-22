Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3519B73A27C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 16:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjFVOAd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 10:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjFVOA3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:00:29 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EF91BD9;
        Thu, 22 Jun 2023 07:00:25 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230622140024euoutp016c59b1213fcbc04a0a7dcab6f00677f0~q--HNBgTF1007310073euoutp01W;
        Thu, 22 Jun 2023 14:00:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230622140024euoutp016c59b1213fcbc04a0a7dcab6f00677f0~q--HNBgTF1007310073euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687442424;
        bh=og1TC2Lnktq3yPqNAHugUqe0csk9nUhazXy+81bh4dw=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=mCUZPxxFAPlZfYMcyjtFzdZobopd9W7sIEmS0WAnAfWvOWNbeSnjCvTqoPq4BflsT
         2So3S8hL+ZL3HkDd5Eh+8RGv9HB078GacsMBEAHSQPAa+kL61XF9pqEmryoVjwNNNw
         bs/wprggINHRtWs8Diakqsfp4AtYSsFi0OgBuBaw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230622140024eucas1p2cbb3f8b639a73e206f4c47f91fb01813~q--G9NX-t3023430234eucas1p2f;
        Thu, 22 Jun 2023 14:00:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id EC.F9.37758.7F354946; Thu, 22
        Jun 2023 15:00:23 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230622140023eucas1p1a4af4ef903b3613453b5b1e254aa2c8a~q--GTP6rD0317103171eucas1p1P;
        Thu, 22 Jun 2023 14:00:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230622140023eusmtrp122f2f2a32f10e3b52e1916a11785fa7c~q--GQ6exq1308413084eusmtrp1f;
        Thu, 22 Jun 2023 14:00:23 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-b4-649453f791b8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0E.1F.10549.7F354946; Thu, 22
        Jun 2023 15:00:23 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230622140022eusmtip11ccd18796ef5394ff02d0e58b93a459b~q--F5zocq3248032480eusmtip1K;
        Thu, 22 Jun 2023 14:00:22 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 22 Jun 2023 15:00:22 +0100
Date:   Thu, 22 Jun 2023 16:00:21 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Jiri Slaby <jirislaby@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <mcgrof@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Jeff Layton" <jlayton@kernel.org>,
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
        Will Deacon <will@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
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
        "Amir Goldstein" <amir73il@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, "Yonghong Song" <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "John Ogness" <john.ogness@linutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Valentin Schneider" <vschneid@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Will Drewry" <wad@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <bpf@vger.kernel.org>,
        <kexec@lists.infradead.org>, <linux-trace-kernel@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 08/11] sysctl: Add size to register_sysctl_init
Message-ID: <20230622140021.g3odhui75ybwuai5@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="syt6n5frzjj2i4j3"
Content-Disposition: inline
In-Reply-To: <fc37eccc-b9b3-d888-6b57-78cd61986a11@kernel.org>
X-Originating-IP: [106.110.32.133]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTe0xTVxzHc+49vbc2ltSK4QTEbHUY5oOp0/CLohnbst1NF11cXLY5NyLX
        16CaVpgubvLoxkOdCChaUEGgQFsBWSki8lglIq/xZmDBqaBSQB4ir/Ea5brMZP99ft/z/Z78
        vic5YloeJ3YWH1Ae4VVKHz8FI8HmO+M1q0Z3xPqurp/0hIQsIwO1mQYEoxPxNBR0WTG8GLey
        EDltwmA0BVMwlD3NwFBpGQM9t58jqO9oYiDOFowhwVbFwkz7UwqSk0Zo6MoOQ5BQo8HQFzKB
        4XFULg0zZg0LoclZDFjKilk4f90J4uNCKYgej0LwoMkZElrXQt+lxTCu07OQmZVMQciNdArM
        jVcQlMZqaWg/cw5D1Ul/KKgcpiC3LYSBp0WnKYgYTcUQez4Ewa3CcgwNNxMYuG+cEcHAqUcM
        lGZVY6i8cxeD4VqQCFL/rKPAGJEhgpaoxwhi+p4gSE5bBoPFO6C+JJECXf5DDHXBJQgMsVMs
        jE1MiMAaHYeh7HQJBTMdwyIoCn9AQf1YD4aC61eZd7Zxoz//irm/eqcwZ7xsRFx8UB3mTBmt
        FNeWmo+4s6F9LJevbWc5TdE9lkvMCeCaC77gNKXPRNxv6cu55Fs2iotsqae5HH0Es939S4mX
        L+93IJBXvbX5W8n++Ii7osPPHI5mXTFTQah7fiQSi4lsHUnp/ygSScRyWToiF+sMWBheINKc
        kUtHonmzwxAi1st+drYHMpr6GcGUhkhBih4Jw6zp5rWgl3ETIrW6KtYewTI3Uq0fmWNGtpLU
        9LbNXes4q+vy9YydaVmIE+lK8rDzQtl7pDC0U2RnqcyTjOY1sgIvIOUXO7HgP0rGzJm0vQMt
        cyFp02K7PE+2mcScjEXCpgoy3HtaJPCPpMJ0jxK4bj6xxr0r8PskKWMKC7yQdJeZWIEXk8qY
        U3NdiCwGkeLpAVYYDIjogodf3rSRaBo7Xya8SXpINBIe1YG0PFsg7OlAos1xtCBLSfgvcsG9
        jBju9+IotFT7SjPtK820/zUT5JUkseA58z95BdEl9dACbyKZmf04EbF65MQHqP338eq3lfz3
        Hmoff3WAcp/HnkP+OWj2v1ZOlw3fQOndgx4WRImRBb0xG36UbahFzlh5SMkrHKWuOdG+cqmv
        z7EfeNWhb1QBfrzaglzEWOEkXbGpfI9cts/nCP8dzx/mVf+eUuJ5zkGUn7s8IW8ysOhJriuv
        OrrRst583L3P9nfKyIZbfLS1dW3M7T+mmrqCD+Y5LXWLWK09Y8tW92Rv3eBiVTDW7Y4djtd2
        /9R902CUHHy4bmv474qm8okFtS47/W9/jDM/0HpfcD1RXl1M1oXx4q7eNSmerYVnj7ltblj0
        epWltHBN3u4Bh/PbG0aN1HTNJ9uUVx/2fOafE/xVtWfZKtuWWk184wmJZ/9xnYK1fdrccuZO
        +fLVrXs7LUs2eH3e2XQRitwSc3c98j4QJVVse239uY7CsC1vunot0cs/DCTuFRbL3rZLWaV9
        Dbukeyu+rqjLWTRSfWHn5T3NJaZuycLDjMZhcNLXSWxWYPV+nzXLaZXa5x9OzkChKgUAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTfUxTZxTG896+vbc4mR2wcEW2zDqd0VktAp4uysx0yxXnNjWabMt0nVzR
        DVpswbglywoUhTKwfExnwa6IRSkdVKRoV0QHDDRAUAYC8jFQULAKImAlHe2KdZnJ/vu9z3me
        JydvcngcPwsVxNsvjWflUkmMgJyDG10NvSsc23OjVtVY50J+mYmE66UlCBzOPA7YhrsxTE53
        U6B2VWAwVSQSMGF2kTBR10CCvfYxgtY77SQcH0nEkD/SRIG79x4BhQVPODBsPoIgv0WFYTTJ
        iWFIY+GAu1JFQXJhGQk1DZcpOHYuEPKOJxOQPa1B0N8eBPldITB6Mhimi4wUlJYVEpB08SwB
        lW2/IKjL1XKg9+hPGJrSY8HWOEWApSeJhHvVGQSkOQwYco8lIai6dA3Dn7/lk9BncnPh0Y+3
        Sagra8bQWH8VQ8mvSi4YOm4QYEor5kKnZghBzuhdBIVnlsD45e3QekVPQJF1AMONxCsISnJn
        KHjqdHKhO/s4hoaMKwS470xxoTq1n4DWp3YMtnOnyPUfM46UTMz89WAGMyadCTF5yhuYqSju
        IpgegxUxWcmjFGPV9lKMqvoWxejLE5ibtk8ZVd1DLnP+7DKmsGqEYNSdrRym3JhGfrL0M+Fa
        uSwhnn1jn0wRv07wuQhChCIxCENCxULR6jVfvBMSJlgZsTaKjdl/kJWvjPhSuK/LsivO/vKh
        I/0blWh4rhr58Gh+KF3cPkaq0RyeH9+AaP30H4R3EEyfm2znetmf/vum+rlpHNH3T1Rh76MC
        0bdOWp+5MH8x3Wx8Qs0yyX+bbnnQw5nlAI9eZDU+S3P4ykB6pttb68/fQF9KHnzGvvw1tONC
        G+VtbSHo8czu54NX6GsnBvEsc/gH6YGpSx4Tz8ML6DMu3qzsw4+gc9JzkXdVAT31IOP52t/T
        EzN3kQb5a19o0r7QpP2vySsvoztdI8T/5OV0UYGd4+V1dGnpGNYjyogC2ARFbHSsQiRUSGIV
        CdJo4R5ZbDny3Exl/fT5i0h3f1xYgwgeqkFvepK3zSXXURCWyqSsIMD3tfLsKD/fKMm337Fy
        2W55QgyrqEFhnm/M4gS9ukfmOUBp/G5R+KowUWi4eFWYOHy1INB3U1yqxI8fLYlnv2HZOFb+
        b47g+QQpCVFugD6Rmme2TeqDI6+r2L695/15HXubt2xWX+2p/nC0KVVbn/PBWL04Zsh3cO1R
        VzeWOmTGmNdfsmwt71vp06y09V3IarNULW7a3jg0ENe8bUX2nOzHaMfJ0+6dNR+965S5jOvr
        yKEf2IYDpxYFpI9HbjUEPz5QVLvjkNOorbVNhrrxBbsmvONqyMLU91WRmw3XhEvsPWSeYVPt
        vNORdPKGQ+PEzoUXxbtWmzPmDSxIe5hy973aiUxddvvSjduqAgcnl5sX6X6vqJjfn8S85TNG
        b+lMOTy85YysPboAF+/tSO9wtUgIP93Ww/MrNT/fj8qUfqXOUhToHgVWfs2VbgspFWDFPolo
        GUeukPwDhsADlcgEAAA=
X-CMS-MailID: 20230622140023eucas1p1a4af4ef903b3613453b5b1e254aa2c8a
X-Msg-Generator: CA
X-RootMTR: 20230621091037eucas1p188e11d8064526a5a0549217d5a419647
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621091037eucas1p188e11d8064526a5a0549217d5a419647
References: <20230621091000.424843-1-j.granados@samsung.com>
        <CGME20230621091037eucas1p188e11d8064526a5a0549217d5a419647@eucas1p1.samsung.com>
        <20230621091000.424843-9-j.granados@samsung.com>
        <2023062150-outbound-quiet-2609@gregkh>
        <20230621131552.pqsordxcjmiopciq@localhost>
        <fc37eccc-b9b3-d888-6b57-78cd61986a11@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--syt6n5frzjj2i4j3
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2023 at 06:21:48AM +0200, Jiri Slaby wrote:
> On 21. 06. 23, 15:15, Joel Granados wrote:
> > On Wed, Jun 21, 2023 at 12:47:58PM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Jun 21, 2023 at 11:09:57AM +0200, Joel Granados wrote:
> > > >   static int __init random_sysctls_init(void)
> > > >   {
> > > > -	register_sysctl_init("kernel/random", random_table);
> > > > +	register_sysctl_init("kernel/random", random_table,
> > > > +			     ARRAY_SIZE(random_table));
> > >=20
> > > As mentioned before, why not just do:
> > >=20
> > > #define register_sysctl_init(string, table)	\
> > > 	__register_sysctl_init(string, table, ARRAY_SIZE(table);
> > Answered you in the original mail where you suggested it.
>=20
> I am curious what that was, do you have a link?
of course. I think you will find it here https://lore.kernel.org/all/202306=
21123816.ufqbob6qthz4hujx@localhost/
>=20
> --=20
> js
> suse labs
>=20

--=20

Joel Granados

--syt6n5frzjj2i4j3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmSUU/UACgkQupfNUreW
QU/eXQwAlJO0Xh+bybgQP96+XlRpihv6ZwN4xoVQS++ddKq1YhcrS2QQ3aAI2zlS
O+JsUdqP3tI8y8lMZnQol7Ez9g0BX1PeqWSUnitoKVCyZe8NwvpjdmYBG5oEuZaE
ruvpOJQoHlFt+0C3hfcxo+gvQtjjXRGDmO0Kjfg5JL0d/TmxV694P5Y9sjJ3Zz/9
q88yHBeZ++k0QVUllifujJ0XKcqA6aLjNd5O+ujwisz+KYpRnslGyqgFG9hI4F9/
FcHmyOP8V6DxshGEpW924k2zVDZu/H/LCl+KqB3vmfaIm/hs34Q4bnG/cnRKWxsW
x7HeXEn489/bnVCmHQ9PTZJCexFp/lL3Mdr5dyQfkk2gwk0hAfzLh1akOv2p7scx
63UyaIoh7zP6aLN1U4LGQfprDbl+Ll55j+KYv/DbhALGXaZ4/Ko1LdCEQpo/rKYU
AfygV67LAp5wW26oCQ0p/2QeqjaIkn8xOjVw7VthnBeBrMFx6jHQylS6QZaogAyV
dB+VmnCT
=Evhn
-----END PGP SIGNATURE-----

--syt6n5frzjj2i4j3--
