Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F76F745EAF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 16:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjGCOmO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 10:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGCOmN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:42:13 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F34F7B2;
        Mon,  3 Jul 2023 07:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1688395327;
        bh=cre8VZmV6gYgTF6bv9oEQ8gWcE0Cd+BqTyhkY8/8Gww=;
        h=Date:From:To:Cc:Subject:From;
        b=Dr9I8ddw6AGZrBWNXdhCwPsLl7OBiyps+er9THFZTMJfnH8N7VAlV3RTkS+pq1JNj
         RVbiC1xrGkH/NFNXZNcH6htc23Mgdynw9goSOMtioI2dtq40ocBcTTSDID4MPm1mt4
         WBD6COK4jCA5WYIJi3HnPLu5xiEaS2fQcnqjalF/+tRo+k52fHlDFy7p0M2nM900RA
         wKm1gjh2G88hdPq44Gp1fcsfWvDpTVFCOK18ms7+DR4k/CaWuVr6pqTsA+gwL5jRQv
         tF3sgn1V1kOVyg56IMY4cZGSHmzOAEOwQ0+QTqp1rrZHSP/IAdEQ99RESkG4Ti/1HO
         3ryDp42PYV7zQ==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 04C8A1B6A;
        Mon,  3 Jul 2023 16:42:07 +0200 (CEST)
Date:   Mon, 3 Jul 2023 16:42:05 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] fanotify accounting for fs/splice.c
Message-ID: <cover.1688393619.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h7vuydtxhwlulk7a"
Content-Disposition: inline
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


--h7vuydtxhwlulk7a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Previously: https://lore.kernel.org/linux-fsdevel/jbyihkyk5dtaohdwjyivambb2=
gffyjs3dodpofafnkkunxq7bu@jngkdxx65pux/t/#u

In short:
  * most read/write APIs generate ACCESS/MODIFY for the read/written file(s)
  * except the [vm]splice/tee family
    (actually, since 6.4, splice itself /does/ generate events but only
     for the non-pipes being spliced from/to; this commit is Fixes:ed)
  * userspace that registers (i|fa)notify on pipes usually relies on it
    actually working (coreutils tail -f is the primo example)
  * it's sub-optimal when someone with a magic syscall can fill up a
    pipe simultaneously ensuring it will never get serviced

Thus: actually generate ACCESS/MODIFY for all the
[vm]spliced/teed-from/to files.

LTP tests are staged in
  https://git.sr.ht/~nabijaczleweli/ltp/commit/v4
("inotify13: new test for fs/splice.c functions vs pipes vs inotify"),
validating that one A and/or one M event per [vm]splice(), tee(),
and sendfile() is generated =E2=80=92
without this patchset, this only holds for sendfile().

Amir has identified a potential performance impact caused by
correctly generating events, and has prepared patches at
  https://github.com/amir73il/linux/commits/fsnotify_pipe
that optimise the most common cases more aggressively.

Please review, and please consider taking these through the vfs
tree for 6.6.

Thanks,
Ahelenia Ziemia=C5=84ska (3):
  splice: always fsnotify_access(in), fsnotify_modify(out) on success
  splice: fsnotify_access(fd)/fsnotify_modify(fd) in vmsplice
  splice: fsnotify_access(in), fsnotify_modify(out) on success in tee

 fs/splice.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

--=20
2.39.2

--h7vuydtxhwlulk7a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSi3j0ACgkQvP0LAY0m
WPEtEQ/9F6xggxB4EolNBUV1fvUunoQyDjqsg//EpbRE/TxQUdUnVrYtCuNxM0gE
jphR/F8R2h2iJmf3p8d/Omjshnggp45+fnKFH3xoY3dNctPNUujmWEDFPtMPPrc6
ZI63MAg/nDUORSlMBu4mCmBWhwkjXR+NViseN49vZQEkkxZiJP8RVBCQUNevze/Q
ZSXE3wjXzMFRU1Q+qa64Zwz5cQnhQxkUHMt/8ILLbrlDCC8WO1wj8ZfwIIT5HGza
kC8AgMIhm/LpjBg/RP8xgqySAawRbJuPXd/jRdCI4gAgERZSCPoHtWMpAj/kP4vN
YzbsWJjH5qsvnEmDl6f6UWTMc+MygDbNF3RawoA2qM0WADISzKyq6fr2f+M+Q47I
JdP1DhzXg4BtUNHadJvKEkWhw0+S2WEF0pPnN7JAoX3IE5K7Wg9cC4U4Og4IiA0i
xp5XaECxIKxAOSVUf/HOXnKbJjO+gGIL9CuXAAx0cYp4xEi/H+HMxZU1KdJ9a0Mh
FJxox+P1Ghsfu8/fj9kQjGvNSikfufzxBGHxVo/1pF6cW0DMtXLrQDeCnfXhXKGX
twKYgURcYzDkbJ0gjRJbwbenGhZL56IwRG0rEbIzyMg49qlhT8CARwabGDj4RiWW
OLMcKJJgLxx78aRQ+STrY7Yu584PZgJpPPKAy4dvRhB3DgBg8lI=
=g2al
-----END PGP SIGNATURE-----

--h7vuydtxhwlulk7a--
