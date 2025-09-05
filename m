Return-Path: <linux-fsdevel+bounces-60370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA126B4619F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 20:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683321C824A0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 18:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9E93705BA;
	Fri,  5 Sep 2025 18:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2UfK7QX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DF02AD25;
	Fri,  5 Sep 2025 18:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757095336; cv=none; b=cQctQwltk4CXs1RaHbG/QT+uRq5cGpFANI1EAiHGQYwjOcvBHMvmoykdpY+X17nc+tXq3KzW06wMDzA4wGhsRaVyDIE2cfrK9uRPK16cEkamPQB3Y2pcCNdYEikUl5uealfcPKgg/NS4QtbVeeWCoO4cTx6z9gizSO7ciq5/EN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757095336; c=relaxed/simple;
	bh=6+8JIJLbwNB4qZrpYNsQtnjhJwAgVff1bSa/FYZHBKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZ95oFQnYzvzXsDKK9A5GxjXM5jOVTXyBZt0xrCOqyXd5BmrZGpXQCYVYTbDNe16xXIDlt+xzYjxf+Mc6XrFJICHfmIodrWSYP0Yt/JdlsxJn66YD5dzA5aKz862PX3zFVDoft2uwsLKPEFnTG82LsNrj80WhDImvDEsofcoo/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2UfK7QX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B25FC4CEF1;
	Fri,  5 Sep 2025 18:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757095335;
	bh=6+8JIJLbwNB4qZrpYNsQtnjhJwAgVff1bSa/FYZHBKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s2UfK7QXsPOsR4h1I7z4w80D4OJq0HUKhdxFzTJJXPQW76a/ymHqdFoShZGHOri27
	 hUIngdSefZ9zAz6kgALIQOXKls+JFAxBrOXQedFuF7/bNjOAbdIegQQN9UkAogzIZt
	 4gerN3GoA1WzegyqmRCTqiO1IDM/9DXScs+5qcWmY+XZ0TepXdr7Z1a4iQPgmIiZXi
	 Ffdcaqr3SGeT60JfLFJKVvACXiy8LazmUV1LMvVCMeC1pigzw/GvLKEk5o3eZYnZes
	 YQe+hO4MjJv5mDsPcaflz0Gi2b4mDfo5x8sKYIZATaXoMww/La75/NoUQPKIOb33Hk
	 DmJ9FMbs7OwfA==
Date: Fri, 5 Sep 2025 19:02:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Usama Arif <usamaarif642@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, corbet@lwn.net,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	hannes@cmpxchg.org, baohua@kernel.org, shakeel.butt@linux.dev,
	riel@surriel.com, laoar.shao@gmail.com, dev.jain@arm.com,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	ryan.roberts@arm.com, vbabka@suse.cz, jannh@google.com,
	Arnd Bergmann <arnd@arndb.de>, sj@kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kernel-team@meta.com, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v5 6/7] selftests: prctl: introduce tests for disabling
 THPs completely
Message-ID: <620a27cc-7a5f-473f-8937-5221d257c066@sirena.org.uk>
References: <20250815135549.130506-1-usamaarif642@gmail.com>
 <20250815135549.130506-7-usamaarif642@gmail.com>
 <c8249725-e91d-4c51-b9bb-40305e61e20d@sirena.org.uk>
 <5F7011AF-8CC2-45E0-A226-273261856FF0@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UFcG+34rk9hn3RB3"
Content-Disposition: inline
In-Reply-To: <5F7011AF-8CC2-45E0-A226-273261856FF0@nvidia.com>
X-Cookie: He who laughs, lasts.


--UFcG+34rk9hn3RB3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 05, 2025 at 01:55:53PM -0400, Zi Yan wrote:
> On 5 Sep 2025, at 13:43, Mark Brown wrote:

> > but the header there is getting ignored AFAICT.  Probably the problem is
> > fairly obvious and I'm just being slow - I'm not quite 100% at the
> > minute.

> prctl_thp_disable.c uses =E2=80=9C#include <sys/mman.h>=E2=80=9D but asm-=
generic/mman-common.h
> is included in asm/mman.h. And sys/mman.h gets MADV_COLLAPSE from
> bits/mman-linux.h. Maybe that is why?

Ah, of course - if glibc is reproducing the kernel definitions rather
than including the kernel headers to get them then that'd do it.
Probably the test needs to locally define the new MADV_COLLAPSE for
glibc compatibility, IME trying to directly include the kernel headers
when glibc doesn't normally use them tends to blow up on you sooner or
later.

I knew it'd be something simple, thanks.

--UFcG+34rk9hn3RB3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmi7JZwACgkQJNaLcl1U
h9CXKQf8CLPDpCThx982MKFSA+6kIQN173w+JjtervyO0xBauOFpYhofXBOJ0T5F
gBBx9/nVvRfBb2qz+9/c6b4AhAZU2soqeZMDTjDJ//eBUYiNlFLbsOMuFPg/s06w
pWU765APcweYpKI8xj2QmAlP6HTEYcAIBhFGv1taQ7bVwS86HL0Rkl+4IUB5KtC+
dyCYUXNJ0TIlxNXvHLzk/t/35IZ3IbphnAk7TcUpcxV2pKnztlzFtQLk66Mgr31j
Af+RATFuHuhGnDOMbg3pUsVUMl2wZ1JfF3FoDs5oyNCUN+isKcmQFiaJMWR8BlzT
/K7wOXmcgx0SuUXmECqvydHaxCcLXw==
=A8qN
-----END PGP SIGNATURE-----

--UFcG+34rk9hn3RB3--

