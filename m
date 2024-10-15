Return-Path: <linux-fsdevel+bounces-31927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFF699DB48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 03:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708091F23178
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 01:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC539155336;
	Tue, 15 Oct 2024 01:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PMW2WQcC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFC414B965
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 01:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728955687; cv=none; b=es0V6C2AbZVbQu2EeV7m7IEdm+sh3VdIAS7ds/dODMYhXhXL3i77IOo6oNZG55UtINeKV5i0yDjJTCOm1i25oQjQ6w+hxBcK0ecEkVAfi+QOipgckLfuwH0/FI3Amw873BjUsbAfNdyD7Hh1e0w47q+q0Do8tsn36h/Lzt9J3zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728955687; c=relaxed/simple;
	bh=gS0yxpQN86jLAWvfeaNTzay/a4WG+ypSZ9NOBXk/+n4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PXqBU2MNuwhKdTVuHORqysrwCRJugTqqAQKmPNzvEwGWgG0RkPwSF9/Ga+W2V6O5d4HcGSiqWtCGYZY6yAF15DgobxsiHncYtHzNcQMaTPKPCGmI3iIvpfDXGwSHPMWJ8g696qlDXAE910z/6iMLbvOzrNi8sb1zNhUtTv+rcGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PMW2WQcC; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 14 Oct 2024 21:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728955677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=EBKI0jhPyCaBxpT3oWhn2T9UWRj8G6nH6l3Lm03f80A=;
	b=PMW2WQcCGq9D7z5wsVzgbyMkEULuGdNp9Z842hnrWFvOhxt1uHtMS0OtcCk589Q1NFxD+q
	anrTGChpKmbhG1dZHzGoVjWCMR28+yedykBqGWLsrg0Mpfv2aeVAz1g1lFL/xFWKLEq8wl
	VrQAF5NSdHhvUALMkK16DtS40eUuTRM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.12-rc4
Message-ID: <lazo4f4eueknrlk5odp37fboznvfxnizhdeqttnmxkbgp7szjj@m3sjqp7mxm5d>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

The following changes since commit 0f25eb4b60771f08fbcca878a8f7f88086d0c885:

  bcachefs: Rework logged op error handling (2024-10-04 20:25:32 -0400)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-10-14

for you to fetch changes up to 5e3b72324d32629fa013f86657308f3dbc1115e1:

  bcachefs: Fix sysfs warning in fstests generic/730,731 (2024-10-14 05:43:01 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.12-rc4

- New metadata version inode_has_child_snapshots
  This fixes bugs with handling of unlinked inodes + snapshots, in
  particular when an inode is reattached after taking a snapshot;
  deleted inodes now get correctly cleaned up across snapshots.

- Disk accounting rewrite fixes
  - validation fixes for when a device has been removed
  - fix journal replay failing with "journal_reclaim_would_deadlock"

- Some more small fixes for erasure coding + device removal

- Assorted small syzbot fixes

----------------------------------------------------------------
Alan Huang (2):
      bcachefs: Release transaction before wake up
      bcachefs: Fix state lock involved deadlock

Kent Overstreet (23):
      bcachefs: Fix lockdep splat in bch2_accounting_read
      bcachefs: Split out check_unreachable_inodes() pass
      bcachefs: reattach_inode() now correctly handles interior snapshot nodes
      bcachefs: btree_iter_peek_upto() now handles BTREE_ITER_all_snapshots
      bcachefs: Delete vestigal check_inode() checks
      bcachefs: bcachefs_metadata_version_inode_has_child_snapshots
      bcachefs: Kill bch2_propagate_key_to_snapshot_leaves()
      bcachefs: bch2_inode_or_descendents_is_open()
      bcachefs: Disk accounting device validation fixes
      closures: Add closure_wait_event_timeout()
      bcachefs: Check if stuck in journal_res_get()
      bcachefs: __wait_for_freeing_inode: Switch to wait_bit_queue_entry
      bcachefs: Fix bch2_have_enough_devs() for BCH_SB_MEMBER_INVALID
      bcachefs: Fix invalid shift in member_to_text()
      bcachefs: Fix accounting replay flags
      bcachefs: Fix bkey_nocow_lock()
      bcachefs: Improve check_snapshot_exists()
      bcachefs: fix uaf in bch2_dio_write_done()
      bcachefs: Fix missing bounds checks in bch2_alloc_read()
      bcachefs: Add missing validation for bch_stripe.csum_granularity_bits
      bcachefs: Fix kasan splat in new_stripe_alloc_buckets()
      bcachefs: Handle race between stripe reuse, invalidate_stripe_to_dev
      bcachefs: Fix sysfs warning in fstests generic/730,731

Mohammed Anees (1):
      bcachefs: Fix NULL pointer dereference in bch2_opt_to_text

Piotr Zalewski (1):
      bcachefs: add check for btree id against max in try read node

 fs/bcachefs/alloc_background.c      |  10 +
 fs/bcachefs/bcachefs_format.h       |   3 +-
 fs/bcachefs/btree_gc.c              |  15 +-
 fs/bcachefs/btree_io.c              |   5 +-
 fs/bcachefs/btree_iter.c            |   6 +-
 fs/bcachefs/btree_iter.h            |   8 +
 fs/bcachefs/btree_node_scan.c       |   3 +
 fs/bcachefs/data_update.c           |   1 +
 fs/bcachefs/disk_accounting.c       | 149 ++++++++++----
 fs/bcachefs/ec.c                    |  94 ++++++---
 fs/bcachefs/errcode.h               |   3 +-
 fs/bcachefs/extents.h               |  10 +
 fs/bcachefs/fs-io-direct.c          |   3 +-
 fs/bcachefs/fs.c                    | 102 +++++++++-
 fs/bcachefs/fs.h                    |   9 +-
 fs/bcachefs/fsck.c                  | 384 ++++++++++++++++++++++--------------
 fs/bcachefs/fsck.h                  |   1 +
 fs/bcachefs/inode.c                 | 275 ++++++++++++++++++++++----
 fs/bcachefs/inode.h                 |  10 +
 fs/bcachefs/inode_format.h          |   3 +-
 fs/bcachefs/journal.c               |  13 ++
 fs/bcachefs/opts.c                  |   4 +-
 fs/bcachefs/recovery.c              |   3 +-
 fs/bcachefs/recovery_passes_types.h |   1 +
 fs/bcachefs/replicas.c              |  39 +++-
 fs/bcachefs/sb-downgrade.c          |   5 +-
 fs/bcachefs/sb-errors_format.h      |   6 +-
 fs/bcachefs/sb-members.c            |  10 +-
 fs/bcachefs/snapshot.c              | 129 +++---------
 fs/bcachefs/snapshot.h              |   3 -
 fs/bcachefs/super.c                 |  34 +++-
 include/linux/closure.h             |  35 ++++
 32 files changed, 976 insertions(+), 400 deletions(-)

