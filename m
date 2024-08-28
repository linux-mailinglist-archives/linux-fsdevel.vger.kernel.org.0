Return-Path: <linux-fsdevel+bounces-27591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3909629E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 16:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23210286736
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 14:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD2F18A6B4;
	Wed, 28 Aug 2024 14:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrGd79/b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9746168489;
	Wed, 28 Aug 2024 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854257; cv=none; b=AjjwJENaHKnLSm698l7VIPb4Epo4iaYWh6IpD5U4uCLg5b59R4G6+zs7Uy8ifT5SU8OyU2TqHyWby8Fg10cJXkGzGtUWy6ztg3dUSB//mWP5EbOjL0sl1UZA5HhTfGlFO6O3Xf2AyswwdMbOir7WwL7hWiG8Unp0SD31VBjyBdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854257; c=relaxed/simple;
	bh=qp4XkaS0PrbdLwrhGw+MAEDZjVMGB9Unfk/C47vHb70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/UoDRrnuqkCC0J8YhqM7igEVMqZTVDSi+FWYsYoqoCRwSk6l0lBWLT5H8Ac4HvcNADxKhoH32G0MG1iLqBwHynT3/vgAAdzvlkITChc6zbwsLqavcAzRArB0ffS9BoiJoqaVdUYsw6TgtEMtYUArfNADdOJGhmTqY4NcZCFqZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrGd79/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1587FC58190;
	Wed, 28 Aug 2024 14:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724854256;
	bh=qp4XkaS0PrbdLwrhGw+MAEDZjVMGB9Unfk/C47vHb70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NrGd79/bkxy5uNQSg/aQYVCZzUtcQChkqi1vHEE8JgYEoneD4TVnVrA1U7uCyOu2P
	 pc4jhnotRJpVsL81E5tXJPcCEgMj9RXQkul0ZZ9KDmng9yDoTCIFM3N1mg/mFvBl+q
	 pPA9Aqo/x1Hi0n02i143QiN7a7ZonIkfp0w1wH1rqSzGhfEhNlOQwqP+9Jsk8htbdA
	 On0mqHZtaVndCmx7CgTwOUvNp7/5tqCwJhPtO+fjMwkA8elE4/u2nkJXf6keavdJY9
	 zZBHjrCKs8/25LXBlgtf6MsU7IvAviSPZoTamroPsID1x8qWzjRcU88z2D0pRjvMbx
	 7MGTLq6mfNUvA==
Date: Wed, 28 Aug 2024 16:10:49 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, 
	justinstitt@google.com, ebiederm@xmission.com, alexei.starovoitov@gmail.com, 
	rostedt@goodmis.org, catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>, 
	Matus Jokay <matus.jokay@stuba.sk>, "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v8 1/8] Get rid of __get_task_comm()
Message-ID: <hxwogrharokumnbphayi22qnl4yxeqxkxdddjkshso3nztroq5@lb3wbcsp3vhf>
References: <20240828030321.20688-1-laoar.shao@gmail.com>
 <20240828030321.20688-2-laoar.shao@gmail.com>
 <lql4y2nvs3ewadszhmv4m6fnqja4ff4ymuurpidlwvgf4twvru@esnh37a2jxbd>
 <n2fxqs3tekvljezaqpfnwhsmjymch4vb47y744zwmy7urf3flv@zvjtepkem4l7>
 <CALOAHbBAYHjDnKBVw63B8JBFc6U-2RNUX9L=ryA2Gbz7nnJfsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="egnngjetwmt4ba2t"
Content-Disposition: inline
In-Reply-To: <CALOAHbBAYHjDnKBVw63B8JBFc6U-2RNUX9L=ryA2Gbz7nnJfsQ@mail.gmail.com>


--egnngjetwmt4ba2t
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
	dri-devel@lists.freedesktop.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>, 
	Matus Jokay <matus.jokay@stuba.sk>, "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v8 1/8] Get rid of __get_task_comm()
References: <20240828030321.20688-1-laoar.shao@gmail.com>
 <20240828030321.20688-2-laoar.shao@gmail.com>
 <lql4y2nvs3ewadszhmv4m6fnqja4ff4ymuurpidlwvgf4twvru@esnh37a2jxbd>
 <n2fxqs3tekvljezaqpfnwhsmjymch4vb47y744zwmy7urf3flv@zvjtepkem4l7>
 <CALOAHbBAYHjDnKBVw63B8JBFc6U-2RNUX9L=ryA2Gbz7nnJfsQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CALOAHbBAYHjDnKBVw63B8JBFc6U-2RNUX9L=ryA2Gbz7nnJfsQ@mail.gmail.com>

Hi Yafang,

On Wed, Aug 28, 2024 at 09:40:35PM GMT, Yafang Shao wrote:
> > Ahh, the actual generic definition is in <include/linux/string.h>.
> > You could do
> >
> >         diff --git i/include/linux/string.h w/include/linux/string.h
> >         index 9edace076ddb..060504719904 100644
> >         --- i/include/linux/string.h
> >         +++ w/include/linux/string.h
> >         @@ -76,11 +76,11 @@ ssize_t sized_strscpy(char *, const char *,=
 size_t);
> >           * known size.
> >           */
> >          #define __strscpy0(dst, src, ...)      \
> >         -       sized_strscpy(dst, src, sizeof(dst) + __must_be_array(d=
st))
> >         +       sized_strscpy(dst, src, ARRAY_SIZE(dst))
> >          #define __strscpy1(dst, src, size)     sized_strscpy(dst, src,=
 size)
