Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF06139E5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 01:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgANAfW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 19:35:22 -0500
Received: from mga04.intel.com ([192.55.52.120]:18398 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728844AbgANAfW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 19:35:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 16:35:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,430,1571727600"; 
   d="scan'208";a="218812609"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jan 2020 16:35:21 -0800
Date:   Mon, 13 Jan 2020 16:35:21 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH V2 08/12] fs/xfs: Add lock/unlock mode to xfs
Message-ID: <20200114003521.GB29860@iweiny-DESK2.sc.intel.com>
References: <20200110192942.25021-1-ira.weiny@intel.com>
 <20200110192942.25021-9-ira.weiny@intel.com>
 <20200113221957.GN8247@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113221957.GN8247@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 13, 2020 at 02:19:57PM -0800, Darrick J. Wong wrote:
> On Fri, Jan 10, 2020 at 11:29:38AM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>

[snip]

> >  
> > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > index 401da197f012..e8fd95b75e5b 100644
> > --- a/fs/xfs/xfs_inode.c
> > +++ b/fs/xfs/xfs_inode.c
> > @@ -142,12 +142,12 @@ xfs_ilock_attr_map_shared(
> >   *
> >   * Basic locking order:
> >   *
> > - * i_rwsem -> i_mmap_lock -> page_lock -> i_ilock
> > + * i_rwsem -> i_dax_sem -> i_mmap_lock -> page_lock -> i_ilock
> 
> Mmmmmm, more locks.  Can we skip the extra lock if CONFIG_FSDAX=n or if
> the filesystem devices don't support DAX at all?

I'll look into it.

> 
> Also, I don't think we're actually following the i_rwsem -> i_daxsem
> order in fallocate, and possibly elsewhere too?

I'll have to verify.  It took a lot of iterations to get the order working so
I'm not going to claim perfection.

> 
> Does the vfs have to take the i_dax_sem to do remapping things like
> reflink?  (Pretend that reflink and dax are compatible for the moment)

Honestly I can't say for sure.  For this series I was careful to exclude
reflink from the locking requirement.

[snip]

> >  
> >  #define XFS_LOCK_FLAGS \
> >  	{ XFS_IOLOCK_EXCL,	"IOLOCK_EXCL" }, \
> > @@ -289,7 +295,9 @@ static inline void xfs_ifunlock(struct xfs_inode *ip)
> >  	{ XFS_ILOCK_EXCL,	"ILOCK_EXCL" }, \
> >  	{ XFS_ILOCK_SHARED,	"ILOCK_SHARED" }, \
> >  	{ XFS_MMAPLOCK_EXCL,	"MMAPLOCK_EXCL" }, \
> > -	{ XFS_MMAPLOCK_SHARED,	"MMAPLOCK_SHARED" }
> > +	{ XFS_MMAPLOCK_SHARED,	"MMAPLOCK_SHARED" }, \
> > +	{ XFS_DAX_EXCL,   	"DAX_EXCL" }, \
> 
> Whitespace between the comma & string.

Fixed.

[snip]

> > +
> >  static const struct inode_operations xfs_dir_inode_operations = {
> >  	.create			= xfs_vn_create,
> >  	.lookup			= xfs_vn_lookup,
> > @@ -1372,7 +1394,7 @@ xfs_setup_iops(
> >  
> >  	switch (inode->i_mode & S_IFMT) {
> >  	case S_IFREG:
> > -		inode->i_op = &xfs_inode_operations;
> > +		inode->i_op = &xfs_reg_inode_operations;
> 
> xfs_file_inode_operations?

Sounds better.  Fixed.

Ira

