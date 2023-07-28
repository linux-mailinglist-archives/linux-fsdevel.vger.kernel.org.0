Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E221767183
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 18:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjG1QIf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 12:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjG1QId (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:08:33 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2271D3C31;
        Fri, 28 Jul 2023 09:08:29 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230728160825euoutp012bf6120b3190b9499b604d40586dede1~2E9K74EOX2341623416euoutp01R;
        Fri, 28 Jul 2023 16:08:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230728160825euoutp012bf6120b3190b9499b604d40586dede1~2E9K74EOX2341623416euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690560505;
        bh=IfYerOX8MhzeuNNwVLAHXLKPDo/w1koh4w2hwJ18k1Q=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=psn1YHiAQcHT3KpVjHbfw8ck8NfIagUS30Zg+LjuMVJXWHZPq9Yw+dxm3wKR9PyMf
         gPiQMfTdAdPqDlgJEeizSl58UHPsbUlZJ6oztB2VepJN07/nULHQ9iNR26O9oPit4O
         v85CBrSNjoa9rkVj6XWZIG+YH+JMfLZu7yYSwV/c=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230728160825eucas1p1ea1f509e71760121da5da2591639efac~2E9Kiolnf2840228402eucas1p12;
        Fri, 28 Jul 2023 16:08:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 72.9C.42423.9F7E3C46; Fri, 28
        Jul 2023 17:08:25 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230728160825eucas1p226b0f61470b979c7dd8bfd7c6f0fb61c~2E9KEp1LC1959919599eucas1p2I;
        Fri, 28 Jul 2023 16:08:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230728160825eusmtrp2a41bdd346d41dcca92c6481d223cc3f3~2E9KD7R2P0698806988eusmtrp2k;
        Fri, 28 Jul 2023 16:08:25 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-6c-64c3e7f9bbe1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B5.4D.10549.8F7E3C46; Fri, 28
        Jul 2023 17:08:24 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230728160824eusmtip1caf52e300c95c38610a5d4f537da89a9~2E9J2_9GK3013030130eusmtip1c;
        Fri, 28 Jul 2023 16:08:24 +0000 (GMT)
Received: from localhost (106.210.248.223) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 28 Jul 2023 17:08:23 +0100
Date:   Fri, 28 Jul 2023 18:08:22 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Simon Horman <horms@kernel.org>
CC:     <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <willy@infradead.org>,
        <josh@joshtriplett.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 05/14] sysctl: Add a size arg to __register_sysctl_table
