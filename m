Return-Path: <linux-fsdevel+bounces-44768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 759C5A6C909
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 11:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20ADB1B640CD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 10:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBC81F541E;
	Sat, 22 Mar 2025 10:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaYNKqo5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4819C1F4E48;
	Sat, 22 Mar 2025 10:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638498; cv=none; b=DnQEHh7lH8MTci5nOKlTZKV5MEssAL5+LX6JLU7CxbSz/OTLvde1JKpzO72cfebCvuH5wnPL4RTS4jEOQt8Ew/VaZQGlR5B+bCFvGEVDb53YCZN5CLVoWzRaFZb23kjfrWDJeb3oc7OrhyT9h2zFhhgRSIn7PALOa6VKr7u2mx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638498; c=relaxed/simple;
	bh=LMzpCqkJQeJGuXfWMz8L6MPk0I3cjNqoGDAnPW0rq4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OZwBJk3FbbH50wqHo4X48p+iPy8Zq8q5ObMGNnXlTHmBj7z+E1+eHAaWr29iMWoA+sMHBs+iD+4c6vpKxICxMvKHTcktQxQfekAwoo4oJbiGQtd9HPQj6ViLAfZQHX6c7oy+ioQGqA5GE3ik/tt4a9f4LR7rQwnjAI6frsOckR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaYNKqo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A48EC4CEDD;
	Sat, 22 Mar 2025 10:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742638497;
	bh=LMzpCqkJQeJGuXfWMz8L6MPk0I3cjNqoGDAnPW0rq4I=;
	h=From:To:Cc:Subject:Date:From;
	b=eaYNKqo5OX9pAMBpeDnkNIsddBnP86Xha2ARGz59XRW/Vq80s3G2VDLlwXBsZU2gr
	 7ZLbwJPJ0/QEoChwc5MoxB17Jk0BQFyKmFAjZnesIOEK97PSLbVI8gaznIQU0XfC8I
	 Txwy3SOq1hMyMgKowZr9+Ec7DGmEvExv1p9rBz/6schPrCUhEd55IfjN76TQWMQ1P5
	 cESK0W5LaVce75fc9tm03vJRuNhtT4BZSb9m6bvc1Z1HxDfn/16ib6tJAXVw+Yu4vd
	 bGbmwOoYEonMsCfPdIpU2v+QOyPuILPHC8n2zyzEZTeLtOAqVreUn9jsY22a5EClIp
	 5PNuSjyfVpt9g==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs iomap
Date: Sat, 22 Mar 2025 11:14:48 +0100
Message-ID: <20250322-vfs-iomap-a2f096e9d3fd@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6691; i=brauner@kernel.org; h=from:subject:message-id; bh=LMzpCqkJQeJGuXfWMz8L6MPk0I3cjNqoGDAnPW0rq4I=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTf6531Syvgk2u8Yqc4Q+A71/apRyrfyE7uefV1+y6Ot ich6tJtHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5+ZXhf6T5/3RnE+mSY+aT zoXazxS3W2Iv9e6yxMkP039Xz8zQWM7wh4ftwtGJys5ODja7uD9JZvy90yb71/JhjFSLH/+Oj6n HWAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains the iomap changes for this cycle:

- Allow the filesystem to submit the writeback bios.

  - Allow the filsystem to track completions on a per-bio bases instead
    of the entire I/O.

  - Change writeback_ops so that ->submit_bio can be done by the filesystem.

  - A new ANON_WRITE flag for writes that don't have a block number
    assigned to them at the iomap level leaving the filesystem to do
    that work in the submission handler.


- Incremental iterator advance

  The folio_batch support for zero range where the filesystem provides a
  batch of folios to process that might not be logically continguous
  requires more flexibility than the current offset based iteration
  currently offers.

  Update all iomap operations to advance the iterator within the
  operation and thus remove the need to advance from the core iomap
  iterator.

- Make buffered writes work with RWF_DONTCACHE

  If RWF_DONTCACHE is set for a write, mark the folios being written as
  uncached. On writeback completion the pages will be dropped.

- Introduce infrastructure for large atomic writes

  This will eventually be used by xfs and ext4.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.iomap

for you to fetch changes up to c84042b32f275dee8e3f10cdd8973e2e879f1fc8:

  Merge patch series "further iomap large atomic writes changes" (2025-03-20 15:16:08 +0100)

