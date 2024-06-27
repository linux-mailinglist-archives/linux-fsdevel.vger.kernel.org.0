Return-Path: <linux-fsdevel+bounces-22642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F55991AB8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 17:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0361F25C66
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 15:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716CD19A2AB;
	Thu, 27 Jun 2024 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NC1H/10N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5401990AD;
	Thu, 27 Jun 2024 15:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502551; cv=none; b=oYIgZdZM6FzJ5GqExVT3USBjcRe0u6sYWbeAgzZ5kttE1sux/3z78yFbOsml/EaaDy6yVjIk+XbFm0t0XTL3a3NDCqTDbEKxK73vdwj7+e6X2iHN+8MHWZZy7rZXJg6I3atrExkENo2ENzggr3HiMqjQC6V7ZXfIAaT0Pp1Pu4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502551; c=relaxed/simple;
	bh=3d+ajZj2euzfXWW4x2ZVNbEbE/hiWAhLUJ05o+3lc94=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EuW7mjY0eydCX4YOz0n9k+HqvjRoLtB8gKu8J9Hor8YtN1O1IaWsxGHIYgM5PyLMXqallhgFUpIYlZVbDwIZWFB8eYeYw0mp3i5E/RUIlNVWYHXOaT8UL2FJphtnr8AxLiybfpFjvi/l4o/0dPFEdnS0ASx7XQzBQZFsFmDWaUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NC1H/10N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CAB1C2BBFC;
	Thu, 27 Jun 2024 15:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719502551;
	bh=3d+ajZj2euzfXWW4x2ZVNbEbE/hiWAhLUJ05o+3lc94=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=NC1H/10NXcID8rY9p89rWEAilDyHattVM/B3S+cB3nevhfH2M8Hlv8SgNjn/6dZJC
	 sRWB8/Rw8VzseX+Nbw5GcoeuBBZqKzg0fjYr1tbnFOj7RIiCIxo8VIYkepm1BXl7qQ
	 srlkLW/NyhucsDg8cgElhVTp+lgSdl8sd1nao7ii6y4Y8kF5pVIQ/Da3OcJZS8yIVA
	 vcib8biIamy9bwaOsNRscLh2IR17ooEqQaBMpnuh9UIYbXaE+8CuG3B0jLqqay37dl
	 Xfk3VAPKYStIu6GGEw/El657VGTfBuUw+Z0d8iNzcL17Qr+3l2b/CSrxDrZ7L4PSHK
	 AwkS+1XzKVvtg==
Message-ID: <4470c858a2a9056a9a26bb48ce36dbfc52a463e2.camel@kernel.org>
Subject: Re: [PATCH 04/10] fs: add infrastructure for multigrain timestamps
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Chandan Babu R
 <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, Theodore
 Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Chris
 Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
 <dsterba@suse.com>, Hugh Dickins <hughd@google.com>, Andrew Morton
 <akpm@linux-foundation.org>,  kernel-team@fb.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-mm@kvack.org,  linux-nfs@vger.kernel.org
Date: Thu, 27 Jun 2024 11:35:47 -0400
In-Reply-To: <Zn1/FVS4NrAwEBwz@tissot.1015granger.net>
References: <20240626-mgtime-v1-0-a189352d0f8f@kernel.org>
	 <20240626-mgtime-v1-4-a189352d0f8f@kernel.org>
	 <Zn1/FVS4NrAwEBwz@tissot.1015granger.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-27 at 11:02 -0400, Chuck Lever wrote:
