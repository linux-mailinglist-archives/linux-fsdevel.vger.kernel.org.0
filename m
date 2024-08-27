Return-Path: <linux-fsdevel+bounces-27309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD0F960198
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 08:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976102825F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 06:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51C31487D6;
	Tue, 27 Aug 2024 06:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hxOQOsCF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEA5146596;
	Tue, 27 Aug 2024 06:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724739971; cv=none; b=bXbjXdz9RRbPJEu2al8rPSna9bf0OfY2Sy1NNWDeZ7wn/911wFN5KG2XgVYg9Gp5N1SGwduqNoFyhSH++W/hVbCdIuIM3B78UyzuzgfHUdhnbvT2a+7FiCo8kLM0pfY2vh66MmidPhiT7JhjFxzLJ9wRKriYKpoDATs0mPCqwoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724739971; c=relaxed/simple;
	bh=dEhTUlXeWzHxDgVzj0ci8VW5ybz/ubs17Yn9nv7EjYM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emHdnXlghI+wz6XfLPaOcSh6WL4maDLRubsG+R/TLXSeK+kGkhR+dBFak7VS50K+HpOvy6GgG2iy+hXKVqI2rlx2xbWwh2KTeq96OS+e3wXIq+oVc5fEhOCjx7LOB9UjTCEAgiXvqoQQa9Ktk5jAjxBsrehh1gfCSI49QLIcQUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=hxOQOsCF; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1724739964;
	bh=dEhTUlXeWzHxDgVzj0ci8VW5ybz/ubs17Yn9nv7EjYM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hxOQOsCFKBD0D/EMlqQ2y4x3oKZAVhGs1l9NbRS2Ipjg2J/qKk9Yz4utwKQb59RS7
	 j3LZF50BJBnI1P5Hdt/TrW/LuRB3VnKVKT14vJG4DBsL14Uq7Y3xiKpSK5UBwm3mdn
	 CI06KAzzE+ge/aGhW3BZp3B0JsNY7cGVI1FvSD8bKgcuxmwHwt9s5x9QxhK+mB+wXS
	 2sFb1z662ze1E/MmoRPEaztGuhGloCL+LhnGzTENyhSchPHvWQI9xaTS8jxjDkHnFW
	 0sUk2iyNrR9dTPTYCZgaHAiCQ31VOuZvpcbKQftPdxxwh+3iOIiyfbh+52WeGaGXCg
	 sQWUk2Q1/57AA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WtHcD3GgXz4w2R;
	Tue, 27 Aug 2024 16:26:04 +1000 (AEST)
Date: Tue, 27 Aug 2024 16:26:03 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org,
 p.raghav@samsung.com, dchinner@redhat.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-next@vger.kernel.org
Subject: Re: [PATCH] iomap: remove set_memor_ro() on zero page
Message-ID: <20240827162603.1a86804a@canb.auug.org.au>
In-Reply-To: <20240827055539.GL865349@frogsfrogsfrogs>
References: <20240826212632.2098685-1-mcgrof@kernel.org>
	<20240827055539.GL865349@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WnlHn7eTQnOBUQK_4ciR3n7";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/WnlHn7eTQnOBUQK_4ciR3n7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 26 Aug 2024 22:55:39 -0700 "Darrick J. Wong" <djwong@kernel.org> wr=
ote:
>
> On Mon, Aug 26, 2024 at 02:26:32PM -0700, Luis Chamberlain wrote:
> > Stephen reported a boot failure on ppc power8 system where
> > set_memor_ro() on the new zero page failed [0]. Christophe Leroy
> > further clarifies we can't use this on on linear memory on ppc, and
> > so instead of special casing this just for PowerPC [2] remove the
> > call as suggested by Darrick.
> >=20
> > [0] https://lore.kernel.org/all/20240826175931.1989f99e@canb.auug.org.a=
u/T/#u
> > [1] https://lore.kernel.org/all/b0fe75b4-c1bb-47f7-a7c3-2534b31c1780@cs=
group.eu/
> > [2] https://lore.kernel.org/all/ZszrJkFOpiy5rCma@bombadil.infradead.org/
> >=20
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org> =20
>=20
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

I added this to linux-next today, and it seems to have fixed the run
time warning, so

Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell

--Sig_/WnlHn7eTQnOBUQK_4ciR3n7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmbNcXsACgkQAVBC80lX
0GwSvQf/SZMg3tJDWWeP8zI9bZsMGEGzu5BLoZ5oj8mmXcuOqPucOfCNi/tvrAh1
OnGlCyfZzYNT8IeItMqx7z2IgUW+PFDfXJhNCRUo/HNtI35ujrDjheFJahmA+Fxx
pupM1EiDiKOY366X0XzQ3vc1Q224QMIcWw7NgpPC2xN3xhsiV4w3d5WSyP/hDigq
2wlrdH8H8ssAD9EM6JXfqPxvFYEoTJzCPj4Nl7/o+/c15SRfGjwXFkd3hbUE2eif
fXlSIFoPaRIwQDvff0jipIQG3ArRIRa0UsyiBvnmdGalXLgG9WoHKrlUzR+a/IU3
+xa+rMHLb9LGTX8ggF8/6S7lWyzF6A==
=5GmB
-----END PGP SIGNATURE-----

--Sig_/WnlHn7eTQnOBUQK_4ciR3n7--

