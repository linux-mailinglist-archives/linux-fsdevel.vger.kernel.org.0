Return-Path: <linux-fsdevel+bounces-32469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F18A9A66F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 13:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8E0282082
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 11:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6775E1E8841;
	Mon, 21 Oct 2024 11:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHe7aUFA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC46C1E5736;
	Mon, 21 Oct 2024 11:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729511250; cv=none; b=g7UH0q3zeNYItqRxFeL56CZwD2V8HGg86XFd1tLbat3a2h8PbVRUUo8v3cGWGnjqI4JmZB/LtK9cWW/BpD8VQaUBq5mfWam3NiTO+LTItJKtSaX1QmXP9tTe5uYynlCCPNaN55+MSHRKK7BqXET+Yt/KmwN7pNCTWxpPB2roCOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729511250; c=relaxed/simple;
	bh=nMG14ljairMQ6TFWydbsEggIuMYy4yOyd86W9fI7e0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cjS7BgOA8P5Z/tpfRr07cVmv2k5IzDIFUsLV7kBN3Oh8c/gV5d/4chBQ7z0ue80/o0ysLOYRozPFC0biUgla55aqEu0pg1ToQOkn4wqcCo1kH8UP4nbrMnoQLS8zKjpVXalKdX/cNI2Oykola3ASSIyDdfhe43953my3fTlfJag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHe7aUFA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E069C4CEC7;
	Mon, 21 Oct 2024 11:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729511250;
	bh=nMG14ljairMQ6TFWydbsEggIuMYy4yOyd86W9fI7e0U=;
	h=From:To:Cc:Subject:Date:From;
	b=VHe7aUFASKC9aCwAtEcbmXwKSdjjN/D5B7OqW10rod0OCD+dI2N/X1V90o7qPAX/o
	 fPkfFeGXM69iCVhI4GC2ekYxyGmXXX9zRe8YGJWEz6oC2nVLVOrRCgdQMiUhVLcRW3
	 oDeyWsqQ+d4L2USsMPFlRvcHHzM8ldSHTcZiaVd+tm2otsP7SF8JLiMqXMpL+hpyjh
	 SvrBgnVafO3Xrw/dL1jN81rm9os7BH++27b2J4Bix/lwa+fNRyzJ7eDwObgQnLCGOd
	 s1UOHnNuig5UDl+JtdlLLjcx1g4DxCNtQhvxA/3BYcupzFenpCBV6Fp2IadOYNxbse
	 lQ9xabN7ptZxA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Mon, 21 Oct 2024 13:46:37 +0200
Message-ID: <20241021-vfs-fixes-cf708029ec67@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3343; i=brauner@kernel.org; h=from:subject:message-id; bh=nMG14ljairMQ6TFWydbsEggIuMYy4yOyd86W9fI7e0U=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSL2Xs53jzrtmqu/26JYqtQNR8ZdR0phlOnPN0KOhMbv ltWHZ3XUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJHCHQy/mHfPyTGa46pvcHvK lNt7Wo0nGdnuUK9nf23Z56ctKfP0GcNfuQ5DK/mMAzYH7OUOZOxbwKEYdEJ8wtTNknNPcQlf1Pd jBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains a few fixes:

afs:

- Fix a lock recursion in afs_wake_up_async_call() on ->notify_lock.

netfs:

- Drop the references to a folio immediately after the folio has been
  extracted to prevent races with future I/O collection.

- Fix a documenation build error.

- Downgrade the i_rwsem for buffered writes to fix a cifs reported
  performance regression when switching to netfslib.

vfs:

- Explicitly return -E2BIG from openat2() if the specified size is
  unexpectedly large. This aligns openat2() with other extensible struct
  based system calls.

- When copying a mount namespace ensure that we only try to remove the
  new copy from the mount namespace rbtree if it has already been added
  to it.

nilfs:

- Clear the buffer delay flag when clearing the buffer state clags when
  a buffer head is discarded to prevent a kernel OOPs.

ocfs2:

- Fix an unitialized value warning in ocfs2_setattr().

proc:

- Fix a kernel doc warning.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-3)
Debian clang version 16.0.6 (27+b1)

All patches are based on v6.11-rc2 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

No known conflicts.

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12-rc5.fixes

for you to fetch changes up to 197231da7f6a2e9884f84a4a463f53f9f491d920:

  proc: Fix W=1 build kernel-doc warning (2024-10-18 13:02:47 +0200)

Please consider pulling these changes from the signed vfs-6.12-rc5.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.12-rc5.fixes

----------------------------------------------------------------
Aleksa Sarai (1):
      openat2: explicitly return -E2BIG for (usize > PAGE_SIZE)

Alessandro Zanni (1):
      fs: Fix uninitialized value issue in from_kuid and from_kgid

Christian Brauner (1):
      fs: don't try and remove empty rbtree node

David Howells (3):
      netfs: In readahead, put the folio refs as soon extracted
      netfs: Downgrade i_rwsem for a buffered write
      afs: Fix lock recursion

Jonathan Corbet (1):
      netfs: fix documentation build error

Ryusuke Konishi (1):
      nilfs2: fix kernel bug due to missing clearing of buffer delay flag

Thorsten Blum (1):
      proc: Fix W=1 build kernel-doc warning

 Documentation/filesystems/netfs_library.rst |  1 -
 fs/afs/internal.h                           |  2 +
 fs/afs/rxrpc.c                              | 83 ++++++++++++++++++++---------
 fs/namespace.c                              |  4 +-
 fs/netfs/buffered_read.c                    | 47 +++++-----------
 fs/netfs/locking.c                          |  3 +-
 fs/netfs/read_collect.c                     |  2 +
 fs/nilfs2/page.c                            |  6 ++-
 fs/ocfs2/file.c                             |  9 ++--
 fs/open.c                                   |  2 +
 fs/proc/fd.c                                |  2 +-
 include/trace/events/netfs.h                |  1 -
 12 files changed, 95 insertions(+), 67 deletions(-)

