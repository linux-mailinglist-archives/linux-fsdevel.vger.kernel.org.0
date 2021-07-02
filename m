Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8133BA49A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 22:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhGBUTQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 16:19:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232491AbhGBUTQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 16:19:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8CB46140E;
        Fri,  2 Jul 2021 20:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625257004;
        bh=NbSvi0y9GaeXCurI4Kj3SsUph1KnedMgtCxiSVdc2P4=;
        h=Date:From:To:Cc:Subject:From;
        b=JiRDkQTkReq3Ulbr/qftOZamtBtIPM+BuUtGLrpQ46pysiF2I7Qs0LryvpqYzvv8i
         Jzrgf1z8xBzP7vjXfDxs6GPSay7/ShqmcsQbncK6dTcLW5AYZ0qbeiB3P+OszsE370
         JxcUiqdoDvxskOqQp6O96/FP7HjZf3rm+GGQQhedZOjls2ABOyRo5pHHdGKqQP97n1
         k5lo8xde7rgk17u537GmKRgcJqaPylwJFk8bZCVyALLl/55R8m2S5KDmO4rlmuBIf9
         he/gXAvOJI/jl5lFlVHTA6KvKaAP8RKUIc0gH4JOakJgBljZDSeqrmXCJLmXFfVg0W
         IdJjLIH9SpwNw==
Date:   Fri, 2 Jul 2021 13:16:43 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: new code for 5.14
Message-ID: <20210702201643.GA13765@locust>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch containing new code for 5.14.  Most of the work
this cycle has been on refactoring various parts of the codebase.  The
biggest non-cleanup changes are (1) reducing the number of cache flushes
sent when writing the log; (2) a substantial number of log recovery
fixes; and (3) I started accepting pull requests from contributors if
the commits in their branches match what's been sent to the list.

For a week or so I /had/ staged a major cleanup of the logging code from
Dave Chinner, but it exposed so many lurking bugs in other parts of the
logging and log recovery code that I decided to defer that patchset
until we can address those latent bugs.

Larger cleanups this time include walking the incore inode cache (me)
and rework of the extended attribute code (Allison) to prepare it for
adding logged xattr updates (and directory tree parent pointers) in
future releases.

The branch merges cleanly against upstream as of a few minutes ago.
Please let me know if anything else strange happens during the merge
process.  The merge commits I made seem stable enough, but as it's the
first time I've ever accepted a pull request, we'd all be open to
feedback for improvements for next time.

--D

