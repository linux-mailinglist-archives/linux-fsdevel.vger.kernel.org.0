Return-Path: <linux-fsdevel+bounces-6859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BB281D7E9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 06:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F0C1C20D20
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 05:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4100A10E8;
	Sun, 24 Dec 2023 05:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="aAOwHujo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4A2EBF;
	Sun, 24 Dec 2023 05:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1703394114;
	bh=hcGjNUWjUvKrg7W9sP+5Qf3cAGzvTS7z8iQNqmWoJVY=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=aAOwHujoZh8A8br2WcnveVFVVHZrmUqFKEiFz3ZvueLw1cv+Nhkmh6lG7MromTihE
	 zaNcru+0J6j8h75/bNzdmFU9LmG3owLRSXuGDKPLDxnxt5Lhi8XxYNgh0HU+NjRCun
	 s4kI0WhYqZIKpiwSP5WrdWH5C2oSF+hhmm8aEJdqB3cfE549aZjW7MnjNfdMulEjTV
	 V28w/uNF/O+hgwuSSCPMDRJ5HF/AQV+4OQANhSZv/PKVFumTBMTsG5QUItjt8EkwMS
	 AHvlJedggztRbSCbLmDKnaJtNBEyb+aE+Bee7H0HDiVB7FHKwwhDB9v9ELAQmxu4ph
	 9NewouF2HOMWQ==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id A5FBD1421E;
	Sun, 24 Dec 2023 06:01:54 +0100 (CET)
Date: Sun, 24 Dec 2023 06:01:54 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH v2 14/11] fuse: allow splicing to trusted mounts only
Message-ID: <7j2y6xumiqxpkpqlakrvoribzin73y2p2rokgryyahegjvwo3h@tarta.nabijaczleweli.xyz>
References: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tvyaxawsxvqayo5w"
Content-Disposition: inline
In-Reply-To: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103


--tvyaxawsxvqayo5w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

FUSE tends to be installed suid 0: this allows normal users to mount
anything, including a program whose write implementation consists
of for(;;) sleep(1);, which, if splice were allowed, would sleep
forever with the pipe lock held.

Normal filesystems can only be mounted by root, and are thus deemed
safe. Extend this to when root mounts a FUSE filesystem and to
virtiofs, mirroring the splice_read "trusted" logic.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 fs/fuse/file.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 20bb16ddfcc9..62308af13396 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3215,6 +3215,21 @@ static long fuse_splice_read(struct file *in, loff_t=
 *ppos,
 	return -EINVAL;
 }
=20
+static ssize_t
+fuse_splice_write(struct pipe_inode_info *pipe, struct file *out,
+		  loff_t *ppos, size_t len, unsigned int flags)
+{
+	struct inode *inode =3D file_inode(out);
+
+	if (fuse_is_bad(inode))
+		return -EIO;
+
+	if (get_fuse_conn(inode)->trusted)
+		return iter_file_splice_write(pipe, out, ppos, len, flags);
+
+	return -EINVAL;
+}
+
 static const struct file_operations fuse_file_operations =3D {
 	.llseek		=3D fuse_file_llseek,
 	.read_iter	=3D fuse_file_read_iter,
@@ -3228,7 +3243,7 @@ static const struct file_operations fuse_file_operati=
ons =3D {
 	.get_unmapped_area =3D thp_get_unmapped_area,
 	.flock		=3D fuse_file_flock,
 	.splice_read	=3D fuse_splice_read,
-	.splice_write	=3D iter_file_splice_write,
+	.splice_write	=3D fuse_splice_write,
 	.unlocked_ioctl	=3D fuse_file_ioctl,
 	.compat_ioctl	=3D fuse_file_compat_ioctl,
 	.poll		=3D fuse_file_poll,
--=20
2.39.2

--tvyaxawsxvqayo5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmWHu0IACgkQvP0LAY0m
WPFLwg/+LJchTpO7Ml5vKmTICDBgJxEwmFDAncwa3SnefMvNGccGKHTLsJPUQPN+
nrcfW47dJNAAlxtveEK6QyoyKbbUj1QX6kSFFnXW/MH+Y6IADaZJ+T6NGa7BjElt
ApvhiX0oym5g6PDv8RipSe3K4bvYmWXrb5yzraCO5JvpS8mvJ3ALlfuEW68d8/3o
ft2O/bq+xeNnSVaKSeo33u/d5QDDeXYKZ0EJy8RkMiw6kWxuEg+CB3EZ2dei6K6P
m8T3XiPFpBhAqno8pw+U/1XKivXOiD0E5hD1oXjMJWlNa5XwdSTVns0cIlkIOgft
TqsjuKvYwMi+JCmqJAp9kYVEXsdlMwOx8G1MtOoSYPPNwzlwTmTKY+pKqSe1h5vq
W70836rfMM+yFqEcw+b8XLJqAnFa6NVnaBpKvfcuQAtn+I4sJS4lOkYTSR2qzcMZ
NvTTI1y1pCwetLYxRl2N8McXExFzGMSNVRZx5OFDkvcm8rv9ATn3J62sN5+dVZH1
noU7yZ65MUaaaMGPEd4Losg8Ymg4PX1zB35mCEpXrplvsBhugtScPzT6+y7eLui6
6AGlDBD0JwU/VtthS15CEUrDyz+uULdP0XA8QGo+lblBhV5mTcDKfNAjFIHXDKHc
I/r+FrLN3Psb2Jh7sQjSGBqfJ6wJPqqCLArEMr/i7FUO6wOxF28=
=nRIb
-----END PGP SIGNATURE-----

--tvyaxawsxvqayo5w--

