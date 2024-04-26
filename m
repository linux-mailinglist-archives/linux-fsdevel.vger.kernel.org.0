Return-Path: <linux-fsdevel+bounces-17906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064F78B3A7B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 16:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A71E1C20E4D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 14:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F0814885A;
	Fri, 26 Apr 2024 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQt5VTpP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30362E639;
	Fri, 26 Apr 2024 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714143580; cv=none; b=hxlvMnz7Hy5YNRF6APpqEtrMXgdaJMkwOCHIgvff4jDcRAcV95h+KwofAncOX7ZnKd6ftkBxgNx27kHijU2zu+pxPF9lvAI8yDLd/3nKK4XL3Fjwy4XK/bawuba2/dCoDbvx3yzTfIz1xQ0jIZxAHnRUes+FR0i4q+UbwcV/lzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714143580; c=relaxed/simple;
	bh=8sTdnzFkV/UWVm3qk79tjYUivdn/wHW1DtbpmUNARIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KAlW1Vo3RYALh/+Kj921biwQE+v9d0/GtNRegKmkgufmJm7SRTRXKMjYhesyt58yIMtb+7IFuzTLWNH3Q5eMuV0qDdXreybe9jeqtBddcKPfw+zz+WLDrab+g4tL7q1joLe6QTIpMdmobfPUzcNWNVKvXXOOa6OWxcNz9eAJtY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQt5VTpP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9BFC113CD;
	Fri, 26 Apr 2024 14:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714143580;
	bh=8sTdnzFkV/UWVm3qk79tjYUivdn/wHW1DtbpmUNARIo=;
	h=From:To:Cc:Subject:Date:From;
	b=jQt5VTpPsVrPGuGuX9i2Z8ZK9TiOWI6suA8uiqjSR4bcRLz7QgEatzXAKMOW4bDlF
	 1aOK250ag+vxhe/+Ad8nHXXzu4Bh9Gk8I6w+FpD+kCSMOSLQpP6UGmQGoyRCa9w0FY
	 Eyx5r8i/OONqd42XPGwXZPx9V4Cr99FA+xaW/vmpMIXPWksaO2g9YyN/NYUUtG/9rL
	 AlYAUDq3QOC4DtQFVouW8BZtTUveGT3QumPZHkSjn+CbPEnWqY7JctUxsGr3V556j7
	 NOM2jAF8DBj/P5ayocZ8u3ZVKpXOH95IQZCdbQdlzACULtGdPRHyC34kM4Jy+AtG0G
	 CtPm6pTrlMvfQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Fri, 26 Apr 2024 16:59:29 +0200
Message-ID: <20240426-vfs-fixes-20b3a0dd3821@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3008; i=brauner@kernel.org; h=from:subject:message-id; bh=8sTdnzFkV/UWVm3qk79tjYUivdn/wHW1DtbpmUNARIo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRpHwyeWnPTQV9w8aR32//1rljsV2KTF/5XetP3j998P kpWs7wO7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI4y2G/wFz5/peZCtw2X5L jLF5ZaTAFoaWhAzVl49ePZZomqKZc52RYcvc0M/fe7qMxGWnSKQ1eBs+qG640es9bx9XK0fsipl tPAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains a few small fixes for this merge window and the attempt to handle
the ntfs removal regression that was reported a little while ago:

* After the removal of the legacy ntfs driver we received reports about
  regressions for some people that do mount "ntfs" explicitly and expect the
  driver to be available. Since ntfs3 is a drop-in for legacy ntfs we alias
  legacy ntfs to ntfs3 just like ext3 is aliased to ext4.

  We also enforce legacy ntfs is always mounted read-only and give it custom
  file operations to ensure that ioctl()'s can't be abused to perform write
  operations.

* Fix an unbalanced module_get() in bdev_open().

* Two smaller fixes for the netfs work done earlier in this cycle.

* Fix the errno returned from the new FS_IOC_GETUUID and FS_IOC_GETFSSYSFSPATH
  ioctls. Both commands just pull information out of the superblock so there's
  no need to call into the actual ioctl handlers.

  So instead of returning ENOIOCTLCMD to indicate to fallback we just return
  ENOTTY directly avoiding that indirection.

/* Testing */
clang: Debian clang version 16.0.6 (19)
gcc: (Debian 13.2.0-7) 13.2.0

All patches are based on v6.9-rc3. No build failures or warnings were observed.

/* Conflicts */
No known conflicts.

The following changes since commit fec50db7033ea478773b159e0e2efb135270e3b7:

  Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.9-rc6.fixes

for you to fetch changes up to c97f59e276d4e93480f29a70accbd0d7273cf3f5:

  netfs: Fix the pre-flush when appending to a file in writethrough mode (2024-04-26 14:56:18 +0200)

Please consider pulling these changes from the signed vfs-6.9-rc6.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.9-rc6.fixes

----------------------------------------------------------------
Christian Brauner (3):
      ntfs3: serve as alias for the legacy ntfs driver
      ntfs3: enforce read-only when used as legacy ntfs driver
      ntfs3: add legacy ntfs file operations

David Howells (2):
      netfs: Fix writethrough-mode error handling
      netfs: Fix the pre-flush when appending to a file in writethrough mode

Günther Noack (1):
      fs: Return ENOTTY directly if FS_IOC_GETUUID or FS_IOC_GETFSSYSFSPATH fail

Yu Kuai (1):
      block: fix module reference leakage from bdev_open_by_dev error path

 block/bdev.c              |  2 +-
 fs/ioctl.c                |  4 +--
 fs/netfs/buffered_write.c | 23 +++++++++--------
 fs/ntfs3/Kconfig          |  9 +++++++
 fs/ntfs3/dir.c            |  7 +++++
 fs/ntfs3/file.c           |  8 ++++++
 fs/ntfs3/inode.c          | 20 ++++++++++++---
 fs/ntfs3/ntfs_fs.h        |  4 +++
 fs/ntfs3/super.c          | 65 ++++++++++++++++++++++++++++++++++++++++++++---
 9 files changed, 121 insertions(+), 21 deletions(-)

