Return-Path: <linux-fsdevel+bounces-20455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A108D3B6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 17:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568D41C23859
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 15:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8773F1836FA;
	Wed, 29 May 2024 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaoQuU+O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89FF1836EF;
	Wed, 29 May 2024 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716997871; cv=none; b=phqPrguycK7FBOaHqlIXYZC1diK7XXMdlqR3erCCwLwy35qfDW2/Uza95sy9Qosy3p8aMiLNgoslY+cXZisk9TkLTdnofC05IqxXq2n5YZjI/AW61dEooncF4LZYbw0YT5wWmKPW9KtbXgIqOtgKWpiclVA8qX3eYMqqz0O+RL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716997871; c=relaxed/simple;
	bh=yfp/7KVmaD9soBtmKL6q5BZ78PtD4h6vksVq6qycOPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTUbVfwvNlkFawVOzSFio3+rHdaCNwIsR2L2oy+QCyD+OC3OknZ5fKo5KZ8kyd0hppsE/IySBEfbi4DaJeedX9CPuPotRyVTygYOr6CXvkNGX8Ta20H4Zr9sA5zh9yS2LKIIr9F0Nf4ejJIfKtYu1xL8ut0dUkM+YvCW1C5j1Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaoQuU+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C84C32789;
	Wed, 29 May 2024 15:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716997869;
	bh=yfp/7KVmaD9soBtmKL6q5BZ78PtD4h6vksVq6qycOPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GaoQuU+Ob2D3PlaLdueq8ggVFX6iSg+v2w6qHqkuwkS9CIgWTLw5y7rGQ7+5GR4Fg
	 uANNlFpP1VgfT6if855Wvm9NdJN5hRzQP8OUOXnuwKFyjKE8G12ivBjGrC1LcCD6w/
	 2CbGLQHQSM6PJj0po0Ffs9ICz8Me24rTqw+GAiNZZ5D95XM1c/Be35pC/WsJGQWlhu
	 cvJiH6240yh986469ZD5sWVoor/vICC4R7TZnHLH5OlRmYRov3nFNqae7tV2jRXm5t
	 74bcVyy7YRqfNy5it18K2OpzG2/9T12ylaqtFtRDxi1h/k1btvzJcvqZ8OIz1ZIaEz
	 EaoL1OtvzQsog==
Date: Wed, 29 May 2024 16:51:00 +0100
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
Subject: Re: [PATCH v4 28/29] kselftest/arm64: Add test case for POR_EL0
 signal frame records
Message-ID: <58fb8a27-6c40-4b13-a231-b0db1c16916c@sirena.org.uk>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-29-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BFkxsI+/n7XbdM1d"
Content-Disposition: inline
In-Reply-To: <20240503130147.1154804-29-joey.gouly@arm.com>
X-Cookie: Everybody gets free BORSCHT!


--BFkxsI+/n7XbdM1d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 03, 2024 at 02:01:46PM +0100, Joey Gouly wrote:
> Ensure that we get signal context for POR_EL0 if and only if POE is present
> on the system.

Reviewed-by: Mark Brown <broonie@kernel.org>

--BFkxsI+/n7XbdM1d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZXTuQACgkQJNaLcl1U
h9B5sgf9GRRafV0J2nOmiAXvWZuutE7IagLikzc5FwyU8kvRSUOCwAK+THgPINah
BKWEKe5a8EKzbzzeOWUu2mhw/twKyx6t92RRQsEc4fzFmotuq+6dET2hiVcbjtyk
c1ipV82q2LVB1L7pmftHRXKUZ0DHxgT346HzSi6Oz8hl/+FIN2Wi/AnTmIIqnDrn
VSmKA7dRfJ8aQ7dsRIBk1sbuBHtNHqE0sCsy1CgaRxnh92opgwRwCy/E3g9bl+mw
hfGE1FluYz3zipMP7rHeVMPXJm95ejVZUENNlNglTFZ97NTPJB7hAYc6BVumdHNx
FHZxeYLHzVUNbVEs0vYJplYVSegMdg==
=IfbO
-----END PGP SIGNATURE-----

--BFkxsI+/n7XbdM1d--