> >
> >          #define __strscpy_pad0(dst, src, ...)  \
> >         -       sized_strscpy_pad(dst, src, sizeof(dst) + __must_be_arr=
ay(dst))
> >         +       sized_strscpy_pad(dst, src, ARRAY_SIZE(dst))
> >          #define __strscpy_pad1(dst, src, size) sized_strscpy_pad(dst, =
src, size)
> >
> >          /**
>=20
> Thank you for your suggestion. How does the following commit log look
> to you? Does it meet your expectations?
>=20
>     string: Use ARRAY_SIZE() in strscpy()
>=20
>     We can use ARRAY_SIZE() instead to clarify that they are regular char=
acters.

I would write the following:

For symmetry with wide-character string functions, ARRAY_SIZE() is more
appropriate than sizeof().

For example, one would call wcs*cpy(dst, src, ARRAY_SIZE(dst)).
The call wcs*cpy(dst, src, sizeof(dst)) would be bogus, since the
argument is the number of wide characters, not the number of bytes.

When translating that to normal characters, one wants conceptually the
same operation, but on (normal) characters.  That is, one wants
strscpy(dst, src, ARRAY_SIZE(dst)).  While strscpy() with sizeof() works
just fine because sizeof(char)=3D=3D1 by definition, it is conceptually
wrong to use it.

By using ARRAY_SIZE(), we get the __must_be_array() check for free.

>=20
>     Co-developed-by: Alejandro Colomar <alx@kernel.org>
>     Signed-off-by: Alejandro Colomar <alx@kernel.org>
>     Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>=20
> diff --git a/arch/um/include/shared/user.h b/arch/um/include/shared/user.h
> index bbab79c0c074..07216996e3a9 100644
> --- a/arch/um/include/shared/user.h
> +++ b/arch/um/include/shared/user.h
> @@ -14,7 +14,7 @@
>   * copying too much infrastructure for my taste, so userspace files
>   * get less checking than kernel files.
>   */
> -#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]) + __must_be_array(x))
>=20
>  /* This is to get size_t and NULL */
>  #ifndef __UM_HOST__
> @@ -60,7 +60,7 @@ static inline void print_hex_dump(const char *level,
> const char *prefix_str,
>  extern int in_aton(char *str);
>  extern size_t strlcat(char *, const char *, size_t);
>  extern size_t sized_strscpy(char *, const char *, size_t);
> -#define strscpy(dst, src)      sized_strscpy(dst, src, sizeof(dst))
> +#define strscpy(dst, src)      sized_strscpy(dst, src, ARRAY_SIZE(dst))
>=20
>  /* Copied from linux/compiler-gcc.h since we can't include it directly */
>  #define barrier() __asm__ __volatile__("": : :"memory")
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 9edace076ddb..060504719904 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
>=20
> @@ -76,11 +76,11 @@ ssize_t sized_strscpy(char *, const char *, size_t);
>   * known size.
>   */
>  #define __strscpy0(dst, src, ...)      \
> -       sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst))
> +       sized_strscpy(dst, src, ARRAY_SIZE(dst))
>  #define __strscpy1(dst, src, size)     sized_strscpy(dst, src, size)
>=20
>  #define __strscpy_pad0(dst, src, ...)  \
> -       sized_strscpy_pad(dst, src, sizeof(dst) + __must_be_array(dst))
> +       sized_strscpy_pad(dst, src, ARRAY_SIZE(dst))
>  #define __strscpy_pad1(dst, src, size) sized_strscpy_pad(dst, src, size)

The diff looks good to me.  Thanks!

Cheers,
Alex

>=20
>  /**
>=20
> --
> Regards
>=20
> Yafang

--=20
<https://www.alejandro-colomar.es/>

--egnngjetwmt4ba2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmbPL+QACgkQnowa+77/
2zJobg//W3RHrDHVBPuZSKc3m1rr+m7+7TxlOxTaXg8qwoJHeHq4f/sbSV5l1HR4
UF2gEJicrF4OknzCcegkXqdjxs1MUkzlaMxIQmj0yPgQmZ1Upg9aoGlVJNyjynvD
09twa1O3azCA8YvuZc+vn0YoqbGkM54+OPWJaBsSERqgcVF57/vXgS702rKBqwhw
3CrAWa/WTX5z10Q6yX+kwV8gWrtOBsMyAQRk53Yr3ZRR8DhCyK1ImS8BSHROV8+T
Dz5g8o2WzPkvKZiLq/Slxa9UpRvw5j5RBh3GBGxhZcubv8arya/FMwXotUa2L3Rr
uvfxbQw6lCR15FlHrI8984b99T7YkIr/pxYmrQABScUz7uMqJAhVutei6YJJgkUs
jpEsNQeOiDgJoQUU7xcVuP1ME6sgdU7/vxYfcjiybYX0rvaVjKTRWRAQt6NmmvqX
L6sZ94Tmba4wN92Akga5S3wnEadpbFHZtVGOVbc6tHz9ee0uVksD+DWSQVz7F8pw
vMu73OMlE/cp9AFZhtVDuUCqneXgvgEGs86akKQuVdx2fSeZG3CVkTH5L8vSlTGi
AlUtf5jlr8oHAP3g6Jl5KTxgGQXaXybO0RlbyVgM1ZrT+vrHLIB0mwBTJ3cIBKLS
jAh4WPx1tmvxpQw9/G3igu98xN7ttGBv7Lc+WxmGK/aQfJtl6T4=
=TaLj
-----END PGP SIGNATURE-----

--egnngjetwmt4ba2t--

