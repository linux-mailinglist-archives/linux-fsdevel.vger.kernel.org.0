Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22D9292C8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Oct 2020 19:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbgJSRU5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Oct 2020 13:20:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730773AbgJSRU5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Oct 2020 13:20:57 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DA4421741;
        Mon, 19 Oct 2020 17:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603128056;
        bh=JsjhxwQ0x2TfWUlCF3HFowvwJyL/r/XdlkjjzaDu+is=;
        h=Date:From:To:Cc:Subject:From;
        b=LBFofpDHDkX/zr474edd4u5TCPlS33oUsb3lt5hZZjnv+GxcZnqARRYKAwjQ6n8hY
         bc0DAVcS1FdlwmnuJxj8G0bokXvQ7PR/sC0LZ0Ol7WjY2CGGDIfRTeuPmCabk5OrAG
         av5LpjsmWxuB4gxy+1G5uwVpygaGpymadRZFoon4=
Date:   Mon, 19 Oct 2020 10:20:55 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: new code for 5.10, part 2
Message-ID: <20201019172055.GK9832@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this second large pile of new stuff for 5.10, with changes
even more monumental than last week!  We are formally announcing the
deprecation of the V4 filesystem format in 2030.  All users must upgrade
to the V5 format, which contains design improvements that greatly
strengthen metadata validation, supports reflink and online fsck, and is
the intended vehicle for handling timestamps past 2038.  We're also
deprecating the old Irix behavioral tweaks in September 2025.

Coming along for the ride are two design changes to the deferred
metadata ops subsystem.  One of the improvements is to retain correct
logical ordering of tasks and subtasks, which is a more logical design
for upper layers of XFS and will become necessary when we add atomic
file range swaps and commits.  The second improvement to deferred ops
improves the scalability of the log by helping the log tail to move
forward during long-running operations.  This reduces log contention
when there are a large number of threads trying to run transactions.

In addition to that, this pull request fixes numerous small bugs in log
recovery; refactors logical intent log item recovery to remove the last
remaining place in XFS where we could have nested transactions; fixes a
couple of ways that intent log item recovery could fail in ways that
wouldn't have happened in the regular commit paths; fixes a deadlock
vector in the GETFSMAP implementation (which improves its performance by
20%); and fixes serious bugs in the realtime growfs, fallocate, and
bitmap handling code.

I anticipate sending a third pull request in a few days with bug fixes,
but otherwise that's it for XFS for 5.10. :)

The branch merges cleanly with upstream as of a few minutes ago, so
please let me know if anything strange happens.

--D

