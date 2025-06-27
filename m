Return-Path: <linux-fsdevel+bounces-53126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C60AEACCE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 04:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D5597B3E17
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 02:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14C419066B;
	Fri, 27 Jun 2025 02:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NqQBdHO4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83F61419A9
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jun 2025 02:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750990993; cv=none; b=IgHbdn14zlbmgFYiTQI0gRG1vfh1844gJuiLTJxd/3zjrFU21VAtbCQznTzSM3grpP2X0PvpEdlQEod0f58vnNlpPtdJ++sBzyEAJy+UXMeCPvxCZUX8yV1DP0sC+Og2zZL6vajhivMobQW+Bc2RNgX77zV/LihRTjqahIaBmNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750990993; c=relaxed/simple;
	bh=av2Zn732X9HE4ruWynFtQpxMvhxph3ZGlcZA4HMgvFg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KFlpzssZ4IcSo+h1ZL+6ABRJay0+fmTreMXhA5Gx/U+lL5EdPeajLKWZ+3OzZcFRUnFXW1G5NZe3HHcu8hdc4zCKkUhYSe9zhSlnISRIa1o7oAk2mevF/91+t97Y9rlKG0aMvJjKiOoim4b75A1RwZc+bGJfJq45VZjKfGRU3eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NqQBdHO4; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 26 Jun 2025 22:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750990977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=EnchciEXaW72XzhWJSIc02euNtVTgDfT6M58RBTXTyk=;
	b=NqQBdHO4fM8T/zVv6ijkz9N5BsOxsvT3VC5ow27+NJDG4PAAJ+sl/44+7dNMluhKNZuhKF
	Br1qX+0lob5QCB90ndBKZGl8KevkakAiTdFNpLSA88dLB0kkvq4cHiUKFF3k/BgjTBTQC4
	SdH8lgO1FAMzV8U3Y/WgUzu6oizUuUg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kerenl@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.16-rc4
Message-ID: <ahdf2izzsmggnhlqlojsnqaedlfbhomrxrtwd2accir365aqtt@6q52cm56jmuf>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

per the maintainer thread discussion and precedent in xfs and btrfs
for repair code in RCs, journal_rewind is again included

The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-06-26

