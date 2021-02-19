Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3594131F45A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 05:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhBSENc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 23:13:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:33792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229636AbhBSEN0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 23:13:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2247764ECC;
        Fri, 19 Feb 2021 04:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613707965;
        bh=+PX9UntlF/QYEWPpKWjd9f9TAXBbmR/jyMtI8MAodTw=;
        h=Date:From:To:Cc:Subject:From;
        b=PKueZwv4N6LsTR/feHP6PPv8VMJw9YM0GjpvilZCVao8W8eBKXyjARxM8qViSzsWp
         /trSIKuxbFWIwQHMtreGxCgMy5FGg76vIsrIMUZdYOh1j0rPBA7eX2rUG+iS5oNqh3
         8UmVgtGMhPGixH8UCWQNsop+mEj9SFc6zn6uK8q3ihwuU5pGUshYNrALDaf7VKMxu2
         Y4O98jFazxVUJleklbsF3hAaDfpgXJ+TYBpZcHWG+Dq835uL8ZVe2CGOy71szWKL6t
         dMKp9Pp5wERSKD6xYPNUjqSoyqMmt5UHMEcBoiZobRAox5N82uJzBf5IQUykc00scz
         jTZup5MyW2Q4w==
Date:   Thu, 18 Feb 2021 20:12:44 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: new code for 5.12
Message-ID: <20210219041244.GZ7193@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull the following branch containing all the new xfs code for
5.12.  There's a lot going on this time, which seems about right for
this drama-filled year.

Community developers added some code to speed up freezing when read-only
workloads are still running, refactored the logging code, added checks
to prevent file extent counter overflow, reduced iolock cycling to speed
up fsync and gc scans, and started the slow march towards supporting
filesystem shrinking.

There's a huge refactoring of the internal speculative preallocation
garbage collection code which fixes a bunch of bugs, makes the gc
scheduling per-AG and hence multithreaded, and standardizes the retry
logic when we try to reserve space or quota, can't, and want to trigger
a gc scan.  We also enable multithreaded quotacheck to reduce mount
times further.  This is also preparation for background file gc, which
may or may not land for 5.13.

We also fixed some deadlocks in the rename code, fixed a quota
accounting leak when FSSETXATTR fails, restored the behavior that write
faults to an mmap'd region actually cause a SIGBUS, fixed a bug where
sgid directory inheritance wasn't quite working properly, and fixed a
bug where symlinks weren't working properly in ecryptfs.  We also now
advertise the inode btree counters feature that was introduced two
cycles ago.

This branch merges cleanly with 5.11, but there were a few merge
conflicts with the pidfd tree that Stephen Rothwell noticed in for-next.
Christian Brauner is trying to create per-mount id mappings, which
apparently requires passing the per-mount user namespace deep into the
filesystems, either directly or through struct files.

The first conflict arises from Christoph's fix for gid inheritance; I
think it can be resolved as follows:

