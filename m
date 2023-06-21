Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD41C7384A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 15:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbjFUNQA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 09:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjFUNP7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:15:59 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534A71994;
        Wed, 21 Jun 2023 06:15:57 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230621131555euoutp01cbc0ed048af8c2bf28332479f20c2ce4~qru-OYmE12681126811euoutp01m;
        Wed, 21 Jun 2023 13:15:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230621131555euoutp01cbc0ed048af8c2bf28332479f20c2ce4~qru-OYmE12681126811euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687353355;
        bh=NbLD2SuFhZddkTpTyuzHX5np9Ewwh7mfi7FsRT8ROaQ=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=JNcJ5ITswF0IEJpYFOaxysTaMYVdrBOLr7EOczmyHgvwYgKoHvv+Z1wasrE5vJ9ze
         mG9m6hTMHD7eQZj6dy6futmrUSKu6ZtWcQPOiIGUJooV0+o97DkZ38AV+6ABgERAne
         ODsU39a5aZus6HUZguwhXM1F7n/MUL3RoWmKiS4c=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230621131555eucas1p20be9c897ff3f7c6cf943c864400829af~qru_4FVm-1334713347eucas1p2z;
        Wed, 21 Jun 2023 13:15:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C1.C4.11320.A08F2946; Wed, 21
        Jun 2023 14:15:54 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230621131554eucas1p135050d4ea931b8da593678132937163f~qru_TTVJM0660106601eucas1p1u;
        Wed, 21 Jun 2023 13:15:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230621131554eusmtrp1692d0318dd759904de572872ce9c6b36~qru_RdmKS1434014340eusmtrp1j;
        Wed, 21 Jun 2023 13:15:54 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-5c-6492f80aeefc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 94.9A.14344.A08F2946; Wed, 21
        Jun 2023 14:15:54 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230621131553eusmtip164806c07aa1bfa8f2bab3ed09c2fc98c~qru95WHid1267712677eusmtip1g;
        Wed, 21 Jun 2023 13:15:53 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 21 Jun 2023 14:15:53 +0100
