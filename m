Return-Path: <linux-fsdevel+bounces-38738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D50BA0772E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 14:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 846A5168E1B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 13:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E9B21882B;
	Thu,  9 Jan 2025 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVnzvjV1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81BD215F5F;
	Thu,  9 Jan 2025 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736428887; cv=none; b=fTl0DXKXNFgc3nL0TeDDQwYKaTUTDNCF2BKzPDcC331lRn6tFKw0B8z69oDUmJoOWJ3RH7ZjHVLM85eeM74hi+zrYUprNAdKuyw249uNDlKn4ChXJWYidIaLvvDxKNM4gTGqs0rwsJktHYPgapYeumk1U+eGAAco7PObaVitu6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736428887; c=relaxed/simple;
	bh=6d+LO0dPq7EhPfFup42LjHy3/gWDPCkOtjawOogUy3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fua43Kh6wYeXaIjX287teiv/R6eUnbQNg460DTLJtzjNpzTn36bYr0gOdkOJ7RWWrXuoO1amiH2u/BTICbynQSAq/74Mh9+H20zJ2KOvmGQHPQyaH0HqUdcon7chCnIQLO1yOMhyutgXTmFQdflRiCqYZK/gDQYEOAcRyV6iVh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVnzvjV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25AAC4CED2;
	Thu,  9 Jan 2025 13:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736428887;
	bh=6d+LO0dPq7EhPfFup42LjHy3/gWDPCkOtjawOogUy3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gVnzvjV1pM+3JKBgDFloKrmn1ptVAmfToOSLih9Sklu5psfrlrZtZi1rdzacNN6vz
	 kmVfYn8t9+Nw2VM5UellqXfuP1yfaR/avYHveYgMQei1JdkDJof5/FPc5NjYNSnhNl
	 JhakAcSp9nl+qx31u2HAN0cKtDza94XYyuloRGfkpLshqd0eZ7M7yzuXD6BadVgrc7
	 Vmgt5zrS+sntX7ZWbEXROhsOgmnU3NWllXyHZ09cfWnJ4nN/CEkvuFfDu0Ues13DvX
	 ir4kD6hmnpeZPwW+nSuzE0CfaYTgbP1Kys3RVfhZvaFXpnltA55Xq5NKg7S2Z5jda5
	 RF2Wlr46zLhzQ==
Date: Thu, 9 Jan 2025 14:21:28 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Hongbo Li <lihongbo22@huawei.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-man@vger.kernel.org
Subject: Re: [PATCH] statx.2: document STATX_DIO_READ_ALIGN
Message-ID: <mpmubgbnuk5vw34l6req2yctf5zdgbggq5k2zwyp2cksquuupe@gqkytiva43ca>
References: <20250109083109.1441561-1-hch@lst.de>
 <20250109083226.GA22264@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2fvkxjltk6wvfh43"
Content-Disposition: inline
In-Reply-To: <20250109083226.GA22264@lst.de>


--2fvkxjltk6wvfh43
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Hongbo Li <lihongbo22@huawei.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-man@vger.kernel.org
Subject: Re: [PATCH] statx.2: document STATX_DIO_READ_ALIGN
References: <20250109083109.1441561-1-hch@lst.de>
 <20250109083226.GA22264@lst.de>
MIME-Version: 1.0
In-Reply-To: <20250109083226.GA22264@lst.de>

Hi Christoph,

On Thu, Jan 09, 2025 at 09:32:26AM +0100, Christoph Hellwig wrote:
> Document the new STATX_DIO_READ_ALIGN flag and the new
> stx_dio_read_offset_align field guarded by it.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Thanks for the patch!  I've applied it.
<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/com=
mit/?h=3Dcontrib&id=3D3eb8ef31cb5295b5eaaaf319796ea6279b7f7002>

A few minor comments:

Please add the CCd people as Cc: in the commit message.  I'll do that
anyway, so it avoids me pasting them, and will probably make it easier
for you to send with git-send-email(1) (or whatever you use).

> Subject: Re: [PATCH] statx.2: document STATX_DIO_READ_ALIGN

I changed commit subjects to use the full path to the manual page.
Also please start with uppercase after the ':'.

Also, please use version numbers for patches (v2, v3, ...).

