Return-Path: <linux-fsdevel+bounces-41148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23490A2B8F2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 03:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB1E167835
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 02:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D129A17B502;
	Fri,  7 Feb 2025 02:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="paAZRdml"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8C81494DD
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 02:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738894846; cv=none; b=eEk//5NQ0CfkCVEMj1NtRxZiV7m2GMQI/jDt52S2R2RBVVhtWqA26OCsPkvy9pv6B+YUyGaQ3+Z5mtWgUvTK7rJEprvwGBtIE1iPd+MpDnj5Br5Q2fUEpsrXBOlcU5gQT++EiPSgpnk9Bi32e3ePjt6e0YPWAGxWYejBiMqT2iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738894846; c=relaxed/simple;
	bh=/qjNMy3fr7XuhlxXcW8LsjCb5CUjcoySJdmCymTEiM0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KBHnpOuEfrdzUEFlE3sTlEo0JefEKzv81khefJE+3U1ex79DnmXjo9JI90hSa1eUbBMFZ+LME+2QEmB5HcPI7vhM5czoIRXyOdRzUtAuo7dlSZCdRvJfaNTONdZaE5T3EllwgzmkAK6RuMI5sNqcSiN4yu7N2I1qdO2JkFP6zdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=paAZRdml; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 6 Feb 2025 21:20:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738894827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=fYzg4hGuEqL0tGkP/p0EcOQZjOlU4CNbCwCV0BxXbeg=;
	b=paAZRdml1C+HBnVTIMd9UWRr1mO8Vm+8iEuQSKWPQV7BHwZAK7hfpuvoP2YDhBwYsru4zx
	zVdNzWzw7zPF0rnvrpmz+Ej7FId3MBWlN070fZ81zQGoNlt/ghSnkO4vPqNXRPGqds+wlp
	hEOihYb9MOqG5NooIyBhoX4gwXzpyf0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.14-rc2
Message-ID: <z2eszznjel6knkkvckjxvkp5feo5jhnwvls3rtk7mbt47znvcr@kvo6dhimlghe>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Nothing major, things continue to be fairly quiet over here.

Tracking some bugs that show up on nix build servers; would like someone
to confirm or deny that these are or are not still happening on 6.14,
and if you've got an environment where this is reproducing and can work
with me to debug that would save me some trouble...

Also, another bug report is implicating hibernate, please let me know if
you have any data on that, still trying to piece together what's going
on there.

And as usual, be noisy if you're seeing a serious bug that's not getting
resolved.

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-02-06

for you to fetch changes up to 44a7bfed6f352b4bae4fd244d0fcd32aa25d0deb:

  bcachefs: bch2_bkey_sectors_need_rebalance() now only depends on bch_extent_rebalance (2025-02-05 19:56:24 -0500)

----------------------------------------------------------------
bcachefs fixes for 6.14-rc2

- add a SubmittingPatches to clarify that patches submitted for bcachefs
  do, in fact, need to be tested
- discard path now correctly issues journal flushes when needed, this
  fixes performance issues when the filesystem is nearly full and we're
  bottlenecked on copygc
- fix a bug that could cause the pending rebalance work accounting to be
  off when devices are being onlined/offlined; users should report if
  they are still seeing this
- and a few more trivial ones

----------------------------------------------------------------
Jeongjun Park (2):
      bcachefs: fix incorrect pointer check in __bch2_subvolume_delete()
      bcachefs: fix deadlock in journal_entry_open()

Kent Overstreet (4):
      bcachefs docs: SubmittingPatches.rst
      bcachefs: Fix discard path journal flushing
      bcachefs: Fix rcu imbalance in bch2_fs_btree_key_cache_exit()
      bcachefs: bch2_bkey_sectors_need_rebalance() now only depends on bch_extent_rebalance

 .../filesystems/bcachefs/SubmittingPatches.rst     | 98 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 fs/bcachefs/alloc_background.c                     | 47 ++++++-----
 fs/bcachefs/alloc_foreground.c                     | 10 ++-
 fs/bcachefs/alloc_types.h                          |  1 +
 fs/bcachefs/btree_key_cache.c                      |  1 -
 fs/bcachefs/buckets_waiting_for_journal.c          | 12 ++-
 fs/bcachefs/buckets_waiting_for_journal.h          |  4 +-
 fs/bcachefs/inode.h                                |  4 +-
 fs/bcachefs/journal.c                              | 18 +++-
 fs/bcachefs/journal.h                              |  1 +
 fs/bcachefs/journal_types.h                        |  1 +
 fs/bcachefs/opts.h                                 | 14 ----
 fs/bcachefs/rebalance.c                            |  8 +-
 fs/bcachefs/rebalance.h                            | 20 +++++
 fs/bcachefs/subvolume.c                            |  7 +-
 fs/bcachefs/super.c                                | 11 +++
 fs/bcachefs/super.h                                |  1 +
 fs/bcachefs/trace.h                                | 14 +++-
 19 files changed, 214 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/filesystems/bcachefs/SubmittingPatches.rst

