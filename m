Return-Path: <linux-fsdevel+bounces-6541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF94181972D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 04:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F23901C255A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 03:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147C910A1E;
	Wed, 20 Dec 2023 03:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n1rJJQ7k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7812FBE0
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 03:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 19 Dec 2023 22:30:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703043059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=5Tf3bbmEYMwA+02doK4ycgX594KTKbQv3kVFPgTRuKY=;
	b=n1rJJQ7kTSdFDqEK/GIxQvIiMJRy8mGSqcQhFBKMDu/DZ0qtOLlh389mMU/MqGv/RnvXv0
	ih3DCnYtL6BPIqo2hNNPir1hZi30k+ru3GKy38vFQ+ABQ1xicdMjWEfeUNxTo3t5oY05dQ
	S23/jSSLun9AlGZBNpJcHzKzbCV68Cg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] more bcachefs fixes for 6.7
Message-ID: <20231220033056.hvoespiy4vcbpl32@moria.home.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus, few more fixes for you - nothing big, but several important
ones in here.

Cheers,


The following changes since commit a66ff26b0f31189e413a87065c25949c359e4bef:

  bcachefs: Close journal entry if necessary when flushing all pins (2023-12-10 16:53:46 -0500)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2023-12-19

for you to fetch changes up to 247ce5f1bb3ea90879e8552b8edf4885b9a9f849:

  bcachefs: Fix bch2_alloc_sectors_start_trans() error handling (2023-12-19 19:01:52 -0500)

----------------------------------------------------------------
More bcachefs bugfixes for 6.7:

 - Fix a deadlock in the data move path with nocow locks (vs. update in
   place writes); when trylock failed we were incorrectly waiting for in
   flight ios to flush.
 - Fix reporting of NFS file handle length
 - Fix early error path in bch2_fs_alloc() - list head wasn't being
   initialized early enough
 - Make sure correct (hardware accelerated) crc modules get loaded
 - Fix a rare overflow in the btree split path, when the packed bkey
   format grows and all the keys have no value (LRU btree).
 - Fix error handling in the sector allocator
   This was causing writes to spuriously fail in multidevice setups, and
   another bug meant that the errors weren't being logged, only reported
   via fsync.

----------------------------------------------------------------
Daniel Hill (1):
      bcachefs: improve modprobe support by providing softdeps

Jan Kara (1):
      bcachefs: Fix determining required file handle length

Kent Overstreet (5):
      bcachefs: Fix nocow locks deadlock
      bcachefs: print explicit recovery pass message only once
      bcachefs: btree_node_u64s_with_format() takes nr keys
      bcachefs; guard against overflow in btree node split
      bcachefs: Fix bch2_alloc_sectors_start_trans() error handling

Thomas Bertschinger (1):
      bcachefs: fix invalid memory access in bch2_fs_alloc() error path

 fs/bcachefs/alloc_foreground.c      | 14 ++++++++++---
 fs/bcachefs/btree_iter.c            |  8 ++++++--
 fs/bcachefs/btree_iter.h            |  1 +
 fs/bcachefs/btree_update_interior.c | 39 ++++++++++++++++++++++++-------------
 fs/bcachefs/btree_update_interior.h |  4 ----
 fs/bcachefs/data_update.c           |  3 ++-
 fs/bcachefs/fs.c                    | 19 +++++++++++++-----
 fs/bcachefs/recovery.h              |  3 +++
 fs/bcachefs/super.c                 |  7 +++++++
 9 files changed, 70 insertions(+), 28 deletions(-)