> On Wed, Jun 26, 2024 at 09:00:24PM -0400, Jeff Layton wrote:
> > The VFS always uses coarse-grained timestamps when updating the ctime
> > and mtime after a change. This has the benefit of allowing filesystems
> > to optimize away a lot metadata updates, down to around 1 per jiffy,
> > even when a file is under heavy writes.
> >=20
> > Unfortunately, this has always been an issue when we're exporting via
> > NFSv3, which relies on timestamps to validate caches. A lot of changes
> > can happen in a jiffy, so timestamps aren't sufficient to help the
> > client decide to invalidate the cache. Even with NFSv4, a lot of
> > exported filesystems don't properly support a change attribute and are
> > subject to the same problems with timestamp granularity. Other
> > applications have similar issues with timestamps (e.g backup
> > applications).
> >=20
> > If we were to always use fine-grained timestamps, that would improve th=
e
> > situation, but that becomes rather expensive, as the underlying
> > filesystem would have to log a lot more metadata updates.
> >=20
> > What we need is a way to only use fine-grained timestamps when they are
> > being actively queried. Now that the ctime is stored as a ktime_t, we
> > can sacrifice the lowest bit in the word to act as a flag marking
> > whether the current timestamp has been queried via stat() or the like.
> >=20
> > This solves the problem of being able to distinguish the timestamp
> > between updates, but introduces a new problem: it's now possible for a
> > file being changed to get a fine-grained timestamp and then a file that
> > was altered later to get a coarse-grained one that appears older than
> > the earlier fine-grained time. To remedy this, keep a global ktime_t
> > value that acts as a timestamp floor.
> >=20
> > When we go to stamp a file, we first get the latter of the current floo=
r
> > value and the current coarse-grained time (call this "now"). If the
> > current inode ctime hasn't been queried then we just attempt to stamp i=
t
> > with that value using a cmpxchg() operation.
> >=20
> > If it has been queried, then first see whether the current coarse time
> > appears later than what we have. If it does, then we accept that value.
> > If it doesn't, then we get a fine-grained time and try to swap that int=
o
> > the global floor. Whether that succeeds or fails, we take the resulting
> > floor time and try to swap that into the ctime.
> >=20
> > There is still one remaining problem:
> >=20
> > All of this works as long as the realtime clock is monotonically
> > increasing. If the clock ever jumps backwards, then we could end up in =
a
> > situation where the floor value is "stuck" far in advance of the clock.
> >=20
> > To remedy this, sanity check the floor value and if it's more than 6ms
> > (~2 jiffies) ahead of the current coarse-grained clock, disregard the
> > floor value, and just accept the current coarse-grained clock.
> >=20
> > Filesystems opt into this by setting the FS_MGTIME fstype flag.=C2=A0 O=
ne
> > caveat: those that do will always present ctimes that have the lowest
> > bit unset, even when the on-disk ctime has it set.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > =C2=A0fs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 168 +++++++++++++++++++++++++++++++++------
> > =C2=A0fs/stat.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 39 ++++++++-
> > =C2=A0include/linux/fs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 30 +++++++
> > =C2=A0include/trace/events/timestamp.h |=C2=A0 97 +++++++++++++++++++++=
+
> > =C2=A04 files changed, 306 insertions(+), 28 deletions(-)
> >=20
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 5d2b0dfe48c3..12790a26102c 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -62,6 +62,8 @@ static unsigned int i_hash_shift __ro_after_init;
> > =C2=A0static struct hlist_head *inode_hashtable __ro_after_init;
> > =C2=A0static __cacheline_aligned_in_smp DEFINE_SPINLOCK(inode_hash_lock=
);
> > =C2=A0
> > +/* Don't send out a ctime lower than this (modulo backward clock jumps=
). */
> > +static __cacheline_aligned_in_smp ktime_t ctime_floor;
>=20
> This is piece of memory that will be hit pretty hard (and you
> obviously recognize that because of the alignment attribute).
>=20
> Would it be of any benefit to keep a distinct ctime_floor in each
> super block instead?
>=20

Good question. Dave Chinner suggested the same thing, but I think it's
a potential problem:

The first series had to be reverted because inodes that had been
modified in order could appear to be modified in reverse order with the
right combination of fine and coarse grained timestamps. With the new
floor value, that's no longer possible, but if we were to make it per-
sb then it becomes possible again with files in different filesystems.

This sort of timestamp comparison is done by tools like "make", and
it's rather common to keep built objects in one location and generate
or copy source files to another. My worry is that managing the floor as
anything but a global value could cause regressions in those sorts of
workloads.

