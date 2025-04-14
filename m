Return-Path: <linux-fsdevel+bounces-46359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C9CA87DE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 12:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2B0017471A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 10:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F65526FA43;
	Mon, 14 Apr 2025 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3MEcSMU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EBD25E829;
	Mon, 14 Apr 2025 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744627507; cv=none; b=qQ1PJ9CrNPLc28hsvziMllPqXE11R40XhC/BnAWysoxwETt5/un5t8rPu50UZ+/GwhPU0bGKak0hacU4aAZzv7iUltLNmSfDaXxYDynqMaS6Gq7TiIBKI2vIkgRH17Hpa8l9HRLz7xnll9ajmmf7lIVWt/OT8sCgClWF9aGDoxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744627507; c=relaxed/simple;
	bh=jbmPN+aG2h7bf0ovaYK1nZkZI5CWL32o5Cx2AfnpJZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QIlbW6TA4MbPoYP8E4a3tayeXKpdGfZbBweBnoCzx1wURZOzl+shMKYUJsmX20ovjtPzpSvTSGWwu+UGutdJEItYiRcyyBnX1KTSn4LLzxxb4MAVuS5K8XY7zq4myZicz2sci0LY8Xpyk8cVhCxgXrvVx9MvvGCW1ttOwOSoSBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3MEcSMU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305AAC4CEE5;
	Mon, 14 Apr 2025 10:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744627505;
	bh=jbmPN+aG2h7bf0ovaYK1nZkZI5CWL32o5Cx2AfnpJZ0=;
	h=From:To:Cc:Subject:Date:From;
	b=G3MEcSMUf7zqL0Y08P0tPTuhpi8Ml9Mkh7R9S4muQBaVdY34ZnE4OZ2RUvO7wqkCY
	 GKpnYIEyPpKO7UqCbb/PYQmUY1J1V5y21VWwAxx3uuVZpsgU+g0SaHt6djACdZI1QC
	 g5XClozkhdqlFODGNBlIHaaXPmKjf07XiC7qNeAVSNk2TsJQdW5UXvqo05Z9H8T05y
	 Yi+S51m8+bXY2tQMdXILGxrC/+mXmfNyfrCWxlWRVqAynhe46b5aFw17PfAkosDhzQ
	 S+vT+XyCTil41zprEj/cGu4tx8grWVsEoZIW0zVPriNvTd1YIITCyQLgJtE1t5lL1a
	 gi9/Gus1cWBPg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Mon, 14 Apr 2025 12:44:19 +0200
Message-ID: <20250414-vfs-fixes-135f081cd64a@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3514; i=brauner@kernel.org; h=from:subject:message-id; bh=jbmPN+aG2h7bf0ovaYK1nZkZI5CWL32o5Cx2AfnpJZ0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/ea798m3/qcqH/5hPaS9vfbf0C//SB/U1kVuzZ3Js9 68Os6j50FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRc1cZ/qn6cSy5p/pM9Nlp 1winyX1nE46nWkZP1XZucnIKbSxaE8Pwv7wq7XXHKskbLJH2fyffklk+IW5/+Y0pehfqOO+zvwx XYQAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains various fixes for this cycle:

* Fix NULL pointer dereference in virtiofs.

* Fix slab OOB access in hfs/hfsplus.

* Only create /proc/fs/netfs when CONFIG_PROC_FS is set.

* Fix getname_flags() to initialize pointer correctly.

* Convert dentry flags to enum.

* Don't allow datadir without lowerdir in overlayfs.

* Use namespace_{lock,unlock} helpers in dissolve_on_fput() instead of
  plain namespace_sem so unmounted mounts are properly cleaned up.

* Skip unnecessary ifs_block_is_uptodate check in iomap.

* Remove an unused forward declaration in overlayfs.

* Fix devpts uid/gid handling after converting to the new mount api.

* Fix afs_dynroot_readdir() to not use the RCU read lock.

* Fix mount_setattr() and open_tree_attr() to not pointlessly do path
  lookup or walk the mount tree if no mount option change has been
  requested.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc3.fixes

for you to fetch changes up to e2aef868a8c39f411eb7bcee3c42e165a21d5cd6:

  Merge tag 'ovl-fixes-6.15-rc2' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs (2025-04-11 16:41:48 +0200)

Please consider pulling these changes from the signed vfs-6.15-rc3.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.15-rc3.fixes

----------------------------------------------------------------
Christian Brauner (2):
      mount: ensure we don't pointlessly walk the mount tree
      Merge tag 'ovl-fixes-6.15-rc2' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs

David Howells (2):
      devpts: Fix type for uid and gid params
      afs: Fix afs_dynroot_readdir() to not use the RCU read lock

Giuseppe Scrivano (1):
      ovl: remove unused forward declaration

Gou Hao (1):
      iomap: skip unnecessary ifs_block_is_uptodate check

Jan Stancek (1):
      fs: use namespace_{lock,unlock} in dissolve_on_fput()

Miklos Szeredi (1):
      ovl: don't allow datadir only

Omar Sandoval (1):
      dcache: convert dentry flag macros to enum

Song Liu (2):
      netfs: Only create /proc/fs/netfs with CONFIG_PROC_FS
      fs: Fix filename init after recent refactoring

Vasiliy Kovalev (1):
      hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key

Xiangsheng Hou (1):
      virtiofs: add filesystem context source name check

 fs/afs/dynroot.c         |   4 +-
 fs/devpts/inode.c        |   4 +-
 fs/fuse/virtio_fs.c      |   3 ++
 fs/hfs/bnode.c           |   6 +++
 fs/hfsplus/bnode.c       |   6 +++
 fs/iomap/buffered-io.c   |   2 +-
 fs/namei.c               |   8 ++--
 fs/namespace.c           |  34 +++++++++------
 fs/netfs/main.c          |   4 ++
 fs/overlayfs/overlayfs.h |   2 -
 fs/overlayfs/super.c     |   5 +++
 include/linux/dcache.h   | 106 ++++++++++++++++++++++-------------------------
 12 files changed, 104 insertions(+), 80 deletions(-)

