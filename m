Return-Path: <linux-fsdevel+bounces-26085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9A69539BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 20:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710AD1F235D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 18:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C387957CB6;
	Thu, 15 Aug 2024 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdNX9evY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BCE52F70;
	Thu, 15 Aug 2024 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723745650; cv=none; b=BQfK0UnZcPq6z69MmzD92AyCD84yibpbcqeqno/lXWvMGcqst5wzbNvMQN9kTWEiPOvOiXEbQecm3IheNVP375GFN15U9XM6LxwyCNoPiw7U0diYBPu+nGUcLEaysvU8jdlotv8xaw4B2ix4yhumFKSVmJESNGINz/PmBfq1yGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723745650; c=relaxed/simple;
	bh=RdD04e7bCL/aVp7Qyn7v8N5dBB4gbycSkh4w1YVB2kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfPTqglrsTUJm0b7DeM/NtH7tW2UtGtJl0ZvWjqiCcZg9Csen51PO7O1NxxYmezt9QfSliTlnSAGRbM8E4Q41itfPBjdQNvvOk2Y1/QjzedNXsKFfFBfyQzf8LCi8btnU1PdYAdYXHgPOvBAMdoRFbEiRt7A7eI4AGHSbEWgROE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdNX9evY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB208C32786;
	Thu, 15 Aug 2024 18:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723745650;
	bh=RdD04e7bCL/aVp7Qyn7v8N5dBB4gbycSkh4w1YVB2kc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BdNX9evYkuNDzaq1aPNqEDzPM6DtOszJ4fplPAv3RtWa/vIKvYlrUd7AEi63DCqnj
	 2ZHmYP3Mhcaxzc3nkhhYZ1sezN/Rie/qqCA2LjgDHrNdp4aniD+lgSn90u0O5kM7ub
	 snWnOv3YaUWn+8rZfdCes1OgLfN4geXYsjJs0xIw8WKiccSuMwsIWlS78BoWm1udr5
	 UeaJIwcpXPwSXqFL0Pwut4my0L7CtbUI9cXNk0RIPALppzDzDXQ+apnvBxCP1QHcnu
	 jG4F5HHXQ7kK9LxOGpKf1DPtz/YzKtlDkJS45/ImafzJCEnmP7dkyB5UYYS1dl2xf4
	 XKP/epYAVeuMw==
Date: Thu, 15 Aug 2024 19:14:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
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
Subject: Re: [PATCH v10 04/40] arm64: Document boot requirements for Guarded
 Control Stacks
Message-ID: <44ce87ea-38c3-4a84-9dac-835b963ed07d@sirena.org.uk>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-4-699e2bd2190b@kernel.org>
 <Zr40H4xAb00MdMlX@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FolSFB1sscROoe34"
Content-Disposition: inline
In-Reply-To: <Zr40H4xAb00MdMlX@arm.com>
X-Cookie: -- Owen Meredith


--FolSFB1sscROoe34
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 15, 2024 at 06:00:15PM +0100, Catalin Marinas wrote:
> On Thu, Aug 01, 2024 at 01:06:31PM +0100, Mark Brown wrote:

> > +  - If EL2 is present:

> > +    - GCSCR_EL2 must be initialised to 0.

> > + - If the kernel is entered at EL1 and EL2 is present:
> > +
> > +    - GCSCR_EL1 must be initialised to 0.
> > +
> > +    - GCSCRE0_EL1 must be initialised to 0.

> Currently booting.rst doesn't list *_EL1 registers to be initialised
> when the kernel is entered at EL1, that would usually be the
> responsibility of EL1. The exception is some bits in SCTLR_EL1 around
> not entering with the MMU and caches enabled. But here I think it makes
> sense to add these GCS registers since if some random bits are set, they
> can affect kernels (and user apps) that don't have GCS support.

Right, exactly - the trouble here is that if we enter EL1 with GCS
enabled we aren't able to do function calls until we either disable GCS
or configure the MMU and allocate a GCS.  This means that all existing
kernels which haven't heard of GCS require that GCS be disabled prior to
starting, they'll just fault within a couple of instructions whenever
they reach the EL for which GCS is enabled so it seems sensible to just
require that this is set up.  It is hard to envision a scenario in which
it would be reasonable to start in a different configuration.

Now I think about it I should move those two to not depend on EL2 being
present, that's just cut'n'paste.

> Don't we need HCRX_EL2.GCSEn to be set when entered at EL1?

Yes, if we want GCS to do anything.  I've added this.

--FolSFB1sscROoe34
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma+RWgACgkQJNaLcl1U
h9BaiQf9EC6tNrCibHFhHciYydBCLiy2LIqlYTMYVmhIGoRxyAWDvgrDDiZx9XtM
yJHys2Cn+xNukEZmz3TbAjtEfCb32S5qodYU+8KsRFp6cIsM2kUCTkFdVTz36dMZ
8IDl4I2zbMlh03uCCC1+5vjuXE+qRPgUOzg1X00q4zHYC05XoSWCm2I1183TgHKJ
4INAGk/sLjwF3oZPOtjnIta/ZUqyrxLbcBH4b1JQQD3WZ34WHJKjbCiZigQYJIMh
iy9ryfYUrf8oluuAuFO8javORaHNBURd9bOsjj004eD9WlKYjp1Ji7iuheq5iWb6
A3XUg+P7gC0bMfb12d1321Rjg8cWng==
=dtpa
-----END PGP SIGNATURE-----

--FolSFB1sscROoe34--

