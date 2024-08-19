Return-Path: <linux-fsdevel+bounces-26276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633A2956F29
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 17:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15553284ED5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 15:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F0416CD0C;
	Mon, 19 Aug 2024 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrEBxu+g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F9C13C67C;
	Mon, 19 Aug 2024 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082292; cv=none; b=k7dmOJMeHnZJTjnGiNEG2l9exTFQjs/yDrst4K3tgkqZvCz50TPxczqoKh0XWEQyW3a3wVg4eQSpfVkDys5gIjjQXiTCE6uvbxynDefr1zdGdlr0f6MUaLgIFeOalgRt8uQ+2HYN5f+GOaEMsUWh5+CaAZbuEyv0o5rsWaMnrLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082292; c=relaxed/simple;
	bh=9K0lJYsHQSHszMJjX6x7fDt2250JGt/1bnUzF/FZPSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBbmFqtR6iDSs0kEclbaG6WQxGVqS1SKeAV8jolYILC/TLOq3j9uJ1E8aTIvVMrD18JKRPdX4pefEUI4JvhBSjVl+bG5f6beIEopfqbkoZBQf0Q9w0dBYHCMvs74txPmrvvlXidtVXcMjnmOK1uEsfbWopduod4P/5Gjpg6veaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrEBxu+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65FAC32782;
	Mon, 19 Aug 2024 15:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724082292;
	bh=9K0lJYsHQSHszMJjX6x7fDt2250JGt/1bnUzF/FZPSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jrEBxu+g3W/W+F6pOwBR+ng5/r6bUlowypNEQ5XHXHVtCPf0wKbvU4xTgMe9Qetd9
	 CpxBjhrcQP82vY34DM/oKUpHXTPk2KEebrCDA3E0dMchzEiyt0dca2ruZpP+KvX71Q
	 NwDog8RMhIViPcZETR41MbRx0xKj/jUc44DG9evJ+m9HP5CRKyjS+M7TufOKn5ciyF
	 3LWI3TU1CsuCqWTWGOZMfOVKsxB+FXtrKuo0wgw6hyF8PRTBVcGrH8B1mD03k5dX2L
	 VBG1R7OT29miF6OIF7EC+xeskwwWxFN4tCku3j084T6J6hzY96a0cH2CTJ6UGJaAvl
	 yKUaOabpdi6/A==
Date: Mon, 19 Aug 2024 16:44:42 +0100
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
Subject: Re: [PATCH v10 19/40] arm64/gcs: Context switch GCS state for EL0
Message-ID: <0f6fd3ec-2481-4507-af0e-3cbbb7406b54@sirena.org.uk>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-19-699e2bd2190b@kernel.org>
 <ZsMwhdmE_Ai9BbM9@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RY211L+JHDJI/V3D"
Content-Disposition: inline
In-Reply-To: <ZsMwhdmE_Ai9BbM9@arm.com>
X-Cookie: Interchangeable parts won't.


--RY211L+JHDJI/V3D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 19, 2024 at 12:46:13PM +0100, Catalin Marinas wrote:
> On Thu, Aug 01, 2024 at 01:06:46PM +0100, Mark Brown wrote:

> > +	/*
> > +	 * Ensure that GCS changes are observable by/from other PEs in
> > +	 * case of migration.
> > +	 */
> > +	if (task_gcs_el0_enabled(current) || task_gcs_el0_enabled(next))
> > +		gcsb_dsync();

> Could we do the sysreg writing under this 'if' block? If no app is using
> GCS (which would be the case for a while), it looks like unnecessary
> sysreg accesses.

Yes, that should be fine I think.

> What's the GCSB DSYNC supposed to do here? The Arm ARM talks about
> ordering between GCS memory effects and other memory effects. I haven't
> looked at the memory model in detail yet (D11.9.1) but AFAICT it has
> nothing to do with the system registers. We'll need this barrier when
> ordering is needed between explicit or implicit (e.g. BL) GCS accesses
> and the explicit classic memory accesses. Paging comes to mind, so maybe
> flush_dcache_page() would need this barrier. ptrace() is another case if
> the memory accessed is a GCS page. I can see you added it in other
> places, I'll have a look as I go through the rest. But I don't think one
> is needed here.

It's not particuarly for the system registers, is there's so that
anything else that looks at the task's GCS sees the current state.  I'm
pretty confident this excessive, the goal was to err on the side of
correctness and then relax later.

--RY211L+JHDJI/V3D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbDaGkACgkQJNaLcl1U
h9BvXwf/RQT11d03bUvuvD6MuYImODPR+T57Yc5/4X0OndD0EPF5k5PWbkvH//Tw
ZLgMt2oTPhRGxuAsNqSI3SJndV6cvgGv2BgT8L/c48ftU6TrvwdLiFuEXY6wzpTu
NcL4WCQ/1U9z74jPkVSAAyyLyhHkjXyzlnlweiOH2IiBaUtoJrq7TcRjAjChMRLG
noxrNAXiLahjU8QUP1bvQeMrCGWdz4TT/sCHjf8Gwo9kySFe8KOcFH56x4FHt+J4
xktf7O8cR+W41/Y+T2xSadecOHrdXU8fW2X/6o5252Ims33XJpYsyrzDV42nzv1T
gKlZCm6EGCD0AKemQ2JTc3fuppNpzw==
=ff4l
-----END PGP SIGNATURE-----

--RY211L+JHDJI/V3D--

