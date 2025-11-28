Return-Path: <linux-fsdevel+bounces-70162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB71DC92A75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 17:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3366A3B065F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 16:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402222F260C;
	Fri, 28 Nov 2025 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtQovTtU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9647D2F0C78;
	Fri, 28 Nov 2025 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764348689; cv=none; b=M3n0KJNvyCosyDlsgszuS4KGoBFBPBh97gxpUfz75gIyzPx5T9bCt74kZW43bmRky81t2bNpPtO33vFFO9fBbYoJNzB3hxoaVwuf7kURdwppZ5uvg2KTn8XNgDZpcjdB+rRpZjZT/7tFfAopow72UgiUCQM+VBEl2ZZCoXxDh6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764348689; c=relaxed/simple;
	bh=S9ZlqJa+zIU/ko8Nqz1nclpu5HG7vuurGQl7J75jz3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpVPtBWQColnZK6SPzCL2HLMKUIzrVcv5T1H/MARYPwhUfWDnVKYr5/iNwTMZfi8zLGg8H0gYfoGztXWJucTX1tDLo/p99SfuXuhStsOOM+sth/faKP7jMdegDlqAB0LrZYapmJEbNKbs0FyjuXEbdy4PF8uA6yjNs4bxgmqR6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtQovTtU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3DCC4CEF1;
	Fri, 28 Nov 2025 16:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764348689;
	bh=S9ZlqJa+zIU/ko8Nqz1nclpu5HG7vuurGQl7J75jz3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gtQovTtUhELW6dM0lZvq474EQDLMJ2fg5LauVYPfH3Xggv1pTYAnEGjVEOSoUrZS7
	 FcSeCh5Ie79p8FW9uOKYR7h8Vwk8BJPd1AYSLwbhfNvxhRAUbe9UpL6WB35bpC0+5D
	 UwJAiGfiz6jI+RPaKwIjNf7/0jDJCFTVX4eopMH5QRRkdYrgfnyz37vcI+xFUAbzW7
	 y+NImXvwKXqQOmo7/MW9Ala9WdWN9rHpVvxYcgVsbQc+oddylb9QlfxruF+zSMfcWR
	 9peI+pe07Jc7CplkceWHePEfZVR9hAO41RsXO6Jz9IYRRW0Rr2kwTSsrJ8uCMK6Kd0
	 kC8KqRmQIOHvQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 12/17 for v6.19] vfs directory delegations
Date: Fri, 28 Nov 2025 17:48:23 +0100
Message-ID: <20251128-vfs-directory-delegations-v619-07cf59ad4cf2@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251128-vfs-v619-77cd88166806@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6401; i=brauner@kernel.org; h=from:subject:message-id; bh=S9ZlqJa+zIU/ko8Nqz1nclpu5HG7vuurGQl7J75jz3g=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRqXnpckir10OhIo8i0w391Z896UGnjoD4pS+tpk45IS siW1SeaOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYStZfhv5eKLWvZlsW2G5r1 emKmWu9Y++KRq4+T5axnLSdVFezirjP8j3E43/Pp2vqpNv7nPI5c0PFv/DzjX3nF10PzL7z9fU3 PnAkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains the work for cecall-only directory delegations for knfsd.

Add support for simple, recallable-only directory delegations. This was
decided at the fall NFS Bakeathon where the NFS client and server
maintainers discussed how to merge directory delegation support.

The approach starts with recallable-only delegations for several reasons:

1. RFC8881 has gaps that are being addressed in RFC8881bis. In particular,
  it requires directory position information for CB_NOTIFY callbacks,
  which is difficult to implement properly under Linux. The spec is being
  extended to allow that information to be omitted.

2. Client-side support for CB_NOTIFY still lags. The client side involves
  heuristics about when to request a delegation.

3. Early indication shows simple, recallable-only delegations can help
  performance. Anna Schumaker mentioned seeing a multi-minute speedup in
  xfstests runs with them enabled.

With these changes, userspace can also request a read lease on a
directory that will be recalled on conflicting accesses. This may be
useful for applications like Samba. Users can disable leases altogether
via the fs.leases-enable sysctl if needed.

VFS Changes

- Dedicated Type for Delegations

  Introduce struct delegated_inode to track inodes that may have delegations
  that need to be broken. This replaces the previous approach of passing
  raw inode pointers through the delegation breaking code paths, providing
  better type safety and clearer semantics for the delegation machinery.

- Break parent directory delegations in open(..., O_CREAT) codepath

