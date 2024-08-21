Return-Path: <linux-fsdevel+bounces-26476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F95F959EEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 15:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA1DCB26DAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 13:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3441ACE11;
	Wed, 21 Aug 2024 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YA0XHROX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDBB1ABEB2;
	Wed, 21 Aug 2024 13:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247688; cv=none; b=JHC8lToQmJoNNxmsbpu4hU1KG261M6NgCEhGn6Bokbtlryixt8XB6auILt0HChvougM8ShBlr4ugzg8BfuCECCN8fhWfG6nNdx4B3bN79V6sMOMSm6OyrjU28IET1Y3miLo4CGTcbp2BU1B0TB9s5I4ky7EDD8TFxEOb6kxVpKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247688; c=relaxed/simple;
	bh=eTD2Cb24CybXMxpAV7IV6bVikyFp8ac2v7wmurkqCBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFl+UUsuunfJPr62OJPu2RC7Gm/n25949XKx1ka25wCgaisLx5pwNpMOx7QU6s3Q0eJuSGEnDBVh3CHayAVPkjbXx+hsK5awyyz/eszkdHw0E3AXEk7bOIcCdld4Pn++/BbSse5Ezg9/Ia5FxOU1rWqy3Zg33bo0qb6KY0DNrUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YA0XHROX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E120EC32782;
	Wed, 21 Aug 2024 13:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724247688;
	bh=eTD2Cb24CybXMxpAV7IV6bVikyFp8ac2v7wmurkqCBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YA0XHROXOcQsdivO+elHDRjUSAQW6gMvqksgn9sJYx6HIQqgOSqBWvwYAKEoAudJ6
	 jpQFknVrYgPzVDOARVuSc6ndK09miMBS/01QDO3m/u8EM9AE7JMF5GhbKwPzkFwqnw
	 y4RvjlX8hCT1cWOdz2s5B5Hg+habrQnztB9Vn3DjTJKQfLxzs9VNsSM74lIHD/r5pY
	 m8AgYIe8mNkTYx8Rh64Z2A5FYg/IGH8Rmd/TeKBCchC+7HTnea+t4Vt/fEOjItOCaD
	 P8WifT5qdMaqyT/W50EYvaoxCO/vst1XsHX+DsxGESHgI2BbyBJq/FsYuxD4uzQtP/
	 bmJqgBU9LV9bQ==
Date: Wed, 21 Aug 2024 14:41:19 +0100
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
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 21/40] arm64/gcs: Implement shadow stack prctl()
 interface
Message-ID: <ba752f63-6a6b-4353-b2c2-0531d943cfd6@sirena.org.uk>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-21-699e2bd2190b@kernel.org>
 <ZsXjiTlfLE61-jJC@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Si11auRToJrS8sAl"
Content-Disposition: inline
In-Reply-To: <ZsXjiTlfLE61-jJC@arm.com>
X-Cookie: You are false data.


--Si11auRToJrS8sAl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 21, 2024 at 01:54:33PM +0100, Catalin Marinas wrote:

> Otherwise it looks fine.

> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

I've also added:

+
+       /* Ensure we remember GCSPR_EL0 if we're disabling. */
+       if (task_gcs_el0_enabled(current))
+               current->thread.gcspr_el0 = read_sysreg_s(SYS_GCSPR_EL0);

to handle the disable case.

--Si11auRToJrS8sAl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbF7n4ACgkQJNaLcl1U
h9Bergf+Lr+93qbWZ/k9ZOtInPd8jxasSRO+qC6wGQEBNiup/wbDIYe/v8WZVn5Z
w4bw2cz7o7ojaKCFrw6eAoto2EKZQXDc2r5UsFegjSdYsFudCg/L7odHSXP1ac2l
J8b/gmDEioJaw8kwgKsABb/7c2Knjpz7HxgzNTBhEV+DJ3ngHp81A7ehdvXyDLT5
C11CbLBC6dWDVxAlFPBR+WUwuIfQLjIfbbZfCl7L0sbtkPQZUTrRN7UhC4e+Ll7x
N01ynknfyTCaCqyfpyfuGxfi7+OKJeKZbGAcLiUvTRikhEIblv9PXLFW+FiUfNWw
SgJ1gyR8bJSUZHgN4w2DFsl0xhPcKg==
=tt95
-----END PGP SIGNATURE-----

--Si11auRToJrS8sAl--

