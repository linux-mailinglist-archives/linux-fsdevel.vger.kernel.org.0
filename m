Return-Path: <linux-fsdevel+bounces-12177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C94085C595
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 21:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808ED1C222B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 20:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E3814AD19;
	Tue, 20 Feb 2024 20:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="livCMehg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B5D612D7;
	Tue, 20 Feb 2024 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708460080; cv=none; b=V+RgeqmbZOdw5GIABJWkdQAT8pyA+gWeDxYdPgX6dqFN3xVNz7DdLgjevFYUn8oxwuq1Adn3smUa/vKejyu+P/w4OnKW35qw71iSqgNFIvMmX4/RQeKuVKfUosNbnFfTJLCokaBg44Yw/waceA5UzZwkzzafCphzXhcV+lm9gtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708460080; c=relaxed/simple;
	bh=PhnmgydTViRe3a3Z0MeKX2O9Z2j/9jkmyt+EI/YkIDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ID6zwQuReBnMNNu0dPh6ZWExaNgbYRR0qg100OFq0tY3iAJED/4xvjW5ccAX7cnJUtjq0YCpCL8ztMWclYjVYsZwXA57DNNHpqXga9x+/co98Y97y2z22ymrSXdCY/TbjtBSP8MEITvap+5ubwoTZz1V8yUvCtnRaU64WzWuHpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=livCMehg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0852DC433C7;
	Tue, 20 Feb 2024 20:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708460079;
	bh=PhnmgydTViRe3a3Z0MeKX2O9Z2j/9jkmyt+EI/YkIDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=livCMehgZsyylqxmsXVj6i8xUdU6xpehFod2AwCiN5tpwFKJ1EI6uVpnpUk1SD1pP
	 GAOlkj14vHO/qPvkX0d2id7JAYJfmORLe28tPRQkxNkQE6Rd+nls0vM8PGBKwrFQaU
	 Z6Hn1f36OwFyKU9OKK+mfymo53Iz1gvB0Pk8YA6mTWUndRC5NI4pVkVYdWAFBH06HP
	 wpOkoK5yJIv0PkCR2AWd/nyXrwJz1hOuoOPB1/Rw7cDtv6Mla+4AxXh12qp+hhLjEp
	 yd71FoqwR1k2BDtT0dWYNV11Xg/QhMr2farOiz7zqwo8yti2+//d2OrlM8Ac/4z8v3
	 SQyYG8IyDqVJw==
Date: Tue, 20 Feb 2024 20:14:30 +0000
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "ardb@kernel.org" <ardb@kernel.org>,
	"maz@kernel.org" <maz@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"oleg@redhat.com" <oleg@redhat.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	"will@kernel.org" <will@kernel.org>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"sorear@fastmail.com" <sorear@fastmail.com>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"thiago.bauermann@linaro.org" <thiago.bauermann@linaro.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"musl@lists.openwall.com" <musl@lists.openwall.com>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v8 00/38] arm64/gcs: Provide support for GCS in userspace
Message-ID: <527e2b4d-5d2b-4993-a30a-834e77a23a40@sirena.org.uk>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
 <22a53b78-10d7-4a5a-a01e-b2f3a8c22e94@app.fastmail.com>
 <4c7bdf8fde9cc45174f10b9221fa58ffb450b755.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LFlVuq7xn7hg1UEJ"
Content-Disposition: inline
In-Reply-To: <4c7bdf8fde9cc45174f10b9221fa58ffb450b755.camel@intel.com>
X-Cookie: E = MC ** 2 +- 3db


--LFlVuq7xn7hg1UEJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 06:41:05PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2024-02-20 at 11:36 -0500, Stefan O'Rear wrote:

> > 2. Shadow stack faults on non-shadow stack pages, if flexible shadow
> > stack
> > =A0=A0 handling is in effect, cause the affected page to become a shadow
> > stack
> > =A0=A0 page.=A0 When this happens, the page filled with invalid address
> > tokens.

> Hmm, could the shadow stack underflow onto the real stack then? Not
> sure how bad that is. INCSSP (incrementing the SSP register on x86)
> loops are not rare so it seems like something that could happen.

Yes, they'd trash any pages of normal stack they touch as they do so but
otherwise seems similar to overflow.

> The situation (for arm and riscv too I think?) is that some
> applications will just not work automatically due to custom stack
> switching implementations. (user level threading libraries, JITs, etc).
> So=A0I think it should be ok to ask for apps to change to enable shadow
> stack and we should avoid doing anything too awkward in pursuit of
> getting it to work completely transparently.

Yes, on arm64 anything that rewrites or is otherwise clever with the
stack is going to have to understand that the GCS exists on arm64 and do
matching rewrites/updates for the GCS.  This includes anything that
switches stacks, it will need to use GCS specific instructions to change
the current shadow stack pointer.

> > MAP_SHARED; I consider this sufficiently perverse application
> > behavior that
> > it is not necessary to ensure exclusive use of the underlying pages
> > while
> > a shadow stack pte exists.=A0 (Applications that use MAP_SHARED for
> > stacks
> > do not get the full benefit of the shadow stack but they keep
> > POSIX.1-2004
> > conformance, applications that allocate stacks exclusively in
> > MAP_PRIVATE
> > memory lose no security.)

> On x86 we don't support MAP_SHARED shadow stacks. There is a whole
> snarl around the dirty bit in the PTE. I'm not sure it's impossible but
> it was gladly avoided. There is also a benefit in avoiding having them
> get mapped as writable in a different context.

Similarly for arm64, I think we can physically do it IIRC but between
having to map via map_shadow_stack() for security reasons and it just
generally not seeming like a clever idea the implementation shouldn't
actually let you get a MAP_SHARED GCS it's not something that's been
considered.

> > I am substantially less familiar with GCS and SHSTK than with
> > Zicfiss.
> > It is likely that a syscall or other mechanism is needed to
> > initialize the
> > shadow stack in flexible memory for makecontext.

> The ucontext stacks (and alt shadow stacks is the plan) need to have a
> "restore token". So, yea, you would probably need some syscall to
> "convert" the normal stack memory into shadow stack with a restore
> token.

Similar considerations for GCS, we need tokens and we don't want
userspace to be able to write by itself in the normal case.

--LFlVuq7xn7hg1UEJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXVCCUACgkQJNaLcl1U
h9CH3gf+IJkDKy0uUAtsKGOEXiHDZs6dgXAT43RbQM/ofajONSRA7nEWsZHy7IWP
Tcz0hVz2/ellXMMRHdtDCKYxE3ugSuE8UQSOLGt2B3R1TDmgkXPW8GWOtV/eIUYS
rJEPCtPF35R3ezGjIYnLBQvSoFNjD4TNyygIvjh6d3Wc8m+aXtiC/whvINTuzOVv
SnYa3aFliCl153Ck0/3GzAiFCbGFUY3qVhKBwbk6MLITlRf9mF5bLp8e5Zzf49yj
9qGcHcDETmpcxDVRJ7oAzh8gqQqein8FOyFDkREnT59O7DdNNTx8m/K29UOnBuLF
z/qP3IZSjbKlJ3d/XfSVG0mTnYnohw==
=e50G
-----END PGP SIGNATURE-----

--LFlVuq7xn7hg1UEJ--

