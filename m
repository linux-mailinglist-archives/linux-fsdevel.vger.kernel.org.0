Return-Path: <linux-fsdevel+bounces-32595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD349AB543
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 19:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1C2285FD7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 17:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B801BE858;
	Tue, 22 Oct 2024 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VlLe/KFg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C581BDA9F
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618761; cv=none; b=pKUrD1Teoxx3IF/bCAsmWbToxS0nH3Vf8iIbQdFc2F2UEAwfin4drZUA06YXCK+QxJ9y+JT6FOUKUIthrHVSa3K77MdAeQrGP++po/fcpFgLRSNIFipHyB4f0O24HO+wOSdJYExbUw1gzodFQtwKcJN0UNIBnkjiuFNtls2urDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618761; c=relaxed/simple;
	bh=5nYBuq8flg0IclcEtqjui0Y8ymtQtA0o/gQ3AaI5Ayk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l3GnHR+K6OrRGX8V5xHCG0KM2pzWTb+3oeQYHisAVyoXHrR+PHeym7xtzmW1yHwx3ttV88qUN7Y6owlI3K2gVwdaQDdYJ2YqaWTr2GSsD71+RujuEE4NAVc0PNTXD8LK0jbM1jk4pxxoNyTAFvsR2w2ItaltYpUhtSobu5wpcaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VlLe/KFg; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Oct 2024 13:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729618756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=nFfwM9REuPvTQaQq5UTnE7bd6ms89tAFZaS8hK6Mt6w=;
	b=VlLe/KFggxObBc8y8RewF50LrIxdfpQZsKaHN1dbMAz2mBQub0lPVBcVUWpJcNLEn0T9D3
	ykp/d7VQtIXsXVyrXA1m0JFY7HomLjB7Rx9b0vzY3XXb2mMS/604lEuxSG2uGFfJ8YW483
	lX3RW0nuDC0dXZTpN4oiG+Lw8D27Sx0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.12-rc5
Message-ID: <rdjwihb4vl62psonhbowazcd6tsv7jp6wbfkku76ze3m3uaxt3@nfe3ywdphf52>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT


The following changes since commit 5e3b72324d32629fa013f86657308f3dbc1115e1:

  bcachefs: Fix sysfs warning in fstests generic/730,731 (2024-10-14 05:43:01 -0400)

are available in the Git repository at:

  https://github.com/koverstreet/bcachefs tags/bcachefs-2024-10-22

for you to fetch changes up to a069f014797fdef8757f3adebc1c16416271a599:

  bcachefs: Set bch_inode_unpacked.bi_snapshot in old inode path (2024-10-20 18:09:09 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.12-rc5

Lots of hotfixes:
- transaction restart injection has been shaking out a few things

- fix a data corruption in the buffered write path on -ENOSPC, found by
  xfstests generic/299

- Some small show_options fixes

- Repair mismatches in inode hash type, seed: different snapshot
  versions of an inode must have the same hash/type seed, used for
  directory entries and xattrs. We were checking the hash seed, but not
  the type, and a user contributed a filesystem where the hash type on
  one inode had somehow been flipped; these fixes allow his filesystem
  to repair.

  Additionally, the hash type flip made some directory entries
  invisible, which were then recreated by userspace; so the hash check
  code now checks for duplicate non dangling dirents, and renames one of
  them if necessary.

- Don't use wait_event_interruptible() in recovery: this fixes some
  filesystems failing to mount with -ERESTARTSYS

- Workaround for kvmalloc not supporting > INT_MAX allocations, causing
  an -ENOMEM when allocating the sorted array of journal keys: this
  allows a 75 TB filesystem to mount

- Make sure bch_inode_unpacked.bi_snapshot is set in the old inode
  compat path: this alllows Marcin's filesystem (in use since before
  6.7) to repair and mount.

----------------------------------------------------------------
Hongbo Li (2):
      bcachefs: fix incorrect show_options results
      bcachefs: skip mount option handle for empty string.

