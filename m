Return-Path: <linux-fsdevel+bounces-13992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9B78761B7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 11:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F23FB1C215F7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 10:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4623653E36;
	Fri,  8 Mar 2024 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcPgGZ61"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947125381E;
	Fri,  8 Mar 2024 10:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709892929; cv=none; b=eYHhfojmK4K1c1J0k99/IQZC4BgODhvVoQNc8MfSLOJ1ca3H1np5LgwcWZ5eFMXNK9jO596o9oxISii+Nob62yYT0VeRTwoIuCCnHtNWoVkV04RhHTeVulSm+8/CkwU1119euPLcjWoZ9tE+J/HZfmjUMfPV6aiQjuJaEEkHkJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709892929; c=relaxed/simple;
	bh=3VnK8HwzGKlhdlzy8zBy5yNylnxU0bOWUgzxnz9BpWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i6VxE5XREaKVwXPQa+vX/UR1fR3/RU+Ma85IHE8gF+g/d7C8Tm+M7LbeRl6A42U4dx5CCKEWJNp3c2LKiBJ5QPqa0/T5ECJHsfI5NUdSZeD8dxq3TDdMpAdv4nwe+QRf0YUXbXXqSIfyo3GZNanbYiPhdzgbesxfddTBniDw9m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcPgGZ61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FEAC433C7;
	Fri,  8 Mar 2024 10:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709892929;
	bh=3VnK8HwzGKlhdlzy8zBy5yNylnxU0bOWUgzxnz9BpWQ=;
	h=From:To:Cc:Subject:Date:From;
	b=PcPgGZ61XofzoXSOrb2StQfomCdKNnezFOua1NzXQch+/bttQJWNWJS5pYZ2gWz6E
	 +aV21XDUp1gFU4xf5/fVl2vAcRwflntjBDo7/Wq1+/4viSyd6L/tJ2anIdLy7E82sz
	 JY8/PpBvk9T7RwEPOGhL5r3oPmUaki/YA1ER2jW3nHN0Oo47S1yPHFNTmB5pl+LKQV
	 BHM6djbOWlxtgJbEcNBOK6v+26YasWp3Z1OlsnpO16WnBOlnpmaK3nWU6+xoH1Viky
	 e7BPqcCvswhmhuWRiwStGi+RUbL4EccmdEoKiA1f9pwwMRIqPJGLILeYmVo/8pcgoE
	 n0yZbWbpVTf2A==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs filelock
Date: Fri,  8 Mar 2024 11:15:17 +0100
Message-ID: <20240308-vfs-filelock-5711cd242ea9@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7941; i=brauner@kernel.org; h=from:subject:message-id; bh=3VnK8HwzGKlhdlzy8zBy5yNylnxU0bOWUgzxnz9BpWQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS+emohzr26f/FRho4X+k4BK1e+vc0g/E8mRcS5xneZc d2aDx0TOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACais5Thr+jiAIuTL/TkAneE L7f9vDRy1pOPrbN9P5s4X1Ph3bfGRZfhf2n8zGN30j9qi3CsmXP4+OOMefZh5oVlkuLaxy8Ee76 ZwAUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
A few years ago struct file_lock_context was added to allow for separate
lists to track different types of file locks instead of using a
singly-linked list for all of them.

Now leases no longer need to be tracked using struct file_lock. However,
a lot of the infrastructure is identical for leases and locks so
separating them isn't trivial.

This pull request splits a group of fields used by both file locks and
leases into a new struct file_lock_core. The new core struct is embedded
in struct file_lock. Coccinelle was used to convert a lot of the callers
to deal with the move, with the remaining 25% or so converted by hand.

Afterwards several internal functions in fs/locks.c are made to work
with struct file_lock_core. Ultimately this allows to split struct
file_lock into struct file_lock and struct file_lease. The file lease
APIs are then converted to take struct file_lease.

/* Testing */
clang: Debian clang version 16.0.6 (19)
gcc: (Debian 13.2.0-7) 13.2.0

All patches are based on v6.8-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with other trees
================================

[1] linux-next: manual merge of the vfs-brauner tree with the nfsd tree
    https://lore.kernel.org/linux-next/20240207114118.23541d8c@canb.auug.org.au

[2] linux-next: manual merge of the vfs-brauner tree with the cifs tree
    https://lore.kernel.org/linux-next/20240208095906.18567844@canb.auug.org.au

[3] linux-next: build failure after merge of the vfs-brauner tree
    https://lore.kernel.org/linux-next/20240219104450.4d258995@canb.auug.org.au

[4] linux-next: manual merge of the vfs-brauner tree with the fuse tree
    https://lore.kernel.org/linux-next/20240307102332.6793fbc7@canb.auug.org.au

Merge conflicts with mainline
=============================

No known conflicts.

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.9.file

for you to fetch changes up to 14786d949a3b8cf00cc32456363b7db22894a0e6:

  filelock: fix deadlock detection in POSIX locking (2024-02-20 09:53:33 +0100)

Please consider pulling these changes from the signed vfs-6.9.file tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.9.file

----------------------------------------------------------------
Christian Brauner (1):
      Merge series 'filelock: split file leases out of struct file_lock' of https://lore.kernel.org/r/20240131-flsplit-v3-0-c6129007ee8d@kernel.org

