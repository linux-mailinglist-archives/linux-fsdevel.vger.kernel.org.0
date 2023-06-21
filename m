Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D17C73848D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 15:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjFUNL4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 09:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjFUNLz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:11:55 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AC71706;
        Wed, 21 Jun 2023 06:11:53 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230621131151euoutp01bc8bebbea69ba176d6badb7e87a484a8~qrrcKFwCf2130921309euoutp01B;
        Wed, 21 Jun 2023 13:11:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230621131151euoutp01bc8bebbea69ba176d6badb7e87a484a8~qrrcKFwCf2130921309euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687353111;
        bh=2O4y4/AbWeMueqHe0D/3ZI0FDn7vWoH6W/Bnc1hXI8w=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=HqRo1EN8b5bvWQROkfcTVVqyVQ/zAmv8ITfXv9JJ9+7esSpiHIkQt5cgn3r7wvisB
         Upp0PfutetwFf1EtjqJwOPJYz1nmdb7Z6O/7l6kL3D0sazLhYuLRrtXbSiM86je+X2
         lcP/wE2su+BtkwSQSh9IpXJYr6GqpDaeQ7hw9dxs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230621131151eucas1p1847f565a11eec2b83f826f4735d9bd39~qrrb1c2Im0883608836eucas1p1_;
        Wed, 21 Jun 2023 13:11:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 00.D3.11320.617F2946; Wed, 21
        Jun 2023 14:11:51 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230621131150eucas1p1c9668cfd8aebcd4005ffe3a20510bf14~qrrbSWi6l0379603796eucas1p16;
        Wed, 21 Jun 2023 13:11:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230621131150eusmtrp2346919855b4d636ebdd3c48db15ffdec~qrrbQcedz0242302423eusmtrp2c;
        Wed, 21 Jun 2023 13:11:50 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-f6-6492f716f94f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9A.D9.14344.617F2946; Wed, 21
        Jun 2023 14:11:50 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230621131150eusmtip1db8bda4ae533f60ba50a09ddffd39f68~qrra5kf3_0998709987eusmtip1L;
        Wed, 21 Jun 2023 13:11:50 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 21 Jun 2023 14:11:49 +0100
