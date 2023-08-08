Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7F57753C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 09:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjHIHN1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 03:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjHIHNZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:13:25 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13421B6;
        Wed,  9 Aug 2023 00:13:24 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230809071321euoutp01daffd5f6a01edf39fc36d5af9cc9ab2d~5pZa-JLBS0907609076euoutp01F;
        Wed,  9 Aug 2023 07:13:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230809071321euoutp01daffd5f6a01edf39fc36d5af9cc9ab2d~5pZa-JLBS0907609076euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691565202;
        bh=V7AXA3XKbCTJdCLCEcFa9yONVo03/VAYcmjCmAIVm/0=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=PbTANdOUFchwh/zQnW95iisuOL+LirFf8CuGNyW/Oa7KXicswQbaSCFd0qWjoU5sm
         TwaZARytYxnAfU11yAZNn/ZXPrBy/vqVu84xMjebQSH0XOYXEuG/Zh0hyMdQcUrAaU
         jrG4mDGWwLdWv3/TIZjPL8jtNkNRvz2u9E9bbhkg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230809071321eucas1p14bd8234289c1ffc5ba343a02aac42e26~5pZauQs4l2464524645eucas1p10;
        Wed,  9 Aug 2023 07:13:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id DA.34.37758.19C33D46; Wed,  9
        Aug 2023 08:13:21 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230809071320eucas1p109d62cad1d2d37692305b4229f42ebe7~5pZZ_3Q6s2824028240eucas1p1p;
        Wed,  9 Aug 2023 07:13:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230809071320eusmtrp2ccf3d42b918a7af1410041dd3126c848~5pZZ77wIF1895118951eusmtrp2J;
        Wed,  9 Aug 2023 07:13:20 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-3b-64d33c91d398
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B2.74.14344.09C33D46; Wed,  9
        Aug 2023 08:13:20 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230809071320eusmtip1458e135fa6711b22ecfe89f8a3278e9c~5pZZkpiyW0118901189eusmtip1W;
        Wed,  9 Aug 2023 07:13:20 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 9 Aug 2023 08:13:19 +0100
Date:   Tue, 8 Aug 2023 15:58:47 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Chris Maness <christopher.maness@gmail.com>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Alexander Aring <alex.aring@gmail.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Florian Westphal <fw@strlen.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Iurii Zaikin <yzaikin@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jan Karcher <jaka@linux.ibm.com>,
        Joerg Reuter <jreuter@yaina.de>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Julian Anastasov <ja@ssi.bg>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Mat Martineau <martineau@kernel.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Roopa Prabhu <roopa@nvidia.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Simon Horman <horms@verge.net.au>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Will Deacon <will@kernel.org>, Xin Long <lucien.xin@gmail.com>,
        <bridge@lists.linux-foundation.org>, <coreteam@netfilter.org>,
        <josh@joshtriplett.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-hams@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-s390@vger.kernel.org>, <linux-sctp@vger.kernel.org>,
        <linux-wpan@vger.kernel.org>, <lvs-devel@vger.kernel.org>,
        <mptcp@lists.linux.dev>, <netdev@vger.kernel.org>,
        <netfilter-devel@vger.kernel.org>, <rds-devel@oss.oracle.com>,
        <willy@infradead.org>
Subject: Re: [PATCH v2 00/14] sysctl: Add a size argument to register
 functions in sysctl
