Return-Path: <linux-fsdevel+bounces-5652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6905180E8CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 11:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7D81C20B04
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 10:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B513B5B5B8;
	Tue, 12 Dec 2023 10:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="LJxubxPL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42C79C;
	Tue, 12 Dec 2023 02:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1702375953;
	bh=4W7u+rDADbbJkWobBhlJPUHFhHQq5S7vzstWfOqjssk=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=LJxubxPLaxOr7sailyjIGDn+LExkcMhhNvGORanAehnhW0OUH7vKXnHMX/aZRUBtp
	 pwgxidzvWNVMaboCG5E7BVf0/wlxXQnv1ANoTO0NkJAU5jYF2MXmUlOWFwPuJ4+lEu
	 Vs8Bs/hdpJd9wgWhGOagMgmb5jhX59JPPMOTD+E1f6Q3spcKsMWjpUNEsP2xL4uV4X
	 ShEYZQXpsUS3X9co4oU1wyXQs7mSBywQpoubPBOZzlK5HOiogOLpd0tUJrpnVsxPM+
	 Mobd/QpmVm9el7ZTVtFajy3et27vJjQWjosb8jVceoJzPmZEu3U4/PgC4wCwkZyoKQ
	 0wa9bYmXe4qIg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 8357512A76;
	Tue, 12 Dec 2023 11:12:33 +0100 (CET)
Date: Tue, 12 Dec 2023 11:12:33 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 01/11] splice: copy_splice_read: do the I/O with
 IOCB_NOWAIT
Message-ID: <19910c8026500ba43f3d93e66e822ae64980d9527.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3cvtmoaqsrgnkrir"
Content-Disposition: inline
In-Reply-To: <1cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>


--3cvtmoaqsrgnkrir
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Otherwise we risk sleeping with the pipe locked for indeterminate
lengths of time.

Link: https://lore.kernel.org/linux-fsdevel/qk6hjuam54khlaikf2ssom6custxf5i=
s2ekkaequf4hvode3ls@zgf7j5j4ubvw/t/#u
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

--3cvtmoaqsrgnkrir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmV4MhEACgkQvP0LAY0m
WPF9Cg/9EffrwGSBBwc94UVX9562toxZU0cTfGiMv1uKHdSNskGZYRfejpTiN74p
n9uDBaV4gmogC62cBg8Z/mQgwjMsOkuWw+6c4JyfR1CSVSOIyBcuDxcMRK8nz5qB
YTKOOiYM3/agWDeDMPp3c5EORR8chn6zq/x9EIySRaOO35WPaBuIGKtg3NAI3Msn
HMVEYidGQjTVbi7mCO9rij6XLh8sWOEJQ1NvURp2Jh/K53Vyuqn9BuiGm/WKf3uI
tBsXci0eUYHndhHFVs9S0TxS6aDqGXuPfKZBb+JlMCDTJIeSceTMFJNvjJ6jrpSM
BT0cD0FAcVDDXhZ7+q75zm7Ha7Vu0V4CAFbMKcYbiFjkudcN5XHLLILHB4qwSEfE
yn7DKo/6llYuykrTWZDn0myZgMRb3mtajqzXLc2zeS0gaKvKaQxZDOQBDmoBRS74
1xKTN+hwAC46Ryo8Memut4QWb5bBmElKlDL3c0flqBHLwHzxb77sSckSs81Bixgi
RSGr0fUP1hhzPQ2B0Ikb1I+KlwP12SzcNcc0cSxrEI2WX6buD3enTQiD3aV+ghku
Jp2Fecr99J/KmKjRzbjjmol9Zb/b3tKySzUQGKSWw7O8Xl/v9w19vzS46ETSkcYj
VKnQkRRfMGT92EZyH5WnhKkQK6zwgRn+mOa9jVnPs13B0fiH8M8=
=EBxL
-----END PGP SIGNATURE-----

--3cvtmoaqsrgnkrir--

