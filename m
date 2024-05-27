Return-Path: <linux-fsdevel+bounces-20228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C708CFF72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 13:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C8A7B21C61
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 11:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B801215DBC1;
	Mon, 27 May 2024 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p87k6Xro"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECB313AA31;
	Mon, 27 May 2024 11:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810986; cv=none; b=kGa+yhOlZXkYEPa/0RBjxYraZ2GCMvcP5guPeTW3Nw/PbK9Pa1y3pFoaHxeMyFllx0Ps+4C+0Gbat+BdKAdn+oEnsOhhNgy0m7BnfEi6PAgobK9ZmiBHgmBwL9Gdw4Rv8vwH9RBLRKGVwoNWmNMSftjmw89fJTHjNJ5IkT7+gM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810986; c=relaxed/simple;
	bh=DEckiRwCpgziP0P5S6eFtBf5HVE5oC96zcHHkjDlBpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tR7QwZScSbvzw06KGGnNCFrtPxPTZDmbpH0Nt8pj7WP6P+4DCIig9SoGjPqegChLlwm9z51QgIilBE+sqcVW6gtezaEuBMfoYqN5LYfKGneQWxayFVw6s2f36FwY1UEzpqYEK4zu2WcJhzS3PWtkqgJmpDsBpFggmsjGWVvzdfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p87k6Xro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB89C2BBFC;
	Mon, 27 May 2024 11:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716810985;
	bh=DEckiRwCpgziP0P5S6eFtBf5HVE5oC96zcHHkjDlBpY=;
	h=From:To:Cc:Subject:Date:From;
	b=p87k6XroMqATDsUBvJyUqe9q5lavadM/gv1KHuYzxpMfiUkGCe8jSrkO56TiVtXMH
	 ZJ6KUkXLl9hVz2/xzrPLirHk7IfDWZnGbCaZZ8kvB8KUfDw5j+VIl+g0CyE8a0vLk5
	 ZPvAo2fiVb7MV9cR8hYrcM1Qm77UMKbO8vAJ/tdg8IfN9vcDUGuiFC10ZVA139be+U
	 5mjx0nMrVZl0pW1HZS3hpihNooBpeiN5TRbgFeUxANxOKsxyY23Ej1Xv67XJYG6vp/
	 p/w28ym6kLVKIwOde7ZyQOMTXciQkmIx6YZJWssG69RRzPCAkGmpAsqMJUV31lxT5l
	 OeXtGPugeBzPg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Mon, 27 May 2024 13:55:56 +0200
Message-ID: <20240527-vfs-fixes-96860426ed27@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3021; i=brauner@kernel.org; h=from:subject:message-id; bh=DEckiRwCpgziP0P5S6eFtBf5HVE5oC96zcHHkjDlBpY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSFlJwPvfXEoezmieigy2xbxXrc332x31mft05U3oP9r ZHnUpeNHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO5dI3hD9dZkbx3E+/smhly 2PHn33lfz4QUXPmtWD1h/yJlxVkWXpUM/7Qcptu6L3r/XCZxl926sE8zXi0tXT/1t83s/Mk7nj9 ynswGAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains a few small fixes for this merge window:

* Fix io_uring based write-through after converting cifs to use the netfs
  library.
* Fix aio error handling when doing write-through via netfs library.
* Fix performance regression in iomap when used with non-large folio mappings.
* Fix signalfd error code.
* Remove obsolete comment in signalfd code.
* Fix async request indication in netfs_perform_write() by raising BDP_ASYNC
  when IOCB_NOWAIT is set.
* Yield swap device immediately to prevent spurious EBUSY errors.
* Don't cross a .backup mountpoint from backup volumes in afs to avoid infinite
  loops.
* Fix a race between umount and async request completion in 9p after 9p was
  converted to use the netfs library.

/* Testing */
clang: Debian clang version 16.0.6 (27)
gcc: (Debian 13.2.0-25) 13.2.0

All patches are based on mainline. No build failures or warnings were observed.

/* Conflicts */
No known conflicts.

The following changes since commit 8f6a15f095a63a83b096d9b29aaff4f0fbe6f6e6:

  Merge tag 'cocci-for-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/jlawall/linux (2024-05-20 16:00:04 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.10-rc2.fixes

for you to fetch changes up to f89ea63f1c65d3e93b255f14f9d9e05df87955fa:

  netfs, 9p: Fix race between umount and async request completion (2024-05-27 13:12:13 +0200)

Please consider pulling these changes from the signed vfs-6.10-rc2.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.10-rc2.fixes

----------------------------------------------------------------
Christian Brauner (1):
      swap: yield device immediately

David Howells (4):
      netfs: Fix io_uring based write-through
      netfs: Fix AIO error handling when doing write-through
      netfs: Fix setting of BDP_ASYNC from iocb flags
      netfs, 9p: Fix race between umount and async request completion

Fedor Pchelkin (2):
      signalfd: fix error return code
      signalfd: drop an obsolete comment

Marc Dionne (1):
      afs: Don't cross .backup mountpoint from backup volume

Xu Yang (2):
      filemap: add helper mapping_max_folio_size()
      iomap: fault in smaller chunks for non-large folio mappings

 fs/9p/vfs_inode.c         |  1 +
 fs/afs/inode.c            |  1 +
 fs/afs/mntpt.c            |  5 +++++
 fs/iomap/buffered-io.c    |  2 +-
 fs/netfs/buffered_write.c |  2 +-
 fs/netfs/direct_write.c   |  2 +-
 fs/netfs/objects.c        |  5 +++++
 fs/netfs/write_collect.c  |  7 ++++---
 fs/netfs/write_issue.c    |  9 +++++++--
 fs/signalfd.c             |  6 +-----
 fs/smb/client/cifsfs.c    |  1 +
 include/linux/netfs.h     | 18 ++++++++++++++++++
 include/linux/pagemap.h   | 34 +++++++++++++++++++++-------------
 kernel/power/swap.c       |  2 +-
 14 files changed, 68 insertions(+), 27 deletions(-)