The following changes since commit 8124c8a6b35386f73523d27eacb71b5364a68c4c:

  Linux 5.13-rc4 (2021-05-30 11:58:25 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.14-merge-6

for you to fetch changes up to 1effb72a8179a02c2dd8a268454ccf50bf68aa50:

  xfs: don't wait on future iclogs when pushing the CIL (2021-06-25 14:02:02 -0700)

----------------------------------------------------------------
New code for 5.14:
- Refactor the buffer cache to use bulk page allocation
- Convert agnumber-based AG iteration to walk per-AG structures
- Clean up some unit conversions and other code warts
- Reduce spinlock contention in the directio fastpath
- Collapse all the inode cache walks into a single function
- Remove indirect function calls from the inode cache walk code
- Dramatically reduce the number of cache flushes sent when writing log
  buffers
- Preserve inode sickness reports for longer
- Rename xfs_eofblocks since it controls inode cache walks
- Refactor the extended attribute code to prepare it for the addition
  of log intent items to make xattrs fully transactional
- A few fixes to earlier large patchsets
- Log recovery fixes so that we don't accidentally mark the log clean
  when log intent recovery fails
- Fix some latent SOB errors
- Clean up shutdown messages that get logged to dmesg
- Fix a regression in the online shrink code
- Fix a UAF in the buffer logging code if the fs goes offline
- Fix uninitialized error variables
- Fix a UAF in the CIL when commited log item callbacks race with a
  shutdown
- Fix a bug where the CIL could hang trying to push part of the log ring
  buffer that hasn't been filled yet

----------------------------------------------------------------
Allison Henderson (15):
      xfs: Reverse apply 72b97ea40d
      xfs: Add xfs_attr_node_remove_name
      xfs: Refactor xfs_attr_set_shortform
      xfs: Separate xfs_attr_node_addname and xfs_attr_node_addname_clear_incomplete
      xfs: Add helper xfs_attr_node_addname_find_attr
      xfs: Hoist xfs_attr_node_addname
      xfs: Hoist xfs_attr_leaf_addname
      xfs: Hoist node transaction handling
      xfs: Add delay ready attr remove routines
      xfs: Add delay ready attr set routines
      xfs: Remove xfs_attr_rmtval_set
      xfs: Clean up xfs_attr_node_addname_clear_incomplete
      xfs: Fix default ASSERT in xfs_attr_set_iter
      xfs: Make attr name schemes consistent
      xfs: Initialize error in xfs_attr_remove_iter

Brian Foster (2):
      xfs: hold buffer across unpin and potential shutdown processing
      xfs: remove dead stale buf unpin handling code

Christoph Hellwig (4):
      xfs: mark xfs_bmap_set_attrforkoff static
      xfs: remove ->b_offset handling for page backed buffers
      xfs: simplify the b_page_count calculation
      xfs: cleanup error handling in xfs_buf_get_map

Darrick J. Wong (38):
      xfs: clean up open-coded fs block unit conversions
      xfs: remove unnecessary shifts
      xfs: move the quotaoff dqrele inode walk into xfs_icache.c
      xfs: detach inode dquots at the end of inactivation
      xfs: move the inode walk functions further down
      xfs: rename xfs_inode_walk functions to xfs_icwalk
      xfs: pass the goal of the incore inode walk to xfs_inode_walk()
      xfs: separate the dqrele_all inode grab logic from xfs_inode_walk_ag_grab
      xfs: move xfs_inew_wait call into xfs_dqrele_inode
      xfs: remove iter_flags parameter from xfs_inode_walk_*
      xfs: remove indirect calls from xfs_inode_walk{,_ag}
      xfs: clean up inode state flag tests in xfs_blockgc_igrab
      xfs: make the icwalk processing functions clean up the grab state
      xfs: fix radix tree tag signs
      xfs: pass struct xfs_eofblocks to the inode scan callback
      xfs: merge xfs_reclaim_inodes_ag into xfs_inode_walk_ag
      xfs: refactor per-AG inode tagging functions
      Merge tag 'xfs-buf-bulk-alloc-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs into xfs-5.14-merge2
      Merge tag 'xfs-perag-conv-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs into xfs-5.14-merge2
      Merge tag 'unit-conversion-cleanups-5.14_2021-06-03' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-5.14-merge2
      Merge tag 'assorted-fixes-5.14-1_2021-06-03' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-5.14-merge2
      Merge tag 'inode-walk-cleanups-5.14_2021-06-03' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-5.14-merge2
      xfs: only reset incore inode health state flags when reclaiming an inode
      xfs: drop IDONTCACHE on inodes when we mark them sick
      xfs: change the prefix of XFS_EOF_FLAGS_* to XFS_ICWALK_FLAG_
      xfs: selectively keep sick inodes in memory
      xfs: rename struct xfs_eofblocks to xfs_icwalk
      Merge tag 'fix-inode-health-reports-5.14_2021-06-08' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-5.14-merge2
      Merge tag 'rename-eofblocks-5.14_2021-06-08' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-5.14-merge2
      Merge tag 'xfs-delay-ready-attrs-v20.1' of https://github.com/allisonhenderson/xfs_work into xfs-5.14-merge4
      xfs: refactor the inode recycling code
      xfs: separate primary inode selection criteria in xfs_iget_cache_hit
      xfs: fix type mismatches in the inode reclaim functions
      xfs: print name of function causing fs shutdown instead of hex pointer
      xfs: shorten the shutdown messages to a single line
      xfs: fix log intent recovery ENOSPC shutdowns when inactivating inodes
      xfs: force the log offline when log intent item recovery fails
      xfs: fix endianness issue in xfs_ag_shrink_space

Dave Chinner (47):
      xfs: split up xfs_buf_allocate_memory
      xfs: use xfs_buf_alloc_pages for uncached buffers
      xfs: use alloc_pages_bulk_array() for buffers
      xfs: merge _xfs_buf_get_pages()
      xfs: move page freeing into _xfs_buf_free_pages()
      xfs: move xfs_perag_get/put to xfs_ag.[ch]
      xfs: prepare for moving perag definitions and support to libxfs
      xfs: move perag structure and setup to libxfs/xfs_ag.[ch]
      xfs: make for_each_perag... a first class citizen
      xfs: convert raw ag walks to use for_each_perag
      xfs: convert xfs_iwalk to use perag references
      xfs: convert secondary superblock walk to use perags
      xfs: pass perags through to the busy extent code
      xfs: push perags through the ag reservation callouts
      xfs: pass perags around in fsmap data dev functions
      xfs: add a perag to the btree cursor
      xfs: convert rmap btree cursor to using a perag
      xfs: convert refcount btree cursor to use perags
      xfs: convert allocbt cursors to use perags
      xfs: use perag for ialloc btree cursors
      xfs: remove agno from btree cursor
      xfs: simplify xfs_dialloc_select_ag() return values
      xfs: collapse AG selection for inode allocation
      xfs: get rid of xfs_dir_ialloc()
      xfs: inode allocation can use a single perag instance
      xfs: clean up and simplify xfs_dialloc()
      xfs: use perag through unlink processing
      xfs: remove xfs_perag_t
      xfs: don't take a spinlock unconditionally in the DIO fastpath
      xfs: get rid of xb_to_gfp()
      xfs: merge xfs_buf_allocate_memory
      xfs: drop the AGI being passed to xfs_check_agi_freecount
      xfs: perag may be null in xfs_imap()
      xfs: log stripe roundoff is a property of the log
      xfs: separate CIL commit record IO
      xfs: remove xfs_blkdev_issue_flush
      xfs: async blkdev cache flush
      xfs: CIL checkpoint flushes caches unconditionally
      xfs: remove need_start_rec parameter from xlog_write()
      xfs: journal IO cache flush reductions
      xfs: Fix CIL throttle hang when CIL space used going backwards
      xfs: xfs_log_force_lsn isn't passed a LSN
      xfs: add iclog state trace events
      xfs: don't nest icloglock inside ic_callback_lock
      xfs: remove callback dequeue loop from xlog_state_do_iclog_callbacks
      xfs: Fix a CIL UAF by getting get rid of the iclog callback lock
      xfs: don't wait on future iclogs when pushing the CIL

Geert Uytterhoeven (1):
      xfs: Fix 64-bit division on 32-bit in xlog_state_switch_iclogs()

Jiapeng Chong (1):
      xfs: Remove redundant assignment to busy

Shaokun Zhang (2):
      xfs: sort variable alphabetically to avoid repeated declaration
      xfs: remove redundant initialization of variable error

 fs/xfs/libxfs/xfs_ag.c             |  280 ++++++++-
 fs/xfs/libxfs/xfs_ag.h             |  136 +++++
 fs/xfs/libxfs/xfs_ag_resv.c        |   11 +-
 fs/xfs/libxfs/xfs_ag_resv.h        |   15 +
 fs/xfs/libxfs/xfs_alloc.c          |  111 ++--
 fs/xfs/libxfs/xfs_alloc.h          |    2 +-
 fs/xfs/libxfs/xfs_alloc_btree.c    |   31 +-
 fs/xfs/libxfs/xfs_alloc_btree.h    |    9 +-
 fs/xfs/libxfs/xfs_attr.c           |  956 +++++++++++++++++------------
 fs/xfs/libxfs/xfs_attr.h           |  403 +++++++++++++
 fs/xfs/libxfs/xfs_attr_leaf.c      |    5 +-
 fs/xfs/libxfs/xfs_attr_leaf.h      |    2 +-
 fs/xfs/libxfs/xfs_attr_remote.c    |  167 +++---
 fs/xfs/libxfs/xfs_attr_remote.h    |    8 +-
 fs/xfs/libxfs/xfs_bmap.c           |    3 +-
 fs/xfs/libxfs/xfs_bmap.h           |    1 -
 fs/xfs/libxfs/xfs_btree.c          |   15 +-
 fs/xfs/libxfs/xfs_btree.h          |   10 +-
 fs/xfs/libxfs/xfs_ialloc.c         |  641 ++++++++++----------
 fs/xfs/libxfs/xfs_ialloc.h         |   40 +-
 fs/xfs/libxfs/xfs_ialloc_btree.c   |   46 +-
 fs/xfs/libxfs/xfs_ialloc_btree.h   |   13 +-
 fs/xfs/libxfs/xfs_inode_buf.c      |    2 +-
 fs/xfs/libxfs/xfs_log_format.h     |    3 -
 fs/xfs/libxfs/xfs_refcount.c       |  122 ++--
 fs/xfs/libxfs/xfs_refcount.h       |    9 +-
 fs/xfs/libxfs/xfs_refcount_btree.c |   39 +-
 fs/xfs/libxfs/xfs_refcount_btree.h |    7 +-
 fs/xfs/libxfs/xfs_rmap.c           |  147 ++---
 fs/xfs/libxfs/xfs_rmap.h           |    6 +-
 fs/xfs/libxfs/xfs_rmap_btree.c     |   46 +-
 fs/xfs/libxfs/xfs_rmap_btree.h     |    6 +-
 fs/xfs/libxfs/xfs_sb.c             |  146 +----
 fs/xfs/libxfs/xfs_sb.h             |    9 -
 fs/xfs/libxfs/xfs_shared.h         |   20 +-
 fs/xfs/libxfs/xfs_types.c          |    4 +-
 fs/xfs/libxfs/xfs_types.h          |    1 +
 fs/xfs/scrub/agheader.c            |    1 +
 fs/xfs/scrub/agheader_repair.c     |   33 +-
 fs/xfs/scrub/alloc.c               |    3 +-
 fs/xfs/scrub/bmap.c                |   21 +-
 fs/xfs/scrub/common.c              |   15 +-
 fs/xfs/scrub/fscounters.c          |   42 +-
 fs/xfs/scrub/health.c              |    2 +-
 fs/xfs/scrub/ialloc.c              |    9 +-
 fs/xfs/scrub/refcount.c            |    3 +-
 fs/xfs/scrub/repair.c              |   14 +-
 fs/xfs/scrub/rmap.c                |    3 +-
 fs/xfs/scrub/trace.c               |    3 +-
 fs/xfs/xfs_attr_inactive.c         |    2 +-
 fs/xfs/xfs_bio_io.c                |   35 ++
 fs/xfs/xfs_bmap_util.c             |    6 +-
 fs/xfs/xfs_buf.c                   |  311 ++++------
 fs/xfs/xfs_buf.h                   |    3 +-
 fs/xfs/xfs_buf_item.c              |   97 ++-
 fs/xfs/xfs_discard.c               |    6 +-
 fs/xfs/xfs_dquot_item.c            |    2 +-
 fs/xfs/xfs_extent_busy.c           |   35 +-
 fs/xfs/xfs_extent_busy.h           |    7 +-
 fs/xfs/xfs_file.c                  |   70 ++-
 fs/xfs/xfs_filestream.c            |    2 +-
 fs/xfs/xfs_fsmap.c                 |   80 ++-
 fs/xfs/xfs_fsops.c                 |   24 +-
 fs/xfs/xfs_health.c                |   15 +-
 fs/xfs/xfs_icache.c                | 1162 ++++++++++++++++++++----------------
 fs/xfs/xfs_icache.h                |   58 +-
 fs/xfs/xfs_inode.c                 |  234 ++++----
 fs/xfs/xfs_inode.h                 |    9 +-
 fs/xfs/xfs_inode_item.c            |   18 +-
 fs/xfs/xfs_inode_item.h            |    2 +-
 fs/xfs/xfs_ioctl.c                 |   41 +-
 fs/xfs/xfs_iops.c                  |    4 +-
 fs/xfs/xfs_iwalk.c                 |   84 ++-
 fs/xfs/xfs_linux.h                 |    2 +
 fs/xfs/xfs_log.c                   |  273 ++++-----
 fs/xfs/xfs_log.h                   |    5 +-
 fs/xfs/xfs_log_cil.c               |  138 +++--
 fs/xfs/xfs_log_priv.h              |   41 +-
 fs/xfs/xfs_log_recover.c           |   61 +-
 fs/xfs/xfs_mount.c                 |  136 +----
 fs/xfs/xfs_mount.h                 |  110 +---
 fs/xfs/xfs_qm.c                    |   10 +-
 fs/xfs/xfs_qm.h                    |    1 -
 fs/xfs/xfs_qm_syscalls.c           |   54 +-
 fs/xfs/xfs_reflink.c               |   13 +-
 fs/xfs/xfs_super.c                 |   10 +-
 fs/xfs/xfs_super.h                 |    1 -
 fs/xfs/xfs_symlink.c               |    9 +-
 fs/xfs/xfs_trace.c                 |    2 +
 fs/xfs/xfs_trace.h                 |  115 +++-
 fs/xfs/xfs_trans.c                 |    6 +-
 fs/xfs/xfs_trans.h                 |    4 +-
 92 files changed, 3855 insertions(+), 3064 deletions(-)
