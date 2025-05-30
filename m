Return-Path: <linux-fsdevel+bounces-50230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E72BBAC929A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 17:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA4D17EEA3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 15:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC9A235068;
	Fri, 30 May 2025 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMtl2R3s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255121E515;
	Fri, 30 May 2025 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748619529; cv=none; b=qogguJbVPfNBTl5IAkDFKt8EiWDTmzgwCjGr2lTQw+bVonxtFHhZgWBRbOse1e/S4rGHvWlzGSJxxEFt9up9WLeGfErBQe22RhHfaOrwd3pZLDC44xPt4+CHiAkC2oaOWxBORJkgsvVPVRmwkWSPNoyhPDbLo14zZ+D3mQxzk84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748619529; c=relaxed/simple;
	bh=dBXrKDEhI+nsHFOnfREu9/TeElOB25sIEbCqv3Uht2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWBFb0ljjUlFkGvG8lgZC+P00uBJSQrxtTq0pmOixgKwYMaRfSA40rFukLP8LpgFQ3KVupB2kqrwb9dBlYGD9ivcS8qFz3OD74APl9D1BqTCAqAEqXuRam1GUEzNk+2W0c8uWgAY2r5DUldQYDTmFxbHcDXXIVG61qccbX+c+A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMtl2R3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FE5C4CEEB;
	Fri, 30 May 2025 15:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748619528;
	bh=dBXrKDEhI+nsHFOnfREu9/TeElOB25sIEbCqv3Uht2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sMtl2R3sCQaSgyH7q3yIAz5+xwxvPngs3VBb+j/+fU2li9uZJiIjQqd4zvALkgYcD
	 E7ufzJ23WEiF324t7MCL70ecWB4EAKP3Lrxt42spQYAjQ3PbFreu23oepdL4dptn93
	 Wh9omOqlq4SMsDVpt+5ZuJth+DxyPEQhlXbhVQaylyMrU7OXxGZXZCJksGd9iClyYg
	 Hv6ItdfUoBdi1JjrlzuJqnFbRWCjh66dVzvsTLQ+cZbghhv4ZfMpf0nsLsjJc96B7A
	 fQLvKF+JRL9yVpAk0f/rxSSBsEKJxN+iPDhr6CDsjqZ4EGEEgDaX6tWeLQriudPrLX
	 OL9Zkn1YH20Ag==
Date: Fri, 30 May 2025 08:38:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, cem@kernel.org,
	linux-xfs@vger.kernel.org,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [QUESTION] xfs, iomap: Handle writeback errors to prevent silent
 data corruption
Message-ID: <20250530153847.GC8328@frogsfrogsfrogs>
References: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>
 <20250529042550.GB8328@frogsfrogsfrogs>
 <20250530-ahnen-relaxen-917e3bba8e2d@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530-ahnen-relaxen-917e3bba8e2d@brauner>

On Fri, May 30, 2025 at 07:17:00AM +0200, Christian Brauner wrote:
> On Wed, May 28, 2025 at 09:25:50PM -0700, Darrick J. Wong wrote:
> > On Thu, May 29, 2025 at 10:50:01AM +0800, Yafang Shao wrote:
> > > Hello,
> > > 
> > > Recently, we encountered data loss when using XFS on an HDD with bad
> > > blocks. After investigation, we determined that the issue was related
> > > to writeback errors. The details are as follows:
> > > 
> > > 1. Process-A writes data to a file using buffered I/O and completes
> > > without errors.
> > > 2. However, during the writeback of the dirtied pagecache pages, an
> > > I/O error occurs, causing the data to fail to reach the disk.
> > > 3. Later, the pagecache pages may be reclaimed due to memory pressure,
> > > since they are already clean pages.
> > > 4. When Process-B reads the same file, it retrieves zeroed data from
> > > the bad blocks, as the original data was never successfully written
> > > (IOMAP_UNWRITTEN).
> > > 
> > > We reviewed the related discussion [0] and confirmed that this is a
> > > known writeback error issue. While using fsync() after buffered
> > > write() could mitigate the problem, this approach is impractical for
> > > our services.
> > > 
> > > Instead, we propose introducing configurable options to notify users
> > > of writeback errors immediately and prevent further operations on
> > > affected files or disks. Possible solutions include:
> > > 
> > > - Option A: Immediately shut down the filesystem upon writeback errors.
> > > - Option B: Mark the affected file as inaccessible if a writeback error occurs.
> > > 
> > > These options could be controlled via mount options or sysfs
> > > configurations. Both solutions would be preferable to silently
> > > returning corrupted data, as they ensure users are aware of disk
> > > issues and can take corrective action.
> > > 
> > > Any suggestions ?
> > 
> > Option C: report all those write errors (direct and buffered) to a
> > daemon and let it figure out what it wants to do:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=health-monitoring_2025-05-21
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=health-monitoring-rust_2025-05-21
> > 
> > Yes this is a long term option since it involves adding upcalls from the
> 
> I hope you don't mean actual usermodehelper upcalls here because we
> should not add any new ones. If you just mean a way to call up from a
> lower layer than that's obviously fine.

