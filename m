Return-Path: <linux-fsdevel+bounces-6860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B462481D7EB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 06:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426CF1F21B5D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 05:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA47139A;
	Sun, 24 Dec 2023 05:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="jHk9hGJB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4D2EC0;
	Sun, 24 Dec 2023 05:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1703394109;
	bh=8JqjLYgVpBXyZxmwMpSVDZbE1TJ3MF+mAG3wx6Uw9pQ=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=jHk9hGJB5O3WI8fjG4cLk3aQJtGC+pfA0r0KZO3OH1sUKU5kWEp0+fh4OVGlfMtMi
	 K+dlbxT25iY5MS+SPpD5IRmF3TuTU5vo46Y7bjzBts7Gaa2eju425b80QL8d95XKMV
	 oEuAasy7V3VjGivCeoLyhnKCyfHJg5L4ELNjAlhFJ23qlJyETRTimLl7C3AFplIvhQ
	 ZThiJDSm9GP4nb092DACHKBbNcYOH2qplLF8TQK1WM0k1TkYiNgSfG8Hqj7z7edvM3
	 WmaxrW+zaE82xLkdKCiTbbDiYZiIPXeePzmmh2nMnt1e7a0vNaYkPsV1eIHw3+98OC
	 YyXAX7hZgbESA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 5AE9E1421C;
	Sun, 24 Dec 2023 06:01:49 +0100 (CET)
Date: Sun, 24 Dec 2023 06:01:49 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH v2 13/11] tty: splice_write: disable
Message-ID: <fvxufyqixohx65lcusrkkfoxs5cnlsuv7kajv6bnngcoewsodx@tarta.nabijaczleweli.xyz>
References: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k5qljftky3o4rq3i"
Content-Disposition: inline
In-Reply-To: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103


--k5qljftky3o4rq3i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Given:
	cat > ttyW.c <<^D
	#define _GNU_SOURCE
	#include <fcntl.h>
	#include <stdlib.h>
	int main()
	{
		int pt =3D posix_openpt(O_RDWR);
		grantpt(pt);
		unlockpt(pt);
		int cl =3D open(ptsname(pt), O_WRONLY);
		for (;;)
			splice(0, 0, cl, 0, 128 * 1024 * 1024, 0);
	}
	^D
	cc ttyW.c -o ttyW
	mkfifo fifo
	truncate 32M 32M
	./ttyW < fifo &
	cp 32M fifo &
	sleep 0.1
	read -r _ < fifo
ttyW used to sleep in splice and the shell used to enter an
uninterruptible sleep in open("fifo");
now the splice returns -EINVAL and the whole program completes.

This is also symmetric with the splice_read removal.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
It hit me that I should actually probably exhaustively re-evaluate
splice_write as well since re-evaluating splice_read went so well.

fs/fuse/dev.c:  .splice_write   =3D fuse_dev_splice_write,
drivers/char/virtio_console.c:  .splice_write =3D port_fops_splice_write,
locks, takes some pages, unlocks, writes, so OK

drivers/char/mem.c:	.splice_write	=3D splice_write_null,
drivers/char/mem.c:	.splice_write	=3D splice_write_zero,
no-op

drivers/char/random.c:	.splice_write =3D iter_file_splice_write,
drivers/char/random.c:	.splice_write =3D iter_file_splice_write,
AFAICT write_pool_user is okay to invoke like this?

net/socket.c:   .splice_write =3D splice_to_socket,
already dealt with in 11/11

drivers/tty/tty_io.c:   .splice_write   =3D iter_file_splice_write,
drivers/tty/tty_io.c:   .splice_write   =3D iter_file_splice_write,
they do lock the pipe and try the write with the lock held;
we already killed splice_read so just kill splice_write for symmetry
(13/11)

fs/fuse/file.c: .splice_write   =3D iter_file_splice_write,
same logic as splice_read applies (14/11)

 drivers/tty/tty_io.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 50c2957a9c7f..d931c34ddcbf 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -465,7 +465,6 @@ static const struct file_operations tty_fops =3D {
 	.llseek		=3D no_llseek,
 	.read_iter	=3D tty_read,
 	.write_iter	=3D tty_write,
-	.splice_write	=3D iter_file_splice_write,
 	.poll		=3D tty_poll,
 	.unlocked_ioctl	=3D tty_ioctl,
 	.compat_ioctl	=3D tty_compat_ioctl,
@@ -479,7 +478,6 @@ static const struct file_operations console_fops =3D {
 	.llseek		=3D no_llseek,
 	.read_iter	=3D tty_read,
 	.write_iter	=3D redirected_tty_write,
-	.splice_write	=3D iter_file_splice_write,
 	.poll		=3D tty_poll,
 	.unlocked_ioctl	=3D tty_ioctl,
 	.compat_ioctl	=3D tty_compat_ioctl,
--=20
2.39.2

--k5qljftky3o4rq3i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmWHuzoACgkQvP0LAY0m
WPFo5xAAr2aMvf/GnD9FPas8XlNZIMRIyccAYSzpCdA84vG2bZcAOWYLbp9yhoJ1
mQIB2TWxX4+uNx260cP/sMqXakJdV0V63yHCn9mkD/YSWMnqedcqDK3V2Ir2YTj1
x1Aiu/j7UjDUR9GieB5USUWpnJrqJhDUu8We/E0kAFHyct1MRQY4LGVhr/0tjNQQ
wQKmzBAo7C13UPbZ7qmKFWpo04PTAN5reHIPrJBWy8ca5PjuiyAn6GBpQ3QXvfio
xNEw9RlzS85nxEkk5T+5HfKEkdXQFh6df+6CIHjNCXeE9T0JChBpQEpm9eca23vE
IYeZzHCpajLc75SQMqhW3cS5uauDkqdr1WqDQviJ19S+jQk4BqRjpVtgq2KTnCWu
V0y6EJ41PfKjkt4WWQIOF6uzT/bLzXieEQffk5NtvnCa9gBOlYgNNBEjNQAxD2ur
+yDbgNbejfTvdBIecz5xk1s3nHxsgwifOnUjcBIb9nn7uFghL9H32x511rz7jvbc
MwgjQaSmoRzM45RDWwPUvVCsNxLUHkIADrdtF1hpDIyoNZxDOlWK8BnPgT+p9PAG
QOMjJxq7+pc/9I2b49rUFqOnHxoJbSn9A35CUpbEKukyUPd8PIMJRr9mno/NXxYY
nmcQvapAeQujR15EXMAQfxAbPRZdp2lN2vBXxYvKzBVesMij2b0=
=ziYk
-----END PGP SIGNATURE-----

--k5qljftky3o4rq3i--