Message-ID: <20230808135847.46ln434mbpiiklvz@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="x4zdqo2w6ogqmllb"
Content-Disposition: inline
In-Reply-To: <CANnsUMGRBnatKB4-3eYjb5aG7YnXDiZG6cjuwSgtjvVF6ErJNg@mail.gmail.com>
X-Originating-IP: [106.110.32.133]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA1VTa1CUZRTu/S67Cwh+ro6+A2iJUIkFYSonlQyHZr5opotljkpTG3yDEjdZ
        SUKYMBDivsgAsQIujazIbYHFNVAEV0G5tCACwQbNyM1yEdAFAR2ghQ+z/j3nnOd5znPemVdE
        ih8JrUVHA49zIYESfzuBOaVpnNW9mbb7rs9bJZM2UNHytwC0Ua5w72oCDYNzWgHcLvlDCOPK
        JARz5Woa5qrjSMhpi6GgrOY0AcONA0LQJBcjaJc/oeHy/WkBGPKKECQ+sIXoS1MIhlIHaOhU
        TghgQREEsykWkJ0QTUBrYgCMZ54loF2TQkPlYDcNV2ubKOi+3E/A3ZocAYxokymQ5UeTMKww
        0NCXrqRgQDVOQPS5xyQ8LbxFgy55gYTC1hECemTDCG7EXaOhVfWjEBoVa0FW1kzBk5ZRBFmj
        XSR0XLWH5skFAnRqIw3GnNfhnqyNgvTCKgKuxM8IQakqFcLg9H0BnGrVCCGmbzs8mzHlUFZ/
        9N5OtiSvBLFjuibE5pWcZM9G3aHYp7OObNXFXoKtlvcLWU29A6uoDGXVhY6s3uDGVhbFC9iG
        i6Wm8b13WNkv9YhVn//hkw2HzHf7cP5Hv+NCnN/92vzIYJYKBVetDauRK4gopBMnIDMRZrbh
        1Fo9mYDMRWKmEGFjbgfFF5MIT6flIL4wIhyXk0k/lyQ1DBL84ALC7Tmdgn9ZMwVDy2ZqhJPm
        G4hFCcXY47hn/UtyAfMGbhvtIxfxGsYZX5tULFmRTCODY9vGlgSrmcM4Pvq6YBFbMq54IXGO
        5PEq3JQ9ZEooMgnC8M+JJ3hogy/MixYZZsyneLjhNMEntcNTo8nLqSNxc5V+aRVmlCuwJitz
        yQYzHviM7Auesxo/uFUl5LEtXqg+t8xPR7hufkLIF8UIK09NLW/YhWM6h5YV7vhGbj3Nm1rh
        noerFtukCZ7RZJF82xL/FLv88K/i4j9HKRnaJP/PYfIXh8lfHMbDzVhV4/y/7qL7FqzMN5A8
        dsNlZeOUAgmL0DouVBrgy0nfDuROOEklAdLQQF8n76CASmT6iS3zt6Z+RYUPHjlpESFCWmRv
        Eg+UF7cjayowKJCzW2Pp9lmHj9jSR/J9OBcS9FVIqD8n1SIbEWW3znKLW5O3mPGVHOe+5bhg
        LuT5lBCZWUcRx/Y6lDcYjnnt6Puyd4+43OxEqhU3nbzKe2Jlb0dmONZVTI1VPMyNrFUH/5a5
        8oCfYfCD29sPlO8LqxpOL8gV90dQqa0rUm73/O5QYnReeK3I7PNI/QavYccNwbR7mkf+E2OX
        bX2/ffQxl9jmrZ6bTm7N0J83WHy4Ed38K2hnilVGsP2lGp07py4Ycbg81KMvjXhGWRt1Be97
        zpdmd1tktXo5ZNwsNvrX6TynbQhV3cN9EWWC8vURfmnCi/17PA7HHUzXUvmqXYa5V0Zw9myF
        eWNWx9b9fuLN4eac5ErswPrH+zMzKuUvfeNaqk+77tvVO793m0vEy16NOw7e0WsOtYjOf2xH
        SY9IXBzJEKnkHxEe0t0EBQAA
