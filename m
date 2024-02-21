Return-Path: <linux-fsdevel+bounces-12300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8302685E55A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 19:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E22F284188
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 18:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF66585288;
	Wed, 21 Feb 2024 18:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ov6cm/hg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1634942A8B;
	Wed, 21 Feb 2024 18:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539407; cv=none; b=NzaBqxI7wnYIq0Ksu4Ehda6RGB+yFjIxcK004WADPESsyGSGPPO9hT/G55JwOO1LxIDKaHiDYlUaMiLy2xGSYaes/ObjZaaTsxRPopxvOWAwQ9D7tYHBemKc7X49km3bNYLHd3F0+XeyDfGRp3VogRS1C8mGpX3La5yedZpxryc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539407; c=relaxed/simple;
	bh=csK/DsyAOVnlfATFEXn3F2y/yVFcNC3OQEkT5JeAyec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QETOAmcgOuVTIdhj/j0sjngR3fPaEYLjLe1XHAIXz5zdrTNLa2UPx/r9UDBZO8YsM2z+FT8fnd0vvHjh+xeKEGiW2/CcBuRqSVdJBBpZQUuu1OVNfbJnUS2U/JNyz6AiE7kci9IfjGO4vqGuiLHTGdwHUp+TmcbDhKXIOCSFglI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ov6cm/hg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCEEC433F1;
	Wed, 21 Feb 2024 18:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708539406;
	bh=csK/DsyAOVnlfATFEXn3F2y/yVFcNC3OQEkT5JeAyec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ov6cm/hg2mleRWqUd3r9/W+rkcAFVU7c27Hx8hcFb4M7UnzZrk5N2v269pkhvIIp6
	 bYnBdTUndPV/TFw7qV/WyGz5Y5QL0nzqxYt/dpw22VmM8LawYB+liEKK4qt6TGiyDk
	 QjYeo/CJfpAl1TAZ9ES5BuQc1+oqqSXYqQ4XvqrYCwSuthuV4CUrHLGWw1uQydZLOx
	 AwoNAI6RkOBmr3gjndpgIT+LOuOI9T5Q22ViTkf+qm8p7en2UwVaM3vLN4MN3sD7yL
	 3uBtCIJ1v9SEg1kQuOc2Sf9OQiw+ZsqkoXTxilnmDq1+1x53S/cyRAhhlK17+JAJew
	 /3/DRkmjzoJ7g==
Date: Wed, 21 Feb 2024 18:16:36 +0000
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
Subject: Re: [PATCH v8 20/38] arm64/gcs: Ensure that new threads have a GCS
Message-ID: <9400cfc3-0e87-4abd-afbc-172736d77a1b@sirena.org.uk>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
 <20240203-arm64-gcs-v8-20-c9fec77673ef@kernel.org>
 <874je399ld.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kWxKAN+nLkxhoap7"
Content-Disposition: inline
In-Reply-To: <874je399ld.fsf@linaro.org>
X-Cookie: The second best policy is dishonesty.


--kWxKAN+nLkxhoap7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 19, 2024 at 11:02:22PM -0300, Thiago Jung Bauermann wrote:
> Mark Brown <broonie@kernel.org> writes:

> > +		gcspr_el0 = addr + size - (2 * sizeof(u64));
> > +		if (!gcs_consume_token(tsk, gcspr_el0)) {

> Should this code validate the end of stack marker? Or doesn't it matter
> whether the marker is correct or not?

I don't think we specifically care, we're just looking for a token here.

--kWxKAN+nLkxhoap7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXWPgMACgkQJNaLcl1U
h9BotQf9GJn/XYpiDfL/lza1ZizUnGoNmGMVjrNpXn5ZUEXw+EsNed40zfVPg2As
MDBjwYmG0UWQjuOimqAPlqsQL2hNSgmuQpeOCdUJXv2+/WBRUOfix+1xhtnPUUlf
VWqNyLLSjFbbzOAmYFiN1HTJkHsSs8FHbtskrWealJQ/wV+6GLXjkz4cP7dP84lL
IZOifB9YSPxwaW7RKUtEJ3D6CfX0xZhD5eahzIbO4E74kha8flAy/1AuHvtlI/+O
0oN9+6kUfQNptazvZMa8wZib2BDF1ORpASOrzn+hmFWgoUD2j2wbkMt/E8sH9ckT
HygbfdF0QU3Xk7fxczBPUTsczeTLeA==
=2YH/
-----END PGP SIGNATURE-----

--kWxKAN+nLkxhoap7--

