Return-Path: <linux-fsdevel+bounces-26086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD75A9539D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 20:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0D51C23560
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 18:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F49B64CEC;
	Thu, 15 Aug 2024 18:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmAPusW9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DEF481C4;
	Thu, 15 Aug 2024 18:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723745974; cv=none; b=kfpb7c10tXyPMkfSqvs4mocrlwaiqfEts36Zdftn4HPfCA2U+g3JuYb3YQRrkWyy6lu3lq+YeJ8HvIYVGDDDt07niEh6pp1mEzMgNF5qjpPJ3T5pHNzY3rLA3sOeSWUcENGFrfjf0oOK6xmS9DNybS78D3LtxeIawrzkFz22KmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723745974; c=relaxed/simple;
	bh=gvOHdCK9aUdR7DPVLDdBmQ4rCqBdWg1NiIKC9n0vn/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=na5yoBDuTp9Xk4YocxzqnEyvyg236iZd4McF7x8d1wVI4N+IfgKQVVmRMUsrtJuVfq1T3updEVyZDF7fuintRexxbYKECmfb/puUBG20Rh+C6hcbsVOic3QeAAC7U9ZfZzaJ11hnZMJtj7S4DgriVZaTxOcodAL8GIpcNZ2JNVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmAPusW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDE0C32786;
	Thu, 15 Aug 2024 18:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723745973;
	bh=gvOHdCK9aUdR7DPVLDdBmQ4rCqBdWg1NiIKC9n0vn/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jmAPusW9RWevvrm7Hg88q9xewbIsd/N/8xTtQyDPWPc982vMFTh7r29JlLa6aHf0o
	 8io0uPtO83IiC/fkk0GKoQNNWuDUbOcvZAodgohYE/SjWTMQpUBTSbad1t64GFmGyS
	 iVChoroyACoTlO+/w+ZVPqDVFAt/hYnGedb6MWnURMr/r772xCwXH9niKnJdXYUqJX
	 ljF+fG3keMrMEmAZlQBZgeB5qVBYqMTd2O22DXiRYL9ul8f7b5FVTiy0/sBLHu0Gpw
	 9wAE4WmxHy9lFZGd0S9lYGKcP1IFTR4cDZzHAlueePqA4AxAzNcZtdqHVh8a0mF8BL
	 9fI1RwFnauAuw==
Date: Thu, 15 Aug 2024 19:19:24 +0100
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"ross.burton@arm.com" <ross.burton@arm.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"kees@kernel.org" <kees@kernel.org>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>, "maz@kernel.org" <maz@kernel.org>,
	"oleg@redhat.com" <oleg@redhat.com>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"thiago.bauermann@linaro.org" <thiago.bauermann@linaro.org>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"will@kernel.org" <will@kernel.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"ardb@kernel.org" <ardb@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v10 12/40] mm: Define VM_SHADOW_STACK for arm64 when we
 support GCS
Message-ID: <9949a344-be8e-40ed-b483-02ff95175072@sirena.org.uk>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-12-699e2bd2190b@kernel.org>
 <34f7a5378447b1a8d5a9561594b37cfeaa6bd2b1.camel@intel.com>
 <3a7d9b69-e9df-4271-a3f0-8e8683c2654f@sirena.org.uk>
 <68ec09da-fb4a-4d59-9c8c-6fae4c48ea68@sirena.org.uk>
 <e6c8618a1585006dde44c17192a3bb7ae8ec5c0b.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U12vN05f82sjc1Kd"
Content-Disposition: inline
In-Reply-To: <e6c8618a1585006dde44c17192a3bb7ae8ec5c0b.camel@intel.com>
X-Cookie: -- Owen Meredith


--U12vN05f82sjc1Kd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 05:53:19PM +0000, Edgecombe, Rick P wrote:
> On Thu, 2024-08-15 at 17:39 +0100, Mark Brown wrote:

> > > Oh, thanks for the heads up - I'd missed that.

> > Looking at this I think it makes sense to do as was done for x86 and
> > split this out into a separate series (part of why I'd missed it),
> > updating the generic implementation to do this by default.=A0 That'll
> > touch a bunch of architectures and the series is already quite big,
> > it's not really an ABI impact.

> The series is already upstream. You just need to add an arm version of th=
at
> linked patch. But up to you.

Your series modified the existing x86 custom arch_get_unmapped_area*()
functions, arm64 uses the generic implementation of those so I'd have to
either add custom implementations (which I can't imagine would be met
with great enthusiasm) or update the generic ones.  A generic
implementation seems reasonable and it looks like RISC-V would also end
up using it so while it's a bit invasive it does seem more sensible to
do the change there.

--U12vN05f82sjc1Kd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma+RqsACgkQJNaLcl1U
h9C2ogf/ZUz9M5cZLraiijYr3jTrEMdCaa6D0jRDGoL0IP3BclPhluw29VOQVf4x
aJ10O4eGMRHl32XL0oWXQlmSmjiHfXTvVmeAnPrKkq6Sx8BDI7tOW1f4b64Iyouq
aGNPYw1YjXPdazXxXLbaQVZZOrq5BE2dbXw6ocHaombvt/oG6sAGc4F4KFXwb6+A
OR+jpoND8CbzSxh4EO89eoixTKgqvVZTLfQ3zZBdyjrrk1jyp6Q/63wMC325Bmam
FebFR/NFJlNNAGpnhBbZhme21z1oZ+1h9K6G37zJUsXqqkOnH56fbsfKJ3wGW37B
VjXIsdlILKUDIICvYmo5rxepKRyUqQ==
=DIrs
-----END PGP SIGNATURE-----

--U12vN05f82sjc1Kd--

