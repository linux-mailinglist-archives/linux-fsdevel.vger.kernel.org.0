Return-Path: <linux-fsdevel+bounces-42576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F07A43E4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 12:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79A6917F778
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 11:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A49267B8C;
	Tue, 25 Feb 2025 11:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXlo5udt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846BF267738;
	Tue, 25 Feb 2025 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484279; cv=none; b=esUZ0xfY0jIbzmoi1SnzuFXTYMb+bEVmmXN0WeNs78IHrdxs/d7v+BD/jD0vOeZRNYCq2OeNK1T9rZHb7OjC0mTyiVTcz3kKHETMC8NnFVHmEm/juVss1UoPK4Hsb0TFojz9tqde1FMXSgeN/ovTCrHlR86tEVrZGsDWNzlsFxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484279; c=relaxed/simple;
	bh=g33eaFZnoadwACcszmozS/7LipM5zDwNdIwqoe6EOpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LUxv4e6LM1a/uUpyBXCaOVbckZEmKV/JRvNaFI2Zj/HiDwBkGb6ou5uG5xUIfqeAhgHsncQqc9kNjqV3GypvvJgdcEVbXi2w1Bn/uzb2eWlpWeWC5DNXeOr+nNVaOWbhJhSpe3i0NcEVnysaerwcxORuZaSA5Wxs3blBd71X9QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXlo5udt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B740BC4CEE8;
	Tue, 25 Feb 2025 11:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740484278;
	bh=g33eaFZnoadwACcszmozS/7LipM5zDwNdIwqoe6EOpE=;
	h=From:To:Cc:Subject:Date:From;
	b=TXlo5udtTLn0TMoIg/jFOS87YAgyBIcG/GPS7bi3VURLodA7AYYtcoi1g/AWv2gam
	 8ij02sqNOSu1hdNl8QmHGjwYlbkFCzqht3WW0lh6e7dnT4yx6xaVgliGMLhcs2NEzJ
	 pI7Du/JUMevaEp+Cr+Zuy9TZU+/u4mCdWE/osiQKnxDXA1J8IfpPTq0IBGBFPUpilw
	 xcodaj6/Ic0wr25AAqZkmrSrsk3J1ssabHh/hnbnDWznvRgen5B2si6uaLs1wvRYHE
	 IlSXd6PPEpIE7Vbvnkw/eX8E3zjHxgfDB5cYRGBe7hzT3XdPyZVghgwIGb13a2DJtd
	 AJwR9Ly/YRcew==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Tue, 25 Feb 2025 12:51:12 +0100
Message-ID: <20250225-vfs-fixes-093d8cb2fe3b@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2769; i=brauner@kernel.org; h=from:subject:message-id; bh=g33eaFZnoadwACcszmozS/7LipM5zDwNdIwqoe6EOpE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTvXbfxdufHnwVZ8dVBq5bZfe589VZZqWj/JtUjZ/SLd v5YcVnsUEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBETv9l+J8pNSXz/OTZPx+d S5jRtD71dfMUhelp4Vwif6T3nZZdF1TOyNDx+fynxHVCxu5cZ9kUDzaV7Dv6ODxz75n3SqoyFyZ M6uIGAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

/* Summary */

This contains various fixes for this cycle:

- Use __readahead_folio() in fuse again to fix a UAF issue when using splice.

- Remove d_op->d_delete method from pidfs.

- Remove d_op->d_delete method from nsfs.

- Simplify iomap_dio_bio_iter().

- Fix a UAF in ovl_dentry_update_reval.

- Fix a miscalulated file range for filemap_fdatawrite_range_kick()

- Don't skip skip dirty page in folio_unmap_invalidate().

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

The following changes since commit 2408a807bfc3f738850ef5ad5e3fd59d66168996:

  Merge tag 'vfs-6.14-rc4.fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs (2025-02-17 10:38:25 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc5.fixes

for you to fetch changes up to b5799106b44e1df594f4696500dbbc3b326bba18:

  iomap: Minor code simplification in iomap_dio_bio_iter() (2025-02-25 11:55:26 +0100)

Please consider pulling these changes from the signed vfs-6.14-rc5.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.14-rc5.fixes

----------------------------------------------------------------
Christian Brauner (4):
      Merge tag 'fuse-fixes-6.14-rc4' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse
      Merge patch series "fixes for uncached IO"
      pidfs: remove d_op->d_delete
      nsfs: remove d_op->d_delete

Jingbo Xu (2):
      mm/filemap: fix miscalculated file range for filemap_fdatawrite_range_kick()
      mm/truncate: don't skip dirty page in folio_unmap_invalidate()

Joanne Koong (1):
      fuse: revert back to __readahead_folio() for readahead

John Garry (1):
      iomap: Minor code simplification in iomap_dio_bio_iter()

Miklos Szeredi (1):
      fuse: don't truncate cached, mutated symlink

Vasiliy Kovalev (1):
      ovl: fix UAF in ovl_dentry_update_reval by moving dput() in ovl_link_up

 fs/fuse/dev.c          |  6 ++++++
 fs/fuse/dir.c          |  2 +-
 fs/fuse/file.c         | 13 +++++++++++--
 fs/iomap/direct-io.c   |  8 +++-----
 fs/namei.c             | 24 +++++++++++++++++++-----
 fs/nsfs.c              |  1 -
 fs/overlayfs/copy_up.c |  2 +-
 fs/pidfs.c             |  1 -
 include/linux/fs.h     |  6 ++++--
 mm/filemap.c           |  2 +-
 mm/truncate.c          |  2 --
 11 files changed, 46 insertions(+), 21 deletions(-)

