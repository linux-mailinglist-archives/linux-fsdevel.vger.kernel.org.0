Return-Path: <linux-fsdevel+bounces-44775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1D5A6C91B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 11:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774C6188DB13
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 10:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FAA1F8AC8;
	Sat, 22 Mar 2025 10:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTeIZMNX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC561FAC4D;
	Sat, 22 Mar 2025 10:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638577; cv=none; b=J9r+/5k2Kn4uV3YN3i8+zO5X4Gpq29DWeaPVV7z3+rbTXkLzanUF+bHTl/JDwR0oEL8NGlizEgxmx4K8s9BQQ4poRBqwPkEGIhWHafIwLV0nK5+SJjRNv/zcawspxEh3CTL5QzuNlWYfSuUOE4iNos+/HqRXrNgeAQnmf0jBn8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638577; c=relaxed/simple;
	bh=7E8KrKyWXwjRY1rdu3XON1N4bmhvoFKS2xSfZlDp1cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FQmuSMtw5HoI8VO8pM2qDF9vNLd1/6Zc4/KJOwmuyCWi1Y2mJhOGFvtuQYE047MLtXWWjCrAjUf+lxVfvSaWNIalUSwiZTCrS15a8E89VAmbUbyDQxY2KtGWi3aIvUbaq/kEQ3+pZZjost51A80QqDI+1vKIiBAS0O9KTwUVeXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTeIZMNX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0811C4CEED;
	Sat, 22 Mar 2025 10:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742638575;
	bh=7E8KrKyWXwjRY1rdu3XON1N4bmhvoFKS2xSfZlDp1cQ=;
	h=From:To:Cc:Subject:Date:From;
	b=gTeIZMNXPo4YvbLZn6LjFsGv1pr2d7dUdXO1CiiWDPx+qMzTTyq2QikK+sIz3brJm
	 8cosq1gPfcsYqWm2BDuvpxyJjeIqBT15kl5W6qAgwjUSZ/KCm6cs4bAiXiU0THChPE
	 XhjTUVFjrhqeskA5xfZkY+37FIZ/kIfsL2Pliq+vLYvJZnBm9/kL3O5U4+rWDxwv37
	 zeoDTVVsjNpS7w529T2KMSgWW+BLyedg+fy5fWEzSGYWl3f/IHywoisQsRDDwz3m3P
	 WDvvRG9ay5UWUye3+2DMgQPfUcx4WpUGcIMdQyqHalNG5srsTYo8yFnhfLG11n8Iu/
	 KEE4H2VK/eTaw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs pagesize
Date: Sat, 22 Mar 2025 11:16:07 +0100
Message-ID: <20250322-vfs-pagesize-6972cdf9bda9@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2586; i=brauner@kernel.org; h=from:subject:message-id; bh=7E8KrKyWXwjRY1rdu3XON1N4bmhvoFKS2xSfZlDp1cQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTf631h7OzrqBqeZjrFoi1g3cFn8z13n97jse7/l5KFG 7/nr79R1FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRjTsY/od8YPSYXvg5ecaL 22Ucgv4Bi97ITXj8ZZp/CsP/zSrccfyMDCfuXDJSk/w75WO55XL/6xN8mA8WCR9eYTXrvaH3Si8 HT34A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This enables block sizes greater than the page size for block devices.
With this we can start supporting block devices with logical block sizes
larger than 4k. It also allows to lift the device cache sector size
support to 64k. This allows filesystems which can use larger sector
sizes up to 64k to ensure that the filesystem will not generate writes
that are smaller than the specified sector size.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.pagesize

for you to fetch changes up to a64e5a596067bddba87fcc2ce37e56c3fca831b7:

  bdev: add back PAGE_SIZE block size validation for sb_set_blocksize() (2025-03-07 12:56:05 +0100)

Please consider pulling these changes from the signed vfs-6.15-rc1.pagesize tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.15-rc1.pagesize

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "enable bs > ps for block devices"

Hannes Reinecke (2):
      fs/mpage: avoid negative shift for large blocksize
      block/bdev: enable large folio support for large logical block sizes

Luis Chamberlain (6):
      fs/buffer: simplify block_read_full_folio() with bh_offset()
      fs/mpage: use blocks_per_folio instead of blocks_per_page
      fs/buffer fs/mpage: remove large folio restriction
      block/bdev: lift block size restrictions to 64k
      bdev: use bdev_io_min() for statx block size
      bdev: add back PAGE_SIZE block size validation for sb_set_blocksize()

Matthew Wilcox (1):
      fs/buffer: remove batching from async read

 block/bdev.c           | 13 ++++++-----
 fs/bcachefs/fs.c       |  2 +-
 fs/buffer.c            | 58 ++++++++++++++++++++------------------------------
 fs/mpage.c             | 49 ++++++++++++++++++++----------------------
 fs/xfs/xfs_super.c     |  3 ++-
 include/linux/blkdev.h |  8 ++++++-
 include/linux/fs.h     |  1 +
 7 files changed, 65 insertions(+), 69 deletions(-)

