Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8719E73EF13
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 01:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjFZXJb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 19:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjFZXJ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 19:09:28 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D5BE173A;
        Mon, 26 Jun 2023 16:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1687820960;
        bh=ahR55X1tMPjwCkeOkwkz+mlJGXSwvA70sfFtKUTZ6Ss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aKRjZtezVd/LhdXkFG54SEwZN9ryQa8wFlxFxLBNvRD7v+XexIoRNNaWsxwWiD7KK
         SfwbA9gGZk/Wbd6xAEEM7d4ympWN90GKQOKfqcc7gQx1v1O0rD8m3ShhrlCO6w0GKt
         Lf331rDdyp1lrpT4cwdlSw/Ubf4bRQ2aUIUUtWNKetPOwUsVukkO5CzuuXxQy+BhlU
         qxDF3gIzlTk67ee5x01nR6CsDA9jHF0y2Jzd5fa7KIHTo4SVvZOP+Mx06mY+C5Z95p
         lH/WmXllzukRrcycICxqvzp4yqNy4iNX1UthdMYk4NEL5yL792W8QKb4uaHHsicrZl
         3AS76GIikN2Pw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 591DF179A;
        Tue, 27 Jun 2023 01:09:20 +0200 (CEST)
Date:   Tue, 27 Jun 2023 01:09:19 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>
Subject: [PATCH v2 3/3] splice: fsnotify_access(in), fsnotify_modify(out) on
 success in tee
Message-ID: <sun5nn6nzp7cvn43m7476rchcel42zuxv6mo2fab6tu24wc2it@intt5usuvpoq>
References: <CAOQ4uxj_DLm8_stRJPR7i8bp9aJ5VtjzWqHL2egCTKe3M-6KSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6v2kz5au4jz2wk57"
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


--6v2kz5au4jz2wk57
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Same logic applies here: this can fill up the pipe, and pollers that rely
on getting IN_MODIFY notifications never wake up.

Fixes: 983652c69199 ("splice: report related fsnotify events")
Link: https://lore.kernel.org/linux-fsdevel/jbyihkyk5dtaohdwjyivambb2gffyjs=
3dodpofafnkkunxq7bu@jngkdxx65pux/t/#u
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 fs/splice.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index a18274209dc1..3234aaa6e957 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1819,6 +1819,11 @@ long do_tee(struct file *in, struct file *out, size_=
t len, unsigned int flags)
 		}
 	}
=20
+	if (ret > 0) {
+		fsnotify_access(in);
+		fsnotify_modify(out);
+	}
+
 	return ret;
 }
=20
--=20
2.39.2

--6v2kz5au4jz2wk57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSaGp4ACgkQvP0LAY0m
WPG5ZA/8Dbc7CGTaG57JDKhdUPyBj5PUFwjx4sYQb1fqYm5MfazsqrGgnak/pIYq
o7tEk7VIxw+I/7lJTACJdYJXsIVjPx2UQxgEwPOXz+jjcrDtg7shfHy6GbfePkkU
5orMzvl3GUktNpK8X8POtiZL43H7oVudaQepEYjPlvGOh8urxqDRdK0lIis8tq9o
rqN+XFjvcWucCIO++nw/HsGKjrH4BArNFGfq8el0MKfVXUxAYxIpCQu6EFPeC1og
odvfHi6Dbl11eoSQMV/+9VD5bYSgXVyH1sZ7QBxiYueOK6Bycz4t7e9ICdlbLFHC
BT+CxTXCmujy2eRbH7WyROcNPjlLNZK9FvkqPzPSDfSqlS3h7iE+bqFBcPEWqVj/
11OU4AdJ7EPvUxMkkupeJ/0VmX38ZPPASkMf9iRHPiehxkXh2fR/nQtO2APIW6Sx
HY/gjDkBp3qrK2zk/3EySoC2bsKewOzd9kBp+/tmomuRU1iQkIDXz3RNeENS1T5m
yn9kKhAC+357rfbP2LpKECYfYMRpBsm1z8e7p5wfy/8yo1pwsfC0qwFMd6EgJFhb
GOjQtz33DLBTXqqEKOEYFOjVrHUqCTcbyXYrOMvbrRRn4DBaS1V6SBvAwqekPLEw
GgYcj5oP9JV0u3z/bd/Xf2fKMNAyr1gBoI5JzDM0WDdmNebUV/g=
=dHgG
-----END PGP SIGNATURE-----

--6v2kz5au4jz2wk57--
