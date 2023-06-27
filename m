Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C3F7401B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 18:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjF0Qzw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 12:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjF0Qzu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:55:50 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A705310DA;
        Tue, 27 Jun 2023 09:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1687884946;
        bh=Ry0ApNAVb50SUY2QJyeYNcjESfCK9nJXD87gDEkJ+YQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OnmsF1+lOLEYVPB0NGmpzo/9sxh+1my+cdRFWzkAgwdL2Gjc9fQeYY0ktoQQHvOF6
         NJHHNKgE8W8LNqitno6cUX0tn5ZTFXrXUgOJzeL9Ce4A8L+O3+yLBBWM5P/lREF/ES
         rVJoOiR2BPG0egC/DV3Hm81JPAYXyyDJGQFruoreds1yB+49Faj1NvUNUXPMcSo+Yw
         7Sixjr35wmqyjMo2VIVcyjB+00hG2KoPT8/IdCvly9m4SFoZjAS5xk/Yb7EQj52fBL
         o2MvmhtZep+VL7fforI3aTqC3BnD4m8oLcqIXlDC/QSpeJ6sFAseZeQnATxRnfcU2q
         CDn8aXOjjo8ug==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 011EC1A8C;
        Tue, 27 Jun 2023 18:55:46 +0200 (CEST)
Date:   Tue, 27 Jun 2023 18:55:44 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>, ltp@vger.kernel.org
Subject: [PATCH v3 1/3] splice: always fsnotify_access(in),
 fsnotify_modify(out) on success
Message-ID: <8827a512f0974b9f261887d344c3b1ffde7b21e5.1687884031.git.nabijaczleweli@nabijaczleweli.xyz>
References: <CAOQ4uxh7i_s4R9pFJPENALdWGG5-dDhqPLEUXuJqSoHraktFiA@mail.gmail.com>
 <cover.1687884029.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="em7yhc3dev4sboup"
Content-Disposition: inline
In-Reply-To: <cover.1687884029.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--em7yhc3dev4sboup
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
---
 fs/splice.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 3e06611d19ae..e16f4f032d2f 100644
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
@@ -1182,18 +1180,15 @@ long do_splice(struct file *in, loff_t *off_in, str=
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
=20
-		return ret;
-	}
-
-	if (opipe) {
+		// splice_write-> already marked out
+		// as modified via vfs_iter_write()
+		goto noaccessout;
+	} else if (opipe) {
 		if (off_out)
 			return -ESPIPE;
 		if (off_in) {
@@ -1209,18 +1204,20 @@ long do_splice(struct file *in, loff_t *off_in, str=
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
-	}
+	if (ret > 0)
+		fsnotify_modify(out);
+noaccessout:
+	if (ret > 0)
+		fsnotify_access(in);
=20
-	return -EINVAL;
+	return ret;
 }
=20
 static long __do_splice(struct file *in, loff_t __user *off_in,
--=20
2.39.2


--em7yhc3dev4sboup
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSbFJAACgkQvP0LAY0m
WPEhahAAm7tA4VlQ9bzYw7H9brQ8LoRUJu/WTbyLhPf3jmahkQ9zGw4QAj3Bx68C
r3VEkvF9s93RZ8v/w5xTlWthfd+EvBCcA4MceIDzHxrYxo8D5OefqSNa9ObbnDrG
aRs+8uxR7RX4JHhC1sGj5LwlP7s15Pjpv5SPDttWlj2ED6EioHQwi0RgIBy8gLe3
jdUan3760Vz9CUMleyWXMTZ21TGIzTmo2UB2Qvbp1bQxyUA6me60lRY8ELCnzmpz
ZxIElS3SuCAsMZMkH80v0yqyarU95KuncASKOU08Qlpfrsve/bZD3mYMJRJmxdt8
LlePegbALgCUw/dh8LHWE51NZnX719Amuvdga68vbTsFQoDFgdZfZhkrA/3Pams1
x4Kx3OO3AdpD1UiHX+PmWfje9JpNHuxXXiRIuLiDNqmOOm1bjaCMWJjwx/rs2a33
kkL+M89npWNK53/1+5zt1quyDu8vNaJArrs4hmDwlCGILKHDdYR6lMIy0wZzWooZ
fK5dq1UAIiAAu/3jKGiywLbQrOGHb3mcKr34QZe7vYb/jcX0S94hcJfjPaJMdruh
0ZtpLIIBLVFr8mvmXm2y3zorl9CVKg4OzHFnV1nyKnh9jl6za0pacNA8SpfP1mg8
SPWZQpDgLteAW8WDgeD6bd0fCCs2PExkRm8q4pjIW/jE2dFIQiI=
=7mBM
-----END PGP SIGNATURE-----

--em7yhc3dev4sboup--
