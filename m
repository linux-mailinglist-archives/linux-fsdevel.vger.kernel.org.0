Return-Path: <linux-fsdevel+bounces-23756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A987932755
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 15:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6241C21176
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 13:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A0E19AD51;
	Tue, 16 Jul 2024 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEcc3cof"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86114199E91;
	Tue, 16 Jul 2024 13:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136094; cv=none; b=dsMORF1CQpzD9hEr+S/W6b1USZl1C5xjUNQ/nkNAgYBBSDXu8qX1hVcirwddgHjEqxJ18adiJkYenKwl8LQXSbN1o+SLl83R9wLlovc7mpSyB6q1wTrxsF4uvdLMKs8P3DY6W1NssVDQzyBMwrfe+o0O0c3TWMQkPfS2VvyDxJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136094; c=relaxed/simple;
	bh=MDYDDMId9Vq5nWSoKcWFrH/nU7E7vtMo3ZqG+CSN320=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YrgTaNT9pLxhrdJW0GgO8c/1zsX9Dgy2Z1HHgTZUT8jG4pIW5T1ry15H6vAPenuC4coqRXunX0Ol++CTCx+ILtwQiCqBeB7VaQk6zVgfOPbUMt2WQm4Holrn3JEjwk19mJr3OYcszvESRFUYdGTGxngqSCgjA17JVF3S6GDnMMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEcc3cof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65C3C116B1;
	Tue, 16 Jul 2024 13:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721136094;
	bh=MDYDDMId9Vq5nWSoKcWFrH/nU7E7vtMo3ZqG+CSN320=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bEcc3cofO5RnyXn9FufGyGU2WpkjaGtJrPT8aBi+b0H30Mo62bFcyv7BR5vjOzAWl
	 uZrJURdKoed8pFvaMONdv+jp+73wl6MZHY8lDrbhzA4r0k9MZJwwbEVAPTLUca374n
	 MKXWh/SA9A+WMrYqrLM47uuFxtJv4bwCU6gu9M/AMrrCd93cOOAIo80yksddlZ2XGX
	 HV8m+g1I5NmH04HdZstHzkTovWOIl4Tv9+QV2lJyJ5PaFFz/k2utvqCm0MEovL8kn7
	 TiQtP+tWgjgVZ+uzbvYTDozgVzwXtJdOIPyPXDVtGte3ugmBPAQmLKeTuEclvh1MpB
	 yNyt/Qcv/YbWg==
Date: Tue, 16 Jul 2024 14:21:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
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
Subject: Re: [PATCH v4 06/29] arm64: context switch POR_EL0 register
Message-ID: <91862b79-b29a-49c2-8a0d-653bb87d3d9b@sirena.org.uk>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-7-joey.gouly@arm.com>
 <3c655663-3407-4602-a958-c5382a6b3133@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o+3mIAah6T0Lu29l"
Content-Disposition: inline
In-Reply-To: <3c655663-3407-4602-a958-c5382a6b3133@arm.com>
X-Cookie: Think honk if you're a telepath.


--o+3mIAah6T0Lu29l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 15, 2024 at 01:57:10PM +0530, Anshuman Khandual wrote:
> On 5/3/24 18:31, Joey Gouly wrote:

> > +static inline bool system_supports_poe(void)
> > +{
> > +	return IS_ENABLED(CONFIG_ARM64_POE) &&

> CONFIG_ARM64_POE has not been defined/added until now ?

That's a common pattern when adding a new feature over a multi-patch
series - add sections guarded with the Kconfig option for the new
feature but which can't be enabled until the last patch of the series
which adds the Kconfig option after the support is complete.

--o+3mIAah6T0Lu29l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaWc9UACgkQJNaLcl1U
h9AE/Qf+Mp0vA/IFkYbl4mm5ponXV9Jh6x5rZSfeflZF96wTd3pBu5Y1PK36VG4R
hDFz7jcBPMBxn7afJA/mlfBPGWQXajmqTcK9TRVaWEG9rj54IZ7XCSiRItv2TwgJ
tGmxIj+O7pyTiDPz0cHxfxAlZ+Yz+RCe8YfKhbPXDxg51hu6UIWxYZ/v9aJtxC4V
tkXEFL+purD/K9Hp6wFTK3VAQFbsNyYcc8ulWXf3qGOHILnb8hznV4ei4BbqHKGk
TsqLVYHBT9RwW4q6RB2O9JeLOm5U7I17+YmBqEvZY/LIZzBtvZ/xYBsh4UCPt/6s
kNbCozOSV32r4nb/Z+kpJqbf9lA7ug==
=cS6P
-----END PGP SIGNATURE-----

--o+3mIAah6T0Lu29l--

