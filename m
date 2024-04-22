Return-Path: <linux-fsdevel+bounces-17435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C38668AD547
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 21:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A591F211FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 19:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D267C155748;
	Mon, 22 Apr 2024 19:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NsfrRM7n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CCD15535E
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Apr 2024 19:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815534; cv=none; b=Vz1z9RWrh+ZG9A3XLBJBa9pYdnw6oWt9HmCv8wxVrtp5FOtA7Ia/PuAMrhlJD5t67aPtYOJYYvSqR84PggflL62SWXCCCvbcmvhUISXoMfiIxrpbd9KuU8iyCtv+JJ6Tq9SecAs73ftX2Zsl+h5zsLymIxPKnGCaZbxbXF5xvRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815534; c=relaxed/simple;
	bh=EK1EZzGAtYGUjl2hyFST+YG4uALloruxlOHlWlLPKhM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NYDA5qG0kTAy/uFah7oru+MqMTXN3pUQIwBeXRn7oHfRH8eslpcUSyUmf1yCm7vJWYaUcveAZlFp1i654lY2OoWK/21z8VknuJy2gOg2jJWuzEbxV9OVhgoQqsGqgozv4VpCGpRj9yZHpb5EUt5Dx70WB5PuArCDvQfI7+lD91s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NsfrRM7n; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 22 Apr 2024 15:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713815530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=2GMQSjZim3LKV3Y1Miu61pAhsMImS7IiK2sA4UPpM/Y=;
	b=NsfrRM7nU9HcXCA9rhNE6cw8+Nm43qOk5NEEv9VJ6pcm7wkWDZjt6x+7OD39iaf8Y8NGLG
	lO1cosqkssc9MdPNzsuCxWmz/tMGMlCsHG/b6xrUoO2VD9+JmA1AM/EmUtL6psJxQjxmGV
	LdQUnp/p5S+G1SwReSTd8gIvncywGLI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes fro 6.9-rc6
Message-ID: <fwtvoxp2ktrhst5rm2yk4uk5atjuvnfpg7wjrozg2zd5p7tqzo@mca5izehz5fx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus, another batch of bcachefs fixes.

Nothing too crazy in this one, and it looks like (fingers crossed) the
recovery and repair issues are settling down - although there's going to
be a long tail there, as we've still yet to really ramp up on error
injection or syzbot.

For users - if anyone is seeing bugs that impact filesystem
availability, make sure you're reporting those and be noisy about it;
all the non critical stuff should be reported too, but are lower
priority for now.

Cheers,
Kent

The following changes since commit ad29cf999a9161e7849aa229d2028854f90728c2:

  bcachefs: set_btree_iter_dontneed also clears should_be_locked (2024-04-15 13:31:15 -0400)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-04-22

for you to fetch changes up to e858beeddfa3a400844c0e22d2118b3b52f1ea5e:

  bcachefs: If we run merges at a lower watermark, they must be nonblocking (2024-04-22 01:26:51 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.9-rc6

- fix a few more deadlocks in recovery
- fix u32/u64 issues in mi_btree_bitmap
- btree key cache shrinker now actually frees, with more instrumentation
  coming so we can verify that it's working correctly more easily in the
  future

----------------------------------------------------------------
Kent Overstreet (14):
      bcachefs: Fix null ptr deref in twf from BCH_IOCTL_FSCK_OFFLINE
      bcachefs: node scan: ignore multiple nodes with same seq if interior
      bcachefs: make sure to release last journal pin in replay
      bcachefs: Fix bch2_dev_btree_bitmap_marked_sectors() shift
      bcachefs: KEY_TYPE_error is allowed for reflink
      bcachefs: fix leak in bch2_gc_write_reflink_key
      bcachefs: Fix bio alloc in check_extent_checksum()
      bcachefs: Check for journal entries overruning end of sb clean section
      bcachefs: Fix missing call to bch2_fs_allocator_background_exit()
      bcachefs: bkey_cached.btree_trans_barrier_seq needs to be a ulong
      bcachefs: Tweak btree key cache shrinker so it actually frees
      bcachefs: Fix deadlock in journal write path
      bcachefs: Fix inode early destruction path
      bcachefs: If we run merges at a lower watermark, they must be nonblocking

Nathan Chancellor (1):
      bcachefs: Fix format specifier in validate_bset_keys()

 fs/bcachefs/backpointers.c          |  2 +-
 fs/bcachefs/bcachefs_format.h       |  3 +-
 fs/bcachefs/btree_gc.c              |  3 +-
 fs/bcachefs/btree_io.c              |  2 +-
 fs/bcachefs/btree_key_cache.c       | 19 +++---------
 fs/bcachefs/btree_node_scan.c       |  2 ++
 fs/bcachefs/btree_types.h           |  2 +-
 fs/bcachefs/btree_update_interior.c |  6 +++-
 fs/bcachefs/chardev.c               |  4 ++-
 fs/bcachefs/fs.c                    |  9 ++++--
 fs/bcachefs/journal_io.c            | 60 ++++++++++++++++++++++++++-----------
 fs/bcachefs/recovery.c              |  5 +++-
 fs/bcachefs/sb-clean.c              |  8 +++++
 fs/bcachefs/sb-errors_types.h       |  3 +-
 fs/bcachefs/sb-members.c            |  4 +--
 fs/bcachefs/sb-members.h            |  6 ++--
 fs/bcachefs/super.c                 |  1 +
 fs/bcachefs/thread_with_file.c      | 15 ++++++++--
 fs/bcachefs/thread_with_file.h      |  3 ++
 19 files changed, 105 insertions(+), 52 deletions(-)

