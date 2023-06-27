Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F88574053B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 22:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjF0UvO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 16:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjF0UvK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:51:10 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAC782D54;
        Tue, 27 Jun 2023 13:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1687899065;
        bh=3nrkr9p7FZVJ/pMwJqhBp8M6P5Ay4Bhj6H5jTZYvtg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lvGWVQNO8/o44Da7YlQ8itfHbwOsJKP7c9R3/eoLHV9YZ+bz8Pwa7lyyeUG4z/Lts
         k9dtOx9BBVqNTqj0eDSjtO4RFZJfgTyJgAiP1asbOmVyPwQSdy69gmWpXyhaliDRfm
         ao5/U4tIKuHJb2EzDYxP8N6YJmvkt/bseDXA8JNV0+cLoXfK7IKHHcuc6YfHlOcx1U
         /t95tPT0rtvQ9IOE3ft4CCMuEAJX+GEewOY4bNkUzkaQvnn+AL5iZpC8Cei/HcQT/8
         zLplP+rBntzTPAgvujTofXMYXw7U8/XpaPFRsnkwRcZbX/iqMK3yyH2FiZtHrZP9Gq
         eJNHIUkf8Q1iQ==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 263C81536;
        Tue, 27 Jun 2023 22:51:05 +0200 (CEST)
Date:   Tue, 27 Jun 2023 22:51:04 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>, ltp@lists.linux.it
Subject: [PATCH v4 3/3] splice: fsnotify_access(in), fsnotify_modify(out) on
 success in tee
Message-ID: <1274d6074fdd2ca4e028c8b62e42d0ef2b847703.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
References: <t5az5bvpfqd3rrwla43437r5vplmkujdytixcxgm7sc4hojspg@jcc63stk66hz>
 <cover.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4ot4an2wv4srdmhm"
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


--4ot4an2wv4srdmhm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Same logic applies here: this can fill up the pipe, and pollers that rely
on getting IN_MODIFY notifications never wake up.

Fixes: 983652c69199 ("splice: report related fsnotify events")
Link: https://lore.kernel.org/linux-fsdevel/jbyihkyk5dtaohdwjyivambb2gffyjs=
3dodpofafnkkunxq7bu@jngkdxx65pux/t/#u
Link: https://bugs.debian.org/1039488
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/splice.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index d3a7f4d5c078..bdbabc2ebfff 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1810,6 +1810,11 @@ long do_tee(struct file *in, struct file *out, size_=
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

--4ot4an2wv4srdmhm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSbS7cACgkQvP0LAY0m
WPGHoBAAuEr2KQDe9rtumdeeAh4Ffl/KEpS/Bi8/idfGipB+ouXMPgw5YvEzycCN
SczBs3/Iw+E/8CHFuXJN9XFrj0GglDr/cYmH0qmZ1ljmKnQUa/P6iRmPhZErr8lv
hHVtfszJGBb2MInCUmEom0SZjZloyvQLtipSabeasgrtBf8prBZcOdjvnzIolGKq
T2IJ2v9xP2ijrNavdvxcO66Gh9ibnQqYAyZtajaXek0qyY0RJoSY7V5N3RwGLQuS
cDsn9fiXYH91zB02leNyzQySWSnS7EIcG1NeSi4SL15ZD9s0srr6LuA5oWBiZBNa
oMTG1zjE2/F85qMEBuCBpFeWw4EHXgVs8XU6XSQXxwSzRHpbPbCOJzQvVNfANVAe
UN61cHxHSPePvWNUG4hnPTCP7ZyTPvNNxVzZ5T8XjT2wAYjTR39bxJczN2wrZkfV
ASrgDVj4mQlReuJD2IWt9S9NTtSzU3TOqWxGi0jXt3m+dxArFS8WW/YK0fmJ2yaq
ZfuaoEEV05G2hqXPvdW3FHFLmdFqG7JlCJsA3gat05z3GttSRmDQaQRDy6CJ0GbW
eSgfr9yFp3ZwuDxqTfWz3vOr6VtX3HHx8n8lRTzzuoUS9iaWW3uNTLYEaEak2koz
nR6OJn7z2/mQ7+gX8GqJMEmnf7UcH1zTTG2xPukKB9bGaYhPVvU=
=CovH
-----END PGP SIGNATURE-----

--4ot4an2wv4srdmhm--
