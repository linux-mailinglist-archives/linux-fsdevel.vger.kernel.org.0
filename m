Return-Path: <linux-fsdevel+bounces-6126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A9C813A4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 19:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788B6282FD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 18:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFBF68E91;
	Thu, 14 Dec 2023 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="N/WMy1GY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0808D4E;
	Thu, 14 Dec 2023 10:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1702579512;
	bh=8SccJBZdD6aVuGUXwvyxv46MttfctOjmM7x9ll4fJrw=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=N/WMy1GYhBqMQtyaK8cwvSxySt3AQyoSakF9rLNn/iXCBzqLaY6Gx6+A8KcCQvv5J
	 snP/AEZA+0N/NiLDcCyBcOAtEWNmIuUx6aMCFbfOSpMEFLHmYjcA1Ya+QP0EL5ZymD
	 vRBoWppY3Xhbn96WzNi4PoKiRsKtXuGBxyJ/GawKf1ktklPLVA8+btLH92qCV2NMDX
	 gGY4KaHQvSXsl0zVsFwYJa5MAfbaz4VNtDPouHcTdYCzXbYqXA9l+ZXF47QKv7iX47
	 4cx7gwZP2ko1pSazp5XgCA1XK84jiA8M1WWWjOi4LCT4AYQWFzz6wItyYGuk2ZWqvS
	 zOnez67wb8xLA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 4A9031398E;
	Thu, 14 Dec 2023 19:45:12 +0100 (CET)
Date: Thu, 14 Dec 2023 19:45:12 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [PATCH RERESEND 08/11] tls/sw: tls_sw_splice_read: always request
 non-blocking I/O
Message-ID: <20fffb097b4d2b328ef16e7353d6829f1ec9efcae.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103
References: <2cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="72rmbb73vdgn7njt"
Content-Disposition: inline
In-Reply-To: <2cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>


--72rmbb73vdgn7njt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Otherwise we risk sleeping with the pipe locked for indeterminate
lengths of time.

Link: https://lore.kernel.org/linux-fsdevel/qk6hjuam54khlaikf2ssom6custxf5i=
s2ekkaequf4hvode3ls@zgf7j5j4ubvw/t/#u
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 net/tls/tls_sw.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index d1fc295b83b5..73d88c6739e8 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2145,7 +2145,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff=
_t *ppos,
 	int chunk;
 	int err;
=20
-	err =3D tls_rx_reader_lock(sk, ctx, flags & SPLICE_F_NONBLOCK);
+	err =3D tls_rx_reader_lock(sk, ctx, true);
 	if (err < 0)
 		return err;
=20
@@ -2154,8 +2154,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff=
_t *ppos,
 	} else {
 		struct tls_decrypt_arg darg;
=20
-		err =3D tls_rx_rec_wait(sk, NULL, flags & SPLICE_F_NONBLOCK,
-				      true);
+		err =3D tls_rx_rec_wait(sk, NULL, true, true);
 		if (err <=3D 0)
 			goto splice_read_end;
=20
--=20
2.39.2

--72rmbb73vdgn7njt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmV7TTcACgkQvP0LAY0m
WPFXNw//bqWp3zjX6kgqvex9txAftjMPBVGK4DyG2w6suviic0vY8UgqI08Pnzln
CjHRLMogxUaDG9VCoYWPTvWXZPGDW3ZTd+KcqjLifFc+pqFaYVi+5YJuzykNlLme
U5qWkoJYfcs9IsCFZ4tb51rnWZhTqvQ48Fx1Od7xn8c7MUMwEWuoxdzF2PoVACmx
mtsEwej6W5FV4kdXZGMd9veB57urNZJf+qVJIVG8fyFOOZfYBDyZKeh5q6ZuBVa9
g/ZyDs68FZoQNaaWqGe1CpSuCEIotOg3rsQPP7QpKjUPy83RdCzM7sBJdvfQ5k5Y
xbPsF49h3yfqexL9RvQjcmqmF3WLUJ16IX2vc8CzSsEoJXRjOdJKb36V0Nh18CSK
S7mGyMnoT06Jn/9gqDl/hMUL1F6MYBjmd1ua1UfvRdazH/xc97NkwUJJb4nrm0ll
6giGRxqdWLcKAIsecGWAiqGC+zGfSDt87gUbhOMKDPfC60I5xY8kHg7DE/EoYLm2
idpYyeWUt8bFqxL1CinAYP31xr18W1JV/6oOeWrfHG/8MmfXfDJ6GKvtm+9lgDV6
kSSMnqlSxh47QFtN/s5G3+hohSbYtm0vwp7kEQQPXU7frjCHXBTKBcoXbqxRoPmS
tLcVXGhYyzLNUXe9VH6dzv1zMPOWLX05fhvlG0XxQlLW89BA2CA=
=jf9+
-----END PGP SIGNATURE-----

--72rmbb73vdgn7njt--

