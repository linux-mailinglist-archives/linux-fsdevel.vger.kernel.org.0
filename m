Return-Path: <linux-fsdevel+bounces-6617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1901081ACEA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 04:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA7B1F24541
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 03:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9556C122;
	Thu, 21 Dec 2023 03:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="TEAPKzrb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8639BA43;
	Thu, 21 Dec 2023 03:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1703128137;
	bh=1D/Y9tw4haAsoW32bBmlqxPIXSiFb95Jx1COnFxB8BE=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=TEAPKzrbGh/rmIZmTSBDQD0YPex0RlH5LAnlgnm2XRnDcZlcPFqXsdwpczOmz2YPy
	 7S/iyHyo92fgR1f1Ano8nsQHuBUsJkSrcOFI/60cy+VnSJ/1A/S70vldPUG7hnBXyd
	 K+/+9XpfGeXvEH7ELM1A5AGG+03D/lgwqFGvx10Jt4DaHHNzyGahdxlONGfaFni4uN
	 NXBdHLL+vi6pgfYDHhdd5lvJ84bT0Un+3M8OpIl5kCIhD1wNC2WLeukcmafu9+PwTz
	 Zzp9KqAFJsO9Wp7oF174uuBMGtEp+B4wnwtZonopTLPiKp4552LFR0pdXFAmqtu8Sh
	 +6QpItt1+GA8w==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id F0FFB13C50;
	Thu, 21 Dec 2023 04:08:56 +0100 (CET)
Date: Thu, 21 Dec 2023 04:08:56 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/11] fuse: fuse_dev_splice_read: use nonblocking I/O
Message-ID: <b6ae6cc54272011a24130723f3344616602ebb55.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bqkxrrmp6nnbaoyy"
Content-Disposition: inline
In-Reply-To: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103-116-3b855e-dirty


--bqkxrrmp6nnbaoyy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Otherwise we risk sleeping with the pipe locked for indeterminate
lengths of time =E2=80=92 since FUSE is usually installed with the fusermou=
nt
helper suid, given
	cat > fusedev.c <<^D
	#define _GNU_SOURCE
	#include <fcntl.h>
	#define FUSE_USE_VERSION 30
	#include <fuse.h>
	static void *fop_init(struct fuse_conn_info *conn, struct fuse_config *cfg)
	{
		for (;;)
			splice(3, 0, 4, 0, 128 * 1024 * 1024, 0);
	}
	static const struct fuse_operations fops =3D { .init =3D fop_init };
	int main(int argc, char **argv)
	{
		return fuse_main(argc, argv, &fops, NULL);
	}
	^D
	cc nullsleep.c $(pkg-config fuse3 --cflags --libs) -o nullsleep
	mkfifo fifo
	mkdir dir
	./nullsleep dir 4>fifo &
	read -r _ < fifo &
	sleep 0.1
	echo zupa > fifo
nullsleep used to sleep in splice and the shell used to enter an
uninterruptible sleep in open("fifo");
now the splice returns -EAGAIN and the whole program completes.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 fs/fuse/dev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 1a8f82f478cb..4e8caf66c01e 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1202,7 +1202,8 @@ __releases(fiq->lock)
  * the 'sent' flag.
  */
 static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
-				struct fuse_copy_state *cs, size_t nbytes)
+				struct fuse_copy_state *cs, size_t nbytes,
+				bool nonblock)
 {
 	ssize_t err;
 	struct fuse_conn *fc =3D fud->fc;
@@ -1238,7 +1239,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud,=
 struct file *file,
 			break;
 		spin_unlock(&fiq->lock);
=20
-		if (file->f_flags & O_NONBLOCK)
+		if (nonblock)
 			return -EAGAIN;
 		err =3D wait_event_interruptible_exclusive(fiq->waitq,
 				!fiq->connected || request_pending(fiq));
@@ -1364,7 +1365,8 @@ static ssize_t fuse_dev_read(struct kiocb *iocb, stru=
ct iov_iter *to)
=20
 	fuse_copy_init(&cs, 1, to);
=20
-	return fuse_dev_do_read(fud, file, &cs, iov_iter_count(to));
+	return fuse_dev_do_read(fud, file, &cs, iov_iter_count(to),
+				file->f_flags & O_NONBLOCK);
 }
=20
 static ssize_t fuse_dev_splice_read(struct file *in, loff_t *ppos,
@@ -1388,7 +1390,7 @@ static ssize_t fuse_dev_splice_read(struct file *in, =
loff_t *ppos,
 	fuse_copy_init(&cs, 1, NULL);
 	cs.pipebufs =3D bufs;
 	cs.pipe =3D pipe;
-	ret =3D fuse_dev_do_read(fud, in, &cs, len);
+	ret =3D fuse_dev_do_read(fud, in, &cs, len, true);
 	if (ret < 0)
 		goto out;
=20
--=20
2.39.2

--bqkxrrmp6nnbaoyy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmWDrEgACgkQvP0LAY0m
WPGhjg/9E8QVPqluCM2NJGxP23wLy/TPlUMg0v4WSYjaGNh5uu7KEYtTT59tkJcs
wNH5Vr7SOAO2y6VB9cYvGNcs1Ot02gsscXvoztxCsRq904eO3XROT/cjScBTtCO9
g19jG0qGc83NkmrAq6nKxYzsqzTClm/9A54p+JVph5Z2w1v2+jT5iPwvwP4k/qWn
wt7lPKn93nDpV6mo02VqYo95FK+KwIBgKP/2yT6BGvaqbJEEFf/2MDwagCOaIPaF
YXQCENkcFLjeL95U6R7cc/XeMeKGSnMPojFaJH4vuHe9EDIaxnWJ5JY2C/G5U4tj
p/GTjo6OlyQce3RVCSN9TyfwT/vzpn7bQ/atOZgc+3ykUXjSTF8ojNWiC5zfaGjq
xtR8vf/BXoW73aBRK3oa14hopGNlaka7XbjA7Z4fcboY4jdSELHDd5Zi+4f3+FVz
JTBB3AdQTazf4+vDvQhkTyzHfIZMcEnC5o8Y3qB2XCwIPeucrhKek2PyfvoktL9N
e64RYPYykI5oG8JqllJXF/J27ix8+63//3X3CjaOgs/0bHPIuqMLY+VsWL5fWVeH
U1cBoleUSobBzFVoBPZB9Fl0QO3OzNsuPRRiSN1kXpvnuvuqdUzzmwDq89cMXM37
ijIE+BfWKby0xmM2Ek/qxlkdWrMh/RkGKiJydOTARB+ApfePQYY=
=PUE9
-----END PGP SIGNATURE-----

--bqkxrrmp6nnbaoyy--

