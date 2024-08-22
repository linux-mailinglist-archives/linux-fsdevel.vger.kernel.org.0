Return-Path: <linux-fsdevel+bounces-26814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F091D95BBF8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 18:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94CDDB261FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 16:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FE31CDA24;
	Thu, 22 Aug 2024 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2sb31TT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DBF1CC8BD;
	Thu, 22 Aug 2024 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724344282; cv=none; b=DTWqIrxHwHFagProFnwsWCgmvJimWljg+vOolqUbFZPNMBsoCHrdCQ/IQ/0wXGWlMS6BBCVRTVJnWvNf28Qgc38F6Zs+hcLL6IICyaK6HBPAoqemMpnp1qVDNZGk+A1e0OkGo3Kmsz9uAjC/727/15EdyP6q2le7LYVEMq80qUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724344282; c=relaxed/simple;
	bh=VUg12QjX/BWOxsree9EbeHZn9D5q4/HlKniQvKwsUbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixQ51+kXdmAIxorFRL7qLYOP72rwn7IEN4sYxYTARGoSqCBGtLrqXClvcjMu5uZw/yzaY6mu71ygB4RT+EJHtm1ivQoz7SR60CKdf1J2ZOIlS0L0n7BiI1M1TuhDVOE/tsGaFh/Ygo2o6AtqPGJI8K5ofGLKrJXGN+pn0aC2ieo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2sb31TT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE19BC32782;
	Thu, 22 Aug 2024 16:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724344281;
	bh=VUg12QjX/BWOxsree9EbeHZn9D5q4/HlKniQvKwsUbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F2sb31TT5g+PjzoVukTl5h2JEC2kDVdeg7nBVbMScaaOxvPYuZaHoYkcfKlUrUN6P
	 AsOCA9l6P8infkmm70iBiMvW5dIOERWTQ8DWgNjEJ1ThbqA6Fv7I1JwDLV62zQTukR
	 uIUy7TwBZwgBqDx4i5WNaOdUnD5Ns5bWM3tkoJsQxPJn+hwFrG1SCONKmCCEv46TzE
	 fs6z5etBnMVissxaHq0/baQA6bOcLp3UsqAnuPSFdRIY8bItuV+mwfw3Wdd9CpGsq2
	 yFY4RK6kS2DDKBKyuZ2JhCcjro00ziexgiXQX3Afzbgxj66BCLhebdtOhVlwV3XTrI
	 yyU+GaGQKLbuQ==
Date: Thu, 22 Aug 2024 17:31:17 +0100
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
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
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v11 18/39] arm64/traps: Handle GCS exceptions
Message-ID: <Zsdn1SC_Ajrc3-GJ@finisterre.sirena.org.uk>
References: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
 <20240822-arm64-gcs-v11-18-41b81947ecb5@kernel.org>
 <ZsdczGTaMgZnEaDy@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ewesK6QkmZD/wpzC"
Content-Disposition: inline
In-Reply-To: <ZsdczGTaMgZnEaDy@arm.com>
X-Cookie: Your love life will be... interesting.


--ewesK6QkmZD/wpzC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 22, 2024 at 04:44:12PM +0100, Catalin Marinas wrote:
> On Thu, Aug 22, 2024 at 02:15:21AM +0100, Mark Brown wrote:

> > +void do_el0_gcs(struct pt_regs *regs, unsigned long esr)
> > +{
> > +	force_signal_inject(SIGSEGV, SEGV_CPERR, regs->pc, 0);
> > +}

> Just double checking: a GCSPOPM (for example, it can be a RET) from a
> non-GCS page would generate a classic permission fault with ISS2.GCS set
> rather than a GCS exception. That's my reading from the Arm ARM
> pseudocode, the text isn't clear to me.

Yes, we only generate GCS exceptions on checking values that have
successfully been loaded from memory or other GCS logic errors - memory
accesses generate data aborts.

--ewesK6QkmZD/wpzC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbHZ9UACgkQJNaLcl1U
h9D9lQf/RHcsNQy/AveAnVZZzgRTxMTttaUD1tUEFeexMusqT2Ar0MqopzgIKpam
lu4zjPI6W5uKaH9xBTV9Rpx//q9HIzraNH4NL9kJNl4NiY+04Y2QMew5hXyC4Qlb
bRkNLFpOdr3kWhYEizRFaoZoT/A3mk/Hml4UOB8SVQmGkXmizkEPy+z48sUlWHfQ
VsDqfKBBnFOkIz5rYVMZP9g/Q6uYE5meFpo/sTWSP9X8S9XUL4GOLpassoZA6vPq
quUdPJfme+jeZI0gN9Rpuktzc6etbvVb5I/pf71dk+Zqr/hbgAaa+gmdQQsOpYdU
K9DAZ5xndPmiuX7YI36ktz2o2+0STQ==
=iVqg
-----END PGP SIGNATURE-----

--ewesK6QkmZD/wpzC--

