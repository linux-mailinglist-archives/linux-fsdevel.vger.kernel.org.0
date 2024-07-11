Return-Path: <linux-fsdevel+bounces-23592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D71892EF67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 21:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 799E9B22A88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 19:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A5116EBFA;
	Thu, 11 Jul 2024 19:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jscyT2Cd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22592288B5;
	Thu, 11 Jul 2024 19:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720725276; cv=none; b=YuqIObiOtvF9LQAumlCg622hfzf6QG31o8nHySYu3vgWkhfcLCZCBnaKZX8guEz4LyCAGNayGyr17mf2MOx6EmHA+rpMvJ3V7X8tAViGv2UTC5zINMdUUSW/JHip8jLO5w3h5HZmTPk0xU6HPH/DFiMQzF0q+p0IWcCroLjnmUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720725276; c=relaxed/simple;
	bh=k/OHcGq3qy9i4BOpijhg3Eu+RQkPhrOuSU3W+B0FQDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWK/LCKbI4KY6035lS4lANxUCywjQ7aRfJ0nzzrtHDhakXX6r90G8wNshQSqEzO7nYE33NWKz1sAKo1nb3mqPSasxggGmO5GtQr1mDuc93djTpCfoqItj7XKWXX++uwtisKupI5v1EYm2UF+zwy4c1JQUDLyWnp94PnBKgnIxu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jscyT2Cd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8AAC116B1;
	Thu, 11 Jul 2024 19:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720725275;
	bh=k/OHcGq3qy9i4BOpijhg3Eu+RQkPhrOuSU3W+B0FQDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jscyT2CdSjxLa9j+k2JK95F6KykwH3G9DAE6wlbdLdQy/i7Oa4QpQzPBdPfxhXmga
	 7K3/vDracPX0CcC2CeEscVT3rcqfVVhlOoz8zviplLQ/0LvQtmRC3C483RTwQA3Qae
	 swtQPAFSJ8nlMcsh/geDSWJFpzUyGcQTzaOQcQcr1yRzcab6mdiF6AiogmLuqyK4rq
	 wCz0n/tB+egXpZwbfeA3lyCjlvzcd7Ph58VIUv8YhlrmfzKPralGiY6DvYTrLUqE+b
	 qTdRD1QDO7g4WnfpIsNqFel5fjv3btW7iAZX2fPVVVmASe2ol0/OFrJru697Oh+osu
	 +aDp1jhscnIhw==
Date: Thu, 11 Jul 2024 12:14:35 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Dave Chinner <david@fromorbit.com>, Andi Kleen <ak@linux.intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Arnd Bergmann <arnd@arndb.de>, Randy Dunlap <rdunlap@infradead.org>,
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
	linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 6/9] xfs: switch to multigrain timestamps
Message-ID: <20240711191435.GV1998502@frogsfrogsfrogs>
References: <20240711-mgtime-v5-0-37bb5b465feb@kernel.org>
 <20240711-mgtime-v5-6-37bb5b465feb@kernel.org>
 <20240711150920.GU1998502@frogsfrogsfrogs>
 <95a135dcec10423b9bcb9f53a1420d80b4afdba7.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95a135dcec10423b9bcb9f53a1420d80b4afdba7.camel@kernel.org>

On Thu, Jul 11, 2024 at 11:58:59AM -0400, Jeff Layton wrote:
> On Thu, 2024-07-11 at 08:09 -0700, Darrick J. Wong wrote:
> > On Thu, Jul 11, 2024 at 07:08:10AM -0400, Jeff Layton wrote:
> > > Enable multigrain timestamps, which should ensure that there is an
> > > apparent change to the timestamp whenever it has been written after
> > > being actively observed via getattr.
> > > 
> > > Also, anytime the mtime changes, the ctime must also change, and those
> > > are now the only two options for xfs_trans_ichgtime. Have that function
> > > unconditionally bump the ctime, and ASSERT that XFS_ICHGTIME_CHG is
> > > always set.
> > > 
> > > Finally, stop setting STATX_CHANGE_COOKIE in getattr, since the ctime
> > > should give us better semantics now.
> > 
> > Following up on "As long as the fs isn't touching i_ctime_nsec directly,
> > you shouldn't need to worry about this" from:
> > https://lore.kernel.org/linux-xfs/cae5c28f172ac57b7eaaa98a00b23f342f01ba64.camel@kernel.org/
> > 
> > xfs /does/ touch i_ctime_nsec directly when it's writing inodes to disk.
> > From xfs_inode_to_disk, see:
> > 
> > 	to->di_ctime = xfs_inode_to_disk_ts(ip, inode_get_ctime(inode));
> > 
> > AFAICT, inode_get_ctime itself remains unchanged, and still returns
> > inode->__i_ctime, right?  In which case it's returning a raw timespec64,
> > which can include the QUERIED flag in tv_nsec, right?
> > 
> 
> No, in the first patch in the series, inode_get_ctime becomes this:
> 
> #define I_CTIME_QUERIED         ((u32)BIT(31))
> 
> static inline time64_t inode_get_ctime_sec(const struct inode *inode)
> {
>         return inode->i_ctime_sec;
> }
> 
> static inline long inode_get_ctime_nsec(const struct inode *inode)
> {
>         return inode->i_ctime_nsec & ~I_CTIME_QUERIED;
> }
> 
> static inline struct timespec64 inode_get_ctime(const struct inode *inode)
> {
>         struct timespec64 ts = { .tv_sec  = inode_get_ctime_sec(inode),
>                                  .tv_nsec = inode_get_ctime_nsec(inode) };
> 
>         return ts;
> }

