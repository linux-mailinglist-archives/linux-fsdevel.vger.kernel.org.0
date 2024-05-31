Return-Path: <linux-fsdevel+bounces-20664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2F18D6707
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 18:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 066AE29202D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 16:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E052E15CD7F;
	Fri, 31 May 2024 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSD3vp0E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2FE156242;
	Fri, 31 May 2024 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717173599; cv=none; b=PHfTuTuWapk0GMfX+GpY1+6WvoBHCoR49ba3zodtdknoIaBoI4E1FNb8eDChi2UhnUG69ZSgp97tvyK6kOahYYqsWkir0cqZACgTRJCQDX0K2LgbnvnBqzSk2WgXapOtPw6fjWUptlExM+RlyBwHpl7kv43ZX8qjmxkV5CbeXxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717173599; c=relaxed/simple;
	bh=rlYXMn9txVbGYCPiT2IUpgeD44MrV8UPEyTPDwBy2Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FE9kv5RjsgBmrPYUHJpmmGInwIX0f0IIfbzi+eOTWZBxE8umki3SZQWvA63FqQYLBc8YL95Tp4CFDUmD+lSI1Laf0ZR9Zz8sVewe6lsLlRgD4YshWOy2SmlwA42tf77+Dw1gAoE5Org6HZuYUA6XFv22IKIPMZHHqJo9nprtP3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSD3vp0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30C6C116B1;
	Fri, 31 May 2024 16:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717173599;
	bh=rlYXMn9txVbGYCPiT2IUpgeD44MrV8UPEyTPDwBy2Tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dSD3vp0EAmW3nQ4jBdkff5x8LhXhmeFSYjYCRtLGk9qtpcSIZtZWjiE0CpQ2PzxQG
	 zq8S87nbi8joiFp3jMggqggvZNfuUE+8cUzIpK9+5B9iud3ukrsQmxDrR9gP3vcCYM
	 2EtmrX3DIxOWBZb8slu2bltZvdr8hLJw0rZU28LN29nZCAoabp7PbOllZeJho9tGBX
	 Xb6CcTbaxFh7g+zcdkqIY2G2nd0RUVAzTmKC/cwjoAEmV6derZ1lQWvYJc5KiQH+OR
	 xsiLE2t3HEY0uiywjJbomMZLqWwmNUv+lV4FB+jXwbYBSshDHzUyKDOu1WXCqi7Fwn
	 gSwAB/Ll67+Dg==
Date: Fri, 31 May 2024 17:39:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Amit Daniel Kachhap <amitdaniel.kachhap@arm.com>
Cc: Joey Gouly <joey.gouly@arm.com>, linux-arm-kernel@lists.infradead.org,
	akpm@linux-foundation.org, aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com, bp@alien8.de, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com,
	hpa@zytor.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, szabolcs.nagy@arm.com,
	tglx@linutronix.de, will@kernel.org, x86@kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 18/29] arm64: add POE signal support
Message-ID: <7789da64-34e2-49db-b203-84b80e5831d5@sirena.org.uk>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-19-joey.gouly@arm.com>
 <229bd367-466e-4bf9-9627-24d2d0821ff4@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="crruTSd4fVdttIMX"
Content-Disposition: inline
In-Reply-To: <229bd367-466e-4bf9-9627-24d2d0821ff4@arm.com>
X-Cookie: Serving suggestion.


--crruTSd4fVdttIMX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 28, 2024 at 12:26:54PM +0530, Amit Daniel Kachhap wrote:
> On 5/3/24 18:31, Joey Gouly wrote:

> > +#define POE_MAGIC	0x504f4530

> > +struct poe_context {
> > +	struct _aarch64_ctx head;
> > +	__u64 por_el0;
> > +};

> There is a comment section in the beginning which mentions the size
> of the context frame structure and subsequent reduction in the
> reserved range. So this new context description can be added there.
> Although looks like it is broken for za, zt and fpmr context.

Could you be more specific about how you think these existing contexts
are broken?  The above looks perfectly good and standard and the
existing contexts do a reasonable simulation of working.  Note that the
ZA and ZT contexts don't generate data payload unless userspace has set
PSTATE.ZA.

--crruTSd4fVdttIMX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZZ/VYACgkQJNaLcl1U
h9Ci3wgAgleCKLaBEMbJu0CzmzGdWvFcfWAwe7pJAUfgV6FDy/JI8Gy8L94zl2Gw
7U3DH3qDg1TZkpc+LT7nqNuoXy4rjjES8veABih0GdUG8DILjqvgitPM6smrf391
KPXshBFPzSV8efQnp15FPdkUJ/jF6+EqJ6Q03F4FOlYbPMRH0d1GKVmU+r09JNOD
2Gh2GZOhyuCLUqqwuDmjpgvHScykEMIN+c7mX1MDYt0xmC9SFTWI7w7Knv15wNPG
I5Bzm7+iqF4KLxD5qazPSlsNihVRSEFDajD8tTpx9601oadr7+oG51y4P71GloJz
c8HHc7Cs4xJpmMSz2TvtDfKpKVWj0w==
=+zed
-----END PGP SIGNATURE-----

--crruTSd4fVdttIMX--

