Return-Path: <linux-fsdevel+bounces-26280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CFE957062
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 18:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DCB21F2138F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 16:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385DD178CF6;
	Mon, 19 Aug 2024 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/Xaqf57"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB3432C8B;
	Mon, 19 Aug 2024 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724085214; cv=none; b=LVRzf2VDIH+ItZZa5dkR4Ksl9R+hyrRLG6IYh2ZkvLcPC4ApEN1Wb0/w+hCG+EtcLYVMyOFJQgAfy/4OII8XLsZBSATMtqjFsNbt74EdU1zIMlmfPZY7dlv8/mDFOx3hcnEUpWB4Fh2e8PXNAFDuNLzfNq+9KUjwanvfnMoxrmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724085214; c=relaxed/simple;
	bh=evii6L2sZLuBZsDeVmQaiukOZYaMAFg0RqLOntPinT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9TSpGbN1Xv4AYgPS1oDUqBedOXgXtZhqpw5fRiKxWl7ixZwaY6DdYhww0KX8VcLl0ivUJO0mtfUJgfL6O45R+9LPO3LivDn/JEolmin7c4ULn3gBewNxFM/s0NUnu4Hi0Zw62AockZrnoaI0bnYwUKJBywYf4ogW8Rq0Xpof1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/Xaqf57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21E0C32782;
	Mon, 19 Aug 2024 16:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724085214;
	bh=evii6L2sZLuBZsDeVmQaiukOZYaMAFg0RqLOntPinT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p/Xaqf57XaWAVesDIXzLwFNmcsGpxCWxCiEl8e7wqsfX6gbZTVZaibIjtofHP+HQy
	 mNkfUOElC8Ed0VjXXvNq9aoGwmAtJUoqRfPxjW6pG4WzPvDPwk2E/ohMtDCdY0XuRP
	 7k9QW/RaYwIiYXeuG0zIRmMObdLvwZzA0wsODoXlGTOLMwINsKdtHKc+TgwAqr4ZO9
	 DbshXmifSQvXAnQSw7yxsDdm+PnnWXUw62cMAbR8DWLupzNOAJI8jMLgI1UYKzU84R
	 zNfPjPPoV8e0rLVIwnBnTaZ7upD0UC+dpiqjmwOqR5FFGfmA4YvEC6JEHoxtzdMqKk
	 RiCeykpYkKbQA==
Date: Mon, 19 Aug 2024 17:33:24 +0100
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
Subject: Re: [PATCH v10 13/40] arm64/mm: Map pages for guarded control stack
Message-ID: <d43f8036-cc06-430c-9e9e-b938037fc64c@sirena.org.uk>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-13-699e2bd2190b@kernel.org>
 <ZsMMDNIp6Pkfbg1e@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eyTciqf51C2CbNXu"
Content-Disposition: inline
In-Reply-To: <ZsMMDNIp6Pkfbg1e@arm.com>
X-Cookie: Interchangeable parts won't.


--eyTciqf51C2CbNXu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 19, 2024 at 10:10:36AM +0100, Catalin Marinas wrote:
> On Thu, Aug 01, 2024 at 01:06:40PM +0100, Mark Brown wrote:

> > +	if (system_supports_gcs() && (vm_flags & VM_SHADOW_STACK)) {
> > +		/*
> > +		 * An executable GCS isn't a good idea, and the mm
> > +		 * core can't cope with a shared GCS.
> > +		 */
> > +		if (vm_flags & (VM_EXEC | VM_ARM64_BTI | VM_SHARED))
> > +			return false;
> > +	}

> I wonder whether we should clear VM_MAYEXEC early on during the vma
> creation. This way the mprotect() case will be handled in the core code.
> At a quick look, do_mmap() seems to always set VM_MAYEXEC but discard it
> for non-executable file mmap. Last time I looked (when doing MTE) there
> wasn't a way for the arch code to clear specific VM_* flags, only to
> validate them. But I think we should just clear VM_MAYEXEC and also
> return an error for VM_EXEC in the core do_mmap() if VM_SHADOW_STACK. It
> would cover the other architectures doing shadow stacks.

Yes, I think adding something generic would make sense here.  That feels
like a cleanup which could be split out?

> Regarding VM_SHARED, how do we even end up with this via the
> map_shadow_stack() syscall? I can't see how one can pass MAP_SHARED to
> do_mmap() on this path. I'm fine with a VM_WARN_ON() if you want the
> check (and there's no way a user can trigger it).

It's just a defenesive programming thing, I'm not aware of any way in
which it should be possible to trigger this.

> Is there any arch restriction with setting BTI and GCS? It doesn't make
> sense but curious if it matters. We block the exec permission anyway
> (unless the BTI pages moved to PIE as well, I don't remember).

As you say BTI should be meaningless for a non-executable page like GCS,
I'm not aware of any way in which it matters.  BTI is separate to PIE.

--eyTciqf51C2CbNXu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbDc9MACgkQJNaLcl1U
h9DcCAf/aZF31au2O5tCW1iS32zwyPysrbia2QSwmoMPN4cH+zZF6jGKfJP53y/G
CNgaoXcyBX2iypaZnICHU23amdDQeA311XwIhP3tEc32tH2i0LgSO39EGLdA4dqe
j9An/W7fAj/0GD9s5qxLjEUDr8DKmihD4s/yemH3g2xwf/NF2Ya/tFXJWfAcJPNr
rg55UlkNM+WG6bZ21EKnqi/ykDJhHVBdmTEYE7vfyMDjneyhO5oMG6ESXUJFBTd6
JrYRPZb0Cr7QlXE2JRP2yZQG9TzS0WMvsi3TN5T17PRy8WpwtCyfLi3Drj5popSF
K/uduuEHbCFXxkFNmqeaOTGvnX2ozA==
=Qsdz
-----END PGP SIGNATURE-----

--eyTciqf51C2CbNXu--

