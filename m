Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4272F166BF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 01:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbgBUAlj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 19:41:39 -0500
Received: from mga18.intel.com ([134.134.136.126]:37708 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729458AbgBUAlj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 19:41:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 16:41:38 -0800
X-IronPort-AV: E=Sophos;i="5.70,466,1574150400"; 
   d="scan'208";a="383311200"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 16:41:37 -0800
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH V4 00/13] Enable per-file/per-directory DAX operations V4
Date:   Thu, 20 Feb 2020 16:41:21 -0800
Message-Id: <20200221004134.30599-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

https://github.com/weiny2/linux-kernel/pull/new/dax-file-state-change-v4

Changes from V3: 
https://lore.kernel.org/lkml/20200208193445.27421-1-ira.weiny@intel.com/

	* Remove global locking...  :-D
	* put back per inode locking and remove pre-mature optimizations
	* Fix issues with Directories having IS_DAX() set
	* Fix kernel crash issues reported by Jeff
	* Add some clean up patches
	* Consolidate diflags to iflags functions
	* Update/add documentation
	* Reorder/rename patches quite a bit

Changes from V2:
https://lore.kernel.org/lkml/20200110192942.25021-1-ira.weiny@intel.com/

	* Move i_dax_sem to be a global percpu_rw_sem rather than per inode
		Internal discussions with Dan determined this would be easier,
		just as performant, and slightly less overhead that having it
		in the SB as suggested by Jan
	* Fix locking order in comments and throughout code
	* Change "mode" to "state" throughout commits
	* Add CONFIG_FS_DAX wrapper to disable inode_[un]lock_state() when not
		configured
	* Add static branch for which is activated by a device which supports
		DAX in XFS
	* Change "lock/unlock" to up/down read/write as appropriate
		Previous names were over simplified
	* Update comments/documentation

	* Remove the xfs specific lock to the vfs (global) layer.
	* Fix i_dax_sem locking order and comments

	* Move 'i_mapped' count from struct inode to struct address_space and
		rename it to mmap_count
	* Add inode_has_mappings() call

	* Fix build issues
	* Clean up syntax spacing and minor issues
	* Update man page text for STATX_ATTR_DAX
	* Add reviewed-by's
	* Rebase to 5.6

	Rename patch:
		from: fs/xfs: Add lock/unlock state to xfs
		to: fs/xfs: Add write DAX lock to xfs layer
	Add patch:
		fs/xfs: Clarify lockdep dependency for xfs_isilocked()
	Drop patch:
		fs/xfs: Fix truncate up


At LSF/MM'19 [1] [2] we discussed applications that overestimate memory
consumption due to their inability to detect whether the kernel will
instantiate page cache for a file, and cases where a global dax enable via a
mount option is too coarse.

The following patch series enables selecting the use of DAX on individual files
and/or directories on xfs, and lays some groundwork to do so in ext4.  In this
scheme the dax mount option can be omitted to allow the per-file property to
take effect.

The insight at LSF/MM was to separate the per-mount or per-file "physical"
capability switch from an "effective" attribute for the file.

At LSF/MM we discussed the difficulties of switching the DAX state of a file
with active mappings / page cache.  It was thought the races could be avoided
by limiting DAX state flips to 0-length files.

However, this turns out to not be true.[3] This is because address space
operations (a_ops) may be in use at any time the inode is referenced and users
have expressed a desire to be able to change the DAX state on a file with data
in it.  For those reasons this patch set allows changing the DAX state flag on
a file as long as it is not current mapped.

Details of when and how DAX state can be changed on a file is included in a
documentation patch.

It should be noted that the physical DAX flag inheritance is not shown in this
patch set as it was maintained from previous work on XFS.  The physical DAX
flag and it's inheritance will need to be added to other file systems for user
control. 

As submitted this works on real hardware testing.


[1] https://lwn.net/Articles/787973/
[2] https://lwn.net/Articles/787233/
[3] https://lkml.org/lkml/2019/10/20/96
[4] https://patchwork.kernel.org/patch/11310511/


To: linux-kernel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org

Ira Weiny (13):
  fs/xfs: Remove unnecessary initialization of i_rwsem
  fs/xfs: Clarify lockdep dependency for xfs_isilocked()
  fs: Remove unneeded IS_DAX() check
  fs/stat: Define DAX statx attribute
  fs/xfs: Isolate the physical DAX flag from enabled
  fs/xfs: Create function xfs_inode_enable_dax()
  fs: Add locking for a dynamic address space operations state
  fs: Prevent DAX state change if file is mmap'ed
  fs/xfs: Add write aops lock to xfs layer
  fs/xfs: Clean up locking in dax invalidate
  fs/xfs: Allow toggle of effective DAX flag
  fs/xfs: Remove xfs_diflags_to_linux()
  Documentation/dax: Update Usage section

 Documentation/filesystems/dax.txt | 84 ++++++++++++++++++++++++++++-
 Documentation/filesystems/vfs.rst | 16 ++++++
 fs/attr.c                         |  1 +
 fs/inode.c                        | 16 ++++--
 fs/iomap/buffered-io.c            |  1 +
 fs/open.c                         |  4 ++
 fs/stat.c                         |  5 ++
 fs/xfs/xfs_icache.c               |  5 +-
 fs/xfs/xfs_inode.c                | 24 +++++++--
 fs/xfs/xfs_inode.h                |  9 +++-
 fs/xfs/xfs_ioctl.c                | 89 +++++++++++++------------------
 fs/xfs/xfs_iops.c                 | 69 ++++++++++++++++--------
 include/linux/fs.h                | 75 ++++++++++++++++++++++++--
 include/uapi/linux/stat.h         |  1 +
 mm/fadvise.c                      |  7 ++-
 mm/filemap.c                      |  4 ++
 mm/huge_memory.c                  |  1 +
 mm/khugepaged.c                   |  2 +
 mm/mmap.c                         | 19 ++++++-
 mm/util.c                         |  9 +++-
 20 files changed, 347 insertions(+), 94 deletions(-)

-- 
2.21.0

