Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62918740536
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 22:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjF0UvB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 16:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjF0Uuz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:50:55 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92EA9ED;
        Tue, 27 Jun 2023 13:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1687899053;
        bh=qCdQpza0vGDqNSdxaU8DpurpP2cGaeH8ooUq+QibGG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c0yE1oTLMDmySbdvOBrMfwjecFrriPS22m25V4FrQ9pdR/RLc0J93Q3wNpU+YwTMx
         5eegks9sgfjtmCD4RzXALcaMHBXL6L+zmZ7YgPOofSKJYravKbeg/2UnKxmzuTfxAK
         K16wd4fd9eIAoXfm+ZW35dh6NI3E14NjI0yz3y/WS7sb2wVDUIUaHgjMMNGhfveWw1
         3vNqt0CseE0IcRJWEdHxiY0IQGuIAe0KahxXq+csSiAvUr9OTWq1TCckCCdxRCqyRA
         8v5XvojpVaDT2nn9XR9eybkbzh2+MqZ5sEYH+wOjf4mrVCx31aFDxTGbh51yaZwS+F
         Rdl6dG4WDtWSw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id E0BCA12C6;
        Tue, 27 Jun 2023 22:50:53 +0200 (CEST)
Date:   Tue, 27 Jun 2023 22:50:52 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>, ltp@lists.linux.it
Subject: [PATCH v4 1/3] splice: always fsnotify_access(in),
 fsnotify_modify(out) on success
Message-ID: <e770188fd86595c6f39d4da86d906a824f8abca3.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
References: <t5az5bvpfqd3rrwla43437r5vplmkujdytixcxgm7sc4hojspg@jcc63stk66hz>
 <cover.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="okjxcfyce7hzio6h"
Content-Disposition: inline
In-Reply-To: <cover.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
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


--okjxcfyce7hzio6h
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

Generate modify out before access in to let inotify merge the
modify out events in thr ipipe case.

Fixes: 983652c69199 ("splice: report related fsnotify events")
Link: https://lore.kernel.org/linux-fsdevel/jbyihkyk5dtaohdwjyivambb2gffyjs=
3dodpofafnkkunxq7bu@jngkdxx65pux/t/#u
Link: https://bugs.debian.org/1039488
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/splice.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 3e06611d19ae..b5c7a5ae0e94 100644
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
@@ -1209,18 +1200,19 @@ long do_splice(struct file *in, loff_t *off_in, str=
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


--okjxcfyce7hzio6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSbS6wACgkQvP0LAY0m
WPHc8BAAiRgaEMu5j8NBZ26GC5jSWsGL7PG7bCp8lcih9HplvlNs0O6oa/O5y2IU
zJX0Eb72Bd8C7qM3y3PNjG7FGYBpQLrw1dy2aJNHPRhbLlDl/OASXo3XmBH9Re+p
NDahkSbVOne/P1y1k6FbaIAo7w1/rf+GMVRCmVNPC4sXJqTqwZ38TO4zdc7YxE17
2MojK2F/N+hJK1kEI8fYkZTJ27eEcRCglNvNgdTrs3EYUB86zklbs/JH3hn76Ev3
Xq+VTO9qXR3cNr2In9/SUWyyjoLnha/zDiqqbkboUBDn0Gird5VgZ4tzvcJGurc4
dB2/yQgpXT6Eye82QDAQ3mKDwIsCErw/pWayeZMgE2QUu6PgBxBBKIjxS+yZ+jDE
IgTLEuPGy66ebTu6YUA4oH8EwSUwA5QTsdc9UFSV6yD5x859mdjXTRgH/z+QeyB+
FTlUlE3AhXkkWzCu0fx/wmfzeGavy+SYRT1yV1iG6TXMPUx1t7mTco+81dz9SH54
zvsHCwI95S06KhcBEU8rbiuTDb0WnGXoTFafJtRwMmP7M7bfhCOiqmm9Mk3aWzxn
nq2PoaMLq6W6VY790IE/brJ0aJ7GmlqKYX702k1sttKsUtPGmIG1v2sKxUQqlOJr
cma2luu4VLCsTkQE4rF9qti4eCww/jv02/upA3JxaGUEuW+qoyY=
=rgjr
-----END PGP SIGNATURE-----

--okjxcfyce7hzio6h--