Date:   Wed, 21 Jun 2023 15:11:47 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Jiri Slaby <jirislaby@kernel.org>
CC:     <mcgrof@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <20230621131147.c3jegl4hgjplcrpu@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="iqp637iv5bkrldev"
Content-Disposition: inline
In-Reply-To: <36fae2b0-4cd2-58b5-cc12-9abdd5ce235b@kernel.org>
X-Originating-IP: [106.210.248.248]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTa1CUZRTH53nfZ99dIHQFJh65VAOkDaAm3s5kOBU6vR/UIJssbKZ24B28
        wOrsumUREyybuZgJq0ECxsLmsu6uLBAwIgiIjCuBcvEGCmIrCggidySCjfUlc6Zvv3PO//+c
        8//wiGi3TJGXaJd0PyeTSmL9GGdcdmnq6jLPSU30myfKMGRbzAw0F5gQTE5n0VDRewfD2NQd
        IaTMlmAwlyRRMFo4y8BonZWB/osjCFrv32Agoy9pztvXKAR7Zw8FutwJGnoLf0CQ3aTCMKic
        xvAgtZQGe5lKCMk6CwO11mohpBd5QlZGMgWaqVQE9254QXZ7CAye9IEpvVEIBRYdBcqzBgrK
        rucgqDueSUPn0Z8xNB6Og4qGcQpKO5QM9FQdoUA9eQrD8XQlgsrz9Riunctm4K7ZLoChH20M
        1FmuYGi4dBmD6UyiAE7daqHArD4tgLbUBwiODT5EoMtfAsPV26C1RkuBvvxPDC1JNQhMx2eE
        8HR6WgB3NBkYrEdqKLDfHxdA1aF7FLQ+7cdQUZTHvPMBO/n9T5jtGpjBrPlXM2KzElswW3K6
        nWI7TpUjNi15UMiWZ3YKWVXVbSGrLVawNys+ZVV1jwXs74ZAVlfZR7Epba00W2xUM+FvRDq/
        Hc3F7vqSk63Y8IXzzkKDFu2rWXjgZrINJyKLawpyEhHxatI0rUYpyFnkJjYgYnw6w/DFGCJP
        SvoFfDGKyK0LecLnlvar86p8RHJNWfi5qjPl3rylFJGeyyeRw4LFr5O+M0O0gxlxMGka6HjG
        HnN9fbnx2VO0eOJlotToGcfAXRxGzid3CxzsKl5HjEfzaJ4XkfoT3djBtPgA0TzMm1sgmmNv
        kj8rcqCTeAOxTbnwl/qTW1U6hucE8kfJbcqxiojbXyLN+QbMDzaSjAzrfDR38shaMs8+xF6e
        M284hkj17JCQL0yI6JPGKV61nqiud8873iUGpebZQUS8gLQ9XsTfuYBoyjJovu1KDh1049VL
        iOnuAE5F/pkvJMt8IVnmf8n4djDRVoww/2sHEX1uP81zKCkoeIK1SGhEnpxCHhfDyUOk3FfL
        5ZI4uUIaszxqb1wxmvuyDbPWsbMo/9Hw8lpEiVAtCpgz2wpNzcgLS/dKOT8PV99iTbSba7Tk
        62842d7PZYpYTl6LvEXYz9M1KLQ+yk0cI9nP7eG4fZzs3yklcvJKpCIu5nQ1/WJzGdt5+9vw
        huDcssjtihO7u1au3eg/4P1+fEdt6OzhkPTdUWkeXgmBbQcbvavzjUyie++eljR7ucE4LNvR
        seHa2WXq4SvnV65670zYCplq6X2niM/CjC6b1u1ZvbVxy6ZGVcxRxfCI/qB0sjtP12c55NfV
        zQXVVzaXJqz13Ry2pSoh+Zwl4Fh8F9QJLiz2Cl74qq1I9VCNnWqt3qHN2t2NAUVXLrmcPBx7
        pFK7ZrqODVgwod0RlWb+yL6GfNJhcJMg07b1Xft++zs+77tVr/go3lJHWFvdC/o2hyttY+e2
        rnstMnZm+8bFSfEJIXSSvMV3xPcvaVR4xcKlH2/3+dAPy3dKVgbSMrnkH/B7UHotBQAA
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTfUxTZxTG9957e1vcmB34cYM4tYPFOC200nJAYDNbluuWDBNNwLnZdXCl
        OFpMC8aBbhQw48tREGUUcEBXUChgETsYCgSZjOkUEJQOUYcftcr4KogVhRXqMpP993vPc57n
        nLzJ4eBuJrYHJ1oRxygV0hgeuYi4ONsxuGHZdG6kb4PRA4pqDSR01VQhmJ4pxKHpwQABk/YB
        NmTM1hNgqFdjYDs1S4KtvYOER+cnEPTc6SMh36omoMh6iQ1zgxYMdKWPcXhw6jsERVdSCRhJ
        niHgnuYMDnOmVDak6GpJaOtoYcMx43IozE/BINeuQXC7zzHfLISRYk+wl1eyoaZWh0FywwkM
        TL0/ImjP0+IwmH2UgEuZcmi6OIXBmRvJJFiaD2OQPq0nIO9YMoKz5zoJuPpLEQk3DXMsGMsa
        IqG99g8CLl74jYCq6iQW6K93Y2BIP8mCfs09BEdG7iPQVbwN4y3boKe1BIPyxr8I6Fa3IqjK
        e86GJzMzLBjIzSeg43ArBnN3pljQnHYbg54njwhoMpaR74XS04e+J+hbw88J2nDcgOjCpG6C
        rj9pxugb+kZE56SMsOlG7SCbTm3+k02X1MXT15p20Kntf7Po0yfW0bqzVozO6O/B6brKdHLr
        2k/5QcrY+DhmtSxWFRfM2ykAIV8QAHyhXwBfsNH/80ChiOcTEhTJxETvY5Q+IV/wZTNZE2hv
        8+L9xsfFKAlVu2YgFw7F9aOumC+TGWgRx42rR9TN88PIKXhSxsk+lpPdqWfXMl40jSPqaetP
        Lx5nEGXNvI/NdxFcb8paPYbPM8ldT10ZvrHASxz18sbKBQPOnVhGWbM0xLzgzn2fOpdyd2GE
        K9efqswuw52p04j6tb8LdwpvUJ0FdxcMOHcf1ak2O/bjOHgFVTHLmUcXbgg1ZH/Vuelb1PVm
        Henkg5Tt+X2kQe7al4K0LwVp/wtyltdR/bNW7H/ld6jy0ke4k4OpmppRogSxK9ESJl4lj5Kr
        hHyVVK6KV0TxI2LldchxNKYL9voGdPLhOL8NYRzUhrwczqFTVV3Ig1DEKhjeEteVdbmRbq6R
        0q8TGGWsRBkfw6jakMjxizm4x9KIWMcFKuIkArGvSOAnDvAVBYg38pa7btmbJnXjRknjmK8Y
        Zi+j/NeHcVw8krBtipXfhLVMKCVX/aoyG9ZvX+0X2sKow7XeA22yUPHgVYm/aP/HG8NOvEuf
        vp1+QPy7KbqyEweFWviR6ZWYgt5E3eLgcUP5ls9eXyxcurmEvJPo+VrY0YrCPfny6uBd9MCb
        l1g5Xwaq7P7+1VGtOxL3EHWHeqsDu1m7fZIK1lpGp8K9zIkrHvJWnV5zNiVow5GQoVub0rL1
        xwNt3uG37nrv9Prw2VN326Ro50jBKqN+uGtTdExUzaTtZ02kZUyccKCw6BPZwYZG7zWlZZaH
        u8MvF1/enqAsP7ZMFfrgA0lEc41tuVZyQLY1peKHb+nQhAiLzMeWEzJaau0x62TnvFLFuzZn
        8giVTCpYhytV0n8AeVQNz8kEAAA=
