Return-Path: <linux-fsdevel+bounces-8372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8B68357F2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 22:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B06861C20A68
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 21:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF9E38DF5;
	Sun, 21 Jan 2024 21:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hAoMWnEg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0278383B9
	for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jan 2024 21:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705872915; cv=none; b=rBt9vBT4Ve/wfEY1yVMY4t3g671YTXuTfqTIbXSay//EQ/Z2NTsgTBg+E3kccbB9vsLxN+iT5s59Jgd3rC97gLdAtVPmDNGcPM3YvgGPDGO/QeCZEqx9d0mQSEbJUGB4l5W6xgiW+eIler87igNMPYB0wkPJ61ti7AvIFVIO0mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705872915; c=relaxed/simple;
	bh=Ds7Qnl2E3+PG4PnCqFoazFIXuc+duwHTLDPZk5Ncimo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MYYHB7jlK/+d77zFPLpzR2RYnMnb6WfFyGtv2K9HtY0pQFau2bH274aPpp/5PvbF2g5c7ugxujl/+dnYfBToMQHAUOrhSg2o7yYhLZURbUPQx2hAKOHmY6b2KBPg22vHvLuMuFZF+UNgBQCxIN4Z6jlNWc+QJE7c2MB+jafREzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hAoMWnEg; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 21 Jan 2024 16:35:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705872910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Ug8HPVmT+R79lekdm1+D7esoiTAn5v7pk1ps73/YWRo=;
	b=hAoMWnEgRx/6680gy74aQfwimsVm4HV/wjgCA4zqRyVmJivmrC9e+7uXnqATaGsVZSapT1
	wCHRHXil/akRxx/7bGvulO/dtRqt1eEzEFmgd++QmcGq+dsKUtkcwFeD3ILYKpwu78c8Q3
	37bnAkg++5O+GuOUUvQ0GVV1WfO5Dpo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] More bcachefs updates for 6.8-rc1
Message-ID: <a34bqdrz33jw26a5px4ul3eid5zudgaxavc2xqoftk2tywgi5w@ghgoiavnkhtd>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus, another small bcachefs pull. Some fixes, Some refactoring,
some minor features.

Cheers,
Kent

The following changes since commit 169de41985f53320580f3d347534966ea83343ca:

  bcachefs: eytzinger0_find() search should be const (2024-01-05 23:24:46 -0500)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-01-21

for you to fetch changes up to 249f441f83c546281f1c175756c81fac332bb64c:

  bcachefs: Improve inode_to_text() (2024-01-21 13:27:11 -0500)

----------------------------------------------------------------
More bcachefs updates for 6.7-rc1

 - assorted prep work for disk space accounting rewrite
 - BTREE_TRIGGER_ATOMIC: after combining our trigger callbacks, this
   makes our trigger context more explicit
 - A few fixes to avoid excessive transaction restarts on multithreaded
   workloads: fstests (in addition to ktest tests) are now checking
   slowpath counters, and that's shaking out a few bugs
 - Assorted tracepoint improvements
 - Starting to break up bcachefs_format.h and move on disk types so
   they're with the code they belong to; this will make room to start
   documenting the on disk format better.
 - A few minor fixes

----------------------------------------------------------------
Colin Ian King (1):
      bcachefs: remove redundant variable tmp

