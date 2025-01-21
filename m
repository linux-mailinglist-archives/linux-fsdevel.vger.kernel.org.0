Return-Path: <linux-fsdevel+bounces-39777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A7CA17E8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 14:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA887163735
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 13:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5151F2399;
	Tue, 21 Jan 2025 13:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qe8yIPES"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C15F1F1308;
	Tue, 21 Jan 2025 13:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737464972; cv=none; b=fgbwWXACbwR9TuSk5H0XbNft1SGDpWCnhQ39q73Gwwg8cTAgYCmV98H0uinzgMA2MrD8RAQdixR8uJJeDqzTFVeUzc0CbjslblFTRMvebqb2ngXcKlJhUfhU5889dqIIGpZ8JdLVuA9Vr/ABcXzL3vYnwuvA/P2cYnmaIe7roIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737464972; c=relaxed/simple;
	bh=tOhnY1NQ7j95wqrQH6ObAODTprbfEenFUqc3H25LPb8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U2x/QxQaw52zK1QAeff5TQqfh3ycxKRuW9ZfLIQxBP6TK8+t3cH5nZcU2iFYIPbD6yEpJmJckXY+tJ9+GsFKbPWkZYkX86gxQQ/SBgV/2PP1UM+f1BCZafXguqzpJSe5l6epl0UoTmEd2Ldr/MuQZqp84PIj4xvfNxxYXNGDddM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qe8yIPES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C52C4CEDF;
	Tue, 21 Jan 2025 13:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737464972;
	bh=tOhnY1NQ7j95wqrQH6ObAODTprbfEenFUqc3H25LPb8=;
	h=Date:From:To:Cc:Subject:From;
	b=Qe8yIPESYrz78wWu1HVRTKBYo5O0R2vz1ILVWX4+y3DyBLYYAfHjH4lWEsNPXWGxF
	 CzW+gKgdk7DWfpIiekfLVvkouedbS7AuLmiDR9YLBzg7HE/o0O3VlkX92tMf57IUrH
	 yUSmxh0f2OCVRICj83UXc110vVydpy3QiWNrVyXuyoKSEHQ7UuhGHtulb+uFnx5qM9
	 P0Upl9Qz4rJldxBHZ9qejRnW8PhEqSshpEGBWpPJjkRPeNMrR0+tOmUDYuUjs3aZh4
	 Ma3qZJjQRo7NG4da+Yp7XqeLJBF917Jy7N+FFXA1gJ+Oo3Y+FUzIHuFCRjT1gDliUs
	 V5szF/1sInsIw==
Date: Tue, 21 Jan 2025 14:09:27 +0100
From: Carlos Maiolino <cem@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: xfs: new code for 6.14
Message-ID: <i6yf5ledzs4qdt5zhrpg7nz5neyygktthupap6uulpuojcx7un@phdanup4alqb>
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

This pull request are mostly focused on the implementation of reflink
and reverse-mapping support for XFS's real-time devices.
This also includes several bugfixes.

The patches are in linux-next for a few days already, and a trial
merge just now, against your TOT didn't show any conflicts.

Thanks,
Carlos.

