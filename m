Return-Path: <linux-fsdevel+bounces-6618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1273A81ACEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 04:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9677C287883
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 03:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F18DDA9;
	Thu, 21 Dec 2023 03:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="BIL6JbTv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2771046B5;
	Thu, 21 Dec 2023 03:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1703128140;
	bh=rt0AEnnzw/E9eyte+sfYqKcDzKN6TKrOk/5CzjvNe7s=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=BIL6JbTvgXjrABthVY0jcMbCt19zMUjX4k54dfyXJIc/Y4RVTGC+gix4NQLV1c5Si
	 m75xgd9AhG5ESQDY10f/8CxmRNrT8/UczSC0W5zsHcSkJi3hp99ecCNWBvpEv8h1C7
	 3RVtyLsMkNskWwos4UWDLcqGyiGb6TyWBC75cpycTIZxbDtZL2x8RXuiNAU4N3xWyS
	 +zIOInw+oBlHINKWcGbIf06mRq1WcuHYIE3cIwdlWzi/jxIH1C6QP4EQEAKoKLJD2O
	 YnbRNbJTiv95+VS+56TJXpJJUAJPlCOWQeiEBTfHikSe0csefBFY629mK5XL0HWc1h
	 jmImqQTZPtOtw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 5352913774;
	Thu, 21 Dec 2023 04:09:00 +0100 (CET)
Date: Thu, 21 Dec 2023 04:09:00 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/11] net/smc: smc_splice_read: always request
 MSG_DONTWAIT
Message-ID: <38e20a4939603718232859ee2170f54d8bcd8ddf.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bmqh3eyp5rhgpey6"
Content-Disposition: inline
In-Reply-To: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103-116-3b855e-dirty


--bmqh3eyp5rhgpey6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Otherwise we risk sleeping with the pipe locked for indeterminate
lengths of time =E2=80=92 this meant that splice(smc -> pipe) with no data
would hold the pipe lock, and any open/read/write/close on the pipe
would enter uninterruptible sleep.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 net/smc/af_smc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 73eebddbbf41..a11a966d031a 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3248,12 +3248,8 @@ static ssize_t smc_splice_read(struct socket *sock, =
loff_t *ppos,
 			rc =3D -ESPIPE;
 			goto out;
 		}
-		if (flags & SPLICE_F_NONBLOCK)
-			flags =3D MSG_DONTWAIT;
-		else
-			flags =3D 0;
 		SMC_STAT_INC(smc, splice_cnt);
-		rc =3D smc_rx_recvmsg(smc, NULL, pipe, len, flags);
+		rc =3D smc_rx_recvmsg(smc, NULL, pipe, len, MSG_DONTWAIT);
 	}
 out:
 	release_sock(sk);
--=20
2.39.2

--bmqh3eyp5rhgpey6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmWDrEsACgkQvP0LAY0m
WPHWuhAAjBNRcDIE5tqe5dn6viHRf+J38xzJmiW1UeKuoS4vl73xjhxZ8+FP1MCO
/UYzkaGPyfeBZ1hvgvyG0Wtnoc48pO5/kcnzmPk1i1fS/C8ubR1U/6cTOTiTQXth
z/Idsc2ZDlIJzIem9vNNYshMJ/UFyQuBTl6X6j4SYWmOjjufrK6O+AWEyEywEApD
Cr2erQ7TMqpRIQy1DgraU9BWxXGQcGsUMe4yO04MyzJgpOcK6DgNcWedkuQLxcpA
4NuB/h8T7JF3wZ3fYsBXqB22u+Vi55yF3sC6hHqgmRKZU8pVfhfxZdqj4PctbLJ+
E4f1zju9PI2guFUqgbEYCdzHpN6InUoUa2niRCdHd7htscw9ohwibXEK/YKCdUfD
qgAtApWAJmPQ7xAo+SzvJDm2QMEL7Flfdcw91lsurE/IJ4JF9XgPHqtLNXV5zE9P
kbEkNQ5+DOG2oXdRHYDerSJfus7CuoDDap7148K7MrwWiU8elE6CstdgyY2TM9Ur
/vF8tCc8H31/ayTz9/aS2wyuwTFJJEZ4ks+pWocdRAk2JhMP21/LVmV98Kfs3+Pj
KhrUqjBUN03PAdoAsFFuaLYRaTr57tl0bO841WOxoE18kSw7lvUn5CT6/IdxvRhc
sreyrKQOARx2ElYMBh+RBq7vKzj4r1GQDY2hDJXesHB3jv+VT5w=
=Rvm3
-----END PGP SIGNATURE-----

--bmqh3eyp5rhgpey6--