Please consider pulling these changes from the signed vfs-6.15-rc1.iomap tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.15-rc1.iomap

----------------------------------------------------------------
Brian Foster (22):
      iomap: factor out iomap length helper
      iomap: split out iomap check and reset logic from iter advance
      iomap: refactor iomap_iter() length check and tracepoint
      iomap: lift error code check out of iomap_iter_advance()
      iomap: lift iter termination logic from iomap_iter_advance()
      iomap: export iomap_iter_advance() and return remaining length
      iomap: support incremental iomap_iter advances
      iomap: advance the iter directly on buffered writes
      iomap: advance the iter directly on unshare range
      iomap: advance the iter directly on zero range
      iomap: advance the iter directly on buffered read
      iomap: advance the iter on direct I/O
      iomap: convert misc simple ops to incremental advance
      dax: advance the iomap_iter in the read/write path
      dax: push advance down into dax_iomap_iter() for read and write
      dax: advance the iomap_iter on zero range
      dax: advance the iomap_iter on unshare range
      dax: advance the iomap_iter on dedupe range
      dax: advance the iomap_iter on pte and pmd faults
      iomap: remove unnecessary advance from iomap_iter()
      iomap: rename iomap_iter processed field to status
      iomap: introduce a full map advance helper

Christian Brauner (7):
      Merge patch series "iomap: allow the file system to submit the writeback bios"
      Merge patch series "iomap: incremental per-operation iter advance"
      Merge patch series "iomap: incremental advance conversion -- phase 2"
      Merge patch series "iomap: make buffered writes work with RWF_DONTCACHE"
      Merge branch 'vfs-6.15.shared.iomap' of gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs
      Merge patch series "iomap preliminaries for large atomic write for xfs with CoW"
      Merge patch series "further iomap large atomic writes changes"

Christoph Hellwig (11):
      iomap: allow the file system to submit the writeback bios
      iomap: simplify io_flags and io_type in struct iomap_ioend
      iomap: add a IOMAP_F_ANON_WRITE flag
      iomap: split bios to zone append limits in the submission handlers
      iomap: move common ioend code to ioend.c
      iomap: factor out a iomap_dio_done helper
      iomap: optionally use ioends for direct I/O
      iomap: add a io_private field to struct iomap_ioend
      iomap: pass private data to iomap_page_mkwrite
      iomap: pass private data to iomap_zero_range
      iomap: pass private data to iomap_truncate_page

Gao Xiang (1):
      iomap: fix inline data on buffered read

Jens Axboe (2):
      iomap: make buffered writes work with RWF_DONTCACHE
      xfs: flag as supporting FOP_DONTCACHE

John Garry (5):
      iomap: Rename IOMAP_ATOMIC -> IOMAP_ATOMIC_HW
      iomap: Support SW-based atomic writes
      iomap: inline iomap_dio_bio_opflags()
      iomap: comment on atomic write checks in iomap_dio_bio_iter()
      iomap: rework IOMAP atomic flags

Ritesh Harjani (IBM) (1):
      iomap: Lift blocksize restriction on atomic writes

 Documentation/filesystems/iomap/design.rst     |   9 +
 Documentation/filesystems/iomap/operations.rst |  42 ++-
 fs/dax.c                                       | 111 ++++----
 fs/ext4/inode.c                                |   4 +
 fs/gfs2/bmap.c                                 |   3 +-
 fs/iomap/Makefile                              |   1 +
 fs/iomap/buffered-io.c                         | 356 +++++++++----------------
 fs/iomap/direct-io.c                           | 279 ++++++++++---------
 fs/iomap/fiemap.c                              |  21 +-
 fs/iomap/internal.h                            |  10 +
 fs/iomap/ioend.c                               | 216 +++++++++++++++
 fs/iomap/iter.c                                |  97 ++++---
 fs/iomap/seek.c                                |  16 +-
 fs/iomap/swapfile.c                            |   7 +-
 fs/iomap/trace.h                               |   8 +-
 fs/xfs/xfs_aops.c                              |  25 +-
 fs/xfs/xfs_file.c                              |   6 +-
 fs/xfs/xfs_iomap.c                             |   8 +-
 fs/zonefs/file.c                               |   2 +-
 include/linux/iomap.h                          | 116 ++++++--
 20 files changed, 816 insertions(+), 521 deletions(-)
 create mode 100644 fs/iomap/internal.h
 create mode 100644 fs/iomap/ioend.c

