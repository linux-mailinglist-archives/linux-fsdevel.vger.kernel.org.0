Return-Path: <linux-fsdevel+bounces-826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F83C7D0F78
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 14:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712671C20F9C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 12:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4351E19BA7;
	Fri, 20 Oct 2023 12:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1KeUXaw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CA8199DB
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 12:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3EAC433C7;
	Fri, 20 Oct 2023 12:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697803969;
	bh=kB1Zjc2tT/Kiij0RZHUaSZTbaKT3uaV6kt0MZRqO3ao=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=u1KeUXawoYyG3rdDy6jdJTAMa6CBiujADoCmEXdNuYkXyu9MLmAhCs59XHfewH69Z
	 1YZtXxAjuumkL12vc+r8XM0XyYBZEzhXynSZ8iHJcmV+MiHV1Js0QSa9/YPOzeTCNg
	 ddC9z/urYYAvgVu/TEDRRvWgEO9YYF+FZ8oYuLQg7R8KKucqjObvftSldeq5NRaMUN
	 ySFtaBhZ3Ud0vLczoN7hL8eQ5kMDVN+Cbtg1oCUsjPsRtKmaAHvc+K9G3jPnZvPiyH
	 hVMKjWAP6YVlcCH6eSZNXNhEobwTgcvkSLHsZetlLf5JFxGLWQYlbapQu1DCjW/MN1
	 iu2/HSTHJb02A==
Message-ID: <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
From: Jeff Layton <jlayton@kernel.org>
To: Dave Chinner <david@fromorbit.com>, Kent Overstreet
	 <kent.overstreet@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Stephen Boyd <sboyd@kernel.org>,  Chandan Babu R <chandan.babu@oracle.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, Josef
 Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Hugh Dickins
 <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, Amir
 Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>, David Howells
 <dhowells@redhat.com>,  linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org,  linux-btrfs@vger.kernel.org,
 linux-mm@kvack.org, linux-nfs@vger.kernel.org
Date: Fri, 20 Oct 2023 08:12:45 -0400
In-Reply-To: <ZTGncMVw19QVJzI6@dread.disaster.area>
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
	 <20231018-mgtime-v1-2-4a7a97b1f482@kernel.org>
	 <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
	 <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
	 <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
	 <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
	 <20231019-fluor-skifahren-ec74ceb6c63e@brauner>
	 <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
	 <ZTGncMVw19QVJzI6@dread.disaster.area>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-10-20 at 09:02 +1100, Dave Chinner wrote:
> On Thu, Oct 19, 2023 at 07:28:48AM -0400, Jeff Layton wrote:
> > On Thu, 2023-10-19 at 11:29 +0200, Christian Brauner wrote:
> > > > Back to your earlier point though:
> > > >=20
> > > > Is a global offset really a non-starter? I can see about doing some=
thing
> > > > per-superblock, but ktime_get_mg_coarse_ts64 should be roughly as c=
heap
> > > > as ktime_get_coarse_ts64. I don't see the downside there for the no=
n-
> > > > multigrain filesystems to call that.
> > >=20
> > > I have to say that this doesn't excite me. This whole thing feels a b=
it
> > > hackish. I think that a change version is the way more sane way to go=
.
> > >=20
> >=20
> > What is it about this set that feels so much more hackish to you? Most
> > of this set is pretty similar to what we had to revert. Is it just the
> > timekeeper changes? Why do you feel those are a problem?
> >=20
> > > >=20
> > > > On another note: maybe I need to put this behind a Kconfig option
> > > > initially too?
> > >=20
> > > So can we for a second consider not introducing fine-grained timestam=
ps
> > > at all. We let NFSv3 live with the cache problem it's been living wit=
h
> > > forever.
> > >=20
> > > And for NFSv4 we actually do introduce a proper i_version for all
> > > filesystems that matter to it.
> > >=20
> > > What filesystems exactly don't expose a proper i_version and what doe=
s
> > > prevent them from adding one or fixing it?
> >=20
> > Certainly we can drop this series altogether if that's the consensus.
> >=20
> > The main exportable filesystem that doesn't have a suitable change
> > counter now is XFS. Fixing it will require an on-disk format change to
> > accommodate a new version counter that doesn't increment on atime
> > updates. This is something the XFS folks were specifically looking to
> > avoid, but maybe that's the simpler option.
>=20
> And now we have travelled the full circle.
>=20

LOL, yes!

> The problem NFS has with atime updates on XFS is a result of
> the default behaviour of relatime - it *always* forces a persistent
> atime update after mtime has changed. Hence a read-after-write
> operation will trigger an atime update because atime is older than
> mtime. This is what causes XFS to run a transaction (i.e. a
> persistent atime update) and that bumps iversion.
>=20

