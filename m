Return-Path: <linux-fsdevel+bounces-49766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3AAAC22BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 14:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B944E717B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 12:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5443A1798F;
	Fri, 23 May 2025 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2oWE0f3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0064E56A;
	Fri, 23 May 2025 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748004009; cv=none; b=kOY2C4fsmKoOcu8w33rku2eb99GJboAVTGiuRslZLkIu2DmzuX69ideQ1eNtRuKV6wESzV8EikrvAa78GM4aOo+bXRHLDCycE91xQBj7CRuaPcRW5uJZcsnvyGlTblghUQOaGZsJ+5HZsdpjLeeIRHJ0Lr0/y2ezb4VzgZbhS9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748004009; c=relaxed/simple;
	bh=a3RlR2dNOuXFrY4NUZQa+kjEkVnWtFSJcfWHVn1ydmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=raMATVXSNPV+E6A4BZ2NvYwVj0+7K7dyY0neY6AThhfdOtmsm5UTJjJqoUu7fVtD3CnqH/s9LEzkaxi8TgN++cL8PmrWHox6rebKuF4+vHIe8VGS7YkbtOSGGr3au0zvbOueoKMOG3J4IjAkWVbclRtYAyeJIHfM55o7Zffgyzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2oWE0f3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0252BC4CEE9;
	Fri, 23 May 2025 12:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748004009;
	bh=a3RlR2dNOuXFrY4NUZQa+kjEkVnWtFSJcfWHVn1ydmA=;
	h=From:To:Cc:Subject:Date:From;
	b=F2oWE0f3lhBQq6ZnOESHZJS7P+oOEYRLVHmekjKfv1+g8ZT7/Sx7Ade+A5KWN9GnO
	 HefYH9Cy10MewVpgJt9zvdO/Ry2u/adXAg27+kBgIzVEbBKNXEiBZCxKisOmxYUlz9
	 DoFrdgpIckU4cbW5PF8ljgVuu5VcWEaxBLX/6J6LEtxwCtHuTTcwAoJj58nS2SiQh7
	 jPiAyU4GK0pu08h+IxQYdch+3yRbQodIYsVN7g8gczo3cyWxUoSBSePLjBFVqduvNg
	 vypWxo/cFIfwWB3H7d7Zaws43uQAkkiyS7wJorJ7TY1fMkjjeJtKHOIDBXCYJugrpg
	 rxo9T0Joop1og==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v6.16] vfs freeze
Date: Fri, 23 May 2025 14:40:00 +0200
Message-ID: <20250523-vfs-freeze-8e3934479cba@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5642; i=brauner@kernel.org; h=from:subject:message-id; bh=a3RlR2dNOuXFrY4NUZQa+kjEkVnWtFSJcfWHVn1ydmA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQY5CwRmGHvpPP30Qrjwh3du1W27+3hFVZINlfPmT794 IWizo6jHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNht2b4p/nesobzRfSv55Yr Vsg3yiXtdmE/vHdaBHdO1yrnjW4XNjIyNN8IezDN60aj948pTTmvXzty3E9Y/JtTi/FC4nyTA9o reQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains various filesystem freezing related work for this cycle:

