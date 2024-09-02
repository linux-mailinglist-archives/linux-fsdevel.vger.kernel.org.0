Return-Path: <linux-fsdevel+bounces-28268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29419968B82
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 18:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E6391C21C86
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 16:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A161A3049;
	Mon,  2 Sep 2024 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="yT7+80O+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4E442AB7;
	Mon,  2 Sep 2024 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725292984; cv=none; b=KFm49FngRPFEsBoT2KfDxyTVno/Cf0f30Foc/MW4esPxTsc5Xf8bjdkoKnuQY28jRXGGISbYYJuMbTWDqxe0N85/iJKjISYohykcgMWXE++DRKfdK2ZAno40HMZvT9YSTQXUg+lmXVEkjoVibb7lVDEmGECXE4Tk8p9RhKyeFGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725292984; c=relaxed/simple;
	bh=0JjunB37iEzXMOdt1r0c+A6zpwOdxB9KTs1TOBOETQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esDtetWJjufJwUCAlRVuvdtAxkajUP5+ErsjMt/7kj+Lzbas0k5QutRh0i5DdRhxndPi1uW5j3Y5eSkjOdyzkZ2eXeCu3hT7T3K332aoYBbF+ZYQpZRy56n8YxWBENApsY+aQYbrQG8PbMYl4IKdlsBY55b4v0zfcosjpqgU6D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=yT7+80O+; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WyD755BNrz9spX;
	Mon,  2 Sep 2024 18:02:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1725292977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y/WAo2wEKoXQ1DpuWFNQF/dhkLU3MgM/L7pMsMzDa3U=;
	b=yT7+80O+kLvfJIrums1mfAqfnvoGfVHmaHUI+A/suaeyi/wLufx8aoPjR6TGbQJMA6pIFn
	afRiGRZ8YQUI/ph+gpDduYcnhcUVbDMYti4YUKKPU0FZUFpkZUHZFMZlNONPEsh5QojeLG
	TkH8TKJ+jyILftA8RMkFHvCz/DMnt7WcDIZ9dQ/uNANWE0ZiWO9fq2JaxSXo+7cWHH6nMz
	iF22V25OedR07/sWWrqyaKokkeL1FIDzPQ//+onct3j12jk/ANX5Invv8QIz6YIDMZ5Jvh
	/rOdEQkdo2iTwwZ8fM7yBib0eEieFm3Mz5GKE9Hf0Jyg7f1autSh3UZdhXEbjg==
Date: Tue, 3 Sep 2024 02:02:39 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, shuah <shuah@kernel.org>, 
	Kees Cook <kees@kernel.org>, Florian Weimer <fweimer@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 1/8] uaccess: add copy_struct_to_user helper
Message-ID: <20240902.090015-soviet.bowling.selfish.chin-kvAI3lnuyqH@cyphar.com>
References: <20240902-extensible-structs-check_fields-v1-0-545e93ede2f2@cyphar.com>
 <20240902-extensible-structs-check_fields-v1-1-545e93ede2f2@cyphar.com>
 <319c0da6-3d9c-4b45-a14c-07c5bbc3afb7@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ftgkfoq5ev7h23w4"
Content-Disposition: inline
In-Reply-To: <319c0da6-3d9c-4b45-a14c-07c5bbc3afb7@app.fastmail.com>


--ftgkfoq5ev7h23w4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-02, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Sep 2, 2024, at 07:06, Aleksa Sarai wrote:
> > This is based on copy_struct_from_user(), but there is one additional
> > case to consider when creating a syscall that returns an
> > extensible-struct to userspace -- how should data in the struct that
> > cannot fit into the userspace struct be handled (ksize > usize)?
> >
> > There are three possibilies:
> >
> >  1. The interface is like sched_getattr(2), where new information will
> >     be silently not provided to userspace. This is probably what most
> >     interfaces will want to do, as it provides the most possible
> >     backwards-compatibility.
> >
> >  2. The interface is like lsm_list_modules(2), where you want to return
> >     an error like -EMSGSIZE if not providing information could result in
> >     the userspace program making a serious mistake (such as one that
> >     could lead to a security problem) or if you want to provide some
> >     flag to userspace so they know that they are missing some
> >     information.
>=20
> I'm not sure if EMSGSIZE is the best choice here, my feeling is that
> the kernel should instead try to behave the same way as an older kernel
> that did not know about the extra fields:

I agree this API is not ideal for syscalls because it can lead to
backward-compatibility issues, but that is how lsm_list_modules(2)
works. I suspect most syscalls will go with designs (1) or (3).

> - if the structure has always been longer than the provided buffer,
>   -EMSGSIZE should likely have been returned all along. If older
>   kernels just provided a short buffer, changing it now is an ABI
>   change that would only affect intentionally broken callers, and
>   I think keeping the behavior unchanged is more consistent.
>=20
> - if an extra flag was added along with the larger buffer size,
>   the old kernel would likely have rejected the new flag with -EINVAL,
>   so I think returning the same thing for userspace built against
>   the old kernel headers is more consistent.
>=20
>=20
> > +static __always_inline __must_check int
> > +copy_struct_to_user(void __user *dst, size_t usize, const void *src,
> > +		    size_t ksize, bool *ignored_trailing)
>=20
> This feels like the kind of function that doesn't need to be inline
> at all and could be moved to lib/usercopy.c instead. It should clearly
> stay in the same place as copy_struct_from_user(), but we could move
> that as well.

IIRC Kees suggested copy_struct_from_user() be inline when I first
included it, though I would have to dig through the old threads to find
the reasoning. __builtin_object_size() was added some time after it was
merged so that wasn't the original reason.

> > +{
> > +	size_t size =3D min(ksize, usize);
> > +	size_t rest =3D max(ksize, usize) - size;
> > +
> > +	/* Double check if ksize is larger than a known object size. */
> > +	if (WARN_ON_ONCE(ksize > __builtin_object_size(src, 1)))
> > +		return -E2BIG;
>=20
> I guess the __builtin_object_size() check is the reason for making
> it __always_inline, but that could be done in a trivial inline
> wrapper around the extern function.  If ksize is always expected
> to be a constant for all callers, the check could even become a
> compile-time check instead of a WARN_ON_ONCE() that feels wrong
> here: if there is a code path where this can get triggered, there
> is clearly a kernel bug, but the only way to find out is to have
> a userspace caller that triggers the code path.
>=20
> Again, the same code is already in copy_struct_from_user(), so
> this is not something you are adding but rather something we
> may want to change for both.
>=20
>       Arnd

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--ftgkfoq5ev7h23w4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZtXhnwAKCRAol/rSt+lE
b0i1AP4n3zvF3EnvaHU3j7y6pOFoMZsPTUgIjM9al7nMqGnp9gD/YOPgm1jLZUNd
4zg7QxzxYtCbzS8HNsO28bO+uW/C1A4=
=93Iu
-----END PGP SIGNATURE-----

--ftgkfoq5ev7h23w4--

