Return-Path: <linux-fsdevel+bounces-6121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 809E1813A3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 19:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E314282CF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 18:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4242068E98;
	Thu, 14 Dec 2023 18:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="P8ju0Sm3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7665211B;
	Thu, 14 Dec 2023 10:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1702579499;
	bh=4qtvhPDlYFbeuPt4vePPlt5K1o3kkOZ+MBZGGwh+FFM=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=P8ju0Sm3OMvOZtPNljKQPhXSyQMlfHEJtE98CO/ic0Ajw5eV+TDkGU0YSWCngB/rj
	 aeenL8AE0EG/+c6NzgDJDM7uPl97/ipRZkB7IvpMSpOmcnwwGnrNrJcQEGp0heUAXz
	 o5ivTEijg31QE7i9ynBuWG4JMqL/FLed/yHTx5oK6WwATt+jX1RqgmkYVrTZdPk5DW
	 2eHWCzVFfqO1a9ixMZlRCg8Hk/GegPSxe6S81hvwtpxW4Np6ZdLYQclS2jwoM+rk0Y
	 0diEBSA2uBsuSrKDe2CovEV9xHqdutsxMVtvPPPcnQ+C0nkfzgONxkxWz69Dmt8CIr
	 O/u7/8m+IR5Nw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 2811613792;
	Thu, 14 Dec 2023 19:44:59 +0100 (CET)
Date: Thu, 14 Dec 2023 19:44:59 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org
Subject: [PATCH RERESEND 03/11] fuse: fuse_dev_splice_read: use nonblocking
 I/O
Message-ID: <2b5c5b0a18a59ec31f098959e26530ff607a67379.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103
References: <2cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z34okndsbgotckru"
Content-Disposition: inline
In-Reply-To: <2cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>


--z34okndsbgotckru
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Otherwise we risk sleeping with the pipe locked for indeterminate
lengths of time.

Link: https://lore.kernel.org/linux-fsdevel/qk6hjuam54khlaikf2ssom6custxf5i=
s2ekkaequf4hvode3ls@zgf7j5j4ubvw/t/#u
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

--z34okndsbgotckru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmV7TSoACgkQvP0LAY0m
WPFH0A/+PdGoz95yW5jZpZej98hWG7cvUnL0HpsyecsebHNVXMw5OvhMvmYAGcJK
Cs8DfB2AfAhC8thPDzlAtyHDmSrJZvmQNsEi/EcY+Un8cuZPfFGAqtwL6zaLIU9F
Fogi7SpX5kV1gWD+l2moVog8darsv51Rvp7tq7/p9KTmZc/YRlmABGJH5ecnou3N
JM51BgB2ZGzOHOeP+chMUPfb9Pmo64FqpE+9IzByBVa/dZUwZMQcmsovCznp5KAj
+fWultaS54SJBoVLeyrRyCuZRtrpL3i4xY3SAkzniUERJGEewDjZFwKB07FcM3HO
caocryABxB0WBtKG36eR9FTQdDGpJV42B5PyMWT8aXSrzLX7qYogsa/nBxGIn53o
GAqr2/3Etx08RcaJM37cUvkGVuKyvJYWzZy2Pz2zNNpvyz8RhFVNGLaIRkMuG6Vt
X83iFKqD4MPzjZiTKuKvB+UofgdkxPnl2OtgUVGLHN0NVYhKtcrCBpUJhrbIksuc
8KTS3wCkzeqU5lfjbYHYHzWB9ehQ9mtB/JgLbdUQNNGjssH3iseC1pacxxmLEoZY
q+7TQooblaS7rzEoJ58q9ldXIEd4fUiMVe8pgcNT/8mbretPo8vNktnMPy04Y3bX
6e2734dikiU3aB2iOhKHOC+T8iVx6YxB2nhSRalgaCXPNNKoBgA=
=RIHh
-----END PGP SIGNATURE-----

--z34okndsbgotckru--

