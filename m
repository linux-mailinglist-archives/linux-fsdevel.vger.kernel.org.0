Return-Path: <linux-fsdevel+bounces-8276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8DE8320BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 22:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AAA81F216C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 21:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EEA3172E;
	Thu, 18 Jan 2024 21:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOjcivrW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EE714270;
	Thu, 18 Jan 2024 21:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705612253; cv=none; b=BYnylEICddo/lcVSCyl8pw+jBpZfj0zMzvshEkwDrOUnoGsaL7lLNi+W3nkEPx7BaMUTSlZZkWCW1xVNR+G0KpTm8QHCNkQ5V1FBdq9irt29XzSma1W0PND5iKJGBAw6rX+df868bApXsEJ19eiHGK04USadwQDiye6HjcmO1Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705612253; c=relaxed/simple;
	bh=f4pgnl8yd020hjFNUjJcTz/Gx6KZT1fbOEGiRHoWS0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjM5n//9w76i08Kfxt3/jLRsNEb/uSucSNVE1aTWOB3WtVE4S/4EVNx8y6piYuyCMzLlTL8Lupb2DN5zc7C5u6KcGOSQ4i8MYkyvy49g2opjEh+iUVa3IzYEGWYZzdfnbk+dPAPz7nGWiOzbTHjj63R4ztVsO0irA81r5GB8emM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOjcivrW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF08C433C7;
	Thu, 18 Jan 2024 21:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705612252;
	bh=f4pgnl8yd020hjFNUjJcTz/Gx6KZT1fbOEGiRHoWS0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZOjcivrWeVqiQ8DXbRajgXxCSi0AX3o34/4vHt4xY0ZnhzaET53Cz7aexMT8aHn4h
	 M5ArFyBw3UfbVpaf4/Z9R5jHEzG3cMVLydldQ+Gz+dB6E/xbSzGvtvCAhWKP3jTkVs
	 NeVoUXPOeaCC1aJFFLAMZi3JyZP5FBbanivHS3DIiDvoTRmSVlVFrh9gK+zgS4JuPx
	 a2NLXYIWfKGkWvFn23pJBDYEqqiOLFyGNR2wEEAtGQdnKptgaikIvDuNwf3KNWUSCq
	 wP+zvTqLzIH15uhXn7/NUWueHheuyrpj/mKTsg6rzfFSF0P0QejjHhX6c+rmg9EklJ
	 5GQ+WBkWh5hgQ==
Date: Thu, 18 Jan 2024 21:10:43 +0000
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
	Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v7 36/39] selftests/arm64: Add GCS signal tests
Message-ID: <94263c5c-817f-4dcf-8418-6c7e3c058557@sirena.org.uk>
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
 <20231122-arm64-gcs-v7-36-201c483bd775@kernel.org>
 <875y0x7f1m.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="doBW+2ZTusCkWc8M"
Content-Disposition: inline
In-Reply-To: <875y0x7f1m.fsf@linaro.org>
X-Cookie: FEELINGS are cascading over me!!!


--doBW+2ZTusCkWc8M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 16, 2023 at 11:12:37PM -0300, Thiago Jung Bauermann wrote:
> Mark Brown <broonie@kernel.org> writes:

> > +/* This should be includable from some standard header, but which? */
> > +#ifndef SEGV_CPERR
> > +#define SEGV_CPERR 10
> > +#endif

> One suggestion is include/uapi/asm-generic/siginfo.h. It already has
> SEGV_MTEAERR and SEGV_MTESERR, as well as si_codes specific to other
> arches.

Sadly the testsuite is being very clever with redefining siginfo_t which
means it conflicts with that header.  I'll update the comment.

> > +	if (!get_current_context(td, &context.uc, sizeof(context))) {
> > +		fprintf(stderr, "Failed getting context\n");
> > +		return 1;
> > +	}

> At this point, before any function call is made, can the test check that
> *(gcspr + 8) == 0? This would detect the issue I mentioned in
> patch 24 of gcs_restore_signal() not zeroing the location of the cap.

Sure.

> > +	if (gcs->gcspr != gcspr) {
> > +		fprintf(stderr, "Got GCSPR %llx but expected %lx\n",
> > +			gcs->gcspr, gcspr);
> > +		return 1;
> > +	}

> I suggest adding a new check here to ensure that gcs->reserved == 0.

This would mean that you couldn't use an old kselftest build to verify
a new kernel that starts using the reserved bits.  It's niche but it
does seem like something that should work.

--doBW+2ZTusCkWc8M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWpk9IACgkQJNaLcl1U
h9D18Qf/dkanHMRcVOLBO0KY2XdPTIfY1GyOkjJY1kaVS8NrmmBXUrDbi21xRyjY
hrG/NK4XolQfikIXkTHDmzK4oPapXDow6he4iR1c9zU0DnLSMp4VoXZ7ocIMAoBi
tQ10946KiS7b3/zM+TNvOJeQcoToWb8HdVsvesPbs3kMHXTGFOCXIIGP+at5Xn+d
jm35bqd8SAcCA57Xci4zNZm6G/40We/QeI3oAQjjrGQuCHeecQQAz1qMinbc5udk
98yjraA9J1Q0v5JAuH1ssAczoXX2hM7H7ZJZFu2x/lXqoq2bvjEDsJUJHybrb4d+
R77h7JGFnnC+PGVQbXKJpz1bueqP8w==
=5ri/
-----END PGP SIGNATURE-----

--doBW+2ZTusCkWc8M--

