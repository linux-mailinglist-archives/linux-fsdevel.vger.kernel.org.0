Return-Path: <linux-fsdevel+bounces-30503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9E298BDD4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 15:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F4F289494
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 13:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F701C4631;
	Tue,  1 Oct 2024 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJPT7R0A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0736AA7;
	Tue,  1 Oct 2024 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789662; cv=none; b=Tvlee1dHESvT1dMLd1gBdfgN8FZ3gfmxXHKP34zoELjSj+Bm2zta3recmaznhYxrnusiuENwp1RrbOQQ2tmSRZ61UCoSrlatq9ZuEjpYczBtA9LNdJy8o0Shc6hkYojHYMDvE8UPzieYU7xR/Cw1cwPat+K7eD+IckD36CMEPa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789662; c=relaxed/simple;
	bh=FtCCvHOARPw3UKJ6Xu62gcUhwmKMoCiwBM0bYf53Ujw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SqT30WXdf2ClSW9vO/8xH7DFmvhgeMQWBDOeIbiqXO/Efy8mKo3ysfS7nMbJh/CVx9J5i61ITGihTx6u6hnwWK625ff3oVvBHLJtSdtEFAc/UvWceG4SdYCRkzw2XGjBrPAYsXcSgxgzE6LvVYsQL6sbbg2mZda004qFUmjoadA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJPT7R0A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8355EC4CEC6;
	Tue,  1 Oct 2024 13:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727789662;
	bh=FtCCvHOARPw3UKJ6Xu62gcUhwmKMoCiwBM0bYf53Ujw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=lJPT7R0ADN3pqKkwEZDh6wqGkwEKKxWgDUJfnc0LTdfDT9h+RHLO7JIUCUHURgT22
	 p90QNOsZVnHgs4+0GS/utuk6Flmos2z1hn2tBxOlEErWzoJPS2E3YH1Ie/fmGlhhaW
	 DxOk1sQ0inXz2xApHz960cAklxdwAwd9r9IsLkB0fDkONkhpN1yC5/kTYdyhxyD7Hr
	 Jk3yaSzuljXeJIE3V5jKGc9955pevGDEhVh8X2YipDxW5pzZrqBqM+RC25BmJ/WmH+
	 H7NNPLgH4r6jn1YC4J1TyxK7RREVuwxdzliUPfO+pj+yj94JtfmI6wLtpeOx4LVUfe
	 G+mF3/UfSf6Qg==
Message-ID: <7761de29d15df87a29575de57554b56a91ae55a0.camel@kernel.org>
Subject: Re: [PATCH v8 02/12] fs: add infrastructure for multigrain
 timestamps
From: Jeff Layton <jlayton@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>,  Jonathan Corbet
 <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, Chandan Babu R
 <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, Theodore
 Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Chris
 Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
 <dsterba@suse.com>,  Hugh Dickins <hughd@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Chuck Lever <chuck.lever@oracle.com>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>,  linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,  linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org,  linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org,  linux-btrfs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-mm@kvack.org
Date: Tue, 01 Oct 2024 09:34:18 -0400
In-Reply-To: <20241001132027.ynzp4sahjek5umbb@quack3>
References: <20241001-mgtime-v8-0-903343d91bc3@kernel.org>
	 <20241001-mgtime-v8-2-903343d91bc3@kernel.org>
	 <20241001132027.ynzp4sahjek5umbb@quack3>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-01 at 15:20 +0200, Jan Kara wrote:
