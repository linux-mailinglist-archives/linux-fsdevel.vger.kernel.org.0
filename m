Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5C27401BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 18:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjF0Q4F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 12:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjF0Q4C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:56:02 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC27018C;
        Tue, 27 Jun 2023 09:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1687884956;
        bh=izqD3jT+ADWBX3rn8DQFe67pMsMvDJNKvE2GgEtMe7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CfHLC6O0JAaN2qNDtJDzq4Gz/M5XN6XtFNQmfupTu66xUWMV5oPWGWAbtwX3Py7yu
         1tOOCa4UaHEOzQptUN1dJeoxRQ8XT5HAOjbFS+/GRntcepqlX0tKIDgk9MsgZwEQsr
         IUxgNj7FFFPN7CBFpJwWDjL0EATSvlyg93KRax6n+ftB0MzQG4uc54WyWdmbvomfma
         U9Y8N+63Obc3b1YUQsxzT/EiHxN6b6U2CDDcHITQEc2ZSCV44JNwByM42BuxSDP803
         K1QsxMTi2Z4+pbozxfaUr8yKAT/iGz4Ajtih/7wiyniZurlp82qwHxOkuuMtZum3o9
         XeJ7DT8gi6REA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 375471A90;
        Tue, 27 Jun 2023 18:55:56 +0200 (CEST)
Date:   Tue, 27 Jun 2023 18:55:55 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>, ltp@vger.kernel.org
Subject: [PATCH v3 3/3] splice: fsnotify_access(in), fsnotify_modify(out) on
 success in tee
Message-ID: <080710f0a1a5c0f124bfa6cc2569b976e0365a91.1687884031.git.nabijaczleweli@nabijaczleweli.xyz>
References: <CAOQ4uxh7i_s4R9pFJPENALdWGG5-dDhqPLEUXuJqSoHraktFiA@mail.gmail.com>
 <cover.1687884029.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zo6f34h56mk2beb3"
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


--zo6f34h56mk2beb3
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
index 0eb36e93c030..2ecfccbda956 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1815,6 +1815,11 @@ long do_tee(struct file *in, struct file *out, size_=
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

--zo6f34h56mk2beb3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSbFJoACgkQvP0LAY0m
WPExtQ/8DSkgj9PMvR7+6k/3ErXOyZwe4IbU9KqbhQNj1vCKQ0xrNEBgYd4drFsm
4JpisqSL0s7oRk0+Wkat7+XsdVRhM1d9j+7HqSeJ6Zb/xU+ImAaPD5vH+DBFD8iP
DAkyqo6x7letILnL4IeDi5ybBWB+k1G+UgVl41F7U7Z6//N2btNutatYYpFS6OJ7
3/7T4e6A7oSr/xkybSZVVpJ0G0DdwAOQ+8wFgEXs+4+ruT0KhYI6/YX8BKhv8kaT
ACCQcaqayISBr6pAcLtIljcIk2SnZef9r1aH+rLf5CZdfSiTYVyKD/oKD6QMjNuG
tWLbVrEKJ2vwWrsLy5fVduVzUAfFoW5yUMkF2mzyK9QysOJp9xtDJHohMWqUAukn
MRAjVMdzCh6KKtgShQljYnwstSlBpsJMrAba2N7P04vdBQIGSzrsIZUNfTjPbuT7
dAeYZzSb/tZja7/iWFg9LFKn4CrYGOom06LNiPv2EtdXnFiGIngo4JBwNTAVBSiA
NQYn5HE99rgBG+FiBRMpHu2a1yqyLDOVZC6kvaQqskGoTVeJvU0LWPMXPh1e+2GK
5nZEWwcn1UoXOkIlG5Bl71li87eGHpuV7DTzWviPj/bq2QzrTsyfB4Uoe1aHOqG5
ufPu7VVmaCvrdThJsveMulYVdnutwTk5vmIqbJeGeNzMzofrbwc=
=EEwd
-----END PGP SIGNATURE-----

--zo6f34h56mk2beb3--
