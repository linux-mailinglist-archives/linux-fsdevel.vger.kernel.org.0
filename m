Return-Path: <linux-fsdevel+bounces-45377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF38A76C6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 19:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610A1188D14A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 17:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD24216386;
	Mon, 31 Mar 2025 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fPehXRci"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FADA21504A
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743440864; cv=none; b=AxjLv1cjthXjgxh+5W+fwHNspLDzBTrDITvo2nzM3rUtahu20dCX/cnVQoE2lZh33MuFJjWl2EaoHGlzX9gFC9JvSavCrwuyRnEMzABgGERIPBfQzDPpVNfdMH9uBJ73zu72zO+I4vIpDf1/DN/r9i1f36/OCIl4jzC1bPpvvZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743440864; c=relaxed/simple;
	bh=0XXHvVH3uTDCMxcR0WdIaNLdp3YBldH2uI8GRVxW53s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qldvBHQ16pCd+Rq4lnph4NfytBvSLcZb5XTkDUFXCnM3O1b2DvS4q9aJqkIS1UfJKIIDANAreQOmt4Xha/BGO4KE9cXbTkUP0BokXO1JVGtu7X1cj9FcRzoLPqw7QINmcZdyovTx035X+JMaXThgKY48o0UHjzXa5j5Z4793m94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fPehXRci; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 31 Mar 2025 13:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743440859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=5OupMGobLMAwcSJf51wqGLHPQ4jZkY1BiImmx9cF0Dg=;
	b=fPehXRci0Usgern7GARpYrL022EgKSkHiT2ifiNiDLZ7nRJ9q7skctJBP84hIECOFcFSeb
	ZViJuCPxxknN6nvxOkzNz+vwMfk7LpKtWqYVKbUP2x6UaSd+t+/L9g3JY21fGVsl06sM9l
	nadt6Ba9UIp0BuEBMI7Y8UbigRqqDbU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs updates for 6.15 part 2
Message-ID: <insmfmxhkgbdvnnqaxkxfllhrea25hojvjaetxgdu3jr6txyjv@i44r2xo2virt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

The following changes since commit d8bdc8daac1d1b0a4efb1ecc69bef4eb4fc5e050:

  bcachefs: Kill unnecessary bch2_dev_usage_read() (2025-03-24 09:50:37 -0400)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-03-31

for you to fetch changes up to 650f5353dcc9b6e690a1c763754fa1e98d217bfc:

  bcachefs: fix bch2_write_point_to_text() units (2025-03-30 20:04:16 -0400)

----------------------------------------------------------------
bcachefs updates for 6.15, part 2

All bugfixes and logging improvements.

Minor merge conflict, see:
https://lore.kernel.org/linux-next/20250331092816.778a7c83@canb.auug.org.au/T/#u

CI says the fs-next tree is good:
https://evilpiepirate.org/~testdashboard/ci?user=fs-next&branch=master

----------------------------------------------------------------
Florian Albrechtskirchinger (1):
      bcachefs: Fix bch2_fs_get_tree() error path