>=20
> > =C2=A0/*
> > =C2=A0 * Empty aops. Can be used for the cases where the user does not
> > =C2=A0 * define any of the address_space operations.
> > @@ -2077,19 +2079,86 @@ int file_remove_privs(struct file *file)
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL(file_remove_privs);
> > =C2=A0
> > +/*
> > + * The coarse-grained clock ticks once per jiffy (every 2ms or so). If=
 the
> > + * current floor is >6ms in the future, assume that the clock has jump=
ed
> > + * backward.
> > + */
> > +#define CTIME_FLOOR_MAX_NS	6000000
> > +
> > +/**
> > + * coarse_ctime - return the current coarse-grained time
> > + * @floor: current ctime_floor value
> > + *
> > + * Get the coarse-grained time, and then determine whether to
> > + * return it or the current floor value. Returns the later of the
> > + * floor and coarse grained time, unless the floor value is too
> > + * far into the future. If that happens, assume the clock has jumped
> > + * backward, and that the floor should be ignored.
> > + */
> > +static ktime_t coarse_ctime(ktime_t floor)
> > +{
> > +	ktime_t now =3D ktime_get_coarse_real() & ~I_CTIME_QUERIED;
> > +
> > +	/* If coarse time is already newer, return that */
> > +	if (ktime_before(floor, now))
> > +		return now;
> > +
> > +	/* Ensure floor is not _too_ far in the future */
> > +	if (ktime_after(floor, now + CTIME_FLOOR_MAX_NS))
> > +		return now;
> > +
> > +	return floor;
> > +}
> > +
> > +/**
> > + * current_time - Return FS time (possibly fine-grained)
> > + * @inode: inode.
> > + *
> > + * Return the current time truncated to the time granularity supported=
 by
> > + * the fs, as suitable for a ctime/mtime change. If the ctime is flagg=
ed
> > + * as having been QUERIED, get a fine-grained timestamp.
> > + */
> > +struct timespec64 current_time(struct inode *inode)
> > +{
> > +	ktime_t ctime, floor =3D smp_load_acquire(&ctime_floor);
> > +	ktime_t now =3D coarse_ctime(floor);
> > +	struct timespec64 now_ts =3D ktime_to_timespec64(now);
> > +
> > +	if (!is_mgtime(inode))
> > +		goto out;
> > +
> > +	/* If nothing has queried it, then coarse time is fine */
> > +	ctime =3D smp_load_acquire(&inode->__i_ctime);
> > +	if (ctime & I_CTIME_QUERIED) {
> > +		/*
> > +		 * If there is no apparent change, then
> > +		 * get a fine-grained timestamp.
> > +		 */
> > +		if ((now | I_CTIME_QUERIED) =3D=3D ctime) {
> > +			ktime_get_real_ts64(&now_ts);
> > +			now_ts.tv_nsec &=3D ~I_CTIME_QUERIED;
> > +		}
> > +	}
> > +out:
> > +	return timestamp_truncate(now_ts, inode);
> > +}
> > +EXPORT_SYMBOL(current_time);
> > +
> > =C2=A0static int inode_needs_update_time(struct inode *inode)
> > =C2=A0{
> > +	struct timespec64 now, ts;
> > =C2=A0	int sync_it =3D 0;
> > -	struct timespec64 now =3D current_time(inode);
> > -	struct timespec64 ts;
> > =C2=A0
> > =C2=A0	/* First try to exhaust all avenues to not sync */
> > =C2=A0	if (IS_NOCMTIME(inode))
> > =C2=A0		return 0;
> > =C2=A0
> > +	now =3D current_time(inode);
> > +
> > =C2=A0	ts =3D inode_get_mtime(inode);
> > =C2=A0	if (!timespec64_equal(&ts, &now))
> > -		sync_it =3D S_MTIME;
> > +		sync_it |=3D S_MTIME;
> > =C2=A0
> > =C2=A0	ts =3D inode_get_ctime(inode);
> > =C2=A0	if (!timespec64_equal(&ts, &now))
> > @@ -2485,25 +2554,6 @@ struct timespec64 timestamp_truncate(struct time=
spec64 t, struct inode *inode)
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL(timestamp_truncate);
> > =C2=A0
> > -/**
> > - * current_time - Return FS time
> > - * @inode: inode.
> > - *
> > - * Return the current time truncated to the time granularity supported=
 by
> > - * the fs.
> > - *
> > - * Note that inode and inode->sb cannot be NULL.
> > - * Otherwise, the function warns and returns time without truncation.
> > - */
> > -struct timespec64 current_time(struct inode *inode)
> > -{
> > -	struct timespec64 now;
> > -
> > -	ktime_get_coarse_real_ts64(&now);
> > -	return timestamp_truncate(now, inode);
> > -}
> > -EXPORT_SYMBOL(current_time);
> > -
> > =C2=A0/**
> > =C2=A0 * inode_get_ctime - fetch the current ctime from the inode
> > =C2=A0 * @inode: inode from which to fetch ctime
> > @@ -2518,12 +2568,18 @@ struct timespec64 inode_get_ctime(const struct =
inode *inode)
> > =C2=A0{
> > =C2=A0	ktime_t ctime =3D inode->__i_ctime;
> > =C2=A0
> > +	if (is_mgtime(inode))
> > +		ctime &=3D ~I_CTIME_QUERIED;
> > =C2=A0	return ktime_to_timespec64(ctime);
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL(inode_get_ctime);
> > =C2=A0
> > =C2=A0struct timespec64 inode_set_ctime_to_ts(struct inode *inode, stru=
ct timespec64 ts)
> > =C2=A0{
> > +	trace_inode_set_ctime_to_ts(inode, &ts);
> > +
> > +	if (is_mgtime(inode))
> > +		ts.tv_nsec &=3D ~I_CTIME_QUERIED;
> > =C2=A0	inode->__i_ctime =3D ktime_set(ts.tv_sec, ts.tv_nsec);
> > =C2=A0	trace_inode_set_ctime_to_ts(inode, &ts);
> > =C2=A0	return ts;
> > @@ -2535,14 +2591,74 @@ EXPORT_SYMBOL(inode_set_ctime_to_ts);
> > =C2=A0 * @inode: inode
> > =C2=A0 *
> > =C2=A0 * Set the inode->i_ctime to the current value for the inode. Ret=
urns
> > - * the current value that was assigned to i_ctime.
> > + * the current value that was assigned to i_ctime. If this is a not
> > + * multigrain inode, then we just set it to whatever the coarse time i=
s.
> > + *
> > + * If it is multigrain, then we first see if the coarse-grained
> > + * timestamp is distinct from what we have. If so, then we'll just use
> > + * that. If we have to get a fine-grained timestamp, then do so, and
> > + * try to swap it into the floor. We accept the new floor value
> > + * regardless of the outcome of the cmpxchg. After that, we try to
> > + * swap the new value into __i_ctime. Again, we take the resulting
> > + * ctime, regardless of the outcome of the swap.
> > =C2=A0 */
> > =C2=A0struct timespec64 inode_set_ctime_current(struct inode *inode)
> > =C2=A0{
> > -	struct timespec64 now =3D current_time(inode);
> > +	ktime_t ctime, now, cur, floor =3D smp_load_acquire(&ctime_floor);
> > +
> > +	now =3D coarse_ctime(floor);
> > =C2=A0
> > -	inode_set_ctime_to_ts(inode, now);
> > -	return now;
> > +	/* Just return that if this is not a multigrain fs */
> > +	if (!is_mgtime(inode)) {
> > +		inode->__i_ctime =3D now;
> > +		goto out;
> > +	}
> > +
> > +	/*
> > +	 * We only need a fine-grained time if someone has queried it,
> > +	 * and the current coarse grained time isn't later than what's
> > +	 * already there.
> > +	 */
> > +	ctime =3D smp_load_acquire(&inode->__i_ctime);
> > +	if ((ctime & I_CTIME_QUERIED) && !ktime_after(now, ctime & ~I_CTIME_Q=
UERIED)) {
> > +		ktime_t old;
> > +
> > +		/* Get a fine-grained time */
> > +		now =3D ktime_get_real() & ~I_CTIME_QUERIED;
> > +
> > +		/*
> > +		 * If the cmpxchg works, we take the new floor value. If
> > +		 * not, then that means that someone else changed it after we
> > +		 * fetched it but before we got here. That value is just
> > +		 * as good, so keep it.
> > +		 */
> > +		old =3D cmpxchg(&ctime_floor, floor, now);
> > +		trace_ctime_floor_update(inode, floor, now, old);
> > +		if (old !=3D floor)
> > +			now =3D old;
> > +	}
> > +retry:
> > +	/* Try to swap the ctime into place. */
> > +	cur =3D cmpxchg(&inode->__i_ctime, ctime, now);
> > +	trace_ctime_inode_update(inode, ctime, now, cur);
> > +
> > +	/* If swap occurred, then we're done */
> > +	if (cur !=3D ctime) {
> > +		/*
> > +		 * Was the change due to someone marking the old ctime QUERIED?
> > +		 * If so then retry the swap. This can only happen once since
> > +		 * the only way to clear I_CTIME_QUERIED is to stamp the inode
> > +		 * with a new ctime.
> > +		 */
> > +		if (!(ctime & I_CTIME_QUERIED) && (ctime | I_CTIME_QUERIED) =3D=3D c=
ur) {
> > +			ctime =3D cur;
> > +			goto retry;
> > +		}
> > +		/* Otherwise, take the new ctime */
> > +		now =3D cur & ~I_CTIME_QUERIED;
> > +	}
> > +out:
> > +	return timestamp_truncate(ktime_to_timespec64(now), inode);
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL(inode_set_ctime_current);
> > =C2=A0
> > diff --git a/fs/stat.c b/fs/stat.c
> > index 6f65b3456cad..7e9bd16b553b 100644
> > --- a/fs/stat.c
> > +++ b/fs/stat.c
> > @@ -22,10 +22,39 @@
> > =C2=A0
> > =C2=A0#include <linux/uaccess.h>
> > =C2=A0#include <asm/unistd.h>
> > +#include <trace/events/timestamp.h>
> > =C2=A0
> > =C2=A0#include "internal.h"
> > =C2=A0#include "mount.h"
> > =C2=A0
> > +/**
> > + * fill_mg_cmtime - Fill in the mtime and ctime and flag ctime as QUER=
IED
> > + * @stat: where to store the resulting values
> > + * @request_mask: STATX_* values requested
> > + * @inode: inode from which to grab the c/mtime
> > + *
> > + * Given @inode, grab the ctime and mtime out if it and store the resu=
lt
> > + * in @stat. When fetching the value, flag it as queried so the next w=
rite
> > + * will ensure a distinct timestamp.
> > + */
> > +void fill_mg_cmtime(struct kstat *stat, u32 request_mask, struct inode=
 *inode)
> > +{
> > +	atomic_long_t *pc =3D (atomic_long_t *)&inode->__i_ctime;
> > +
> > +	/* If neither time was requested, then don't report them */
> > +	if (!(request_mask & (STATX_CTIME|STATX_MTIME))) {
> > +		stat->result_mask &=3D ~(STATX_CTIME|STATX_MTIME);
> > +		return;
> > +	}
> > +
> > +	stat->mtime.tv_sec =3D inode->i_mtime_sec;
> > +	stat->mtime.tv_nsec =3D inode->i_mtime_nsec;
> > +	stat->ctime =3D ktime_to_timespec64(atomic_long_fetch_or(I_CTIME_QUER=
IED, pc) &
> > +						~I_CTIME_QUERIED);
> > +	trace_fill_mg_cmtime(inode, atomic_long_read(pc));
> > +}
> > +EXPORT_SYMBOL(fill_mg_cmtime);
> > +
> > =C2=A0/**
> > =C2=A0 * generic_fillattr - Fill in the basic attributes from the inode=
 struct
> > =C2=A0 * @idmap:		idmap of the mount the inode was found from
> > @@ -58,8 +87,14 @@ void generic_fillattr(struct mnt_idmap *idmap, u32 r=
equest_mask,
> > =C2=A0	stat->rdev =3D inode->i_rdev;
> > =C2=A0	stat->size =3D i_size_read(inode);
> > =C2=A0	stat->atime =3D inode_get_atime(inode);
> > -	stat->mtime =3D inode_get_mtime(inode);
> > -	stat->ctime =3D inode_get_ctime(inode);
> > +
> > +	if (is_mgtime(inode)) {
> > +		fill_mg_cmtime(stat, request_mask, inode);
> > +	} else {
> > +		stat->ctime =3D inode_get_ctime(inode);
> > +		stat->mtime =3D inode_get_mtime(inode);
> > +	}
> > +
> > =C2=A0	stat->blksize =3D i_blocksize(inode);
> > =C2=A0	stat->blocks =3D inode->i_blocks;
> > =C2=A0
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 4b10db12725d..5694cb6c4dc2 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -1608,6 +1608,23 @@ static inline struct timespec64 inode_set_mtime(=
struct inode *inode,
> > =C2=A0	return inode_set_mtime_to_ts(inode, ts);
> > =C2=A0}
> > =C2=A0
> > +/*
> > + * Multigrain timestamps
> > + *
> > + * Conditionally use fine-grained ctime and mtime timestamps when ther=
e
> > + * are users actively observing them via getattr. The primary use-case
> > + * for this is NFS clients that use the ctime to distinguish between
> > + * different states of the file, and that are often fooled by multiple
> > + * operations that occur in the same coarse-grained timer tick.
> > + *
> > + * We use the least significant bit of the ktime_t to track the QUERIE=
D
> > + * flag. This means that filesystems with multigrain timestamps effect=
ively
> > + * have 2ns resolution for the ctime, even if they advertise 1ns s_tim=
e_gran.
> > + */
> > +#define I_CTIME_QUERIED		(1LL)
> > +
> > +static inline bool is_mgtime(const struct inode *inode);
> > +
> > =C2=A0struct timespec64 inode_get_ctime(const struct inode *inode);
> > =C2=A0struct timespec64 inode_set_ctime_to_ts(struct inode *inode, stru=
ct timespec64 ts);
> > =C2=A0
> > @@ -2477,6 +2494,7 @@ struct file_system_type {
> > =C2=A0#define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
> > =C2=A0#define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission=
 events */
> > =C2=A0#define FS_ALLOW_IDMAP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* FS has been updated to handle vf=
s idmappings. */
> > +#define FS_MGTIME		64	/* FS uses multigrain timestamps */
> > =C2=A0#define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() du=
ring rename() internally. */
> > =C2=A0	int (*init_fs_context)(struct fs_context *);
> > =C2=A0	const struct fs_parameter_spec *parameters;
> > @@ -2500,6 +2518,17 @@ struct file_system_type {
> > =C2=A0
> > =C2=A0#define MODULE_ALIAS_FS(NAME) MODULE_ALIAS("fs-" NAME)
> > =C2=A0
> > +/**
> > + * is_mgtime: is this inode using multigrain timestamps
> > + * @inode: inode to test for multigrain timestamps
> > + *
> > + * Return true if the inode uses multigrain timestamps, false otherwis=
e.
> > + */
> > +static inline bool is_mgtime(const struct inode *inode)
> > +{
> > +	return inode->i_sb->s_type->fs_flags & FS_MGTIME;
> > +}
> > +
> > =C2=A0extern struct dentry *mount_bdev(struct file_system_type *fs_type=
,
> > =C2=A0	int flags, const char *dev_name, void *data,
> > =C2=A0	int (*fill_super)(struct super_block *, void *, int));
> > @@ -3234,6 +3263,7 @@ extern void page_put_link(void *);
> > =C2=A0extern int page_symlink(struct inode *inode, const char *symname,=
 int len);
> > =C2=A0extern const struct inode_operations page_symlink_inode_operation=
s;
> > =C2=A0extern void kfree_link(void *);
> > +void fill_mg_cmtime(struct kstat *stat, u32 request_mask, struct inode=
 *inode);
> > =C2=A0void generic_fillattr(struct mnt_idmap *, u32, struct inode *, st=
ruct kstat *);
> > =C2=A0void generic_fill_statx_attr(struct inode *inode, struct kstat *s=
tat);
> > =C2=A0extern int vfs_getattr_nosec(const struct path *, struct kstat *,=
 u32, unsigned int);
> > diff --git a/include/trace/events/timestamp.h b/include/trace/events/ti=
mestamp.h
> > index 35ff875d3800..1f71738aa38c 100644
> > --- a/include/trace/events/timestamp.h
> > +++ b/include/trace/events/timestamp.h
> > @@ -8,6 +8,78 @@
> > =C2=A0#include <linux/tracepoint.h>
> > =C2=A0#include <linux/fs.h>
> > =C2=A0
> > +TRACE_EVENT(ctime_floor_update,
> > +	TP_PROTO(struct inode *inode,
> > +		 ktime_t old,
> > +		 ktime_t new,
> > +		 ktime_t cur),
> > +
> > +	TP_ARGS(inode, old, new, cur),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(dev_t,				dev)
> > +		__field(ino_t,				ino)
> > +		__field(ktime_t,			old)
> > +		__field(ktime_t,			new)
> > +		__field(ktime_t,			cur)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->dev		=3D inode->i_sb->s_dev;
> > +		__entry->ino		=3D inode->i_ino;
> > +		__entry->old		=3D old;
> > +		__entry->new		=3D new;
> > +		__entry->cur		=3D cur;
> > +	),
> > +
> > +	TP_printk("ino=3D%d:%d:%lu old=3D%llu.%lu new=3D%llu.%lu cur=3D%llu.%=
lu swp=3D%c",
> > +		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino,
> > +		ktime_to_timespec64(__entry->old).tv_sec,
> > +		ktime_to_timespec64(__entry->old).tv_nsec,
> > +		ktime_to_timespec64(__entry->new).tv_sec,
> > +		ktime_to_timespec64(__entry->new).tv_nsec,
> > +		ktime_to_timespec64(__entry->cur).tv_sec,
> > +		ktime_to_timespec64(__entry->cur).tv_nsec,
> > +		(__entry->old =3D=3D __entry->cur) ? 'Y' : 'N'
> > +	)
> > +);
> > +
> > +TRACE_EVENT(ctime_inode_update,
> > +	TP_PROTO(struct inode *inode,
> > +		 ktime_t old,
> > +		 ktime_t new,
> > +		 ktime_t cur),
> > +
> > +	TP_ARGS(inode, old, new, cur),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(dev_t,				dev)
> > +		__field(ino_t,				ino)
> > +		__field(ktime_t,			old)
> > +		__field(ktime_t,			new)
> > +		__field(ktime_t,			cur)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->dev		=3D inode->i_sb->s_dev;
> > +		__entry->ino		=3D inode->i_ino;
> > +		__entry->old		=3D old;
> > +		__entry->new		=3D new;
> > +		__entry->cur		=3D cur;
> > +	),
> > +
> > +	TP_printk("ino=3D%d:%d:%ld old=3D%llu.%ld new=3D%llu.%ld cur=3D%llu.%=
ld swp=3D%c",
> > +		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino,
> > +		ktime_to_timespec64(__entry->old).tv_sec,
> > +		ktime_to_timespec64(__entry->old).tv_nsec,
> > +		ktime_to_timespec64(__entry->new).tv_sec,
> > +		ktime_to_timespec64(__entry->new).tv_nsec,
> > +		ktime_to_timespec64(__entry->cur).tv_sec,
> > +		ktime_to_timespec64(__entry->cur).tv_nsec,
> > +		(__entry->old =3D=3D __entry->cur ? 'Y' : 'N')
> > +	)
> > +);
> > +
> > =C2=A0TRACE_EVENT(inode_needs_update_time,
> > =C2=A0	TP_PROTO(struct inode *inode,
> > =C2=A0		 struct timespec64 *now,
> > @@ -70,6 +142,31 @@ TRACE_EVENT(inode_set_ctime_to_ts,
> > =C2=A0		__entry->ts_sec, __entry->ts_nsec
> > =C2=A0	)
> > =C2=A0);
> > +
> > +TRACE_EVENT(fill_mg_cmtime,
> > +	TP_PROTO(struct inode *inode,
> > +		 ktime_t ctime),
> > +
> > +	TP_ARGS(inode, ctime),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(dev_t,			dev)
> > +		__field(ino_t,			ino)
> > +		__field(ktime_t,		ctime)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->dev		=3D inode->i_sb->s_dev;
> > +		__entry->ino		=3D inode->i_ino;
> > +		__entry->ctime		=3D ctime;
> > +	),
> > +
> > +	TP_printk("ino=3D%d:%d:%ld ctime=3D%llu.%lu",
> > +		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino,
> > +		ktime_to_timespec64(__entry->ctime).tv_sec,
> > +		ktime_to_timespec64(__entry->ctime).tv_nsec
> > +	)
> > +);
> > =C2=A0#endif /* _TRACE_TIMESTAMP_H */
> > =C2=A0
> > =C2=A0/* This part must be outside protection */
> >=20
> > --=20
> > 2.45.2
> >=20
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

