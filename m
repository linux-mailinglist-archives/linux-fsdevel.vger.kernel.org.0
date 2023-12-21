Return-Path: <linux-fsdevel+bounces-6625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C9281AD04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 04:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46B0C1F24591
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 03:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBAD199D1;
	Thu, 21 Dec 2023 03:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="HINY7x7B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CD81802F;
	Thu, 21 Dec 2023 03:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1703128160;
	bh=eC4NraofFatu6EgrcpX+Ng78r0bAeuupM1IBexlD5Ys=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=HINY7x7BkBUHP9olDZg9BvZ7avlAArx1U47t/vMBnlm8bvXRPUqPOZGu4BP0calNW
	 +qP5WwTZ7m8A6P0Eq0SomxcbT3bjO6+HGgOP3fN8XBVcWzNmwFOfvjG7Sy7qSkxi95
	 UdNRo5p0d4TaG+0RL5UoMtpy5b0pXrCyKu3RtpYWkylfBHmzNcSw9W8ZERB9ODPDYR
	 omIHfyZXYy55TAZgy23srefzgvzBFACrKKO/7laPUDUgEnO8pbk/d/MzSRLofYJ8GQ
	 7GjOD2R6/n3A4BCOHdRplwqDvcVp2EjmqpFuxRRdwcDpkQxflvSW1R2lop763rEJCb
	 C6x+K8LGUIZTw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id E02471377A;
	Thu, 21 Dec 2023 04:09:20 +0100 (CET)
Date: Thu, 21 Dec 2023 04:09:20 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/11] splice: splice_to_socket: always request
 MSG_DONTWAIT
Message-ID: <b169b3bb105b4691b778ccb991f58853c95d106c.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7ll6ly7udayb4srv"
Content-Disposition: inline
In-Reply-To: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103-116-3b855e-dirty


--7ll6ly7udayb4srv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The pipe is locked at the top of the function, so sock_sendmsg
sleeps for space with the pipe lock held =E2=80=92 given:
	cat > to_socket.c <<^D
	#define _GNU_SOURCE
	#include <fcntl.h>
	#include <unistd.h>
	#include <sys/socket.h>
	#include <sys/un.h>
	int main()
	{
		int sp[2];
		socketpair(AF_UNIX, SOCK_STREAM | SOCK_NONBLOCK, 0, sp);
		while(write(sp[1], sp, 1) =3D=3D 1)
			;
		fcntl(sp[1], F_SETFL, 0);
		for (;;)
			splice(0, 0, sp[1], 0, 128 * 1024 * 1024, 0);
	}
	^D
	cc to_socket.c -o to_socket
	mkfifo fifo
	sleep 10 > fifo &
	./to_socket < fifo &
	echo zupa > fifo
to_socket used to sleep in splice and the shell used to enter an
uninterruptible sleep in closing the fifo in dup2(10, 1);
now the splice returns -EAGAIN and the whole program completes.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 fs/splice.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 9d29664f23ee..2871c6f9366f 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -869,13 +869,11 @@ ssize_t splice_to_socket(struct pipe_inode_info *pipe=
, struct file *out,
 		if (!bc)
 			break;
=20
-		msg.msg_flags =3D MSG_SPLICE_PAGES;
+		msg.msg_flags =3D MSG_SPLICE_PAGES | MSG_DONTWAIT;
 		if (flags & SPLICE_F_MORE)
 			msg.msg_flags |=3D MSG_MORE;
 		if (remain && pipe_occupancy(pipe->head, tail) > 0)
 			msg.msg_flags |=3D MSG_MORE;
-		if (out->f_flags & O_NONBLOCK)
-			msg.msg_flags |=3D MSG_DONTWAIT;
=20
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, bvec, bc,
 			      len - remain);
--=20
2.39.2

--7ll6ly7udayb4srv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmWDrGAACgkQvP0LAY0m
WPGBFg/8DcmEH0+8W+ZzRVYrjfTXuyoYUY7BMRekBTC+JG0lqAf4+BacV0cB1ckq
1Ke39FFciElW6WkZAGan2q9sp8IGIEKRfQEZlgY1iXloYa2PXZpWjfMay/fvAWaf
/IFmVYYs5+a5+4Tl424i4adE1+VQzqTA1UF6uxLmhGfQGhrIHUjOeS6OkfpQIhq8
JJvowap4FPJ2Hf2H1v5WmgHVOxGvKkUgbGH/wHSwnAvdaQm7L5YM5WIncBVl/JFx
5xGnnJhwCKNeF7VwauepX34psZsqLaQanGaY8HkkKp+xZt6v15puKl3Two7JAgga
WIJhI7ZfIyYrAjLM9aA/yJ0nObZjUM24tdgH5O+/GKFjbT6ImraTSmxP4MtWIJ6O
qjQn35qpQlwRCevoXvjGZm60M1howRho9TgoiKNyMdfE0qUkN7Ii2RDSQpgWtlZ9
7lz6aY4f83ZJDKqGp3CkqEIE38q5fbbYstk+LZURkETCD6Ca7sY/JAOP9xyzBEgL
Yo2W3qYqxIoVzw6K+MKiZbf90U1neq5vQDLy4/IZw5RAmJ5Lbr9zCabcd5JYvDaY
gmpJmQbIu2i5F8Dq/2d/FjIqYKFadLDeMyey4+DspLJBLCF3RdTum/UE4uOw35ut
+jn+TgkNM3YSJMa85bvpvNmKqnYW8F/Xqf6KwEPJcenQ+SdiES4=
=Gnc5
-----END PGP SIGNATURE-----

--7ll6ly7udayb4srv--

