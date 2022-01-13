Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABC948D272
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 07:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiAMGsF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 01:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiAMGsE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 01:48:04 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA75C06173F;
        Wed, 12 Jan 2022 22:48:04 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:105:465:1:4:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4JZFPG3nZ0zQjgH;
        Thu, 13 Jan 2022 07:48:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Date:   Thu, 13 Jan 2022 17:47:51 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        ptikhomirov@virtuozzo.com, linux-api@vger.kernel.org
Subject: Re: [PATCH] fs/open: add new RESOLVE_EMPTY_PATH flag for openat2
Message-ID: <20220113064751.y6sqhdnyudz2eo7e@senku>
References: <1641978137-754828-1-git-send-email-andrey.zhadchenko@virtuozzo.com>
 <20220112143940.ugj27xzprmptqmr7@wittgenstein>
 <20220112144331.dpbhi7j2vwutrxyt@senku>
 <20220112145325.hdim2q2qgewvgceh@wittgenstein>
 <0140c600-89e2-6be7-2967-f4b13b0baeaa@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ubysecontcjtk3jm"
Content-Disposition: inline
In-Reply-To: <0140c600-89e2-6be7-2967-f4b13b0baeaa@virtuozzo.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ubysecontcjtk3jm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-01-12, Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com> wrote:
>=20
>=20
> On 1/12/22 17:53, Christian Brauner wrote:
> > On Thu, Jan 13, 2022 at 01:43:31AM +1100, Aleksa Sarai wrote:
> > > On 2022-01-12, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> > > > On Wed, Jan 12, 2022 at 12:02:17PM +0300, Andrey Zhadchenko wrote:
> > > > > If you have an opened O_PATH file, currently there is no way to r=
e-open
> > > > > it with other flags with openat/openat2. As a workaround it is po=
ssible
> > > > > to open it via /proc/self/fd/<X>, however
> > > > > 1) You need to ensure that /proc exists
> > > > > 2) You cannot use O_NOFOLLOW flag
> > > > >=20
> > > > > Both problems may look insignificant, but they are sensitive for =
CRIU.
> > > >=20
> > > > Not just CRIU. It's also an issue for systemd, LXD, and other users.
> > > > (One old example is where we do need to sometimes stash an O_PATH f=
d to
> > > > a /dev/pts/ptmx device and to actually perform an open on the devic=
e we
> > > > reopen via /proc/<pid>/fd/<nr>.)
> > > >=20
> > > > > First of all, procfs may not be mounted in the namespace where we=
 are
> > > > > restoring the process. Secondly, if someone opens a file with O_N=
OFOLLOW
> > > > > flag, it is exposed in /proc/pid/fdinfo/<X>. So CRIU must also op=
en the
> > > > > file with this flag during restore.
> > > > >=20
> > > > > This patch adds new constant RESOLVE_EMPTY_PATH for resolve field=
 of
> > > > > struct open_how and changes getname() call to getname_flags() to =
avoid
> > > > > ENOENT for empty filenames.
> > > >=20
> > > >  From my perspective this makes sense and is something that would be
> > > > very useful instead of having to hack around this via procfs.
> > > >=20
> > > > However, e should consider adding RESOLVE_EMPTY_PATH since we alrea=
dy
> > > > have AT_EMPTY_PATH. If we think this is workable we should try and =
reuse
> > > > AT_EMPTY_PATH that keeps the api consistent with linkat(), readlink=
at(),
> > > > execveat(), statx(), open_tree(), mount_setattr() etc.
> > > >=20
> > > > If AT_EMPTY_PATH doesn't conflict with another O_* flag one could m=
ake
> > > > openat() support it too?
> > >=20
> > > I would much prefer O_EMPTYPATH, in fact I think this is what I called
> > > it in my first draft ages ago. RESOLVE_ is meant to be related to
> > > resolution restrictions, not changing the opening mode.
> >=20
> > That seems okay to me too. The advantage of AT_EMPTY_PATH is that we
> > don't double down on the naming confusion, imho.
> Unfortunately AT_EMPTY_PATH is 0x1000 which is O_DSYNC (octal 010000).
> At first I thought to add new field in struct open_how for AT_* flags.
> However most of them are irrelevant, except AT_SYMLINK_NOFOLLOW, which
> duplicates RESOLVE flags, and maybe AT_NO_AUTOMOUNT.
> O_EMPTYPATH idea seems cool

Yeah the issue is that openat/openat2 don't actually take AT_* flags and
all of the constants conflict. I would prefer not mixing O_ and AT_
flags in open (and I suspect Al would also prefer that).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--ubysecontcjtk3jm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCYd/LFQAKCRCdlLljIbnQ
Ep/XAQC3JjiknQDdfQ7gaTSTa8oEdMfufhQp8Gg8lciYE62x7AEAwFOm/Nuluvuq
Mh7NK9I0suuRZsJZsdY85sp+JLygwwU=
=82Gy
-----END PGP SIGNATURE-----

--ubysecontcjtk3jm--
