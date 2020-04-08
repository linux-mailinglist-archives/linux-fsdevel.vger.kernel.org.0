Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3351A1953
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 02:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgDHAsI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 20:48:08 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:57005 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726428AbgDHAsI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 20:48:08 -0400
Received: from dread.disaster.area (pa49-180-164-3.pa.nsw.optusnet.com.au [49.180.164.3])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id E352E3A454A;
        Wed,  8 Apr 2020 10:48:02 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jLysr-0005w2-Tp; Wed, 08 Apr 2020 10:48:01 +1000
Date:   Wed, 8 Apr 2020 10:48:01 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V6 4/8] fs/xfs: Make DAX mount option a tri-state
Message-ID: <20200408004801.GH24067@dread.disaster.area>
References: <20200407182958.568475-1-ira.weiny@intel.com>
 <20200407182958.568475-5-ira.weiny@intel.com>
 <20200407235909.GF24067@dread.disaster.area>
 <20200408000903.GA569068@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408000903.GA569068@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=K0+o7W9luyMo1Ua2eXjR1w==:117 a=K0+o7W9luyMo1Ua2eXjR1w==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=cl8xLZFz6L8A:10
        a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8 a=d8_y8XitTFHW5w8ycSMA:9
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 07, 2020 at 05:09:04PM -0700, Ira Weiny wrote:
> On Wed, Apr 08, 2020 at 09:59:09AM +1000, Dave Chinner wrote:
> > On Tue, Apr 07, 2020 at 11:29:54AM -0700, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > As agreed upon[1].  We make the dax mount option a tri-state.  '-o dax'
> > > continues to operate the same.  We add 'always', 'never', and 'iflag'
> > > (default).
> > > 
> > > [1] https://lore.kernel.org/lkml/20200405061945.GA94792@iweiny-DESK2.sc.intel.com/
> > > 
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > ---
> > > Changes from v5:
> > > 	New Patch
> > > ---
> > >  fs/xfs/xfs_iops.c  |  2 +-
> > >  fs/xfs/xfs_mount.h | 26 +++++++++++++++++++++++++-
> > >  fs/xfs/xfs_super.c | 34 +++++++++++++++++++++++++++++-----
> > >  3 files changed, 55 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > > index 81f2f93caec0..1ec4a36917bd 100644
> > > --- a/fs/xfs/xfs_iops.c
> > > +++ b/fs/xfs/xfs_iops.c
> > > @@ -1248,7 +1248,7 @@ xfs_inode_supports_dax(
> > >  		return false;
> > >  
> > >  	/* DAX mount option or DAX iflag must be set. */
> > > -	if (!(mp->m_flags & XFS_MOUNT_DAX) &&
> > > +	if (xfs_mount_dax_mode(mp) != XFS_DAX_ALWAYS &&
> > >  	    !(ip->i_d.di_flags2 & XFS_DIFLAG2_DAX))
> > >  		return false;
> > >  
> > > diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> > > index 88ab09ed29e7..ce027ee06692 100644
> > > --- a/fs/xfs/xfs_mount.h
> > > +++ b/fs/xfs/xfs_mount.h
> > > @@ -233,7 +233,31 @@ typedef struct xfs_mount {
> > >  						   allocator */
> > >  #define XFS_MOUNT_NOATTR2	(1ULL << 25)	/* disable use of attr2 format */
> > >  
> > > -#define XFS_MOUNT_DAX		(1ULL << 62)	/* TEST ONLY! */
> > > +/* DAX flag is a 2 bit field representing a tri-state for dax
> > > + *      iflag, always, never
> > > + * We reserve/document the 2 bits using dax field/field2
> > > + */
> > > +#define XFS_DAX_FIELD_MASK 0x3ULL
> > > +#define XFS_DAX_FIELD_SHIFT 62
> > > +#define XFS_MOUNT_DAX_FIELD	(1ULL << 62)
> > > +#define XFS_MOUNT_DAX_FIELD2	(1ULL << 63)
> > > +
> > > +enum {
> > > +	XFS_DAX_IFLAG = 0,
> > > +	XFS_DAX_ALWAYS = 1,
> > > +	XFS_DAX_NEVER = 2,
> > > +};
> > > +
> > > +static inline void xfs_mount_set_dax(struct xfs_mount *mp, u32 val)
> > > +{
> > > +	mp->m_flags &= ~(XFS_DAX_FIELD_MASK << XFS_DAX_FIELD_SHIFT);
> > > +	mp->m_flags |= ((val & XFS_DAX_FIELD_MASK) << XFS_DAX_FIELD_SHIFT);
> > > +}
> > > +
> > > +static inline u32 xfs_mount_dax_mode(struct xfs_mount *mp)
> > > +{
> > > +	return (mp->m_flags >> XFS_DAX_FIELD_SHIFT) & XFS_DAX_FIELD_MASK;
> > > +}
> > 
> > This is overly complex. Just use 2 flags:
> 
> LOL...  I was afraid someone would say that.  At first I used 2 flags with
> fsparam_string, but then I realized Darrick suggested fsparam_enum:

Well, I'm not concerned about the fsparam enum, it's just that
encoding an integer into a flags bit field is just ... messy.
Especially when encoding that state can be done with just 2 flags.

If you want to keep the xfs_mount_dax_mode() wrapper, then:

static inline uint32_t xfs_mount_dax_mode(struct xfs_mount *mp)
{
	if (mp->m_flags & XFS_MOUNT_DAX_NEVER)
		return XFS_DAX_NEVER;
	if (mp->m_flags & XFS_MOUNT_DAX_ALWAYS)
		return XFS_DAX_ALWAYS;
	return XFS_DAX_IFLAG;
}

but once it's encoded in flags like this, the wrapper really isn't
necessary...

Also, while I think of it, can we change "iflag" to "inode". i.e.
the DAX state is held on the inode. Saying it comes from an "inode
flag" encodes the implementation into the user interface. i.e. it
could well be held in an xattr on the inode on another filesystem,
so we shouldn't mention "flag" in the user API....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
