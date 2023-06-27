Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59887401B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 18:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjF0Qzy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 12:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjF0Qzx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:55:53 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C6ED10F;
        Tue, 27 Jun 2023 09:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1687884951;
        bh=zaiiTIQm+Ka+TX+0vYl9PnxvGYZU7w8NqATlroNC6p0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WdMG1sm5NRYxvt8I5gq00DBkYKI3Q4MObBBsJbYbOqARD5a59yVLVqXWjEAMyxcRD
         Rh8oa93FQxAJBISz7ANoEICJf6GgApt42SYAZPxqLvX7dzSI0+rcZm7OdjR7dl6idW
         cc0RqjU+ghJV/0ITRG/Xfc8uh1cIQq4G4HDf7d0t1VOtaTkZErVTo5lnP8oJ/lhn8w
         /q57QcwV8wqexSrRO0lN212HReZZ771YSxo9FQie1eJ2AzDE2uwiugXgQRHVt+Y9KU
         8l+5Qln1fSGx4g5ZAeCjHVZRrmSjCjVt5JwaXiqLt/xOtT678NxnQ5lohqkeh/2P5C
         MeKiMorEgQZGQ==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 6E44B1A8E;
        Tue, 27 Jun 2023 18:55:51 +0200 (CEST)
Date:   Tue, 27 Jun 2023 18:55:50 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>, ltp@vger.kernel.org
Subject: [PATCH v3 2/3] splice: fsnotify_access(fd)/fsnotify_modify(fd) in
 vmsplice
Message-ID: <4206d7388fdbee87053c9655919096225a461423.1687884031.git.nabijaczleweli@nabijaczleweli.xyz>
References: <CAOQ4uxh7i_s4R9pFJPENALdWGG5-dDhqPLEUXuJqSoHraktFiA@mail.gmail.com>
 <cover.1687884029.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cpbjxknbnzpkvej4"
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


--cpbjxknbnzpkvej4
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
---
 fs/splice.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index e16f4f032d2f..0eb36e93c030 100644
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


--cpbjxknbnzpkvej4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSbFJYACgkQvP0LAY0m
WPGKpg/+P1CWa054iG0eUAuibLGHKkDfKfxiOdTlFq9wnUd6z5Kf3Lu23aL8QjBM
DM2DQ4MRpfsqTtFUFt2GNbR9jfjGpSbBpOB6gm0oIkxc5agoj6q3QrI5U3eaS2tk
LRXYirsceM1eTe3aNnxuiTgH3mbGy11dTsiQQca5B/E1HoHB0w7jkHfRIbPKR7vE
ZGeq33QEZnIDhd/K7LGQtkLHONKI50wyOx4heq9uPsP6kb4AlqLlUgjQ3lQR+Pg0
y0cHK3vkcx2uxLbsJu8bdzym18QZRmUPu47iwoqitrAbVeXy9Yp3qqgZ2nXTwCVd
RzIc8YL4sMoLnV1hC0c/LRQfycQLihkP1+Er0AI3fRoGJ8YoIdiTYUKc7IQSwLgM
trpMMichcXnbJDE9gAUD+6xRws2pD02Au2Op0bh1MD8qyuOQ5Cashx68X1mmsdSV
e1Ph2RQbQo5/tjyoHS/oRB2ng2a5dnYQdomI3VeTjh2rmsksqGPVSB+G1d1xEE8q
DL390ZMnSSyUD56kdxmVcUQiZdVyuDBf/Q3OAB+ZBSEXYUjE/leoZLD1EgPECrxB
LP30SNOsKe1V0no4/rf2IBpyAzCD6Yv0hXi30VF3jobxBnl7jnBUId84oeRKXwbk
BV3ZK70o/4eDqdpxN2uEvViRvp8rCzU17wRD1DzDbnoN4gQ743c=
=DRDx
-----END PGP SIGNATURE-----

--cpbjxknbnzpkvej4--
