Return-Path: <linux-fsdevel+bounces-5655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C7980E8DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 11:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32841F21942
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 10:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FE45B5A4;
	Tue, 12 Dec 2023 10:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="PWAYJ5/7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38125D6F;
	Tue, 12 Dec 2023 02:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1702375980;
	bh=n8Tz0tvGMgfdPFnvnOzQj+h8yUtCIOndgwGis4T/GEQ=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=PWAYJ5/7wGUdmHMz7N8QIQ4ekEIZwUOQDYzI8AfNrITIDjbYq/1SNBNUO6W2SXSRv
	 hHzG6JjeJdhYvhET3HtOFwVx7kZpYdfNJb0N4PNZ4Lf5NS72RwZWqsE9VCRHUT4uNd
	 VU8uSlJz1K+dzahePgbnKs38jkUTqmiYE7P3nYtFQWaCygmhG32bYliYjHHmTlG1KI
	 mdDKFVuCqnSLSBu2vIkOS/9tA8a1SdrvQL1HJMFNmq1Va+zTspvwE0iEUB2pP7/5l+
	 ff1OarfhS7x54MiYVFBlTqGta7IxiFzcLEVZeR2JDhYw0QUu+LL1fi2GoLbRIoy01Z
	 8/hsDv3xIzpdQ==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 4061D13784;
	Tue, 12 Dec 2023 11:13:00 +0100 (CET)
Date: Tue, 12 Dec 2023 11:13:00 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 11/11] splice: splice_to_socket: always request
 MSG_DONTWAIT
Message-ID: <1813e1805aa942862d300bec4d0563c5a466dce78.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wcobgse6hj3ubesx"
Content-Disposition: inline
In-Reply-To: <1cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>


--wcobgse6hj3ubesx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Otherwise we risk sleeping with the pipe locked for indeterminate
lengths of time.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 fs/splice.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 81788bf7daa1..d5885032f9a8 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -869,13 +869,11 @@ ssize_t splice_to_socket(struct pipe_inode_info *pipe=
, struct file *out,
 		if (!bc)
 			break;
=20
-		msg.msg_flags =3D MSG_SPLICE_PAGES;
+		msg.msg_flags =3D MSG_SPLICE_PAGES | MSG_DONTWAIT;
 		if (flags & SPLICE_F_MORE)
 			msg.msg_flags |=3D MSG_MORE;
 		if (remain && pipe_occupancy(pipe->head, tail) > 0)
 			msg.msg_flags |=3D MSG_MORE;
-		if (out->f_flags & O_NONBLOCK)
-			msg.msg_flags |=3D MSG_DONTWAIT;
=20
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, bvec, bc,
 			      len - remain);
--=20
2.39.2

--wcobgse6hj3ubesx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmV4MisACgkQvP0LAY0m
WPGwRxAAs6fr478UQ2p25vI1thcEvzX4w5WUOAwBkLcqvY9dMJZ7vZTzRqlmIFnO
IiI7kNBIre5AaHQn8I2d7YQddxrurwLLa5MkuvdfxSRzOt3lU6jsZotQKCg1pAmh
vJqsRNkQk0n0w7HTsx/xBTYFbw73DiJGxYJrdYdhhd7W66rVCr7lc8SuOPXG67sG
ngKc80p1H3XASjYpXHuKSF//z0QNRPZt/YbSVNFFMJ0CjJoIb8XjOsPvtVSnl7Hq
iVOE/mpqDpsBuibIVk/iPTWYRrt0RiHl7jIMcTaEpr5AZ8T0kn4wapEbISmBxhU7
Tn5FH3QH76qSZWBrbD/fuh1OTdQbqUDlCSSwOS44M3Y3Indafsor+8D+RxpY46Fl
9BedCQqc+dPTNtEeL8R1b6PUn7BPug0h/M+L7U3TT1burIAqgmaGGaqIK49Pps8Y
c1pH1bx4BWWB4F75amTC+A0uZEWCKnA/4BORvMTpATwBnsPOngznOREP3yzoNoiR
1QdmcJL7YAs52Nq219+RM5CEJhQqA1Y6vGAHA2WWOMsoue8su8FhMO/SL9dafcq+
Tvw6BW1jnxUdeOOK5I4eOwzTIi8B7FoJNk8O6E5I9YWwxPPk79v6MnICMKVCNcSQ
4BIxIGjVD6EhR6GowE44L19F8GBFkiJKe8Lx/iOyW3AyLjUElBM=
=NDdt
-----END PGP SIGNATURE-----

--wcobgse6hj3ubesx--

