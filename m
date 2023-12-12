Return-Path: <linux-fsdevel+bounces-5653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D5480E8D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 11:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3F1B1C20BC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 10:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2CF5C061;
	Tue, 12 Dec 2023 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="pw6XLXic"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E900DD9;
	Tue, 12 Dec 2023 02:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1702375960;
	bh=g8iY2h+KeEWIRzD4R4jVgCFkjuQjTUqXcpcOACu7ias=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=pw6XLXicnVg0zWWuIVngs44b7T+SOpKSunQd3is3IrR5tTKNZGmmpy9Yx+FpMDau2
	 cswcXbe/DwtzyXjJ+tsb28zfFjJK40Iagqxp7u28lPMetPsSmwb63ZA20QwbbfQcNC
	 1k0IDx5QViMTv8h4bi6fAsRvvZS72h4dxPOeXt98Tm9bDl0Cym1lH1o816JxSA9I++
	 8GvhgjNnVLmKvxlOyFe6kCepgsv7GxaCp8nhCRwoR9mqZWwfd5vbDJ0Za2h4WJ/TRb
	 /2gpXn0nQM+Fi0SFzksbTGyToscNDeoEp/OTc4I3AU7OSyc70MKx48A2Kzna+oVM2J
	 7/f4EQb0B60gA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 5A2A912A7A;
	Tue, 12 Dec 2023 11:12:40 +0100 (CET)
Date: Tue, 12 Dec 2023 11:12:40 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 03/11] fuse: fuse_dev_splice_read: use nonblocking I/O
Message-ID: <1b5c5b0a18a59ec31f098959e26530ff607a67379.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c6tynwv5x5dyuh4x"
Content-Disposition: inline
In-Reply-To: <1cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>


--c6tynwv5x5dyuh4x
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

--c6tynwv5x5dyuh4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmV4MhcACgkQvP0LAY0m
WPEj+A/+N0AmpH2RP6YlzkjfUWBbbwk04r4Kt2Y5qTL4VYmxKV2oZrtWgxGgi9ku
4eNXhny1R3F9yqovwQXQGPSMHPMfbHR+ggMeY6K+prItZKRmCrMSdoXwEl+4Fp8S
LMb6s1h5DCkJh95bjJAgDrlEJPnKWbRPtxhPBbJQ0asAYmRnOJ0w0LOFOgk5opi0
jwA+sG5TaIYGl4SCJY1fyUFBaQJxaaV+d//BGf8545m6Eq5maBSxE1YEtz9rJI6g
tKqUJh0cMB44wJSeML06LxWOswgW2iuCfce5ReoXHoLBqFuJRjxL3WUW+AAszua+
V08khpYZrT0X5Mp7B5oXKHjqDK8qOGY4ZyxmfGmMZvAHZsoJv4qdxsB9DCmuNRfF
2qx+dBXwbiUXkR0wKwH8ItfSLCso4gTL8LjaE+aN4C25zVWDbjUwAfj/pEMQImwL
JRCva7NGBTG7sRo0ABbAsXPrL9h6AW/ParE6uEuOQlNaj7tEDEQN8IcO+v/Xk67m
Wh77SaYkLGQV4T3UZF0gzjiOZeTqP4DO9C28HNvTGJT9OiOsMIHUUf/ko7UBo+Fs
ZlptXlT2gJ7s1S+ONVTxerxcOZhdW4jW6LiOtm0j6n18E5MDdrTMPnN5LgoZRcIx
Z+0V4zb2qv7QALW//GnmehymjhUJb/Kh7vRenFtQRvpOzUBoq+c=
=ANlq
-----END PGP SIGNATURE-----

--c6tynwv5x5dyuh4x--

