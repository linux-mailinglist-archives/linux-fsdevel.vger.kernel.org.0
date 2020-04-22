Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2271B4CE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 20:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgDVSvX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 14:51:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:46413 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgDVSvW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 14:51:22 -0400
IronPort-SDR: qA3ucP6gC5+IQx3Xsjgf+YjHMnYXASXGXj6l7UCQyGwuaPg3FYQqVJyb2uuzftZAqoG7yqgKRM
 0s/PzybHF6Ag==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 11:51:21 -0700
IronPort-SDR: qqIquuGL482KeAk9Fi2fpLDL6RgzKTQLdO3ZrjDmL6Yf3xRhccswmwkjvWiLXWUe5Hc3zejhOa
 XdCI2ppN3jtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,304,1583222400"; 
   d="scan'208";a="290931747"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga002.fm.intel.com with ESMTP; 22 Apr 2020 11:51:21 -0700
Date:   Wed, 22 Apr 2020 11:51:21 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V9 03/11] fs/stat: Define DAX statx attribute
Message-ID: <20200422185121.GL3372712@iweiny-DESK2.sc.intel.com>
References: <20200421191754.3372370-1-ira.weiny@intel.com>
 <20200421191754.3372370-4-ira.weiny@intel.com>
 <20200422162951.GE6733@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422162951.GE6733@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 22, 2020 at 09:29:51AM -0700, Darrick J. Wong wrote:
> On Tue, Apr 21, 2020 at 12:17:45PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > In order for users to determine if a file is currently operating in DAX
> > state (effective DAX).  Define a statx attribute value and set that
> > attribute if the effective DAX flag is set.
> > 
> > To go along with this we propose the following addition to the statx man
> > page:
> > 
> > STATX_ATTR_DAX
> > 
> > 	The file is in the DAX (cpu direct access) state.  DAX state
> > 	attempts to minimize software cache effects for both I/O and
> > 	memory mappings of this file.  It requires a file system which
> > 	has been configured to support DAX.
> > 
> > 	DAX generally assumes all accesses are via cpu load / store
> > 	instructions which can minimize overhead for small accesses, but
> > 	may adversely affect cpu utilization for large transfers.
> > 
> > 	File I/O is done directly to/from user-space buffers and memory
> > 	mapped I/O may be performed with direct memory mappings that
> > 	bypass kernel page cache.
> > 
> > 	While the DAX property tends to result in data being transferred
> > 	synchronously, it does not give the same guarantees of O_SYNC
> > 	where data and the necessary metadata are transferred together.
> > 
> > 	A DAX file may support being mapped with the MAP_SYNC flag,
> > 	which enables a program to use CPU cache flush instructions to
> > 	persist CPU store operations without an explicit fsync(2).  See
> > 	mmap(2) for more information.
> 
> One thing I hadn't noticed before -- this is a change to userspace API,
> so please cc this series to linux-api@vger.kernel.org when you send V10.

Right!  Glad you caught me on this because I was just preparing to send V10.

Is there someone I could directly mail who needs to look at this?  I guess I
thought we had the important FS people involved for this type of API change.
:-/

> 
> Also, I've started to think about commit order sequencing for actually
> landing this series.  Usually I try to put vfs and documentation things
> before xfs stuff, which means I came up with:
> 
> vfs       xfs          I_DONTCACHE
> 2 3 11    1 4 5 6 7    8 9 10
> 
> Note that I separated the DONTCACHE part because it touches VFS
> internals, which implies a higher standard of review (aka Al) and I do
> not wish to hold up the 2-3-11-1-4-5-6-7 patches if the dontcache part
> becomes contentious.
> 
> What do you think of that ordering?

I think 1 stands on it's own separate from this series...  so I would keep it
first.  Moving Documentation up is easy.

I've changed to this order...

prelim   vfs       xfs        I_DONTCACHE
1        2 3 11    4 5 6 7    8 9 10

Which is pretty much the same now that I look at it!  ;-)

> 
> (Heck, maybe I'll just put patch 1 in the queue for 5.8 right now...)

IMHO, I think 1 and 2 can go.

While patch 2 is in the VFS layer it is very much a DAX thing.  Jan and
Christoph approved it.  I think even Dave approved the version before I
removed io_is_direct() but I don't recall now.

Dan and I also discussed it internally when I first found the issue.  So I'm
very confident in it!  :-D

Unfortunately, 3 and 10 are the critical pieces to the feature.  So we could
move 3 out later after 8 and 9 are approved.  But I don't think it buys us
much to have the tri-state go in without the rest.

Ira

> 
> --D
> 
> > Reviewed-by: Dave Chinner <dchinner@redhat.com>
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from V2:
> > 	Update man page text with comments from Darrick, Jan, Dan, and
> > 	Dave.
> > ---
> >  fs/stat.c                 | 3 +++
> >  include/uapi/linux/stat.h | 1 +
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/fs/stat.c b/fs/stat.c
> > index 030008796479..894699c74dde 100644
> > --- a/fs/stat.c
> > +++ b/fs/stat.c
> > @@ -79,6 +79,9 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
> >  	if (IS_AUTOMOUNT(inode))
> >  		stat->attributes |= STATX_ATTR_AUTOMOUNT;
> >  
> > +	if (IS_DAX(inode))
> > +		stat->attributes |= STATX_ATTR_DAX;
> > +
> >  	if (inode->i_op->getattr)
> >  		return inode->i_op->getattr(path, stat, request_mask,
> >  					    query_flags);
> > diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> > index ad80a5c885d5..e5f9d5517f6b 100644
> > --- a/include/uapi/linux/stat.h
> > +++ b/include/uapi/linux/stat.h
> > @@ -169,6 +169,7 @@ struct statx {
> >  #define STATX_ATTR_ENCRYPTED		0x00000800 /* [I] File requires key to decrypt in fs */
> >  #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
> >  #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
> > +#define STATX_ATTR_DAX			0x00002000 /* [I] File is DAX */
> >  
> >  
> >  #endif /* _UAPI_LINUX_STAT_H */
> > -- 
> > 2.25.1
> > 
