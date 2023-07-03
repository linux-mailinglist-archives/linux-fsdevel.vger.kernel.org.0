Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5033745EB3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 16:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjGCOmV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 10:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjGCOmU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:42:20 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 428C3E5C;
        Mon,  3 Jul 2023 07:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1688395338;
        bh=bxFjauUq2WL32jHSPjtbjDPG477Jdv0YrEDq/u80aBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AhrIA4bpNXctnbjB9zL/sj1rGqhNvu6fT18CYncnYQWpQSIoov7xveEfjOSjqjLPy
         zFtA91S2is2jbaHqb6RgRM3K+YTrqhLPanrW513653hGfBScv8jheHZe9kn0okLZZJ
         XKA+JI+Yg0gIQrMPbxwRdGJ9k8THmYYI2v3APzNvzS8NqREcJzHyi8SqAHc1REhDAb
         TdXAgU+ldh/kaK3eaOOH/XDcfCLjqBQvtKHCWbxiQdr3wWsbCEEtQ7uT4FVP57VCL3
         kYYXfuN2yUQWehsiZ/iLwv1fgzmh7N4qgxt2MBp0PUydMkBLfKNDQ2tHekvoqg0yO5
         EZklTMJRFR6dg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 8FBCE1B6C;
        Mon,  3 Jul 2023 16:42:18 +0200 (CEST)
Date:   Mon, 3 Jul 2023 16:42:17 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] splice: fsnotify_access(fd)/fsnotify_modify(fd) in
 vmsplice
Message-ID: <8d9ad5acb9c5c1dd2376a2ff5da6ac3183115389.1688393619.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1688393619.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ybsrpykphwaki6lg"
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


--ybsrpykphwaki6lg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Same logic applies here: this can fill up the pipe and pollers that rely
on getting IN_MODIFY notifications never wake up.

Fixes: 983652c69199 ("splice: report related fsnotify events")
Link: https://lore.kernel.org/linux-fsdevel/jbyihkyk5dtaohdwjyivambb2gffyjs=
3dodpofafnkkunxq7bu@jngkdxx65pux/t/#u
Link: https://bugs.debian.org/1039488
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Acked-by: Jan Kara <jack@suse.cz>
---
 fs/splice.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index 6ae6da52eba9..5deb12d743b1 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1346,6 +1346,9 @@ static long vmsplice_to_user(struct file *file, struc=
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
@@ -1375,8 +1378,10 @@ static long vmsplice_to_pipe(struct file *file, stru=
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
--=20
2.39.2


--ybsrpykphwaki6lg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSi3kkACgkQvP0LAY0m
WPGb/g/9GGTQCA3sX50kUiY44a5rX+Ff2TYxykNMrLWb5vbRU+KcvUQeMpXDOWiB
a6I5vSYTnbLemmo7VVKNUPAtN85nKRu8k30QFlYPA8nBXOBQhnfa+mu6hYzEEPZ/
oSBTcdj4eNtgDExIfQ9azx7onGtPQ/W8B4q6sXWSEy/olpqYZEwbT+D9AqZNYj+k
VgcFI+dtbSw/fk03vhihniKRLrkue9vyDdkhYDuwvCLyZ0FO/W4Fnp73NPrz54g8
oUdYaOR4wfDYaFf2Mo++4wRlNsBxsVsC8+VMQKPsx2MNuyGUH1o+Hus38/htUGVk
DjMp/P6icRwWLZ8+SWt3qpg1POt8voICR6OuI8JvutiHAZiMcyKvyA1vDe8Oi3sf
//uzGtAyoKd2x1AybJMoYnMTdV1j8PJfxBH+8VVh6SCTCWdGcklifS2TyWZShoCt
F9tKIBayhCOyEHesQQjMiIG5N2BiOnkX9Zr6gKrXwT2wFpeedAZIW4tl4af8Hv9G
1VrnO+hSsA5bLg77KgXlO3sYMLiQsW9oG3uTBds62ownw1xroMKNGIS0hHtNYk8V
pUdfLZyUfbc/Kx1S4Wxz1isLdmN7dBuBj00o195RgrcsTUQhIcAYuX6c2+/CI+OC
pcfVrAylsjVNMqyKwNC1ywpWxsxzMWmUaj9UQFPeVuuKkdqcG7g=
=BYux
-----END PGP SIGNATURE-----

--ybsrpykphwaki6lg--
