Return-Path: <linux-fsdevel+bounces-26158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0204995548C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 03:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B57283F91
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 01:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBA14A33;
	Sat, 17 Aug 2024 01:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NbQ+w4oL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869CC29A2
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Aug 2024 01:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723857616; cv=none; b=VFEi7J3WXDHjX54FANrFPUZSXm6+KKjE/xIKeYyrfN7U2MbbPVGRtaxuzenflwyooT1H9nmlUD0oneBrcBUGl5pBZmcsXP4uPYIjHv8rEMTyvWi6ss85MWLje9zyg7fA7VIOiBla7rh6F/I/ZEjDJWECZOoQ8SjDoEOqj/8Rfes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723857616; c=relaxed/simple;
	bh=6xizN+LbSybSC+qA6Wufiq3CS/S2oVo+OZCVEwpDJNk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sP4iXWphDaGaiK+23eigFvoAdjMev91+VRfTqVcBcwKkR934hnoM9YtWI2FVSSOIio+Bf+Za6+j6Ol4W4su/j+n0rgU9enbEl9Ib6oiJHb2ml+ITI4pQYZCMpF3+j/R+o3HlySmPw5R7weBaiL1Il/aXcFOWS/4bgjY9Y4cazIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NbQ+w4oL; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 16 Aug 2024 21:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723857610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=iF3eBkejSMN1ED//zc+wduQ2laK1pfoGGnyFLYjXXOU=;
	b=NbQ+w4oLbZz+M8+ISTcH/2LY2UMabTzanyqI3cX/tMWrHTu4eDd3xg381N+TYXej0rqrKn
	VIYUZAEkvf45BAkkGzrGCAtVM2eK/ThAlHq/8YFfJNwWjmIrjeEMEUNLQPI2cv5wWNqVWD
	k1Wb7b/N+enLQOz6S7WNZevfyKAVbzg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.11-rc4
Message-ID: <xu2afkq5jhn62z3juxkbvs2idoyldruyv3h65ympwx2svbgjia@2qqk5e6pcdoc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus, fresh batch of fixes for you.

We still have one regression from the disk accounting rewrite
outstanding: we have a user reporting that the checks in
bch2_accounting_validate() are firing, and in a codepath where that
shouldn't be possible. Something funny is going on.

Aside from that, everything is looking good for 6.11, and I expect we'll
have that one resolved soon.

The following changes since commit 8a2491db7bea6ad88ec568731eafd583501f1c96:

  bcachefs: bcachefs_metadata_version_disk_accounting_v3 (2024-08-09 19:21:28 -0400)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-08-16

