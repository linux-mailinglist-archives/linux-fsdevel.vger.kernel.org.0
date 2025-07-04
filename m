Return-Path: <linux-fsdevel+bounces-53904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE629AF8C4F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 10:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B5055614D4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 08:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24C629AB1B;
	Fri,  4 Jul 2025 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2wesZs1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5826D2882AD;
	Fri,  4 Jul 2025 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751618247; cv=none; b=JgDOXDB93/hW7sFKfHyQ2QhnLwkRbCpiox45fgtvy1jebbaV6zpXbVLrT+8oy3ElBirqKLRHnaAshjyPCLRhS3A27BMq1sThXJ91y147Qfkqa3a4vQAqdQR3yvmGsCOUyYQ5dtwtb434PX96Faxc2cOzNkb0MqnJKGQtshOz0fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751618247; c=relaxed/simple;
	bh=UcVEdWsMgJuOK8h1XyR+xUtQH0ZdYigTqHJT3JO4cLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UrrvlnOq9GZe0rNGdDoUlU6t6I9u7+bNn4lVtG5uzRjjqS40BWkxP05l2Yuz4vhTLy0xPz1Dk85qjVi2kILNSuEoGvTKepPLZre/EbPwV0btQJGVVIp0E2WHOPTyBKCQLBZxh/f5m+XKG6sHON+Zk0Uusykgd9QGgedQYb+2Fm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2wesZs1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C92C4CEE3;
	Fri,  4 Jul 2025 08:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751618246;
	bh=UcVEdWsMgJuOK8h1XyR+xUtQH0ZdYigTqHJT3JO4cLI=;
	h=From:To:Cc:Subject:Date:From;
	b=E2wesZs1dzJfJhjcqoa+yxVE6YJwdff8Kl7u4D4xKDxHxJTyYik8cM8E6maaYmazt
	 71xJJs40ia567tw4hiZzgudx2ar+AnKUcaQfTh1j3Z/3koApKJ+w3LJjUyyrf54Xjd
	 S2l2gFyfUIaZoA5t/VsKevBpr8Z4S1Y8LH1jbPZxNma7kC67cT2MCR3F8dBXyB4VDj
	 bjuzWaooWWJgFTFNNtT8xgvbVrC3qzV1+kXioJSvpP4NMmVlwgcJchXz1XAksCJVDn
	 gO61DpHb71/SUp8EYljp/dUDkikroLLG6a8jxyXeNi7wimsUpthUNYMcUavFJIHqxa
	 trkC8qxIQkz0w==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Fri,  4 Jul 2025 10:36:54 +0200
Message-ID: <20250704-vfs-fixes-fa31f5ff8c05@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5415; i=brauner@kernel.org; h=from:subject:message-id; bh=UcVEdWsMgJuOK8h1XyR+xUtQH0ZdYigTqHJT3JO4cLI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSkT1rJy3RN6tvdy2f/i/yZfXXiqx/lgXyPuy5y/fCJS HfePjMhu6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiuxgY/lebhRoEJbuZ7g/Z Vm9rHHdxu4uKts66s6J89npWX6Vk9zAy3I2z/CsplSZwcvHfO54ajWYJMd0X+g62ZZ7ZZCy++kQ mPwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

This includes a fix for a priority inversion in eventpoll. I did
consider it a fix and it is a single commit but it is a bit more code
than we would usually let through after -rc2. If you want me to delay
that until the merge window that's perfectly fine. You can either just
revert right after merging this or I can send you a new pull request
tomorrow.

/* Summary */

This contains another round of fixes for this cycle:

- Fix a regression caused by the anonymous inode rework. Making them
  regular files causes various places in the kernel to tip over starting
  with io_uring. Revert to the former status quo and port our assertion
  to be based on checking the inode so we don't lose the valuable
  VFS_*_ON_*() assertions that have already helped discover weird
  behavior our outright bugs.

- Fix the the upper bound calculation in fuse_fill_write_pages().

- Fix priority inversion issues in the eventpoll code.

- Make secretmen use anon_inode_make_secure_inode() to avoid bypassing
  the LSM layer.

- Fix a netfs hang due to missing case in final DIO read result
  collection.

- Fix a double put of the netfs_io_request struct.

- Provide some helpers to abstract out NETFS_RREQ_IN_PROGRESS flag
  wrangling.

- Fix infinite looping in netfs_wait_for_pause/request().

- Fix a netfs ref leak on an extra subrequest inserted into a request's
  list of subreqs.

- Fix various cifs RPC callbacks to set NETFS_SREQ_NEED_RETRY if a
  subrequest fails retriably.

- Fix a cifs warning in the workqueue code when reconnecting a channel.

- Fix the updating of i_size in netfs to avoid a race between testing if
  we should have extended the file with a DIO write and changing i_size.

- Merge the places in netfs that update i_size on write.

- Fix coredump socket selftests.

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

The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc5.fixes

for you to fetch changes up to 1e7ab6f67824343ee3e96f100f0937c393749a8a:

  anon_inode: rework assertions (2025-07-02 14:41:39 +0200)

Please consider pulling these changes from the signed vfs-6.16-rc5.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.16-rc5.fixes

----------------------------------------------------------------
Christian Brauner (2):
      Merge patch series "netfs, cifs: Fixes to retry-related code"
      anon_inode: rework assertions

David Howells (9):
      netfs: Fix hang due to missing case in final DIO read result collection
      netfs: Fix double put of request
      netfs: Provide helpers to perform NETFS_RREQ_IN_PROGRESS flag wangling
      netfs: Fix looping in wait functions
      netfs: Fix ref leak on inserted extra subreq in write retry
      netfs: Fix i_size updating
      netfs: Merge i_size update functions
      netfs: Renumber the NETFS_RREQ_* flags to make traces easier to read
      netfs: Update tracepoints in a number of ways

Joanne Koong (1):
      fuse: fix fuse_fill_write_pages() upper bound calculation

Nam Cao (2):
      selftests/coredump: Fix "socket_detect_userspace_client" test failure
      eventpoll: Fix priority inversion problem

Paulo Alcantara (3):
      smb: client: set missing retry flag in smb2_writev_callback()
      smb: client: set missing retry flag in cifs_readv_callback()
      smb: client: set missing retry flag in cifs_writev_callback()

Shivank Garg (1):
      fs: export anon_inode_make_secure_inode() and fix secretmem LSM bypass

 fs/anon_inodes.c                                  |  23 +-
 fs/eventpoll.c                                    | 458 +++++++---------------
 fs/exec.c                                         |   9 +-
 fs/fuse/file.c                                    |   5 +-
 fs/libfs.c                                        |   8 +-
 fs/namei.c                                        |   2 +-
 fs/netfs/buffered_write.c                         |  38 +-
 fs/netfs/direct_write.c                           |  16 -
 fs/netfs/internal.h                               |  26 +-
 fs/netfs/main.c                                   |   6 +-
 fs/netfs/misc.c                                   |  50 ++-
 fs/netfs/read_collect.c                           |  16 +-
 fs/netfs/write_collect.c                          |  14 +-
 fs/netfs/write_retry.c                            |   3 +-
 fs/smb/client/cifssmb.c                           |  22 ++
 fs/smb/client/smb2pdu.c                           |  27 +-
 include/linux/fs.h                                |   2 +
 include/linux/netfs.h                             |  21 +-
 include/trace/events/netfs.h                      |  29 +-
 mm/secretmem.c                                    |   9 +-
 tools/testing/selftests/coredump/stackdump_test.c |   5 +
 21 files changed, 351 insertions(+), 438 deletions(-)

