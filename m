Return-Path: <linux-fsdevel+bounces-25367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BF194B368
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 01:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D338282471
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 23:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9DF155731;
	Wed,  7 Aug 2024 23:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldPGJCN3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C943A364A0;
	Wed,  7 Aug 2024 23:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723072251; cv=none; b=adou6n3UW0KBVAdtYA+aSEZradNRXP/jdEEhi0j8IbCEiZ1hZ+pK3yOeG656wQfLcLTpaKJZP/yqYSlmH3wTJvEVaFefxVenXO3NJnoJ/P6/1CxZbOSzDJlCT3W7CnSHMv907i+l62aG1EbtFCs3/MdUNVtEoupqvvUMDz5pIFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723072251; c=relaxed/simple;
	bh=2Arp6skp4lsIU7gY1P9i7DjssGu8XkY+Mw3cDuEayR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qk06qg60/a+kOObOk0rRo9zSoolcbsonm6Ym15LmNazEZzwqA7VNFqyRdLeUcZIyoRQKpPHoMh6dJplLj6H6mzcsg1w1qdoJbUOgNMr6qvT32+I06XnCteLRC0jHZZPd7bE+7nhp/NEGM/PsgcwveBePe4l2SFPpdVYLt8TycrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldPGJCN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981DAC32781;
	Wed,  7 Aug 2024 23:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723072250;
	bh=2Arp6skp4lsIU7gY1P9i7DjssGu8XkY+Mw3cDuEayR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ldPGJCN3ZIDgEu+JqjWfyq8SgqSslLPbqwCyfHIbYErRgOIehLhNY8ykRxM5cqxN9
	 8zLt6qFaoEsTxmdXQlNeR0GOWyyv/7LlHYqTjDpl4km+Lh47gWxn+QwWAJaeeqkxcz
	 uey7J7Tw+gewcUdJBkGWJ82NhjTlRwlecbrGKGlxaayUVXo1f76DhrTcwNCN3CiL93
	 ultdDjdKSdDB7QJyUD/EV35Yp/s59ljLUg+KSXR6aZZe4Ahby+4ueC364F2qE305Qx
	 0/p7XcxLIbWOKxEwma0XAlfBY5zIca/keWPAYZ//Kqxe8p3Kfr1BpQ5agkDMyXC0M2
	 CHZ/DousmFKBQ==
Date: Thu, 8 Aug 2024 00:10:46 +0100
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
Message-ID: <ZrP-9gHsvVHr2Y5B@finisterre.sirena.org.uk>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-38-699e2bd2190b@kernel.org>
 <877ccsdkjp.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+DPYyleG5oZF9XZc"
Content-Disposition: inline
In-Reply-To: <877ccsdkjp.fsf@linaro.org>
X-Cookie: Your love life will be... interesting.


--+DPYyleG5oZF9XZc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 07, 2024 at 07:39:54PM -0300, Thiago Jung Bauermann wrote:
> Mark Brown <broonie@kernel.org> writes:

> > Add a stress test which runs one more process than we have CPUs spinning
> > through a very recursive function with frequent syscalls immediately prior

> Unfortunately, gcs-stress still fails on my FVP setup. I tested on an
> arm64 defconfig with and without THP enabled with, the same results:

Can you please try to investigate why this is happening on your system?
I am unable to reproduce this, for example the actual branch that was
posted gave this:

# selftests: arm64: gcs-stress
# TAP version 13
# 1..9
# # 8 CPUs, 9 GCS threads
# # Will run for 10s
# # Started Thread-8350
# # Started Thread-8351
# # Started Thread-8352
# # Started Thread-8353
# # Started Thread-8354
# # Started Thread-8355
# # Started Thread-8356
# # Started Thread-8357
# # Started Thread-8358
# # Thread-8350: Running

...

# # Sending signals, timeout remaining: 100ms
# # Finishing up...
# # Thread-8351: Terminated by signal 15, no error
# # Thread-8352: Terminated by signal 15, no error
# # Thread-8353: Terminated by signal 15, no error
# # Thread-8354: Terminated by signal 15, no error
# # Thread-8355: Terminated by signal 15, no error
# # Thread-8357: Terminated by signal 15, no error
# # Thread-8358: Terminated by signal 15, no error
# ok 1 Thread-8350
# ok 2 Thread-8351
# ok 3 Thread-8352
# ok 4 Thread-8353
# ok 5 Thread-8354
# ok 6 Thread-8355
# ok 7 Thread-8356
# ok 8 Thread-8357
# ok 9 Thread-8358
# # Thread-8356: Terminated by signal 15, no error
# # Thread-8350: Terminated by signal 15, no error
# # Totals: pass:9 fail:0 xfail:0 xpass:0 skip:0 error:0

and Anders also ran the selftests successfully, including with THP
enabled (as noted in the changelog those issues should now be resolved).
THP issues should not have been relevant for this test as it doesn't
fork with GCS enabled.

> # # Thread-4870: Failed to enable GCS

which is printed if a basic PR_SET_SHADOW_STACK_STATUS fails immediately
the program starts executing:

function _start
        // Run with GCS
        mov     x0, PR_SET_SHADOW_STACK_STATUS
        mov     x1, PR_SHADOW_STACK_ENABLE
        mov     x2, xzr
        mov     x3, xzr
        mov     x4, xzr
        mov     x5, xzr
        mov     x8, #__NR_prctl
        svc     #0
        cbz     x0, 1f
        puts    "Failed to enable GCS\n"
        b       abort

the defines for which all seem up to date (and unlikely to fail in
system or config specific fashions).  What happens if you try to execute
the gcs-stress-thread binary directly, does strace show anything
interesting?  If you instrument arch_set_shadow_stack_status() in the
kernel does it show anything?

--+DPYyleG5oZF9XZc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaz/vUACgkQJNaLcl1U
h9D82gf+KEl5xAmYb9cWom+7gcXMomlPJMrkA7dYPaZDmS1e+GV/mZGvgZoHdWQD
5vVHwhl1MUOzyDonNieLL2Oa07SBlqSmg8D6TvELS/I2CllFObqIVtNWO2d7DYW2
/fOtJrFUTKWlteufFlt34Q9f9zp0AMkeEWhKVhLL00MKm0/6eKrZsDPRN/4gbtbt
yY6VNkJCYivlodKM8zBXd/dkWKo3kMcl5gSYlVExD7tbMhwpdg1VLVn/Nwnmlb1O
/yOj8phnDdEZt6AbpagWi78WSdXp9K2KE5JohOtw+CQlaaK2ekeaswe6qwV8Ijn/
i2dbu6EJf382fN3bB+lB+CrVXX0UsQ==
=kdke
-----END PGP SIGNATURE-----

--+DPYyleG5oZF9XZc--

