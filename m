Return-Path: <linux-fsdevel+bounces-27938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E86964D4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 19:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D821C22D8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E971B790B;
	Thu, 29 Aug 2024 17:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2Pb7Pr9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAA41B373E;
	Thu, 29 Aug 2024 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724954116; cv=none; b=cIjOFwRL9p5jb7nZlJ8NmoEsys3g6QlO4K2rzP4z6BNbcIURAV1BZBA1zezrb8mXCCmiIq9eJm6oSkYchqwKi8RESAzaAG1Fjy/pKYXkFpz2RLIZngvO7xAKSTeJe8kDHZAlmKNXDfO3VTxDZ7y5F+9dtiTeyiN6hayfZU6bpAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724954116; c=relaxed/simple;
	bh=z1cQe5fZ3eIjl/LjO580rRqXvmPg9r6zi9VQ/SQ8gPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQSWG1xWqyFrw+KmjQA0BmVrLXO36Zo+/AEJTZrjL93Q7eSJpmV+BEsKSp2lRex7EdZ1nj8wyKO5djCQlUFWz/HUaq+FnR2aHk5Tmzepq81//zUIEI2UctKLk8bQiVONpyxM/XxMIJuUEGHKzf5DA8rgYfl6ODngbCjzdnmvFXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2Pb7Pr9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6830DC4CEC2;
	Thu, 29 Aug 2024 17:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724954115;
	bh=z1cQe5fZ3eIjl/LjO580rRqXvmPg9r6zi9VQ/SQ8gPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p2Pb7Pr9Idi3U+1dSAJy5ZGpjTgQK2XuuocvVWY2B529zQ97Vq4V8vzQJwQXOMTcW
	 gQBJjVRys2e1pQmbBMo9uHpVYFfhiRg2g82986bh9kxyHQZwjtz7pAhW9dY7Z1mDZf
	 E4G2QpyrU10N9vbMIvp6oxvvHr9+Z7L6OFXjpWynLK0rw0YVWMyogEt3CQr3A7DYm4
	 dXg5jdhDQWvAQZaxgmmLVH4iJyy2tlrN5uUjSnLqah7tWxtXXcT9tZ3HE3TqXD/BOj
	 bhRP49xJaAqI6sdcPP3UebPpiOfr7sgNAUUF1R4b0E+6TtsAmsJKBusYZ2JTdZ1aLh
	 9c8JFmE/294uw==
Date: Thu, 29 Aug 2024 18:55:07 +0100
From: Mark Brown <broonie@kernel.org>
To: Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, nd@arm.com,
	akpm@linux-foundation.org, aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com, bp@alien8.de,
	catalin.marinas@arm.com, christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, skhan@linuxfoundation.org,
	szabolcs.nagy@arm.com, tglx@linutronix.de, will@kernel.org,
	x86@kernel.org, kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 16/30] arm64: handle PKEY/POE faults
Message-ID: <40600b75-68eb-421a-a122-256bd20afb89@sirena.org.uk>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
 <20240822151113.1479789-17-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YUq+oyo8aHhnCJ3l"
Content-Disposition: inline
In-Reply-To: <20240822151113.1479789-17-joey.gouly@arm.com>
X-Cookie: Go 'way!  You're bothering me!


--YUq+oyo8aHhnCJ3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 22, 2024 at 04:10:59PM +0100, Joey Gouly wrote:

> +static bool fault_from_pkey(unsigned long esr, struct vm_area_struct *vma,
> +			unsigned int mm_flags)
> +{
> +	unsigned long iss2 = ESR_ELx_ISS2(esr);
> +
> +	if (!system_supports_poe())
> +		return false;
> +
> +	if (iss2 & ESR_ELx_Overlay)
> +		return true;

Does this need an is_data_abort() && is_instruction_abort() check?
Overlay doesn't appear to be defined for all exception types and it
wasn't clear enough to me that the callers have done this check.

--YUq+oyo8aHhnCJ3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbQtfoACgkQJNaLcl1U
h9DlUgf/dqGRzK2dLE7+N4y+4LBWAGW7tClTB7FD0kyv5R02H8XfYHXRznQNP3xw
e9h9X7WvrF+tHVvKaRLrgCF1qKwIwIpd/i5py+jWxSVZLIg1Al5vjZp6yGIRTiw5
Gn7Ts60w/kNQNKizo8sr12ekIA8bn+EYGm7YznCxbsQ0Fo6Wx5ZGpcAsIObQVg/J
bGFjL4IKMlaC8ZgP80PJW+sa3iAhlAK0RuDj1/BiVDfsLQHlMmD6M3Mpn4MTDB4A
l60V2J4QW1eLkxWHCaeLE+1vBVHMCYgY4orFoA9WAbVFM0UDnI7EKgS22lGK/kxn
L2I9TP72B0wTkDL1Ft+34Ka8AV+2Sw==
=72Y0
-----END PGP SIGNATURE-----

--YUq+oyo8aHhnCJ3l--

