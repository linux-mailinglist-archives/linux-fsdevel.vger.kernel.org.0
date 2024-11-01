Return-Path: <linux-fsdevel+bounces-33409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028A99B8A29
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 05:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAA0A2833AA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 04:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BC0146D65;
	Fri,  1 Nov 2024 04:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lsJ/B6Z7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDFC38FA3
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Nov 2024 04:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730434167; cv=none; b=WFMIuOWMNACtKCyClDXaBDw48d4s0DF4Cxl7AuORqKgTE1k5yyYsi0mOyoriNPpWiHfzySriMvT4saH8T9YUoHQ5hJETR+nG3hpcm6ap9ZiFwv0tY53jQSaUDPb66Bpnyj+vqzuAYeQRR6TSDb56LgzGHerEgADI0Z2JFHNS5eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730434167; c=relaxed/simple;
	bh=TdUIHuVi/9ph7I5q2Va3gRk4gff0Cl8EHEqDPA8RXEs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HKV/iNholOkSljQqfZX6JcoshvbpT8DbiVIpKfKOWvri8eUASHGtQ7+ihVfmwwBmn5sMfbCOMFY5LXBizSkEv7iqvKGAsdE1+79U+UUDn4umwPqqHKj5cLsnZl9ZmNnZ/hfOujJe8dpEVykcdFhG6K7DNfmXhC3emr/Aw4GLuy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lsJ/B6Z7; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 1 Nov 2024 00:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730434161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=uTmhfDD80R+n+JEPIjWtz3k33zC9n8sn4NYC1W9JVZ4=;
	b=lsJ/B6Z72gxaNRk9rJwl47qOMUvi4hUDwRqTJg84GE57peuG7fZlHHQUPVCretPX+VGDVB
	rpvuDTqEcVNbde+NvnH/dxb03cRGH2i7w40LVpG3VUEE1rSqtO38ghufhTSI5Y1YtI+kn/
	EdI5jw/c3XyUs9LxF+qsqpUYUm61ssw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.12-rc6
Message-ID: <crtbzb56yioclpibocd7whnjit43dub4hoeycxd5fzvzsnqnou@i22opfzxvitj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Nothing crazy to report...

Test dashboard failures are down 40% from a month ago, critical bug
reports have dropped off dramatically (there are a few still outstanding
I need to get to; apparently there's still a bug with online fsck and
open unlinked files), and we're starting to crank through the syzbot
stuff (also, syzbot seems to have made it past the dumb "whoops, we
forgot to validate that" and is turning up some genuinely interesting
ones).

Been hitting some bugs in compaction (confirmed by users running with it
flipped off), and lately I've been seeing some sporadic test hangs due
to what looks like a block layer writeback throttling bug, ouch.

The following changes since commit a069f014797fdef8757f3adebc1c16416271a599:

  bcachefs: Set bch_inode_unpacked.bi_snapshot in old inode path (2024-10-20 18:09:09 -0400)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-10-31

for you to fetch changes up to 3726a1970bd72419aa7a54f574635f855b98d67a:

  bcachefs: Fix NULL ptr dereference in btree_node_iter_and_journal_peek (2024-10-29 06:34:11 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.12-rc6

Various syzbot fixes, and the more notable ones:

- Fix for pointers in an extent overflowing the max (16) on a filesystem
  with many devices: we were creating too many cached copies when moving
  data around. Now, we only create at most one cached copy if there's a
  promote target set.

  Caching will be a bit broken for reflinked data until 6.13: I have
  larger series queued up which significantly improves the plumbing for
  data options down into the extent (bch_extent_rebalance) to fix this.

- Fix for deadlock on -ENOSPC on tiny filesystems

  Allocation from the partial open_bucket list wasn't correctly
  accounting partial open_buckets as free: this fixes the main cause of
  tests timing out in the automated tests.

----------------------------------------------------------------
Gaosheng Cui (1):
      bcachefs: fix possible null-ptr-deref in __bch2_ec_stripe_head_get()

Gianfranco Trad (1):
      bcachefs: Fix invalid shift in validate_sb_layout()

Jeongjun Park (2):
      bcachefs: fix shift oob in alloc_lru_idx_fragmentation
      bcachefs: fix null-ptr-deref in have_stripes()

Kent Overstreet (5):
      bcachefs: Fix UAF in bch2_reconstruct_alloc()
      bcachefs: Fix unhandled transaction restart in fallocate
      bcachefs: Don't keep tons of cached pointers around
      bcachefs: Don't filter partial list buckets in open_buckets_to_text()
      bcachefs: Fix deadlock on -ENOSPC w.r.t. partial open buckets

Piotr Zalewski (2):
      bcachefs: init freespace inited bits to 0 in bch2_fs_initialize
      bcachefs: Fix NULL ptr dereference in btree_node_iter_and_journal_peek

 fs/bcachefs/alloc_background.h |  3 ++
 fs/bcachefs/alloc_foreground.c | 19 ++++++++--
 fs/bcachefs/bcachefs.h         |  1 +
 fs/bcachefs/btree_iter.c       | 13 +++++++
 fs/bcachefs/data_update.c      | 21 ++++++-----
 fs/bcachefs/data_update.h      |  3 +-
 fs/bcachefs/ec.c               |  4 ++
 fs/bcachefs/errcode.h          |  2 +
 fs/bcachefs/extents.c          | 86 ++++++++++++++++++++++++++++++++++--------
 fs/bcachefs/extents.h          |  5 ++-
 fs/bcachefs/fs-io.c            | 17 +++++++--
 fs/bcachefs/move.c             |  2 +-
 fs/bcachefs/recovery.c         | 14 +++++--
 fs/bcachefs/sb-downgrade.c     |  3 ++
 fs/bcachefs/super-io.c         |  5 +++
 15 files changed, 160 insertions(+), 38 deletions(-)

