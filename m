Return-Path: <linux-fsdevel+bounces-6123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 828B3813A3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 19:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D9D1F220F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 18:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C8168E80;
	Thu, 14 Dec 2023 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="QQwQ7kVs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4729518F;
	Thu, 14 Dec 2023 10:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1702579504;
	bh=2ssiVml4m8qqmo285KKEoUuoX6hT0FelEWEeDIquwac=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=QQwQ7kVsirDbfrc3qHB34GkO3GIFQTUF/vVWaXTL/s5rXafsrY3xyV9wYGYQw6HE/
	 ee4penYF7q4qAgMlMeUkYnDYfVtqNkPvfxpgAm7dd0HewSWdnH4LUcKglTmgoSaS0f
	 XIDSyCBKMi6S1fAjqdPtNgoDO6WjfMG/dlRUn1N+QD0EOGZiLN+MWnpBwJYpVOA4CT
	 DbRwvoAKPmKFmvxFpm+p/bHNtncRBSTw+2S+L5aaCDpYOHvtOu09tJOwycBNkRyspd
	 78rfnsknZQ+OLAhKmOl9E673CaExiP8CZCuqy994nyfaU/kBnZqUpkS+fSEahYSKn7
	 YJsxSs1dxmbKw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id D6DF413794;
	Thu, 14 Dec 2023 19:45:04 +0100 (CET)
Date: Thu, 14 Dec 2023 19:45:04 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Pengcheng Yang <yangpc@wangsu.com>, 
	Zhang Zhengming <zhang.zhengming@h3c.com>, Xu Panda <xu.panda@zte.com.cn>, Li kunyu <kunyu@nfschina.com>, 
	Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>, Suren Baghdasaryan <surenb@google.com>, 
	linux-kernel@vger.kernel.org
Subject: [PATCH RERESEND 05/11] relayfs: relay_file_splice_read: always
 return -EAGAIN for no data
Message-ID: <2329ea2aecb56e982f16aea7c637fd0e8a7985506.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103
References: <2cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r7skt7wykof2z2de"
Content-Disposition: inline
In-Reply-To: <2cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>


--r7skt7wykof2z2de
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

For consistency with the new "file->pipe reads non-blockingly" semantic.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 kernel/relay.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/relay.c b/kernel/relay.c
index 83fe0325cde1..3d381e94a204 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -1215,8 +1215,7 @@ static ssize_t relay_file_splice_read(struct file *in,
 		if (ret < 0)
 			break;
 		else if (!ret) {
-			if (flags & SPLICE_F_NONBLOCK)
-				ret =3D -EAGAIN;
+			ret =3D -EAGAIN;
 			break;
 		}
=20
--=20
2.39.2

--r7skt7wykof2z2de
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmV7TTAACgkQvP0LAY0m
WPGpIBAAtgSY2hCgLEKlAVjEfl1/tbiE3LuNlXrzoW7favgFzE8BZ6vY8XVnKgdc
cIZxw5f3ym3BxK48mh1d2rqxuW92seUTF4zAsIz82xt4DC+72FYH5rXQqrS7svZs
FvxSBpm6OduP5vib1Ef3kfXkE4kI2HzlkGOhyrmThQ7c9f8HTNu6HGcHtqZAMUGC
5jnukq361XsjFi+MxIais0Zc9SVW4P3sx4SM6lGosiCCwhg8AF1n8BFqn1X4tzSy
jLKxPqDytA2ngC/j9/A+SlkPK5TSxHpy+o95YDCxtQziSmrkoTDQq0/WdiE3Hjul
NK+z9kbYvbx0VX0cll6zBiByBlnn2EZ2LBlL0Hxj9PE2/ilISjwSYpn6kI+/CgPE
ylp2qkDcYeBrQ+BQefgivj0xM+zEnwSIOGIAnw4AT0L407X7QfKW2ZYfr29psds+
11B+eKjI2GsGXQleAzrRKHu1Ig3mXPR2W4L8N6o+HpvQenjbNB2KPOVAdcGVidNQ
0aVmKToGwBMTuyHcIayRmkuVr3qbIW+czzBnUebPORF3R0GdmkINBzsDXJPK+AZ0
ROUOG4WiITeauhl/wiBC/E6OvgPgBu0BvVc5VxNc3xusVdfI67APOZrw0MSqYAwW
leCU6koppIyQkl6fLzEq2IoOTkWXoiXr2IORy4N7YyzHjQrZXF8=
=CQg3
-----END PGP SIGNATURE-----

--r7skt7wykof2z2de--

