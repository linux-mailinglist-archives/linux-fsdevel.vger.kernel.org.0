Return-Path: <linux-fsdevel+bounces-30555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7DD98C333
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 18:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21FFB1F211F5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 16:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857C31CC14C;
	Tue,  1 Oct 2024 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqbtuRFJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F291C2424;
	Tue,  1 Oct 2024 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727799322; cv=none; b=C1I8WRTCqd1fGxDHTTnOwyPPK/xrEviSpQfZ5Rm+avtgGL2rt/mZ+U2xXBd20VIJl5PbFYe+kCIP/d+g7cJ/iWA4EMRoWtorkROOc/4XjWVpuICz8DRLTsiScyVgLxa6/3eLkmaaIoLqIE0egXvEiZaJS9HxWiGojsYfgzkXwo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727799322; c=relaxed/simple;
	bh=+OmrwFFvI55GhiVmjwakGzI55IFXbs0OQLhUUTgaw38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lk6e6sn+V5O0J8pu84TRelserARq6EW8u/lzt8EeAs06Y6rK9VN2AxuzIAQwSeetWdJINW6qkx0HU0vayZw1frCvr3VDoqdT1yv85VoWzguud5G6Xk5U5hD/Q6C9WjFDkBYi0fK3n5dfDyNsD0JpEdLX6BnyENeb1WJrXnLIgcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqbtuRFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64E3C4CEC7;
	Tue,  1 Oct 2024 16:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727799321;
	bh=+OmrwFFvI55GhiVmjwakGzI55IFXbs0OQLhUUTgaw38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RqbtuRFJU3u7JGA6mstBP8v+VnF2+BpPvJBISYpoE1myMPoeofcLOfETglwd/qqZX
	 x6xbtmUE/AaEcoWn0ZA8t0QUZQjaEsa66J35m09JoEfVzTDOIpJbSzpgGrbYGk7ROR
	 Imomv1HBZRnI/fzOcUfTyuK6zGFljqtNCMIAK2siGRxnBJbqwPASU2pU1LcPDOROtb
	 yxFRIIJPpDmySpyG1SG6qGCbTLZLpLzu+QVE7YuzjfOhmInh2W/JnLERnqF9jC+jh+
	 uPLt33Yevu1qKZxJS38du1tCjiT/+4HgU/OhVG31JhV+AgobMsR7Pk5M44bCsRITkI
	 oGQGlV/9jIzhQ==
Date: Tue, 1 Oct 2024 17:15:08 +0100
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
Subject: Re: [PATCH 17/33] prctl: arch-agnostic prctl for shadow stack
Message-ID: <e7c48ad8-5fe2-46d8-b137-e04046b7c572@sirena.org.uk>
References: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
 <20241001-v5_user_cfi_series-v1-17-3ba65b6e550f@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HnBpW/dMWd9OANPk"
Content-Disposition: inline
In-Reply-To: <20241001-v5_user_cfi_series-v1-17-3ba65b6e550f@rivosinc.com>
X-Cookie: Even a hawk is an eagle among crows.


--HnBpW/dMWd9OANPk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2024 at 09:06:22AM -0700, Deepak Gupta wrote:
> From: Mark Brown <broonie@kernel.org>

> This is based on a patch originally written by Deepak Gupta but later
> modified by Mark Brown for arm's GCS patch series.
>=20
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Co-developed-by: Deepak Gupta <debug@rivosinc.com>
> ---

You need to add your own signoff to this when reposting, see
submitting-patches.rst.

--HnBpW/dMWd9OANPk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmb8IAsACgkQJNaLcl1U
h9DrwQf7BAFQooaBsGyKz4K0gmdZvizPyAYQqIuRAHGgQfFjNxxMAxr9uixHnfTg
/mZbG5XRVKtI2yxwczMB6CMGwI1HZ4s2Inp/eJbCxUbAH6vU8tYpveECIII9zKk3
I7sr3LtJGO2vNA6jL4aC9sjIBK8ArFU3U3q3xFvuNA3rweEVNh/pN2syIsK+WXuS
cdkujVFleyQUjcyYIPGZIDNctM39NDfOhgBe3mSiAwDzXnTay7MMBdpFP9DffM/Z
+VzTmLgom8P7XIJJglgDDUYqrh0D5VsztFKJ1BPcwUR7y7KJpO0EBPuvglcXPbqa
Qm1qEKcpAzSR4Y56hqjCRCmPB4fIXw==
=G7w+
-----END PGP SIGNATURE-----

--HnBpW/dMWd9OANPk--

