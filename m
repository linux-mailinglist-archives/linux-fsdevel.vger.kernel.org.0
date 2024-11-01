Return-Path: <linux-fsdevel+bounces-33462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C386C9B913C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 13:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E5201F22AC2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 12:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95AB19E99E;
	Fri,  1 Nov 2024 12:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTQ108ki"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E51D19E7F7;
	Fri,  1 Nov 2024 12:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730465010; cv=none; b=mnSpeoy2tNy3ptWdi/thXTCA9B6VVAvOJDGnhHwp9zUR3z5cETj+x1QWWyjJLZGb8cuIyi2yz0shUux7P8i7TVBitkSdLYaAlOnZ5s3L7katy8tL762Gs2e2taNCQZ7EgR8zSYEu4fK/M4Uewpcj8iz59nVnCbFyphVDweVATXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730465010; c=relaxed/simple;
	bh=uPlh3P5DwiTFnDljux1ea+i8bOrJ1psZxB9V4LleEII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kGh1zURWoTWR6z5LhN60HveS+DaSCRou9kl7XK51NyoX6ke0ubsEyRJ+D0PUVcwm+nZ3mGtWQJOl0l5Arz2S0YWKsvTbb/54Dbcei/DzRJcp9cdXmdrEFfRtHysKXlIi0i6/l2SaQk6eSCLl1TLCQ4z550GK9hC3XUSXQ3C3qM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTQ108ki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7D6C4CECE;
	Fri,  1 Nov 2024 12:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730465009;
	bh=uPlh3P5DwiTFnDljux1ea+i8bOrJ1psZxB9V4LleEII=;
	h=From:To:Cc:Subject:Date:From;
	b=hTQ108kikP8x12oxffI82zsXg6c0NtrMDkTtRGBM0jxRogs7+aF07hGH+m265vkOa
	 HqqNZsqrxra6Tpo8i4YfWRJIMShllKx/0xQ8LuaY2L+FQEjwLwaVBWIlTdjCa2G0P9
	 sfYWbv/X0Bo1lirL5OBx3l+s4EgOQfnrTJYEcWXV+YWTJUmo7ueVFIeYuNiNg0ujlY
	 wCA+a5EUradafD2LLizEeHm2b8KGOAY2LCQd/wY2OSDUE8n6a3Xdu7Z8LXUKdCDIOQ
	 C2JLm2qOt5mCvFAckwp0jSGH0GVyNCmtklkSm6sPeAQEF5W9HD5ZIiHfKyCz/1hUxY
	 j9oeDHvK1j2lg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Fri,  1 Nov 2024 13:43:21 +0100
Message-ID: <20241101-vfs-fixes-11d83463b3ce@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3217; i=brauner@kernel.org; h=from:subject:message-id; bh=uPlh3P5DwiTFnDljux1ea+i8bOrJ1psZxB9V4LleEII=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSrnHm1M1nJyVh8RcjJi9Fu7z70FEhfY/lzVEt7ncWES Nfc+WtdO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbysZXhn/nkAC8FC4G2thnH zx9kUng7VfO/T/JvC16DS9+3lZUmPmZkaPV0essRydZooRw+oUdMqFM7a7XEg69/tdYbXRRp1Xj MBAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains a few fixes:

VFS:

- Fix copy_page_from_iter_atomic() if KMAP_LOCAL_FORCE_MAP=y is set.

- Add a get_tree_bdev_flags() helper that allows to modify e.g., whether
  errors are logged into the filesystem context during superblock
  creation. This is used by erofs to fix a userspace regression where an
  error is currently logged when its used on a regular file which is an
  new allowed mode in erofs.

netfs:

- Fix the sysfs debug path in the documentation.

- Fix iov_iter_get_pages*() for folio queues by skipping the page
  extracation if we're at the end of a folio.

afs:

- Fix moving subdirectories to different parent directory.

autofs:

- Fix handling of AUTOFS_DEV_IOCTL_TIMEOUT_CMD ioctl in
  validate_dev_ioctl(). The actual ioctl number, not the ioctl command
  needs to be checked for autofs.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-3)
Debian clang version 16.0.6 (27+b1)

All patches are based on v6.11-rc4 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

No known conflicts.

The following changes since commit 42f7652d3eb527d03665b09edac47f85fb600924:

  Linux 6.12-rc4 (2024-10-20 15:19:38 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12-rc6.fixes

for you to fetch changes up to c749d9b7ebbc5716af7a95f7768634b30d9446ec:

  iov_iter: fix copy_page_from_iter_atomic() if KMAP_LOCAL_FORCE_MAP (2024-10-28 13:39:35 +0100)

(Note, I'm still not fully recovered so currently with a little reduced
 activity.)
Please consider pulling these changes from the signed vfs-6.12-rc6.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.12-rc6.fixes

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "fs/super.c: introduce get_tree_bdev_flags()"

David Howells (2):
      afs: Fix missing subdir edit when renamed between parent dirs
      iov_iter: Fix iov_iter_get_pages*() for folio_queue

Gao Xiang (2):
      fs/super.c: introduce get_tree_bdev_flags()
      erofs: use get_tree_bdev_flags() to avoid misleading messages

Hongbo Li (1):
      doc: correcting the debug path for cachefiles

Hugh Dickins (1):
      iov_iter: fix copy_page_from_iter_atomic() if KMAP_LOCAL_FORCE_MAP

Ian Kent (1):
      autofs: fix thinko in validate_dev_ioctl()

 Documentation/filesystems/caching/cachefiles.rst |  2 +-
 fs/afs/dir.c                                     | 25 +++++++
 fs/afs/dir_edit.c                                | 91 +++++++++++++++++++++++-
 fs/afs/internal.h                                |  2 +
 fs/autofs/dev-ioctl.c                            |  5 +-
 fs/erofs/super.c                                 |  4 +-
 fs/super.c                                       | 26 +++++--
 include/linux/fs_context.h                       |  6 ++
 include/trace/events/afs.h                       |  7 +-
 lib/iov_iter.c                                   | 25 ++++---
 10 files changed, 169 insertions(+), 24 deletions(-)

