Return-Path: <linux-fsdevel+bounces-31685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB7C99A195
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 12:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC331F23632
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 10:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253A71E5020;
	Fri, 11 Oct 2024 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bux5p6Ku"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CF91E3773;
	Fri, 11 Oct 2024 10:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728643135; cv=none; b=MooDX8220fcDNaui4CAAgiuDcEuh4+nLYfHX3ILQCD0cCTni+mbTr3GzqVy9J+RU2FSRibvL6ArWdOL99Mn8dJpyzBoaQJsCErDiSJC2sFSCr95pCMhDQrtDpeJ9AiGxkLyZOxfDA7MyYc4KjOKQube1dlktOpKuWsKsa/pJ8Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728643135; c=relaxed/simple;
	bh=5KifsyOckMISdoD/eCayNq1MKzZ08TydkAYy0i/gD9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLlgJ/e/M36jxdGn/hYzHFQ2/ZLnpH39/eHtV8q+BoAyjDvwTUi6rkNOnNJVJha/r9ryUHwsuatv/Q5rTs1tqSx0Lux2C9IhZt1RBqRZpfgljAzLx1JE7r0t4a10RfzoTDJehpuP/qEhQjV4PykMO4UpXaWTdgYHjGaxWLV8mWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bux5p6Ku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39FAC4CECD;
	Fri, 11 Oct 2024 10:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728643135;
	bh=5KifsyOckMISdoD/eCayNq1MKzZ08TydkAYy0i/gD9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bux5p6Kudlx8dt0Eqz21QygqtNlmzFQ1Em5avFM86svr7uf/khX3ZesFhpi+e9pI8
	 4U5EGyaISIuZkr03vAn+BsC1NyEy7yYNon0acmdOMCclpaYZEC+WbnBSwArU3K34bO
	 3qEUVzSjbW7E4pi/fMzKUEw+TZXC2HMK3SN/wHQgM+mSMnKTf3qe3tHuH18kBZt3HL
	 HvSerc/a9U+HmdaFE/9JWsZbbzvKRfnhMFSYMD+lB6AU7WUnlrV5+9Lt5nj7c6ziOH
	 7nI6Rgu18aeiK8YwRqtiJ/+WTKw5nxJjeEGp4n2at59zJzphGP9WPyJrlwWYhZ/mfi
	 b1k9T7b64hWIA==
Date: Fri, 11 Oct 2024 11:38:51 +0100
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
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH RFC/RFT 2/3] mm: helper `is_shadow_stack_vma` to check
 shadow stack vma
Message-ID: <ZwkAO9P3CxGbyq4L@finisterre.sirena.org.uk>
References: <20241010-shstk_converge-v1-0-631beca676e7@rivosinc.com>
 <20241010-shstk_converge-v1-2-631beca676e7@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4zYo/B+253W5RkjB"
Content-Disposition: inline
In-Reply-To: <20241010-shstk_converge-v1-2-631beca676e7@rivosinc.com>
X-Cookie: Editing is a rewording activity.


--4zYo/B+253W5RkjB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 05:32:04PM -0700, Deepak Gupta wrote:
> VM_SHADOW_STACK (alias to VM_HIGH_ARCH_5) is used to encode shadow stack
> VMA on three architectures (x86 shadow stack, arm GCS and RISC-V shadow
> stack). In case architecture doesn't implement shadow stack, it's VM_NONE
> Introducing a helper `is_shadow_stack_vma` to determine shadow stack vma
> or not.
>=20
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  mm/gup.c |  2 +-
>  mm/vma.h | 10 +++++++---
>  2 files changed, 8 insertions(+), 4 deletions(-)

As I noted in reply to the version of this patch in the RISC-V series
there's another test for VM_SHADOW_STACK in mm/mmap.c.

--4zYo/B+253W5RkjB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcJADoACgkQJNaLcl1U
h9AINQf/X72VpmC3qgyCk9bL7hkP3fb0q1+UbJS64dlYea313u2psyRklZdeIxl9
YBmaV2mf6I9WNwWtqtUlynkA+oz/Mf2pNt1G+kkTYTNWZ/69MTFXSvmKeEdrnQ/c
zPFp2eMxC3jAPW3vdRgYQMKDgelzD5g+53LBOryBCOpT0mWrdPrDIAPZcccKpKpf
piSVHCCsWEjfzJopQaAZRQgGTVSrtwELR52lOM3FwC8StXwYUEQrBMJFdCKXO0R/
Ib4TWsCcq0UDW91t6zxJvL9Q3wEleYRB83JDFM3N6wz36LkGtvh8mgd9OhhChu7g
4wvien0yfxmNfOx/H1QsE1dnZiZ3bw==
=Fanw
-----END PGP SIGNATURE-----

--4zYo/B+253W5RkjB--

