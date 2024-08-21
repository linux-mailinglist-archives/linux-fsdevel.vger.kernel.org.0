Return-Path: <linux-fsdevel+bounces-26469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6791959C54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 14:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4F91F21E69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 12:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8495192D87;
	Wed, 21 Aug 2024 12:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2vqtqLz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEC31917C7;
	Wed, 21 Aug 2024 12:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244512; cv=none; b=JX+w2oJ6v0qH6V/y75HVAeCpv2Oj1hsOHzHlvrCFRRT5qwYtPkDXL3XQ+W+6buMGalPG7JaD8/QvMv9eTZtDAJroyNCJPAPobNb9cgG6K6gsSi8OkPNi4zMJvuM7xhwvY7Ifu+j2Z5wyp6jbjVEHirqbd7RbKHJjwNQk+9iMNmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244512; c=relaxed/simple;
	bh=j9HZBA2/5Wb2g40y9Oti29HTzjGioJbne5mKkeX2ur8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A80GpX62+fOBxHDYX0Ou5X4S770j0ck6qEMMCqkm33ZcNdhNEIMoRG/fyJneckYGGD/ymO86b60gH2EmpUgDpqDBttkGSQKneRr+fFhw1TkTzwVpa+iVoJt0mSnAdM2j71tYg/NJzxwKk7pHyQ3ENC9KCc2u6eOYCcMU9KBjCDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2vqtqLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34586C4AF0C;
	Wed, 21 Aug 2024 12:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724244511;
	bh=j9HZBA2/5Wb2g40y9Oti29HTzjGioJbne5mKkeX2ur8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c2vqtqLzx77yK+jri4pI05ZBvo2YloFCkoCVtCEjRuNnOxfTyJdeVqAID+oks/Got
	 k/MOAywNrA9LkLm2vhxFrX8HojrmEpCpPMFZ8usZAOfEXdFUi9ZJwugyMFj8wDYOpP
	 J1p1m7nAlRo1BJ53vsZ41xGztHqtr9cQpA/9TG6W3AYjgGVSZYvjFqKjCbFotL/+sN
	 WOBnbQJNg1ix3kDwZLLHWgSh5TWlK3ROmZdRmEhC1vOJVT/Udnx4TyTf9FOU8SDCdC
	 IYiUPSkNc7T8xR3pNt74QmD397GNbk0kklwH3BlYq4s8DCTEhzbg4+mFWP0qXvQSXc
	 HGPkV5gyPIOuA==
Date: Wed, 21 Aug 2024 13:48:22 +0100
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
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 19/40] arm64/gcs: Context switch GCS state for EL0
Message-ID: <3bc63a7e-0cb7-483b-9054-b52727997b6d@sirena.org.uk>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-19-699e2bd2190b@kernel.org>
 <ZsMwhdmE_Ai9BbM9@arm.com>
 <0f6fd3ec-2481-4507-af0e-3cbbb7406b54@sirena.org.uk>
 <3b316422-7f88-4f5d-a691-eb9209ec4ba9@sirena.org.uk>
 <ZsWqTtCq1mNJH1vz@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qtdMReCOgtjtAPvI"
Content-Disposition: inline
In-Reply-To: <ZsWqTtCq1mNJH1vz@arm.com>
X-Cookie: You are false data.


--qtdMReCOgtjtAPvI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 21, 2024 at 09:50:22AM +0100, Catalin Marinas wrote:
> On Tue, Aug 20, 2024 at 06:56:19PM +0100, Mark Brown wrote:

> > I forgot when writing the above that we always allow reads from
> > GCSPR_EL0 in order to avoid corner cases for unwinders in the case of
> > asynchronous disable.  I'd expect that to be cheap to access though.

> But then gcs_preserve_current_state() doesn't save the GCSPR_EL0 value
> if the shadow stack was disabled. At the subsequent switch to this task,
> we write some stale value.

True, we should make the disable save the current value.

--qtdMReCOgtjtAPvI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbF4hUACgkQJNaLcl1U
h9DrbQf/SQgnftiL0Tbvv1xffP9U4UoVPIul2GtdtgQHIDIzT1ukcsmQhdRliW8p
YkPVH3S3HbTM+Qtdp/kLSqVJHoK9rDDUsUJYlLAIBhC0dxhz6vEeOekbUti1UKFB
hdq/nUQDHb0LMufsGWvFir+5WNZkrUMFajAkS8FQ/0RFAA8IXmWgihu6T+Lf1wu2
TVR7gLXkxw51w03S8rD5D4xGzNLF6xXKU50cftHNVPwu8zsPbXCbu1jIpaPVPCXM
oWKLc3IOSmG0w3XNoWb7Ki07+H0OmcAbrXvIDK/8FLyyHrcehyy+teM/H/AJqJtt
gDCFIXYlvUlLXHmodMUWCk2uNYAYXA==
=msk7
-----END PGP SIGNATURE-----

--qtdMReCOgtjtAPvI--

