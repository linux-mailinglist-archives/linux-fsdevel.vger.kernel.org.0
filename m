Return-Path: <linux-fsdevel+bounces-57207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44059B1F90B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 10:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 134417A8BE0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 07:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0427823D29A;
	Sun, 10 Aug 2025 08:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJdGfnTN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E22239E6F;
	Sun, 10 Aug 2025 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754812808; cv=none; b=hNpw9Iuw8/qkazMtTNRPnYRwDJlNJ2eN90/5B9unfqh7Uvd+uOg9/BhmeVNxppnWf6rf/OEIiA1ylNQO20tjXu1CTsKXNJUz5Th04ODA3qNEOe9u2nlDUZxXKl1CxXDZPGMX5TaSiy+uLqU0xW8Fzpm3GlUNjog4l9A9Xhnn7yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754812808; c=relaxed/simple;
	bh=aTHyx1cf8uUcKi9iLPhMiaHNvBZweQxvaRFblGuIkU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MFG5yFInQ/F2gNa2+Y0roSyTYPKmeU/fivEk1bDXNRGJTzi91ebWEqe9TdukBpJygI3fL2sGvd8+xMbVAwz64NKX06Gpfu2akZ1SSwc9VgvAZPUy2GSYeWxhwg7rF1kF9Q8Uf2RwMqdJf1MSRL4Lrzk4tZfDY0Qh35WRMGpC2Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJdGfnTN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E84DC4CEEB;
	Sun, 10 Aug 2025 08:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754812807;
	bh=aTHyx1cf8uUcKi9iLPhMiaHNvBZweQxvaRFblGuIkU0=;
	h=From:To:Cc:Subject:Date:From;
	b=WJdGfnTNdEQ6MVf/hGAbh0JwTqoz1Yh+pYp0k313F/a1j/rorDF8R07LPBEZ0sLKf
	 6TxIZXJpfRkfiRSg79aTBLrOKodHRWnOYxIzpGNzqukX7W9ZpAjrTaSykO5VbJXU6M
	 rkyXb6XfNgNUexzXDTYxsxC562eZhrAIUbuI29XD8/0xg59FuqKZjrrfxyllWOp+0H
	 pVx0Qmp2Zi2NnZkdXh0MsxAXjpQMVsGoNDFQBesUFz9qP+u5Wtl/oSyI7pmdRGsa5n
	 +v/4jBd7cw61Mw1MmUKzH2i7rF9Ljz955U2e9s4ryWyazVca4ZmDDM7IWpIX6vR9d2
	 covGiQZeubuTQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org,
	fsverity@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-mtd@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v5 00/13] Move fscrypt and fsverity info out of struct inode
Date: Sun, 10 Aug 2025 00:56:53 -0700
Message-ID: <20250810075706.172910-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a cleaned-up implementation of moving the i_crypt_info and
i_verity_info pointers out of 'struct inode' and into the fs-specific
part of the inode, as proposed previously by Christian at
https://lore.kernel.org/r/20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org/

The high-level concept is still the same: fs/crypto/ and fs/verity/
locate the pointer by adding an offset to the address of struct inode.
The offset is retrieved from fscrypt_operations or fsverity_operations.

I've cleaned up a lot of the details, including:
- Grouped changes into patches differently
- Rewrote commit messages and comments to be clearer
- Adjusted code formatting to be consistent with existing code
- Removed unneeded #ifdefs
- Improved choice and location of VFS_WARN_ON_ONCE() statements
- Added missing kerneldoc for ubifs_inode::i_crypt_info
- Moved field initialization to init_once functions when they exist
- Improved ceph offset calculation and removed unneeded static_asserts
- fsverity_get_info() now checks IS_VERITY() instead of v_ops
- fscrypt_put_encryption_info() no longer checks IS_ENCRYPTED(), since I
  no longer think it's actually correct there.
- verity_data_blocks() now keeps doing a raw dereference
- Dropped fscrypt_set_inode_info() 
- Renamed some functions
- Do offset calculation using int, so we don't rely on unsigned overflow
- And more.

For v4 and earlier, see
https://lore.kernel.org/r/20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org/

I'd like to take this series through the fscrypt tree for 6.18.
(fsverity normally has a separate tree, but by choosing just one tree
for this, we'll avoid conflicts in some places.)

Eric Biggers (13):
  fscrypt: replace raw loads of info pointer with helper function
  fscrypt: add support for info in fs-specific part of inode
  ext4: move crypt info pointer to fs-specific part of inode
  f2fs: move crypt info pointer to fs-specific part of inode
  ubifs: move crypt info pointer to fs-specific part of inode
  ceph: move crypt info pointer to fs-specific part of inode
  fs: remove inode::i_crypt_info
  fsverity: add support for info in fs-specific part of inode
  ext4: move verity info pointer to fs-specific part of inode
  f2fs: move verity info pointer to fs-specific part of inode
  btrfs: move verity info pointer to fs-specific part of inode
  fs: remove inode::i_verity_info
  fsverity: check IS_VERITY() in fsverity_cleanup_inode()

 fs/btrfs/btrfs_inode.h       |  5 ++++
 fs/btrfs/inode.c             |  3 ++
 fs/btrfs/verity.c            |  2 ++
 fs/ceph/crypto.c             |  2 ++
 fs/ceph/inode.c              |  1 +
 fs/ceph/super.h              |  1 +
 fs/crypto/bio.c              |  2 +-
 fs/crypto/crypto.c           | 14 +++++----
 fs/crypto/fname.c            | 11 +++----
 fs/crypto/fscrypt_private.h  |  4 +--
 fs/crypto/hooks.c            |  2 +-
 fs/crypto/inline_crypt.c     | 12 ++++----
 fs/crypto/keysetup.c         | 43 ++++++++++++++++-----------
 fs/crypto/policy.c           |  7 +++--
 fs/ext4/crypto.c             |  2 ++
 fs/ext4/ext4.h               |  8 +++++
 fs/ext4/super.c              |  6 ++++
 fs/ext4/verity.c             |  2 ++
 fs/f2fs/f2fs.h               |  6 ++++
 fs/f2fs/super.c              | 10 ++++++-
 fs/f2fs/verity.c             |  2 ++
 fs/ubifs/crypto.c            |  2 ++
 fs/ubifs/ubifs.h             |  4 +++
 fs/verity/enable.c           |  6 ++--
 fs/verity/fsverity_private.h |  9 +++---
 fs/verity/open.c             | 23 ++++++++-------
 fs/verity/verify.c           |  2 +-
 include/linux/fs.h           | 10 -------
 include/linux/fscrypt.h      | 40 +++++++++++++++++++++++--
 include/linux/fsverity.h     | 57 +++++++++++++++++++++++++++++-------
 30 files changed, 215 insertions(+), 83 deletions(-)


base-commit: 561c80369df0733ba0574882a1635287b20f9de2
-- 
2.50.1