Jeff Layton (50):
      filelock: fl_pid field should be signed int
      filelock: rename some fields in tracepoints
      filelock: rename fl_pid variable in lock_get_status
      filelock: add some new helper functions
      9p: rename fl_type variable in v9fs_file_do_lock
      afs: convert to using new filelock helpers
      ceph: convert to using new filelock helpers
      dlm: convert to using new filelock helpers
      gfs2: convert to using new filelock helpers
      lockd: convert to using new filelock helpers
      nfs: convert to using new filelock helpers
      nfsd: convert to using new filelock helpers
      ocfs2: convert to using new filelock helpers
      smb/client: convert to using new filelock helpers
      smb/server: convert to using new filelock helpers
      filelock: drop the IS_* macros
      filelock: split common fields into struct file_lock_core
      filelock: have fs/locks.c deal with file_lock_core directly
      filelock: convert more internal functions to use file_lock_core
      filelock: make posix_same_owner take file_lock_core pointers
      filelock: convert posix_owner_key to take file_lock_core arg
      filelock: make locks_{insert,delete}_global_locks take file_lock_core arg
      filelock: convert locks_{insert,delete}_global_blocked
      filelock: make __locks_delete_block and __locks_wake_up_blocks take file_lock_core
      filelock: convert __locks_insert_block, conflict and deadlock checks to use file_lock_core
      filelock: convert fl_blocker to file_lock_core
      filelock: clean up locks_delete_block internals
      filelock: reorganize locks_delete_block and __locks_insert_block
      filelock: make assign_type helper take a file_lock_core pointer
      filelock: convert locks_wake_up_blocks to take a file_lock_core pointer
      filelock: convert locks_insert_lock_ctx and locks_delete_lock_ctx
      filelock: convert locks_translate_pid to take file_lock_core
      filelock: convert seqfile handling to use file_lock_core
      9p: adapt to breakup of struct file_lock
      afs: adapt to breakup of struct file_lock
      ceph: adapt to breakup of struct file_lock
      dlm: adapt to breakup of struct file_lock
      gfs2: adapt to breakup of struct file_lock
      fuse: adapt to breakup of struct file_lock
      lockd: adapt to breakup of struct file_lock
      nfs: adapt to breakup of struct file_lock
      nfsd: adapt to breakup of struct file_lock
      ocfs2: adapt to breakup of struct file_lock
      smb/client: adapt to breakup of struct file_lock
      smb/server: adapt to breakup of struct file_lock
      filelock: remove temporary compatibility macros
      filelock: split leases out of struct file_lock
      filelock: don't do security checks on nfsd setlease calls
      filelock: always define for_each_file_lock()
      filelock: fix deadlock detection in POSIX locking

NeilBrown (1):
      smb: remove redundant check

 fs/9p/vfs_file.c                |  40 +-
 fs/afs/flock.c                  |  60 +--
 fs/ceph/locks.c                 |  74 ++--
 fs/dlm/plock.c                  |  44 +-
 fs/fuse/file.c                  |  14 +-
 fs/gfs2/file.c                  |  16 +-
 fs/libfs.c                      |   2 +-
 fs/lockd/clnt4xdr.c             |  14 +-
 fs/lockd/clntlock.c             |   2 +-
 fs/lockd/clntproc.c             |  65 +--
 fs/lockd/clntxdr.c              |  14 +-
 fs/lockd/svc4proc.c             |  10 +-
 fs/lockd/svclock.c              |  64 +--
 fs/lockd/svcproc.c              |  10 +-
 fs/lockd/svcsubs.c              |  24 +-
 fs/lockd/xdr.c                  |  14 +-
 fs/lockd/xdr4.c                 |  14 +-
 fs/locks.c                      | 894 ++++++++++++++++++++++------------------
 fs/nfs/delegation.c             |   4 +-
 fs/nfs/file.c                   |  22 +-
 fs/nfs/nfs3proc.c               |   2 +-
 fs/nfs/nfs4_fs.h                |   2 +-
 fs/nfs/nfs4file.c               |   2 +-
 fs/nfs/nfs4proc.c               |  39 +-
 fs/nfs/nfs4state.c              |  22 +-
 fs/nfs/nfs4trace.h              |   4 +-
 fs/nfs/nfs4xdr.c                |   8 +-
 fs/nfs/write.c                  |   8 +-
 fs/nfsd/filecache.c             |   4 +-
 fs/nfsd/nfs4callback.c          |   2 +-
 fs/nfsd/nfs4layouts.c           |  35 +-
 fs/nfsd/nfs4state.c             | 124 +++---
 fs/ocfs2/locks.c                |  12 +-
 fs/ocfs2/stack_user.c           |   2 +-
 fs/open.c                       |   2 +-
 fs/posix_acl.c                  |   4 +-
 fs/smb/client/cifsfs.c          |   5 +-
 fs/smb/client/cifssmb.c         |   8 +-
 fs/smb/client/file.c            |  78 ++--
 fs/smb/client/smb2file.c        |   2 +-
 fs/smb/server/smb2pdu.c         |  44 +-
 fs/smb/server/vfs.c             |  14 +-
 include/linux/filelock.h        | 129 ++++--
 include/linux/fs.h              |   5 +-
 include/linux/lockd/lockd.h     |   8 +-
 include/linux/lockd/xdr.h       |   2 +-
 include/trace/events/afs.h      |   4 +-
 include/trace/events/filelock.h | 102 ++---
 48 files changed, 1117 insertions(+), 957 deletions(-)

