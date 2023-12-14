Return-Path: <linux-fsdevel+bounces-6124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B323813A44
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 19:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CA41C20CC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 18:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1716668EA6;
	Thu, 14 Dec 2023 18:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="oyywvtgX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0DF191;
	Thu, 14 Dec 2023 10:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1702579507;
	bh=PXy1R2vwiW8A+KWASBw8dr5/DmcBJ0IEf3dFC85mQcY=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=oyywvtgX6oB4Loxdmd/EoU++8RV/IElw8VF3Jy+1ZdFZhJ6d573To1kXtbm6XaZrf
	 6+GeDpcK8oRxScDdXUiFqwABUMekRu4SnvSlM4J9scZMnPHJeDSf+S6UmrU0HKMzww
	 +d2AD00EGLyCdS4STW5c0WrmXDNzL7mHOCc0eKrJaPBa3ZNvDfsKWDdnmjh7zZXetJ
	 +Kz6W/D0UGJvTBfTggfxoe81Rl8kyANYCb5d6vfWDRrPbj1K/hVt9TV6SVphxL2HrS
	 60byyjT0YCbKti0kKIM+PYPHZEd6z3dlwZphS8HxraVIv+y3ADdJ1DK2IjpKHUXs8G
	 bZ24ZQirTcmEg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 902331398C;
	Thu, 14 Dec 2023 19:45:07 +0100 (CET)
Date: Thu, 14 Dec 2023 19:45:07 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Karsten Graul <kgraul@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Jan Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>, 
	Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RERESEND 06/11] net/smc: smc_splice_read: always request
 MSG_DONTWAIT
Message-ID: <245da5ab094bcc7d3331385e8813074922c2a13c6.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103
References: <2cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l4z4w7hyrnleo4rd"
Content-Disposition: inline
In-Reply-To: <2cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>


--l4z4w7hyrnleo4rd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Otherwise we risk sleeping with the pipe locked for indeterminate
lengths of time.

Link: https://lore.kernel.org/linux-fsdevel/qk6hjuam54khlaikf2ssom6custxf5i=
s2ekkaequf4hvode3ls@zgf7j5j4ubvw/t/#u
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 net/smc/af_smc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index bacdd971615e..89473305f629 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3243,12 +3243,8 @@ static ssize_t smc_splice_read(struct socket *sock, =
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

--l4z4w7hyrnleo4rd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmV7TTMACgkQvP0LAY0m
WPForQ//WzHhUmkfyAAcw6XAu0st2Tx/S0T4A8l24yTjKu6/h2phrrquWFN0C79n
nDa7MaFQEA8qXMAsROApZoHayZpSq+w3jee6D+3MRwnsPp8wEMWs+KGTlX09D978
4qbgCq1shAJSsms4U1EbSINfu499AwyDUREI5wY+49WCdZMADG/C7imntuw4xspd
scXnF8CXKfEezTx6VJPTYhJHswgbwkKbh6GtuiZmppqaFZAdXolj/9Vpb8+Rlm38
jiPL7XX7zBoI+yZdsxprh4xNU7rvOpIGnnVlGswDlJ7Y36wryXhOIhQOF3hzhKLE
2GsdPt6YkjVmXiGPSIx+5UZ8+GIOhSoI+M/pLwep29PVG+HST7UCJfdO+TGgiKWd
sPRImk1GFZJvC0XK4xAn5XLGubk17JcrDNkaXX8BxK0nD7uZkqxpDXsQKkEJhXEh
xfXb/PV2Pl140PJ3D72sak8KKoR+MLjnxKnGX2I+08OVJBE1+k/SKn0HolRUTupW
lkFwG/qehZppWnoBjVrSnknp9EppSS0cxCprhYo4VsowmDduVE1AbyMGad2olq1h
K6opPf1wfCnR8EzaFHsAopFlRi1NHVE5xZ4Hu77zAVnxficxxEL86rijUiUAM5uY
ClM5h5nv8LDF04ZN70QS6uytYomwSnnlLiWHYX/JkOtxXvDm7QA=
=hazA
-----END PGP SIGNATURE-----

--l4z4w7hyrnleo4rd--

