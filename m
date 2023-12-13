Return-Path: <linux-fsdevel+bounces-5856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F17581135B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AD3C1F217CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 13:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0A62DF7D;
	Wed, 13 Dec 2023 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLSW8zDA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8655928E22;
	Wed, 13 Dec 2023 13:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E3DC433C7;
	Wed, 13 Dec 2023 13:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702475379;
	bh=PNyFI2Mpc1WdMv+09T1SXKvFizOb61KSv71WhxqWz8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nLSW8zDANEVNHFOtFyXlOB9m7Pc9xIeqUMFJpaJNXgyoNhBzVXEUk9opATfsy2oal
	 wRbvuaumSqLUIa+NMSBfO/LMqX+4nSqtiio6HenhDMeGFWGnlOGELna0yPd2Irl9jO
	 5+MI5ynunAofTV7goPnqKF6+f5L1czOZ3ExA4GV3magiQkQIzKd9jyffRnP+4b5kBK
	 L2N4V+xJ0pzQoB6JF+Kvtcj0gx7onTfczeFs6gwWM5KCfQlYS1P8nC+RSzSIx8HneL
	 n7gwwtiX2MyG0bZYK6tkUUbfvV2ZJ+bZjgfm0jVXpQDKqS+WyK+6MqdutTajzX6ecw
	 /B7NAIrU16Nng==
Date: Wed, 13 Dec 2023 13:49:29 +0000
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"rppt@kernel.org" <rppt@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>, "maz@kernel.org" <maz@kernel.org>,
	"oleg@redhat.com" <oleg@redhat.com>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"will@kernel.org" <will@kernel.org>,
	"thiago.bauermann@linaro.org" <thiago.bauermann@linaro.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"ardb@kernel.org" <ardb@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v7 02/39] prctl: arch-agnostic prctl for shadow stack
Message-ID: <d723fdb4-9be9-4846-a49d-6bd00602afb3@sirena.org.uk>
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
 <20231122-arm64-gcs-v7-2-201c483bd775@kernel.org>
 <e1362732ba86990b7707d3f5b785358b77c5f896.camel@intel.com>
 <28c584ff-ef25-464f-852c-c5ddf66e5906@sirena.org.uk>
 <4acb51ebb3764f6a48a741d7b7d33f9a68c996fb.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+/nsIWnogzOjsOHn"
Content-Disposition: inline
In-Reply-To: <4acb51ebb3764f6a48a741d7b7d33f9a68c996fb.camel@intel.com>
X-Cookie: One size fits all.


--+/nsIWnogzOjsOHn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 12, 2023 at 09:22:59PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2023-12-12 at 20:26 +0000, Mark Brown wrote:

> > In general if things have a need to get at prctl()s via ptrace we
> > should
> > just fix that, at least for arm64 there's things like the vector
> > lengths
> > that are currently controlled via prctl(), but it shouldn't be a
> > blocker
> > for the locking specifically.

> ptrace arch_prctl() is a bit odd. Not all values of 'option' are
> supported because ptrace arch_prctl's have to operate cross task. Some
> have extra code to support doing this, and some only know how to
> operate on the current task, so return an error in the ptrace case.

It feels like x86 is doing some things via arch_prctl() rather than
implementing specific ptrace() interfaces for them, there's a lot of
stuff where ptrace isn't a great fit for due to it's concept that it's
going to work with an array of registers so that's understandable.

> I guess a benefit would be that there could be some arch agnostic
> ptrace userspace code. And I'd also guess (really a guess) that most
> ptracing code has some arch awareness already, but the other way is
> probably non-zero. Same for shadow stack enabling code. Then on the
> kernel side we'd have to add and support a ptrace prctl() solution.

> Is it worth the effort? I don't have a strong opinion.

I don't have a strong enough opinion on it to start working on it
immediately at any rate.

--+/nsIWnogzOjsOHn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV5tmgACgkQJNaLcl1U
h9CAhAf8CQEZOdWDIY7Wox4T7BzkaUfw/3Fa/4lTqu0TQ31mrybSqq9IHseTshgc
Mn6pJLAuHfPGj1iDEGxc3ukqVD/LgxFzMPoA18ZkdIrRLEAxoeKcq1vvJLfl6zws
GnWoqPcVdY1adnKNGo57jhoeE9pO71+2lfqK4yndK/BjR+iSo/PWM91Ub9SN2EbF
/czeqjpXV+eRF11RAEHmYsx/Uwz3ibAIE9vc0Yn8X9x+EEJhRZ1op3afAqK/Jn5I
X3sM+uRaDnWAb3KJ0C460J8jgjFuukww2GPdAFCp9HOQSXRYxKp4BfkxcAcAS9mL
xBHVT6Pa6B/vaeTYas4nGzUoUcaukA==
=4csw
-----END PGP SIGNATURE-----

--+/nsIWnogzOjsOHn--

