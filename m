Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044A4392D72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 14:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbhE0MDX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 08:03:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:54298 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234562AbhE0MDW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 08:03:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622116908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dzbVRZmzFuPYI5poJku3auZPHvmkGSaVp1vMN+///aM=;
        b=f2cxEqETTBvEmV4ULoxNaMI1iCVFmFrGue2YsLPhsPaIwuWVWOs+sxiPUa8otMLF+YX0oZ
        uhov743BXdjHMHq4sEArHqsspS7mHteRQKwa0LzGiZVHpqcufpjvdvGhVbTucTMzS1ouxn
        le5Tq6JlMjVPTCeShhV6Fk3X7MaBZg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622116908;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dzbVRZmzFuPYI5poJku3auZPHvmkGSaVp1vMN+///aM=;
        b=7ZmMbPHvotaCLsOpw+GVeU5Zo9oFBCWF89Cqa0I7loV15uebJ80v4o2t67vCmwZ9u62oXn
        kdu5eoF4IBW9prBQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1D6CBAD77;
        Thu, 27 May 2021 12:01:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5A1181F2C9A; Thu, 27 May 2021 14:01:47 +0200 (CEST)
Date:   Thu, 27 May 2021 14:01:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
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
Message-ID: <20210527120147.GD24486@quack2.suse.cz>
References: <20210525125652.20457-1-jack@suse.cz>
 <20210525135100.11221-7-jack@suse.cz>
 <20210525213729.GC202144@locust>
 <20210526101840.GC30369@quack2.suse.cz>
 <20210526153251.GZ202121@locust>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526153251.GZ202121@locust>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 26-05-21 08:32:51, Darrick J. Wong wrote:
> On Wed, May 26, 2021 at 12:18:40PM +0200, Jan Kara wrote:
> > On Tue 25-05-21 14:37:29, Darrick J. Wong wrote:
> > > On Tue, May 25, 2021 at 03:50:44PM +0200, Jan Kara wrote:
> > > > Use invalidate_lock instead of XFS internal i_mmap_lock. The intended
> > > > purpose of invalidate_lock is exactly the same. Note that the locking in
> > > > __xfs_filemap_fault() slightly changes as filemap_fault() already takes
> > > > invalidate_lock.
> > > > 
> > > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > > CC: <linux-xfs@vger.kernel.org>
> > > > CC: "Darrick J. Wong" <darrick.wong@oracle.com>
> > > 
> > > It's djwong@kernel.org now.
> > 
> > OK, updated.
> > 
> > > > @@ -355,8 +358,11 @@ xfs_isilocked(
> > > >  
> > > >  	if (lock_flags & (XFS_MMAPLOCK_EXCL|XFS_MMAPLOCK_SHARED)) {
> > > >  		if (!(lock_flags & XFS_MMAPLOCK_SHARED))
> > > > -			return !!ip->i_mmaplock.mr_writer;
> > > > -		return rwsem_is_locked(&ip->i_mmaplock.mr_lock);
> > > > +			return !debug_locks ||
> > > > +				lockdep_is_held_type(
> > > > +					&VFS_I(ip)->i_mapping->invalidate_lock,
> > > > +					0);
> > > > +		return rwsem_is_locked(&VFS_I(ip)->i_mapping->invalidate_lock);
> > > 
> > > This doesn't look right...
> > > 
> > > If lockdep is disabled, we always return true for
> > > xfs_isilocked(ip, XFS_MMAPLOCK_EXCL) even if nobody holds the lock?
> > > 
> > > Granted, you probably just copy-pasted from the IOLOCK_SHARED clause
> > > beneath it.  Er... oh right, preichl was messing with all that...
> > > 
> > > https://lore.kernel.org/linux-xfs/20201016021005.548850-2-preichl@redhat.com/
> > 
> > Indeed copy-paste programming ;) It certainly makes the assertions happy
> > but useless. Should I pull the patch you reference into the series? It
> > seems to have been uncontroversial and reviewed. Or will you pull the
> > series to xfs tree so I can just rebase on top?
> 
> The full conversion series introduced assertion failures because lockdep
> can't handle some of the ILOCK usage patterns, specifically the fact
> that a thread sometimes takes the ILOCK but then hands the inode to a
> workqueue to avoid overflowing the first thread's stack.  That's why it
> never got merged into the xfs tree.

I see. Yeah, we do "interesting" dances around lockdep fs-freezing
annotations for AIO as well where the freeze protection is inherited from
submission to completion context (we effectively generate false release
event for lockdep when exiting submit context and false acquire event in
the completion context). It can be done but it's ugly and error prone.

> However, that kind of switcheroo isn't done with the
> MMAPLOCK/invalidate_lock, so you could simply pull the patch I linked
> above into your series.

OK, will do!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
