Return-Path: <linux-fsdevel+bounces-70151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A685AC929E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 17:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8BD524E38DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 16:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025C72BE7C6;
	Fri, 28 Nov 2025 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kd6CmG1Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9522BD5A8;
	Fri, 28 Nov 2025 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764348673; cv=none; b=pvrnOCOMZX5cTAtzpSqqZ3/EdJ6sdHNBFMQamFTuQ77GPYXW0yhCvXW9Fxp4d6r5DcpBgXmc2NvAgtB9FElgW++5/vE1Uy4UdEW9SLgezR0XvAxFjqdrKaM3emEVBfoma6WZB7ECcKSRyYEyFQEIfHNdZ4scr5HpgH8egemjMnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764348673; c=relaxed/simple;
	bh=SMcu90V9w57f6ww19sTIzIryZ/79gScNfrvOqrzRc6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BgwfFNR5kHvjcgmZHYaM9dSSTTFf9Lg/GxFeMSgq0MmNTIk9TkT/NMNOqG1z9Q2nxtCLg5pcyjzvbTd2hhdquoZ03WQfDAhPCF7HbCfFQDDOjZ5lYJ0UdZbHri0dPVUIlN+o3wBCWg+RUxj404nmUJXMD0zD87ow8YUkB2G10qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kd6CmG1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F1CC116B1;
	Fri, 28 Nov 2025 16:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764348671;
	bh=SMcu90V9w57f6ww19sTIzIryZ/79gScNfrvOqrzRc6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kd6CmG1YOVQ01rGb/pB5RTHVEu6gQCt6nuzUtcWMhR0JBTvoaRPaHsL9DPOU/7iDk
	 5OAStEaJFO94tXrljZDN+9LtVP2acJxA+gkHGrOnkbiGYmyXdaBtTV/gsPs4QWeY73
	 pB5tOLPRoFIuPRevRfj37KCOKVGJ5od4PXT8stpPG4z57pvN4pGeKsj6xPsGjZ79Cw
	 s4pEatA7xx8dlZnINcjtlL2p8kmRCff6sgShj/kNim0pjnoNuwOTIkQdaqXW2aUuRm
	 sTnc9iKtPhw2ATHpUURFlbKav939TpDq5rgpu4ToHfnZt1hguoDaNiSICj3yTQhG1Y
	 RgobBaecda+Fw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 01/17 for v6.19] vfs iomap
Date: Fri, 28 Nov 2025 17:48:12 +0100
Message-ID: <20251128-vfs-iomap-v619-1b28bca81324@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251128-vfs-v619-77cd88166806@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8011; i=brauner@kernel.org; h=from:subject:message-id; bh=SMcu90V9w57f6ww19sTIzIryZ/79gScNfrvOqrzRc6M=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRqXnq4StTyxartMRsTysslzxRVfwp+VnIx/oJt3J/iE MZ3P7indJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEfC0jw3O7R0dsYngf13uo JebfKZluvPhQkVTF0ZMXv37T25JrncjwT+/kR7P20rb/7XWZG8778/2a920/82qGLMlbzcbCG/Z qcAEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains the iomap changes for this cycle:

* FUSE iomap Support for Buffered Reads

  This adds iomap support for FUSE buffered reads and readahead. This
  enables granular uptodate tracking with large folios so only
  non-uptodate portions need to be read. Also fixes a race condition
  with large folios + writeback cache that could cause data corruption
  on partial writes followed by reads.

  - Refactored iomap read/readahead bio logic into helpers
  - Added caller-provided callbacks for read operations
  - Moved buffered IO bio logic into new file
  - FUSE now uses iomap for read_folio and readahead

* Zero Range Folio Batch Support

  Adds folio batch support for iomap_zero_range() to handle dirty folios
  over unwritten mappings. Fixes raciness issues where dirty data could
  be lost during zero range operations.

  - filemap_get_folios_tag_range() helper for dirty folio lookup
  - Optional zero range dirty folio processing
  - XFS fills dirty folios on zero range of unwritten mappings
  - Removed old partial EOF zeroing optimization

* DIO Write Completions from Interrupt Context

  Restore pre-iomap behavior where pure overwrite completions run inline
  rather than being deferred to workqueue. Reduces context switches for
  high-performance workloads like ScyllaDB.

  - Removed unused IOCB_DIO_CALLER_COMP code
  - Error completions always run in user context (fixes zonefs)
  - Reworked REQ_FUA selection logic
  - Inverted IOMAP_DIO_INLINE_COMP to IOMAP_DIO_OFFLOAD_COMP

* Buffered IO Cleanups

  Some performance and code clarity improvements:

  - Replace manual bitmap scanning with find_next_bit()
  - Simplify read skip logic for writes
  - Optimize pending async writeback accounting
  - Better variable naming
  - Documentation for iomap_finish_folio_write() requirements

* Misaligned Vectors for Zoned XFS

  Enables sub-block aligned vectors in XFS always-COW mode for zoned
  devices via new IOMAP_DIO_FSBLOCK_ALIGNED flag.

