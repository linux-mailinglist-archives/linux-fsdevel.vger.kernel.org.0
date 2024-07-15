Return-Path: <linux-fsdevel+bounces-23716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059E0931BB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 22:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A0A1C21A9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 20:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F808528F;
	Mon, 15 Jul 2024 20:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuGYsfLc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511A42AF1E;
	Mon, 15 Jul 2024 20:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721074665; cv=none; b=UAv0XorOHeu0/uVHZmC0iYHeVgv4afkbHi6QNmpLSAMafhzY3BuoKAL79ElJRZOVTcOxndnp3mkf3jb524BpcwA8O4uGq8b3/u+gD7Oz1I9GWb/W+t6da7INbO8da8fkeo7rtGfja9aYspC3h4CzP0zkMqxGyWBF7f81x2IBUEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721074665; c=relaxed/simple;
	bh=nV0pV7geh3E0Gng/hveSYWznkIUJ2IUGHcX8dzFXWOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2nhhdy+XIhsICo6mxHxDLpzefesJKDcVWc59dFfR7w9KcGxdaeJ0rKOZZMeAAXkLnneDYqGbaSBO+oZ1Q1GadLxIeZ1HNvkTT68pSNO3zg2UOaq3k6Yxf9CA82FmKhEjqX3DR5CxGcEiJ1PSLLU1G7AMpg2+wSD5QVF7SZwa98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuGYsfLc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10193C32782;
	Mon, 15 Jul 2024 20:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721074664;
	bh=nV0pV7geh3E0Gng/hveSYWznkIUJ2IUGHcX8dzFXWOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TuGYsfLcx4GspKL86Eh/mosMZut+5IR33yPnktkxhHSsLtJLwoG7R+PTdsfJaGNGv
	 EEsBgrMTB/d9+P3pG00k5CpvXUlXXAUp06SkyRUyXzXG5Gg1QfUVaAwFJnEDA81Eve
	 XCiLvlIQNT3XrJ79nV1CWO/lkeMB4onsXrzbIfzKukWEVI5fcH5gd1lG8G0Sa67wNg
	 SgOOQzlTIfTSa1WWFAGegf9V1reI0i3t/93fD1W8pVcDHtiv3ZHiQoI5/uSe4cmJY9
	 NbZlWOo3IIm1W58H9bQP5k72fSzsTKG5TnnyM/uiLPOVNFWGsyHwa2tFqGd8P45cDq
	 ZBFIDVDbN9n2w==
Date: Mon, 15 Jul 2024 21:16:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@kernel.org, aneesh.kumar@linux.ibm.com, bp@alien8.de,
	catalin.marinas@arm.com, christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, szabolcs.nagy@arm.com,
	tglx@linutronix.de, will@kernel.org, x86@kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 10/29] arm64: enable the Permission Overlay Extension
 for EL0
Message-ID: <a867d629-270f-4f34-90a6-4bc346e5c018@sirena.org.uk>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-11-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q58zRk7wvnj6jGJn"
Content-Disposition: inline
In-Reply-To: <20240503130147.1154804-11-joey.gouly@arm.com>
X-Cookie: You'll be sorry...


--Q58zRk7wvnj6jGJn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 03, 2024 at 02:01:28PM +0100, Joey Gouly wrote:

> This takes the last bit of HWCAP2, is this fine? What can we do about
> more features in the future?

HWCAP3 has already been allocated so we could just start using that.

--Q58zRk7wvnj6jGJn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaVg6sACgkQJNaLcl1U
h9AW9Af+JYOKBw8IlU3TJ8USeMzNKhlTsIR9EXmjyh8mC+eUbN+xIrb5A7B4dG6m
dk6iLPP5/E8GCiVOKSmrN2D8WF4fcCTkl1cwLojd2EkthrMhOX1qgJTkzNosR76D
aVo2JL7YvyiEpKMaZv74UnaxL9zipPWHMwX8tyakt+3F75Jho3fjo/pkNleV8jxl
bALzynA7fKtt7p2R57PbLXPhTLG4IxG/8gH2ODuDwMj6o46ng4BmOfZXlgaqOgsT
RxnODCG0OpXODiw+QlMS/JBrbg21d3Rc3CHVUsz4INNeI0WRL1yv35HFKWdfhuIQ
v1DA+hOMClSlNNEQ+qWr3JYq7W6eqw==
=sIpQ
-----END PGP SIGNATURE-----

--Q58zRk7wvnj6jGJn--

