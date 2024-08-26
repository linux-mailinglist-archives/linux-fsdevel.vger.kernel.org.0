Return-Path: <linux-fsdevel+bounces-27190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9C195F4E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 17:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8289B21A86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 15:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6418192B93;
	Mon, 26 Aug 2024 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4lLWe3t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC561CD25;
	Mon, 26 Aug 2024 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724685929; cv=none; b=SBsF70KYQZ/2xu/TS5rF/uQ2QG6x3V7V6SGCvHgQNyTgGQtCMIkQP1kZu2Mcr4C7BWhYFHSOQ9KDVNkkqeoWXMF0FQPaV3xcSTJUX55IVbE7VjOstFTA7BMJz1LCMIuXOOYvr2vpJAFkN0gPhnso3zkRbLcT3cGHbTBpPO/JV6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724685929; c=relaxed/simple;
	bh=wPp+lpnf6Z7NpVDAMX08zwhLtbHujBYZzuDcdLCSyqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TuZZ40VI7jeBgKE1MjnlABdVaRtzu34xKKvstFKnwh5vRZTZMx7WALH5wbgREcbqP6I4EwRav5k3PuXJpXLABVL1WH94RODmKf8O/oXV94RD4/4Xz5SPvbMdfjntzby9BPJYX9sQA6P/iZkLBRKegSt3LgsmhiZ3g78QZp8rqRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4lLWe3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8180C52FC5;
	Mon, 26 Aug 2024 15:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724685928;
	bh=wPp+lpnf6Z7NpVDAMX08zwhLtbHujBYZzuDcdLCSyqo=;
	h=From:To:Cc:Subject:Date:From;
	b=h4lLWe3tw8iH9MLtcbDg+ta2KOzwk2XZO0mAcdXNi+sKjyRcpgt1CRuLy6rXJQA0/
	 3qESRK95Y35uiGFHPSIT4XP+yQUTq0c7odBjiMjtKYo7mj7QomnurMfr97Vw0YLoDJ
	 wzbCeYo8HVZ5pHU7TxI6LrGhfRD8ybKdumbOokKkWqYb8yS/JYVgE0+vLF9gNxmZ8G
	 /K9W1zX0xqoKkGW+LJCfNyOcaXPIvEnO3RScsnO3ypyUwg0kqb/oMjnhllmxwt8af9
	 dK5SXvKpLXz3O6FkxYJ3/cfnlXBkBuBftnyMutywLg1nKgi0A5Hx/XGPuR9GbstkNI
	 JbR+qJ6z+eAkA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Mon, 26 Aug 2024 17:25:04 +0200
Message-ID: <20240826-vfs-fixes-3028447211c8@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3818; i=brauner@kernel.org; h=from:subject:message-id; bh=wPp+lpnf6Z7NpVDAMX08zwhLtbHujBYZzuDcdLCSyqo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSdmRfJ6sb6dvF736N6RSv/z1W5lWumIHX5muDKtcr3e rd9slna1FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRHb6MDO/Zry+sFNdaZLA7 WbOxUdnNfIPj9cPRUQ6G4Szz9u/6eomRYd+Zt9vVeZY7Gd6MyP7CHWY8cfZKt2yWa2F5L1+wb15 /lREA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

/* Summary */
This contains fixes for this merge window:

VFS:

- Ensure that backing files uses file->f_ops->splice_write() for splice.

netfs:

- Revert the removal of PG_private_2 from netfs_release_folio() as cephfs still
  relies on this.

- When AS_RELEASE_ALWAYS is set on a mapping the folio needs to always be
  invalidated during truncation.

- Fix losing untruncated data in a folio by making letting
  netfs_release_folio() return false if the folio is dirty.

- Fix trimming of streaming-write folios in netfs_inval_folio() .

- Reset iterator before retrying a short read.

- Fix interaction of streaming writes with zero-point tracker

afs:

- During truncation afs currently calls truncate_setsize() which sets i_size,
  expands the pagecache and truncates it. The first two operations aren't
  needed because they will have already been done. So call truncate_pagecache()
  instead and skip the redundant parts.

overlayfs:

- Fix checking of the number of allowed lower layers so 500 layers can actually
  be used instead of just 499

- Add missing '\n' to pr_err() output.

- Pass string to ovl_parse_layer() and thus allow it to be used for
  Opt_lowerdir as well.

pidfd:

- Revert blocking the creation of pidfds for kthread as apparently userspace
  relies on this. Specifically, it breaks systemd during shutdown.

romfs:

- Fix romfs_read_folio() to use the correct offset with folio_zero_tail().

/* Testing */
Debian clang version 16.0.6 (27+b1)
gcc (Debian 14.2.0-1) 14.2.0

/* Conflicts */
No known conflicts.

The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208399:

  Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11-rc6.fixes

for you to fetch changes up to e00e99ba6c6b8e5239e75cd6684a6827d93c39a2:

  netfs: Fix interaction of streaming writes with zero-point tracker (2024-08-24 16:09:17 +0200)

Please consider pulling these changes from the signed vfs-6.11-rc6.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.11-rc6.fixes

----------------------------------------------------------------
Christian Brauner (4):
      romfs: fix romfs_read_folio()
      Revert "pidfd: prevent creation of pidfds for kthreads"
      ovl: pass string to ovl_parse_layer()
      Merge patch series "ovl: simplify ovl_parse_param_lowerdir()"

David Howells (7):
      netfs, ceph: Partially revert "netfs: Replace PG_fscache by setting folio->private and marking dirty"
      mm: Fix missing folio invalidation calls during truncation
      afs: Fix post-setattr file edit to do truncation correctly
      netfs: Fix netfs_release_folio() to say no if folio dirty
      netfs: Fix trimming of streaming-write folios in netfs_inval_folio()
      netfs: Fix missing iterator reset on retry of short read
      netfs: Fix interaction of streaming writes with zero-point tracker

Ed Tsai (1):
      backing-file: convert to using fops->splice_write

Zhihao Cheng (2):
      ovl: fix wrong lowerdir number check for parameter Opt_lowerdir
      ovl: ovl_parse_param_lowerdir: Add missed '\n' for pr_err

 fs/afs/inode.c           | 11 ++++++---
 fs/backing-file.c        |  5 +++-
 fs/ceph/inode.c          |  1 +
 fs/netfs/io.c            |  1 +
 fs/netfs/misc.c          | 60 ++++++++++++++++++++++++++++++++++++------------
 fs/netfs/write_collect.c |  7 ++++++
 fs/overlayfs/params.c    | 51 ++++++++++------------------------------
 fs/romfs/super.c         |  2 +-
 kernel/fork.c            | 25 +++-----------------
 mm/truncate.c            |  4 ++--
 10 files changed, 84 insertions(+), 83 deletions(-)

