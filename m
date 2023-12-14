Return-Path: <linux-fsdevel+bounces-6127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DBC813A4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 19:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EFD0282F7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 18:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C60F68B91;
	Thu, 14 Dec 2023 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="PH1S8/Df"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C68D6D;
	Thu, 14 Dec 2023 10:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1702579514;
	bh=+jS1MLjilnhxRPOp0kqbSSFP9DLnqgTL1iwYC7/xSp8=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=PH1S8/DfkxO1QyDe0AqWW8FTVsk0Kh+JAcJjokfuWmIJ1XIXS4j3UdhaddJCcs3Ns
	 XzQHOBgPOsF+JTRHOv6L4hkqJrJOnM6jtbRPn/8maHf1xjn8eHwqY3vurChFIUx8ll
	 FtTdKk96NeN/4TE84wdjzanPXyIUkzUsp+DAFoJtn1AGNqEhxw0WbTKZuI9EN/iUfZ
	 W5NljOKMiCWg8N4LE1+BZewiYPut6wykWkqZuZK5nUalpzFR+9RZsSxpIAv66cCS9R
	 EZ8uilAs9BmK1jMUUYzyC3QEsNQK3fFjGp4nIWiX+U2AVDn2Fh8NAlH9XXh4ywMKAL
	 wJTOwaCVPXV8g==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 52B9A13798;
	Thu, 14 Dec 2023 19:45:14 +0100 (CET)
Date: Thu, 14 Dec 2023 19:45:14 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RERESEND 09/11] net/tcp: tcp_splice_read: always do
 non-blocking reads
Message-ID: <2d44f2f64c18151d103ee045d1e3ce7a7d5534273.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103
References: <2cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6sgdahaz72uicyvq"
Content-Disposition: inline
In-Reply-To: <2cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>


--6sgdahaz72uicyvq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Otherwise we risk sleeping with the pipe locked for indeterminate
lengths of time.

sock_rcvtimeo() returns 0 if the second argument is true, so the
explicit re-try loop for empty read conditions can be removed
entirely.

Link: https://lore.kernel.org/linux-fsdevel/qk6hjuam54khlaikf2ssom6custxf5i=
s2ekkaequf4hvode3ls@zgf7j5j4ubvw/t/#u
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 net/ipv4/tcp.c | 30 +++---------------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 3f66cdeef7de..09b562e2c1bf 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -782,7 +782,6 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *pp=
os,
 		.len =3D len,
 		.flags =3D flags,
 	};
-	long timeo;
 	ssize_t spliced;
 	int ret;
=20
@@ -797,7 +796,6 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *pp=
os,
=20
 	lock_sock(sk);
=20
-	timeo =3D sock_rcvtimeo(sk, sock->file->f_flags & O_NONBLOCK);
 	while (tss.len) {
 		ret =3D __tcp_splice_read(sk, &tss);
 		if (ret < 0)
@@ -821,35 +819,13 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *=
ppos,
 				ret =3D -ENOTCONN;
 				break;
 			}
-			if (!timeo) {
-				ret =3D -EAGAIN;
-				break;
-			}
-			/* if __tcp_splice_read() got nothing while we have
-			 * an skb in receive queue, we do not want to loop.
-			 * This might happen with URG data.
-			 */
-			if (!skb_queue_empty(&sk->sk_receive_queue))
-				break;
-			sk_wait_data(sk, &timeo, NULL);
-			if (signal_pending(current)) {
-				ret =3D sock_intr_errno(timeo);
-				break;
-			}
-			continue;
+			ret =3D -EAGAIN;
+			break;
 		}
 		tss.len -=3D ret;
 		spliced +=3D ret;
=20
-		if (!tss.len || !timeo)
-			break;
-		release_sock(sk);
-		lock_sock(sk);
-
-		if (sk->sk_err || sk->sk_state =3D=3D TCP_CLOSE ||
-		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-		    signal_pending(current))
-			break;
+		break;
 	}
=20
 	release_sock(sk);
--=20
2.39.2

--6sgdahaz72uicyvq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmV7TTkACgkQvP0LAY0m
WPGANw/8D1YCIrVZ4bS0K0ryXlK1B+D+T4y2m/WOWKAApdw0Noli4oDhvaFjRX5x
p2NKG/bJNc2gk4H9HPvkhO3AOFKFDAPv9nMRbfaIvXgRBLI9EarZGZolTNBdYipJ
+Q7fHHBlqhKrrtIGWnpppqqElD4N/xD5QwCRDB+UnTcuyj4Pj1yJG0ZIcSgkg3th
OGqO5gyXZs4kxWHaVBhgCsfWt67WEhqZpmxi1Oyid8Ka06kkbU1KS1IeNujp8DKr
VIAchxFge51ljmYKZK6PSw/iassC2QPnMcasNZZYAVnTU5IZpMZMq+6662rIeH3W
1edAJZw8R4NHzmlfERNl8s7yaZ3y6fV+OJC9OoFdu/sQIaCimeOzKsZvBspJd69G
OG2AcfcKwDuKnjPiUM2m9hsWmLQ7vQhXIxDXs+U80WDvMuKqzKKwXM4uUWNjQjaf
27ftOG8zkI4c09WJe+Kj6e8OwKujNLXUmvyRSssFJLUvSmo18A1DeICqXXk8gTng
ugtQw3vq+89SM78KfiblW8ck2llVgOlRkrUbynw03eQ1SKF9N7Up3sN5DOgD21BJ
WuHgES2Ushzrp75tudATCZrSffsdw6uzuDmQRgeRNWHdcoWU8yHengVRgBLdqKBB
cQ2S1H1SexjjqJanjO7TLIZ5tPEKvcBgJGWXaaXj2rBntkyJc4k=
=XfJ5
-----END PGP SIGNATURE-----

--6sgdahaz72uicyvq--

