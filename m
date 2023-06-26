Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D68E73EF0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 01:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjFZXIp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 19:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjFZXIo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 19:08:44 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF82610FB;
        Mon, 26 Jun 2023 16:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1687820919;
        bh=iASaIQSREKLq2OFVu4k4J+TAbxohSrL+yjCExkMJmeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bk6TKlHsfUUcFxuVbDcSAjmmsUMXwKgcojyjXMlinXZS4Q45RXGFagnjSa2Y5MRXb
         U/chkw+pv6FTegKkZVDpN389XaGF6+VudrsW6Z3tsbr/BQD9LRGdkxdMrrS7Em+TbS
         HmZ1L2pYudBMIKl6lpDQxDgG/Em/HbwUh8HneMsja0jzSo6I5ov+E5ZTM9PEmjKIAo
         8TrD4E/bYehXw0LS3wzH5y82JDbZHkI2BlqWwZ+YZYBW4wOjzwDfaL4MhaozxyW/p/
         n+xywt0inXLQb3nA9S+/2d5xtHxK8fiVuwOAcaq8DjPL9XnBR14SB+aCi11VSni8Bp
         Uu6ogLMbwAweA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id A6EC9CFC;
        Tue, 27 Jun 2023 01:08:39 +0200 (CEST)
Date:   Tue, 27 Jun 2023 01:08:38 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>
Subject: [PATCH v2 0/3] fanotify accounting for fs/splice.c
Message-ID: <pw3ljisf6ctpku2o44bdy3aaqdt4ofnedrdt4a4qylhasxsli6@wxhy3nsjcwn4>
References: <CAOQ4uxj_DLm8_stRJPR7i8bp9aJ5VtjzWqHL2egCTKe3M-6KSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u5ahfxgiox6lrsd2"
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


--u5ahfxgiox6lrsd2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

"people just forget to add inotify hooks to their I/O routines as a rule"?
Guess what I did, fully knowing that some are missing in this file :)

=3D=3D> te.c <=3D=3D
#define _GNU_SOURCE
#include <fcntl.h>
#include <stdio.h>
int main() {
  ssize_t rd, acc =3D 0;
  while ((rd =3D tee(0, 1, 128 * 1024 * 1024, 0)) > 0)
    acc +=3D rd;
  fprintf(stderr, "te=3D%zd: %m\n", acc);
}

=3D=3D> vm.c <=3D=3D
#define _GNU_SOURCE
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
static char sb[1024 * 1024];
int main() {
  memcpy(sb, "=C5=BCupan", sizeof("=C5=BCupan"));
  ssize_t rd =3D
      vmsplice(1, &(struct iovec){.iov_base =3D sb, .iov_len =3D sizeof(sb)=
}, 1,
               SPLICE_F_GIFT);
  fprintf(stderr, "vm=3D%zd: %m\n", rd);
}


echo zupa | ./te > fifo tees a few times and then blocks when the pipe
fills, at which point we get into the broken state.

Similarly, ./vm > fifo (with the default 64k F_GETPIPE_SZ) enters that
same state instantly.

With 2/3 and 3/3, they instead do
  1: mask=3D2, cook=3D0, len=3D0, name=3D
  rd=3D80
  1: mask=3D2, cook=3D0, len=3D0, name=3D
  rd=3D80
  ...
in a loop, as-expected, and=20
  # ./vm > fifo
  vm=3D65200: Success
  1: mask=3D2, cook=3D0, len=3D0, name=3D
  rd=3D65200

I took the liberty of marking 2/3 and 3/3 as Fixes: of the original
fanotify-in-splice commit as well, I think they fit the bill.

Ahelenia Ziemia=C5=84ska (3):
  splice: always fsnotify_access(in), fsnotify_modify(out) on success
  splice: fsnotify_modify(fd) in vmsplice
  splice: fsnotify_access(in), fsnotify_modify(out) on success in tee

 fs/splice.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

--=20
2.39.2

--u5ahfxgiox6lrsd2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSaGnYACgkQvP0LAY0m
WPE5LA//cvaUBrA93SjLEn8aSKrha/Xdzj+yQwa1lvefbPW7DIJ4rCc8RepslTie
ShLW0t+MAfOIpMLRNxLWv3SlhyWtCTN/XqsfwmL/4jtpGfM3vcyPOiXbQPp7304H
1qOzYCV/FUEgEUu1ZtYD2PRNtLJfIwg473Yx/+ib/0trWAWDid3BfkfmSEbK13ix
ZCxd+/gcEX/a7GTrIAiSW4ki8Mi/yX7FyMK5VvHoDIWop3z1EEYwapKxYzSvqjCu
g+KVXFXtBOvVPhcpsbqPoo4xyT7Ew+LzMKdnogaySOOMiEpogjQ2aL7JxGPiZj/M
0JcGqjVJUvWhZw5g1egwMdq1mZP4SIjL66Q2BC3SD1K89v8JsJtfGZr5l9u8IS/r
k1rmKZ1ClnHPNyIQtFl34n2F5KkRdyJHvF6u4ZzQy0px2tr6EkUTNH5qBbSFSiNy
S4p3BbR3vnxyKFYud6gDPBXkOMm3euIJcdjAnT6nmjFXab5OuMBTAKWsoMxeKg7x
06JoMBaTFhp/LHCV1KMNjdJGIXWnVnmONX0FDIkKSncayKGBAZapzhCc56ADaDK2
0XR2Jua+uux8ueuYqWg7CwChS1oSHtSE1SCZMAZkqvHjkBou6ogLN/AKTDzIvH85
OEPRfej4bd439khKCAQNVZio0cSV7KdLxzWBVne2fPZ8HmGxKU4=
=TrVD
-----END PGP SIGNATURE-----

--u5ahfxgiox6lrsd2--
