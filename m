Return-Path: <linux-fsdevel+bounces-6622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B974D81ACFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 04:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB8F1C23D47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 03:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C0518646;
	Thu, 21 Dec 2023 03:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="WnvVBEoU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D4118035;
	Thu, 21 Dec 2023 03:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1703128150;
	bh=Jm7XzHnqDG9iwaDHGTe5ldutgziwWY+ScUPkOH8HCS0=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=WnvVBEoUJFMt79/ZV/pfyW1Dj4U9GOMXgiBmZdAw8p9y5MsOYMkGKNgVs3tq+RU6q
	 kGnfCNltQC7vfNESPY2wuggMkbwywOgPLzEnOk1DdWumqI+LIGHIr0QpVwln7sXyjB
	 lKQorhc2w9446jX2cHwSLOOu71JnHxShnnPyuhXTaZ8pvYdiQeRgdn1bj8E2c9kY5F
	 Fn6w3hCwRNqO0qeq2ZHQ45u+XzoiSBMDe/lVVvxBHuXNTfwGnlJfDohjOydzALdzpY
	 22tTHAkwi0hnuRAlEnPYbDsIC+ZZaBuZBmd7AmHAROo5cxShp3A7BwkHLstbwXqFc9
	 iIY5IRYM8cZiA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id CB40D13778;
	Thu, 21 Dec 2023 04:09:10 +0100 (CET)
Date: Thu, 21 Dec 2023 04:09:10 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Subject: [PATCH v2 08/11] tty: splice_read: disable
Message-ID: <4dec932dcd027aa5836d70a6d6bedd55914c84c2.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xhoon5hag52ewyt5"
Content-Disposition: inline
In-Reply-To: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103-116-3b855e-dirty


--xhoon5hag52ewyt5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We request non-blocking I/O in the generic copy_splice_read, but
"the tty layer doesn't actually honor the IOCB_NOWAIT flag for
various historical reasons.". This means that a tty->pipe splice
will happily sleep with the pipe locked forever, and any process
trying to take it (due to an open/read/write/&c.) will enter
uninterruptible sleep.

This also masks inconsistent wake-ups (usually every second line)
when splicing from ttys in icanon mode.

Link: https://lore.kernel.org/linux-fsdevel/CAHk-=3DwimmqG_wvSRtMiKPeGGDL81=
6n65u=3DMq2+H3-=3DuM2U6FmA@mail.gmail.com/
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 drivers/tty/tty_io.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 06414e43e0b5..50c2957a9c7f 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -465,7 +465,6 @@ static const struct file_operations tty_fops =3D {
 	.llseek		=3D no_llseek,
 	.read_iter	=3D tty_read,
 	.write_iter	=3D tty_write,
-	.splice_read	=3D copy_splice_read,
 	.splice_write	=3D iter_file_splice_write,
 	.poll		=3D tty_poll,
 	.unlocked_ioctl	=3D tty_ioctl,
@@ -480,7 +479,6 @@ static const struct file_operations console_fops =3D {
 	.llseek		=3D no_llseek,
 	.read_iter	=3D tty_read,
 	.write_iter	=3D redirected_tty_write,
-	.splice_read	=3D copy_splice_read,
 	.splice_write	=3D iter_file_splice_write,
 	.poll		=3D tty_poll,
 	.unlocked_ioctl	=3D tty_ioctl,
--=20
2.39.2

--xhoon5hag52ewyt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmWDrFYACgkQvP0LAY0m
WPFiew//X6BX8RJw1PY1eaEg4QYKwlhfsrT1c2vYhOzG2qdi/+UBCiIKur+G8zeX
XQrCVlQQPp040+qs1+vzKh70Bv6jH8cFM08Ma0cYP4s/OsUI9x709ghJbRrgQSF7
afEW5OxfmEInvQB+yqawARcZ8cPzRE45tJsMLzILK3UHC6ocn5MrsEkEmvmmiTBs
8w/HTKJ0yqw6gr8DAsQADHLYWqCVQdFbC96ImYhayezql9FsAwp7+eRIKYjV7h2T
Ar8HD8WYcJp+vqhlewFDiAdVknzB55rvqbljSf4W9S70X/Qpuud1ZMS9LjdqBja6
F78+8TWVhYt7o/rzRx7g1OFQUps1IRvQKaQ2sWgZWGRafGzAU9BOLvVT1VPeZfHL
Nl8Ha8z6NF+7iON0INpN1PeaN/Hi7Zzbddvqm/9UYB4e0UdI+Nim/ySrVIB8pHcr
prQbZb+mGMpYNS5LDDht5RQ8Wwi8xv3gxmDfnEBv17BjdSqjWVzgrf3ftMgw+21v
2VJiBWBi5fyuN0CE4pCfeFpKXUqC2dUsqOT62OLeM8hwcp9qGOyR2TLeVdSWtA2/
4vz14VZanQWXQn7r64u0+/9ALYd/eI8cpYjssTQ07bM8h7rvkD3CG3czymociekj
2C6AhPWMJWtRiizgRu0rBm4a7ySLJxvVRptpdgONhyuMKEo3wz4=
=e2Gy
-----END PGP SIGNATURE-----

--xhoon5hag52ewyt5--

