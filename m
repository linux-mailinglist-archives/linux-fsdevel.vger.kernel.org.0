Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224F8740533
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 22:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjF0Uux (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 16:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjF0Uuu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:50:50 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 194BBED;
        Tue, 27 Jun 2023 13:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1687899047;
        bh=zhLge2fIvDMjALdhMD05+tueCYzIk6/Kl0MFRGFrYIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xz4XR+XhvVLaJ53FyxpTAVg+9gCf9wr8ep7qkuA+qDeraK1HpJ1LFDrexTiH/h75M
         fiPAAfxv9YULL4NL+HtBNQ+TLY/cMJW9zfR72jw0vJGQdyX71kSN1Ja9b7DcQRIX6G
         uouB8Cz9aeDP7eBTLwVKcuV6rZujjsk3IK7oP6v2ncr7dQrxnzRF+ky+zdW1ZYlgDh
         gn4fp6+g/5C8ftj9KCKTfTjJAoUmRxsQblZGus9n5v4zfWvKkgCPmtOpi2KZTM+e3P
         qYtGNNIhsd0Rq2Jcr1BtxCpjBzPYw65ZiD+sf7wBX8HU7T8EClw/kigOXlHJ4y8Tlj
         P8WKYPLisSabw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 55DF412C2;
        Tue, 27 Jun 2023 22:50:47 +0200 (CEST)
Date:   Tue, 27 Jun 2023 22:50:46 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>, ltp@lists.linux.it
Subject: [PATCH v4 0/3] fanotify accounting for fs/splice.c
Message-ID: <cover.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
References: <t5az5bvpfqd3rrwla43437r5vplmkujdytixcxgm7sc4hojspg@jcc63stk66hz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n5hw2fxp2pfe5yae"
Content-Disposition: inline
In-Reply-To: <t5az5bvpfqd3rrwla43437r5vplmkujdytixcxgm7sc4hojspg@jcc63stk66hz>
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


--n5hw2fxp2pfe5yae
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Always generate modify out, access in for splice;
this gets automatically merged with no ugly special cases.

No changes to 2/3 or 3/3.

Ahelenia Ziemia=C5=84ska (3):
  splice: always fsnotify_access(in), fsnotify_modify(out) on success
  splice: fsnotify_access(fd)/fsnotify_modify(fd) in vmsplice
  splice: fsnotify_access(in), fsnotify_modify(out) on success in tee

 fs/splice.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

Interdiff against v3:
diff --git a/fs/splice.c b/fs/splice.c
index 2ecfccbda956..bdbabc2ebfff 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1184,10 +1184,6 @@ long do_splice(struct file *in, loff_t *off_in, stru=
ct file *out,
 			out->f_pos =3D offset;
 		else
 			*off_out =3D offset;
-
-		// splice_write-> already marked out
-		// as modified via vfs_iter_write()
-		goto noaccessout;
 	} else if (opipe) {
 		if (off_out)
 			return -ESPIPE;
@@ -1211,11 +1207,10 @@ long do_splice(struct file *in, loff_t *off_in, str=
uct file *out,
 	} else
 		return -EINVAL;
=20
-	if (ret > 0)
+	if (ret > 0) {
 		fsnotify_modify(out);
-noaccessout:
-	if (ret > 0)
 		fsnotify_access(in);
+	}
=20
 	return ret;
 }
--=20
2.39.2

--n5hw2fxp2pfe5yae
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSbS6UACgkQvP0LAY0m
WPEIMw/+JWEOYiu+hu5odjWLPEeBk1HxJLjWW/mnA5+RwtNhT6WM6079tZKVNNhj
zhInTK49LjQX8Jwsi+uZUlCtFipKmQUv2poCx+6jA5TeaDeBXblG1Z6uNaMTDuOA
oQG4uVxrwVtU56eKvllHj+BmG7pJbdGmrAlrRe9rVXemRw939VrVYKds/RUrYego
uoxuW8pG1SZ26TnCf7FnRIDAqQsS1p5TE2YbUqF2SL5oCqrzyjH2KbHCG6GWXv8J
FN4bcKcgEjCieAuKafa9htfQxLlGkOA58szfhC6EYkVqn2VhNqDBmFRI8vOH0aHh
BaKveWDJxNmNxD1hSJob6rZpG7qxLgjcwVUaDt0BOL2I8YAMTUW475DhLkJO+ucu
dDSZZOUB3hTexBUi8o/dnFUipR4/PZ+fAFY7G7Pwof5xopTsOf7BfNl0Ev4cd4RD
oTO5qlaLl93iZIfQ8oMmI0vRntKfxvQ5nrTOclDyJ3uh0jdtYSsu1+3DfTNUQywl
T1I+r3Z3uyYBM7mF0S4VBiL8NLi27S8slX1lv8xulTtLtabI7IDTEt9lZK7maTTx
mwmaweT+NjxS7pezcJ1UbatL7VOquw1+wzIpsqlmvcCyCIiJ6G7tvRAzHySd5h/b
yEbRkUgvT6gA/Pojwh1JbtVioAMEnvFHEMCnL2VmnlsUBYSN4Ro=
=l/Wh
-----END PGP SIGNATURE-----

--n5hw2fxp2pfe5yae--
