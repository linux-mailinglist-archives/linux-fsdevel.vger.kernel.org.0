Return-Path: <linux-fsdevel+bounces-57058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F561B1E7BA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 13:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 710F57AA9B8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 11:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8E7275855;
	Fri,  8 Aug 2025 11:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlH2z2/S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E27125C827;
	Fri,  8 Aug 2025 11:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754653725; cv=none; b=rb2vZ8Qjl9+1/jnZNdtdPz/xxc8R5nM0ulPP6lHHfXIa5rdKJImSQAvTEmPPzEWYXcbi7XXfxmsmUJFvkiCFpA8XiDuW/ohp5PBN1ADC/RyHp0vk0HGZBOGmIladYIpl3k4vz2gVjgSPHnzBdxpuaiIM1emfVc6KkcEgz52lEYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754653725; c=relaxed/simple;
	bh=FUx4gUgdyZ2ZZBXuzAMKD50bvkFnEcWtdMYMuJy1cVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGwE/Z/fk7JD4UrBrzwpoch3JP8/PAbCDAJNWqm/HCmCeLY0Oos1nEKnmv69TNbH4yZVMTLWjbHRdmSea5O33HuOI4nO4xjqC992KoaNFgeaW+taVbZNcomiYrVMFTMsCsFEfdvQJx2fPAXxUt8kKE1XKBxpsHnWw0AhqS415OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlH2z2/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFFEC4CEF1;
	Fri,  8 Aug 2025 11:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754653724;
	bh=FUx4gUgdyZ2ZZBXuzAMKD50bvkFnEcWtdMYMuJy1cVM=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:From;
	b=KlH2z2/SRGW4K4fN/lCfwfHAWCLsioLuNXYi0U8bGmXfTGaqjSCRwOhCs4s6TOA0J
	 7X5PzrzWTGmySfiKXxgGxB0TXo1/sEh2IwxOimdqCIM5itio7QuZye5qUFhTiowsro
	 g9QGixSNwxKrLcq5ITi3jqk67TuJhrezSoeLBNFz3QMy7WAmsXR3PnPszSWAp/YNRf
	 EpX42Uy/odYqRyAa1Gq9Pu3xMZtrRg9Wroqn8PxqGIn7GoY01TQOQU0yKZO8i1uzel
	 dv/TdTFEOVjWt68sUn36VVGp+5yBeS/m5Bp5b7ElzfFVkSOFUCDepl9vRLQpiKGtKo
	 ASrYLKLOSRMsg==
Date: Fri, 8 Aug 2025 12:48:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
Cc: patchwork-bot+linux-riscv@kernel.org, linux-riscv@lists.infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	akpm@linux-foundation.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
	lorenzo.stoakes@oracle.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, conor@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, arnd@arndb.de,
	brauner@kernel.org, peterz@infradead.org, oleg@redhat.com,
	ebiederm@xmission.com, kees@kernel.org, corbet@lwn.net,
	shuah@kernel.org, jannh@google.com, conor+dt@kernel.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, lossin@kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com,
	richard.henderson@linaro.org, jim.shu@sifive.com,
	andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com,
	atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com,
	alexghiti@rivosinc.com, samitolvanen@google.com,
	rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org,
	zong.li@sifive.com, david@redhat.com
Subject: Re: [PATCH v19 00/27] riscv control-flow integrity for usermode
Message-ID: <09081487-89ac-4f8d-b9fc-e563f09726d2@sirena.org.uk>
References: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
 <175450053775.2863135.11568399057706626223.git-patchwork-notify@kernel.org>
 <db4eb976-693c-426c-a867-66cadd3dd7d8@sirena.org.uk>
 <aJWz82F21pVTSVJi@debug.ba.rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D45dRbRxMwDeSA/W"
Content-Disposition: inline
In-Reply-To: <aJWz82F21pVTSVJi@debug.ba.rivosinc.com>
X-Cookie: What an artist dies with me!


--D45dRbRxMwDeSA/W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 08, 2025 at 01:23:15AM -0700, Deepak Gupta wrote:
> On Thu, Aug 07, 2025 at 01:28:36PM +0100, Mark Brown wrote:

> > Do you have an update for my clone3() shadow

> No I don't.

> > stack series that I could roll in for when I repost that after the merge
> > window, and/or instructions for how to run this stuff for RISC-V on some
> > emulated platform?

> I would want to write-up instructions. But I don't want you to go through
> a lot of hassle of building toolchain and bunch of other stuff.
> Let me see how I can make it easy for you. Will report back.

Thanks.  FWIW I should already be sorted for the kernel build, unless
there's a super new or specialist toolchain required for this feature
(I'd guess I should be fine for the shadow stacks bit?) - it's userspace
and emulation for the extension I'm missing.

--D45dRbRxMwDeSA/W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiV5A4ACgkQJNaLcl1U
h9BR4gf/Yvc9us1uldFqSA9g7p+0bzU3IY/RfdDdME4qVGVWWXybW7b1P+6OdvKr
lRLLeAJQkpEzhtLNeXXTVgRijmaDgccqM2d2Vkehw9qrW1+pwA56PX8PQPBtJsGL
riODDRX0jZSrSVAPE/mwrQRc97vY83Tme2w2Psah2FzICcRcLdsC9vz3BIsquWgp
5LbvWFyIS7PraLBoSkO76qBYDtRwjw3LzoANXm5rYo9QKsT48UPgjfvmzxLqTSxT
oDMob4PjC2+1FU6Q1yzo5CUyK+aX58BM0OGwWEq4DDOCu5kd0ltVJen8HWszpfVz
YgUpgySyAiGsfZTi1JBRv158syBsdQ==
=5/MC
-----END PGP SIGNATURE-----

--D45dRbRxMwDeSA/W--

