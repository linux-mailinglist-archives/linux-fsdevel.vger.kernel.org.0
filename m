Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDA973DEE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 14:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjFZMUf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 08:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjFZMUJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:20:09 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D570B170D;
        Mon, 26 Jun 2023 05:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1687781982;
        bh=J9L/5JuVInuF5NaqRJE9KRe0F/GfXtqHLAHb+kv1VSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lLaNAZu+/e6K4mn/eUBVhJNdYsbxdQgEcV1NaGkGhwCAEjqkg4z7iSOQc7hIVFUBL
         kvHa0E/4uBa8iZ5/lmDndNc3nn5TFO/IWnDMKV+ePcXPRQ3ouPgRsx7e1z1aI5CEx4
         WOURWP3PIL5qtRulRDJcN/xHiuBmWfdgICXy+VK7rXQ/4Va+LKQriG+A0fPsooBCpH
         IfUYhIQk5FJycaem+YQKMAB2TnI9pEPNes7rg5b9947sw5z1H/7l7p4eq9UMuciz5B
         7tWRmzYt5oFxeW9ALFrtAq6VbED4GIJirRmCpl8eh/W3nddzpyy3/a8pdOibg9gIg4
         lrr8mAwRex/Jw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id C7DAAEDC;
        Mon, 26 Jun 2023 14:19:42 +0200 (CEST)
Date:   Mon, 26 Jun 2023 14:19:41 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: splice(-> FIFO) never wakes up inotify IN_MODIFY?
Message-ID: <ndm45oojyc5swspfxejfq4nd635xnx5m35otsireckxp6heduh@2opifgi3b3cw>
References: <jbyihkyk5dtaohdwjyivambb2gffyjs3dodpofafnkkunxq7bu@jngkdxx65pux>
 <CAOQ4uxhut2NHc+MY-XOJay5B-OKXU2X5Fe0-6-RCMKt584ft5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y5ql4mqia7g2rmqd"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhut2NHc+MY-XOJay5B-OKXU2X5Fe0-6-RCMKt584ft5A@mail.gmail.com>
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


--y5ql4mqia7g2rmqd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2023 at 09:11:53AM +0300, Amir Goldstein wrote:
> On Mon, Jun 26, 2023 at 6:54=E2=80=AFAM Ahelenia Ziemia=C5=84ska
> <nabijaczleweli@nabijaczleweli.xyz> wrote:
> >
> > Hi!
> >
> > Consider the following programs:
> > -- >8 --
> > =3D=3D> ino.c <=3D=3D
> > #define _GNU_SOURCE
> > #include <stdio.h>
> > #include <sys/inotify.h>
> > #include <unistd.h>
> > int main() {
> >   int ino =3D inotify_init1(IN_CLOEXEC);
> >   inotify_add_watch(ino, "/dev/fd/0", IN_MODIFY);
> >
> >   char buf[64 * 1024];
> >   struct inotify_event ev;
> >   while (read(ino, &ev, sizeof(ev)) > 0) {
> >     fprintf(stderr, "%d: mask=3D%x, cook=3D%x, len=3D%x, name=3D%.*s\n"=
, ev.wd, ev.mask,
> >             ev.cookie, ev.len, (int)ev.len, ev.name);
> >     fprintf(stderr, "rd=3D%zd\n", read(0, buf, sizeof(buf)));
> >   }
> > }
> >
>=20
> That's a very odd (and wrong) way to implement poll(2).
> This is not a documented way to use pipes, so it may
> happen to work with sendfile(2), but there is no guarantee.
That's what I'm trying to do, yes.
What's the right way to implement poll here? Because I don't think Linux
has poll for pipes that behaves like this and POSIX certainly doesn't
guarantee it, and, indeed, requires that polling a pipe that was hanged
up instantly returns with POLLHUP forever.

