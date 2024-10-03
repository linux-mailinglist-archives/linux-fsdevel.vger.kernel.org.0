Return-Path: <linux-fsdevel+bounces-30844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A28398EBF8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 11:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05CBD1F23981
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 09:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9191422C7;
	Thu,  3 Oct 2024 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUvhodXz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6897A45BE3;
	Thu,  3 Oct 2024 09:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727946039; cv=none; b=P+0+Pq1QhaNx9lQ9E5XaGWbcdThE3ULmdw2AGhhT/NgrfOeI+zKq8+4it0a+Ee0j7rVtHZMhqsuIX3ZdmcgMLCXEIMx1L9tROXvfj/GmPcinLaaK9R95mVNYnHLK/PTh6hUzSNURqATsXjif+yCjRRfcLcmhbYdVhy7At3tW60U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727946039; c=relaxed/simple;
	bh=oWnWVcbRYOqF6dqFeKKxm/8XQtTMj28eNVFxgPIxyqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CMe6144LbZud3s0W+9eSvA7CWUdkhbnNvOENyECnslQ9Yyvq5jhyr9T/qRoLgTW5O0A80lVOGnow+cNPvbmptYH4kb+watOpJ8sy3bBa6TUtQ4nFa2Z+ylQmknMmwyGT/GVVZz/utnJgHeXTXuMcpfod9KUZCCtYSV63EHt6U44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUvhodXz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DD8C4CEC7;
	Thu,  3 Oct 2024 09:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727946039;
	bh=oWnWVcbRYOqF6dqFeKKxm/8XQtTMj28eNVFxgPIxyqU=;
	h=From:To:Cc:Subject:Date:From;
	b=EUvhodXzHD9KZzNnGMsFdOUxDf1yYly10JF7Ronc3Ncf/p12Hfn+WE8bbUzvHfuwH
	 OSLNXt3bVYOaMzvkB531lbahpxPr4I3eR86AMiNvurH35HU+r7GRjJMC3U1mpBelko
	 naEMAq5zIBMA79UQYYAoy9J8EqhU228LFPbQUlLgLX1+NJs80zXbj3dQCUP0ieQe/z
	 8Jjfh1qWvCh5s/LIobEmTn8DcWINX/IYSFhyx3fV7HldkRzfjWF+Pa3ykD2DjMUwhn
	 eDhAk/Xoo4xpvHZGBVP14vJE7BJi2l6AfPtZJeHk4cdDffbjsaEKXSnVrKXKvVcNa0
	 x9xE5+n7mI3Iw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Thu,  3 Oct 2024 11:00:20 +0200
Message-ID: <20241003-vfs-fixes-86b826e78b57@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2600; i=brauner@kernel.org; h=from:subject:message-id; bh=oWnWVcbRYOqF6dqFeKKxm/8XQtTMj28eNVFxgPIxyqU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT9i1Xb0tm/SrThK/ezNivj1R0dL7X3KNp0PJtyrvjHr EttpSJ3O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSHM7I8KV7boXYyX0r0/Uc PVxnVDK51E5TNXTcOk1C/lJRyZQt5xkZDntneOUnzzujZvCM5dzFD2lL425dyea7fmeFwjrpcLd KDgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains fixes for this merge window:

vfs:

- Ensure that iter_folioq_get_pages() advances to the next slot otherwise it
  will end up using the same folio with an out-of-bound offset.

iomap:

- Dont unshare delalloc extents which can't be reflinked, and thus can't be shared.

- Constrain the file range passed to iomap_file_unshare() directly in iomap
  instead of requiring the callers to do it.

netfs:

- Use folioq_count instead of folioq_nr_slot to prevent an unitialized value
  warning in netfs_clear_buffer().

- Fix missing wakeup after issuing writes by scheduling the write collector
  only if all the subrequest queues are empty and thus no writes are pending.

- Fix two minor documentation bugs.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-3)
Debian clang version 16.0.6 (27+b1)

/* Conflicts */

No known conflicts.

The following changes since commit e32cde8d2bd7d251a8f9b434143977ddf13dcec6:

  Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext (2024-09-30 12:58:17 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12-rc2.fixes.2

for you to fetch changes up to a311a08a4237241fb5b9d219d3e33346de6e83e0:

  iomap: constrain the file range passed to iomap_file_unshare (2024-10-03 10:22:28 +0200)

Please consider pulling these changes from the signed vfs-6.12-rc2.fixes.2 tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.12-rc2.fixes.2

----------------------------------------------------------------
Chang Yu (1):
      netfs: Fix a KMSAN uninit-value error in netfs_clear_buffer

Christian Brauner (2):
      folio_queue: fix documentation
      Documentation: add missing folio_queue entry

Darrick J. Wong (2):
      iomap: don't bother unsharing delalloc extents
      iomap: constrain the file range passed to iomap_file_unshare

David Howells (1):
      netfs: Fix missing wakeup after issuing writes

Omar Sandoval (1):
      iov_iter: fix advancing slot in iter_folioq_get_pages()

 Documentation/core-api/index.rst |  1 +
 fs/dax.c                         |  6 +++++-
 fs/iomap/buffered-io.c           |  9 +++++++--
 fs/netfs/misc.c                  |  2 +-
 fs/netfs/write_issue.c           | 42 ++++++++++++++++++++++++++--------------
 include/linux/folio_queue.h      |  2 +-
 lib/iov_iter.c                   |  2 +-
 7 files changed, 43 insertions(+), 21 deletions(-)