> ---
>  man/man2/statx.2 | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>=20
> diff --git a/man/man2/statx.2 b/man/man2/statx.2
> index c5b5a28ec2f1..7ad9c219a51d 100644
> --- a/man/man2/statx.2
> +++ b/man/man2/statx.2
> @@ -76,6 +76,9 @@ struct statx {
>      __u32 stx_atomic_write_unit_min;
>      __u32 stx_atomic_write_unit_max;
>      __u32 stx_atomic_write_segments_max;
> +

I didn't realize this needed a \&.  The CI reminded me.  I've amended
that.


Have a lovely day!
Alex

> +    /* File offset alignment for direct I/O reads */
> +    __u32   stx_dio_read_offset_align;
>  };
>  .EE
>  .in
> @@ -261,7 +264,7 @@ STATX_BTIME	Want stx_btime
>  STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTIME.
>  	It is deprecated and should not be used.
>  STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
> -STATX_DIOALIGN	Want stx_dio_mem_align and stx_dio_offset_align
> +STATX_DIOALIGN	Want stx_dio_mem_align and stx_dio_offset_align.
>  	(since Linux 6.1; support varies by filesystem)
>  STATX_MNT_ID_UNIQUE	Want unique stx_mnt_id (since Linux 6.8)
>  STATX_SUBVOL	Want stx_subvol
> @@ -270,6 +273,8 @@ STATX_WRITE_ATOMIC	Want stx_atomic_write_unit_min,
>  	stx_atomic_write_unit_max,
>  	and stx_atomic_write_segments_max.
>  	(since Linux 6.11; support varies by filesystem)
> +STATX_DIO_READ_ALIGN	Want stx_dio_read_offset_align.
> +	(since Linux 6.14; support varies by filesystem)
>  .TE
>  .in
>  .P
> @@ -467,6 +472,25 @@ This will only be nonzero if
>  .I stx_dio_mem_align
>  is nonzero, and vice versa.
>  .TP
> +.I stx_dio_read_offset_align
> +The alignment (in bytes) required for file offsets and I/O segment lengt=
hs for
> +direct I/O reads
> +.RB ( O_DIRECT )
> +on this file.
> +If zero, the limit in
> +.I stx_dio_offset_align
> +applies for reads as well.
> +If non-zero, this value must be smaller than or equal to
> +.I stx_dio_offset_align
> +which must be provided by the file system if requested by the applicatio=
n.
> +The memory alignment in
> +.I stx_dio_mem_align
> +is not affected by this value.
> +.IP
> +.B STATX_DIO_READ_ALIGN
> +.RI ( stx_dio_offset_align )
> +is supported by xfs on regular files since Linux 6.14.
> +.TP
>  .I stx_subvol
>  Subvolume number of the current file.
>  .IP
> --=20
> 2.45.2
>=20
>=20

--=20
<https://www.alejandro-colomar.es/>

--2fvkxjltk6wvfh43
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmd/zVgACgkQnowa+77/
2zKP/hAAiff/HOuiTtbwQXRuRtY7UOESjfLKrJM/e1SDpBYV+rtPOCoWIjU5PbAc
4F+HgRwKvylcgb6PLk1oEOZkm8Plway4Xkq3Tz9Vg96oClWwbto66x1oqd+2Xxtk
j+7dptOn+wnIlQdpB1HsrceadOIDXQOr8UINGwr2yhL7Cb0uyXOgShOPxbtCcYgp
kZr8wC/+AD2drL2eORlf5A4GWXicsDqAgGRqmFX7wiTYEhnLtNqkrfCNLArvGV8M
AmiIPzcgHraBIUWi8aiXxKYg2iqYoEHvo/vqSA+bFCba6PSVII77Fn9rYVhoaBnt
E1q9WctVJljV/z57CAp14NHsiedGIAa/kNpsKb1UpLizvIPiVpA0qJek5tyd4M/h
l5wGbUDp6kmhaq49Y0ZRe5hcgr4apV6HbsYcuyIwiD4VXnLguPM9U5waz0GtUk1l
bNH9Ddvg/dwdL211qELX0PzFQh9ILd9u/5OXjHjBG2DczETycvkhl5HRgnOVUgmB
5wrgUeSercTs7Zx/vu3twsZFIs4tjk34WexSYhMszzGfHb4eQ/LovSkzHZjn2H1f
YJ/YH2YY3JAanJk++yagnjdqZlJDO60bIsd/LLSo0GRr649liRyWs49yXdLjU7r2
5PuE4ri0PWePw47bu/8ZzR83E6xcBtJQmBTWyjIXI6J2h/BAUVo=
=52Ng
-----END PGP SIGNATURE-----

--2fvkxjltk6wvfh43--