> > -- >8 --
> > $ make se sp ino
> > $ mkfifo fifo
> > $ ./ino < fifo &
> > [1] 230
> > $ echo a > fifo
> > $ echo a > fifo
> > 1: mask=3D2, cook=3D0, len=3D0, name=3D
> > rd=3D4
> > $ echo c > fifo
> > 1: mask=3D2, cook=3D0, len=3D0, name=3D
> > rd=3D2
> > $ ./se > fifo
> > abcdef
> > 1: mask=3D2, cook=3D0, len=3D0, name=3D
> > asd
> > ^D
> > se=3D11: Success
> > rd=3D11
> > 1: mask=3D2, cook=3D0, len=3D0, name=3D
> > rd=3D0
> > $ ./sp > fifo
> > abcdefg
> > asd
> > dsasdadadad
> > sp=3D24: Success
> > $ < sp ./sp > fifo
> > sp=3D25856: Success
> > $ < sp ./sp > fifo
> > ^C
> > $ echo sp > fifo
> > ^C
> > -- >8 --
> >
> > Note how in all ./sp > fifo cases, ./ino doesn't wake up!
> > Note also how, thus, we've managed to fill the pipe buffer with ./sp
> > (when it transferred 25856), and now we can't /ever/ write there again
> > (both splicing and normal writes block, since there's no space left in
> >  the pipe; ./ino hasn't seen this and will never wake up or service the
> >  pipe):
> > so we've effectively "denied service" by slickily using a different
> > syscall to do the write, right?
> >
> > I consider this to be unexpected behaviour because (a) obviously and
> > (b) sendfile() sends the inotify event.
> >
> Only applications that do not check for availability
> of input in the pipe correctly will get "denied service".
>=20
> The fact is that relying on inotify IN_MODIFY and IN_ACCESS events
> for pipes is not a good idea.
Okay, so how /is/ "correctly" then?
Sleep in a loop and read non-blockingly?
splice also breaks that (and, well, the pipe it's splicing to in general)
  https://lore.kernel.org/linux-fsdevel/qk6hjuam54khlaikf2ssom6custxf5is2ek=
kaequf4hvode3ls@zgf7j5j4ubvw/t/#u
but that's beside the point I guess.

> splice(2) differentiates three different cases:
>         if (ipipe && opipe) {
> ...
>         if (ipipe) {
> ...
>         if (opipe) {
> ...
>=20
> IN_ACCESS will only be generated for non-pipe input
> IN_MODIFY will only be generated for non-pipe output
>
> Similarly FAN_ACCESS_PERM fanotify permission events
> will only be generated for non-pipe input.
inotify(7) and fanotify(7) don't squeak on that,
and imply the *ACCESS stuff is just for reading.

> sendfile(2) OTOH does not special cases the pipe input
> case at all and it generates IN_MODIFY for the pipe output
> case as well.
>=20
> My general opinion about IN_ACCESS/IN_MODIFY
> (as well as FAN_ACCESS_PERM) is that they are not
> very practical, not well defined for pipes and anyway do
> not cover all the ways that a file can be modified/accessed
> (i.e. mmap). Therefore, IMO, there is no incentive to fix
> something that has been broken for decades unless
> you have a very real use case - not a made up one.
My made-up use-case is tail -f, but I can just request
IN_MOFIFY|IN_ACCESS for pipes, so if that's "correctly" then great.
If it isn't, then, again, how /do/ you poll pipes.

> If you would insist on fixing this inconsistency, I would be
> willing to consider a patch that matches sendfile(2) behavior
> to that of splice(2) and not the other way around.
Meh, platform-specific API, long-standing behaviour, it's whatever;
I'll just update *notify(7) to include that *ACCESSses are generated
for "wants to/has read OR pipe was written".

--y5ql4mqia7g2rmqd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSZglsACgkQvP0LAY0m
WPHKZg//QxpXVsySg3GHGem9itEDr2rmSZQNm5W7/2RuK/AsbXhNHfIcK9JzOcDb
a6xzESBWsihIDsKok81MqIfaWMpGNlVi+Qbsb2vWzLkSzKJaRdzGAXhfoZLKYhRK
HKDiMTzwjvEyUkv7GL27O6spXQmmzFqEeSNI5ncXad+lIfHdKjmGw4/mH+TDWVZ9
STG8kUBocD+mJEXFd/zKDav+CxM4miUbea+gx8x/QFf53GzUSotJBiE8I44SLTXw
JO5AFr1LZIz7Owddd+EzEE3Wv2T+r7ras0I107xmPUJfu+nMwEw83/ab42yJk3NF
l6p+NjkUhX0jWoDHcEJ1wxj+ip+Wdz+s8qwph3VJhR+mZQMqcghlW2aXARmdTWB7
tVGFDSI7qRNaHjgMjf5hQ+OQwLSOBKgVtW/vVHYKHXdNWDdWGOSWceFsKQIXuzZC
icRSFX8TqjJQqXxsa12P4IWD+GhMQ/edzYCML1Df91Xp7qve8K15HXThRGEzusxs
ujeXt+2IwjqseH0x4U6zAXoc+tV/lS2XkyuzmsyKm5yixtwn19PCzDTSJFw3Ugw/
yIo4myLTFRSwjYMqQ1VB1qKdD9BOqZ+t0+K+D+SpHc6wnpcRp7qjCM0oJZAmcw6e
eWOCIX1swC0gXCSDWCv/1XNs8e9lphKymOn7biQ7385XySgq46E=
=z3gq
-----END PGP SIGNATURE-----

--y5ql4mqia7g2rmqd--
