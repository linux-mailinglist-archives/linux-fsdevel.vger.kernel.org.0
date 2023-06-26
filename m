Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3C573E215
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 16:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjFZO0D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 10:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjFZOZt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:25:49 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EF9210CB;
        Mon, 26 Jun 2023 07:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1687789543;
        bh=i6O4ngsx2ktTmVzWSuII1juMQqfsoJmZ03DNRqux+Dw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MK7aSg0DOhBqnDMATrhx4LnQAfYiuRIkAXaws+JXSRgVjDPXkWg9UM85/Xv5HA4c3
         oErRkO9aBJGmPlaA6NmKeC8DuxWkWRat8RhrahhzlSnb2Dc4KCaieS9zx8luPkXd03
         JCsuRsWSEo7UpqDnFdI4Fw8QFmLyHuwbSeK/l3TsN8HcoNgYhRG5Y0WfKxwCy8v2wh
         1jdl1O31BnoLXQff66g/27GL4qkPlresA/8V5fNFBNRlgX2G2xyCrgKobz7rEzkPva
         zi+ddqXiKew0Zz6t5q3EkTS6sXuS+PXI8vvT4JrqCO4cSGOqpPRnQ4cHmlD929StSE
         2yssrBVLjKBng==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 0CADC180C;
        Mon, 26 Jun 2023 16:25:43 +0200 (CEST)
Date:   Mon, 26 Jun 2023 16:25:41 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: splice(-> FIFO) never wakes up inotify IN_MODIFY?
Message-ID: <bngangrplbxesizu5kbi442fw2et5dzh723nzxsqj2b2p5ikze@dtnajlktfc2g>
References: <jbyihkyk5dtaohdwjyivambb2gffyjs3dodpofafnkkunxq7bu@jngkdxx65pux>
 <CAOQ4uxhut2NHc+MY-XOJay5B-OKXU2X5Fe0-6-RCMKt584ft5A@mail.gmail.com>
 <ndm45oojyc5swspfxejfq4nd635xnx5m35otsireckxp6heduh@2opifgi3b3cw>
 <vlzqpije6ltf2jga7btkccraxxnucxrcsqbskdnk6s2sarkitb@5huvtml62a5c>
 <20230626135159.wzbtjgo6qryfet4e@quack3>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4vndfkeg7aishp6c"
Content-Disposition: inline
In-Reply-To: <20230626135159.wzbtjgo6qryfet4e@quack3>
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


--4vndfkeg7aishp6c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2023 at 03:51:59PM +0200, Jan Kara wrote:
> On Mon 26-06-23 14:57:55, Ahelenia Ziemia=C5=84ska wrote:
> > On Mon, Jun 26, 2023 at 02:19:42PM +0200, Ahelenia Ziemia=C5=84ska wrot=
e:
> > > > splice(2) differentiates three different cases:
> > > >         if (ipipe && opipe) {
> > > > ...
> > > >         if (ipipe) {
> > > > ...
> > > >         if (opipe) {
> > > > ...
> > > >=20
> > > > IN_ACCESS will only be generated for non-pipe input
> > > > IN_MODIFY will only be generated for non-pipe output
> > > >
> > > > Similarly FAN_ACCESS_PERM fanotify permission events
> > > > will only be generated for non-pipe input.
> > Sorry, I must've misunderstood this as "splicing to a pipe generates
> > *ACCESS". Testing reveals this is not the case. So is it really true
> > that the only way to poll a pipe is a sleep()/read(O_NONBLOCK) loop?
> So why doesn't poll(3) work? AFAIK it should...
poll returns instantly with revents=3DPOLLHUP for pipes that were closed
by the last writer.

Thus, you're either in a hot loop or you have to explicitly detect this
and fall back to sleeping, which defeats the point of polling:
-- >8 --
#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <poll.h>
#include <stdio.h>
#include <unistd.h>
int main() {
  char buf[64 * 1024];
  struct pollfd pf =3D {.fd =3D 0, .events =3D POLLIN};
  size_t consec =3D 0;
  for (ssize_t rd;;) {
    while (poll(&pf, 1, -1) <=3D 0)
      ;
    if (pf.revents & POLLIN) {
      while ((rd =3D read(0, buf, sizeof(buf))) =3D=3D -1 && errno =3D=3D E=
INTR)
        ;
      fprintf(stderr, "\nrd=3D%zd: %m\n", rd);
    }
    if (pf.revents & POLLHUP) {
      if (!consec++)
        fprintf(stderr, "\n\tPOLLHUPs");
      fprintf(stderr, "\r%zu", consec);
    } else
      consec =3D 0;
  }
}
-- >8 --

And
-- >8 --
$ ./rdr < fifo

rd=3D12: Success

1779532 POLLHUPs
rd=3D5: Success

945087  POLLHUPs
rd=3D12: Success
^C
-- >8 --
corresponding to
-- >8 --
$ cat > fifo
abc
def
ghi
^D
$ echo zupa > fifo
$ cat > fifo
as
dsaa
asd
^C
-- >8 --

--4vndfkeg7aishp6c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSZn+MACgkQvP0LAY0m
WPEtvhAAnoc8iGU5tbBviUj4eAspCbymYYCzvQtpQBWBCevNmprEWYcATNj2tetx
9o1uTLxYRHFil8uIcUnq0/zzwbGNmmVZpZn4WzBszM6rBC81PgtucxzSZ/gdOZia
J9WTog/1ZL4ecsVc4tMmm7D++qDYPg5ndm+JCQpp6z9fwxd8l6mwOvdOEO5KTl3h
7YUKtii0OxxrjiNNdT6rIP/yF65Z38wmKO8A5Ab1mjuIfDQ/EhVPeFS9C62+J41H
AphKzxg31+1kNyFSYv2oeYMTVLAXuVuGMV6Qq+OYpixkOpanW3RFjYcHd5oIQ/DO
0VUM36xMMh5zXZmuN4cNWX5yJD9cP4XLH36jlt4pOJsoCb8pQBc4DcfFeO83ef4R
L6betbH6LnKhycjO5Wfv2forBf5OHtOlripTyM3HCivpfFTOQXBXVTapCbD3huNj
kqIQoM23AG7VOJWcf15HsRe/v0VCbOaz/4EY1+keJSqxdlqZvgDAZ3coKOOSvp6i
8yReURg28bDo8jLKRTSJMvbY+K1RqSVFc/e84xgKthPr5zCdTd1sLpfWcrcKjAdf
ClOT87YPeXzyWO413vsy37j1bcj8R6CVP1r+frfyujL7ahKDFNxDJfbKnzOJyEH2
9vaOoMe2FX4rFFVqoFp4O2AEwgf8RvJl1RfvgRqTQJhlyXuTPlk=
=sIzT
-----END PGP SIGNATURE-----

--4vndfkeg7aishp6c--
