Return-Path: <linux-fsdevel+bounces-6626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 658DE81AD07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 04:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06946B21984
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 03:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14F89477;
	Thu, 21 Dec 2023 03:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="F7gAnsMy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED18722324;
	Thu, 21 Dec 2023 03:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1703128166;
	bh=QL0lddTMwRPoSZ6aTDIQu4Srn7Q11jih7quYd1vg0Vo=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=F7gAnsMyVXO678N+0p+QbMrYBWgojnKNsTIWjttkyfbMZ1MBMUxaIBde0RDt12APh
	 i3Jko7SRzsL1OmiSoIJ4SZ4H6msWH7exQvARD+Jv8HX13w0KORDjAXdTH+Idhj0+X5
	 GGYH8ke4EI8fIy5O5jg0HH1Ju4a0MSDgVguNsJ0i6Tb//n+Jmvrz0YvkwBlwT5erA4
	 T/7Md7StzD6FraWo9cmrWWYZTQ6bKz9PpM306NILw6tAxiF9D45Uuhdw8yF4l2ZYH0
	 QGqBAu0FjQjTd/sqTkj5dUCM0n4fpM1f3dJP7jwVqjPcZAhfI9T4K1xhtdIbPBL48N
	 PQAUUz7vlAFAA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 5CB8213DB6;
	Thu, 21 Dec 2023 04:09:26 +0100 (CET)
Date: Thu, 21 Dec 2023 04:09:26 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Alejandro Colomar <alx@kernel.org>, linux-man@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/11 man-pages] splice.2: document 6.8 blocking behaviour
Message-ID: <ii3qfagelsu6j2zddtzl6cruy6bpd5wimx35dabhktymjxrwli@tarta.nabijaczleweli.xyz>
References: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tzluzsf63urqlqnv"
Content-Disposition: inline
In-Reply-To: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103-116-3b855e-dirty


--tzluzsf63urqlqnv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hypothetical text that matches v2.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 man2/splice.2 | 47 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/man2/splice.2 b/man2/splice.2
index e5d05a05c..d2c7ac8d5 100644
--- a/man2/splice.2
+++ b/man2/splice.2
@@ -139,10 +139,11 @@ .SH ERRORS
 .B EAGAIN
 .B SPLICE_F_NONBLOCK
 was specified in
-.I flags
-or one of the file descriptors had been marked as nonblocking
-.RB ( O_NONBLOCK ) ,
-and the operation would block.
+.IR flags ,
+one of the file descriptors had been marked as nonblocking
+.RB ( O_NONBLOCK )
+and the operation would block,
+or splicing from an untrusted IPC mechanism and no data was available (see=
 HISTORY below).
 .TP
 .B EBADF
 One or both file descriptors are not valid,
@@ -192,6 +193,44 @@ .SH HISTORY
 Since Linux 2.6.31,
 .\" commit 7c77f0b3f9208c339a4b40737bb2cb0f0319bb8d
 both arguments may refer to pipes.
+.P
+Between Linux 4.9 and 6.7,
+.\" commit 8924feff66f35fe22ce77aafe3f21eb8e5cff881
+splicing from a non-pipe to a pipe without
+.B SPLICE_F_NONBLOCK
+would hold the pipe lock and wait for data on the non-pipe.
+This isn't an issue for files, but if the non-pipe is a tty,
+or an IPC mechanism like a socket or a
+.BR fuse (4)
+filesystem, this means that a thread attempting any operation (like
+.BR open (2)/ read (2)/ write (2)/ close (2))
+on the pipe would enter uninterruptible sleep until data appeared,
+which may never happen.
+The same applies to splicing from a pipe to a full socket.
+.P
+Since Linux 6.8,
+.\" commit TBD
+splicing from ttys is disabled
+.RB ( EINVAL ),
+reads done when splicing from sockets happen in non-blocking mode
+(as-if
+.BR MSG_DONTWAIT ,
+returning
+.B EAGAIN
+if no data is available),
+and splicing from
+.BR fuse (4)
+filesystems is only allowed if they were mounted by
+root in the initial user namespace
+(this matches security semantics for normal filesystems).
+If a splice implementation is devised that doesn't need to lock the pipe
+while waiting for data, this may be reversed in a future version.
+Writes when splicing to sockets are also done non-blockingly
+(as-if
+.BR MSG_DONTWAIT ,
+returning
+.B EAGAIN
+if the socket is full).
 .SH NOTES
 The three system calls
 .BR splice (),
--=20
2.39.2

--tzluzsf63urqlqnv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmWDrGUACgkQvP0LAY0m
WPGGsw//RHDHC3nWcXcS0wI+Jj9gq66xabAnvTGMEWaFyDdD8DhVE4XR//kvgtQi
64sdrcurB2Akl1h+ixBFWcKukWTc4xRdHd0K7WBeI+59IyfKRl/kjC9kdYyAXsnQ
I9Hx8U7PKvL5JsTU4Had0PzxlYnRlGiRwjolJ7Hx3rpxuKQZMF4B1daxMLAOyT/1
m5bTcBN/gtU0rVDYtD9cSGNO3lvCbldvWMldOzwgbrjAylbQAAKLunIRyV9sOHMo
Di3AoIhen1eU755zej0C/CjVgmKUYa1GG3Qm7M9bwtdaJFOnSFcLqlEd3adgnog4
gKwuLFqoyxkAg42VD7sALbQdfX9rpqm565tVRFqF/TLGMSb8i9tZ+UxEAu76LEmp
DKk3XNO0oq6TPNEDtTCT7kJGuaTv4gK2DXD2KIPOBqHgWGQ25eB9rA5CDIz+8160
UIMSRY9/8j37Gej0tW46INCM1j/ww7nwaJnlIu1FdS2ZIb2ghz6uMoRO8p0714qQ
a65z+Dc+mdTDGHGeb7vFjPJ0KdsHm/fLZL6c7JxRNkPk0/BAbrCyybo3mUfz8Jts
OyJCZ59ETtjeDfWn9+NAgE4V17B9chQCVyx5Fkq+geRfau21Af1TwbBtbpOM+VP9
8QibeIR9csBfcHSyB6ZL0Y3XNkHyYc4IqGisOZ4F3yG+0OuyKsM=
=hZAa
-----END PGP SIGNATURE-----

--tzluzsf63urqlqnv--

