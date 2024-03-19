Return-Path: <linux-fsdevel+bounces-14844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0867880723
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 23:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E273C1C21B31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 22:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872934F88A;
	Tue, 19 Mar 2024 22:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cu9OoAcZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29215101D4
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Mar 2024 22:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710886284; cv=none; b=n9jNbWHZ/HU02Mc8MI82qphYf7Gz57mdUINGFujN82SlXgzX/f2wjLw8jI8dLBHHsl81pBtmq5j+66isip0RDTWFwbmtmIoUW6frSEzzIdsb33vgke7XavWJvzeFcPjtlDCInPWpViC55FiPcK5Sy1tcEN02w+LGQ45gWBfiJso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710886284; c=relaxed/simple;
	bh=ISOhSDV7rsGKaoctsa473zJBnGTkZPKSqQr9JefmsnU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cLydHMjSRs/3LCtr5JCzA8fSYsUqY13U3NNFPwVc1MxPt4imkOMsRSG28ehCWMQt4w4KikUXhApghcTcIxDU78K6cjIe/rrhebHTWLIkirOWlWaGZKjhp2PdB89Jbj51e25k4dv2MHg+xzzmr114YTQo7E8NpkHAb4rmqxzckxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cu9OoAcZ; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 19 Mar 2024 18:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710886280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=QbdXFcsAVXRBojMy8+Pc1cBSvS+94IkHlxqp1mxqCDA=;
	b=cu9OoAcZOnxyy0MzUqbeHKlUU+mVOtmwFz0r+pnrQlXkFdQSAIYGmYHkXLwIs4zW+At/dP
	90C6qFzRIREg0qkm2hcW5ePIkrv1KIOs4b0LcsIEeCMDWvVeK+ds7lguhqtWLM3sIqWWTU
	DLSYVXf65f906aEcgritGg4oSJKozhc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bachefs fixes for 6.9-rc1
Message-ID: <qhecenhgh5bnkjllimyvmqc6cv5bv4vposvh5hqtjjm7hx3q4u@r4gwjp6wl2k2>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus, small batch of bcachefs fixes for you.

Going to have a larger pull for you soon with some new repair code -
some users got hit bad with the failure to downgrade bug (the fix for
which is still not in 6.7) - that caused the splitbrain detection to
attempt to kick out every device from the filesystem, and some users
attempted to run in very_degraded mode got things very borked.

For users:
 - there's a no_splitbrain_check option which runs the splitbrain checks
   in dry run mode, that should suffice to get most people going
 - if your fs is very borked, 'scan entire device for btree nodes and
   reconstruct' is almost done; it looks like that will be a pretty
   bulletproof way to reconstruct.

Some poeple may have their filesystems unavailable for a bit but I'm
trying to make sure no one looses data, and no one should be forced to
migrate either, we should always get back to a working functional rw fs.

Cheers,
Kent

The following changes since commit be28368b2ccb328b207c9f66c35bb088d91e6a03:

  bcachefs: time_stats: shrink time_stat_buffer for better alignment (2024-03-13 21:38:03 -0400)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-03-19

for you to fetch changes up to 2e92d26b25432ec3399cb517beb0a79a745ec60f:

  bcachefs: Fix lost wakeup on journal shutdown (2024-03-18 23:35:42 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.9-rc1

Assorted bugfixes.

Most are fixes for simple assertion pops; the most significant fix is
for a deadlock in recovery when we have to rewrite large numbers of
btree nodes to fix errors. This was incorrectly running out of the same
workqueue as the core interior btree update path - we now give it its
own single threaded workqueue.

This was visible to users as "bch2_btree_update_start(): error:
BCH_ERR_journal_reclaim_would_deadlock" - and then recovery hanging.

----------------------------------------------------------------
Kent Overstreet (17):
      bcachefs: Change "accounting overran journal reservation" to a warning
      bcachefs: Fix check_key_has_snapshot() call
      bcachefs: Fix spurious -BCH_ERR_transaction_restart_nested
      bcachefs: Avoid extent entry type assertions in .invalid()
      bcachefs: Fix locking in bch2_alloc_write_key()
      bcachefs: Split out btree_node_rewrite_worker
      bcachefs: Improve sysfs internal/btree_updates
      bcachefs: Fix nested transaction restart handling in bch2_bucket_gens_init()
      bcachefs: bch2_snapshot_is_ancestor() now safe to call in early recovery
      bcachefs: fix for building in userspace
      bcachefs: Don't corrupt journal keys gap buffer when dropping alloc info
      bcachefs: Fix lost transaction restart error
      bcachefs: Improve bch2_fatal_error()
      bcachefs: Run check_topology() first
      bcachefs: ratelimit errors from async_btree_node_rewrite
      bcachefs; Fix deadlock in bch2_btree_update_start()
      bcachefs: Fix lost wakeup on journal shutdown

 fs/bcachefs/alloc_background.c      | 15 +++++++------
 fs/bcachefs/alloc_foreground.c      | 10 +++++----
 fs/bcachefs/bcachefs.h              |  2 ++
 fs/bcachefs/btree_gc.c              |  2 +-
 fs/bcachefs/btree_io.c              | 12 +++++-----
 fs/bcachefs/btree_key_cache.c       |  2 +-
 fs/bcachefs/btree_update_interior.c | 44 ++++++++++++++++++++++++-------------
 fs/bcachefs/btree_update_interior.h |  1 +
 fs/bcachefs/btree_write_buffer.c    |  2 +-
 fs/bcachefs/buckets.c               |  6 ++---
 fs/bcachefs/debug.c                 |  2 +-
 fs/bcachefs/ec.c                    |  6 ++---
 fs/bcachefs/error.h                 |  4 ++--
 fs/bcachefs/extents.h               |  6 ++---
 fs/bcachefs/fs.c                    |  3 ++-
 fs/bcachefs/fsck.c                  | 33 ++++++++++++++++++++--------
 fs/bcachefs/journal.c               | 12 +++++-----
 fs/bcachefs/journal_io.c            | 15 ++++++-------
 fs/bcachefs/logged_ops.c            |  4 ++--
 fs/bcachefs/movinggc.c              |  3 +--
 fs/bcachefs/recovery.c              |  6 ++++-
 fs/bcachefs/recovery_types.h        |  2 +-
 fs/bcachefs/snapshot.c              | 32 +++++++++++++++------------
 fs/bcachefs/super-io.c              |  8 +++----
 fs/bcachefs/super.c                 | 33 ++++++++++++++--------------
 fs/bcachefs/util.h                  |  3 +++
 26 files changed, 157 insertions(+), 111 deletions(-)

