Return-Path: <linux-fsdevel+bounces-26527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC7595A4CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 20:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF80E1C229B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 18:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7F71B530B;
	Wed, 21 Aug 2024 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1Z5wNq7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280211D131A;
	Wed, 21 Aug 2024 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724265683; cv=none; b=dhic1eK8jYKaKm/ByW0RqFFgHU8ZiwR/T3+lA8ZB0oMUoqdyaBeiPqUIcLZ7aTD8SLW/aIaFQpQo4RssdYi2nLEU4mxi7+U697VwDyYziRy1V2KavM48RgBeENSM5OuGhqdz0j+ZgSPNzbO5VRn2u6X97tWlke02by64Eo8u3wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724265683; c=relaxed/simple;
	bh=E8dXxpdarfv5CApG/ySDW3eYs88clE31dyTXCgdIj+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOp74YnADgHcGCnsE8tNqSE1zjuxzlA2iMeHTx+T2n+L4PKuqu2+i05l6aWanXmpJAhNlxjc7eq0MJ/KMOA0xHdN11aqyGeuo5ZpkjR9r4TXRpgeMF4j2YOX3mWQhRTNCPGCgcjXfwwB6/xUyx3dT33xXNYPDYHiy95zvWNR4/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1Z5wNq7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160FEC32781;
	Wed, 21 Aug 2024 18:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724265682;
	bh=E8dXxpdarfv5CApG/ySDW3eYs88clE31dyTXCgdIj+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P1Z5wNq7V+GasD5vLMXFUN5I8quGoeaPeU/IOn49bO8otYh4m4+pEPuD02+LjkIpu
	 1InGS8UBGdn07hLYwr9lczN0PpJKUZda3+PUnVYGPIHPz37YiW/rlBT39Wu3Z6waXl
	 yFHS8eRfeRov6xX2PfirQ7yEoiX+M7qPnRSKDkpLB7DgHumi3WXwPKLN/zebkWiSh5
	 BVgWHhEMq7jh8WLHQBofBwINPODDw2R/uDRfRihMjYS5SRen4JvJhmC1N9DkEtYC28
	 UbCdbUMMqjuH/078spkgiUnjLrN7q0REvfVwOvY+hgphHs8YYEHun383qhkKCWENa0
	 +x6JMwgsjOsOA==
Date: Wed, 21 Aug 2024 19:41:12 +0100
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
Subject: Re: [PATCH v10 25/40] arm64/ptrace: Expose GCS via ptrace and core
 files
Message-ID: <79d5dad9-3194-45dd-8c2e-663cea2e5f4f@sirena.org.uk>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-25-699e2bd2190b@kernel.org>
 <ZsYqfJ3V_-ljqlwq@arm.com>
 <58ee01de-88a6-4d0c-845a-3d5bebc0c55c@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BMJnA8eFDlPmLXSS"
Content-Disposition: inline
In-Reply-To: <58ee01de-88a6-4d0c-845a-3d5bebc0c55c@sirena.org.uk>
X-Cookie: Are you a turtle?


--BMJnA8eFDlPmLXSS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 21, 2024 at 07:28:08PM +0100, Mark Brown wrote:

> part of an otherwise invalid write.  The validation is checking for
> unknown features and enables.  With clone3() we could relax the enable
> check, but I've just pulled that out of the series for the time being.

Actually thinking about it some more I'll just remove the check for
enable, the support for threads with GCS enabled and no kernel allocated
GCS is already there and I didn't pull that bit out.

--BMJnA8eFDlPmLXSS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbGNMgACgkQJNaLcl1U
h9Cs9gf/faFn4ZIWAD0ObkgYSu2MFgvuc0/TxhjIvIwyaRcVoqWhCLuxFx6tDyf7
R003D+EGEn6M1h6zfEPXV/PKOBUV1KMnZcpTgESMJyUVa4HSREWmw7nMQZmiifDl
xICPAzUBzqlPsIcc5S1eQlR7ecwt80Hs0WM5cWjh4YmQikjGU4LZse2eCrrVQ+8E
hrLM84hndTamAlUtO9oREDCdZ8BZc+wxpQSRpRuufSMIdD/Ujv26ikmoRDOvGSbW
h8v2pgOb1hekEEesgevZoE1YbJ76Z5GfQO4HdJKSh/iB4vz5mbmj324y6K0oL4Ej
dsCLfFizij3MQaU6gmwwgHzolx6UWg==
=MjH1
-----END PGP SIGNATURE-----

--BMJnA8eFDlPmLXSS--