The following changes since commit fe341eb151ec0ba80fb74edd6201fc78e5232b6b:

  xfs: ensure that fpunch, fcollapse, and finsert operations are aligned to rt extent size (2020-09-15 20:52:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.10-merge-5

for you to fetch changes up to 894645546bb12ce008dcba0f68834d270fcd1dde:

  xfs: fix Kconfig asking about XFS_SUPPORT_V4 when XFS_FS=n (2020-10-16 15:34:28 -0700)

----------------------------------------------------------------
Recalling the first round of new code for 5.10, in which we added:
- New feature: Widen inode timestamps and quota grace expiration
  timestamps to support dates through the year 2486.
- New feature: storing inode btree counts in the AGI to speed up certain
  mount time per-AG block reservation operatoins and add a little more
  metadata redundancy.

For the second round of new code for 5.10:
- Deprecate the V4 filesystem format, some disused mount options, and some
  legacy sysctl knobs now that we can support dates into the 25th century.
  Note that removal of V4 support will not happen until the early 2030s.
- Fix some probles with inode realtime flag propagation.
- Fix some buffer handling issues when growing a rt filesystem.
- Fix a problem where a BMAP_REMAP unmap call would free rt extents even
  though the purpose of BMAP_REMAP is to avoid freeing the blocks.
- Strengthen the dabtree online scrubber to check hash values on child
  dabtree blocks.
- Actually log new intent items created as part of recovering log intent
  items.
- Fix a bug where quotas weren't attached to an inode undergoing bmap
  intent item recovery.
- Fix a buffer overrun problem with specially crafted log buffer
  headers.
- Various cleanups to type usage and slightly inaccurate comments.
- More cleanups to the xattr, log, and quota code.
- Don't run the (slower) shared-rmap operations on attr fork mappings.
- Fix a bug where we failed to check the LSN of finobt blocks during
  replay and could therefore overwrite newer data with older data.
- Clean up the ugly nested transaction mess that log recovery uses to
  stage intent item recovery in the correct order by creating a proper
  data structure to capture recovered chains.
- Use the capture structure to resume intent item chains with the
  same log space and block reservations as when they were captured.
- Fix a UAF bug in bmap intent item recovery where we failed to maintain
  our reference to the incore inode if the bmap operation needed to
  relog itself to continue.
- Rearrange the defer ops mechanism to finish newly created subtasks
  of a parent task before moving on to the next parent task.
- Automatically relog intent items in deferred ops chains if doing so
  would help us avoid pinning the log tail.  This will help fix some
  log scaling problems now and will facilitate atomic file updates later.
- Fix a deadlock in the GETFSMAP implementation by using an internal
  memory buffer to reduce indirect calls and copies to userspace,
  thereby improving its performance by ~20%.
- Fix various problems when calling growfs on a realtime volume would
  not fully update the filesystem metadata.
- Fix broken Kconfig asking about deprecated XFS when XFS is disabled.

----------------------------------------------------------------
Brian Foster (1):
      xfs: drop extra transaction roll from inode extent truncate

Chandan Babu R (2):
      xfs: Set xfs_buf type flag when growing summary/bitmap files
      xfs: Set xfs_buf's b_ops member when zeroing bitmap/summary files

Darrick J. Wong (28):
      xfs: refactor inode flags propagation code
      xfs: don't propagate RTINHERIT -> REALTIME when there is no rtdev
      xfs: deprecate the V4 format
      xfs: don't free rt blocks when we're doing a REMAP bunmapi call
      xfs: check dabtree node hash values when loading child blocks
      xfs: log new intent items created as part of finishing recovered intent items
      xfs: attach inode to dquot in xfs_bui_item_recover
      xfs: don't release log intent items when recovery fails
      xfs: avoid shared rmap operations for attr fork extents
      xfs: remove xfs_defer_reset
      xfs: remove XFS_LI_RECOVERED
      xfs: proper replay of deferred ops queued during log recovery
      xfs: xfs_defer_capture should absorb remaining block reservations
      xfs: xfs_defer_capture should absorb remaining transaction reservation
      xfs: clean up bmap intent item recovery checking
      xfs: clean up xfs_bui_item_recover iget/trans_alloc/ilock ordering
      xfs: fix an incore inode UAF in xfs_bui_recover
      xfs: change the order in which child and parent defer ops are finished
      xfs: periodically relog deferred intent items
      xfs: expose the log push threshold
      xfs: only relog deferred intent items if free space in the log gets low
      xfs: limit entries returned when counting fsmap records
      xfs: fix deadlock and streamline xfs_getfsmap performance
      xfs: fix realtime bitmap/summary file truncation when growing rt volume
      xfs: make xfs_growfs_rt update secondary superblocks
      xfs: annotate grabbing the realtime bitmap/summary locks in growfs
      xfs: fix high key handling in the rt allocator's query_range function
      xfs: fix Kconfig asking about XFS_SUPPORT_V4 when XFS_FS=n

Dave Chinner (1):
      xfs: fix finobt btree block recovery ordering

Gao Xiang (3):
      xfs: avoid LR buffer overrun due to crafted h_len
      xfs: clean up calculation of LR header blocks
      xfs: drop the obsolete comment on filestream locking

Kaixu Xia (11):
      xfs: remove the unused SYNCHRONIZE macro
      xfs: use the existing type definition for di_projid
      xfs: remove the unnecessary xfs_dqid_t type cast
      xfs: fix some comments
      xfs: remove the redundant crc feature check in xfs_attr3_rmt_verify
      xfs: remove the unused parameter id from xfs_qm_dqattach_one
      xfs: do the assert for all the log done items in xfs_trans_cancel
      xfs: code cleanup in xfs_attr_leaf_entsize_{remote,local}
      xfs: directly call xfs_generic_create() for ->create() and ->mkdir()
      xfs: do the ASSERT for the arguments O_{u,g,p}dqpp
      xfs: fix the indent in xfs_trans_mod_dquot

Pavel Reichl (2):
      xfs: remove deprecated mount options
      xfs: remove deprecated sysctl options

 Documentation/admin-guide/xfs.rst |  32 +++++-
 fs/xfs/Kconfig                    |  25 ++++
 fs/xfs/libxfs/xfs_attr_remote.c   |   2 -
 fs/xfs/libxfs/xfs_bmap.c          |  19 ++--
 fs/xfs/libxfs/xfs_da_format.h     |  18 +--
 fs/xfs/libxfs/xfs_defer.c         | 232 ++++++++++++++++++++++++++++++++++----
 fs/xfs/libxfs/xfs_defer.h         |  37 ++++++
 fs/xfs/libxfs/xfs_inode_buf.h     |   2 +-
 fs/xfs/libxfs/xfs_rmap.c          |  27 +++--
 fs/xfs/libxfs/xfs_rtbitmap.c      |  11 +-
 fs/xfs/scrub/dabtree.c            |  14 +++
 fs/xfs/xfs_bmap_item.c            | 136 +++++++++++-----------
 fs/xfs/xfs_buf_item_recover.c     |   2 +
 fs/xfs/xfs_dquot.c                |   4 +-
 fs/xfs/xfs_extfree_item.c         |  44 ++++++--
 fs/xfs/xfs_filestream.c           |  34 +-----
 fs/xfs/xfs_fsmap.c                |  48 ++++----
 fs/xfs/xfs_fsmap.h                |   6 +-
 fs/xfs/xfs_inode.c                | 123 +++++++++++---------
 fs/xfs/xfs_ioctl.c                | 146 ++++++++++++++++--------
 fs/xfs/xfs_iops.c                 |   4 +-
 fs/xfs/xfs_linux.h                |   1 -
 fs/xfs/xfs_log.c                  |  44 +++++---
 fs/xfs/xfs_log.h                  |   2 +
 fs/xfs/xfs_log_recover.c          | 221 ++++++++++++++++++------------------
 fs/xfs/xfs_qm.c                   |  16 +--
 fs/xfs/xfs_refcount_item.c        |  51 +++++----
 fs/xfs/xfs_rmap_item.c            |  42 +++++--
 fs/xfs/xfs_rtalloc.c              |  31 ++++-
 fs/xfs/xfs_stats.c                |   4 +
 fs/xfs/xfs_stats.h                |   1 +
 fs/xfs/xfs_super.c                |  44 +++++---
 fs/xfs/xfs_sysctl.c               |  36 +++++-
 fs/xfs/xfs_trace.h                |   1 +
 fs/xfs/xfs_trans.c                |   2 +-
 fs/xfs/xfs_trans.h                |  33 +++++-
 fs/xfs/xfs_trans_dquot.c          |  43 +++----
 37 files changed, 1026 insertions(+), 512 deletions(-)
