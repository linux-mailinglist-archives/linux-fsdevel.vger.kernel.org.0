Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9017936EE96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 19:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240917AbhD2RHI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 13:07:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233622AbhD2RHH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 13:07:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED8ED6144B;
        Thu, 29 Apr 2021 17:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619715980;
        bh=Nvw1NjfEMcuy3mDrzk6RktH0ylSVCuj9mtiNBpPsQHM=;
        h=Date:From:To:Cc:Subject:From;
        b=g+/Jbrl1iuK8muwq/cM94QvtyLZwlhfN5mnWim2ASXLnLEXwmYn8wi25Fifp31Tav
         iJj54ndmkf0vk2P2t26Tqxe1zvZ4X/en5QSA3A9DW8eNRm/jzDpTPV3LblLrRF5H9e
         tE0H2bVqnbS3M8jYg2Peo25wT6JIdoMF5si1OWkvVT+SrZG14RD6lTCBgJGIpJbjhr
         myT4Eq+zhjkAxsHL87g+6ukVINBEIoxUJTghU6cHTHh7r48aSjdE8oSGwvhbhjAgZ3
         A4tTXwuaNlWK00PODJeFR2niveIpND5c+HvmD6foxxvcgGmwPNQXq/BnAB/SRk5rKc
         QjkxODlx6FLxA==
Date:   Thu, 29 Apr 2021 10:06:19 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: new code for 5.13
Message-ID: <20210429170619.GM3122264@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull the following branch containing new xfs code for 5.13.  The
notable user-visible addition this cycle is ability to remove space from
the last AG in a filesystem.  This is the first of many changes needed
for full-fledged support for shrinking a filesystem.  Still needed are
(a) the ability to reorganize files and metadata away from the end of
the fs; (b) the ability to remove entire allocation groups; (c) shrink
support for realtime volumes; and (d) thorough testing of (a-c).

