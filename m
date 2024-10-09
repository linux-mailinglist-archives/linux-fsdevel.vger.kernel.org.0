Return-Path: <linux-fsdevel+bounces-31431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DA4996735
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 12:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99342284A21
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 10:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E651218FDAE;
	Wed,  9 Oct 2024 10:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CU/Syyph"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FB618C008;
	Wed,  9 Oct 2024 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728469535; cv=none; b=gH4odi6BhEEuFqNJZ4IW6xn3xzga9Hf5toy4KC0BBlYvRQoj/TvoxJSJYyY+QHrzvAniLekMfoSnm2A8Hav/snPI8HRUilzpMICKX2diJa6WDXutY0A3cgbrn2QV0jKCYX0oxRfavAxMtoPXoc1pY45ZanDLKwjyJD8oWp1rTa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728469535; c=relaxed/simple;
	bh=E98w9taq8sn2oCFo6PyCyTLfRrjriLoSIyE58uTuJiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMOuAz3yas3TvRM0NpkUWutt3q4tUgp6zK/V2/GZ5qsFygPBoRpxxClS1wHswLY5U2SN+4Wz55IVawV63sGYSjPGiXAnUY+F3h8wXqfRT4DeVnJQnV9xnb4uYuPKlURD12V6bQ64rGOEArsJM39fazTzQKQ8b2YJwVpz2MYFHIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CU/Syyph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F86C4CEC5;
	Wed,  9 Oct 2024 10:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728469534;
	bh=E98w9taq8sn2oCFo6PyCyTLfRrjriLoSIyE58uTuJiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CU/SyyphBFW7CION5UzN5ZaM2s9B2KaWUYjQIE24jNpQiaaNBcPZ/JBx43vZR9RIm
	 dKAuev96gZiqv3cQzmnlNpHZGs9yUnbcbXXoet9w9Wkw11upiEbCgMxXNsdL4ezFdY
	 +p5Tmy9zeIo8mmLnp1544+X/5q23ssqCYC9uPdMTUlybp9F8xH4e8D5xzIK9/AHeT4
	 VM8+SYp7oWGh1v48rq/tPnXUE9W2Y0QAcFjQlkkDsy7TNbdxWPifO6On6S6nNdb6x/
	 +Q0hlFwhivhYuLDaOGJFcmJB/380AQV7gmfUOo5/8+ukhcjeDEpd9KT8HTxCDfwmeH
	 x2vMMvQe1JdeA==
Date: Wed, 9 Oct 2024 11:25:31 +0100
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "robh@kernel.org" <robh@kernel.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"oleg@redhat.com" <oleg@redhat.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor@kernel.org" <conor@kernel.org>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
	"kees@kernel.org" <kees@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"jim.shu@sifive.com" <jim.shu@sifive.com>,
	"alistair.francis@wdc.com" <alistair.francis@wdc.com>,
	"cleger@rivosinc.com" <cleger@rivosinc.com>,
	"kito.cheng@sifive.com" <kito.cheng@sifive.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"samitolvanen@google.com" <samitolvanen@google.com>,
	"evan@rivosinc.com" <evan@rivosinc.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"atishp@rivosinc.com" <atishp@rivosinc.com>,
	"andybnac@gmail.com" <andybnac@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"charlie@rivosinc.com" <charlie@rivosinc.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"richard.henderson@linaro.org" <richard.henderson@linaro.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"alexghiti@rivosinc.com" <alexghiti@rivosinc.com>
Subject: Re: [PATCH v6 16/33] riscv/shstk: If needed allocate a new shadow
 stack on clone
Message-ID: <ZwZaG3NT72BwYxJO@finisterre.sirena.org.uk>
References: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
 <20241008-v5_user_cfi_series-v6-16-60d9fe073f37@rivosinc.com>
 <aa75cbd142c51b996423f18769d8b8d7ecc39081.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pV5KnxhmLMXWkQIN"
Content-Disposition: inline
In-Reply-To: <aa75cbd142c51b996423f18769d8b8d7ecc39081.camel@intel.com>
X-Cookie: Editing is a rewording activity.


--pV5KnxhmLMXWkQIN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 08, 2024 at 10:55:29PM +0000, Edgecombe, Rick P wrote:

> A lot of this patch and the previous one is similar to x86's and arm's. It great
> that we can have consistency around this behavior.

> There might be enough consistency to refactor some of the arch code into a
> kernel/shstk.c.

> Should we try?

I think so - I think we discussed it before.  I was thinking of looking
at it once the clone3() stuff settles down, I don't want to trigger any
unneeded refectorings there and cause further delays.

--pV5KnxhmLMXWkQIN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcGWhUACgkQJNaLcl1U
h9CV8Qf+Ph9QxNDXCUSDZQA7lOMJTS+c3a+WdGbveXt6JMb2hP4Udd4ELfDvQVsP
2vwWUtByxmDax2qjADTJn56IYnJp+1yB9YBfBuwEGHGP67KgKDpcUHieu4xPemue
2pid1MtBjTUsviljsva6rAoewc+MO3Z5AAICoplF1wXYwW8JWpgKpALzehjsUnOG
xGgEXqiS5ycjWc0ikmHyeOQRK13/4EVaiJr+pklcIbhhggLbnNIB7jvKTKnBr/ds
fkXQZeW9aA6kQUAetPKjlkvwxOhyxix4xDR3tCncJjA/emX+9fze/UwLrBDs75JO
eMHp4p8ZUDqVuxPu6ZNF8wGk8VJChA==
=EDL3
-----END PGP SIGNATURE-----

--pV5KnxhmLMXWkQIN--

