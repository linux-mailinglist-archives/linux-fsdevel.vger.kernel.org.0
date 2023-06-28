Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C317B7416F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 19:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjF1RJS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 13:09:18 -0400
Received: from 139-28-40-42.artus.net.pl ([139.28.40.42]:37344 "EHLO
        tarta.nabijaczleweli.xyz" rhost-flags-OK-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S230188AbjF1RJQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1687972152;
        bh=Azb+7KmhOPI1fOD5IRqrbRnBzipbzWTnsPjGo5pFpZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GG6M0jTtbJL4DE9M1o0UiN5rkJqjyJXB+clJpl1TA8dnrL2iFmM+wljQ7L3sqrLft
         VIRre+KMJkQhvdjyKecisfjOEBydfQrCO1s0umOGBDdSFZs0I0S38CWdjqQ3NY8oPt
         CdMORq3v9idEMHJTjYtjD1ny1AQRsWEjkJKdR76lM3dW11BjnA3sWC7sOBfrODjbs7
         BCvTC4hS0/kZOAX8XaSzNHNXSqRieXcn9pHFLHrlvY4jyNxpVMC1sR2hyoZjL3M5km
         pDtMhoPR076Nf3z8cSt9zdjj9flvbWNrtgXs+EhOLpT6BkSASQCfOnIp7cf93pdNuz
         G0+yaf6HX6f4Q==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 8C3AB10F0;
        Wed, 28 Jun 2023 19:09:12 +0200 (CEST)
Date:   Wed, 28 Jun 2023 19:09:11 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>, ltp@lists.linux.it
Subject: Re: [PATCH v4 1/3] splice: always fsnotify_access(in),
 fsnotify_modify(out) on success
Message-ID: <q2nwpf74fngjdlhukkxvlxuz3xkaaq4aup7hzpqjkqlmlthag5@dsx6m7cgk5yt>
References: <t5az5bvpfqd3rrwla43437r5vplmkujdytixcxgm7sc4hojspg@jcc63stk66hz>
 <cover.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
 <e770188fd86595c6f39d4da86d906a824f8abca3.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
 <CAOQ4uxjQcn9DUo_Z2LGTgG0SOViy8h5=ST_A5v1v=gdFLwj6Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pzkuk7n3hd7my5on"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjQcn9DUo_Z2LGTgG0SOViy8h5=ST_A5v1v=gdFLwj6Hw@mail.gmail.com>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--pzkuk7n3hd7my5on
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2023 at 09:33:43AM +0300, Amir Goldstein wrote:
> On Tue, Jun 27, 2023 at 11:50=E2=80=AFPM Ahelenia Ziemia=C5=84ska
> <nabijaczleweli@nabijaczleweli.xyz> wrote:
> > The current behaviour caused an asymmetry where some write APIs
> > (write, sendfile) would notify the written-to/read-from objects,
> > but splice wouldn't.
> >
> > This affected userspace which uses inotify, most notably coreutils
> > tail -f, to monitor pipes.
> > If the pipe buffer had been filled by a splice-family function:
> >   * tail wouldn't know and thus wouldn't service the pipe, and
> >   * all writes to the pipe would block because it's full,
> > thus service was denied.
> > (For the particular case of tail -f this could be worked around
> >  with ---disable-inotify.)
> Is my understanding of the tail code wrong?
> My understanding was that tail_forever_inotify() is not called for
> pipes, or is it being called when tailing a mixed collection of pipes
> and regular files? If there are subtleties like those you need to
> mention them , otherwise people will not be able to reproduce the
> problem that you are describing.
I can't squeak to the code itself, but it's trivial to check:
  $ tail -f  fifo &
  [1] 3213996
  $ echo zupa > fifo
  zupa
  $ echo zupa > fifo
  zupa
  $ echo zupa > fifo
  zupa
  $ cat /bin/tail > fifo
  # ...
  $ cat /bin/tail > fifo
hangs: the fifo is being watched with inotify.

This happens regardless of other files being specified.

tail -f doesn't follow FIFOs or pipes if they're fd 0
(guaranteed by POSIX, coreutils conforms).

OTOH, you could theoretically do
  $ cat | tail -f /dev/fd/3 3<&0
which first reads from the pipe until completion (=E2=87=94 hangup, cat die=
d),
then hangs, because it's waiting for more data on the pipe.

This can never happen under a normal scenario, but doing
  $ echo zupa > /proc/3238590/fd/3
a few times reveals it's using classic 1/s polling
(and splicing to /proc/3238590/fd/3 actually yields that data being
 output from tail).

> I need to warn you about something regarding this patch -
> often there are colliding interests among different kernel users -
> fsnotify use cases quite often collide with the interest of users tracking
> performance regressions and IN_ACCESS/IN_MODIFY on anonymous pipes
> specifically have been the source of several performance regression repor=
ts
> in the past and have driven optimizations like:
>=20
> 71d734103edf ("fsnotify: Rearrange fast path to minimise overhead
> when there is no watcher")
> e43de7f0862b ("fsnotify: optimize the case of no marks of any type")
>=20
> The moral of this story is: even if your patches are accepted by fsnotify
> reviewers, once they are staged for merging they will be subject to
> performance regression tests and I can tell you with certainty that
> performance regression will not be tolerated for the tail -f use case.
> I will push your v4 patches to a branch in my github, to let the kernel
> test bots run the performance regressions on it whenever they get to it.
>=20
> Moreover, if coreutils will change tail -f to start setting inotify watch=
es
> on anonymous pipes (my understanding is that currently does not?),
> then any tail -f on anonymous pipe can cripple the "no marks on sb"
> performance optimization for all anonymous pipes and that would be
> a *very* unfortunate outcome.
As seen above, it doesn't set inotify watches on anon pipes, and
(since it manages to distinguish "| /dev/fd/3 3<&0" from "fifo",
 so it must be going further than S_ISFIFO(fstat()))
this is an explicit design decision.

If you refuse setting inotifies on anon pipes then that likely won't
impact any userspace program (it's pathological, and for tail-like cases
 it'd only be meaningful for magic /proc/$pid/fd/* symlinks),
and if it's in the name of performance then no-one'll likely complain,
or even notice.

> I think we need to add a rule to fanotify_events_supported() to ban
> sb/mount marks on SB_KERNMOUNT and backport this
> fix to LTS kernels (I will look into it) and then we can fine tune
> the s_fsnotify_connectors optimization in fsnotify_parent() for
> the SB_KERNMOUNT special case.
> This may be able to save your patch for the faith of NACKed
> for performance regression.
This goes over my head, but if Jan says it makes sense
then it must do.

> > Generate modify out before access in to let inotify merge the
> > modify out events in thr ipipe case.
> This comment is not clear and does not belong in this context,
> but it very much belongs near the code in question.
Turned it into
		/*
		 * Generate modify out before access in:
		 * do_splice_from() may've already sent modify out,
		 * and this ensures the events get merged.
		 */
for v5.

--pzkuk7n3hd7my5on
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmScaTcACgkQvP0LAY0m
WPEYsxAAmr4/LLDFJManVKTz0BcZOWbLlrl+QbFZuuV/IHsPu0+VtNKKI05iIbFa
sYp0GcvSi6ULNc0xJIStVhGfJRV41gahS4MuEthS71lRn4fSfJHig+yJUhpY6IAQ
y+jrJvWpxi2p4/LxBh68l9jlrXeO34YtK+mNDhNcfLsVv8aWmKzZ2qzHguO0qXM6
gX3q/6a0pVPl2dZcFuHTOSu1KDLCthW89NgvDXhv3UvGiJu7wLDBv9oxOJJxvvHO
JhumgDBxTTY2tSl1+eN48GIEkV3/B95LdDfLJ7kkfgi8+Hev2ocWMsAqHBx/8p/R
h7duYTPeJcvyNZtAm20Lc9d0hT9eu1ozGdU6fOavJzYWqGO2K8Aad3qWOKXDm5/T
PlnPm1wkpEpzz3f2gNV9UGUN7MbHq1nl3+bL1hOKi66vrwsf5zPJ1FutEGEM82FF
rV+5b2wXCIdWMYuDmpOdq1rSglEoXeOTAaaNHFihbi0nfXJ1HjFjE4ZxqGhczrfp
OdIf24/LqgkaRwhUJB0lEwTK2BJhbln0ch7vCAy/lJsEWpld373neoaP3VpxyxD+
4Xvx8FeYaRczyDwKNgx7fijXwRmC7nb9Tssqmmwsgh8khJCVmNedlWW1rGtLgdU3
t7itE/VHQ6vAZuu2QkzPA9ETrtfq5kySj14ftrYgaJUy8/LUxvs=
=/nNu
-----END PGP SIGNATURE-----

--pzkuk7n3hd7my5on--
