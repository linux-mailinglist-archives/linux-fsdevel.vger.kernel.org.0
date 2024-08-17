Return-Path: <linux-fsdevel+bounces-26182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CD795568F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 11:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B097028291C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 09:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EC814659C;
	Sat, 17 Aug 2024 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHZuxKob"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70EF2107;
	Sat, 17 Aug 2024 09:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723885513; cv=none; b=pPYnQu/ndU8y1Pldn1eP0/CTxBw4MVszWm0rifBwtw5As+v6+NrzsJg4Nh9zEdhDcOUMr1+E5R9x/LjAMBhTdkmQWBrv2HIA0rY0WziiNpeviOF/gmpjfs8aIi9y8BJ5+VMV4eOJ+nLiG9vRvmRZDqZbafOSBIZi8nN2FXcbVjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723885513; c=relaxed/simple;
	bh=v/bo9jddffzD66AkTiZN77T4QpmXWOzZY5qpNjnaKaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3W/+v1pGlVgv+RjpRRpnPgZ5jz4bU7zTN4QGkj9aTR1xJEFgttlT+uTmB1vCERBDsnbp85asm1N89bG5S2l/CmCFSVs2+ndOApz3GtRzxLCN+ulokLiyB/1M7Xav/tg4a3ZklFNDcLjFmdRedar+0FVQRKFdHD57Xx45lFn/Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHZuxKob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA74EC116B1;
	Sat, 17 Aug 2024 09:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723885512;
	bh=v/bo9jddffzD66AkTiZN77T4QpmXWOzZY5qpNjnaKaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uHZuxKobkZPexs4wQXgy+BigHynUnVn2wGZXIYK3rG4h1ghhRi91iSqYmk1RnU63k
	 MYVCdI6WXmjOKe7vXj9nBcdZr2YbbrM+4cxYpWJnBOzHYN8WBZYmnx6wTiP4pjScM+
	 a/38aDduZcDlZxZVablIYLfBKHjroH/uEmZroFJijBXpSek36A1Vq0124G01TH8w0V
	 349jwsrENGcMoLN4tKqn/Ly5mzH+uaU1bEjYR6cmhq5vnxcfuxX9XmftRtil9AjQ5X
	 ZZp+c56fp7/mSI3ovhzAorNflOdFGMQvkdTuHSISLpP32Gg7Nqy6zjelHnwHbFIEv+
	 WQ4Hzf798ofiA==
Date: Sat, 17 Aug 2024 11:05:06 +0200
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
Subject: Re: [PATCH v7 6/8] mm/util: Deduplicate code in
 {kstrdup,kstrndup,kmemdup_nul}
Message-ID: <qdzuvazxkvueook2a64qo2jcdrrbnkp2pn2dbury34ad47jvno@eu6ul4fso6yi>
References: <20240817025624.13157-1-laoar.shao@gmail.com>
 <20240817025624.13157-7-laoar.shao@gmail.com>
 <nmhexn3mkwhgu5e6o3i7gvipboisbuwdoloshf64ulgzdxr5nv@3gwujx2y5jre>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4u7yqqf3o53fozhu"
Content-Disposition: inline
In-Reply-To: <nmhexn3mkwhgu5e6o3i7gvipboisbuwdoloshf64ulgzdxr5nv@3gwujx2y5jre>


--4u7yqqf3o53fozhu
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
Subject: Re: [PATCH v7 6/8] mm/util: Deduplicate code in
 {kstrdup,kstrndup,kmemdup_nul}
References: <20240817025624.13157-1-laoar.shao@gmail.com>
 <20240817025624.13157-7-laoar.shao@gmail.com>
 <nmhexn3mkwhgu5e6o3i7gvipboisbuwdoloshf64ulgzdxr5nv@3gwujx2y5jre>
MIME-Version: 1.0
In-Reply-To: <nmhexn3mkwhgu5e6o3i7gvipboisbuwdoloshf64ulgzdxr5nv@3gwujx2y5jre>

