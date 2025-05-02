Return-Path: <linux-fsdevel+bounces-47882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03905AA6866
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 03:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB34498042C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 01:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1DE26AD9;
	Fri,  2 May 2025 01:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PT1uvR4E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7934F18E3F
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 May 2025 01:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746149639; cv=none; b=eLL6cvDHNKRW2Th5W9MU9YWTsPqYNLZ7RVvt7tkaFTpk44r1TjmQd+wpcaVEX0SzHWdfyWSLsAi2MGr/XB6sYhvSiG8H29AuP3IhJHe9RxWaLrIKU+N7UaDHbg4NDnp4Iypgg/bX8GD0G3/AtCFf6ihR6uI0r4Pa5Qw7ckWz8DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746149639; c=relaxed/simple;
	bh=VFjD3rX9Q7nIanEsWLWsYCBzpSANUb1jB6SFhJ8JD70=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qSENbKg3VLBgAVfYwJH/pr0dWmpBnmQIBTT/9ucTsuvWcUa2rw4n0I6/LTTBL6/m6zkyqy8aN+bq/yGtGed4sh088BBEhsgV1SPMTkk+t4/GIqLJcvQ26gYgWrY/PIqvi9y49xsLIWf3RpKb29JWYKA9OmVKaBWt55C02VjZC1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PT1uvR4E; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 1 May 2025 21:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746149631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=KC+mXqTnHbJi8iH4wCBFRFB5qghJEho5DX6blQUzrxc=;
	b=PT1uvR4EjRmouoTxItV+lh4PXW7hPBZjZcwBY/IkdPOJnyAeDnfTLi7PJZVvrjAs+8EORo
	cvzdImNSjJM3BIWeiCauNanWtkElANOXjjG0rovOCZ2m0gUaqXCiePt7k+oGXizms+DYEb
	v1w26vGW4EWIlsz2FrH9D/lVp/jbhhU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for rc5
Message-ID: <avyfprbtjpphuhxjqekretgco6xs5r23efrlpkqx6uc5lhec7v@igrgjqacgb7i>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Every week I keep telling myself "boy, that was a busy week of
bugfixing, but next week is sure to finally slow down a bit".

Hah.

But it's all pretty small and boring.

A note on repair to users:
--------------------------

We're continuing to steadily improve on self healing/automatic repair;
we want to automatically repair and mount no matter what filesystem
damage has occurred (and I've been seeing some fun ones, we had one this
week that was from pcie power savings mode gone haywire).

But we aren't doing this all at once, because repair code is among the
most fiddly and least well tested: we're steadily adding error paths to
the whitelist for automatic repair as they come up.

So if you ever run into something where a manual fsck is required, do
drop me a note and include the output of 'bcachefs show-super -f errors'
- that'll tell me what to add to the whitelist.

The following changes since commit b4432656b36e5cc1d50a1f2dc15357543add530e:

  Linux 6.15-rc4 (2025-04-27 15:19:23 -0700)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-05-01

for you to fetch changes up to 6846100b00d97d3d6f05766ae86a0d821d849e78:

  bcachefs: Remove incorrect __counted_by annotation (2025-05-01 16:38:58 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.15-rc5

Lots of assorted small fixes...

- Some repair path fixes, a fix for -ENOMEM when reconstructing lots of
  alloc info on large filesystems, upgrade for ancient 0.14 filesystems,
  etc.

- Various assert tweaks; assert -> ERO, ERO -> log the error in the
  superblock and continue

- casefolding now uses d_ops like on other casefolding filesystems

- fix device label create on device add, fix bucket array resize on
  filesystem resize

- fix xattrs with FORTIFY_SOURCE builds with gcc-15/clang

----------------------------------------------------------------
Alan Huang (1):
      bcachefs: Remove incorrect __counted_by annotation

Kent Overstreet (21):
      bcachefs: Fix losing return code in next_fiemap_extent()
      bcachefs: Use generic_set_sb_d_ops for standard casefolding d_ops
      bcachefs: Emit unicode version message on startup
      bcachefs: Add missing utf8_unload()
      bcachefs: Run BCH_RECOVERY_PASS_reconstruct_snapshots on missing subvol -> snapshot
      bcachefs: Add upgrade table entry from 0.14
      bcachefs: fix bch2_dev_buckets_resize()
      bcachefs: Improve bch2_dev_bucket_missing()
      bcachefs: Don't generate alloc updates to invalid buckets
      bcachefs: btree_node_data_missing is now autofix
      bcachefs: btree_root_unreadable_and_scan_found_nothing autofix for non data btrees
      bcachefs: More informative error message when shutting down due to error
      bcachefs: Use bch2_kvmalloc() for journal keys array
      bcachefs: Topology error after insert is now an ERO
      bcachefs: improve missing journal write device error message
      bcachefs: readdir fixes
      bcachefs: Kill ERO in __bch2_i_sectors_acct()
      bcachefs: check for inode.bi_sectors underflow
      bcachefs: Kill ERO for i_blocks check in truncate
      bcachefs: Fix __bch2_dev_group_set()
      bcachefs: add missing sched_annotate_sleep()

 fs/bcachefs/btree_gc.c              | 27 ++++++++++++++++++--
 fs/bcachefs/btree_journal_iter.c    |  2 +-
 fs/bcachefs/btree_update_interior.c | 49 ++++++++++++++++++++++++-------------
 fs/bcachefs/buckets.c               | 15 ++++++++----
 fs/bcachefs/dirent.c                |  4 +--
 fs/bcachefs/disk_groups.c           | 25 +++++++++----------
 fs/bcachefs/ec.c                    |  4 +--
 fs/bcachefs/error.c                 |  4 ++-
 fs/bcachefs/fs-io.c                 | 44 ++++++++++++++++++++++++++-------
 fs/bcachefs/fs.c                    | 15 ++++++++----
 fs/bcachefs/io_write.c              | 21 ++++++++++++++++
 fs/bcachefs/journal_io.c            |  2 +-
 fs/bcachefs/namei.c                 |  3 +++
 fs/bcachefs/sb-downgrade.c          |  4 +++
 fs/bcachefs/sb-errors_format.h      | 13 +++++++---
 fs/bcachefs/sb-members.c            |  6 +++--
 fs/bcachefs/sb-members.h            | 13 ++++++----
 fs/bcachefs/subvolume.c             |  5 ++--
 fs/bcachefs/super.c                 | 46 ++++++++++++++++++++--------------
 fs/bcachefs/xattr_format.h          |  8 +++++-
 20 files changed, 219 insertions(+), 91 deletions(-)