Kent Overstreet (34):
      bcachefs: Fix nonce inconsistency in bch2_write_prep_encoded_data()
      bcachefs: Fix silent short reads in data read retry path
      bcachefs: Fix duplicate checksum error messages in write path
      bcachefs: Use print_string_as_lines() for journal stuck messages
      bcachefs: Validate number of counters for accounting keys
      bcachefs: Document disk accounting keys and conuters
      bcachefs: Don't unnecessarily decrypt data when moving
      bcachefs: Fix btree iter flags in data move (2)
      bcachefs: Fix 'hung task' messages in btree node scan
      bcachefs: cond_resched() in journal_key_sort_cmp()
      bcachefs: Fix permissions on version modparam
      bcachefs: Recovery no longer holds state_lock
      bcachefs: Fix bch2_seek_hole() locking
      bcachefs: Don't return 0 size holes from bch2_seek_hole()
      bcachefs: Fix WARN() in bch2_bkey_pick_read_device()
      bcachefs: print_string_as_lines: fix extra newline
      bcachefs: add missing newline in bch2_trans_updates_to_text()
      bcachefs: fix logging in journal_entry_err_msg()
      bcachefs: bch2_time_stats_init_no_pcpu()
      bcachefs: Add an "ignore unknown" option to bch2_parse_mount_opts()
      bcachefs: Consistent indentation of multiline fsck errors
      bcachefs: Better helpers for inconsistency errors
      bcachefs: bch2_count_fsck_err()
      bcachefs: Better printing of inconsistency errors
      bcachefs: Change btree_insert_node() assertion to error
      bcachefs: Clear fs_path_parent on subvolume unlink
      bcachefs: bch2_ioctl_subvolume_destroy() fixes
      bcachefs: fix units in rebalance_status
      bcachefs: Silence errors after emergency shutdown
      bcachefs: Don't use designated initializers for disk_accounting_pos
      bcachefs: Reorder error messages that include journal debug
      bcachefs: BCH_JSET_ENTRY_log_bkey
      bcachefs: Log original key being moved in data updates
      bcachefs: fix bch2_write_point_to_text() units

 fs/bcachefs/alloc_background.c       |  22 ++--
 fs/bcachefs/alloc_foreground.c       |   2 +-
 fs/bcachefs/backpointers.c           |  43 ++++---
 fs/bcachefs/bcachefs_format.h        |   3 +-
 fs/bcachefs/btree_cache.c            |   2 +-
 fs/bcachefs/btree_gc.c               |  23 ++--
 fs/bcachefs/btree_io.c               |  63 +++++-----
 fs/bcachefs/btree_iter.c             |  14 +--
 fs/bcachefs/btree_iter.h             |   1 -
 fs/bcachefs/btree_journal_iter.c     |   2 +
 fs/bcachefs/btree_node_scan.c        |  14 ++-
 fs/bcachefs/btree_update.c           |  13 ++
 fs/bcachefs/btree_update.h           |   2 +
 fs/bcachefs/btree_update_interior.c  |  91 ++++++++------
 fs/bcachefs/buckets.c                | 161 ++++++++++++++-----------
 fs/bcachefs/chardev.c                |   6 +-
 fs/bcachefs/data_update.c            |  22 +++-
 fs/bcachefs/data_update.h            |  12 ++
 fs/bcachefs/disk_accounting.c        |  40 ++++---
 fs/bcachefs/disk_accounting.h        |   8 +-
 fs/bcachefs/disk_accounting_format.h |  80 +++++++++++--
 fs/bcachefs/ec.c                     |  22 ++--
 fs/bcachefs/errcode.h                |   3 +
 fs/bcachefs/error.c                  | 226 ++++++++++++++++++++++++++---------
 fs/bcachefs/error.h                  |  48 ++++----
 fs/bcachefs/extents.c                |   7 +-
 fs/bcachefs/fs-io-buffered.c         |   2 +-
 fs/bcachefs/fs-io.c                  |  31 +++--
 fs/bcachefs/fs-ioctl.c               |   6 +-
 fs/bcachefs/fs.c                     |   9 +-
 fs/bcachefs/fsck.c                   |  22 ++--
 fs/bcachefs/io_read.c                |   4 +-
 fs/bcachefs/io_read.h                |   6 +-
 fs/bcachefs/io_write.c               |  44 ++++---
 fs/bcachefs/journal.c                |  19 +--
 fs/bcachefs/journal_io.c             |  38 ++++--
 fs/bcachefs/lru.c                    |   7 +-
 fs/bcachefs/move.c                   |  37 +++++-
 fs/bcachefs/namei.c                  |   4 +-
 fs/bcachefs/opts.c                   |  49 ++++----
 fs/bcachefs/opts.h                   |   3 +-
 fs/bcachefs/printbuf.c               |  19 +++
 fs/bcachefs/printbuf.h               |   1 +
 fs/bcachefs/progress.c               |   6 +-
 fs/bcachefs/rebalance.c              |   5 +-
 fs/bcachefs/recovery_passes.c        |  12 +-
 fs/bcachefs/reflink.c                |  12 +-
 fs/bcachefs/sb-errors_format.h       |   6 +-
 fs/bcachefs/snapshot.c               |  16 +--
 fs/bcachefs/str_hash.c               |   2 +-
 fs/bcachefs/subvolume.c              |   1 +
 fs/bcachefs/super.c                  |  38 +++---
 fs/bcachefs/sysfs.c                  |   9 +-
 fs/bcachefs/time_stats.c             |  20 +++-
 fs/bcachefs/time_stats.h             |   1 +
 fs/bcachefs/util.c                   |   2 +-
 fs/bcachefs/util.h                   |   1 +
 57 files changed, 856 insertions(+), 506 deletions(-)

