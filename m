Return-Path: <linux-fsdevel+bounces-34725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064419C8192
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 04:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC112825FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 03:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF291E7C15;
	Thu, 14 Nov 2024 03:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YAPgBiTk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E016AAD
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 03:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731556347; cv=none; b=aAauKZTVPrjAEZjKChsMn2Py+EUjSVPgbR72k8W65NvYKhknpPuqB+lUbKxKnL2HAV3c/F9UF+D3MSs69lj+XpkZ7iL3xWIawqrnKFqJuLxeH17X9ZZSPBnWbjiwHtuoZrgVHsCsdLhcdohfSE0FWA8CA7cocTwMJW8tGaWmpsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731556347; c=relaxed/simple;
	bh=/S42EZqqN0W2UO4Bsk+y11k9ARPosuqRf0PctlLNXNU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PWakVT9zYUxyyqMRH3UPKDY+40aN936V9f+jD+uvnn6A3hUN7yp2vV1DVFvc+VcfBfIpdjsqvPcpjimLMKeFtZGO49Tbm1wqdoX5UaEyAmMwMEHXeSfFUXmYZ3GCGHri/2DoDBlG75DDsBdTT6DF5b2fvbWS4pHkZH1pNHW+EKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YAPgBiTk; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 13 Nov 2024 22:52:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731556338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ET4lcoEGwBhlJY/4rJSYc2MjLbqKun/Nl/7JWraGcvg=;
	b=YAPgBiTk20vENViW+T2NY/0DimIb1GTMlKlxgvUYiP8jwixK5dW6bBrql5apisrzh4XEW8
	F4UXfmDUdZOlzWktlYdA+QWdBbTVmAqbVKBYV0Ih7gH0kh85ut30DZ8V1VVk9taLIhiSBJ
	WxildPXeCuY8p7DHyjdKKNxjAs4W5DA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.12
Message-ID: <seaiutwvlv35bllqy55ajospsaiynelevpcmov7kax4txomo3c@uam4pyhzmzuu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

test dashboard is looking good, rebasing to rc6 fixed the crazy hangs we
were seeing on rc1...

(and they were crazy; processes were getting stuck on inode lock when
lockdep said nothing was holding it).

this fixes one minor regression from the btree cache fixes in the last
pull request (in the scan_for_btree_nodes repair path) - and the
shutdown path fix is the big one here, in terms of bugs closed.

so I would say things are slowing down here, except now that I've got an
easy way to run syzbot reproducers I'm noticing that we're losing a lot
of coverage because mainly we're mostly bailing out when we see
something corrupt. When self healing is flipped on for more stuff
there's probably going to be another flood of syzbot stuff...

The following changes since commit 8440da933127fc5330c3d1090cdd612fddbc40eb:

  bcachefs: Fix UAF in __promote_alloc() error path (2024-11-07 16:48:21 -0500)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-11-13

for you to fetch changes up to 840c2fbcc5cd33ba8fab180f09da0bb7f354ea71:

  bcachefs: Fix assertion pop in bch2_ptr_swab() (2024-11-12 03:46:57 -0500)

----------------------------------------------------------------
bcachefs fixes for 6.12

- Assorted tiny syzbot fixes
- Shutdown path fix: "bch2_btree_write_buffer_flush_going_ro()"

  The shutdown path wasn't flushing the btree write buffer, leading to
  shutting down while we still had operations in flight. This fixes a
  whole slew of syzbot bugs, and undoubtedly other strange heisenbugs.

----------------------------------------------------------------
Kent Overstreet (9):
      bcachefs: bch2_btree_write_buffer_flush_going_ro()
      bcachefs: Fix bch_member.btree_bitmap_shift validation
      bcachefs: Fix missing validation for bch_backpointer.level
      bcachefs: Fix validate_bset() repair path
      bcachefs: Fix hidden btree errors when reading roots
      bcachefs: Fix assertion pop in topology repair
      bcachefs: Allow for unknown key types in backpointers fsck
      bcachefs: Fix journal_entry_dev_usage_to_text() overrun
      bcachefs: Fix assertion pop in bch2_ptr_swab()

 fs/bcachefs/backpointers.c          | 17 ++++++++++++-----
 fs/bcachefs/btree_gc.c              |  2 +-
 fs/bcachefs/btree_io.c              |  6 +-----
 fs/bcachefs/btree_update_interior.c |  3 ++-
 fs/bcachefs/btree_write_buffer.c    | 30 +++++++++++++++++++++++++++---
 fs/bcachefs/btree_write_buffer.h    |  1 +
 fs/bcachefs/extents.c               |  5 ++++-
 fs/bcachefs/journal_io.c            |  3 +++
 fs/bcachefs/recovery_passes.c       |  6 ++++++
 fs/bcachefs/recovery_passes_types.h |  1 +
 fs/bcachefs/sb-errors_format.h      |  6 +++++-
 fs/bcachefs/sb-members.c            |  4 ++--
 fs/bcachefs/sb-members_format.h     |  6 ++++++
 fs/bcachefs/super.c                 |  1 +
 14 files changed, 72 insertions(+), 19 deletions(-)

