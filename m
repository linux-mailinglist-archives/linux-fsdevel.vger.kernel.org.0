Return-Path: <linux-fsdevel+bounces-6615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C7081ACE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 04:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544F91C23BEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 03:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2608828;
	Thu, 21 Dec 2023 03:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="ediueyH5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7224404;
	Thu, 21 Dec 2023 03:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1703128126;
	bh=ybIdi0gMPgMmtj3200db5CwiLm00xeI7NHXtjlFkAIo=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=ediueyH5QEM2+HRkyZx4r28DFAwiicXxhNwbwe+bf/itVrncIEDncK2IBL+WyxqsB
	 WYQZaksBXFw8HKQyinNsue1UzUlAJDZmTfXW3mK7LckZfT+NZFPGKsAzVIubWuVTSa
	 7oD6Jr1u+OWvSjYK7r7jriaN6hUqfLfDexIcD8DNn8GVIRaAc9cOlpp9AkMzp8pq1+
	 gS/DzMM8Yl1z8jnWZLBE4McHEy+z4IqXKZayA/MANTXJvVGkWsdDD1wvykD9aKpfl4
	 ApOnk0BTRUEP3hXTrOlt6irzt2KC1KVqJdYwmzxYjErRDb8nhu0cnKgfT9yPNhmIdh
	 /zoRAlkZpkvaA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id F318313DAE;
	Thu, 21 Dec 2023 04:08:45 +0100 (CET)
Date: Thu, 21 Dec 2023 04:08:45 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/11] splice: copy_splice_read: do the I/O with
 IOCB_NOWAIT
Message-ID: <d87ac02081f2d698dde10da7da51336afc59b480.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w6med5uoq7ajniqd"
Content-Disposition: inline
In-Reply-To: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103-116-3b855e-dirty


--w6med5uoq7ajniqd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Otherwise we risk sleeping with the pipe locked for indeterminate
lengths of time =E2=80=92 given:
	cat > udp.c <<^D
	#define _GNU_SOURCE
	#include <fcntl.h>
	#include <sys/socket.h>
	#include <netinet/in.h>
	#include <netinet/udp.h>
	int main()
	{
		int s =3D socket(AF_INET, SOCK_DGRAM, 0);
		bind(s,
		     &(struct sockaddr_in){ .sin_family =3D AF_INET,
					    .sin_addr.s_addr =3D htonl(INADDR_ANY) },
		     sizeof(struct sockaddr_in));
		for (;;)
			splice(s, 0, 1, 0, 128 * 1024 * 1024, 0);
	}
	^D
	cc udp.c -o udp
	mkfifo fifo
	./udp > fifo &
	read -r _ < fifo &
	sleep 0.1
	echo zupa > fifo
udp used to sleep in splice and the shell used to enter an
uninterruptible sleep in open("fifo");
now the splice returns -EAGAIN and the whole program completes.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 fs/splice.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/splice.c b/fs/splice.c
index d983d375ff11..9d29664f23ee 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -361,6 +361,7 @@ ssize_t copy_splice_read(struct file *in, loff_t *ppos,
 	iov_iter_bvec(&to, ITER_DEST, bv, npages, len);
 	init_sync_kiocb(&kiocb, in);
 	kiocb.ki_pos =3D *ppos;
+	kiocb.ki_flags |=3D IOCB_NOWAIT;
 	ret =3D call_read_iter(in, &kiocb, &to);
=20
 	if (ret > 0) {
--=20
2.39.2

--w6med5uoq7ajniqd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmWDrD0ACgkQvP0LAY0m
WPERzw//fQqEHfIMs2zy1REUwi6S7TEe95nkL+8f5Xe3G0lCCSw6p9aKhVPKYzCa
QYZBq5RfYuMPmp8atJfmK+qj0Ku1XBUyha3qoVENEUPCYUnK2FAzz+hdXRfEkclu
fsD3oK0LalXC7vEA14px41dTWzWpSbM24wfsrzAqJURR1h/GX43mMCQJG4AW0ZRx
PZYWty6Qy0cfc9br29M3HNOrQQBDJyhvE5+Bgm0TJNNg73DLkwAfzj93ATnGx7zF
dYzd3bg/C1JQ+ImoqrJf8ADypkHrWTxi0L17OZyck+N0XrolkEp3YDKxcPMkVmuC
WijDI7lSca26Z1SNmHRHZxkbXTc2K1vQmZqFZh8bYfCVWdfpUkmSdz+wQ4p2BrgF
4d9rwFPcdW3TI0GIE/cGDOlr9Uz5aifCzc6P6YSTltOXb7L2jQqJ14q4uqWKwJ86
YhYsBi+ZOwkIdIaTJyQ9gfdcDz+o0thTPrVVxHVILxBa4rAImPUvtdWNDoZQcFAn
Jy+tfpk2aLgSlgY8d9svq7IKAgGX+AKsKtzWQEkWUtV9Gb+cZcA4ZAZ5LNmwiofH
PbELxyFjXWP2Dd3Rs6huMY7cM6hsIY5DZcx5ZzlbMD/CX8RYC9XEj/e9n72MZ226
Yz+LWwBY2cEDrY2gEwl12GM1PQAF2QZeAVcGkfhJdknDCb9gWGI=
=kVSS
-----END PGP SIGNATURE-----

--w6med5uoq7ajniqd--

