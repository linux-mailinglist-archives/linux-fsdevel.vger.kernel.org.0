Return-Path: <linux-fsdevel+bounces-63440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA0ABB9422
	for <lists+linux-fsdevel@lfdr.de>; Sun, 05 Oct 2025 07:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E9734E1702
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Oct 2025 05:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17BA1E1E1E;
	Sun,  5 Oct 2025 05:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="OqUzqsmn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6B7126C05;
	Sun,  5 Oct 2025 05:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759642681; cv=none; b=pcanPouoEIrG32wrVoy4y2B54T/Zy2jao/NUAI0ECCNtBu+igfhY10UWHeQNkYLKpW+wGYrC6dS3hnLcVF9cMnhtyT6np2mwgdvUGGZ5ziig3cCTpPgVV98W8/jOuMBp3gJZ9Gq6rrkqt/wr6397HReIdhk3e1YJ/uyFKvXlTLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759642681; c=relaxed/simple;
	bh=6F0CzM+vMWA9ALL6cpRvIbUDqS/dg+JYk9nyEMxzxZU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fFeyHCZ1z9p4C0pwlB7k/Ry1s++mgU57tbE2xrh8zDYNe7QoSdOFINSSUCMH+VkMb+ED+Nw2g9R5keGdeHN3tjNo+1C4V8ydZk+CaB6ahjaYa48JBZq2GxLZcl66YDsHvo199BMl4DUPg07mflmKkRRgSPnWie0cjUbGtu+5HsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=OqUzqsmn; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4cfWQB0ZDlz9yBj;
	Sun,  5 Oct 2025 07:37:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1759642674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6F0CzM+vMWA9ALL6cpRvIbUDqS/dg+JYk9nyEMxzxZU=;
	b=OqUzqsmn39dM8pmMwAaqi934iWsGE6Cxdm+O3v3QPjZSF6jXp10TRjQqAlyeodgYETQzmH
	BGlsyl3RI/vOtDYCZIPyVhIsQ8CO5XVgBllLSsqCYreEYrRJIIm3KAmQu9MkGec8ffCY7U
	IH3G7pNbIfOpjD0UmHBv3yqj9YTV2N46M8JkJyjNOijz+grg27rAqhxbfRbc6VplfUWwOA
	J1Xj1yJ3tGORgB0jvDyEW/PBH9EG6Tgu3j7MmcodpCfz52P/Lp419bhJiH+TSuVQeNVWjT
	NOQQsemiYouEs6swm+glIW7bo1FBza7i4awlVIP+6lc1CNfj2BcuCf36rrEmqg==
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,  brauner@kernel.org,
  linux-kernel@vger.kernel.org,  jack@suse.cz
Subject: Re: [PATCH] fs: Use a cleanup attribute in copy_fdtable()
In-Reply-To: <20251004211908.GD2441659@ZenIV> (Al Viro's message of "Sat, 4
	Oct 2025 22:19:08 +0100")
References: <20251004210340.193748-1-mssola@mssola.com>
	<20251004211908.GD2441659@ZenIV>
Date: Sun, 05 Oct 2025 07:37:50 +0200
Message-ID: <878qhpc3ip.fsf@>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Al Viro @ 2025-10-04 22:19 +01:

> On Sat, Oct 04, 2025 at 11:03:40PM +0200, Miquel Sabat=C3=A9 Sol=C3=A0 wr=
ote:
>> This is a small cleanup in which by using the __free(kfree) cleanup
>> attribute we can avoid three labels to go to, and the code turns to be
>> more concise and easier to follow.
>
> Have you tried to build and boot that?

Yes, and it worked on my machine...

>
> That aside, it is not easier to follow in that form - especially since
> kfree() is *not* the right destructor for the object in question.
> Having part of destructor done via sodding __cleanup, with the rest
> open-coded on various failure exits is confusing as hell.
>
> RAII has its uses, but applied unidiomatically it ends up being a mess
> that is harder to follow and reason about than the dreadful gotos it
> replaces.

I agree that it would generally not be the right destructor for it, but
in the case of this function it ends up being equivalent. But I see
that, if in general that wouldn't be the proper way, declaring the
fdtable variable like that can be misleading, even if equivalent
here. Thus, defeating the purpose of this patch.

>
> NAKed-by: Al Viro <viro@zeniv.linux.org.uk>

Thanks for the review,
Miquel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmjiBC4bFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZQ4lD/40OwC5BCFB9rDGuIf0ooR/hI0Il00SlqwopgV/iqTtwTUWJjb2lwHc92x1
8gxHgPImTG5AVa2DrhrTqn4loWDelK0m1OWQPEfnuFFAFg71+uRLc54VPPbHMo+N
QqQQ32u2z2BphQ7xO+QUGf1w5t5NxjaRnqdjNEdnsaMIY9ieW94YCFSGJ+6IFfEZ
Dm/zlgj/3kIrmo/la9VryTLrv0jvSkaR8Rc44PYMdLM2hQDhrOKSwy8yF8ILnm1Z
WHXD9ugIFFhCCT9/ideu5tysSoe/E3Eowd6+bBJOPobn2I7cqbHVCV3nMN2mCTkK
3GM+urRqHGOIEOpUBLVhbUJsTR9TOuAmkjzIVtllKSWNlI4DbP2wAusmhoDCI7Yg
74Bms+3avhtl1QAKx0Tv0Kz3D3Lx545A/SFF80CGC08XgM6HryFwAos5eylKcuIU
mMAUFrQpFMvzp/eq0IkeBUriAKf2qLxUUGz0x3U8GEWqx+RwxXH8uHsP3TYxS6yr
JicWcQNYSR2wFm2Ocvfae7p5sCvYHcl2lCh8GShsld64h+q3/wF1onuXsL4oP6yh
ZFyLH1Iktj9EYxG2/GrO9ZnSElOaGtTSrdqcyVCJGFsMxmqMN7Pmoit5HlAVeqDM
vAANrBTBHwTEsaWS2oT4vkTAp1OQCU6TZol9YiXVKA7zsl9a6w==
=tKwb
-----END PGP SIGNATURE-----
--=-=-=--

