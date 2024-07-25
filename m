Return-Path: <linux-fsdevel+bounces-24266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0383093C829
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 20:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38CC1F22885
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 18:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191A519DF7C;
	Thu, 25 Jul 2024 18:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8MLbVSU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AC9DF6C;
	Thu, 25 Jul 2024 18:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721931110; cv=none; b=GxU2yI9U5+88XkxsHnsbSJTBRIcpto5uvQmqTfBjNpiFdnanSTRsA/NAUcwZAq7SAkHZPWfDkVywWfoTA8KqsSxcgLbh9eahEXLgXBgaO8y8etJQ558qTM+p3mWr49XXQVo2zzihwueMVJ1D3okg9eU6fH/erBhNl9969lu0J0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721931110; c=relaxed/simple;
	bh=qMPNAiU4QG51WPd2++7tk9Ir3s3Q0Q2T/8v0cyCK9EM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDB7xfVoX3afXJ1H1h5CTSyiCusz5BDtzUqwD37YudZGwzFVGrMVDKfudmLtRb0w6gGS7uPMoJK0UuY65YnrgGYi7HweZWGAV5r0nMUI1u322v2o9uKN+aUAdkq1aRubgToiEuXl1yMsI4r3I9qcOxQr3X/n+91HvSGlrM12ny4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8MLbVSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9308C116B1;
	Thu, 25 Jul 2024 18:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721931110;
	bh=qMPNAiU4QG51WPd2++7tk9Ir3s3Q0Q2T/8v0cyCK9EM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i8MLbVSUZNyx2oKUzGxGulXalYXs/A3uuRF0gXaAp/dV3ROUF08DFt2kY/IMp5Xcm
	 vlXuoNeyAMEqYxrVUEI1dQlobQI79RrraPupjRZYMkILK/7R65RxA8Oko9h7UBRf1I
	 Njg0GtY8b1A4UiJ6N1oPGBmghESZCD4ochXvxojhpHw4NrPw5RTJoqGGUv1WMWuO2v
	 GmLBdZVjEf2L9xTtJi59xk15gvfikBTs1nGQwnW3F7760FeZ6Ow9iI/7TOkF2iLETQ
	 BfgrrX0qUOsSl2IKa5ozSDfzDbrGZSGqna2afVmNcVJYv1zNPS480l0tCDd/lH0Fxc
	 GHxSJJD0mx8jg==
Date: Thu, 25 Jul 2024 19:11:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Amit Daniel Kachhap <amitdaniel.kachhap@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@kernel.org, aneesh.kumar@linux.ibm.com, bp@alien8.de,
	catalin.marinas@arm.com, christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, szabolcs.nagy@arm.com,
	tglx@linutronix.de, will@kernel.org, x86@kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 18/29] arm64: add POE signal support
Message-ID: <a13c3d5e-6517-4632-b20d-49ce9f0d8e58@sirena.org.uk>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-19-joey.gouly@arm.com>
 <229bd367-466e-4bf9-9627-24d2d0821ff4@arm.com>
 <7789da64-34e2-49db-b203-84b80e5831d5@sirena.org.uk>
 <cf7de572-420a-4d59-a8dd-effaff002e12@arm.com>
 <ZqJ2I3f2qdiD2DfP@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zuHkNnSXmHBvO0dc"
Content-Disposition: inline
In-Reply-To: <ZqJ2I3f2qdiD2DfP@e133380.arm.com>
X-Cookie: Zeus gave Leda the bird.


--zuHkNnSXmHBvO0dc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 25, 2024 at 04:58:27PM +0100, Dave Martin wrote:

> I'll post a draft patch separately, since I think the update could
> benefit from separate discussion, but my back-of-the-envelope
> calculation suggests that (before this patch) we are down to 0x90
> bytes of free space (i.e., over 96% full).

> I wonder whether it is time to start pushing back on adding a new
> _foo_context for every individual register, though?

> Maybe we could add some kind of _misc_context for miscellaneous 64-bit
> regs.

That'd have to be a variably sized structure with pairs of sysreg
ID/value items in it I think which would be a bit of a pain to implement
but doable.  The per-record header is 64 bits, we'd get maximal saving
by allocating a byte for the IDs.

It would be very unfortunate timing to start gating things on such a
change though (I'm particularly worried about GCS here, at this point
the kernel changes are blocking the entire ecosystem).

--zuHkNnSXmHBvO0dc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmailV0ACgkQJNaLcl1U
h9CJNAf/T4L+WiIsdTTGLKLrGIifWcIZMFDKVEGwW4FdSIpGyr1zBwSxsMMMpYMn
Y2vOp2+u+NUD72aKzhi9w2oDqf/zxrRMRtTac9G5p5yxDJ8A5TnZmLeUCeRDfeaD
KbGzJ+pmP6VAhz6dx1LVHo2/BlPFEBYic7aByH/VtQK5orNc9Ss1pjPj9M1kcMtS
ZpQDRVd9H8sTthXnA2au8VRVeCZIvHB7c6CHXWu8+gv4DVW9fcWaVmq7sKvrt3vA
KH+DHAft/yAobtjLtcPlj5ImoCIbRjmIa4qy3NsHji/xAHl4695sncCMJB7yi0fU
5WfF3lyw+U6HxGVPCH7jlQcjPB7XOw==
=PpFd
-----END PGP SIGNATURE-----

--zuHkNnSXmHBvO0dc--

