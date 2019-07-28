Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2EA978280
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2019 01:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfG1Xv1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Jul 2019 19:51:27 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59525 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbfG1Xv0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Jul 2019 19:51:26 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45xfjQ2Q0wz9sBt;
        Mon, 29 Jul 2019 09:51:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564357883;
        bh=+Sm3w908JcE82ssAs1nSzuDW2v9mYsOQgWyC71ct+r4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LUBMGnGhZiyd6A2n9SjLJbgB1fX/qq4quPY2rR4fx4UmSVL1hnCt2zwGGwF1vmeCY
         IIpWjYeDbHhu4LjuA2lXj32tosi0nKjOQOQYvBZk+mHFcLDWe1S+H1MCo8U8F8PnbT
         yPPrQW5jkM8pM6Xn5d4nDh4KkpRRL1c2rViyharlscFJF47Ftytd2S1VdaU/FjgzUh
         NRhCPjtu9+cfX/+XW8X12/JlWrmBRUZtfj+m/op4PeC1ycKzwK9u0qbsLKnJfp/4mm
         D1OfW6lxvooS3/QAIt4AZiaq9Kensk+7vVygKTDuccbp1TGTxtdVgyY0SbcLRdsz/q
         XhHyx1knsyguA==
Date:   Mon, 29 Jul 2019 09:51:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org
Subject: Re: mmotm 2019-07-24-21-39 uploaded (mm/memcontrol)
Message-ID: <20190729095121.080c1a93@canb.auug.org.au>
In-Reply-To: <20190727101608.GA1740@chrisdown.name>
References: <20190725044010.4tE0dhrji%akpm@linux-foundation.org>
        <4831a203-8853-27d7-1996-280d34ea824f@infradead.org>
        <20190725163959.3d759a7f37ba40bb7f75244e@linux-foundation.org>
        <20190727034205.GA10843@archlinux-threadripper>
        <20190726211952.757a63db5271d516faa7eaac@linux-foundation.org>
        <20190727101608.GA1740@chrisdown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zy3Q_OmUUHqfTfaZG9i6x+B";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/zy3Q_OmUUHqfTfaZG9i6x+B
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Sat, 27 Jul 2019 11:16:08 +0100 Chris Down <chris@chrisdown.name> wrote:
>
> u64 division: truly the gift that keeps on giving. Thanks Andrew for foll=
owing=20
> up on these.
>=20
> Andrew Morton writes:
> >Ah.
> >
> >It's rather unclear why that u64 cast is there anyway.  We're dealing
> >with ulongs all over this code.  The below will suffice. =20
>=20
> This place in particular uses u64 to make sure we don't overflow when lef=
t=20
> shifting, since the numbers can get pretty big (and that's somewhat neede=
d due=20
> to the need for high precision when calculating the penalty jiffies). It'=
s ok=20
> if the output after division is an unsigned long, just the intermediate s=
teps=20
> need to have enough precision.
>=20
> >Chris, please take a look?
> >
> >--- a/mm/memcontrol.c~mm-throttle-allocators-when-failing-reclaim-over-m=
emoryhigh-fix-fix-fix
> >+++ a/mm/memcontrol.c
> >@@ -2415,7 +2415,7 @@ void mem_cgroup_handle_over_high(void)
> > 	clamped_high =3D max(high, 1UL);
> >
> > 	overage =3D (u64)(usage - high) << MEMCG_DELAY_PRECISION_SHIFT;
> >-	do_div(overage, clamped_high);
> >+	overage /=3D clamped_high; =20
>=20
> I think this isn't going to work because left shifting by=20
> MEMCG_DELAY_PRECISION_SHIFT can make the number bigger than ULONG_MAX, wh=
ich=20
> may cause wraparound -- we need to retain the u64 until we divide.
>=20
> Maybe div_u64 will satisfy both ARM and i386? ie.
>=20
> diff --git mm/memcontrol.c mm/memcontrol.c
> index 5c7b9facb0eb..e12a47e96154 100644
> --- mm/memcontrol.c
> +++ mm/memcontrol.c
> @@ -2419,8 +2419,8 @@ void mem_cgroup_handle_over_high(void)
>          */
>         clamped_high =3D max(high, 1UL);
> =20
> -       overage =3D (u64)(usage - high) << MEMCG_DELAY_PRECISION_SHIFT;
> -       do_div(overage, clamped_high);
> +       overage =3D div_u64((u64)(usage - high) << MEMCG_DELAY_PRECISION_=
SHIFT,
> +                         clamped_high);
> =20
>         penalty_jiffies =3D ((u64)overage * overage * HZ)
>                 >> (MEMCG_DELAY_PRECISION_SHIFT + MEMCG_DELAY_SCALING_SHI=
FT); =20

I have applied this to the akpm-current tree in linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/zy3Q_OmUUHqfTfaZG9i6x+B
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0+NPkACgkQAVBC80lX
0GwSggf/R3ZZuH5LliVhgCqbaBSFe93KVSxKonReOK3mTFha+qmnk8vOnjMxHn6E
LnMnA3mI7jJZw/uHTSE/ccUfWIGgJ/nWKU8M2iCuVQwChcocbVaf6TTViNwSZRAy
0hgehpDyAN/LuS8hPxNHre02xDtx4faKRkUUPLUuFC6wXycQ6UoLFoccYNQWKbuB
Xdm5vGFxSwgNkwi/wGWZnkikoBMIOseFvqDP7SevW2NAQdST9LIoXY2t5RXTcNDh
O6E3TpOOXH+GP00uphn+21GLF4AGZLgajZrTdv2v/pkzSfW1qI/hdfkuHb1bOCnx
SFymgmdpe6PfoqnBr01hSGHc22TskQ==
=DFTr
-----END PGP SIGNATURE-----

--Sig_/zy3Q_OmUUHqfTfaZG9i6x+B--