X-CMS-MailID: 20230621131150eucas1p1c9668cfd8aebcd4005ffe3a20510bf14
X-Msg-Generator: CA
X-RootMTR: 20230621091037eucas1p188e11d8064526a5a0549217d5a419647
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621091037eucas1p188e11d8064526a5a0549217d5a419647
References: <20230621091000.424843-1-j.granados@samsung.com>
        <CGME20230621091037eucas1p188e11d8064526a5a0549217d5a419647@eucas1p1.samsung.com>
        <20230621091000.424843-9-j.granados@samsung.com>
        <36fae2b0-4cd2-58b5-cc12-9abdd5ce235b@kernel.org>
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

--iqp637iv5bkrldev
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 11:56:03AM +0200, Jiri Slaby wrote:
> On 21. 06. 23, 11:09, Joel Granados wrote:
> > In order to remove the end element from the ctl_table struct arrays, we
> > explicitly define the size when registering the targes. We add a size
> > argument to the register_sysctl_init call and pass an ARRAY_SIZE for all
> > the callers.
>=20
> Hi, I am missing here (or in 00/00) _why_ you are doing that. Is it by a
Not sure what happened. I used the kernels get_maintainers.pl script
together with git-send-email. These are my settings:

"
tocmd =3D"`pwd`/scripts/get_maintainer.pl --nogit --nogit-fallback --norole=
stats --m --nol --nor"
cccmd =3D"`pwd`/scripts/get_maintainer.pl --nogit --nogit-fallback --norole=
stats --l --r --nom"
"

Could it be that there is an error in MAINTAINERS?

> chance those saved 9k? I hope not.
Not by chance. It is an expected consequence of removing the empty sentinel
element from ctl_table arrays

Best
>=20
> thanks,
> --=20
> js
> suse labs
>=20

--=20

Joel Granados

--iqp637iv5bkrldev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmSS9xMACgkQupfNUreW
QU/SugwAjz9Nx/luD2X1jMmB/DLFYSelLyv19pjyd9G0GZhEpbjgMPAZSdozNRfh
SJiGP9v4VptCMgQA6clQZvFGtQZ7H2RWzwmXM5xilft5bLPFIOwb+tMctiP7iJ3h
DMaPmx8BBTPNE5NRtEYVqsF0sA9GqO6d7PgZMNBi/9PMlleQMKROdUeyRq3sDXMQ
098gOYeuVIRNTWnLfNiCju8zkthUVEGlMZ3jOVaOFDCGE5Ua42l0StHVu/8oB+WD
bVNpOUAFalLOyYSGJj0Jau58jKdiBwfxBhS4tJgFHzxWNPkfIZSu0YPfIJbEcdAC
mVT4X9lNxFnO2J1vCfIuch/GaTxYC6r3jY3ffaMdV/LtProQLo+Swb3/QOOSHj6p
Ut9ZznrnIvPjjny+MRuKC8eMoGPYmU163B/4AN8isdHtdMy2YRLCrnZW+CwmxDvI
dTLcQzvZnyo1pCjXQL5bwFdi3BVUdGD9V2gqDaFGj/eJj/U6G2zu5MGoRrJKO/Hi
b7C5kEHu
=2P4k
-----END PGP SIGNATURE-----

--iqp637iv5bkrldev--
