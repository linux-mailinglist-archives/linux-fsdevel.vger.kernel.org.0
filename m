Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9B139F674
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 14:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbhFHMZf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 08:25:35 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41262 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbhFHMZf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 08:25:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 068C71FD4B;
        Tue,  8 Jun 2021 12:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623155021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9bGY+Cp/pA/h7guRE2vnnzMhgDr7PUBan0gj2Iw/ofI=;
        b=u+SJezkNd+Hoy4TfHmq/mbbx5D8h6raNCIe+MwxggDuvtCqz7pVcD7eM1nbJHaQgq+I3my
        3i7vDVPXx6oHV/Keus/sL+hjeAgtO00KSyTNORn8Zw+1sEM7AY7JmeY5qIvsBhEF5NtDj8
        Srd1wuy2dHheynxeRqlgPZLBXH5MniY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623155021;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9bGY+Cp/pA/h7guRE2vnnzMhgDr7PUBan0gj2Iw/ofI=;
        b=NgBZQfRqJnI6VvgsU0Gc4V+xB5uFCK0ttkDE0YMGzDaZvCRCGQg4CZC2NzMIJNyad41SHa
        +dBP2rSIDB0nPdAw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id E3E48A3B81;
        Tue,  8 Jun 2021 12:23:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CFD9C1F2C94; Tue,  8 Jun 2021 14:23:40 +0200 (CEST)
Date:   Tue, 8 Jun 2021 14:23:40 +0200
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
Subject: Re: [PATCH 08/14] xfs: Convert to use invalidate_lock
Message-ID: <20210608122340.GH5562@quack2.suse.cz>
References: <20210607144631.8717-1-jack@suse.cz>
 <20210607145236.31852-8-jack@suse.cz>
 <20210607155633.GI2945738@locust>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607155633.GI2945738@locust>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 07-06-21 08:56:33, Darrick J. Wong wrote:
> On Mon, Jun 07, 2021 at 04:52:18PM +0200, Jan Kara wrote:
> > Use invalidate_lock instead of XFS internal i_mmap_lock. The intended
> > purpose of invalidate_lock is exactly the same. Note that the locking in
> > __xfs_filemap_fault() slightly changes as filemap_fault() already takes
> > invalidate_lock.
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > CC: <linux-xfs@vger.kernel.org>
> > CC: "Darrick J. Wong" <djwong@kernel.org>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/xfs/xfs_file.c  | 13 +++++++-----
> >  fs/xfs/xfs_inode.c | 50 ++++++++++++++++++++++++----------------------
> >  fs/xfs/xfs_inode.h |  1 -
> >  fs/xfs/xfs_super.c |  2 --
> >  4 files changed, 34 insertions(+), 32 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > index 396ef36dcd0a..7cb7703c2209 100644
> > --- a/fs/xfs/xfs_file.c
> > +++ b/fs/xfs/xfs_file.c
> > @@ -1282,7 +1282,7 @@ xfs_file_llseek(
> >   *
> >   * mmap_lock (MM)
> >   *   sb_start_pagefault(vfs, freeze)
> > - *     i_mmaplock (XFS - truncate serialisation)
> > + *     invalidate_lock (vfs/XFS_MMAPLOCK - truncate serialisation)
> >   *       page_lock (MM)
> >   *         i_lock (XFS - extent map serialisation)
> >   */
> > @@ -1303,24 +1303,27 @@ __xfs_filemap_fault(
> >  		file_update_time(vmf->vma->vm_file);
> >  	}
> >  
> > -	xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
> >  	if (IS_DAX(inode)) {
> >  		pfn_t pfn;
> >  
> > +		xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
> >  		ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL,
> >  				(write_fault && !vmf->cow_page) ?
> >  				 &xfs_direct_write_iomap_ops :
> >  				 &xfs_read_iomap_ops);
> >  		if (ret & VM_FAULT_NEEDDSYNC)
> >  			ret = dax_finish_sync_fault(vmf, pe_size, pfn);
> > +		xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
> 
> I've been wondering if iomap_page_mkwrite and dax_iomap_fault should be
> taking these locks?  I guess that would violate the premise that iomap
> requires that callers arrange for concurrency control (i.e. iomap
> doesn't take locks).

Well, iomap does take page locks but I agree that generally it stays away
from high-level locks. So keeping invalidate_lock out of it makes more
sense to me as well.

> Code changes look fine, though.
> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
