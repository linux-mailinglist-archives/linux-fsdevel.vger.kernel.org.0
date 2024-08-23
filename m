Return-Path: <linux-fsdevel+bounces-26982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FEC95D5A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 20:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74EAD2859DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B5D192B98;
	Fri, 23 Aug 2024 18:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cqmz/Ojv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205FB2D7B8
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 18:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724439283; cv=none; b=pvlW4jPaoNq+DnXSQgBLDNfmIPUYiJR4oXOQAktkBpfEQddXcpXjCF9IvI5TZU1jpuFKxn1iYqpXD5Y2UUkMskWgFdqYbwg8hfs3DAC7EqGDZj/ThDZv+ZtsvNSHEV1NMDmIWWwwxu/WsdwEovYhTM9A45n5rGHcJAIS61WLW8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724439283; c=relaxed/simple;
	bh=/DdMYTjwstrBylwKPuC2pFIafnNcMvM2MnZ06dk1UmE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=g6AIviTpr7hwMOlglj/I3tfQxdpI6hDBl9ItSC5QyS6hEMQVrmsixDe7QJrH4vMDjZAKVf+8I4zZ0Bl0FdZ3zBsnSECHqcjInylm1Eq+VqiyD2s9h/2+eCXsf6jt387O7EmQGvQTl0R1DrdbyPzvaQO5WfS4tvX4sO1Lu6Jcfuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cqmz/Ojv; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 23 Aug 2024 14:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724439278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ewITys7TI497HKJmvYcop9fBCsPv2oU9A0QT2PIx4Fg=;
	b=cqmz/OjvP1l+Xib5cy4oiaIfcB6/Rs/rVysfV9o7gtjxxbfAxgym6KR3GqknhZxrLxWN/6
	GzdnGfMpZYva7Le5atWFC5Vmpc/vBMzKhw4wU9nkwP0hsSr7beC1DQMV89+ABmgrnyijPQ
	ooDOJSAvhFBJxNbJf77rq/vtNC7Caxg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.11-rc5
Message-ID: <sctzes5z3s2zoadzldrpw3yfycauc4kpcsbpidjkrew5hkz7yf@eejp6nunfpin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus, big one this time...

no more bug reports related to the disk accounting rewrite, things are
looking good over here as far as regressions go

The following changes since commit 0e49d3ff12501adaafaf6fdb19699f021d1eda1c:

  bcachefs: Fix locking in __bch2_trans_mark_dev_sb() (2024-08-16 20:45:15 -0400)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-08-23

