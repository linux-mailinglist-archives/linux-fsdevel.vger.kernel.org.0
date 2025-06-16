Return-Path: <linux-fsdevel+bounces-51717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71120ADAA8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 10:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20A4F3A7DD4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 08:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C4026D4C1;
	Mon, 16 Jun 2025 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/qbE3Iq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C95C2C1A2;
	Mon, 16 Jun 2025 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750062035; cv=none; b=ZsX9wY9d09xqw3VHb6DELGab0CgUEe5NcAxxo2QAeKrwMcbuwaeSKFj0zwt4vacZzt1tqD9ZANd1diZFsj7v0hdJixA0UxX8z6GEwCehQIPe4WxNfmrCx4rh2zKYlUuVzu7O9TO4bajRERwZukQgaaIH1jR6wPhOfVmofiwBhCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750062035; c=relaxed/simple;
	bh=MYRmGlLoIXrin3wWq4OyK6li1uInLcEiJ2ttFcjN3so=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dl0Mg/oJfFek2hBXid9hoHjocFaQAJStrXd+QzSqaxxXWae04v69VQgTSDfNvUMtZRwTsgJeps54f1O2CUGelmkMYDgCzZnDEcHJ41CBJNMMLXN3Pvb2w1DaJsRGVfLvvNNh6PHTbLMB50eTnFZes3gFW8uqn/KOeu/tiCGoAdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/qbE3Iq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAC9C4CEEA;
	Mon, 16 Jun 2025 08:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750062034;
	bh=MYRmGlLoIXrin3wWq4OyK6li1uInLcEiJ2ttFcjN3so=;
	h=From:To:Cc:Subject:Date:From;
	b=d/qbE3IqQ6tOPl10gfb3wrpX00JJJhAkMDf1j/TzMUFrL2qqmfc7duSM81IO1DMd+
	 P6WuSfhmxHuVmKBLi1qWo5I+K2svA5o0r/rQirlK95/lDzkm8qHNuHhV15GnYtqhqO
	 ephWufSuw+UUK9+fFlZfF0MVA6YNvXpcJzGs7NZq2G9TZTz1g1HkKBzTHdWDsMLUXp
	 iEVZmxEjrzk9vlPlUkTv5ZSvvSZWpbJjIoCSLhraVhu1kwa5umO4SDcSFMzU9o9Hrr
	 extJmQSeop838Rzxu1q6sBXaJGCeN2FWH/dYJ8y84keQIP0X+sw67jQ/u+6Ehjcn8q
	 24ueyodq/HsKA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Mon, 16 Jun 2025 10:20:20 +0200
Message-ID: <20250616-vfs-fixes-c7cd6114f3de@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2996; i=brauner@kernel.org; h=from:subject:message-id; bh=MYRmGlLoIXrin3wWq4OyK6li1uInLcEiJ2ttFcjN3so=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT4Xz5p+zLxGafQnu//17gp/jJ9nSiU9YRF+9ByFYbED etKDRb+7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhILSMjwyX52ZtmH2IpsDFN 1bg5f/vnG2cUn1osXum1s/X+qycr25kZGXo4nj6837N38d7v/CtFXnCfstu3XVc2j5vjxOXV0xc LBHEDAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains another round of fixes for this cycle:

- Fix a regression in overlayfs caused by reworking the lookup_one*()
  set of helpers.

- Make sure that the name of the dentry is printed in
  overlayfs' mkdir() helper.

- Add missing iocb values to TRACE_IOCB_STRINGS define.

- Unlock the superblock during iterate_supers_type().
  This was an accidental internal api change.

- Drop a misleading assert in file_seek_cur_needs_f_lock() helper.

- Never refuse to return PIDFD_GET_INGO when parent pid is zero.
  That can trivially happen in container scenarios where the parent
  process might be located in an ancestor pid namespace.

- Don't revalidate in try_lookup_noperm() as that causes regression for
  filesystems such as cifs.

- Fix simple_xattr_list() and reset the err variable after
  security_inode_listsecurity() got called so as not to confuse
  userspace about the length of the xattr.

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

The following changes since commit 5abc7438f1e9d62e91ad775cc83c9594c48d2282:

  Merge tag 'nfs-for-6.16-1' of git://git.linux-nfs.org/projects/anna/linux-nfs (2025-06-03 16:13:32 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc3.fixes

for you to fetch changes up to dd2d6b7f6f519d078a866a36a625b0297d81c5bc:

  fs: drop assert in file_seek_cur_needs_f_lock (2025-06-16 09:59:24 +0200)

Please consider pulling these changes from the signed vfs-6.16-rc3.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.16-rc3.fixes

----------------------------------------------------------------
Amir Goldstein (2):
      ovl: fix regression caused by lookup helpers API changes
      ovl: fix debug print in case of mkdir error

Christoph Hellwig (1):
      fs: add missing values to TRACE_IOCB_STRINGS

Darrick J. Wong (1):
      fs: unlock the superblock during iterate_supers_type

Luis Henriques (1):
      fs: drop assert in file_seek_cur_needs_f_lock

Mike Yuan (1):
      pidfs: never refuse ppid == 0 in PIDFD_GET_INFO

NeilBrown (1):
      VFS: change try_lookup_noperm() to skip revalidation

Stephen Smalley (1):
      fs/xattr.c: fix simple_xattr_list()

 fs/file.c                |  8 ++++++--
 fs/namei.c               | 17 +++++++++++++----
 fs/overlayfs/namei.c     | 10 ++++++++--
 fs/overlayfs/overlayfs.h |  8 +++++---
 fs/pidfs.c               |  2 +-
 fs/super.c               |  4 +++-
 fs/xattr.c               |  1 +
 include/linux/fs.h       |  4 +++-
 8 files changed, 40 insertions(+), 14 deletions(-)

