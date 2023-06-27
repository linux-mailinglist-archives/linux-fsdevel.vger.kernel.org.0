Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0D77401B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 18:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjF0Qzb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 12:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjF0Qza (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:55:30 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA06397;
        Tue, 27 Jun 2023 09:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1687884923;
        bh=JbdHKDIIKTI2/zLdYwnwsm7aGJ9yF1yJAJVd+rjxLKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MUO1vDXxXz65himZ9pbtz3C9L+ROPw+Lh6PGBVcZpo2R1LG+J2X1rMfA/P6bk2MfA
         YQl769QrR2gOTNNjJVLEtY57Bump4i0jvV+oeG+LqKpHnKJwazU0tFN+hd+04G02Wu
         Cm5UXQV1MOuBm3uGdJ7jU6o+smeBu4rKzXq24aWfyQcvd/QEWEgjYSHauXmT9JgxPb
         cy+UC6Vf7gGot7CszkTcPhxdu1y+Jb7mfxqz9UbYoHzb8odyQyiklbM3F4fWPGCRbw
         rwU+/Gi1+yaQrcovrHIti/GZCG6/yqUN41/TjUlSV3hMyqKSOkxCa+hXcHwP7KVC68
         lsPejDrYmTyqw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 914181A88;
        Tue, 27 Jun 2023 18:55:23 +0200 (CEST)
Date:   Tue, 27 Jun 2023 18:55:22 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>, ltp@vger.kernel.org
Subject: [PATCH v3 0/3+1] fanotify accounting for fs/splice.c
Message-ID: <cover.1687884029.git.nabijaczleweli@nabijaczleweli.xyz>
References: <CAOQ4uxh7i_s4R9pFJPENALdWGG5-dDhqPLEUXuJqSoHraktFiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f6uaq6n3eobdp347"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh7i_s4R9pFJPENALdWGG5-dDhqPLEUXuJqSoHraktFiA@mail.gmail.com>
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


--f6uaq6n3eobdp347
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In 1/3 I've applied if/else if/else tree like you said,
and expounded a bit in the message.

This is less pretty now, however, since it turns out that
iter_file_splice_write() already marks the out fd as written because it
writes to it via vfs_iter_write(), and that sent a double notification.

$ git grep -F .splice_write | grep -v iter_file_splice_write
drivers/char/mem.c:     .splice_write   =3D splice_write_null,
drivers/char/virtio_console.c:  .splice_write =3D port_fops_splice_write,
fs/fuse/dev.c:  .splice_write   =3D fuse_dev_splice_write,
fs/gfs2/file.c: .splice_write   =3D gfs2_file_splice_write,
fs/gfs2/file.c: .splice_write   =3D gfs2_file_splice_write,
fs/overlayfs/file.c:    .splice_write   =3D ovl_splice_write,
net/socket.c:   .splice_write =3D generic_splice_sendpage,
scripts/coccinelle/api/stream_open.cocci:    .splice_write =3D splice_write=
_f,

Of these, splice_write_null() doesn't mark out as written
(but it's for /dev/null so I think this is expected),
and I haven't been able to visually confirm whether
port_fops_splice_write() and generic_splice_sendpage() do.

All the others delegate to iter_file_splice_write().

In 2/3 I fixed the vmsplice notification placement
(access from pipe, modify to pipe).

I'm following this up with an LTP patch, where only sendfile_file_to_pipe
passes on 6.1.27-1 and all tests pass on v6.4 + this patchset.

Ahelenia Ziemia=C5=84ska (3):
  splice: always fsnotify_access(in), fsnotify_modify(out) on success
  splice: fsnotify_access(fd)/fsnotify_modify(fd) in vmsplice
  splice: fsnotify_access(in), fsnotify_modify(out) on success in tee

 fs/splice.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)


Interdiff against v2:
diff --git a/fs/splice.c b/fs/splice.c
index 3234aaa6e957..0427f0a91c7d 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1155,10 +1155,7 @@ long do_splice(struct file *in, loff_t *off_in, stru=
ct file *out,
 			flags |=3D SPLICE_F_NONBLOCK;
=20
 		ret =3D splice_pipe_to_pipe(ipipe, opipe, len, flags);
-		goto notify;
-	}
-
-	if (ipipe) {
+	} else if (ipipe) {
 		if (off_in)
 			return -ESPIPE;
 		if (off_out) {
@@ -1188,10 +1185,10 @@ long do_splice(struct file *in, loff_t *off_in, str=
uct file *out,
 		else
 			*off_out =3D offset;
=20
-		goto notify;
-	}
-
-	if (opipe) {
+		// ->splice_write already marked out
+		// as modified via vfs_iter_write()
+		goto noaccessout;
+	} else if (opipe) {
 		if (off_out)
 			return -ESPIPE;
 		if (off_in) {
@@ -1211,17 +1208,14 @@ long do_splice(struct file *in, loff_t *off_in, str=
uct file *out,
 			in->f_pos =3D offset;
 		else
 			*off_in =3D offset;
+	} else
+		return -EINVAL;
=20
-		goto notify;
-	}
-
-	return -EINVAL;
-
-notify:
-	if (ret > 0) {
-		fsnotify_access(in);
+	if (ret > 0)
 		fsnotify_modify(out);
-	}
+noaccessout:
+	if (ret > 0)
+		fsnotify_access(in);
=20
 	return ret;
 }
@@ -1352,6 +1346,9 @@ static long vmsplice_to_user(struct file *file, struc=
t iov_iter *iter,
 		pipe_unlock(pipe);
 	}
=20
+	if (ret > 0)
+		fsnotify_access(file);
+
 	return ret;
 }
=20
@@ -1381,8 +1378,10 @@ static long vmsplice_to_pipe(struct file *file, stru=
ct iov_iter *iter,
 	if (!ret)
 		ret =3D iter_to_pipe(iter, pipe, buf_flag);
 	pipe_unlock(pipe);
-	if (ret > 0)
+	if (ret > 0) {
 		wakeup_pipe_readers(pipe);
+		fsnotify_modify(file);
+	}
 	return ret;
 }
=20
@@ -1447,9 +1446,6 @@ SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec=
 __user *, uiov,
 	else
 		error =3D vmsplice_to_user(f.file, &iter, flags);
=20
-	if (error > 0)
-		fsnotify_modify(f.file);
-
 	kfree(iov);
 out_fdput:
 	fdput(f);
--=20
2.39.2

--f6uaq6n3eobdp347
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSbFHcACgkQvP0LAY0m
WPH3ZBAArBN/sYgOWaVpxfOvMsGOhp9aYKSVVR44HMgkx6eWFL3zMiTBI2Ear5as
0CMjZGJFhsJeDRvM/r06vOC25axhDrxFDtuL7+4X79DmehbnXlrgUWo6HmcK6tFy
uATiSVA+JeMqtO0P6dxwLNoByoeJN5nAxRNcq19fsHhhgMBhnNUxbj6vNSLAv/aR
krW/EN4aNI02eEbib2xzc5xOWeq351bYfCqYFYRPp4B2mbMeGtnNfVLwVO56A2fN
bIpNR3EmqgygLdDfrJLHh/H8ywsYR/+GLWRvGq6PB1F3EbxBhzlgH6ACDJy2Juv3
5yZrvbrDLCdwXgiEZ/Q55Y1bq4nehwr1OA3otzPUaUWU+v+JnMnt0QFjEIFgp6v/
rCt7NCbaEcRfvqQ1INsAQBZY7e2dKc21qq6k3W4oBvRRv2XGWEhpiYeUv41d4Qqr
Tx93C+CuHHY2HdbrDtoHWvJ+IrXCInUD6elAGQ/I7nODsWxgm1QlSIN8E0X9qSym
v38HwiEJxtIB2ydBspYvQi12Zs5Yb5g7dv96Klra6rnFAdE5DMwjd2ZZcQzl8EQy
9A0XSkDRfK/mkxWc+v0bV8uniE2M8s9WoJQpZleFlNFWpKvX6Xg1UEOb/YLMgCnZ
811ReQuztcWs1ZzfQW0ddu3jBO1LMBGHgqNw+pI54dNBJNCLN9M=
=6qu6
-----END PGP SIGNATURE-----

--f6uaq6n3eobdp347--
