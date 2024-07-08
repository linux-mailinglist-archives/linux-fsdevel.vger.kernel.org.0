Return-Path: <linux-fsdevel+bounces-23289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B89092A591
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 17:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD992B21858
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 15:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DE3143896;
	Mon,  8 Jul 2024 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/0399J5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDE713D2BB;
	Mon,  8 Jul 2024 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720452248; cv=none; b=CPhk2rw68o8QhuLjcvO7sw5J0itIeCBye7Hy8woLUWY+rjL77v5w3g1Lh99uNGrLOhL2VDQYOWUh5jjZy4z7u1vtCqPLAc7/wUrg3dlEJI262Bcq3i0aE9FL3MDn603rxhW/AGOBzFgP2NroOwl2cE40N4Rlv6s5yr9XD/lBM8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720452248; c=relaxed/simple;
	bh=LTXBiHb0u7M2riWX62SAARPdddui+kXj4v4mVWFMc+U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uM2qctZS2wXnG+/QxHGU7iMDCb+KjtkHSDndfojczsxxxfRFIML0kRNFMzVloVR0OIvLj8wqZoMyKqFXz5+tCbmopDaAbU0UCHbxmmrXIGwVKnbNy3RCSgbFnZ2odmKunvFu9n3/q8ZD2a+a07u0L2CGklMLiioVApjb85qU8kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/0399J5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD220C116B1;
	Mon,  8 Jul 2024 15:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720452247;
	bh=LTXBiHb0u7M2riWX62SAARPdddui+kXj4v4mVWFMc+U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=i/0399J5HvqQllGiFGJHRu51r0M9NjLo3irlixuA1I5WkDMELFIZG/a58yTJ9gPhi
	 mpJXXe2a6XxR/BkeCV62GbTsYHR1zb4q+267AxmCFajClXBHySmvlM/9RFY1SyJ97S
	 pojlIBUvgwwsvd/JQJ5L1xtcQZ6Tyr1GlapHWCWqjmF4Zy9eg/MJc/H2BMHBlyml7a
	 +dwsubLJ2nMlcV/y8Zk7iM+oMa2I6y8xnwhA1MaNUXqBJ7iTbBCTxvlWBUOjQ9mwJd
	 7SjLQdgWETyv7TdQ/un5g2qnhBTCB8lLV9QBFdSqcqCODgYLsQeekBXRMh6NrxPFCo
	 jmFYbgjwzxOZw==
Message-ID: <81727e89b1d7cea5e1d6f011f04405942a7f9814.camel@kernel.org>
Subject: Re: [PATCH v3 1/9] fs: add infrastructure for multigrain timestamps
From: Jeff Layton <jlayton@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Chandan Babu R
 <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, Theodore
 Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Chris
 Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
 <dsterba@suse.com>, Hugh Dickins <hughd@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Dave Chinner <david@fromorbit.com>, Andi Kleen <ak@linux.intel.com>, 
 Christoph Hellwig <hch@infradead.org>, kernel-team@fb.com,
 linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,  linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org,  linux-btrfs@vger.kernel.org,
 linux-mm@kvack.org, linux-nfs@vger.kernel.org,  linux-doc@vger.kernel.org
Date: Mon, 08 Jul 2024 11:24:03 -0400
In-Reply-To: <a6eafa219d7beda6e86ad931317c89ca2114ce12.camel@kernel.org>
References: <20240705-mgtime-v3-0-85b2daa9b335@kernel.org>
	 <20240705-mgtime-v3-1-85b2daa9b335@kernel.org>
	 <a6eafa219d7beda6e86ad931317c89ca2114ce12.camel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-08 at 08:30 -0400, Jeff Layton wrote:
> On Fri, 2024-07-05 at 13:02 -0400, Jeff Layton wrote:
> > The VFS has always used coarse-grained timestamps when updating the
> > ctime and mtime after a change. This has the benefit of allowing
> > filesystems to optimize away a lot metadata updates, down to around 1
> > per jiffy, even when a file is under heavy writes.
> >=20
> > Unfortunately, this has always been an issue when we're exporting via
> > NFSv3, which relies on timestamps to validate caches. A lot of changes
> > can happen in a jiffy, so timestamps aren't sufficient to help the
> > client decide when to invalidate the cache. Even with NFSv4, a lot of
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
> > being actively queried. Use the (unused) top bit in inode->i_ctime_nsec
> > as a flag that indicates whether the current timestamps have been
> > queried via stat() or the like. When it's set, we allow the kernel to
> > use a fine-grained timestamp iff it's necessary to make the ctime show
> > a different value.
> >=20
> > This solves the problem of being able to distinguish the timestamp
> > between updates, but introduces a new problem: it's now possible for a
> > file being changed to get a fine-grained timestamp. A file that is
> > altered just a bit later can then get a coarse-grained one that appears
> > older than the earlier fine-grained time. This violates timestamp
> > ordering guarantees.
> >=20
> > To remedy this, keep a global monotonic ktime_t value that acts as a
> > timestamp floor.=C2=A0 When we go to stamp a file, we first get the lat=
ter of
> > the current floor value and the current coarse-grained time. If the
> > inode ctime hasn't been queried then we just attempt to stamp it with
> > that value.
> >=20
> > If it has been queried, then first see whether the current coarse time
> > is later than the existing ctime. If it is, then we accept that value.
> > If it isn't, then we get a fine-grained time and try to swap that into
> > the global floor. Whether that succeeds or fails, we take the resulting
> > floor time, convert it to realtime and try to swap that into the ctime.
> >=20
> > We take the result of the ctime swap whether it succeeds or fails, sinc=
e
> > either is just as valid.
> >=20
> > Filesystems can opt into this by setting the FS_MGTIME fstype flag.
> > Others should be unaffected (other than being subject to the same floor
> > value as multigrain filesystems).
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > =C2=A0fs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 172 =
++++++++++++++++++++++++++++++++++++++++++++---------
> > =C2=A0fs/stat.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 36 ++++++++++-
> > =C2=A0include/linux/fs.h |=C2=A0 34 ++++++++---
> > =C2=A03 files changed, 205 insertions(+), 37 deletions(-)
> >=20
> > diff --git a/fs/inode.c b/fs/inode.c
> > index f356fe2ec2b6..844ff0750959 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -60,6 +60,12 @@ static unsigned int i_hash_shift __ro_after_init;
> > =C2=A0static struct hlist_head *inode_hashtable __ro_after_init;
> > =C2=A0static __cacheline_aligned_in_smp DEFINE_SPINLOCK(inode_hash_lock=
);
> > =C2=A0
> > +/*
> > + * This represents the latest time that we have handed out as a
> > + * timestamp on the system. Tracked as a MONOTONIC value, and
> > + * converted to the realtime clock on an as-needed basis.
> > + */
> > +static __cacheline_aligned_in_smp ktime_t ctime_floor;
>=20
>=20
> Now that this is being tracked as a monotonic value, I think I probably
> do need to move this to being per time_namespace. I'll plan to
> integrate that before the next posting.
>=20

I take it back.

time_namespaces are all about virtualizing the clock for userland
consumption. They're implemented as a set of offsets from the global
timekeeper monotonic clock.

Since the floor value is an internal kernel value that is never
presented directly to userland, I don't think we need to make this per-
time_namespace after all. That would just mean dealing with extra
offset calculation.

I'll plan to resend with the latest changes here soon.

