Return-Path: <linux-fsdevel+bounces-50290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A00ACAB0A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 11:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A7D189D68F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 09:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CA71C3C1F;
	Mon,  2 Jun 2025 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qqpj2yf/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F8A8BE5;
	Mon,  2 Jun 2025 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748854972; cv=none; b=JyrEvQQa/kG5ozFQcuLG1+hQEiF87wwzajTRbNR8ZJi0qyPkwGT1m3eAvE5ZOIPCLNIt84Tbvpp4CD3v7sktDhDzvEB6nhynVGrHS+uNVWT6y396KlXUlguAC6UcOA7ZqWAy3/Efb4dUp2v2XKSzjEBnJubSGu1m/5NrxHq/bnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748854972; c=relaxed/simple;
	bh=iX3w6g2vZ1GkUU//uv+84WjdPgYNSYQQnfsJz8cXOX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vEojcAHwM5j7MctFtkzTGBTsowNH3+fVx0Dam4rEeLfaZt+u6L2w2Jb0SwKCHhOaAqFcIS2dNzoGjuge38Ob3Axp22Q0ctsbY9Bhl75AjhSS22WDy47eE+gekqay/jbH9Yjk/am39F2B49tSNl7o4qitFMG33S3bpTNAZoGUgEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qqpj2yf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037C8C4CEEB;
	Mon,  2 Jun 2025 09:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748854972;
	bh=iX3w6g2vZ1GkUU//uv+84WjdPgYNSYQQnfsJz8cXOX0=;
	h=From:To:Cc:Subject:Date:From;
	b=Qqpj2yf/j4fxAW2ioly+hF0u7Kug3OvUQGCwBEriLRKKbLwBeJpPMDeovd1Ag327f
	 GWqMkZCv03SoKCjH+fL8rRQVJReL3ZUekBNpzhL8iLCFduRb87e/pZdTgj9ZYrBmUl
	 ulpKyXHNuXwCS/G0X1D8iNoXN5zSnaoYcE/NkkRrwrX0qhZs+U31sHH40FgSdm97sS
	 g/XTYyRYRIS5rHyf0Z4uUhBes0i4FWxME75ywndZnP0G4n8Fo2M8+1WlyAhERIp/6A
	 L7M9PajTWIwnnNFKRDErasCFAHJ8HZKJDXcl5m0PhB8o3kwJW7+A0PzTYxLajQac88
	 xCJgX4TK8nqYA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Mon,  2 Jun 2025 11:02:42 +0200
Message-ID: <20250602-vfs-fixes-257460b833e1@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3132; i=brauner@kernel.org; h=from:subject:message-id; bh=iX3w6g2vZ1GkUU//uv+84WjdPgYNSYQQnfsJz8cXOX0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTYZmzefTu4a6afu01Ds3gMn/TDUwVlQveZ7oQ5t6tOf jP3eplYRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESi1zEytN6/meugydb5Ymr4 mcoELusJq9xe/BTr3l177cyXKet8vRkZzur46EeF/LsTtP+ngabY02fz3+jKLZ9kv2X/fzbGMH9 NVgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains a first round of fixes for this cycle:

- Fix the AT_HANDLE_CONNECTABLE option so filesystems that don't know
  how to decode a connected non-dir dentry fail the request.

- Use repr(transparent) to ensure identical layout between the C and
  Rust implementation of struct file.

- Add a missing xas_pause() into the dax code employing
  wait_entry_unlocked_exclusive().

- Fix FOP_DONTCACHE which we disabled for v6.15. A folio could get
  redirtied and/or scheduled for writeback after the initial dropbehind
  test. Change the test accordingly to handle these cases so we can
  re-enable FOP_DONTCACHE again.

  This obviously will need backports to v6.15.

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

The following changes since commit 015a99fa76650e7d6efa3e36f20c0f5b346fe9ce:

  Merge tag 'nolibc-20250526-for-6.16-1' of git://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc (2025-05-27 11:27:09 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc2.fixes

for you to fetch changes up to 5402c4d4d2000a9baa30c1157c97152ec6383733:

  exportfs: require ->fh_to_parent() to encode connectable file handles (2025-05-30 07:30:47 +0200)

Please consider pulling these changes from the signed vfs-6.16-rc2.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.16-rc2.fixes

----------------------------------------------------------------
Alistair Popple (1):
      fs/dax: Fix "don't skip locked entries when scanning entries"

Amir Goldstein (1):
      exportfs: require ->fh_to_parent() to encode connectable file handles

Christian Brauner (2):
      Merge patch series "dropbehind fixes and cleanups"
      Merge patch series "rust: file: mark `LocalFile` as `repr(transparent)`"

Jens Axboe (6):
      mm/filemap: gate dropbehind invalidate on folio !dirty && !writeback
      mm/filemap: use filemap_end_dropbehind() for read invalidation
      Revert "Disable FOP_DONTCACHE for now due to bugs"
      mm/filemap: unify read/write dropbehind naming
      mm/filemap: unify dropbehind flag testing and clearing
      iomap: don't lose folio dropbehind state for overwrites

Pekka Ristola (2):
      rust: file: mark `LocalFile` as `repr(transparent)`
      rust: file: improve safety comments

 fs/dax.c                 |  2 +-
 fs/iomap/buffered-io.c   |  2 ++
 fs/xfs/xfs_aops.c        | 22 ++++++++++++++++++++--
 include/linux/exportfs.h | 10 ++++++++++
 include/linux/fs.h       |  2 +-
 include/linux/iomap.h    |  5 ++++-
 mm/filemap.c             | 39 ++++++++++++++++++++++++---------------
 rust/kernel/fs/file.rs   | 10 ++++++----
 8 files changed, 68 insertions(+), 24 deletions(-)

