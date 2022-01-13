Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11B748D292
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 08:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiAMHDs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 02:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiAMHDp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 02:03:45 -0500
X-Greylist: delayed 511 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Jan 2022 23:03:45 PST
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F4BC06173F;
        Wed, 12 Jan 2022 23:03:44 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:105:465:1:4:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4JZFYW4LXSzQlM0;
        Thu, 13 Jan 2022 07:55:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Date:   Thu, 13 Jan 2022 17:55:00 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        ptikhomirov@virtuozzo.com, linux-api@vger.kernel.org
Subject: Re: [PATCH] fs/open: add new RESOLVE_EMPTY_PATH flag for openat2
Message-ID: <20220113065500.i5ho4sde7apyax3x@senku>
References: <1641978137-754828-1-git-send-email-andrey.zhadchenko@virtuozzo.com>
 <20220112143419.rgxumbts2jjb4aig@senku>
 <20220112145109.pou6676bsoatfg6x@wittgenstein>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="27hyu3bcsaud7wi2"
Content-Disposition: inline
In-Reply-To: <20220112145109.pou6676bsoatfg6x@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--27hyu3bcsaud7wi2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-01-12, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> On Thu, Jan 13, 2022 at 01:34:19AM +1100, Aleksa Sarai wrote:
> > On 2022-01-12, Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com> wrot=
e:
> > > If you have an opened O_PATH file, currently there is no way to re-op=
en
> > > it with other flags with openat/openat2. As a workaround it is possib=
le
> > > to open it via /proc/self/fd/<X>, however
> > > 1) You need to ensure that /proc exists
> > > 2) You cannot use O_NOFOLLOW flag
> >=20
> > There is also another issue -- you can mount on top of magic-links so if
> > you're a container runtime that has been tricked into creating bad
> > mounts of top of /proc/ subdirectories there's no way of detecting that
> > this has happened. (Though I think in the long-term we will need to
> > make it possible for unprivileged users to create a procfs mountfd if
> > they have hidepid=3D4,subset=3Dpids set -- there are loads of things
> > containers need to touch in procfs which can be overmounted in malicious
> > ways.)
>=20
> Yeah, though I see this as a less pressing issue for now. I'd rather
> postpone this and make userspace work a bit more. There are ways to
> design programs so you know that the procfs instance you're interacting
> with is the one you want to interact with without requiring unprivileged
> mounting outside of a userns+pidns+mountns pair. ;)

I'm not sure I agree. While with openat2(RESOLVE_NO_XDEV|RESOLVE_NO_SYMLINK=
S)
you can access the vast majority of procfs through a checked procfs
handle (fstatfs and the other checks you can do), you cannot jump
through magic links safely because RESOLVE_NO_XDEV blocks magic-link
jumps.

You can't even use a safe handle to /proc/self/fd and then just follow
the link because you can mount magiclinks on top of magiclinks, so even
a hypothetical RESOLVE_ONLY_MAGICLINKS wouldn't really work. Maybe a
RESOLVE_ONLY_MAGICLINKS that didn't cross mounts except if the crossing
was through a magiclink would work but I suspect implementing that would
be tricky (there's loads of places where you might trip LOOKUP_NO_XDEV).

O_EMPTYPATH would solve this issue for the /proc/self/fd/... magiclinks,
but /proc/self/{exe,cwd,root,ns/*} are all still susceptible to the same
issue. We use /proc/self/exe in runc, and everyone uses /proc/self/ns/*.

But yeah we can definitely solve this in a separate patchseries, and
O_EMPTYPATH is something we should have regardless of whether we solve
the procfs issue another way.

> > > Both problems may look insignificant, but they are sensitive for CRIU.
> > > First of all, procfs may not be mounted in the namespace where we are
> > > restoring the process. Secondly, if someone opens a file with O_NOFOL=
LOW
> > > flag, it is exposed in /proc/pid/fdinfo/<X>. So CRIU must also open t=
he
> > > file with this flag during restore.
> > >=20
> > > This patch adds new constant RESOLVE_EMPTY_PATH for resolve field of
> > > struct open_how and changes getname() call to getname_flags() to avoid
> > > ENOENT for empty filenames.
> >=20
> > This is something I've wanted to implement for a while, but from memory
> > we need to add some other protections in place before enabling this.
> >=20
> > The main one is disallowing re-opening of a path when it was originally
> > opened with a different set of modes. [1] is the patch I originally
> > wrote as part of the openat2(2) (but I dropped it since I wasn't sure
> > whether it might break some systems in subtle ways -- though according
> > to my testing there wasn't an issue on any of my machines).
>=20
> Oh this is the discussion we had around turning an opath fd into a say
> O_RDWR fd, I think.
> So yes, I think restricting fd reopening makes sense. However, going
> from an O_PATH fd to e.g. an fd with O_RDWR does make sense and needs to
> be the default anyway. So we would need to implement this as a denylist
> anyway. The default is that opath fds can be reopened with whatever and
> only if the opath creator has restricted reopening will it fail, i.e.
> it's similar to a denylist.
>=20
> But this patch wouldn't prevent that or hinder the upgrade mask
> restriction afaict.

Yeah the patch I linked implements the behaviour you mentioned (O_PATH
of a regular path lets you re-open with any mode, O_PATH of an O_PATH
copies the permitted re-opening modes of the old O_PATH, and O_PATH of a
magic link copies the file mode of the magic link).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--27hyu3bcsaud7wi2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCYd/MwQAKCRCdlLljIbnQ
Ejh/AP9TN+TTzNsppDzCQGdUyBFbAKZjhMETzh6ylRMs4KI6QQD/TY1KYHxQ0nuS
dur9asC3rlT+cTbjDSefkS11vJF6LQk=
=Jm1p
-----END PGP SIGNATURE-----

--27hyu3bcsaud7wi2--
