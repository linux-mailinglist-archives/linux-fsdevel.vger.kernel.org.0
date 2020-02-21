Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF922166C40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 02:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgBUBWH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 20:22:07 -0500
Received: from mout-p-202.mailbox.org ([80.241.56.172]:22976 "EHLO
        mout-p-202.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729476AbgBUBWG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 20:22:06 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 48NtwW3WsKzQlCK;
        Fri, 21 Feb 2020 02:22:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id gB_F9IHMADEC; Fri, 21 Feb 2020 02:21:59 +0100 (CET)
Date:   Fri, 21 Feb 2020 12:21:42 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Ross Zwisler <zwisler@google.com>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Raul Rangel <rrangel@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mattias Nissler <mnissler@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Benjamin Gordon <bmgordon@google.com>,
        Micah Morton <mortonm@google.com>,
        Dmitry Torokhov <dtor@google.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v5] Add a "nosymfollow" mount option.
Message-ID: <20200221012142.4onrcfjtyghg237d@yavin.dot.cyphar.com>
References: <20200204215014.257377-1-zwisler@google.com>
 <CAHQZ30BgsCodGofui2kLwtpgzmpqcDnaWpS4hYf7Z+mGgwxWQw@mail.gmail.com>
 <CAGRrVHwQimihNNVs434jNGF3BL5_Qov+1eYqBYKPCecQ0yjxpw@mail.gmail.com>
 <CAGRrVHyzX4zOpO2nniv42BHOCbyCdPV9U7GE3FVhjzeFonb0bQ@mail.gmail.com>
 <20200205032110.GR8731@bombadil.infradead.org>
 <20200205034500.x3omkziqwu3g5gpx@yavin>
 <CAGRrVHxRdLMx5axcB1Fyea8RZhfd-EO3TTpQtOvpOP0yxnAsbQ@mail.gmail.com>
 <20200213154642.GA38197@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xsczwp6mfjixgoyo"
Content-Disposition: inline
In-Reply-To: <20200213154642.GA38197@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--xsczwp6mfjixgoyo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-13, Ross Zwisler <zwisler@google.com> wrote:
> On Thu, Feb 06, 2020 at 12:10:45PM -0700, Ross Zwisler wrote:
> > On Tue, Feb 4, 2020 at 8:45 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
> > > On 2020-02-04, Matthew Wilcox <willy@infradead.org> wrote:
> > > > On Tue, Feb 04, 2020 at 04:49:48PM -0700, Ross Zwisler wrote:
> > > > > On Tue, Feb 4, 2020 at 3:11 PM Ross Zwisler <zwisler@chromium.org=
> wrote:
> > > > > > On Tue, Feb 4, 2020 at 2:53 PM Raul Rangel <rrangel@google.com>=
 wrote:
> > > > > > > > --- a/include/uapi/linux/mount.h
> > > > > > > > +++ b/include/uapi/linux/mount.h
> > > > > > > > @@ -34,6 +34,7 @@
> > > > > > > >  #define MS_I_VERSION   (1<<23) /* Update inode I_version f=
ield */
> > > > > > > >  #define MS_STRICTATIME (1<<24) /* Always perform atime upd=
ates */
> > > > > > > >  #define MS_LAZYTIME    (1<<25) /* Update the on-disk [acm]=
times lazily */
> > > > > > > > +#define MS_NOSYMFOLLOW (1<<26) /* Do not follow symlinks */
> > > > > > > Doesn't this conflict with MS_SUBMOUNT below?
> > > > > > > >
> > > > > > > >  /* These sb flags are internal to the kernel */
> > > > > > > >  #define MS_SUBMOUNT     (1<<26)
> > > > > >
> > > > > > Yep.  Thanks for the catch, v6 on it's way.
> > > > >
> > > > > It actually looks like most of the flags which are internal to the
> > > > > kernel are actually unused (MS_SUBMOUNT, MS_NOREMOTELOCK, MS_NOSE=
C,
> > > > > MS_BORN and MS_ACTIVE).  Several are unused completely, and the r=
est
> > > > > are just part of the AA_MS_IGNORE_MASK which masks them off in the
> > > > > apparmor LSM, but I'm pretty sure they couldn't have been set any=
way.
> > > > >
> > > > > I'll just take over (1<<26) for MS_NOSYMFOLLOW, and remove the re=
st in
> > > > > a second patch.
> > > > >
> > > > > If someone thinks these flags are actually used by something and =
I'm
> > > > > just missing it, please let me know.
> > > >
> > > > Afraid you did miss it ...
> > > >
> > > > /*
> > > >  * sb->s_flags.  Note that these mirror the equivalent MS_* flags w=
here
> > > >  * represented in both.
> > > >  */
> > > > ...
> > > > #define SB_SUBMOUNT     (1<<26)
> > > >
> > > > It's not entirely clear to me why they need to be the same, but I h=
aven't
> > > > been paying close attention to the separation of superblock and mou=
nt
> > > > flags, so someone else can probably explain the why of it.
> > >
> > > I could be wrong, but I believe this is historic and originates from =
the
> > > kernel setting certain flags internally (similar to the whole O_* fla=
g,
> > > "internal" O_* flag, and FMODE_NOTIFY mixup).
> > >
> > > Also, one of the arguments for the new mount API was that we'd run out
> > > MS_* bits so it's possible that you have to enable this new mount opt=
ion
> > > in the new mount API only. (Though Howells is the right person to talk
> > > to on this point.)
> >=20
> > As far as I can tell, SB_SUBMOUNT doesn't actually have any dependence =
on
> > MS_SUBMOUNT. Nothing ever sets or checks MS_SUBMOUNT from within the ke=
rnel,
> > and whether or not it's set from userspace has no bearing on how SB_SUB=
MOUNT
> > is used.  SB_SUBMOUNT is set independently inside of the kernel in
> > vfs_submount().
> >=20
> > I agree that their association seems to be historical, introduced in th=
is
> > commit from David Howells:
> >=20
> > e462ec50cb5fa VFS: Differentiate mount flags (MS_*) from internal super=
block flags
> >=20
> > In that commit message David notes:
> >=20
> >      (1) Some MS_* flags get translated to MNT_* flags (such as MS_NODE=
V ->
> >          MNT_NODEV) without passing this on to the filesystem, but some
> >          filesystems set such flags anyway.
> >=20
> > I think this is sort of what we are trying to do with MS_NOSYMFOLLOW: h=
ave a
> > userspace flag that translates to MNT_NOSYMFOLLOW, but which doesn't ne=
ed an
> > associated SB_* flag.  Is it okay to reclaim the bit currently owned by
> > MS_SUBMOUNT and use it for MS_NOSYMFOLLOW.
> >=20
> > A second option would be to choose one of the unused MS_* values from t=
he
> > middle of the range, such as 256 or 512.  Looking back as far as git wi=
ll let
> > me, I don't think that these flags have been used for MS_* values at le=
ast
> > since v2.6.12:
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/include/linux/fs.h?id=3D1da177e4c3f41524e886b7f1b8a0c1fc7321cac2
> >=20
> > I think maybe these used to be S_WRITE and S_APPEND, which weren't file=
system
> > mount flags?
> >=20
> > https://sites.uclouvain.be/SystInfo/usr/include/sys/mount.h.html
> >=20
> > A third option would be to create this flag using the new mount system:
> >=20
> > https://lwn.net/Articles/753473/
> > https://lwn.net/Articles/759499/
> >=20
> > My main concern with this option is that for Chrome OS we'd like to be =
able to
> > backport whatever solution we come up with to a variety of older kernel=
s, and
> > if we go with the new mount system this would require us to backport the
> > entire new mount system to those kernels, which I think is infeasible. =
=20
> >=20
> > David, what are your thoughts on this?  Of these three options for supp=
orting
> > a new MS_NOSYMFOLLOW flag:
> >=20
> > 1) reclaim the bit currently used by MS_SUBMOUNT
> > 2) use a smaller unused value for the flag, 256 or 512
> > 3) implement the new flag only in the new mount system
> >=20
> > do you think either #1 or #2 are workable?  If so, which would you pref=
er?
>=20
> Gentle ping on this - do either of the options using the existing mount A=
PI
> seem possible?  Would it be useful for me to send out example patches in =
one
> of those directions?  Or is it out of the question, and I should spend my=
 time
> on making patches using the new mount system?  Thanks!

I think (1) or (2) sound reasonable, but I'm not really the right person
to ask.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--xsczwp6mfjixgoyo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXk8wowAKCRCdlLljIbnQ
Es1iAQDuT/a47/nE7aKahxtlanEMrLCGeMRrWIZPfm9nP6QvIAEAzmfRulzyRUaO
aJqg3PlVJUtu7shA39yqgFXB6iB3tQM=
=TQ4/
-----END PGP SIGNATURE-----

--xsczwp6mfjixgoyo--
