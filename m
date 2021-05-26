Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF39A391C12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 17:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbhEZPeY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 May 2021 11:34:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234615AbhEZPeY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 May 2021 11:34:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E70560FEB;
        Wed, 26 May 2021 15:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622043172;
        bh=V5vCXBefwn7ATI2q09Zc6Pyr3lgUwNBruf3selAP4x4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jbwHAkWFow3o+pBkhghb3kHEKwUgkNydGv3mNOmncX52Qoz1jR2s3vJbxA6JPcd88
         tab4+/Gep3cvFcm3cZMlAQxOOmHOWF86MNOlkpXVV0n2emp7yBv++bsf9Zail+czZ/
         4AwrVtxdw45GdYyGip8v1vFDbPEI1l6/GKxPDVKUAz97lejoC/GIypyNOFV2/7orn9
         AwoGrXmEstbTzqHVdZQadJZX+Kld/lh1w/YQ+Oi1d9U5EtitGuZAvULQN/GbfIBQkf
         Lsq/rxD2moQfCmv6WNsXnHOKeGsJ5R+L0/D6492eq6NGD7sDKAYmg4SAWgQZh3H+UD
         3oYe04vxFLyHQ==
Date:   Wed, 26 May 2021 08:32:51 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>, ceph-devel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 07/13] xfs: Convert to use invalidate_lock
Message-ID: <20210526153251.GZ202121@locust>
References: <20210525125652.20457-1-jack@suse.cz>
 <20210525135100.11221-7-jack@suse.cz>
 <20210525213729.GC202144@locust>
 <20210526101840.GC30369@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526101840.GC30369@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 26, 2021 at 12:18:40PM +0200, Jan Kara wrote:
> On Tue 25-05-21 14:37:29, Darrick J. Wong wrote:
> > On Tue, May 25, 2021 at 03:50:44PM +0200, Jan Kara wrote:
> > > Use invalidate_lock instead of XFS internal i_mmap_lock. The intended
> > > purpose of invalidate_lock is exactly the same. Note that the locking in
> > > __xfs_filemap_fault() slightly changes as filemap_fault() already takes
> > > invalidate_lock.
> > > 
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > CC: <linux-xfs@vger.kernel.org>
> > > CC: "Darrick J. Wong" <darrick.wong@oracle.com>
> > 
> > It's djwong@kernel.org now.
> 
> OK, updated.
> 
> > > @@ -355,8 +358,11 @@ xfs_isilocked(
> > >  
> > >  	if (lock_flags & (XFS_MMAPLOCK_EXCL|XFS_MMAPLOCK_SHARED)) {
> > >  		if (!(lock_flags & XFS_MMAPLOCK_SHARED))
> > > -			return !!ip->i_mmaplock.mr_writer;
> > > -		return rwsem_is_locked(&ip->i_mmaplock.mr_lock);
> > > +			return !debug_locks ||
> > > +				lockdep_is_held_type(
> > > +					&VFS_I(ip)->i_mapping->invalidate_lock,
> > > +					0);
> > > +		return rwsem_is_locked(&VFS_I(ip)->i_mapping->invalidate_lock);
> > 
> > This doesn't look right...
> > 
> > If lockdep is disabled, we always return true for
> > xfs_isilocked(ip, XFS_MMAPLOCK_EXCL) even if nobody holds the lock?
> > 
> > Granted, you probably just copy-pasted from the IOLOCK_SHARED clause
> > beneath it.  Er... oh right, preichl was messing with all that...
> > 
> > https://lore.kernel.org/linux-xfs/20201016021005.548850-2-preichl@redhat.com/
> 
> Indeed copy-paste programming ;) It certainly makes the assertions happy
> but useless. Should I pull the patch you reference into the series? It
> seems to have been uncontroversial and reviewed. Or will you pull the
> series to xfs tree so I can just rebase on top?

The full conversion series introduced assertion failures because lockdep
can't handle some of the ILOCK usage patterns, specifically the fact
that a thread sometimes takes the ILOCK but then hands the inode to a
workqueue to avoid overflowing the first thread's stack.  That's why it
never got merged into the xfs tree.

However, that kind of switcheroo isn't done with the
MMAPLOCK/invalidate_lock, so you could simply pull the patch I linked
above into your series.

--D

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
