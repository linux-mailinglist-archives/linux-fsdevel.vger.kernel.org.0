Return-Path: <linux-fsdevel+bounces-5742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB69D80F7E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 21:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D693B20ED0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 20:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A3463C19;
	Tue, 12 Dec 2023 20:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QK3xwh7/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCB863C0A;
	Tue, 12 Dec 2023 20:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C190EC433C7;
	Tue, 12 Dec 2023 20:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702412785;
	bh=ITS9iepxKmDBteakc9JcBmcwe4qkWaGAUfkgjLJxKz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QK3xwh7/RovgLawsgEE27tFvsEmWXv9zo7z8pvLyL07K+1LB60nrenIjCvuljOe6O
	 41c/d6u9DpvjRjFbkGD3P7jmXStQB53cqmZKdEcnFfWLpGUOCj6vXd8lnyrF285YBk
	 lVETctoAeX57YmnxNLRbavEXKvRsDBaDhwBiBYye6h5MN+tCnF67DNpZdysaYny5kM
	 t6INZGptEmFHhK3ZOTufikrTYp0MGbYMADqUFNtympWn8LwrjrDYUNKzFAW2JmdTUH
	 jSwlGihfJo7Y1K458B8sp76wN0x2qFUaS7cUbWtzteUthuknj5NGIFYj3sBiBRZ0Ms
	 PcHfkNUJGI2Qg==
Date: Tue, 12 Dec 2023 20:26:15 +0000
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "ardb@kernel.org" <ardb@kernel.org>,
	"maz@kernel.org" <maz@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"oleg@redhat.com" <oleg@redhat.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	"will@kernel.org" <will@kernel.org>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"brauner@kernel.org" <brauner@kernel.org>,
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
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v7 02/39] prctl: arch-agnostic prctl for shadow stack
Message-ID: <28c584ff-ef25-464f-852c-c5ddf66e5906@sirena.org.uk>
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
 <20231122-arm64-gcs-v7-2-201c483bd775@kernel.org>
 <e1362732ba86990b7707d3f5b785358b77c5f896.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LPMEijolhyLOy67U"
Content-Disposition: inline
In-Reply-To: <e1362732ba86990b7707d3f5b785358b77c5f896.camel@intel.com>
X-Cookie: If rash develops, discontinue use.


--LPMEijolhyLOy67U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 12, 2023 at 08:17:09PM +0000, Edgecombe, Rick P wrote:
> On Wed, 2023-11-22 at 09:42 +0000, Mark Brown wrote:

> > These features are expected to be inherited by new threads and
> > cleared
> > on exec(), unknown features should be rejected for enable but
> > accepted
> > for locking (in order to allow for future proofing).

> The reason why I stuck with arch_prctl when this came up is that CRIU
> (and probably other ptracers) needs a way to unlock via ptrace. ptrace
> arch_prctl() can do this. Did you have a plan for unlocking via ptrace?

The set of locked features is read/write via ptrace in my arm64 series,
that's architecture specific unfortunately but that seems to be the way
with ptrace.

In general if things have a need to get at prctl()s via ptrace we should
just fix that, at least for arm64 there's things like the vector lengths
that are currently controlled via prctl(), but it shouldn't be a blocker
for the locking specifically.

--LPMEijolhyLOy67U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV4weYACgkQJNaLcl1U
h9BRvwf/S9so8PzoqYCQJHpoRcvkwkq4+soyG3JSVYBAX+IsKPFGhH92O4Zp5DZJ
aASTrqwmW/PsW8TX8LOC1w1a2OadrpSIa4r8kxsWZWdzkg6OHWcZ/XlhGe4a1yMF
kUw36Z5PIqQRf02YHLYdelHq6/xswjma9YcOb5iVB0TZAL5mQw/2CHXr4ahGlAFr
Pj4wVYIkXRohUP6gR04RuD61bfD4WIFneYjIjzPYYYo9yxWSiiOrpO/MD1Jb7bQe
BaUHpGEsUZysAGRWxVvg+6v85VbHn/PYX8xT5xk9AmfYP8KM8HaClCKtzVBg//10
a9fZcXajnHu4O2S5h6Jsn5IYnbwpcg==
=ln+K
-----END PGP SIGNATURE-----

--LPMEijolhyLOy67U--

