Return-Path: <linux-fsdevel+bounces-6907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE28E81E282
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Dec 2023 22:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB01A282276
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Dec 2023 21:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340CF53E32;
	Mon, 25 Dec 2023 21:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="CzCyLweo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E586A53E19;
	Mon, 25 Dec 2023 21:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1703541017;
	bh=MA+tfrS1lXeibluol1bguEI4A96X8uMrK02NpuUsP+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CzCyLweo2a3NR4pzHahCYYWw7UfrdovuCPf4zjosK0ao6fagU2ueJw9nsRfi7DaoG
	 RCREWnmAQyEZaoj/W1eN/riX2/3BEMnp5MkSmiU410v0bIRW/Au+qs1dIVg/xnp+XJ
	 XH4tL3Zb1VyYJ8R+/8TJv6ilmH7t0QQiz4soCSgvzL9HTjThl2P243dFFtWASvdXqw
	 5QJ10w3tI4l2HnJ0PAWk5BTtl8DewuG7EgvdcMuF9mpdeXUl86AY5HiLEZk8Gl5uvJ
	 7MNyzLycO6+r9owOb5dSZAEAldx7/zZImFzht6WadGe1KlZR8UwdjysO9Ur7NApyuA
	 3NrmwuRVEJonQ==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id A83961448C;
	Mon, 25 Dec 2023 22:50:17 +0100 (CET)
Date: Mon, 25 Dec 2023 22:50:17 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Askar Safin <safinaskar@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-man <linux-man@vger.kernel.org>, linux-s390@vger.kernel.org, linux-serial@vger.kernel.org, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: Avoid unprivileged splice(file->)/(->socket) pipe exclusion
Message-ID: <d4ocnyfwlwqfdthubds6yshbn2xk67rsjh32glhkjtzcvq4x6k@tarta.nabijaczleweli.xyz>
References: <CAPnZJGCdr7pw80Pq38UacmxsbQAowmasPtFxQVCP+tm6Cj9pUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="elcjl7by3l7zvqng"
Content-Disposition: inline
In-Reply-To: <CAPnZJGCdr7pw80Pq38UacmxsbQAowmasPtFxQVCP+tm6Cj9pUg@mail.gmail.com>
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--elcjl7by3l7zvqng
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 12:34:44AM +0300, Askar Safin wrote:
> In https://lore.kernel.org/lkml/CAHk-=3DwgG_2cmHgZwKjydi7=3DiimyHyN8aessn=
bM9XQ9ufbaUz9g@mail.gmail.com/
> Linus said:
> > I have grown to pretty much hate
> > splice() over the years, just because it's been a constant source of
> > sorrow in so many ways.
>=20
> > It's just that it was never as lovely and as useful as it promised to
> > be. So I'd actually be more than happy to just say "let's decommission
> > splice entirely, just keeping the interfaces alive for backwards
> > compatibility"
> So probably we should do this as Linus suggested? I. e. fully remove
> splice by replacing it with trivial read-write?
I am doing just like he suggested downthread of my original report, in
  https://lore.kernel.org/linux-fsdevel/CAHk-=3DwimmqG_wvSRtMiKPeGGDL816n65=
u=3DMq2+H3-=3DuM2U6FmA@mail.gmail.com/
> But it is possible that we need to just bite the bullet and say
> "copy_splice_read() needs to use a non-blocking kiocb for the IO".

I see it post-dates the thing you cited,
which naturally makes it more valid,
and it directly references this particular issue,
instead of an annoying data corruption one.

This whole series effectively amounts to three patches
(delete splice_* form ttys,
 make IPC splice_read  nonblocking when lock is held,
 make IPC splice_write nonblocking when lock is held)
just the latter two to thirty implementations of the same funxion.

This is hardly reason to kill an interface that doubles the performance
of a very common operation IMO.

Honestly, no-one would probably run into this in another decade
if just the splice_* deletion from ttys was implemented;
this is just thoroughness to a fault since you can spin this as a
security issue, really.

Best,

--elcjl7by3l7zvqng
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmWJ+RcACgkQvP0LAY0m
WPEPHBAAprjcx1jdgNBsSoj62jLD0KLv+GkwIAVu1KVkI4xzk4wswel3/5uGs/KK
iyqj+OIxNaJsNUgc3Ro5fYFoK5R+zdLLBXMUujf8xa86XjWGYWYy3PnqpsuR00bJ
JrJ4ZHygilZU5WwVaz3S9HMV5tjBDLlLuHwkvaoBGuMQRdmfaI09hrrwB3ORbmEX
NAa0Al21p2raW/YN7SRsOiR49b6zNyK7t7tz3hNaDJiAI9x1rHhcUpoNi/0hyn0C
5LfBH+0J5hXlPgivvmHGeKggq9H1Y8610WUW9TVSlvxmOMxfOThoVGjV3c6JSzrB
4sgiqs5KVtB8Q0b7N157551R63FSnYHSmxObXixgQcuwew+e3gJ8HDt76YDm/ujc
TK/kzSmGrqwpENtSuO9OaBh0UjvI39EArPWQCiDhcHr70ICgxsHV0QWcUkRfWf9c
p3kNJorU0Lrf04dyS89p6pkA4rDFUj9eColK1CvFNgOLxG2IEyd2LFGqN5S58ZF6
Z0+6GY/qkJ+i/7qbCVEb0KGpPW9XEmPU0UFwA0PeaAhiAs9yAc+NbUyoIixQWFsu
HHFBnp4xcAwlLWrBWPgDSxv8nR1vhP0ti90/6FiHQhUtlK1T85YUHVkPJTn02iHD
1Q3ibe4SIWcc4GScMo9Ypz8i0j3Vc1qWvGM8p/PuxJlOIBCz3k4=
=y6v1
-----END PGP SIGNATURE-----

--elcjl7by3l7zvqng--

