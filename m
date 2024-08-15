Return-Path: <linux-fsdevel+bounces-26074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB4F953717
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 17:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918CA28A46D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 15:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80821AD3F5;
	Thu, 15 Aug 2024 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqZS310e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547C11A706B;
	Thu, 15 Aug 2024 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735476; cv=none; b=iCBT0qTHIzqcKIZoq6DH8GtZ3GusG7TzQJrRKrJgyXNWliW8HHyw5FPGHUnjbEpfBVJHoY0zbIDveQYuZThqFp89VzpcfT6IDNp1ZXS5q1bCnDmYCqyWmZLfC/gEX0vuN3gB8KKC/H45YswFBsubkB1h5rGwz0eYmXFHkKtvbXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735476; c=relaxed/simple;
	bh=ICZgpaAfwuMR3pqfoKaQI6huKtAIlk7+AL/YQW7wSzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iM4Xd9562QRJHR9qFKJq8upxH8qK2XxewRCN6ITWk3V3Z+aOMzTC3cFpGMdGaR+f+rRZdyVf9B/WbJS4g5YRQMwsUVxN86oeGxSU8Br/A1oYpcYv9/Iq8PJCI1pCpDOrOhh25qLezQmGHoXYSy5qvNx7vr2e91cCO2Ydcj6OJyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqZS310e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4344C32786;
	Thu, 15 Aug 2024 15:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723735475;
	bh=ICZgpaAfwuMR3pqfoKaQI6huKtAIlk7+AL/YQW7wSzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pqZS310enYO3SuTKgqFBE1ONxMk5uQHkWyqjqlJm7oPicN+OhBG2QVNkgmtU9si4v
	 aO84Mpuvhc8OggeDVc6lsPuTWi2ARPg6YGyOOmMlwJYMRmLwLr/7ekvT13PDEXtO8N
	 MSvzPnFp9jNfRk9F3oYMnRCeY0litDzNrwFbgRBiZvsx/RDgK0iLmolLBSgsy3UmLK
	 dgD52B7taQ7VBGBKL1KBfJGTbFJIgXgSkGJtuvIdGoYCqOGELbep0OGePItQqw1IRY
	 j5lEJUPcwlLaVh4yh2kJUdHIoR+DNVCESBUvxThvwEc584Vx/fPL3TtrlnPnONN75K
	 fo2FvpN95wYlQ==
Date: Thu, 15 Aug 2024 16:24:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Joey Gouly <joey.gouly@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@kernel.org, aneesh.kumar@linux.ibm.com, bp@alien8.de,
	christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com,
	hpa@zytor.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, szabolcs.nagy@arm.com,
	tglx@linutronix.de, will@kernel.org, x86@kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 18/29] arm64: add POE signal support
Message-ID: <a3b72007-e0f6-4a81-a23a-6c5bb5df8cf0@sirena.org.uk>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-19-joey.gouly@arm.com>
 <ZqJ2knGETfS4nfEA@e133380.arm.com>
 <20240801155441.GB841837@e124191.cambridge.arm.com>
 <Zqu2VYELikM5LFY/@e133380.arm.com>
 <20240806103532.GA1986436@e124191.cambridge.arm.com>
 <20240806143103.GB2017741@e124191.cambridge.arm.com>
 <ZrzHU9et8L_0Tv_B@arm.com>
 <20240815131815.GA3657684@e124191.cambridge.arm.com>
 <Zr4aJqc/ifRXJQAd@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wqb8liXWozkhAkEw"
Content-Disposition: inline
In-Reply-To: <Zr4aJqc/ifRXJQAd@e133380.arm.com>
X-Cookie: -- Owen Meredith


--wqb8liXWozkhAkEw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 15, 2024 at 04:09:26PM +0100, Dave Martin wrote:

> I'm coming round to the view that trying to provide absolute guarantees
> about the signal frame size is unsustainable.  x86 didn't, and got away
> with it for some time...  Maybe we should just get rid of the relevant
> comments in headers, and water down guarantees in the SVE/SME
> documentation to recommendations with no promise attached?

I tend to agree, especially given that even within the fixed size our
layout is variable.  It creates contortions and realistically the big
issue is the vector extensions rather than anything else.  There we're
kind of constrained in what we can do.

--wqb8liXWozkhAkEw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma+HasACgkQJNaLcl1U
h9Aj1Qf/YNaa1FCiSI68LMMwxwE6eenm9OEl456cdnlqFBO9AkqUcrDmxhLHSH03
GXCM+GkBVn8BYFt9QFvMe7j1isn+eJhuaPVQV7bj6JGZb/5hw8Q2au78WGQDcfXK
7aAATdyMJlyl5xbWpzB5EP71BIpQ08XuxMbh1B1zcMjfJGlDdR7izJxhAWJekzr6
/FYhxfXLIINvWKD/QJw2mO3D61zS0CB3K0yZGKz811qViXyaoP9GrtRiLtglFkjU
TSoEwNVwVI/TNLQ1owKssDBw76Lxj9jaoLoFLl+K+vfrEwS3PD71MB3MabBrdqNG
kU8UB4OXrCNYhMJ+5rqw15bTFY+0sQ==
=L2pp
-----END PGP SIGNATURE-----

--wqb8liXWozkhAkEw--

