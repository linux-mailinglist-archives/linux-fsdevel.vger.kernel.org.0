Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25CAE180E9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 04:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgCKDgk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 23:36:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39626 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbgCKDgj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 23:36:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02B3X3Yi178241;
        Wed, 11 Mar 2020 03:36:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=j/yAOurweEWBuZxlqFBKOrkzZqy6u3iCDxl2snn59TU=;
 b=NhBZ38G6y3teXoCeN68p61lNHMmBednLWiDZhqslGd/epgDSF2HaEd4WzvZewinW8ydG
 sYryB8/vvlpruOvywqeeOgy/IP8vWh/zARQm+dR+L0RvIEsfGxLwniOmGU9B5++Ud6pa
 vujv4recSmzjqHlkpzoBht7HwGBA8MGBUiVcM1rnUpHe4YHvelq0MYzO/bA2SLcVRg2y
 6MRhdz9Ul9r8D+qYbK5ifv8JXRc29AXqjNC9lTGTVCFV+aIhV33haN3IWrH+CFwQ0kOh
 sXo6q8H8C2W17GBK3lUmGOOiQ431OpLgMghMDc3aHV+vU7hLJNzc92RNMbwco3RLP6Ed BA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2yp9v646c3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Mar 2020 03:36:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02B3YZUT190641;
        Wed, 11 Mar 2020 03:36:23 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2yp8pvxcnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Mar 2020 03:36:23 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02B3aHZx015209;
        Wed, 11 Mar 2020 03:36:17 GMT
Received: from localhost (/10.159.131.14)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Mar 2020 20:36:16 -0700
Date:   Tue, 10 Mar 2020 20:36:14 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH V5 00/12] Enable per-file/per-directory DAX operations V5
Message-ID: <20200311033614.GQ1752567@magnolia>
References: <20200227052442.22524-1-ira.weiny@intel.com>
 <20200305155144.GA5598@lst.de>
 <20200309170437.GA271052@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309170437.GA271052@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003110020
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 09, 2020 at 10:04:37AM -0700, Ira Weiny wrote:
> On Thu, Mar 05, 2020 at 04:51:44PM +0100, Christoph Hellwig wrote:
> > FYI, I still will fully NAK any series that adds additional locks
> > and thus atomic instructions to basically every fs call, and grows
> > the inode by a rw_semaphore plus and atomic64_t.  I also think the
> > whole idea of switching operation vectors at runtime is fatally flawed
> > and we should never add such code, nevermind just for a fringe usecase
> > of a fringe feature.
> 
> Being new to this area of the kernel I'm not clear on the history...

I /think/ the TLDR version in no particular order is:

- Some people expressed interest in being able to control page cache vs.
  direct access on pmem hardware at a higher granularity than the entire
  fs.

- Dave Chinner(?) added the per-inode flag intending it to be the sign
  that would flip on DAX.

- Someone (I forget who) made it a mount option that would enable it for
  all files regardless of inode flags and whatnot.

- Eric Sandeen(?) complained that the behavior of the dax inode flag was
  weird, particularly the part where you set the iflag and at some point
  if and when the inode gets reclaimed and then reconstituted then the
  change will finally take place.

- Christoph Hellwig objected on various grounds (the kernel is
  responsible for selecting the most appropriate hardware abstraction
  for the usage pattern; a binary flag doesn't capture enough detail for
  potential future pmem hardware; and now additional locking overhead).

- There's been (I hope) a long term understanding that the mount option
  will go away eventually, and not after we remove the EXPERIMENTAL
  tags.

(FWIW I tend to agree with Eric and Christoph, but I also thought it
would be useful at least to see what changeable file operations would be
like; if there were other users who had already implemented it; and how
much of an apetite there was for revoke().)

Hopefully I summarized that more or less accurately...

> It was my understanding that the per-file flag support was a requirement to
> removing the experimental designation from DAX.  Is this still the case?

Nailing down the meaning of the per-file dax flag is/was the requirement,
even if we kill it off entirely in the end.

Given Christoph's veto threat, I suppose that leaves the following
options?

