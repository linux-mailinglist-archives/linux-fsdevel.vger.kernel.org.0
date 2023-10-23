Return-Path: <linux-fsdevel+bounces-934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEA77D39FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 16:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB207281594
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 14:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838B51B279;
	Mon, 23 Oct 2023 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lw4U4lAm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C6A1B266
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 14:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8D9C433C8;
	Mon, 23 Oct 2023 14:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698072325;
	bh=91a8VTs5JN9FYOXvxMQyestaa0PVYwRW42Ibsjs911E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=lw4U4lAm7e7JjW7Twvx7dgnksnYjCafBZjdBtHp7UbNsZHBlltPUjwfAD3JJFobKK
	 YIclYbYbnUXV5wDd2QspXHH9j3ucue+ZaTh8WNKSNUeTT/zLjHvLj66WkoBv8ulyOf
	 /Qv0AVua2uCdW5bGV8Cx4N0ZBEiJ+F4c4V294klGZ4ucUjKrlazSO4ZiZLDV/8FzNB
	 yLpgjO9W+9YWCxRVa7jC03OI5RCnXRFtulL6oqaHgwpyiygr5K7T2jXwtye9F11REE
	 kyv23w34L5LNcObGEo7dvTpRRTVoq1aV70DkpmXFK+3I1AVp4x103QxLNAhdlZnnU/
	 zeSwwb9tkPHlA==
Message-ID: <61b32a4093948ae1ae8603688793f07de764430f.camel@kernel.org>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
From: Jeff Layton <jlayton@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Christian Brauner
 <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, John Stultz <jstultz@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,  Stephen Boyd <sboyd@kernel.org>,
 Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong"
 <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, Josef Bacik
 <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Hugh Dickins
 <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, Amir
 Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>, David Howells
 <dhowells@redhat.com>,  linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org,  linux-btrfs@vger.kernel.org,
 linux-mm@kvack.org, linux-nfs@vger.kernel.org
Date: Mon, 23 Oct 2023 10:45:21 -0400
In-Reply-To: <ZTWfX3CqPy9yCddQ@dread.disaster.area>
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
	 <20231018-mgtime-v1-2-4a7a97b1f482@kernel.org>
	 <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
	 <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
	 <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
	 <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
	 <20231019-fluor-skifahren-ec74ceb6c63e@brauner>
	 <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
	 <ZTGncMVw19QVJzI6@dread.disaster.area>
	 <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
	 <ZTWfX3CqPy9yCddQ@dread.disaster.area>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-10-23 at 09:17 +1100, Dave Chinner wrote:
> On Fri, Oct 20, 2023 at 08:12:45AM -0400, Jeff Layton wrote:
> > On Fri, 2023-10-20 at 09:02 +1100, Dave Chinner wrote:
> > > On Thu, Oct 19, 2023 at 07:28:48AM -0400, Jeff Layton wrote:
> > > > On Thu, 2023-10-19 at 11:29 +0200, Christian Brauner wrote:
> > > > > > Back to your earlier point though:
> > > > > >=20
> > > > > > Is a global offset really a non-starter? I can see about doing =
something
> > > > > > per-superblock, but ktime_get_mg_coarse_ts64 should be roughly =
as cheap
> > > > > > as ktime_get_coarse_ts64. I don't see the downside there for th=
e non-
> > > > > > multigrain filesystems to call that.
> > > > >=20
> > > > > I have to say that this doesn't excite me. This whole thing feels=
 a bit
> > > > > hackish. I think that a change version is the way more sane way t=
o go.
> > > > >=20
> > > >=20
> > > > What is it about this set that feels so much more hackish to you? M=
ost
> > > > of this set is pretty similar to what we had to revert. Is it just =
the
> > > > timekeeper changes? Why do you feel those are a problem?
> > > >=20
> > > > > >=20
> > > > > > On another note: maybe I need to put this behind a Kconfig opti=
on
> > > > > > initially too?
> > > > >=20
> > > > > So can we for a second consider not introducing fine-grained time=
stamps
> > > > > at all. We let NFSv3 live with the cache problem it's been living=
 with
> > > > > forever.
> > > > >=20
> > > > > And for NFSv4 we actually do introduce a proper i_version for all
> > > > > filesystems that matter to it.
> > > > >=20
> > > > > What filesystems exactly don't expose a proper i_version and what=
 does
> > > > > prevent them from adding one or fixing it?
> > > >=20
> > > > Certainly we can drop this series altogether if that's the consensu=
s.
> > > >=20
> > > > The main exportable filesystem that doesn't have a suitable change
> > > > counter now is XFS. Fixing it will require an on-disk format change=
 to
