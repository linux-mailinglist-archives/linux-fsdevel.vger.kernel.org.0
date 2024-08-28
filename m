Return-Path: <linux-fsdevel+bounces-27542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 080A69624FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 12:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8A91F24B83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 10:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9000E16BE37;
	Wed, 28 Aug 2024 10:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkDzbRiK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C580C1465AC;
	Wed, 28 Aug 2024 10:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724841174; cv=none; b=jmAZZWdT5CxJYqTveduBzXX9ocV6piobDPFsYFG0YTrBlGDaETKMUKjSvEaMPriiGOe0PLppV0nRmHmYFSTn4mawYM9dcHS5koR4coP8T365czhqnx9bmzjmFJfbRy+3G5bjD2PCikIVcu0NsubeWQyWgrbUB0UEfNFvux/GA+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724841174; c=relaxed/simple;
	bh=RAZiyHV0BW9WjoN1ECXpyLaENcTOjscCNA3CQ8WtSxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErEYOQUrfs3aK8H/N1fJ8pHUyI5pmRlvH2ZoAiizZGmM2W6+raoQWKKw+1IPijUKGiD1cQGaVjjEk6zlfZXhU2qcVop2DRxiT7w7akPmE+H1FrbgM9nAbHz/AxM0vkxe8aqRq3g9VjIt0obigmV9oAuZIrLVid/axf8d9Ca50Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkDzbRiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D188C98EC2;
	Wed, 28 Aug 2024 10:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724841173;
	bh=RAZiyHV0BW9WjoN1ECXpyLaENcTOjscCNA3CQ8WtSxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rkDzbRiKRlpXFmTZretmNOGGQgiy5srKWiQ0PRA0Tk0OZDkahXPqUd4Z9CUuUNqBo
	 nYGxEXH3rwTgaamSsdtMI/ul4SgdEA45Mv5vcQ1jvnYqV8l67eUuZvJUhL0+SpOZLc
	 CtR3OVviUoN03RcnZCIWKOV5FaDXwjOJQL/YcDD8pcTl4aTGvITIxAaQnIJVjL/dxH
	 TEfdTsqMfwOnr6d/uYlOW+ygSijg0UhHigPd3keM8m3YwMUpZU+wsk3kDRnsPInXGr
	 luK/ARDKw3REReStXJIPprYvfeemOfSSHFZLRQB2gkKHeej8wuLr70XMYRGbXclw6c
	 riP3Ob2CZ89tw==
Date: Wed, 28 Aug 2024 12:32:47 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, 
	justinstitt@google.com, ebiederm@xmission.com, alexei.starovoitov@gmail.com, 
	rostedt@goodmis.org, catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Simon Horman <horms@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v8 6/8] mm/util: Deduplicate code in
 {kstrdup,kstrndup,kmemdup_nul}
Message-ID: <byi4tx6l2lrbs5w6oxypr44ldntlh4kp56vnsza3iuztwb37oa@2qtdx2kgz4bq>
References: <20240828030321.20688-1-laoar.shao@gmail.com>
 <20240828030321.20688-7-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fvf522dvf7ucivwn"
Content-Disposition: inline
In-Reply-To: <20240828030321.20688-7-laoar.shao@gmail.com>


--fvf522dvf7ucivwn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, 
	justinstitt@google.com, ebiederm@xmission.com, alexei.starovoitov@gmail.com, 
	rostedt@goodmis.org, catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Simon Horman <horms@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v8 6/8] mm/util: Deduplicate code in
 {kstrdup,kstrndup,kmemdup_nul}
References: <20240828030321.20688-1-laoar.shao@gmail.com>
 <20240828030321.20688-7-laoar.shao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20240828030321.20688-7-laoar.shao@gmail.com>

On Wed, Aug 28, 2024 at 11:03:19AM GMT, Yafang Shao wrote:
> These three functions follow the same pattern. To deduplicate the code,
> let's introduce a common helper __kmemdup_nul().
>=20
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Alejandro Colomar <alx@kernel.org>
> ---

Reviewed-by: Alejandro Colomar <alx@kernel.org>

Cheers,
Alex

