Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F1B6EEE76
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Apr 2023 08:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239598AbjDZGlt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 02:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239223AbjDZGls (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 02:41:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A68270B;
        Tue, 25 Apr 2023 23:41:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00EB7629EF;
        Wed, 26 Apr 2023 06:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EEEC433EF;
        Wed, 26 Apr 2023 06:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682491305;
        bh=GYawAKtyB+67DF5dOe3+ygfSWpsE72Z++2D8abXFW88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V1dD0wk6HWcJxDIYcpu/23lmqlur3gYMpk9haqzo+sUd9+bkezKVyPBzPbckLYsPr
         v1YpekJZY1GW1Scgx9YUrruOdi93muBTe5zT4rxoP+BOAXwYUKUoDCHHtqZ3HZqqgz
         UEN5c+pDuBVo6HpPFyglV9uH1/rzf4ebQPcEW3CW34NBD2EKGc3za2AGLT0JuWv4gv
         e3fhAXsxWtLXLI+6AUM2KFGAHzcR+jWLcUpkB+OYdkKQZAbnpabhpbCt2yVytPoj9m
         ODxComtw7/rxgixJj8WfXY0Wp7L3ErkKLA47Np/3n6E7XBv9y/hqY9iy6Opk/OWra6
         eaV2j2Q5JoNYA==
Date:   Wed, 26 Apr 2023 08:41:38 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     NeilBrown <neilb@suse.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/3] fs: add infrastructure for multigrain inode
 i_m/ctime
Message-ID: <20230426-notlage-inspizieren-938380b785dd@brauner>
References: <20230424151104.175456-1-jlayton@kernel.org>
 <20230424151104.175456-2-jlayton@kernel.org>
 <168237287734.24821.11016713590413362200@noble.neil.brown.name>
 <404a9a8066b0735c9f355214d4eadf0d975b3188.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <404a9a8066b0735c9f355214d4eadf0d975b3188.camel@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 24, 2023 at 06:30:45PM -0400, Jeff Layton wrote:
> On Tue, 2023-04-25 at 07:47 +1000, NeilBrown wrote:
> > On Tue, 25 Apr 2023, Jeff Layton wrote:
> > > The VFS always uses coarse-grained timestamp updates for filling out the
> > > ctime and mtime after a change. This has the benefit of allowing
> > > filesystems to optimize away a lot metaupdates, to around once per
> > > jiffy, even when a file is under heavy writes.
> > > 
> > > Unfortunately, this has always been an issue when we're exporting via
> > > NFSv3, which relies on timestamps to validate caches. Even with NFSv4, a
> > > lot of exported filesystems don't properly support a change attribute
> > > and are subject to the same problems with timestamp granularity. Other
> > > applications have similar issues (e.g backup applications).
> > > 
> > > Switching to always using fine-grained timestamps would improve the
> > > situation for NFS, but that becomes rather expensive, as the underlying
> > > filesystem will have to log a lot more metadata updates.
> > > 
> > > What we need is a way to only use fine-grained timestamps when they are
> > > being actively queried:
> > > 
> > > Whenever the mtime changes, the ctime must also change since we're
> > > changing the metadata. When a superblock has a s_time_gran >1, we can
> > > use the lowest-order bit of the inode->i_ctime as a flag to indicate
> > > that the value has been queried. Then on the next write, we'll fetch a
> > > fine-grained timestamp instead of the usual coarse-grained one.
> > 
> > This assumes that any s_time_gran value greater then 1, is even.  This is
> > currently true in practice (it is always a power of 10 I think).
> > But should we have a WARN_ON_ONCE() somewhere just in case?
> > 
> > > 
> > > We could enable this for any filesystem that has a s_time_gran >1, but
> > > for now, this patch adds a new SB_MULTIGRAIN_TS flag to allow filesystems
> > > to opt-in to this behavior.
> > > 
> > > It then adds a new current_ctime function that acts like the
> > > current_time helper, but will conditionally grab fine-grained timestamps
> > > when the flag is set in the current ctime. Also, there is a new
> > > generic_fill_multigrain_cmtime for grabbing the c/mtime out of the inode
> > > and atomically marking the ctime as queried.
> > > 
> > > Later patches will convert filesystems over to this new scheme.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/inode.c         | 57 +++++++++++++++++++++++++++++++++++++++---
> > >  fs/stat.c          | 24 ++++++++++++++++++
> > >  include/linux/fs.h | 62 ++++++++++++++++++++++++++++++++--------------
> > >  3 files changed, 121 insertions(+), 22 deletions(-)
> > > 
> > > diff --git a/fs/inode.c b/fs/inode.c
> > > index 4558dc2f1355..4bd11bdb46d4 100644
> > > --- a/fs/inode.c
> > > +++ b/fs/inode.c
> > > @@ -2030,6 +2030,7 @@ EXPORT_SYMBOL(file_remove_privs);
> > >  static int inode_needs_update_time(struct inode *inode, struct timespec64 *now)
> > >  {
> > >  	int sync_it = 0;
> > > +	struct timespec64 ctime = inode->i_ctime;
> > >  
> > >  	/* First try to exhaust all avenues to not sync */
> > >  	if (IS_NOCMTIME(inode))
> > > @@ -2038,7 +2039,9 @@ static int inode_needs_update_time(struct inode *inode, struct timespec64 *now)
> > >  	if (!timespec64_equal(&inode->i_mtime, now))
> > >  		sync_it = S_MTIME;
> > >  
> > > -	if (!timespec64_equal(&inode->i_ctime, now))
> > > +	if (is_multigrain_ts(inode))
> > > +		ctime.tv_nsec &= ~I_CTIME_QUERIED;
> > > +	if (!timespec64_equal(&ctime, now))
> > >  		sync_it |= S_CTIME;
> > >  
> > >  	if (IS_I_VERSION(inode) && inode_iversion_need_inc(inode))
> > > @@ -2062,6 +2065,50 @@ static int __file_update_time(struct file *file, struct timespec64 *now,
> > >  	return ret;
> > >  }
> > >  
> > > +/**
> > > + * current_ctime - Return FS time (possibly high-res)
> > > + * @inode: inode.
> > > + *
> > > + * Return the current time truncated to the time granularity supported by
> > > + * the fs, as suitable for a ctime/mtime change.
> > > + *
> > > + * For a multigrain timestamp, if the timestamp is flagged as having been
> > > + * QUERIED, then get a fine-grained timestamp.
> > > + */
> > > +struct timespec64 current_ctime(struct inode *inode)
> > > +{
> > > +	struct timespec64 now;
> > > +	long nsec = 0;
> > > +	bool multigrain = is_multigrain_ts(inode);
> > > +
> > > +	if (multigrain) {
> > > +		atomic_long_t *pnsec = (atomic_long_t *)&inode->i_ctime.tv_nsec;
> > > +
> > > +		nsec = atomic_long_fetch_and(~I_CTIME_QUERIED, pnsec);
> > 
> >  atomic_long_fetch_andnot(I_CTIME_QUERIED, pnsec)  ??
> > 
> 
> I didn't realize that existed! Sure, I can make that change.
> 
> > > +	}
> > > +
> > > +	if (nsec & I_CTIME_QUERIED) {
> > > +		ktime_get_real_ts64(&now);
> > > +	} else {
> > > +		ktime_get_coarse_real_ts64(&now);
> > > +
> > > +		if (multigrain) {
> > > +			/*
> > > +			 * If we've recently fetched a fine-grained timestamp
> > > +			 * then the coarse-grained one may be earlier than the
> > > +			 * existing one. Just keep the existing ctime if so.
> > > +			 */
> > > +			struct timespec64 ctime = inode->i_ctime;
> > > +
> > > +			if (timespec64_compare(&ctime, &now) > 0)
> > > +				now = ctime;
> > 
> > I think this ctime could have the I_CTIME_QUERIED bit set.  We probably
> > don't want that ??
> > 
> > 
> 
> The timestamp_truncate below will take care of it.
> 
> > > +		}
> > > +	}
> > > +
> > > +	return timestamp_truncate(now, inode);
> > > +}
> > > +EXPORT_SYMBOL(current_ctime);
> > > +
> > >  /**
> > >   * file_update_time - update mtime and ctime time
> > >   * @file: file accessed
> > > @@ -2080,7 +2127,7 @@ int file_update_time(struct file *file)
> > >  {
> > >  	int ret;
> > >  	struct inode *inode = file_inode(file);
> > > -	struct timespec64 now = current_time(inode);
> > > +	struct timespec64 now = current_ctime(inode);
> > >  
> > >  	ret = inode_needs_update_time(inode, &now);
> > >  	if (ret <= 0)
> > > @@ -2109,7 +2156,7 @@ static int file_modified_flags(struct file *file, int flags)
> > >  {
> > >  	int ret;
> > >  	struct inode *inode = file_inode(file);
> > > -	struct timespec64 now = current_time(inode);
> > > +	struct timespec64 now = current_ctime(inode);
> > >  
> > >  	/*
> > >  	 * Clear the security bits if the process is not being run by root.
> > > @@ -2419,9 +2466,11 @@ struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *inode)
> > >  	if (unlikely(t.tv_sec == sb->s_time_max || t.tv_sec == sb->s_time_min))
> > >  		t.tv_nsec = 0;
> > >  
> > > -	/* Avoid division in the common cases 1 ns and 1 s. */
> > > +	/* Avoid division in the common cases 1 ns, 2 ns and 1 s. */
> > >  	if (gran == 1)
> > >  		; /* nothing */
> > > +	else if (gran == 2)
> > > +		t.tv_nsec &= ~1L;
> > >  	else if (gran == NSEC_PER_SEC)
> > >  		t.tv_nsec = 0;
> > >  	else if (gran > 1 && gran < NSEC_PER_SEC)
> > > diff --git a/fs/stat.c b/fs/stat.c
> > > index 7c238da22ef0..67b56daf9663 100644
> > > --- a/fs/stat.c
> > > +++ b/fs/stat.c
> > > @@ -26,6 +26,30 @@
> > >  #include "internal.h"
> > >  #include "mount.h"
> > >  
> > > +/**
> > > + * generic_fill_multigrain_cmtime - Fill in the mtime and ctime and flag ctime as QUERIED
> > > + * @inode: inode from which to grab the c/mtime
> > > + * @stat: where to store the resulting values
> > > + *
> > > + * Given @inode, grab the ctime and mtime out if it and store the result
> > > + * in @stat. When fetching the value, flag it as queried so the next write
> > > + * will use a fine-grained timestamp.
> > > + */
> > > +void generic_fill_multigrain_cmtime(struct inode *inode, struct kstat *stat)
> > > +{
> > > +	atomic_long_t *pnsec = (atomic_long_t *)&inode->i_ctime.tv_nsec;
> > > +
> > > +	stat->mtime = inode->i_mtime;
> > > +	stat->ctime.tv_sec = inode->i_ctime.tv_sec;
> > > +	/*
> > > +	 * Atomically set the QUERIED flag and fetch the new value with
> > > +	 * the flag masked off.
> > > +	 */
> > > +	stat->ctime.tv_nsec = atomic_long_fetch_or(I_CTIME_QUERIED, pnsec)
> > > +					& ~I_CTIME_QUERIED;
> > > +}
> > > +EXPORT_SYMBOL(generic_fill_multigrain_cmtime);
> > > +
> > >  /**
> > >   * generic_fillattr - Fill in the basic attributes from the inode struct
> > >   * @idmap:	idmap of the mount the inode was found from
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index c85916e9f7db..e6dd3ce051ef 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -1059,21 +1059,22 @@ extern int send_sigurg(struct fown_struct *fown);
> > >   * sb->s_flags.  Note that these mirror the equivalent MS_* flags where
> > >   * represented in both.
> > >   */
> > > -#define SB_RDONLY	 1	/* Mount read-only */
> > > -#define SB_NOSUID	 2	/* Ignore suid and sgid bits */
> > > -#define SB_NODEV	 4	/* Disallow access to device special files */
> > > -#define SB_NOEXEC	 8	/* Disallow program execution */
> > > -#define SB_SYNCHRONOUS	16	/* Writes are synced at once */
> > > -#define SB_MANDLOCK	64	/* Allow mandatory locks on an FS */
> > > -#define SB_DIRSYNC	128	/* Directory modifications are synchronous */
> > > -#define SB_NOATIME	1024	/* Do not update access times. */
> > > -#define SB_NODIRATIME	2048	/* Do not update directory access times */
> > > -#define SB_SILENT	32768
> > > -#define SB_POSIXACL	(1<<16)	/* VFS does not apply the umask */
> > > -#define SB_INLINECRYPT	(1<<17)	/* Use blk-crypto for encrypted files */
> > > -#define SB_KERNMOUNT	(1<<22) /* this is a kern_mount call */
> > > -#define SB_I_VERSION	(1<<23) /* Update inode I_version field */
> > > -#define SB_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
> > > +#define SB_RDONLY		(1<<0)	/* Mount read-only */
> > 
> >  BIT(0) ???
> > 
> 
> Even better. I'll revise it.

Please split this and the alignment stuff below into a preparatory
cleanup patch.

> 
> > > +#define SB_NOSUID		(1<<1)	/* Ignore suid and sgid bits */
> > 
> >  BIT(1) ??
> > 
> > > +#define SB_NODEV		(1<<2)	/* Disallow access to device special files */
> > > +#define SB_NOEXEC		(1<<3)	/* Disallow program execution */
> > > +#define SB_SYNCHRONOUS		(1<<4)	/* Writes are synced at once */
> > > +#define SB_MANDLOCK		(1<<6)	/* Allow mandatory locks on an FS */
> > > +#define SB_DIRSYNC		(1<<7)	/* Directory modifications are synchronous */
> > > +#define SB_NOATIME		(1<<10)	/* Do not update access times. */
> > > +#define SB_NODIRATIME		(1<<11)	/* Do not update directory access times */
> > > +#define SB_SILENT		(1<<15)
> > > +#define SB_POSIXACL		(1<<16)	/* VFS does not apply the umask */
> > > +#define SB_INLINECRYPT		(1<<17)	/* Use blk-crypto for encrypted files */
> > > +#define SB_KERNMOUNT		(1<<22) /* this is a kern_mount call */
> > > +#define SB_I_VERSION		(1<<23) /* Update inode I_version field */
> > > +#define SB_MULTIGRAIN_TS	(1<<24) /* Use multigrain c/mtimes */
> > > +#define SB_LAZYTIME		(1<<25) /* Update the on-disk [acm]times lazily */
> > >  
> > >  /* These sb flags are internal to the kernel */
> > >  #define SB_SUBMOUNT     (1<<26)
> > 
> > Why not align this one too?
> > 
> 
> Sure. I'll add that in for the next one.
