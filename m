Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE4874186D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 20:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjF1S4t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 14:56:49 -0400
Received: from 139-28-40-42.artus.net.pl ([139.28.40.42]:57848 "EHLO
        tarta.nabijaczleweli.xyz" rhost-flags-OK-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S232925AbjF1Syd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1687978469;
        bh=407huGS784lSIw/L/pvQpXD2aAp/xkHCUK2qKZHT5AE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YEn/HOy3ZICA3+l2IV3469bYHERBi4TAUqhwAP5q1X9kuMYuFl6u5EsvMWMGtX7o5
         6jxJaBZ/fPxHj4GhcApIPQW+ZAqy3oxDP6fXoam5bNZwO7RdS5e5U1TWySlLCV1DTk
         VHC009Ftk8NQKDYPkiNDcL822ueIhvD/LrSqKR+i3DBNQxNGqkBTMXZv2B1GAEgCDm
         JmxCJlHXbFYghbWj4nBuNrEVV4wG/Q952nG6HgbGrHaaQuqcgo+VNyzRDGMdb50R0V
         v0/d3Gb087RhRKnFzRSZVVRpIY10Lr5UVuyqMSlc1ns1HWfvzpxbDw5yXDGWhqdo4T
         s49yhejK8BWTg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id C0BB410F4;
        Wed, 28 Jun 2023 20:54:29 +0200 (CEST)
Date:   Wed, 28 Jun 2023 20:54:28 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chung-Chiang Cheng <cccheng@synology.com>, ltp@lists.linux.it
Subject: Re: [PATCH v4 0/3] fanotify accounting for fs/splice.c
Message-ID: <ns6dcoilztzcutuduujfnbz5eggy3fk7z4t2bajy545zbay5d7@4bodludrpxe6>
References: <t5az5bvpfqd3rrwla43437r5vplmkujdytixcxgm7sc4hojspg@jcc63stk66hz>
 <cover.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
 <20230628113853.2b67fic5nvlisx3r@quack3>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t22ubltek2za4lgw"
Content-Disposition: inline
In-Reply-To: <20230628113853.2b67fic5nvlisx3r@quack3>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--t22ubltek2za4lgw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Wed, Jun 28, 2023 at 01:38:53PM +0200, Jan Kara wrote:
> On Tue 27-06-23 22:50:46, Ahelenia Ziemia=C5=84ska wrote:
> > Always generate modify out, access in for splice;
> > this gets automatically merged with no ugly special cases.
> >=20
> > No changes to 2/3 or 3/3.
> Thanks for the patches Ahelena! The code looks fine to me but to be honest
> I still have one unresolved question so let me think about it loud here f=
or
> documentation purposes :). Do we want fsnotify (any filesystem
> notification framework like inotify or fanotify) to actually generate
> events on FIFOs? FIFOs are virtual objects and are not part of the
> filesystem as such (well, the inode itself and the name is), hence
> *filesystem* notification framework does not seem like a great fit to wat=
ch
> for changes or accesses there. And if we say "yes" for FIFOs, then why not
> AF_UNIX sockets? Where do we draw the line? And is it all worth the
> trouble?
As a relative outsider (I haven't used inotify before this, and have not
 been subjected to it or its peripheries before),
I interpreted inotify as being the Correct solution for:
  1. stuff you can find in a normal
     (non-/dev, you don't want to touch devices)
     filesystem traversal
  2. stuff you can open
where, going down the list in inode(7):
  S_IFSOCK   can't open
  S_IFLNK    can't open
  S_IFREG    yes!
  S_IFBLK    it's a device
  S_IFDIR    yes!
  S_IFCHR    it's a device
  S_IFIFO    yes!

It appears that I'm not the only one who's interpreted it that way,
especially since neither regular files nor pipes are pollable.
(Though, under that same categorisation, I wouldn't be surprised
 if anonymous pipes had been refused, for example, since those are
 conventionally unnameable.)

To this end, I'd say we're leaving the line precisely where it was drawn
before, even if by accident.

> I understand the convenience of inotify working on FIFOs for the "tail -f"
> usecase but then wouldn't this better be fixed in tail(1) itself by using
> epoll(7) for FIFOs which, as I've noted in my other reply, does not have
> the problem that poll(2) has when there are no writers?
Yes, epoll in ET mode returns POLLHUP only once, but you /also/ need the
inotify anyway for regular files, which epoll refuses
(and, with -F, you may want both epoll for a pipe and inotify for the
 directory it's contained in).
Is it possible to do? yes. Is it more annoying than just having pipes
report when they were written to? very much so.

inotify actually working(*) is presumably why coreutils tail doesn't use
epoll =E2=80=92 inotify already provides all required events(*), you can us=
e the
same code for regular files and fifos, and with one fewer level of
indirection: there's just no need(*).

(*: except with a magic syscall only I use apparently)

--t22ubltek2za4lgw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmScgeQACgkQvP0LAY0m
WPFU0hAAsQQgDTXFQBzqm2D+2vh1lcuz9TJUyJydbOgXaLC1qP/QtcPSCisL6n9k
URhk3SzQ9X5zVbXsxdjp3vPvPKOa9AETM7XcgDfuFbYAkG8EZ6/C9+oy9GvLfr+A
fKF+yowqAEh1sE5+JuqO6RGoQ00ZIGnK/umNQ0Y3f+zbxyvIkOwCSvpM85FdJQKk
3SQcGPsvZeCxuWs48Ew3pEPt1KdRFd/09cqBWOak0rqD4X01PMiGi4NeOplayq1m
T/zwX3mwdzWsWatYETmt+s+81prWz7ZX6QgEGT0iUnntZO6vS8yxT3ONCzePlRmY
maXGjYmBQOcJonQk+6KzLYR58RCk21JScFuFLPi9fqURpXec7NdDtsS+LyUY6s92
iRb3Qzns6I/klxwjJ40xdgRFkiaOyrpgod+/J5SIlaImna3BQuM25PrYXnZHnXoW
azbWHmIDifdx/ZVoJPjW1MctW21yzozQCyZgk8RQZRSGSkBAjo4+Q1ag+LyToQvj
cei7qcWupecsQChCpDOOvK5gxGETeqHlEW/3Vtr83JjLdTlFxpyo+e4B2Jxlm8DL
E19bxeY22W8Q/k23S3ihAwC/VlSqCn1jDvIVDnYrwBigfMilVA5vTqy3wWHIBIlJ
E5G4NgcEOvHTPAcqHzOx6Lvw1y3CdAHAoE0eEktsRumxBfz/IhU=
=f2tP
-----END PGP SIGNATURE-----

--t22ubltek2za4lgw--
