Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FED73EF0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 01:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjFZXJG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 19:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjFZXJG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 19:09:06 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A77FD1701;
        Mon, 26 Jun 2023 16:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1687820942;
        bh=sub/f/fHhbhbOWVCyd50R46uZcOKsIBrfjQMG/W+FCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HxqwL28g71pwu+IzMPEwCvy41NJdhiKG+zYcdx2zjgKQ91pOvlul3YCIP+DzvVLKG
         f6IEv3xbPmNa28JVA/k1ED8XGqkXTn0qniqHcv3n68NlNyYcV4BwDq1lBVdOEh/FIf
         3bK5xwypKzuEqZ2REhkXsk1H3B0PYfqdQXB/M+4chFeS+ETdxatb1RXAnpN85AYBJi
         SEU0yauqTvLue95Rq252Ihl1kM7pT7uR3Q7zOFH/n0slXtIvHuXq3c1CPkyzYszmXM
         n0Efd7R1qXXshbGFMj1l4aJDkJW/joG6HztqM6DRXyTk4iPo2Ir12J/IQVsP1OCNKp
         Lh+dcGejjbOSw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id EA355CFE;
        Tue, 27 Jun 2023 01:09:01 +0200 (CEST)
Date:   Tue, 27 Jun 2023 01:09:00 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>
Subject: [PATCH v2 1/3] splice: always fsnotify_access(in),
 fsnotify_modify(out) on success
Message-ID: <al4pxc2uftonry5vyunx5qblllbaakjsehrc74fbbk7pxddyv7@gn3k55eldmmp>
References: <CAOQ4uxj_DLm8_stRJPR7i8bp9aJ5VtjzWqHL2egCTKe3M-6KSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gryd5vox5utp35lw"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj_DLm8_stRJPR7i8bp9aJ5VtjzWqHL2egCTKe3M-6KSw@mail.gmail.com>
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


--gryd5vox5utp35lw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The current behaviour caused an asymmetry where some write APIs
(write, sendfile) would notify the written-to/read-from objects,
but splice wouldn't.

This affected userspace which used inotify, like coreutils tail -f.

Fixes: 983652c69199 ("splice: report related fsnotify events")
Link: https://lore.kernel.org/linux-fsdevel/jbyihkyk5dtaohdwjyivambb2gffyjs=
3dodpofafnkkunxq7bu@jngkdxx65pux/t/#u
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
No changes since v1 (except in the message).

 fs/splice.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 3e06611d19ae..94fae24f9d54 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1154,7 +1154,8 @@ long do_splice(struct file *in, loff_t *off_in, struc=
t file *out,
 		if ((in->f_flags | out->f_flags) & O_NONBLOCK)
 			flags |=3D SPLICE_F_NONBLOCK;
=20
-		return splice_pipe_to_pipe(ipipe, opipe, len, flags);
+		ret =3D splice_pipe_to_pipe(ipipe, opipe, len, flags);
+		goto notify;
 	}
=20
 	if (ipipe) {
@@ -1182,15 +1183,12 @@ long do_splice(struct file *in, loff_t *off_in, str=
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
+		goto notify;
 	}
=20
 	if (opipe) {
@@ -1209,18 +1207,23 @@ long do_splice(struct file *in, loff_t *off_in, str=
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
=20
-		return ret;
+		goto notify;
 	}
=20
 	return -EINVAL;
+
+notify:
+	if (ret > 0) {
+		fsnotify_access(in);
+		fsnotify_modify(out);
+	}
+
+	return ret;
 }
=20
 static long __do_splice(struct file *in, loff_t __user *off_in,
--=20
2.39.2


--gryd5vox5utp35lw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSaGowACgkQvP0LAY0m
WPEDSw//ayNYath/dKwG3xqHQEgbQxT/PNnP5LsdRIbTatY1FVLYDWKyI9/6IkGm
VYDDQQwBlq4GpCY+jjK8fO+NhoscJB1FtTFcMfGbttzF6b4Nzu4cjYnacgYjGS6B
ofEB2uIc7rv0ilUz9Cst+0VsA5EBR0r9geFxGei2lVYLi1UCi3jyN33wtQ0z5c3O
b9KjSjuJjbtP3tkxsGa74icXNS3TNUOPtikVxqrWbf+UBAkN1KHom65P2GIqixjS
Fi1ic9W+K4koz5Tr7qBCSUZdwVdH2Bnkis4L8725yMfxitjX+VomqnF6ifFClKeu
8wT/iW9P+Gr7Rn4g7DN/0U2BGgvcakStGA3Gtsm9uHy6sj58yAVNEeX62r+IXU9a
j/OxUbYzzSwEMY23YFYW0QtmzR5q+TjmJVKVQtJcCOaflqz/OlfceyR2ss78UNQs
Yefl9U7FM3LVQoS78fvM4WiFNqlGwDjEeo9FdUJUjf9D4hwQcWqXOjEfXgK4LLdg
StKJfk9mOGNofI1sYgBMOZL7lnF9x7ILCdNFGRnemmkilOoWjXmPFmw9n+Dkpc4b
SHD8pdFoXCExujyeaxDm4NLZS6cmYUV9w3/l2g48t86Lxe7BpX53Eu4nf03opVF6
nN26aORRZ/Lb/OF1BUIot9VAszPtFBus78vaMxvAd240N6Uym0o=
=12tM
-----END PGP SIGNATURE-----

--gryd5vox5utp35lw--
