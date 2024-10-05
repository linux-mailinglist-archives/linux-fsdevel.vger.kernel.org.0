Return-Path: <linux-fsdevel+bounces-31075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B540C991993
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 20:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23DA1B21499
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 18:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D7715D5DA;
	Sat,  5 Oct 2024 18:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P3NpJU6Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631BC15854F
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Oct 2024 18:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728153326; cv=none; b=I2gIFuRQrgof3vY8C7zIf4vr4HrBlQWYz3/xVdn0MRgvw8FcwGOCYfGM6IK7qABHC0TiTO19Ymjb+JG/X0J4SOe8U9A83gd0lEm5l8Tr3UcK25if6JRjLiLW+Sy3zjUnguj9zIUmsLWBcVimaDbYl/W/7qmczwM69pAWt4WuJkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728153326; c=relaxed/simple;
	bh=lCw7vnpXDNzWRzBIGJZ41zjrjyexnOuB98d+jyGedFI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LkrFBWkx06gFlvC8I1IWD89nrg7mPIvSJYNOL5xP8+tgERMOyRieSigeaErCSzvt0XVAlWXrEpiSrmOtlsrdbrWTvvd5qeeS0hHaN+cE6V7U5C/V1SShU6QrZooPpsdExRAGggM/25TWdHBjAwlH/Lk1Yf/OT/NfM95m2I+ly8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P3NpJU6Z; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 5 Oct 2024 14:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728153322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=AM7Qw3VEFLcUwcLSiVIWVKX76u7BUc/+Zwgd/c7iThE=;
	b=P3NpJU6ZrZKZbyYAeE5f7UeFsOkC94I+Ui/Gbm2VLC5AfWpwzzs62ek+PIbF0Hm9mPznkP
	0odq9ONjU+BWa14vIkwUfbdZpoyikVaggyuHtLwZsBxwOXHKk3hbAGIrqKJYpITWd7smz3
	6KSIhpm0MKCDO/o7AbuNHpz/reet6Yw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.12-rc2
Message-ID: <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Several more filesystems repaired, thank you to the users who have been
providing testing. The snapshots + unlinked fixes on top of this are
posted here:

https://lore.kernel.org/linux-bcachefs/20241005182955.1588763-1-kent.overstreet@linux.dev/T/#t

The following changes since commit 2007d28ec0095c6db0a24fd8bb8fe280c65446cd:

  bcachefs: rename version -> bversion for big endian builds (2024-09-29 23:55:52 -0400)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-10-05

for you to fetch changes up to 0f25eb4b60771f08fbcca878a8f7f88086d0c885:

  bcachefs: Rework logged op error handling (2024-10-04 20:25:32 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.12-rc2

A lot of little fixes, bigger ones include:

- bcachefs's __wait_on_freeing_inode() was broken in rc1 due to vfs
  changes, now fixed along with another lost wakeup
- fragmentation LRU fixes; fsck now repairs successfully (this is the
  data structure copygc uses); along with some nice simplification.
- Rework logged op error handling, so that if logged op replay errors
  (due to another filesystem error) we delete the logged op instead of
  going into an infinite loop)
- Various small filesystem connectivitity repair fixes

The final part of this patch series, fixing snapshots + unlinked file
handling, is now out on the list - I'm giving that part of the series
more time for user testing.

----------------------------------------------------------------
Kent Overstreet (18):
      bcachefs: Fix bad shift in bch2_read_flag_list()
      bcachefs: Fix return type of dirent_points_to_inode_nowarn()
      bcachefs: Fix bch2_inode_is_open() check
      bcachefs: Fix trans_commit disk accounting revert
      bcachefs: Add missing wakeup to bch2_inode_hash_remove()
      bcachefs: Fix reattach_inode()
      bcachefs: Create lost+found in correct snapshot
      bcachefs: bkey errors are only AUTOFIX during read
      bcachefs: Make sure we print error that causes fsck to bail out
      bcachefs: Mark more errors AUTOFIX
      bcachefs: minor lru fsck fixes
      bcachefs: Kill alloc_v4.fragmentation_lru
      bcachefs: Check for directories with no backpointers
      bcachefs: Check for unlinked inodes with dirents
      bcachefs: Check for unlinked, non-empty dirs in check_inode()
      bcachefs: Kill snapshot arg to fsck_write_inode()
      bcachefs: Add warn param to subvol_get_snapshot, peek_inode
      bcachefs: Rework logged op error handling

 fs/bcachefs/alloc_background.c        |  30 ++++--
 fs/bcachefs/alloc_background_format.h |   2 +-
 fs/bcachefs/btree_gc.c                |   3 -
 fs/bcachefs/btree_trans_commit.c      |   3 +-
 fs/bcachefs/error.c                   |  23 +++-
 fs/bcachefs/error.h                   |   9 +-
 fs/bcachefs/fs.c                      |  33 +++---
 fs/bcachefs/fsck.c                    | 194 ++++++++++++++++++++++------------
 fs/bcachefs/inode.c                   |  44 +++-----
 fs/bcachefs/inode.h                   |  28 +++--
 fs/bcachefs/io_misc.c                 |  63 +++++++----
 fs/bcachefs/logged_ops.c              |  16 +--
 fs/bcachefs/logged_ops.h              |   2 +-
 fs/bcachefs/lru.c                     |  34 +++---
 fs/bcachefs/move.c                    |   2 +-
 fs/bcachefs/movinggc.c                |  12 ++-
 fs/bcachefs/sb-errors_format.h        |  33 +++---
 fs/bcachefs/subvolume.c               |  16 ++-
 fs/bcachefs/subvolume.h               |   2 +
 fs/bcachefs/util.c                    |   2 +-
 20 files changed, 342 insertions(+), 209 deletions(-)