> On Tue 01-10-24 06:58:56, Jeff Layton wrote:
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
> > To remedy this, keep a global monotonic atomic64_t value that acts as a
> > timestamp floor.  When we go to stamp a file, we first get the latter o=
f
> > the current floor value and the current coarse-grained time. If the
> > inode ctime hasn't been queried then we just attempt to stamp it with
> > that value.
> >=20
> > If it has been queried, then first see whether the current coarse time
> > is later than the existing ctime. If it is, then we accept that value.
> > If it isn't, then we get a fine-grained timestamp.
> >=20
> > Filesystems can opt into this by setting the FS_MGTIME fstype flag.
> > Others should be unaffected (other than being subject to the same floor
> > value as multigrain filesystems).
> >=20
> > Tested-by: Randy Dunlap <rdunlap@infradead.org> # documentation bits
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> Mostly looks good. Some smaller comments below.
>=20
> > +/**
> > + * current_time - Return FS time (possibly fine-grained)
> > + * @inode: inode.
> > + *
> > + * Return the current time truncated to the time granularity supported=
 by
> > + * the fs, as suitable for a ctime/mtime change. If the ctime is flagg=
ed
> > + * as having been QUERIED, get a fine-grained timestamp, but don't upd=
ate
> > + * the floor.
> > + *
> > + * For a multigrain inode, this is effectively an estimate of the time=
stamp
> > + * that a file would receive. An actual update must go through
> > + * inode_set_ctime_current().
> > + */
> > +struct timespec64 current_time(struct inode *inode)
> > +{
> > +	struct timespec64 now;
> > +	u32 cns;
> > +
> > +	ktime_get_coarse_real_ts64_mg(&now);
> > +
> > +	if (!is_mgtime(inode))
> > +		goto out;
> > +
> > +	/* If nothing has queried it, then coarse time is fine */
> > +	cns =3D smp_load_acquire(&inode->i_ctime_nsec);
> > +	if (cns & I_CTIME_QUERIED) {
> > +		/*
> > +		 * If there is no apparent change, then get a fine-grained
> > +		 * timestamp.
> > +		 */
> > +		if (now.tv_nsec =3D=3D (cns & ~I_CTIME_QUERIED))
> > +			ktime_get_real_ts64(&now);
> > +	}
> > +out:
> > +	return timestamp_truncate(now, inode);
> > +}
> > +EXPORT_SYMBOL(current_time);
> > +
> >  static int inode_needs_update_time(struct inode *inode)
> >  {
> > +	struct timespec64 now, ts;
> >  	int sync_it =3D 0;
> > -	struct timespec64 now =3D current_time(inode);
> > -	struct timespec64 ts;
> > =20
> >  	/* First try to exhaust all avenues to not sync */
> >  	if (IS_NOCMTIME(inode))
> >  		return 0;
> > =20
> > +	now =3D current_time(inode);
> > +
> >  	ts =3D inode_get_mtime(inode);
> >  	if (!timespec64_equal(&ts, &now))
> > -		sync_it =3D S_MTIME;
> > +		sync_it |=3D S_MTIME;
> > =20
> >  	ts =3D inode_get_ctime(inode);
> >  	if (!timespec64_equal(&ts, &now))
> > @@ -2598,6 +2637,15 @@ void inode_nohighmem(struct inode *inode)
> >  }
> >  EXPORT_SYMBOL(inode_nohighmem);
> > =20
> > +struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct ti=
mespec64 ts)
> > +{
> > +	set_normalized_timespec64(&ts, ts.tv_sec, ts.tv_nsec);
> > +	inode->i_ctime_sec =3D ts.tv_sec;
> > +	inode->i_ctime_nsec =3D ts.tv_nsec;
> > +	return ts;
> > +}
> > +EXPORT_SYMBOL(inode_set_ctime_to_ts);
> > +
> >  /**
> >   * timestamp_truncate - Truncate timespec to a granularity
> >   * @t: Timespec
> > @@ -2630,36 +2678,75 @@ struct timespec64 timestamp_truncate(struct tim=
espec64 t, struct inode *inode)
> >  EXPORT_SYMBOL(timestamp_truncate);
> > =20
> >  /**
> > - * current_time - Return FS time
> > - * @inode: inode.
> > + * inode_set_ctime_current - set the ctime to current_time
> > + * @inode: inode
> >   *
> > - * Return the current time truncated to the time granularity supported=
 by
> > - * the fs.
> > + * Set the inode's ctime to the current value for the inode. Returns t=
he
> > + * current value that was assigned. If this is not a multigrain inode,=
 then we
> > + * set it to the later of the coarse time and floor value.
> >   *
> > - * Note that inode and inode->sb cannot be NULL.
> > - * Otherwise, the function warns and returns time without truncation.
> > + * If it is multigrain, then we first see if the coarse-grained timest=
amp is
> > + * distinct from what we have. If so, then we'll just use that. If we =
have to
> > + * get a fine-grained timestamp, then do so, and try to swap it into t=
he floor.
> > + * We accept the new floor value regardless of the outcome of the cmpx=
chg.
> > + * After that, we try to swap the new value into i_ctime_nsec. Again, =
we take
> > + * the resulting ctime, regardless of the outcome of the swap.
>=20
> This comment seems outdated now. No floor in this function anymore...
>=20

True. Will fix.

> > -struct timespec64 current_time(struct inode *inode)
> > +struct timespec64 inode_set_ctime_current(struct inode *inode)
> >  {
> >  	struct timespec64 now;
> > +	u32 cns, cur;
> ...
>=20
> > diff --git a/fs/stat.c b/fs/stat.c
> > index 41e598376d7e..381926fb405f 100644
> > --- a/fs/stat.c
> > +++ b/fs/stat.c
> > @@ -26,6 +26,35 @@
> >  #include "internal.h"
> >  #include "mount.h"
> > =20
> > +/**
> > + * fill_mg_cmtime - Fill in the mtime and ctime and flag ctime as QUER=
IED
> > + * @stat: where to store the resulting values
> > + * @request_mask: STATX_* values requested
> > + * @inode: inode from which to grab the c/mtime
> > + *
> > + * Given @inode, grab the ctime and mtime out if it and store the resu=
lt
> 						 ^^ of
>=20
> > + * in @stat. When fetching the value, flag it as QUERIED (if not alrea=
dy)
> > + * so the next write will record a distinct timestamp.
> > + */
> > +void fill_mg_cmtime(struct kstat *stat, u32 request_mask, struct inode=
 *inode)