Date:   Wed, 21 Jun 2023 15:15:52 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <mcgrof@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
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
        Will Deacon <will@kernel.org>, Petr Mladek <pmladek@suse.com>,
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
Message-ID: <20230621131552.pqsordxcjmiopciq@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="kqwdriluwhsvqta5"
Content-Disposition: inline
In-Reply-To: <2023062150-outbound-quiet-2609@gregkh>
X-Originating-IP: [106.210.248.248]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2VTa1BUZRjuO+fbc5ZVmCOYfCH+CEwNBAtT3zFpYrLxdDMtK6sxW+UMOAoo
        K6ZZCssmsmIgoOCCBu0IC7sBwrJBuOCsIHETJLkJeAMV5eINBNyRjfXg5Ez/nve5nO95fhwp
        7Xxc6ibdErpTCA+Vb/NgZNh0frzRRzaWGPhG6YHFkJ5vYKApT49g1JpGQ1lfJ4bh8U4W1BNG
        DAZjFAWPCiYYeFRZzUD/uYcImntaGEi5E4Uh/U49C7bu2xRoMx/T0FcQgyC9UYVhSGnFcDOh
        mAabScVCtDafAUt1BQvHTrtCWko0BYnjCQiutbhBeocfDJ1wh/GsXBby8rUUKEt0FJgu/Yag
        MllDQ3f8UQz1h0KgrG6EguIuJQO3yw9TEDt6CkPyMSWCM+YaDP/8lc7AFYNNAvfjbjBQmd+A
        oe783xj0f0RK4FTbRQoMsTkSaE+4iSBp6BYCbfY8eFDxOTSfzaAgq/Q6hotRZxHok5+yMGa1
        SqAzMQVD9eGzFNh6RiRQfvAaBc1j/RjKTv/OvPspP/rLr5i/OvAU84aTBsSnRV7EvDGng+K7
        TpUi/kj0EMuXarpZXlV+meUzCiP41rKveVXloIQv0nnx2jN3KF7d3kzzhbmxzJoF38hWBArb
        tuwSwhe9870sWGfNpLZnOe5OKuihIlHzNDVykBLuLZKaU8SqkUzqzOkQUQ52UeIxjMhRm3bq
        eIRIaWwqeh4xadIkopCNSEz+CGsXnrmqzO+LQjEicXrLZFwqxdxrJEfD2T0Mt5A0DnTRdjyT
        W0ziGzTP3qa5W7NIU+sAYxdcuPeIObpXYseO3DIy0tpHi3gGqTnei+2Y5naTys5R2v59mptN
        siekdtphslzNeTMrFvUkbeVaRsQ/k1rj5WdrCNcynTzpvjUlrCT3rjbQInYhd6uNU2F3UpcU
        h8VAEiIVE/dZ8dAjkhU1Qomut4nqUu9UIoDolInI3ohwTqR9cIZY1IkkmlJokXYkBw84i+55
        RH9lACcgT80L0zQvTNP8N02kF5KMsofM/2hvkpXZT4vYn+Tl3cMZiM1FrkKEIiRIUPiFCj/4
        KuQhiojQIN/NYSGFaPKPrZuoHi5B2Xcf+FoQJUUWNHcyfKNA34TccGhYqOAx03FOYWKgs2Og
        fM+PQnjYxvCIbYLCgmZLsYero7d/zWZnLki+U9gqCNuF8OcqJXVwi6T2LW3rmNNjVi4q2fFB
        f6qkqnGTdx377R6f0ipFU4zvww9/ClkfkL0jQNd7Inbx/R6v5UMfGVXLmWk1y141y1YtbbNV
        yQ+o102fc+7k8V7vGTdNW61rM2P5ov2b8oIudH8XP+g9i50VlJQU7E5MSyzyAenGDJN7uWdx
        bfquk8HjLp8wDuWdPhlLZC1ORX+upoe9X1Je3d+6t6n7EFanqlaqX4+7azN/ORhp3LSh7zMX
        /3We0f4l5rEvrOqilU91HgvqufY1tdlO0c2Rgesthse1T172mx9zbEP8Ov9pK74yWMKc115o
        8FvhdOS6/+oifDtOf6lqPvTUzB0IyGp1Qh1hr8Ts/XifB1YEy9/0osMV8n8BgipHCCwFAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA2VTe0xTdxT2d++v9xY2lksBuaAmS93YhrNSBD1MIGSL8e6RadyDsMW5Bq5C
        Bi1rgeiGk2cm3VCoKFkpivKSx3itMJSHiBXGAAUUxPGQlwIK+AAEVoFRmmUm++/L953zfeec
        5AhJUTntKAySh/FKuSxYTFni5qXGvs2W85oAl+laC9AVF1LQVlSAYM6YRkLVWA+GmYUeGtRL
        egyF+mgCpkuWKJg2NFLw8OpTBB3DnRSkjkdj0I230LDcN0pA5rlnJIyV/IhAdyMOw1SMEcO9
        pHISliviaIjNLKagvvEyDadL7SEtNZYAzUISgoFOR9DdcYWp9PWwkJNPQ1FxJgExlRcIqLh1
        FoEhRUtC34lTGFp+CoGq5lkCyntjKBitTSQgYS4bQ8rpGATVNU0Ybl7SUdBfuCyAxz8PUWAo
        bsXQ3PAHhoJfowSQfbudgMKEPAF0J91DcHLqPoLMXCd4cvkT6KjLICDn4iCG9ug6BAUpizTM
        G40C6NGkYmhMrCNgeXhWALXHBgjomH+Ioar0POWzm5uLP465uxOLmCs8U4i4tKh2zOnz7hBc
        b/ZFxCXHTtHcRW0fzcXV/kVzGWXhXFeVHxdnmBRwv11w5jKrxwlO3d1BcmX5CdSeN7+QeCoV
        4WH8q4EKVZiX+EspuEqkHiBxdfOQSLdu3/eOq7t4i7dnAB8cFMErt3h/LQmsqL5JhmZZHRqv
        yUdRqO0lNbIQsowbW6FNE6iRpVDEZCO29EwuNgvr2dKZToEZ27DPu9SUuegJYidGNZRJEDHl
        iP17wF6NhELMvM7maRkTTTFvszcmekkTtmW2sidatbSpl2SG1rIVI9dWBRvmPbYmdmQ1wIrZ
        zs52jZHmgEnEPq0uxmbBmm36ZWQVk0wEG2MYxqYwklnH5i4JTbTFygZNDTW0edCN7O3aTMqM
        j7DTi/dRErLRvuCkfcFJ+5+TmXZmu5fGif/Rm9iccw9JM/Zii4oe4QxE5yNbPlwVcjBE5SpR
        yUJU4fKDEn9FSBla+ZmKhgV9Jcp78ERSjwghqkevmXYvKWhDjliukPNiW6sNZZoAkVWA7PB3
        vFKxXxkezKvqkfvKFZNJRzt/xcoDysP2S7e5uEvdtnm4uHts2yq2t3o/9JhMxByUhfHf8Hwo
        r/y3jxBaOEYRorY9DpK1fYtfXTsSad+t/9bu+nXRyztbSVtBQex8f2zA5gZfuxavU9LKjvTG
        hSjLxAfi4nGHzmjv9rp9Vz091cKlwQ3GxrHPPA43q3FV4p/+axJ+EEw+HfjoU53BCT/LuvuK
        /ujaSxHGHXhd5RXvmfhdh6Zys9d8Pu2isX70VlWCj1OTww2rW3U2BX7H3zgw23y0/zz5eIeP
        xicmJLm8Pt7t+W4PZ+s00QG3d4d2WguGRp3cRw2MaK/ueJDUl1fn7O2JSp/pNzj0dnUYB3lF
        /L5WjZY8KdfrPsj6+LBoUVYu8f/+lmfr2YzH7mHnr+2y84u0DDV4Rw5uEiPfD7dE/H4lPUKM
        VYEyqTOpVMn+Aa3aWqDIBAAA
