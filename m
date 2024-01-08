Return-Path: <linux-fsdevel+bounces-7521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A0182680C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 07:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4313E1F21AC9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 06:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36E48827;
	Mon,  8 Jan 2024 06:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uiFT3Pzl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428E479C2;
	Mon,  8 Jan 2024 06:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9001C433C8;
	Mon,  8 Jan 2024 06:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704695675;
	bh=we4QgASfZn7Yzt4Yd7Uz3nioWAnTSp9XSQ9/4YxUJvU=;
	h=From:To:Cc:Subject:Date:From;
	b=uiFT3PzlaCkRiLGFYG4WiebzrgZfaMYkEFU4j3Soth6pf95wyLVsx2+VQVuDzkT0S
	 Vfn60Q1wYTWE5JbQToW4oQM4f0p8vUQ8WxYtm8mguo52qJYXWHaKmNki1Aaat3S+0v
	 HhweQIjTou1RKIpvDhN3LwwLP9kMqkoS7mnjw2Iz40be10fSsGJ2bJXq59onG2wZwg
	 XrjPtgxME6hBiRU68cQEwdhBJX434PP1LXl4M91FY95JXrCWfBeCskbG2oQNXrDZtl
	 FqgpjEEQ+7zYYb7tgZXHDGwpl6HjTh6q8Gy4GVwZ4hmzZkqjdETSP+aMOhl7WABjXN
	 9lMUh82o2tIpw==
User-agent: mu4e 1.10.8; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: torvalds@linux-foundation.org
Cc: bagasdotme@gmail.com,bodonnel@redhat.com,chandanbabu@kernel.org,cmaiolino@redhat.com,dan.j.williams@intel.com,david@fromorbit.com,dchinner@redhat.com,djwong@kernel.org,glider@google.com,hch@lst.de,leo.lilong@huawei.com,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org,oliver.sang@intel.com,ruansy.fnst@fujitsu.com,sandeen@redhat.com,wangjinchao@xfusion.com,zhangjiachen.jaycee@bytedance.com,zhangtianci.1997@bytedance.com
Subject: [GIT PULL] xfs: new code for 6.8
Date: Mon, 08 Jan 2024 11:35:39 +0530
Message-ID: <87jzok72py.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Linus,

Please pull this branch with changes for xfs for 6.8-rc1.

Online repair functionality continues to be expanded. Please refer to the
section "New code for 6.8" for a brief description of changes added to Online
repair.

A new memory failure flag (MF_MEM_PRE_REMOVE) is introduced. This will be used
to notify tasks when a pmem device is removed.

The remaining changes are limited to bug fixes and cleanups.

I did a test-merge with the main upstream branch as of a few minutes ago and
didn't see any conflicts.  Please let me know if you encounter any problems.

