Return-Path: <linux-fsdevel+bounces-31435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBCA996818
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 13:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553801F23023
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 11:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E974B1917FB;
	Wed,  9 Oct 2024 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mz7RtfQh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D1618E76E;
	Wed,  9 Oct 2024 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728472297; cv=none; b=kf3PilvI7VW7K1SgfB0ChpdWXY6bLqilX8ymW/VXcWhrHgEpGh6zgHYjt/9mw37fmTJleQZEzv0N/tyUlmYOsv5odHeRt7snvGDa5C9q7jHRVomKcIX2kJVTdci5WktkADK/+X6+6z4gmHWK1Mp/hbfCIPnvZqkzzz0Ky3EXnWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728472297; c=relaxed/simple;
	bh=e3rviv3TJdVjm4yn7ziTk9KSuLclDXQUchWzo7AyiA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWi35ReKZ8BCL6tZ80BEyYAYcmDVbYe58dYlkonzWt0tYV2Y/v+SqdGygpvqM+i0a2NIG/03BKhOHsoRKHc7bXS0hoYIgrM8dtkyo2/8oqbSBFVsKgtqV6cRjBWDR9aTBhvYCN+xY06OSER9MiIqMJIxVCZc3dkdkwiqrFb4LEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mz7RtfQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AD7C4CEC5;
	Wed,  9 Oct 2024 11:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728472295;
	bh=e3rviv3TJdVjm4yn7ziTk9KSuLclDXQUchWzo7AyiA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mz7RtfQhCZ0uNCUFMWKtrHAFeascQPu/ebICZ3tR6PzNzrHFcc/TnETf+OJkJge90
	 ZR7BDjTr/iiEplJZ/McnERDIbJoo4Ruuko8yzXydymmHZercGjMUXR86WYDdDQJwhN
	 TIfk2Qog/C8fAdxxpVjiYALqqIduKNgy3iaiEe9KNN0SWuIast05sUg34l4uHjyfCn
	 xXgrJNWDslnX8A3zp1HtNtRwrw3gHZjBDPwqOjvfkIBTkKfvKyla22qr1n5qra8it0
	 9Vmmpa2HsBpKn4+LhSFP4gryYnJ0bcZMuKDcHnX9tTYsHSPZplMSMCHVO1DIZeMxqN
	 C2HFPzUeHbo7w==
Date: Wed, 9 Oct 2024 12:11:32 +0100
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
	samitolvanen@google.com, rick.p.edgecombe@intel.com
Subject: Re: [PATCH v6 02/33] mm: helper `is_shadow_stack_vma` to check
 shadow stack vma
Message-ID: <ZwZk5LufEv-7GLlf@finisterre.sirena.org.uk>
References: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
 <20241008-v5_user_cfi_series-v6-2-60d9fe073f37@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RiYacTSmJWPXVleE"
Content-Disposition: inline
In-Reply-To: <20241008-v5_user_cfi_series-v6-2-60d9fe073f37@rivosinc.com>
X-Cookie: Editing is a rewording activity.


--RiYacTSmJWPXVleE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 08, 2024 at 03:36:44PM -0700, Deepak Gupta wrote:
> VM_SHADOW_STACK (alias to VM_HIGH_ARCH_5) is used to encode shadow stack
> VMA on three architectures (x86 shadow stack, arm GCS and RISC-V shadow
> stack). In case architecture doesn't implement shadow stack, it's VM_NONE
> Introducing a helper `is_shadow_stack_vma` to determine shadow stack vma
> or not.

Not that it makes any difference but the arm64 eneded up defining
VM_SHADOW_STACK to VM_HIGH_ARCH_6.

> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  mm/gup.c |  2 +-
>  mm/vma.h | 10 +++++++---
>  2 files changed, 8 insertions(+), 4 deletions(-)

There's another test of VM_SHADOW_STACK in mainline now, added by my
change df7e1286b1dc3d6c ("mm: care about shadow stack guard gap when
getting an unmapped area") - sorry, I should've remembered this change
=66rom your series and pulled it into mine.

> @@ -387,7 +392,6 @@ static inline bool is_data_mapping(vm_flags_t flags)
>         return (flags & (VM_WRITE | VM_SHARED | VM_STACK)) =3D=3D VM_WRIT=
E;
>  }
>=20
> -
>  static inline void vma_iter_config(struct vma_iterator *vmi,
>                 unsigned long index, unsigned long last)

Unrelated whitespace change.

--RiYacTSmJWPXVleE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcGZOMACgkQJNaLcl1U
h9Dh9Qf/V2pf5NwELa5AFo32pS+UvPU+55Sn73YaN7CJwHb51fe8tNSKG9c3Gq8e
E/N5zPxVN7izgYi2vXXf1GVM/Hm9oZUxNyU4BrkNeRLh7ofy0CsGwspy7Xp+k4LH
mUZX01pPjiQ71euc4oxfaUpZT85PVe/Tj1pYyNSulKwk2My4BSuW+eHt+kD4v9uC
TSSp4NrtEi8xN29WICLiOfJQ/GZnusdljjbOEDauW3H02lVyqsi9vr5nCUlViEqu
A60ZAzYJ9XrQQEJXK6n0FL2ebd7wJH0RvYRKMCNrFBpLRUs7kiFCcczFV8QfnPTN
B9GbsQB+3EaHLl6oGV2gv6QyQgmoCw==
=uBsi
-----END PGP SIGNATURE-----

--RiYacTSmJWPXVleE--