1) Leave the inode flag (FS_XFLAG_DAX) as it is, and export the S_DAX
status via statx.  Document that changes to FS_XFLAG_DAX do not take
effect immediately and that one must check statx to find out the real
mode.  If we choose this, I would also deprecate the dax mount option;
send in my mkfs.xfs patch to make it so that you can set FS_XFLAG_DAX on
all files at mkfs time; and we can finally lay this whole thing to rest.
This is the closest to what we have today.

2) Withdraw FS_XFLAG_DAX entirely, and let the kernel choose based on
usage patterns, hardware heuristics, or spiteful arbitrariness.

Can we please pick (1) and just be done with this?  I want to move on.

--D

There are still other things that need to be ironed out WRT pmem:

a) reflink and page/pfn/whatever sharing -- fix the mm or (ab)use the
xfs buffer cache, or something worse?

b) getting our stories straight on how to clear poison, and whether or
not we can come up with a better story for ZERO_FILE_RANGE on pmem.  In
the ideal world I'd love to see Z_F_R actually memset(0) the pmem and
clear poison, at least if the file->pmem mappings were contiguous.

c) wiring up xfs to hwpoison, or wiring up hwpoison to xfs, or otherwise
figuring out how to get storage to tell xfs that it lost something so
that maybe xfs can fix it quickly

