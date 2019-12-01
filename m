Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F88610E33E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2019 19:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfLASsQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Dec 2019 13:48:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727298AbfLASsQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Dec 2019 13:48:16 -0500
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41EBD20833;
        Sun,  1 Dec 2019 18:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575226095;
        bh=wxzr14VZwc67DRIGiSD7xbuELtfCkneiz9MKnKrBtFc=;
        h=Date:From:To:Cc:Subject:From;
        b=k+aHCXpsU6qfEovDyxnG6gkOq9HJAJCkLKqsI7h7v3L24I0s+8KznlTbuEhzvZjQv
         UFFaxRUAyTy9sbubZojfq++vSeHU4eZg4bTEB66NEqxpFE1S60QAQAIO/56X70iNp9
         PdAuxcfCfb9wB8P/nGDgSWgithBvpvVRe3VFGdyw=
Date:   Sun, 1 Dec 2019 10:48:14 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: new code for 5.5
Message-ID: <20191201184814.GA7335@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this set of new code for 5.5.  For this release, we changed
quite a few things.  Highlights:

- Fixed some long tail latency problems in the block allocator;
- Removed some long deprecated (and for the past several years no-op)
  mount options and ioctls;
- Strengthened the extended attribute and directory verifiers;
- Audited and fixed all the places where we could return EFSCORRUPTED
  without logging anything;
- Refactored the old SGI space allocation ioctls to make the equivalent
  fallocate calls;
- Fixed a race between fallocate and directio;
- Fixed an integer overflow when files have more than a few billion(!)
  extents;
- Fixed a longstanding bug where quota accounting could be incorrect
  when performing unwritten extent conversion on a freshly mounted fs;
- Fixed various complaints in scrub about soft lockups and
  unresponsiveness to signals;
- De-vtable'd the directory handling code, which should make it faster;
- Converted to the new mount api, for better or for worse;
- Cleaned up some memory leaks;

and quite a lot of other smaller fixes and cleanups.

The branch has survived several days of xfstests runs and merges cleanly
with this morning's master.  Please let me know if anything strange
happens.

FYI, Stephen Rothwell reported a merge conflict with the y2038 tree at
the end of October[1].  His resolution looked pretty straightforward,
though the current y2038 for-next branch no longer changes fs/ioctl.c
(and the changes that were in it are not in upstream master), so that
may not be necessary.

[1] https://lore.kernel.org/linux-xfs/20191030153046.01efae4a@canb.auug.org.au/

--D

