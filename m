Return-Path: <linux-fsdevel+bounces-6620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9071881ACF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 04:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22E81C22E3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 03:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A519156DD;
	Thu, 21 Dec 2023 03:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="hrXydvLU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A5011C8F;
	Thu, 21 Dec 2023 03:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1703128146;
	bh=qAmWyUoU8YkxZBfMhksVxnOF3K/+1yNv2stDp0bUYaU=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=hrXydvLUYIdw/FBFstYDD0jtvpmYHx7nxxp9isDfxsq73gon5fgyFx5bfxnW3/Avt
	 TRS26FntbCF27nt03x2dC7y8lqLSb8Wb9/KZ28RgGNo2I2EespxvKECab83zycPPAO
	 SRSk37HAGLPApY/QUvIqy67G4DmZvN0nFAEeea0qmhYUYPtIJ3s6Ep7PFj0Kz0x/ul
	 SQ3Rx+4PZnCnNpbibiFfc/jBNw9C8+Lz8aDRL8fcTbFUwr45cnLqEBEzfEolTEsuwm
	 frH/s4dgzX1JbwALRgvlMANY91NuJV4w6tAP8xYVCtRzlfeYKZkCAEa85Hl/MMO4kl
	 P60Bb3mQsTUcg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 10E8D13DB2;
	Thu, 21 Dec 2023 04:09:06 +0100 (CET)
Date: Thu, 21 Dec 2023 04:09:05 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/11] tls/sw: tls_sw_splice_read: always request
 non-blocking I/O
Message-ID: <f14a9bee9658d8aced8cd0a951bbc962c6a7bd5b.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ol5qyjq3wpi4gz2a"
Content-Disposition: inline
In-Reply-To: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103-116-3b855e-dirty


--ol5qyjq3wpi4gz2a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Otherwise we risk sleeping with the pipe locked for indeterminate
lengths of time =E2=80=92 given
	cat > tls_sw.c <<^D
	#define _GNU_SOURCE
	#include <fcntl.h>
	#include <unistd.h>
	#include <sys/socket.h>
	#include <netinet/in.h>
	#include <netinet/tcp.h>
	#include <linux/tls.h>
	int main()
	{
		int s =3D socket(AF_INET, SOCK_STREAM, 0);
		struct sockaddr_in addr =3D {
			.sin_family =3D AF_INET,
			.sin_addr =3D { htonl(INADDR_LOOPBACK) },
			.sin_port =3D htons(getpid() % (0xFFFF - 1000) + 1000)
		};
		bind(s, &addr, sizeof(addr));
		listen(s, 1);
		if (!fork()) {
			connect(socket(AF_INET, SOCK_STREAM, 0), &addr, sizeof(addr));
			sleep(100);
			return 0;
		}

		s =3D accept(s, NULL, NULL);
		setsockopt(s, SOL_TCP, TCP_ULP, "tls", sizeof("tls"));
		setsockopt(s, SOL_TLS, TLS_RX,
			   &(struct tls12_crypto_info_aes_gcm_128){
				   .info.version =3D TLS_1_2_VERSION,
				   .info.cipher_type =3D TLS_CIPHER_AES_GCM_128 },
			   sizeof(struct tls12_crypto_info_aes_gcm_128));

		for (;;)
			splice(s, 0, 1, 0, 128 * 1024 * 1024, 0);
	}
	^D
	cc tls_sw.c -o tls_sw
	mkfifo fifo
	./tls_sw > fifo &
	read -r _ < fifo &
	sleep 0.1
	echo zupa > fifo
tls_sw used to sleep in splice and the shell used to enter an
uninterruptible sleep in open("fifo");
now the splice returns -EAGAIN and the whole program completes.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 net/tls/tls_sw.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index e37b4d2e2acd..3f474deed94d 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2157,7 +2157,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff=
_t *ppos,
 	int chunk;
 	int err;
=20
-	err =3D tls_rx_reader_lock(sk, ctx, flags & SPLICE_F_NONBLOCK);
+	err =3D tls_rx_reader_lock(sk, ctx, true);
 	if (err < 0)
 		return err;
=20
@@ -2166,8 +2166,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff=
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

--ol5qyjq3wpi4gz2a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmWDrFEACgkQvP0LAY0m
WPG5yBAAiSaEIPGtJWTxMcMY0+EBT2H2t4VUmUJY/LDInj1PKpoOfALLGu5pWbmQ
YTVboZCg+8LuhF1QENmND/uqQde8kDs5fxsH+4AslkjhonKQe7EB4PDOfuM4lYbS
BUJce2K4XxZw2EYadWEK9Y64b7aqZEC7eU/KF6RFn1KbN1jsI4HCwuzK2iiLIrAK
MWOvkOcumfldoRnpY+/1HNa4HDO1OV0zmLh+kI1spW+m633L3aDNIkKfx5Oj+t8R
h/XHNHV9Kd4NF7B9UQcvnmtZhOZaWDrbiKBbdIckZKvH/Lxikd5X2tlnbEn/AGg9
++12+Pni38KjYuVQiPtIslY36nmb6FgItrNtoVcuIV1Y7H9PwR/PKPudhQypzp98
5zz3O/sNGT90/ijkml7ogMVvxQ+lOi2LTQjyvghqn7elfSrEShq2cXLSPHP6OxJx
g+urvgQqBA8CgLAL8FF7cqkypBUnK30l53iyAW+yCDJcu/aP4Ic/5csNoNsAF/f0
ldLitD0a9ycWqU4zvc/yK3cS/2EAWAYFoMIeh3ADfX1IHHDTArU8Eoo45/gbLA9T
FKETvEq9TnnnkCBznidKcJ2iD23EBx7Yp+pmhlH2mvhnugq38auiN8UnIddAteDh
WQqdpqxOq1dDNRaOUSwX2BVknuVYfg3p+5iWlTavMh2K9dECYxo=
=qGBH
-----END PGP SIGNATURE-----

--ol5qyjq3wpi4gz2a--