> Ira
> 
> > 
> > On Wed, Feb 26, 2020 at 09:24:30PM -0800, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > Changes from V4:
> > > 	* Open code the aops lock rather than add it to the xfs_ilock()
> > > 	  subsystem (Darrick's comments were obsoleted by this change)
> > > 	* Fix lkp build suggestions and bugs
> > > 
> > > Changes from V3:
> > > 	* Remove global locking...  :-D
> > > 	* put back per inode locking and remove pre-mature optimizations
> > > 	* Fix issues with Directories having IS_DAX() set
> > > 	* Fix kernel crash issues reported by Jeff
> > > 	* Add some clean up patches
> > > 	* Consolidate diflags to iflags functions
> > > 	* Update/add documentation
> > > 	* Reorder/rename patches quite a bit
> > > 
> > > Changes from V2:
> > > 
> > > 	* Move i_dax_sem to be a global percpu_rw_sem rather than per inode
> > > 		Internal discussions with Dan determined this would be easier,
> > > 		just as performant, and slightly less overhead that having it
> > > 		in the SB as suggested by Jan
> > > 	* Fix locking order in comments and throughout code
> > > 	* Change "mode" to "state" throughout commits
> > > 	* Add CONFIG_FS_DAX wrapper to disable inode_[un]lock_state() when not
> > > 		configured
> > > 	* Add static branch for which is activated by a device which supports
> > > 		DAX in XFS
> > > 	* Change "lock/unlock" to up/down read/write as appropriate
> > > 		Previous names were over simplified
> > > 	* Update comments/documentation
> > > 
> > > 	* Remove the xfs specific lock to the vfs (global) layer.
> > > 	* Fix i_dax_sem locking order and comments
> > > 
> > > 	* Move 'i_mapped' count from struct inode to struct address_space and
> > > 		rename it to mmap_count
> > > 	* Add inode_has_mappings() call
> > > 
> > > 	* Fix build issues
> > > 	* Clean up syntax spacing and minor issues
> > > 	* Update man page text for STATX_ATTR_DAX
> > > 	* Add reviewed-by's
> > > 	* Rebase to 5.6
> > > 
> > > 	Rename patch:
> > > 		from: fs/xfs: Add lock/unlock state to xfs
> > > 		to: fs/xfs: Add write DAX lock to xfs layer
> > > 	Add patch:
> > > 		fs/xfs: Clarify lockdep dependency for xfs_isilocked()
> > > 	Drop patch:
> > > 		fs/xfs: Fix truncate up
> > > 
> > > 
> > > At LSF/MM'19 [1] [2] we discussed applications that overestimate memory
> > > consumption due to their inability to detect whether the kernel will
> > > instantiate page cache for a file, and cases where a global dax enable via a
> > > mount option is too coarse.
> > > 
> > > The following patch series enables selecting the use of DAX on individual files
> > > and/or directories on xfs, and lays some groundwork to do so in ext4.  In this
> > > scheme the dax mount option can be omitted to allow the per-file property to
> > > take effect.
> > > 
> > > The insight at LSF/MM was to separate the per-mount or per-file "physical"
> > > capability switch from an "effective" attribute for the file.
> > > 
> > > At LSF/MM we discussed the difficulties of switching the DAX state of a file
> > > with active mappings / page cache.  It was thought the races could be avoided
> > > by limiting DAX state flips to 0-length files.
> > > 
> > > However, this turns out to not be true.[3] This is because address space
> > > operations (a_ops) may be in use at any time the inode is referenced and users
> > > have expressed a desire to be able to change the DAX state on a file with data
> > > in it.  For those reasons this patch set allows changing the DAX state flag on
> > > a file as long as it is not current mapped.
> > > 
> > > Details of when and how DAX state can be changed on a file is included in a
> > > documentation patch.
> > > 
> > > It should be noted that the physical DAX flag inheritance is not shown in this
> > > patch set as it was maintained from previous work on XFS.  The physical DAX
> > > flag and it's inheritance will need to be added to other file systems for user
> > > control. 
> > > 
> > > As submitted this works on real hardware testing.
> > > 
> > > 
> > > [1] https://lwn.net/Articles/787973/
> > > [2] https://lwn.net/Articles/787233/
> > > [3] https://lkml.org/lkml/2019/10/20/96
> > > [4] https://patchwork.kernel.org/patch/11310511/
> > > 
> > > 
> > > To: linux-kernel@vger.kernel.org
> > > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > > Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Cc: Dave Chinner <david@fromorbit.com>
> > > Cc: Christoph Hellwig <hch@lst.de>
> > > Cc: "Theodore Y. Ts'o" <tytso@mit.edu>
> > > Cc: Jan Kara <jack@suse.cz>
> > > Cc: linux-ext4@vger.kernel.org
> > > Cc: linux-xfs@vger.kernel.org
> > > Cc: linux-fsdevel@vger.kernel.org
> > > 
> > > 
> > > Ira Weiny (12):
> > >   fs/xfs: Remove unnecessary initialization of i_rwsem
> > >   fs: Remove unneeded IS_DAX() check
> > >   fs/stat: Define DAX statx attribute
> > >   fs/xfs: Isolate the physical DAX flag from enabled
> > >   fs/xfs: Create function xfs_inode_enable_dax()
> > >   fs: Add locking for a dynamic address space operations state
> > >   fs: Prevent DAX state change if file is mmap'ed
> > >   fs/xfs: Hold off aops users while changing DAX state
> > >   fs/xfs: Clean up locking in dax invalidate
> > >   fs/xfs: Allow toggle of effective DAX flag
> > >   fs/xfs: Remove xfs_diflags_to_linux()
> > >   Documentation/dax: Update Usage section
> > > 
> > >  Documentation/filesystems/dax.txt | 84 +++++++++++++++++++++++++-
> > >  Documentation/filesystems/vfs.rst | 16 +++++
> > >  fs/attr.c                         |  1 +
> > >  fs/inode.c                        | 16 ++++-
> > >  fs/iomap/buffered-io.c            |  1 +
> > >  fs/open.c                         |  4 ++
> > >  fs/stat.c                         |  5 ++
> > >  fs/xfs/xfs_icache.c               |  5 +-
> > >  fs/xfs/xfs_inode.h                |  2 +
> > >  fs/xfs/xfs_ioctl.c                | 98 +++++++++++++++----------------
> > >  fs/xfs/xfs_iops.c                 | 69 +++++++++++++++-------
> > >  include/linux/fs.h                | 73 ++++++++++++++++++++++-
> > >  include/uapi/linux/stat.h         |  1 +
> > >  mm/fadvise.c                      |  7 ++-
> > >  mm/filemap.c                      |  4 ++
> > >  mm/huge_memory.c                  |  1 +
> > >  mm/khugepaged.c                   |  2 +
> > >  mm/mmap.c                         | 19 +++++-
> > >  mm/util.c                         |  9 ++-
> > >  19 files changed, 328 insertions(+), 89 deletions(-)
> > > 
> > > -- 
> > > 2.21.0
> > ---end quoted text---
