Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B3F6F0397
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 11:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243296AbjD0JpU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 05:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243338AbjD0JpH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:45:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC5F49E9;
        Thu, 27 Apr 2023 02:45:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6814163C1D;
        Thu, 27 Apr 2023 09:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EF4C433A0;
        Thu, 27 Apr 2023 09:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682588702;
        bh=XbeJa7myqc5lpH0j9C1TtH8QoaXv86GZaE6uBALe91o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ky7i7k6QFq2LS1IXK40oMleXhg4LnfDdvsevFLmS7UpY27YL+99KpsBqi3jH1AuQw
         SdyZySmFtCCkARYqvAH5TtKyqh9ocd7BVhrKrfBcEBC+EF2GZczdoBmXhbQ4mJxOOY
         Gk4G1uyL3E2lHxht1iVcvlwOjvktkMe0bq5RPFB2BSMRpjPO6A86fCSWtBvOt2Eg/Q
         M7sw6lOP4cTZVlYIVeHal2TjI6E4L2tupt5Bxt++UEJUnYp0T3GV+g4eJiorOz6bxW
         no+xq90Xu8i81zvfS8Lwwp7ufo4ppDWR3SyhF3PRLCYImqxpjtPH+DeTpmpKSRU9Wc
         JW6K7RmLldkhg==
Date:   Thu, 27 Apr 2023 11:44:56 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
Message-ID: <20230427-reinschauen-zwerge-a7f546c7d51a@brauner>
References: <20230424151104.175456-1-jlayton@kernel.org>
 <20230424151104.175456-2-jlayton@kernel.org>
 <20230426-meerblick-tortur-c6606f6126fa@brauner>
 <07ce85763471a5964c9311792aa7e2f2d1696798.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <07ce85763471a5964c9311792aa7e2f2d1696798.camel@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 26, 2023 at 05:46:25AM -0400, Jeff Layton wrote:
> On Wed, 2023-04-26 at 08:53 +0200, Christian Brauner wrote:
> > On Mon, Apr 24, 2023 at 11:11:02AM -0400, Jeff Layton wrote:
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
> > 
> > Is that trying to mask off I_CTIME_QUERIED?
> > If so, can we please use that constant as raw constants tend to be
> > confusing in the long run.
> 
> Sort of. In principle you could set s_time_gran to 2 without setting
> SB_MULTIGRAIN_TS. In that case, would it be correct to use the flag
> there?

Fair, then maybe just leave a comment in there. My main worry is going
back to this later and then staring at this trying to remember what's
happening...
