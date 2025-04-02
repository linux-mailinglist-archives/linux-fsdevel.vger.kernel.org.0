Return-Path: <linux-fsdevel+bounces-45536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74818A79260
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 17:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858303B5D42
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 15:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E08215098F;
	Wed,  2 Apr 2025 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKgAC7xz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B389434545;
	Wed,  2 Apr 2025 15:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743608786; cv=none; b=dpZQbMxXHNnLSH7TMWABbuxn5x6828IyjvmGBxhqa72uPkx06zfiCjiRxa6nud7xN5lprfPKPOF1AVr8amy5fx6qzSJMi9y9oSa9M5pznpQBGJVwTsGUnUfWb0ymDyzfPtzRsEmiZTzENMnKCPhLWxvqWRTtPGvxnqvhbIL1IIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743608786; c=relaxed/simple;
	bh=/CczPmzk4htdqxZ07yuqfEg7FuP+4yK+x6bwN6hz4pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nb1qOLGSCb0nE3yNfBcMsOHZ+Fb+tDzQbtDzpdcoWJ9Ljee51t9jwFTM6//M2eUP9gF2QZ6PmzvnjtHs/lRViYmcHq+poyPPtsKeg5e+UieQK9X1ZzDYjhF7L50WxCKQ3H67ndOCMV1rDWlYUz+OltFI5UiLio6ks/gaC3UJu3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKgAC7xz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFCCC4CEDD;
	Wed,  2 Apr 2025 15:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743608786;
	bh=/CczPmzk4htdqxZ07yuqfEg7FuP+4yK+x6bwN6hz4pQ=;
	h=From:To:Cc:Subject:Date:From;
	b=PKgAC7xzHY6k0QUaYYV14uhfv11ft7ietVtaCorow10JUU5ky5dfrX5EyIzq3qIOm
	 r/dx7Rf+Zep8zNfB4yByLENkqIJxUQrct9BlVyeBX29GVjUVOwRibMBfGZkILznzMo
	 F2NDpPi2LYLBstUr8n5DrG2V219tqZpuhTVCRSf/UJ77jb+n5ZyBD4siokZ8Zxcx4X
	 eB642WT8HevtYVDrPZEywlJsQJwoFn+uyQ43fcxxQm4oWdf0cO5PTmbLG0St1D7iIG
	 UsQxm8QJ0i/8ID0DT1+5saKK1qHIT+0BDoeelgehULxvJzwylh9kibuLSREvmIB1nq
	 t3t9soj4px+vw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Wed,  2 Apr 2025 17:46:12 +0200
Message-ID: <20250402-vfs-fixes-a079545d90a9@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3346; i=brauner@kernel.org; h=from:subject:message-id; bh=/CczPmzk4htdqxZ07yuqfEg7FuP+4yK+x6bwN6hz4pQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS/jT6aycWne/++nVHrzxLV1ONXDtlu9Zm1+1OF4v88d bZ1m6NtOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACby+CrD/6DDm/PnSEx6dvFj 3FyhnKenbvnf37bF4YFESjYze9skHSFGhg6j4N1fb/Q+i2u/VNfCe4xhQs+kcmfphdpqu45sPf1 1PTcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains various fixes for this cycle:

- Add a new maintainer for configfs.

- Fix exportfs module description.

- Place flexible array memeber at the end of an internal struct in the
  mount code.

- Add new maintainer for netfslib as Jeff Layton is stepping down as
  current co-maintainer.

- Fix error handling in cachefiles_get_directory().

- Cleanup do_notify_pidfd().

- Fix syscall number definitions in pidfd selftests.

- Fix racy usage of fs_struct->in exec during multi-threaded exec.

- Ensure correct exit code is reported when pidfs_exit() is called from
  release_task() for a delayed thread-group leader exit.

- Fix conflicting iomap flag definitions.

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

The following changes since commit 2df0c02dab829dd89360d98a8a1abaa026ef5798:

  x86 boot build: make git ignore stale 'tools' directory (2025-03-24 23:09:14 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.fixes

for you to fetch changes up to 923936efeb74b3f42e5ad283a0b9110bda102601:

  iomap: Fix conflicting values of iomap flags (2025-03-28 10:45:00 +0100)

Please consider pulling these changes from the signed vfs-6.15-rc1.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.15-rc1.fixes

----------------------------------------------------------------
Andreas Hindborg (1):
      MAINTAINERS: configfs: add Andreas Hindborg as maintainer

Arnd Bergmann (1):
      exportfs: add module description

Gustavo A. R. Silva (1):
      fs: namespace: Avoid -Wflex-array-member-not-at-end warning

Jeff Layton (1):
      netfs: add Paulo as maintainer and remove myself as Reviewer

Marc Dionne (1):
      cachefiles: Fix oops in vfs_mkdir from cachefiles_get_directory

Oleg Nesterov (4):
      pidfs: cleanup the usage of do_notify_pidfd()
      selftests/pidfd: fixes syscall number defines
      exec: fix the racy usage of fs_struct->in_exec
      exit: fix the usage of delay_group_leader->exit_code in do_notify_parent() and pidfs_exit()

Ritesh Harjani (IBM) (1):
      iomap: Fix conflicting values of iomap flags

 CREDITS                                           |  4 ++++
 MAINTAINERS                                       |  7 ++++---
 fs/cachefiles/namei.c                             |  7 ++++---
 fs/exec.c                                         | 15 +++++++++------
 fs/exportfs/expfs.c                               |  1 +
 fs/namespace.c                                    |  4 +++-
 include/linux/iomap.h                             | 15 +++++++--------
 kernel/exit.c                                     | 11 +++++------
 kernel/signal.c                                   |  8 +++-----
 tools/testing/selftests/clone3/clone3_selftests.h |  2 +-
 tools/testing/selftests/pidfd/pidfd.h             |  8 ++++----
 11 files changed, 45 insertions(+), 37 deletions(-)

