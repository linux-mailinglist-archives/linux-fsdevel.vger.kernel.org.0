Return-Path: <linux-fsdevel+bounces-23609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3C192FBE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 15:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5491C2236F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 13:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A56A17109F;
	Fri, 12 Jul 2024 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTobzlFA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAECA16CD12;
	Fri, 12 Jul 2024 13:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720792506; cv=none; b=joqbdUGyb4ShR1aLjXZhFjl3aHFxvFjKGTIO1vueLLWYbhXXsD80bj8z0wNccUdTR/WkZ5fgpko0E6ifXct2ZCQiUHjgX+iIcCF80NaKwd9S+X1Uu+5tiacFAk2cSWTQb2iML5xW2Cp4ioUuwhjeUrbQfyBS6Lwy++9A2VAXXqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720792506; c=relaxed/simple;
	bh=ziAkUQPSRF/ipI1Oq+b7qdZXl5boe3MmXIx+Ir7QFbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PlO5ctjQb+bo9PovJZc4Zg3484LbC+ynV0Yv3S+0kSAii/xZpmSlS9+jj6nbZCTFidaBu6B9KrjGFL5N7b3H8eZpeys2UuRzFTXv4kFFrrrcbmH+bGFbhd9mJx0eEpXY0/d1CDa0xF8bcvoL12SvqWDeZNsFNJKgKR4QKhAHYp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTobzlFA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30795C32782;
	Fri, 12 Jul 2024 13:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720792506;
	bh=ziAkUQPSRF/ipI1Oq+b7qdZXl5boe3MmXIx+Ir7QFbg=;
	h=From:To:Cc:Subject:Date:From;
	b=TTobzlFA/dkCJIbNe8s/ReWoRPe3eu/mXZzYXoaFou+qhUOkg5LTx+aPlRH6NgJ6P
	 e0TI7vdmxGnNA2uwvY6V0nZa3xLAjsuCW9mOb8puCMSCyly56ynetc4gxN22Fm7d6j
	 as0U1yag3LlX3R7se5667e74ltEgxsNUvXjKqq+FPYOXrcxxZGCWZjtgmdUqxqyocM
	 pdmZVcRJS6jyK8Du0qDXaAhYGaIeZ95G7BtKrgDtQPNPxpyBaIRwkIab1d9Xgob726
	 iDCdFH957CUcNztdfpei2pNY/ehqeNQn6EJ7ZbItAi6kPtxyzQDK9DsFjDBepzuMmg
	 PFNffqI9k18Yg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v6.11] vfs pg_error
Date: Fri, 12 Jul 2024 15:54:57 +0200
Message-ID: <20240712-vfs-pgerror-ced219c8c800@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3822; i=brauner@kernel.org; h=from:subject:message-id; bh=ziAkUQPSRF/ipI1Oq+b7qdZXl5boe3MmXIx+Ir7QFbg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRNNN2889gJ09lbZFNrMj522rK+PX/jZW2erxfX6Zeq0 l5/yh74dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyk2pWR4dWLqL0le25eqJv0 QXTZuZmuZ9hUPLpkjjaqzTj0uTdntybDX2Hhn44Xzk9L+BXeF7V75sZZpxJf/88Q4uZ2vFjdNGN iPisA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains work to remove almost all remaining users of PG_error from
filesystems and filesystem helper libraries. An additional patch will be coming
in via the jfs tree which tests the PG_error bit. Afterwards nothing will be
testing it anymore and it's safe to remove all places which set or clear the
PG_error bit. The goal is to fully remove PG_error by the next merge window.

/* Testing */
clang: Debian clang version 16.0.6 (26)
gcc: (Debian 13.2.0-24)

All patches are based on v6.10-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

There's one merge conflict in fs/nsfs/symlink.c
After conflict resolution the function should look like this:

static int nfs_symlink_filler(struct file *file, struct folio *folio)
{
        struct inode *inode = folio->mapping->host;
        int error;

        error = NFS_PROTO(inode)->readlink(inode, &folio->page, 0, PAGE_SIZE);
        folio_end_read(folio, error == 0);
        return error;
}

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11.pg_error

for you to fetch changes up to 7ad635ea82704a64c40aba67a7d04293d4780f0f:

  buffer: Remove calls to set and clear the folio error flag (2024-05-31 12:31:43 +0200)

Please consider pulling these changes from the signed vfs-6.11.pg_error tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.11.pg_error

----------------------------------------------------------------
Matthew Wilcox (Oracle) (16):
      befs: Convert befs_symlink_read_folio() to use folio_end_read()
      coda: Convert coda_symlink_filler() to use folio_end_read()
      cramfs: Convert cramfs_read_folio to use a folio
      efs: Convert efs_symlink_read_folio to use a folio
      hpfs: Convert hpfs_symlink_read_folio to use a folio
      isofs: Convert rock_ridge_symlink_read_folio to use a folio
      hostfs: Convert hostfs_read_folio() to use a folio
      jffs2: Remove calls to set/clear the folio error flag
      nfs: Remove calls to folio_set_error
      orangefs: Remove calls to set/clear the error flag
      reiserfs: Remove call to folio_set_error()
      romfs: Convert romfs_read_folio() to use a folio
      ufs: Remove call to set the folio error flag
      vboxsf: Convert vboxsf_read_folio() to use a folio
      iomap: Remove calls to set and clear folio error flag
      buffer: Remove calls to set and clear the folio error flag

 fs/befs/linuxvfs.c            | 10 ++++------
 fs/buffer.c                   |  7 +------
 fs/coda/symlink.c             | 10 +---------
 fs/cramfs/inode.c             | 25 ++++++++++---------------
 fs/efs/symlink.c              | 14 +++++---------
 fs/hostfs/hostfs_kern.c       | 23 ++++++-----------------
 fs/hpfs/namei.c               | 15 +++------------
 fs/iomap/buffered-io.c        |  8 --------
 fs/isofs/rock.c               | 17 ++++++++---------
 fs/jffs2/file.c               | 14 +++-----------
 fs/mpage.c                    | 13 +++----------
 fs/nfs/read.c                 |  2 --
 fs/nfs/symlink.c              | 12 ++----------
 fs/nfs/write.c                |  1 -
 fs/orangefs/inode.c           | 13 +++----------
 fs/orangefs/orangefs-bufmap.c |  4 +---
 fs/reiserfs/inode.c           |  1 -
 fs/romfs/super.c              | 22 ++++++----------------
 fs/ufs/dir.c                  |  1 -
 fs/vboxsf/file.c              | 18 +++++-------------
 20 files changed, 61 insertions(+), 169 deletions(-)

