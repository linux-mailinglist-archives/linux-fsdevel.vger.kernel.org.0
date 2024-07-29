Return-Path: <linux-fsdevel+bounces-24453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 016B793F86D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 16:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D102813E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 14:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53622153BEE;
	Mon, 29 Jul 2024 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGBYnPIB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ED2823A9;
	Mon, 29 Jul 2024 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722264070; cv=none; b=fnNQiGK/mxnOWDsDZz1gK/EQVgzXj3NbU21chbbCrh+foCrLFKDLMOulDq3J2U+WRq9XbQ4fpieee4HyjH19YMo64pq66KjoO9ZOtciu/f43++hcyxN2os3K2/wz0V/uWcNK0j8hTcCoZHkz+ypke6hCzhrRbbNXR9Aa5RFePpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722264070; c=relaxed/simple;
	bh=Q1+AFnT8npjT4Lpzo89th+2c5Ce2NhXgTpXjWRxaQgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCDeF9cLoC5TtFfDFBy5PnJyUzg34VsSTZkO0e3nlMa4W+ViGfG9KexjXsaRYre4KB1WVaBpVb/w0YfhTFiL2J4u9sROd3W9VMmboIbaj5HvJwlsqfDRivNr5gxi4pjfrjXGpnFIwywitK+HmPn4Rd5xW07YhvFaH3XvjBlZfH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGBYnPIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432FDC32786;
	Mon, 29 Jul 2024 14:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722264070;
	bh=Q1+AFnT8npjT4Lpzo89th+2c5Ce2NhXgTpXjWRxaQgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tGBYnPIBHtddODwHKJTwc5SNcydiu0rIYiiTdQSD6Jcfh58muUgxoWWx1HGhX+dBA
	 q4aNdnMat9XV/dJSr0Krv+/572bI25pLk/Mw8m3pM/U67w+XRoDfY2+d4KHpmcz3zd
	 fs7kdyp/5OPkGmfFhDPiV8SESJ0AtpesUlGHkWwO5faFczHM1ygCJXXDhxZQtS9nMM
	 L7cFmnCjTkawc8+Es8/SthD6tGXrnfkoP8QVC8hDN+yc/Ow6VOcYYv+1KldeWxoBo2
	 ImEtsNVE8MBdBTpOGXTm/zjat/YsFzJyu+drwCuJE0zSeQMzp8zqe1jcPiaFpveRI2
	 IYuXCKTTYBmqQ==
Date: Mon, 29 Jul 2024 15:41:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Amit Daniel Kachhap <amitdaniel.kachhap@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@kernel.org, aneesh.kumar@linux.ibm.com, bp@alien8.de,
	catalin.marinas@arm.com, christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, szabolcs.nagy@arm.com,
	tglx@linutronix.de, will@kernel.org, x86@kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 18/29] arm64: add POE signal support
Message-ID: <8a6135cc-67cd-4fbe-96fa-3598491c1c66@sirena.org.uk>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-19-joey.gouly@arm.com>
 <229bd367-466e-4bf9-9627-24d2d0821ff4@arm.com>
 <7789da64-34e2-49db-b203-84b80e5831d5@sirena.org.uk>
 <cf7de572-420a-4d59-a8dd-effaff002e12@arm.com>
 <ZqJ2I3f2qdiD2DfP@e133380.arm.com>
 <a13c3d5e-6517-4632-b20d-49ce9f0d8e58@sirena.org.uk>
 <ZqPLSRjjE+SRoGAQ@e133380.arm.com>
 <a52f1762-afd4-4527-88ac-76cdd8a59d5d@sirena.org.uk>
 <Zqemv4YUSM0gouYO@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hJtaL31y4F/8RS76"
Content-Disposition: inline
In-Reply-To: <Zqemv4YUSM0gouYO@e133380.arm.com>
X-Cookie: List was current at time of printing.


--hJtaL31y4F/8RS76
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 29, 2024 at 03:27:11PM +0100, Dave Martin wrote:
> On Fri, Jul 26, 2024 at 06:39:27PM +0100, Mark Brown wrote:

> > Yes, though that would mean if we had to generate any register in there
> > we'd always have to generate at least as many entries as whatever number
> > it got assigned which depending on how much optionality ends up getting
> > used might be unfortunate.

> Ack, though it's only 150 bytes or so at most, so just zeroing it all
> (or as much as we know about) doesn't feel like a big cost.

> It depends how determined we are to squeeze the most out of the
> remaining space.

Indeed, I was more thinking about how it might scale as the number of
extensions grows rather than the current costs.

--hJtaL31y4F/8RS76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmanqfsACgkQJNaLcl1U
h9AXbgf+JtPrAvhLYf2ZdjhYtqAh1SMzgRQmESORZGriT/8kYjk9Mo4NTTvAC2Yn
/VfRFTo1v4jtdJYliDP8UNjdn0/QJDc/vV8wuWpM2OuGhJIY632rnSXGdUKRyg1n
x2CMonSmVuyf9RgJv7ycXFXL2p1CqtQTJ1s1B/q+JMxL0qRTtPouELOvuEzsk6Pu
cr0MQ6m9KR1RlhfmTeW23zy+Diwyrgj9E6Fp5vHHU31sK1rYS7z7ODNzWxhBOkdw
JY29M0Zsww4EHQqBRB9CoPAKSbx3GgG6c5yo6BHxem4Fpun2mq0OKuIfobbb8Luk
psf1yW9CJPnOO6ekMQXlpmPZwS1CPg==
=os6B
-----END PGP SIGNATURE-----

--hJtaL31y4F/8RS76--

