Return-Path: <linux-fsdevel+bounces-6616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C693381ACE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 04:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DDFBB221E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 03:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0CCAD5C;
	Thu, 21 Dec 2023 03:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="dSrYc8hG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03422AD4B;
	Thu, 21 Dec 2023 03:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1703128132;
	bh=eAEZKuHticwVYxrh9ppCMct1OB8vV2MAUTSowqzWAZ8=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=dSrYc8hG+4fSy0WFWd9aZsqSwDNE4gGjB3V5Qw1jR5c2AUkMmUdNDUVzE1Fe9+45G
	 y//sDt54gWQYIvIR/B5mXHUKki0Ca2X4hMpymSj+1073lc8INhpYVQpbAw6bISFAOA
	 92s6NHFQw/rg3Prjt9JAsN4UgZf6L8ELbsPCO53JVe4cbsssKs19jqzNYtrLmOI6Hc
	 y42k5X73W9gUZNZOMYA5rCn2UwZvfJvAolnMdhdAyYLek71D24c5TqS5XjvYCbUY0L
	 cDXTpFHzEvxJVo9G7A7vG3DrM5zAaez2GiIKUUPOvnxXjMPSvVzAuaIG6jQvb+q2Oa
	 H/aURzGp3PWaA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 15D4F13DB0;
	Thu, 21 Dec 2023 04:08:52 +0100 (CET)
Date: Thu, 21 Dec 2023 04:08:51 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, David Howells <dhowells@redhat.com>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, John Fastabend <john.fastabend@gmail.com>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/11] af_unix: unix_stream_splice_read: always request
 MSG_DONTWAIT
Message-ID: <8309aff7e55f0c7fe973bb2d1e6b6b3a80ac5a99.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v7y3y5g75dijoqbs"
Content-Disposition: inline
In-Reply-To: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103-116-3b855e-dirty


--v7y3y5g75dijoqbs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Otherwise we risk sleeping with the pipe locked for indeterminate
lengths of time =E2=80=92 given:
	cat > unix.c <<^D
	#define _GNU_SOURCE
	#include <fcntl.h>
	#include <sys/socket.h>
	#include <sys/un.h>
	int main()
	{
		int sp[2];
		socketpair(AF_UNIX, SOCK_STREAM, 0, sp);
		for (;;)
			splice(sp[0], 0, 1, 0, 128 * 1024 * 1024, 0);
	}
	^D
	cc unix.c -o unix
	mkfifo fifo
	./unix > fifo &
	read -r _ < fifo &
	sleep 0.1
	echo zupa > fifo
unix used to sleep in splice and the shell used to enter an
uninterruptible sleep in open("fifo");
now the splice returns -EAGAIN and the whole program completes.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 net/unix/af_unix.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index ac1f2bc18fc9..bae84552bf58 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2921,15 +2921,12 @@ static ssize_t unix_stream_splice_read(struct socke=
t *sock,  loff_t *ppos,
 		.pipe =3D pipe,
 		.size =3D size,
 		.splice_flags =3D flags,
+		.flags =3D MSG_DONTWAIT,
 	};
=20
 	if (unlikely(*ppos))
 		return -ESPIPE;
=20
-	if (sock->file->f_flags & O_NONBLOCK ||
-	    flags & SPLICE_F_NONBLOCK)
-		state.flags =3D MSG_DONTWAIT;
-
 	return unix_stream_read_generic(&state, false);
 }
=20
--=20
2.39.2

--v7y3y5g75dijoqbs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmWDrEMACgkQvP0LAY0m
WPFwKhAAo41u1QzR/jF+s5GRQX+lH5PM1qDFUNRtKYaqEW3TAkZX9dacRh/mj/w3
Ft/oX+Prl+XffMC9Ysnw2xxmpdnOiOEDZHTCuwI/w53Iymv7IUZXjvMQfPlW5ZdY
nnefkBoguNC8jvynt4bHAALcmNWah1cNUSmiGH8NVJWIz6dLwsRiJH8DcZjvmmXt
P5hYvFizVmZqDpJaSd3MzyE14qBl3mrEQ2LvNeH5kEmw7yoeeugayk7AcS6ixqsg
fF8TwkTdm+D0me7i544z+HRBfW3xnP23ulkM+DE5Boi+WTtZHn+Di4/2rdqwrs3Z
bPYR4SlQIesMjDihHjZBMmj11S3/JwJ03E6kWLw/FoFQKyNA2gY88ky867GMZ1/v
/ZbnfhqPq0BAeEks+Pj8tzEt1nAaGwWk2YIMEMInJR2qDqpP+UFdakP69PbOlcp2
YXwzbxkod42UTVPRdB4M82nsgLxV5elyVxg12fAEXavQ7bYV2JdkxHdTqqW954JD
T5FAd5GHlkCtcG+HYv+UPY7EWlgQI0Qc/6RBaoYdKLystZq1RpBWvZsjxv0bXQG5
K4my9r0laEVNCaOeQAwzo8K5jbNSyEVodmHukqPki95nqxaWB/nwSUz59vSVPYWt
VfNrXnZfzd+Ss/j9CJk0DKOJHMJzTwez+CdsuZ+Xd5yEy4gjdzk=
=EAl7
-----END PGP SIGNATURE-----

--v7y3y5g75dijoqbs--

