Return-Path: <linux-fsdevel+bounces-26069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 179579536A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 17:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2A61C254D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 15:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52BD1ABEC8;
	Thu, 15 Aug 2024 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKZYerGH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375B529CE6;
	Thu, 15 Aug 2024 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723734343; cv=none; b=N5LuMXk3NKVTHEIMuKylDjDuMNm9m0gJdSKMI47GxjI+SWrwiEQsT5Edz3LchIZZeLv9yntcZpl5q0rK40Qf+MJyn3LtDiHS2n/qiedtOBqgSjQkhmu2K5S+GwCd8MQkgG3zYFuSUo4NjN6KP3dYCe980phrpWocd8oNHzw5Xdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723734343; c=relaxed/simple;
	bh=VaZmCxGBF8KztnlsWWYHsWkxQ+nObQmzwcHV6fkRBCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cndFNdn3HT0aBeaKnYnbZgqlOF204bO6g2OpIoZdw/DpiYsAoC+8xNoXdudkZOGRveUJmmN2y53ZhZjrZJSDxLpoofkVOgILf01gvHreaCxPESIjoXN7enSdr/GnwRSvbrNAJAYlMDP1AH5Puw8BzlsJ0pkAwflXCCtWH2oklmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKZYerGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C21C4AF0D;
	Thu, 15 Aug 2024 15:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723734342;
	bh=VaZmCxGBF8KztnlsWWYHsWkxQ+nObQmzwcHV6fkRBCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AKZYerGHcjQDpXEtvnruAGu5zXDe7awbHeen5Mm3saiTtNbcwHPI2BNFcpGWaKLl7
	 YIKg6KnEFRVGaNPCZCbWvEPBvhVlfqikdVQyxH311a84xo7K2q0lWx4/oPE4spK+Gc
	 uVkrd2SL+XZHxyR1/oBYNkBNcNnPIsk4aho61+F4Aysl+0A3Wz95fLmEsodqnvYA90
	 Y0JvpH7+0yNt6fPPLf1ogR/SXjp7qymrN/8ccZueeoHvawyYsYLYsLW2g+4m0kriSI
	 6xvFXlUgNCrp4sQx0OnVpPiV7ujihcrQde8PFl5rQyVaq2FkjbGlnZNsTfDFw1A+GF
	 wKIh9mENd/rRg==
Date: Thu, 15 Aug 2024 16:05:32 +0100
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
Message-ID: <efe1d936-011d-49e3-a0ff-8f6276e4d782@sirena.org.uk>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-24-699e2bd2190b@kernel.org>
 <ZrzIv3FWNgJizDc2@e133380.arm.com>
 <7433e3d2-996a-45a0-b917-666a340ad109@sirena.org.uk>
 <Zr4KMaBv4JXx8uBz@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SmjZxCFLN11graeJ"
Content-Disposition: inline
In-Reply-To: <Zr4KMaBv4JXx8uBz@e133380.arm.com>
X-Cookie: -- Owen Meredith


--SmjZxCFLN11graeJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 03:01:21PM +0100, Dave Martin wrote:

> My thought was that if libc knows about shadow stacks, it is probably
> going to be built to use them too and so would enable shadow stack
> during startup to protect its own code.

> (Technically those would be independent decisions, but it seems a good
> idea to use a hardening feature if you know about and it is present.)

> If so, shadow stacks might always get turned on before the main program
> gets a look-in.

> Or is that not the expectation?

The expectation (at least for arm64) is that the main program will only
have shadow stacks if everything says it can support them.  If the
dynamic linker turns them on during startup prior to parsing the main
executables this means that it should turn them off before actually
starting the executable, taking care to consider any locking of features.

> > > Is there any scenario where it is legitimate for the signal handler to
> > > change the shadow stack mode or to return with an altered GCSPR_EL0?

> > If userspace can rewrite the stack pointer on return (eg, to return to a
> > different context as part of userspace threading) then it will need to

> Do we know if code that actually does that?  IIUC, trying to do this is
> totally broken on most arches nowadays; making it work requires a
> reentrant C library and/or logic to defer signals around critical
> sections in userspace.

> "Real" threading makes this pretty pointless for the most part.

> Related question: does shadow stack work with ucontext-based coroutines?
> Per-context stacks need to be allocated by the program for that.

Yes, ucontext based coroutines are the sort of thing I meant when I was
talking about returning to a different context? =20

> > be able to also update GCSPR_EL0 to something consistent otherwise
> > attempting to return from the interrupted context isn't going to go
> > well.  Changing the mode is a bit more exotic, as it is in general.
> > It's as much to provide information to the signal handler as anything
> > else.

> I'm not sure that we should always put information in the signal frame
> that the signal handler can't obtain directly.

> I guess it's harmless to include this, though.

If we don't include it then if different ucontexts have different GCS
features enabled we run into trouble on context switch.

> > > Is the guarded stack considered necessary (or at least beneficial) for
> > > backtracing, or is the regular stack sufficient?

> > It's potentially beneficial, being less vulnerable to corruption and
> > simpler to parse if all you're interested in is return addresses.
> > Profiling in particular was mentioned, grabbing a linear block of memory
> > will hopefully be less overhead than chasing down the stack.  The
> > regular stack should generally be sufficient though.

> I guess we can't really argue that the shadow stack pointer is
> redundant here though.  The whole point of shadow stacks is to make
> things more robust...

> Just kicking the tyres on the question of whether we need it here, but
> I guess it's hard to make a good case for saying "no".

Indeed.  The general model here is that we don't break userspace that
relies on parses the normal stack (so the GCS is never *necessary*) but
clearly you want to have it.

--SmjZxCFLN11graeJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma+GTsACgkQJNaLcl1U
h9Cb8wf/XCjGckqPDQqfMA0CTLZ811XV2dX1kqvju9JAXl44DN3khpUuEAkktoKg
KbrTL623QOjWbXYNgob5OLdQY42g++1RsuH62wKmX2kr080OWTmKFnRRROJzBftx
t9l70dd63SnOG7orRLDAACk/Api5Gr9PnCVZ/wc5DvzpD8Oiu8JxTTYgBlYkE/AH
7ypTKtVlPzjfwNV95yhvqPFkoOPSsnSaQPBgZSthZf6LL6iT2IymUV01zdLYCuCL
YyeXxml1r7AkEjF2dAncCRH1A9ZwpmjpMiF/GsjJBzX4hvu2cS+LUiYodWA2fO1Q
6+/7fZ2S/ywynEbWYd2kLO2E/zQWMg==
=78We
-----END PGP SIGNATURE-----

--SmjZxCFLN11graeJ--

