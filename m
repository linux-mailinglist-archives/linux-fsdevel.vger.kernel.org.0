Return-Path: <linux-fsdevel+bounces-12693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5B68628CF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 03:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA281F217AF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 02:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604418BF7;
	Sun, 25 Feb 2024 02:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uvwcLTA/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575B62F41
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 02:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708828719; cv=none; b=jh0BYQEzrb9IHIrR7vuhwEcTABItwbnKp4I4sXgTKbE09k4iOn/eAf4qCJ92ObB8GeXIjS+U3tz9CqnsPAHWuYb/Zj33Vg289TF1jtE9HZxkOTONpvDEq6dXYBSPZKzBQjIIkXXZGQgVrcQhxDSJfCZF8BT3Xa71NS/D95VrPMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708828719; c=relaxed/simple;
	bh=JoV9DJ+vFR1r4GaiacG2hqDz+lqO9SZK4X/J6Hh6ANI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CbgyrGvb7cIiIarKuTLePV5sjGambE7uZX7RsB7nmacn9jJMQa3ZJFvbDLp1DtowqNbcDEnlvv7HJ8PKOzv2vJjxOhgxEdfMTvTRIXDQA0cgQKQFyQ0TFhjF9Xj3jo4lrMamqIWEHCx7BUyFJxOxTQUiOf4tGtr3VTvw9P+4hzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uvwcLTA/; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708828714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V5+DSdY0aRNEv/2+yTdFbM0tH4++AQae7Dw+EEJHSY8=;
	b=uvwcLTA/FEYN7cQhp0+DJgmyNTxQzHXzQcPOnzdacjXH9q08bX/38vNHprJikRJ/V1Rn4Z
	PvREeBNAPNBb39BzEPLVcbpB5A2F6t1yyKPL8b5HDDIQ5tmjq/h69jnBsTULrLBQbrQ4/6
	l9xrarlLJ5u49AJ9HDVZ+V04c0xldrA=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	djwong@kernel.org,
	bfoster@redhat.com
Subject: [PATCH 00/21] bcachefs disk accounting rewrite
Date: Sat, 24 Feb 2024 21:38:02 -0500
Message-ID: <20240225023826.2413565-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

here it is; the disk accounting rewrite I've been talking about since
forever.

git link:
https://evilpiepirate.org/git/bcachefs.git/log/?h=bcachefs-disk-accounting-rewrite

