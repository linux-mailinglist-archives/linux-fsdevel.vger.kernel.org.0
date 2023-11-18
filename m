Return-Path: <linux-fsdevel+bounces-3115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5891F7EFE82
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Nov 2023 09:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C0A7B20AA6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Nov 2023 08:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219FB107AF;
	Sat, 18 Nov 2023 08:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQO4XFah"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5474810787
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Nov 2023 08:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43996C433C7;
	Sat, 18 Nov 2023 08:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700295765;
	bh=TZPMn/MAA1ndauppHbEL1Zh6Gr/+Tvjm2NLYGYsMOcc=;
	h=From:To:Cc:Subject:Date:From;
	b=IQO4XFahKU/LZS6DKdGxC7jiNEJTjl4sM7w+UiQB4YEGs5iuwTUt+ErStom6ffsMc
	 ZE1Nh/oZT6mzqlPo+iPnaFd1tIlvRpbbWEKfCzxD08K9UOTdLem81YIT4sYWD95Lf/
	 jcdw5WnMF9Jsx/wHkufXabYIxYtJGeB0S5RB3u4d55LvgFI5ei86w/AWQaxPmBH06d
	 hLmRSfAvLfLE9Ybnh8LAG6fe2yGCsrN05qyrEtesASIv5Xi43LaPEJwWkDZUMZCuES
	 lsWBOMP0wgUoTJBeVdZ4X+JxV/YROYGNb9svXGXDnBVGMZO3y4u2AhoAHC+Rwd/dp8
	 H6TPEKK7Gmijg==
User-agent: mu4e 1.8.10; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: torvalds@linux-foundation.org
Cc: ailiop@suse.com,chandanbabu@kernel.org,dchinner@redhat.com,djwong@kernel.org,hch@lst.de,holger@applied-asynchrony.com,leah.rumancik@gmail.com,leo.lilong@huawei.com,linux-xfs@vger.kernel.org,linux-fsdevel@vger.kernel.org,osandov@fb.com,willy@infradead.org
Subject: [GIT PULL] xfs: bug fixes for 6.7
Date: Sat, 18 Nov 2023 13:46:27 +0530
Message-ID: <87zfzb31yl.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Linus,

Please pull this branch with changes for xfs for 6.7-rc2. The changes are
limited to only bug fixes whose summary is provided below.

I did a test-merge with the main upstream branch as of a few minutes ago and
didn't see any conflicts.  Please let me know if you encounter any problems.

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.7-fixes-1

for you to fetch changes up to 7930d9e103700cde15833638855b750715c12091:

  xfs: recovery should not clear di_flushiter unconditionally (2023-11-13 09:11:41 +0530)

----------------------------------------------------------------
Bug fixes for 6.7-rc2:

 * Fix deadlock arising due to intent items in AIL not being cleared when log
   recovery fails.
 * Fix stale data exposure bug when remapping COW fork extents to data fork.
 * Fix deadlock when data device flush fails.
 * Fix AGFL minimum size calculation.
 * Select DEBUG_FS instead of XFS_DEBUG when XFS_ONLINE_SCRUB_STATS is
   selected.
 * Fix corruption of log inode's extent count field when NREXT64 feature is
 enabled.

Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>

----------------------------------------------------------------
Anthony Iliopoulos (1):
      xfs: fix again select in kconfig XFS_ONLINE_SCRUB_STATS

Christoph Hellwig (1):
      xfs: only remap the written blocks in xfs_reflink_end_cow_extent

Dave Chinner (2):
      xfs: inode recovery does not validate the recovered inode
      xfs: recovery should not clear di_flushiter unconditionally

Leah Rumancik (1):
      xfs: up(ic_sema) if flushing data device fails

Long Li (2):
      xfs: factor out xfs_defer_pending_abort
      xfs: abort intent items when recovery intents fail

Matthew Wilcox (Oracle) (1):
      XFS: Update MAINTAINERS to catch all XFS documentation

Omar Sandoval (1):
      xfs: fix internal error from AGFL exhaustion

 MAINTAINERS                     |  3 +--
 fs/xfs/Kconfig                  |  2 +-
 fs/xfs/libxfs/xfs_alloc.c       | 27 +++++++++++++++++++++---
 fs/xfs/libxfs/xfs_defer.c       | 28 ++++++++++++++++---------
 fs/xfs/libxfs/xfs_defer.h       |  2 +-
 fs/xfs/libxfs/xfs_inode_buf.c   |  3 +++
 fs/xfs/xfs_inode_item_recover.c | 46 +++++++++++++++++++++++++++--------------
 fs/xfs/xfs_log.c                | 23 +++++++++++----------
 fs/xfs/xfs_log_recover.c        |  2 +-
 fs/xfs/xfs_reflink.c            |  1 +
 10 files changed, 92 insertions(+), 45 deletions(-)