> > =C2=A0/*
> > =C2=A0 * Empty aops. Can be used for the cases where the user does not
> > =C2=A0 * define any of the address_space operations.
> > @@ -2127,19 +2133,72 @@ int file_remove_privs(struct file *file)
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL(file_remove_privs);
> > =C2=A0
> > +/**
> > + * coarse_ctime - return the current coarse-grained time
> > + * @floor: current ctime_floor value
> > + *
> > + * Get the coarse-grained time, and then determine whether to
> > + * return it or the current floor value. Returns the later of the
> > + * floor and coarse grained timestamps, converted to realtime
> > + * clock value.
> > + */
> > +static ktime_t coarse_ctime(ktime_t floor)
> > +{
> > +	ktime_t coarse =3D ktime_get_coarse();
> > +
> > +	/* If coarse time is already newer, return that */
> > +	if (!ktime_after(floor, coarse))
> > +		return ktime_mono_to_real(coarse);
> > +	return ktime_mono_to_real(floor);
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
> > +	ktime_t floor =3D smp_load_acquire(&ctime_floor);
> > +	ktime_t now =3D coarse_ctime(floor);
> > +	struct timespec64 now_ts =3D ktime_to_timespec64(now);
> > +	u32 cns;
> > +
> > +	if (!is_mgtime(inode))
> > +		goto out;
> > +
> > +	/* If nothing has queried it, then coarse time is fine */
> > +	cns =3D smp_load_acquire(&inode->i_ctime_nsec);
> > +	if (cns & I_CTIME_QUERIED) {
> > +		/*
> > +		 * If there is no apparent change, then
> > +		 * get a fine-grained timestamp.
> > +		 */
> > +		if (now_ts.tv_nsec =3D=3D (cns & ~I_CTIME_QUERIED))
> > +			ktime_get_real_ts64(&now_ts);
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
> > @@ -2507,6 +2566,14 @@ void inode_nohighmem(struct inode *inode)
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL(inode_nohighmem);
> > =C2=A0
> > +struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct ti=
mespec64 ts)
> > +{
> > +	inode->i_ctime_sec =3D ts.tv_sec;
> > +	inode->i_ctime_nsec =3D ts.tv_nsec & ~I_CTIME_QUERIED;
> > +	return ts;
> > +}
> > +EXPORT_SYMBOL(inode_set_ctime_to_ts);
> > +
> > =C2=A0/**
> > =C2=A0 * timestamp_truncate - Truncate timespec to a granularity
> > =C2=A0 * @t: Timespec
> > @@ -2538,38 +2605,89 @@ struct timespec64 timestamp_truncate(struct tim=
espec64 t, struct inode *inode)
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
> > =C2=A0 * inode_set_ctime_current - set the ctime to current_time
> > =C2=A0 * @inode: inode
> > =C2=A0 *
> > - * Set the inode->i_ctime to the current value for the inode. Returns
> > - * the current value that was assigned to i_ctime.
> > + * Set the inode's ctime to the current value for the inode. Returns
> > + * the current value that was assigned. If this is a not multigrain in=
ode,
> > + * then we just set it to whatever the coarse_ctime is.
> > + *
> > + * If it is multigrain, then we first see if the coarse-grained
> > + * timestamp is distinct from what we have. If so, then we'll just use
> > + * that. If we have to get a fine-grained timestamp, then do so, and
> > + * try to swap it into the floor. We accept the new floor value
> > + * regardless of the outcome of the cmpxchg. After that, we try to
> > + * swap the new value into i_ctime_nsec. Again, we take the resulting
> > + * ctime, regardless of the outcome of the swap.
> > =C2=A0 */
> > =C2=A0struct timespec64 inode_set_ctime_current(struct inode *inode)
> > =C2=A0{
> > -	struct timespec64 now =3D current_time(inode);
> > +	ktime_t now, floor =3D smp_load_acquire(&ctime_floor);
> > +	struct timespec64 now_ts;
> > +	u32 cns, cur;
> > +
> > +	now =3D coarse_ctime(floor);
> > +
> > +	/* Just return that if this is not a multigrain fs */
> > +	if (!is_mgtime(inode)) {
> > +		now_ts =3D ktime_to_timespec64(now);
> > +		inode_set_ctime_to_ts(inode, now_ts);
> > +		goto out;
> > +	}
> > =C2=A0
> > -	inode_set_ctime_to_ts(inode, now);
> > -	return now;
> > +	/*
> > +	 * We only need a fine-grained time if someone has queried it,
> > +	 * and the current coarse grained time isn't later than what's
> > +	 * already there.
> > +	 */
> > +	cns =3D smp_load_acquire(&inode->i_ctime_nsec);
> > +	if (cns & I_CTIME_QUERIED) {
> > +		ktime_t ctime =3D ktime_set(inode->i_ctime_sec, cns & ~I_CTIME_QUERI=
ED);
> > +
> > +		if (!ktime_after(now, ctime)) {
> > +			ktime_t old, fine;
> > +
> > +			/* Get a fine-grained time */
> > +			fine =3D ktime_get();
> > +
> > +			/*
> > +			 * If the cmpxchg works, we take the new floor value. If
> > +			 * not, then that means that someone else changed it after we
> > +			 * fetched it but before we got here. That value is just
> > +			 * as good, so keep it.
> > +			 */
> > +			old =3D cmpxchg(&ctime_floor, floor, fine);
> > +			if (old !=3D floor)
> > +				fine =3D old;
> > +			now =3D ktime_mono_to_real(fine);
> > +		}
> > +	}
> > +	now_ts =3D ktime_to_timespec64(now);
> > +retry:
> > +	/* Try to swap the nsec value into place. */
> > +	cur =3D cmpxchg(&inode->i_ctime_nsec, cns, now_ts.tv_nsec);
> > +
> > +	/* If swap occurred, then we're (mostly) done */
> > +	if (cur =3D=3D cns) {
> > +		inode->i_ctime_sec =3D now_ts.tv_sec;
> > +	} else {
> > +		/*
> > +		 * Was the change due to someone marking the old ctime QUERIED?
> > +		 * If so then retry the swap. This can only happen once since
> > +		 * the only way to clear I_CTIME_QUERIED is to stamp the inode
> > +		 * with a new ctime.
> > +		 */
> > +		if (!(cns & I_CTIME_QUERIED) && (cns | I_CTIME_QUERIED) =3D=3D cur) =
{
> > +			cns =3D cur;
> > +			goto retry;
> > +		}
> > +		/* Otherwise, keep the existing ctime */
> > +		now_ts.tv_sec =3D inode->i_ctime_sec;
> > +		now_ts.tv_nsec =3D cur & ~I_CTIME_QUERIED;
> > +	}
> > +out:
> > +	return timestamp_truncate(now_ts, inode);
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL(inode_set_ctime_current);
> > =C2=A0
> > diff --git a/fs/stat.c b/fs/stat.c
> > index 6f65b3456cad..df7fdd3afed9 100644
> > --- a/fs/stat.c
> > +++ b/fs/stat.c
> > @@ -26,6 +26,32 @@
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
> > +	atomic_t *pcn =3D (atomic_t *)&inode->i_ctime_nsec;
> > +
> > +	/* If neither time was requested, then don't report them */
> > +	if (!(request_mask & (STATX_CTIME|STATX_MTIME))) {
> > +		stat->result_mask &=3D ~(STATX_CTIME|STATX_MTIME);
> > +		return;
> > +	}
> > +
> > +	stat->mtime =3D inode_get_mtime(inode);
> > +	stat->ctime.tv_sec =3D inode->i_ctime_sec;
> > +	stat->ctime.tv_nsec =3D ((u32)atomic_fetch_or(I_CTIME_QUERIED, pcn)) =
& ~I_CTIME_QUERIED;
> > +}
> > +EXPORT_SYMBOL(fill_mg_cmtime);
> > +
> > =C2=A0/**
> > =C2=A0 * generic_fillattr - Fill in the basic attributes from the inode=
 struct
> > =C2=A0 * @idmap:		idmap of the mount the inode was found from
> > @@ -58,8 +84,14 @@ void generic_fillattr(struct mnt_idmap *idmap, u32 r=
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
> > index dc9f9c4b2572..f873f6c58669 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -1608,6 +1608,17 @@ static inline struct timespec64 inode_set_mtime(=
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
> > + */
> > +#define I_CTIME_QUERIED		((u32)BIT(31))
> > +
> > =C2=A0static inline time64_t inode_get_ctime_sec(const struct inode *in=
ode)
> > =C2=A0{
> > =C2=A0	return inode->i_ctime_sec;
> > @@ -1615,7 +1626,7 @@ static inline time64_t inode_get_ctime_sec(const =
struct inode *inode)
> > =C2=A0
> > =C2=A0static inline long inode_get_ctime_nsec(const struct inode *inode=
)
> > =C2=A0{
> > -	return inode->i_ctime_nsec;
> > +	return inode->i_ctime_nsec & ~I_CTIME_QUERIED;
> > =C2=A0}
> > =C2=A0
> > =C2=A0static inline struct timespec64 inode_get_ctime(const struct inod=
e *inode)
> > @@ -1626,13 +1637,7 @@ static inline struct timespec64 inode_get_ctime(=
const struct inode *inode)
> > =C2=A0	return ts;
> > =C2=A0}
> > =C2=A0
> > -static inline struct timespec64 inode_set_ctime_to_ts(struct inode *in=
ode,
> > -						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct timespec64 ts)
> > -{
> > -	inode->i_ctime_sec =3D ts.tv_sec;
> > -	inode->i_ctime_nsec =3D ts.tv_nsec;
> > -	return ts;
> > -}
> > +struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct ti=
mespec64 ts);
> > =C2=A0
> > =C2=A0/**
> > =C2=A0 * inode_set_ctime - set the ctime in the inode
> > @@ -2490,6 +2495,7 @@ struct file_system_type {
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
> > @@ -2513,6 +2519,17 @@ struct file_system_type {
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
> > @@ -3252,6 +3269,7 @@ extern void page_put_link(void *);
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
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