The following changes since commit 111d36d6278756128b7d7fab787fdcbf8221cd98:

  xfs: lock dquot buffer before detaching dquot from b_li_list (2025-01-10 10:12:48 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-merge-6.14

for you to fetch changes up to ee10f6fcdb961e810d7b16be1285319c15c78ef6:

  xfs: fix buffer lookup vs release race (2025-01-16 10:19:59 +0100)

----------------------------------------------------------------
New XFS code for 6.14

* Implement reflink support for the realtime device
* Implement reverse-mapping support for the realtime device
* Several bug fixes and cleanups

Signed-off-by: Carlos Maiolino <cem@kernel.org>

----------------------------------------------------------------
Carlos Maiolino (5):
      Merge tag 'xfs-6.13-fixes_2024-12-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into for-next
      Merge tag 'btree-ifork-records_2024-12-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into for-next
      Merge tag 'reserve-rt-metadata-space_2024-12-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into for-next
      Merge tag 'realtime-rmap_2024-12-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into for-next
      Merge tag 'realtime-reflink_2024-12-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into for-next

Christoph Hellwig (25):
      xfs: refactor xfs_reflink_find_shared
      xfs: mark xfs_dir_isempty static
      xfs: remove XFS_ILOG_NONCORE
      xfs: remove the t_magic field in struct xfs_trans
      xfs: fix the comment above xfs_discard_endio
      xfs: don't take m_sb_lock in xfs_fs_statfs
      xfs: refactor xfs_fs_statfs
      xfs: constify feature checks
      xfs: fix a double completion for buffers on in-memory targets
      xfs: remove the incorrect comment above xfs_buf_free_maps
      xfs: remove the incorrect comment about the b_pag field
      xfs: move xfs_buf_iowait out of (__)xfs_buf_submit
      xfs: simplify xfs_buf_delwri_pushbuf
      xfs: remove xfs_buf_delwri_submit_buffers
      xfs: move write verification out of _xfs_buf_ioapply
      xfs: move in-memory buftarg handling out of _xfs_buf_ioapply
      xfs: simplify buffer I/O submission
      xfs: move invalidate_kernel_vmap_range to xfs_buf_ioend
      xfs: remove the extra buffer reference in xfs_buf_submit
      xfs: always complete the buffer inline in xfs_buf_submit
      xfs: simplify xfsaild_resubmit_item
      xfs: move b_li_list based retry handling to common code
      xfs: add a b_iodone callback to struct xfs_buf
      xfs: check for dead buffers in xfs_buf_find_insert
      xfs: fix buffer lookup vs release race

Darrick J. Wong (91):
      xfs: don't over-report free space or inodes in statvfs
      xfs: tidy up xfs_iroot_realloc
      xfs: release the dquot buf outside of qli_lock
      xfs: refactor the inode fork memory allocation functions
      xfs: make xfs_iroot_realloc take the new numrecs instead of deltas
      xfs: make xfs_iroot_realloc a bmap btree function
      xfs: tidy up xfs_bmap_broot_realloc a bit
      xfs: hoist the node iroot update code out of xfs_btree_new_iroot
      xfs: hoist the node iroot update code out of xfs_btree_kill_iroot
      xfs: add some rtgroup inode helpers
      xfs: prepare rmap btree cursor tracepoints for realtime
      xfs: prepare to reuse the dquot pointer space in struct xfs_inode
      xfs: simplify the xfs_rmap_{alloc,free}_extent calling conventions
      xfs: support storing records in the inode core root
      xfs: allow inode-based btrees to reserve space in the data device
      xfs: introduce realtime rmap btree ondisk definitions
      xfs: realtime rmap btree transaction reservations
      xfs: add realtime rmap btree operations
      xfs: prepare rmap functions to deal with rtrmapbt
      xfs: add a realtime flag to the rmap update log redo items
      xfs: support recovering rmap intent items targetting realtime extents
      xfs: pretty print metadata file types in error messages
      xfs: support file data forks containing metadata btrees
      xfs: add realtime reverse map inode to metadata directory
      xfs: add metadata reservations for realtime rmap btrees
      xfs: wire up a new metafile type for the realtime rmap
      xfs: wire up rmap map and unmap to the realtime rmapbt
      xfs: create routine to allocate and initialize a realtime rmap btree inode
      xfs: wire up getfsmap to the realtime reverse mapping btree
      xfs: check that the rtrmapbt maxlevels doesn't increase when growing fs
      xfs: report realtime rmap btree corruption errors to the health system
      xfs: allow queued realtime intents to drain before scrubbing
      xfs: scrub the realtime rmapbt
      xfs: cross-reference realtime bitmap to realtime rmapbt scrubber
      xfs: cross-reference the realtime rmapbt
      xfs: scan rt rmap when we're doing an intense rmap check of bmbt mappings
      xfs: scrub the metadir path of rt rmap btree files
      xfs: walk the rt reverse mapping tree when rebuilding rmap
      xfs: online repair of realtime file bmaps
      xfs: repair inodes that have realtime extents
      xfs: repair rmap btree inodes
      xfs: online repair of realtime bitmaps for a realtime group
      xfs: support repairing metadata btrees rooted in metadir inodes
      xfs: online repair of the realtime rmap btree
      xfs: create a shadow rmap btree during realtime rmap repair
      xfs: hook live realtime rmap operations during a repair operation
      xfs: don't shut down the filesystem for media failures beyond end of log
      xfs: react to fsdax failure notifications on the rt device
      xfs: enable realtime rmap btree
      xfs: prepare refcount btree cursor tracepoints for realtime
      xfs: namespace the maximum length/refcount symbols
      xfs: introduce realtime refcount btree ondisk definitions
      xfs: realtime refcount btree transaction reservations
      xfs: add realtime refcount btree operations
      xfs: prepare refcount functions to deal with rtrefcountbt
      xfs: add a realtime flag to the refcount update log redo items
      xfs: support recovering refcount intent items targetting realtime extents
      xfs: add realtime refcount btree block detection to log recovery
      xfs: add realtime refcount btree inode to metadata directory
      xfs: add metadata reservations for realtime refcount btree
      xfs: wire up a new metafile type for the realtime refcount
      xfs: wire up realtime refcount btree cursors
      xfs: create routine to allocate and initialize a realtime refcount btree inode
      xfs: update rmap to allow cow staging extents in the rt rmap
      xfs: compute rtrmap btree max levels when reflink enabled
      xfs: refactor reflink quota updates
      xfs: enable CoW for realtime data
      xfs: enable sharing of realtime file blocks
      xfs: allow inodes to have the realtime and reflink flags
      xfs: recover CoW leftovers in the realtime volume
      xfs: fix xfs_get_extsz_hint behavior with realtime alwayscow files
      xfs: apply rt extent alignment constraints to CoW extsize hint
      xfs: enable extent size hints for CoW operations
      xfs: check that the rtrefcount maxlevels doesn't increase when growing fs
      xfs: report realtime refcount btree corruption errors to the health system
      xfs: scrub the realtime refcount btree
      xfs: cross-reference checks with the rt refcount btree
      xfs: allow overlapping rtrmapbt records for shared data extents
      xfs: check reference counts of gaps between rt refcount records
      xfs: allow dquot rt block count to exceed rt blocks on reflink fs
      xfs: detect and repair misaligned rtinherit directory cowextsize hints
      xfs: scrub the metadir path of rt refcount btree files
      xfs: don't flag quota rt block usage on rtreflink filesystems
      xfs: check new rtbitmap records against rt refcount btree
      xfs: walk the rt reference count tree when rebuilding rmap
      xfs: capture realtime CoW staging extents when rebuilding rt rmapbt
      xfs: online repair of the realtime refcount btree
      xfs: repair inodes that have a refcount btree in the data fork
      xfs: check for shared rt extents when rebuilding rt file's data fork
      xfs: fix CoW forks for realtime files
      xfs: enable realtime reflink

Long Li (4):
      xfs: fix mount hang during primary superblock recovery failure
      xfs: clean up xfs_end_ioend() to reuse local variables
      xfs: remove redundant update for ticket->t_curr_res in xfs_log_ticket_regrant
      xfs: remove bp->b_error check in xfs_attr3_root_inactive

Mirsad Todorovac (1):
      xfs/libxfs: replace kmalloc() and memcpy() with kmemdup()

 fs/xfs/Makefile                      |    6 +
 fs/xfs/libxfs/xfs_ag_resv.c          |    3 +
 fs/xfs/libxfs/xfs_attr.c             |    4 +-
 fs/xfs/libxfs/xfs_bmap.c             |   34 +-
 fs/xfs/libxfs/xfs_bmap_btree.c       |  111 ++++
 fs/xfs/libxfs/xfs_bmap_btree.h       |    3 +
 fs/xfs/libxfs/xfs_btree.c            |  411 +++++++++++---
 fs/xfs/libxfs/xfs_btree.h            |   28 +-
 fs/xfs/libxfs/xfs_btree_mem.c        |    1 +
 fs/xfs/libxfs/xfs_btree_staging.c    |   10 +-
 fs/xfs/libxfs/xfs_defer.h            |    2 +
 fs/xfs/libxfs/xfs_dir2.c             |    9 +-
 fs/xfs/libxfs/xfs_dir2.h             |    1 -
 fs/xfs/libxfs/xfs_errortag.h         |    4 +-
 fs/xfs/libxfs/xfs_exchmaps.c         |    4 +-
 fs/xfs/libxfs/xfs_format.h           |   51 +-
 fs/xfs/libxfs/xfs_fs.h               |   10 +-
 fs/xfs/libxfs/xfs_health.h           |    6 +-
 fs/xfs/libxfs/xfs_inode_buf.c        |   65 ++-
 fs/xfs/libxfs/xfs_inode_fork.c       |  201 +++----
 fs/xfs/libxfs/xfs_inode_fork.h       |    6 +-
 fs/xfs/libxfs/xfs_log_format.h       |   16 +-
 fs/xfs/libxfs/xfs_log_recover.h      |    4 +
 fs/xfs/libxfs/xfs_metadir.c          |    4 +
 fs/xfs/libxfs/xfs_metafile.c         |  223 ++++++++
 fs/xfs/libxfs/xfs_metafile.h         |   13 +
 fs/xfs/libxfs/xfs_ondisk.h           |    4 +
 fs/xfs/libxfs/xfs_refcount.c         |  278 +++++++--
 fs/xfs/libxfs/xfs_refcount.h         |   23 +-
 fs/xfs/libxfs/xfs_rmap.c             |  178 ++++--
 fs/xfs/libxfs/xfs_rmap.h             |   12 +-
 fs/xfs/libxfs/xfs_rtbitmap.c         |    2 +-
 fs/xfs/libxfs/xfs_rtbitmap.h         |    9 +
 fs/xfs/libxfs/xfs_rtgroup.c          |   74 ++-
 fs/xfs/libxfs/xfs_rtgroup.h          |   58 +-
 fs/xfs/libxfs/xfs_rtrefcount_btree.c |  757 +++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_rtrefcount_btree.h |  189 +++++++
 fs/xfs/libxfs/xfs_rtrmap_btree.c     | 1035 ++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_rtrmap_btree.h     |  210 +++++++
 fs/xfs/libxfs/xfs_sb.c               |   14 +
 fs/xfs/libxfs/xfs_shared.h           |   21 +
 fs/xfs/libxfs/xfs_trans_resv.c       |   37 +-
 fs/xfs/libxfs/xfs_trans_space.h      |   13 +
 fs/xfs/libxfs/xfs_types.h            |    7 +
 fs/xfs/scrub/agheader_repair.c       |    2 +-
 fs/xfs/scrub/alloc_repair.c          |    5 +-
 fs/xfs/scrub/bmap.c                  |  126 ++++-
 fs/xfs/scrub/bmap_repair.c           |  148 ++++-
 fs/xfs/scrub/common.c                |  170 +++++-
 fs/xfs/scrub/common.h                |   26 +-
 fs/xfs/scrub/cow_repair.c            |  180 +++++-
 fs/xfs/scrub/health.c                |    2 +
 fs/xfs/scrub/inode.c                 |   41 +-
 fs/xfs/scrub/inode_repair.c          |  193 ++++++-
 fs/xfs/scrub/metapath.c              |    6 +
 fs/xfs/scrub/newbt.c                 |   42 ++
 fs/xfs/scrub/newbt.h                 |    1 +
 fs/xfs/scrub/quota.c                 |    8 +-
 fs/xfs/scrub/quota_repair.c          |    2 +-
 fs/xfs/scrub/reap.c                  |  288 +++++++++-
 fs/xfs/scrub/reap.h                  |    9 +
 fs/xfs/scrub/refcount.c              |    2 +-
 fs/xfs/scrub/refcount_repair.c       |    6 +-
 fs/xfs/scrub/repair.c                |  197 +++++++
 fs/xfs/scrub/repair.h                |   24 +
 fs/xfs/scrub/rgb_bitmap.h            |   37 ++
 fs/xfs/scrub/rgsuper.c               |    6 +-
 fs/xfs/scrub/rmap_repair.c           |   91 ++-
 fs/xfs/scrub/rtb_bitmap.h            |   37 ++
 fs/xfs/scrub/rtbitmap.c              |   77 ++-
 fs/xfs/scrub/rtbitmap.h              |   55 ++
 fs/xfs/scrub/rtbitmap_repair.c       |  451 ++++++++++++++-
 fs/xfs/scrub/rtrefcount.c            |  661 ++++++++++++++++++++++
 fs/xfs/scrub/rtrefcount_repair.c     |  783 +++++++++++++++++++++++++
 fs/xfs/scrub/rtrmap.c                |  323 +++++++++++
 fs/xfs/scrub/rtrmap_repair.c         | 1006 +++++++++++++++++++++++++++++++++
 fs/xfs/scrub/rtsummary.c             |   17 +-
 fs/xfs/scrub/rtsummary_repair.c      |    3 +-
 fs/xfs/scrub/scrub.c                 |   18 +-
 fs/xfs/scrub/scrub.h                 |   28 +-
 fs/xfs/scrub/stats.c                 |    2 +
 fs/xfs/scrub/tempexch.h              |    2 +-
 fs/xfs/scrub/tempfile.c              |   21 +-
 fs/xfs/scrub/trace.c                 |    1 +
 fs/xfs/scrub/trace.h                 |  280 ++++++++-
 fs/xfs/xfs_aops.c                    |    2 +-
 fs/xfs/xfs_attr_inactive.c           |    5 -
 fs/xfs/xfs_buf.c                     |  606 ++++++++------------
 fs/xfs/xfs_buf.h                     |   11 +-
 fs/xfs/xfs_buf_item.h                |    5 -
 fs/xfs/xfs_buf_item_recover.c        |   19 +-
 fs/xfs/xfs_discard.c                 |    2 +-
 fs/xfs/xfs_dquot.c                   |   26 +-
 fs/xfs/xfs_dquot.h                   |    3 +
 fs/xfs/xfs_drain.c                   |   20 +-
 fs/xfs/xfs_drain.h                   |    7 +-
 fs/xfs/xfs_error.c                   |    3 +
 fs/xfs/xfs_exchrange.c               |    3 +
 fs/xfs/xfs_fsmap.c                   |  193 ++++++-
 fs/xfs/xfs_fsops.c                   |   30 +
 fs/xfs/xfs_health.c                  |    2 +
 fs/xfs/xfs_inode.c                   |   19 +-
 fs/xfs/xfs_inode.h                   |   16 +-
 fs/xfs/xfs_inode_item.c              |   30 +-
 fs/xfs/xfs_inode_item_recover.c      |   48 +-
 fs/xfs/xfs_ioctl.c                   |   21 +-
 fs/xfs/xfs_log.c                     |    2 -
 fs/xfs/xfs_log_recover.c             |    4 +
 fs/xfs/xfs_mount.c                   |   14 +
 fs/xfs/xfs_mount.h                   |   25 +-
 fs/xfs/xfs_notify_failure.c          |  230 +++++---
 fs/xfs/xfs_notify_failure.h          |   11 +
 fs/xfs/xfs_qm.c                      |   10 +-
 fs/xfs/xfs_qm_bhv.c                  |   26 +-
 fs/xfs/xfs_quota.h                   |    5 -
 fs/xfs/xfs_refcount_item.c           |  240 +++++++-
 fs/xfs/xfs_reflink.c                 |  321 ++++++++---
 fs/xfs/xfs_reflink.h                 |    4 +-
 fs/xfs/xfs_rmap_item.c               |  216 ++++++-
 fs/xfs/xfs_rtalloc.c                 |  121 +++-
 fs/xfs/xfs_rtalloc.h                 |   20 +
 fs/xfs/xfs_stats.c                   |    5 +-
 fs/xfs/xfs_stats.h                   |    3 +
 fs/xfs/xfs_super.c                   |  142 +++--
 fs/xfs/xfs_super.h                   |    1 -
 fs/xfs/xfs_trace.h                   |  270 ++++++---
 fs/xfs/xfs_trans.c                   |    6 +-
 fs/xfs/xfs_trans.h                   |    1 -
 fs/xfs/xfs_trans_ail.c               |    9 +-
 fs/xfs/xfs_trans_buf.c               |    8 +-
 fs/xfs/xfs_trans_dquot.c             |    8 +-
 131 files changed, 10861 insertions(+), 1440 deletions(-)
 create mode 100644 fs/xfs/libxfs/xfs_rtrefcount_btree.c
 create mode 100644 fs/xfs/libxfs/xfs_rtrefcount_btree.h
 create mode 100644 fs/xfs/libxfs/xfs_rtrmap_btree.c
 create mode 100644 fs/xfs/libxfs/xfs_rtrmap_btree.h
 create mode 100644 fs/xfs/scrub/rgb_bitmap.h
 create mode 100644 fs/xfs/scrub/rtb_bitmap.h
 create mode 100644 fs/xfs/scrub/rtrefcount.c
 create mode 100644 fs/xfs/scrub/rtrefcount_repair.c
 create mode 100644 fs/xfs/scrub/rtrmap.c
 create mode 100644 fs/xfs/scrub/rtrmap_repair.c
 create mode 100644 fs/xfs/xfs_notify_failure.h