X-Brightmail-Tracker: H4sIAAAAAAAAA2VTa0xTZxj2O+f0nKJhKzf5gsJcRceAFQoUXhwYzZJ52IyZbj82kGgnJ+CE
        lrTAdIvKQIaUiyU4nMUg6uwKcpO6yqUQRUERBgwB5wAddxUmKKCAXFbolpns3/O9z+V98iUv
        n7TOZBz4+2UxnEImjRTSK6nGhVs976kD7oZ5Xteth8uNj2mojfeDXqOKB/3ztTTcLuxiYEyb
        hmC+VM+D+YpkEs60HKOguDKJgMH6PgYM6ZcQtGpe8ODq8EsaRnILEKQ+WQuJv0whGDjRx4N2
        7TgNi3lymMlYBadViQQ0pUbBWHYOAa2GDB6U9XfywFjdQEHn1R4C7laeoWGoNp0C9blEEgbz
        RnjQnaWloK9kjIDEs89JmNXd4kFz+iIJuqYhAn5XDyK4kVzDg6aSBAbq81aDuvgOBS8aRxGc
        Gu0goc3oDHcmFwlo1k/wYOKMC/SqWyjI0l0hoCplmgFtSRED/S+HafiuycDAsW4JvJo29dBW
        7NiyiS3MLUTs0+YGxOYWfsvmxP9GsbMzruyV/PsEW6HpYVjDtQ1sXlksq9e5sn+MBLJlBSk0
        W5dfZKJ7/Vn1+WuI1f909BOnYFGAQh4bw62LkCtjAoUhYvASif1B5OXjLxJ7+4Vu8pIIPTYH
        hHGR++M4hcfmvaKIpw3ZTHTZ6oM/qIxEPGqyViELPhb44LS6fkKFVvKtBRcRzrjdTJuJtfjy
        ZAfPjG3wXKeKNoueIXyv4gJjfugRbqlKZJZUlMAZJ7/qWXbQAnfcMtpNLmFbgQeumcxbXkEK
        6gXY+OfN5RU2ghCcknh9GVsK/PBi6jxpTr1A4vT8k8hMWOGG0wPUEiYFcbj35AOTiG/Ca/DP
        C/ylsYVgJx6sSyLMVYV4ajT9n9qH8cT8EFIjG81rSZrXkjT/JZnH7+C53Lb/j92w9twIacaB
        uLh4jMpDTAGy5WKVUeFRSi+RUhqljJWFi/bJo8qQ6R4M9TNXylH+k2eiWkTwUS1yNjn7Si+1
        IgdKJpdxQlvLwE/bwqwtw6SHvuEU8j2K2EhOWYskpm/MJB3s9slNxyWL2SP29ZSIfXz9PSX+
        vt5Ce8ug6ONSa0G4NIY7wHHRnOJfH8G3cIgnPq5+63a9quPLlodpG99Ylfquu26davbsxl/t
        Vgz7tvOTqg4/3mHV8Vl3yOSpap596faFwA+CP/rCYk25s2Lvpbou9fa/sjNyoGZFasStOLsP
        p0VHb2jGEx4Hy6YelG/Q7MZWoaHCcy6O24LGC3R9qlN+ioGLJ7YXF3onGHI4pVV4tvFr7fcO
        tDg5jZHfz6xh9duaQ3btdgpiUi3bjVvVvmHhVmMt9IXSmvAtFjk7KTeJ/shBx3LZwXu+gzbb
        LN92c0lIe3Rce9Hd0WO906O2H7/yH37/5pEU1/O2XRVzhucHtmoeZRU1xHUrJJWf7zaWt2H7
        5CehuDL3oV1b+q7hQ92Fb87UCyllhFTsSiqU0r8BZ8mLvKQEAAA=