Those particular atime updates are not a problem. If we're updating the
mtime and ctime anyway, then bumping the change attribute is OK.

The problem is that relatime _also_ does an on-disk update once a day
for just an atime update. On XFS, this means that the change attribute
also gets bumped and the clients invalidate their caches all at once.

That doesn't sound like a big problem at first, but what if you're
sharing a multi-gigabyte r/o file between multiple clients? This sort of
thing is fairly common on render-farm workloads, and all of your clients
will end up invalidating their caches once once a day if you're serving
from XFS.

> lazytime does not behave this way - it delays all persistent
> timestamp updates until the next persistent change or until the
> lazytime aggregation period expires (24 hours). Hence with lazytime,
> read-after-write operations do not trigger a persistent atime
> update, and so XFS does not run a transaction to update atime. Hence
> i_version does not get bumped, and NFS behaves as expected.
>=20

Similar problem here. Once a day, NFS clients will invalidate the cache
on any static content served from XFS.

> IOWs, what the NFS server actually wants from the filesytsems is for
> lazy timestamp updates to always be used on read operations. It does
> not want persistent timestamp updates that change on-disk state. The
> recent "redefinition" of when i_version should change effectively
> encodes this - i_version should only change when a persistent
> metadata or data change is made that also changes [cm]time.
>
> Hence the simple, in-memory solution to this problem is for NFS to
> tell the filesysetms that it needs to using lazy (in-memory) atime
> updates for the given operation rather than persistent atime updates.
>
> We already need to modify how atime updates work for io_uring -
> io_uring needs atime updates to be guaranteed non-blocking similar
> to updating mtime in the write IO path. If a persistent timestamp
> change needs to be run, then the timestamp update needs to return
> -EAGAIN rather than (potentially) blocking so the entire operation
> can be punted to a context that can block.
>=20
> This requires control flags to be passed to the core atime handling
> functions.  If a filesystem doesn't understand/support the flags, it
> can just ignore it and do the update however it was going to do it.
> It won't make anything work incorrectly, just might do something
> that is not ideal.
>=20
> With this new "non-blocking update only" flag for io_uring and a
> new "non-persistent update only" flag for NFS, we have a very
> similar conditional atime update requirements from two completely
> independent in-kernel applications.
>=20
> IOWs, this can be solved quite simply by having the -application-
> define the persistence semantics of the operation being performed.
> Add a RWF_LAZYTIME/IOCB_LAZYTIME flag for read IO that is being
> issued from the nfs daemon (i.e. passed to vfs_iter_read()) and then
> the vfs/filesystem can do exactly the right thing for the IO being
> issued.
>=20
> This is what io_uring does with IOCB_NOWAIT to tell the filesystems
> that the IO must be non-blocking, and it's the key we already use
> for non-blocking mtime updates and will use to trigger non-blocking
> atime updates....
>=20
> I also know of cases where a per-IO RWF_LAZYTIME flag would be
> beneficial - large databases are already using lazytime mount
> options so that their data IO doesn't take persistent mtime update
> overhead hits on every write IO.....
>=20

I don't think that trying to do something "special" for activity that is
initiated by the NFS server solves anything. Bear in mind that NFS
clients care about locally-initiated activity too.

The bottom line is that we don't want to be foisting a cache
invalidation on the clients just because someone read a file, or did
some similar activity like a readdir or readlink. The lazytime/relatime
options may mitigate the problem, but they're not a real solution.

What NFS _really_ wants is a proper change counter that doesn't
increment on read(like) operations. In practice, that comes down to just
not incrementing it on atime updates.

btrfs, ext4 and tmpfs have this (now). xfs does not because its change
attribute is incremented when an atime update is logged, and that is
evidently something that cannot be changed without an on-disk format
change.

> > There is also bcachefs which I don't think has a change attr yet. They'=
d
> > also likely need a on-disk format change, but hopefully that's a easier
> > thing to do there since it's a brand new filesystem.
>=20
> It's not a "brand new filesystem". It's been out there for quite a
> long while, and it has many users that would be impacted by on-disk
> format changes at this point in it's life. on-disk format changes
> are a fairly major deal for filesystems, and if there is any way we
> can avoid them we should.


Sure. It's new to me though. It's also not yet merged into mainline.

I'd _really_ like to see a proper change counter added before it's
merged, or at least space in the on-disk inode reserved for one until we
can get it plumbed in. That would suck for the current users, I suppose,
but at least that userbase is small now. Once it's merged, there will be
a lot more people using it and it becomes just that much more difficult.

I suppose bcachefs could try to hold out for the multigrain timestamp
work too, but that may not ever make it in.
--=20
Jeff Layton <jlayton@kernel.org>