> > > > accommodate a new version counter that doesn't increment on atime
> > > > updates. This is something the XFS folks were specifically looking =
to
> > > > avoid, but maybe that's the simpler option.
> > >=20
> > > And now we have travelled the full circle.
> > >=20
> >=20
> > LOL, yes!
> >=20
> > > The problem NFS has with atime updates on XFS is a result of
> > > the default behaviour of relatime - it *always* forces a persistent
> > > atime update after mtime has changed. Hence a read-after-write
> > > operation will trigger an atime update because atime is older than
> > > mtime. This is what causes XFS to run a transaction (i.e. a
> > > persistent atime update) and that bumps iversion.
> > >=20
> >=20
> > Those particular atime updates are not a problem. If we're updating the
> > mtime and ctime anyway, then bumping the change attribute is OK.
> >=20
> > The problem is that relatime _also_ does an on-disk update once a day
> > for just an atime update. On XFS, this means that the change attribute
> > also gets bumped and the clients invalidate their caches all at once.
> >=20
> > That doesn't sound like a big problem at first, but what if you're
> > sharing a multi-gigabyte r/o file between multiple clients? This sort o=
f
> > thing is fairly common on render-farm workloads, and all of your client=
s
> > will end up invalidating their caches once once a day if you're serving
> > from XFS.
>=20
> So we have noatime inode and mount options for such specialised
> workloads that cannot tolerate cached ever being invalidated, yes?
>=20
> > > lazytime does not behave this way - it delays all persistent
> > > timestamp updates until the next persistent change or until the
> > > lazytime aggregation period expires (24 hours). Hence with lazytime,
> > > read-after-write operations do not trigger a persistent atime
> > > update, and so XFS does not run a transaction to update atime. Hence
> > > i_version does not get bumped, and NFS behaves as expected.
> > >=20
> >=20
> > Similar problem here. Once a day, NFS clients will invalidate the cache
> > on any static content served from XFS.
>=20
> Lazytime has /proc/sys/vm/dirtytime_expire_seconds to change the
> interval that triggers persistent time changes. That could easily be
> configured to be longer than a day for workloads that care about
> this sort of thing. Indeed, we could just set up timestamps that NFS
> says "do not make persistent" to only be persisted when the inode is
> removed from server memory rather than be timed out by background
> writeback....
>=20
> -----
>=20
> All I'm suggesting is that rather than using mount options for
> noatime-like behaviour for NFSD accesses, we actually have the nfsd
> accesses say "we'd like pure atime updates without iversion, please".
>=20
> Keep in mind that XFS does actually try to avoid bumping i_version
> on pure timestamp updates - we carved that out a long time ago (see
> the difference in XFS_ILOG_CORE vs XFS_ILOG_TIMESTAMP in
> xfs_vn_update_time() and xfs_trans_log_inode()) so that we could
> optimise fdatasync() to ignore timestamp updates that occur as a
> result of pure data overwrites.
>=20
> Hence XFS only bumps i_version for pure timestamp updates if the
> iversion queried flag is set. IOWs, XFS it is actually doing exactly
> what the VFS iversion implementation is telling it to do with
> timestamp updates for non-core inode metadata updates.
>=20
> That's the fundamental issue here: nfsd has set VFS state that tells
> the filesystem to "bump iversion on next persistent inode change",
> but the nfsd then runs operations that can change non-critical
> persistent inode state in "query-only" operations. It then expects
> filesystems to know that it should ignore the iversion queried state
> within this context.  However, without external behavioural control
> flags, filesystems cannot know that an isolated metadata update has
> context specific iversion behavioural constraints.

> Hence fixing this is purely a VFS/nfsd i_version implementation
> problem - if the nfsd is running a querying operation, it should
> tell the filesystem that it should ignore iversion query state. If
> nothing the application level cache cares about is being changed
> during the query operation, it should tell the filesystem to ignore
> iversion query state because it is likely the nfsd query itself will
> set it (or have already set it itself in the case of compound
> operations).
>=20
> This does not need XFS on-disk format changes to fix. This does not
> need changes to timestamp infrastructure to fix. We just need the
> nfsd application to tell us that we should ignore the vfs i_version
> query state when we update non-core inode metadata within query
> operation contexts.
>=20


I think you're missing the point of the problem I'm trying to solve.
I'm not necessarily trying to guard nfsd against its own accesses. The
reads that trigger an eventual atime update could come from anywhere --
nfsd, userland accesses, etc.

If you are serving an XFS filesystem, with the (default) relatime mount
option, then you are guaranteed that the clients will invalidate their
cache of a file once per day, assuming that at least one read was issued
against the file during that day.

That read will cause an eventual atime bump to be logged, at which point
the change attribute will change. The client will then assume that it
needs to invalidate its cache when it sees that change.

Changing how nfsd does its own accesses won't fix anything, because the
problematic atime bump can come from any sort of read access.
--=20
Jeff Layton <jlayton@kernel.org>

