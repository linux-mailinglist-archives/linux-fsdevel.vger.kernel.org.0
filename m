Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD53745EB5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 16:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjGCOm3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 10:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjGCOm1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:42:27 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 806B2E74;
        Mon,  3 Jul 2023 07:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1688395342;
        bh=SowbDY6YnsriPuN0djgR0SpF4itfDBztRXtp8moML7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EsXuPnSi0xOmIDA9aB+N2jhQz9p0AOzj61HDIQTIJdzsnRWnGbDF/huwP1B2Kx+s4
         GKbOd+IEDrPuqA8IYlgDBOn6HOsDRcDqUnEcUykq7eexZHfYx4Z3D/N8VYaI//nkFq
         WJkt4AYUkUzX5FoP6FZzjhpdok8hVpqoRCs4WGx2pbfxIKqawO2xUiBirSXWlAmDpE
         P8FV50NHcwz5rhWzafQCFhpJ2R+IRTIKCBssG8XeIt/RX5FLzqNjXl7fEXeVDbeqZB
         +llvKsXyqOJZ9yQPPq7UR0PsOfrof+FV3TOpe1D5CNEgiM3y7YUE3X9IMLGbTYa4l6
         iS2kXT2bbIGnA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 9D49F1DC4;
        Mon,  3 Jul 2023 16:42:22 +0200 (CEST)
Date:   Mon, 3 Jul 2023 16:42:21 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] splice: fsnotify_access(in), fsnotify_modify(out) on
 success in tee
Message-ID: <10d76dd8c85017ae3cd047c9b9a32e26daefdaa2.1688393619.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1688393619.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kdyjczppc4aawsdj"
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


--kdyjczppc4aawsdj
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
Acked-by: Jan Kara <jack@suse.cz>
---
 fs/splice.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index 5deb12d743b1..c49909dbf3c5 100644
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

--kdyjczppc4aawsdj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSi3k0ACgkQvP0LAY0m
WPF9+Q/+J6bU/ve99xlYUDp9QIZx97GByxsAc60UTli80+/M2askRgboNzVMr54t
WeQhhZ+c7qDVF5b6m6xBASK/cOF8jqSawpVZI7RY6FvxvaTl1gBxbaLdizgPIBc0
FpMxenMxQ/fxAlCj4OAYJRjSyunx8JciUdCo8iq9PPa+wGVFYa8Di8UMwzeh60r5
Yu+VQvsGvm74MpvZMhjtvQdljLMsdoZUx/fR4I4SIiyXP34sRm1wM+xOtlT9XO2H
tm+6BizWGO0mvh6XDYeKRhgszHAKITKtH8RygIW+Vl7VrtqeUkNxh6g8XOKDQ/oK
UlCnE8lWjXUq7iabebSTxBKUPSiCMMhe5tmQ77OL3RFq+frPLZV1uefCPkY/dHvP
GjNnAp+vDMQ4kTN9sWK6TobWHVeN4ZQVK2EWm8jA4vTuNqp5DQTvc9pG43j/sXeC
zXyUS9+KLuW6PBfJKqoULRnLgufbShCdp2EEdNpBqjgQWB8zMyYGbHq0WRVDvdfW
46irAZjFq6Hcma5/MwRU/fcPRm0TZR4uoyqiSnny7BhGoS8aCDkED5Qe8jWQt2p2
O4yuYvg5To59EL+oPrT5Oel3lRjjeysySFPEBpT3YDolvxaGnHeD1w5QVcitS5e1
2Tx8PIUIN+/ho8iKkqJBqvrUr+Idn+VF7PGi2R0IeOuPwNSmiIc=
=htXo
-----END PGP SIGNATURE-----

--kdyjczppc4aawsdj--
