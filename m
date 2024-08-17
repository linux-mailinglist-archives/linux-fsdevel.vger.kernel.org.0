Return-Path: <linux-fsdevel+bounces-26196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D31795591C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 19:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 400471C20DD1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 17:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C20155A21;
	Sat, 17 Aug 2024 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdabWq0d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B241CC2C6;
	Sat, 17 Aug 2024 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723914214; cv=none; b=TvhneARf/o3QRJhmBjFtX9HTKYSTLy1hTozmRH0mPoe0wDxRSF0JHML+j/zgi+G6/lPuG9uKAGNjnlatP5/JbtbfwhBT7FXhn3Jgk77MhTpjE3eBOVhYlQEK7NHdsNFg91VeREaxHzD1CR3R4C1FyS2SXgqL6XfPd1DlF9HXRdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723914214; c=relaxed/simple;
	bh=WFyA/tqAMMg3mjewQExpczQ1ttYWRQIE/f0Lskwrtmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udH+pRGOcWUEJPG9iSzvyFUxRz34rGMZ+ievGtDu1to9TUxoqUOIXGC5+JQugfdEMC1ntoTXhcDeE2kT+xiaQdl3gRJjS3BkN03lrbGomUNMujVOzxKxcWOhUdhxXOJ3Fr/lqIhbQvXqSNATNfq1bvkB5+riZcSdnMi0gQBRgsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdabWq0d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E87C116B1;
	Sat, 17 Aug 2024 17:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723914214;
	bh=WFyA/tqAMMg3mjewQExpczQ1ttYWRQIE/f0Lskwrtmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EdabWq0doPpfWz9pF2Ld9tpLm4HMzTpi6r3fhTLX2OY1p75l7B3/zm00zZTV9BTan
	 SBWnUKG21Gy+kLs+auHFYn8KFvpU+5zTkPlU/xEFVQXvuwhYV+RMluoxxyxfON/BxK
	 5Mh2Q2ILxJnN/d260gXBY3n0iYAunUgcedLgrATwzwSBi5M2KSvxGVOUa+g6vp7N0r
	 //KNIas75bfdgXSc+YkRESg9AbJ5rbl2ikS1NDJkmlFs1aGZZbbllG0v5UPwft9nbB
	 dCwTCz08wCo1N+tHaDB++89/d5lbVD4UPR2MHRUj/UroHSZYk4lb2lwpJx4LxfpBKT
	 fFaFHC1j4OhYw==
Date: Sat, 17 Aug 2024 19:03:28 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, 
	justinstitt@google.com, ebiederm@xmission.com, alexei.starovoitov@gmail.com, 
	rostedt@goodmis.org, catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v7 5/8] mm/util: Fix possible race condition in kstrdup()
Message-ID: <qnaa7if7x3um3sxhsi2tenupzhurv33qqdyypbmpwwsmqftzr2@ssjbepjb6jjk>
References: <20240817025624.13157-1-laoar.shao@gmail.com>
 <20240817025624.13157-6-laoar.shao@gmail.com>
 <w6fx3gozq73slfpge4xucpezffrdioauzvoscdw2is5xf7viea@a4doumg264s4>
 <CAHk-=wi_U7S=R2ptr3dN21fOVbDGimY3-qpkSebeGtYh6pDCKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="htzjtxdf6lu6in7e"
Content-Disposition: inline
In-Reply-To: <CAHk-=wi_U7S=R2ptr3dN21fOVbDGimY3-qpkSebeGtYh6pDCKA@mail.gmail.com>


--htzjtxdf6lu6in7e
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, 
	justinstitt@google.com, ebiederm@xmission.com, alexei.starovoitov@gmail.com, 
	rostedt@goodmis.org, catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v7 5/8] mm/util: Fix possible race condition in kstrdup()
References: <20240817025624.13157-1-laoar.shao@gmail.com>
 <20240817025624.13157-6-laoar.shao@gmail.com>
 <w6fx3gozq73slfpge4xucpezffrdioauzvoscdw2is5xf7viea@a4doumg264s4>
 <CAHk-=wi_U7S=R2ptr3dN21fOVbDGimY3-qpkSebeGtYh6pDCKA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHk-=wi_U7S=R2ptr3dN21fOVbDGimY3-qpkSebeGtYh6pDCKA@mail.gmail.com>

Hi Linus,

