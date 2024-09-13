Return-Path: <linux-fsdevel+bounces-29335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 570C49782D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 16:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D86D1F230BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 14:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6463D1DFDE;
	Fri, 13 Sep 2024 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZYXMB2V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C352E8F47;
	Fri, 13 Sep 2024 14:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726238683; cv=none; b=Pz0gDROgcpO6BZDFhMmHrzvwFmriMoSGwZL2Lrsc/E6f6rAKBtU1x6i8NsVtwL2GXxUB7e3iy64CApihdqG4401vCLy2QDAu41KNqcBMEJPl/lzJ/s+E9PUQc+rCsQfNXMpVVJnhBGrwcvPhR1qIx9sKpRpGUS9INOlw/zMwGTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726238683; c=relaxed/simple;
	bh=dbhC+Po6jXUp4ueqs57Yxhruw4p/WiDzZR9CQjKXaNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QNBWfVFcYOfkd9i72aSSdYoVU/Lo3jhC8zRhOi4u02R5h8619ou6K6Ap7FM8VLq5rkdGYUwJ8o7jqCotxkSwFvySgCGBQLZVvNyfRYr721GAUu6NTdks+/bthTVUbvtNFdGvpbhkd9YuQfQzsid63/ejbYvSU0FiLk5Ai7L9Fw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZYXMB2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DB0C4CEC0;
	Fri, 13 Sep 2024 14:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726238683;
	bh=dbhC+Po6jXUp4ueqs57Yxhruw4p/WiDzZR9CQjKXaNY=;
	h=From:To:Cc:Subject:Date:From;
	b=bZYXMB2V5CsMoRh3gVcDc5XvdpJDR2m/sUjRHJGL9PcZPT7ZrRD0VBOJl0Acn+DYQ
	 oyZh0FHwQp+p+NhQMIQY8fsVXW+Ejg5bXnmC6goOZK1fkdKJTBZSusq3NyaJ8dRzH2
	 4MiBe7Ee7Yn62/V7oS6TWuDXX6XYH5px05ML9OwN/Wx0b3+teu1zaDPNYzr0Vq/SKO
	 KFkxFkCH0CMKRSHck7NRS7ML/KCBMu8hlYHBQ+BwmWLreWODQ92eWv6jiffu+MXTDF
	 XEsf3WLGOZbmKIxG/t7Bg1vUAJfi2s8ekjlhQbsIUm9wMNFmWn2yKtIMwEIlnkXujf
	 cfYP1DB/xbL/A==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fallocate
Date: Fri, 13 Sep 2024 16:44:09 +0200
Message-ID: <20240913-vfs-fallocate-34e5962f7372@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2280; i=brauner@kernel.org; h=from:subject:message-id; bh=dbhC+Po6jXUp4ueqs57Yxhruw4p/WiDzZR9CQjKXaNY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ98T9fz3C0ZkMI3+75OaZlJppmAfavK3YwOP7c81r6+ 6QuERnpjhIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlYrGP4nrF1q0X2DpUpd2cy ar67USy0alLHg9BtiRsnHre+Usewi5FhRubGZPYD09Sl35Xx/dkv5OTYuCS0d5rG/TMLH3wu+9P HDgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains work to try and cleanup some the fallocate mode handling.
Currently, it confusingly mixes operation modes and an optional flag.
The work here tries to better define operation modes and optional flags
allowing the core and filesystem code to use switch statements to switch
on the operation mode.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-3)
Debian clang version 16.0.6 (27+b1)

All patches are based on v6.11-rc4 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208399:

  Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12.fallocate

for you to fetch changes up to 7fbabbb4ae2a7203861e4db363e3c861a4df260e:

  Merge patch series "Subject: sort out the fallocate mode mess" (2024-08-28 16:54:05 +0200)

Please consider pulling these changes from the signed vfs-6.12.fallocate tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.12.fallocate

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "Sort out the fallocate mode mess"

Christoph Hellwig (6):
      block: remove checks for FALLOC_FL_NO_HIDE_STALE
      ext4: remove tracing for FALLOC_FL_NO_HIDE_STALE
      fs: sort out the fallocate mode vs flag mess
      xfs: call xfs_flush_unmap_range from xfs_free_file_space
      xfs: move the xfs_is_always_cow_inode check into xfs_alloc_file_space
      xfs: refactor xfs_file_fallocate

 block/fops.c                |  10 +-
 fs/open.c                   |  51 ++++---
 fs/xfs/xfs_bmap_util.c      |  11 ++
 fs/xfs/xfs_file.c           | 353 ++++++++++++++++++++++++++------------------
 include/linux/falloc.h      |  18 ++-
 include/trace/events/ext4.h |   1 -
 include/uapi/linux/falloc.h |   1 +
 7 files changed, 258 insertions(+), 187 deletions(-)

