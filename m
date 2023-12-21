Return-Path: <linux-fsdevel+bounces-6624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A3481AD01
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 04:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0321DB22025
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 03:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C775208D6;
	Thu, 21 Dec 2023 03:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="am0OQY2u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA69C1C6A1;
	Thu, 21 Dec 2023 03:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1703128155;
	bh=v1LDSBFECKp55cHcJgliRFwG+eK4aIOtUl+IUjCyXZY=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=am0OQY2uHQDPfoEgBreevZIYAovUOsivpLozXpHY6pDWjxDYLTNFj7NA0QFY2Vfx6
	 L/+q4JL2V27Lw/bDmDgn2EarKldnDeXiFRghJDXzVLw7ADErJaTDoVQv6YicHiC8kS
	 QRXkdMg5g3felN1IFwhEprDyplJ/m/QB5gBdiRDcKy5kOgcm16GOeUwGw/HF7SISk9
	 8W3AUt1HClvnSG5JqSMNiKlnkNorwtWjOiZo9IZMm1MouZvR8rFDfgptFyyYWSZsW7
	 njK2XgAtXofLjlKDiVQqFkCRtI9Oivf+FVruSRmFAaFPLgkqqnQ6bRc5VlVE2/cnyb
	 Mem/xPS8Kep7g==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id E2DA913D44;
	Thu, 21 Dec 2023 04:09:15 +0100 (CET)
Date: Thu, 21 Dec 2023 04:09:15 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/11] fuse: allow splicing from filesystems mounted by
 real root
Message-ID: <7a160b52d8fa53a9257a2383021a5279d2628edb.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ib5fcwvnutvdnkwo"
Content-Disposition: inline
In-Reply-To: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103-116-3b855e-dirty


--ib5fcwvnutvdnkwo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

FUSE tends to be installed suid 0: this allows normal users to mount
anything, including a program whose read implementation consists
of for(;;) sleep(1);, which, if splice were allowed, would sleep
forever with the pipe lock held.

Normal filesystems can only be mounted by root, and are thus deemed
safe. Extend this to when root mounts a FUSE filesystem with an
explicit check.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 fs/fuse/fuse_i.h | 1 +
 fs/fuse/inode.c  | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 463c5d4ad8b4..a9ceaf10c1d2 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -532,6 +532,7 @@ struct fuse_fs_context {
 	bool no_control:1;
 	bool no_force_umount:1;
 	bool legacy_opts_show:1;
+	bool trusted:1;
 	enum fuse_dax_mode dax_mode;
 	unsigned int max_read;
 	unsigned int blksize;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 2a6d44f91729..91108ba9acec 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1779,6 +1779,7 @@ static int fuse_get_tree(struct fs_context *fsc)
=20
 	fuse_conn_init(fc, fm, fsc->user_ns, &fuse_dev_fiq_ops, NULL);
 	fc->release =3D fuse_free_conn;
+	fc->trusted =3D ctx->trusted;
=20
 	fsc->s_fs_info =3D fm;
=20
@@ -1840,6 +1841,7 @@ static int fuse_init_fs_context(struct fs_context *fs=
c)
 	ctx->max_read =3D ~0;
 	ctx->blksize =3D FUSE_DEFAULT_BLKSIZE;
 	ctx->legacy_opts_show =3D true;
+	ctx->trusted =3D uid_eq(current_uid(), GLOBAL_ROOT_UID);
=20
 #ifdef CONFIG_BLOCK
 	if (fsc->fs_type =3D=3D &fuseblk_fs_type) {
--=20
2.39.2

--ib5fcwvnutvdnkwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmWDrFsACgkQvP0LAY0m
WPGvRQ/9E5gj/WEiFWxAunqfNfvbKfZZa64v0YdYbCCfwr8+fz0ixXjXXLxFxeLs
kRbAIE0nXfWcBZJ7PDcfWTbrT3Y0WkN/XeEelCnICGx+90Oko5t2wZEzf7EGanjy
3VjQHe4r5wF9Vb56AlLIMU46tiOQL9fDfdYhhZQjznU9SZ7jQ5a2UViRhNsTg6NL
8pmvC0nyWhuuDuxQE7ItI0GSvsnLXZDGcvHJZ+w/MHugB4LS31gqavLg38SlfKYM
EDjbJVKM6ptVZJMC/8EFbpgW4Eq8rIn0J2Q+8UvXUttJlSggWVbI9z769kOBh1Kr
uUOgoGa2sX4UlMkHvh/cyGPyu57Ek5zsFla09oAMhtLSjmVFoOMKWeZCeOdsCUyG
ifyX0vSM01L+6kl9Q0lbzWIKX158wkVO1xmP54hXp6JiZthDkMT1kMp44r/YH59S
uLuz5Y1BeHRUCBPdefSOnYPvcQCPtb+k4JWM6KsYufadKTm9j8Cgx0bkN/Xe4h1E
UyxT/In/W/phGlAXoU2WvY3A5TZuPFzOBXxO7OZbTb8R4czjiIyRSyNMWCP8lBDv
w66zDWE70k2MNVKqkr/cAs0bfQY/j6MSYPxYncs6XZc8i57E6QWc4JOb3DqPH4wq
RYvSaF0QJ/AlLGt4WuHOMzWVrLWl1Vll0QrvCa12VC4tDRPm3fA=
=FOXo
-----END PGP SIGNATURE-----

--ib5fcwvnutvdnkwo--