- Allow the power subsystem to support filesystem freeze for suspend and
  hibernate.

  Now all the pieces are in place to actually allow the power subsystem
  to freeze/thaw filesystems during suspend/resume. Filesystems are only
  frozen and thawed if the power subsystem does actually own the freeze.

  If the filesystem is already frozen by the time we've frozen all
  userspace processes we don't care to freeze it again. That's
  userspace's job once the process resumes. We only actually freeze
  filesystems if we absolutely have to and we ignore other failures to
  freeze.

  We could bubble up errors and fail suspend/resume if the error isn't
  EBUSY (aka it's already frozen) but I don't think that this is worth
  it. Filesystem freezing during suspend/resume is best-effort. If the
  user has 500 ext4 filesystems mounted and 4 fail to freeze for
  whatever reason then we simply skip them.

  What we have now is already a big improvement and let's see how we
  fare with it before making our lives even harder (and uglier) than we
  have to.

- Allow efivars to support freeze and thaw

  Allow efivarfs to partake to resync variable state during system
  hibernation and suspend. Add freeze/thaw support.

  This is a pretty straightforward implementation. We simply add regular
  freeze/thaw support for both userspace and the kernel. efivars is the
  first pseudofilesystem that adds support for filesystem freezing and
  thawing.

  The simplicity comes from the fact that we simply always resync
  variable state after efivarfs has been frozen. It doesn't matter
  whether that's because of suspend, userspace initiated freeze or
  hibernation. Efivars is simple enough that it doesn't matter that we
  walk all dentries. There are no directories and there aren't insane
  amounts of entries and both freeze/thaw are already heavy-handed
  operations. If userspace initiated a freeze/thaw cycle they would need
  CAP_SYS_ADMIN in the initial user namespace (as that's where efivarfs
  is mounted) so it can't be triggered by random userspace. IOW, we
  really really don't care.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

This has a merge conflict with mainline that can be resolved as follows:

diff --cc fs/efivarfs/super.c
index b2de4079864c,63f152d25c20..000000000000
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@@ -18,9 -18,9 +18,10 @@@
  #include <linux/statfs.h>
  #include <linux/notifier.h>
  #include <linux/printk.h>
 +#include <linux/namei.h>

  #include "internal.h"
+ #include "../internal.h"

  static int efivarfs_ops_notifier(struct notifier_block *nb, unsigned long event,
                                 void *data)

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc1.super

for you to fetch changes up to 1afe9e7da8c0ab3c17d4a469ed4c0607024cf0d4:

  f2fs: fix freezing filesystem during resize (2025-05-09 12:41:24 +0200)

Please consider pulling these changes from the signed vfs-6.16-rc1.super tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.16-rc1.super

----------------------------------------------------------------
Christian Brauner (15):
      super: remove pointless s_root checks
      super: simplify user_get_super()
      super: skip dying superblocks early
      super: use a common iterator (Part 1)
      super: use common iterator (Part 2)
      gfs2: pass through holder from the VFS for freeze/thaw
      super: add filesystem freezing helpers for suspend and hibernate
      Merge patch series "Extend freeze support to suspend and hibernate"
      libfs: export find_next_child()
      power: freeze filesystems during suspend/resume
      efivarfs: support freeze/thaw
      kernfs: add warning about implementing freeze/thaw
      Merge patch series "efivarfs: support freeze/thaw"
      Merge patch series "power: wire-up filesystem freeze/thaw with suspend/resume"
      f2fs: fix freezing filesystem during resize

James Bottomley (2):
      locking/percpu-rwsem: add freezable alternative to down_read
      fs: allow all writers to be frozen

 fs/efivarfs/internal.h        |   1 -
 fs/efivarfs/super.c           | 195 +++++++-------------------
 fs/f2fs/gc.c                  |   6 +-
 fs/gfs2/super.c               |  24 ++--
 fs/gfs2/sys.c                 |   4 +-
 fs/internal.h                 |   1 +
 fs/ioctl.c                    |   8 +-
 fs/kernfs/mount.c             |  15 ++
 fs/libfs.c                    |   3 +-
 fs/super.c                    | 316 ++++++++++++++++++++++++++++++------------
 fs/xfs/scrub/fscounters.c     |   4 +-
 fs/xfs/xfs_notify_failure.c   |   6 +-
 include/linux/fs.h            |  19 ++-
 include/linux/percpu-rwsem.h  |  20 ++-
 kernel/locking/percpu-rwsem.c |  13 +-
 kernel/power/hibernate.c      |  16 ++-
 kernel/power/main.c           |  31 +++++
 kernel/power/power.h          |   4 +
 kernel/power/suspend.c        |   7 +
 19 files changed, 417 insertions(+), 276 deletions(-)

