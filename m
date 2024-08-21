Return-Path: <linux-fsdevel+bounces-26522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5C095A4B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 20:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B75B2836CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 18:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0371B5302;
	Wed, 21 Aug 2024 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTYagprE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944451B253F;
	Wed, 21 Aug 2024 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724264888; cv=none; b=tGgt1hL+ahC/lweNRiz6rfN0svV9X1x/UHj2IFEHyF8+9y0fHgN8bA8X4YtJiW9t7W2KIvubCeWHq2izpZOJb/p7QZSYJeTcvsvmGgqflb7tv3GCM+cUC8rl7pNDQ9UO7TU7UCWS+Zf9jXrETWo0b8R3jUXGkNq+zTM+Sc8pEGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724264888; c=relaxed/simple;
	bh=33baSij/lfUz4rEbu0DhfDZckukmuW2FH61KazHkxLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLeqNt7kTCZHlT5ffJWBGl1MmnKWBqd+m8lqb2im2Yk1a5rk67xmd8vcRZjpBSOi8ZFQjjHj5aXqUPgPBx3/JBpl7rgjTNq+Szky3PpI0JwR6crx5LttqIpUupeWzPVZmuH8jCIXJoDSFYRZ8zkF5bmJFrqFRfP2ITLrBuHosTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTYagprE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA21CC32781;
	Wed, 21 Aug 2024 18:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724264888;
	bh=33baSij/lfUz4rEbu0DhfDZckukmuW2FH61KazHkxLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aTYagprEzcz2g3EIW4SxspQ7iO18F5DjDWUNZgvbFQBngLuxfa6dpeP9T9dw7WcuL
	 wATPmQQbugIpTAh+yu8sQl3uSAiFbniz7t3a2VnwftqkWda+6Ps2U60RXXCERSDZKk
	 2G5yackwgc9NzDJc7QB/noWi9xSl7fY6yumKqreAng88x0/HI5LN6dTxOu0JwDYf32
	 p3tyUuzRIkNq5iNeYht0PNQ+RGraYbbe95MRQSJXxDFqT1bsLDmzRKGdCcZTHGY5YK
	 AJQoS+KuBojRbSang2TOeLaRZyoOISyOl2kL2kBHWHcU8AvSgrttUrgRRyzQGIPGaq
	 KzW+H6ExR6s6Q==
Date: Wed, 21 Aug 2024 19:27:53 +0100
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
Subject: Re: [PATCH v10 25/40] arm64/ptrace: Expose GCS via ptrace and core
 files
Message-ID: <58ee01de-88a6-4d0c-845a-3d5bebc0c55c@sirena.org.uk>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-25-699e2bd2190b@kernel.org>
 <ZsYqfJ3V_-ljqlwq@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XTSIK84UC9+qnNMX"
Content-Disposition: inline
In-Reply-To: <ZsYqfJ3V_-ljqlwq@arm.com>
X-Cookie: You are false data.


--XTSIK84UC9+qnNMX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 21, 2024 at 06:57:16PM +0100, Catalin Marinas wrote:
> On Thu, Aug 01, 2024 at 01:06:52PM +0100, Mark Brown wrote:

> > +	if (user_gcs.features_enabled & ~PR_SHADOW_STACK_SUPPORTED_STATUS_MASK)
> > +		return -EINVAL;

> > +	/* Do not allow enable via ptrace */
> > +	if ((user_gcs.features_enabled & PR_SHADOW_STACK_ENABLE) &&
> > +	    !(target->thread.gcs_el0_mode & PR_SHADOW_STACK_ENABLE))
> > +		return -EBUSY;

> > +	target->thread.gcs_el0_mode = user_gcs.features_enabled;
> > +	target->thread.gcs_el0_locked = user_gcs.features_locked;
> > +	target->thread.gcspr_el0 = user_gcs.gcspr_el0;

> As in the previous thread, I thought we need to restore GCSPR_EL0
> unconditionally.

My thinking here is that if we return an error code then ideally we
shouldn't implement any changes, especially in cases like this one
where we're rejecting inputs that are just invalid.  That seems like the
least surprising outcome and what we should strive for, even if it's too
complicated for some cases.  It is possible to write GCSPR_EL0
regardless of if GCS is enabled, it's just not possible to write it as
part of an otherwise invalid write.  The validation is checking for
unknown features and enables.  With clone3() we could relax the enable
check, but I've just pulled that out of the series for the time being.

> I don't particularly like that this register becomes some scrap one that
> threads can use regardless of GCS. Not sure we have a simple solution.
> We could track three states: GCS never enabled, GCS enabled and GCS
> disabled after being enabled. It's probably not worth it.

Yeah, I did give consideration to that but as you say I think it's
probably not worth it - you end up with a state machine which for the
most part only gets two of the states exercised.

> On ptrace() access to the shadow stack, we rely on the barrier in the
> context switch code if stopping a thread. If other threads are running
> on other CPUs, it's racy anyway even for normal accesses, so I don't
> think we need to do anything more for ptrace.

Yes, I don't see any reason to try to do anything special there.

--XTSIK84UC9+qnNMX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbGMagACgkQJNaLcl1U
h9Db9wf/YDOH2BjzBXwu0lqzdwn2i+txsrhK+t+d9GX2VzQ6TRQJVseEw3ZiryNO
J1DTR+iMp5FlHiA+dBqzqZs6Fm09BlHVaMuawV056J8O9fcpyhzG+xMMxoPyAika
UeVQkZEUvs2eE76O+txWVhVwfLbKWAspcwflXBcFPVd8iT3yQxAgcS4k/h40zC3M
h96mx+doBNKP+V9QlLlcLMiSsPS6VVN6PGE36A1uHbJWx03Kg133qsB+hzBPC8DU
mJUnsZprHcbNVOYMJa/HMExbUltPGbuN61YzZvRT3mXkX/eykU2RkhITaZ7p8H8m
SUu+YRFrKXGRJYWTXtUkcFtUO90vrA==
=5j94
-----END PGP SIGNATURE-----

--XTSIK84UC9+qnNMX--