> > +{
>=20
> Given how things worked out in the end, it seems this function doesn't ne=
ed
> to handle mtime at all and we can move mtime handling back to shared gene=
ric
> code?
>=20

I don't think we can. The mtime is effectively derived from the ctime.

If I query only the mtime, I think it's reasonable to expect that it
will change if there is another write, even if I don't query the ctime.
We won't get that unless we can also set the flag in the ctime when
only the mtime is requested.

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
> > +	stat->ctime.tv_nsec =3D (u32)atomic_read(pcn);
> > +	if (!(stat->ctime.tv_nsec & I_CTIME_QUERIED))
> > +		stat->ctime.tv_nsec =3D ((u32)atomic_fetch_or(I_CTIME_QUERIED, pcn))=
;
> > +	stat->ctime.tv_nsec &=3D ~I_CTIME_QUERIED;
> > +}
> > +EXPORT_SYMBOL(fill_mg_cmtime);
> > +
> >  /**
> >   * generic_fillattr - Fill in the basic attributes from the inode stru=
ct
> >   * @idmap:		idmap of the mount the inode was found from
> > @@ -58,8 +87,14 @@ void generic_fillattr(struct mnt_idmap *idmap, u32 r=
equest_mask,
> >  	stat->rdev =3D inode->i_rdev;
> >  	stat->size =3D i_size_read(inode);
> >  	stat->atime =3D inode_get_atime(inode);
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
> >  	stat->blksize =3D i_blocksize(inode);
> >  	stat->blocks =3D inode->i_blocks;
> > =20
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index e3c603d01337..23908bad166c 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -1653,6 +1653,17 @@ static inline struct timespec64 inode_set_mtime(=
struct inode *inode,
> >  	return inode_set_mtime_to_ts(inode, ts);
> >  }
> > =20
> > +/*
> > + * Multigrain timestamps
> > + *
> > + * Conditionally use fine-grained ctime and mtime timestamps when ther=
e
> > + * are users actively observing them via getattr. The primary use-case
> > + * for this is NFS clients that use the ctime to distinguish between
> > + * different states of the file, and that are often fooled by multiple
> > + * operations that occur in the same coarse-grained timer tick.
>=20
> Again, mtime seems unaffected by mgtime changes now.
>=20

I still think we need this.
=20
> > + */
> > +#define I_CTIME_QUERIED		((u32)BIT(31))
> > +
>=20
> 								Honza

--=20
Jeff Layton <jlayton@kernel.org>

