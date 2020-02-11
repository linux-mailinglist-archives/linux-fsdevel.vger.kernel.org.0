Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5AC6159A98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 21:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbgBKUiJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 15:38:09 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:45707 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728063AbgBKUiJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 15:38:09 -0500
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au [49.179.138.28])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id F25C17EAB21;
        Wed, 12 Feb 2020 07:38:04 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j1cIG-0002wd-CD; Wed, 12 Feb 2020 07:38:04 +1100
Date:   Wed, 12 Feb 2020 07:38:04 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 04/12] fs/xfs: Clean up DAX support check
Message-ID: <20200211203804.GL10776@dread.disaster.area>
References: <20200208193445.27421-1-ira.weiny@intel.com>
 <20200208193445.27421-5-ira.weiny@intel.com>
 <20200211055745.GG10776@dread.disaster.area>
 <20200211162830.GB12866@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211162830.GB12866@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8 a=DmWA4bM_9KjgS68gnp8A:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:28:30AM -0800, Ira Weiny wrote:
> On Tue, Feb 11, 2020 at 04:57:45PM +1100, Dave Chinner wrote:
> > On Sat, Feb 08, 2020 at 11:34:37AM -0800, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > Rather than open coding xfs_inode_supports_dax() in
> > > xfs_ioctl_setattr_dax_invalidate() export xfs_inode_supports_dax() and
> > > call it in preparation for swapping dax flags.
> > > 
> > > This also means updating xfs_inode_supports_dax() to return true for a
> > > directory.
> > 
> > That's not correct. This now means S_DAX gets set on directory inodes
> > because both xfs_inode_supports_dax() and the on-disk inode flag
> > checks return true in xfs_diflags_to_iflags(). Hence when we
> > instantiate a directory inode with a DAX inherit hint set on it
> > we'll set S_DAX on the inode and so IS_DAX() will return true for
> > directory inodes...
> 
> I'm not following.  Don't we want S_DAX to get set on directory inodes?

No, because S_DAX is used for controlling direct user data access,
and we *never* let users directly access directory data. Even the
filesystems don't access directory data directly - the transactional
change model of journaling filesystems requires metadata to be
buffered in memory and never directly modified.

Hence when filesystems like ext4 keep their directory data in the
page cache, we do not want the kernel to think that this inode is
accessed through the DAX subsystem - it is accessed via the buffered
IO interfaces like page_cache_sync_readahead() and writeback is
controlled by the journal. Hence setting S_DAX on these inodes is
incorrect.

Whilst XFS doesn't use the page cache for it's metadata
buffering, the issue is the same as it's also a journalling
filesystem. hence setting S_DAX on XFS directory inodes is also
incorrect.

> IIRC what we wanted was something like this where IS_DAX is the current state
> and "dax" is the inode flag:
> 
> / <IS_DAX=0 dax=0>
> 	dir1 <IS_DAX=0 dax=0>
> 		f0 <IS_DAX=0 dax=0>
> 		f1 <IS_DAX=1 dax=1>
> 	dir2 <IS_DAX=1 dax=1>
> 		f2 <IS_DAX=1 dax=1>
> 		f3 <IS_DAX=0 dax=0>
> 		dir3 <IS_DAX=1 dax=1>
> 			f4 <IS_DAX=1 dax=1>
> 		dir4 <IS_DAX=0 dax=0>
> 			f5 <IS_DAX=0 dax=0>
> 		f6 <IS_DAX=1 dax=1>
> 
> Where f1, dir2, f3, and dir4 required explicit state changes when they were
> created.  Because they inherited their dax state from the parent.  All the
> other creations happened based on the DAX state of the parent directory.  So we
> need to store and know the state of the directories.  What am I missing?

I think that you are conflating internal filesystem feature
management details (the inheritance of the DAX flag feature of
directories) with kernel IO path behaviour (the inode S_DAX flag).

i.e. IS_DAX() indicates whether DAX is _actively being used_ to
access the data of a regular file inode, not to indicate whether the
on-disk flags used to manage default behaviour are set or not.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
