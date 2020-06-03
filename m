Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3975E1ECD3D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 12:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgFCKK2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 06:10:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:47920 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbgFCKK1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 06:10:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BBAB4ABCF;
        Wed,  3 Jun 2020 10:10:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 077581E1281; Wed,  3 Jun 2020 12:10:24 +0200 (CEST)
Date:   Wed, 3 Jun 2020 12:10:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     ira.weiny@intel.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH V11 11/11] fs/xfs: Update
 xfs_ioctl_setattr_dax_invalidate()
Message-ID: <20200603101024.GG19165@quack2.suse.cz>
References: <20200428002142.404144-1-ira.weiny@intel.com>
 <20200428002142.404144-12-ira.weiny@intel.com>
 <20200428201138.GD6742@magnolia>
 <20200602172353.GC8230@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602172353.GC8230@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 02-06-20 10:23:53, Darrick J. Wong wrote:
> On Tue, Apr 28, 2020 at 01:11:38PM -0700, Darrick J. Wong wrote:
> > > -out_unlock:
> > > -	xfs_iunlock(ip, XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL);
> > > -	return error;
> > > +	if ((mp->m_flags & XFS_MOUNT_DAX_ALWAYS) ||
> > > +	    (mp->m_flags & XFS_MOUNT_DAX_NEVER))
> > > +		return;
> > >  
> > > +	if (((fa->fsx_xflags & FS_XFLAG_DAX) &&
> > > +	    !(ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)) ||
> > > +	    (!(fa->fsx_xflags & FS_XFLAG_DAX) &&
> > > +	     (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)))
> > > +		d_mark_dontcache(inode);
> 
> Now that I think about this further, are we /really/ sure that we want
> to let unprivileged userspace cause inode evictions?

You have to have an equivalent of write access to the file to be able to
trigger d_mark_dontcache(). So you can e.g. delete it.  Or you could
fadvise / madvise regarding its page cache. I don't see the ability to push
inode out of cache as stronger than the abilities you already have...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