The following changes since commit c039b99792726346ad46ff17c5a5bcb77a5edac4:

  iomap: use a srcmap for a read-modify-write I/O (2019-10-21 08:51:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.5-merge-16

for you to fetch changes up to 8feb4732ff9f2732354b44c4418569974e2f949c:

  xfs: allow parent directory scans to be interrupted with fatal signals (2019-11-27 08:23:14 -0800)

----------------------------------------------------------------
New code for 5.5:
- Fill out the build string
- Prevent inode fork extent count overflows
- Refactor the allocator to reduce long tail latency
- Rework incore log locking a little to reduce spinning
- Break up the xfs_iomap_begin functions into smaller more cohesive
parts
- Fix allocation alignment being dropped too early when the allocation
request is for more blocks than an AG is large
- Other small cleanups
- Clean up file buftarg retrieval helpers
- Hoist the resvsp and unresvsp ioctls to the vfs
- Remove the undocumented biosize mount option, since it has never been
  mentioned as existing or supported on linux
- Clean up some of the mount option printing and parsing
- Enhance attr leaf verifier to check block structure
- Check dirent and attr names for invalid characters before passing them
to the vfs
- Refactor open-coded bmbt walking
- Fix a few places where we return EIO instead of EFSCORRUPTED after
failing metadata sanity checks
- Fix a synchronization problem between fallocate and aio dio corrupting
the file length
- Clean up various loose ends in the iomap and bmap code
- Convert to the new mount api
- Make sure we always log something when returning EFSCORRUPTED
- Fix some problems where long running scrub loops could trigger soft
lockup warnings and/or fail to exit due to fatal signals pending
- Fix various Coverity complaints
- Remove most of the function pointers from the directory code to reduce
indirection penalties
- Ensure that dquots are attached to the inode when performing unwritten
extent conversion after io
- Deuglify incore projid and crtime types
- Fix another AGI/AGF locking order deadlock when renaming
- Clean up some quota typedefs
- Remove the FSSETDM ioctls which haven't done anything in 20 years
- Fix some memory leaks when mounting the log fails
- Fix an underflow when updating an xattr leaf freemap
- Remove some trivial wrappers
- Report metadata corruption as an error, not a (potentially) fatal
assertion
- Clean up the dir/attr buffer mapping code
- Allow fatal signals to kill scrub during parent pointer checks

----------------------------------------------------------------
Arnd Bergmann (1):
      xfs: avoid time_t in user api

Ben Dooks (Codethink) (1):
      xfs: add mising include of xfs_pnfs.h for missing declarations

Brian Foster (13):
      xfs: track active state of allocation btree cursors
      xfs: introduce allocation cursor data structure
      xfs: track allocation busy state in allocation cursor
      xfs: track best extent from cntbt lastblock scan in alloc cursor
      xfs: refactor cntbt lastblock scan best extent logic into helper
      xfs: reuse best extent tracking logic for bnobt scan
      xfs: refactor allocation tree fixup code
      xfs: refactor and reuse best extent scanning logic
      xfs: refactor near mode alloc bnobt scan into separate function
      xfs: factor out tree fixup logic into helper
      xfs: optimize near mode bnobt scans with concurrent cntbt lookups
      xfs: don't set bmapi total block req where minleft is
      xfs: fix attr leaf header freemap.size underflow

Carlos Maiolino (3):
      xfs: Remove slab init wrappers
      xfs: Remove kmem_zone_destroy() wrapper
      xfs: Remove kmem_zone_free() wrapper

Christoph Hellwig (112):
      xfs: ignore extent size hints for always COW inodes
      xfs: pass the correct flag to xlog_write_iclog
      xfs: remove the unused ic_io_size field from xlog_in_core
      xfs: move the locking from xlog_state_finish_copy to the callers
      xfs: call xlog_state_release_iclog with l_icloglock held
      xfs: remove dead ifdef XFSERRORDEBUG code
      xfs: remove the unused XLOG_STATE_ALL and XLOG_STATE_UNUSED flags
      xfs: turn ic_state into an enum
      xfs: remove the XLOG_STATE_DO_CALLBACK state
      xfs: also call xfs_file_iomap_end_delalloc for zeroing operations
      xfs: remove xfs_reflink_dirty_extents
      xfs: pass two imaps to xfs_reflink_allocate_cow
      xfs: refactor xfs_file_iomap_begin_delay
      xfs: fill out the srcmap in iomap_begin
      xfs: factor out a helper to calculate the end_fsb
      xfs: split out a new set of read-only iomap ops
      xfs: move xfs_file_iomap_begin_delay around
      xfs: split the iomap ops for buffered vs direct writes
      xfs: rename the whichfork variable in xfs_buffered_write_iomap_begin
      xfs: cleanup xfs_direct_write_iomap_begin
      xfs: improve the IOMAP_NOWAIT check for COW inodes
      xfs: mark xfs_buf_free static
      xfs: add a xfs_inode_buftarg helper
      xfs: use xfs_inode_buftarg in xfs_file_dio_aio_write
      xfs: use xfs_inode_buftarg in xfs_file_ioctl
      xfs: don't implement XFS_IOC_RESVSP / XFS_IOC_RESVSP64
      fs: add generic UNRESVSP and ZERO_RANGE ioctl handlers
      xfs: disable xfs_ioc_space for always COW inodes
      xfs: consolidate preallocation in xfs_file_fallocate
      xfs: simplify setting bio flags
      xfs: remove the dsunit and dswidth variables in
      xfs: cleanup calculating the stat optimal I/O size
      xfs: don't use a different allocsice for -o wsync
      xfs: remove the m_readio_* fields in struct xfs_mount
      xfs: rename the m_writeio_* fields in struct xfs_mount
      xfs: simplify parsing of allocsize mount option
      xfs: rename the XFS_MOUNT_DFLT_IOSIZE option to
      xfs: reverse the polarity of XFS_MOUNT_COMPAT_IOSIZE
      xfs: clean up printing the allocsize option in
      xfs: clean up printing inode32/64 in xfs_showargs
      xfs: merge xfs_showargs into xfs_fs_show_options
      xfs: simplify xfs_iomap_eof_align_last_fsb
      xfs: mark xfs_eof_alignment static
      xfs: remove the extsize argument to xfs_eof_alignment
      xfs: slightly tweak an assert in xfs_fs_map_blocks
      xfs: don't log the inode in xfs_fs_map_blocks if it
      xfs: simplify the xfs_iomap_write_direct calling
      xfs: refactor xfs_bmapi_allocate
      xfs: move extent zeroing to xfs_bmapi_allocate
      xfs: cleanup use of the XFS_ALLOC_ flags
      xfs: move incore structures out of xfs_da_format.h
      xfs: use unsigned int for all size values in struct xfs_da_geometry
      xfs: refactor btree node scrubbing
      xfs: devirtualize ->node_hdr_from_disk
      xfs: devirtualize ->node_hdr_to_disk
      xfs: add a btree entries pointer to struct xfs_da3_icnode_hdr
      xfs: move the node header size to struct xfs_da_geometry
      xfs: devirtualize ->leaf_hdr_from_disk
      xfs: devirtualize ->leaf_hdr_to_disk
      xfs: add an entries pointer to struct xfs_dir3_icleaf_hdr
      xfs: move the dir2 leaf header size to struct xfs_da_geometry
      xfs: move the max dir2 leaf entries count to struct xfs_da_geometry
      xfs: devirtualize ->free_hdr_from_disk
      xfs: devirtualize ->free_hdr_to_disk
      xfs: make the xfs_dir3_icfree_hdr available to xfs_dir2_node_addname_int
      xfs: add a bests pointer to struct xfs_dir3_icfree_hdr
      xfs: move the dir2 free header size to struct xfs_da_geometry
      xfs: move the max dir2 free bests count to struct xfs_da_geometry
      xfs: devirtualize ->db_to_fdb and ->db_to_fdindex
      xfs: devirtualize ->sf_get_parent_ino and ->sf_put_parent_ino
      xfs: devirtualize ->sf_entsize and ->sf_nextentry
      xfs: devirtualize ->sf_get_ino and ->sf_put_ino
      xfs: devirtualize ->sf_get_ftype and ->sf_put_ftype
      xfs: remove the unused ->data_first_entry_p method
      xfs: remove the data_dot_offset field in struct xfs_dir_ops
      xfs: remove the data_dotdot_offset field in struct xfs_dir_ops
      xfs: remove the ->data_dot_entry_p and ->data_dotdot_entry_p methods
      xfs: remove the ->data_unused_p method
      xfs: cleanup xfs_dir2_block_getdents
      xfs: cleanup xfs_dir2_leaf_getdents
      xfs: cleanup xchk_dir_rec
      xfs: cleanup xchk_directory_data_bestfree
      xfs: cleanup xfs_dir2_block_to_sf
      xfs: cleanup xfs_dir2_data_freescan_int
      xfs: cleanup __xfs_dir3_data_check
      xfs: remove the now unused ->data_entry_p method
      xfs: replace xfs_dir3_data_endp with xfs_dir3_data_end_offset
      xfs: devirtualize ->data_entsize
      xfs: devirtualize ->data_entry_tag_p
      xfs: move the dir2 data block fixed offsets to struct xfs_da_geometry
      xfs: cleanup xfs_dir2_data_entsize
      xfs: devirtualize ->data_bestfree_p
      xfs: devirtualize ->data_get_ftype and ->data_put_ftype
      xfs: remove the now unused dir ops infrastructure
      xfs: merge xfs_dir2_data_freescan and xfs_dir2_data_freescan_int
      xfs: always pass a valid hdr to xfs_dir3_leaf_check_int
      xfs: remove the unused m_chsize field
      xfs: devirtualize ->m_dirnameops
      xfs: use a struct timespec64 for the in-core crtime
      xfs: merge the projid fields in struct xfs_icdinode
      xfs: don't reset the "inode core" in xfs_iread
      xfs: remove XFS_IOC_FSSETDM and XFS_IOC_FSSETDM_BY_HANDLE
      xfs: simplify mappedbno handling in xfs_da_{get,read}_buf
      xfs: refactor xfs_dabuf_map
      xfs: improve the xfs_dabuf_map calling conventions
      xfs: remove the mappedbno argument to xfs_da_reada_buf
      xfs: remove the mappedbno argument to xfs_attr3_leaf_read
      xfs: remove the mappedbno argument to xfs_dir3_leaf_read
      xfs: remove the mappedbno argument to xfs_dir3_leafn_read
      xfs: split xfs_da3_node_read
      xfs: remove the mappedbno argument to xfs_da_read_buf
      xfs: remove the mappedbno argument to xfs_da_get_buf

Colin Ian King (1):
      xfs: remove redundant assignment to variable error

Dan Carpenter (1):
      xfs: remove a stray tab in xfs_remount_rw()

Darrick J. Wong (32):
      xfs: check attribute leaf block structure
      xfs: namecheck attribute names before listing them
      xfs: namecheck directory entry names before listing them
      xfs: replace -EIO with -EFSCORRUPTED for corrupt metadata
      xfs: refactor xfs_bmap_count_blocks using newer btree helpers
      xfs: refactor xfs_iread_extents to use xfs_btree_visit_blocks
      xfs: relax shortform directory size checks
      xfs: constify the buffer pointer arguments to error functions
      xfs: always log corruption errors
      xfs: decrease indenting problems in xfs_dabuf_map
      xfs: add missing assert in xfs_fsmap_owner_from_rmap
      xfs: make the assertion message functions take a mount parameter
      xfs: add missing early termination checks to record scrubbing functions
      xfs: periodically yield scrub threads to the scheduler
      xfs: fix missing header includes
      xfs: null out bma->prev if no previous extent
      xfs: "optimize" buffer item log segment bitmap setting
      xfs: range check ri_cnt when recovering log items
      xfs: annotate functions that trip static checker locking checks
      xfs: clean up weird while loop in xfs_alloc_ag_vextent_near
      xfs: refactor "does this fork map blocks" predicate
      xfs: convert EIO to EFSCORRUPTED when log contents are invalid
      xfs: actually check xfs_btree_check_block return in xfs_btree_islastblock
      xfs: attach dquots and reserve quota blocks during unwritten conversion
      xfs: attach dquots before performing xfs_swap_extents
      xfs: add a XFS_IS_CORRUPT macro
      xfs: kill the XFS_WANT_CORRUPT_* macros
      xfs: convert open coded corruption check to use XFS_IS_CORRUPT
      xfs: fix another missing include
      xfs: fix some memory leaks in log recovery
      xfs: report corruption only as a regular error
      xfs: allow parent directory scans to be interrupted with fatal signals

Dave Chinner (3):
      xfs: fix inode fork extent count overflow
      xfs: cap longest free extent to maximum allocatable
      xfs: properly serialise fallocate against AIO+DIO

Eric Sandeen (2):
      xfs: remove unused typedef definitions
      xfs: remove unused structure members & simple typedefs

Ian Kent (18):
      xfs: remove the biosize mount option
      xfs: remove unused struct xfs_mount field m_fsname_len
      xfs: use super s_id instead of struct xfs_mount m_fsname
      xfs: dont use XFS_IS_QUOTA_RUNNING() for option check
      xfs: use kmem functions for struct xfs_mount
      xfs: merge freeing of mp names and mp
      xfs: add xfs_remount_rw() helper
      xfs: add xfs_remount_ro() helper
      xfs: refactor suffix_kstrtoint()
      xfs: avoid redundant checks when options is empty
      xfs: refactor xfs_parseags()
      xfs: move xfs_parseargs() validation to a helper
      xfs: dont set sb in xfs_mount_alloc()
      xfs: switch to use the new mount-api
      xfs: move xfs_fc_reconfigure() above xfs_fc_free()
      xfs: move xfs_fc_get_tree() above xfs_fc_reconfigure()
      xfs: move xfs_fc_parse_param() above xfs_fc_get_tree()
      xfs: fold xfs_mount-alloc() into xfs_init_fs_context()

Jan Kara (1):
      xfs: Sanity check flags of Q_XQUOTARM call

Joe Perches (1):
      xfs: Correct comment tyops -> typos

Pavel Reichl (5):
      xfs: remove the xfs_disk_dquot_t and xfs_dquot_t
      xfs: remove the xfs_quotainfo_t typedef
      xfs: remove the xfs_dq_logitem_t typedef
      xfs: remove the xfs_qoff_logitem_t typedef
      xfs: Replace function declaration by actual definition

YueHaibing (1):
      xfs: remove duplicated include from xfs_dir2_data.c

kaixuxia (2):
      xfs: remove the duplicated inode log fieldmask set
      xfs: Fix deadlock between AGI and AGF when target_ip exists in xfs_rename()

yu kuai (1):
      xfs: include QUOTA, FATAL ASSERT build options in XFS_BUILD_OPTIONS

 fs/compat_ioctl.c               |   31 +-
 fs/ioctl.c                      |   12 +-
 fs/xfs/Makefile                 |    1 -
 fs/xfs/kmem.c                   |    2 +-
 fs/xfs/kmem.h                   |   30 -
 fs/xfs/libxfs/xfs_ag_resv.c     |    2 +
 fs/xfs/libxfs/xfs_alloc.c       | 1236 ++++++++++++++++++++-------------
 fs/xfs/libxfs/xfs_alloc.h       |   16 +-
 fs/xfs/libxfs/xfs_alloc_btree.c |    1 +
 fs/xfs/libxfs/xfs_attr.c        |   24 +-
 fs/xfs/libxfs/xfs_attr_leaf.c   |  134 +++-
 fs/xfs/libxfs/xfs_attr_leaf.h   |   30 +-
 fs/xfs/libxfs/xfs_attr_remote.c |    1 +
 fs/xfs/libxfs/xfs_bit.c         |    1 +
 fs/xfs/libxfs/xfs_bmap.c        |  686 ++++++++++--------
 fs/xfs/libxfs/xfs_btree.c       |   97 +--
 fs/xfs/libxfs/xfs_btree.h       |   37 +-
 fs/xfs/libxfs/xfs_da_btree.c    |  668 +++++++++---------
 fs/xfs/libxfs/xfs_da_btree.h    |   73 +-
 fs/xfs/libxfs/xfs_da_format.c   |  888 ------------------------
 fs/xfs/libxfs/xfs_da_format.h   |   59 +-
 fs/xfs/libxfs/xfs_dir2.c        |   72 +-
 fs/xfs/libxfs/xfs_dir2.h        |   90 +--
 fs/xfs/libxfs/xfs_dir2_block.c  |  131 ++--
 fs/xfs/libxfs/xfs_dir2_data.c   |  282 ++++----
 fs/xfs/libxfs/xfs_dir2_leaf.c   |  307 ++++----
 fs/xfs/libxfs/xfs_dir2_node.c   |  431 ++++++------
 fs/xfs/libxfs/xfs_dir2_priv.h   |  114 ++-
 fs/xfs/libxfs/xfs_dir2_sf.c     |  424 ++++++-----
 fs/xfs/libxfs/xfs_dquot_buf.c   |    8 +-
 fs/xfs/libxfs/xfs_format.h      |   14 +-
 fs/xfs/libxfs/xfs_fs.h          |    4 +-
 fs/xfs/libxfs/xfs_ialloc.c      |  117 +++-
 fs/xfs/libxfs/xfs_iext_tree.c   |    2 +-
 fs/xfs/libxfs/xfs_inode_buf.c   |   21 +-
 fs/xfs/libxfs/xfs_inode_buf.h   |    5 +-
 fs/xfs/libxfs/xfs_inode_fork.c  |   22 +-
 fs/xfs/libxfs/xfs_inode_fork.h  |   18 +-
 fs/xfs/libxfs/xfs_log_format.h  |    4 +-
 fs/xfs/libxfs/xfs_log_recover.h |    4 +-
 fs/xfs/libxfs/xfs_refcount.c    |  174 +++--
 fs/xfs/libxfs/xfs_rmap.c        |  377 +++++++---
 fs/xfs/libxfs/xfs_rtbitmap.c    |    4 +-
 fs/xfs/libxfs/xfs_sb.c          |    1 +
 fs/xfs/libxfs/xfs_trans_inode.c |    8 +-
 fs/xfs/libxfs/xfs_trans_resv.c  |    6 +-
 fs/xfs/libxfs/xfs_types.h       |    2 -
 fs/xfs/scrub/attr.c             |   11 +-
 fs/xfs/scrub/bitmap.c           |    3 +-
 fs/xfs/scrub/common.h           |    9 +-
 fs/xfs/scrub/dabtree.c          |   62 +-
 fs/xfs/scrub/dabtree.h          |    3 +-
 fs/xfs/scrub/dir.c              |  132 ++--
 fs/xfs/scrub/fscounters.c       |    8 +-
 fs/xfs/scrub/health.c           |    1 +
 fs/xfs/scrub/parent.c           |   27 +-
 fs/xfs/scrub/quota.c            |    7 +
 fs/xfs/scrub/scrub.c            |    1 +
 fs/xfs/xfs_acl.c                |   18 +-
 fs/xfs/xfs_aops.c               |   43 +-
 fs/xfs/xfs_aops.h               |    3 -
 fs/xfs/xfs_attr_inactive.c      |   76 +-
 fs/xfs/xfs_attr_list.c          |   75 +-
 fs/xfs/xfs_bmap_item.c          |   11 +-
 fs/xfs/xfs_bmap_util.c          |  255 ++-----
 fs/xfs/xfs_bmap_util.h          |    4 -
 fs/xfs/xfs_buf.c                |   32 +-
 fs/xfs/xfs_buf.h                |    1 -
 fs/xfs/xfs_buf_item.c           |    6 +-
 fs/xfs/xfs_dir2_readdir.c       |  137 ++--
 fs/xfs/xfs_discard.c            |    6 +-
 fs/xfs/xfs_dquot.c              |   46 +-
 fs/xfs/xfs_dquot.h              |   98 +--
 fs/xfs/xfs_dquot_item.h         |   34 +-
 fs/xfs/xfs_error.c              |   31 +-
 fs/xfs/xfs_error.h              |   33 +-
 fs/xfs/xfs_extent_busy.c        |    2 +-
 fs/xfs/xfs_extfree_item.c       |    9 +-
 fs/xfs/xfs_file.c               |  104 ++-
 fs/xfs/xfs_filestream.c         |    3 +-
 fs/xfs/xfs_fsmap.c              |    1 +
 fs/xfs/xfs_icache.c             |    8 +-
 fs/xfs/xfs_icreate_item.c       |    2 +-
 fs/xfs/xfs_inode.c              |   48 +-
 fs/xfs/xfs_inode.h              |   31 +-
 fs/xfs/xfs_inode_item.c         |   15 +-
 fs/xfs/xfs_ioctl.c              |  203 +-----
 fs/xfs/xfs_ioctl.h              |    7 -
 fs/xfs/xfs_ioctl32.c            |   49 +-
 fs/xfs/xfs_ioctl32.h            |   13 +-
 fs/xfs/xfs_iomap.c              |  862 ++++++++++++-----------
 fs/xfs/xfs_iomap.h              |   11 +-
 fs/xfs/xfs_iops.c               |   70 +-
 fs/xfs/xfs_itable.c             |    6 +-
 fs/xfs/xfs_iwalk.c              |    3 +-
 fs/xfs/xfs_linux.h              |   14 +-
 fs/xfs/xfs_log.c                |  434 +++++-------
 fs/xfs/xfs_log_cil.c            |    6 +-
 fs/xfs/xfs_log_priv.h           |   33 +-
 fs/xfs/xfs_log_recover.c        |  148 ++--
 fs/xfs/xfs_message.c            |   22 +-
 fs/xfs/xfs_message.h            |    6 +-
 fs/xfs/xfs_mount.c              |   58 +-
 fs/xfs/xfs_mount.h              |   57 +-
 fs/xfs/xfs_pnfs.c               |   56 +-
 fs/xfs/xfs_qm.c                 |   67 +-
 fs/xfs/xfs_qm.h                 |    6 +-
 fs/xfs/xfs_qm_bhv.c             |    8 +-
 fs/xfs/xfs_qm_syscalls.c        |  139 ++--
 fs/xfs/xfs_quotaops.c           |    3 +
 fs/xfs/xfs_refcount_item.c      |    9 +-
 fs/xfs/xfs_reflink.c            |  138 +---
 fs/xfs/xfs_reflink.h            |    4 +-
 fs/xfs/xfs_rmap_item.c          |   13 +-
 fs/xfs/xfs_rtalloc.c            |    3 +-
 fs/xfs/xfs_super.c              | 1466 +++++++++++++++++++--------------------
 fs/xfs/xfs_super.h              |   10 +
 fs/xfs/xfs_symlink.c            |    1 +
 fs/xfs/xfs_symlink.h            |    2 +-
 fs/xfs/xfs_trace.h              |   35 +-
 fs/xfs/xfs_trans.c              |    2 +-
 fs/xfs/xfs_trans_ail.c          |   10 +-
 fs/xfs/xfs_trans_dquot.c        |   56 +-
 fs/xfs/xfs_xattr.c              |    1 +
 include/linux/falloc.h          |    3 +
 include/linux/fs.h              |    2 +-
 126 files changed, 5833 insertions(+), 6270 deletions(-)
 delete mode 100644 fs/xfs/libxfs/xfs_da_format.c
