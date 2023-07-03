Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A955745EB1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 16:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjGCOmR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 10:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjGCOmQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:42:16 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12002B2;
        Mon,  3 Jul 2023 07:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1688395334;
        bh=xUQlRJiv0BrDJu2N4vefK4PLI4lrSt6Z70TDgeQpcYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hKE4LH1qBJLiXXH9rih/kbNbGViPFRh7mp4kfHOm8PL48Or5SW9QTOO/HZOz0Wiqo
         /dV6D/T26s14gdarunqZSVTjn1AigsmFkD3jSblOg8ZLckdb7zPN5HhkOwD64aywR9
         ffHZwQJBm40JW38O99WfivmMcRi+Lltc3Zwqkpami0Cxc0GnO/is19Q8qapVqPr+cl
         6TLGGcvYMbWdN+vqAQqGj56hDfHCqi9BT58EARtAIm6QgOCO9QL4iQec6MTF/ZfH8K
         erTR/VfIhdHCiB288dTe2BY1fHtPUtWtc5MYFrypJxZ8//WHk9DvbWtufi03usHRph
         pgTITT+bp/m2g==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 571C71DBE;
        Mon,  3 Jul 2023 16:42:14 +0200 (CEST)
Date:   Mon, 3 Jul 2023 16:42:13 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] splice: always fsnotify_access(in),
 fsnotify_modify(out) on success
Message-ID: <604ec704d933e0e0121d9e107ce914512e045fad.1688393619.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1688393619.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jq5mboc5m63x3mer"
Content-Disposition: inline
In-Reply-To: <cover.1688393619.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--jq5mboc5m63x3mer
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The current behaviour caused an asymmetry where some write APIs
(write, sendfile) would notify the written-to/read-from objects,
but splice wouldn't.

This affected userspace which uses inotify, most notably coreutils
tail -f, to monitor pipes.
If the pipe buffer had been filled by a splice-family function:
  * tail wouldn't know and thus wouldn't service the pipe, and
  * all writes to the pipe would block because it's full,
thus service was denied.
(For the particular case of tail -f this could be worked around
 with ---disable-inotify.)

Fixes: 983652c69199 ("splice: report related fsnotify events")
Link: https://lore.kernel.org/linux-fsdevel/jbyihkyk5dtaohdwjyivambb2gffyjs=
3dodpofafnkkunxq7bu@jngkdxx65pux/t/#u
Link: https://bugs.debian.org/1039488
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Acked-by: Jan Kara <jack@suse.cz>
---
 fs/splice.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 3e06611d19ae..6ae6da52eba9 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1154,10 +1154,8 @@ long do_splice(struct file *in, loff_t *off_in, stru=
ct file *out,
 		if ((in->f_flags | out->f_flags) & O_NONBLOCK)
 			flags |=3D SPLICE_F_NONBLOCK;
=20
-		return splice_pipe_to_pipe(ipipe, opipe, len, flags);
-	}
-
-	if (ipipe) {
+		ret =3D splice_pipe_to_pipe(ipipe, opipe, len, flags);
+	} else if (ipipe) {
 		if (off_in)
 			return -ESPIPE;
 		if (off_out) {
@@ -1182,18 +1180,11 @@ long do_splice(struct file *in, loff_t *off_in, str=
uct file *out,
 		ret =3D do_splice_from(ipipe, out, &offset, len, flags);
 		file_end_write(out);
=20
-		if (ret > 0)
-			fsnotify_modify(out);
-
 		if (!off_out)
 			out->f_pos =3D offset;
 		else
 			*off_out =3D offset;
-
-		return ret;
-	}
-
-	if (opipe) {
+	} else if (opipe) {
 		if (off_out)
 			return -ESPIPE;
 		if (off_in) {
@@ -1209,18 +1200,24 @@ long do_splice(struct file *in, loff_t *off_in, str=
uct file *out,
=20
 		ret =3D splice_file_to_pipe(in, opipe, &offset, len, flags);
=20
-		if (ret > 0)
-			fsnotify_access(in);
-
 		if (!off_in)
 			in->f_pos =3D offset;
 		else
 			*off_in =3D offset;
+	} else
+		return -EINVAL;
=20
-		return ret;
+	if (ret > 0) {
+		/*
+		 * Generate modify out before access in:
+		 * do_splice_from() may've already sent modify out,
+		 * and this ensures the events get merged.
+		 */
+		fsnotify_modify(out);
+		fsnotify_access(in);
 	}
=20
-	return -EINVAL;
+	return ret;
 }
=20
 static long __do_splice(struct file *in, loff_t __user *off_in,
--=20
2.39.2


--jq5mboc5m63x3mer
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSi3kQACgkQvP0LAY0m
WPHHCQ/8CWKTO+MNjS4ZRBYNto+BgHIPRE68LHKKAziWQgba9ovC43UxLtpmdVdL
fEMuS/6qGrsLY2WynXneQZapLD4Kinsf+4wDQG+iEKlhvdFDtfejYGQTqMNADrY1
D8hz+W1imgvGgIWdTUb7P3eGtZJHHwrp3/okTZWVnknevux2+3KcAMnQeJwEZxKw
Wsy+xQrK9rOdXhs4MOKlWrJWofNytkZdODeUsyzGdoe2ochw1g3FfqIOgrLLuKLj
Nmdypw3N70G7CKzO2lqI9GtgL64HRH0qpi3y+svIfEirLwQYiP+7CwxS2o94RLiT
MuEaSL7zWdhWQp8sfdE3lYd+4skNROUZiR5nRLEEOgw2/pRN6iwF8CjOVht/SL8y
f9BMP05IP86Skwf2grIuyQiJEg2UVqgMGjsmiSNXrzi6/bBiLQhOdl/WC++uuENF
8lS6cxO/x75EonzjoV/pBm4hszIb9c/pUJoqLPhucgpbZnpbGHFRzSMZ3p6FH6wO
nZ3x3/L9IRCwjyhDHzIUJvlLKlK/Gg6qjJb58uI7OUvaPtGY7HflBpfOZxLbb5MY
/1xiaqzPW8z/gnDGS26tzlAPXJoh9h8j26Wj+JNpUMoVVcmEjuFmzNtEYE6y9sLD
y5BJAAvnOaxm5y9vEJtuSEQejQEIlt0E7cVg7VgLgWh0Co1L5t8=
=0+8T
-----END PGP SIGNATURE-----

--jq5mboc5m63x3mer--
