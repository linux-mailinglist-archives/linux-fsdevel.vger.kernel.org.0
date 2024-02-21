Return-Path: <linux-fsdevel+bounces-12196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B90B985CCE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 01:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23AF82836E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 00:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E6923AD;
	Wed, 21 Feb 2024 00:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EO1AKxM9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F0217D2;
	Wed, 21 Feb 2024 00:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476293; cv=none; b=rLYu+ukfo5jA5KyJgvV4+4ZVmxTMNgD3m9OF854cldBrkXlVbTbdVQW2HkyIsZrgIXbB9+a6IHy0N432IRMtCeKxQZHAbxvV4oTYX5YBZc3sZrIZwwjunJbAmAsgE5PYDnVSLYT+nKkS0MQS3kxdwuM76xGJ3WC3vNi6hylmk2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476293; c=relaxed/simple;
	bh=RgYHLlEs8Obx/1+1Ex9Dia48d76DvmFNDuLMAR9oXbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8QCQiikidltPOET8y3Lh/KyvGv+l38zGWeXrV3B/NlZJDSR8u7+bWKpfhqNatbkaU8CZvR6yIGOSMo4FWwNMLAXD6arwEKkCb5iS/GWkZFDIR3K7erWCvjHebPaWtKLP/Exz1N89ckeS3n3uXPbq+0ZHosQ14YlkAk3ff6ffLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EO1AKxM9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C393C433F1;
	Wed, 21 Feb 2024 00:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708476293;
	bh=RgYHLlEs8Obx/1+1Ex9Dia48d76DvmFNDuLMAR9oXbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EO1AKxM9atAW5ijESg1UGQbijOEntefJ4W7hvVziFA0UrM4OUrijGVaBzcLEs6wYr
	 OjSIBHChIOgwKca7pXNbM5Cobz19+3leTFG2K/9EVjkOotzvVw0v6ez05ByOvLbcwV
	 +CEf8bXXKN6XhhDI0KQZwE7hmlaMqLtNtNfWohmrOO5PLVL5FNBfFfrfun8qdbWle6
	 BBkj3Iud3EUQQytsOc+psDxTBNOG28HZowRKkkW/VLD4pWv0zXFVJLZNdlQZAg0FeB
	 on/Je8QMYpg2sD3Y5jNv2RyOVaFeGMIIzBve14j+nne6Gk0zkfJUvj0vvAw6pPQKrV
	 0fcsjUUDb1b7Q==
Date: Wed, 21 Feb 2024 00:44:43 +0000
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "dalias@libc.org" <dalias@libc.org>,
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
Message-ID: <cffc9c7e-ba1c-4894-a455-8b2d687182cd@sirena.org.uk>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
 <22a53b78-10d7-4a5a-a01e-b2f3a8c22e94@app.fastmail.com>
 <4c7bdf8fde9cc45174f10b9221fa58ffb450b755.camel@intel.com>
 <20240220185714.GO4163@brightrain.aerifal.cx>
 <9fc9c45ff6e14df80ad023e66ff7a978bd4ec91c.camel@intel.com>
 <20240220235415.GP4163@brightrain.aerifal.cx>
 <a57d6c7eada4b9a7c35addbc8556f5b53a0c3e6f.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zmCyS0Odp0mOsqor"
Content-Disposition: inline
In-Reply-To: <a57d6c7eada4b9a7c35addbc8556f5b53a0c3e6f.camel@intel.com>
X-Cookie: E = MC ** 2 +- 3db


--zmCyS0Odp0mOsqor
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 21, 2024 at 12:35:48AM +0000, Edgecombe, Rick P wrote:

> doing. But those threads might be using shadow stack instructions
> (INCSSP, RSTORSSP, etc). These are a collection of instructions that
> allow limited control of the SSP. When shadow stack gets disabled,
> these suddenly turn into #UD generating instructions. So any other
> threads executing those instructions when shadow stack got disabled
> would be in for a nasty surprise.

> Glibc's permissive mode (that disables shadow stack when dlopen()ing a
> DSO that doesn't support shadow stack) is quite limited because of
> this. There was a POC for working around it, but I'll stop there for
> now, to not spam you with the details. I'm not sure of arm and risc-v
> details on this specific corner, but for x86.

We have the same issue with disabling GCS causing GCS instructions to
become undefined.

--zmCyS0Odp0mOsqor
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXVR3oACgkQJNaLcl1U
h9BO9Qf/bgPI/9ROkHiV6cP5ag9FVPBuoU4y8o043FWrLxXipYjgLbjIps3r7NYd
VLNWiX+sScsGrwtujlkAC3JYU0QAro+3+MY0cp+MjZopgqrEpOHlREM+dZO4FSB+
BH4GTQgpADdgkbaukCb71Yd8D8HkPkpjvvsEGO6Kv2Bq4kMF6w2sd5O/llI+5BPN
0v1hps6/0VWFICJibmb4hRIRPMjb91mxGQRdpF8OTCgHa0w4UXaTHLttIE3iqCd4
nyeOZPkoIxUv3fYTVZjAqm6emWXXodOaOQrOtjTM1shBFck2DtY+hJJopNkuwE2j
qeuz0TLv83oNLhiCiSUgT5gKjQrvdA==
=VhGm
-----END PGP SIGNATURE-----

--zmCyS0Odp0mOsqor--

