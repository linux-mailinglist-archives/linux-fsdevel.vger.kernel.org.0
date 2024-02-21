Return-Path: <linux-fsdevel+bounces-12295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB30985E4B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 18:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CB77B23882
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 17:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E32C84038;
	Wed, 21 Feb 2024 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O12n148t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB93F82865;
	Wed, 21 Feb 2024 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708536983; cv=none; b=oar2RshXI3OCV8qDYcrJvi1AW99x0vWqXR9A+fMDneD7eJcRpefdD6mrzG7Sy2LAg3QLX6eB9YgkVvLAd76il2NnbxB6/QK+Q5smlBcS3769SSafM7OWuHPF96IEuM5tZpy+kfHyOQse2Fo0mFY5cVxgI+JywSir8w1oT/Ab8dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708536983; c=relaxed/simple;
	bh=yiMUcDHHU5n4NoQ84wGw656HnuqVIwBmqSIpUYSySM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pm4hsDeN3YzFtJKMeEL4BpULGS6KHPSDVs55bYyiDpFpGaTnAW3znsuhOLg6vgMKtlOvKxvsvNhDKjuKYxpK4msIPatgic+wc/M2tHGFwruH2t/WTg16ZiC4rWWLZSKhznxa12MjoM5z5gljdXApqog/KsUKDz7T1nKtyGq7hXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O12n148t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569D2C433F1;
	Wed, 21 Feb 2024 17:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708536983;
	bh=yiMUcDHHU5n4NoQ84wGw656HnuqVIwBmqSIpUYSySM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O12n148tnxl0hHrH0KNUw308nap2CMfsjiJaCO+G6etl5udAA3V57bqbWZBFQUGZs
	 Kj4x4GxnB2NHbhBuzMjO33ReX0o4unLwDVUsx7rE6BrK0mSY+AQVi1U20errE3mUk7
	 nVTIbjx7vjPf0I68CWxX1fA4b1OFc0RyrKyDq5swD9NlwBDQWruvA/i+WNXsvWkpRM
	 uYyCW+odtKyrAny0HBpdXJaxNnNh93OFpmEFT500VAoVKZsfjMLpKQM8nF17WmQNVZ
	 f7b+uqFxyhSA53z6Utjz7HKlp+QYfzdvrhQRfPQSg/ENFM+J0kh3Y5lihL5FmDHnX1
	 07XkRuq4u5RdA==
Date: Wed, 21 Feb 2024 17:36:12 +0000
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
Message-ID: <4a3809e8-61b2-4341-a868-292ba6e64e8a@sirena.org.uk>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
 <22a53b78-10d7-4a5a-a01e-b2f3a8c22e94@app.fastmail.com>
 <4c7bdf8fde9cc45174f10b9221fa58ffb450b755.camel@intel.com>
 <20240220185714.GO4163@brightrain.aerifal.cx>
 <9fc9c45ff6e14df80ad023e66ff7a978bd4ec91c.camel@intel.com>
 <20240220235415.GP4163@brightrain.aerifal.cx>
 <a57d6c7eada4b9a7c35addbc8556f5b53a0c3e6f.camel@intel.com>
 <20240221012736.GQ4163@brightrain.aerifal.cx>
 <d18f060d-37ac-48b1-9f67-a5c5db79b34e@sirena.org.uk>
 <20240221145800.GR4163@brightrain.aerifal.cx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SXzKVr6cSzokmvVK"
Content-Disposition: inline
In-Reply-To: <20240221145800.GR4163@brightrain.aerifal.cx>
X-Cookie: The second best policy is dishonesty.


--SXzKVr6cSzokmvVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 21, 2024 at 09:58:01AM -0500, dalias@libc.org wrote:
> On Wed, Feb 21, 2024 at 01:53:10PM +0000, Mark Brown wrote:
> > On Tue, Feb 20, 2024 at 08:27:37PM -0500, dalias@libc.org wrote:
> > > On Wed, Feb 21, 2024 at 12:35:48AM +0000, Edgecombe, Rick P wrote:

> > > > (INCSSP, RSTORSSP, etc). These are a collection of instructions that
> > > > allow limited control of the SSP. When shadow stack gets disabled,
> > > > these suddenly turn into #UD generating instructions. So any other
> > > > threads executing those instructions when shadow stack got disabled
> > > > would be in for a nasty surprise.

> > > This is the kernel's problem if that's happening. It should be
> > > trapping these and returning immediately like a NOP if shadow stack
> > > has been disabled, not generating SIGILL.

> > I'm not sure that's going to work out well, all it takes is some code
> > that's looking at the shadow stack and expecting something to happen as
> > a result of the instructions it's executing and we run into trouble.  A

> I said NOP but there's no reason it strictly needs to be a NOP. It
> could instead do something reasonable to convey the state of racing
> with shadow stack being disabled.

This feels like it's getting complicated and I fear it may be an uphill
struggle to get such code merged, at least for arm64.  My instinct is
that it's going to be much more robust and generally tractable to let
things run to some suitable synchronisation point and then disable
there, but if we're going to do that then userspace can hopefully
arrange to do the disabling itself through the standard disable
interface anyway.  Presumably it'll want to notice things being disabled
at some point anyway?  TBH that's been how all the prior proposals for
process wide disable I've seen were done.

--SXzKVr6cSzokmvVK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXWNIwACgkQJNaLcl1U
h9CDBQf/b2osUy8IL9ugqihJXvxZdZ2gjHyphrXKAEbbUT4oT2dVS/P4nlvlYurY
9IML2O8yTSshh0R+WaZCQ28PqhVENeRSLmgsuSIDiSrLY66okGApL4XVaAWAek2d
KvQ3CU5OkGfGONdHJpiaDdcQbFBuEvUq258Kv+jUJnTKUnmFIjGeM1SIZzQMbrUH
6cXrpAA0Pqc5yrwYFzYxky0ZScQRgr1RQMV43e7IbCtfGnFfbvevfzgWwzZINjf9
kjz8RcfyhXuAoW1sAaXsPz49nL0NGr4l5riEdr3SmDYyvhJ5LEpDnFtANzD4lD3E
cZMNKqJyog/SgaLaqh6dMTlV5Qd9gw==
=pmML
-----END PGP SIGNATURE-----

--SXzKVr6cSzokmvVK--

