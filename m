Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F9A48D9E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 15:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbiAMOpO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 09:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbiAMOpN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:45:13 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641A0C06161C;
        Thu, 13 Jan 2022 06:45:13 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [80.241.60.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4JZRzp2s8XzQlNZ;
        Thu, 13 Jan 2022 15:45:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Date:   Fri, 14 Jan 2022 01:44:58 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        ptikhomirov@virtuozzo.com, linux-api@vger.kernel.org
Subject: Re: [PATCH] fs/open: add new RESOLVE_EMPTY_PATH flag for openat2
Message-ID: <20220113144458.vpqlowweiiqkxgsc@senku>
References: <1641978137-754828-1-git-send-email-andrey.zhadchenko@virtuozzo.com>
 <20220112143419.rgxumbts2jjb4aig@senku>
 <20220112145109.pou6676bsoatfg6x@wittgenstein>
 <011a03b8-81a8-9b0e-a41b-93d9dde12d5f@virtuozzo.com>
 <20220113064643.dhhdhb7kw2qetyu3@senku>
 <20220113140556.asn5sbeyisegb44h@wittgenstein>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cikzx6mojdynwf3q"
Content-Disposition: inline
In-Reply-To: <20220113140556.asn5sbeyisegb44h@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--cikzx6mojdynwf3q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-01-13, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> On Thu, Jan 13, 2022 at 05:46:43PM +1100, Aleksa Sarai wrote:
> > On 2022-01-12, Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com> wrot=
e:
> > > On 1/12/22 17:51, Christian Brauner wrote:
> > > > On Thu, Jan 13, 2022 at 01:34:19AM +1100, Aleksa Sarai wrote:
> > > > > On 2022-01-12, Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com=
> wrote:
> > > > > > If you have an opened O_PATH file, currently there is no way to=
 re-open
> > > > > > it with other flags with openat/openat2. As a workaround it is =
possible
> > > > > > to open it via /proc/self/fd/<X>, however
> > > > > > 1) You need to ensure that /proc exists
> > > > > > 2) You cannot use O_NOFOLLOW flag
> > > > >=20
> > > > > There is also another issue -- you can mount on top of magic-link=
s so if
> > > > > you're a container runtime that has been tricked into creating bad
> > > > > mounts of top of /proc/ subdirectories there's no way of detectin=
g that
> > > > > this has happened. (Though I think in the long-term we will need =
to
> > > > > make it possible for unprivileged users to create a procfs mountf=
d if
> > > > > they have hidepid=3D4,subset=3Dpids set -- there are loads of thi=
ngs
> > > > > containers need to touch in procfs which can be overmounted in ma=
licious
> > > > > ways.)
> > > >=20
> > > > Yeah, though I see this as a less pressing issue for now. I'd rather
> > > > postpone this and make userspace work a bit more. There are ways to
> > > > design programs so you know that the procfs instance you're interac=
ting
> > > > with is the one you want to interact with without requiring unprivi=
leged
> > > > mounting outside of a userns+pidns+mountns pair. ;)
> > > >=20
> > > > >=20
> > > > > > Both problems may look insignificant, but they are sensitive fo=
r CRIU.
> > > > > > First of all, procfs may not be mounted in the namespace where =
we are
> > > > > > restoring the process. Secondly, if someone opens a file with O=
_NOFOLLOW
> > > > > > flag, it is exposed in /proc/pid/fdinfo/<X>. So CRIU must also =
open the
> > > > > > file with this flag during restore.
> > > > > >=20
> > > > > > This patch adds new constant RESOLVE_EMPTY_PATH for resolve fie=
ld of
> > > > > > struct open_how and changes getname() call to getname_flags() t=
o avoid
> > > > > > ENOENT for empty filenames.
> > > > >=20
> > > > > This is something I've wanted to implement for a while, but from =
memory
> > > > > we need to add some other protections in place before enabling th=
is.
> > > > >=20
> > > > > The main one is disallowing re-opening of a path when it was orig=
inally
> > > > > opened with a different set of modes. [1] is the patch I original=
ly
> > > I looked at this patch. However I am not able to reproduce the proble=
m.
> > > For example, I can't open /proc/self/exe as RDWR with the following:
> > > fd1 =3D open(/proc/self/exe, O_PATH)
> > > fd2 =3D open(/proc/self/fd/3, O_RDWR) <- error
> > > or open file with incorrect flags via O_PATH to O_PATH fd from proc
> > > This is fixed or did I understand this problem wrong?
> >=20
> > You will get -ETXTBSY because the /proc/self/exe is still a current->mm
> > of a process. What you need to do is have two processes (or fork+exec a
> > process and do this):
>=20
> Note that not too long ago someone proposed to remove the -ETXTBSY
> restriction and I argued against doing that in order to not make these
> attacks easier.
>=20
> >=20
> >  1. Grab the /proc/$pid/exe handle of the target process.
> >  2. Wait for the target process to do an exec() of another program (or
> >     exit).
> >  3. *Then* re-open the fd with write permissions. This is allowed
> >     because the file is no longer being used as the current->mm of a
> > 	process and thus is treated like a regular file handle even though
> > 	it was only ever resolveable through /proc/self/exe which should
> > 	(semantically) only ever be readable.
> >=20
> > This attack was used against runc in 2016 and a similar attack was
> > possible with some later CVEs (I think there was also one against LXC at
> > some point but I might be mistaken). There were other bugs which lead to
>=20
> (IIrc, it only affects privileged containers and we did write the fix for=
 this
> together.)
>=20
> > this vector being usable, but my view is that this shouldn't have been
> > possible in the first place.
> >=20
> > I can cook up a simple example if the above description isn't explaining
> > the issue thoroughly enough.
> >=20
> > > > > wrote as part of the openat2(2) (but I dropped it since I wasn't =
sure
> > > > > whether it might break some systems in subtle ways -- though acco=
rding
> > > > > to my testing there wasn't an issue on any of my machines).
> > > >=20
> > > > Oh this is the discussion we had around turning an opath fd into a =
say
> > > > O_RDWR fd, I think.
> > > > So yes, I think restricting fd reopening makes sense. However, going
> > > > from an O_PATH fd to e.g. an fd with O_RDWR does make sense and nee=
ds to
> > > > be the default anyway. So we would need to implement this as a deny=
list
> > > > anyway. The default is that opath fds can be reopened with whatever=
 and
> > > > only if the opath creator has restricted reopening will it fail, i.=
e.
> > > > it's similar to a denylist.
> > > >=20
> > > > But this patch wouldn't prevent that or hinder the upgrade mask
> > > > restriction afaict.
> > >=20
> > > This issue is actually more complicated than I thought.
> > >=20
> > > What do you think of the following:
> > > 1. Add new O_EMPTYPATH constant
> > > 2. When we open something with O_PATH, remember access flags (current=
ly
> > > we drop all flags in do_dentry_open() for O_PATH fds). This is similar
> > > to Aleksa Sarai idea, but I do not think we should add some new field=
s,
> > > because CRIU needs to be able to see it. Just leave access flags
> > > untouched.
> >=20
> > There are two problems with this:
> >=20
> >  * The problem with this is that O_PATH and O_PATH|O_RDONLY are
> >    identical. O_RDONLY is defined as 0. I guess by new fields you're
> >    referring to what you'd get from fcntl(F_GETFL)?
> >=20
> >    What you're suggesting here is the openat2() O_PATH access mask
> >    stuff. That is a feature I think would be useful, but it's not
> >    necessary to get O_EMPTYPATH working.
>=20
> Yes, that's crucial to notice. I don't think we need to make the
> patchsets dependent on each other which is what I mentioned in my
> earlier mail.
>=20
> >=20
> >    If you really need to be able to get the O_PATH re-opening mask of a
> >    file descriptor (which you probably do for CRIU) we can add that
> >    information to F_GETFL or some other such interface.
>=20
> fcntl() would certainly be a sensible choice for that.
>=20
> >=20
> >  * We need to make sure that the default access modes of O_PATH on
> >    magic links are correct. We can't simply allow any access mode in
> >    that case, because if we do then we haven't really solved the
> >    /proc/self/exe issue.
>=20
> Or alternatively we make O_EMPTYPATH not work on magic links.
>=20
> >=20
> > > 3. for openat(fd, "", O_EMPTYPATH | <access flags>) additionally check
> > > access flags against the ones we remembered for O_PATH fd
> >=20
> >  * We also need to add the same restrictions for opening through
> >    /proc/self/fd/$n.
> >=20
> > > This won't solve magiclinks problems but there at least will be API to
> > > avoid procfs and which allow to add some restrictions.
> >=20
> > I think the magic link problems need to be solved if we're going to
> > enshrine this fd reopening behaviour by adding an O_* flag for it.
>=20
> As I understand it there are two naive options:
> 1. We do add O_EMPTYPATH before introducing upgrade masks. In this case
>    O_EMPTYPATH would be unrestricted by default. Meaning, you can go
>    from an O_PATH fd to an fd with any access mask.
>    So after the introduction of upgrade masks, O_EMPTYPATH is restricted
>    iff the O_PATH fd has opened with an upgrade mask.
> 2. We do introduce upgrade masks before introducing O_EMPTYPATH.
>    Iiuc, we could then introduce O_EMPTYPATH in a more restricted
>    manner such that O_EMPTYPATH will be restricted by default,
>    i.e. it wouldn't allow reopening an O_PATH fd _unless_ an upgrade
>    mask has been specified. The problem with this approach is that
>    /proc/self/fd/$n would break that logic and we can't change that
>    behavior without regressions.
>    Additionally, this might  make O_EMPTYPATH less useful for some users
>    in case they are not in control of the O_PATH fd handed to them
>    and the opener has not opened the O_PATH fd with an upgrade mask.
>=20
> So I think 2. is out of the question which means that we can add
> O_EMPTYPATH first or add upgrade masks first or together; it wouldn't
> really matter afaict.

Yeah agreed. (1) was what I had planned originally. O_EMPTYPATH should
be identical semantically to /proc/self/fd/$n (both for the API's sanity
and our own). It also makes more sense to make upgrade_mask a deny list
because it makes it simpler to add new deny modes in the future (such as
denying exec permissions -- which isn't currently possible).

And yes, we should add upgrade_masks later.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--cikzx6mojdynwf3q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCYeA65wAKCRCdlLljIbnQ
EsZ2AQDpjVAuKYxE7KNEMkeAEKedSUvPHzcuuDfUu4SkGaZbWQEAu6kVa1WfzSDk
qlZDmCvY+foGgHavxJhXVxidIlAvKAg=
=/ZRC
-----END PGP SIGNATURE-----

--cikzx6mojdynwf3q--