for you to fetch changes up to ef6fac0f9e5d0695cee1d820c727fe753eca52d5:

  bcachefs: Plumb correct ip to trans_relock_fail tracepoint (2025-06-26 00:01:16 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.16-rc4

----------------------------------------------------------------
Alan Huang (7):
      bcachefs: Don't allocate new memory when mempool is exhausted
      bcachefs: Fix alloc_req use after free
      bcachefs: Add missing EBUG_ON
      bcachefs: Delay calculation of trans->journal_u64s
      bcachefs: Move bset size check before csum check
      bcachefs: Fix pool->alloc NULL pointer dereference
      bcachefs: Don't unlock the trans if ret doesn't match BCH_ERR_operation_blocked

Bharadwaj Raju (1):
      bcachefs: don't return fsck_fix for unfixable node errors in __btree_err

Kent Overstreet (43):
      bcachefs: trace_extent_trim_atomic
      bcachefs: btree iter tracepoints
      bcachefs: Fix bch2_journal_keys_peek_prev_min()
      bcachefs: btree_iter: fix updates, journal overlay
      bcachefs: better __bch2_snapshot_is_ancestor() assert
      bcachefs: pass last_seq into fs_journal_start()
      bcachefs: Fix "now allowing incompatible features" message
      bcachefs: Fix snapshot_key_missing_inode_snapshot repair
      bcachefs: fsck: fix add_inode()
      bcachefs: fsck: fix extent past end of inode repair
      bcachefs: opts.journal_rewind
      bcachefs: Kill unused tracepoints
      bcachefs: mark more errors autofix
      bcachefs: fsck: Improve check_key_has_inode()
      bcachefs: Call bch2_fs_init_rw() early if we'll be going rw
      bcachefs: Fix __bch2_inum_to_path() when crossing subvol boundaries
      bcachefs: fsck: Print path when we find a subvol loop
      bcachefs: fsck: Fix remove_backpointer() for subvol roots
      bcachefs: fsck: Fix reattach_inode() for subvol roots
      bcachefs: fsck: check_directory_structure runs in reverse order
      bcachefs: fsck: additional diagnostics for reattach_inode()
      bcachefs: fsck: check_subdir_count logs path
      bcachefs: fsck: Fix check_path_loop() + snapshots
      bcachefs: Fix bch2_read_bio_to_text()
      bcachefs: Fix restart handling in btree_node_scrub_work()
      bcachefs: fsck: Fix check_directory_structure when no check_dirents
      bcachefs: fsck: fix unhandled restart in topology repair
      bcachefs: fsck: Fix oops in key_visible_in_snapshot()
      bcachefs: fix spurious error in read_btree_roots()
      bcachefs: Fix missing newlines before ero
      bcachefs: Fix *__bch2_trans_subbuf_alloc() error path
      bcachefs: Don't log fsck err in the journal if doing repair elsewhere
      bcachefs: Add missing key type checks to check_snapshot_exists()
      bcachefs: Add missing bch2_err_class() to fileattr_set()
      bcachefs: fix spurious error_throw
      bcachefs: Fix range in bch2_lookup_indirect_extent() error path
      bcachefs: Check for bad write buffer key when moving from journal
      bcachefs: Use wait_on_allocator() when allocating journal
      bcachefs: fix bch2_journal_keys_peek_prev_min() underflow
      bcachefs: btree_root_unreadable_and_scan_found_nothing should not be autofix
      bcachefs: Ensure btree node scan runs before checking for scanned nodes
      bcachefs: Ensure we rewind to run recovery passes
      bcachefs: Plumb correct ip to trans_relock_fail tracepoint

 fs/bcachefs/alloc_background.c         |  13 +-
 fs/bcachefs/backpointers.c             |   2 +-
 fs/bcachefs/bcachefs.h                 |   3 +-
 fs/bcachefs/btree_gc.c                 |  37 ++--
 fs/bcachefs/btree_io.c                 |  74 ++++----
 fs/bcachefs/btree_iter.c               | 173 ++++++++++++------
 fs/bcachefs/btree_journal_iter.c       |  82 ++++++---
 fs/bcachefs/btree_journal_iter_types.h |   5 +-
 fs/bcachefs/btree_locking.c            |  12 +-
 fs/bcachefs/btree_node_scan.c          |   6 +-
 fs/bcachefs/btree_node_scan.h          |   2 +-
 fs/bcachefs/btree_trans_commit.c       |  18 +-
 fs/bcachefs/btree_types.h              |   1 +
 fs/bcachefs/btree_update.c             |  16 +-
 fs/bcachefs/btree_update.h             |   5 +-
 fs/bcachefs/btree_update_interior.c    |  16 +-
 fs/bcachefs/btree_update_interior.h    |   3 +
 fs/bcachefs/btree_write_buffer.c       |   8 +-
 fs/bcachefs/btree_write_buffer.h       |   6 +
 fs/bcachefs/chardev.c                  |  29 ++-
 fs/bcachefs/data_update.c              |   1 +
 fs/bcachefs/errcode.h                  |   5 -
 fs/bcachefs/error.c                    |   4 +-
 fs/bcachefs/extent_update.c            |  13 +-
 fs/bcachefs/fs.c                       |   3 +-
 fs/bcachefs/fsck.c                     | 317 +++++++++++++++++++++++----------
 fs/bcachefs/inode.h                    |   5 +
 fs/bcachefs/io_read.c                  |   7 +-
 fs/bcachefs/journal.c                  |  20 +--
 fs/bcachefs/journal.h                  |   2 +-
 fs/bcachefs/journal_io.c               |  26 ++-
 fs/bcachefs/namei.c                    |  30 +++-
 fs/bcachefs/opts.h                     |   5 +
 fs/bcachefs/recovery.c                 |  24 ++-
 fs/bcachefs/recovery_passes.c          |  19 +-
 fs/bcachefs/recovery_passes.h          |   9 +
 fs/bcachefs/reflink.c                  |  12 +-
 fs/bcachefs/sb-errors_format.h         |  19 +-
 fs/bcachefs/snapshot.c                 |  14 +-
 fs/bcachefs/super.c                    |  13 +-
 fs/bcachefs/super.h                    |   1 +
 fs/bcachefs/trace.h                    | 125 +++----------
 42 files changed, 734 insertions(+), 451 deletions(-)

