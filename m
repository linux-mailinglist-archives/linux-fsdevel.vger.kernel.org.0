Return-Path: <linux-fsdevel+bounces-499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392BD7CB4C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 22:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7AE1C20A3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 20:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1D0381CD;
	Mon, 16 Oct 2023 20:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="JVhaOxgf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20B2381B3
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 20:36:04 +0000 (UTC)
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DC6F5;
	Mon, 16 Oct 2023 13:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1697488559;
	bh=AbhKjmGcFK7a0VSiC3Uyp/FqZCpYv3ilKDudDv/H+vg=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=JVhaOxgfx7Mls92DNPEIWl9LDiGpLsqnYzvsIikxwThGSQkKph//v1LaOuQww4Jxs
	 834qWDOxzlJZ+w3TVxkD/3tpeLhRRRkdC5t+fKPiLNbdpSakUTP/vVweidpMvXV/4j
	 0dgVhKfiNO0loNffmpqR1pBfze63D4UcGtKLRhaXHvIaleLWumdMi26LAipBDTplCd
	 KoGZKJHXcsIS2oJ0sWeV3HjJFTTxZWaAUV7oKOnQzlIvejR/hrjok+SxPcRKCeZ5B9
	 6Q8ng29ppdCpc3MKP0JtRI6fKZVE+e7u4Q4ptnz/0LakLzVpNjA+kvLC1ImClyMSR4
	 RsIlD/R+AywNw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 1CEFD10502;
	Mon, 16 Oct 2023 22:35:59 +0200 (CEST)
Date: Mon, 16 Oct 2023 22:35:59 +0200
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] splice: file->pipe: -EINVAL for non-regular files w/o
 FMODE_NOWAIT
Message-ID: <5974c79b84c0b3aad566ff7c33b082f90ac5f17e.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2kmqog55wiriurlb"
Content-Disposition: inline
In-Reply-To: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231006
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--2kmqog55wiriurlb
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

--2kmqog55wiriurlb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmUtnq4ACgkQvP0LAY0m
WPEpAg/7BUL4idkMMgsWTcDBR1zcXKEzx7VaIGw4cMmWVQsbi6ni0c3xtMf87Pcp
f2qkU4hKon41qzlJQy2xpQx9XzW4FpyCpLM4bf01vm3w7uoW/5NeF+bWUpljo0I7
OT5UbgEEiWedBkiB2k2zNugZyz5arEmCb1pLOqXCfkjeQ6W0SfSOM1wFIe+FMes0
B6GO6TOGW799SSLRO8bLXj8A40cHomCJAF7lbt1KLB1QwmSVHe/AgpdTBnx6SWek
1JupLtJ1AQMBRzqs1WoFfPWK19oYPH+IQxS+AcHxamcF2HG9eoX9hVlThYyY2rUj
0zbcyoFnl9yN7q7d3XD1f1TE74uYGY0Z3EgXRaPzT9YHLx24Ts5c34iWhUe3mTqM
naBJkhDJYJebRvTbLHUX4CGyA4EsOYB2ibc3JzmG5MyCphU6jasEDnGqGqLAmb83
f2Yl2M004ytC5unxrZ2zaQjp4WaF2v7NnShUtxWXjuDgzgi3MiN6VCp5YazjvhzX
9psziTqbubn4OCrVp0misOQUQL7Q5+/m/YIcfDkBDAtaFfj3d/IHtyBbUla+5lYO
9Jwk5RBsZtiFn0dQRhpAMMGpAdKkmNlBvfuDGqNsN0BD4ZEAt2/c2lOlIa/uzS6s
E8R958JUoWmdYWprxxKIhN8UjvuB4SnV4glRyZTc+ngPYa57pKI=
=39/H
-----END PGP SIGNATURE-----

--2kmqog55wiriurlb--

