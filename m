Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E27211A1391
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 20:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgDGSaM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 14:30:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:60112 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgDGSaL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 14:30:11 -0400
IronPort-SDR: aat543FUNqMwKniNQEWkV4Un5133hP62tEFF4hDlKtIwx+EGUj/ZaSzmvXwuzuHcHLWNWB+wRg
 HEpHzmHXEEbw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 11:30:10 -0700
IronPort-SDR: ZwrsoMC8FP+nMgQHxSpq0C5muJmfVAL83tMxkeXV63taXiHZ1DJeyxaq2vFmySl8XEg79EDTLa
 678dkWgjTJ1g==
X-IronPort-AV: E=Sophos;i="5.72,356,1580803200"; 
   d="scan'208";a="424844297"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 11:30:10 -0700
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>
Subject: [PATCH V6 0/8] Enable per-file/per-directory DAX operations V6
Date:   Tue,  7 Apr 2020 11:29:50 -0700
Message-Id: <20200407182958.568475-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Changes from V5:
	* make dax mount option a tri-state
	* Reject changes to FS_XFLAG_DAX for regular files
		- Allow only on directories
	* Update documentation

At LSF/MM'19 [1] [2] we discussed applications that overestimate memory
consumption due to their inability to detect whether the kernel will
instantiate page cache for a file, and cases where a global dax enable via a
mount option is too coarse.

The following patch series enables the use of DAX on individual files and/or
directories on xfs, and lays some groundwork to do so in ext4.  It further
enhances the dax mount option to be a tri-state of 'always', 'never', or
'iflag' (default).  Furthermore, it maintians '-o dax' to be equivalent to '-o
dax=always'.

The insight at LSF/MM was to separate the per-mount or per-file "physical"
(FS_XFLAG_DAX) capability switch from an "effective" (S_DAX) attribute for the
file.

At LSF/MM we discussed the difficulties of switching the DAX state of a file
with active mappings / page cache.  It was thought the races could be avoided
by limiting DAX state flips to 0-length files.

However, this turns out to not be true.[3][5] This is because address space
operations (a_ops) may be in use at any time the inode is referenced.

For this reason direct manipulation of the FS_XFLAG_DAX file is prohibited on
files in this patch set.  File can only inherit this flag from their parent
directory on creation.

Details of when and how DAX state can be changed on a file is included in a
documentation patch.

It should be noted that FS_XFLAG_DAX inheritance is not shown in this patch set
as it was maintained from previous work on XFS.  FS_XFLAG_DAX and it's
inheritance will need to be added to other file systems for user control. 


[1] https://lwn.net/Articles/787973/
[2] https://lwn.net/Articles/787233/
[3] https://lkml.org/lkml/2019/10/20/96
[4] https://patchwork.kernel.org/patch/11310511/
[5] https://lore.kernel.org/lkml/20200405061945.GA94792@iweiny-DESK2.sc.intel.com/


To: linux-kernel@vger.kernel.org
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org


Changes from V4:
	* Open code the aops lock rather than add it to the xfs_ilock()
	  subsystem (Darrick's comments were obsoleted by this change)
	* Fix lkp build suggestions and bugs

Changes from V3:
	* Remove global locking...  :-D
	* put back per inode locking and remove pre-mature optimizations
	* Fix issues with Directories having IS_DAX() set
	* Fix kernel crash issues reported by Jeff
	* Add some clean up patches
	* Consolidate diflags to iflags functions
	* Update/add documentation
	* Reorder/rename patches quite a bit

Changes from V2:

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

Ira Weiny (8):
  fs/xfs: Remove unnecessary initialization of i_rwsem
  fs: Remove unneeded IS_DAX() check
  fs/stat: Define DAX statx attribute
  fs/xfs: Make DAX mount option a tri-state
  fs/xfs: Create function xfs_inode_enable_dax()
  fs/xfs: Combine xfs_diflags_to_linux() and xfs_diflags_to_iflags()
  fs/xfs: Change xfs_ioctl_setattr_dax_invalidate() to
    xfs_ioctl_dax_check()
  Documentation/dax: Update Usage section

 Documentation/filesystems/dax.txt |  94 +++++++++++++++++++++-
 fs/stat.c                         |   3 +
 fs/xfs/xfs_icache.c               |   4 +-
 fs/xfs/xfs_inode.h                |   1 +
 fs/xfs/xfs_ioctl.c                | 124 +++---------------------------
 fs/xfs/xfs_iops.c                 |  62 ++++++++++-----
 fs/xfs/xfs_mount.h                |  26 ++++++-
 fs/xfs/xfs_super.c                |  34 ++++++--
 include/linux/fs.h                |   2 +-
 include/uapi/linux/stat.h         |   1 +
 10 files changed, 206 insertions(+), 145 deletions(-)

-- 
2.25.1