Message-ID: <20230728160822.4dh3asnao2l4bdwx@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="7ni6yiinrfnn3syj"
Content-Disposition: inline
In-Reply-To: <ZMOdqvMfyPkNYBoq@kernel.org>
X-Originating-IP: [106.210.248.223]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsWy7djPc7o/nx9OMbi/VMpizvkWFounxx6x
        WzzqP8Fm8X9BvsWZ7lyLC9v6WC327D3JYnF51xw2ixsTnjJaHFsgZvHt9BtGi98/gELLdvo5
        8HrMbrjI4rFl5U0mjwWbSj02r9DyuPXa1mPTqk42j/f7rrJ5fN4kF8ARxWWTkpqTWZZapG+X
        wJUx48BGpoLjkhVvts9mamDcKNrFyMkhIWAiMWXSJ/YuRi4OIYEVjBL3fqxihnC+MEq86roL
        lfnMKPHm+De2LkYOsJbry6sg4ssZJSa9fotQNLvhFROEs5VRYs7XySwgS1gEVCV+vuhgBLHZ
        BHQkzr+5wwxiiwgoS5yd2wLWwCzQxCzxaP5WdpCEsICPxOzfl5lAbF4Bc4mWe7vYIGxBiZMz
        n4ANZRaokNi/dBU7yEnMAtISy/9xgIQ5BbQk5k+dwgrxnLLEwSW/2SHsWolTW26B7ZIQuMQp
        Mf9dN1TCReLmvTdQDcISr45vgYrLSPzfOR+qYTKjxP5/H9ghnNWMEssavzJBVFlLtFx5AtXh
        KHH53TVGSCDxSdx4KwhxKJ/EpG3TmSHCvBIdbUIQ1WoSq++9YZnAqDwLyWuzkLw2C+E1iLCO
        xILdn9gwhLUlli18zQxh20qsW/eeZQEj+ypG8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzA
        1Hj63/FPOxjnvvqod4iRiYPxEKMKUPOjDasvMEqx5OXnpSqJ8J4KOJQixJuSWFmVWpQfX1Sa
        k1p8iFGag0VJnFfb9mSykEB6YklqdmpqQWoRTJaJg1OqgYmthrtiu9Yn02X5Z+03LzzyMiSs
        YJvxwYrS4lWcGinXPsR5b9y0hsP31Olo41z7xsmHNi2QbrDSvj2TXb3w2J2YtffW5Z680DnP
        zGep33NW3TmPt0tFrz+upbPRfp7LhBm2Wlr/n3xW/BWbuu3628def+vn9ZpP6PX6v85otde2
        i8InDzBsC9wltZZ/4d9H7442/Gz7d9cj32LC/vOcohwMRvd9Z88qiD1ilW60IFjk59FD+w29
        vvip/1vJm89000n9heyPDRwdKosnz+c/MXfRhTuzL7y3deM7yBuaJFHhJTuJtVxCZkn4Bu2q
        Lyqff4hqT9+sdFT+YS27sUr9x7173Mz6o5o33+B+szGOz+WzEktxRqKhFnNRcSIA9uDFgQgE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42I5/e/4Xd0fzw+nGLw5amYx53wLi8XTY4/Y
        LR71n2Cz+L8g3+JMd67FhW19rBZ79p5ksbi8aw6bxY0JTxktji0Qs/h2+g2jxe8fQKFlO/0c
        eD1mN1xk8diy8iaTx4JNpR6bV2h53Hpt67FpVSebx/t9V9k8Pm+SC+CI0rMpyi8tSVXIyC8u
        sVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mt4N+U8e8FRyYqeWQ/ZGhjX
        i3YxcnBICJhIXF9e1cXIxSEksJRR4sDVgyxdjJxAcRmJjV+uskLYwhJ/rnWxQRR9ZJRovjiB
        CcLZyiixfcsSZpAqFgFViZ8vOhhBbDYBHYnzb+6AxUUElCXOzm0Ba2AWaGKWeDR/KztIQljA
        R2L278tMIDavgLlEy71dUCueMkos3N/BCpEQlDg58wkLyK3MAmUSnS9jIUxpieX/OEAqOAW0
        JOZPnQJ1qbLEwSW/2SHsWonPf58xTmAUnoVk0CyEQbMQBoFUMAMNuvHvJROGsLbEsoWvmSFs
        W4l1696zLGBkX8UoklpanJueW2yoV5yYW1yal66XnJ+7iRGYGrYd+7l5B+O8Vx/1DjEycTAe
        YlQB6ny0YfUFRimWvPy8VCUR3lMBh1KEeFMSK6tSi/Lji0pzUosPMZoCA3Eis5Rocj4waeWV
        xBuaGZgamphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTCt5l622vTUj4f3p4Rf
        L69hXXaGpaXO5HzCvbULn1WqiFZtTdRI/vSnxm2nydl3xmbLpq0wX7yet4ZlQk/p+88aF6Iu
        yDAzJP79E8Gfq2A8M///2dYd9tZB7+MUPjmW1ZvLquz/cOJBdLk2y4qe7dNn6c+843BfwLT5
        1Y3Z/O95d7LtbLzTGBEyv7JbqD32vl+O/aEVy3LXR10JFLR7/9RQuFrv3saUrMbNUiu+vp58
        i8HY6/zyVv6777Rm7LzwUNHf33Df8R9z3XdLdaVe7lw9ceuEJhdbnsptvoz7YwsSj9aE9CyS
        yXlg7ivHW1LMUv5rofQzYd9zxgtOhRxYPeVS7L7cpl0fus/rv9C33ZamxFKckWioxVxUnAgA
        JbiPsKIDAAA=