Doh!  I forgot that this has already been soaking in the vfs tree:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/include/linux/fs.h?h=next-20240711&id=3aa63a569c64e708df547a8913c84e64a06e7853

> ...which should ensure that you never store the QUERIED bit.

So yep, we're fine here.  Sorry about the noise; this was the very
subtle clue in the diff that the change had already been applied:

 static inline struct timespec64 inode_get_ctime(const struct inode *inode)
@@ -1626,13 +1637,7 @@ static inline struct timespec64 inode_get_ctime(const struct inode *inode)
 	return ts;
 }

(Doh doh doh doh doh...)

> > Now let's look at the consumer:
> > 
> > static inline xfs_timestamp_t
> > xfs_inode_to_disk_ts(
> > 	struct xfs_inode		*ip,
> > 	const struct timespec64		tv)
> > {
> > 	struct xfs_legacy_timestamp	*lts;
> > 	xfs_timestamp_t			ts;
> > 
> > 	if (xfs_inode_has_bigtime(ip))
> > 		return cpu_to_be64(xfs_inode_encode_bigtime(tv));
> > 
> > 	lts = (struct xfs_legacy_timestamp *)&ts;
> > 	lts->t_sec = cpu_to_be32(tv.tv_sec);
> > 	lts->t_nsec = cpu_to_be32(tv.tv_nsec);
> > 
> > 	return ts;
> > }
> > 
> > For the !bigtime case (aka before we added y2038 support) the queried
> > flag gets encoded into the tv_nsec field since xfs doesn't filter the
> > queried flag.
> > 
> > For the bigtime case, the timespec is turned into an absolute nsec count
> > since the xfs epoch (which is the minimum timestamp possible under the
> > old encoding scheme):
> > 
> > static inline uint64_t xfs_inode_encode_bigtime(struct timespec64 tv)
> > {
> > 	return xfs_unix_to_bigtime(tv.tv_sec) * NSEC_PER_SEC + tv.tv_nsec;
> > }
> > 
> > Here we'd also be mixing in the QUERIED flag, only now we've encoded a
> > time that's a second in the future.  I think the solution is to add a:
> > 
> > static inline struct timespec64
> > inode_peek_ctime(const struct inode *inode)
> > {
> > 	return (struct timespec64){
> > 		.tv_sec = inode->__i_ctime.tv_sec,
> > 		.tv_nsec = inode->__i_ctime.tv_nsec & ~I_CTIME_QUERIED,
> > 	};
> > }
> > 
> > similar to what inode_peek_iversion does for iversion; and then
> > xfs_inode_to_disk can do:
> > 
> > 	to->di_ctime = xfs_inode_to_disk_ts(ip, inode_peek_ctime(inode));
> > 
> > which would prevent I_CTIME_QUERIED from going out to disk.
> > 
> > At load time, xfs_inode_from_disk uses inode_set_ctime_to_ts so I think
> > xfs won't accidentally introduce QUERIED when it's loading an inode from
> > disk.
> > 
> > 
> 
> Also already done in this patchset:
> 
> struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct timespec64 ts)
> {
>         inode->i_ctime_sec = ts.tv_sec;
>         inode->i_ctime_nsec = ts.tv_nsec & ~I_CTIME_QUERIED;
>         trace_inode_set_ctime_to_ts(inode, &ts);
>         return ts;
> }
> EXPORT_SYMBOL(inode_set_ctime_to_ts);
> 
> Basically, we never want to store or fetch the QUERIED flag from disk,
> and since it's in an unused bit, we can just universally mask it off
> when dealing with "external" users of it.
> 
> One caveat -- I am using the sign bit for the QUERIED flag, so I'm
> assuming that no one should ever pass inode_set_ctime_to_ts a negative
> tv_nsec value.
> 
> Maybe I should add a WARN_ON_ONCE here to check for that? It seems
> nonsensical, but you never know...

