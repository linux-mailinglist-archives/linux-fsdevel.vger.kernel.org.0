Return-Path: <linux-fsdevel+bounces-23507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A6F92D83A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 20:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889E71C21138
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 18:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7DF19644B;
	Wed, 10 Jul 2024 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBignoqF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0B31922E3;
	Wed, 10 Jul 2024 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720636024; cv=none; b=Ws2UaXNSHwuHpw55JdI6RSS7PQ8+MMaCALHCSqtq/K7SV5oVZ40wGwTg76NEBMmZF9kHkbZ+eMaNnfbPESo2B8hipw0k0W9dYiYCMklBCENCOvv6S0EL68o16TZX5ZtlRO4nnctwiTiEryJtWX1d5VjaHwXQDxGQL6N0eVbz8UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720636024; c=relaxed/simple;
	bh=eRrtqZRqKI+Vs713ksZJJnhpC7362rwfU+pQUCdgXy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPeosFbvqjlyQYn1QY7GP5ha88SL7uqkhqj/oPwD8LsWatiSlC2EXsBnCkSq9yY9tpaRjrCuFH39gYyjskTz6WdSD1N+Os45fHKoGF/Y8Cdgmw6v0/yaK9kVBytpHWZDY5TX7Hm9eqCEeMEJH2YhttFQlFx9+k1gwwxxklLVaOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBignoqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5056C32781;
	Wed, 10 Jul 2024 18:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720636023;
	bh=eRrtqZRqKI+Vs713ksZJJnhpC7362rwfU+pQUCdgXy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kBignoqFgMiQnAofIwr6TpBgYH9jPjzRaSC842ug8+rx6x5ll0CjTdOuNwKz+XNaU
	 NDvkrwV2QNWMtc2QwoU1ijOz5da9rUzzZ4Zm4X9y1ohMBoG7CVKn0v8dUDWTmbo5kp
	 qCrq3abaj3XVJlXugg7JTU4S4r1FduVMcT4Z37pYvXrQ+HC5Pfyh6axADebI74bLMd
	 mL+FCPzGJMJSDDh/UgJFPTRSJhQcGB2O3dEluBrE8THwZhBROKgdbzxw1XeKE8fCoR
	 WqmFYL3/Bn0OvLOJQI+kNsc03yBZkhbSjm+4JlasoCc+ZLBwTbq5WG/vpdgUXOB+/4
	 KqrO9fqPgf3Gw==
Date: Wed, 10 Jul 2024 19:27:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Florian Weimer <fweimer@redhat.com>
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
	Christian Brauner <brauner@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Ross Burton <ross.burton@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	"Schimpe, Christina" <christina.schimpe@intel.com>,
	"Pandey, Sunil K" <sunil.k.pandey@intel.com>
Subject: Re: [PATCH v9 05/39] arm64/gcs: Document the ABI for Guarded Control
 Stacks
Message-ID: <Zo7SdDT_cBp6uXgT@finisterre.sirena.org.uk>
References: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
 <20240625-arm64-gcs-v9-5-0f634469b8f0@kernel.org>
 <87a5iph6u2.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GNMZNZkOBV+voqRu"
Content-Disposition: inline
In-Reply-To: <87a5iph6u2.fsf@oldenburg.str.redhat.com>
X-Cookie: Your love life will be... interesting.


--GNMZNZkOBV+voqRu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 10, 2024 at 12:36:21PM +0200, Florian Weimer wrote:
> * Mark Brown:

> > +* When GCS is enabled for the interrupted thread a signal handling specific
> > +  GCS cap token will be written to the GCS, this is an architectural GCS cap
> > +  token with bit 63 set and the token type (bits 0..11) all clear.  The
> > +  GCSPR_EL0 reported in the signal frame will point to this cap token.

> How does this marker interfere with Top Byte Ignore (TBI; I hope I got
> the name right)?  The specification currently does not say that only
> addresses pushed to the shadow stack with the top byte cleared, which
> potentially makes the markup ambiguous.  On x86-64, the same issue may

Indeed...  Given that we use the address on the GCS as part of the token
on first pass I think we could get away with just using the address and
not setting the top bit, we'd have an invalid cap pointing into a GCS
page which shouldn't otherwise be on the GCS.  I'll give that some more
thought.

> exist with LAM.  I have not tested yet what happens there.  On AArch64
> and RISC-V, it may be more natural to use the LSB instead of the LSB for
> the mark bit because of its instruction alignment.

The LSB is already taken by the architecture on aarch64, the bottom bits
of the value are used for the token type field with no values/bits
reserved for software use.

> We also have a gap on x86-64 for backtrace generation because the
> interrupted instruction address does not end up on the shadow stack.
> This address is potentially quite interesting for backtrace generation.
> I assume it's currently missing because the kernel does not resume
> execution using a regular return instruction.  It would be really useful
> if it could be pushed to the shadow stack, or recoverable from the
> shadow stack in some other way (e.g., the address of the signal context
> could be pushed instead).  That would need some form of marker as well.

Right, we'd have to manually consume any extra address we put on the
GCS.  I'm not seeing any gagetisation issues with writing an extra value
there that isn't a valid stack cap at the minute but I'll need to think
it through properly - don't know if anyone else has thoughts here?

--GNMZNZkOBV+voqRu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaO0nMACgkQJNaLcl1U
h9CYNwf9FL92M924ZTMgdzdOGnvfj92Q8ImGFAmDoUP3IjVPivJTPYhDuY+GaQaY
hojzU0+/ygci8GNBa3kaJGdT2kzo4J6aMfzV8Lw5OFhjfZvg98gQbw+HeRVou0BB
trtAQLx/+CWEYHy1qXMPQ3jRHuINOT80L4T321NSPyd7rlSksPpZU/NqHmUI9iW9
MpODGOLfCOg2W3CrQMA8AT1F09NeC4fBr+XRq1f3PwskzNRz/DR89M1amdCG7bky
oOk/WAsSGY8RWuY7/GurREwf7vUc1akIFax3lqDscpCbSuZ89FcFfs6YEAUqgq86
qV5kGewLUdqaGwutNJRSCAV+QkJXjw==
=dJd9
-----END PGP SIGNATURE-----

--GNMZNZkOBV+voqRu--

