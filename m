Return-Path: <linux-fsdevel+bounces-31434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A320996803
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 13:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136FD1F22D8E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 11:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83C31917E6;
	Wed,  9 Oct 2024 11:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQ/b9j93"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2CA1C6BE;
	Wed,  9 Oct 2024 11:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728471961; cv=none; b=fR+eABf2KOUZX6pk5kq0FAJFvs8hWB0Y1+FCj4iog869nM9TywvTpK4BuoPnEs4qkh1n3sZHWQ0sIV2eB/VusrBySnTSnSu1V3sN+fv6tElpdzlTVm12UZZfZG1kcv7qgVUui9k9TL8oVbK/f1nFYWdQUWVgsilRp3UIl83kfgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728471961; c=relaxed/simple;
	bh=q/ht5rusQH29reCgQKkQ7cxAxVD7sSLy4Jo1uGfHo0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yb9v7Ymc0lLZdSQGrCBe2gSNhQQDaOUfGrjzT5ciCvCX8hUSpoq2HbitQTaDaXMkruyQoGDmX+XUKv0yrHvj1WRwzd3+xk0R3tgU4Og3RIYWqpig0jp0hft8rbdRJKiz4laeDny5GRgUw4UD+omRza0v4ogFG5SSTXGqbyEYYic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQ/b9j93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB2BC4CEC5;
	Wed,  9 Oct 2024 11:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728471960;
	bh=q/ht5rusQH29reCgQKkQ7cxAxVD7sSLy4Jo1uGfHo0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQ/b9j93K6RqAqgOUVMgfWoJsX5As1kolPBoc1Y73PNguggklUUrUm2Ap+8EzcnQL
	 q1m6g5FdIty689UhD2b5AzShUkate3A6XOljtsoMwAwmAWIgjx4jayaN+AWF8F4T9S
	 z26oFKbiOTGuQS86JgZwc2gC9p4KnFCD7dLoSUKSS5Nf2TtSABKSG1CslKD55avTD6
	 nudWnFJtEZ2i5CHu60HDNsExl6LyE2587gf6cMM3mS/fC9mra+T0Wa4nFpqjpsXVQ4
	 aagGb/fIscXPvjhoTdQGNYv8iQLBq4HwXneOlsq96NIQAJtqmEm24eqebhSI6o2bfj
	 1JnC7rG+hfcLg==
Date: Wed, 9 Oct 2024 12:05:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, rick.p.edgecombe@intel.com,
	David Hildenbrand <david@redhat.com>,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andy Chiu <andy.chiu@sifive.com>
Subject: Re: [PATCH v6 00/33] riscv control-flow integrity for usermode
Message-ID: <ZwZjlSZKoJ9np3td@finisterre.sirena.org.uk>
References: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7oPJV4nwhqMkz2xI"
Content-Disposition: inline
In-Reply-To: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
X-Cookie: Editing is a rewording activity.


--7oPJV4nwhqMkz2xI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 08, 2024 at 03:36:42PM -0700, Deepak Gupta wrote:

> Equivalent to landing pad (zicfilp) on x86 is `ENDBRANCH` instruction in Intel
> CET [3] and branch target identification (BTI) [4] on arm.
> Similarly x86's Intel CET has shadow stack [5] and arm64 has guarded control
> stack (GCS) [6] which are very similar to risc-v's zicfiss shadow stack.

> x86 already supports shadow stack for user mode and arm64 support for GCS in
> usermode [7] is ongoing.

FWIW the arm64 support is now in -next, including these:

> Mark Brown (2):
>       mm: Introduce ARCH_HAS_USER_SHADOW_STACK
>       prctl: arch-agnostic prctl for shadow stack

shared changes to generic code.

--7oPJV4nwhqMkz2xI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcGY5QACgkQJNaLcl1U
h9DuYgf/Yx/hYhzwGnR6YPAWZpgt5JjVuDPJa1JE1Ei8ieKYodc7o6QkOA5hSrTm
WYjjS9qnSLJMACL3DYu4mSJA8xQotPF5iqQaMppk1O/o2e3oTwawz7s0nV/YrWro
AqVenIjySprRKZMNLMT7px8D0NFUlqICKS05NO3+KlS3J/tdxEnW5ugscd0abE6V
UuEUA6JnHqtwrdff5T2I3hZqDw1W+3uMDoCYjB5hsmRbZQsdR31IbaAqJIiV30Xn
e2tXbl+/62YIiebxZzUJGexuc7CbwdMnNC6aRjMTFEZ1R4YF1DJZMu9TcIBP/W2b
q6AR4EUd7yJlirhYQIzbhTVozmqMlA==
=L1c6
-----END PGP SIGNATURE-----

--7oPJV4nwhqMkz2xI--

