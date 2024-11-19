Return-Path: <linux-fsdevel+bounces-35213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D159D28B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 15:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52432283022
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 14:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A2D1CFEA0;
	Tue, 19 Nov 2024 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrAWHFVP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFFA1CF5E3;
	Tue, 19 Nov 2024 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028165; cv=none; b=AvMaglKHD1xiNqI5Hzf+AqI6x3yC5m25zmKghT4g2C3gvsJMeK89/fkMqPWtNnyOnaeKgr7q/c8ZmaD8k5mBUdUcss9hWzvGT9DkJsx/34lPbNEHk0N6Ul/Z8Q5I720MHq1T4iIZ3wRHZFfbyBHdD0gpyWGM3aP1xYXjgllRPJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028165; c=relaxed/simple;
	bh=K6VM8vXpuFLI3+J1oXORSYiYl4sVvm/EC/BHaNrWwqU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FdAS+R0E97I36BQPUyYkKHKty/zJpynXDdt3Y/yDX2YiDBne+VJfeepOwbp9O9ad8euYp/1rvru6YjkPWVRsAs1yEFmxoeTxAGZBbExcunFR2CsiMLu7u+mZ5R/B5UcePKQ2dFu3WTOlYk+pmunVLen94eCdzBAYUJ9somUDVa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrAWHFVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967E2C4CECF;
	Tue, 19 Nov 2024 14:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732028164;
	bh=K6VM8vXpuFLI3+J1oXORSYiYl4sVvm/EC/BHaNrWwqU=;
	h=Date:From:To:Cc:Subject:From;
	b=WrAWHFVPOjuKthgJpnXuOFOxIrrjFP2xg+9e2vrPiF+gqY1JbGwTc2jDotBRlFqIz
	 ODsggJj291SpsIotQXe5ye59aV46Yu60tJ7iyeWw+d3qNu6Xx/Y74pkoUYw52kCYYL
	 3Tam3HkX3nN4e+IG9NcnLZdsvRoXNSBiO8PTpDkQ7wnC0GWLYzjzTSlRaDMEc0Xm2v
	 LJ5OQxpfOJaOz7WpR1a1l3yKEGrzArt+ruYEJgQT5+1X98hdDJ4kblnnA/OKZk4JRi
	 fGpHBwLGZaim/KI+bAngwDVsGXp2IwgZ/0anGI1yq4jp+OrpQNB3SdsjVNFiKeONFs
	 srLTd0+odOJzw==
Date: Tue, 19 Nov 2024 15:56:00 +0100
From: Carlos Maiolino <cem@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: xfs: new code for 6.13
Message-ID: <6mrksfh2g2jasx4vurcnm3ho5ycn7klvo3ypwcw4ld2sn4josr@2k63jb7jzrtp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

could you please pull the patches below?

The bulk of this pull request is a major rework that Darrick and Christoph have
been doing on XFS's real-time volume, coupled with a few features to support
this rework.
It does also includes some bug fixes.

Those patches are in linux-next for a few days already, and  I just did a trial
merge on your TOT, and didn't see any conflicts.

This is the firs merge window I'm working on, if something needs to be improved
in the pull request, please let me know.

Cheers,
Carlos