On Sat, Aug 17, 2024 at 10:58:02AM GMT, Alejandro Colomar wrote:
> Hi Yafang,
>=20
> On Sat, Aug 17, 2024 at 10:56:22AM GMT, Yafang Shao wrote:
> > These three functions follow the same pattern. To deduplicate the code,
> > let's introduce a common helper __kmemdup_nul().
> >=20
> > Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Simon Horman <horms@kernel.org>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > ---
> >  mm/util.c | 67 +++++++++++++++++++++----------------------------------
> >  1 file changed, 26 insertions(+), 41 deletions(-)
> >=20
> > diff --git a/mm/util.c b/mm/util.c
> > index 4542d8a800d9..310c7735c617 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -45,33 +45,40 @@ void kfree_const(const void *x)
> >  EXPORT_SYMBOL(kfree_const);
> > =20
> >  /**
> > - * kstrdup - allocate space for and copy an existing string
> > - * @s: the string to duplicate
> > + * __kmemdup_nul - Create a NUL-terminated string from @s, which might=
 be unterminated.
> > + * @s: The data to copy
> > + * @len: The size of the data, including the null terminator
> >   * @gfp: the GFP mask used in the kmalloc() call when allocating memory
> >   *
> > - * Return: newly allocated copy of @s or %NULL in case of error
> > + * Return: newly allocated copy of @s with NUL-termination or %NULL in
> > + * case of error
> >   */
> > -noinline
> > -char *kstrdup(const char *s, gfp_t gfp)
> > +static __always_inline char *__kmemdup_nul(const char *s, size_t len, =
gfp_t gfp)
> >  {
> > -	size_t len;
> >  	char *buf;
> > =20
> > -	if (!s)
> > +	buf =3D kmalloc_track_caller(len, gfp);
> > +	if (!buf)
> >  		return NULL;
> > =20
> > -	len =3D strlen(s) + 1;
> > -	buf =3D kmalloc_track_caller(len, gfp);
> > -	if (buf) {
> > -		memcpy(buf, s, len);
> > -		/* During memcpy(), the string might be updated to a new value,
> > -		 * which could be longer than the string when strlen() is
> > -		 * called. Therefore, we need to add a null termimator.
> > -		 */
> > -		buf[len - 1] =3D '\0';
> > -	}
> > +	memcpy(buf, s, len);
> > +	/* Ensure the buf is always NUL-terminated, regardless of @s. */
> > +	buf[len - 1] =3D '\0';
> >  	return buf;
> >  }
> > +
> > +/**
> > + * kstrdup - allocate space for and copy an existing string
> > + * @s: the string to duplicate
> > + * @gfp: the GFP mask used in the kmalloc() call when allocating memory
> > + *
> > + * Return: newly allocated copy of @s or %NULL in case of error
> > + */
> > +noinline
> > +char *kstrdup(const char *s, gfp_t gfp)
> > +{
> > +	return s ? __kmemdup_nul(s, strlen(s) + 1, gfp) : NULL;
> > +}
> >  EXPORT_SYMBOL(kstrdup);
> > =20
> >  /**
> > @@ -106,19 +113,7 @@ EXPORT_SYMBOL(kstrdup_const);
> >   */
> >  char *kstrndup(const char *s, size_t max, gfp_t gfp)
> >  {
> > -	size_t len;
> > -	char *buf;
> > -
> > -	if (!s)
> > -		return NULL;
> > -
> > -	len =3D strnlen(s, max);
> > -	buf =3D kmalloc_track_caller(len+1, gfp);
> > -	if (buf) {
> > -		memcpy(buf, s, len);
> > -		buf[len] =3D '\0';
> > -	}
> > -	return buf;
> > +	return s ? __kmemdup_nul(s, strnlen(s, max) + 1, gfp) : NULL;
> >  }
> >  EXPORT_SYMBOL(kstrndup);
> > =20
> > @@ -192,17 +187,7 @@ EXPORT_SYMBOL(kvmemdup);
> >   */
> >  char *kmemdup_nul(const char *s, size_t len, gfp_t gfp)
> >  {
> > -	char *buf;
> > -
> > -	if (!s)
> > -		return NULL;
> > -
> > -	buf =3D kmalloc_track_caller(len + 1, gfp);
> > -	if (buf) {
> > -		memcpy(buf, s, len);
> > -		buf[len] =3D '\0';
> > -	}
> > -	return buf;
> > +	return s ? __kmemdup_nul(s, len + 1, gfp) : NULL;
> >  }
> >  EXPORT_SYMBOL(kmemdup_nul);
>=20
> I like the idea of the patch, but it's plagued with all those +1 and -1.
> I think that's due to a bad choice of value being passed by.  If you
> pass the actual length of the string (as suggested in my reply to the
> previous patch) you should end up with a cleaner set of APIs.
>=20
> The only remaining +1 is for kmalloc_track_caller(), which I ignore what
> it does.