for you to fetch changes up to 4d8ead60ffd937a73b50f42f6bd776b6a7919dde:

  bcachefs: key cache can now allocate from pending (2024-08-22 11:51:55 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.11-rc5

Lots of little fixes and two big items, which were orgiinally slated for
the 6.12 merge window but turned out to be pretty important.

The little stuff includes assorted syzbot fixes and some upgrade fixes
for old (pre 1.0) filesystems, and a fix for moving data off a device
that was switched to durability=0 after data had been written to it.

The big items are:
- rhashtable conversion for VFS inodes cache
  Thas was slated for the 6.12 merge window, but a deadlock was
  uncovered in __wait_for_freeing_inode(); bcachefs inverts the usual
  locking between the VFS inode cache and on disk (btree) locking, with
  some advantages and some extra trickyness. The result was that we were
  waiting (via __wait_for_freeing_inode()) on the evict -> clear_inode()
  path with btree locks held, which was a rare deadlock but undoubtedly
  also one of the sources of the SRCU warnings.

- new data structure for managing freelists in btree key cache
  This eliminates the btree key cache lock, and associated lock
  contention. User feedback is that this resolves the main source of the
  SRCU warnings we've been seeing - which means that on some of the big
  multithreaded workloads people are running the lock contention was
  really bad (threads piling up and causing O(n^2) wait times), if it
  was able to trigger a 10 second delay warning.

On the test reported by
https://lore.kernel.org/linux-bcachefs/CAGudoHGenxzk0ZqPXXi1_QDbfqQhGHu+wUwzyS6WmfkUZ1HiXA@mail.gmail.com/

We're now 4x faster than xfs on creatrees, roughly even on walktrees,
with consistent run to run performance; dominant factor in profiles is
lru lock contention.

----------------------------------------------------------------
Kent Overstreet (34):
      bcachefs: Reallocate table when we're increasing size
      bcachefs: fix field-spanning write warning
      bcachefs: Fix incorrect gfp flags
      bcachefs: Extra debug for data move path
      bcachefs: bch2_data_update_init() cleanup
      bcachefs: Fix "trying to move an extent, but nr_replicas=0"
      bcachefs: setting bcachefs_effective.* xattrs is a noop
      bcachefs: Fix failure to relock in btree_node_get()
      bcachefs: Fix bch2_trigger_alloc assert
      bcachefs: Fix bch2_bucket_gens_init()
      bcachefs: fix time_stats_to_text()
      bcachefs: fix missing bch2_err_str()
      bcachefs: unlock_long() before resort in journal replay
      bcachefs: fix failure to relock in bch2_btree_node_mem_alloc()
      bcachefs: fix failure to relock in btree_node_fill()
      bcachefs: Fix locking in bch2_ioc_setlabel()
      bcachefs: Fix replay_now_at() assert
      bcachefs: Fix missing validation in bch2_sb_journal_v2_validate()
      fs/super.c: improve get_tree() error message
      bcachefs: Fix warning in bch2_fs_journal_stop()
      bcachefs: Fix compat issue with old alloc_v4 keys
      bcachefs: Fix refcounting in discard path
      bcachefs: clear path->should_be_locked in bch2_btree_key_cache_drop()
      bcachefs: add missing inode_walker_exit()
      bcachefs: don't use rht_bucket() in btree_key_cache_scan()
      inode: make __iget() a static inline
      bcachefs: switch to rhashtable for vfs inodes hash
      bcachefs: Fix deadlock in __wait_on_freeing_inode()
      bcachefs: journal_entry_replicas_not_marked is now autofix
      lib/generic-radix-tree.c: genradix_ptr_inlined()
      lib/generic-radix-tree.c: add preallocation
      bcachefs: rcu_pending
      bcachefs: Rip out freelists from btree key cache
      bcachefs: key cache can now allocate from pending

Yuesong Li (1):
      bcachefs: Fix double assignment in check_dirent_to_subvol()

 fs/bcachefs/Makefile                      |   1 +
 fs/bcachefs/acl.c                         |   2 +-
 fs/bcachefs/alloc_background.c            |  66 ++--
 fs/bcachefs/alloc_background_format.h     |   1 +
 fs/bcachefs/bcachefs.h                    |   1 +
 fs/bcachefs/btree_cache.c                 |  25 ++
 fs/bcachefs/btree_cache.h                 |   2 +
 fs/bcachefs/btree_iter.h                  |   9 +
 fs/bcachefs/btree_key_cache.c             | 426 ++++++---------------
 fs/bcachefs/btree_key_cache_types.h       |  18 +-
 fs/bcachefs/btree_types.h                 |   3 +-
 fs/bcachefs/btree_update_interior.c       |  46 +--
 fs/bcachefs/buckets_waiting_for_journal.c |   4 +-
 fs/bcachefs/data_update.c                 | 209 ++++++-----
 fs/bcachefs/extents.c                     |   2 +
 fs/bcachefs/fs-io-buffered.c              |   4 +-
 fs/bcachefs/fs-io-direct.c                |   2 +-
 fs/bcachefs/fs-io.c                       |   6 +-
 fs/bcachefs/fs-ioctl.c                    |   7 +-
 fs/bcachefs/fs.c                          | 234 ++++++++----
 fs/bcachefs/fs.h                          |  18 +-
 fs/bcachefs/fsck.c                        |   6 +-
 fs/bcachefs/inode.c                       |   2 +-
 fs/bcachefs/journal.c                     |   2 +-
 fs/bcachefs/journal_sb.c                  |  15 +
 fs/bcachefs/rcu_pending.c                 | 603 ++++++++++++++++++++++++++++++
 fs/bcachefs/rcu_pending.h                 |  25 ++
 fs/bcachefs/recovery.c                    |   9 +-
 fs/bcachefs/replicas.c                    |   3 +-
 fs/bcachefs/sb-errors_format.h            |   2 +-
 fs/bcachefs/subvolume_types.h             |   3 +-
 fs/bcachefs/super.c                       |   2 +
 fs/bcachefs/util.c                        |   1 -
 fs/bcachefs/xattr.c                       |  14 +-
 fs/inode.c                                |   8 -
 fs/super.c                                |   4 +-
 include/linux/fs.h                        |   9 +-
 include/linux/generic-radix-tree.h        | 106 +++++-
 lib/generic-radix-tree.c                  |  80 +---
 39 files changed, 1309 insertions(+), 671 deletions(-)
 create mode 100644 fs/bcachefs/rcu_pending.c
 create mode 100644 fs/bcachefs/rcu_pending.h

