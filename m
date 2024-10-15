Return-Path: <linux-fsdevel+bounces-31963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F22A99E606
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 13:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC99F1F2497A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 11:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD85C1E765B;
	Tue, 15 Oct 2024 11:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbeM88be"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D69815099D;
	Tue, 15 Oct 2024 11:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992257; cv=none; b=UpbB0qOMXU6EmTG7vswSEZV0zWQXo2Kl4Mrl9N4TJqLsX5cQXKP30YO2GaAEJ17xyq2DyRvi4KbqBRyMJ2TS/ZadY3aa0sIQI/2gwinxhCjDsNi+coGpO/we/hOrbRbgQp18hlgjNT8mb2E6SzE3TFcm4zsMD9jgECS+0JpxWX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992257; c=relaxed/simple;
	bh=nzKkooEEihDyJVJuqXRx5VvoSpX/RR5Bmk9kAI/CNcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blJ0t3cQscvCGZraKv736BQHBdrg7zoI/4QI2LZhy3Z4CMxQucFrPeJm3mWvsxYPs6rmiqWlvVmlIDoDcRwoYp8QYgHl1NwUPUuqmt23J6FpYBO88qWvSgCVeh9UGFfBWOEjpb2Ws/ul22RHAPszPHkjHLUX5pDletk8VGRqi8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbeM88be; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855F2C4CECF;
	Tue, 15 Oct 2024 11:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728992257;
	bh=nzKkooEEihDyJVJuqXRx5VvoSpX/RR5Bmk9kAI/CNcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HbeM88beLvexpIibuyARfwJXtbdxo9ki+MlIaadD1gh0a7YVjYtcTdRoEMkoAlF4e
	 f4s7KvHkYTwinGlbPzN4xftfw5YTVc44PcOBAGfyD5v5p3V/xuc07GAi38/ajzMste
	 lLRn5hcLEoGxFfA+bKYQ+HCxOn3t3ZTtcTYNuIF3iQBHbFc/hG4PMLC8CZkXiqsMmG
	 aHw88t8V9rFcpnkoolv/5Eq4fzj5MwWj0igxO5CcSAl/gnWNOpQfabc9yW8MmCu7zo
	 QPGOztI2WwQvoq1Bexuky4J0Oe/Ti2n7x3GnbRyw4SrJN/StBLvUd4yMlXRexkwYwb
	 7duKxT/HAPulg==
Date: Tue, 15 Oct 2024 12:37:24 +0100
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
Message-ID: <090857dd-979f-4071-9772-8d0053ff361f@sirena.org.uk>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
 <20240822151113.1479789-20-joey.gouly@arm.com>
 <47e1537f-5b60-4541-aed1-a20e804c137d@arm.com>
 <20241009144301.GA12453@willie-the-truck>
 <20241014171023.GA18295@willie-the-truck>
 <20241015095911.GA3777204@e124191.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W88ha9UeD6OkiR51"
Content-Disposition: inline
In-Reply-To: <20241015095911.GA3777204@e124191.cambridge.arm.com>
X-Cookie: New customers only.


--W88ha9UeD6OkiR51
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 15, 2024 at 10:59:11AM +0100, Joey Gouly wrote:
> On Mon, Oct 14, 2024 at 06:10:23PM +0100, Will Deacon wrote:

> > Looking a little more at this, I think we have quite a weird behaviour
> > on arm64 as it stands. It looks like we rely on the signal frame to hold
> > the original POR_EL0 so, if for some reason we fail to allocate space
> > for the POR context, I think we'll return back from the signal with
> > POR_EL0_INIT. That seems bad?

> If we don't allocate space for POR_EL0, I think the program recieves SIGSGEV?

...

> So I think it's "fine"?

Yeah, there's a bunch of other stuff would go badly if we tried to carry
on after failing to allocate a signal frame.

--W88ha9UeD6OkiR51
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcOU/MACgkQJNaLcl1U
h9BfWgf/eSDT7mJTq3m8uQf08GvOUXMDhZbrgXOWwb+FyP6aWAAddUEovPEavEvc
iv7L9TzG/BRu8Dn9feF7LHlXUbcynAzscFgaysXUrafVyKatccR5v1IhGvNyzdeX
sUP+mTNHfLoIh5AQA5WfUJHN47Jq9/O1R1cJ/BgYWKlMgbEAMHFqKknfApuV7K2Y
S6PpBawO6LvT641x+zS1Vcl+Y7jFRkHt89aLWfhetheuo6f8o2Lc1qBHN4f6kqXp
iR7moBoquhONF4SuwZcTIeBXOuRRFTW8GdZNm/iVt6eYJeKf4Vv8aAhun8+Dam1y
crxvSRFOp4cZ2VKI+zWNCKFw+nIBZg==
=o0Ti
-----END PGP SIGNATURE-----

--W88ha9UeD6OkiR51--

