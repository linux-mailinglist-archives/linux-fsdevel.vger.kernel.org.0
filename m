Return-Path: <linux-fsdevel+bounces-12477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F73985FA82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 14:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B866B28402
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 13:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBA11350CA;
	Thu, 22 Feb 2024 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aanTBA7Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F656133425;
	Thu, 22 Feb 2024 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610283; cv=none; b=hZefbuIgv0u/bIcmsB+v0T+GKW+P5WGMKmy8eT7OAmLaKaQaD1NUMYbRAPSGZtQVMvU0Houn8B0KqutAtjxztX+ZK19UEAgvnQlWSB7ZgfTgIbr0fPowLCGJ6XkEZ6BMHC7UgwxvgtfyWQb+scVvuOdB3ISZRa3pRM5L8APSdAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610283; c=relaxed/simple;
	bh=qjmPfoVywGfr4jqsh5FJ/yxg8KOM8vjU9JBU7Z2KpR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+TWLfofWNgZEafxNoAecDDqfXWlFwy+15gka/Opymyq/daCGqB5Hg8kQK2/mtXRPRg0tyZ0r3Whv5tFUZliwR7sQYBz+4ZnP0mkMmn87jY+R4tcLkmP1+kHzv841XfEUsn2qMO36LETTlCW71OWm9bJBQIHRn0uQ26c0+hlg+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aanTBA7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D645C43390;
	Thu, 22 Feb 2024 13:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708610282;
	bh=qjmPfoVywGfr4jqsh5FJ/yxg8KOM8vjU9JBU7Z2KpR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aanTBA7Q5SU1zTtPDaMhX4nwG1EogaRTB6711DBMiXTmU8FRFzAcB7zQYgcUM2OaJ
	 XHksqp0nMGR665Zm+lDgT+yDropmULnL8lKiWtjJKJ3NL1ecrCmrLU8OR7ZcsowhNV
	 u+zivFcDWQqEkxqOD8K6xYSAKOOwaNrLKqXv3SiHTMwf1JJvLKTjXxiKAVOfTIyX6A
	 QW2bcztZSCAVxYQoLX8XBJuGKkKkAorTgEuxggq4WcuU6lezBNTj3BInSRIVEXBTih
	 tlOZte74whZIn/QZQ00VCk0r89EM0A76cAGvXtNTTd6uAX30BQpy9H3OHFzXJG137X
	 8lNOIn1prx5Vg==
Date: Thu, 22 Feb 2024 13:57:53 +0000
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "dalias@libc.org" <dalias@libc.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"musl@lists.openwall.com" <musl@lists.openwall.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>, "maz@kernel.org" <maz@kernel.org>,
	"oleg@redhat.com" <oleg@redhat.com>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	"will@kernel.org" <will@kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"ardb@kernel.org" <ardb@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"thiago.bauermann@linaro.org" <thiago.bauermann@linaro.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"sorear@fastmail.com" <sorear@fastmail.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [musl] Re: [PATCH v8 00/38] arm64/gcs: Provide support for GCS
 in userspace
Message-ID: <c2426b69-5411-45fe-851a-219e1f4f9d3b@sirena.org.uk>
References: <20240221012736.GQ4163@brightrain.aerifal.cx>
 <d18f060d-37ac-48b1-9f67-a5c5db79b34e@sirena.org.uk>
 <20240221145800.GR4163@brightrain.aerifal.cx>
 <4a3809e8-61b2-4341-a868-292ba6e64e8a@sirena.org.uk>
 <20240221175717.GS4163@brightrain.aerifal.cx>
 <f4a54297767eb098d903404cbe8860d655d79bed.camel@intel.com>
 <20240221183055.GT4163@brightrain.aerifal.cx>
 <c3085fbe10193dfe59b25bc7da776e60779b0e8c.camel@intel.com>
 <20240221190639.GU4163@brightrain.aerifal.cx>
 <e3a432c0fa9f5fe837e9d2fc7b36304709a34428.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y7x2ZPCVf8cy8GEb"
Content-Disposition: inline
In-Reply-To: <e3a432c0fa9f5fe837e9d2fc7b36304709a34428.camel@intel.com>
X-Cookie: I have accepted Provolone into my life!


--Y7x2ZPCVf8cy8GEb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 21, 2024 at 07:22:21PM +0000, Edgecombe, Rick P wrote:
> On Wed, 2024-02-21 at 14:06 -0500, dalias@libc.org wrote:

> > It's fine to turn RDSSP into an actual emulated read of the SSP, or
> > at
> > least an emulated load of zero so that uninitialized data is not left
> > in the target register.

> We can't intercept RDSSP, but it becomes a NOP by default. (disclaimer
> x86-only knowledge).

For arm64 we have a separate control GCSCRE0_EL1.nTR for access to
GCSPR_EL0 (our SSP equivalent) we can use.

> > I have not looked at all the instructions that become #UD but I
> > suspect they all have reasonable trivial ways to implement a
> > "disabled" version of them that userspace can act upon reasonably.

> This would have to be thought through functionally and performance
> wise. I'm not opposed if can come up with a fully fleshed out plan. How
> serious are you in pursuing musl support, if we had something like
> this?

Same here, we have to be careful since it's defining ABI in a way that
we don't normally provide ABI but if there's a clear case for doing it
then...

--Y7x2ZPCVf8cy8GEb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXXUuAACgkQJNaLcl1U
h9CWhgf9ENKHpmQFWkFp9BvnSQpoqzt8GvTsea21+X/Sj2LF1t9awlhI1ZonFcLg
kiWOH7voRFXaX11HTooF+5zW0lljzQzeKy6a4cAqvyhV93pQz5U7Tzuk5xqkLe3o
mtXBUEWVIO/JPNSAwHNb44hXL7AjS1MEYgj0iqYvqWCYqikKit3kjOjJrc3jdb4y
3NQgra/qAykoQji1F3ZFkEtRyHALvMWET9TzzVyrCoTYPzIRzCWnkkBxKsNMokGC
nwxW+cuoESrLNygNc/V3CbbUqAYkdO7AbmSvBvzQ0pboXO5M+p4sPnapddZeoYiK
JVmWfU7+hu6JUz1Bj5tBIoRL24Q7Og==
=mhhY
-----END PGP SIGNATURE-----

--Y7x2ZPCVf8cy8GEb--

