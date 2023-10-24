Return-Path: <linux-fsdevel+bounces-1082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C32257D53DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 16:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24DB1C20C6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 14:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8116F2C863;
	Tue, 24 Oct 2023 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIcNEkom"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF832FBFB
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 14:24:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161ECC433C7;
	Tue, 24 Oct 2023 14:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698157468;
	bh=7s4owhTS2KWdPLIBnSmPESiU6Lmlr9CBB23zaMiuKo8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=HIcNEkomyOMSom+TIflQWtM1yj31IzKvSV99wsuAM9Ems2egxYGi+XMdfPwJYutrD
	 GYeOu78X4F5rTATUVir3ssZR4gFcryc0oPeTydpOPsrU3LN+eOOp0xhO6DZYTjds+7
	 BN0YVN0YKh8LhIykqaw8RiwxQ+sMOByx7ypNDLqRAk5Tcmr3xnjiuD6whzGD8Czxvi
	 CB+4O2pvEK2XXx/vp7vEkV4OzMUDtNLCgUIlAtMH6G20hZ5nTK4HXE9iGcGtyNzdk/
	 QfNAxAAcWjNWVoYhKL7AYJgOeODO/rA3atgoHqxvRcgpEDFC+9uOB0vnTz1lWMSiB/
	 OMX51ENDmTLRw==
Message-ID: <01ecb2b7876a4562570658b92f4c12cbc7ad2518.camel@kernel.org>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
From: Jeff Layton <jlayton@kernel.org>
To: Dave Chinner <david@fromorbit.com>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Christian Brauner
 <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, John Stultz
 <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd
 <sboyd@kernel.org>, Chandan Babu R <chandan.babu@oracle.com>, "Darrick J.
 Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, Josef Bacik
 <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Hugh Dickins
 <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, Amir
 Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>, David Howells
 <dhowells@redhat.com>,  linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org,  linux-btrfs@vger.kernel.org,
 linux-mm@kvack.org, linux-nfs@vger.kernel.org
Date: Tue, 24 Oct 2023 10:24:24 -0400
In-Reply-To: <ZTc8tClCRkfX3kD7@dread.disaster.area>
References: 
	<CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
	 <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
	 <20231019-fluor-skifahren-ec74ceb6c63e@brauner>
	 <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
	 <ZTGncMVw19QVJzI6@dread.disaster.area>
	 <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
	 <ZTWfX3CqPy9yCddQ@dread.disaster.area>
	 <61b32a4093948ae1ae8603688793f07de764430f.camel@kernel.org>
	 <ZTcBI2xaZz1GdMjX@dread.disaster.area>
	 <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
	 <ZTc8tClCRkfX3kD7@dread.disaster.area>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-10-24 at 14:40 +1100, Dave Chinner wrote:
> On Mon, Oct 23, 2023 at 02:18:12PM -1000, Linus Torvalds wrote:
> > On Mon, 23 Oct 2023 at 13:26, Dave Chinner <david@fromorbit.com> wrote:
> > >=20
> > > The problem is the first read request after a modification has been
> > > made. That is causing relatime to see mtime > atime and triggering
> > > an atime update. XFS sees this, does an atime update, and in
> > > committing that persistent inode metadata update, it calls
> > > inode_maybe_inc_iversion(force =3D false) to check if an iversion
> > > update is necessary. The VFS sees I_VERSION_QUERIED, and so it bumps
> > > i_version and tells XFS to persist it.
> >=20
> > Could we perhaps just have a mode where we don't increment i_version
> > for just atime updates?
> >=20
> > Maybe we don't even need a mode, and could just decide that atime
> > updates aren't i_version updates at all?
>=20
> We do that already - in memory atime updates don't bump i_version at
> all. The issue is the rare persistent atime update requests that
> still happen - they are the ones that trigger an i_version bump on
> XFS, and one of the relatime heuristics tickle this specific issue.
>=20
> If we push the problematic persistent atime updates to be in-memory
> updates only, then the whole problem with i_version goes away....
>=20