X-CMS-MailID: 20230728160825eucas1p226b0f61470b979c7dd8bfd7c6f0fb61c
X-Msg-Generator: CA
X-RootMTR: 20230726140656eucas1p26cd9da21663d25b51dda75258aaa3b55
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230726140656eucas1p26cd9da21663d25b51dda75258aaa3b55
References: <20230726140635.2059334-1-j.granados@samsung.com>
        <CGME20230726140656eucas1p26cd9da21663d25b51dda75258aaa3b55@eucas1p2.samsung.com>
        <20230726140635.2059334-6-j.granados@samsung.com>
        <ZMOdqvMfyPkNYBoq@kernel.org>
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

--7ni6yiinrfnn3syj
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 12:51:22PM +0200, Simon Horman wrote:
> On Wed, Jul 26, 2023 at 04:06:25PM +0200, Joel Granados wrote:
> > This is part of the effort to remove the sentinel element in the
> > ctl_table arrays. We add a table_size argument to
> > __register_sysctl_table and adjust callers, all of which pass ctl_table
> > pointers and need an explicit call to ARRAY_SIZE.
> >=20
> > The new table_size argument does not yet have any effect in the
> > init_header call which is still dependent on the sentinel's presence.
> > table_size *does* however drive the `kzalloc` allocation in
> > __register_sysctl_table with no adverse effects as the allocated memory
> > is either one element greater than the calculated ctl_table array (for
> > the calls in ipc_sysctl.c, mq_sysctl.c and ucount.c) or the exact size
> > of the calculated ctl_table array (for the call from sysctl_net.c and
> > register_sysctl). This approach will allows us to "just" remove the
> > sentinel without further changes to __register_sysctl_table as
> > table_size will represent the exact size for all the callers at that
> > point.
> >=20
> > Temporarily implement a size calculation in register_net_sysctl, which
> > is an indirection call for all the network register calls.
> >=20
> > Signed-off-by: Joel Granados <j.granados@samsung.com>
> > ---
> >  fs/proc/proc_sysctl.c  | 22 +++++++++++-----------
> >  include/linux/sysctl.h |  2 +-
> >  ipc/ipc_sysctl.c       |  4 +++-
> >  ipc/mq_sysctl.c        |  4 +++-
> >  kernel/ucount.c        |  3 ++-
> >  net/sysctl_net.c       |  8 +++++++-
> >  6 files changed, 27 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> > index fa1438f1a355..8d04f01a89c1 100644
> > --- a/fs/proc/proc_sysctl.c
> > +++ b/fs/proc/proc_sysctl.c
> > @@ -1354,27 +1354,20 @@ static struct ctl_dir *sysctl_mkdir_p(struct ct=
l_dir *dir, const char *path)
> >   */
> >  struct ctl_table_header *__register_sysctl_table(
> >  	struct ctl_table_set *set,
> > -	const char *path, struct ctl_table *table)
> > +	const char *path, struct ctl_table *table, size_t table_size)
>=20
> Hi Joel,
>=20
> Please consider adding table_size to the kernel doc for this function.
Good catch. Will do for V2.
>=20
> ...

--=20

Joel Granados

--7ni6yiinrfnn3syj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmTD5/UACgkQupfNUreW
QU9yVgv9FI6vEoP7ICCbc5xmO32SsGcIFVIFRjwlStRGZfznmH4DaIVLUvsVajtg
gMqLu/YrmLsfl7iz5QgfiYPDMfvUyG6AsC9/XGAjdXaKjC8VT3O23CvJji8fxTQU
QgxsNakRW3zpxygah1h3adb/S51n4yGl+eElZsmusDXMNIzCH190fTh6ycyU7z+Y
Abr4KDJAGm9tNKZNoNyMnJfqrzbfAEQtOTvFn12CgthunKuIYPCbl82yrSoroe08
skv+dnNSy8hFS6pVSd3EN/EiDfQeJgkFQOIfQLmh/TDjKRhMjIQ8qI4ngVdityay
QdCRCOfIphwVjSgFP/9sBKUyb3zAccJrW/se5PPoj9aLG+9Kx5zgjyQ0yj2jlAg3
8BMRy69ViAIsc1kgxXxhkYvn2mFYYkRkrN+p2xuWk72Ipbi9rJpl5eVOmEPMaSLL
ijchIfcEGPOMzcXbGquuZRrmL0Yj9DEKjSpwLigL90aFG//0w4xBomEUo6GS2S/6
BJfVnki5
=L0jG
-----END PGP SIGNATURE-----

--7ni6yiinrfnn3syj--
