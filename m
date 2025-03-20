Return-Path: <linux-fsdevel+bounces-44643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B6FA6AF4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 21:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53CDC18954A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 20:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A9B22A4E5;
	Thu, 20 Mar 2025 20:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlp2Pook"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937B322A1E1;
	Thu, 20 Mar 2025 20:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742503307; cv=none; b=TbjgIIS0+N+nGPH4vnYP+IF3xWtBUJcCHUlXLD4NdHToOLTu9bYq0jJhHvU12RaJsi1M+fvb2q/8FGRilFg3USQZ+E2jRmL2gu2tf9y8lFcZwkqJ+hGa14Z16w7bnaFdcANwzExAy6XER/5N+gD/tcu3utPmWfXyco2mMoEi+QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742503307; c=relaxed/simple;
	bh=we7z1WwNJDJljOB6Mz7Zq0uh+GzR+JX7NMU010ZfZsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YTY2ofIdXH3wLd3aVyOvCIl5rF6ei6bOvA96ujWYHvrN2b0vSds8PpPJBVcVfcUT67MubjtmH7PPAzhSOjYcybxSNzNP1fJfvL/cYMpnGkh4QSbHDX1rk656cE+/4VJxgrr0SNcCaQjHvaKgX5D/D/c4MSzlaXrkfoVo0mkwHgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlp2Pook; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A85C4CEE8;
	Thu, 20 Mar 2025 20:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742503307;
	bh=we7z1WwNJDJljOB6Mz7Zq0uh+GzR+JX7NMU010ZfZsA=;
	h=From:To:Cc:Subject:Date:From;
	b=dlp2PooktNvBiG1iuY/0+3hesVXOmP7KadLXiWARDz41nyC5snhjr/ETbsSe2uLMr
	 XCj1c9Pu540hLOvjFcB32/A53PvVxNyGvxQoyDiAzXJWTUowVnXM2bFIcYm0UQljN6
	 qQm8jG/OGWYqWUyIjw//sVyAKb2x/WL1jXPXHMqHadmquFs7AmDCJdWJFuGoIktvcd
	 F4C44bbUV9AFhv3TWI48GYFVqsVBOaNlybwyDsRZY4q3qKdpSAbmEuQin3LVuQxK3L
	 7LaMW12caf+y0lJxKBZx6cvCpb23U2DIMslPh2te8EgYpIei9yhjvZ3rPfjAabIw4R
	 /Zz8YyQ4V9Pcw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Thu, 20 Mar 2025 16:22:48 +0100
Message-ID: <20250320-vfs-fixes-35ad42f81f73@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2928; i=brauner@kernel.org; h=from:subject:message-id; bh=we7z1WwNJDJljOB6Mz7Zq0uh+GzR+JX7NMU010ZfZsA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTfMTrLa/Zzu8onbp7T5alTDxtrrQ6u0Wt8wVjG9nBvq 82xuU3hHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPJsGX4p/n31wG260E290qq PV2s+rVuZ0dqrX241bDD5sgMi4VHBRj+u1WfO3+EtyA3L9rXc2t3wqvbkvuy7ycJ2vzPvbJ3js0 dRgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

/* Summary */

This contains a final set of fixes for this cycle:

VFS:

- Ensure that the stable offset api doesn't return duplicate directory
  entries when userspace has to perform the getdents call multiple times
  on large directories.

afs:

- Prevent invalid pointer dereference during get_link RCU pathwalk.

fuse:

- Fix deadlock caused by uninitialized rings when using io_uring with fuse.

- Handle race condition when using io_uring with fuse to prevent NULL dereference.

libnetfs:

- Ensure that invalidate_cache is only called if implemented.

- Fix collection of results during pause when collection is offloaded.

- Ensure rolling_buffer_load_from_ra() doesn't clear mark bits.

- Make netfs_unbuffered_read() return ssize_t rather than int.

/* Testing */

gcc version (Debian 14.2.0-8) 14.2.0
Debian clang version 19.1.4 (1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 4701f33a10702d5fc577c32434eb62adde0a1ae1:

  Linux 6.14-rc7 (2025-03-16 12:55:17 -1000)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-final.fixes

for you to fetch changes up to f70681e9e6066ab7b102e6b46a336a8ed67812ae:

  libfs: Fix duplicate directory entry in offset_dir_lookup (2025-03-20 14:28:18 +0100)

Please consider pulling these changes from the signed vfs-6.14-final.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.14-final.fixes

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "netfs: Miscellaneous fixes"

David Howells (4):
      afs: Fix afs_atcell_get_link() to check if ws_cell is unset first
      netfs: Fix collection of results during pause when collection offloaded
      netfs: Fix rolling_buffer_load_from_ra() to not clear mark bits
      netfs: Fix netfs_unbuffered_read() to return ssize_t rather than int

Joanne Koong (1):
      fuse: fix uring race condition for null dereference of fc

Luis Henriques (1):
      fuse: fix possible deadlock if rings are never initialized

Max Kellermann (1):
      netfs: Call `invalidate_cache` only if implemented

Yongjian Sun (1):
      libfs: Fix duplicate directory entry in offset_dir_lookup

 fs/afs/dynroot.c          |  6 +++---
 fs/fuse/dev.c             |  2 +-
 fs/fuse/dev_uring.c       |  4 ++--
 fs/libfs.c                |  2 +-
 fs/netfs/direct_read.c    |  6 +++---
 fs/netfs/read_collect.c   | 18 ++++++++++--------
 fs/netfs/rolling_buffer.c |  4 ----
 fs/netfs/write_collect.c  |  3 ++-
 8 files changed, 22 insertions(+), 23 deletions(-)

