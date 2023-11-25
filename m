Return-Path: <linux-fsdevel+bounces-3801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB047F8A73
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 13:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E5D82816EC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 12:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B5EEAE5;
	Sat, 25 Nov 2023 12:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diLxf7zo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1611D539F;
	Sat, 25 Nov 2023 12:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF71C433C7;
	Sat, 25 Nov 2023 12:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700913772;
	bh=tuP3mnsyjalSFkRoYilZotwb2CTmKBTRrdYxee7FyEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=diLxf7zoZzu/TtTiAEGeGm69Lqim48csQd7BtltmOaYD2RG8p+qiG5DOP5EEitwMZ
	 4IOBNKkcnNTeg9qr/Weow3vmUlYvtkYy1eFNkWzLnPE7/f7E15JVWJzZOmZpOOCP3l
	 VYDc8ri5hrWYdfpeQLLTWdJR/4NO4Az3CEaPJnGAU6gK6MAo4Gogk42UooIz8GuA8w
	 WBXPVwIBcoO4EJcTokwYORM3Wd7E3CsV3uS8wfLicwSx222uEVefKFvlYlUFVmbcIb
	 +i6ZeuqTRu5KKdT5R14SjAa8nznIMB2NoKcXmuzfK/xmNpnGFGTfOg2CigmxQxPEtq
	 JSO854vAMR2FQ==
Date: Sat, 25 Nov 2023 12:02:49 +0000
From: Mark Brown <broonie@kernel.org>
To: Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@linux.ibm.com, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, maz@kernel.org, oliver.upton@linux.dev,
	shuah@kernel.org, will@kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v3 05/25] arm64: context switch POR_EL0 register
Message-ID: <ZWHiaTO6VUzHmbDB@finisterre.sirena.org.uk>
References: <20231124163510.1835740-1-joey.gouly@arm.com>
 <20231124163510.1835740-6-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ow+J4bMvxCVXQcLF"
Content-Disposition: inline
In-Reply-To: <20231124163510.1835740-6-joey.gouly@arm.com>
X-Cookie: Slow day.  Practice crawling.


--ow+J4bMvxCVXQcLF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 04:34:50PM +0000, Joey Gouly wrote:

> +static void flush_poe(void)
> +{
> +	if (system_supports_poe())
> +		write_sysreg_s(POR_EL0_INIT, SYS_POR_EL0);
> +}

Here we have no isb()...

> +static void permission_overlay_switch(struct task_struct *next)
> +{
> +	if (system_supports_poe()) {
> +		current->thread.por_el0 =3D read_sysreg_s(SYS_POR_EL0);
> +		if (current->thread.por_el0 !=3D next->thread.por_el0) {
> +			write_sysreg_s(next->thread.por_el0, SYS_POR_EL0);
> +			isb();
> +		}
> +	}
> +}

=2E..but here we do, I'd expect them to be consistent. =20

If the barrier is needed it'd probably be helpful to have a comment
explaining why we need it before the ERET.

--ow+J4bMvxCVXQcLF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVh4mYACgkQJNaLcl1U
h9BPiwf7BZimFuxNSYhP3hqXG6y4xu3e8rftssQCYtcNtXnIVlsn/6C7YMdoBuw2
TV0LvyB1ZLjJRA8D9lBOsGm/MyW/yw15yHRHUYs+F+2+1mr8juEVIt+311HWRl9b
JgBFfc+5fmzNpHr7xLAkgLY49z+cm0YXSx8NbyAO71UZj/hOyGsTuzVEoflXWKmG
bmTAK2h5QqW3gRwf/Ty/BE9bCDGp7xLKTZXSdRCZxS+321SCBqIZbalqJ53oePCT
YqYDr7McCoyhEv9QYhg3hh1+Yeg5ieFylfAQJmMzd8r2MU/zdYAbS8zFmPNPMBKP
XhIttzUePYRY9o9GJyOLYSjqKkZ9Yg==
=iEOq
-----END PGP SIGNATURE-----

--ow+J4bMvxCVXQcLF--