diff --cc fs/xfs/xfs_inode.c
index 636ac13b1df2,95b7f2ba4e06..000000000000
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@@ -809,13 -810,13 +810,13 @@@ xfs_init_new_inode
  	inode->i_rdev = rdev;
  	ip->i_d.di_projid = prid;
  
 -	if (pip && XFS_INHERIT_GID(pip)) {
 -		inode->i_gid = VFS_I(pip)->i_gid;
 -		if ((VFS_I(pip)->i_mode & S_ISGID) && S_ISDIR(mode))
 -			inode->i_mode |= S_ISGID;
 +	if (dir && !(dir->i_mode & S_ISGID) &&
 +	    (mp->m_flags & XFS_MOUNT_GRPID)) {
- 		inode->i_uid = current_fsuid();
++		inode->i_uid = fsuid_into_mnt(mnt_userns);
 +		inode->i_gid = dir->i_gid;
 +		inode->i_mode = mode;
  	} else {
- 		inode_init_owner(inode, dir, mode);
 -		inode->i_gid = fsgid_into_mnt(mnt_userns);
++		inode_init_owner(mnt_userns, inode, dir, mode);
  	}
  
  	/*

I think the important bits here are making sure the previous
current_fs[ug]id() calls get turned into fs[ug]id_into_mnt() calls, and
making sure the mnt_userns pointer gets passed to inode_init_owner().

The second conflict involves the quota reservation rework patchset, and
I think it can be resolved as follows:

diff --cc fs/xfs/xfs_ioctl.c
index 248083ea0276,3d4c7ca080fb..000000000000
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@@ -1275,9 -1280,9 +1280,10 @@@ xfs_ioctl_setattr_prepare_dax
   */
  static struct xfs_trans *
  xfs_ioctl_setattr_get_trans(
- 	struct xfs_inode	*ip,
 -	struct file		*file)
++	struct file		*file,
 +	struct xfs_dquot	*pdqp)
  {
+ 	struct xfs_inode	*ip = XFS_I(file_inode(file));
  	struct xfs_mount	*mp = ip->i_mount;
  	struct xfs_trans	*tp;
  	int			error = -EROFS;
@@@ -1461,9 -1470,9 +1469,9 @@@ xfs_ioctl_setattr
  
  	xfs_ioctl_setattr_prepare_dax(ip, fa);
  
- 	tp = xfs_ioctl_setattr_get_trans(ip, pdqp);
 -	tp = xfs_ioctl_setattr_get_trans(file);
++	tp = xfs_ioctl_setattr_get_trans(file, pdqp);
  	if (IS_ERR(tp)) {
 -		code = PTR_ERR(tp);
 +		error = PTR_ERR(tp);
  		goto error_free_dquots;
  	}
  
@@@ -1599,7 -1615,7 +1606,7 @@@ xfs_ioc_setxflags
  
  	xfs_ioctl_setattr_prepare_dax(ip, &fa);
  
- 	tp = xfs_ioctl_setattr_get_trans(ip, NULL);
 -	tp = xfs_ioctl_setattr_get_trans(filp);
++	tp = xfs_ioctl_setattr_get_trans(filp, NULL);
  	if (IS_ERR(tp)) {
  		error = PTR_ERR(tp);
  		goto out_drop_write;

Mr. Brauner swapped the xfs_inode pointer in the first argument of
xfs_ioctl_setattr_get_trans for a struct file, and I added a second
argument to pass a xfs_dquot that we're making reservations against into
the get_trans function.  The rest of the diff updates the callsite
parameters.

After the merge, the function signature should be:

static struct xfs_trans *
xfs_ioctl_setattr_get_trans(
	struct file		*file,
	struct xfs_dquot	*pdqp) {...}

The third conflict is also from the quota rework patchset, and (AFAICT)
auto-resolved like this:

diff --cc fs/xfs/xfs_inode.c
index 636ac13b1df2,95b7f2ba4e06..000000000000
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@@ -1159,12 -1167,16 +1166,12 @@@ xfs_create_tmpfile
  	resblks = XFS_IALLOC_SPACE_RES(mp);
  	tres = &M_RES(mp)->tr_create_tmpfile;
  
 -	error = xfs_trans_alloc(mp, tres, resblks, 0, 0, &tp);
 +	error = xfs_trans_alloc_icreate(mp, tres, udqp, gdqp, pdqp, resblks,
 +			&tp);
  	if (error)
 -		goto out_release_inode;
 -
 -	error = xfs_trans_reserve_quota(tp, mp, udqp, gdqp,
 -						pdqp, resblks, 1, 0);
 -	if (error)
 -		goto out_trans_cancel;
 +		goto out_release_dquots;
  
- 	error = xfs_dir_ialloc(&tp, dp, mode, 0, 0, prid, &ip);
+ 	error = xfs_dir_ialloc(mnt_userns, &tp, dp, mode, 0, 0, prid, &ip);
  	if (error)
  		goto out_trans_cancel;
  
All that is going on here is adding the mnt_userns parameter as the
first argument to xfs_dir_ialloc; I think the only reason my test merge
noticed it is because it's adjacent to a different change that I made.

With those pieces fixed up, the tree builds and seems to pass the simple
fstest run that I did.  Please let me know if anything else strange
happens during the merge process, particularly since there usually
aren't merge conflicts. :)

I will probably follow this up in a day or two with a couple more fixes
that have trickled in, but I am still catching up after the same ice
storm that knocked you in the dark(?) last Sunday also knocked me
offline until yesterday afternoon.  It's a bit disconcerting that a
single evening's ice storm could cut power to 10% of the state's
population and overload the cell phone networks to the point of
unusability.

--D

The following changes since commit 19c329f6808995b142b3966301f217c831e7cf31:

  Linux 5.11-rc4 (2021-01-17 16:37:05 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.12-merge-5

for you to fetch changes up to 1cd738b13ae9b29e03d6149f0246c61f76e81fcf:

  xfs: consider shutdown in bmapbt cursor delete assert (2021-02-11 08:46:38 -0800)

----------------------------------------------------------------
New code for 5.12:
- Fix an ABBA deadlock when renaming files on overlayfs.
- Make sure that we can't overflow the inode extent counters when adding
  to or removing extents from a file.
- Make directory sgid inheritance work the same way as all the other
  filesystems.
- Don't drain the buffer cache on freeze and ro remount, which should
  reduce the amount of time if read-only workloads are continuing
  during the freeze.
- Fix a bug where symlink size isn't reported to the vfs in ecryptfs.
- Disentangle log cleaning from log covering.  This refactoring sets us
  up for future changes to the log, though for now it simply means that
  we can use covering for freezes, and cleaning becomes something we
  only do at unmount.
- Speed up file fsyncs by reducing iolock cycling.
- Fix delalloc blocks leaking when changing the project id fails because
  of input validation errors in FSSETXATTR.
- Fix oversized quota reservation when converting unwritten extents
  during a DAX write.
- Create a transaction allocation helper function to standardize the
  idiom of allocating a transaction, reserving blocks, locking inodes,
  and reserving quota.  Replace all the open-coded logic for file
  creation, file ownership changes, and file modifications to use them.
- Actually shut down the fs if the incore quota reservations get
  corrupted.
- Fix background block garbage collection scans to not block and to
  actually clean out CoW staging extents properly.
- Run block gc scans when we run low on project quota.
- Use the standardized transaction allocation helpers to make it so that
  ENOSPC and EDQUOT errors during reservation will back out, invoke the
  block gc scanner, and try again.  This is preparation for introducing
  background inode garbage collection in the next cycle.
- Combine speculative post-EOF block garbage collection with speculative
  copy on write block garbage collection.
- Enable multithreaded quotacheck.
- Allow sysadmins to tweak the CPU affinities and maximum concurrency
  levels of quotacheck and background blockgc worker pools.
- Expose the inode btree counter feature in the fs geometry ioctl.
- Cleanups of the growfs code in preparation for starting work on
  filesystem shrinking.
- Fix all the bloody gcc warnings that the maintainer knows about. :P
- Fix a RST syntax error.
- Don't trigger bmbt corruption assertions after the fs shuts down.
- Restore behavior of forcing SIGBUS on a shut down filesystem when
  someone triggers a mmap write fault (or really, any buffered write).

----------------------------------------------------------------
Brian Foster (14):
      xfs: rename xfs_wait_buftarg() to xfs_buftarg_drain()
      xfs: don't drain buffer lru on freeze and read-only remount
      xfs: sync lazy sb accounting on quiesce of read-only mounts
      xfs: lift writable fs check up into log worker task
      xfs: separate log cleaning from log quiesce
      xfs: cover the log during log quiesce
      xfs: don't reset log idle state on covering checkpoints
      xfs: fold sbcount quiesce logging into log covering
      xfs: remove duplicate wq cancel and log force from attr quiesce
      xfs: remove xfs_quiesce_attr()
      xfs: cover the log on freeze instead of cleaning it
      xfs: fix unused log variable in xfs_log_cover()
      xfs: restore shutdown check in mapped write fault path
      xfs: consider shutdown in bmapbt cursor delete assert

Chandan Babu R (17):
      xfs: Add helper for checking per-inode extent count overflow
      xfs: Check for extent overflow when trivally adding a new extent
      xfs: Check for extent overflow when punching a hole
      xfs: Check for extent overflow when adding dir entries
      xfs: Check for extent overflow when removing dir entries
      xfs: Check for extent overflow when renaming dir entries
      xfs: Check for extent overflow when adding/removing xattrs
      xfs: Check for extent overflow when writing to unwritten extent
      xfs: Check for extent overflow when moving extent from cow to data fork
      xfs: Check for extent overflow when remapping an extent
      xfs: Check for extent overflow when swapping extents
      xfs: Introduce error injection to reduce maximum inode fork extent count
      xfs: Remove duplicate assert statement in xfs_bmap_btalloc()
      xfs: Compute bmap extent alignments in a separate function
      xfs: Process allocated extent in a separate function
      xfs: Introduce error injection to allocate only minlen size extents for files
      xfs: Fix 'set but not used' warning in xfs_bmap_compute_alignments()

Christoph Hellwig (3):
      xfs: fix up non-directory creation in SGID directories
      xfs: refactor xfs_file_fsync
      xfs: reduce ilock acquisitions in xfs_file_fsync

Darrick J. Wong (44):
      xfs: fix an ABBA deadlock in xfs_rename
      xfs: fix chown leaking delalloc quota blocks when fssetxattr fails
      xfs: reduce quota reservation when doing a dax unwritten extent conversion
      xfs: clean up quota reservation callsites
      xfs: create convenience wrappers for incore quota block reservations
      xfs: remove xfs_trans_unreserve_quota_nblks completely
      xfs: clean up icreate quota reservation calls
      xfs: fix up build warnings when quotas are disabled
      xfs: reserve data and rt quota at the same time
      xfs: refactor common transaction/inode/quota allocation idiom
      xfs: allow reservation of rtblocks with xfs_trans_alloc_inode
      xfs: refactor reflink functions to use xfs_trans_alloc_inode
      xfs: refactor inode creation transaction/inode/quota allocation idiom
      xfs: refactor inode ownership change transaction/inode/quota allocation idiom
      xfs: remove xfs_qm_vop_chown_reserve
      xfs: rename code to error in xfs_ioctl_setattr
      xfs: shut down the filesystem if we screw up quota reservation
      xfs: trigger all block gc scans when low on quota space
      xfs: don't stall cowblocks scan if we can't take locks
      xfs: xfs_inode_free_quota_blocks should scan project quota
      xfs: move and rename xfs_inode_free_quota_blocks to avoid conflicts
      xfs: pass flags and return gc errors from xfs_blockgc_free_quota
      xfs: try worst case space reservation upfront in xfs_reflink_remap_extent
      xfs: flush eof/cowblocks if we can't reserve quota for file blocks
      xfs: flush eof/cowblocks if we can't reserve quota for inode creation
      xfs: flush eof/cowblocks if we can't reserve quota for chown
      xfs: add a tracepoint for blockgc scans
      xfs: refactor xfs_icache_free_{eof,cow}blocks call sites
      xfs: flush speculative space allocations when we run out of space
      xfs: increase the default parallelism levels of pwork clients
      xfs: set WQ_SYSFS on all workqueues in debug mode
      xfs: relocate the eofb/cowb workqueue functions
      xfs: hide xfs_icache_free_eofblocks
      xfs: hide xfs_icache_free_cowblocks
      xfs: remove trivial eof/cowblocks functions
      xfs: consolidate incore inode radix tree posteof/cowblocks tags
      xfs: consolidate the eofblocks and cowblocks workers
      xfs: only walk the incore inode tree once per blockgc scan
      xfs: rename block gc start and stop functions
      xfs: parallelize block preallocation garbage collection
      xfs: expose the blockgc workqueue knobs publicly
      xfs: don't bounce the iolock between free_{eof,cow}blocks
      xfs: fix incorrect root dquot corruption error when switching group/project quota types
      xfs: fix rst syntax error in admin guide

Eric Biggers (1):
      xfs: remove a stale comment from xfs_file_aio_write_checks()

Gao Xiang (2):
      xfs: rename `new' to `delta' in xfs_growfs_data_private()
      xfs: get rid of xfs_growfs_{data,log}_t

Jeffrey Mitchell (1):
      xfs: set inode size after creating symlink

Yumei Huang (1):
      xfs: Fix assert failure in xfs_setattr_size()

Zorro Lang (1):
      libxfs: expose inobtcount in xfs geometry

kernel test robot (1):
      xfs: fix boolreturn.cocci warnings

 Documentation/admin-guide/xfs.rst |  42 ++++
 fs/xfs/libxfs/xfs_alloc.c         |  50 +++++
 fs/xfs/libxfs/xfs_alloc.h         |   3 +
 fs/xfs/libxfs/xfs_attr.c          |  22 +-
 fs/xfs/libxfs/xfs_bmap.c          | 315 ++++++++++++++++++---------
 fs/xfs/libxfs/xfs_btree.c         |  33 ++-
 fs/xfs/libxfs/xfs_dir2.h          |   2 -
 fs/xfs/libxfs/xfs_dir2_sf.c       |   2 +-
 fs/xfs/libxfs/xfs_errortag.h      |   6 +-
 fs/xfs/libxfs/xfs_fs.h            |   1 +
 fs/xfs/libxfs/xfs_inode_fork.c    |  27 +++
 fs/xfs/libxfs/xfs_inode_fork.h    |  63 ++++++
 fs/xfs/libxfs/xfs_sb.c            |   2 +
 fs/xfs/scrub/common.c             |   4 +-
 fs/xfs/xfs_bmap_item.c            |  10 +
 fs/xfs/xfs_bmap_util.c            |  81 ++++---
 fs/xfs/xfs_buf.c                  |  30 ++-
 fs/xfs/xfs_buf.h                  |  11 +-
 fs/xfs/xfs_dquot.c                |  47 +++-
 fs/xfs/xfs_error.c                |   6 +
 fs/xfs/xfs_file.c                 | 114 +++++-----
 fs/xfs/xfs_fsops.c                |  32 +--
 fs/xfs/xfs_fsops.h                |   4 +-
 fs/xfs/xfs_globals.c              |   7 +-
 fs/xfs/xfs_icache.c               | 438 ++++++++++++++++++++------------------
 fs/xfs/xfs_icache.h               |  24 +--
 fs/xfs/xfs_inode.c                | 134 ++++++++----
 fs/xfs/xfs_ioctl.c                |  75 +++----
 fs/xfs/xfs_iomap.c                |  53 ++---
 fs/xfs/xfs_iops.c                 |  28 +--
 fs/xfs/xfs_iwalk.c                |   5 +-
 fs/xfs/xfs_linux.h                |   3 +-
 fs/xfs/xfs_log.c                  | 142 +++++++++---
 fs/xfs/xfs_log.h                  |   4 +-
 fs/xfs/xfs_mount.c                |  43 +---
 fs/xfs/xfs_mount.h                |  10 +-
 fs/xfs/xfs_mru_cache.c            |   2 +-
 fs/xfs/xfs_pwork.c                |  25 +--
 fs/xfs/xfs_pwork.h                |   4 +-
 fs/xfs/xfs_qm.c                   | 116 ++--------
 fs/xfs/xfs_quota.h                |  49 +++--
 fs/xfs/xfs_reflink.c              | 109 ++++++----
 fs/xfs/xfs_rtalloc.c              |   5 +
 fs/xfs/xfs_super.c                |  82 +++----
 fs/xfs/xfs_super.h                |   6 +
 fs/xfs/xfs_symlink.c              |  15 +-
 fs/xfs/xfs_sysctl.c               |  15 +-
 fs/xfs/xfs_sysctl.h               |   3 +-
 fs/xfs/xfs_trace.c                |   1 +
 fs/xfs/xfs_trace.h                |  50 ++++-
 fs/xfs/xfs_trans.c                | 195 +++++++++++++++++
 fs/xfs/xfs_trans.h                |  13 ++
 fs/xfs/xfs_trans_dquot.c          |  73 +++++--
 53 files changed, 1654 insertions(+), 982 deletions(-)