Correct.  The VFS upcalls to XFS on some event, then XFS queues the
event data (or drops it) and waits for userspace to read the queued
events.  We're not directly invoking a helper program from deep in the
guts, that's too wild even for me. ;)

> Fwiw, have you considered building this on top of a fanotify extension
> instead of inventing your own mechanism for this?

I have, at various stages of this experiment.

Originally, I was only going to export xfs-specific metadata events
(e.g. this AG's inode btree index is bad) so that the userspace program
(xfs_healer) could initiate a repair against the broken pieces.

At the time I thought it would be fun to experiment with an anonfd file
that emitted jsonp objects so that I could avoid the usual C struct ABI
mess because json is easily parsed into key-value mapping objects in a
lot of languages (that aren't C).  It later turned out that formatting
the json is rather more costly than I thought even with seq_bufs, so I
added an alternate format that emits boring C structures.

Having gone back to C structs, it would be possibly (and possibly quite
nice) to migrate to fanotify so that I don't have to maintain a bunch of
queuing code.  But that can have its own drawbacks, as Ted and I
discovered when we discussed his patches that pushed ext4 error events
through fanotify:

For filesystem metadata events, the fine details of representing that
metadata in a generic interface gets really messy because each
filesystem has a different design.  To initiate a repair you need to
know a lot of specifics: which AG has a bad structure, and what
structure within that AG; or which file and what structure under that
file, etc.  Ted and Jan Kara and I tried to come up with a reasonably
generic format for all that and didn't succeed; the best I could think
of is:

struct fanotify_event_info_fsmeta_error {
	struct fanotify_event_info_header hdr;

	__u32 mask;	/* bitmask of objects */
	__u32 what;	/* union decoder */
	union {
		struct {
			__u32 gno;	/* shard number if applicable */
			__u32 pad0[5];
		};
		struct {
			__u64 ino;	/* affected file */
			__u32 gen;
			__u32 pad1[3];
		};
		struct {
			__u64 diskaddr;	/* device media error */
			__u64 length;
			__u32 device;
			__u32 pad2;
		};
	};

	__u64 pad[2];	/* future expansion */
};

But now we have this gross struct with a union in the ABI, and what
happens when someone wants to add support for a filesystem with even
stranger stuff e.g. btrfs/bcachefs?  We could punt in the generic header
and do this instead:

struct fanotify_event_info_fsmeta_error {
	struct fanotify_event_info_header hdr;

	__u32 fstype;		/* same as statfs::f_type */
	unsigned char data[];	/* good luck with this */
};

and now you just open-cast a pointer to the char array to whatever
fs-specific format you want, but eeeuugh.

The other reason for sticking with an anonfd (so far) is that the kernel
side of xfs_healer is designed to maintain a soft reference to the
xfs_mount object so that the userspace program need not maintain an open
fd on the filesystem, because that prevents unmount.  I aim to find a
means for the magic healer fd to gain the ability to reopen the root
directory of the filesystem so that the sysadmin running mount --move
doesn't break the healer.

I think fanotify fixes the "healer pins the mount" problems but I don't
think there's a way to do the reopening thing.

Getting back to the question that opened this thread -- I think regular
file IO errors can be represented with a sequence of
fanotify_event_metadata -> fanotify_event_info_fid ->
fanotify_event_info_range -> fanotify_event_info_error objects in the
fanotify stream.  This format I think is easily standardized across
filesystems and can be wired up from iomap without a lot of fuss.  But I
don't know how fsnotify event blob chaining works well enough to say for
sure. :/

--D

> > pagecache/vfs into the filesystem and out through even more XFS code,
> > which has to go through its usual rigorous reviews.
> > 
> > But if there's interest then I could move up the timeline on submitting
> > those since I wasn't going to do much with any of that until 2026.
> > 
> > --D
> > 
> > > [0] https://lwn.net/Articles/724307/
> > > 
> > > -- 
> > > Regards
> > > Yafang

