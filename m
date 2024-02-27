Return-Path: <linux-fsdevel+bounces-12976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD27869BC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 17:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6446E2840EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 16:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98A214831C;
	Tue, 27 Feb 2024 16:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bu6/7a9p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E35146910;
	Tue, 27 Feb 2024 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050470; cv=none; b=JVk862IcPEsv7ankVuCofQvHcXMsUAzqM5Dx9YC8xXlgfCX4LsyNA1FN5P1Qw86Bzbk4WZeuRRzEB7+CwfIDGiX5EL9sgGN1O+H2Qi0NF1XMBqBn1jO7Qr2QqLBf/fdZ/sH5IQdIvxUg16yJOCPLY8i1gOVO5EAz3yp4RuqK9Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050470; c=relaxed/simple;
	bh=Z0zdHdGOC4SxL9F4fOxTZqBNKee6nTHQxhkxmuHIUy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtmGEeKuvPcDMXbTbYJ2zrtr3qwpbX7FrgzLdRf3R38mfB+0pNW3+8XJw1AfiJNMieyaMB+9LumYzYQT+TuEXIHnkHOXnDL8SYWZQfHNxz43A6EiSB25CPmKkXyV4iPiJTVEHTaL2dH23TOAJvgCra2rTyWIvEa3Ar8MKX04kvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bu6/7a9p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E15C433C7;
	Tue, 27 Feb 2024 16:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709050469;
	bh=Z0zdHdGOC4SxL9F4fOxTZqBNKee6nTHQxhkxmuHIUy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bu6/7a9p0+arHtaKXxCctuJK9G25JMzbW0pwbRP43HOmbuMNqCWXbIHivT+3SBYMZ
	 9Z4ouUH+AyfxbDMLHdHU7+7mkkDnVNyGnBHUcB+ZwwNRmRP51FhkAYq5CKL3UTbmoE
	 DB+xHeddLTXOtf9IKAqE0dvA/4PIWfU3ueNrn5DlO8HzLcOUtj8WjCcyUj6BNlb/xU
	 QbrcoC9cCuJ2bgEi1WNIcoMF7bSZ/e2/IG9KnSFMFnxBa2xeCX2bgrZGyUBPqxS/BC
	 mTscCuzUtLrJRJPe3S4yN50sSOYiYXLMTnAeH9A8fHrDV4npTQ3Xx1CJbJABG24CJK
	 KMCdpzNDk0URw==
Date: Tue, 27 Feb 2024 16:14:20 +0000
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
Message-ID: <4adb0c7e-34a1-4c50-b011-6e31ef8813a7@sirena.org.uk>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
 <20240203-arm64-gcs-v8-33-c9fec77673ef@kernel.org>
 <87sf1n7uea.fsf@linaro.org>
 <9b899b4e-7410-4c3b-967b-7794dac742e4@sirena.org.uk>
 <87ttlzsyro.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4XK/IPqd7iEUtIhJ"
Content-Disposition: inline
In-Reply-To: <87ttlzsyro.fsf@linaro.org>
X-Cookie: Please go away.


--4XK/IPqd7iEUtIhJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 22, 2024 at 11:24:59PM -0300, Thiago Jung Bauermann wrote:
> Mark Brown <broonie@kernel.org> writes:

> My rootfs is Ubuntu 22.04.3. In case it's useful, my kernel config is
> here:

> https://people.linaro.org/~thiago.bauermann/gcs/config-v6.8.0-rc2

Does using defconfig make a difference for you?

> Here are some firmware versions from early boot:

These are (as you'd expect) the same.

> It looks like our main differences are the kernel config and the distro.

Indeed.

--4XK/IPqd7iEUtIhJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXeClsACgkQJNaLcl1U
h9BabAf/cpgfEVM3rUB3E+ztSqzGFbC8vSFUf7Y8lhyyC2yCzJVvWROYle2Au1N4
JRDVph/nZGsbGjyJOWDudsQ8IfPw6m95s+21HkGPq7WI+97Y7gxQtf93zeMPr7Pd
HWCr3QDaCFB+Fi6cdhukIJ+Q0HmaQExEt5Enpg5/ntl1oqafk6GiF5f2Ltzno+UG
dWc07BNatMpKKSMict51j5K1n0Penjgc4B99WpRG3Vj5ErhBDRKjmTwTNW7qfRdE
zxAHyE1N+Q4QSsXeQUXtsLMPP1ieXKLPbf5FwcaKIZMuOS03xP5kKJZ3jmn/DOVq
V4ZcQAzA+dxVvH8SWCA8MFdxHym1mQ==
=vAyG
-----END PGP SIGNATURE-----

--4XK/IPqd7iEUtIhJ--