>  mm/util.c | 68 ++++++++++++++++++++++---------------------------------
>  1 file changed, 27 insertions(+), 41 deletions(-)
>=20
> diff --git a/mm/util.c b/mm/util.c
> index 9a77a347c385..42714fe13e24 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -45,33 +45,41 @@ void kfree_const(const void *x)
>  EXPORT_SYMBOL(kfree_const);
> =20
>  /**
> - * kstrdup - allocate space for and copy an existing string
> - * @s: the string to duplicate
> + * __kmemdup_nul - Create a NUL-terminated string from @s, which might b=
e unterminated.
> + * @s: The data to copy
> + * @len: The size of the data, not including the NUL terminator
>   * @gfp: the GFP mask used in the kmalloc() call when allocating memory
>   *
> - * Return: newly allocated copy of @s or %NULL in case of error
> + * Return: newly allocated copy of @s with NUL-termination or %NULL in
> + * case of error
>   */
> -noinline
> -char *kstrdup(const char *s, gfp_t gfp)
> +static __always_inline char *__kmemdup_nul(const char *s, size_t len, gf=
p_t gfp)
>  {
> -	size_t len;
>  	char *buf;
> =20
> -	if (!s)
> +	/* '+1' for the NUL terminator */
> +	buf =3D kmalloc_track_caller(len + 1, gfp);
> +	if (!buf)
>  		return NULL;
> =20
> -	len =3D strlen(s) + 1;
> -	buf =3D kmalloc_track_caller(len, gfp);
> -	if (buf) {
> -		memcpy(buf, s, len);
> -		/* During memcpy(), the string might be updated to a new value,
> -		 * which could be longer than the string when strlen() is
> -		 * called. Therefore, we need to add a NUL termimator.
> -		 */
> -		buf[len - 1] =3D '\0';
> -	}
> +	memcpy(buf, s, len);
> +	/* Ensure the buf is always NUL-terminated, regardless of @s. */
> +	buf[len] =3D '\0';
>  	return buf;
>  }
> +
> +/**
> + * kstrdup - allocate space for and copy an existing string
> + * @s: the string to duplicate
> + * @gfp: the GFP mask used in the kmalloc() call when allocating memory
> + *
> + * Return: newly allocated copy of @s or %NULL in case of error
> + */
> +noinline
> +char *kstrdup(const char *s, gfp_t gfp)
> +{
> +	return s ? __kmemdup_nul(s, strlen(s), gfp) : NULL;
> +}
>  EXPORT_SYMBOL(kstrdup);
> =20
>  /**
> @@ -106,19 +114,7 @@ EXPORT_SYMBOL(kstrdup_const);
>   */
>  char *kstrndup(const char *s, size_t max, gfp_t gfp)
>  {
> -	size_t len;
> -	char *buf;
> -
> -	if (!s)
> -		return NULL;
> -
> -	len =3D strnlen(s, max);
> -	buf =3D kmalloc_track_caller(len+1, gfp);
> -	if (buf) {
> -		memcpy(buf, s, len);
> -		buf[len] =3D '\0';
> -	}
> -	return buf;
> +	return s ? __kmemdup_nul(s, strnlen(s, max), gfp) : NULL;
>  }
>  EXPORT_SYMBOL(kstrndup);
> =20
> @@ -192,17 +188,7 @@ EXPORT_SYMBOL(kvmemdup);
>   */
>  char *kmemdup_nul(const char *s, size_t len, gfp_t gfp)
>  {
> -	char *buf;
> -
> -	if (!s)
> -		return NULL;
> -
> -	buf =3D kmalloc_track_caller(len + 1, gfp);
> -	if (buf) {
> -		memcpy(buf, s, len);
> -		buf[len] =3D '\0';
> -	}
> -	return buf;
> +	return s ? __kmemdup_nul(s, len, gfp) : NULL;
>  }
>  EXPORT_SYMBOL(kmemdup_nul);
> =20
> --=20
> 2.43.5
>=20

--=20
<https://www.alejandro-colomar.es/>

--fvf522dvf7ucivwn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmbO/MkACgkQnowa+77/
2zJ0rg/6A9w0pR/IBhWTYnFTKH8DiRQVQuPVpRuWDuTYTqrMqUR2OEtQ2gWcf10h
TYl0N0mXcVo4vsCvdthueqs1ipa1bvOY3QN5aKpL5qXRq81NBe4JWd7ym/T8TU9Z
EP6iBPimsQMYTPMNwgCK768HYPfu9lygO8CecifrGLoSZ5EDZ2GnyDz2xzCMZIq6
+KKTKJqyhww4ydIgm49fMi1bk59rI45fjg0GpVepcATmdR6bbPiE8yvdazxOJCT1
t6dAVGehLzNV1hGgDqiG8QS0GuqM1YMwEy6pWoi6zoHUjT8326bOP0UXuzB1NAxd
M93w62xDoKpceGkLS22ajjH+0H7qgBtWyXBpd6QUVoqQ0lBWpnS7FfqMh9wJmd5L
55IaQKIPcaWDSBImqC/Mm2NYgH0DgcuF+JN/xaR6bhx+92rpzhE4/HM7Fll9OmuF
NVDkfuQIuuuZ74Be1QOYCa4h+jeB6sksNlF18wmhH8OipYCzRVEjROxUSd4SSb2m
bWd1Wpkx65jf1musgB9Q3oGofNPQvx9xnKYKk97o0n+UXyi7B7abukTl4oXKWbmB
WisDpchUmGJAOm0uncet+rsM5Vod5zXbdf0aRXz5WPYAE1CDauPDzi9z2qKrYdHc
gzn7xNZqVSRW8SsYctxEgro1zc1c8XxsHFiWJCQdjtwh9fOA1zU=
=+sNM
-----END PGP SIGNATURE-----

--fvf522dvf7ucivwn--

