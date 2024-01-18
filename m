Return-Path: <linux-fsdevel+bounces-8275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 787BD832013
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 20:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01FF3B2617B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 19:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9622E642;
	Thu, 18 Jan 2024 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOcnPxyT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89772E400;
	Thu, 18 Jan 2024 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705607922; cv=none; b=am45jjnvgUxY0IbhpoMTTS2lHa8F9DmTF8fL6IOLS5KIkuyMFqEyf/RqJ8YvfGzQ3sD+X7IcB8BSs4usaR4uSpUK771GHrUX/tZfBMv/abBRKGqTAVf0j51RcFu7LUv0yleDWHWD+2MxzC2CXImUA3yPlhc3qQArLKHGjFwyvOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705607922; c=relaxed/simple;
	bh=dg8AYukbRIwcDM7XMhA2eAX0Vj/41D/3o41gR6bxNzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2EqRnVsmsXg0for47OZ0wRfNZtlvsuBIIAGRYJCMCmGzn+2RbynZ+BBhp5U11b/Q6eZwORLctC568VTYu4LCpjZPochdJbTh0Jii4b/qzVZ1OcMVCSx0FBqiXQ/nL6Q/G3SNu4GEJl0FKHt4Ecgho3DkCkJ/K5NTjQSq+64WYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOcnPxyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BF7C433C7;
	Thu, 18 Jan 2024 19:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705607921;
	bh=dg8AYukbRIwcDM7XMhA2eAX0Vj/41D/3o41gR6bxNzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kOcnPxyTNJLXDXVOtyj99VAsOk5s0Rmh83NR1a9NOgU/OF5FOi72j3zLwSt210Nus
	 Dj4P0dm5hTDZcazYWhWxYczQmqtNTEG43VEDdUXGPSaqLmzmR97NTuw8YTekBMF+OI
	 ldipeDxBaXKpzY0ZaRVwUQbY/pusnuaIPwFnT8vd0t+Q4pG8AH3CLYak4Z4vUn0Ub/
	 MDDl+enUsNxWgtsRxya+NNhRr7KdNGzGlzh7twIgvuG8k/M7SgqKtOQoy/Bk96yx28
	 VpimFp2KEjfb1RkRd3mdE37KHbO4bTVMjTmEalTGSdvHcEBV3FsSLG7BuKppdoTIIP
	 riNFJwlivNLUg==
Date: Thu, 18 Jan 2024 19:58:32 +0000
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
	Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v7 34/39] kselftest/arm64: Add a GCS test program built
 with the system libc
Message-ID: <d5c8b071-dd68-4e5c-b0ba-10c5fdc0c730@sirena.org.uk>
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
 <20231122-arm64-gcs-v7-34-201c483bd775@kernel.org>
 <875y1089i4.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J0lYyRO8meje2xTl"
Content-Disposition: inline
In-Reply-To: <875y1089i4.fsf@linaro.org>
X-Cookie: FEELINGS are cascading over me!!!


--J0lYyRO8meje2xTl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 14, 2023 at 11:50:11PM -0300, Thiago Jung Bauermann wrote:

> If I swap process_vm_readv() and process_vm_writev(), then the read
> succeeds but the write fails:

The writes are intended to fail, for security reasons we explicitly
block this API for GCS pages.  Given that process_vm_writev() is only
available with similar permissions to ptrace() which does not have these
restrictions this on first consideration feels like something that we
should allow but it feels out of scope for this already very large
series to do so so I'll fix the test.

--J0lYyRO8meje2xTl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWpgucACgkQJNaLcl1U
h9CYvgf5AXvQCEOJft2rRvx77RKKR6OcqHq1nMW9gq0PedqzL0bOOJ8VUxLbblGi
ODi9eMUiTzx/e+/d8/7JXSG4dg6mZmDLRZlgKYdl0wYK+D4AL1jb8Xm3KRcZPTYj
9wXpkwLj3R/4slPoom0idK/+g7BmgwhhGKsmDPh279p1vXn4F3GdbFvta3KvvKB4
f8jmwIVrllAaAXZsmg2eIvTd/lvna7Oa6C3UrHqN8QYaiokebhB+fvyY5LIRx6oW
a0godJWG2XN83VL3A5Mgnk2v27ewHVAAQ5MeMKBJSYwLQYNyWlh1Y6J0s7jAYmhU
pQqh3jZ7jg6I1WyqsYO12yX1KYXFTw==
=FSEz
-----END PGP SIGNATURE-----

--J0lYyRO8meje2xTl--

