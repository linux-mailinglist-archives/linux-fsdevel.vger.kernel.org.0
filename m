Return-Path: <linux-fsdevel+bounces-56983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B87B1D7DC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 14:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57DF93B2598
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 12:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEF524728C;
	Thu,  7 Aug 2025 12:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfRz8/lo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400CD24293B;
	Thu,  7 Aug 2025 12:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754569730; cv=none; b=bB/NEk5V23zU3lu/IwaSSzshEjPrbLEDur6uZbAfqDT/dSjUgRLCnPzcA3Yj1W7VFvx+Pk5btca8C2o+kvAhCP1fjNY1qKpKsZ/5KjiH33njnidTNouqoe7stg5yuiDlO4ZA32F8ZiqyVgVk1hFm5/y+bq02eSDQFZlTS9qo/14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754569730; c=relaxed/simple;
	bh=kUH5cN8R6K2VxLTJzE/eGBwS7eFdgy3gZa8/khg7FMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9e3kBsv5TqLG0d8glRcEl3eesOLWooNxQDuUaw6gAd0Tlqu+7kdnPmnghmn5NHgJ8WyT9r+UbpCzrMr/Sr4YVIxtDK7JSod0dxUmejzAeerUQIc9+xIYj0Ti5U0CbJVxSpONGN6bcIqgBSzWEWQAYwv9UEzShLT1qDgFZLpcf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfRz8/lo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB578C4CEEB;
	Thu,  7 Aug 2025 12:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754569729;
	bh=kUH5cN8R6K2VxLTJzE/eGBwS7eFdgy3gZa8/khg7FMc=;
	h=Date:From:List-Id:To:Cc:Subject:References:In-Reply-To:From;
	b=QfRz8/lokPQVbrBLQdFUg7Zb/pO83LwtQj6QWEu50ZIIRiNZFCedBiyH1vPKdZCmn
	 sd6EpNnPi3l2PXkuxCii2LHjBXBHhb8dMe7F02R3uXDPg+W0NEArdn2LzuNZWk4n4C
	 /Sx0iu7o5KWBtcGI3LpmP5Ug+gPg6/SSSMluaZMDVq7o8iEupbbo1t+inLw6H7xOEs
	 jqbuylhW2q93qMf3JwvCe+wxRi2FEEeMt64N6gLqFXR4huwOVfenuJMDp6TjvScCLC
	 7UWGcPsoYmI5swp1B3/noAXrQ9FI+wP3dI6JCb6TOGkWKhf2Oy8Cic2ZCTYFeNZEkL
	 7GwpI5SHcfNkg==
Date: Thu, 7 Aug 2025 13:28:36 +0100
From: Mark Brown <broonie@kernel.org>
To: patchwork-bot+linux-riscv@kernel.org
Cc: Deepak Gupta <debug@rivosinc.com>, linux-riscv@lists.infradead.org,
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
Message-ID: <db4eb976-693c-426c-a867-66cadd3dd7d8@sirena.org.uk>
References: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
 <175450053775.2863135.11568399057706626223.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8Jovl+rM+g+rY2Z6"
Content-Disposition: inline
In-Reply-To: <175450053775.2863135.11568399057706626223.git-patchwork-notify@kernel.org>
X-Cookie: Real Users hate Real Programmers.


--8Jovl+rM+g+rY2Z6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 06, 2025 at 05:15:37PM +0000, patchwork-bot+linux-riscv@kernel.org wrote:

> This series was applied to riscv/linux.git (for-next)
> by Alexandre Ghiti <alexghiti@rivosinc.com>:

>   - [v19,11/27] riscv/shstk: If needed allocate a new shadow stack on clone
>     https://git.kernel.org/riscv/c/9c72a71321a6
>   - [v19,12/27] riscv: Implements arch agnostic shadow stack prctls
>     https://git.kernel.org/riscv/c/52eff0ab5f8e

Congratulations Deepak!  Do you have an update for my clone3() shadow
stack series that I could roll in for when I repost that after the merge
window, and/or instructions for how to run this stuff for RISC-V on some
emulated platform?

--8Jovl+rM+g+rY2Z6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiUm/QACgkQJNaLcl1U
h9BDYgf/Ty4Hzzi0OZOuIjqMAO+hAw56Z5Cp+NT+3TWGYWAJtxuukMORT3mrkWI4
+lKrRIDqhecWHSZ3jeKvFjPvxTcPu/kwjG7GsseqGj7HJGoOufVlruKUj79xtdKS
4V/WwyvqakZ4h3F0zy+bCyIrkBkQNbC3TTJVey1+4t0WNSj2uK4ZXespwXt+omY7
MOsfSOj3AY1ueunPYkofK1g6VWYe4HSldfLRvwJMeUadPJ49XFhfpi41NsqdfhBB
I8rdBWPSCS47tFoalL0R2oB+Dp78k8LmZhqKIRpPwAhMHIg3sI/kBMK4neka58L2
d0MPk00RRPiLdsDKGHuaAWzwtLHXaA==
=viF/
-----END PGP SIGNATURE-----

--8Jovl+rM+g+rY2Z6--

