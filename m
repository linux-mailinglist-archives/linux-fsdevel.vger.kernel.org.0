Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 446B813CD5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 20:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgAOTpP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 14:45:15 -0500
Received: from mga07.intel.com ([134.134.136.100]:38916 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgAOTpO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 14:45:14 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 11:45:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,323,1574150400"; 
   d="scan'208";a="218250260"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga008.jf.intel.com with ESMTP; 15 Jan 2020 11:45:13 -0800
Date:   Wed, 15 Jan 2020 11:45:13 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH V2 01/12] fs/stat: Define DAX statx attribute
Message-ID: <20200115194512.GF23311@iweiny-DESK2.sc.intel.com>
References: <20200110192942.25021-1-ira.weiny@intel.com>
 <20200110192942.25021-2-ira.weiny@intel.com>
 <20200115113715.GB2595@quack2.suse.cz>
 <20200115173834.GD8247@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115173834.GD8247@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 09:38:34AM -0800, Darrick J. Wong wrote:
> On Wed, Jan 15, 2020 at 12:37:15PM +0100, Jan Kara wrote:
> > On Fri 10-01-20 11:29:31, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > In order for users to determine if a file is currently operating in DAX
> > > mode (effective DAX).  Define a statx attribute value and set that
> > > attribute if the effective DAX flag is set.
> > > 
> > > To go along with this we propose the following addition to the statx man
> > > page:
> > > 
> > > STATX_ATTR_DAX
> > > 
> > > 	DAX (cpu direct access) is a file mode that attempts to minimize
> 
> "..is a file I/O mode"?

or  "... is a file state ..."?
 
> > > 	software cache effects for both I/O and memory mappings of this
> > > 	file.  It requires a capable device, a compatible filesystem
> > > 	block size, and filesystem opt-in.
> 
> "...a capable storage device..."

Done

> 
> What does "compatible fs block size" mean?  How does the user figure out
> if their fs blocksize is compatible?  Do we tell users to refer their
> filesystem's documentation here?

Perhaps it is wrong for this to be in the man page at all?  Would it be better
to assume the file system and block device are already configured properly by
the admin?

For which the blocksize restrictions are already well documented.  ie:

https://www.kernel.org/doc/Documentation/filesystems/dax.txt

?

How about changing the text to:

	It requires a block device and file system which have been configured
	to support DAX.

?

> 
> > > It generally assumes all
> > > 	accesses are via cpu load / store instructions which can
> > > 	minimize overhead for small accesses, but adversely affect cpu
> > > 	utilization for large transfers.
> 
> Will this always be true for persistent memory?

I'm not clear.  Did you mean; "this" == adverse utilization for large transfers?

> 
> I wasn't even aware that large transfers adversely affected CPU
> utilization. ;)

Sure vs using a DMA engine for example.

> 
> > >  File I/O is done directly
> > > 	to/from user-space buffers. While the DAX property tends to
> > > 	result in data being transferred synchronously it does not give
> 
> "...transferred synchronously, it does not..."

done.

> 
> > > 	the guarantees of synchronous I/O that data and necessary
> 
> "...it does not guarantee that I/O or file metadata have been flushed to
> the storage device."

The lack of guarantee here is mainly regarding metadata.

How about:

        While the DAX property tends to result in data being transferred
        synchronously, it does not give the same guarantees of 
	synchronous I/O where data and the necessary metadata are 
	transferred together.

> 
> > > 	metadata are transferred. Memory mapped I/O may be performed
> > > 	with direct mappings that bypass system memory buffering.
> 
> "...with direct memory mappings that bypass kernel page cache."

Done.

> 
> > > Again
> > > 	while memory-mapped I/O tends to result in data being
> 
> I would move the sentence about "Memory mapped I/O..." to directly after
> the sentence about file I/O being done directly to and from userspace so
> that you don't need to repeat this statement.

Done.

> 
> > > 	transferred synchronously it does not guarantee synchronous
> > > 	metadata updates. A dax file may optionally support being mapped
> > > 	with the MAP_SYNC flag which does allow cpu store operations to
> > > 	be considered synchronous modulo cpu cache effects.
> 
> How does one detect or work around or deal with "cpu cache effects"?  I
> assume some sort of CPU cache flush instruction is what is meant here,
> but I think we could mention the basics of what has to be done here:
> 
> "A DAX file may support being mapped with the MAP_SYNC flag, which
> enables a program to use CPU cache flush operations to persist CPU store
> operations without an explicit fsync(2).  See mmap(2) for more
> information."?

That sounds better.  I like the reference to mmap as well.

Ok I changed a couple of things as well.  How does this sound?


STATX_ATTR_DAX 

        DAX (cpu direct access) is a file mode that attempts to minimize
        software cache effects for both I/O and memory mappings of this
        file.  It requires a block device and file system which have
        been configured to support DAX.

        DAX generally assumes all accesses are via cpu load / store
        instructions which can minimize overhead for small accesses, but
        may adversely affect cpu utilization for large transfers.

        File I/O is done directly to/from user-space buffers and memory
        mapped I/O may be performed with direct memory mappings that
        bypass kernel page cache.

        While the DAX property tends to result in data being transferred
        synchronously, it does not give the same guarantees of
        synchronous I/O where data and the necessary metadata are
        transferred together.

        A DAX file may support being mapped with the MAP_SYNC flag,
        which enables a program to use CPU cache flush operations to
        persist CPU store operations without an explicit fsync(2).  See
        mmap(2) for more information.


Ira

> 
> Oof, a paragraph break would be nice. :)
> 
> --D
> 
> > > 
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > This looks good to me. You can add:
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > 
> > 								Honza
> > 
> > > ---
> > >  fs/stat.c                 | 3 +++
> > >  include/uapi/linux/stat.h | 1 +
> > >  2 files changed, 4 insertions(+)
> > > 
> > > diff --git a/fs/stat.c b/fs/stat.c
> > > index 030008796479..894699c74dde 100644
> > > --- a/fs/stat.c
> > > +++ b/fs/stat.c
> > > @@ -79,6 +79,9 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
> > >  	if (IS_AUTOMOUNT(inode))
> > >  		stat->attributes |= STATX_ATTR_AUTOMOUNT;
> > >  
> > > +	if (IS_DAX(inode))
> > > +		stat->attributes |= STATX_ATTR_DAX;
> > > +
> > >  	if (inode->i_op->getattr)
> > >  		return inode->i_op->getattr(path, stat, request_mask,
> > >  					    query_flags);
> > > diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> > > index ad80a5c885d5..e5f9d5517f6b 100644
> > > --- a/include/uapi/linux/stat.h
> > > +++ b/include/uapi/linux/stat.h
> > > @@ -169,6 +169,7 @@ struct statx {
> > >  #define STATX_ATTR_ENCRYPTED		0x00000800 /* [I] File requires key to decrypt in fs */
> > >  #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
> > >  #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
> > > +#define STATX_ATTR_DAX			0x00002000 /* [I] File is DAX */
> > >  
> > >  
> > >  #endif /* _UAPI_LINUX_STAT_H */
> > > -- 
> > > 2.21.0
> > > 
> > -- 
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
