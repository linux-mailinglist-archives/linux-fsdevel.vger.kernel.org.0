Return-Path: <linux-fsdevel+bounces-25403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2A694B8E0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 10:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4418CB28318
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 08:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68E8189910;
	Thu,  8 Aug 2024 08:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jc1TkavT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C24E139CE9;
	Thu,  8 Aug 2024 08:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723105122; cv=none; b=r2Sc1BAQ2sdfm7x56R3lZ8Pw18wV2ppOa+JJqx7Ix//YySXCHJT59Q48UUb4NaWMxJ6I73LevuKLLWDn+TYg8M8NtlGFLhgYRKfrwJ+wmDmYUpCmzCf1y/ccFe9nei2DkjqeLOIaAT6LiGDGvWY1ujL9xdPj9H60U+EZHCi/L4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723105122; c=relaxed/simple;
	bh=BR4CYQvHKo7S4XehLC4CADBELA11Nm62X+WdUtFf9n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/EXyhZHzeh//IruO0XLJOhbi0m6ubi7jjKjvbAuDmBSSnBkob5yVkc5fVLP14wz1b1pTm0maLxr9DSM+NXnYG9CW7H5yTAqvuBLCBgAuXyvXduq34bq6robDQT12j/6C9I1UsXFSTaKuF86p1Q/PGDfHeAiJR0mPL00eDKMd2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jc1TkavT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F67FC32782;
	Thu,  8 Aug 2024 08:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723105122;
	bh=BR4CYQvHKo7S4XehLC4CADBELA11Nm62X+WdUtFf9n4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jc1TkavT0yEwNQChojDNn6AzGcsiESQp68rBPCuDzS3h7cmm5mLAyY/voHLXit3ob
	 YkYUfwcDxzH57mFobw6RuiTbcQDB7A/Dj18LPpDs/7TM+IzPBk1iMMJa8aGs8NIabQ
	 rLTZBdmlTgnZinuKZ6W70lM90r+vHQruMzAhCDUOcQPyLqDx4HgggSMUhP/irHTGzK
	 XLQkATMF3M9dx/Iw7RIjCYaaU8Opo84nZlHK4TCSxzmpVukJESm7/IP13d0V+6AyDb
	 xJw618pEuua6MmBDeXs0tcK8qgBBc2CVlYuyDwUg1htX4TnGHXSl1aUscA1F2nWxgC
	 BiJGXD7RqbUwQ==
Date: Thu, 8 Aug 2024 09:18:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
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
	Ross Burton <ross.burton@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 38/40] kselftest/arm64: Add a GCS stress test
Message-ID: <ZrR_XZ3JCCIrZUIo@finisterre.sirena.org.uk>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-38-699e2bd2190b@kernel.org>
 <877ccsdkjp.fsf@linaro.org>
 <ZrP-9gHsvVHr2Y5B@finisterre.sirena.org.uk>
 <87y157cz2h.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2xjwlae8dVoFu1hA"
Content-Disposition: inline
In-Reply-To: <87y157cz2h.fsf@linaro.org>
X-Cookie: Your love life will be... interesting.


--2xjwlae8dVoFu1hA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2024 at 03:23:50AM -0300, Thiago Jung Bauermann wrote:

> Thank you for the pointer. It turned out that I accidentally ran the
> selftests binaries from the v9 version instead of the v10 version, and
> the gcs-stress-thread binary failed because it was using the old value
> for PR_SET_SHADOW_STACK_STATUS.
>=20
> Using the v10 version of the selftests the gcs-stress test passes. Sorry
> for the false alarm.
>=20
> Tested-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>

Ah, that's a relief thanks!

--2xjwlae8dVoFu1hA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma0f1wACgkQJNaLcl1U
h9AAlAf3QAXjvC2gygXbsaueHos4q0nKMAX2bdp+mK3zjoJgg9+GqHPoEFx3Efja
cj5Ct4enLdN36SwqP5OU/agevzvPdKsT2CstNckW/VhAbkgbEi4F8w62q9q2NBO2
gyXPx0aWtgmzptzEPgrEl8+PeL/kyPB9DVnbYGfMI5X2xeMgn4XRyZYjLYuuBWAR
2BlS1DNybUyfO+005zhZnrjlbTN56woklGF9gOfbNT8HoKpWh/VcX9giGP9v/EFi
e+Qpos4Bb9+b3JKeJo2EFjdgvborCnQQJxvGSEMp7QB9wrOs0QsrrhD+Jvs6rmcg
J0pHE5R3OyGMXNNpg2MHtg9o1FPh
=uK/+
-----END PGP SIGNATURE-----

--2xjwlae8dVoFu1hA--

