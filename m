Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D5F1EBFF2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jun 2020 18:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgFBQ0q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 12:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbgFBQ0q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 12:26:46 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0694206C3;
        Tue,  2 Jun 2020 16:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591115204;
        bh=3/le4j93lulevphUTItA/BquMCkwRnK3iz2LOiB4lSk=;
        h=Date:From:To:Cc:Subject:From;
        b=OuiMzPBh5bC+wyJc16TyZAifpzqZXpXnalT4hsHqbi+90nhlDTrRcZUsklGE8CYTr
         6bTIPo+S+UeMhUWjFwgLsST6rUXIB4uv472DKuRlU2hXzNvZBYDRxyOkwEtDl/vz/l
         FHgt79ndrZC1ud95tmHOtXL5V3whU48h1geh+UjM=
Date:   Tue, 2 Jun 2020 09:26:44 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: new code for 5.8 (now with fixed To line)
Message-ID: <20200602162644.GE8204@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sorry Linus, I totally FUBARed the addressing on the pull request.
Resending directly to you so that it doesn't get lost in the spam
folder.

--D

---

Hi Linus,

Please pull the new XFS code for 5.8.  Most of the changes this cycle
are refactoring of existing code in preparation for things landing in
the future.  We also fixed various problems and deficiencies in the
quota implementation, and (I hope) the last of the stale read vectors by
forcing write allocations to go through the unwritten state until the
write completes.

This branch merges cleanly with master as of a few minutes ago, so
please let me know if anything strange happens.  I anticipate a second
pull request next week for a DAX-related restructuring that requires the
DAX branch (sent separately).

--D

