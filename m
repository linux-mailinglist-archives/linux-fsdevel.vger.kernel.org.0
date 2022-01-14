Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E625D48E346
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jan 2022 05:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbiANE2f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 23:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiANE2f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 23:28:35 -0500
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22CEC061574;
        Thu, 13 Jan 2022 20:28:34 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4JZpFp6tDXzQlM6;
        Fri, 14 Jan 2022 05:28:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Date:   Fri, 14 Jan 2022 15:28:17 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        ptikhomirov@virtuozzo.com, linux-api@vger.kernel.org
Subject: Re: [PATCH] fs/open: add new RESOLVE_EMPTY_PATH flag for openat2
Message-ID: <20220114042817.qxpqims6qbteyasc@senku>
References: <1641978137-754828-1-git-send-email-andrey.zhadchenko@virtuozzo.com>
 <20220112143419.rgxumbts2jjb4aig@senku>
 <20220112145109.pou6676bsoatfg6x@wittgenstein>
 <011a03b8-81a8-9b0e-a41b-93d9dde12d5f@virtuozzo.com>
 <20220113064643.dhhdhb7kw2qetyu3@senku>
 <8452fb29-b308-df9a-c2d4-f0ad29b1649c@virtuozzo.com>
 <f1128946-5675-7d8e-e475-d889dc7f5f80@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="os7jubhpjvhhykva"
Content-Disposition: inline
In-Reply-To: <f1128946-5675-7d8e-e475-d889dc7f5f80@virtuozzo.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--os7jubhpjvhhykva
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-01-14, Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com> wrote:
>=20
>=20
> On 1/13/22 10:52, Andrey Zhadchenko wrote:
> >=20
> >=20
> > On 1/13/22 09:46, Aleksa Sarai wrote:
> > > On 2022-01-12, Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com> wr=
ote:
> > > > On 1/12/22 17:51, Christian Brauner wrote:
> > > > > On Thu, Jan 13, 2022 at 01:34:19AM +1100, Aleksa Sarai wrote:
> > > > > > On 2022-01-12, Andrey Zhadchenko
> > > > > > <andrey.zhadchenko@virtuozzo.com> wrote:
> > > > > > > If you have an opened O_PATH file, currently there
> > > > > > > is no way to re-open
> > > > > > > it with other flags with openat/openat2. As a
> > > > > > > workaround it is possible
> > > > > > > to open it via /proc/self/fd/<X>, however
> > > > > > > 1) You need to ensure that /proc exists
> > > > > > > 2) You cannot use O_NOFOLLOW flag
> > > > > >=20
> > > > > > There is also another issue -- you can mount on top of
> > > > > > magic-links so if
> > > > > > you're a container runtime that has been tricked into creating =
bad
> > > > > > mounts of top of /proc/ subdirectories there's no way of
> > > > > > detecting that
> > > > > > this has happened. (Though I think in the long-term we will nee=
d to
> > > > > > make it possible for unprivileged users to create a procfs moun=
tfd if
> > > > > > they have hidepid=3D4,subset=3Dpids set -- there are loads of t=
hings
> > > > > > containers need to touch in procfs which can be
> > > > > > overmounted in malicious
> > > > > > ways.)
> > > > >=20
> > > > > Yeah, though I see this as a less pressing issue for now. I'd rat=
her
> > > > > postpone this and make userspace work a bit more. There are ways =
to
> > > > > design programs so you know that the procfs instance you're inter=
acting
> > > > > with is the one you want to interact with without requiring
> > > > > unprivileged
> > > > > mounting outside of a userns+pidns+mountns pair. ;)
> > > > >=20
> > > > > >=20
> > > > > > > Both problems may look insignificant, but they are
> > > > > > > sensitive for CRIU.
> > > > > > > First of all, procfs may not be mounted in the namespace wher=
e we are
> > > > > > > restoring the process. Secondly, if someone opens a
> > > > > > > file with O_NOFOLLOW
> > > > > > > flag, it is exposed in /proc/pid/fdinfo/<X>. So CRIU
> > > > > > > must also open the
> > > > > > > file with this flag during restore.
> > > > > > >=20
> > > > > > > This patch adds new constant RESOLVE_EMPTY_PATH for resolve f=
ield of
> > > > > > > struct open_how and changes getname() call to
> > > > > > > getname_flags() to avoid
> > > > > > > ENOENT for empty filenames.
> > > > > >=20
> > > > > > This is something I've wanted to implement for a while,
> > > > > > but from memory
> > > > > > we need to add some other protections in place before enabling =
this.
> > > > > >=20
> > > > > > The main one is disallowing re-opening of a path when it
> > > > > > was originally
> > > > > > opened with a different set of modes. [1] is the patch I origin=
ally
> > > > I looked at this patch. However I am not able to reproduce the prob=
lem.
> > > > For example, I can't open /proc/self/exe as RDWR with the following:
> > > > fd1 =3D open(/proc/self/exe, O_PATH)
> > > > fd2 =3D open(/proc/self/fd/3, O_RDWR) <- error
> > > > or open file with incorrect flags via O_PATH to O_PATH fd from proc
> > > > This is fixed or did I understand this problem wrong?
> > >=20
> > > You will get -ETXTBSY because the /proc/self/exe is still a current->=
mm
> > > of a process. What you need to do is have two processes (or fork+exec=
 a
> > > process and do this):
> > >=20
> > > =A0 1. Grab the /proc/$pid/exe handle of the target process.
> > > =A0 2. Wait for the target process to do an exec() of another program=
 (or
> > > =A0=A0=A0=A0 exit).
> > > =A0 3. *Then* re-open the fd with write permissions. This is allowed
> > > =A0=A0=A0=A0 because the file is no longer being used as the current-=
>mm of a
> > > =A0=A0=A0=A0process and thus is treated like a regular file handle ev=
en though
> > > =A0=A0=A0=A0it was only ever resolveable through /proc/self/exe which=
 should
