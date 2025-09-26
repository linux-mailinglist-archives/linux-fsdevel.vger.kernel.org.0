Return-Path: <linux-fsdevel+bounces-62891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C25BA41F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 16:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5219F1C05827
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 14:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEB922B8B0;
	Fri, 26 Sep 2025 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqoCtWTE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC55B2248AE;
	Fri, 26 Sep 2025 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896362; cv=none; b=UaDAePn0Dh+dlWp7wksPIaKkaMvPQGbIFGYT9I2/VWLdg8xqfz+A6eYo6oejRhnrqQ/qyUz8gEVXyht9MvOQcugt/+pbh5zkRG5PuB3VMPQH43u/vSCmXibr141DZrE6nwlN6KOmjBze8T6S0wmoSt7IT2/Dq4FeDIy2xxMOR1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896362; c=relaxed/simple;
	bh=+mF3f5ZuZvF0EbugEE0LrQfm8njKZn68VeofxNQK/80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AlwXFPjewTc1e46WHSlFf4CSi14Rs54hBZFgGiJzAVjZij1WSmSOXgPHxnGbVUfzlW0GzkgWmRRVMWfzz2XcExpxx48ll7YLxpbI9FqPjPC8E70XdtvlKlaeAx80sG7FqbbrtKgSG2tui5btYteK0wp5oSs8HUytm2tvwN7gGBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqoCtWTE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78978C4CEF7;
	Fri, 26 Sep 2025 14:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758896362;
	bh=+mF3f5ZuZvF0EbugEE0LrQfm8njKZn68VeofxNQK/80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZqoCtWTEXTK5whUjOQHMhVcHSV5/a2XqH+HuetiDLn8afsS5OaHisrdBQwoEyIuQJ
	 KN/b2mz3hGa/HcrlN07or5Uff/0K0G+Q/dH7lxBH1jRHNgPqzp7rgEXtIyrWbw1CAE
	 xQoQeb87YjmNMQzcpN9xBlmXlm0jA3QI4Z4wdstC+xOpd9nlZ7BNMx3PD+Th4kzyz/
	 8Y9bdfnWzUxqTm2oSWZmdH/89ZblURkhTE5d4gn64nMeud18d/Z5lXZ6xKQxG5vSNi
	 dHk0kyD0AY5yKdhgg1HdLT2sMT0FwFXq/5xNJOJx8k/ykhpx6l8KeFf7DDL4aqDXsZ
	 LGKqKsInDCGAA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 12/12 for v6.18] async directory preliminaries
Date: Fri, 26 Sep 2025 16:19:06 +0200
Message-ID: <20250926-vfs-async-920f57c61768@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926-vfs-618-e880cf3b910f@brauner>
References: <20250926-vfs-618-e880cf3b910f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3822; i=brauner@kernel.org; h=from:subject:message-id; bh=+mF3f5ZuZvF0EbugEE0LrQfm8njKZn68VeofxNQK/80=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRcW3CxVMtw37zW3rsuHUWW7q0x65XfdCQqXJMvMvtxb dsJF71vHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNJ4GZkeHz8ZrlpkOWT4LsB QqZf3Jx0r62+aOS31Nxv5dvEgFmTtjIybHj7qODzAqsFN5gYyl7+WCbj90D5OXuhte3EPZeT35r P4wYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains further preparatory changes for the asynchronous directory
locking scheme:

* Add lookup_one_positive_killable() which allows overlayfs to perform
  lookup that won't block on a fatal signal.

* Unify the mount idmap handling in struct renamedata as a rename can
  only happen within a single mount.

* Introduce kern_path_parent() for audit which sets the path to the
  parent and returns a dentry for the target without holding any locks
  on return.

* Rename kern_path_locked() as it is only used to prepare for the
  removal of an object from the filesystem:

   kern_path_locked()    => start_removing_path()
   kern_path_create()    => start_creating_path()
   user_path_create()    => start_creating_user_path()
   user_path_locked_at() => start_removing_user_path_at()
   done_path_create()    => end_creating_path()
   NA                    => end_removing_path()

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

[1] https://lore.kernel.org/linux-next/aNOyrz1bd1WTrZgc@finisterre.sirena.org.uk

[2] https://lore.kernel.org/linux-next/aNU3FtEZ3w_NcYwI@sirena.org.uk

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc1.async

for you to fetch changes up to 4f5ea5aa0dcdd3c7487fbabad5b86b3cd7d2b8c4:

  Merge patch series "vfs: preparatory changes to centralize locking of create/remove/rename" (2025-09-23 12:37:42 +0200)

Please consider pulling these changes from the signed vfs-6.18-rc1.async tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.18-rc1.async

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "vfs: preparatory changes to centralize locking of create/remove/rename"

NeilBrown (6):
      VFS/ovl: add lookup_one_positive_killable()
      VFS: discard err2 in filename_create()
      VFS: unify old_mnt_idmap and new_mnt_idmap in renamedata
      VFS/audit: introduce kern_path_parent() for audit
      VFS: rename kern_path_locked() and related functions.
      debugfs: rename start_creating() to debugfs_start_creating()

 Documentation/filesystems/porting.rst        |  12 ++
 arch/powerpc/platforms/cell/spufs/syscalls.c |   4 +-
 drivers/base/devtmpfs.c                      |  22 ++--
 fs/bcachefs/fs-ioctl.c                       |  10 +-
 fs/cachefiles/namei.c                        |   3 +-
 fs/debugfs/inode.c                           |  11 +-
 fs/ecryptfs/inode.c                          |   3 +-
 fs/init.c                                    |  17 +--
 fs/namei.c                                   | 164 ++++++++++++++++++++-------
 fs/nfsd/vfs.c                                |   3 +-
 fs/ocfs2/refcounttree.c                      |   4 +-
 fs/overlayfs/overlayfs.h                     |   3 +-
 fs/overlayfs/readdir.c                       |  28 ++---
 fs/smb/server/vfs.c                          |  11 +-
 include/linux/fs.h                           |   6 +-
 include/linux/namei.h                        |  21 ++--
 kernel/audit_fsnotify.c                      |  11 +-
 kernel/audit_watch.c                         |   3 +-
 kernel/bpf/inode.c                           |   4 +-
 net/unix/af_unix.c                           |   6 +-
 20 files changed, 216 insertions(+), 130 deletions(-)

