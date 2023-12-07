Return-Path: <linux-fsdevel+bounces-5163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0963808AC7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 15:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47869B21032
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 14:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2F544378
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNjNn79q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C96C40BE4;
	Thu,  7 Dec 2023 14:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B982C433CA;
	Thu,  7 Dec 2023 14:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701958349;
	bh=47UZfvnQWDEJSOeupCYwAYrzuYtNC/T8g7iT65OoBZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KNjNn79q5qw9TWzhiTTP83A72DjqspeTkbwfxzoFnhtiod+ean4s/g2ZihwzwXDAU
	 Am57C5Ozpebi7RrIDin2lfTxnQxnd/g1SJoTl2stCv7gjEib8S29onQm4DWkSwfzAZ
	 zQi1z8Fa3bGDCUGc8ZtXlmlIVQ6Xi6yNJgaAYtgdyVUXKyIp8aiTF0U1YOWvQahFHS
	 ovxFQg0P0owLouv5ZAp97Cl/VvE9siUPJngtZBoqORuYrfG2l/L7z/ZrGnG0gD2Q4f
	 uSh67mCPQywqM40/rxG+J9b+1jRbCMjSIyBubfR+IcM6KHPn1/BRu4XSAbS+A0laFC
	 Gp0YR7Yh9D9NQ==
Date: Thu, 7 Dec 2023 14:12:23 +0000
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Joey Gouly <joey.gouly@arm.com>, linux-arm-kernel@lists.infradead.org,
	akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
	dave.hansen@linux.intel.com, maz@kernel.org, oliver.upton@linux.dev,
	shuah@kernel.org, will@kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v3 05/25] arm64: context switch POR_EL0 register
Message-ID: <6ff480e3-e2d4-472a-ba6f-4037e438f69b@sirena.org.uk>
References: <20231124163510.1835740-1-joey.gouly@arm.com>
 <20231124163510.1835740-6-joey.gouly@arm.com>
 <ZWHiaTO6VUzHmbDB@finisterre.sirena.org.uk>
 <ZXHO0_ypVTUb392K@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tFLJkYHdpJA4U9vc"
Content-Disposition: inline
In-Reply-To: <ZXHO0_ypVTUb392K@arm.com>
X-Cookie: Two is company, three is an orgy.


--tFLJkYHdpJA4U9vc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 07, 2023 at 01:55:31PM +0000, Catalin Marinas wrote:
> On Sat, Nov 25, 2023 at 12:02:49PM +0000, Mark Brown wrote:
> > On Fri, Nov 24, 2023 at 04:34:50PM +0000, Joey Gouly wrote:

> > > +static void flush_poe(void)
> > > +{
> > > +	if (system_supports_poe())
> > > +		write_sysreg_s(POR_EL0_INIT, SYS_POR_EL0);
> > > +}

> > Here we have no isb()...

> My immediate thought was that we'd not care about the ISB here since
> we'll have an ERET before getting to EL0. However, we may have some
> LDTR/STTR populating the new process args page on exec which may, in
> theory, pick up a stale POR_EL0.

Yeah, it was a combination of the inconsistency and the lack of clarity
over there being a path which could potentially use POR_EL0 before ERET.
We at least probably need some comments with regard to the requirements
here.

--tFLJkYHdpJA4U9vc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVx0sYACgkQJNaLcl1U
h9AZCgf/X0uy8/6EiE75lAKZoYXgFKyGs21xpo+KNf8OlxnW1Cmwd9pWCniE0DGV
/4Knlc88paXTUnUA8ufobkjiQdj+R2nYJUnW62qD/SfOULo8As//rlpui0NgjfYO
2e2UKWEJ0cHFdSGifE0R4DF3qmQFo5K73m7ywedSo1IMrbM6EIR6qBTOe3mnOIcu
ofI81TpLR6gKiz0hA2uWNITQQK8VNG0Czuvi6QaIVOKnADLbPFP5orAZDEdt4t06
Qa13Ok13tFqqUSxGnsHFnCLRvRILPy2L6ecupywOUsgtMIj3kkfTi4uMRs4EPcMx
6eViRFXbIAXNsGbjwlE1t4vNBPLbBQ==
=nEdy
-----END PGP SIGNATURE-----

--tFLJkYHdpJA4U9vc--

