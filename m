Return-Path: <linux-fsdevel+bounces-12195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7284E85CCD8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 01:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018A21F23095
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 00:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64642568;
	Wed, 21 Feb 2024 00:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXXGDS8T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0062B1842;
	Wed, 21 Feb 2024 00:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476026; cv=none; b=n5mzJ/4bs+qHlmmEBTG+7b5Zez9wjZE06BZOb4+uvbwuwz1KcKwFSgKM6z4t+5Y9sI+/Yim4yzpxfJ+BPj/WCVtG2Dn0H0AeF8kGlwXGaHuZKewSRsLbvIUlQ6x28FTOF9yQFBeqmKR8Hbd7G1I5N7nvGFclj823ZZcV/2DuFEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476026; c=relaxed/simple;
	bh=4oc1pZky5HkjCTR+BuVavdWJx7t0uS02Mzr1ZCWHjCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1nSoLImu1x+OZrao0GP0bVAK0wSaOZSQICOlq73lV+IhbOpiUC3uw1Ai25cbLsCiPwL7la0MWOsfCo44+4DFb5z6sfHpYF6LFbBxkdWBLM4dvMSo0omi930hoOhuv1UaLPGwYQGTEHOoiy+uVz2bTWNvsWSbFJ/W7Cr58ST6I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXXGDS8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD31C433F1;
	Wed, 21 Feb 2024 00:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708476025;
	bh=4oc1pZky5HkjCTR+BuVavdWJx7t0uS02Mzr1ZCWHjCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VXXGDS8ThunN70a0rYLJLDyy89pGrp2M3fSV0kNxp/p/8CGEClIOL4nl+ZzbTjuIV
	 8V6uBESKVIYNjOAaa8Uo/S6TiQUo9smlP+Yw+uyKF1sXBB96kRwPAL6dnJjedxyo6k
	 4qbYaZ9JN4f9mZjp3cNgSl3cbBK9AnbdforPZw6T9Sb2nChqCEt0AgeAAASchO8E6a
	 ez7o0m5s5o/RTEFvNxASj/1hCwyW75ZRt4zTttSENFrinE4aZ9eLNeLRP+SphzQMF6
	 qqBsMn6ugGGsgIJzoiO9Uxo6EPe3R7ANKhZYz08gVHsrHyerm0ZL7k0trACQOzI77b
	 d6YNu+2OHW7dQ==
Date: Wed, 21 Feb 2024 00:40:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Stefan O'Rear <sorear@fastmail.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	Rich Felker <dalias@libc.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"musl@lists.openwall.com" <musl@lists.openwall.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	Oliver Upton <oliver.upton@linux.dev>,
	Palmer Dabbelt <palmer@dabbelt.com>, debug <debug@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"shuah@kernel.org" <shuah@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
	"oleg@redhat.com" <oleg@redhat.com>,
	Florian Weimer <fweimer@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	James Morse <james.morse@arm.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Will Deacon <will@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [musl] Re: [PATCH v8 00/38] arm64/gcs: Provide support for GCS
 in userspace
Message-ID: <4be8dc73-4873-44e5-8ef6-62e55d5023a7@sirena.org.uk>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
 <22a53b78-10d7-4a5a-a01e-b2f3a8c22e94@app.fastmail.com>
 <4c7bdf8fde9cc45174f10b9221fa58ffb450b755.camel@intel.com>
 <20240220185714.GO4163@brightrain.aerifal.cx>
 <9fc9c45ff6e14df80ad023e66ff7a978bd4ec91c.camel@intel.com>
 <063acc75-ea1d-4dd3-aecb-e5c8884005db@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EBD7P8ZrkhP4e0ph"
Content-Disposition: inline
In-Reply-To: <063acc75-ea1d-4dd3-aecb-e5c8884005db@app.fastmail.com>
X-Cookie: E = MC ** 2 +- 3db


--EBD7P8ZrkhP4e0ph
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 20, 2024 at 06:59:58PM -0500, Stefan O'Rear wrote:
> On Tue, Feb 20, 2024, at 6:30 PM, Edgecombe, Rick P wrote:

> > Maybe I'm misunderstanding. I thought the proposal included allowing
> > shadow stack access to convert normal address ranges to shadow stack,
> > and normal writes to convert shadow stack to normal.

> Ideally for riscv only writes would cause conversion, an incssp underflow
> which performs shadow stack reads would be able to fault early.

> For arm, since a syscall is needed anyway to set up the token in a new
> shadow stack region, it would make sense for conversion from non-shadow
> to shadow usage to never be automatic.

Well, we only need the token to pivot in userspace so we could
*potentially* work something out as part of the conversion process.
It's not filling me with enthusiasm though, and I've certainly not
actually thought it through yet.

> > I agree though that the late allocation failures are not great. Mark is
> > working on clone3 support which should allow moving the shadow stack
> > allocation to happen in userspace with the normal stack. Even for riscv
> > though, doesn't it need to update a new register in stack switching?

> > BTW, x86 shadow stack has a mode where the shadow stack is writable
> > with a special instruction (WRSS). It enables the SSP to be set
> > arbitrarily by writing restore tokens. We discussed this as an option
> > to make the existing longjmp() and signal stuff work more transparently
> > for glibc.

We have this feature on arm64 too, plus a separately controllable push
instruction (though that's less useful here).

> > BTW, when I talk about "not supporting" I don't mean the app should
> > crash. I mean it should instead run normally, just without shadow stack
> > enabled. Not sure if that was clear. Since shadow stack is not
> > essential for an application to function, it is only security hardening
> > on top.

> I appreciate that.  How far can we go in that direction?  If we can
> automatically disable shadow stacks on any call to makecontext, sigaltstack,
> or pthread_attr_setstack without causing other threads to crash if they were
> in the middle of shadow stack maintenance we can probably simplify this
> proposal, although I need to think more about what's possible.

Aside from concerns about disabling over all the threads in the process
(which should be solvable if annoying) this would be incompatible with
policies which prevent disabling of shadow stacks, and it feels like it
might end up being a gadget people could use which will concern some
people.  There's a tension here between compatibility and the security
applications of these features.

--EBD7P8ZrkhP4e0ph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXVRm8ACgkQJNaLcl1U
h9C3fgf/Vl3KFlMHtkZvrz9cGvE2TbC0mqrxMOeapZww/WMKCmIqHtFjSPzmQOKB
im3jrrFwQk29IabWprHeQo3+DYZFyMTugJwwJEv4rd++VT8MzDo90LzRjpj4WVzS
aCfx0m/xEicqx9wCP0hcygDCzrktn/MTm4+/b7fTIzhDobIOvheS2/tRMwq7x8HD
DTzVsfLNoau1eSLjxdfkFA+/rAkUuoNVqjDs33Sxiw9mBtoi0jNLc07YvZQm8u27
ijTimNGyEbckTAafaHEd86bwPjHRaiCTEsF4PP55m/lZrpYKjeSDVJw6H6skSvmm
ubMgYOa5diXQA6KCtKkjvhptV/C+oQ==
=FQI7
-----END PGP SIGNATURE-----

--EBD7P8ZrkhP4e0ph--

