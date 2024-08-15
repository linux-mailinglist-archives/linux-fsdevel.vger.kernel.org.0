Return-Path: <linux-fsdevel+bounces-26067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F16A195361C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 16:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC6A1F216DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 14:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114321A0710;
	Thu, 15 Aug 2024 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkyWvQ4E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD391684AC;
	Thu, 15 Aug 2024 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723733157; cv=none; b=jj5c0fTu4xIjuCxAFvHP9NITdK5vB3vKMoXUeNsc2m98uWE94qHahge0AzZ/mI0eD3YzbBugm+dGlxE/c2HfHtSZle5OgtrJGSVOdz74u0QN3KJvpx5HmIbBQ5O7yVPCfeuENzEujw2eEKSrieO3h5eQJ/8zbMCzaq+0vtqxuLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723733157; c=relaxed/simple;
	bh=2cDt1K6+J5wSrcJZUtuu3LeNVSJEFjKPwrWj5SaKiNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEy+qjmTBK7+zrsCk3uuD9BrKaoDUkcoEaLUSHUdfeblwh4S5SpHIun+m7ZJTKJEL7J2lRPBmRaKeY+0n9c++Z7Zk81Ziv5p6sQWPzmz6+kcZJ7zYij6iS3+gf78QkYrstfTRbQGZ4McIWV1skuywhnQ5a1GI5VUNEKW2qBqJP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkyWvQ4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FD2C32786;
	Thu, 15 Aug 2024 14:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723733156;
	bh=2cDt1K6+J5wSrcJZUtuu3LeNVSJEFjKPwrWj5SaKiNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dkyWvQ4Eab0Mev50PZAJYqogMNDU85sEM8xyDLyMBRLPYfSyYMs4Toxeeac3zKKzR
	 SVYiz0K3D/g5+QdJDJf6nnD7Qy5wegctjwv3PhgGuZQY25B70KrgmCZZodWN80rYG4
	 xgyBL4JRJP0blqHfxeXBdOINIMqtjMPIDiU3EAy528V5A/8EzPPoOqwoWNxSLeqZJ8
	 aTicr1XYnwKnEUqDF1Xrp1mjm2FxzbK2B+hfsEryf1OceDTaZvHybOAYJGaTnae+Hx
	 m3AiyIQyKKbVQsZ8w/6axwsvY9uG8nz5g12owbbscNwaEsUNFWsKTMjQMF5DEvyvSR
	 epH5YoGP75B5A==
Date: Thu, 15 Aug 2024 15:45:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
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
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Ross Burton <ross.burton@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 23/40] arm64/signal: Set up and restore the GCS
 context for signal handlers
Message-ID: <c56fa974-88f7-4c1f-83bd-8c481fe0045d@sirena.org.uk>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-23-699e2bd2190b@kernel.org>
 <ZrzEfg5LqdAzgJ6+@e133380.arm.com>
 <08932f6d-01ef-40e8-97d2-08f0d2016191@sirena.org.uk>
 <Zr4EkmtUKop9o9wu@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3MLeToVkjySp9DbY"
Content-Disposition: inline
In-Reply-To: <Zr4EkmtUKop9o9wu@e133380.arm.com>
X-Cookie: -- Owen Meredith


--3MLeToVkjySp9DbY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 15, 2024 at 02:37:22PM +0100, Dave Martin wrote:

> Is there a test for taking and returning from a signal on an alternate
> (main) stack, when a shadow stack is in use?  Sounds like something
> that would be good to check if not.

Not specifically for any of the architectures.

--3MLeToVkjySp9DbY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma+FJkACgkQJNaLcl1U
h9AtQgf9EWahd20jQzZ5Dsh45BuaYqYLMeZdINXFGKq0fNzYErgx+xiHkpfbAaW/
b5F5wBNruWnW5d9ggUOMRlIRUCnVyNAc0dxH2QcmuYYHWZiHecjqNy0YjqvjQSrP
pQtbL9E5+BYHBHUWoMYk6VG/CyhqdfprAA2A3isd9pJwETxQ4ivAstUIL7IkWnSj
pJRVZrtPKkrMzPWhawrH/9/4KYx+6Pvt+MbX3074EcxifcRBuDuD2wvP6Zyp8NpI
/3JNJeUDARpgaYF8ZVZyqqldrLekwUHNqVqSfL8JEkLjkX7j77gzxw+k+WJLFg7f
mjLH7VvkpTbNVNlX4LER8RNMYYNNjg==
=bD/v
-----END PGP SIGNATURE-----

--3MLeToVkjySp9DbY--

