Return-Path: <linux-fsdevel+bounces-41837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1E1A38064
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 11:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E258C3A64FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 10:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD929217736;
	Mon, 17 Feb 2025 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H98LNVqq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC7623CE;
	Mon, 17 Feb 2025 10:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788651; cv=none; b=Hm724bZknxcxdUGxrSCymnAk3qDK7b6wOGBhNJHwCVOLDLBKTxgDqYzGI+1ZhOycgOwD1bykIVwQHqVB/WB9VeOikMdRDuAOX9BiBtgAUsuF8Ax7bQTVi8CRQ/BCp8uDkPzr3KeAVUwbyMdHS6wrV3XMuPzKUqYOkm4I2T/LlxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788651; c=relaxed/simple;
	bh=f6Z0nliZuktumIn0eNWMEeg5gDD5fHD5zp7a4S5tFMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PfRmFXEYHg2+Y58SRlT1OKGT5VFCWNL7uFKmbUX6J0Oxa7on0ExQs1pDnsLBvsxZIDAjbgSp38uWZqxZDR5tBLP8i8qjT97O66591j5YU5qZn7wHn+HEBmcC/sfGm+FgAZKRcpzZ3a1zr5jayj/hWQhSCrB4hgiXrlRCZaMEKqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H98LNVqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A74DC4CED1;
	Mon, 17 Feb 2025 10:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739788650;
	bh=f6Z0nliZuktumIn0eNWMEeg5gDD5fHD5zp7a4S5tFMo=;
	h=From:To:Cc:Subject:Date:From;
	b=H98LNVqqFfJAslWTcYIFxqUFYqOLy3LJ9b8s1gX63kWCQjGM9cNu1R7BdLmwbSTHQ
	 L0ujRxg3PUxbdNIpiGzgv2tOQEbcH4a7wwCCorKlDmTEw7nrwLPIaZT5tV+KsResQI
	 v2oaG65Wv/2anhSTl5X+4V3NavXcrgE9ES8QZ4pcryswhA6RupeueHUSOZhn7iUk7D
	 FAkLrHbbzBKhJs3jg5+EWD8K4i0QgjT5sSTB0B5nDo6zz2fSV+CqqdrEsjJR3lJxPm
	 7s2c9jqt/gHulthpMm1IGA1DZQr7RE5LJlHqmFVO8NID9yIkSCT77daRSJ22irTgbZ
	 J52nzNIgytipA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Mon, 17 Feb 2025 11:37:00 +0100
Message-ID: <20250217-vfs-fixes-f47d095c551e@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3592; i=brauner@kernel.org; h=from:subject:message-id; bh=f6Z0nliZuktumIn0eNWMEeg5gDD5fHD5zp7a4S5tFMo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRvFkzy/f3w/zJmEQ6DlsWPXW8kPBRluKvlzb5xx8Slw n1RS/eUdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExENpSR4dG2rTvTP4seeP5F VCzz4eE1vs25ncfeXw1zLPOROD5p6TVGhjvLn20+kJF6X+gN1wMN51VnVhTV/Go+cnJbicKffXP 6z7ECAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains various fixes for this cycle:

- It was reported that the acct(2) system call can be used to trigger a
  NULL deref in cases where it is set to write to a file that triggers
  an internal lookup.

  This can e.g., happen when pointing acct(2) to /sys/power/resume. At
  the point the where the write to this file happens the calling task
  has already exited and called exit_fs() but an internal lookup might
  be triggered through lookup_bdev(). This may trigger a NULL-deref when
  accessing current->fs.

  Reorganize the code so that the the final write happens from the
  workqueue but with the caller's credentials. This preserves the
  (strange) permission model and has almost no regression risk.

  Also block access to kernel internal filesystems as well as procfs and
  sysfs in the first place.

- Various fixes for netfslib:

  - Fix a number of read-retry hangs, including:

    - Incorrect getting/putting of references on subreqs as we
      retry them.

    - Failure to track whether a last old subrequest in a retried
      set is superfluous.

    - Inconsistency in the usage of wait queues used for subrequests
      (ie. using clear_and_wake_up_bit() whilst waiting on a private
      waitqueue).

  - Add stats counters for retries and publish in /proc/fs/netfs/stats.
    This is not a fix per se, but is useful in debugging and shouldn't
    otherwise change the operation of the code.

  - Fix the ordering of queuing subrequests with respect to setting the
    request flag that says we've now queued them all.

/* Testing */

gcc version (Debian 14.2.0-8) 14.2.0
Debian clang version 19.1.4 (1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc4.fixes

for you to fetch changes up to a33f72554adf4552e53af3784cebfc4f2886c396:

  Merge patch series "netfs: Miscellaneous fixes" (2025-02-13 16:00:53 +0100)

Please consider pulling these changes from the signed vfs-6.14-rc4.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.14-rc4.fixes

----------------------------------------------------------------
Christian Brauner (4):
      acct: perform last write from workqueue
      acct: block access to kernel internal filesystems
      Merge patch series "acct: don't allow access to internal filesystems"
      Merge patch series "netfs: Miscellaneous fixes"

David Howells (3):
      netfs: Fix a number of read-retry hangs
      netfs: Add retry stat counters
      netfs: Fix setting NETFS_RREQ_ALL_QUEUED to be after all subreqs queued

 fs/netfs/buffered_read.c     |  19 ++++--
 fs/netfs/internal.h          |   4 ++
 fs/netfs/read_collect.c      |   6 +-
 fs/netfs/read_retry.c        |  43 ++++++++++----
 fs/netfs/stats.c             |   9 +++
 fs/netfs/write_issue.c       |   1 +
 fs/netfs/write_retry.c       |   2 +
 include/linux/netfs.h        |   2 +-
 include/trace/events/netfs.h |   4 +-
 kernel/acct.c                | 134 +++++++++++++++++++++++++++----------------
 10 files changed, 154 insertions(+), 70 deletions(-)

