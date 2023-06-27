Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3076474053A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 22:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjF0UvL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 16:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjF0UvI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:51:08 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A77A0294A;
        Tue, 27 Jun 2023 13:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1687899060;
        bh=6Wh1Cs4Lx6l34QcFbXvDoNqOObzq40OnIaHRz3J6+lA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Idml7t5m1KSjmntTg/8gAFAJ/EDz4Lr2BddO4Ua2npmHdP7LXjuQpA20sYyfh4I1i
         3wFcnoO1EgqqLnLHQaLGlWiguVFmRIWfmP4QKt3LLt5xAK0P7JR8VT3yknBzAvTl0S
         fBoilZA9WGbENUtWy7UUhCqj8x46POnvEbjtSkIiKh43PP7312mlfq6SgumuRrcAOq
         dCMIUgpjwcReQknykV0svSul/aHybkpA0oeQ9YzonP2IY48CAuI7MC012GXzEZ5IOe
         cX0lMSEdsGKWvePax1AoLM01P1PX5Q6TzrZ/iGQBXxCp4tA1LjkYdp99nabv94ef+E
         swhyhQknB5SJA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id C7B351A24;
        Tue, 27 Jun 2023 22:51:00 +0200 (CEST)
Date:   Tue, 27 Jun 2023 22:50:59 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>, ltp@lists.linux.it
Subject: [PATCH v4 2/3] splice: fsnotify_access(fd)/fsnotify_modify(fd) in
 vmsplice
Message-ID: <c4e47008a1f8a8177223b15d6e3fe5f62c36798e.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
References: <t5az5bvpfqd3rrwla43437r5vplmkujdytixcxgm7sc4hojspg@jcc63stk66hz>
 <cover.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nslsgyputznadjqs"
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


--nslsgyputznadjqs
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
---
 fs/splice.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index b5c7a5ae0e94..d3a7f4d5c078 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1341,6 +1341,9 @@ static long vmsplice_to_user(struct file *file, struc=
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
@@ -1370,8 +1373,10 @@ static long vmsplice_to_pipe(struct file *file, stru=
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


--nslsgyputznadjqs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSbS7MACgkQvP0LAY0m
WPE64A//ThBem4any7e5paxp7oc9fQlzpzdhDmB1EiAaxJTCc4rLL9pLZ43RqqKH
egDcXf25IIlV4leoEd7I/oYWkfMR4tAzAA2Ybemd6vfpfp+fNc8xmic7+IByh7IB
939PedK4wcXBvPZh0oZ2duU3sbMblUKzrytozJdb9xrw25RzBNHp9qKPEN8nxVRB
rycnlrNotAgVJvdkQakHwktiX8gyACQP950oDpUWKNYV6iltzNd8bRxhr0B8b6zE
ejFckwSRDTCOW9x69QamJRuLEeA6UjZW5ruaZ68Ue5SzP5kDsu+nRY6hLRhe6wyE
JBj+isED2ITmAnIpioBQKYk8/zbo7ed3eDAJowYZdms+06WnVHhvEtGUNctuYiOK
mLf6YoPLKbZr2h+hgMTzQnk6Owa3m3coi2Jnhj7BuUoVUAxwoqBMgWqd4ScgY9Tv
PpjCCNaESUialmrLAOoMa2JfQWHRthXJN1ksoD27F3glS71SWDsmFgo32l6Ai5SH
JiQhQWv/CHuNHow3EVQPKDi07Eq2reBjlGuknUYYDmaodljOSVtrvbhYkZh3XU34
y2fLQqfdcw8bLsOOKD79HcQJxhSfm7k2rH6X6G8WiA5+NN07YNQCyVI2j//e4Fj0
Dof0aJBFcHYOdiayTPdLdUlk0TNO3X2jV/EXcOT6P7jYPsc9kGA=
=/GyC
-----END PGP SIGNATURE-----

--nslsgyputznadjqs--
