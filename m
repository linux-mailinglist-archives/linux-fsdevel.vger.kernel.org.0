Return-Path: <linux-fsdevel+bounces-31979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 603E799ED6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 15:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25316285C38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 13:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77021FC7D7;
	Tue, 15 Oct 2024 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrKsNHUr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1783C1FC7CA;
	Tue, 15 Oct 2024 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998778; cv=none; b=g1U5SHNls26M+pZF4dMWAzFrvIP0vR1U3RG8BqEH7oxNcELRevSzZGP4pSwdIAu6ZyE2LccBMff+5jhsOK50vs+0qdB0V5ceOQR9BNDWAv3rXS3aaH2OogyCJg00HGuAsQxkS7STUtDsV2K+dWipieBneVgry+mFEIq3dmHVNNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998778; c=relaxed/simple;
	bh=oFFPT5mvvt/DlJJSCGR58VuLSdcKbAv5xgnJpcGR0tY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uv4ZWx8A83md4DDfKqrCr7P06qAgT2ZY7tbohlgHW1+aQsLXrkgey/G32+Wg6M5PbNAI3o/PtM9dUPJVCUPsT6WgftROGTeTquVfW3MNvdYem4TIIoncrCbuAThF8nH0sDl28J/W7hGsG2+Ui70Pg8MDFZ96n0ocXXzdDVZ/UGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrKsNHUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3CCC4CECE;
	Tue, 15 Oct 2024 13:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728998777;
	bh=oFFPT5mvvt/DlJJSCGR58VuLSdcKbAv5xgnJpcGR0tY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FrKsNHUrBSbtPVikj1FML7vlz2mzC3ZXIoGIfrjrUd5GNlvj7byXhK69OID1comZ3
	 ERsc0zdXy2HK9A2Z7G99T+h/RV2RmGFRkCXOSx8aShAqDswaIjUsafckOOSl1skiEU
	 I2tf+OBx0u4OvVcY4HsF2UpTQUhJbpZzsK31x/FIIThfUQgmq8SNCnsUS81S2+rnJn
	 JbezWxhO8+rA32VdG2XOwewpI/bX783q2XyJgeqNS477KHazRAG5kVkrecFNa/Tgu6
	 T9M85n1LAvOk5DzGVWzOFVwwmW+vDtjPlBvN5IHs9Pu+Y+jgPolGy/RrDmde4Rw9M3
	 Bn4LSqGCTRfig==
Date: Tue, 15 Oct 2024 14:26:09 +0100
From: Mark Brown <broonie@kernel.org>
To: Joey Gouly <joey.gouly@arm.com>
Cc: Will Deacon <will@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>,
	linux-arm-kernel@lists.infradead.org, nd@arm.com,
	akpm@linux-foundation.org, aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com, bp@alien8.de,
	catalin.marinas@arm.com, christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, skhan@linuxfoundation.org,
	szabolcs.nagy@arm.com, tglx@linutronix.de, x86@kernel.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 19/30] arm64: add POE signal support
Message-ID: <e9eb6cf1-1ed4-45b0-85c1-39028728f952@sirena.org.uk>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
 <20240822151113.1479789-20-joey.gouly@arm.com>
 <47e1537f-5b60-4541-aed1-a20e804c137d@arm.com>
 <20241009144301.GA12453@willie-the-truck>
 <20241014171023.GA18295@willie-the-truck>
 <20241015095911.GA3777204@e124191.cambridge.arm.com>
 <20241015114116.GA19334@willie-the-truck>
 <20241015122529.GA3820764@e124191.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VY579BsplRjShns6"
Content-Disposition: inline
In-Reply-To: <20241015122529.GA3820764@e124191.cambridge.arm.com>
X-Cookie: New customers only.


--VY579BsplRjShns6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 15, 2024 at 01:25:29PM +0100, Joey Gouly wrote:
> On Tue, Oct 15, 2024 at 12:41:16PM +0100, Will Deacon wrote:

> > 	if (system_supports_poe() && err == 0 && user->poe_offset) {
> > 		...

> > which gives the wrong impression that the POR is somehow optional, even
> > if the CPU supports POE. So we should drop that check of
> > 'user->poe_offset' as it cannot be NULL here.

> That was cargo culted (by me) from the rest of the function (apart from TPIDR2
> and FPMR). I think Kevin is planning on sending his signal changes still, but
> is on holiday, maybe he can remove the last part of the condition as part of
> his series.

That's there because the decisions about "should we save this thing" are
taken in setup_sigframe_layout() and for a bunch of the extensions we
suppress the saving if they're in some sort of default state (eg, when
we don't have TIF_SVE set we don't output the SVE sigframe).

--VY579BsplRjShns6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcObXAACgkQJNaLcl1U
h9Buxgf7B6JxtnaQV7bcQdxU3W/45vjVnsJAj4oq+mBBFjqBV2314SqKcMSBrcJ1
xE3cGR9A04qVmbrPzOkCkiHLXWFD6I/JAZP9eAZGwJXU0Jr8fJWBnXFqDEUdWstw
XRJtiGFQkpdq/e0ijRt5DymHm18i/lEE/eg6Zi2o621Abzx9QNS+LMKkn9WpTOk8
W/xOE+DMhh2zpccEJ8VU2HgFJxZ/EcqC/fgkBlJTTApUuvHNdhue2DyBAgzIIsoq
2UYiKeiDTIkN07oUwJ7pRlftHSrLAZyM6WfK8+SZ2rQ1QzhTX8KUz5WzBw3BBpz5
7nn2tj3oFNHFeCRd88yFJnu0JH0lIw==
=yrSH
-----END PGP SIGNATURE-----

--VY579BsplRjShns6--

