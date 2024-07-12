Return-Path: <linux-fsdevel+bounces-23612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F7192FBF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 15:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B78EDB2269E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 13:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C8717109C;
	Fri, 12 Jul 2024 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fouAlRyn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B026216D4C0;
	Fri, 12 Jul 2024 13:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720792694; cv=none; b=nbnzsjkRiFi+v8edBvsizE4K4MJe188fkllAqM6Bvl7TZj8J9zOLJv2Ba5GetBafcm61w8I4y6Y5a5dr4tSBBn/4jx/Kb0i9X1jl+WL+kI+IRbpVdfG/dk7MWKWqmNLfPby94fDKb1/fMdWU7IiTemt+AvegeyLoi5TC+C330n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720792694; c=relaxed/simple;
	bh=LE6swfDieRQr3hPIcf8Klp3+9L1gsB8t1+ruvFA10HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UvrRepvE5egVMiWz+arfGk2XzGZbxfdONEe78AVWdflVbH+78Y9DiRZ42QOsIAmPji76zp09MXw2ZAmzc//gQmcW3iua7wEdpcAp7Wryk0DJCYzL0b1PjmucRwB96aFYJZAKKZHeC3rAuRJJGd2Xqmn5g4KKg5gFringn4NV8ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fouAlRyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DEBC32782;
	Fri, 12 Jul 2024 13:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720792694;
	bh=LE6swfDieRQr3hPIcf8Klp3+9L1gsB8t1+ruvFA10HQ=;
	h=From:To:Cc:Subject:Date:From;
	b=fouAlRynFLb4/GdTT3FGC00cUFR2sSjFeRkniCmEOIrTx4RZGFqCuqSAwbbH+F+a1
	 Rmx+6Am/zwr9eL12HMWUchPt34jPEgSpzHxIuGBcYnaXiJ2qtsa3up2C2UO4wzz2AX
	 iUlLWc11xFA9vPr/UjCRO3KddVMk2w+7t8r2ItASyslRtNQyEHaSBWtVJ8fSQ6sUCm
	 Y2YwUk3AdfkLvqUUr9Dah77ZZwwdnAdqjQtPplTgJUvpH0CgSyOwVRavCT1b/9FFn9
	 QmqV2pbvGrXn/ACIVwaNFh9nGDI9nzwQOrMMl0YDSzunxI1nXE0CRyVQh2dbSwe0VH
	 ZJ74aWp9upJeg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v6.11] vfs inode
Date: Fri, 12 Jul 2024 15:58:04 +0200
Message-ID: <20240712-vfs-inode-224711153dd2@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3599; i=brauner@kernel.org; h=from:subject:message-id; bh=LE6swfDieRQr3hPIcf8Klp3+9L1gsB8t1+ruvFA10HQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRNNMvlsRCN5xJ0F25s2Z5U4mEq5ztJ0z827oYb67QWF Zum3ZM7SlkYxLgYZMUUWRzaTcLllvNUbDbK1ICZw8oEMoSBi1MAJvKmneGfmtmPoxFRt9TOSRxa F5SldP9ZpobAR/8HamFhphdvfJ27leGf3YGjP8JtjTKehfpsk3OWW3P3bMKmJa0eSp32eyt/sUV yAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains smaller performance improvements to inodes and dentries:

# inode:

- Add rcu based inode lookup variants. They avoid one inode hash lock acquire
  in the common case thereby significantly reducing contention. We already
  support RCU-based operations but didn't take advantage of them during inode
  insertion.

  Callers of iget_locked() get the improvement without any code changes.
  Callers that need a custom callback can switch to iget5_locked_rcu() as e.g.,
  did btrfs.

  With 20 threads each walking a dedicated 1000 dirs * 1000 files directory
  tree to stat(2) on a 32 core + 24GB ram vm:

  before: 3.54s user 892.30s system 1966% cpu 45.549 total
  after:  3.28s user 738.66s system 1955% cpu 37.932 total (-16.7%)

  Long-term we should pick up the effort to introduce more fine-grained locking
  and possibly improve on the currently used hash implementation.

- Start zeroing i_state in inode_init_always() instead of doing it in
  individual filesystems. This allows us to remove an unneeded lock acquire in
  new_inode() and not burden individual filesystems with this.

dcache:

- Move d_lockref out of the area used by RCU lookup to avoid cacheline ping
  poing because the embedded name is sharing a cacheline with d_lockref.

- Fix dentry size on 32bit with CONFIG_SMP=y so it does actually end up with
  128 bytes in total.

/* Testing */
clang: Debian clang version 16.0.6 (26)
gcc: (Debian 13.2.0-24)

All patches are based on v6.10-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with other trees
================================

[1]: linux-next: manual merge of the vfs-brauner tree with the btrfs tree
     https://lore.kernel.org/linux-next/ZnFyeNLLrEcX5_g0@sirena.org.uk

Merge conflicts with mainline
=============================

This causes a merge conflict with fs/bcachefs/fs.c. The gist is that
inode->i_state initialization in __bch2_new_inode() isn't needed anymore after
this is merged and that line needs to be deleted from that function.

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11.inode

for you to fetch changes up to dc99c0ff53f588bb210b1e8b3314c7581cde68a2:

  fs: fix dentry size (2024-07-03 10:34:11 +0200)

Please consider pulling these changes from the signed vfs-6.11.inode tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.11.inode

----------------------------------------------------------------
Christian Brauner (1):
      fs: fix dentry size

Mateusz Guzik (7):
      vfs: add rcu-based find_inode variants for iget ops
      btrfs: use iget5_locked_rcu
      xfs: preserve i_state around inode_init_always in xfs_reinit_inode
      vfs: partially sanitize i_state zeroing on inode creation
      xfs: remove now spurious i_state initialization in xfs_inode_alloc
      bcachefs: remove now spurious i_state initialization
      vfs: move d_lockref out of the area used by RCU lookup

 fs/bcachefs/fs.c       |   1 -
 fs/btrfs/inode.c       |   2 +-
 fs/inode.c             | 108 +++++++++++++++++++++++++++++++++++++------------
 fs/xfs/xfs_icache.c    |   5 ++-
 include/linux/dcache.h |   9 ++++-
 include/linux/fs.h     |   7 +++-
 6 files changed, 99 insertions(+), 33 deletions(-)

