Return-Path: <linux-fsdevel+bounces-23943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AA193507F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 18:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB28284003
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 16:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F71144D34;
	Thu, 18 Jul 2024 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLlYu6gW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B2B7D3EF;
	Thu, 18 Jul 2024 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721319409; cv=none; b=JAqNzo7/1U8sdMF3sGE7XX1bS2aum1ul4YXPemq6gTjp/G3Gwg1aeMHEar3f09EOcRGPBtlAhVtw3RFqSAGfaMKjiRRrWRO2mcjM62R33QsAAA+5Pdge4D5WQm1M36DxouYPL3o2q5F4HBDP7ojsn7Hcn5GrZMoYnKFm7RJzWwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721319409; c=relaxed/simple;
	bh=gKUCbuXhzgw1JXGUEH5JtAqhnI1xtcOjVYOUIZ4L7WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEstMmC6/U3LwNcsSp2//MhG81Uum2CM2eY5ZZHjkC9YtMT7qZUDxaBdN5Yh/RXwbbp8kaf5AWqOjyOXGQORy756UPHJ3l/kmbd8GKsM8rUQ4EY2a5sytcSIbUuCJ0QCS5QQOr6Pk4yylUQLUid9L4h2P6cvBhddMkIdeu3eGUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLlYu6gW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46843C116B1;
	Thu, 18 Jul 2024 16:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721319408;
	bh=gKUCbuXhzgw1JXGUEH5JtAqhnI1xtcOjVYOUIZ4L7WU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rLlYu6gWOogx7mLKzNfrMoEn5IliXebJuEhDM/YqrOAs0xiiQi6bBzH51WVhr0QJY
	 Zmz8pj28Y+tUuZFCcQ+CeaKHFWqQNypCAdrLOte91CySDjbvX/rzhyyR3se0bq2LpP
	 g6RJw1flOPNxSa3KhVH6/l82V95VuqoX1PB6yBPMkusoTfwHjtJOhkTDhpZqR17bH7
	 f6Um9jZ/myfqy9kdeb1SYQci7ZstuknJvs14kGvO4JNq1TXB+SqRUsXdc42IdtRGlO
	 15WGVzA8vf4KSb71viIsgiMbNYYY2atS0TtJSRYErrbyAqLJXfywco361yELivTB6A
	 OHz65cHYteddQ==
Date: Thu, 18 Jul 2024 17:16:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Ross Burton <ross.burton@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v9 35/39] kselftest/arm64: Add a GCS test program built
 with the system libc
Message-ID: <a1ee93ab-2168-4228-a4e8-eab02c046bd3@sirena.org.uk>
References: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
 <20240625-arm64-gcs-v9-35-0f634469b8f0@kernel.org>
 <87plray8we.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4iOkZ0TI53vzajDb"
Content-Disposition: inline
In-Reply-To: <87plray8we.fsf@linaro.org>
X-Cookie: For off-road use only.


--4iOkZ0TI53vzajDb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 18, 2024 at 01:14:41PM -0300, Thiago Jung Bauermann wrote:

> In my FVP VM, this test gets a GCS SIGSEGV before running the first test:

Do you have THP enabled?  That still doesn't work (I'm expecting it to
be fixed with -rc1).

--4iOkZ0TI53vzajDb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaZP+YACgkQJNaLcl1U
h9BR6Qf9GiojqUKYh+SyKawuW3opLEJKR/7zCB196w+/g9gnE5g1RbTQ8JPI1tlR
c3GGKFe6YZzDvo2XPzwWRcb5+xqPig7ZFkM5EdMMUcaFklfX2xTqhSAOMjkvaMFx
bj1ELRnstQmWoibVbFHPk3iI3g4INItNqTua4YSyW1efyShyruDItI6rMORwMoAX
JYEYM5K6aNhh56OcSwX9ZKjF8KIA3UPTWCi/Dt9KcX45bEmxR/tc8qi/YIvhIPG1
swvurAIyaqJ8PLR6B7dO9nYj2WReVR1yjql8sZHw1i0lHeSB4bd7hXP0R+XgYU2T
MjO/IPnJGt/92ViI0r5HvZeqZf7KKg==
=OYr2
-----END PGP SIGNATURE-----

--4iOkZ0TI53vzajDb--