The following changes since commit 59b723cd2adbac2a34fc8e12c74ae26ae45bf230:

  Linux 6.12-rc6 (2024-11-03 14:05:52 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.13-merge-1

for you to fetch changes up to 5877dc24be5dad833e09e3c4c8f6e178d2970fbd:

  Merge tag 'better-ondisk-6.13_2024-11-05' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into staging-merge (2024-11-12 11:03:15 +0100)

----------------------------------------------------------------
New xfs code for 6.13

* convert perag to use xarrays
* create a new generic allocation group structure
* Add metadata inode dir trees
* Create in-core rt allocation groups
* Shard the RT section into allocation groups
* Persist quota options with the enw metadata dir tree
* Enable quota for RT volumes
* Enable metadata directory trees
* Some bugfixes

Signed-off-by: Carlos Maiolino <cem@kernel.org>

----------------------------------------------------------------
Carlos Maiolino (10):
      Merge tag 'perag-xarray-6.13_2024-11-05' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into staging-merge
      Merge tag 'generic-groups-6.13_2024-11-05' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into staging-merge
      Merge tag 'metadata-directory-tree-6.13_2024-11-05' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into staging-merge
      Merge tag 'incore-rtgroups-6.13_2024-11-05' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into staging-merge
      Merge tag 'rtgroups-prep-6.13_2024-11-05' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into staging-merge
      Merge tag 'realtime-groups-6.13_2024-11-05' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into staging-merge
      Merge tag 'metadir-quotas-6.13_2024-11-05' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into staging-merge
      Merge tag 'realtime-quotas-6.13_2024-11-05' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into staging-merge
      Merge tag 'metadir-6.13_2024-11-05' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into staging-merge
      Merge tag 'better-ondisk-6.13_2024-11-05' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into staging-merge

Christoph Hellwig (60):
      xfs: simplify sector number calculation in xfs_zero_extent
      xfs: split the page fault trace event
      xfs: split write fault handling out of __xfs_filemap_fault
      xfs: remove __xfs_filemap_fault
      xfs: remove xfs_page_mkwrite_iomap_ops
      xfs: fix superfluous clearing of info->low in __xfs_getfsmap_datadev
      xfs: remove the unused pagb_count field in struct xfs_perag
      xfs: remove the unused pag_active_wq field in struct xfs_perag
      xfs: pass a pag to xfs_difree_inode_chunk
      xfs: remove the agno argument to xfs_free_ag_extent
      xfs: add xfs_agbno_to_fsb and xfs_agbno_to_daddr helpers
      xfs: add a xfs_agino_to_ino helper
      xfs: pass a pag to xfs_extent_busy_{search,reuse}
      xfs: keep a reference to the pag for busy extents
      xfs: remove the mount field from struct xfs_busy_extents
      xfs: remove the unused trace_xfs_iwalk_ag trace point
      xfs: remove the unused xrep_bmap_walk_rmap trace point
      xfs: constify pag arguments to trace points
      xfs: pass a perag structure to the xfs_ag_resv_init_error trace point
      xfs: pass objects to the xfs_irec_merge_{pre,post} trace points
      xfs: pass the iunlink item to the xfs_iunlink_update_dinode trace point
      xfs: pass objects to the xrep_ibt_walk_rmap tracepoint
      xfs: pass the pag to the trace_xrep_calc_ag_resblks{,_btsize} trace points
      xfs: pass the pag to the xrep_newbt_extent_class tracepoints
      xfs: factor out a xfs_iwalk_args helper
      xfs: convert remaining trace points to pass pag structures
      xfs: factor out a generic xfs_group structure
      xfs: split xfs_initialize_perag
      xfs: add a xfs_group_next_range helper
      xfs: insert the pag structures into the xarray later
      xfs: switch perag iteration from the for_each macros to a while based iterator
      xfs: move metadata health tracking to the generic group structure
      xfs: mark xfs_perag_intent_{hold,rele} static
      xfs: move draining of deferred operations to the generic group structure
      xfs: move the online repair rmap hooks to the generic group structure
      xfs: return the busy generation from xfs_extent_busy_list_empty
      xfs: convert extent busy tracepoints to the generic group structure
      xfs: convert busy extent tracking to the generic group structure
      xfs: add a generic group pointer to the btree cursor
      xfs: store a generic xfs_group pointer in xfs_getfsmap_info
      xfs: add group based bno conversion helpers
      xfs: remove xfs_group_intent_hold and xfs_group_intent_rele
      xfs: store a generic group structure in the intents
      xfs: clean up xfs_getfsmap_helper arguments
      xfs: add a xfs_bmap_free_rtblocks helper
      xfs: add a xfs_qm_unmount_rt helper
      xfs: factor out a xfs_growfs_rt_alloc_blocks helper
      xfs: cleanup xfs_getfsmap_rtdev_rtbitmap
      xfs: split xfs_trim_rtdev_extents
      xfs: move RT bitmap and summary information to the rtgroup
      xfs: support creating per-RTG files in growfs
      xfs: calculate RT bitmap and summary blocks based on sb_rextents
      xfs: use xfs_growfs_rt_alloc_fake_mount in xfs_growfs_rt_alloc_blocks
      xfs: factor out a xfs_growfs_check_rtgeom helper
      xfs: refactor xfs_rtbitmap_blockcount
      xfs: refactor xfs_rtsummary_blockcount
      xfs: make RT extent numbers relative to the rtgroup
      iomap: add a merge boundary flag
      xfs: add a helper to prevent bmap merges across rtgroup boundaries
      xfs: make the RT allocator rtgroup aware

Darrick J. Wong (84):
      xfs: fix simplify extent lookup in xfs_can_free_eofblocks
      xfs: constify the xfs_sb predicates
      xfs: constify the xfs_inode predicates
      xfs: rename metadata inode predicates
      xfs: standardize EXPERIMENTAL warning generation
      xfs: define the on-disk format for the metadir feature
      xfs: iget for metadata inodes
      xfs: load metadata directory root at mount time
      xfs: enforce metadata inode flag
      xfs: read and write metadata inode directory tree
      xfs: disable the agi rotor for metadata inodes
      xfs: hide metadata inodes from everyone because they are special
      xfs: advertise metadata directory feature
      xfs: allow bulkstat to return metadata directories
      xfs: don't count metadata directory files to quota
      xfs: mark quota inodes as metadata files
      xfs: adjust xfs_bmap_add_attrfork for metadir
      xfs: record health problems with the metadata directory
      xfs: refactor directory tree root predicates
      xfs: do not count metadata directory files when doing online quotacheck
      xfs: metadata files can have xattrs if metadir is enabled
      xfs: adjust parent pointer scrubber for sb-rooted metadata files
      xfs: fix di_metatype field of inodes that won't load
      xfs: scrub metadata directories
      xfs: check the metadata directory inumber in superblocks
      xfs: move repair temporary files to the metadata directory tree
      xfs: check metadata directory file path connectivity
      xfs: confirm dotdot target before replacing it during a repair
      xfs: create incore realtime group structures
      xfs: define locking primitives for realtime groups
      xfs: add a lockdep class key for rtgroup inodes
      xfs: support caching rtgroup metadata inodes
      xfs: repair metadata directory file path connectivity
      xfs: add rtgroup-based realtime scrubbing context management
      xfs: remove XFS_ILOCK_RT*
      xfs: factor out a xfs_growfs_rt_alloc_fake_mount helper
      xfs: fix rt device offset calculations for FITRIM
      xfs: define the format of rt groups
      xfs: check the realtime superblock at mount time
      xfs: update realtime super every time we update the primary fs super
      xfs: export realtime group geometry via XFS_FSOP_GEOM
      xfs: check that rtblock extents do not break rtsupers or rtgroups
      xfs: add frextents to the lazysbcounters when rtgroups enabled
      xfs: convert sick_map loops to use ARRAY_SIZE
      xfs: record rt group metadata errors in the health system
      xfs: export the geometry of realtime groups to userspace
      xfs: add block headers to realtime bitmap and summary blocks
      xfs: encode the rtbitmap in big endian format
      xfs: encode the rtsummary in big endian format
      xfs: grow the realtime section when realtime groups are enabled
      xfs: store rtgroup information with a bmap intent
      xfs: force swapext to a realtime file to use the file content exchange ioctl
      xfs: support logging EFIs for realtime extents
      xfs: support error injection when freeing rt extents
      xfs: use realtime EFI to free extents when rtgroups are enabled
      xfs: don't merge ioends across RTGs
      xfs: don't coalesce file mappings that cross rtgroup boundaries in scrub
      xfs: scrub the realtime group superblock
      xfs: repair realtime group superblock
      xfs: scrub metadir paths for rtgroup metadata
      xfs: mask off the rtbitmap and summary inodes when metadir in use
      xfs: create helpers to deal with rounding xfs_fileoff_t to rtx boundaries
      xfs: create helpers to deal with rounding xfs_filblks_t to rtx boundaries
      xfs: make xfs_rtblock_t a segmented address like xfs_fsblock_t
      xfs: adjust min_block usage in xfs_verify_agbno
      xfs: move the min and max group block numbers to xfs_group
      xfs: port the perag discard code to handle generic groups
      xfs: implement busy extent tracking for rtgroups
      xfs: use rtgroup busy extent list for FITRIM
      xfs: refactor xfs_qm_destroy_quotainos
      xfs: use metadir for quota inodes
      xfs: fix chown with rt quota
      xfs: scrub quota file metapaths
      xfs: advertise realtime quota support in the xqm stat files
      xfs: persist quota flags with metadir
      xfs: report realtime block quota limits on realtime directories
      xfs: create quota preallocation watermarks for realtime quota
      xfs: reserve quota for realtime files correctly
      xfs: update sb field checks when metadir is turned on
      xfs: enable realtime quota again
      xfs: enable metadata directory feature
      xfs: convert struct typedefs in xfs_ondisk.h
      xfs: separate space btree structures in xfs_ondisk.h
      xfs: port ondisk structure checks from xfs/122 to the kernel

Dave Chinner (1):
      xfs: sb_spino_align is not verified

Long Li (1):
      xfs: remove the redundant xfs_alloc_log_agf

 fs/iomap/buffered-io.c             |    6 +
 fs/xfs/Makefile                    |    8 +-
 fs/xfs/libxfs/xfs_ag.c             |  256 ++++-----
 fs/xfs/libxfs/xfs_ag.h             |  205 ++++----
 fs/xfs/libxfs/xfs_ag_resv.c        |   22 +-
 fs/xfs/libxfs/xfs_alloc.c          |  119 +++--
 fs/xfs/libxfs/xfs_alloc.h          |   19 +-
 fs/xfs/libxfs/xfs_alloc_btree.c    |   30 +-
 fs/xfs/libxfs/xfs_attr.c           |    5 +-
 fs/xfs/libxfs/xfs_bmap.c           |  137 +++--
 fs/xfs/libxfs/xfs_bmap.h           |    2 +-
 fs/xfs/libxfs/xfs_btree.c          |   38 +-
 fs/xfs/libxfs/xfs_btree.h          |    3 +-
 fs/xfs/libxfs/xfs_btree_mem.c      |    6 +-
 fs/xfs/libxfs/xfs_defer.c          |    6 +
 fs/xfs/libxfs/xfs_defer.h          |    1 +
 fs/xfs/libxfs/xfs_dquot_buf.c      |  190 +++++++
 fs/xfs/libxfs/xfs_format.h         |  199 ++++++-
 fs/xfs/libxfs/xfs_fs.h             |   53 +-
 fs/xfs/libxfs/xfs_group.c          |  225 ++++++++
 fs/xfs/libxfs/xfs_group.h          |  164 ++++++
 fs/xfs/libxfs/xfs_health.h         |   89 ++--
 fs/xfs/libxfs/xfs_ialloc.c         |  175 +++---
 fs/xfs/libxfs/xfs_ialloc_btree.c   |   31 +-
 fs/xfs/libxfs/xfs_inode_buf.c      |   90 +++-
 fs/xfs/libxfs/xfs_inode_buf.h      |    3 +
 fs/xfs/libxfs/xfs_inode_util.c     |    6 +-
 fs/xfs/libxfs/xfs_log_format.h     |    8 +-
 fs/xfs/libxfs/xfs_log_recover.h    |    2 +
 fs/xfs/libxfs/xfs_metadir.c        |  481 +++++++++++++++++
 fs/xfs/libxfs/xfs_metadir.h        |   47 ++
 fs/xfs/libxfs/xfs_metafile.c       |   52 ++
 fs/xfs/libxfs/xfs_metafile.h       |   31 ++
 fs/xfs/libxfs/xfs_ondisk.h         |  186 +++++--
 fs/xfs/libxfs/xfs_quota_defs.h     |   43 ++
 fs/xfs/libxfs/xfs_refcount.c       |   33 +-
 fs/xfs/libxfs/xfs_refcount.h       |    2 +-
 fs/xfs/libxfs/xfs_refcount_btree.c |   17 +-
 fs/xfs/libxfs/xfs_rmap.c           |   42 +-
 fs/xfs/libxfs/xfs_rmap.h           |    6 +-
 fs/xfs/libxfs/xfs_rmap_btree.c     |   28 +-
 fs/xfs/libxfs/xfs_rtbitmap.c       |  388 +++++++++-----
 fs/xfs/libxfs/xfs_rtbitmap.h       |  247 ++++++---
 fs/xfs/libxfs/xfs_rtgroup.c        |  697 ++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_rtgroup.h        |  284 ++++++++++
 fs/xfs/libxfs/xfs_sb.c             |  276 +++++++++-
 fs/xfs/libxfs/xfs_sb.h             |    6 +-
 fs/xfs/libxfs/xfs_shared.h         |    4 +
 fs/xfs/libxfs/xfs_trans_resv.c     |    2 +-
 fs/xfs/libxfs/xfs_types.c          |   44 +-
 fs/xfs/libxfs/xfs_types.h          |   16 +-
 fs/xfs/scrub/agheader.c            |   52 +-
 fs/xfs/scrub/agheader_repair.c     |   42 +-
 fs/xfs/scrub/alloc.c               |    2 +-
 fs/xfs/scrub/alloc_repair.c        |   22 +-
 fs/xfs/scrub/bmap.c                |   38 +-
 fs/xfs/scrub/bmap_repair.c         |   11 +-
 fs/xfs/scrub/common.c              |  149 +++++-
 fs/xfs/scrub/common.h              |   40 +-
 fs/xfs/scrub/cow_repair.c          |   21 +-
 fs/xfs/scrub/dir.c                 |   10 +-
 fs/xfs/scrub/dir_repair.c          |   20 +-
 fs/xfs/scrub/dirtree.c             |   32 +-
 fs/xfs/scrub/dirtree.h             |   12 +-
 fs/xfs/scrub/findparent.c          |   28 +-
 fs/xfs/scrub/fscounters.c          |   35 +-
 fs/xfs/scrub/fscounters_repair.c   |    9 +-
 fs/xfs/scrub/health.c              |   54 +-
 fs/xfs/scrub/ialloc.c              |   16 +-
 fs/xfs/scrub/ialloc_repair.c       |   27 +-
 fs/xfs/scrub/inode.c               |   35 +-
 fs/xfs/scrub/inode_repair.c        |   39 +-
 fs/xfs/scrub/iscan.c               |    4 +-
 fs/xfs/scrub/metapath.c            |  689 ++++++++++++++++++++++++
 fs/xfs/scrub/newbt.c               |   52 +-
 fs/xfs/scrub/nlinks.c              |    4 +-
 fs/xfs/scrub/nlinks_repair.c       |    4 +-
 fs/xfs/scrub/orphanage.c           |    4 +-
 fs/xfs/scrub/parent.c              |   39 +-
 fs/xfs/scrub/parent_repair.c       |   37 +-
 fs/xfs/scrub/quotacheck.c          |    7 +-
 fs/xfs/scrub/reap.c                |   10 +-
 fs/xfs/scrub/refcount.c            |    3 +-
 fs/xfs/scrub/refcount_repair.c     |    7 +-
 fs/xfs/scrub/repair.c              |   61 ++-
 fs/xfs/scrub/repair.h              |   13 +
 fs/xfs/scrub/rgsuper.c             |   84 +++
 fs/xfs/scrub/rmap.c                |    4 +-
 fs/xfs/scrub/rmap_repair.c         |   25 +-
 fs/xfs/scrub/rtbitmap.c            |   54 +-
 fs/xfs/scrub/rtsummary.c           |  116 ++--
 fs/xfs/scrub/rtsummary_repair.c    |   22 +-
 fs/xfs/scrub/scrub.c               |   52 +-
 fs/xfs/scrub/scrub.h               |   17 +
 fs/xfs/scrub/stats.c               |    2 +
 fs/xfs/scrub/tempfile.c            |  105 ++++
 fs/xfs/scrub/tempfile.h            |    3 +
 fs/xfs/scrub/trace.c               |    1 +
 fs/xfs/scrub/trace.h               |  247 +++++----
 fs/xfs/xfs_bmap_item.c             |   26 +-
 fs/xfs/xfs_bmap_util.c             |   46 +-
 fs/xfs/xfs_buf_item_recover.c      |   67 ++-
 fs/xfs/xfs_discard.c               |  308 +++++++++--
 fs/xfs/xfs_dquot.c                 |   38 +-
 fs/xfs/xfs_dquot.h                 |   18 +-
 fs/xfs/xfs_drain.c                 |   78 ++-
 fs/xfs/xfs_drain.h                 |   22 +-
 fs/xfs/xfs_exchrange.c             |    2 +-
 fs/xfs/xfs_extent_busy.c           |  214 +++++---
 fs/xfs/xfs_extent_busy.h           |   65 +--
 fs/xfs/xfs_extfree_item.c          |  282 ++++++++--
 fs/xfs/xfs_file.c                  |   66 ++-
 fs/xfs/xfs_filestream.c            |   13 +-
 fs/xfs/xfs_fsmap.c                 |  363 +++++++------
 fs/xfs/xfs_fsmap.h                 |   15 +
 fs/xfs/xfs_fsops.c                 |   14 +-
 fs/xfs/xfs_health.c                |  278 +++++-----
 fs/xfs/xfs_icache.c                |  134 +++--
 fs/xfs/xfs_inode.c                 |   33 +-
 fs/xfs/xfs_inode.h                 |   49 +-
 fs/xfs/xfs_inode_item.c            |    7 +-
 fs/xfs/xfs_inode_item_recover.c    |    2 +-
 fs/xfs/xfs_ioctl.c                 |   46 +-
 fs/xfs/xfs_iomap.c                 |   71 ++-
 fs/xfs/xfs_iomap.h                 |    1 -
 fs/xfs/xfs_iops.c                  |   15 +-
 fs/xfs/xfs_itable.c                |   33 +-
 fs/xfs/xfs_itable.h                |    3 +
 fs/xfs/xfs_iunlink_item.c          |   13 +-
 fs/xfs/xfs_iwalk.c                 |  116 ++--
 fs/xfs/xfs_iwalk.h                 |    7 +-
 fs/xfs/xfs_log_cil.c               |    3 +-
 fs/xfs/xfs_log_recover.c           |   18 +-
 fs/xfs/xfs_message.c               |   51 ++
 fs/xfs/xfs_message.h               |   20 +-
 fs/xfs/xfs_mount.c                 |   61 ++-
 fs/xfs/xfs_mount.h                 |  113 +++-
 fs/xfs/xfs_pnfs.c                  |    3 +-
 fs/xfs/xfs_qm.c                    |  381 +++++++++++---
 fs/xfs/xfs_qm_bhv.c                |   36 +-
 fs/xfs/xfs_quota.h                 |   19 +-
 fs/xfs/xfs_refcount_item.c         |    9 +-
 fs/xfs/xfs_reflink.c               |    7 +-
 fs/xfs/xfs_rmap_item.c             |    9 +-
 fs/xfs/xfs_rtalloc.c               | 1025 ++++++++++++++++++++++++++++--------
 fs/xfs/xfs_rtalloc.h               |    6 +
 fs/xfs/xfs_stats.c                 |    7 +-
 fs/xfs/xfs_super.c                 |   75 ++-
 fs/xfs/xfs_trace.c                 |    5 +
 fs/xfs/xfs_trace.h                 |  687 ++++++++++++++++--------
 fs/xfs/xfs_trans.c                 |   97 +++-
 fs/xfs/xfs_trans.h                 |    2 +
 fs/xfs/xfs_trans_buf.c             |   25 +-
 fs/xfs/xfs_trans_dquot.c           |   17 +
 fs/xfs/xfs_xattr.c                 |    3 +-
 include/linux/iomap.h              |    4 +
 156 files changed, 9572 insertions(+), 2946 deletions(-)
 create mode 100644 fs/xfs/libxfs/xfs_group.c
 create mode 100644 fs/xfs/libxfs/xfs_group.h
 create mode 100644 fs/xfs/libxfs/xfs_metadir.c
 create mode 100644 fs/xfs/libxfs/xfs_metadir.h
 create mode 100644 fs/xfs/libxfs/xfs_metafile.c
 create mode 100644 fs/xfs/libxfs/xfs_metafile.h
 create mode 100644 fs/xfs/libxfs/xfs_rtgroup.c
 create mode 100644 fs/xfs/libxfs/xfs_rtgroup.h
 create mode 100644 fs/xfs/scrub/metapath.c
 create mode 100644 fs/xfs/scrub/rgsuper.c


