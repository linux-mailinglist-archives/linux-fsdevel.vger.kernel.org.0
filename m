Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB9E1274BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 05:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfLTEfa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 23:35:30 -0500
Received: from mout-p-201.mailbox.org ([80.241.56.171]:18280 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfLTEfa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 23:35:30 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 47fGBk2v34zQjm6;
        Fri, 20 Dec 2019 05:35:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id 5BE2jh93RM9y; Fri, 20 Dec 2019 05:35:22 +0100 (CET)
Date:   Fri, 20 Dec 2019 15:35:10 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Gian-Carlo Pascutto <gpascutto@mozilla.com>,
        Emilio Cobos =?utf-8?Q?=C3=81lvarez?= <ealvarez@mozilla.com>,
        Jed Davis <jld@mozilla.com>
Subject: Re: [PATCH v4 2/5] pid: Add PIDFD_IOCTL_GETFD to fetch file
 descriptors from processes
Message-ID: <20191220043510.r5h6wvsp2p5glyjv@yavin.dot.cyphar.com>
References: <20191218235459.GA17271@ircssh-2.c.rugged-nimbus-611.internal>
 <CAK8P3a2eT=bHkUamyp-P3Y2adNq1KBk7UknCYBY5_aR4zJmYaQ@mail.gmail.com>
 <20191219103525.yqb5f4pbd2dvztkb@wittgenstein>
 <CAMp4zn_z-CCQYMpT=GjZeGVLobjHBCSbmfha1rtWdmptOQ8JtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nmgp7ksjzcrpo6tt"
Content-Disposition: inline
In-Reply-To: <CAMp4zn_z-CCQYMpT=GjZeGVLobjHBCSbmfha1rtWdmptOQ8JtA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--nmgp7ksjzcrpo6tt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-12-19, Sargun Dhillon <sargun@sargun.me> wrote:
> On Thu, Dec 19, 2019 at 2:35 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> > I guess this is the remaining question we should settle, i.e. what do we
> > prefer.
> > I still think that adding a new syscall for this seems a bit rich. On
> > the other hand it seems that a lot more people agree that using a
> > dedicated syscall instead of an ioctl is the correct way; especially
> > when it touches core kernel functionality. I mean that was one of the
> > takeaways from the pidfd API ioctl-vs-syscall discussion.
> >
> > A syscall is nicer especially for core-kernel code like this.
> > So I guess the only way to find out is to try the syscall approach and
> > either get yelled and switch to an ioctl() or have it accepted.
> >
> > What does everyone else think? Arnd, still in favor of a syscall I take
> > it. Oleg, you had suggested a syscall too, right? Florian, any
> > thoughts/worries on/about this from the glibc side?
> >
> > Christian
>=20
> My feelings towards this are that syscalls might pose a problem if we
> ever want to extend this API. Of course we can have a reserved
> "flags" field, and populate it later, but what if we turn out to need
> a proper struct? I already know we're going to want to add one
> around cgroup metadata (net_cls), and likely we'll want to add
> a "steal" flag as well. As Arnd mentioned earlier, this is trivial to
> fix in a traditional ioctl environment, as ioctls are "cheap". How
> do we feel about potentially adding a pidfd_getfd2? Or are we
> confident that reserved flags will save us?

If we end up making this a syscall, then we can re-use the
copy_struct_from_user() API to make it both extensible and compatible in
both directions. I wasn't aware that this was frowned upon for ioctls
(sorry for the extra work) but there are several syscalls which use this
model for extendability (clone3, openat2, sched_setattr,
perf_events_open) so there shouldn't be any such complaints for a
syscall which is extensible.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--nmgp7ksjzcrpo6tt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXfxPewAKCRCdlLljIbnQ
ElNGAP0QzHxTfcWUIyKQwziyZ7SKPlC5ve6y0476CjvwfTG0mQD+JDR19gzaS69O
MYDK8035BURwBnELBe2PceZHzjVhlAQ=
=Kwh+
-----END PGP SIGNATURE-----

--nmgp7ksjzcrpo6tt--
