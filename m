Return-Path: <linux-fsdevel+bounces-6120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 442C1813A3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 19:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EB50B21561
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 18:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C7868E8F;
	Thu, 14 Dec 2023 18:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="jHdrVrI5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A816FB;
	Thu, 14 Dec 2023 10:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1702579495;
	bh=HdTsxawUqvYBqho9F8qfYgYlmOiA88qfknRMSXgij6E=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=jHdrVrI5NZyeYt+K+FSO9zKM0tTA499Q1cB+K1dvZbIIKwM7zi+hpj7wvgNZmr04/
	 Sk2dELl2jUoSWvLp7A//4WuKVr9z4rEy6PqFY+LNOv2V8M5X85ffyZVWN220/NIS0b
	 sA8JDl5dpah4bnW1EfP+RGorBMlQS7cqtym4B0dJf0P3xjtQIlVQLYwOFz+kA2jCaO
	 YTKGUs70Ox8ei/67BnYdwOvclbIkAw4uDSy+RI29C7qaj/1jsUepUUC9PjUCrYqque
	 /mQgTIETwDiVnv6YFez8wCuWMviss9E/QVpmxhF1DraMXfnLgMoVhj1quE7+9OMfAo
	 itv8Acm2JtGWg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id DAF0B13272;
	Thu, 14 Dec 2023 19:44:55 +0100 (CET)
Date: Thu, 14 Dec 2023 19:44:55 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, David Howells <dhowells@redhat.com>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Kirill Tkhai <tkhai@ya.ru>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [PATCH RERESEND 02/11] af_unix: unix_stream_splice_read: always
 request MSG_DONTWAIT
Message-ID: <28db45d00902da22ae25aa16a0c28bb41002fc039.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103
References: <2cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ye7hyns4bd3ezngs"
Content-Disposition: inline
In-Reply-To: <2cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>


--ye7hyns4bd3ezngs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Otherwise we risk sleeping with the pipe locked for indeterminate
lengths of time.

Link: https://lore.kernel.org/linux-fsdevel/qk6hjuam54khlaikf2ssom6custxf5i=
s2ekkaequf4hvode3ls@zgf7j5j4ubvw/t/#u
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 net/unix/af_unix.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 3e8a04a13668..9489b9bda753 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2889,15 +2889,12 @@ static ssize_t unix_stream_splice_read(struct socke=
t *sock,  loff_t *ppos,
 		.pipe =3D pipe,
 		.size =3D size,
 		.splice_flags =3D flags,
+		.flags =3D MSG_DONTWAIT,
 	};
=20
 	if (unlikely(*ppos))
 		return -ESPIPE;
=20
-	if (sock->file->f_flags & O_NONBLOCK ||
-	    flags & SPLICE_F_NONBLOCK)
-		state.flags =3D MSG_DONTWAIT;
-
 	return unix_stream_read_generic(&state, false);
 }
=20
--=20
2.39.2

--ye7hyns4bd3ezngs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmV7TScACgkQvP0LAY0m
WPGi6xAAnOF1XsITYUFaL7TgbYsG5Cc848T8lIyQ52KabsYFv6bNp74g60c2vPo+
JhktQE8Iur9cvutWppKMZsLoQMRZxFD5oD9Bmbx19Gx3UQVejdrYQEAtqaMLHMZU
tlao88CDisdmKBQ0mTKrxFzpgxVxClvO88NNAj3AYLitDTZs47D3OewrsuJPYCl2
N24xmsdG3x2L4b7EvXrIs8ZOgHAcf+i5Ue00ZujtQXVAB6G5LSk44L+Bgl3M6nRu
A6FltV5RieigL1ahQjPA8peQ8PU6YkaeeCMhIbQhWeZD2MywVaoR8n3moOpXRt9G
tR6qVoZsu9exzPyMAxz6qYYXv0BozBZLzdhcOVhkIV7hYt4TiRrepufM/e639Zuh
N+q/4BTTyyJ7d57t059sFyNKu5cvyAi8lP5zd4Z2vxnArF5LGAdZLefve9RT0Z7Y
RG6QCXMUTGdyemR5SSycouPySpZtWozJPdblqg7vKNP4JcE1Vzv3E0BRGKdnE29O
7uZiZWb+/FXtmqRnrXWCJVPeFES+71NMIVe2mrbYBQGWfiK5re3Dm41L60a8UC8N
ilUpVKft7YURQQEXuNsP/IL0gjanyNRq/qD2Y5FsnT1j1aNgBAm7AIGTgRrstLWu
ddtWF1lQak5HHxX1j2u1Z2zzNlq2GT5QY415ZS8oL2PZiR7AcKY=
=j3Oi
-----END PGP SIGNATURE-----

--ye7hyns4bd3ezngs--

