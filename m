Return-Path: <linux-fsdevel+bounces-26274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A056956E64
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 17:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11EFE1F22A2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 15:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D897C1779B1;
	Mon, 19 Aug 2024 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCYk6sau"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226022AD2C;
	Mon, 19 Aug 2024 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080491; cv=none; b=XSJYua2hnxAhmf0d7klJ9mHbGkiw/z7g+/XO5nNVnRaHNq+FxDReAlBbU8GpKIQYZiilLR3A0zMg25/M4eU85Zdi34R7Wg3FhQHhnkiwvtGDw1MnRdsiBqi3Ib7f0+jB1ZIXSE6a6BIe/SjqM1pEMc+oIwZ6HiXSIaDpHSbGfOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080491; c=relaxed/simple;
	bh=S8xLhlX6RpZyNHWb7anPniOddgqkLHLd/F+Q/aXteFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKHTWfhqPuW3e9FJLuiFsjLXeVfq7k0k5vPZZZd9Lpzzj3w/VOD76l2FzB636Ye4mxIOC+4hBDWA29Mmu9feTeXF3qu00Y3Impg9VsU2WnGlygzJaNHp/q1v3a8utfo+b/lKRXA1cWp4xBfJpNBrF2DcW9IOnokOORNpqq54/VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCYk6sau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33AF7C32782;
	Mon, 19 Aug 2024 15:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724080490;
	bh=S8xLhlX6RpZyNHWb7anPniOddgqkLHLd/F+Q/aXteFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lCYk6sauuzGZXdmOUXd2qTfJWvnED9bat34saswazgl+M63wcMrmkDGih3C8kQurA
	 Y2P6GJV0apLQodqEjQKA4tdHpmZayAUehizPYmJryKzc9k2pe7FjLLsB+nMt+yQu9h
	 6haqcAo1ROW4FSaTAo1ixtaogoPe/ZoVBT9tJrC3lFtzrBO+EUNak/Eatw3H2Lcpe/
	 c/nYpouIZebXmyZmxMOP8ewWLGfSRVwk2VIvLTWpC+zyPpx85rnhXiCbZ9E8XxLZ9C
	 WuivjB335AbSXgBL+2B1hZIrxM8FYBoq6IoTjhDAc4WPE3BbvP3auleWIgXw19OJYa
	 wCRcfVWJ45ZMA==
Date: Mon, 19 Aug 2024 16:14:41 +0100
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
Subject: Re: [PATCH v10 18/40] arm64/mm: Handle GCS data aborts
Message-ID: <24d33455-d958-4f27-8a2c-4f237fc2bd29@sirena.org.uk>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-18-699e2bd2190b@kernel.org>
 <ZsMNwAsAWr2IxFns@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4ClE/UJ5laHl8PFo"
Content-Disposition: inline
In-Reply-To: <ZsMNwAsAWr2IxFns@arm.com>
X-Cookie: Interchangeable parts won't.


--4ClE/UJ5laHl8PFo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 19, 2024 at 10:17:52AM +0100, Catalin Marinas wrote:
> On Thu, Aug 01, 2024 at 01:06:45PM +0100, Mark Brown wrote:

> > +static bool is_invalid_gcs_access(struct vm_area_struct *vma, u64 esr)
> > +{

> > +	if (unlikely(is_gcs_fault(esr))) {
> > +		/* GCS accesses must be performed on a GCS page */
> > +		if (!(vma->vm_flags & VM_SHADOW_STACK))
> > +			return true;
> > +		if (!(vma->vm_flags & VM_WRITE))
> > +			return true;

> Do we need the VM_WRITE check here? Further down in do_page_fault(), we
> already do the check as we set vm_flags = VM_WRITE.

> >       if (!(vma->vm_flags & vm_flags)) {
> >               vma_end_read(vma);
> >               fault = 0;

It looks bitrotted, yes.

> I was wondering whether we should prevent mprotect(PROT_READ) on the GCS
> page. But I guess that's fine, we'll SIGSEGV later if we get an invalid
> GCS access.

Yeah, that doesn't seem like a particular problem - the concern is
adding rather than removing GCS.

--4ClE/UJ5laHl8PFo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbDYWAACgkQJNaLcl1U
h9CIagf8CVGRJRPIYEL8OXtLlRDHe/BAx31NyJ8PnnV2H/LyZ/HkpxFqkEdopZ2W
SnomGLDZ/Sbry7VZUUVbO9QNmD/7UinwFR26WOigUY8aHtv/SDsMpx68OMvMPGtp
aOgTkLDZdZiL3OZbxsdYj24aQ2gywicEb/JxgcqYwclQvQn3geXt9wvBJIZvUqOI
f9ioaV7/pP5zWb35Kra+jjC2CUxouQ1ozkrxlJhyTT9VM3I4iefpf6eaGmgah7G9
n5vrIJWkdxaC4B8K/p+Uk/2LJYWdvOho+S1PnJPJloXX/3+dCvveT+3yVcEzT1z0
73smiFLb21oBkc5wjzRqiGDdQA7z3Q==
=d5gu
-----END PGP SIGNATURE-----

--4ClE/UJ5laHl8PFo--

