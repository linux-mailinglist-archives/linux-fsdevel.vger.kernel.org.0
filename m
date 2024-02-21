Return-Path: <linux-fsdevel+bounces-12307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D11C685E60E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 19:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4763C1F246EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 18:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CE98563E;
	Wed, 21 Feb 2024 18:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H40tZsSH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9299A3C068;
	Wed, 21 Feb 2024 18:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540350; cv=none; b=LZqybXkjD+104g3RnB6QTELKU0iQN/ePqk9kSvCyhk/B6lKZMpphQZvaVLKjBkswq9TviTQhwxQN7FYLaajCDRzJgI61iw0YG38AEcrbVMkhI4THcNGUkX2rQ/gQLSe/jPf8VF8sM0KyHJ27XZKlvniP9zypmOa0UBD1+EBFfeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540350; c=relaxed/simple;
	bh=2gbTzpi4a1N3obFiGlpwydsY4IO9OTAD9wjD4yTOHtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reh+Nck48pMPe7KXPwwFeLleWx6VIlDjJCJDZuR+MaYpXWZZOQvB6V2MbW0GNPT3TrCyJHjD2EHfV7QYKtlGjWEZUP9Iieyggw65ujFGKzzEa92YuUlut78hJy3qkCD6n9ZzfibWoeBO8ONJd58K/1jwETO1BTC9fHR6HHtbl+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H40tZsSH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761A0C433C7;
	Wed, 21 Feb 2024 18:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708540350;
	bh=2gbTzpi4a1N3obFiGlpwydsY4IO9OTAD9wjD4yTOHtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H40tZsSHO3GGXtYAAc+MX1H9hfXkqwzWeiS1DXzFw/AxJv57LXIcw9mhK5Su5mCC9
	 i7wBl/5lZkXR64n/gvb9Qu6kwvmY4KSzCfoDfdOA/0HOVJOyFi99fo5AUrZzfMf21M
	 H5ZfGf4y6MVG3cjBzbpNByDEsfiX1Nhpk3W13pSfKx1vxCizFYAPrtIdE1dQdlHFoa
	 M62tazglgeiMA/9SJ7abPRLFww+GYA8BdkndbbknsJBZotawG1kAYGbU/63Fwwwo5S
	 qZIBiA4tp0C5/RmatwR1pY7XKkdWRv+L3TpkPOGgYU7whHYd38xXjaXnKyLaZVOEPA
	 F+OljWdJ5xjYA==
Date: Wed, 21 Feb 2024 18:32:20 +0000
From: Mark Brown <broonie@kernel.org>
To: "dalias@libc.org" <dalias@libc.org>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"musl@lists.openwall.com" <musl@lists.openwall.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>, "maz@kernel.org" <maz@kernel.org>,
	"oleg@redhat.com" <oleg@redhat.com>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	"will@kernel.org" <will@kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"ardb@kernel.org" <ardb@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"thiago.bauermann@linaro.org" <thiago.bauermann@linaro.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"sorear@fastmail.com" <sorear@fastmail.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [musl] Re: [PATCH v8 00/38] arm64/gcs: Provide support for GCS
 in userspace
Message-ID: <b41e39d1-29f9-4958-9728-6781e72230f8@sirena.org.uk>
References: <4c7bdf8fde9cc45174f10b9221fa58ffb450b755.camel@intel.com>
 <20240220185714.GO4163@brightrain.aerifal.cx>
 <9fc9c45ff6e14df80ad023e66ff7a978bd4ec91c.camel@intel.com>
 <20240220235415.GP4163@brightrain.aerifal.cx>
 <a57d6c7eada4b9a7c35addbc8556f5b53a0c3e6f.camel@intel.com>
 <20240221012736.GQ4163@brightrain.aerifal.cx>
 <d18f060d-37ac-48b1-9f67-a5c5db79b34e@sirena.org.uk>
 <20240221145800.GR4163@brightrain.aerifal.cx>
 <4a3809e8-61b2-4341-a868-292ba6e64e8a@sirena.org.uk>
 <20240221175717.GS4163@brightrain.aerifal.cx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aNn12J2DOa91OM79"
Content-Disposition: inline
In-Reply-To: <20240221175717.GS4163@brightrain.aerifal.cx>
X-Cookie: The second best policy is dishonesty.


--aNn12J2DOa91OM79
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 21, 2024 at 12:57:19PM -0500, dalias@libc.org wrote:
> On Wed, Feb 21, 2024 at 05:36:12PM +0000, Mark Brown wrote:

> > This feels like it's getting complicated and I fear it may be an uphill
> > struggle to get such code merged, at least for arm64.  My instinct is
> > that it's going to be much more robust and generally tractable to let
> > things run to some suitable synchronisation point and then disable
> > there, but if we're going to do that then userspace can hopefully
> > arrange to do the disabling itself through the standard disable
> > interface anyway.  Presumably it'll want to notice things being disabled
> > at some point anyway?  TBH that's been how all the prior proposals for
> > process wide disable I've seen were done.

> If it's possible to disable per-thread rather than per-process, some
> things are easier. Disabling on account of using alt stacks only needs

Both x86 and arm64 currently track shadow stack enablement per thread,
not per process, so it's not just possible to do per thread it's the
only thing we're currently implementing.  I think the same is true for
RISC-V but I didn't look as closely at that yet.

> to be done on the threads using those stacks. However, for dlopen
> purposes you need a way to disable shadow stack for the whole process.
> Initially this is only needed for the thread that called dlopen, but
> it needs to have propagated to any thread that synchronizes with
> completion of the call to dlopen by the time that synchronization
> occurs, and since that synchronization can happen in lots of different
> ways that are purely userspace (thanks to futexes being userspace in
> the uncontended case), I don't see any way to make it work without
> extremely invasive, high-cost checks.

Yeah, it's not particularly nice - any whole process disable is going to
have some nasty cases I think.  Rick's message about covered AFAIR the
discussion, there were also some proposals for more limited userspaces I
think.

> If folks on the kernel side are not going to be amenable to doing the
> things that are easy for the kernel to make it work without breaking
> compatibility with existing interfaces, but that are impossible or
> near-impossible for userspace to do, this seems like a dead-end. And I
> suspect an operation to "disable shadow stack, but without making
> threads still in SS-critical sections crash" is going to be
> necessary..

Could you be more specific as to the easy things that you're referencing
here?

--aNn12J2DOa91OM79
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXWQbMACgkQJNaLcl1U
h9DFYgf/eUQGsS5iljaIOTVjUeRJr5sdmobctbHRbzZDrRfndMq/8GGcuj4IwRdx
QH2JWncI0dBc3SdIsUCDuiT5M80YdW0MbbyF0WnodznOGFFOmAdShPrpJOYpq0PJ
uxQlFwIl/RPfqC9VKTRflsuttBL5yWgTCWiM0qX0TSs8CSSzLHZJZGy0EB0BLJUj
aWIcOnrEMi/h7VJY3PdqDd048xQMlVz9u3igr9rRr0yInyVXgkBu5W+9ORlWZ9Tc
CDbo/yL8Wjz0PdEVRaoPUQqpVVfY01V/Ka3X3aX1b3VJBEkvcOCjncbp4epk3z9e
ZahyLth4XwKs8PXzuwjgpHYnESAYJg==
=//LR
-----END PGP SIGNATURE-----

--aNn12J2DOa91OM79--