The following changes since commit 0e698dfa282211e414076f9dc7e83c1c288314fd:

  Linux 5.7-rc4 (2020-05-03 14:56:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.8-merge-8

for you to fetch changes up to 6dcde60efd946e38fac8d276a6ca47492103e856:

  xfs: more lockdep whackamole with kmem_alloc* (2020-05-27 08:49:28 -0700)

----------------------------------------------------------------
New code for 5.8:
    - Various cleanups to remove dead code, unnecessary conditionals,
      asserts, etc.
    - Fix a linker warning caused by xfs stuffing '-g' into CFLAGS
      redundantly.
    - Tighten up our dmesg logging to ensure that everything is prefixed
      with 'XFS' for easier grepping.
    - Kill a bunch of typedefs.
    - Refactor the deferred ops code to reduce indirect function calls.
    - Increase type-safety with the deferred ops code.
    - Make the DAX mount options a tri-state.
    - Fix some error handling problems in the inode flush code and clean up
      other inode flush warts.
    - Refactor log recovery so that each log item recovery functions now live
      with the other log item processing code.
    - Fix some SPDX forms.
    - Fix quota counter corruption if the fs crashes after running
      quotacheck but before any dquots get logged.
    - Don't fail metadata verification on zero-entry attr leaf blocks, since
      they're just part of the disk format now due to a historic lack of log
      atomicity.
    - Don't allow SWAPEXT between files with different [ugp]id when quotas
      are enabled.
    - Refactor inode fork reading and verification to run directly from the
      inode-from-disk function.  This means that we now actually guarantee
      that _iget'ted inodes are totally verified and ready to go.
    - Move the incore inode fork format and extent counts to the ifork
      structure.
    - Scalability improvements by reducing cacheline pingponging in
      struct xfs_mount.
    - More scalability improvements by removing m_active_trans from the
      hot path.
    - Fix inode counter update sanity checking to run /only/ on debug
      kernels.
    - Fix longstanding inconsistency in what error code we return when a
      program hits project quota limits (ENOSPC).
    - Fix group quota returning the wrong error code when a program hits
      group quota limits.
    - Fix per-type quota limits and grace periods for group and project
      quotas so that they actually work.
    - Allow extension of individual grace periods.
    - Refactor the non-reclaim inode radix tree walking code to remove a
      bunch of stupid little functions and straighten out the
      inconsistent naming schemes.
    - Fix a bug in speculative preallocation where we measured a new
      allocation based on the last extent mapping in the file instead of
      looking farther for the last contiguous space allocation.
    - Force delalloc writes to unwritten extents.  This closes a
      stale disk contents exposure vector if the system goes down before
      the write completes.
    - More lockdep whackamole.

----------------------------------------------------------------
Arnd Bergmann (1):
      xfs: stop CONFIG_XFS_DEBUG from changing compiler flags

Brian Foster (19):
      xfs: refactor failed buffer resubmission into xfsaild
      xfs: factor out buffer I/O failure code
      xfs: simplify inode flush error handling
      xfs: remove unnecessary shutdown check from xfs_iflush()
      xfs: reset buffer write failure state on successful completion
      xfs: refactor ratelimited buffer error messages into helper
      xfs: ratelimit unmount time per-buffer I/O error alert
      xfs: fix duplicate verification from xfs_qm_dqflush()
      xfs: abort consistently on dquot flush failure
      xfs: acquire ->ail_lock from xfs_trans_ail_delete()
      xfs: use delete helper for items expected to be in AIL
      xfs: drop unused shutdown parameter from xfs_trans_ail_remove()
      xfs: combine xfs_trans_ail_[remove|delete]()
      xfs: remove unused iflush stale parameter
      xfs: random buffer write failure errortag
      xfs: remove unused shutdown types
      xfs: remove unused iget_flags param from xfs_imap_to_bp()
      xfs: fix unused variable warning in buffer completion on !DEBUG
      xfs: don't fail verifier on empty attr3 leaf block

Chen Zhou (1):
      xfs: remove duplicate headers

Christoph Hellwig (33):
      xfs: refactor the buffer cancellation table helpers
      xfs: rename inode_list xlog_recover_reorder_trans
      xfs: factor out a xlog_buf_readahead helper
      xfs: simplify xlog_recover_inode_ra_pass2
      xfs: refactor xlog_recover_buffer_pass1
      xfs: remove the xfs_efi_log_item_t typedef
      xfs: remove the xfs_efd_log_item_t typedef
      xfs: remove the xfs_inode_log_item_t typedef
      xfs: factor out a xfs_defer_create_intent helper
      xfs: merge the ->log_item defer op into ->create_intent
      xfs: merge the ->diff_items defer op into ->create_intent
      xfs: turn dfp_intent into a xfs_log_item
      xfs: refactor xfs_defer_finish_noroll
      xfs: turn dfp_done into a xfs_log_item
      xfs: use a xfs_btree_cur for the ->finish_cleanup state
      xfs: spell out the parameter name for ->cancel_item
      xfs: xfs_bmapi_read doesn't take a fork id as the last argument
      xfs: call xfs_iformat_fork from xfs_inode_from_disk
      xfs: split xfs_iformat_fork
      xfs: handle unallocated inodes in xfs_inode_from_disk
      xfs: call xfs_dinode_verify from xfs_inode_from_disk
      xfs: don't reset i_delayed_blks in xfs_iread
      xfs: remove xfs_iread
      xfs: remove xfs_ifork_ops
      xfs: refactor xfs_inode_verify_forks
      xfs: improve local fork verification
      xfs: remove the special COW fork handling in xfs_bmapi_read
      xfs: remove the NULL fork handling in xfs_bmapi_read
      xfs: remove the XFS_DFORK_Q macro
      xfs: remove xfs_ifree_local_data
      xfs: move the per-fork nextents fields into struct xfs_ifork
      xfs: move the fork format fields into struct xfs_ifork
      xfs: cleanup xfs_idestroy_fork

Darrick J. Wong (47):
      xfs: report unrecognized log item type codes during recovery
      xfs: clean up the error handling in xfs_swap_extents
      xfs: convert xfs_log_recover_item_t to struct xfs_log_recover_item
      xfs: refactor log recovery item sorting into a generic dispatch structure
      xfs: refactor log recovery item dispatch for pass2 readhead functions
      xfs: refactor log recovery item dispatch for pass1 commit functions
      xfs: refactor log recovery buffer item dispatch for pass2 commit functions
      xfs: refactor log recovery inode item dispatch for pass2 commit functions
      xfs: refactor log recovery dquot item dispatch for pass2 commit functions
      xfs: refactor log recovery icreate item dispatch for pass2 commit functions
      xfs: refactor log recovery EFI item dispatch for pass2 commit functions
      xfs: refactor log recovery RUI item dispatch for pass2 commit functions
      xfs: refactor log recovery CUI item dispatch for pass2 commit functions
      xfs: refactor log recovery BUI item dispatch for pass2 commit functions
      xfs: remove log recovery quotaoff item dispatch for pass2 commit functions
      xfs: refactor recovered EFI log item playback
      xfs: refactor recovered RUI log item playback
      xfs: refactor recovered CUI log item playback
      xfs: refactor recovered BUI log item playback
      xfs: refactor xlog_item_is_intent now that we're done converting
      xfs: refactor releasing finished intents during log recovery
      xfs: refactor adding recovered intent items to the log
      xfs: refactor intent item RECOVERED flag into the log item
      xfs: refactor intent item iop_recover calls
      xfs: hoist setting of XFS_LI_RECOVERED to caller
      xfs: move log recovery buffer cancellation code to xfs_buf_item_recover.c
      xfs: remove unnecessary includes from xfs_log_recover.c
      xfs: use ordered buffers to initialize dquot buffers during quotacheck
      xfs: don't allow SWAPEXT if we'd screw up quota accounting
      xfs: clean up xchk_bmap_check_rmaps usage of XFS_IFORK_Q
      xfs: move eofblocks conversion function to xfs_ioctl.c
      xfs: replace open-coded XFS_ICI_NO_TAG
      xfs: remove unused xfs_inode_ag_iterator function
      xfs: remove xfs_inode_ag_iterator_flags
      xfs: remove flags argument from xfs_inode_ag_walk
      xfs: remove __xfs_icache_free_eofblocks
      xfs: refactor eofb matching into a single helper
      xfs: fix inode ag walk predicate function return values
      xfs: use bool for done in xfs_inode_ag_walk
      xfs: move xfs_inode_ag_iterator to be closer to the perag walking code
      xfs: straighten out all the naming around incore inode tree walks
      xfs: rearrange xfs_inode_walk_ag parameters
      xfs: don't fail unwritten extent conversion on writeback due to edquot
      xfs: measure all contiguous previous extents for prealloc size
      xfs: refactor xfs_iomap_prealloc_size
      xfs: force writes to delalloc regions to unwritten
      xfs: more lockdep whackamole with kmem_alloc*

Dave Chinner (4):
      xfs: gut error handling in xfs_trans_unreserve_and_mod_sb()
      xfs: reduce free inode accounting overhead
      xfs: separate read-only variables in struct xfs_mount
      xfs: remove the m_active_trans counter

Eric Sandeen (8):
      xfs: define printk_once variants for xfs messages
      xfs: group quota should return EDQUOT when prj quota enabled
      xfs: always return -ENOSPC on project quota reservation failure
      xfs: fix up some whitespace in quota code
      xfs: pass xfs_dquot to xfs_qm_adjust_dqtimers
      xfs: switch xfs_get_defquota to take explicit type
      xfs: per-type quota timers and warn limits
      xfs: allow individual quota grace period extension

Gustavo A. R. Silva (1):
      xfs: Replace zero-length array with flexible-array

Ira Weiny (5):
      fs/xfs: Remove unnecessary initialization of i_rwsem
      fs/xfs: Change XFS_MOUNT_DAX to XFS_MOUNT_DAX_ALWAYS
      fs/xfs: Make DAX mount option a tri-state
      fs/xfs: Create function xfs_inode_should_enable_dax()
      fs/xfs: Combine xfs_diflags_to_linux() and xfs_diflags_to_iflags()

Kaixu Xia (8):
      xfs: trace quota allocations for all quota types
      xfs: combine two if statements with same condition
      xfs: reserve quota inode transaction space only when needed
      xfs: remove unnecessary variable udqp from xfs_ioctl_setattr
      xfs: remove unnecessary assertion from xfs_qm_vop_create_dqattach
      xfs: simplify the flags setting in xfs_qm_scall_quotaon
      xfs: remove unnecessary check of the variable resblks in xfs_symlink
      xfs: fix the warning message in xfs_validate_sb_common()

Nishad Kamdar (1):
      xfs: Use the correct style for SPDX License Identifier

Zheng Bin (1):
      xfs: ensure f_bfree returned by statfs() is non-negative

 .../filesystems/xfs-self-describing-metadata.txt   |   10 +-
 fs/xfs/Makefile                                    |    5 +-
 fs/xfs/kmem.h                                      |    8 +-
 fs/xfs/libxfs/xfs_ag_resv.h                        |    2 +-
 fs/xfs/libxfs/xfs_alloc.h                          |    2 +-
 fs/xfs/libxfs/xfs_alloc_btree.h                    |    2 +-
 fs/xfs/libxfs/xfs_attr.c                           |   16 +-
 fs/xfs/libxfs/xfs_attr.h                           |    2 +-
 fs/xfs/libxfs/xfs_attr_leaf.c                      |   59 +-
 fs/xfs/libxfs/xfs_attr_leaf.h                      |    2 +-
 fs/xfs/libxfs/xfs_attr_remote.h                    |    2 +-
 fs/xfs/libxfs/xfs_attr_sf.h                        |    2 +-
 fs/xfs/libxfs/xfs_bit.h                            |    2 +-
 fs/xfs/libxfs/xfs_bmap.c                           |  310 +--
 fs/xfs/libxfs/xfs_bmap.h                           |    2 +-
 fs/xfs/libxfs/xfs_bmap_btree.c                     |    5 +-
 fs/xfs/libxfs/xfs_bmap_btree.h                     |    2 +-
 fs/xfs/libxfs/xfs_btree.h                          |    2 +-
 fs/xfs/libxfs/xfs_da_btree.h                       |    2 +-
 fs/xfs/libxfs/xfs_da_format.h                      |    2 +-
 fs/xfs/libxfs/xfs_defer.c                          |  162 +-
 fs/xfs/libxfs/xfs_defer.h                          |   26 +-
 fs/xfs/libxfs/xfs_dir2.c                           |    8 +-
 fs/xfs/libxfs/xfs_dir2.h                           |    2 +-
 fs/xfs/libxfs/xfs_dir2_block.c                     |    2 +-
 fs/xfs/libxfs/xfs_dir2_priv.h                      |    2 +-
 fs/xfs/libxfs/xfs_dir2_sf.c                        |   13 +-
 fs/xfs/libxfs/xfs_errortag.h                       |    6 +-
 fs/xfs/libxfs/xfs_format.h                         |    9 +-
 fs/xfs/libxfs/xfs_fs.h                             |    2 +-
 fs/xfs/libxfs/xfs_health.h                         |    2 +-
 fs/xfs/libxfs/xfs_inode_buf.c                      |  186 +-
 fs/xfs/libxfs/xfs_inode_buf.h                      |   10 +-
 fs/xfs/libxfs/xfs_inode_fork.c                     |  320 ++-
 fs/xfs/libxfs/xfs_inode_fork.h                     |   68 +-
 fs/xfs/libxfs/xfs_log_recover.h                    |   83 +-
 fs/xfs/libxfs/xfs_quota_defs.h                     |    1 -
 fs/xfs/libxfs/xfs_rtbitmap.c                       |    2 +-
 fs/xfs/libxfs/xfs_sb.c                             |    2 +-
 fs/xfs/libxfs/xfs_symlink_remote.c                 |   14 +-
 fs/xfs/libxfs/xfs_trans_inode.c                    |    2 +-
 fs/xfs/scrub/bmap.c                                |   40 +-
 fs/xfs/scrub/dabtree.c                             |    2 +-
 fs/xfs/scrub/dir.c                                 |    7 +-
 fs/xfs/scrub/ialloc.c                              |    3 +-
 fs/xfs/scrub/parent.c                              |    2 +-
 fs/xfs/xfs_aops.c                                  |    2 +-
 fs/xfs/xfs_attr_inactive.c                         |    9 +-
 fs/xfs/xfs_attr_list.c                             |    4 +-
 fs/xfs/xfs_bmap_item.c                             |  237 +-
 fs/xfs/xfs_bmap_item.h                             |   11 -
 fs/xfs/xfs_bmap_util.c                             |   79 +-
 fs/xfs/xfs_buf.c                                   |   70 +-
 fs/xfs/xfs_buf.h                                   |    2 +
 fs/xfs/xfs_buf_item.c                              |  106 +-
 fs/xfs/xfs_buf_item.h                              |    2 -
 fs/xfs/xfs_buf_item_recover.c                      |  984 ++++++++
 fs/xfs/xfs_dir2_readdir.c                          |    2 +-
 fs/xfs/xfs_dquot.c                                 |  118 +-
 fs/xfs/xfs_dquot.h                                 |    2 +-
 fs/xfs/xfs_dquot_item.c                            |   17 +-
 fs/xfs/xfs_dquot_item_recover.c                    |  201 ++
 fs/xfs/xfs_error.c                                 |    3 +
 fs/xfs/xfs_extfree_item.c                          |  216 +-
 fs/xfs/xfs_extfree_item.h                          |   25 +-
 fs/xfs/xfs_file.c                                  |    2 +-
 fs/xfs/xfs_fsops.c                                 |    5 +-
 fs/xfs/xfs_icache.c                                |  341 ++-
 fs/xfs/xfs_icache.h                                |   51 +-
 fs/xfs/xfs_icreate_item.c                          |  152 ++
 fs/xfs/xfs_inode.c                                 |  263 +-
 fs/xfs/xfs_inode.h                                 |    6 +-
 fs/xfs/xfs_inode_item.c                            |   54 +-
 fs/xfs/xfs_inode_item.h                            |    6 +-
 fs/xfs/xfs_inode_item_recover.c                    |  394 +++
 fs/xfs/xfs_ioctl.c                                 |  100 +-
 fs/xfs/xfs_iomap.c                                 |  113 +-
 fs/xfs/xfs_iops.c                                  |   77 +-
 fs/xfs/xfs_itable.c                                |    6 +-
 fs/xfs/xfs_log_recover.c                           | 2561 ++------------------
 fs/xfs/xfs_message.c                               |   22 +
 fs/xfs/xfs_message.h                               |   24 +-
 fs/xfs/xfs_mount.c                                 |   40 +-
 fs/xfs/xfs_mount.h                                 |  157 +-
 fs/xfs/xfs_pnfs.c                                  |    5 +-
 fs/xfs/xfs_qm.c                                    |   66 +-
 fs/xfs/xfs_qm.h                                    |   78 +-
 fs/xfs/xfs_qm_syscalls.c                           |   83 +-
 fs/xfs/xfs_quotaops.c                              |   30 +-
 fs/xfs/xfs_refcount_item.c                         |  252 +-
 fs/xfs/xfs_refcount_item.h                         |   11 -
 fs/xfs/xfs_rmap_item.c                             |  229 +-
 fs/xfs/xfs_rmap_item.h                             |   13 -
 fs/xfs/xfs_super.c                                 |   68 +-
 fs/xfs/xfs_symlink.c                               |   10 +-
 fs/xfs/xfs_trace.h                                 |    4 +-
 fs/xfs/xfs_trans.c                                 |  203 +-
 fs/xfs/xfs_trans.h                                 |    6 +-
 fs/xfs/xfs_trans_ail.c                             |   79 +-
 fs/xfs/xfs_trans_dquot.c                           |   23 +-
 fs/xfs/xfs_trans_priv.h                            |   21 +-
 fs/xfs/xfs_xattr.c                                 |    1 -
 102 files changed, 4244 insertions(+), 4817 deletions(-)
 create mode 100644 fs/xfs/xfs_buf_item_recover.c
 create mode 100644 fs/xfs/xfs_dquot_item_recover.c
 create mode 100644 fs/xfs/xfs_inode_item_recover.c

----- End forwarded message -----
