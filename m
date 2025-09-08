Return-Path: <linux-fsdevel+bounces-60565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2255BB493B8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 17:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4033516FC1E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 15:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8B730F52A;
	Mon,  8 Sep 2025 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ep1EYedZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803EB30EF8C;
	Mon,  8 Sep 2025 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345891; cv=none; b=JfbRRayNZefsBwJP5lf9NYWK9gGYPS93iHQV/nVCw3nTCDbbzZr7xGUuyvIHdtGzSYdcQUyJp8ykirZ8IWfbQCT88Edqzzitopp09LbGIiztJywAUdSqi/i62pWI0fM6oo/arbdtL527ScIkGG4MK+qxlS3TFBzF0MKNmTV0k+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345891; c=relaxed/simple;
	bh=oarmcvIm1kef6CmcsianKwOkYkE4XFEwSbH1MfeQkz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgzJl7Ar/jRmOii+X91o6TZPoArnTG9PbPouc+z2c97CE3nfoFqP5oQrokbdfHGHF6hlwBC2CIo3rix1cXwW4LUO9331bA7M9fJt2pvQxFmskj+CnGTnqC1rbaTBaxEFu5adLUur/Fs9JgwsdAMRHsTPhcg9C8JVPTA0mc/xwJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ep1EYedZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD347C4CEF5;
	Mon,  8 Sep 2025 15:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757345891;
	bh=oarmcvIm1kef6CmcsianKwOkYkE4XFEwSbH1MfeQkz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ep1EYedZ6Ec5TwvGsFIhH4bfdCRa3Al1hhJLIEPRFPaZmx2PFFJLOHx2+PsYoxPuQ
	 9SdkOxvuaOl7VEhV+W0G7k6h3CZwVU5npM87W6mNJMrvGbpJq1kKbN4ojpNMBX6icC
	 VQkzL8f5e9C+JErhGyJSNtVRKduuvkBV++VcSCdNEojPexWQhCyFlI+RCWvjdZKTtt
	 qwCJVL4FXuMV+LXKGgDu51ADdbFlqXmWvEdfjm1NHrFafa59yPCSZm2iwRdDcLTqJd
	 YwhpntsNBNfTcSuzzldNyIsAK1r78Z7OZ8Gsy/xor7kxAIWc1R5oODYoBpJEAdYNiT
	 H+jOajvRkJ20Q==
Date: Mon, 8 Sep 2025 16:38:03 +0100
From: Mark Brown <broonie@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
	david@redhat.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	corbet@lwn.net, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
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
Message-ID: <771871a1-9ee7-472d-b8fd-449565c5ae80@sirena.org.uk>
References: <20250815135549.130506-1-usamaarif642@gmail.com>
 <20250815135549.130506-7-usamaarif642@gmail.com>
 <c8249725-e91d-4c51-b9bb-40305e61e20d@sirena.org.uk>
 <5F7011AF-8CC2-45E0-A226-273261856FF0@nvidia.com>
 <620a27cc-7a5f-473f-8937-5221d257c066@sirena.org.uk>
 <abe39fc3-37a3-416d-b868-345f4e577427@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hfwXTexgNKMLpchl"
Content-Disposition: inline
In-Reply-To: <abe39fc3-37a3-416d-b868-345f4e577427@gmail.com>
X-Cookie: Air is water with holes in it.


--hfwXTexgNKMLpchl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 05, 2025 at 08:40:25PM +0100, Usama Arif wrote:

> diff --git a/tools/testing/selftests/mm/prctl_thp_disable.c b/tools/testing/selftests/mm/prctl_thp_disable.c
> index 89ed0d7db1c16..0afcdbad94f3d 100644
> --- a/tools/testing/selftests/mm/prctl_thp_disable.c
> +++ b/tools/testing/selftests/mm/prctl_thp_disable.c
> @@ -9,6 +9,7 @@
>  #include <string.h>
>  #include <unistd.h>
>  #include <sys/mman.h>
> +#include <linux/mman.h>
>  #include <sys/prctl.h>
>  #include <sys/wait.h>

> should fix this issue?

That seems to do the right thing for me, I'm slightly nervous about
collisions with glibc in future (it's been an issue in the past when
they're not using our headers) but I guess we can deal with that if it
actually comes up.

--hfwXTexgNKMLpchl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmi++FoACgkQJNaLcl1U
h9CQUAf9GffZCLtWduDOey9wyk38tq59lJt4ncsVhdGdlf8P9K1mRKQ0QbwiQ8WK
IcvgFV17rPnWluoFp1fMi1Sr4QTodXu0Mh/9Nwi1WePdL7oN3qIPJc0vVpS77hSb
/n9SoSTWu/wTR+aC7MUbNOhybPJ51EmWgKu9OjRjiaTPhZkcgsnmf/UdbrfxIo4B
/r8mDK+0ueEU7f4cNotXEHwX368l7XaxAS4eUZYA3G+dt4KOd870SmQoNm3XvFHO
aR56puJdfE5dssvWD4SwFfG42uuwRv36s3tS8zftcU/TM7bSCFLscYEy/GjFXjtj
yxPy8DivYxW2jew8K9YE45p3LMK7Lg==
=ts8T
-----END PGP SIGNATURE-----

--hfwXTexgNKMLpchl--