Kent Overstreet (42):
      bcachefs: Don't log errors if BCH_WRITE_ALLOC_NOWAIT
      bcachefs: eytzinger_for_each() declares loop iter
      bcachefs: drop to_text code for obsolete bps in alloc keys
      bcachefs: BTREE_TRIGGER_ATOMIC
      bcachefs: helpers for printing data types
      bcachefs: bch2_prt_compression_type()
      bcachefs: bch_fs_usage_base
      bcachefs: bch2_trans_account_disk_usage_change()
      bcachefs: Reduce would_deadlock restarts
      bcachefs: Don't pass memcmp() as a pointer
      bcachefs: Add .val_to_text() for KEY_TYPE_cookie
      bcachefs: bch2_kthread_io_clock_wait() no longer sleeps until full amount
      bcachefs: Re-add move_extent_write tracepoint
      bcachefs: Add missing bch2_moving_ctxt_flush_all()
      bcachefs: Improve move_extent tracepoint
      bcachefs: Avoid flushing the journal in the discard path
      bcachefs: Print size of superblock with space allocated
      bcachefs: Better journal tracepoints
      bcachefs: bkey_and_val_eq()
      bcachefs: extents_to_bp_state
      bcachefs: Fix excess transaction restarts in __bchfs_fallocate()
      bcachefs: Improve trace_trans_restart_relock
      bcachefs: bios must be 512 byte algined
      bcachefs: Prep work for variable size btree node buffers
      bcachefs: opts->compression can now also be applied in the background
      bcachefs: add missing __GFP_NOWARN
      bcachefs: bch_snapshot::btime
      bcachefs: comment bch_subvolume
      bcachefs: counters.c -> sb-counters.c
      bcachefs: sb-counters_format.h
      bcachefs; quota_format.h
      bcachefs: inode_format.h
      bcachefs: dirent_format.h
      bcachefs: xattr_format.h
      bcachefs: alloc_background_format.h
      bcachefs: snapshot_format.h
      bcachefs: subvolume_format.h
      bcachefs: ec_format.h
      bcachefs; extents_format.h
      bcachefs: reflink_format.h
      bcachefs: logged_ops_format.h
      bcachefs: Improve inode_to_text()

