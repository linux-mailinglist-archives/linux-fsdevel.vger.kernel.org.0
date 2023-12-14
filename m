Return-Path: <linux-fsdevel+bounces-6128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73413813A50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 19:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EFCD283018
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 18:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F123E68E98;
	Thu, 14 Dec 2023 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="bU9lIeGD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FF610C4;
	Thu, 14 Dec 2023 10:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1702579516;
	bh=nDrwqDx6g17tp76N5xVUDx8sUEDcvzOb97eotkFu3/k=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=bU9lIeGDIS4sb4eigHq8GkEC2G0QMzGoWlh/3T6TCHg4E7CiLMx6bQhTrB2uPpk8j
	 ssozwnxjkVhZyEpDAVSf+GeMQ2iDxQaNQB9ZJF33EZtkloiW25yAV6e2kfwdpVNQBg
	 rAo1xySnVgDvdqKVSOX/Hx4LKdqcTnlQaI84JLOg6QMzXXlCbUAe6Ced9wsyGUJjqU
	 ybnPvgcZ4j8Qo80Ln49MG0FiNV3kUv2kbj6z9B/91NC+JUFPl13k8ro6EBaBE/uYLt
	 aYiwtqxmm6DHMe24nl6WsxT3vvR/q0x+MAbHsLbLdGqvfOlyB/Lo/b3On3E8BUVJEp
	 V6V+Z3IxNwrbA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 4786313990;
	Thu, 14 Dec 2023 19:45:16 +0100 (CET)
Date: Thu, 14 Dec 2023 19:45:16 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RERESEND 10/11] splice: file->pipe: -EINVAL for non-regular
 files w/o FMODE_NOWAIT
Message-ID: <25974c79b84c0b3aad566ff7c33b082f90ac5f17e.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103
References: <2cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nahgatr7vznet5uy"
Content-Disposition: inline
In-Reply-To: <2cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>


--nahgatr7vznet5uy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We request non-blocking I/O in the generic implementation, but some
files =E2=80=92 ttys =E2=80=92 only check O_NONBLOCK. Refuse them here, les=
t we
risk sleeping with the pipe locked for indeterminate lengths of
time.

This also masks inconsistent wake-ups (usually every second line)
when splicing from ttys in icanon mode.

Regular files don't /have/ a distinct O_NONBLOCK mode,
because they always behave non-blockingly, and for them FMODE_NOWAIT is
used in the purest sense of
  /* File is capable of returning -EAGAIN if I/O will block */
which is not set by the vast majority of filesystems,
and it's not the semantic we want here.

Link: https://lore.kernel.org/linux-fsdevel/qk6hjuam54khlaikf2ssom6custxf5i=
s2ekkaequf4hvode3ls@zgf7j5j4ubvw/t/#u
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 fs/splice.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index 9d29664f23ee..81788bf7daa1 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1300,6 +1300,8 @@ long do_splice(struct file *in, loff_t *off_in, struc=
t file *out,
 	} else if (opipe) {
 		if (off_out)
 			return -ESPIPE;
+		if (!((in->f_mode & FMODE_NOWAIT) || S_ISREG(in->f_inode->i_mode)))
+			return -EINVAL;
 		if (off_in) {
 			if (!(in->f_mode & FMODE_PREAD))
 				return -EINVAL;
--=20
2.39.2

--nahgatr7vznet5uy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmV7TTsACgkQvP0LAY0m
WPG0kw//XaT6a9M/I3lwDoHIwD8jmA4YvrDYXd17kTGGyTlEjJ3MkN1uy0tBL9JB
F15x4n42QkCX2nBf+wClYkG4sbss0sPz7qw0nvU9no5+a4p9a9Q+Q6619FKoKTgD
P1MD8ehjb0chM9VbWUZ2wXYxHn/CLDXuBXIx/FcGeu7/XWFCrJo6PJoENie6FBIb
tNHKTkCDq1v4cQFi9ZzkKaEuYkt62FbRnMlP65tgdu62kFnbSm69rZqkSkw8e5fW
uHRZ+mdEiGpcyPrf4Dh30BA3uee8kQ751LKN0hOEvwIqudidUhCNPYJ42d+ndSsa
K7mu2XaPKtqgqNZar5OrNSiGqCXlOZlmxXcjEgeC6OWCMa7kdL891rngHVSN7VG5
LvV/wi+3BdNnASOspkE/N73LA43sEQPQbkNrNsXsp1PT/wJsXCnzm9fKD8uUewpN
srV0zasghFl6aI6TYDCUwmEbNHtoB0tJF0mNvU9IvETZJg92jSvC/GDKlE6L1Bb+
VL/Pwz1POWtyzgZSGTcom/HAa2x5IgDZ8qEkb7OLegqDv/Aqw486RK+tJpW1Cf5M
OKlAM50448ziDvq+WkvbKF2Pu0iseBFVAWP1q8wzYWYOb4yMUFwDVrpgE3E81iww
CEbzBNC5UfeaeoIdwLpgBQW9dx/kfVVToK1O5EyJk+iuFQF1WRY=
=2snT
-----END PGP SIGNATURE-----

--nahgatr7vznet5uy--

