Return-Path: <linux-fsdevel+bounces-29195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC7A976F8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 19:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24F31C23C1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 17:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85511BFDE6;
	Thu, 12 Sep 2024 17:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILfeSbw+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B77D15098A;
	Thu, 12 Sep 2024 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726162183; cv=none; b=g5EOigVpMQ5ZMXxSSf2vYXpgX3PWY94J7A2RQcoJIpiLI42DeSJ2uO3C/FhVLhceNSsnt+dONnp7fjT869wqc2Zli2omZI4gPxXVqNqwEJ2SpSyqR4OHr13TVqW+KxvFUyar5U7dxI/Y/dek60jr4F60IwYWEi1/JzWHMBLRuY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726162183; c=relaxed/simple;
	bh=zDGznEn/StT0eacvGsbWQqOmyRaA1BKWZvptYgykthA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/CjdEvpaoHtPaJK3+4k+UkCSgMRjQ9PpW2ZvvF2makzVvcUsTSTk5bPuDahY1MFiXvixrrHpOcYA+jFL9MghhRHt+wQYwRu87AGWZgRF+jqE8mySDJJL49F7nLIpb/LcCOfx5VuKGG8zNWDnXLq1CXnLe1YQUJlDE2qM+i4HfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILfeSbw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57E1C4CEC3;
	Thu, 12 Sep 2024 17:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726162182;
	bh=zDGznEn/StT0eacvGsbWQqOmyRaA1BKWZvptYgykthA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ILfeSbw+ykMKzupv4qU1xlaCnMmDg80aCV9c/GQ8X1ITGrUufUpoEUhKQivsfZt96
	 mIl2oZmkrvZ8EQ78pc7uNOHIm2BHJEl+ct8or6iRF1Gsy17jWW0Cdgr2jtscW7rc8P
	 rn8JQLaFDgCjckH1eN92sIqA8UTxyEFoDIfo3BWyeEUrDTeRjrhH+lVTXxh3G1X/1L
	 3EWncvTiw65P6HteNwzHx3AKz6C5wisCIQs57AEBEVwm+C+/wf/VeDNv36l70XU53a
	 AZFcv3AOQwH4qSGsx1LsWQBYsjOfJvlFEF0tYqxK9B7C6sXnovn8nwb0YZxrguOuQd
	 rFc0ZuLmvSknw==
Date: Thu, 12 Sep 2024 18:29:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] arm64: Add infrastructure for use of AT_HWCAP3
Message-ID: <b8d2f79b-1ef9-4e30-b3eb-a586fa88c4ba@sirena.org.uk>
References: <20240906-arm64-elf-hwcap3-v1-0-8df1a5e63508@kernel.org>
 <ZuMauVtQz21aBiAX@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PY2TG83/gvDfQre4"
Content-Disposition: inline
In-Reply-To: <ZuMauVtQz21aBiAX@arm.com>
X-Cookie: Happiness is the greatest good.


--PY2TG83/gvDfQre4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 12, 2024 at 05:45:45PM +0100, Catalin Marinas wrote:
> On Fri, Sep 06, 2024 at 12:05:23AM +0100, Mark Brown wrote:

> > We will at some point need to bite this bullet but we need to decide if
> > it's now or later.  Given that we used the high bits of AT_HWCAP2 first
> > and AT_HWCAP3 is already defined it feels like that might be people's
> > preference, in order to minimise churn in serieses adding new HWCAPs
> > it'd be good to get consensus if that's the case or not.

> Since the arm64 ABI documents that only bits 62 and 63 from AT_HWCAP are
> reserved for glibc, I think we should start using the remaining 30 bits
> of AT_HWCAP first before going for AT_HWCAP3. I'm sure we'll go through
> them quickly enough, so these two patches will have to be merged at some
> point.

That does seem like the easiest path for everyone, assuming that there
hasn't been any usage of the remaining spare bits we weren't aware of.

> We'll need an Ack from the (arm64) glibc people on the GCS patch series
> if we are going for bits 32+ in AT_HWCAP.

Yup, hopefully Yuri or Wilco can confirm prior to reposting.  It does
seem like it'd be good for glibc to add whatever support is needed for
HWCAP3/4 now anyway so that whenever we do burn through the remaining
bits on AT_HWCAP there's less friction as we start using them.

--PY2TG83/gvDfQre4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbjJP8ACgkQJNaLcl1U
h9A5uAf/dRvyo0ETJshkqYxCUdY9OOrC8VAw6izGokC7Pbig9GfOGMbwramzsIPK
79bkWe8NRIYB/ZAPmQJE5on/o7LIfGKmBacSz/hRBUzB0frm2utsQSbFzxOlUZdw
gBfOhfJ0WT9Fr2HWojcoHFy3Wrlh7yU6fCxLptsclItcYQ66OHqPLyZ3ZmhMJfke
CdE0ibgG4E5bMwpDHwmUFct9PkaIxLm8G80VBU3h8584BCTGEgy+0zGPfQBi8CBF
f5SeikY/4ZtCA+SznibclKPw5u0Ow7Z5jmP6/CPInfu0a71R8/nkmAiLJ0hBr7IO
NsADawEmyVdwQRMhsRpMwtW/HNdULA==
=ra9H
-----END PGP SIGNATURE-----

--PY2TG83/gvDfQre4--

