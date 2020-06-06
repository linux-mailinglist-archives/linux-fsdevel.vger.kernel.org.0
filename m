Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918291F0729
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jun 2020 17:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgFFPCP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Jun 2020 11:02:15 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:55040 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgFFPCP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Jun 2020 11:02:15 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 8D9E81C0BD2; Sat,  6 Jun 2020 17:02:13 +0200 (CEST)
Date:   Sat, 6 Jun 2020 17:02:12 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>, trivial@kernel.org
Subject: [PATCH] fs/userfaultfd: No need for gotos
Message-ID: <20200606150212.GA10177@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

No need for gotos when all the target does is return. In this case it
also avoids redundant variable assignments.
   =20
Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index e39fdec8a0b0..860db4fd28dc 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1883,12 +1883,10 @@ static int userfaultfd_api(struct userfaultfd_ctx *=
ctx,
 	int ret;
 	__u64 features;
=20
-	ret =3D -EINVAL;
 	if (ctx->state !=3D UFFD_STATE_WAIT_API)
-		goto out;
-	ret =3D -EFAULT;
+		return -EINVAL;
 	if (copy_from_user(&uffdio_api, buf, sizeof(uffdio_api)))
-		goto out;
+		return -EFAULT;
 	features =3D uffdio_api.features;
 	ret =3D -EINVAL;
 	if (uffdio_api.api !=3D UFFD_API || (features & ~UFFD_API_FEATURES))
@@ -1899,20 +1897,18 @@ static int userfaultfd_api(struct userfaultfd_ctx *=
ctx,
 	/* report all available features and ioctls to userland */
 	uffdio_api.features =3D UFFD_API_FEATURES;
 	uffdio_api.ioctls =3D UFFD_API_IOCTLS;
-	ret =3D -EFAULT;
 	if (copy_to_user(buf, &uffdio_api, sizeof(uffdio_api)))
-		goto out;
+		return -EFAULT;
 	ctx->state =3D UFFD_STATE_RUNNING;
 	/* only enable the requested features for this uffd context */
 	ctx->features =3D uffd_ctx_features(features);
-	ret =3D 0;
-out:
-	return ret;
+	return 0;
+
 err_out:
 	memset(&uffdio_api, 0, sizeof(uffdio_api));
 	if (copy_to_user(buf, &uffdio_api, sizeof(uffdio_api)))
-		ret =3D -EFAULT;
-	goto out;
+		return -EFAULT;
+	return ret;
 }
=20
 static long userfaultfd_ioctl(struct file *file, unsigned cmd,

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7br/QACgkQMOfwapXb+vLuTgCffgDHCTwERlN7JJzHjLRblSPS
TM4An38anrr/xa3XKIWoa6RPCX/AxW3S
=ixQe
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