The following changes since commit 33cc938e65a98f1d29d0a18403dbbee050dcad9a:

  Linux 6.7-rc4 (2023-12-03 18:52:56 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.8-merge-3

for you to fetch changes up to bcdfae6ee520b665385020fa3e47633a8af84f12:

  xfs: use the op name in trace_xlog_intent_recovery_failed (2023-12-29 13:37:05 +0530)

----------------------------------------------------------------
New code for 6.8:

  * New features/functionality
    * Online repair
      * Reserve disk space for online repairs.
      * Fix misinteraction between the AIL and btree bulkloader because of
        which the bulk load fails to queue a buffer for writeback if it
        happens to be on the AIL list.
      * Prevent transaction reservation overflows when reaping blocks during
        online repair.
      * Whenever possible, bulkloader now copies multiple records into a
        block.
      * Support repairing of
        1. Per-AG free space, inode and refcount btrees.
	2. Ondisk inodes.
	3. File data and attribute fork mappings.
      * Verify the contents of
        1. Inode and data fork of realtime bitmap file.
	2. Quota files.
    * Introduce MF_MEM_PRE_REMOVE. This will be used to notify tasks about
      a pmem device being removed.

  * Bug fixes
    * Fix memory leak of recovered attri intent items.
    * Fix UAF during log intent recovery.
    * Fix realtime geometry integer overflows.
    * Prevent scrub from live locking in xchk_iget.
    * Prevent fs shutdown when removing files during low free disk space.
    * Prevent transaction reservation overflow when extending an RT device.
    * Prevent incorrect warning from being printed when extending a
      filesystem.
    * Fix an off-by-one error in xreap_agextent_binval.
    * Serialize access to perag radix tree during deletion operation.
    * Fix perag memory leak during growfs.
    * Allow allocation of minlen realtime extent when the maximum sized
      realtime free extent is minlen in size.

  * Cleanups
    * Remove duplicate boilerplate code spread across functionality associated
      with different log items.
    * Cleanup resblks interfaces.
    * Pass defer ops pointer to defer helpers instead of an enum.
    * Initialize di_crc in xfs_log_dinode to prevent KMSAN warnings.
    * Use static_assert() instead of BUILD_BUG_ON_MSG() to validate size of
      structures and structure member offsets. This is done in order to be
      able to share the code with userspace.
    * Move XFS documentation under a new directory specific to XFS.
    * Do not invoke deferred ops' ->create_done callback if the deferred
      operation does not have an intent item associated with it.
    * Remove duplicate inclusion of header files from scrub/health.c.
    * Refactor Realtime code.
    * Cleanup attr code.

Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>

----------------------------------------------------------------
Bagas Sanjaya (1):
      Documentation: xfs: consolidate XFS docs into its own subdirectory

Chandan Babu R (13):
      Merge tag 'reconstruct-defer-work-6.8_2023-12-06' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.8-mergeA
      Merge tag 'reconstruct-defer-cleanups-6.8_2023-12-06' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.8-mergeA
      Merge tag 'fix-rtmount-overflows-6.8_2023-12-06' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.8-mergeA
      Merge tag 'defer-elide-create-done-6.8_2023-12-06' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.8-mergeA
      Merge tag 'scrub-livelock-prevention-6.8_2023-12-06' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.8-mergeA
      Merge tag 'repair-auto-reap-space-reservations-6.8_2023-12-06' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.8-mergeA
      Merge tag 'fix-growfsrt-failures-6.8_2023-12-13' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.8-mergeB
      Merge tag 'repair-prep-for-bulk-loading-6.8_2023-12-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.8-mergeB
      Merge tag 'repair-ag-btrees-6.8_2023-12-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.8-mergeB
      Merge tag 'repair-inodes-6.8_2023-12-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.8-mergeB
      Merge tag 'repair-file-mappings-6.8_2023-12-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.8-mergeB
      Merge tag 'repair-rtbitmap-6.8_2023-12-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.8-mergeB
      Merge tag 'repair-quota-6.8_2023-12-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.8-mergeB

Christoph Hellwig (43):
      xfs: clean up the XFS_IOC_{GS}ET_RESBLKS handler
      xfs: clean up the XFS_IOC_FSCOUNTS handler
      xfs: clean up the xfs_reserve_blocks interface
      xfs: clean up xfs_fsops.h
      xfs: use static_assert to check struct sizes and offsets
      xfs: move xfs_ondisk.h to libxfs/
      xfs: consolidate the xfs_attr_defer_* helpers
      xfs: move xfs_attr_defer_type up in xfs_attr_item.c
      xfs: store an ops pointer in struct xfs_defer_pending
      xfs: pass the defer ops instead of type to xfs_defer_start_recovery
      xfs: pass the defer ops directly to xfs_defer_add
      xfs: consider minlen sized extents in xfs_rtallocate_extent_block
      xfs: turn the xfs_trans_mod_dquot_byino stub into an inline function
      xfs: remove the xfs_alloc_arg argument to xfs_bmap_btalloc_accounting
      xfs: also use xfs_bmap_btalloc_accounting for RT allocations
      xfs: move xfs_bmap_rtalloc to xfs_rtalloc.c
      xfs: return -ENOSPC from xfs_rtallocate_*
      xfs: reflow the tail end of xfs_bmap_rtalloc
      xfs: indicate if xfs_bmap_adjacent changed ap->blkno
      xfs: cleanup picking the start extent hint in xfs_bmap_rtalloc
      xfs: move xfs_rtget_summary to xfs_rtbitmap.c
      xfs: split xfs_rtmodify_summary_int
      xfs: invert a check in xfs_rtallocate_extent_block
      xfs: reflow the tail end of xfs_rtallocate_extent_block
      xfs: merge the calls to xfs_rtallocate_range in xfs_rtallocate_block
      xfs: tidy up xfs_rtallocate_extent_exact
      xfs: factor out a xfs_rtalloc_sumlevel helper
      xfs: remove rt-wrappers from xfs_format.h
      xfs: remove XFS_RTMIN/XFS_RTMAX
      xfs: reorder the minlen and prod calculations in xfs_bmap_rtalloc
      xfs: simplify and optimize the RT allocation fallback cascade
      xfs: fold xfs_rtallocate_extent into xfs_bmap_rtalloc
      xfs: make if_data a void pointer
      xfs: return if_data from xfs_idata_realloc
      xfs: move the xfs_attr_sf_lookup tracepoint
      xfs: simplify xfs_attr_sf_findname
      xfs: remove xfs_attr_shortform_lookup
      xfs: use xfs_attr_sf_findname in xfs_attr_shortform_getvalue
      xfs: remove struct xfs_attr_shortform
      xfs: remove xfs_attr_sf_hdr_t
      xfs: turn the XFS_DA_OP_REPLACE checks in xfs_attr_shortform_addname into asserts
      xfs: fix a use after free in xfs_defer_finish_recovery
      xfs: use the op name in trace_xlog_intent_recovery_failed

Darrick J. Wong (70):
      xfs: don't leak recovered attri intent items
      xfs: use xfs_defer_pending objects to recover intent items
      xfs: pass the xfs_defer_pending object to iop_recover
      xfs: transfer recovered intent item ownership in ->iop_recover
      xfs: recreate work items when recovering intent items
      xfs: dump the recovered xattri log item if corruption happens
      xfs: don't set XFS_TRANS_HAS_INTENT_DONE when there's no ATTRD log item
      xfs: use xfs_defer_finish_one to finish recovered work items
      xfs: hoist intent done flag setting to ->finish_item callsite
      xfs: move ->iop_recover to xfs_defer_op_type
      xfs: collapse the ->finish_item helpers
      xfs: hoist ->create_intent boilerplate to its callsite
      xfs: use xfs_defer_create_done for the relogging operation
      xfs: clean out XFS_LI_DIRTY setting boilerplate from ->iop_relog
      xfs: hoist xfs_trans_add_item calls to defer ops functions
      xfs: collapse the ->create_done functions
      xfs: make rextslog computation consistent with mkfs
      xfs: fix 32-bit truncation in xfs_compute_rextslog
      xfs: document what LARP means
      xfs: move ->iop_relog to struct xfs_defer_op_type
      xfs: don't allow overly small or large realtime volumes
      xfs: elide ->create_done calls for unlogged deferred work
      xfs: make xchk_iget safer in the presence of corrupt inode btrees
      xfs: don't append work items to logged xfs_defer_pending objects
      xfs: allow pausing of pending deferred work items
      xfs: remove __xfs_free_extent_later
      xfs: automatic freeing of freshly allocated unwritten space
      xfs: remove unused fields from struct xbtree_ifakeroot
      xfs: implement block reservation accounting for btrees we're staging
      xfs: log EFIs for all btree blocks being used to stage a btree
      xfs: force small EFIs for reaping btree extents
      xfs: recompute growfsrtfree transaction reservation while growing rt volume
      xfs: fix an off-by-one error in xreap_agextent_binval
      xfs: force all buffers to be written during btree bulk load
      xfs: set XBF_DONE on newly formatted btree block that are ready for writing
      xfs: read leaf blocks when computing keys for bulkloading into node blocks
      xfs: add debug knobs to control btree bulk load slack factors
      xfs: move btree bulkload record initialization to ->get_record implementations
      xfs: constrain dirty buffers while formatting a staged btree
      xfs: create separate structures and code for u32 bitmaps
      xfs: move the per-AG datatype bitmaps to separate files
      xfs: roll the scrub transaction after completing a repair
      xfs: remove trivial bnobt/inobt scrub helpers
      xfs: repair free space btrees
      xfs: repair inode btrees
      xfs: disable online repair quota helpers when quota not enabled
      xfs: repair refcount btrees
      xfs: try to attach dquots to files before repairing them
      xfs: add missing nrext64 inode flag check to scrub
      xfs: dont cast to char * for XFS_DFORK_*PTR macros
      xfs: set inode sick state flags when we zap either ondisk fork
      xfs: repair inode records
      xfs: zap broken inode forks
      xfs: abort directory parent scrub scans if we encounter a zapped directory
      xfs: reintroduce reaping of file metadata blocks to xrep_reap_extents
      xfs: skip the rmapbt search on an empty attr fork unless we know it was zapped
      xfs: repair inode fork block mapping data structures
      xfs: refactor repair forcing tests into a repair.c helper
      xfs: create a ranged query function for refcount btrees
      xfs: repair problems in CoW forks
      xfs: check rt bitmap file geometry more thoroughly
      xfs: check rt summary file geometry more thoroughly
      xfs: always check the rtbitmap and rtsummary files
      xfs: repair the inode core and forks of a metadata inode
      xfs: create a new inode fork block unmap helper
      xfs: online repair of realtime bitmaps
      xfs: check the ondisk space mapping behind a dquot
      xfs: check dquot resource timers
      xfs: improve dquot iteration for scrub
      xfs: repair quotas

Dave Chinner (1):
      xfs: initialise di_crc in xfs_log_dinode

Eric Sandeen (1):
      xfs: short circuit xfs_growfs_data_private() if delta is zero

Jiachen Zhang (1):
      xfs: ensure logflagsp is initialized in xfs_bmap_del_extent_real

Long Li (2):
      xfs: add lock protection when remove perag from radix tree
      xfs: fix perag leak when growfs fails

Shiyang Ruan (1):
      mm, pmem, xfs: Introduce MF_MEM_PRE_REMOVE for unbind

Wang Jinchao (1):
      xfs/health: cleanup, remove duplicated including

Zhang Tianci (2):
      xfs: update dir3 leaf block metadata after swap
      xfs: extract xfs_da_buf_copy() helper function

 Documentation/filesystems/index.rst                |    5 +-
 Documentation/filesystems/xfs/index.rst            |   14 +
 .../{ => xfs}/xfs-delayed-logging-design.rst       |    0
 .../{ => xfs}/xfs-maintainer-entry-profile.rst     |    0
 .../{ => xfs}/xfs-online-fsck-design.rst           |    2 +-
 .../{ => xfs}/xfs-self-describing-metadata.rst     |    0
 .../maintainer/maintainer-entry-profile.rst        |    2 +-
 MAINTAINERS                                        |    4 +-
 drivers/dax/super.c                                |    3 +-
 fs/xfs/Makefile                                    |   21 +-
 fs/xfs/libxfs/xfs_ag.c                             |   38 +-
 fs/xfs/libxfs/xfs_ag.h                             |   12 +
 fs/xfs/libxfs/xfs_ag_resv.c                        |    2 +
 fs/xfs/libxfs/xfs_alloc.c                          |  116 +-
 fs/xfs/libxfs/xfs_alloc.h                          |   24 +-
 fs/xfs/libxfs/xfs_alloc_btree.c                    |   13 +-
 fs/xfs/libxfs/xfs_attr.c                           |  125 +-
 fs/xfs/libxfs/xfs_attr_leaf.c                      |  238 +--
 fs/xfs/libxfs/xfs_attr_leaf.h                      |    8 +-
 fs/xfs/libxfs/xfs_attr_sf.h                        |   24 +-
 fs/xfs/libxfs/xfs_bmap.c                           |  201 ++-
 fs/xfs/libxfs/xfs_bmap.h                           |    9 +-
 fs/xfs/libxfs/xfs_bmap_btree.c                     |  123 +-
 fs/xfs/libxfs/xfs_bmap_btree.h                     |    5 +
 fs/xfs/libxfs/xfs_btree.c                          |   28 +-
 fs/xfs/libxfs/xfs_btree.h                          |    5 +
 fs/xfs/libxfs/xfs_btree_staging.c                  |   89 +-
 fs/xfs/libxfs/xfs_btree_staging.h                  |   33 +-
 fs/xfs/libxfs/xfs_da_btree.c                       |   69 +-
 fs/xfs/libxfs/xfs_da_btree.h                       |    2 +
 fs/xfs/libxfs/xfs_da_format.h                      |   31 +-
 fs/xfs/libxfs/xfs_defer.c                          |  457 ++++--
 fs/xfs/libxfs/xfs_defer.h                          |   59 +-
 fs/xfs/libxfs/xfs_dir2.c                           |    2 +-
 fs/xfs/libxfs/xfs_dir2_block.c                     |    6 +-
 fs/xfs/libxfs/xfs_dir2_priv.h                      |    3 +-
 fs/xfs/libxfs/xfs_dir2_sf.c                        |   91 +-
 fs/xfs/libxfs/xfs_format.h                         |   19 +-
 fs/xfs/libxfs/xfs_health.h                         |   10 +
 fs/xfs/libxfs/xfs_ialloc.c                         |   36 +-
 fs/xfs/libxfs/xfs_ialloc.h                         |    3 +-
 fs/xfs/libxfs/xfs_ialloc_btree.c                   |    2 +-
 fs/xfs/libxfs/xfs_iext_tree.c                      |   59 +-
 fs/xfs/libxfs/xfs_inode_fork.c                     |   78 +-
 fs/xfs/libxfs/xfs_inode_fork.h                     |   13 +-
 fs/xfs/libxfs/xfs_log_recover.h                    |    8 +
 fs/xfs/{ => libxfs}/xfs_ondisk.h                   |   22 +-
 fs/xfs/libxfs/xfs_refcount.c                       |   57 +-
 fs/xfs/libxfs/xfs_refcount.h                       |   12 +-
 fs/xfs/libxfs/xfs_refcount_btree.c                 |   15 +-
 fs/xfs/libxfs/xfs_rmap.c                           |    2 +-
 fs/xfs/libxfs/xfs_rtbitmap.c                       |  148 +-
 fs/xfs/libxfs/xfs_rtbitmap.h                       |   20 +-
 fs/xfs/libxfs/xfs_sb.c                             |    6 +-
 fs/xfs/libxfs/xfs_shared.h                         |    2 +-
 fs/xfs/libxfs/xfs_symlink_remote.c                 |   12 +-
 fs/xfs/libxfs/xfs_types.h                          |    8 +-
 fs/xfs/scrub/agb_bitmap.c                          |  103 ++
 fs/xfs/scrub/agb_bitmap.h                          |   68 +
 fs/xfs/scrub/agheader_repair.c                     |   19 +-
 fs/xfs/scrub/alloc.c                               |   52 +-
 fs/xfs/scrub/alloc_repair.c                        |  934 ++++++++++++
 fs/xfs/scrub/attr.c                                |   17 +-
 fs/xfs/scrub/bitmap.c                              |  509 ++++---
 fs/xfs/scrub/bitmap.h                              |  111 +-
 fs/xfs/scrub/bmap.c                                |  162 ++-
 fs/xfs/scrub/bmap_repair.c                         |  867 +++++++++++
 fs/xfs/scrub/common.c                              |   35 +-
 fs/xfs/scrub/common.h                              |   56 +
 fs/xfs/scrub/cow_repair.c                          |  614 ++++++++
 fs/xfs/scrub/dir.c                                 |   42 +-
 fs/xfs/scrub/dqiterate.c                           |  211 +++
 fs/xfs/scrub/fsb_bitmap.h                          |   37 +
 fs/xfs/scrub/health.c                              |   34 +-
 fs/xfs/scrub/health.h                              |    2 +
 fs/xfs/scrub/ialloc.c                              |   39 +-
 fs/xfs/scrub/ialloc_repair.c                       |  884 ++++++++++++
 fs/xfs/scrub/inode.c                               |   20 +-
 fs/xfs/scrub/inode_repair.c                        | 1525 ++++++++++++++++++++
 fs/xfs/scrub/newbt.c                               |  559 +++++++
 fs/xfs/scrub/newbt.h                               |   68 +
 fs/xfs/scrub/off_bitmap.h                          |   37 +
 fs/xfs/scrub/parent.c                              |   17 +
 fs/xfs/scrub/quota.c                               |  107 +-
 fs/xfs/scrub/quota.h                               |   36 +
 fs/xfs/scrub/quota_repair.c                        |  575 ++++++++
 fs/xfs/scrub/readdir.c                             |    6 +-
 fs/xfs/scrub/reap.c                                |  168 ++-
 fs/xfs/scrub/reap.h                                |    5 +
 fs/xfs/scrub/refcount.c                            |    2 +-
 fs/xfs/scrub/refcount_repair.c                     |  794 ++++++++++
 fs/xfs/scrub/repair.c                              |  391 ++++-
 fs/xfs/scrub/repair.h                              |   99 ++
 fs/xfs/scrub/rmap.c                                |    1 +
 fs/xfs/scrub/rtbitmap.c                            |  107 +-
 fs/xfs/scrub/rtbitmap.h                            |   22 +
 fs/xfs/scrub/rtbitmap_repair.c                     |  202 +++
 fs/xfs/scrub/rtsummary.c                           |  143 +-
 fs/xfs/scrub/scrub.c                               |   62 +-
 fs/xfs/scrub/scrub.h                               |   15 +-
 fs/xfs/scrub/symlink.c                             |   22 +-
 fs/xfs/scrub/trace.c                               |    3 +
 fs/xfs/scrub/trace.h                               |  488 ++++++-
 fs/xfs/scrub/xfarray.h                             |   22 +
 fs/xfs/xfs_attr_item.c                             |  295 ++--
 fs/xfs/xfs_attr_list.c                             |   13 +-
 fs/xfs/xfs_bmap_item.c                             |  218 ++-
 fs/xfs/xfs_bmap_util.c                             |  141 --
 fs/xfs/xfs_bmap_util.h                             |    2 +-
 fs/xfs/xfs_buf.c                                   |   44 +-
 fs/xfs/xfs_buf.h                                   |    1 +
 fs/xfs/xfs_dir2_readdir.c                          |    9 +-
 fs/xfs/xfs_dquot.c                                 |   37 +-
 fs/xfs/xfs_dquot.h                                 |    8 +-
 fs/xfs/xfs_extent_busy.c                           |   13 +
 fs/xfs/xfs_extent_busy.h                           |    2 +
 fs/xfs/xfs_extfree_item.c                          |  356 ++---
 fs/xfs/xfs_fsops.c                                 |   59 +-
 fs/xfs/xfs_fsops.h                                 |   14 +-
 fs/xfs/xfs_globals.c                               |   12 +
 fs/xfs/xfs_health.c                                |    8 +-
 fs/xfs/xfs_inode.c                                 |   65 +-
 fs/xfs/xfs_inode.h                                 |    2 +
 fs/xfs/xfs_inode_item.c                            |   13 +-
 fs/xfs/xfs_ioctl.c                                 |  115 +-
 fs/xfs/xfs_log.c                                   |    1 +
 fs/xfs/xfs_log_priv.h                              |    1 +
 fs/xfs/xfs_log_recover.c                           |  129 +-
 fs/xfs/xfs_mount.c                                 |    8 +-
 fs/xfs/xfs_notify_failure.c                        |  108 +-
 fs/xfs/xfs_quota.h                                 |    5 +-
 fs/xfs/xfs_refcount_item.c                         |  252 +---
 fs/xfs/xfs_reflink.c                               |    2 +-
 fs/xfs/xfs_rmap_item.c                             |  275 ++--
 fs/xfs/xfs_rtalloc.c                               |  661 ++++-----
 fs/xfs/xfs_rtalloc.h                               |   37 -
 fs/xfs/xfs_super.c                                 |    6 +-
 fs/xfs/xfs_symlink.c                               |    7 +-
 fs/xfs/xfs_sysctl.h                                |    2 +
 fs/xfs/xfs_sysfs.c                                 |   63 +
 fs/xfs/xfs_trace.h                                 |   42 +-
 fs/xfs/xfs_trans.c                                 |   62 +
 fs/xfs/xfs_trans.h                                 |   16 +-
 fs/xfs/xfs_xattr.c                                 |    6 +
 include/linux/mm.h                                 |    1 +
 mm/memory-failure.c                                |   21 +-
 146 files changed, 12802 insertions(+), 3018 deletions(-)
 create mode 100644 Documentation/filesystems/xfs/index.rst
 rename Documentation/filesystems/{ => xfs}/xfs-delayed-logging-design.rst (100%)
 rename Documentation/filesystems/{ => xfs}/xfs-maintainer-entry-profile.rst (100%)
 rename Documentation/filesystems/{ => xfs}/xfs-online-fsck-design.rst (99%)
 rename Documentation/filesystems/{ => xfs}/xfs-self-describing-metadata.rst (100%)
 rename fs/xfs/{ => libxfs}/xfs_ondisk.h (92%)
 create mode 100644 fs/xfs/scrub/agb_bitmap.c
 create mode 100644 fs/xfs/scrub/agb_bitmap.h
 create mode 100644 fs/xfs/scrub/alloc_repair.c
 create mode 100644 fs/xfs/scrub/bmap_repair.c
 create mode 100644 fs/xfs/scrub/cow_repair.c
 create mode 100644 fs/xfs/scrub/dqiterate.c
 create mode 100644 fs/xfs/scrub/fsb_bitmap.h
 create mode 100644 fs/xfs/scrub/ialloc_repair.c
 create mode 100644 fs/xfs/scrub/inode_repair.c
 create mode 100644 fs/xfs/scrub/newbt.c
 create mode 100644 fs/xfs/scrub/newbt.h
 create mode 100644 fs/xfs/scrub/off_bitmap.h
 create mode 100644 fs/xfs/scrub/quota.h
 create mode 100644 fs/xfs/scrub/quota_repair.c
 create mode 100644 fs/xfs/scrub/refcount_repair.c
 create mode 100644 fs/xfs/scrub/rtbitmap.h
 create mode 100644 fs/xfs/scrub/rtbitmap_repair.c

