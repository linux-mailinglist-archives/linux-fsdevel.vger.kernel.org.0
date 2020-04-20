Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A2A1B1387
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 19:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgDTRuD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 13:50:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:32432 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbgDTRuD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:50:03 -0400
IronPort-SDR: j4KjzegMtVuHtNFs8k/MSV58Cfzrx2YBfVI9Koo3ZlOhliXBECx+9iPocA1yUI4VlhrI9CoaPS
 Q62C/ygfKqLQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 10:50:03 -0700
IronPort-SDR: ThbZkBRL0/1in8byZP0/RBVo7FL6Oc2SA7ZPR4MiDXbeiER3enyqOnImzGN1dzeZqNulAFjQG0
 jXK6zE8kka+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,407,1580803200"; 
   d="scan'208";a="290175933"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga002.fm.intel.com with ESMTP; 20 Apr 2020 10:50:02 -0700
Date:   Mon, 20 Apr 2020 10:50:02 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V8 04/11] fs/xfs: Change XFS_MOUNT_DAX to
 XFS_MOUNT_DAX_ALWAYS
Message-ID: <20200420175002.GA2838440@iweiny-DESK2.sc.intel.com>
References: <20200415064523.2244712-1-ira.weiny@intel.com>
 <20200415064523.2244712-5-ira.weiny@intel.com>
 <20200420021555.GB9800@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420021555.GB9800@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 20, 2020 at 12:15:55PM +1000, Dave Chinner wrote:
> On Tue, Apr 14, 2020 at 11:45:16PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > In prep for the new tri-state mount option which then introduces
> > XFS_MOUNT_DAX_NEVER.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  fs/xfs/xfs_iops.c  | 2 +-
> >  fs/xfs/xfs_mount.h | 2 +-
> >  fs/xfs/xfs_super.c | 8 ++++----
> >  3 files changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > index 81f2f93caec0..a6e634631da8 100644
> > --- a/fs/xfs/xfs_iops.c
> > +++ b/fs/xfs/xfs_iops.c
> > @@ -1248,7 +1248,7 @@ xfs_inode_supports_dax(
> >  		return false;
> >  
> >  	/* DAX mount option or DAX iflag must be set. */
> > -	if (!(mp->m_flags & XFS_MOUNT_DAX) &&
> > +	if (!(mp->m_flags & XFS_MOUNT_DAX_ALWAYS) &&
> >  	    !(ip->i_d.di_flags2 & XFS_DIFLAG2_DAX))
> >  		return false;
> >  
> > diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> > index 88ab09ed29e7..54bd74088936 100644
> > --- a/fs/xfs/xfs_mount.h
> > +++ b/fs/xfs/xfs_mount.h
> > @@ -233,7 +233,7 @@ typedef struct xfs_mount {
> >  						   allocator */
> >  #define XFS_MOUNT_NOATTR2	(1ULL << 25)	/* disable use of attr2 format */
> >  
> > -#define XFS_MOUNT_DAX		(1ULL << 62)	/* TEST ONLY! */
> > +#define XFS_MOUNT_DAX_ALWAYS	(1ULL << 62)	/* TEST ONLY! */
> 
> As this is going to be permanent, please remove the "Test only"

I did that in the next patch...  But I'll move it here.

> comment and renumber the bits used down to 26. - the high bit was
> used only to keep it out of the ranges that permanent mount option
> flags used...

Ok, done for v9

Ira

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
