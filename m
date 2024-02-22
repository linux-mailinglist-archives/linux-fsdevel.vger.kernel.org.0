Return-Path: <linux-fsdevel+bounces-12514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E4B860347
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 20:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81719B2FF73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 19:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDF4548E9;
	Thu, 22 Feb 2024 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtyLjiQP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E12A14B806;
	Thu, 22 Feb 2024 19:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629073; cv=none; b=qzYhGGzXT5I/lkRWhQMYhSedYZ2Ea5qfY2F5+F+aAl3Cxo0SOuNQbatURdB7a8MG4blKLD249YBDT6V4ybMVkfYuBFvd0qaEw/jqtxxtKz/f3mjE+Ayen+xNjJXVzEbnPudL9jTO5YwXLBNGhYTB5Bk+C0ejRkYRqyB6fym2n0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629073; c=relaxed/simple;
	bh=8nrfNIHr+Eb25TRq75f4NF1/J8WEqatyymrtaLx6QLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRxvJ5DGdITMNMNUMtFn8ihph7M0ZtPjbfI6UreXfh86kIFgVJN9ozmbVwt/ZK3tLnln9AWaJlIMgqH48SzjBHdB+9a8tbdU34/1zsaaS/tc+yTgaooq/+cPRMIPtn5S/hGclEOSGASGuCmR2H1tm0mcUqvGKtlhUvxvy+4ZUx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtyLjiQP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0452C433C7;
	Thu, 22 Feb 2024 19:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708629073;
	bh=8nrfNIHr+Eb25TRq75f4NF1/J8WEqatyymrtaLx6QLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qtyLjiQPSFvaJ9M7rV182imqkcwMJbcYO+r+dMGBtOYxSYpBaVnRvNZ11XJBROR9e
	 sFol8k1v+wYlFvUyUBro/7AQx2+kDhj5NNqwRD48ht2iA7YBv6eSnjKNmaHOBzNY49
	 rCeBnV+yiSRZ9mKiMtIIEvMu8x1IIfnswGl/xXqSXqac+W3bzu7M/y7q2JSc3d+Esh
	 ud72RE65wIOLdDAYaE/5y0Ovalrhl4By/n4OFtjms2QwzNoKpCgzpJBTr/WkDAs+28
	 qka5RHZp4Vb35lhxNepvftYRS6jQtzsIH6LXS5xsnjOXHpO0swqcwz1+VYW/6fI51S
	 2PJtnLCwdBOSQ==
Date: Thu, 22 Feb 2024 19:11:04 +0000
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
Message-ID: <9b899b4e-7410-4c3b-967b-7794dac742e4@sirena.org.uk>
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
	protocol="application/pgp-signature"; boundary="ZHq996jFPNViQlH3"
Content-Disposition: inline
In-Reply-To: <87sf1n7uea.fsf@linaro.org>
X-Cookie: I have accepted Provolone into my life!


--ZHq996jFPNViQlH3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 19, 2024 at 11:15:57PM -0300, Thiago Jung Bauermann wrote:

> The only issue as can be seen above is that the can_call_function test
> is failing. The child is getting a GCS Segmentation fault when returning
> from fork().

> I tried debugging it with GDB, but I don't see what's wrong since the
> address in LR matches the first entry in GCSPR. Here is the
> debug session:

I believe based on prior discussions that you're running this using
shrinkwrap - can you confirm exactly how please, including things like
which firmware configuration you're using?  I'm using current git with

  shrinkwrap run \
        --rtvar KERNEL=arch/arm64/boot/Image \
        --rtvar ROOTFS=${ROOTFS} \
        --rtvar CMDLINE="${CMDLINE}" \
        --overlay=arch/v9.4.yaml ns-edk2.yaml

and a locally built yocto and everything seems perfectly happy.

--ZHq996jFPNViQlH3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXXnEcACgkQJNaLcl1U
h9A9hgf+IJIWILnaAT0TG0s4fwHDFwBgAEwmbr/85IsiE58YLlQn3tHAkAETsExB
EtAk73IgOoaGfvFDcKF9Zq3PjE2iQ3r+Lh1A6/nyUdQBcMaZSES4ioXx5cwwjqFX
m6lWkAiAzHxqFN++5z9gfq4lT3HjZQ3TFVE8y4Ij6vmmOeTIINFEGovAi330xkEZ
prLXALb7+ONnUB3jG7VDY7Gx7HF+jt2Qd9gAz1KNNrBCEJT2fImUVEI1P/15iww7
Xxm2Udbwd52h580B1x1sa7tMEFRi34tvmKx+2HHSgGFQ/a10LFpE4VnsW1vHUzGn
2k8W5X8LkpXaHbgoXUGBMqDMFlKkWw==
=owiX
-----END PGP SIGNATURE-----

--ZHq996jFPNViQlH3--

