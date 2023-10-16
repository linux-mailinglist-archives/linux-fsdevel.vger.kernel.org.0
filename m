Return-Path: <linux-fsdevel+bounces-500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 253A97CB4C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 22:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8F0EB21253
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 20:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D41381DF;
	Mon, 16 Oct 2023 20:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="C1tqd1IU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794A3381CE
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 20:36:07 +0000 (UTC)
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D7119B;
	Mon, 16 Oct 2023 13:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1697488561;
	bh=GkcnvUcVpOCe5CAn1FqxU2g9Mal7SpC32VFF9WWd900=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=C1tqd1IUfTUwcsTencFYK4ZinxRZ0QuZ2dZaoE4ARNPRyq9gW9vWpdT8w5ibyI9IO
	 r/FM5jS6XvZd94ewaBp3MmdkRCL01YlZZssVYT41RzBlOUuSwQmqV+o25Ai1oqf73g
	 whBgvc+ZQIe1ix40Z7jL4XY9W38v3Z3RqOdHieeMFPqJmKEnGktgj7gqgPU8eFoxmn
	 IucbGc2OFlHummOanDb/K4JlQDjB2Lrog6jG0eHqeDRjXWJq25q7gLNGnW7fC69FOK
	 cZaaNZmMMW+ARrhcgZtdy2gtZEiAZ/iNRHUwVcZRPlnB2HWc4b5sja3KX4egmRmtL5
	 DhT5tHfmd/Wsg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 6EDA4FAF2;
	Mon, 16 Oct 2023 22:36:01 +0200 (CEST)
Date: Mon, 16 Oct 2023 22:36:01 +0200
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] splice: splice_to_socket: always request MSG_DONTWAIT
Message-ID: <813e1805aa942862d300bec4d0563c5a466dce78.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4tuu7g3cnuobllgt"
Content-Disposition: inline
In-Reply-To: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231006
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--4tuu7g3cnuobllgt
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

--4tuu7g3cnuobllgt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmUtnrEACgkQvP0LAY0m
WPFaiw/+PYxS4XTUis48aaacFF5+UetcG8qMihZRg51JtDxWGPZp4BjlVL6pODGg
tCRTmD6NsG5XDSeKHSKx0TRSmY+aBTtEmxlg0HvQ2etwqGBgbiZ7JR5PI8oxtr7G
LbMaqhTeLfE8u62NfGYM37mCRLbQcVam0pjcKH/JlUzJhdh8lnzvrqTfzF4T1Mhb
jM42T3cy0Qq0kG0BWI2mSH0cBuklkb+2I6SiEIRSjZsqQxawCxavVve5JAQYfCDZ
eulH5r115uagSiKcZIec2qfywUv9ATUZ9Lr71j8U4YBsfIh4uo/kSjtZcrHCxmFc
weUWiweg3VTHfdHmIUOMWZ3Yt4zwNzf6v3gK7e3glYBiFLYuAU/NqKlkWBJVGLJy
wBEf0L/vf0z/DQJPOWgLpqSbVelNjgiA0U6kTggLy6QImCHaCKqti+0mj/JPGsWn
P63QY/wyxtI/bmaMOhp8mNovo1tZnr9L9liXcLhkBA70eROu8OIyxlFT1Cm8ueKM
NNL3vixRal7Lz+Le4YcbXzSbfkf9OGf5qVFzGL0UY4YmmlbaBB4WEeE8RwmPT3QA
Zf+WFnYoCH7x+QKSUWmAXNgrHPADtk1qG5RCrMOuBcqEEq24vPC14vje+ZFxXLDq
3xJPtVnNQrzwrTsDr5Syw3mg8tV2/yGAtg4DTkX+jxsgDmuFDVg=
=alCd
-----END PGP SIGNATURE-----

--4tuu7g3cnuobllgt--