> > > =A0=A0=A0=A0(semantically) only ever be readable.
> > >=20
> > > This attack was used against runc in 2016 and a similar attack was
> > > possible with some later CVEs (I think there was also one against LXC=
 at
> > > some point but I might be mistaken). There were other bugs which lead=
 to
> > > this vector being usable, but my view is that this shouldn't have been
> > > possible in the first place.
> > >=20
> > > I can cook up a simple example if the above description isn't explain=
ing
> > > the issue thoroughly enough.
> > >=20
> >=20
> > Thanks for the explanation! I get it now
> >=20
> > > > > > wrote as part of the openat2(2) (but I dropped it since I wasn'=
t sure
> > > > > > whether it might break some systems in subtle ways -- though ac=
cording
> > > > > > to my testing there wasn't an issue on any of my machines).
> > > > >=20
> > > > > Oh this is the discussion we had around turning an opath fd into =
a say
> > > > > O_RDWR fd, I think.
> > > > > So yes, I think restricting fd reopening makes sense. However, go=
ing
> > > > > from an O_PATH fd to e.g. an fd with O_RDWR does make sense
> > > > > and needs to
> > > > > be the default anyway. So we would need to implement this as a de=
nylist
> > > > > anyway. The default is that opath fds can be reopened with whatev=
er and
> > > > > only if the opath creator has restricted reopening will it fail, =
i.e.
> > > > > it's similar to a denylist.
> > > > >=20
> > > > > But this patch wouldn't prevent that or hinder the upgrade mask
> > > > > restriction afaict.
> > > >=20
> > > > This issue is actually more complicated than I thought.
> > > >=20
> > > > What do you think of the following:
> > > > 1. Add new O_EMPTYPATH constant
> > > > 2. When we open something with O_PATH, remember access flags (curre=
ntly
> > > > we drop all flags in do_dentry_open() for O_PATH fds). This is simi=
lar
> > > > to Aleksa Sarai idea, but I do not think we should add some new fie=
lds,
> > > > because CRIU needs to be able to see it. Just leave access flags
> > > > untouched.
> > >=20
> > > There are two problems with this:
> > >=20
> > > =A0 * The problem with this is that O_PATH and O_PATH|O_RDONLY are
> > > =A0=A0=A0 identical. O_RDONLY is defined as 0. I guess by new fields =
you're
> >=20
> > Yes, I didn't thought about that.
> >=20
> > > =A0=A0=A0 referring to what you'd get from fcntl(F_GETFL)?
> > >=20
> > > =A0=A0=A0 What you're suggesting here is the openat2() O_PATH access =
mask
> > > =A0=A0=A0 stuff. That is a feature I think would be useful, but it's =
not
> > > =A0=A0=A0 necessary to get O_EMPTYPATH working.
> > >=20
> > > =A0=A0=A0 If you really need to be able to get the O_PATH re-opening =
mask of a
> > > =A0=A0=A0 file descriptor (which you probably do for CRIU) we can add=
 that
> > > =A0=A0=A0 information to F_GETFL or some other such interface.
> >=20
> > That would be cool. In the patch I saw new FMODE_PATH_READ and
> > MODE_PATH_WRITE but there was no option to dump it.
> >=20
> > >=20
> > > =A0 * We need to make sure that the default access modes of O_PATH on
> > > =A0=A0=A0 magic links are correct. We can't simply allow any access m=
ode in
> > > =A0=A0=A0 that case, because if we do then we haven't really solved t=
he
> > > =A0=A0=A0 /proc/self/exe issue.
> > >=20
> > > > 3. for openat(fd, "", O_EMPTYPATH | <access flags>) additionally ch=
eck
> > > > access flags against the ones we remembered for O_PATH fd
> > >=20
> > > =A0 * We also need to add the same restrictions for opening through
> > > =A0=A0=A0 /proc/self/fd/$n.
> > >=20
> > > > This won't solve magiclinks problems but there at least will be API=
 to
> > > > avoid procfs and which allow to add some restrictions.
> > >=20
> > > I think the magic link problems need to be solved if we're going to
> > > enshrine this fd reopening behaviour by adding an O_* flag for it.
> > > Though of course this is already an issue with /proc/self/fd/$n
> > > re-opening.
> >=20
> > I think these issues are close but still different. Probably we can make
> > three ideas from this discussion.
> > 1. Add an O_EMPTYPATH flag to re-open O_PATH descriptor. This won't be
> > really a new feature (since we can already do it via /proc for most
> > cases). And also this won't break anything.
> > 2. Add modes for magiclinks. This is more restrictive change. However I
> > don't think any non-malicious programs will do procfs shenanigans and
> > will be affected by this changes. This is the patch you sent some time
> > ago
>=20
> Oops, I didn't notice third patch in you series "open: O_EMPTYPATH:
> procfs-less file descriptor re-opening". This is exactly what I tried to
> do.
> It will be very cool if you resurrect and re-send magic-links
> adjustments and O_EMPTYPATH.

I'll rebase it (adding a way to dump the reopening mask for O_PATH
descriptors) and send it next week (assuming it doesn't require too
much tweaking).

It should be noted that on paper you can get the reopening mask with the
current version of the patchset (look at the mode of the magic link in
/proc/self/fd/$n) but that's obviously not a reasonable solution.

> > 3. Add an option to restrict O_PATH re-opening (maybe via fcntl?). And
> > make it apply if someone tries to do /proc workaround with this exact
> > O_PATH fd

I originally wanted to do this in openat2() since it feels analogous to
open modes for regular file descriptors (in fact I planned to make
how->mode a union with how->upgrade_mask) but I'll need to think about
how to expose that in fcntl().

> > > However since I already have a patch which solves this issue, I can w=
ork
> > > on reviving it and re-send it.
> >=20
> > Why not if it only makes it better

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--os7jubhpjvhhykva
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCYeD73gAKCRCdlLljIbnQ
EtfFAP48CHGw6F78mWVhsHbAVinc0QKOuaWH9r5DkJkb5j8uqgEArFxyp1ECK4Cy
ca4IwWuF7RtBelaJ5JXbIULJnz9segk=
=6fT0
-----END PGP SIGNATURE-----

--os7jubhpjvhhykva--
