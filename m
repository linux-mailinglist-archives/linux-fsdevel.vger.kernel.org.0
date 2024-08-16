Return-Path: <linux-fsdevel+bounces-26115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DA6954877
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 14:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3C5284902
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 12:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394501AE87B;
	Fri, 16 Aug 2024 12:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lammGcz+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83878156F44;
	Fri, 16 Aug 2024 12:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723809752; cv=none; b=f+QLPcCuiXJcGdAHu60XxYHadWy33lav9wNM7+GVqnHYkW1MHFrtgZcspp1PfbOxdHnm+ydnp8t30j8FzwYppuwwckjCnrMTyWk+2uirsJR9Z0cD5WgpbaMsGhdKLOBW+4Wu34iMTDDfe9KfbfAQGagl26QBjvDol1nxkFPCTfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723809752; c=relaxed/simple;
	bh=oPeCvIbifLel6Ow5IZxAJAB7Vu3RJACPj3rWPilHCSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=te5ImRZvugcFy3zuE2UJRPaFLfcVdvhbmAOt5/QcuB8MHwgxjjZSJXeDijX2E38O2Sk9H9OB4ZmHnlmDpd10R99OO4FEGIsoJjsc8GB56ukj4s94RTXlKcy/c/ixpVzXVqJPUdG/g7QYNZm2J3G2cJ0AK5L9ydBuyRoW/Nav4dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lammGcz+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3A6C32782;
	Fri, 16 Aug 2024 12:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723809752;
	bh=oPeCvIbifLel6Ow5IZxAJAB7Vu3RJACPj3rWPilHCSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lammGcz+t6OGLNs0WJ0Ion4Wo4GhurUkVu9VWiP20uUI84FAGr99BGSEVKLI3fz0A
	 fdGUkReozzGf4aWRVUznXu1+ekkxTAXKX9asXpNuaMQ1tYN4asJdK2ScKq+YtJngv9
	 eBTUzZ6sgM4PJfqhUUEouo3q1afG4J2UT9kK9sHh3i6JTPG7VScNqDMPYJjMiJ/yEb
	 aDHpqxKNlUXj5jxTAw9xe58I5LaYxqrSdwd8JLqUkMgLqODMxadE/yFK1sG8NLIRrS
	 rF0cmj1k6ZNEaPvijrCCoPuA1yH2NQ+PEC7/6R5P2m1BKIliB/yCGa8WCxE1omVOJe
	 vrEUxH6ID2hnA==
Date: Fri, 16 Aug 2024 13:02:22 +0100
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
Subject: Re: [PATCH v10 05/40] arm64/gcs: Document the ABI for Guarded
 Control Stacks
Message-ID: <7c17b28e-a5d1-4113-9580-9501692af513@sirena.org.uk>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-5-699e2bd2190b@kernel.org>
 <Zr8zTTrJ6M0SCvCV@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p6v+ZIr+kcIsmhYm"
Content-Disposition: inline
In-Reply-To: <Zr8zTTrJ6M0SCvCV@arm.com>
X-Cookie: A Smith & Wesson beats four aces.


--p6v+ZIr+kcIsmhYm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 16, 2024 at 12:09:01PM +0100, Catalin Marinas wrote:
> On Thu, Aug 01, 2024 at 01:06:32PM +0100, Mark Brown wrote:

> > +* EL0 GCS entries with bit 63 set are reserved for use, one such use is defined

> Maybe "reserved for specific uses". The proposed sentenced feels like
> it's missing something.

Actually we removed the usage of bit 63 so I'll just drop this.

> > +* When a new thread is created by a thread which has GCS enabled then a
> > +  new Guarded Control Stack will be allocated for the new thread with
> > +  half the size of the standard stack.

> Is the half size still the case? It also seems a bit inconsistent to
> have RLIMIT_STACK when GCS is enabled and half the stack size when a new
> thread is created.

Yes, this predates the rebase onto clone3() - I'll update.

> [...]
> > +* When a thread is freed the Guarded Control Stack initially allocated for
> > +  that thread will be freed.  Note carefully that if the stack has been
> > +  switched this may not be the stack currently in use by the thread.

> Is this true for shadow stacks explicitly allocated by the user with
> map_shadow_stack()?

It is only true for the stacks allocaeted by the kernel, if we didn't
allocate a stack we don't free it.

> > +* The signal handler will use the same GCS as the interrupted context.

> I assume this is true even with sigaltstack. Not easy to have
> alternative shadow stack without additional ABI.

Yes.

--p6v+ZIr+kcIsmhYm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma/P80ACgkQJNaLcl1U
h9Dfgwf9EHMFRik1mUwmgRytVPWYPFLCBG8YZtDuO0Wxbs78KN6zc8ji2vFJ8lIJ
B1hNUxCH6BOhm+AfFVF3zkoXZn+wjlPnLRGOPJUodgh27zecCwTCrwayO8ncECyf
bIeq0XnjssL7P2A2wNVK0cFXU9W+Gw3OjVUAPUQmdC7lk6w4GwIMnpgQs1Vrueko
IO1qBTeiV0rySxm/x0E14lq3kpX7eAcrBERnR+wfA17R4CtVClV2S1lT8YyUdYl7
n81clFcHhylhTBz7napWIOchWjXqicUT7zqHLPKHMVxutUuuT1Mc+obOdDSUsdcl
8qUKqX887cAFNJNPd+6Nlq+t+MtUZA==
=6lHH
-----END PGP SIGNATURE-----

--p6v+ZIr+kcIsmhYm--