for you to fetch changes up to 0e49d3ff12501adaafaf6fdb19699f021d1eda1c:

  bcachefs: Fix locking in __bch2_trans_mark_dev_sb() (2024-08-16 20:45:15 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.11-rc4

- New on disk format version, bcachefs_metadata_version_disk_accounting_inum

This adds one more disk accounting counter, which counts disk usage and
number of extents per inode number. This lets us track fragmentation,
for implementing defragmentation later, and it also counts disk usage
per inode in all snapshots, which will be a useful thing to expose to
users.

- One performance issue we've observed is threads spinning when they
should be waiting for dirty keys in the key cache to be flushed by
journal reclaim, so we now have hysteresis for the waiting thread, as
well as improving the tracepoint and a new time_stat, for tracking time
blocked waiting on key cache flushing.

And, various assorted smaller fixes.

----------------------------------------------------------------
Kent Overstreet (19):
      bcachefs: delete faulty fastpath in bch2_btree_path_traverse_cached()
      bcachefs: Fix bch2_trigger_alloc when upgrading from old versions
      bcachefs: bch2_accounting_invalid() fixup
      bcachefs: disk accounting: ignore unknown types
      bcachefs: Add missing downgrade table entry
      bcachefs: Convert for_each_btree_node() to lockrestart_do()
      lib/generic-radix-tree.c: Fix rare race in __genradix_ptr_alloc()
      bcachefs: Add hysteresis to waiting on btree key cache flush
      bcachefs: Improve trans_blocked_journal_reclaim tracepoint
      bcachefs: Add a time_stat for blocked on key cache flush
      bcachefs: Fix warning in __bch2_fsck_err() for trans not passed in
      bcachefs: Make bkey_fsck_err() a wrapper around fsck_err()
      bcachefs: Kill __bch2_accounting_mem_mod()
      bcachefs: bcachefs_metadata_version_disk_accounting_inum
      bcachefs: Increase size of cuckoo hash table on too many rehashes
      bcachefs: Fix forgetting to pass trans to fsck_err()
      bcachefs: avoid overflowing LRU_TIME_BITS for cached data lru
      bcachefs: fix incorrect i_state usage
      bcachefs: Fix locking in __bch2_trans_mark_dev_sb()

 fs/bcachefs/alloc_background.c            |  77 ++++++++--------
 fs/bcachefs/alloc_background.h            |  30 +++----
 fs/bcachefs/backpointers.c                |  23 ++---
 fs/bcachefs/backpointers.h                |   5 +-
 fs/bcachefs/bcachefs.h                    |   1 +
 fs/bcachefs/bcachefs_format.h             |   3 +-
 fs/bcachefs/bkey.h                        |   7 +-
 fs/bcachefs/bkey_methods.c                | 109 +++++++++++-----------
 fs/bcachefs/bkey_methods.h                |  21 +++--
 fs/bcachefs/btree_gc.c                    |   5 +-
 fs/bcachefs/btree_io.c                    |  69 +++++---------
 fs/bcachefs/btree_iter.c                  |   1 +
 fs/bcachefs/btree_iter.h                  |  42 +++++----
 fs/bcachefs/btree_key_cache.c             |   5 --
 fs/bcachefs/btree_key_cache.h             |  18 +++-
 fs/bcachefs/btree_node_scan.c             |   2 +-
 fs/bcachefs/btree_trans_commit.c          |  82 +++++------------
 fs/bcachefs/btree_update_interior.c       |  16 +---
 fs/bcachefs/buckets.c                     |  30 +++++--
 fs/bcachefs/buckets_waiting_for_journal.c |  11 ++-
 fs/bcachefs/data_update.c                 |   6 +-
 fs/bcachefs/debug.c                       |  38 ++------
 fs/bcachefs/dirent.c                      |  33 ++++---
 fs/bcachefs/dirent.h                      |   5 +-
 fs/bcachefs/disk_accounting.c             |  34 ++++---
 fs/bcachefs/disk_accounting.h             |  60 ++++++-------
 fs/bcachefs/disk_accounting_format.h      |   8 +-
 fs/bcachefs/ec.c                          |  15 ++--
 fs/bcachefs/ec.h                          |   5 +-
 fs/bcachefs/errcode.h                     |   1 +
 fs/bcachefs/error.c                       |  22 +++++
 fs/bcachefs/error.h                       |  39 ++++----
 fs/bcachefs/extents.c                     | 144 +++++++++++++++---------------
 fs/bcachefs/extents.h                     |  24 ++---
 fs/bcachefs/fs.c                          |   2 +-
 fs/bcachefs/inode.c                       |  77 ++++++++--------
 fs/bcachefs/inode.h                       |  24 ++---
 fs/bcachefs/journal_io.c                  |  24 ++---
 fs/bcachefs/lru.c                         |   9 +-
 fs/bcachefs/lru.h                         |   5 +-
 fs/bcachefs/quota.c                       |   8 +-
 fs/bcachefs/quota.h                       |   5 +-
 fs/bcachefs/reflink.c                     |  19 ++--
 fs/bcachefs/reflink.h                     |  22 ++---
 fs/bcachefs/sb-downgrade.c                |   6 +-
 fs/bcachefs/snapshot.c                    |  42 +++++----
 fs/bcachefs/snapshot.h                    |  11 ++-
 fs/bcachefs/subvolume.c                   |  16 ++--
 fs/bcachefs/subvolume.h                   |   5 +-
 fs/bcachefs/trace.c                       |   1 +
 fs/bcachefs/trace.h                       |  27 +++++-
 fs/bcachefs/xattr.c                       |  21 +++--
 fs/bcachefs/xattr.h                       |   5 +-
 lib/generic-radix-tree.c                  |   2 +
 54 files changed, 650 insertions(+), 672 deletions(-)

