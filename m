Return-Path: <linux-fsdevel+bounces-26081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C481395386E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 18:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7385E1F24569
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 16:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF69B1BA879;
	Thu, 15 Aug 2024 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVPQBXWf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185D11AC8B2;
	Thu, 15 Aug 2024 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723739963; cv=none; b=Q7SfuZr/skI1dTTRJIdybPkq1qn9BEcgipKQRxsEYYSpoBJtQPvuI6LkvWAmwKNRLbQlO6+jiTASa/7rO33Lz8DQe0LuqvADncdrdu/lZnVmcNPbknArMEg8gRJGTQyk4JtCRLcMiDyjmx3QIvxg2FFBGCrl1jay1Q+qKzYAVhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723739963; c=relaxed/simple;
	bh=nqEGxPh8pwY20u2MZKu3nNO4QLRYnQ4hjFehvCemvbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5iVzMP+JSbKUYqsNVjRQYfP5ZZ0ezL9qp86WuLFReDS2+7umNVvlhjEo4FOUXZMcNvW8909FpSuZ4us9vsrR2wWQTJFKVI0r15QYbbonSaJ5IJx/nrhmI8TiS0NHlGNzGYpfdwTlyb8yVkOrX6+TFkaNhCpW8OROfOadBp0brU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVPQBXWf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A991CC32786;
	Thu, 15 Aug 2024 16:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723739962;
	bh=nqEGxPh8pwY20u2MZKu3nNO4QLRYnQ4hjFehvCemvbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mVPQBXWf4rO5tqOD7E573dr/pYnLkTbMxIobg0TVBQo8vrWdsI+BSdGVLxb3z+DuI
	 AB3CwtvHVEesic9NWEB62pNPzB0UJqdc4mZ/YzivT5ZFGoUdfWmLZh0iYBRkZNSExn
	 CGmJRmgQTCFJdl9Jw4SsQ6861ethBoLCMBjuFdUCeyp75mtiYAk9jbkXTk4v+6uMeT
	 No3dA8UXevsw+hJpGxWXFGCI0EsP6KJ4mwGaZhjhGW8rn/ZTEU4zMNmsprnEpxb62I
	 jijupNJtzAxMTcTemcyG6LtY/cD39wLSqWkRJGa6R7ozAs02XXoMJxVcOvJZnO77q8
	 Ub0FE7zYHQYCA==
Date: Thu, 15 Aug 2024 17:39:12 +0100
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "ardb@kernel.org" <ardb@kernel.org>,
	"maz@kernel.org" <maz@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"oleg@redhat.com" <oleg@redhat.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	"will@kernel.org" <will@kernel.org>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"kees@kernel.org" <kees@kernel.org>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"ross.burton@arm.com" <ross.burton@arm.com>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"thiago.bauermann@linaro.org" <thiago.bauermann@linaro.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v10 12/40] mm: Define VM_SHADOW_STACK for arm64 when we
 support GCS
Message-ID: <68ec09da-fb4a-4d59-9c8c-6fae4c48ea68@sirena.org.uk>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-12-699e2bd2190b@kernel.org>
 <34f7a5378447b1a8d5a9561594b37cfeaa6bd2b1.camel@intel.com>
 <3a7d9b69-e9df-4271-a3f0-8e8683c2654f@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vKd189vsbNknapJj"
Content-Disposition: inline
In-Reply-To: <3a7d9b69-e9df-4271-a3f0-8e8683c2654f@sirena.org.uk>
X-Cookie: -- Owen Meredith


--vKd189vsbNknapJj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 15, 2024 at 04:26:47PM +0100, Mark Brown wrote:
> On Thu, Aug 15, 2024 at 03:20:52PM +0000, Edgecombe, Rick P wrote:

> > FYI - If you want to have more complete guard gaps, you need to do this for arm
> > too:
> > https://lore.kernel.org/linux-mm/20240326021656.202649-14-rick.p.edgecombe@intel.com/

> > Using VM_SHADOW_STACK only gets you part of the way there.

> Oh, thanks for the heads up - I'd missed that.

Looking at this I think it makes sense to do as was done for x86 and
split this out into a separate series (part of why I'd missed it),
updating the generic implementation to do this by default.  That'll
touch a bunch of architectures and the series is already quite big,
it's not really an ABI impact.

--vKd189vsbNknapJj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma+Ly8ACgkQJNaLcl1U
h9AuIgf+OuQaTIedzXEkMKSzSn8gQPJlIY5KrokvUJ1INFNplupcL8meQbjGaCke
k6p6rULpXRg8dAR2gjIllIWy3YaYrcqKK7VUWUVHy2rdwtozDi5JICj3GVYrZ1N4
RHRL44Xq/dMXBORv5Zm06QeTaZxhgmj+wKvnVVrgiZN33cbHEULW5W3HX/qCcsDe
7qR7858W0Qkm1wZ8tyY3UkGI8AiUO3oMCaQ/pokDf9EDQagBid3Aqe0iMQmRacMZ
XaEy5ijWBddwXQb8qolzElM+ySPoxEf+jwEqHAH6WP4ke1NlJrj6+Xn7JN+/OuY8
Lv5n7BHbDEebZQo46ohDBN+Q0iR0vg==
=uwcZ
-----END PGP SIGNATURE-----

--vKd189vsbNknapJj--

