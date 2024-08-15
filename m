Return-Path: <linux-fsdevel+bounces-26076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1EC953746
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 17:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD51282788
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 15:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB991AD3F3;
	Thu, 15 Aug 2024 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2VOK3AI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FF41AD408;
	Thu, 15 Aug 2024 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735804; cv=none; b=NxDouc4hbo76zpjRsgLGdKcsiObamiUAswOG6VuCpunDfG6sWILKk1TD/KJm62Mexkl8Veabrvy2A2F6b2+TI/vs3ylXtKdiCxUluLjbfW6rMdlo6PbPMk/GwsLVHMfKA3fkwOeK/Ud5aXr36Wegh3e8wsIcho9kDwl+R0wIBSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735804; c=relaxed/simple;
	bh=eIyx3IBfKno0cNAgEw1iBNzp1pqq6ljpPhCQTDU9dZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQXV2jzuFR26xsYd3d2AJUZKgg3G+FJysj5nxQgTz1+OnF2/Ny33wMpqPrmFX50yGGfvVyADvD1y29lxMa3TdkHWEHy4+fn7bH76iKI7iX87Y3L19FNwdpVb0tCTJnlcBF6RtxDC43Y1YBVmxLR+mTKD8tK9CqsE1MLWaVHB5fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2VOK3AI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F12C32786;
	Thu, 15 Aug 2024 15:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723735803;
	bh=eIyx3IBfKno0cNAgEw1iBNzp1pqq6ljpPhCQTDU9dZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f2VOK3AIWLU8QSUcuez403jAVeUCxkGiqTwl/3vXpTISYj5ZNiaC7iRk9B1NZQLjA
	 ovS1xr5gzeXsj2qNTSBFtyK1r+NxVe1nNs7sFTPO/KORonQhYRYOL9MBdvAC1kTDUW
	 vaAvADvtMEuupWZG7KxvNlIMv37mit4/B9L6sSEm1SlLUCoOOZInyG6S0M6A8fjPBo
	 O0D6R9ho6KCsny6znOChjPwNDpYIp/Ae8NQuuWxnILZlVGI6zgwCn/Allcb9RHmYO+
	 fd68FywO/qwePHjIoRGOlchOiPZz3nc64ZdSlgTIdvCBcid+R8wy8E1G3vTTrZTKT1
	 QB/eLkqJrI0jg==
Date: Thu, 15 Aug 2024 16:29:54 +0100
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
Subject: Re: [PATCH v10 23/40] arm64/signal: Set up and restore the GCS
 context for signal handlers
Message-ID: <7fa96f26-5bf6-490f-8986-258033fbfe0e@sirena.org.uk>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-23-699e2bd2190b@kernel.org>
 <ZrzEfg5LqdAzgJ6+@e133380.arm.com>
 <08932f6d-01ef-40e8-97d2-08f0d2016191@sirena.org.uk>
 <Zr4EkmtUKop9o9wu@e133380.arm.com>
 <c56fa974-88f7-4c1f-83bd-8c481fe0045d@sirena.org.uk>
 <Zr4avB6+U4tLDy8E@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YyEFoEtU1rhfM5GN"
Content-Disposition: inline
In-Reply-To: <Zr4avB6+U4tLDy8E@e133380.arm.com>
X-Cookie: -- Owen Meredith


--YyEFoEtU1rhfM5GN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 15, 2024 at 04:11:56PM +0100, Dave Martin wrote:
> On Thu, Aug 15, 2024 at 03:45:45PM +0100, Mark Brown wrote:
> > On Thu, Aug 15, 2024 at 02:37:22PM +0100, Dave Martin wrote:

> > > Is there a test for taking and returning from a signal on an alternate
> > > (main) stack, when a shadow stack is in use?  Sounds like something
> > > that would be good to check if not.

> > Not specifically for any of the architectures.

> Can you see any reason why this shouldn't work?

No, it's expected to work - I'm just not specifically aware of an
explicit test for it.  Possibly some of the userspace bringup work
might've covered it?  Any libc tests for altstack support should've
exercised it for example.

> Maybe I'll hacking up a test if I get around to it, but don't take this
> as a promise!

Thanks for your firm commitment!  :P

--YyEFoEtU1rhfM5GN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma+HvEACgkQJNaLcl1U
h9BAegf/QtK1e+T9WZ1prxPIxk18DlFBSQaVl3fAvm96vjPtE5PP3xAzEPik0b3O
Z8qDui3LXfB5xvftgIUUnEo1Yl7a5NiEUuqdU1fUUvXGk8OCVEmEQLXbBPOC6cyQ
e0jNgMzBJ0L/zIM5XPjEBw33aYk0GrwL/ib4Fyzo7SfscLaZQ926T72vSydRXaIo
TXc3QKHKWYHOaCAEMZgW2uBgmm7u97mFH7E7HJAqEiRPE0T4f6qQjluDGEcy1crb
DJfTgadShNXTjshCzNYyYtHXZgrQjyRUSbCA4Cgnwj9McpBbwQQkbx9kXH6sZdHV
Qgdiabh+uFXtADbJInyFT0RqRakHXg==
=3J6F
-----END PGP SIGNATURE-----

--YyEFoEtU1rhfM5GN--

