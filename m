Return-Path: <linux-fsdevel+bounces-31684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5A799A169
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 12:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56EB22818D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 10:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E08620FA83;
	Fri, 11 Oct 2024 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJx1W9Uq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832F41991AF;
	Fri, 11 Oct 2024 10:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728642808; cv=none; b=jCC1IQwn9ToxbAjYie6Koro/ECMyh0FsVo/iYLBh/cSrYZCr0XIUKcBWtdOT5133dvSLHWTbcD1+FjE8o8sREIaqJgjn5i9XrlCwk/kyP6Sf0eNnR+Gsx+SMCHqGXsXA24nyYbxJ1Rf19tyqVFvspsnTQtDWRaf07wD3CWcZg2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728642808; c=relaxed/simple;
	bh=GhorcXUBxSQTPlPuWzhEnEeFppc/7B1cz3ZeylvbZas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buBn49F7j5I5f4SLXyER8ZkgWkfiBbJrmH0LJMigjpAKw3LFIAUpH0sJbyMH9mB3K01ED/TNDbPCPLsGxVUue8SbG7ZPf89KCC0fHZSd58gXu50HcD6VQUXdwDeln2uqFl868FlnDyGSq32Z8Q7shz2uRGSZ1sIfjhaMzY+RDLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJx1W9Uq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB40C4CEC3;
	Fri, 11 Oct 2024 10:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728642808;
	bh=GhorcXUBxSQTPlPuWzhEnEeFppc/7B1cz3ZeylvbZas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uJx1W9UqBE6Hf5hcVjoM4flGgvmD1IVniYrw/a/r7Gyt18niIZhnTCJ/PJRR+AUtr
	 /Wzb3dtDOAkwX/dK93zaJ+W4B3L57il/rCZ4L5jXpX3G4BCrJijSAMAMZ5jtVvKF3P
	 qYfgQr2mzVkZoL4LM0zH08iO4mGhiKjLHiAn/k1EVNm/hluuJ3d4CYpxKLHgMzUwpP
	 YfFzXku0Rpw/z+5/7I4zV/wR0GiQmrn7rueMDzB3VaJ6mNFT6V+91cT/+8XMMgqeFX
	 vv1pANtyio0xTML2bHPcIjKU0w4co9DfCBULBqFSaBfbUlNayiwOtLZHb9dJNtQcA1
	 +ol8dpVu7Oitg==
Date: Fri, 11 Oct 2024 11:33:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Subject: Re: [PATCH RFC/RFT 1/3] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
Message-ID: <Zwj-9Dg3onEHnbDq@finisterre.sirena.org.uk>
References: <20241010-shstk_converge-v1-0-631beca676e7@rivosinc.com>
 <20241010-shstk_converge-v1-1-631beca676e7@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ocdJt+o9mUjvRHVH"
Content-Disposition: inline
In-Reply-To: <20241010-shstk_converge-v1-1-631beca676e7@rivosinc.com>
X-Cookie: Editing is a rewording activity.


--ocdJt+o9mUjvRHVH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 05:32:03PM -0700, Deepak Gupta wrote:
> From: Mark Brown <broonie@kernel.org>
>=20
> Since multiple architectures have support for shadow stacks and we need to
> select support for this feature in several places in the generic code
> provide a generic config option that the architectures can select.
>=20
> Suggested-by: David Hildenbrand <david@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Reviewed-by: Deepak Gupta <debug@rivosinc.com>
> Reviewed-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
> ---

You need to add your own signoff when resending things (though I guess
this is likely to get applied to a tree that already contains this
patch so it likely doesn't matter in the end).

--ocdJt+o9mUjvRHVH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcI/vMACgkQJNaLcl1U
h9DUvwf8CFk5qIwgXlnGyTrPYSXbnOtVbQryriXq4ItU769fSrWbYRrSDfHAZNuL
GFJbbI7qXQIwUZjp7itgbXwjiYEfEi1LiaqDJSfsZNEjv5z/HigTj+Q1Z20/nEO+
QZuVAIXw14A9w+6EYEukxtADhKW53aedbezpJDd8I3eJiaLYy9WxumkOsndh0Tzn
8DtO2wXHph/jGp8AoWDmLTqU0eMuqWELHgAmirtfl0mHxChlilDYO88fJSt4o2Om
QlfMrg+YQKIYe76JfjkISxIXeoYXpU9gKjVXPdbJW5rLLl+9o621MhYV6kCe/Ipu
FjBehOpbNwCRAdM2ctnXaIfshhKRdQ==
=0ZCo
-----END PGP SIGNATURE-----

--ocdJt+o9mUjvRHVH--

