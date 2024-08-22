Return-Path: <linux-fsdevel+bounces-26813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AEE95BBDB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 18:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A00A2B2B74F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 16:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72741CCEE0;
	Thu, 22 Aug 2024 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5mqUunk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179F51D130F;
	Thu, 22 Aug 2024 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343882; cv=none; b=pNiOpUr0iWYVxtfUR/lrsTdsxgxTqlRcFz1I455sPXBKw3ugpQ65TCjS3U0+AEZv0PrX7YFcVmPqCyDDQ5REWhIoOe/T4xwwwpuxlYiSES+2cSqcLnlWr+A6sOD4WtHU/MshHrxDRyOtqQfgpn0gjB48rM0UktQyY9M1rmDBC3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343882; c=relaxed/simple;
	bh=+UYr1EMbxmQcwL8f+aGCf7y/v2m/OChUZcEGlURHIO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlHbV4615ExoRRAK31bx6NzmToLZllmzQ1ZdYWJXo0KaHC+icXdgoKfPeJ675K+oaONTLYuqM1Ny+9IBxOK4pEFEyk4sqKfUJcJ/k7ER0O3TxuiqxwQ74eLle0BHw5n2WId+vBfTA0VuHBJRehO8+G+EMcCSgSmfzF1p6Bi0+64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5mqUunk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BE0C4AF10;
	Thu, 22 Aug 2024 16:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724343880;
	bh=+UYr1EMbxmQcwL8f+aGCf7y/v2m/OChUZcEGlURHIO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q5mqUunkkDfgxKkhsWSbZZ4bvlykv/a1Lf0TVH7BJZZL2anFRHs6IiIw4LSR+MngM
	 UwhWBH53191BOM4l76kFFpFjR+yNjnHX5b9U60zH9p5m3yL5wTLwKAXccT7v8Xj/4m
	 GE7T5BSenuI1dBEd38ZHv0OGdnbzWIYt8/lvkd9xnedhTNcEzQIGO4vavP16xmZVoM
	 pdOP1dObNGxQh4/QJ3zP/rRFw+yAaqk3mCkPvi4wP2eYdGyZ560g7HhU+ja2mq6Iu7
	 KOJBS96PBxgSr+B9/o7wIywbdg6B5nYDnjWYDe3qZWoawc/ydUnvuuafFbZuvNvr13
	 6aiGRQw3qejfg==
Date: Thu, 22 Aug 2024 17:24:36 +0100
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
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v11 21/39] arm64/gcs: Ensure that new threads have a GCS
Message-ID: <ZsdmRHinYQdbPn9p@finisterre.sirena.org.uk>
References: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
 <20240822-arm64-gcs-v11-21-41b81947ecb5@kernel.org>
 <ZsdkikRi2wgBlODX@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cphCPo7ma/MLqBWq"
Content-Disposition: inline
In-Reply-To: <ZsdkikRi2wgBlODX@arm.com>
X-Cookie: Your love life will be... interesting.


--cphCPo7ma/MLqBWq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 22, 2024 at 05:17:14PM +0100, Catalin Marinas wrote:

> >  	/*
> > -	 * Ensure that GCS changes are observable by/from other PEs in
> > -	 * case of migration.
> > +	 * Ensure that GCS memory effects of the 'prev' thread are
> > +	 * ordered before other memory accesses with release semantics
> > +	 * (or preceded by a DMB) on the current PE. In addition, any
> > +	 * memory accesses with acquire semantics (or succeeded by a
> > +	 * DMB) are ordered before GCS memory effects of the 'next'
> > +	 * thread. This will ensure that the GCS memory effects are
> > +	 * visible to other PEs in case of migration.
> >  	 */
> > -	gcsb_dsync();
> > +	if (task_gcs_el0_enabled(current) || task_gcs_el0_enabled(next))
> > +		gcsb_dsync();

> Ah, the comment turned up in this patch. It looks fine.

Oh, sorry - I should probably just pull this hunk into the other patch.

--cphCPo7ma/MLqBWq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbHZkMACgkQJNaLcl1U
h9AXTQf6AzdK45ja4zPd6pOLOLIMS6ytyzho0mtx63LPWkg3eGQA4Jllqqgf/Kpt
lhMuC4Cc1DJw0Flz6uHop/VNpp/EqYDexQY9oKRVaMjgndRtvYUnX5FdleS0/gjd
V6Ap8KdW5YZjNzm8Z1n7LE0g0TySfxVXr7Dwlo+e9XiB+Jp502hXQoRw+W7BCmio
VpYUTnm+gt05lzMZEo9ps1iOOzTfYOmwEjiCRuq0fzFrgW2hN4AWoG+ooxmG1YJc
BWl2k7dfQSfHFv7y+1ywHglWgFzkWYN1QwQY00OatFCf9MPIYGiTj1Oml5+UTP+o
HWP0UgIWgVuH85MHHUY67CCKtRcS4w==
=N19k
-----END PGP SIGNATURE-----

--cphCPo7ma/MLqBWq--

