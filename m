Return-Path: <linux-fsdevel+bounces-26079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE35953797
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 17:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C743B249BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 15:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4426C1B3740;
	Thu, 15 Aug 2024 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQHxQvc5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA9D1A4F3B;
	Thu, 15 Aug 2024 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723736774; cv=none; b=tK8R4wTQjXSItjCcyt2LB2GmzfmSwT8Jp7Vbi6Mb0Yt6Dhb43qw9ECOXfER8pLsRbr6JeMKX2JZm6EAfx0nd2UtG2mmhrGmVv4VNkS14ybfYwELYUIOaDmIEwnDAKmnhwjrdHOYM4C7/1zMxU10Obx44xfmP1iR2VbK2248OGnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723736774; c=relaxed/simple;
	bh=OhahuUFfndYeeiIAqMoZWO/itLbhbmCl9Dektx2bSmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Do8fxN4JEcNSI1DtjxbxpoOw4H+WuJbkuvy6QBOV3yKEfuPWDb1vppfqcWL7AG4LbOwoIwLzp04QRhorlteGAlF+b9uj8M/n1fOfmhdMOwAj1keUkRq7nUtgc7uvLKlqsQDN7Fixrk2NUxesjEsyeMBunw2pPYVmgwlHjTgA0VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQHxQvc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A925FC32786;
	Thu, 15 Aug 2024 15:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723736774;
	bh=OhahuUFfndYeeiIAqMoZWO/itLbhbmCl9Dektx2bSmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQHxQvc5mzqu6Xt9OdE1XNZLD70/O3dkcJiXZaxebgJDxx2JQVYIg435975yYCQQr
	 l5jUPJ9oJMKRElz7Dpy6UeqrDFRWxrZL9GgVJl4lw07+FN4VZhWpX5TJn27GiUUmzn
	 zflbVeq8Fynrs4ZZayXEmrP67CO7FB82ptXHbETuTJY707TwQqihr/CnxYOeOkK3Iq
	 Dls40SNfnnISQ4sF8cCZV+d/wVSzh4VpXAdOpq9qVv/6PVrUYatD7Il2JO1i+4JRAP
	 0bkotokage4eWgXhiPbnrXkVCVs4p5DoijU6EnNn09pzgcTeB9heRVbuopXzrzYpak
	 8cbW3fI2l2ChA==
Date: Thu, 15 Aug 2024 16:46:04 +0100
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
Message-ID: <280e4455-9cf7-40e1-9114-7bb3aa9de868@sirena.org.uk>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-24-699e2bd2190b@kernel.org>
 <ZrzIv3FWNgJizDc2@e133380.arm.com>
 <7433e3d2-996a-45a0-b917-666a340ad109@sirena.org.uk>
 <Zr4KMaBv4JXx8uBz@e133380.arm.com>
 <efe1d936-011d-49e3-a0ff-8f6276e4d782@sirena.org.uk>
 <Zr4fxZ8wf+Wcey4E@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GXfbjsfo8XCmDLMF"
Content-Disposition: inline
In-Reply-To: <Zr4fxZ8wf+Wcey4E@e133380.arm.com>
X-Cookie: -- Owen Meredith


--GXfbjsfo8XCmDLMF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 04:33:25PM +0100, Dave Martin wrote:
> On Thu, Aug 15, 2024 at 04:05:32PM +0100, Mark Brown wrote:

> > The expectation (at least for arm64) is that the main program will only
> > have shadow stacks if everything says it can support them.  If the
> > dynamic linker turns them on during startup prior to parsing the main
> > executables this means that it should turn them off before actually
> > starting the executable, taking care to consider any locking of feature=
s.

> Hmm, so we really do get a clear "enable shadow stack" call to the
> kernel, which we can reasonaly expect won't happen for ancient software?

Yes, userspace always has to explicitly enable the GCS.

> If so, I think dumping the GCS state in the sigframe could be made
> conditional on that without problems (?)

It is - we only allocate the sigframe if the task has GCS enabled.

> > > Related question: does shadow stack work with ucontext-based coroutin=
es?
> > > Per-context stacks need to be allocated by the program for that.

> > Yes, ucontext based coroutines are the sort of thing I meant when I was
> > talking about returning to a different context? =20

> Ah, right.  Doing this asynchronously on the back of a signal (instead
> of doing a sigreturn) is the bad thing.  setcontext() officially
> doesn't work for this any more, and doing it by hacking or rebuilding
> the sigframe is extremely hairy and probably a terrible idea for the
> reasons I gave.

I see.  I tend to view this as more adventurous than I personally would
be when writing userspace code but equally I don't see a need to
actively break things.  There's no *requirement* to use libc...

> So, overall I think making ucontext coroutines with with GCS is purely
> a libc matter that is "interesting" here, but we don't need to worry
> about.

Yes, it's not our problem so long as we don't get in the way somehow.

--GXfbjsfo8XCmDLMF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma+IrsACgkQJNaLcl1U
h9DSDwf/fvoSsWjkRUucDXlPXcS3xALg/zYnf2jri8K1FvhKbx6ExKFpnk/0g2BM
wK2PwaNUJU1aco+sWt4qWO5BpC2IehhK4SayS1RosRQNYaC++NMOh2/8HVNEHE10
XYPyfSZwI+nnf/4yS6Zz1HdzVTbuTkNBtkWyJtEO+gVukwrqd8ZroQ0fuSBvQyOu
ZmkniP6ouY5JUJvZtbLtaP0MurY44KnJyfZKbDuNyinTVw/SRukqIPVzy3RT0tTJ
rYVAnu34kZUCOei6ztPt+st1eA0IfyO0JvM2DcPAY7ZI1JHi15NFj0P2SedICD9d
gFptQBZcUxVlVAqy5L/gZ2G4JmaFVw==
=AdhV
-----END PGP SIGNATURE-----

--GXfbjsfo8XCmDLMF--