test dashboard (just rebased, results are regenerating as of this
writing but shouldn't be any regressions left):
https://evilpiepirate.org/~testdashboard/ci?branch=bcachefs-disk-accounting-rewrite

The old disk accounting scheme was fast, but had some limitations:

 - lack of scalability: it was based on percpu counters additionally
   sharded by outstanding journal buffer, and then just prior to journal
   write we'd roll up the counters and add them to the journal entry.

   But this meant that all counters were added to every journal write,
   which meant it'd never be able to support per-snapshot counters.

 - it was a pain to extend
   this was why, until now, we didn't have proper compressed accounting,
   and getting compression ratio required a full btree scan

In the new scheme:
 - every set of counters is a bkey, a key in a btree
   (BTREE_ID_accounting).

   this means they aren't pinned in the journal

 - the key has structure, and is extensible
   disk_accounting_key is a tagged union, and it's just union'd over
   bpos

 - counters are deltas, until flushed to the underlying btree

   this means counter updates are normal btree updates; the btree write
   buffer makes counter updates efficient.

Since reading counters from the btree would be expensive - it'd require
a write buffer flush to get up-to-date counters - we also maintain a
parallel set of accounting in memory, a bit like the old scheme but
without the per-journal-buffer sharding. The in memory accounters
indexed in an eytzinger tree by disk_accounting_key/bpos, with the
counters themselves being percpu u64s.

Reviewers: do a "is this adequately documented, can I find my way
around, do things make sense", not line-by-line "does this have bugs".

Compatibility: this is in no way compatible with the old disk accounting
on disk format, and it's not feasible to write out accounting in the old
format - that means we have to regenerate accounting when upgrading or
downgrading past this version.

That should work more or less seamlessly with the most recent compat
bits (bch_sb_field downgrade, so we can tell older versions what
recovery psases to run and what to fix); additionally, userspace fsck
now checks if the kernel bcachefs version better matches the on disk
version than itself and if so uses the kernle fsck implementation with
the OFFLINE_FSCK ioctl - so we shouldn't be bouncing back and forth
between versions if your tools and kernel don't match.

upgrade/downgrade still need a bit more testing, but transparently using
kernel fsck is well tested as of latest versions.

but: 6.7 users (& possibly 6.8) beware, the sb_downgrade section is in
6.7 but BCH_IOCTL_OFFLINE_FSCK is not, and backporting that doesn't look
likely given current -stable process fiasco.

merge ETA - this stuff may make the next merge window; I'd like to get
per-snapshot-id accounting done with it, that should be the biggest item
left.

Cheers,
Kent

Kent Overstreet (21):
  bcachefs: KEY_TYPE_accounting
  bcachefs: Accumulate accounting keys in journal replay
  bcachefs: btree write buffer knows how to accumulate bch_accounting
    keys
  bcachefs: Disk space accounting rewrite
  bcachefs: dev_usage updated by new accounting
  bcachefs: Kill bch2_fs_usage_initialize()
  bcachefs: Convert bch2_ioctl_fs_usage() to new accounting
  bcachefs: kill bch2_fs_usage_read()
  bcachefs: Kill writing old accounting to journal
  bcachefs: Delete journal-buf-sharded old style accounting
  bcachefs: Kill bch2_fs_usage_to_text()
  bcachefs: Kill fs_usage_online
  bcachefs: Kill replicas_journal_res
  bcachefs: Convert gc to new accounting
  bcachefs: Convert bch2_replicas_gc2() to new accounting
  bcachefs: bch2_verify_accounting_clean()
  bcachefs: Eytzinger accumulation for accounting keys
  bcachefs: bch_acct_compression
  bcachefs: Convert bch2_compression_stats_to_text() to new accounting
  bcachefs: bch2_fs_accounting_to_text()
  bcachefs: bch2_fs_usage_base_to_text()

 fs/bcachefs/Makefile                   |   3 +-
 fs/bcachefs/alloc_background.c         | 137 +++--
 fs/bcachefs/alloc_background.h         |   2 +
 fs/bcachefs/bcachefs.h                 |  22 +-
 fs/bcachefs/bcachefs_format.h          |  81 +--
 fs/bcachefs/bcachefs_ioctl.h           |   7 +-
 fs/bcachefs/bkey_methods.c             |   1 +
 fs/bcachefs/btree_gc.c                 | 259 ++++------
 fs/bcachefs/btree_iter.c               |   9 -
 fs/bcachefs/btree_journal_iter.c       |  23 +-
 fs/bcachefs/btree_journal_iter.h       |  15 +
 fs/bcachefs/btree_trans_commit.c       |  71 ++-
 fs/bcachefs/btree_types.h              |   1 -
 fs/bcachefs/btree_update.h             |  22 +-
 fs/bcachefs/btree_write_buffer.c       | 120 ++++-
 fs/bcachefs/btree_write_buffer.h       |  50 +-
 fs/bcachefs/btree_write_buffer_types.h |   2 +
 fs/bcachefs/buckets.c                  | 663 ++++---------------------
 fs/bcachefs/buckets.h                  |  70 +--
 fs/bcachefs/buckets_types.h            |  14 +-
 fs/bcachefs/chardev.c                  |  75 +--
 fs/bcachefs/disk_accounting.c          | 584 ++++++++++++++++++++++
 fs/bcachefs/disk_accounting.h          | 203 ++++++++
 fs/bcachefs/disk_accounting_format.h   | 145 ++++++
 fs/bcachefs/disk_accounting_types.h    |  20 +
 fs/bcachefs/ec.c                       | 166 ++++---
 fs/bcachefs/inode.c                    |  42 +-
 fs/bcachefs/journal_io.c               |  13 +-
 fs/bcachefs/recovery.c                 | 126 +++--
 fs/bcachefs/recovery_types.h           |   1 +
 fs/bcachefs/replicas.c                 | 242 ++-------
 fs/bcachefs/replicas.h                 |  16 +-
 fs/bcachefs/replicas_format.h          |  21 +
 fs/bcachefs/replicas_types.h           |  16 -
 fs/bcachefs/sb-clean.c                 |  62 ---
 fs/bcachefs/sb-downgrade.c             |  12 +-
 fs/bcachefs/sb-errors_types.h          |   4 +-
 fs/bcachefs/super.c                    |  74 ++-
 fs/bcachefs/sysfs.c                    | 109 ++--
 39 files changed, 1873 insertions(+), 1630 deletions(-)
 create mode 100644 fs/bcachefs/disk_accounting.c
 create mode 100644 fs/bcachefs/disk_accounting.h
 create mode 100644 fs/bcachefs/disk_accounting_format.h
 create mode 100644 fs/bcachefs/disk_accounting_types.h
 create mode 100644 fs/bcachefs/replicas_format.h

-- 
2.43.0


