Return-Path: <linux-fsdevel+bounces-12311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5255985E723
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 20:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084041F22D62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 19:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DB385C7A;
	Wed, 21 Feb 2024 19:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fM7bxuzf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E284D83A06;
	Wed, 21 Feb 2024 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708543221; cv=none; b=LfEaDtLNfCxEXpkDasfer0/6tUxUNGHCBuQete8jVHb3bftuD1YwNE0Rw5INgggRD/GMf4ZACE7oqvKl3guoQaN2dq1s6tWdjF2AmJ2XP9qs4+kRY0UDtj6Sc/VEyX42c5x4Bn83ecjzVzTWiV4nzXJYZDS1agPmBFwpHR5cHvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708543221; c=relaxed/simple;
	bh=LHJE1R6CeCVbz5voxdhxWZEEGGRoTCqvuitIhyGxW/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuSitFXWqsfJaHykw+zFaWa8/gefwcdPGkxu+n6pXT+I/9pm6HaO9MINfXB2LZVzPYZJliw5AoDeWRrSel+ZCxpd+Lam+FJ/ijXMMO7JEjtZzft7HsQFfQvKltcxO4cHMib+VJ2I9cGE/fnwpsc89mKFZQlRHKtNcksjYtkL4Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fM7bxuzf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5294CC433F1;
	Wed, 21 Feb 2024 19:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708543220;
	bh=LHJE1R6CeCVbz5voxdhxWZEEGGRoTCqvuitIhyGxW/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fM7bxuzf37U7KgkBjE4t6xl7196zWQ3zUCNoJ+agd+QN1cy+Xyq7yQXJHO1ESLu+m
	 WfRkNjkseH24zdDLgFE1SQHiWbwcIsKTde/kK/nypgvvdaArvLxpMbxTv/DpPdea0Y
	 h/S2n8KTkPnE0y1deFIAUzbMSfmwY+RBO7FMARe9q8Qz3/FxPYnixoXp6/h5t4/vuP
	 uoT778pZQf+ryGuzNashUCuvUxs+4C4xh9U2NIQYurkPfiYpJq05pv7AaQTTfFstDU
	 3dg2YeZnziQRTHuGFAV/FX2fhdlhfvtEv0Qil9L1OpaX49KYycDzgKOwtGXtT8v3X9
	 UMMPgrMEFWVIg==
Date: Wed, 21 Feb 2024 19:20:11 +0000
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
Subject: Re: [PATCH v8 33/38] kselftest/arm64: Add a GCS test program built
 with the system libc
Message-ID: <084d97c0-a84c-49e1-a1e2-d864dbfcce0e@sirena.org.uk>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
 <20240203-arm64-gcs-v8-33-c9fec77673ef@kernel.org>
 <87sf1n7uea.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2wtnap7o07IPW6JY"
Content-Disposition: inline
In-Reply-To: <87sf1n7uea.fsf@linaro.org>
X-Cookie: The second best policy is dishonesty.


--2wtnap7o07IPW6JY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 19, 2024 at 11:15:57PM -0300, Thiago Jung Bauermann wrote:

> The only issue as can be seen above is that the can_call_function test
> is failing. The child is getting a GCS Segmentation fault when returning
> from fork().

> I tried debugging it with GDB, but I don't see what's wrong since the
> address in LR matches the first entry in GCSPR. Here is the
> debug session:

I'm simply not seeing this in my testing.  There's *something* going on
somewhere, I had another report of a similarish thing elsewhere, but not
in any way that I've ever been able to reproduce.  It smells like there
might be something missing with the page tables...

--2wtnap7o07IPW6JY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXWTOoACgkQJNaLcl1U
h9BQigf/fQNxlJZgGDgIILMsKObHoXWsq3JdCPlraW9xJegPTEC5/TbR57O6F0Ds
/m4Si6b75N7h1+TLJWetmyKnGAMNBss9qHx2swhi78CdwKsefp4GKaivaFWVKxRx
srdyCavP5tHvbc4O2WqN4A8HZY2ekXKnaXvmz/1DtfvKpV5hgYKBo99ISPLrMVpC
gX/jBaUd5GFOX6ImWBzN30pXfHRJXBr0DiXBrTlxoevDfu7GvQN4qECSqBxM2s1F
Q0vvblI/SBO9CX3h1Pnbdr4VleVLI3arjc4YTBiaPY8cVjHyb1RkUeUrRWVXRzU8
pzYSSKqd4kQ61qa9FEiZhZs13o9otQ==
=eqM2
-----END PGP SIGNATURE-----

--2wtnap7o07IPW6JY--