Well in theory filesystems should validate incoming timestamps and
reject tv_nsec with the high bit set, but I'd bet there's a filesystem
out there that allows negative nanoseconds, even if the kernel will
never pass it such a thing. ;)

> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/xfs/libxfs/xfs_trans_inode.c |  6 +++---
> > >  fs/xfs/xfs_iops.c               | 10 +++-------
> > >  fs/xfs/xfs_super.c              |  2 +-
> > >  3 files changed, 7 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
> > > index 69fc5b981352..1f3639bbf5f0 100644
> > > --- a/fs/xfs/libxfs/xfs_trans_inode.c
> > > +++ b/fs/xfs/libxfs/xfs_trans_inode.c
> > > @@ -62,12 +62,12 @@ xfs_trans_ichgtime(
> > >  	ASSERT(tp);
> > >  	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
> > >  
> > > -	tv = current_time(inode);
> > > +	/* If the mtime changes, then ctime must also change */
> > > +	ASSERT(flags & XFS_ICHGTIME_CHG);
> > >  
> > > +	tv = inode_set_ctime_current(inode);
> > >  	if (flags & XFS_ICHGTIME_MOD)
> > >  		inode_set_mtime_to_ts(inode, tv);
> > > -	if (flags & XFS_ICHGTIME_CHG)
> > > -		inode_set_ctime_to_ts(inode, tv);
> > >  	if (flags & XFS_ICHGTIME_CREATE)
> > >  		ip->i_crtime = tv;

And as I mentioned elsewhere in this thread, 6.11 contains a change to
make it so that xfs_trans_ichgtime can set the access time.  That breaks
the old assertion that XFS_ICHGTIME_CHG is always set, but I think we
can work around that easily.

	if (flags & XFS_ICHGTIME_CHG)
		tv = inode_set_ctime_current(inode);
	else
		tv = current_time(inode);

--D

> > >  }
> > > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > > index a00dcbc77e12..d25872f818fa 100644
> > > --- a/fs/xfs/xfs_iops.c
> > > +++ b/fs/xfs/xfs_iops.c
> > > @@ -592,8 +592,9 @@ xfs_vn_getattr(
> > >  	stat->gid = vfsgid_into_kgid(vfsgid);
> > >  	stat->ino = ip->i_ino;
> > >  	stat->atime = inode_get_atime(inode);
> > > -	stat->mtime = inode_get_mtime(inode);
> > > -	stat->ctime = inode_get_ctime(inode);
> > > +
> > > +	fill_mg_cmtime(stat, request_mask, inode);
> > > +
> > >  	stat->blocks = XFS_FSB_TO_BB(mp, ip->i_nblocks + ip->i_delayed_blks);
> > >  
> > >  	if (xfs_has_v3inodes(mp)) {
> > > @@ -603,11 +604,6 @@ xfs_vn_getattr(
> > >  		}
> > >  	}
> > >  
> > > -	if ((request_mask & STATX_CHANGE_COOKIE) && IS_I_VERSION(inode)) {
> > > -		stat->change_cookie = inode_query_iversion(inode);
> > > -		stat->result_mask |= STATX_CHANGE_COOKIE;
> > > -	}
> > > -
> > >  	/*
> > >  	 * Note: If you add another clause to set an attribute flag, please
> > >  	 * update attributes_mask below.
> > > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > > index 27e9f749c4c7..210481b03fdb 100644
> > > --- a/fs/xfs/xfs_super.c
> > > +++ b/fs/xfs/xfs_super.c
> > > @@ -2052,7 +2052,7 @@ static struct file_system_type xfs_fs_type = {
> > >  	.init_fs_context	= xfs_init_fs_context,
> > >  	.parameters		= xfs_fs_parameters,
> > >  	.kill_sb		= xfs_kill_sb,
> > > -	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
> > > +	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
> > >  };
> > >  MODULE_ALIAS_FS("xfs");
> > >  
> > > 
> > > -- 
> > > 2.45.2
> > > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>

