Return-Path: <linux-fsdevel+bounces-6619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE00681ACF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 04:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7E42824A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 03:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CC211CAB;
	Thu, 21 Dec 2023 03:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="nkTFe+Uc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B53C11733;
	Thu, 21 Dec 2023 03:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1703128143;
	bh=6cAMXGnL8xft83SbIhEKbKmwbcXCq5q+4GH8QxHM/tU=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=nkTFe+UcamJPNdAUF84BUUelHqg5p0U2NAf/DySmBvEG1zMkvmE8aQS/RngAaN4Kz
	 zC5+ksKX3o+01b3rHDWmjsUPIBqXUwr3xzsNHXotTXW4jdRFqHlhE9rm/Zsq9V1AiA
	 5lURoPVM0hVQz/fQN2B+ZOeK1vzk+UD962C8pCjJr2FU0KLs+EcbZDBIgDIcbwG0tU
	 vs2YV9lOSzqMm3wKj3T5mo9w7pWrHmRIYG4lNbVOm7PNGIpf7IqR/UXlNdTtDoVOFH
	 OSTHH3079/bf8upcZ4UjTbYiO9zGahq4NJr275pKX86OKXmpB8JBMEBkkpUFLqy5xq
	 UNIiRVnlOhrXA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 5C10313776;
	Thu, 21 Dec 2023 04:09:03 +0100 (CET)
Date: Thu, 21 Dec 2023 04:09:03 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Howells <dhowells@redhat.com>, Shigeru Yoshida <syoshida@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Peilin Ye <peilin.ye@bytedance.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/11] kcm: kcm_splice_read: always request MSG_DONTWAIT
Message-ID: <0d8847df2f13e0831ee2f5504d06d5d12036d8f9.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5o6qkbs6x2rmqla5"
Content-Disposition: inline
In-Reply-To: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103-116-3b855e-dirty


--5o6qkbs6x2rmqla5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Otherwise we risk sleeping with the pipe locked for indeterminate
lengths of time =E2=80=92 given:
	cat > kcm.c <<^D
	#define _GNU_SOURCE
	#include <fcntl.h>
	#include <sys/socket.h>
	#include <netinet/in.h>
	#include <linux/kcm.h>
	int main()
	{
		int kcm =3D socket(AF_KCM, SOCK_SEQPACKET, KCMPROTO_CONNECTED);
		for (;;)
			splice(kcm, 0, 1, 0, 128 * 1024 * 1024, 0);
	}
	^D
	cc kcm.c -o kcm
	mkfifo fifo
	./kcm > fifo &
	read -r _ < fifo &
	sleep 0.1
	echo zupa > fifo
kcm used to sleep in splice and the shell used to enter an
uninterruptible sleep in open("fifo");
now the splice returns -EAGAIN and the whole program completes.

Also: don't pass the SPLICE_F_*-style flags argument to
skb_recv_datagram(), which expects MSG_*-style flags.
This fixes SPLICE_F_NONBLOCK not having worked.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 net/kcm/kcmsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 65d1f6755f98..ccfc46f31891 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1028,7 +1028,7 @@ static ssize_t kcm_splice_read(struct socket *sock, l=
off_t *ppos,
=20
 	/* Only support splice for SOCKSEQPACKET */
=20
-	skb =3D skb_recv_datagram(sk, flags, &err);
+	skb =3D skb_recv_datagram(sk, MSG_DONTWAIT, &err);
 	if (!skb)
 		goto err_out;
=20
--=20
2.39.2

--5o6qkbs6x2rmqla5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmWDrE4ACgkQvP0LAY0m
WPEftBAAobcH1Stzc1ZSZysDN16RiUErj0K8RwIdXVmaDF043DDg8UQjFpEioV5/
MrWCvh+4waj1JsLJudS3d1LcPa8slRE8OuqS8KKmQWwo16nVktvvgskIqEXlrSYH
tsCYFSoN7F9NVWjLV43B7G0ZE8WfJrSONfjiyYaxt6L5ifNmTEQrWQcIDuG/SFVR
nNgnkz07szyhZj3EWiXAnY4WgUaip+bDuUYpftrvQ4+kcDqYc14rUWNwxyykQGda
Octdnl/hL+DCrl+75gjT4QoHHGDapY2Zdj2uBNRaTEI3K2qWGhmsW5Tubzp5+Co9
ViY/kfXxg98M0ZW0p7vgWP6XH5QJZ8ePzPiNhT/2LSogJHyGfdw2vuj060x0T5JE
BEZfzRmGJeYOvTxKP+0gMcpXehwi0sHvJ9iUFkpcdUNbDLGYmah963eiuPaw6AQ/
4OfHnWLLSpuKQ0trL7pcbJQvlcX3qeSSoGMxkDRGo5wrMhoht8kKdqG+FoMX1WRU
eZcCzntt3HlzEIKgld346Wl34vXhzCnIyX9sB/f99VJC31ve6xGEesGjmdaUN18P
wP2WuHBIaQpWxP5HBaiu8nB7F381mTSHfMl78eeRIuILQvrQR/2Np4A8sV+qfDba
bxYZ0TWeWEX12Zs9T5v+h0prIOmhgxeolyACPrAgMPnHWLy6rJ4=
=nrSb
-----END PGP SIGNATURE-----

--5o6qkbs6x2rmqla5--