There are a number of performance improvements in this code drop: Dave
streamlined various parts of the buffer logging code and reduced the
cost of various debugging checks, and added the ability to pre-create
the xattr structures while creating files.  Brian eliminated transaction
reservations that were being held across writeback (thus reducing
livelock potential.

Other random pieces: Pavel fixed the repetitve warnings about deprecated
mount options, I fixed online fsck to behave itself when a readonly
remount comes in during scrub, and refactored various other parts of
that code, Christoph contributed a lot of refactoring this cycle.  The
xfs_icdinode structure has been absorbed into the (incore) xfs_inode
structure, and the format and flags handling around xfs_inode_fork
structures has been simplified.  Chandan provided a number of fixes for
extent count overflow related problems that have been shaken out by
debugging knobs added during 5.12.

Unfortunately, some of our refactoring work collided with Miklos'
patchset that refactors FS_IOC_[GS]ETFLAGS and FS_IOC_FS[GS]ETXATTR.
The functions xfs_ioc_fssetxattr, xfs_ioc_getxflags, and
xfs_ioc_setxflags remain unnecessary and should remain removed.
The rest of the conflicts can be resolved with this patch:

diff --cc fs/xfs/xfs_ioctl.c
index bbda105a2ce5,bf490bfae6cb..000000000000
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@@ -1057,17 -1056,77 +1057,19 @@@ xfs_ioc_ag_geometry
  static void
  xfs_fill_fsxattr(
  	struct xfs_inode	*ip,
 -	bool			attr,
 -	struct fsxattr		*fa)
 +	int			whichfork,
 +	struct fileattr		*fa)
  {
+ 	struct xfs_mount	*mp = ip->i_mount;
 -	struct xfs_ifork	*ifp = attr ? ip->i_afp : &ip->i_df;
 +	struct xfs_ifork	*ifp = XFS_IFORK_PTR(ip, whichfork);
  
 -	simple_fill_fsxattr(fa, xfs_ip2xflags(ip));
 +	fileattr_fill_xflags(fa, xfs_ip2xflags(ip));
- 	fa->fsx_extsize = ip->i_d.di_extsize << ip->i_mount->m_sb.sb_blocklog;
- 	fa->fsx_cowextsize = ip->i_d.di_cowextsize <<
- 			ip->i_mount->m_sb.sb_blocklog;
- 	fa->fsx_projid = ip->i_d.di_projid;
- 	if (ifp && (ifp->if_flags & XFS_IFEXTENTS))
+ 
+ 	fa->fsx_extsize = XFS_FSB_TO_B(mp, ip->i_extsize);
+ 	if (ip->i_diflags2 & XFS_DIFLAG2_COWEXTSIZE)
+ 		fa->fsx_cowextsize = XFS_FSB_TO_B(mp, ip->i_cowextsize);
+ 	fa->fsx_projid = ip->i_projid;
+ 	if (ifp && !xfs_need_iread_extents(ifp))
  		fa->fsx_nextents = xfs_iext_count(ifp);
  	else
  		fa->fsx_nextents = xfs_ifork_nextents(ifp);
@@@ -1167,10 -1212,10 +1169,10 @@@ static in
  xfs_ioctl_setattr_xflags(
  	struct xfs_trans	*tp,
  	struct xfs_inode	*ip,
 -	struct fsxattr		*fa)
 +	struct fileattr		*fa)
  {
  	struct xfs_mount	*mp = ip->i_mount;
- 	uint64_t		di_flags2;
+ 	uint64_t		i_flags2;
  
  	/* Can't change realtime flag if any extents are allocated. */
  	if ((ip->i_df.if_nextents || ip->i_delayed_blks) &&
@@@ -1289,11 -1348,8 +1291,11 @@@ xfs_ioctl_setattr_check_extsize
  	xfs_extlen_t		size;
  	xfs_fsblock_t		extsize_fsb;
  
 +	if (!fa->fsx_valid)
 +		return 0;
 +
  	if (S_ISREG(VFS_I(ip)->i_mode) && ip->i_df.if_nextents &&
- 	    ((ip->i_d.di_extsize << mp->m_sb.sb_blocklog) != fa->fsx_extsize))
+ 	    ((ip->i_extsize << mp->m_sb.sb_blocklog) != fa->fsx_extsize))
  		return -EINVAL;
  
  	if (fa->fsx_extsize == 0)
@@@ -1476,18 -1520,18 +1478,19 @@@ xfs_fileattr_set
  	 * extent size hint should be set on the inode. If no extent size flags
  	 * are set on the inode then unconditionally clear the extent size hint.
  	 */
- 	if (ip->i_d.di_flags & (XFS_DIFLAG_EXTSIZE | XFS_DIFLAG_EXTSZINHERIT))
- 		ip->i_d.di_extsize = fa->fsx_extsize >> mp->m_sb.sb_blocklog;
+ 	if (ip->i_diflags & (XFS_DIFLAG_EXTSIZE | XFS_DIFLAG_EXTSZINHERIT))
+ 		ip->i_extsize = XFS_B_TO_FSB(mp, fa->fsx_extsize);
  	else
- 		ip->i_d.di_extsize = 0;
- 	if (xfs_sb_version_has_v3inode(&mp->m_sb) &&
- 	    (ip->i_d.di_flags2 & XFS_DIFLAG2_COWEXTSIZE))
- 		ip->i_d.di_cowextsize = fa->fsx_cowextsize >>
- 				mp->m_sb.sb_blocklog;
- 	else
- 		ip->i_d.di_cowextsize = 0;
+ 		ip->i_extsize = 0;
+ 
+ 	if (xfs_sb_version_has_v3inode(&mp->m_sb)) {
+ 		if (ip->i_diflags2 & XFS_DIFLAG2_COWEXTSIZE)
+ 			ip->i_cowextsize = XFS_B_TO_FSB(mp, fa->fsx_cowextsize);
+ 		else
+ 			ip->i_cowextsize = 0;
+ 	}
  
 +skip_xattr:
  	error = xfs_trans_commit(tp);
  
  	/*

With the conflicts resolved, the tree builds and seems to pass the
fstests run that I did.  Please let me know if anything else strange
happens during the merge process.

I anticipate a second pull request next week for some minor code
cleanups and numerous bug fixes.

--D

The following changes since commit 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b:

  Linux 5.12-rc4 (2021-03-21 14:56:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.13-merge-3

for you to fetch changes up to 76adf92a30f3b92a7f91bb00b28ea80efccd0f01:

  xfs: remove xfs_quiesce_attr declaration (2021-04-16 08:28:36 -0700)

----------------------------------------------------------------
New code for 5.13:
- Various minor fixes in online scrub.
- Prevent metadata files from being automatically inactivated.
- Validate btree heights by the computed per-btree limits.
- Don't warn about remounting with deprecated mount options.
- Initialize attr forks at create time if we suspect we're going to need
  to store them.
- Reduce memory reallocation workouts in the logging code.
- Fix some theoretical math calculation errors in logged buffers that
  span multiple discontig memory ranges but contiguous ondisk regions.
- Speedups in dirty buffer bitmap handling.
- Make type verifier functions more inline-happy to reduce overhead.
- Reduce debug overhead in directory checking code.
- Many many typo fixes.
- Begin to handle the permanent loss of the very end of a filesystem.
- Fold struct xfs_icdinode into xfs_inode.
- Deprecate the long defunct BMV_IF_NO_DMAPI_READ from the bmapx ioctl.
- Remove a broken directory block format check from online scrub.
- Fix a bug where we could produce an unnecessarily tall data fork btree
  when creating an attr fork.
- Fix scrub and readonly remounts racing.
- Fix a writeback ioend log deadlock problem by dropping the behavior
  where we could preallocate a setfilesize transaction.
- Fix some bugs in the new extent count checking code.
- Fix some bugs in the attr fork preallocation code.
- Refactor if_flags out of the incore inode fork data structure.

----------------------------------------------------------------
Anthony Iliopoulos (2):
      xfs: fix xfs_trans slab cache name
      xfs: deprecate BMV_IF_NO_DMAPI_READ flag

Bhaskar Chowdhury (3):
      xfs: Rudimentary typo fixes
      xfs: Rudimentary spelling fix
      xfs: Fix a typo

Brian Foster (4):
      xfs: drop submit side trans alloc for append ioends
      xfs: open code ioend needs workqueue helper
      xfs: drop unused ioend private merge and setfilesize code
      xfs: drop unnecessary setfilesize helper

Chandan Babu R (5):
      xfs: Fix dax inode extent calculation when direct write is performed on an unwritten extent
      xfs: Initialize xfs_alloc_arg->total correctly when allocating minlen extents
      xfs: scrub: Remove incorrect check executed on block format directories
      xfs: Use struct xfs_bmdr_block instead of struct xfs_btree_block to calculate root node size
      xfs: scrub: Disable check for unoptimized data fork bmbt node

Christoph Hellwig (27):
      xfs: split xfs_imap_to_bp
      xfs: consistently initialize di_flags2
      xfs: handle crtime more carefully in xfs_bulkstat_one_int
      xfs: remove the unused xfs_icdinode_has_bigtime helper
      xfs: remove the di_dmevmask and di_dmstate fields from struct xfs_icdinode
      xfs: don't clear the "dinode core" in xfs_inode_alloc
      xfs: move the di_projid field to struct xfs_inode
      xfs: move the di_size field to struct xfs_inode
      xfs: move the di_nblocks field to struct xfs_inode
      xfs: move the di_extsize field to struct xfs_inode
      xfs: move the di_cowextsize field to struct xfs_inode
      xfs: move the di_flushiter field to struct xfs_inode
      xfs: cleanup xfs_fill_fsxattr
      xfs: use XFS_B_TO_FSB in xfs_ioctl_setattr
      xfs: use a union for i_cowextsize and i_flushiter
      xfs: move the di_forkoff field to struct xfs_inode
      xfs: move the di_flags field to struct xfs_inode
      xfs: move the di_flags2 field to struct xfs_inode
      xfs: move the di_crtime field to struct xfs_inode
      xfs: merge _xfs_dic2xflags into xfs_ip2xflags
      xfs: move the XFS_IFEXTENTS check into xfs_iread_extents
      xfs: rename and simplify xfs_bmap_one_block
      xfs: simplify xfs_attr_remove_args
      xfs: only look at the fork format in xfs_idestroy_fork
      xfs: remove XFS_IFBROOT
      xfs: remove XFS_IFINLINE
      xfs: remove XFS_IFEXTENTS

Colin Ian King (1):
      xfs: fix return of uninitialized value in variable error

Darrick J. Wong (15):
      xfs: drop freeze protection when running GETFSMAP
      xfs: fix uninitialized variables in xrep_calc_ag_resblks
      xfs: fix dquot scrub loop cancellation
      xfs: bail out of scrub immediately if scan incomplete
      xfs: mark a data structure sick if there are cross-referencing errors
      xfs: set the scrub AG number in xchk_ag_read_headers
      xfs: remove return value from xchk_ag_btcur_init
      xfs: validate ag btree levels using the precomputed values
      xfs: prevent metadata files from being inactivated
      xfs: rename the blockgc workqueue
      xfs: move the xfs_can_free_eofblocks call under the IOLOCK
      xfs: move the check for post-EOF mappings into xfs_can_free_eofblocks
      xfs: fix scrub and remount-ro protection when running scrub
      xfs: get rid of the ip parameter to xchk_setup_*
      xfs: remove xfs_quiesce_attr declaration

Dave Chinner (12):
      xfs: initialise attr fork on inode create
      xfs: reduce buffer log item shadow allocations
      xfs: xfs_buf_item_size_segment() needs to pass segment offset
      xfs: optimise xfs_buf_item_size/format for contiguous regions
      xfs: type verification is expensive
      xfs: No need for inode number error injection in __xfs_dir3_data_check
      xfs: reduce debug overhead of dir leaf/node checks
      xfs: __percpu_counter_compare() inode count debug too expensive
      xfs: eager inode attr fork init needs attr feature awareness
      xfs: inode fork allocation depends on XFS_IFEXTENT flag
      xfs: default attr fork size does not handle device inodes
      xfs: precalculate default inode attribute offset

Gao Xiang (6):
      xfs: ensure xfs_errortag_random_default matches XFS_ERRTAG_MAX
      xfs: update lazy sb counters immediately for resizefs
      xfs: hoist out xfs_resizefs_init_new_ags()
      xfs: introduce xfs_ag_shrink_space()
      xfs: support shrinking unused space in the last AG
      xfs: add error injection for per-AG resv failure

Pavel Reichl (2):
      xfs: rename variable mp to parsing_mp
      xfs: Skip repetitive warnings about mount options

 Documentation/admin-guide/xfs.rst |   2 +-
 fs/xfs/libxfs/xfs_ag.c            | 115 +++++++++++++++++
 fs/xfs/libxfs/xfs_ag.h            |   2 +
 fs/xfs/libxfs/xfs_ag_resv.c       |   6 +-
 fs/xfs/libxfs/xfs_alloc.c         |   8 +-
 fs/xfs/libxfs/xfs_attr.c          |  54 +++++---
 fs/xfs/libxfs/xfs_attr.h          |   1 +
 fs/xfs/libxfs/xfs_attr_leaf.c     |  35 +++--
 fs/xfs/libxfs/xfs_bmap.c          | 229 +++++++++++++--------------------
 fs/xfs/libxfs/xfs_bmap.h          |   2 +-
 fs/xfs/libxfs/xfs_bmap_btree.c    |   6 +-
 fs/xfs/libxfs/xfs_btree_staging.c |   1 -
 fs/xfs/libxfs/xfs_da_btree.c      |   4 +-
 fs/xfs/libxfs/xfs_dir2.c          |  14 +-
 fs/xfs/libxfs/xfs_dir2_block.c    |  12 +-
 fs/xfs/libxfs/xfs_dir2_data.c     |   2 +-
 fs/xfs/libxfs/xfs_dir2_leaf.c     |  12 +-
 fs/xfs/libxfs/xfs_dir2_node.c     |   4 +-
 fs/xfs/libxfs/xfs_dir2_priv.h     |   3 +-
 fs/xfs/libxfs/xfs_dir2_sf.c       |  58 ++++-----
 fs/xfs/libxfs/xfs_errortag.h      |   4 +-
 fs/xfs/libxfs/xfs_format.h        |   5 +-
 fs/xfs/libxfs/xfs_fs.h            |   2 +-
 fs/xfs/libxfs/xfs_ialloc.c        |   4 +-
 fs/xfs/libxfs/xfs_iext_tree.c     |   2 +-
 fs/xfs/libxfs/xfs_inode_buf.c     |  81 +++++-------
 fs/xfs/libxfs/xfs_inode_buf.h     |  33 +----
 fs/xfs/libxfs/xfs_inode_fork.c    |  48 +++----
 fs/xfs/libxfs/xfs_inode_fork.h    |  20 +--
 fs/xfs/libxfs/xfs_rtbitmap.c      |   4 +-
 fs/xfs/libxfs/xfs_shared.h        |   4 +
 fs/xfs/libxfs/xfs_trans_inode.c   |   7 +-
 fs/xfs/libxfs/xfs_types.c         |  18 +--
 fs/xfs/scrub/agheader.c           |  33 ++---
 fs/xfs/scrub/alloc.c              |   5 +-
 fs/xfs/scrub/attr.c               |   5 +-
 fs/xfs/scrub/bmap.c               |  20 +--
 fs/xfs/scrub/btree.c              |  30 ++++-
 fs/xfs/scrub/common.c             |  38 +++---
 fs/xfs/scrub/common.h             |  58 ++++-----
 fs/xfs/scrub/dir.c                |  20 +--
 fs/xfs/scrub/fscounters.c         |   3 +-
 fs/xfs/scrub/health.c             |   3 +-
 fs/xfs/scrub/ialloc.c             |   8 +-
 fs/xfs/scrub/inode.c              |   5 +-
 fs/xfs/scrub/parent.c             |   7 +-
 fs/xfs/scrub/quota.c              |  11 +-
 fs/xfs/scrub/refcount.c           |   5 +-
 fs/xfs/scrub/repair.c             |  11 +-
 fs/xfs/scrub/repair.h             |   6 +-
 fs/xfs/scrub/rmap.c               |   5 +-
 fs/xfs/scrub/rtbitmap.c           |   7 +-
 fs/xfs/scrub/scrub.c              |  42 +++---
 fs/xfs/scrub/scrub.h              |  14 +-
 fs/xfs/scrub/symlink.c            |   9 +-
 fs/xfs/scrub/xfs_scrub.h          |   4 +-
 fs/xfs/xfs_aops.c                 | 138 +++-----------------
 fs/xfs/xfs_attr_list.c            |   2 +-
 fs/xfs/xfs_bmap_util.c            | 219 ++++++++++++++++---------------
 fs/xfs/xfs_buf_item.c             | 141 +++++++++++++++-----
 fs/xfs/xfs_dir2_readdir.c         |  12 +-
 fs/xfs/xfs_dquot.c                |  10 +-
 fs/xfs/xfs_error.c                |   5 +
 fs/xfs/xfs_file.c                 |  12 +-
 fs/xfs/xfs_filestream.h           |   2 +-
 fs/xfs/xfs_fsmap.c                |  14 +-
 fs/xfs/xfs_fsops.c                | 195 ++++++++++++++++++----------
 fs/xfs/xfs_icache.c               |  35 ++---
 fs/xfs/xfs_inode.c                | 262 ++++++++++++++++++++------------------
 fs/xfs/xfs_inode.h                |  42 ++++--
 fs/xfs/xfs_inode_item.c           |  56 +++++---
 fs/xfs/xfs_ioctl.c                |  71 ++++++-----
 fs/xfs/xfs_iomap.c                |  27 ++--
 fs/xfs/xfs_iops.c                 |  65 +++++++---
 fs/xfs/xfs_itable.c               |  19 ++-
 fs/xfs/xfs_linux.h                |   2 +-
 fs/xfs/xfs_log_recover.c          |  13 +-
 fs/xfs/xfs_mount.c                |  14 +-
 fs/xfs/xfs_mount.h                |   2 +-
 fs/xfs/xfs_pnfs.c                 |   2 +-
 fs/xfs/xfs_qm.c                   |  22 ++--
 fs/xfs/xfs_qm_bhv.c               |   2 +-
 fs/xfs/xfs_qm_syscalls.c          |   2 +-
 fs/xfs/xfs_quotaops.c             |   2 +-
 fs/xfs/xfs_reflink.c              |  22 ++--
 fs/xfs/xfs_rtalloc.c              |  16 +--
 fs/xfs/xfs_super.c                | 132 ++++++++++---------
 fs/xfs/xfs_super.h                |   1 -
 fs/xfs/xfs_symlink.c              |  28 ++--
 fs/xfs/xfs_trace.h                |  16 +--
 fs/xfs/xfs_trans.c                |  14 +-
 fs/xfs/xfs_xattr.c                |   2 +
 92 files changed, 1463 insertions(+), 1307 deletions(-)
