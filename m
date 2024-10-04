Return-Path: <linux-fsdevel+bounces-30964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CB1990281
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 13:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D438AB2296E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 11:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D72D15B140;
	Fri,  4 Oct 2024 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6TkvVj7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0541D5AD8;
	Fri,  4 Oct 2024 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728042619; cv=none; b=S5AarNBgJUmP63fqpOcfwj+AhPtpLj7HHk9TJO5ndyPQsL1p2qNMNbzXxKQwHy+TeCdaLbGJn3vUHFejs9ZjniMkNdnvyllUf+MGEnmYFjFmfT8GU0p8eJsVkupfHzXurmdgUyimdK22niYEKnoDXEXuFNeEp1sdea9XMmxFftI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728042619; c=relaxed/simple;
	bh=+BeodDaFGWOje549S0KudeQ/WQofpaiwc9P5QexdJr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O13Ic9kOUeIdwP7Hpvq0DJ/oG65uHXhkWSvAQ+eLFyFjXK3z0rDkr7gf8nU0vLbZIlyZ+jXQ3u3kYDg+KESLiRuvANuzquIHkHMZVSQeVR+is8lE7NptAYP0a0tzpXY+9whttbIKNR8WobKYyOZINyd5gWhvetsYrf3XIFe5FH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6TkvVj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83680C4CEC6;
	Fri,  4 Oct 2024 11:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728042618;
	bh=+BeodDaFGWOje549S0KudeQ/WQofpaiwc9P5QexdJr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k6TkvVj7GMjGbmKB1HJLF/vkMjkfzBK2z4CFAq24H++hZNqit5hWnu+qiurDMqtJ9
	 DW7IidlCRTM3QaMhphpojCHjZ9fTG9JpZUW3qZPbU5yq9fQl1YgOGiV+fPAEKsj4YY
	 lHObhuf9Yt8SIkxWEEYLeXqbYgcv7Or4B9En46bl/EKtkJpsJKrdkSrdZTlfIUvbGS
	 HHtgo5u5ZT9DkHGaMrAGkcfT9+xGVcKVHfYCKheZIw9xBKQUz0jS4MB3qmjis5vPXQ
	 hgzdrNECfwJPJwiQuKv4im1uOOuAQYJSeqvyP18pTTVOMYiRTqVEpfylWiGr7FpOK+
	 w/AUkl/4UDraA==
Date: Fri, 4 Oct 2024 12:50:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
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
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Ross Burton <ross.burton@arm.com>,
	David Spickett <david.spickett@arm.com>,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v13 22/40] arm64/gcs: Ensure that new threads have a GCS
Message-ID: <0e4d84e6-81ae-41ea-a17e-484df90f4444@sirena.org.uk>
References: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
 <20241001-arm64-gcs-v13-22-222b78d87eee@kernel.org>
 <Zv_PFVffwIkKevzE@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LKVsNEPzgkEHa/nF"
Content-Disposition: inline
In-Reply-To: <Zv_PFVffwIkKevzE@arm.com>
X-Cookie: A bachelor is an unaltared male.


--LKVsNEPzgkEHa/nF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 04, 2024 at 02:18:45PM +0300, Catalin Marinas wrote:

> I think Szabolcs mentioned a GCS leak with v12:

> https://lore.kernel.org/r/ZtrihWQFyb2/XrQV@arm.com

> (and in some private messages IIRC)

> Has this been identified? The changelog only mentions a leak in v8.

Yes, it's this in the changelog:

  - Implement mm_release() and free transparently allocated GCSs there.

--LKVsNEPzgkEHa/nF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmb/1m8ACgkQJNaLcl1U
h9CX5Qf/YXV4PCUMoouOlHODLlWL0QpqxDnrB4g2yYs90X9BTpJIF7Ax3i9mVe6N
UETYxylUWRj9l39/OFtO1HFZkJcLdlWYkYREST9X6NX4htudvuu/5oAN06NXH9jd
znOG1a/FdzPxRygtN3Lt6P6eodHJct9XRgduDANTu4oCEl7PAuW6ob88izh/c+FO
MaiKZXsdWB+nc0KOSVk3HA0ogs8szrCQcWNti/LArlYFZWwurCtfYxgCUQFEzSSh
SDemv5W+sFX+l7V/S4YCawDcIcLv0B+jV9lx0ECWzyhLeOrIxBDTYSKr3ukgLR7n
+XdVZaKYGBSKeIaoCVbZcVM3Ul+CTQ==
=zRYX
-----END PGP SIGNATURE-----

--LKVsNEPzgkEHa/nF--

