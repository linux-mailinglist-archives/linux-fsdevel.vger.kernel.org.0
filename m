Return-Path: <linux-fsdevel+bounces-24050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8C1938BA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 10:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D474FB214B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 08:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301BC1684B0;
	Mon, 22 Jul 2024 08:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHxO8XN+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76416182BD;
	Mon, 22 Jul 2024 08:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721638660; cv=none; b=G4ABlBFKlvLeybnPxS+7WQ3aliTqMj+7FYJkOJEzKxMTCnz7glKXbelCkKguztqQyeB6g5uGnmC9x2/Ww0B5azgCfisENOYm0/9NRBB/u/+oKa6p4yhBn1+XbVNI2+DKfFUPZ0BaF8B1zWjw2Fs18Hjf/WOfeD0AySPoMm42Cwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721638660; c=relaxed/simple;
	bh=5pdsAMvxf33KPLFdJQj2/+6yZV6fAT2tSKEZ5x9YW2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlzOlaMFCVBOV9621swfsBUvDQbpSIK5OMW8ttv9ehO9eNuc+HksMvTTK5jROIXxeEkZx7OMR/iBo8BPFCuq2yrVfDyt5pYkfAEU7xl4Yyv8OAQk5te18bDDvd/OPR1tVFSO1E1+U8/7aiuNHgDU1sSnirlfsCeApflme7kFK1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHxO8XN+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CFDC116B1;
	Mon, 22 Jul 2024 08:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721638660;
	bh=5pdsAMvxf33KPLFdJQj2/+6yZV6fAT2tSKEZ5x9YW2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZHxO8XN+foJShMt2aKArXK1IdXRzJuQU27YCTJfFZwoQ7H7WCy+u8B9jpMyN4Efv1
	 0yLHsB6MMrCBmpo0ZPenUlRjMWqnJh1Y9wc2R2tD0Rva4o+1LslX8kXPiTv+MVae33
	 /8JuTUH2tJO4E1OweFMqLlLI3WblfWfg3JI2icKOLinTi0v7T9QoBdk0QchjJLeqwE
	 dxBRpwjbGqPp+bb+NIRUsCl5S6uDGSt5Km5nUfoWpkzN8mXi2qjxgrLJU7L6CfTXfb
	 JiyDmcT8gUs1CNjlwNzwaCMtGg8tmeq28UIbtrSDs0nIjnNel0R194B4XgVpFJKSUp
	 SfzKjLHHdmA3g==
Date: Mon, 22 Jul 2024 09:57:30 +0100
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
Message-ID: <875ccce5-69ab-4a43-b49c-977036df4173@sirena.org.uk>
References: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
 <20240625-arm64-gcs-v9-35-0f634469b8f0@kernel.org>
 <87plray8we.fsf@linaro.org>
 <a1ee93ab-2168-4228-a4e8-eab02c046bd3@sirena.org.uk>
 <87ed7qxrlb.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mfQxvhGMKqgo3PYf"
Content-Disposition: inline
In-Reply-To: <87ed7qxrlb.fsf@linaro.org>
X-Cookie: Everything you know is wrong!


--mfQxvhGMKqgo3PYf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 18, 2024 at 07:28:32PM -0300, Thiago Jung Bauermann wrote:
> Mark Brown <broonie@kernel.org> writes:

> > Do you have THP enabled?  That still doesn't work (I'm expecting it to
> > be fixed with -rc1).

> I did have it enabled. After turning it off in the kernel config, the
> test does pass. But I see 30 lines of "INVALID GCS" in dmesg while
> running it. Is it expected?

Oops, that's a debug print left in by mistake but does indicate
everything's running well.

--mfQxvhGMKqgo3PYf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaeHvoACgkQJNaLcl1U
h9AI+wf/RBDATTODyaTvKOScU1coj20M1RS7G89cHABna4bQRQtFNmjI7sd2fLpl
JqGje1yPm1EVEweCnIKuP7DURmfjm7EYn+WqebEBO80n/p+2Md7qAy61du1uJEuV
MlqV44RmEi/pKozAa0EFjN5rS14u0w86Up9k0SJEBX+0SjpZrUWhpkUQyj+B90B7
WHY8XiMIv3UDvcI9oPowQAJuvIfM7hl8JD7njibxQX+fqex+DY0C1p0MOG8BQ0TM
9Y+eI9rkpz8eDXTN1Tcm5HnTlBn5UJhFsuWnyZSkJ2jVXSvvYSieik4QRH9U4rqj
tAPxlFXuzQeJGORQnqNCvINjO9Cc5w==
=RXC2
-----END PGP SIGNATURE-----

--mfQxvhGMKqgo3PYf--