- Allow mkdir to wait for delegation break on parent

- Allow rmdir to wait for delegation break on parent

- Add try_break_deleg calls for parents to vfs_link(), vfs_rename(),
  and vfs_unlink()

- Make vfs_create(), vfs_mknod(), and vfs_symlink() break delegations
  on parent directory

- Clean up argument list for vfs_create()

- Expose delegation support to userland

Filelock Changes

- Make lease_alloc() take a flags argument

- Rework the __break_lease API to use flags

- Add struct delegated_inode

- Push the S_ISREG check down to ->setlease handlers

  - Lift the ban on directory leases in generic_setlease

NFSD Changes

- Allow filecache to hold S_IFDIR files

- Allow DELEGRETURN on directories

- Wire up GET_DIR_DELEGATION handling

Fixes

- Fix kernel-doc warnings in __fcntl_getlease
- Add needed headers for new struct delegation definition

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

[1] https://lore.kernel.org/linux-next/20251117073452.2c9b0190@canb.auug.org.au

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.directory.delegations

for you to fetch changes up to 4be9e04ebf75a5c4478c1c6295e2122e5dc98f5f:

  vfs: add needed headers for new struct delegation definition (2025-11-28 10:55:34 +0100)

Please consider pulling these changes from the signed vfs-6.19-rc1.directory.delegations tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.19-rc1.directory.delegations

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "vfs: recall-only directory delegations for knfsd"

Jeff Layton (18):
      filelock: make lease_alloc() take a flags argument
      filelock: rework the __break_lease API to use flags
      filelock: add struct delegated_inode
      filelock: push the S_ISREG check down to ->setlease handlers
      vfs: add try_break_deleg calls for parents to vfs_{link,rename,unlink}
      vfs: allow mkdir to wait for delegation break on parent
      vfs: allow rmdir to wait for delegation break on parent
      vfs: break parent dir delegations in open(..., O_CREAT) codepath
      vfs: clean up argument list for vfs_create()
      vfs: make vfs_create break delegations on parent directory
      vfs: make vfs_mknod break delegations on parent directory
      vfs: make vfs_symlink break delegations on parent dir
      filelock: lift the ban on directory leases in generic_setlease
      nfsd: allow filecache to hold S_IFDIR files
      nfsd: allow DELEGRETURN on directories
      nfsd: wire up GET_DIR_DELEGATION handling
      vfs: expose delegation support to userland
      vfs: add needed headers for new struct delegation definition

Randy Dunlap (1):
      filelock: __fcntl_getlease: fix kernel-doc warnings

 drivers/base/devtmpfs.c    |   6 +-
 fs/attr.c                  |   2 +-
 fs/cachefiles/namei.c      |   2 +-
 fs/ecryptfs/inode.c        |  11 ++-
 fs/fcntl.c                 |  13 ++++
 fs/fuse/dir.c              |   1 +
 fs/init.c                  |   6 +-
 fs/locks.c                 | 103 ++++++++++++++++++++--------
 fs/namei.c                 | 162 +++++++++++++++++++++++++++++++++------------
 fs/nfs/nfs4file.c          |   2 +
 fs/nfsd/filecache.c        |  57 ++++++++++++----
 fs/nfsd/filecache.h        |   2 +
 fs/nfsd/nfs3proc.c         |   2 +-
 fs/nfsd/nfs4proc.c         |  22 +++++-
 fs/nfsd/nfs4recover.c      |   6 +-
 fs/nfsd/nfs4state.c        | 103 +++++++++++++++++++++++++++-
 fs/nfsd/state.h            |   5 ++
 fs/nfsd/vfs.c              |  16 ++---
 fs/nfsd/vfs.h              |   2 +-
 fs/open.c                  |  12 ++--
 fs/overlayfs/overlayfs.h   |  10 +--
 fs/posix_acl.c             |   8 +--
 fs/smb/client/cifsfs.c     |   3 +
 fs/smb/server/vfs.c        |   9 ++-
 fs/utimes.c                |   4 +-
 fs/xattr.c                 |  12 ++--
 fs/xfs/scrub/orphanage.c   |   2 +-
 include/linux/filelock.h   |  98 +++++++++++++++++++++------
 include/linux/fs.h         |  24 ++++---
 include/linux/xattr.h      |   4 +-
 include/uapi/linux/fcntl.h |  16 +++++
 net/unix/af_unix.c         |   2 +-
 32 files changed, 550 insertions(+), 177 deletions(-)