On Sat, Aug 17, 2024 at 09:26:21AM GMT, Linus Torvalds wrote:
> On Sat, 17 Aug 2024 at 01:48, Alejandro Colomar <alx@kernel.org> wrote:
> >
> > I would compact the above to:
> >
> >         len =3D strlen(s);
> >         buf =3D kmalloc_track_caller(len + 1, gfp);
> >         if (buf)
> >                 strcpy(mempcpy(buf, s, len), "");
>=20
> No, we're not doing this kind of horror.

Ok.

> If _FORTIFY_SOURCE has problems with a simple "memcpy and add NUL",
> then _FORTIFY_SOURCE needs to be fixed.

_FORTIFY_SOURCE works (AFAIK) by replacing the usual string calls by
oneis that do some extra work to learn the real size of the buffers.
This means that for _FORTIFY_SOURCE to work, you need to actually call a
function.  Since the "add NUL" is not done in a function call, it's
unprotected (except that sanitizers may protect it via other means).
Here's the fortified version of strcpy(3) in the kernel:

	$ grepc -h -B15 strcpy ./include/linux/fortify-string.h
	/**
	 * strcpy - Copy a string into another string buffer
	 *
	 * @p: pointer to destination of copy
	 * @q: pointer to NUL-terminated source string to copy
	 *
	 * Do not use this function. While FORTIFY_SOURCE tries to avoid
	 * overflows, this is only possible when the sizes of @q and @p are
	 * known to the compiler. Prefer strscpy(), though note its different
	 * return values for detecting truncation.
	 *
	 * Returns @p.
	 *
	 */
	/* Defined after fortified strlen to reuse it. */
	__FORTIFY_INLINE __diagnose_as(__builtin_strcpy, 1, 2)
	char *strcpy(char * const POS p, const char * const POS q)
	{
		const size_t p_size =3D __member_size(p);
		const size_t q_size =3D __member_size(q);
		size_t size;

		/* If neither buffer size is known, immediately give up. */
		if (__builtin_constant_p(p_size) &&
		    __builtin_constant_p(q_size) &&
		    p_size =3D=3D SIZE_MAX && q_size =3D=3D SIZE_MAX)
			return __underlying_strcpy(p, q);
		size =3D strlen(q) + 1;
		/* Compile-time check for const size overflow. */
		if (__compiletime_lessthan(p_size, size))
			__write_overflow();
		/* Run-time check for dynamic size overflow. */
		if (p_size < size)
			fortify_panic(FORTIFY_FUNC_strcpy, FORTIFY_WRITE, p_size, size, p);
		__underlying_memcpy(p, q, size);
		return p;
	}

> We don't replace a "buf[len] =3D 0" with strcpy(,""). Yes, compilers may
> simplify it, but dammit, it's an unreadable incomprehensible mess to
> humans, and humans still matter a LOT more.

I understand.  While I don't consider it unreadable anymore (I guess I
got used to it), it felt strange at first.

>=20
>                 Linus

Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>

--htzjtxdf6lu6in7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmbA19sACgkQnowa+77/
2zIEAA//cSO5TER2rwseJ/ok0csn2IXjUaI0+NFv3HxRr9JU5EYfGxGjUpUr1YJW
upOq6aClxC/IX92s1cm3+HLu60WHKisWeVbR2cUxMUYij3GG/oJsZtaorKWht1xy
LPcoxJ3jad4f1CizEpgsZqiHEh8268embvgGpLsJEwHkYHq8JCstS48Wnuqcajx5
xDj9AM+fVtQ+x4RfFxGD4HtFoPWlHhkRS+wBgft09EUFzPiRWZynqTfq1lQuShm7
cBkDCH550QdgnHyu9wT4CY/3KnuybekcKkqQJXwi8Snw/FEZ+KnEBkCmC64UimEV
3VMX2yEvfkVQepZzsZ5vteO0KPd2+kdc+cdd3m29kw4tggsmPcptqVPofxtB1UzG
uZwj13eqjdhvTunRIp4lnqIE12MH2I2tinH/LaKU8Hx54HmEe2b0GcKSPZS5rC9f
BTj7YlZBzsI+50qWJoE6cHb4MraUwdubY5fFA5tPI2z+/5v69TEiX9seCS6cZH59
hHeKCDnRYvvqpH48w3JtYDroAOBA1QE6rUulRtEQaHJjpgsscp67+aLphOAY2pii
iI+jJPkLTAAphkNmJxV/SPOFNB90XmYAfL+maTz0po09EuJMA8Aj4VugWxbMIs7f
jO+zORD/dO86aEY99VOX6NJxhO50h1Q7BAvf1FASHafi3fahRgI=
=xff3
-----END PGP SIGNATURE-----

--htzjtxdf6lu6in7e--