X-CMS-MailID: 20230809071320eucas1p109d62cad1d2d37692305b4229f42ebe7
X-Msg-Generator: CA
X-RootMTR: 20230808025059eucas1p24caeb224edb8f4fce693364913a37841
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230808025059eucas1p24caeb224edb8f4fce693364913a37841
References: <20230731071728.3493794-1-j.granados@samsung.com>
        <ZMgpck0rjqHR74sl@bombadil.infradead.org>
        <ZNFlqwwvE6w6HyHl@bombadil.infradead.org>
        <CANnsUMG3WO_19GpnsNaXPqu6eEnpBvYUpkrf1QbHwsc9wEoCZQ@mail.gmail.com>
        <ZNGBrkP7J2g/BAWV@bombadil.infradead.org>
        <CGME20230808025059eucas1p24caeb224edb8f4fce693364913a37841@eucas1p2.samsung.com>
        <CANnsUMGRBnatKB4-3eYjb5aG7YnXDiZG6cjuwSgtjvVF6ErJNg@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--x4zdqo2w6ogqmllb
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Chris

My questions inline
On Mon, Aug 07, 2023 at 07:50:44PM -0700, Chris Maness wrote:
> I tried running the current mainline kernel (current Arch Linux) with
What kernel version are we talking about exactly here? Please notice the
base that I used in the cover letter (rc2 or rc3). They should also
rebase cleanly on top of v6.5-rc5.

I'm not sure what the patches will do if you apply them to an older
kernel.

> simple single MUX socket (ax0) using LinFBB.  I was a happy camper as
> it seemed to work fine at first, then the system just slowed to a
> crawl.  I am wondering if any of these patches are addressing this
> behavior.  No kernel panic like before, but not what I was hoping for.
So you have been experiencing kernel panics from before? What does
before mean? And can you bisect to pinpoint what commit fixed it?

> I have also tried sixpack, and that explodes instantly the last time I
> have checked.   That goes all the way back to the v4 kernels.  v2 is
> fine there.
You mean that 6pack is broken in all the major versions up until v2? If
this is the case, then it might be an issue that is not related to this
patchset.I see that Andreas Koensgen <ajk@comnets.uni-bremen.de> is the
maintainer of 6pack, maybe he can chime in on the issue?

>=20
> 73 de Chris KQ6UP
>=20
> On Mon, Aug 7, 2023 at 4:43=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.or=
g> wrote:
> >
> > On Mon, Aug 07, 2023 at 04:00:49PM -0700, Chris Maness wrote:
> > > When are these likely to hit the mainline release code?
> >
> > linux-next tomorrow. The first 7 patches are scheduled for mainline
> > as they were merged + tested without any hiccups. These last few patches
> > I'll wait and see. If nothing blows up on linux-next perhaps I'll
> > include them to Linux for mainline during the next merge window.
> >
> >   Luis
>=20
>=20
>=20
> --=20
> Thanks,
> Chris Maness

--=20

Joel Granados

--x4zdqo2w6ogqmllb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmTSShUACgkQupfNUreW
QU9V5Qv9EPEpi2TR8AnLqIPU7OhWjIi17BiRDGt3v4ld7gPtc9IDscWkSVOlkMHp
CJsDbzP6uifAXxWYA/eqroOI7XNJn4YT96BVArmjzPBNAtMyqIyKQtqWvtlmLxnQ
1XsF8kk8rkIguKbfvLeU26KBKXpy4ET8XODODPl1jVqo+/ztgRB85ZujCqeqwLah
Qk249z8JImXEI4zYMoh7TPqKNSWFCkWoyRsVc+nlDPoPvl82b0pDATR5N5j4uU9+
QB1sNVZkgWXqu7Z+Pfmy7UgtSd5AO9juaaCpVdROh6FXtrP1xxnIS4qdL71H4n57
hpLxWSjLlm4S24sfl46pbCAfGU5iWM1QSe0nMquMfG+SR0uLyuDs3FvHsEeXzATE
KzjhrFGiEXkBUtJW4L/rKGMa2vJBs6TWEuA9tlWvJF7U6E6WapKJNI8TrZjt1DlX
TeV+PipASlYIhVb2o+ZRbbSJIVkr88vGBEBlsn8LOODSL/BACgWfhvrwmVDFqf8m
LXyRMUq6
=mpca
-----END PGP SIGNATURE-----

--x4zdqo2w6ogqmllb--
