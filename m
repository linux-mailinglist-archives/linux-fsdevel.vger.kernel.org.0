Return-Path: <linux-fsdevel+bounces-24078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A4F9390B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 16:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7851F222CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 14:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9315C16DC2D;
	Mon, 22 Jul 2024 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjmEXCND"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D542E8F70;
	Mon, 22 Jul 2024 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721658694; cv=none; b=mi2zRqTLwgPmi0cSEbhw96S17RzGjdQZSpYPL3klM9w1oYL8OzfAPKHN+1JazF0JY9q7BqJeRYS0VQKWnD1KONlA9b3z6v2chQGK+3/u07mTrwJdn9M8Ujbb1SkwZA82lAUjUmi2YCDRhpE2enPDBKnRNA6fBEk9k779Ho+C94k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721658694; c=relaxed/simple;
	bh=19lbAMuG8/46S2vgOQ57EZ7eAEiw5QZgfuSPqQZDrsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2z2wjoXmnLpYkBpeA+5vmNE1ET12mSsNohMdue1lW2dOpQ8DsnbCL+6TibuoOUXEejP3C2CKMj2vDNuSInxzpQFP+27S3n3GSOtV7x5Mzg71oaSdJpICW5zXMmeevPLAdJUxiAV/kJmu8U5TjV3eiXHEZrCtaMyHrnfWJts7Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjmEXCND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A25C4AF0B;
	Mon, 22 Jul 2024 14:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721658693;
	bh=19lbAMuG8/46S2vgOQ57EZ7eAEiw5QZgfuSPqQZDrsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rjmEXCNDKBFkXhGlJsIiF/YiOAsxKiiVQ1yy0ea0mM7am81QSF76gClDv9enAtAlY
	 k5zMblh91dP2iCOQWwD6UXBINMw2SURV0D5VkPmSTcCj+7qrLkiTc9H5X2ZXYxh7QX
	 /ztn3FxVCqDdZwqpFFWuHB/egHyBWfmfrmpKrYkCGpLDHUdnmnfjb/anl9IGvbPEnH
	 XugwdYQn62/PfBmN2Sx/MlckvPbNVxoeQqCGdrWIx9EJAnA97fRcl1FAgUYZvFPWh/
	 St8tz1MT7X7blLPvAvrsbs+/p6oIUcWDkcQJuST7wIJtoLExPii3xtAVeQFrVH08LG
	 pTi8SManLPJQA==
Date: Mon, 22 Jul 2024 15:31:24 +0100
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
Subject: Re: [PATCH v9 38/39] kselftest/arm64: Add a GCS stress test
Message-ID: <19c8a2eb-1c52-43aa-a329-3dc245c966e6@sirena.org.uk>
References: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
 <20240625-arm64-gcs-v9-38-0f634469b8f0@kernel.org>
 <875xt2xojp.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fZmP/tHPENLmAEIV"
Content-Disposition: inline
In-Reply-To: <875xt2xojp.fsf@linaro.org>
X-Cookie: Everything you know is wrong!


--fZmP/tHPENLmAEIV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 18, 2024 at 08:34:18PM -0300, Thiago Jung Bauermann wrote:
> Mark Brown <broonie@kernel.org> writes:

> # # Waiting for 9 children
> # # Thread-4030: Failed to enable GCS
> # # Thread-4031: Failed to enable GCS

This is already fixed locally, just rebasing bitrot.

--fZmP/tHPENLmAEIV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaebTsACgkQJNaLcl1U
h9A1BAf/U0ze5vCUOiRu38u3xvKe2wO4c/NxU38BnN6U5lriKaPwnoC8WAtlYPBJ
67+s8YadLJLRgDMtuUHW85HuikmcDmVUs5SUM7HwwVd6qMVx9FYmMls8aA9Powqn
u0Y4vFhfQwlvL0aSBnYPBF2vjCXMYzN8EVHJaJhPJlB5HsZstADQQM77apbd9U2V
BD0gJukw9LhNPPTmNyuuBnF9jXXCAUXEpEosdsWYl4f6+msBc5abKIt1agzRJhFE
yYalLzSD/wqZOZGLXf/Cx/DzdJLC8/ahN8cI5MqCUDDQFLFnhV/vS2yld0/Cu0sw
qwhjMxP9NPq+uiruBXIU7nGO40rudg==
=Kw0J
-----END PGP SIGNATURE-----

--fZmP/tHPENLmAEIV--

