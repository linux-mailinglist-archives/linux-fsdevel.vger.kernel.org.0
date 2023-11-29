Return-Path: <linux-fsdevel+bounces-4251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB4F7FE358
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 23:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481F8282528
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0158947A45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZEJ8FSSi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343AA10CB
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 12:43:43 -0800 (PST)
Date: Wed, 29 Nov 2023 15:43:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701290621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=VAfvTVgkT1TJqyKd1et+j08YoV+NfvuOHQ/uuVLCDts=;
	b=ZEJ8FSSi/bpE8wwFLHlzVDiewRK7yIqiubswyI2W8D8MbvxLTMV1i6F7VkfEKBBnFtk7Q0
	53/+ap7tGPOEwhjw5RYZ28AVQ+bnvH4A8kxMwcLXfxsPe8Ekk6eprTRPG6I78NMAR2oH+j
	LDWdag5TvUhDTF5tqBt3kerfurXiWHI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] more bcachefs fixes
Message-ID: <20231129204336.4yfhhptdgrfaguur@moria.home.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus, some more bcachefs fixes. Nothing too crazy to report,
changelog should have it all.

Cheers,
Kent

The following changes since commit 98b1cc82c4affc16f5598d4fa14b1858671b2263:

  Linux 6.7-rc2 (2023-11-19 15:02:14 -0800)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2023-11-29

for you to fetch changes up to 415e5107b0dce0e5407ae4a46700cd7e8859e252:

  bcachefs: Extra kthread_should_stop() calls for copygc (2023-11-28 22:58:23 -0500)

----------------------------------------------------------------
More bcachefs bugfixes for 6.7

Bigger/user visible fixes:

 - bcache & bcachefs were broken with CFI enabled; patch for closures to
   fix type punning

 - mark erasure coding as extra-experimental; there are incompatible
   disk space accounting changes coming for erasure coding, and I'm
   still seeing checksum errors in some tests

 - several fixes for durability-related issues (durability is a device
   specific setting where we can tell bcachefs that data on a given
   device should be counted as replicated x times )

 - a fix for a rare livelock when a btree node merge then updates a
   parent node that is almost full

 - fix a race in the device removal path, where dropping a pointer in a
   btree node to a device would be clobbered by an in flight btree write
   updating the btree node key on completion

 - fix one SRCU lock hold time warning in the btree gc code - ther's
   still a bunch more of these to fix

 - fix a rare race where we'd start copygc before initializing the "are
   we rw" percpu refcount; copygc would think we were already ro and die
   immediately

https://evilpiepirate.org/~testdashboard/ci?branch=bcachefs-for-upstream

----------------------------------------------------------------
Brian Foster (1):
      bcachefs: preserve device path as device name

Kent Overstreet (22):
      closures: CLOSURE_CALLBACK() to fix type punning
      bcachefs: Put erasure coding behind an EXPERIMENTAL kconfig option
      bcachefs: bch2_moving_ctxt_flush_all()
      bcachefs: Make sure bch2_move_ratelimit() also waits for move_ops
      bcachefs: Don't stop copygc thread on device resize
      bcachefs: Start gc, copygc, rebalance threads after initing writes ref
      bcachefs: Fix an endianness conversion
      bcachefs: Proper refcounting for journal_keys
      bcachefs: deallocate_extra_replicas()
      bcachefs: Data update path won't accidentaly grow replicas
      bcachefs: Fix ec + durability calculation
      bcachefs: bpos is misaligned on big endian
      bcachefs: Fix zstd compress workspace size
      bcachefs: Add missing validation for jset_entry_data_usage
      bcachefs: Fix bucket data type for stripe buckets
      bcachefs: Fix split_race livelock
      bcachefs: trace_move_extent_start_fail() now includes errcode
      bcachefs: -EROFS doesn't count as move_extent_start_fail
      bcachefs: move journal seq assertion
      bcachefs: Fix race between btree writes and metadata drop
      bcachefs: Convert gc_alloc_start() to for_each_btree_key2()
      bcachefs: Extra kthread_should_stop() calls for copygc

 drivers/md/bcache/btree.c           |  14 ++--
 drivers/md/bcache/journal.c         |  20 +++---
 drivers/md/bcache/movinggc.c        |  16 ++---
 drivers/md/bcache/request.c         |  74 ++++++++++-----------
 drivers/md/bcache/request.h         |   2 +-
 drivers/md/bcache/super.c           |  40 ++++++------
 drivers/md/bcache/writeback.c       |  16 ++---
 fs/bcachefs/Kconfig                 |  12 ++++
 fs/bcachefs/alloc_foreground.c      |  30 +++++++++
 fs/bcachefs/bcachefs.h              |   4 +-
 fs/bcachefs/bcachefs_format.h       |   8 ++-
 fs/bcachefs/btree_gc.c              |   9 +--
 fs/bcachefs/btree_io.c              |   7 +-
 fs/bcachefs/btree_iter.c            |   6 +-
 fs/bcachefs/btree_journal_iter.c    |  18 +++++-
 fs/bcachefs/btree_journal_iter.h    |  10 ++-
 fs/bcachefs/btree_update_interior.c |  14 +++-
 fs/bcachefs/buckets.c               |  10 +--
 fs/bcachefs/compress.c              |  16 +++--
 fs/bcachefs/data_update.c           |  92 +++++++++++++++++++++++---
 fs/bcachefs/data_update.h           |   9 ++-
 fs/bcachefs/errcode.h               |   3 +-
 fs/bcachefs/extents.c               |  30 ++++-----
 fs/bcachefs/fs-io-direct.c          |   8 +--
 fs/bcachefs/fs.c                    |   3 +-
 fs/bcachefs/io_read.c               |   2 +-
 fs/bcachefs/io_write.c              |  14 ++--
 fs/bcachefs/io_write.h              |   3 +-
 fs/bcachefs/journal.c               |   2 +
 fs/bcachefs/journal.h               |   4 +-
 fs/bcachefs/journal_io.c            |  29 ++++++---
 fs/bcachefs/journal_io.h            |   2 +-
 fs/bcachefs/move.c                  | 126 ++++++++++++------------------------
 fs/bcachefs/move.h                  |  19 ++++++
 fs/bcachefs/movinggc.c              |   2 +-
 fs/bcachefs/recovery.c              |  11 ++--
 fs/bcachefs/replicas.c              |  69 +++++++++++---------
 fs/bcachefs/replicas.h              |   2 +
 fs/bcachefs/snapshot.c              |   2 +-
 fs/bcachefs/super-io.c              |   5 ++
 fs/bcachefs/super.c                 |  34 ++++++----
 fs/bcachefs/super_types.h           |   1 +
 fs/bcachefs/trace.h                 |   6 +-
 include/linux/closure.h             |   9 ++-
 lib/closure.c                       |   5 +-
 45 files changed, 495 insertions(+), 323 deletions(-)

