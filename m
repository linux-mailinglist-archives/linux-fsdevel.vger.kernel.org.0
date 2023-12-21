Return-Path: <linux-fsdevel+bounces-6621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EB681ACF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 04:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9779C2882A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 03:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835B517735;
	Thu, 21 Dec 2023 03:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="pHDgVoMi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893EB15AE7;
	Thu, 21 Dec 2023 03:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1703128148;
	bh=fnKQoYZiI85fSTbAEaSEfBVSSLGdtMQnakutCuLUGCM=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=pHDgVoMizVeq6S9MWjn6uFDxllWq6WcSq2K7TB4c041J+twDbF2NTE2zhwr+5oIWW
	 xUVV0a6x46nlrs3++bVB4Js/bq9at4BnjVdo47lP9XATAs1HW6dGqc6harEIdxtpmd
	 jOhuYtMKj4wfmnBPgcRGljdUZb4XZuwCNYqr5jaC+WtzeauWCGDZg5wyqt4a0Q+7zD
	 aGX3tGEKc9P6eFLqcyDq7T1iigA0PaarDSCMdYsn2C4CjU/6rAcHqh5juofkXC1su6
	 sFxQLeyNa77hwQHmvHZnzMHkOVZIJBgpYyAS4upsU1UAO1pi5r/lvKYw6bl0evc+r1
	 8GzCAWdNZe/5g==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 9AA7313D42;
	Thu, 21 Dec 2023 04:09:08 +0100 (CET)
Date: Thu, 21 Dec 2023 04:09:08 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/11] net/tcp: tcp_splice_read: always do non-blocking
 reads
Message-ID: <d2d856ed990f713d03e72c72dc81097467cbf983.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hdk27c4uwgmfnada"
Content-Disposition: inline
In-Reply-To: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103-116-3b855e-dirty


--hdk27c4uwgmfnada
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Otherwise we risk sleeping with the pipe locked for indeterminate
lengths of time =E2=80=92 given:
	cat > tcp.c <<^D
	#define _GNU_SOURCE
	#include <fcntl.h>
	#include <unistd.h>
	#include <sys/socket.h>
	#include <netinet/in.h>
	#include <linux/tls.h>
	int main()
	{
		int s =3D socket(AF_INET, SOCK_STREAM, 0);
		struct sockaddr_in addr =3D {
			.sin_family =3D AF_INET,
			.sin_addr =3D { htonl(INADDR_LOOPBACK) },
			.sin_port =3D htons(getpid() % (0xFFFF - 1000) + 1000)
		};
		bind(s, &addr, sizeof(addr));
		listen(s, 1);
		if (!fork()) {
			connect(socket(AF_INET, SOCK_STREAM, 0), &addr, sizeof(addr));
			sleep(100);
			return 0;
		}

		s =3D accept(s, NULL, NULL);
		for (;;)
			splice(s, 0, 1, 0, 128 * 1024 * 1024, 0);
	}
	^D
	cc tcp.c -o tcp
	mkfifo fifo
	./tcp > fifo &
	read -r _ < fifo &
	sleep 0.1
	echo zupa > fifo
tcp used to sleep in splice and the shell used to enter an
uninterruptible sleep in open("fifo");
now the splice returns -EAGAIN and the whole program completes.

sock_rcvtimeo() returns 0 if the second argument is true, so the
explicit re-try loop for empty read conditions can be removed
entirely.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 net/ipv4/tcp.c | 32 +++-----------------------------
 1 file changed, 3 insertions(+), 29 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index ff6838ca2e58..17a0e2a766b7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -782,7 +782,6 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *pp=
os,
 		.len =3D len,
 		.flags =3D flags,
 	};
-	long timeo;
 	ssize_t spliced;
 	int ret;
=20
@@ -797,7 +796,6 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *pp=
os,
=20
 	lock_sock(sk);
=20
-	timeo =3D sock_rcvtimeo(sk, sock->file->f_flags & O_NONBLOCK);
 	while (tss.len) {
 		ret =3D __tcp_splice_read(sk, &tss);
 		if (ret < 0)
@@ -821,37 +819,13 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *=
ppos,
 				ret =3D -ENOTCONN;
 				break;
 			}
-			if (!timeo) {
-				ret =3D -EAGAIN;
-				break;
-			}
-			/* if __tcp_splice_read() got nothing while we have
-			 * an skb in receive queue, we do not want to loop.
-			 * This might happen with URG data.
-			 */
-			if (!skb_queue_empty(&sk->sk_receive_queue))
-				break;
-			ret =3D sk_wait_data(sk, &timeo, NULL);
-			if (ret < 0)
-				break;
-			if (signal_pending(current)) {
-				ret =3D sock_intr_errno(timeo);
-				break;
-			}
-			continue;
+			ret =3D -EAGAIN;
+			break;
 		}
 		tss.len -=3D ret;
 		spliced +=3D ret;
=20
-		if (!tss.len || !timeo)
-			break;
-		release_sock(sk);
-		lock_sock(sk);
-
-		if (sk->sk_err || sk->sk_state =3D=3D TCP_CLOSE ||
-		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-		    signal_pending(current))
-			break;
+		break;
 	}
=20
 	release_sock(sk);
--=20
2.39.2

--hdk27c4uwgmfnada
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmWDrFQACgkQvP0LAY0m
WPEuzxAApW4yq5Dyu4M9dPkyvFpQ+3E5bXzE78/t08DzT4BYKiVs3lWJmT8zdQ9r
ia5Q+qt3qLTwP4Qk8v6Br3n/PlsUXC4+BI/iNJ9VONYqJmKVP//W4rECWtDOWGzt
uPFTwZ/2+0g01mMMuWkiknZEezXUB3W6nmKunAmCf6SjRIP2kA7/B0KF9QrE7fqo
aN9/OBmLMJ1KbwAkla1DCKh920jS6J4r/1/QTq7Pr/SZz88E/H3G0c77j3smDccl
rZl4THzrN5pjb7nXvPvCnU3r5gi7HVuZMcctL8VMY3jOekCQFcwMVGithI42KUPJ
RBHY2+4zCWzFHtGoQGm/tObvX0hVnziGxg8oyEjDEA7wB/wRI0jlghBG05/Z2CHl
g7qK7tjQg8DjBJgQ2KfzLBoq9zct6hBJLUxx8+hpRfmeI6fh1IwIy1f1MIsIrsHm
78gmw6LcBkz7VLkwLSiFXK1I1OAJ76j76J7T8SUKbQ31ALL3Z9u9mLq0V/jsrEMX
wkVWLUbnaSXRJosK/KN2ILt7V67pwFaMJ4p0FU22hrMHqRQ7GbhUztKXhPph2gHp
7zAAwIFhB1x9D4tqwwkUJHAw/LsaFnoKzWz996p6KM/BTQvoRSfqkM2YcMo34rD+
t5SUqKAa9IWeVHC58pLb2o8AKKWzCH0OlX9x8HUa5EZqS/Y3g+U=
=+Ry1
-----END PGP SIGNATURE-----

--hdk27c4uwgmfnada--

