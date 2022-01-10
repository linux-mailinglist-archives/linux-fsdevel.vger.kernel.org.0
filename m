Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9309D48A26C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jan 2022 23:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241441AbiAJWGT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 17:06:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50110 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240960AbiAJWGS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:06:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E442B8180C;
        Mon, 10 Jan 2022 22:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED69C36AE9;
        Mon, 10 Jan 2022 22:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641852376;
        bh=0EknUIecnauWxeDKBTherSAPBBzXTdCu/8DysfmHeQc=;
        h=Date:From:To:Cc:Subject:From;
        b=DsqDjduXjGcJL/m+4zf3/kFjC3DcMLMLNwFj0dWWsqNPDTYM7drDmVjN4x+gT+moN
         OxaJCCJzAoWiIqK+n6olTqp5lbbyMliNYd4IO4FtiQIdVRCygo0t46BNRfZ1tib7jM
         IZeqEamENLNSwPuO2GFN4odNOPoG9mct8MMdXQdpWil3qkQ5vpsHEeKaSvLqTjnSEu
         XU2E3JtJEvsaHf+nVtDvxMN7CF1PZq9mP+8yg52hU5rSfnU/p78QFGPDErH4mfIKw7
         55COssmfGNU3MHMtGo9BeZrbWmsGbIJn7xjooG7FL/mTNzj1mYpS351Cnw3HW48sTA
         4s6hP982+u5+w==
Date:   Mon, 10 Jan 2022 14:06:15 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: new code for 5.17
Message-ID: <20220110220615.GA656707@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this new code for Linux 5.17.  The big new feature here is
that the mount code now only bothers to try to free stale COW staging
extents if the fs unmounted uncleanly.  This should reduce mount times,
particularly on filesystems supporting reflink and containing a large
number of allocation groups.

Everything else this cycle are bugfixes, as the iomap folios conversion
should be plenty enough excitement for anyone.  That and I ran out of
brain bandwidth after Thanksgiving last year.

The branch merges cleanly against upstream as of a few minutes ago.
Please let me know if anything else strange happens during the merge
process.  There will definitely be a second pull request coming with
at least one more bug fix and most probably a full withdrawal of the
recently troublesome ALLOCSP ioctl family.

--D

The following changes since commit 2585cf9dfaaddf00b069673f27bb3f8530e2039c:

  Linux 5.16-rc5 (2021-12-12 14:53:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.17-merge-2

for you to fetch changes up to 7e937bb3cbe1f6b9840a43f879aa6e3f1a5e6537:

  xfs: warn about inodes with project id of -1 (2022-01-06 10:43:30 -0800)

----------------------------------------------------------------
New code for 5.17:
 - Fix log recovery with da btree buffers when metauuid is in use.
 - Fix type coercion problems in xattr buffer size validation.
 - Fix a bug in online scrub dir leaf bestcount checking.
 - Only run COW recovery when recovering the log.
 - Fix symlink target buffer UAF problems and symlink locking problems
   by not exposing xfs innards to the VFS.
 - Fix incorrect quotaoff lock usage.
 - Don't let transactions cancel cleanly if they have deferred work
   items attached.
 - Fix a UAF when we're deciding if we need to relog an intent item.
 - Reduce kvmalloc overhead for log shadow buffers.
 - Clean up sysfs attr group usage.
 - Fix a bug where scrub's bmap/rmap checking could race with a quota
   file block allocation due to insufficient locking.
 - Teach scrub to complain about invalid project ids.

----------------------------------------------------------------
Dan Carpenter (1):
      xfs: prevent a WARN_ONCE() in xfs_ioc_attr_list()

Darrick J. Wong (8):
      xfs: shut down filesystem if we xfs_trans_cancel with deferred work items
      xfs: fix quotaoff mutex usage now that we don't support disabling it
      xfs: don't expose internal symlink metadata buffers to the vfs
      xfs: only run COW extent recovery when there are no live extents
      xfs: fix a bug in the online fsck directory leaf1 bestcount check
      xfs: prevent UAF in xfs_log_item_in_current_chkpt
      xfs: hold quota inode ILOCK_EXCL until the end of dqalloc
      xfs: warn about inodes with project id of -1

Dave Chinner (2):
      xfs: check sb_meta_uuid for dabuf buffer recovery
      xfs: reduce kvmalloc overhead for CIL shadow buffers

Greg Kroah-Hartman (1):
      xfs: sysfs: use default_groups in kobj_type

Jiapeng Chong (1):
      xfs: Remove redundant assignment of mp

Yang Xu (1):
      xfs: Fix comments mentioning xfs_ialloc

 fs/xfs/scrub/dir.c            | 15 +++++---
 fs/xfs/scrub/inode.c          | 14 ++++++++
 fs/xfs/scrub/quota.c          |  4 +--
 fs/xfs/scrub/repair.c         |  3 ++
 fs/xfs/scrub/scrub.c          |  4 ---
 fs/xfs/scrub/scrub.h          |  1 -
 fs/xfs/xfs_buf_item_recover.c |  2 +-
 fs/xfs/xfs_dquot.c            | 79 +++++++++++++++----------------------------
 fs/xfs/xfs_error.c            |  3 +-
 fs/xfs/xfs_icache.c           |  3 +-
 fs/xfs/xfs_ioctl.c            |  2 +-
 fs/xfs/xfs_ioctl.h            |  5 +--
 fs/xfs/xfs_iops.c             | 40 +++-------------------
 fs/xfs/xfs_log_cil.c          | 52 ++++++++++++++++++++--------
 fs/xfs/xfs_log_recover.c      | 26 ++++++++++++--
 fs/xfs/xfs_mount.c            | 10 ------
 fs/xfs/xfs_qm_syscalls.c      | 11 +-----
 fs/xfs/xfs_reflink.c          |  5 ++-
 fs/xfs/xfs_super.c            |  9 -----
 fs/xfs/xfs_symlink.c          | 27 ++++++++++-----
 fs/xfs/xfs_sysfs.c            | 16 +++++----
 fs/xfs/xfs_trans.c            | 11 +++++-
 22 files changed, 175 insertions(+), 167 deletions(-)
