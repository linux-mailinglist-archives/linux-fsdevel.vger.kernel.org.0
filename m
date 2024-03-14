Return-Path: <linux-fsdevel+bounces-14400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9541787BE4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 15:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D92EB21AF6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 14:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF276FE36;
	Thu, 14 Mar 2024 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/9GI0MN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AAA6EB74;
	Thu, 14 Mar 2024 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710425020; cv=none; b=fi+VNCUEz4MU8M2N4j3ApbHWLa/dNw2Pc3QAgI0XDbQmtwc0RagABowO5Bd5fP3Gyg0gtC5S+WZz7BQ/l/hCIdjaFF4DgX1/OqMgWWNy8Ef979ePg+YWEahGRJj1dBWWlzh0dFxAZ6ZrWUCgGx+RnovOx/YedbBSYQD37jvHNZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710425020; c=relaxed/simple;
	bh=ocgVFU/TLLicKSAOp5e6Jw1mceRESxNPxDSwgKLBNEA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDizKREOZ2RgjVRx4bbzDj3beuAaHN34rQiCxj5TdtSukYTrhIvaFueWeVmmcdygC2fs5Ww56b5q4lpt6pHHwSTRWbPwXDgY/wS1x992R4wJHdgIvzlyFHDNw9z0RlIqnxrnRXyioQxcLSMFpe8FGP1pzrogXp/ZNPuayqJxpUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/9GI0MN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000D1C433F1;
	Thu, 14 Mar 2024 14:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710425019;
	bh=ocgVFU/TLLicKSAOp5e6Jw1mceRESxNPxDSwgKLBNEA=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=D/9GI0MNs8JWQAPf5Z1G4ogPOnDtQG33rHgiHHxOa92Emq5WYrPE2KautM9N9cX+a
	 WbAAwO3Wj6eGQhlBVLL1NOWBqJbIlFLWdPaqBN/vgFeUiLRGt27X/853VR56NhzJPM
	 bhGT0rC8lV23Q2AvhaQZDdo1vP+n3SNU5ZK6A1oMZc/AgCrrdI/vToA98gaZ6j16XQ
	 410z3sbYFy+9A6BbGCT/624NNsQU9AsUlIbj4QVgBsD7FAG1GJ9BPAnQ5tp06sJY54
	 ZxTk2LafU3ZP/TjsguM9rT43oB0GzuUw09qEcfHP28AKHoMaGH0kFo3KBKE2b2YYZk
	 0oMCxcfNdjKUg==
Date: Thu, 14 Mar 2024 14:03:30 +0000
From: Mark Brown <broonie@kernel.org>
To: "dalias@libc.org" <dalias@libc.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
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
Message-ID: <d334e9b9-659c-476f-b28d-42d3ac3dc591@sirena.org.uk>
References: <4c7bdf8fde9cc45174f10b9221fa58ffb450b755.camel@intel.com>
 <20240220185714.GO4163@brightrain.aerifal.cx>
 <9fc9c45ff6e14df80ad023e66ff7a978bd4ec91c.camel@intel.com>
 <20240220235415.GP4163@brightrain.aerifal.cx>
 <a57d6c7eada4b9a7c35addbc8556f5b53a0c3e6f.camel@intel.com>
 <20240221012736.GQ4163@brightrain.aerifal.cx>
 <d18f060d-37ac-48b1-9f67-a5c5db79b34e@sirena.org.uk>
 <20240221145800.GR4163@brightrain.aerifal.cx>
 <4a3809e8-61b2-4341-a868-292ba6e64e8a@sirena.org.uk>
 <20240302145702.GD1884416@port70.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pT4wHotY8cx/YSEA"
Content-Disposition: inline
In-Reply-To: <20240302145702.GD1884416@port70.net>
X-Cookie: WYSIWYG:


--pT4wHotY8cx/YSEA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 02, 2024 at 03:57:02PM +0100, Szabolcs Nagy wrote:
> * Mark Brown <broonie@kernel.org> [2024-02-21 17:36:12 +0000]:

> > > I said NOP but there's no reason it strictly needs to be a NOP. It
> > > could instead do something reasonable to convey the state of racing
> > > with shadow stack being disabled.

> > This feels like it's getting complicated and I fear it may be an uphill
> > struggle to get such code merged, at least for arm64.  My instinct is

> the aarch64 behaviour is already nop
> for gcs instructions when gcs is disabled.
> the isa was designed so async disable is
> possible.

Yeah, we'd need to handle GCSPR_EL0 somehow (currently it's inaccessible
when GCS is disabled) and userspace would need to take care it's not
doing something that could get stuck if for example a pop didn't
actually *do* anything.

--pT4wHotY8cx/YSEA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXzA7EACgkQJNaLcl1U
h9DtMwf+JnNjwm9DjgfaCHDp+cP7YhhFhwS5JiqPHng947Eq2YICGNh1KUf/HVq8
VjnGVfZYycl6Q5XcsKtiIge6fzgb0z/vDrjYKaCVLhu7sC03mGroef90nO0gvw2K
OvMgE+0BzMA7XrMHBWIQlu7p5Wm6rF6U/pVowEHQNunK3uQEyFUzjJUyTYewV/YV
vuEPBmX2VzqLAzACX142ClcYwHzODx0SQPdvnzrSpXnpw7440+JMYNK/x7QKwPV+
kWJg2tTuYGo37YLUmSXzk/EQLoQ2mMtcC423i+XHC3W1ATJC6lioyhuPFrec4rmw
f6AuUBTWAwPFswxpCAmg1ZfUVZGWZg==
=Oz06
-----END PGP SIGNATURE-----

--pT4wHotY8cx/YSEA--

