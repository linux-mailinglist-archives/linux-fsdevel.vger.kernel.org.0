Return-Path: <linux-fsdevel+bounces-62886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9B1BA41B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 16:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7308F1886FDE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 14:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428A32116E7;
	Fri, 26 Sep 2025 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/RsZczg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F1C1C700D;
	Fri, 26 Sep 2025 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896356; cv=none; b=Y6IY8aBDgNwhqJfe8ZhoLXkW0y2has8BWN9p5mtbMGA1Xftnf8NEd0Zhem+c4OzoCWyxVvFDZ3esylCI+GvkjEpF2hIfuAoS1bnXFk4I5GxQeVcyv0eAnFHOzMGWXVLc2zddKUuj2QgRxw6vvngNC8CaZvy130JMAaLAO0KL7Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896356; c=relaxed/simple;
	bh=8utFmDcG4z+8QeNM+4qBA8fQp61CzhsUL6K1IxxavOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSq+5bPSu/O2boXA/S76JCgpILvv8mJ3ZhOw7ipLV0U3egYLpdAZYDrQCTleN9SsKvcybVErSdb/heXEnS46SkKixNRxeBjN4g4hNqaEWegw73EqkjM3eiP6xywQoAsFqZ70dFKp7d2o9BlroZRrZS/UMbgqtv3dLH+qkkPkXUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/RsZczg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CAFC4CEF7;
	Fri, 26 Sep 2025 14:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758896354;
	bh=8utFmDcG4z+8QeNM+4qBA8fQp61CzhsUL6K1IxxavOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c/RsZczg6Mq7+ud0qwJPwOCPRXl7fe0lIEpO0bfub0yiqdf+lu84Ltuz8F5MqEbkL
	 ij07C3p+ZjZaUtM8uxEnxL0ufosqr96tDPiocNNp6sBTPARiEwmZ+zC/Z2kAv8FG2T
	 1iba9+2/3VZEtyrvMJNJoChkGUEwg6dskDRVyiunqNrMgPf5ea3S7w89VivaM/4IPg
	 VBAxsIR1kPvuWB0zcCKC+GbDE3nSGNeEyHHGA+dRPylBwzBmNHCCO56j5zD98SqAE/
	 APaDbHEeuk2qh5C6zO2kWDjGKSRYVXJoeDnUlF2XssRzSnbqXTlwLGLeXwgCZqTdom
	 FWQdHbTVVLXvg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 07/12 for v6.18] workqueue
Date: Fri, 26 Sep 2025 16:19:01 +0200
Message-ID: <20250926-vfs-workqueue-6bff38a4de55@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926-vfs-618-e880cf3b910f@brauner>
References: <20250926-vfs-618-e880cf3b910f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4416; i=brauner@kernel.org; h=from:subject:message-id; bh=8utFmDcG4z+8QeNM+4qBA8fQp61CzhsUL6K1IxxavOU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRcW3BB6auDx8yLi1S8N38Ta/Q3PXd/RZBad7nmvhzdx ui2U1WfOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZS9ZrhD4/Om+hpWpnlh9h/ P9LwePX59f+gzU/eTFVYu4hzIWdYRx7Df68uuedPbBff3GvhleN0MUvMkM+45btt+gZ2liU9jy8 HMgEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains various workqueue changes affecting the filesystem layer.

Currently if a user enqueue a work item using schedule_delayed_work()
the used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This replaces the use of system_wq and system_unbound_wq. system_wq is a
per-CPU workqueue which isn't very obvious from the name and
system_unbound_wq is to be used when locality is not required.

So this renames system_wq to system_percpu_wq, and system_unbound_wq to
system_dfl_wq.

This also adds a new WQ_PERCPU flag to allow the fs subsystem users to
explicitly request the use of per-CPU behavior. Both WQ_UNBOUND and
WQ_PERCPU flags coexist for one release cycle to allow callers to
transition their calls. WQ_UNBOUND will be removed in a next release
cycle.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

[1] https://lore.kernel.org/linux-next/aNEKzrMMxLAVHGIn@finisterre.sirena.org.uk
    This will have a merge conflict with changes in the quota tree.
    Steven's proposed resolution is correct.

No known conflicts.

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc1.workqueue

for you to fetch changes up to 56ce6c8b11a95c65764e27cb6021b1e98ccc4212:

  Merge patch series "fs: replace wq users and add WQ_PERCPU to alloc_workqueue() users" (2025-09-19 16:15:12 +0200)

Please consider pulling these changes from the signed vfs-6.18-rc1.workqueue tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.18-rc1.workqueue

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "fs: replace wq users and add WQ_PERCPU to alloc_workqueue() users"

Marco Crivellari (3):
      fs: replace use of system_unbound_wq with system_dfl_wq
      fs: replace use of system_wq with system_percpu_wq
      fs: WQ_PERCPU added to alloc_workqueue users

 fs/afs/callback.c                |  4 ++--
 fs/afs/main.c                    |  4 ++--
 fs/afs/write.c                   |  2 +-
 fs/aio.c                         |  2 +-
 fs/bcachefs/btree_write_buffer.c |  2 +-
 fs/bcachefs/io_read.c            |  8 ++++----
 fs/bcachefs/journal_io.c         |  2 +-
 fs/bcachefs/super.c              | 10 +++++-----
 fs/btrfs/block-group.c           |  2 +-
 fs/btrfs/disk-io.c               |  2 +-
 fs/btrfs/extent_map.c            |  2 +-
 fs/btrfs/space-info.c            |  4 ++--
 fs/btrfs/zoned.c                 |  2 +-
 fs/ceph/super.c                  |  2 +-
 fs/coredump.c                    |  2 +-
 fs/dlm/lowcomms.c                |  2 +-
 fs/dlm/main.c                    |  2 +-
 fs/ext4/mballoc.c                |  2 +-
 fs/fs-writeback.c                |  4 ++--
 fs/fuse/dev.c                    |  2 +-
 fs/fuse/inode.c                  |  2 +-
 fs/gfs2/main.c                   |  5 +++--
 fs/gfs2/ops_fstype.c             |  6 ++++--
 fs/netfs/misc.c                  |  2 +-
 fs/netfs/objects.c               |  2 +-
 fs/nfs/namespace.c               |  2 +-
 fs/nfs/nfs4renewd.c              |  2 +-
 fs/nfsd/filecache.c              |  2 +-
 fs/notify/mark.c                 |  4 ++--
 fs/ocfs2/dlm/dlmdomain.c         |  3 ++-
 fs/ocfs2/dlmfs/dlmfs.c           |  3 ++-
 fs/quota/dquot.c                 |  2 +-
 fs/smb/client/cifsfs.c           | 16 +++++++++++-----
 fs/smb/server/ksmbd_work.c       |  2 +-
 fs/smb/server/transport_rdma.c   |  3 ++-
 fs/super.c                       |  3 ++-
 fs/verity/verify.c               |  2 +-
 fs/xfs/xfs_log.c                 |  3 +--
 fs/xfs/xfs_mru_cache.c           |  3 ++-
 fs/xfs/xfs_super.c               | 15 ++++++++-------
 40 files changed, 79 insertions(+), 65 deletions(-)

