Return-Path: <linux-fsdevel+bounces-18760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E3B8BC178
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 16:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA194281717
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 14:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6169628DD1;
	Sun,  5 May 2024 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPi6uav5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD231747F;
	Sun,  5 May 2024 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714920110; cv=none; b=uuIvvUaiXq2hEGC0D0jycru8OTHuQoDo8gbek3rjvkvWDVI8todlEi59vnLbzEXZ+/oq4NMyrmakjlPqhEUYjqds1gQE0yXzl6ASi/Zfm6/MjBoKLzQ4A79GErPYx/G2wpjG7zDmLmT+s2Dg7N+HtxMAwPZGXXFc4dQvGvNNQ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714920110; c=relaxed/simple;
	bh=/tY7IK1QVTL6FMfA+Ww9aRKIyTlFGPjNOtHtVgAmoKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhjY27EYFNZaIUStm8xpkb5qJxFgPFAsRQcL2Vjy1ZqQVVgOba/bZpGf8U/n0bxnz5RWb5YPhOMViHIBqThF/xJUnkmiNXmEhQiG2MK23D7ow6csF66m9ZFiiE9/qygwwEMxHZ3UK40mM05Fex6pvVjx1mfIYm2QZQ09LDR2DB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPi6uav5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48ECC113CC;
	Sun,  5 May 2024 14:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714920110;
	bh=/tY7IK1QVTL6FMfA+Ww9aRKIyTlFGPjNOtHtVgAmoKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RPi6uav5aYbPQfmfHatxieTjhCQQ4RHhRST8lMJVxqqXA1lvsP2881H8aDI6PohGQ
	 LeHY5VWkdagoHfKD2NKLD2h/PE+Y42Qhnk2RnVFDnGPdUGZ6mqz2NJCSp9WbokuMd/
	 gXQZ0f5TIRvmcxHsCK8xTyUTceKjAnZiuv171CcUpOg8lxrdpLoFQ7GGLYtuxOlQyn
	 9CP9XYcDx9tZdI3y7aQdDIIJAKZTAHeBnf+LSQDkrSTpw6ssx0ZdmzC58ADE3cuJaU
	 JCoOiMDMUiDYf2JQLz6PzgY/WxQSO8NGTZOMpJy8nMXPSCsv0xL+sHNGrn7iOi0s5f
	 q8Z086FVh2m/w==
Date: Sun, 5 May 2024 23:41:46 +0900
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
Subject: Re: [PATCH v4 00/29] arm64: Permission Overlay Extension
Message-ID: <ZjeaqkJVmNHUBi11@finisterre.sirena.org.uk>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Mvqulcr+gDoxw3xu"
Content-Disposition: inline
In-Reply-To: <20240503130147.1154804-1-joey.gouly@arm.com>
X-Cookie: lisp, v.:


--Mvqulcr+gDoxw3xu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 03, 2024 at 02:01:18PM +0100, Joey Gouly wrote:

> One possible issue with this version, I took the last bit of HWCAP2.

Fortunately we already have AT_HWCAP[34] defined thanks to PowerPC.

--Mvqulcr+gDoxw3xu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmY3mqoACgkQJNaLcl1U
h9DyDQf9FoDkCaYHDO5wProKreHZRTnyo5S6VE72gy5he2LZ7cUSiGEdleVivA4u
8R/kRZXT60g/uhii3EkTh2HOot2Bkbkq79OwjSZN1sS9vmvOFqaNe5v+vSVrHaiI
X2EXd0YIlKboeQAsL7RI17OmneWdCX3UzfPckF6xsgPEvWZU46DSc/4kff6/cahW
uAGUC9hcDdU9wrfi26ffmLu2F+V7ro64nLRGotI4jK3klTFRi6uyFE+LAmOii2Cg
erA+PnNqh1uDmi94V8HXlcg+wX/2JlEei+ATyoi5K22UgdyL/0VUG5yPn06Y6DHJ
mjHRwI6iO+NclFXmvqfStSh+YfD4BA==
=cQNP
-----END PGP SIGNATURE-----

--Mvqulcr+gDoxw3xu--