* Bug Fixes

  - Allocate s_dio_done_wq for async reads (fixes syzbot report after error completion changes)
  - Fix iomap_read_end() for already uptodate folios (regression fix)

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

[1]: https://lore.kernel.org/linux-next/20251117143259.05d36122@canb.auug.org.au

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.iomap

for you to fetch changes up to 7fd8720dff2d9c70cf5a1a13b7513af01952ec02:

  iomap: allocate s_dio_done_wq for async reads as well (2025-11-25 10:22:19 +0100)

Please consider pulling these changes from the signed vfs-6.19-rc1.iomap tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.19-rc1.iomap

----------------------------------------------------------------
Brian Foster (7):
      filemap: add helper to look up dirty folios in a range
      iomap: remove pos+len BUG_ON() to after folio lookup
      iomap: optional zero range dirty folio processing
      xfs: always trim mapping to requested range for zero range
      xfs: fill dirty folios on zero range of unwritten mappings
      iomap: remove old partial eof zeroing optimization
      xfs: error tag to force zeroing on debug kernels

Christian Brauner (5):
      Merge patch series "fuse: use iomap for buffered reads + readahead"
      Merge patch series "iomap: zero range folio batch support"
      Merge patch series "alloc misaligned vectors for zoned XFS v2"
      Merge patch series "iomap: buffered io changes"
      Merge patch series "enable iomap dio write completions from interrupt context v2"

Christoph Hellwig (8):
      iomap: move buffered io bio logic into new file
      xfs: support sub-block aligned vectors in always COW mode
      fs, iomap: remove IOCB_DIO_CALLER_COMP
      iomap: always run error completions in user context
      iomap: rework REQ_FUA selection
      iomap: support write completions from interrupt context
      iomap: invert the polarity of IOMAP_DIO_INLINE_COMP
      iomap: allocate s_dio_done_wq for async reads as well

Joanne Koong (24):
      iomap: move bio read logic into helper function
      iomap: move read/readahead bio submission logic into helper function
      iomap: simplify iomap_iter_advance()
      iomap: store read/readahead bio generically
      iomap: adjust read range correctly for non-block-aligned positions
      iomap: iterate over folio mapping in iomap_readpage_iter()
      iomap: rename iomap_readpage_iter() to iomap_read_folio_iter()
      iomap: rename iomap_readpage_ctx struct to iomap_read_folio_ctx
      iomap: track pending read bytes more optimally
      iomap: set accurate iter->pos when reading folio ranges
      iomap: add caller-provided callbacks for read and readahead
      iomap: make iomap_read_folio() a void return
      fuse: use iomap for read_folio
      fuse: use iomap for readahead
      fuse: remove fc->blkbits workaround for partial writes
      iomap: rename bytes_pending/bytes_accounted to bytes_submitted/bytes_not_submitted
      iomap: account for unaligned end offsets when truncating read range
      docs: document iomap writeback's iomap_finish_folio_write() requirement
      iomap: optimize pending async writeback accounting
      iomap: simplify ->read_folio_range() error handling for reads
      iomap: simplify when reads can be skipped for writes
      iomap: use find_next_bit() for dirty bitmap scanning
      iomap: use find_next_bit() for uptodate bitmap scanning
      iomap: fix iomap_read_end() for already uptodate folios

Qu Wenruo (1):
      iomap: add IOMAP_DIO_FSBLOCK_ALIGNED flag

 Documentation/filesystems/iomap/operations.rst |  50 +-
 block/fops.c                                   |   5 +-
 fs/backing-file.c                              |   6 -
 fs/dax.c                                       |  30 +-
 fs/erofs/data.c                                |   5 +-
 fs/fuse/dir.c                                  |   2 +-
 fs/fuse/file.c                                 | 286 ++++++-----
 fs/fuse/fuse_i.h                               |   8 -
 fs/fuse/inode.c                                |  13 +-
 fs/gfs2/aops.c                                 |   6 +-
 fs/iomap/Makefile                              |   3 +-
 fs/iomap/bio.c                                 |  88 ++++
 fs/iomap/buffered-io.c                         | 636 +++++++++++++++----------
 fs/iomap/direct-io.c                           | 230 +++++----
 fs/iomap/internal.h                            |  12 +
 fs/iomap/ioend.c                               |   2 -
 fs/iomap/iter.c                                |  20 +-
 fs/iomap/seek.c                                |   8 +-
 fs/iomap/trace.h                               |   7 +-
 fs/xfs/libxfs/xfs_errortag.h                   |   6 +-
 fs/xfs/xfs_aops.c                              |   5 +-
 fs/xfs/xfs_file.c                              |  50 +-
 fs/xfs/xfs_iomap.c                             |  38 +-
 fs/zonefs/file.c                               |   5 +-
 include/linux/fs.h                             |  43 +-
 include/linux/iomap.h                          |  86 +++-
 include/linux/pagemap.h                        |   2 +
 io_uring/rw.c                                  |  16 +-
 mm/filemap.c                                   |  58 +++
 29 files changed, 1093 insertions(+), 633 deletions(-)
 create mode 100644 fs/iomap/bio.c

