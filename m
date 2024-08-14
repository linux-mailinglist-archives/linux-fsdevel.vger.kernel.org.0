Return-Path: <linux-fsdevel+bounces-25933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2AA951FD8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 18:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135A21F21619
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 16:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2641BBBDE;
	Wed, 14 Aug 2024 16:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4rPNJ6Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F135D1BBBC1;
	Wed, 14 Aug 2024 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652514; cv=none; b=r3MSCah6bq70dpv42QfWQaocr5iXxMwGHY7ZCl+SspKMpj9h2/AhCotoWBLopAe2P7YyyI+N4ArQ3CBlqbcpIrnDpvl5LGRFYOmZKZ9qTtC56PWe4E8mlo5Yhz1OXH0eef4wiESvy4Qj4/t7xtacTDb1fXicixRJdA15l1vWcjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652514; c=relaxed/simple;
	bh=y8gPBkTOEvl5zKXterrWvlJucqFgWO/8eWjzKQnvzD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MypPMNqIFcx80G15We0GjLvZpIA/0VzUFScWZrw3gD/EgtXRrmBzU9oDXtlApeuBIpgWmgPgT+foK8IAEuIRCon6ICva2hJJsAkI2GktoBfodfNXPrCQdC1Er+O6d/DO6nYfbKe+WEpQ8yfCuzJAQPv165ezRpDtgC8PAOh2saQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4rPNJ6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5CBC4AF09;
	Wed, 14 Aug 2024 16:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723652513;
	bh=y8gPBkTOEvl5zKXterrWvlJucqFgWO/8eWjzKQnvzD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q4rPNJ6ZS8/YTjHc/9HkxRU27ouAY0yibwaXXAm+1vcSBPqrepnOKEU4AR3KEhnOt
	 s58dD84l+9v/yfPZN6YN2ee+5/Ym6lay4t2aiB6H3CiXfg445fDVhup1StlDclBTyN
	 d6Tf9ZIXcKqcM2L3sfgF+ddNkeVAxqDhU5qIjR7ZPgaAoUWw/E0xVSN5pIIVghvJgH
	 ao3pIeIoMl3CcpagSZ9IYoUJzDC0aICQgPiBRlV88oVgdcBIHluUExu1ctrkOZWkoE
	 9l/H09OLwebwQfZ3EaETR7W2P/kahXmTAg0E5aVvsQbbYfL+9JItY7NLBOg8IGqomK
	 WAZ23R2KyrVjw==
Date: Wed, 14 Aug 2024 17:21:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Ross Burton <ross.burton@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 24/40] arm64/signal: Expose GCS state in signal frames
Message-ID: <7433e3d2-996a-45a0-b917-666a340ad109@sirena.org.uk>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-24-699e2bd2190b@kernel.org>
 <ZrzIv3FWNgJizDc2@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m4k347TUK5jMfMto"
Content-Disposition: inline
In-Reply-To: <ZrzIv3FWNgJizDc2@e133380.arm.com>
X-Cookie: The second best policy is dishonesty.


--m4k347TUK5jMfMto
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 14, 2024 at 04:09:51PM +0100, Dave Martin wrote:
> On Thu, Aug 01, 2024 at 01:06:51PM +0100, Mark Brown wrote:

> > +	if (add_all || task_gcs_el0_enabled(current)) {
> > +		err = sigframe_alloc(user, &user->gcs_offset,
> > +				     sizeof(struct gcs_context));
> > +		if (err)
> > +			return err;
> > +	}

> Who turns on GCS?  I have a concern that if libc is new enough to be
> built for GCS then the libc startup code will to turn it on, even if
> the binary stack running on top of libc is old.

It should normally be the dynamic linker which should be looking for
annotatations in the binaries it's loading before it decides if it's
going to turn on GCS (and libc doing something similar if it's going to
dlopen() things in a process with GCS enabled).

> Is there any scenario where it is legitimate for the signal handler to
> change the shadow stack mode or to return with an altered GCSPR_EL0?

If userspace can rewrite the stack pointer on return (eg, to return to a
different context as part of userspace threading) then it will need to
be able to also update GCSPR_EL0 to something consistent otherwise
attempting to return from the interrupted context isn't going to go
well.  Changing the mode is a bit more exotic, as it is in general.
It's as much to provide information to the signal handler as anything
else.

> Is the guarded stack considered necessary (or at least beneficial) for
> backtracing, or is the regular stack sufficient?

It's potentially beneficial, being less vulnerable to corruption and
simpler to parse if all you're interested in is return addresses.
Profiling in particular was mentioned, grabbing a linear block of memory
will hopefully be less overhead than chasing down the stack.  The
regular stack should generally be sufficient though.

--m4k347TUK5jMfMto
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma82ZcACgkQJNaLcl1U
h9Dw8Af/XElMBO/KVokIR07KfaB7sgnHeJUwP31NSZhm66aDj1xZVgyEok6vrQOQ
UAQRifPV98myi1QmsusRk+fCC2OGUG2eLWctGHDghxBwYs5hOCl5kebcUIKzzjNH
8aqD3GZNX1JLH8PLbzDMVhdLpM4uyKOvZFammGDrnoXjhZaBVSKS0PibtS54TY+R
HA7tSTIm/+xG4rXkAPJ/vo9YZf+cF1bTp1ccC47oQGzsPJIlPfulipp25A71VIiQ
9enlRUbkSEEZhQH+UZ2Rkpk1+sMCKUv5uT/m2vNWx1gRkngD8YkNUG2TnE9FQqSE
01uJahLacQ3yCSaWsm6UnjpUxI3Qng==
=9afo
-----END PGP SIGNATURE-----

--m4k347TUK5jMfMto--

