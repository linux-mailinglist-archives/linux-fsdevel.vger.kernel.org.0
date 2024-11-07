Return-Path: <linux-fsdevel+bounces-33979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DB29C122F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 00:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0DBA1C2092D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 23:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1100E218D98;
	Thu,  7 Nov 2024 23:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bG9VjSm4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53961EC017
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 23:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731020540; cv=none; b=PSzB6lblbzdxn3luzE1XeygAYxzLxjapFf/XlaOodfeKeo/lEXUZezZy8COVLismhMD9D1I+rjAENDEVjcg8C7qlqkSVZmiZI/sbYu1CZHDlrUAkNebap3pfkeMYeGTF8uu7vvwEeTnJT5lLKz0xViS47LobVm+e/Lj8ZI7TdDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731020540; c=relaxed/simple;
	bh=Pohx9jBQc9jNwE7jCX6Bx+4kiZPDybWn3sHfTlV4aXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M7qS8AqNCJecHYaI7Y2TTU5XpNwMvHEGpVhs0ddL/yE/yrapczRx4IJeBMKpemyDx/Jvxm7ZaxDiojVYlk4TgniWCaMrSRoa6eChsq4CgUphhKuoG4ylXyJVOl/7nO+Ffl6FlltYrl68kT/TpJLv9+jaRV6XS5+HI8xVWZ4K9aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bG9VjSm4; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 7 Nov 2024 18:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731020534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=b/WGjHgYDEQmVHKDXmJbaSo/SGnqQ2mhgtYoFMZdbNs=;
	b=bG9VjSm47CkZd9VXTEUAaA2pAE2h2saw6DcgHmeOxf5/5+ZmFUG3lZrz3lcloBpbdNfjSN
	2WxJ8sGu3j/A2/5Lx5ma+9Oj6jQmbVcziMMu4xYtIylxsRDbSzSUFF1VPC9RdxYnogeiBT
	0Cth2d+EctD32mPYSkojBdKRP8xDNDc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.12-rc7
Message-ID: <voykwwyfpnpe54naeo67mbbltxodfqe5vzx7gk3rkwcj45e6vg@ak2ecjquamyn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus, about the usual batch of fixes...

- rebased to rc6 because upstream bugs were interfering with my CI
  results; also, there's still a bug in memory allocation profiling that
  Andrew hasn't sent you a fix for, which is keeping me from flipping on
  leak detection in all my tests

- bcachefs devs take note (and anyone dealing with syzbot): I now have a
  ktest test for building a kernel and running a syzbot reproducer in a
  single command, see
  https://evilpiepirate.org/git/ktest.git/commit/?id=3c30e501fb0d1413849cfc4f5832f8f5cff48585

The following changes since commit 59b723cd2adbac2a34fc8e12c74ae26ae45bf230:

  Linux 6.12-rc6 (2024-11-03 14:05:52 -1000)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-11-07

for you to fetch changes up to 8440da933127fc5330c3d1090cdd612fddbc40eb:

  bcachefs: Fix UAF in __promote_alloc() error path (2024-11-07 16:48:21 -0500)

----------------------------------------------------------------
bcachefs fixes for 6.12-rc7

Some trivial syzbot fixes, two more serious btree fixes found by looping
single_devices.ktest small_nodes:

- Topology error on split after merge, where we accidentaly picked the
  node being deleted for the pivot, resulting in an assertion pop

- New nodes being preallocated were left on the freedlist, unlocked,
  resulting in them sometimes being accidentally freed: this dated from
  pre-cycle detector, when we could leave them locked. This should have
  resulted in more explosions and fireworks, but turned out to be
  surprisingly hard to hit because the preallocated nodes were being
  used right away.

  the fix for this is bigger than we'd like - reworking btree list
  handling was a bit invasive - but we've now got more assertions and
  it's well tested.

- Also another mishandled transaction restart fix (in
  btree_node_prefetch) - we're almost done with those.

----------------------------------------------------------------
Hongbo Li (1):
      bcachefs: check the invalid parameter for perf test

Kent Overstreet (7):
      bcachefs: Fix null ptr deref in bucket_gen_get()
      bcachefs: Fix error handling in bch2_btree_node_prefetch()
      bcachefs: Ancient versions with bad bkey_formats are no longer supported
      bcachefs: Fix topology errors on split after merge
      bcachefs: Ensure BCH_FS_may_go_rw is set before exiting recovery
      bcachefs: btree_cache.freeable list fixes
      bcachefs: Fix UAF in __promote_alloc() error path

Pei Xiao (1):
      bcachefs: add check NULL return of bio_kmalloc in journal_read_bucket

Piotr Zalewski (1):
      bcachefs: Change OPT_STR max to be 1 less than the size of choices array

 fs/bcachefs/bkey.c                  |   7 +--
 fs/bcachefs/btree_cache.c           | 107 ++++++++++++++++++++++--------------
 fs/bcachefs/btree_cache.h           |   2 +
 fs/bcachefs/btree_node_scan.c       |   2 +-
 fs/bcachefs/btree_update_interior.c |  30 ++++++----
 fs/bcachefs/buckets.h               |  19 ++++---
 fs/bcachefs/errcode.h               |   1 +
 fs/bcachefs/io_read.c               |  10 ++--
 fs/bcachefs/io_write.c              |   7 +--
 fs/bcachefs/journal_io.c            |   2 +
 fs/bcachefs/opts.c                  |   4 +-
 fs/bcachefs/recovery.c              |   7 +++
 fs/bcachefs/recovery_passes.c       |   6 ++
 fs/bcachefs/tests.c                 |   5 ++
 14 files changed, 131 insertions(+), 78 deletions(-)

