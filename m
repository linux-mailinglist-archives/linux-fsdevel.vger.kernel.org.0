Return-Path: <linux-fsdevel+bounces-30758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0815E98E25B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 20:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2855B21CC8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 18:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E19F212F1A;
	Wed,  2 Oct 2024 18:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpLyxwDc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E440F1D0BA2;
	Wed,  2 Oct 2024 18:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727893465; cv=none; b=PfkXg2L7vJHCMMjUPdVfs9UFvti754YU9W1Z3s2YUhItkZudMlUMlfJbmbm4i8g8u6q/xbpkaVYnqFaMEUiDhJ+xah9y0WpixFk1AIO8wuUPYJhrzFm3GBzJfVHmUz2kqN9wTusnYjiU6jcmSB8BaCPV/nMLHjI/FJ3VRGgUTWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727893465; c=relaxed/simple;
	bh=Xn5r/F/y3n+IVpjGqNQ5xxlIqpNtWX913WJmrs1pThE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7uWIBxI9rCW4y8mrtACrt3pke4a1pYL+uiRPDB/6k2cLiQnO3smwt7TASScNSkkfzsyuW25qkEMzbfPWj/UzpIbfFlKFaIz4tqJDof2KUWyIt03s4K5R6x/wiDAmbhJ3KszeGT3YiA1cHxzcSrjaIJsqDRrDa+SC2if9Oz2YjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpLyxwDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4524BC4CEC2;
	Wed,  2 Oct 2024 18:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727893464;
	bh=Xn5r/F/y3n+IVpjGqNQ5xxlIqpNtWX913WJmrs1pThE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HpLyxwDchSeqF4R9rk9zqytwWCTBbpujg7WnOnXPszioolkSCIFdMKzkLWZeF4ohP
	 PssFFutZ0TqK/qn3q51d9EEuAw1pmYyCIWQjcAmufjUCC0l618/rZcYNJWnnizCg2G
	 1CNq7+MXFCmw+6MEaE1iTjnB6QQMMH8g2IbrGHBviaxXC3DKarwixTHZrjcuZIVaF8
	 uykmFydsc/VUQbPXgNyiEqKDEo6UDITxmpz1IbAxb3J0yd96UH6KQ5fJ2jmwinS3Lh
	 bV3306MvladnEqvxq3o8HLRZ428Zey8544gcd+Ycx/nCEeiynVhb3l2MR99n+DXhMT
	 0AeL/bD/KzbNQ==
Date: Wed, 2 Oct 2024 19:24:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
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
	David Spickett <david.spickett@arm.com>,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v13 16/40] KVM: arm64: Manage GCS access and registers
 for guests
Message-ID: <37fbc082-6bda-46e3-9ee7-9240b41f26fd@sirena.org.uk>
References: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
 <20241001-arm64-gcs-v13-16-222b78d87eee@kernel.org>
 <86bk0373nq.wl-maz@kernel.org>
 <86a5fm7b4i.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f644fc4VKEnWPPLA"
Content-Disposition: inline
In-Reply-To: <86a5fm7b4i.wl-maz@kernel.org>
X-Cookie: Know Thy User.


--f644fc4VKEnWPPLA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 02, 2024 at 04:55:25PM +0100, Marc Zyngier wrote:
> Marc Zyngier <maz@kernel.org> wrote:

> > > +	if (!kvm_has_gcs(kvm))
> > > +		kvm->arch.fgu[HFGxTR_GROUP] |= (HFGxTR_EL2_nGCS_EL0 |
> > > +						HFGxTR_EL2_nGCS_EL1);

> > Why are you still allowing the GCS instructions when GCS isn't
> > enabled?

> Scratch that, they are NOPs when GCS isn't enabled, so there shouldn't
> be any need for extra traps.

They are, though really they should UNDEF if GCS isn't there (which I
had thought was what you were referencing here).  Equally we only have
traps for a subset of GCS instructions and it's not like there aren't a
whole bunch of untrappable extensions anyway so it's not clear it's
worth the effort just for that.

--f644fc4VKEnWPPLA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmb9j8sACgkQJNaLcl1U
h9AOWQf8DFoVOjrYp2ocafOH0wTbI6Jawr1ucPRjwYcn5sAGuTLywrEihNxOR42y
l62ygvYkYtUWpgViQZqrQznNkYbdxg7O6dnvc4ywKu0iWo1KPVJFT0At7NZp6Pxy
z8z/9OOYjxelIy33541t+XgjS3MxR3LA2PJSZd7ZOd4sHZMl7t1oLNi/s9HV0LAK
/xkcFEkwnX1y0EndbVnntD9crF+J0pBIuO1z3wtywncxixscc0PgM3e1mvmTmYu6
k62weouXEqlaiF5DZ6hHH4iHj8mPMYlnmvEz6Dsiev6PWcCm2hYrKiIO44ThjQJU
OggiVTV8pqPtukHW/VmVN/VFPC5k6w==
=YDrc
-----END PGP SIGNATURE-----

--f644fc4VKEnWPPLA--