X-CMS-MailID: 20230621131554eucas1p135050d4ea931b8da593678132937163f
X-Msg-Generator: CA
X-RootMTR: 20230621091037eucas1p188e11d8064526a5a0549217d5a419647
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621091037eucas1p188e11d8064526a5a0549217d5a419647
References: <20230621091000.424843-1-j.granados@samsung.com>
        <CGME20230621091037eucas1p188e11d8064526a5a0549217d5a419647@eucas1p1.samsung.com>
        <20230621091000.424843-9-j.granados@samsung.com>
        <2023062150-outbound-quiet-2609@gregkh>
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

--kqwdriluwhsvqta5
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 12:47:58PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jun 21, 2023 at 11:09:57AM +0200, Joel Granados wrote:
> >  static int __init random_sysctls_init(void)
> >  {
> > -	register_sysctl_init("kernel/random", random_table);
> > +	register_sysctl_init("kernel/random", random_table,
> > +			     ARRAY_SIZE(random_table));
>=20
> As mentioned before, why not just do:
>=20
> #define register_sysctl_init(string, table)	\
> 	__register_sysctl_init(string, table, ARRAY_SIZE(table);
Answered you in the original mail where you suggested it.

Best
>=20
> or something like that?
>=20
> That way no callers need to change AND you prevent the size from ever
> being incorrect?
>=20
> thanks,
>=20
> greg k-h

--=20

Joel Granados

--kqwdriluwhsvqta5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmSS+AgACgkQupfNUreW
QU8jOQwAkoxloAVnIuEyaWUNUmcFoEEQMjNqdYL2wi038MemWOYfweOEMRyOEo3b
iqRfJVW+fiwb+BFTXw9Z3i1KteXm7mdz4YY+VbjJiygOSu0zhM4LY4ViTh8pu5LV
FSsRDdRaQZfbeb8bog0lWFauAs5AfpyFcUqvZM1O9TDiI+nMrMlzb4PzSBJeIq3r
DCIxRhnWhl/QbfXYBx8rRHskljcS6NTXtILN4S3H88F5YOdof86uQwtXnz28VLdW
C6DK8aafbLVrwB8/nYX6YxrT4nFquNKfodH7jKM7iHGCxZWc3ALSwvKBA6mjMSCh
GqhXmroSN4hN0N1vA/oDK9ZwZ1GPwqmxtmXe1Rtp/Ah3CtzC2F3hbPxaHP5yEVJS
pyPZRKBdEvIvWFhDf3JfEAhrvP08QKKyDN6cihST4dXQ7SHdgpwAVcK7hLnNU0mw
Tg+iK0faxcu/tfkmixursSgigO7zwZJXKbBifv3mQ1RP5E5QnsSfgsgY50ogU7/I
hN6IedMI
=UHCo
-----END PGP SIGNATURE-----

--kqwdriluwhsvqta5--