Su Yue (3):
      bcachefs: fix memleak in bch2_split_devs
      bcachefs: kvfree bch_fs::snapshots in bch2_fs_snapshots_exit
      bcachefs: grab s_umount only if snapshotting

 fs/bcachefs/Makefile                      |   2 +-
 fs/bcachefs/alloc_background.c            |  89 +--
 fs/bcachefs/alloc_background_format.h     |  92 ++++
 fs/bcachefs/alloc_foreground.c            |   7 +-
 fs/bcachefs/backpointers.c                | 100 ++--
 fs/bcachefs/backpointers.h                |   1 +
 fs/bcachefs/bcachefs.h                    |   5 -
 fs/bcachefs/bcachefs_format.h             | 888 +-----------------------------
 fs/bcachefs/bkey.c                        |   2 +-
 fs/bcachefs/bkey_methods.c                |   9 +
 fs/bcachefs/bkey_methods.h                |  10 +-
 fs/bcachefs/bset.c                        |   7 +-
 fs/bcachefs/bset.h                        |   3 +-
 fs/bcachefs/btree_cache.c                 |  12 +-
 fs/bcachefs/btree_cache.h                 |  19 +-
 fs/bcachefs/btree_gc.c                    |  36 +-
 fs/bcachefs/btree_io.c                    |  38 +-
 fs/bcachefs/btree_iter.c                  |   2 +-
 fs/bcachefs/btree_iter.h                  |   5 +
 fs/bcachefs/btree_locking.c               |  40 +-
 fs/bcachefs/btree_locking.h               |   9 +-
 fs/bcachefs/btree_trans_commit.c          |  35 +-
 fs/bcachefs/btree_types.h                 |  12 +-
 fs/bcachefs/btree_update_interior.c       |   8 +-
 fs/bcachefs/btree_update_interior.h       |  42 +-
 fs/bcachefs/btree_write_buffer.c          |   7 +-
 fs/bcachefs/buckets.c                     | 148 ++---
 fs/bcachefs/buckets.h                     |  17 +
 fs/bcachefs/buckets_types.h               |  15 +-
 fs/bcachefs/clock.c                       |   4 +-
 fs/bcachefs/compress.h                    |   8 +
 fs/bcachefs/data_update.c                 |   6 +-
 fs/bcachefs/debug.c                       |  16 +-
 fs/bcachefs/dirent_format.h               |  42 ++
 fs/bcachefs/ec.c                          |   6 +-
 fs/bcachefs/ec_format.h                   |  19 +
 fs/bcachefs/extents.c                     |  11 +-
 fs/bcachefs/extents.h                     |   2 +-
 fs/bcachefs/extents_format.h              | 295 ++++++++++
 fs/bcachefs/eytzinger.h                   |   4 +-
 fs/bcachefs/fs-io-direct.c                |   4 +
 fs/bcachefs/fs-io-pagecache.c             |  37 +-
 fs/bcachefs/fs-io-pagecache.h             |   2 +-
 fs/bcachefs/fs-io.c                       |   7 +-
 fs/bcachefs/fs-ioctl.c                    |  11 +-
 fs/bcachefs/inode.c                       |  29 +-
 fs/bcachefs/inode_format.h                | 166 ++++++
 fs/bcachefs/io_misc.c                     |   4 +-
 fs/bcachefs/io_write.c                    |  13 +-
 fs/bcachefs/journal.c                     | 111 ++--
 fs/bcachefs/journal_io.c                  |   5 +-
 fs/bcachefs/logged_ops_format.h           |  30 +
 fs/bcachefs/move.c                        |  65 ++-
 fs/bcachefs/opts.c                        |   4 +-
 fs/bcachefs/opts.h                        |   9 +-
 fs/bcachefs/quota_format.h                |  47 ++
 fs/bcachefs/rebalance.c                   |  13 +-
 fs/bcachefs/recovery.c                    |   2 +-
 fs/bcachefs/reflink.c                     |  21 +-
 fs/bcachefs/reflink.h                     |   8 +-
 fs/bcachefs/reflink_format.h              |  33 ++
 fs/bcachefs/replicas.c                    |  28 +-
 fs/bcachefs/sb-clean.c                    |   2 +-
 fs/bcachefs/{counters.c => sb-counters.c} |   2 +-
 fs/bcachefs/{counters.h => sb-counters.h} |   7 +-
 fs/bcachefs/sb-counters_format.h          |  98 ++++
 fs/bcachefs/sb-members.c                  |   4 +-
 fs/bcachefs/snapshot.c                    |   4 +-
 fs/bcachefs/snapshot_format.h             |  36 ++
 fs/bcachefs/subvolume_format.h            |  35 ++
 fs/bcachefs/super-io.c                    |   6 +-
 fs/bcachefs/super.c                       |   6 +-
 fs/bcachefs/sysfs.c                       |  15 +-
 fs/bcachefs/trace.h                       |  76 +--
 fs/bcachefs/util.c                        |  15 +-
 fs/bcachefs/util.h                        |   3 +-
 fs/bcachefs/xattr.c                       |   5 +-
 fs/bcachefs/xattr_format.h                |  19 +
 78 files changed, 1629 insertions(+), 1426 deletions(-)
 create mode 100644 fs/bcachefs/alloc_background_format.h
 create mode 100644 fs/bcachefs/dirent_format.h
 create mode 100644 fs/bcachefs/ec_format.h
 create mode 100644 fs/bcachefs/extents_format.h
 create mode 100644 fs/bcachefs/inode_format.h
 create mode 100644 fs/bcachefs/logged_ops_format.h
 create mode 100644 fs/bcachefs/quota_format.h
 create mode 100644 fs/bcachefs/reflink_format.h
 rename fs/bcachefs/{counters.c => sb-counters.c} (99%)
 rename fs/bcachefs/{counters.h => sb-counters.h} (77%)
 create mode 100644 fs/bcachefs/sb-counters_format.h
 create mode 100644 fs/bcachefs/snapshot_format.h
 create mode 100644 fs/bcachefs/subvolume_format.h
 create mode 100644 fs/bcachefs/xattr_format.h

