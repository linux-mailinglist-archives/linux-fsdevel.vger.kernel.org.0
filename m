Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF9A73EF11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 01:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjFZXJT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 19:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjFZXJO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 19:09:14 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F77E1701;
        Mon, 26 Jun 2023 16:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1687820951;
        bh=+Yr5r5tG9lNpcgAHvStT9mCUIkD4YLaRJRy3M3c4Tqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hxU83TaBoEaA02pAlqIgCfA16dHrOofbg/dUHxRm+2un6Yumd2364qaq5EXEWuAij
         632S4cpDA3idsBq2OkWgVzcdLx0NLSFfFLqV4JLRbW4sRySMe0cxU9B+DABZJt+3Yi
         crgWARtpmWtnl0jjDkWNrTd3APkR8P4cuSRusIiLNDtMdjE2z2PlDEJLLtWcEjnIZS
         b1+17vzZ6LmLyx8prL6gS0LNg/Bouspz32sLX4IcYx+30+PwCXhOmVxKu063ltZFXo
         TcF12OEfXHCrHAO2sK3pdaXjrZOwHFewL4oQfa2GfPldDWwlcOraU0lJiTIjDQPNwe
         gWc8+LPpbST1A==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 70917EEE;
        Tue, 27 Jun 2023 01:09:11 +0200 (CEST)
Date:   Tue, 27 Jun 2023 01:09:10 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>
Subject: [PATCH v2 2/3] splice: fsnotify_modify(fd) in vmsplice
Message-ID: <raezzuhjjoddoc5tsln2bg3rkudczwou4jjfq6noeawrtn6jre@uvf4rikifzpx>
References: <CAOQ4uxj_DLm8_stRJPR7i8bp9aJ5VtjzWqHL2egCTKe3M-6KSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sl6ezw3kqbrv7hs4"
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


--sl6ezw3kqbrv7hs4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Same logic applies here: this can fill up the pipe and pollers that rely
on getting IN_MODIFY notifications never wake up.

Fixes: 983652c69199 ("splice: report related fsnotify events")
Link: https://lore.kernel.org/linux-fsdevel/jbyihkyk5dtaohdwjyivambb2gffyjs=
3dodpofafnkkunxq7bu@jngkdxx65pux/t/#u
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 fs/splice.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index 94fae24f9d54..a18274209dc1 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1447,6 +1447,9 @@ SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec=
 __user *, uiov,
 	else
 		error =3D vmsplice_to_user(f.file, &iter, flags);
=20
+	if (error > 0)
+		fsnotify_modify(f.file);
+
 	kfree(iov);
 out_fdput:
 	fdput(f);
--=20
2.39.2


--sl6ezw3kqbrv7hs4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSaGpYACgkQvP0LAY0m
WPFpLQ/+NNdkAGrPyNGGP/W7H/qoDhlAPxj3lbKQrFSAax7f+KeVgh7t6jvNL4Ie
tw+Wh0Hd9NsUCTtPeX8kLZ8HDkVBtB02itaMqraiLk0E/qhwD0Y1a4XCZWhtwHVo
pzpBmO29pMQXPVpXUE+fNlArc9Fk//ZOkqMPCI7QW8vp2CWy9W1L9Q8RCfhP3crR
WaiRqYiXWl0vuqvbcTBD4XTLnLGiDGOi85GEmwdFVcIMgVNk03b3szm2q8Xud4Sm
U1jXI6TyiZzU4cI77RuGqCIqeEJfH8r7BzJQtRHHCktc4QD23HROwq8zB3JtUhpZ
l61a37XYkFPcIrhKE6aPd39iZIVJE0tS/K582E9PWuNeEs0/mIW4e8cX1BWIA+ur
3yRJ03ah7Y2j00V5l/W/ahyCwWqgT2BscCu9knaWFsQPthc+vL4uv/iCH2am0Jsb
lGiKpTlHSlZhHfUYEunUYX0XSc7WbXFULsCbtf6ErOtApjtSLk2HHHVoCoifMux5
e2px3XQIk7UmUj1y7JbkPYzyKJk71hig3+IpGg1kB2TUtXH8pXiqBU2OPsMcL+27
PQxzafvV3mPDj8hlL2chX1qaJc6eMyTNugd+BiuNpbqH9NdK6YVbbJXaiKrJ8DqH
GFnDxRamv2iUK1SuGINK2CoNbeWM7f3/IRNbv/yLRj+58S3LgfA=
=QL7N
-----END PGP SIGNATURE-----

--sl6ezw3kqbrv7hs4--