D'oh, of course that's the malloc.  Yes, it makes sense to have a +1
there.

>=20
> 	char *
> 	__kmemdup_nul(const char *s, size_t len, gfp_t gfp)
> 	{
> 		char *buf;
>=20
> 		buf =3D kmalloc_track_caller(len + 1, gfp);
> 		if (!buf)
> 			return NULL;
>=20
> 		strcpy(mempcpy(buf, s, len), "");
> 		return buf;

Alternatively, you can also rewrite the above two lines into one as:

		return strncat(strcpy(buf, ""), s, len);

The good thing is that you have strncat() in the kernel, AFAICS.
I reminded myself when checking the definitions that I wrote in shadow:

	#define XSTRNDUP(s)                                           \
	(                                                             \
	    STRNCAT(strcpy(XMALLOC(strnlen(s, NITEMS(s)) + 1, char), ""), s) \
	)
	#define STRNDUPA(s)                                           \
	(                                                             \
	    STRNCAT(strcpy(alloca(strnlen(s, NITEMS(s)) + 1), ""), s) \
	)


Cheers,
Alex

> 	}
>=20
> 	char *
> 	kstrdup(const char *s, gfp_t gfp)
> 	{
> 		return s ? __kmemdup_nul(s, strlen(s), gfp) : NULL;
> 	}
>=20
> 	char *
> 	kstrndup(const char *s, size_t n, gfp_t gfp)
> 	{
> 		return s ? __kmemdup_nul(s, strnlen(s, n), gfp) : NULL;
> 	}
>=20
> 	char *
> 	kmemdup_nul(const char *s, size_t len, gfp_t gfp)
> 	{
> 		return s ? __kmemdup_nul(s, len, gfp) : NULL;
> 	}
>=20
> Have a lovely day!
> Alex
>=20
> --=20
> <https://www.alejandro-colomar.es/>



--=20
<https://www.alejandro-colomar.es/>

--4u7yqqf3o53fozhu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmbAZ8IACgkQnowa+77/
2zLvOA//Z/lDWnXjHMZFqj20EeCk/sOJvw2j0zS6ByjjhPwbF0QB4deovmQwO1rB
UfUFQNBO+A+m7nw8x/mLrYWRp9QX1koU8+XGacYS2fA/3zREzEbEDkWgaRej0TkD
lI5oQJysXdRk4zv0t+oSPS42Ga+OLoqOogKapp40DpFcY/PfC0lI/dP32nYeKIpL
H6XRqcEwqTOSNl8LOg3YkNO6Z93l+zsqDRCeiqze77O0QnrxDYY5gZdQkBfTiWDv
w5CzMOKn55JzbPrbPiQID2PKvokrMvtE0cS6WpBOjLNguoEyrPWaOJY9wTe3zJx0
jYczxxaqMVJOy+e/JzejKO7/8UaL4BjsKRkQxDUqX9JT2M1Mx94U/x4NdJ74Qpjg
BT5tAy0REvgQ5nfchZzwMxj94NK8fQ1kls54V3RcZ4SwF8Y8TL/UIXO0n3OHbHAZ
dDSam/sQaJCtIDEfeSjIAMISt2mUPaSu+K9IUQl5xlL+7hvtP7YJzOy0W5cP87uT
OIswibfrvvKaeBSmpPx2reAdydjV0ErJia59TA8Qr1gbtFl5N4y6V6KCAojgjKL/
RMowH5Jeai7WuTHla5CCBRc9sSpx2BFHpdcfW1+Kt8SvhOQ9BOcEq42xaM2megcd
weFqBQ6+YsgwWcVz7UNoMIi2UfQQpAvIflidVV9krOZsjk3OT9s=
=BouQ
-----END PGP SIGNATURE-----

--4u7yqqf3o53fozhu--