Kent Overstreet (24):
      bcachefs: fix restart handling in bch2_rename2()
      bcachefs: fix bch2_hash_delete() error path
      bcachefs: fix restart handling in bch2_fiemap()
      bcachefs: fix missing restart handling in bch2_read_retry_nodecode()
      bcachefs: fix restart handling in bch2_do_invalidates_work()
      bcachefs: fix restart handling in bch2_alloc_write_key()
      bcachefs: fix restart handling in __bch2_resume_logged_op_finsert()
      bcachefs: handle restarts in bch2_bucket_io_time_reset()
      bcachefs: Don't use commit_do() unnecessarily
      bcachefS: ec: fix data type on stripe deletion
      bcachefs: fix disk reservation accounting in bch2_folio_reservation_get()
      bcachefs: bch2_folio_reservation_get_partial() is now better behaved
      bcachefs: Fix data corruption on -ENOSPC in buffered write path
      bcachefs: Run in-kernel offline fsck without ratelimit errors
      bcachefs: INODE_STR_HASH() for bch_inode_unpacked
      bcachefs: Add hash seed, type to inode_to_text()
      bcachefs: Repair mismatches in inode hash seed, type
      bcachefs: bch2_hash_set_or_get_in_snapshot()
      bcachefs: fsck: Improve hash_check_key()
      bcachefs: Fix __bch2_fsck_err() warning
      bcachefs: Don't use wait_event_interruptible() in recovery
      bcachefs: Workaround for kvmalloc() not supporting > INT_MAX allocations
      bcachefs: Mark more errors as AUTOFIX
      bcachefs: Set bch_inode_unpacked.bi_snapshot in old inode path

 fs/bcachefs/alloc_background.c      |  37 +++--
 fs/bcachefs/alloc_foreground.c      |   2 +-
 fs/bcachefs/btree_gc.c              |  12 +-
 fs/bcachefs/btree_io.c              |   2 +-
 fs/bcachefs/btree_iter.h            |   2 +
 fs/bcachefs/btree_update.c          |   4 +-
 fs/bcachefs/btree_update.h          |   2 +-
 fs/bcachefs/btree_update_interior.c |   4 +-
 fs/bcachefs/buckets.c               |   7 +-
 fs/bcachefs/buckets.h               |  12 +-
 fs/bcachefs/chardev.c               |   1 +
 fs/bcachefs/darray.c                |  15 +-
 fs/bcachefs/dirent.c                |   7 -
 fs/bcachefs/dirent.h                |   7 +
 fs/bcachefs/disk_accounting.c       |   6 +-
 fs/bcachefs/ec.c                    |  22 +--
 fs/bcachefs/error.c                 |   5 +-
 fs/bcachefs/fs-io-buffered.c        |   6 +
 fs/bcachefs/fs-io-pagecache.c       |  70 +++++----
 fs/bcachefs/fs-io.c                 |   2 +-
 fs/bcachefs/fs.c                    |  18 +--
 fs/bcachefs/fsck.c                  | 281 +++++++++++++++++++++++++++++-------
 fs/bcachefs/inode.c                 |  27 ++--
 fs/bcachefs/inode.h                 |   1 +
 fs/bcachefs/inode_format.h          |   6 +-
 fs/bcachefs/io_misc.c               |   2 +-
 fs/bcachefs/io_read.c               |   8 +-
 fs/bcachefs/io_write.c              |   4 +-
 fs/bcachefs/journal.c               |  10 +-
 fs/bcachefs/journal.h               |   2 +-
 fs/bcachefs/opts.c                  |   6 +-
 fs/bcachefs/opts.h                  |   3 +-
 fs/bcachefs/quota.c                 |   2 +-
 fs/bcachefs/rebalance.c             |   4 +-
 fs/bcachefs/recovery.c              |   2 +-
 fs/bcachefs/sb-errors_format.h      |   4 +-
 fs/bcachefs/str_hash.h              |  60 +++++---
 fs/bcachefs/subvolume.c             |   7 +-
 fs/bcachefs/super.c                 |   2 +-
 fs/bcachefs/tests.c                 |   4 +-
 fs/bcachefs/xattr.c                 |   2 +-
 41 files changed, 475 insertions(+), 205 deletions(-)