POSIX (more or less) states that if you're updating the inode for any
reason other than an atime update, then you need to update the ctime.
The NFSv4 spec (more or less) defines the change attribute as something
that should show a change any time the ctime would change.

Now, from mount(8) manpage, in the section on lazytime:

           The on-disk timestamps are updated only when:

           =E2=80=A2   the inode needs to be updated for some change unrela=
ted to file timestamps

           =E2=80=A2   the application employs fsync(2), syncfs(2), or sync=
(2)

           =E2=80=A2   an undeleted inode is evicted from memory

           =E2=80=A2   more than 24 hours have passed since the inode was w=
ritten to disk.


The first is not a problem for NFS. If we're updating the ctime or mtime
or other attributes, then we _need_ to bump the change attribute
(assuming that something has queried it and can tell a difference).

The second is potentially an issue. If a file has an in-memory atime
update and them someone calls sync(2), XFS will end up bumping the
change attribute.

Ditto for the third. If someone does a getattr and brings an inode back
into core, then you're looking at a cache invalidation on the client.

The fourth is also a problem, once a day your clients will end up
invaliding their caches.

You might think "so what? Once a day is no big deal!", but there are
places that have built up cascading fscache setups across WANs to
distribute large, read-mostly files. This is quite problematic in these
sorts of setups as they end up seeing cache invalidations all over the
place.

noatime is a workaround, but it has its own problems and ugliness, and
it sucks that XFS doesn't "just work" when served by NFS.


> > Yes, yes, it's obviously technically a "inode modification", but does
> > anybody actually *want* atime updates with no actual other changes to
> > be version events?
>=20
> Well, yes, there was. That's why we defined i_version in the on disk
> format this way well over a decade ago. It was part of some deep
> dark magical HSM beans that allowed the application to combine
> multiple scans for different inode metadata changes into a single
> pass. atime changes was one of the things it needed to know about
> for tiering and space scavenging purposes....
>=20

As Amir points out, is this still behavior that you're required to
preserve? NFS serving is a bit more common than weird HSM stuff.=20

Maybe newly created XFS filesystems could be made to update i_version in
a way that nfsd expects? We could add a mkfs.xfs option to allow for the
legacy behavior if required.

> > Or maybe i_version can update, but callers of getattr() could have two
> > bits for that STATX_CHANGE_COOKIE, one for "I care about atime" and
> > one for others, and we'd pass that down to inode_query_version, and
> > we'd have a I_VERSION_QUERIED and a I_VERSION_QUERIED_STRICT, and the
> > "I care about atime" case ould set the strict one.
>=20
> This makes correct behaviour reliant on the applicaiton using the
> query mechanism correctly. I have my doubts that userspace
> developers will be able to understand the subtle difference between
> the two options and always choose correctly....
>=20
> And then there's always the issue that we might end up with both
> flags set and we get conflicting bug reports about how atime is not
> behaving the way the applications want it to behave.
>=20
> > Then inode_maybe_inc_iversion() could - for atome updates - skip the
> > version update *unless* it sees that I_VERSION_QUERIED_STRICT bit.
> >=20
> > Does that sound sane to people?
>=20
> I'd much prefer we just do the right thing transparently at the
> filesystem level; all we need is for the inode to be flagged that it
> should be doing in memory atime updates rather than persistent
> updates.
>=20
> Perhaps the nfs server should just set a new S_LAZYTIME flag on
> inodes it accesses similar to how we can set S_NOATIME on inodes to
> elide atime updates altogether. Once set, the inode will behave that
> way until it is reclaimed from memory....
>=20


Yeah, I think adding this sort of extra complexity on the query side is
probably not what's needed.

I'm also not crazy about trying to treat nfsd's accesses as special in
some way. nfsd is really not doing anything special at all, other than
querying for STATX_CHANGE_COOKIE.=20

The problem is on the update side: nfsd expects the STATX_CHANGE_COOKIE
to conform to certain behavior, and XFS simply does not (specifically
around updates to the inode that only change the atime).

--=20
Jeff Layton <jlayton@kernel.org>

